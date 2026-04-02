# CLAUDE.md

This file provides guidance to Claude Code when working with code in this repository.

## Project

A C++20 reimplementation of [quilt](https://savannah.nongnu.org/projects/quilt), the patch management tool.
Builds a single `quilt` binary that manages a stack of patches against a source tree. Public domain (Unlicense).

The reference document for quilt behavior is `docs/manual.md`. When in doubt about how a command should behave, run real `quilt` (system-installed) through the same scenario and match its output.

## Dependencies

Install the original quilt for behavioral comparison and test validation:

```bash
sudo apt-get install -y quilt
```

The test suite can be run against real quilt (`bash test/test.sh quilt`) to verify test correctness.

For Windows cross-compilation and testing, install mingw-w64 and wine:

```bash
sudo apt-get install -y mingw-w64 wine
```

**apt install tips**: Always use `-y` to skip interactive confirmation prompts. If package lists are stale, run `sudo apt-get update` first. These installs (especially `wine`) can be slow — run them as background tasks when possible.

## Build

```bash
# Linux (native)
cmake -B build -DCMAKE_BUILD_TYPE=Release
cmake --build build

# Windows cross-compile (mingw-w64, produces static .exe)
cmake -B build-win32 -DCMAKE_TOOLCHAIN_FILE=cmake/mingw-w64.cmake
cmake --build build-win32
```

## Amalgamation

The build also produces `quilt.cpp` (project root) — a self-contained single-file
amalgamation of all sources using `platform_win32.cpp`. Compile it standalone with:

```bash
# Cross-compile to Windows (mingw-w64)
x86_64-w64-mingw32-g++ -std=c++20 -o quilt.exe quilt.cpp -static -lshell32

# Native Windows g++
g++ -std=c++20 -o quilt.exe quilt.cpp -lshell32
```

Regenerate: `cmake --build build --target amalgam` (not built by default).
Do not edit `quilt.cpp` directly.

## Test

```bash
cmake --build build
ctest --test-dir build -j8
```

CTest now registers one test per scenario, so failures are isolated and the suite can run in parallel. The CTest path is shell-free and uses CMake scripting under `test/`.

To run the suite against an arbitrary quilt binary, configure with `QUILT_TEST_EXECUTABLE`:

```bash
cmake -B build-external -DQUILT_TEST_EXECUTABLE=/path/to/quilt
ctest --test-dir build-external -j8
```

The legacy shell harness remains in `test/test.sh` for ad hoc comparison, including against real quilt (`bash test/test.sh quilt`).

## Architecture

All internal strings are UTF-8. Indices and counts use `ptrdiff_t` (signed) with `std::ssize()` instead of `.size()`. The boundary utility `checked_cast<T>()` is used at every signed-to-unsigned conversion point, along with `str_find()` and `str_rfind()` (→ `ptrdiff_t`, returning −1 for not-found), all defined in `quilt.hpp`. `size_t` is only used at system call boundaries (POSIX `write`, Win32 `WriteFile`).

### Headers

- `quilt.hpp` — precompiled header and shared interface. Defines `QuiltState`, string/path utilities, `Command` dispatch table type, and all `cmd_*` function declarations.
- `platform.hpp` — platform abstraction layer: process execution (`run_cmd`, `run_cmd_input`), filesystem ops, environment, and I/O. Declares `quilt_main()`.

### Source files

- `core.cpp` — `QuiltState` methods, string/path utilities, series/applied-patches file I/O, backup/restore file helpers, `quilt_main()` entry point with command dispatch table.
- `cmd_stack.cpp` — stack navigation and push/pop: series, applied, unapplied, top, next, previous, push, pop.
- `cmd_patch.cpp` — patch content commands: new, add, remove, edit, refresh, diff, revert, snapshot, init.
- `cmd_manage.cpp` — patch management: delete, rename, import, header, files, patches, fold, fork, upgrade.
- `cmd_mail.cpp` — mbox generation for emailing patches (`quilt mail`).
- `cmd_annotate.cpp` — annotated file listing showing which patches modify which lines.
- `cmd_graph.cpp` — dependency graph generation in dot(1) format.
- `patch.cpp` — built-in patch engine for applying unified diffs (fuzz, reverse, merge conflicts, reject files).
- `cmd_stubs.cpp` — unimplemented commands that return "not yet implemented": grep, setup, shell.
- `platform_posix.cpp` — POSIX implementation (fork/exec, POSIX file I/O). Contains `main()`.
- `platform_win32.cpp` — Win32 implementation (`CreateProcess`, wide-char APIs, UTF-16 conversion). Contains `main()`.

### Key design patterns

- **Platform selection at build time**: `CMakeLists.txt` links exactly one of `platform_posix.cpp` or `platform_win32.cpp`. No `#ifdef` in shared code.
- **Backup-based patch tracking**: Push/pop works by backing up files into `.pc/<patchname>/` before applying patches. Pop restores from these backups. A built-in patch engine (`patch.cpp`) applies unified diffs; the external `diff` command is used for generating them.
- **Metadata files in `.pc/<patch>/`**: The `.timestamp` and `.needs_refresh` files are quilt metadata, not tracked files. `files_in_patch()` filters these out (anything starting with `.`).
- **Core helpers accessed via extern**: Functions like `ensure_pc_dir`, `backup_file`, `restore_file`, `write_series`, `write_applied`, `pc_patch_dir`, and `files_in_patch` are defined in `core.cpp` but not declared in headers — command files use `extern` forward declarations.
- **Command signature**: Every command is `int cmd_*(QuiltState &q, int argc, char **argv)` where `argv[0]` is the command name. Commands do their own option parsing with simple loops.
- **Patch name display matches original quilt**: Output follows the same conventions as original quilt for displaying patch names (including `QUILT_PATCHES_PREFIX` behavior).
- **Strip-level-aware path parsing**: `parse_patch_files()` strips N leading path components from `+++` lines to match what `patch -pN` does. This ensures backup paths in `.pc/` match the actual filenames.
- **Shell-like splitting for env vars**: `shell_split()` in `core.cpp` handles `QUILT_*_ARGS` and `QUILT_*_OPTS` variables with single quotes, double quotes (with `\"`, `\\`, `\$` escapes), `$VAR`/`${VAR}` expansion, and adjacent segment merging. Used instead of `split_on_whitespace` at all env-var call sites. `split_on_whitespace` is still used for series file parsing.
- **Amalgamation source list**: `cmake/make_amalgam.sh` receives its source file list from CMake's `AMALGAM_SOURCES` variable via arguments — no redundant list in the script. When adding a new source file, only update `CMakeLists.txt`.

## Systematic Feature Testing

To audit quilt.cpp for behavioral correctness, build in Debug mode (enables ASan), then systematically test every command and flag combination by comparing with original quilt.

### Setup

```bash
cmake -B build -DCMAKE_BUILD_TYPE=Debug && cmake --build build
ctest --test-dir build -j8                    # baseline — all tests should pass
cmake -B build-external -DQUILT_TEST_EXECUTABLE=$(which quilt)
ctest --test-dir build-external -j8           # shared tests against original quilt
```

### Agent-based testing

Launch 3-4 parallel `general-purpose` agents, each focused on a command group. This is the core technique — agents do the tedious comparison work and report structured findings.

**Agent prompt template** (adapt per group):
> You are testing quilt.cpp, a C++20 reimplementation of quilt.
> Working directory: /path/to/worktree
> The quilt binary is at: build/quilt (use absolute path)
> Original quilt is at: /path/to/system/quilt
>
> Test the following commands thoroughly, comparing with original quilt:
> [list commands and flags to test]
>
> For each test: create a temp dir under /tmp, set up a patch stack,
> run the command with both quilt.cpp and original quilt, compare
> output messages and exit codes.
>
> Report findings as a structured list: what works, what's broken
> (with source file and line number for the root cause), what differs
> cosmetically.

**Command groups that work well as test units:**
- **Stack navigation**: push (-a, -f, -q, -v, --fuzz=N, --merge, --leave-rejects, --refresh, numeric arg, patch arg), pop (-a, -f, -q, -v, --refresh, numeric arg, patch arg), series (-v, --color), applied/unapplied, top/next/previous
- **Patch content**: refresh (-p0/1/ab, -u, -U N, -c, -C N, -z, -f, --no-timestamps, --no-index, --diffstat, --sort, --backup, --strip-trailing-whitespace), diff (-P, -p, -u, -U, -c, -C, --combine, -z, -R, --snapshot, --no-timestamps, --no-index, --sort, file args), header (-a, -r, -e, --backup, --strip-diffstat, --strip-trailing-whitespace, patch arg), revert (-P, multiple files)
- **Management**: delete (-r, --backup, -n, topmost), rename (-P), import (-p N, -R, -P name, -f, -d o/a/n, multiple files), fold (-R, -q, -f, -p N), fork (with/without name)
- **Special**: snapshot (basic, -d), annotate (-P, multi-patch), graph (--all, --reduce, --lines=N, --edge-labels=files)
- **Environment variables**: QUILT_SERIES, QUILT_PC, QUILT_DIFF_OPTS, QUILT_PATCH_OPTS, QUILT_DIFF_ARGS, QUILT_REFRESH_ARGS, QUILT_PUSH_ARGS, QUILT_NO_DIFF_INDEX, QUILT_NO_DIFF_TIMESTAMPS, QUILT_PATCHES_PREFIX, --quiltrc file, --quiltrc -

### Bug fix workflow

When an agent reports a bug:
1. **Write a test** in `test/Scenarios.cmake` — three parts needed:
   - Add scenario name to `QUILT_TEST_SCENARIOS` or `QUILT_TEST_SCENARIOS_NATIVE`
   - Write the `function(qt_scenario_<name>)` implementation
   - Add `elseif(scenario STREQUAL "<name>")` dispatch entry in `qt_run_named_scenario`
2. **Confirm test fails**: `ctest --test-dir build -R scenario_name`
3. **If shared, confirm it passes on original quilt**: `ctest --test-dir build-external -R scenario_name`
4. **Fix the bug** in the appropriate `src/cmd_*.cpp` or `src/core.cpp`
5. **Rebuild and run full suite**: `cmake --build build && ctest --test-dir build -j8`
6. **Commit** each logical group of related fixes together

### Test placement rules

- `QUILT_TEST_SCENARIOS` — tests that pass against both quilt.cpp and upstream quilt. Prefer this list.
- `QUILT_TEST_SCENARIOS_NATIVE` — tests for quilt.cpp-specific behavior: Debian extensions (init, --dep3), quilt.cpp extensions (--verbose long option on push/pop), builtin patch/diff engine internals, mail command format, shell_split internals, or tests whose error messages intentionally differ from upstream. **These also run on Windows** — do not use this list for platform skipping.

### Writing test scenarios

Test infrastructure lives in `test/TestHarness.cmake` (helpers), `test/RunScenario.cmake` (dispatcher), and `test/Scenarios.cmake` (all scenarios). A complete scenario looks like:

```cmake
function(qt_scenario_revert_file_delete)
    qt_begin_test("revert_file_delete")
    qt_write_file("${QT_WORK_DIR}/f.txt" "content\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    file(REMOVE "${QT_WORK_DIR}/f.txt")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "recreated\n")
    qt_quilt_ok(ARGS revert f.txt MESSAGE "revert failed")
    if(EXISTS "${QT_WORK_DIR}/f.txt")
        qt_fail("revert should delete file when patch deletes it")
    endif()
endfunction()
```

**Available helpers** (defined in `test/TestHarness.cmake`):

| Function | Purpose |
|----------|---------|
| `qt_begin_test("name")` | Create isolated work directory, set `QT_WORK_DIR` |
| `qt_quilt_ok(ARGS ... [MESSAGE msg] [ENV "V=x"] [INPUT data])` | Run quilt, assert exit 0 |
| `qt_quilt(RESULT rc OUTPUT out ERROR err ARGS ...)` | Run quilt, capture everything |
| `qt_write_file(path content)` | Write file (creates parent dirs) |
| `qt_append_file(path content)` | Append to file |
| `qt_read_file_raw(out_var path)` | Read file contents into variable |
| `qt_read_file_strip(out_var path)` | Read file, strip trailing whitespace |
| `qt_combine_output(out_var stdout stderr)` | Concatenate stdout+stderr for searching |
| `qt_assert_success(rc msg)` / `qt_assert_failure(rc msg)` | Check exit codes |
| `qt_assert_equal(actual expected msg)` | String equality |
| `qt_assert_contains(text needle msg)` | Substring search |
| `qt_assert_not_contains(text needle msg)` | Negative substring search |
| `qt_assert_matches(text regex msg)` | Regex match |
| `qt_assert_file_text(path expected msg)` | File contents equal (stripped) |
| `qt_assert_file_contains(path needle msg)` | File contains substring |
| `qt_assert_file_not_contains(path needle msg)` | File doesn't contain substring |
| `qt_assert_exists(path msg)` / `qt_assert_not_exists(path msg)` | File existence |
| `qt_assert_line_count(text N msg)` | Count newlines |
| `qt_fail(msg)` | Unconditional failure |

**Patterns:**
- **Environment variables**: `qt_quilt_ok(ENV "QUILT_PATCHES=/abs/path" ARGS series)`
- **Stdin data**: `qt_quilt_ok(ARGS fold -f INPUT "--- a/f.txt\n+++ b/f.txt\n...")` — for multi-line patches use CMake bracket syntax: `INPUT [=[ ... ]=]`
- **Binary data**: CMake can't handle null bytes in strings. Use `execute_process(COMMAND printf "\\0\\001")` to write binary files.
- **Combined output checking**: `qt_combine_output(combined "${out}" "${err}")` then `qt_assert_contains("${combined}" "error text" "msg")` — use this when you don't know if output goes to stdout or stderr.

## Design decisions

- **Debian quilt vs upstream quilt**: Debian maintains a fork of quilt with extensions not in upstream (savannah.nongnu.org). quilt.cpp implements some Debian extensions: `init` command, `header --dep3`. The Homebrew quilt on macOS is upstream, not Debian. Tests for Debian-only features go in `QUILT_TEST_SCENARIOS_NATIVE` so the shared suite passes against upstream quilt.
- **`quilt mail` diverges from original intentionally**: Output targets `git am`, not mailing lists. No `--send`, no cover letter, `--from`/`--sender` required. Cover-letter options (`-m`, `-M`, `--subject`, `--reply-to`) are accepted but silently ignored for compatibility with the original quilt's option set. See README.md "Differences from Quilt" for full details.
- **`quilt upgrade` is a no-op**: Only the version 2 `.pc/` format is supported. The command succeeds silently.
- **Commands that are implemented move out of `cmd_stubs.cpp`**: Stubs are only for truly unimplemented commands. Once a command has real behavior (even trivial like `upgrade`), it belongs in the appropriate `cmd_*.cpp` file.
- **Tests must not depend on user environment**: The test harness (`test/TestHarness.cmake`) sets `HOME` to a per-test temp directory on every invocation, preventing `~/.quiltrc` from interfering. Tests that need a quiltrc create one explicitly.
- **Tests should pass against both quilt.cpp and original quilt where possible**: Scenarios in `QUILT_TEST_SCENARIOS` run against both. Scenarios in `QUILT_TEST_SCENARIOS_NATIVE` (like `mail_*`) only run against quilt.cpp. When writing tests for shared scenarios, use options both implementations accept. See "Systematic Feature Testing" above for the full test harness API and scenario-writing guide.
