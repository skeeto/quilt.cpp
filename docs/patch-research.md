# Implementing Unix patch: algorithms, formats, and engineering tradeoffs

The core challenge of implementing `patch` is not parsing diffs — it is **reliably locating where each hunk belongs** in a file that may have diverged from the version the diff was created against. Every major implementation solves this with a bidirectional spiral search outward from an expected line number, combined with cumulative offset tracking across hunks. The differences between implementations — GNU patch's fuzz factor, Git's hash-optimized strict matching, Busybox's streaming regex-like scan — reflect fundamental tradeoffs between robustness, safety, and simplicity. This report covers the algorithms, data structures, and engineering decisions behind each approach in implementation-ready depth.

---

## The spiral search: how patch finds where a hunk belongs

The central algorithm in GNU patch lives in `locate_hunk()` (in `src/patch.c`). It computes an initial guess for where a hunk should apply, then searches outward in alternating directions until a match is found or the searchable region is exhausted.

**Step 1 — Compute `first_guess`.** The hunk header specifies a starting line number (`pch_first()`). GNU patch adds the cumulative offset from previously applied hunks (`last_offset`) to get the adjusted starting position: `first_guess = pch_first() + last_offset`. This single adjustment is the key to efficient multi-hunk application — without it, every hunk would search from scratch.

**Step 2 — Try exact position.** If `patch_match(first_guess, 0, fuzz)` succeeds, return immediately. For well-formed patches against unmodified files, this hits on the first try, making application **O(C) per hunk** where C is the number of context lines.

**Step 3 — Spiral outward.** The search alternates forward and backward: `first_guess + 1`, `first_guess - 1`, `first_guess + 2`, `first_guess - 2`, and so on. Two bounds constrain the search: `max_pos_offset` prevents searching past the end of the file, and `max_neg_offset` prevents searching backward past `last_frozen_line` (the last line already written to output). The backward bound includes `+ pch_context()` to allow overlapping context regions between adjacent hunks.

**Step 4 — Update offset.** When a match is found at position `where`, the algorithm records `last_offset = where - pch_first()`, so the next hunk's guess automatically incorporates the cumulative drift. This means if an earlier hunk inserted 10 lines, all subsequent hunks start searching 10 lines later.

The `patch_match()` function itself compares context and deletion lines from the hunk against input file lines fetched via `ifetch()` (which indexes into a pre-built line-pointer array). The `fuzz` parameter controls how many context lines to skip at the top (`pline = 1 + fuzz`) and bottom (`pat_lines - fuzz`) of the pattern. Git's `apply.c` uses an identical bidirectional scan in `find_pos()` — the source code comment reads: *"There's probably some smart way to do this, but I'll leave that to the smart and beautiful people. I'm simple and stupid."*

The critical difference is that **Git precomputes a hash for every line** in the target file during `image_prepare()`. The `match_fragment()` function compares these integer hashes before falling back to `memcmp()`, giving O(1) rejection of non-matching positions versus GNU patch's character-by-character comparison. This makes Git's search significantly faster on large files with many candidate positions.

---

## Hunk parsing and the internal representation

GNU patch uses a unified internal representation regardless of input format. The parser `another_hunk()` in `src/pch.c` reads unified, context, normal, or ed-script diffs and normalizes them into parallel arrays:

```
p_line[]  — pointer to each line's text
p_len[]   — byte length of each line  
p_Char[]  — type marker: ' ' context, '-' delete, '+' add, '!' change, '*' / '=' headers
```

For a unified diff hunk, the array layout after parsing is: index 0 holds a synthetic `*** old_start,old_end ****` header; indices **1 through p_ptrn_lines** hold the old-file lines (context and deletions); index `p_ptrn_lines+1` holds a synthetic `--- new_start,new_end ----` separator; and the remaining indices hold new-file lines (context and additions). This normalization means the matching and application code treats context and unified diffs identically.

**Application proceeds in three steps per hunk.** First, `copy_till(where - 1)` flushes all input lines from `last_frozen_line + 1` through the line just before the match position to the output file unchanged. Second, the replacement section of the hunk is written — context lines (which are identical between old and new) plus addition lines. Third, `last_frozen_line` advances to `where + pch_ptrn_lines() - 1`, marking the old-file lines as consumed. The `copy_till()` function enforces monotonic forward progress: if `last_frozen_line > lastline`, it aborts with *"misordered hunks! output would be garbled"*.

The hunk arrays start at size **125** (`hunkmax`) and grow by doubling via `grow_hunkmax()`. Git's approach differs: each `struct fragment` stores the raw hunk text plus line numbers, and `struct image` represents the file as a contiguous buffer with a line table containing per-line offset, length, hash, and flags. Fragments modify the image in-place rather than streaming to a temp file.

---

## Fuzz matching: trading safety for flexibility

GNU patch's fuzz factor is the mechanism that allows patches to apply against modified files. The main loop in `patch.c` tries increasing fuzz levels:

```c
for (fuzz = 0; fuzz <= min(maxfuzz, pch_context()); fuzz++) {
    where = locate_hunk(fuzz);
    if (where) break;
}
```

At **fuzz 0**, all context lines must match exactly — the safest mode. At **fuzz 1**, the first and last context lines are ignored, reducing matching constraints by 2 lines. At **fuzz 2** (the default maximum, set by `DEF_MAX_FUZZ` in `common.h`), only the middle context line constrains placement when using the standard 3-line context. The man page warns: *"you should also be slightly suspicious"* at fuzz 2.

Modern GNU patch (2.7+) refines fuzz into `prefix_fuzz` and `suffix_fuzz`, clamped to the actual number of prefix and suffix context lines in the hunk. This enables a safety heuristic: if after applying fuzz, more prefix context remains than suffix context, the hunk is constrained to match near the **end of the file**; if more suffix than prefix remains, it must match near the **beginning**. This prevents the degenerate case where stripping all context allows a hunk to match anywhere.

**The performance cost of fuzz is multiplicative.** Each fuzz level triggers a complete spiral scan of the file. Worst-case complexity per hunk is **O(F × N × C)** where F is the fuzz factor, N is file length, and C is context line count. For a patch with H hunks, total worst case is O(H × F × N × C).

**Git apply deliberately does not support fuzz.** Junio C Hamano's design decision is that fuzz risks silent misapplication — a hunk that matches with fuzz 2 at the wrong location can corrupt a file in ways that compile cleanly but introduce subtle bugs. Git provides `--3way` as the alternative: when a hunk fails to match, Git uses the SHA recorded in the `index` line to retrieve the original blob and performs a proper three-way merge. This is semantically correct where fuzz is heuristic.

Busybox patch also lacks fuzz support entirely — its `apply_one_hunk()` treats the hunk as a streaming pattern, scanning forward through the file until context lines match sequentially, with no offset tracking or spiral search.

---

## Four diff formats and how they shape the application strategy

**Unified diff** (`diff -u`) is the most common format. The `@@ -old_start,old_count +new_start,new_count @@` header provides line numbers and counts. Lines prefixed with `' '` are context, `'-'` are deletions, `'+'` are additions. Context and deletions are interleaved with additions, making the format compact. A critical parsing detail: when count is 1, the `,1` may be omitted, so `@@ -5 +5,3 @@` means the old range is 1 line starting at line 5. Empty ranges use count 0 with start pointing to the line before the range.

**Context diff** (`diff -c`) uses separate old and new sections delimited by `***` and `---` lines (note: `***` marks the old file, `---` marks the new — **reversed** from unified format headers). The `'!'` marker explicitly identifies changed lines appearing in both sections. Parsing is more complex because old and new content must be correlated, and the dual-block structure roughly doubles the diff size. GNU patch converts context diffs to its unified internal representation during parsing.

**Normal diff** uses `ed`-style commands (`NaM`, `N,MdR`, `N,McR,S`) with `< ` and `> ` line prefixes. It provides no context lines, making fuzzy matching impossible. Parsing is straightforward: extract the command and line ranges, read the prefixed content.

**Ed scripts** (`diff -e`) are the oldest format — sequences of `ed` commands in reverse order (end-of-file first, so earlier edits don't invalidate later line numbers). GNU patch applies these by piping them directly to the `ed` editor, which means **patch cannot detect line number errors** in ed scripts. If the file has changed, `ed` silently edits the wrong lines. The format cannot represent files lacking a final newline and cannot be reversed.

---

## Conflict handling: reject files, merge markers, and atomicity models

When a hunk fails to match at any position and fuzz level, implementations diverge in their handling strategy.

**GNU patch uses partial application with reject files.** Each successful hunk is applied; each failed hunk is written to a `.rej` file in context diff format (regardless of input format). The output file contains a mix of applied and unapplied changes. Exit status 1 indicates rejects were created. The `--reject-format` option allows choosing unified or context format for rejects. This approach maximizes the amount of work done automatically but can leave files in inconsistent states.

**GNU patch's `--merge` mode** writes conflict markers directly into the output file instead of creating reject files. In standard mode, markers follow the `<<<<<<<` / `=======` / `>>>>>>>` convention used by Git and other VCS merge tools. The `--merge=diff3` variant adds a `|||||||` section showing the original patch context. The man page notes that *"computing how to merge a hunk is significantly harder than using the standard fuzzy algorithm"* and that `--merge` implies `--forward` (no reverse detection).

**Git apply defaults to all-or-nothing semantics.** If any hunk in the patch fails, no files are modified. This is implemented as a two-phase process: first validate all hunks against all files, then apply. The `--reject` flag switches to GNU-style partial application with `.rej` files. The `--3way` flag enables three-way merge as a fallback — `try_threeway()` retrieves the original blob from the object store using the SHA in the `index` line, applies the patch to produce a "theirs" version, then calls `ll_merge()` (the same merge engine used by `git merge`) with base/ours/theirs. This produces proper conflict markers and is semantically superior to fuzz-based heuristics.

---

## Efficiency: what makes patch fast in practice

The typical time complexity of applying a patch is **O(N + H × C)** — reading the file plus matching each hunk's context lines at the expected position. This is effectively linear because offset tracking ensures most hunks match on the first try. Several techniques maintain this performance:

**Incremental offset tracking** (`last_offset`) avoids re-scanning. After each hunk, the cumulative drift between expected and actual positions is recorded. The next hunk starts searching from the adjusted position, not from its raw header line number.

**The `last_frozen_line` constraint** shrinks the search space monotonically. Each applied hunk advances this watermark, and the backward search cannot cross it. This means later hunks search a progressively smaller region.

**Git's per-line hashing** converts the inner loop from O(line_length) string comparison to O(1) integer comparison for non-matching positions. The `image_prepare()` function computes a hash for every line during file loading. `match_fragment()` checks all preimage line hashes against target line hashes before any `memcmp()`.

**Single-pass output assembly** in GNU patch streams unchanged lines directly from input to a temp file via `copy_till()`, avoiding building the entire output in memory. Git instead modifies an in-memory `image` structure, which uses more memory but enables atomic validation.

**File loading** in both GNU patch and Git reads the entire file into memory and builds a line-pointer array. Neither uses memory-mapped I/O. GNU patch's `inp.c` provides `plan_a()` (load into memory) and `plan_b()` (use a temp file for very large files, with line access through seeking). Git's `strbuf_read_file()` loads the complete file into a contiguous buffer.

A notable optimization **not used by any major implementation** is hash-table indexing of file lines. Building a hash map from line content to positions would convert the spiral scan into O(1) lookups for the first context line, then O(C) verification. This would help pathological cases (many hunks with large offsets on huge files) but adds complexity for a scenario that rarely occurs with well-formed patches.

---

## How notable implementations differ in design philosophy

**Larry Wall's original patch (1985)** established the architecture still used today: format auto-detection, bidirectional spiral search, fuzz matching, reject files. Wall designed for robustness against 1980s mail corruption — USENET and UUCP could strip trailing whitespace, mangle line endings, or delete blank lines. The code includes the heuristic `Strcpy(buf, "  \n")` ("assume blank lines got chopped") which caused a **35-year-old bug** discovered in FreeBSD's derived code in 2020. Wall's patch also featured whimsical output messages like "...hmm" during analysis, later removed by GNU maintainers.

**GNU patch (current 2.7.x)** evolved from Wall's code, adding unified diff support, `--merge` mode, `--dry-run`, refined prefix/suffix fuzz, POSIX conformance modes, and version control integration (RCS, SCCS, ClearCase, Perforce). Key source files are `src/patch.c` (main loop, `locate_hunk()`, `patch_match()`), `src/pch.c` (hunk parsing), `src/inp.c` (file loading), and `src/merge.c` (conflict marker generation). The internal representation normalizes all diff formats into a unified parallel-array structure.

**Git apply (~5000 lines in `apply.c`)** is a clean-room implementation optimized for correctness over flexibility. It **rejects fuzz matching** by design, uses per-line hashing for fast matching, supports git-specific extensions (binary patches via base85+zlib encoding, file mode changes, rename/copy detection), and provides three-way merge via blob SHA lookup. Binary patch verification is cryptographic: after application, the result is hashed and compared against the expected SHA. Git's atomicity model (validate all hunks before writing any changes) prevents the partial-application problem that plagues GNU patch.

**Busybox patch (~573 lines)** is a minimal implementation supporting only unified diffs. Its matching algorithm is fundamentally different: rather than spiral search from an expected position, `apply_one_hunk()` treats the hunk as a **streaming pattern**, scanning forward through the file until context lines match sequentially. The source comment states: *"This does not use the location information, but instead treats a hunk as a sort of regex."* There is no fuzz support, no reject files, no offset tracking — if a hunk fails, it's simply reported and skipped.

**BSD patch (OpenBSD/FreeBSD)** descends directly from Wall's code rather than GNU patch. It supports all four diff formats but lacks GNU extensions like `--merge`, `--reject-format`, and `--binary`. OpenBSD's version has been security-audited. FreeBSD's version carried the blank-line heuristic bug for 35 years until Warner Losh's 2020 fix.

**Plan 9** takes a radically different approach: instead of a diff-application tool, it provides a **collaborative patch workflow** implemented as `rc` shell scripts (`patch/create`, `patch/apply`, `patch/diff`). Conflict detection is binary — if the source has changed since the patch was created, application fails entirely. No fuzz matching, no partial application. For Unix-style patching, Plan 9 offers `ape/patch` through its POSIX compatibility layer.

---

## Edge cases that break naive implementations

**The `\ No newline at end of file` marker** is not counted in hunk line totals and modifies the semantics of the *preceding* line: strip its trailing newline. It can appear after `-`, `+`, or context lines, and multiple times per hunk. A common case: old file lacks a final newline, new file adds one — represented as a deletion line followed by the marker, then an addition line without the marker. Many third-party implementations have bugs around this marker.

**File creation and deletion** are signaled by `/dev/null` as the old or new filename. Git diffs use explicit `new file mode` / `deleted file mode` headers. A file dated at the Unix epoch (1970-01-01) paired with a normally-dated file is the traditional heuristic for detecting creation/deletion. GNU patch also removes empty ancestor directories after file deletion and creates necessary parent directories for new files.

**Reversed patch detection** works by attempting to apply the first hunk forward; if it fails, trying it reversed. If the reversed application succeeds, GNU patch prompts the user (*"Reversed (or previously applied) patch detected!"*). Git apply is strict — it simply fails without auto-detection. The `-N` (forward) flag suppresses this heuristic.

**Path prefix stripping** (`-p N`) removes N leading pathname components. Adjacent slashes count as one separator: `/usr///src/` has two components regardless of extra slashes. With no `-p` specified, GNU patch strips everything except the basename. Git defaults to `-p1`, matching its `a/`/`b/` prefix convention. When old and new filenames differ after stripping, patch uses a **file selection heuristic**: prefer existing files, then shortest paths, then fewest new directories needed.

**Mixed line endings** are handled by GNU patch automatically stripping CR before LF during matching. The `--binary` flag disables this transformation. Cross-platform patches remain fragile — a patch created on Windows (CRLF) applied on Linux (LF) generally works with GNU patch, but the reverse often fails.

**Git binary patches** use a two-part format: a forward hunk (old→new) and a reverse hunk (new→old). Content is zlib-compressed, then base85-encoded with per-line length characters (A–Z = 1–26 bytes, a–z = 27–52 bytes). Two variants exist: `literal` (complete file replacement) and `delta` (Git pack delta format with copy/insert instructions). Only `git apply` can process these — GNU patch ignores binary diff sections entirely.

---

## Conclusion

The `patch` algorithm is deceptively simple at its core — a bidirectional search plus streaming copy — but the engineering complexity lives in the edges: fuzz matching that risks silent misapplication, offset tracking that must handle overlapping context regions, format normalization across four diff syntaxes, and dozens of edge cases around line endings, missing newlines, and file metadata. The most important architectural insight is that **correctness and flexibility are fundamentally in tension**: GNU patch's fuzz factor enables patching diverged files but can place hunks at wrong locations; Git's strict matching with three-way merge fallback is safer but requires object-store access. For new implementations, the key decisions are whether to support fuzz (and accept the risk), whether to use per-line hashing (significant speedup for large files), and whether to adopt all-or-nothing atomicity (safer but less flexible than partial application). The streaming single-pass architecture with incremental offset tracking remains the most efficient approach for the common case where patches apply cleanly near their expected positions.