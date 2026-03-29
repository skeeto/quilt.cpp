# Quilt patch management: a complete behavioral reference

**Quilt is a stack-based patch management tool that tracks changes as ordered diff files against a source tree.** Originally derived from Andrew Morton's kernel patch scripts and rewritten by Andreas Grünbacher for SUSE, quilt manages patches as first-class output artifacts — not commits in a VCS, but portable unified diffs organized by a series file. This document covers every subcommand, internal data structure, configuration knob, and behavioral edge case needed to reimplement quilt from scratch in C++. The tool's architecture is deceptively simple: a `patches/` directory holds diff files and a `series` file; a `.pc/` directory holds backup copies of pre-patch files and metadata. All operations reduce to manipulating these two directories plus invoking GNU `diff` and `patch`.

---

## Architecture and core concepts

Quilt models patches as a **stack**. The bottom patch applies first against the pristine source tree; each successive patch applies on top of the cumulative result. The "topmost patch" is the most recently applied one. Most commands operate on the topmost patch by default.

**Three key directories** define quilt's world:

- **Source tree root**: Discovered by searching upward from CWD for a directory containing `patches/` (or `$QUILT_PATCHES`). This mirrors how Git searches for `.git/`.
- **`patches/`** (configurable via `QUILT_PATCHES`, default `patches`): Contains patch files and the `series` file.
- **`.pc/`** (configurable via `QUILT_PC`, default `.pc`): Contains backup files, applied-patches list, and metadata. This is quilt's equivalent of `.git/`.

**Exit codes** are critical for scripting: **0** means success, **1** means error, and **2** means quilt did nothing (e.g., `push` when all patches are applied, `pop` when none are applied). The exit-2 convention enables clean `while quilt push; do quilt refresh; done` loops.

Quilt is implemented as shell scripts (76.6% of the codebase). Each subcommand is a separate script file. Helper scripts include `backup-files` (file state management), `patchfns` (shared functions), `dependency-graph` (for `graph`), `inspect` (for `setup` with RPM specs), and `edmail` (for `mail`).

---

## File format specifications

### The series file

**Location search order**: `.pc/<series-name>` → `<project-root>/<series-name>` → `<QUILT_PATCHES>/<series-name>`. The default series filename is `series` (configurable via `QUILT_SERIES`).

**Format**: Plain text, one entry per line.

```
# Lines starting with # are comments
patch1.diff
subdir/patch2.diff -p0              # strip level 0
patch3.diff -p2 -R                  # reversed patch, strip level 2
patch4.diff -p1 # inline comment
```

**Rules**: Each non-comment line contains a patch filename (relative to `QUILT_PATCHES`), followed by optional `patch(1)`-style options (`-p0`, `-p2`, `-R`), followed by an optional inline comment (` # text`). The **default strip level is `-p1`** when no `-p` option appears. Quilt updates the series file automatically during `new`, `delete`, `import`, `rename`, and `fork` operations. Users may manually edit the series while patches are applied, provided applied patches retain their original order.

### The `.pc/` directory structure

```
.pc/
├── .version              # Format version (currently "2")
├── .quilt_patches        # Value of QUILT_PATCHES at init (e.g., "patches")
├── .quilt_series         # Value of QUILT_SERIES at init (e.g., "series")
├── applied-patches       # Applied patches in order, one per line
├── patch1.diff/          # Backup directory for patch1
│   ├── src/main.c        # Pre-patch copy of src/main.c
│   ├── src/utils.h       # Pre-patch copy of src/utils.h
│   └── .timestamp        # Timestamp marker
├── patch2.diff/
│   ├── src/main.c        # State AFTER patch1, BEFORE patch2
│   └── .timestamp
└── .snap/                # Snapshot directory (only after `quilt snapshot`)
```

**`.pc/applied-patches`** is the authoritative record of which patches are applied and in what order. The last line is the topmost patch. **`.pc/<patchname>/`** contains backup copies of files as they existed *before* the named patch was applied. For files that did not exist before the patch (new files), an **empty zero-byte file** is stored as a sentinel. The `.timestamp` file inside each patch directory is used for mtime-based change detection. **`.pc/.version`** contains `2` for the current format; if it doesn't match, quilt refuses to operate and directs users to run `quilt upgrade`.

### Patch file format

Patch files are standard unified diffs with an optional header. All text before the first diff hunk is the "header" — quilt preserves this during `refresh`. The header can contain DEP-3 metadata, diffstat output, or freeform description text. The diff section uses configurable path styles: `-p1` default (`dir.orig/file` vs `dir/file`), `-p0` (bare paths), or `-p ab` (`a/file` vs `b/file`, matching `git diff` output).

---

## Complete subcommand reference

### Patch creation and file tracking

#### `quilt new [-p n] {patchname}`

Creates a new empty patch and inserts it into the series file immediately after the current topmost patch (or at the beginning if no patches are applied). The new patch becomes the topmost applied patch instantly, even though it contains no changes.

**Exact behavior**: (1) Creates `.pc/` directory with `.version`, `.quilt_patches`, `.quilt_series` if they don't exist. (2) Creates `patches/` directory if needed. (3) Inserts the patch name into the series file after the topmost patch. (4) Creates `.pc/<patchname>/` directory. (5) Adds the patch name to `.pc/applied-patches`. (6) Creates `.pc/<patchname>/.timestamp`. The actual patch file in `patches/` is **not** created until `quilt refresh` runs.

**Flags**: `-p n` sets the patch strip level (`-p0` or `-p1`).

**Non-obvious behavior**: Patch names can include subdirectory prefixes (e.g., `bugfixes/crash-fix.patch`). Quilt does not automatically append `.diff` or `.patch` — the user must include the extension. Always create patches from the source tree root directory.

```bash
quilt new fix-buffer-overflow.patch
# Patch fix-buffer-overflow.patch is now on top
```

#### `quilt add [-P patch] {file} ...`

Registers files with the topmost (or named) patch by creating backup copies in `.pc/<patchname>/`. Files **must** be added before modification so quilt can capture the pre-change state.

**Exact behavior**: For each file: (1) Checks the file isn't already tracked by this patch. (2) Checks no patch applied *above* the target patch modifies this file. (3) Copies the file to `.pc/<patchname>/<filepath>` (or creates an empty file if it doesn't exist yet). (4) Ensures the source file has a hard-link count of 1 (breaks any hard links).

**Forgetting `quilt add` before editing is the single most common quilt mistake.** Changes to unregistered files will not appear in the patch. Use `quilt edit` instead to avoid this.

```bash
quilt add src/main.c
# File src/main.c added to patch fix-buffer-overflow.patch
```

#### `quilt remove [-P patch] {file} ...`

Removes files from the topmost or named patch, restoring their original version from backup. Files modified by patches applied on top cannot be removed.

```bash
quilt remove test/data/obsolete.zip
# File test/data/obsolete.zip removed from patch fix.patch
```

#### `quilt edit {file} ...`

Shorthand for `quilt add file && $EDITOR file`. This is the **recommended** way to modify files because it prevents the forgotten-add mistake. Can also be used on files already tracked by the topmost patch for further editing.

```bash
quilt edit src/main.c
# Opens $EDITOR; make changes, save, exit
```

---

### Stack navigation

#### `quilt push [-afqvm] [--fuzz=N] [--merge[=merge|diff3]] [--leave-rejects] [--color[=always|auto|never]] [--refresh] [num|patch]`

Applies patches from the series file onto the source tree. Without arguments, applies the single next unapplied patch.

**Exact behavior for each patch applied**: (1) Creates `.pc/<patchname>/` directory. (2) Runs `backup-files` to create hard-linked backup copies of all files the patch will modify into `.pc/<patchname>/`. (3) Invokes GNU `patch` with the strip level from the series file, options from `QUILT_PATCH_OPTS`, the fuzz factor, and the patch file on stdin. (4) On success: adds the patch name to `.pc/applied-patches`, creates `.pc/<patchname>/.timestamp`, prints status. (5) On failure without `-f`: restores all backups, prints `"Patch <name> does not apply (enforce with -f)"`, exits 1. (6) On failure with `-f`: keeps partial application, creates `.rej` files, marks patch as needing refresh, adds to `applied-patches`, exits 1. (7) If the patch file doesn't exist in `patches/`: prints `"Patch <name> does not exist; applied empty patch"` and continues.

**Key flags**: `-a` applies all remaining patches. `-f` forces application despite rejects. `--fuzz=N` sets maximum fuzz factor (default **2**). `--merge[=merge|diff3]` uses patch's merge mode instead of producing rejects. `--leave-rejects` keeps `.rej` files even without `-f`. `--refresh` runs `quilt refresh` after each successful application. `num` applies that many patches. `patch` applies all patches up to and including the named one.

**Exit code 2** when series is fully applied: `"File series fully applied, ends at patch <name>"`. **Exit code 1** when the named patch is already applied: `"Patch <name> is currently applied"`.

```bash
quilt push                    # Apply next patch
quilt push -a                 # Apply all patches
quilt push 03_manpage.diff    # Apply up to this patch
quilt push -f                 # Force-apply (creates .rej files)
quilt push 3                  # Apply next 3 patches
```

#### `quilt pop [-afRqv] [--refresh] [num|patch]`

Removes (unapplies) patches from the stack by restoring files from `.pc/` backups.

**Exact behavior for each patch removed**: (1) If `--refresh`: runs `quilt refresh` first. (2) Without `-f`: checks if the patch removes cleanly (via timestamps or reverse-apply verification if `-R`). (3) If dirty and not forced: prints `"Patch <name> does not remove cleanly (refresh it or enforce with -f)"` plus hint about `quilt diff -z`, aborts. (4) Restores files from `.pc/<patchname>/`: if backup is empty (0 bytes), the file was created by this patch and is **deleted**; if backup is non-empty, the source file is **replaced** with the backup. (5) Removes `.pc/<patchname>/` directory. (6) Removes the patch name from `.pc/applied-patches`.

**The `-R` flag** forces reverse-application verification rather than relying on timestamp-based shortcuts. Without it, quilt may use mtime comparisons to decide if files match expected state.

**Critical rule**: Never update the source tree (e.g., `git pull`, `svn update`) while patches are applied. Pop all patches first.

```bash
quilt pop                     # Remove topmost patch
quilt pop -a                  # Remove all patches
quilt pop 02_fix.diff         # Pop until 02_fix.diff is on top
```

#### `quilt applied [patch]`

Prints all currently applied patches in order (bottom to top), or all patches up to and including the named patch.

#### `quilt unapplied [patch]`

Prints all patches that are not currently applied, or all patches following the named patch in the series.

#### `quilt top`

Prints the name of the topmost applied patch. Returns error if no patches are applied.

#### `quilt previous [patch]`

Prints the name of the patch before the topmost or specified patch.

#### `quilt next [patch]`

Prints the name of the next patch after the topmost or specified patch in the series.

---

### Patch content management

#### `quilt refresh [-p n|-p ab] [-u|-U num|-c|-C num] [-z[new_name]] [-f] [--no-timestamps] [--no-index] [--diffstat] [--sort] [--backup] [--strip-trailing-whitespace] [patch]`

Regenerates the specified (or topmost) patch file by running GNU `diff` between backup copies in `.pc/<patchname>/` and current source files. **This is the command that actually writes patch files.**

**Exact behavior**: (1) Determines target patch (default: topmost). (2) For non-topmost patches without `-f`: checks if any patches above modify the same files and aborts if so. With `-f`: only includes changes in files not shadowed by upper patches, warns about shadowed files. (3) For each file tracked by the patch: runs `diff` between `.pc/<patchname>/<file>` (backup) and current `<file>`. (4) Preserves all header text from the existing patch file (everything before the first diff hunk). (5) Writes the combined diff output to `patches/<patchname>`. (6) Updates `.pc/<patchname>/.timestamp`.

**Key flags**: `-p ab` produces `a/file` / `b/file` paths (recommended for Debian). `--no-timestamps` and `--no-index` suppress timestamp and `Index:` lines for cleaner patches. `--diffstat` adds/replaces a diffstat section in the header. `--sort` orders files alphabetically. `--backup` saves old patch as `patch~`. `-z[new_name]` writes changes to a new patch instead of updating the current one (fork-like). `--strip-trailing-whitespace` cleans up whitespace.

**Diff formats**: Unified (`-u`, `-U num`) is the default. Context diff (`-c`, `-C num`) is also supported. Only `-p0`, `-p1`, and `-p ab` are valid strip levels for diff output.

```bash
quilt refresh                              # Update topmost patch
quilt refresh -p ab --no-timestamps        # Clean Debian-style format
quilt refresh --diffstat --sort            # With statistics, sorted
```

#### `quilt diff [-p n|-p ab] [-u|-U num|-c|-C num] [--combine patch|-z] [-R] [-P patch] [--snapshot] [--diff=utility] [--no-timestamps] [--no-index] [--sort] [--color[=always|auto|never]] [file ...]`

Shows differences without writing anything. This is the read-only counterpart to `refresh`.

**Critical distinction**: `quilt diff` (without `-z`) shows the **entire patch content** (backup vs. current file, identical to what `refresh` would write). `quilt diff -z` shows only **uncommitted changes** since the last refresh — the delta between the last-refreshed state and current working state. Think of `quilt diff` as `git diff HEAD` and `quilt diff -z` as `git diff`.

**Key flags**: `--combine patch` produces a combined diff across a range of patches (`-` means first applied patch). `--snapshot` diffs against a previously taken snapshot. `-R` creates a reverse diff. `--diff=utility` uses an alternate diff program. `--color` enables syntax coloring.

```bash
quilt diff                     # Full diff of topmost patch
quilt diff -z                  # Uncommitted changes only
quilt diff --snapshot          # Diff against snapshot
quilt diff --combine -         # Combined diff of all applied patches
```

#### `quilt header [-a|-r|-e] [--backup] [--dep3] [--strip-diffstat] [--strip-trailing-whitespace] [patch]`

Prints or modifies the descriptive header of the topmost or specified patch. The header is all text preceding the first diff hunk in the patch file.

**Modes**: Without `-a`/`-r`/`-e`, prints the header (read-only). `-e` opens the header in `$EDITOR`. `-a` appends stdin to the header. `-r` replaces the header with stdin. `--dep3` inserts a DEP-3 template when editing (Debian standard for patch metadata with fields like `Description`, `Author`, `Origin`, `Bug`, `Forwarded`, `Last-Update`). `--strip-diffstat` removes diffstat output from the header. `--backup` saves old patch as `patch~`.

```bash
quilt header                           # Print current header
quilt header -e --dep3                 # Edit with DEP-3 template
quilt header -r <<EOF
Description: Fix buffer overflow in parser
Author: Jane Smith <jane@example.com>
Bug: https://bugs.example.com/123
EOF
```

---

### Series and file queries

#### `quilt series [--color[=always|auto|never]] [-v]`

Prints all patches in the series file (both applied and unapplied). With `--color`, applied patches appear in **green**, the topmost patch in **yellow/brown**, and unapplied patches in the default color.

#### `quilt patches [-v] [--color] {file} [files...]`

Prints which patches modify the specified file(s). Works for both applied and unapplied patches, though unapplied patches use a **heuristic** (parsing patch files) which is slower than scanning `.pc/` directories for applied patches. This is the inverse of `quilt files`.

```bash
quilt patches src/main.c
# 01_fix.diff
# 03_refactor.diff
```

#### `quilt files [-v] [-a] [-l] [--combine patch] [patch]`

Prints the list of files the topmost or specified patch modifies. `-a` lists all files across all applied patches. `-l` prefixes each file with its patch name. `--combine patch` lists files for a range of patches.

```bash
quilt files -a -l
# 01_fix.diff    src/main.c
# 02_feature.diff src/config.c
```

---

### Importing and distributing patches

#### `quilt import [-p num] [-R] [-P patch] [-f] [-d {o|a|n}] patchfile ...`

Imports external patch files into the quilt series. Patches are **copied** into the `patches/` directory and inserted into the series file after the current topmost patch. Patches are **not applied** — you must `quilt push` afterward.

**Key flags**: `-P patch` renames the imported patch (single file only). `-p num` sets strip level (recorded in series). `-R` marks as reversed. `-f` overwrites existing patches. `-d {o|a|n}` controls header merging when overwriting: keep **o**ld, keep **a**ll (concatenate), or keep **n**ew header.

```bash
quilt import /tmp/upstream-fix.patch
quilt import -P better-name.patch /tmp/ugly-name.diff
quilt push    # Must push after import
```

#### `quilt fold [-R] [-q] [-f] [-p strip-level]`

Integrates a patch read from **standard input** into the topmost patch. This merges another diff's changes into the current patch, similar to `git rebase -i` with squash/fixup.

**Exact behavior**: (1) Reads patch data from stdin. (2) Ensures all files the incoming patch modifies are tracked by the topmost patch (adds them if not). (3) Applies the incoming patch to the working tree via GNU `patch`. (4) A subsequent `quilt refresh` is required to update the patch file.

```bash
cat /tmp/small-fix.patch | quilt fold
quilt fold -p0 < additional-changes.diff
quilt refresh    # Required after folding
```

#### `quilt mail {--mbox file|--send} [-m text] [-M file] [--prefix prefix] [--sender ...] [--from ...] [--to ...] [--cc ...] [--bcc ...] [--subject ...] [--reply-to message] [--charset ...] [--signature file] [--select] [first_patch [last_patch]]`

Creates email messages from patches, following the Linux kernel's email-based patch submission workflow. One email per patch in the specified range.

**Behavior**: `--mbox file` stores messages in standard mbox format. `--send` sends directly via sendmail. Opens an editor for the introduction (cover letter) message unless `-m text` is provided. `--prefix` sets the bracketed subject prefix (default: `"patch"`, producing subjects like `[patch 1/5] Fix buffer overflow`). Uses the `edmail` helper script for RFC 822 header manipulation. `--reply-to message` adds `In-Reply-To` headers for threading. `--signature file` appends a signature (default `~/.signature`; `-` for none). `--select` opens the series in an editor to pick which patches to send.

The special value `-` means "first patch in series" (as `first_patch`) or "last patch in series" (as `last_patch`).

```bash
quilt mail --mbox /tmp/patches.mbox --to maintainer@example.com
quilt mail --send --to lkml@vger.kernel.org - -   # All patches
```

---

### Special operations

#### `quilt setup [-d path-prefix] [--sourcedir dir] [-v] {seriesfile}`

Initializes a source tree from a quilt series file. Reads the series file, extracts any archives referenced by `# Source:` metadata comments, creates `patches` and `series` symlinks, and initializes `.pc/` metadata. Does **not** apply patches — the user must run `quilt push -a` afterward.

The series file may contain special metadata comments that control archive extraction:
- `# Sourcedir: dir` — where to find source archives (overridden by `--sourcedir`)
- `# Source: filename` — an archive (tar/zip/7z) to extract into the working tree
- `# Patchdir: dir` — subdirectory prefix for patches that follow

**Key flags**: `--sourcedir dir` specifies where package sources (tarballs, patches) are located (default `.`). The `patches` symlink will point to this directory. `-d path-prefix` creates the source tree under the given prefix directory. `-v` enables verbose output.

If the target directory already contains a `patches` entry, quilt falls back to using `quilt_patches` and `quilt_series` as alternative names.

**Note**: RPM spec file support (`--fast`, `--slow`, `--fuzz`, `--spec-filter`) is not implemented. Only series files are supported.

**Typical workflow**: The primary use case is RPM-style packaging where upstream source and patches are separate artifacts in a single directory:

```
package-sources/
  widget-1.0.tar.gz          # upstream tarball
  series                     # patch list with metadata
  fix-crash.patch
  add-feature.patch
```

The series file contains archive metadata alongside the patch list:

```
# Source: widget-1.0.tar.gz
fix-crash.patch
add-feature.patch
```

Running setup extracts the tarball, then creates symlinks so that `quilt push` can find the patches without copying them:

```bash
quilt setup --sourcedir package-sources package-sources/series
cd widget-1.0
quilt push -a
```

This produces:

```
widget-1.0/                       # extracted from tarball
  .pc/                            # quilt metadata
  patches -> ../package-sources/  # symlink to source directory
  series -> ../package-sources/series
```

Here `--sourcedir` says "where the files are" and `-d` says "where to put the result." The `-d` flag adds a path prefix when the tarball doesn't create its own subdirectory, or when you want to control the output layout.

Without `# Source:` archive metadata, setup just creates the symlinks and `.pc/` — essentially `quilt init` but pointing `patches/` at an external directory via symlink. The archive extraction is where the real value of the command lives.

#### `quilt snapshot [-d]`

Takes a snapshot of the current working state by copying all currently modified files into `.pc/.snap/`. Later, `quilt diff --snapshot` shows what changed since the snapshot was taken. Only one snapshot exists at a time. The `-d` flag removes the current snapshot.

**Internal mechanism**: Uses `backup-files` with `-b -s -L` flags to create hard-linked copies in `.pc/.snap/`. When `quilt diff --snapshot` runs, it uses these copies as the "old" version for comparison.

```bash
quilt snapshot                  # Take snapshot
# ... make changes, push/pop patches ...
quilt diff --snapshot           # See what changed since snapshot
quilt snapshot -d               # Remove snapshot
```

#### `quilt graph [--all] [--reduce] [--lines[=num]] [--edge-labels=files] [-T ps] [patch]`

Generates a DOT-format directed graph of dependencies between applied patches, suitable for rendering with Graphviz.

**Dependency computation**: Without `--lines`, two patches are dependent if both modify the same file (file-level dependency from `.pc/` metadata). With `--lines[=num]`, dependencies are computed by actual line overlap, using `num` lines of context (default 2). `--all` includes all applied patches (default: only patches the topmost depends on). `--reduce` eliminates transitive edges (if A→B→C, removes direct A→C). `--edge-labels=files` labels edges with the shared filenames. `-T ps` directly produces PostScript output.

```bash
quilt graph --all --reduce | dot -Tpng > dependencies.png
quilt graph --edge-labels=files | dot -Tsvg > graph.svg
```

#### `quilt annotate [-P patch] {file}`

Prints an annotated listing of a file showing which patch last modified each line — analogous to `git blame`. Only considers applied patches. Works by comparing successive backup files in `.pc/<patchname>/` to determine which patch introduced each line. `-P patch` stops at the specified patch rather than the topmost.

```bash
quilt annotate src/main.c
# 1  01_fix.diff      int main(int argc, char **argv) {
# 1  01_fix.diff          if (argc < 2) {
# 2  02_feature.diff          print_usage();
```

#### `quilt grep [-h|options] {pattern}`

Grep through source files recursively, **automatically skipping** the `patches/` and `.pc/` directories. All standard `grep(1)` options are passed through. Without filename arguments, searches the entire source tree. The `-h` flag prints quilt help (for grep's `-h`, use `quilt grep -- -h`). Search expressions starting with a dash need double-dash: `quilt grep -- -- -pattern`.

```bash
quilt grep "TODO"
quilt grep -rn "buffer_size" src/
```

#### `quilt fork [new_name]`

Creates a verbatim copy of the topmost patch under a new name. The series file is updated to reference the new name; the original patch file is preserved but no longer referenced by the series. All `.pc/` metadata is updated. If no name is given, appends `-2` (or increments: `-3`, `-4`, etc.).

**Use case**: When you need to modify a patch but preserve the original — for example, the original is shared across multiple series files.

```bash
quilt fork improved-fix.patch
quilt edit src/main.c
quilt refresh
```

#### `quilt rename [-P patch] new_name`

Renames the topmost or specified patch. Automatically updates the series file and renames the actual patch file in `patches/`.

```bash
quilt rename better-descriptive-name.patch
quilt rename -P old-name.diff new-name.diff
```

#### `quilt delete [-r] [--backup] [patch|-n]`

Removes a patch from the series file. Only the topmost applied patch or any unapplied patch can be deleted. `-n` deletes the next patch after the topmost (useful for removing the next unapplied patch). `-r` also removes the patch file from `patches/`. `--backup` (with `-r`) renames to `patch~` instead of deleting. Without `-r`, only removes the series entry; the patch file remains.

```bash
quilt delete                       # Remove topmost from series
quilt delete -r                    # Remove from series AND delete file
quilt delete -r --backup           # Remove but keep backup as patch~
quilt delete -n                    # Delete next unapplied patch
```

#### `quilt revert [-P patch] {file} ...`

Reverts uncommitted changes to specific files in the topmost or named patch. "Uncommitted" means changes not yet captured by `quilt refresh`. After revert, `quilt diff -z` shows no differences for those files. Restores from `.pc/<patchname>/` backup. Cannot revert files modified by patches applied on top.

```bash
quilt revert src/main.c           # Undo uncommitted changes
```

#### `quilt upgrade`

Migrates quilt metadata from an older format to the current version (`.pc/.version` = `2`). Quilt prompts for this when needed. Rarely used in practice.

#### `quilt shell [command]`

Launches a shell (or runs a command) in a duplicate environment. After exiting, modifications are applied to the topmost patch. Available in newer quilt versions.

---

## The backup-files mechanism

The `backup-files` utility is the workhorse for all file state management. It supports these operations:

- **`-b` (backup)**: Before `quilt push`, copies files to `.pc/<patchname>/`. Uses hard links (`-L`) for efficiency. For files that don't yet exist, stores an empty zero-byte sentinel.
- **`-r` (restore)**: During `quilt pop`, restores files from `.pc/<patchname>/`. Empty backups (0 bytes) mean the file was created by the patch, so it gets **deleted** from the source tree. Non-empty backups replace the current file.
- **`-c` (copy for snapshots)**: During `quilt snapshot`, copies files to `.pc/.snap/`.
- **`-x` (remove)**: Deletes backup files after successful operations.

Additional flags: `-s` (silent), `-t` (touch after restore), `-L` (ensure link count 1), `-k` (keep backup on restore), `-f file` (read filenames from a file), `-B prefix` (backup directory prefix).

---

## Interaction with GNU diff and patch

Quilt delegates all actual patching to **GNU `patch`** and all diff generation to **GNU `diff`**. It does not implement its own diff/patch algorithms.

**During `push`**: Quilt invokes `patch` approximately as: `patch -d <source-root> [--backup --prefix=.pc/<patchname>/] [--quoting-style=literal] [-p<N>] [-R] [--fuzz=<N>] [<QUILT_PATCH_OPTS>] < <patch-file>`. Additional options come from `QUILT_PATCH_OPTS`.

**During `refresh` and `diff`**: Quilt invokes `diff` for each file, comparing the backup in `.pc/<patchname>/<file>` with the current source file. Additional options come from `QUILT_DIFF_OPTS` (e.g., `-p` shows C function names in hunk headers).

### Strip levels explained

The `-p` flag controls pathname handling in patches:

- **`-p0`**: No stripping. Paths appear exactly as in the source tree (e.g., `src/main.c`).
- **`-p1`** (default): One directory component stripped. Standard `dir.orig/file` vs `dir/file` format.
- **`-p ab`**: Quilt-specific mode producing `-p1` patches with `a/file` and `b/file` prefixes, matching `git diff` output. **Recommended for Debian packages.**

The strip level is recorded per-patch in the series file. Only `-p0`, `-p1`, and `-p ab` are valid for `quilt diff` and `quilt refresh`; quilt rejects other values with an explicit error message.

---

## Configuration and environment variables

### The `.quiltrc` file

**Search order**: `~/.quiltrc` → `/etc/quilt.quiltrc`. Override with `--quiltrc file` or `--quiltrc -` (no config). The file is a **bash script** sourced on startup, so it can contain conditional logic.

**The `QUILT_<COMMAND>_ARGS` pattern**: Any command's default arguments can be set via a variable with the command name in uppercase. For example, `QUILT_DIFF_ARGS` sets defaults for `quilt diff`, `QUILT_PUSH_ARGS` for `quilt push`, and `QUILT_REFRESH_ARGS` for `quilt refresh`.

**Recommended Debian configuration** (from Raphaël Hertzog's widely-used template):

```bash
for where in ./ ../ ../../ ../../../ ../../../../ ../../../../../; do
    if [ -e ${where}debian/rules -a -d ${where}debian/patches ]; then
        export QUILT_PATCHES=debian/patches
        break
    fi
done
QUILT_PUSH_ARGS="--color=auto"
QUILT_DIFF_ARGS="--no-timestamps --no-index -p ab --color=auto"
QUILT_REFRESH_ARGS="--no-timestamps --no-index -p ab"
QUILT_DIFF_OPTS='-p'
QUILT_PATCH_OPTS="--reject-format=unified"
```

### Complete environment variable reference

| Variable | Default | Purpose |
|----------|---------|---------|
| `QUILT_PATCHES` | `patches` | Directory containing patch files |
| `QUILT_SERIES` | `series` | Name of the series file |
| `QUILT_PC` | `.pc` | Location of backup/metadata files |
| `QUILT_DIFF_OPTS` | (none) | Extra options passed to GNU `diff` |
| `QUILT_PATCH_OPTS` | (none) | Extra options passed to GNU `patch` |
| `QUILT_DIFFSTAT_OPTS` | (none) | Extra options passed to `diffstat` |
| `QUILT_DIFF_ARGS` | (none) | Default args for `quilt diff` |
| `QUILT_REFRESH_ARGS` | (none) | Default args for `quilt refresh` |
| `QUILT_PUSH_ARGS` | (none) | Default args for `quilt push` |
| `QUILT_NO_DIFF_INDEX` | (unset) | Suppress `Index:` lines in patches |
| `QUILT_NO_DIFF_TIMESTAMPS` | (unset) | Suppress timestamps in patch headers |
| `QUILT_PATCHES_PREFIX` | (unset) | Prefix patch names with QUILT_PATCHES directory |
| `QUILT_PAGER` | Falls back to `GIT_PAGER`, `PAGER`, then `less -R` | Pager for output |
| `QUILT_COLORS` | (per-context defaults) | ANSI SGR color codes for output |
| `EDITOR` | (system default) | Editor for `quilt edit` and `quilt header -e` |
| `LESS` | `-FRSX` | Arguments for the `less` pager |

### Color configuration

`QUILT_COLORS` uses the format `format_name=SGR_value:format_name=SGR_value:...`:

| Name | Command | Meaning | Default SGR |
|------|---------|---------|-------------|
| `diff_hdr` | diff | Index line | 32 (green) |
| `diff_add` | diff | Added lines | 36 (cyan) |
| `diff_rem` | diff | Removed lines | 35 (magenta) |
| `diff_hunk` | diff | Hunk header | 33 (yellow) |
| `diff_ctx` | diff | Context text | 35 (magenta) |
| `diff_cctx` | diff | Asterisk sequences | 33 (yellow) |
| `diff_mod` | diff | Modified lines | 35 (magenta) |
| `patch_fail` | push | Failure message | 31 (red) |
| `patch_fuzz` | push | Fuzz information | 35 (magenta) |
| `patch_offs` | push | Offset information | 33 (yellow) |
| `series_app` | series | Applied patch names | 32 (green) |
| `series_top` | series | Top patch name | 33 (yellow) |
| `series_una` | series | Unapplied patch names | 0 (none) |

### Global options

- **`--trace`**: Runs the command in bash trace mode (`set -x`), showing every internal command executed. Invaluable for debugging.
- **`--quiltrc file`**: Use specified config file; `"-"` means no config file.
- **`--version`**: Print version and exit.

---

## Debian packaging with quilt

### The dpkg-source 3.0 (quilt) format

**Over 95% of non-native Debian source packages** use this format. The `debian/source/format` file contains the string `3.0 (quilt)`. A source package consists of the upstream tarball (`*.orig.tar.*`), the Debian tarball (`*.debian.tar.xz` containing the entire `debian/` directory), and patches listed in `debian/patches/series`.

**At extraction** (`dpkg-source -x`): The orig tarball is extracted, the debian tarball overlaid, and all patches from `debian/patches/series` applied in order. **At build** (`dpkg-source -b`): All patches must be applied. Any untracked changes to upstream files cause dpkg-source to create an automatic `debian-changes-<version>` patch — preventable with `--abort-on-upstream-changes` in `debian/source/local-options`.

**Critical detail**: dpkg-source implements its own quilt-compatible logic and does **not** require quilt to be installed. However, quilt is the recommended tool for interactive patch management.

### The `dquilt` alias pattern

The Debian New Maintainers' Guide recommends a separate quilt configuration for Debian work:

```bash
alias dquilt="quilt --quiltrc=${HOME}/.quiltrc-dpkg"
. /usr/share/bash-completion/completions/quilt
complete -F _quilt_completion -o filenames dquilt
```

This keeps Debian-specific settings (like `QUILT_PATCHES=debian/patches`) separate from general quilt usage.

### DEP-3 patch header standard

DEP-3 (Debian Enhancement Proposal 3) defines RFC 2822-like structured metadata for patch headers. Key fields: `Description`/`Subject` (required), `Author`/`From`, `Origin` (`upstream`, `backport`, `vendor`, `other` + URL), `Bug` (upstream tracker URL), `Bug-Debian` (Debian BTS URL), `Forwarded` (URL, `no`, or `not-needed`), `Applied-Upstream` (version or commit), `Last-Update` (YYYY-MM-DD). `quilt header -e --dep3` inserts a template with these fields.

---

## Real-world workflows

### Linux kernel development

Quilt is **directly descended from kernel development**. Andrew Morton's patch scripts for the -mm tree were the inspiration. The -mm tree was maintained as a quilt series of hundreds of patches representing work-in-progress for the mainline kernel. Morton still uses quilt-style management today — kernel.org mailing list messages from 2024 still reference patches being added to and removed from the -mm tree.

### openSUSE kernel packaging

The openSUSE kernel-source repository stores patches in `patches.suse/` with a `series.conf` master file. The `scripts/sequence-patch.sh` script can use either standard quilt or **Rapidquilt** (a parallel patch applier for performance). Each patch requires RFC 822-style headers. The standard workflow uses `quilt setup *.spec` to initialize, then `quilt push -a` to apply.

### Standard Debian workflow

```bash
quilt push -a                          # Apply all existing patches
quilt new fix-something.patch          # Create new patch
quilt edit src/file.c                  # Track file and open editor
quilt refresh                          # Generate the patch
quilt header --dep3 -e                 # Add DEP-3 metadata
quilt pop -a                           # Unapply all before building
```

### Refreshing all patches after upstream update

```bash
quilt pop -a
while quilt push; do quilt refresh; done
```

This loop exploits the exit-2 convention: `quilt push` returns 2 when all patches are applied, terminating the `while` loop.

### Handling failed patches

```bash
quilt push -f                          # Force apply, creates .rej files
cat file.rej                           # Inspect rejected hunks
vim file                               # Manually resolve conflicts
rm file.rej                            # Clean up
quilt refresh                          # Regenerate the fixed patch
```

### Removing patches absorbed by upstream

```bash
quilt delete -r 04_already-upstream.diff
# or if the patch is on top and reverse-applies cleanly:
quilt pop                              # Unapply
quilt delete -r                        # Remove from series and delete file
```

---

## Common pitfalls and troubleshooting

**"No series file found"**: `QUILT_PATCHES` is not set correctly. Quilt defaults to `patches/series`; Debian packages need `QUILT_PATCHES=debian/patches`.

**Forgetting `quilt add` before editing**: The most common mistake. Changes to unregistered files won't appear in the patch. Prevention: always use `quilt edit` instead of editing directly.

**"Patch does not apply (enforce with -f)"**: Upstream code changed, making context lines mismatch. Fix by force-applying (`quilt push -f`), inspecting `.rej` files, manually fixing, then running `quilt refresh`.

**"Fuzz is not allowed" from dpkg-source**: The 3.0 (quilt) format requires fuzz-free patches. Fix: `quilt pop -a && while quilt push; do quilt refresh; done`.

**Accidental upstream modifications**: dpkg-source creates an automatic `debian-changes-<version>` patch. Prevention: add `abort-on-upstream-changes` to `debian/source/local-options`.

**Timestamps causing unnecessary diff churn**: Configure `QUILT_REFRESH_ARGS="--no-timestamps --no-index -p ab"`.

**Updating source tree with patches applied**: Never run `git pull` or `svn update` while patches are applied. Always `quilt pop -a` first, update, then push patches back.

**Binary files in patches**: GNU diff cannot handle binary files. Use `quilt remove <file>` to exclude the binary from the patch, or use `debian/source/include-binaries` for Debian packages.

---

## Quilt compared to git-based patch management

The fundamental difference is philosophical: **quilt's primary output is patches** (portable diff files), while **Git's primary output is commits** (repository-bound history). Quilt requires no VCS and works on any tarball. Git tools offer superior 3-way merge conflict resolution, history tracking, and collaboration workflows.

Several tools bridge the gap. **StGit** (Stacked Git) provides quilt-like push/pop/refresh semantics backed by Git commits, with Git's merge engine for conflict resolution. **guilt** maps quilt concepts onto `.git/patches/`. **TopGit** supports non-linear patch dependencies as a DAG. **`gbp pq`** (git-buildpackage patch queue) converts between `debian/patches/` and Git branches, letting developers use Git without learning quilt. **`git quiltimport`** is a built-in Git command that converts a quilt series into Git commits.

Quilt remains the right tool when working with Debian source packages (it's the native format), managing patches against non-Git tarballs, operating in SUSE/openSUSE kernel packaging, or distributing patches that must be consumed by diverse systems. Git tools are superior when the project already uses Git, when history of patch evolution matters, when complex conflict resolution is expected, or when `git rebase -i` style workflows are preferred.

---

## Conclusion

Quilt's behavioral contract is defined by a small set of invariants. The series file provides the ordered patch list. The `.pc/` directory provides the state machine — `applied-patches` tracks position in the stack, and per-patch backup directories enable both rollback (pop) and diff generation (refresh/diff). Every push creates backups before applying via GNU `patch`; every pop restores from backups; every refresh generates diffs between backups and current files via GNU `diff`. The exit code convention (0/1/2) enables compositional scripting. A C++ reimplementation must faithfully reproduce these invariants: the series file parsing rules, the `.pc/` directory layout with zero-byte sentinels for new files, the backup-then-apply push sequence, the restore-or-delete pop logic, the header-preserving refresh algorithm, and the exact error messages and exit codes that existing scripts and tools (dpkg-source, `sequence-patch.sh`, `while quilt push; do quilt refresh; done`) depend on.