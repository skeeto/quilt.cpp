# CLAUDE.md

This file provides guidance to Claude Code when working with code in this repository.

## Project

A C++20 reimplementation of [quilt](https://savannah.nongnu.org/projects/quilt), the patch management tool.
Builds a single `quilt` binary that manages a stack of patches against a source tree. Public domain (Unlicense).

The reference document for quilt behavior is `quilt.html` (or `quilt.txt`). When in doubt about how a command should behave, run real `quilt` (system-installed) through the same scenario and match its output.

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

All internal strings are UTF-8. Indices and counts use `ptrdiff_t` (signed) with `std::ssize()` instead of `.size()`. The boundary utilities `to_uz()` (→ `size_t`), `to_int()` (→ `int`), `str_find()`, and `str_rfind()` (→ `ptrdiff_t`, returning −1 for not-found) are defined in `quilt.hpp` and used at every signed-to-unsigned conversion point. `size_t` is only used at system call boundaries (POSIX `write`, Win32 `WriteFile`).

### Headers

- `quilt.hpp` — precompiled header and shared interface. Defines `QuiltState`, string/path utilities, `Command` dispatch table type, and all `cmd_*` function declarations.
- `platform.hpp` — platform abstraction layer: process execution (`run_cmd`, `run_cmd_input`), filesystem ops, environment, and I/O. Declares `quilt_main()`.

### Source files

- `core.cpp` — `QuiltState` methods, string/path utilities, series/applied-patches file I/O, backup/restore file helpers, `quilt_main()` entry point with command dispatch table.
- `cmd_stack.cpp` — stack navigation and push/pop: series, applied, unapplied, top, next, previous, push, pop.
- `cmd_patch.cpp` — patch content commands: new, add, remove, edit, refresh, diff, revert.
- `cmd_manage.cpp` — patch management: delete, rename, import, header, files, patches, fold, fork, upgrade.
- `cmd_mail.cpp` — mbox generation for emailing patches (`quilt mail`).
- `cmd_stubs.cpp` — unimplemented commands that return "not yet implemented": annotate, grep, graph, setup, shell, snapshot, init.
- `platform_posix.cpp` — POSIX implementation (fork/exec, POSIX file I/O). Contains `main()`.
- `platform_win32.cpp` — Win32 implementation (`CreateProcess`, wide-char APIs, UTF-16 conversion). Contains `main()`.

### Key design patterns

- **Platform selection at build time**: `CMakeLists.txt` links exactly one of `platform_posix.cpp` or `platform_win32.cpp`. No `#ifdef` in shared code.
- **Backup-based patch tracking**: Push/pop works by backing up files into `.pc/<patchname>/` before applying patches. Pop restores from these backups. The external `patch` command is used for applying diffs; `diff` is used for generating them.
- **Metadata files in `.pc/<patch>/`**: The `.timestamp` and `.needs_refresh` files are quilt metadata, not tracked files. `files_in_patch()` filters these out (anything starting with `.`).
- **Core helpers accessed via extern**: Functions like `ensure_pc_dir`, `backup_file`, `restore_file`, `write_series`, `write_applied`, `pc_patch_dir`, and `files_in_patch` are defined in `core.cpp` but not declared in headers — command files use `extern` forward declarations.
- **Command signature**: Every command is `int cmd_*(QuiltState &q, int argc, char **argv)` where `argv[0]` is the command name. Commands do their own option parsing with simple loops.
- **Patch names are bare**: Display output uses bare patch names (e.g., `flower.diff`), never prefixed with the patches directory. The `patches/` path is only used internally for file I/O.
- **Strip-level-aware path parsing**: `parse_patch_files()` strips N leading path components from `+++` lines to match what `patch -pN` does. This ensures backup paths in `.pc/` match the actual filenames.
- **Shell-like splitting for env vars**: `shell_split()` in `core.cpp` handles `QUILT_*_ARGS` and `QUILT_*_OPTS` variables with single quotes, double quotes (with `\"`, `\\`, `\$` escapes), `$VAR`/`${VAR}` expansion, and adjacent segment merging. Used instead of `split_on_whitespace` at all env-var call sites. `split_on_whitespace` is still used for series file parsing.
- **Amalgamation source list**: `cmake/make_amalgam.sh` receives its source file list from CMake's `AMALGAM_SOURCES` variable via arguments — no redundant list in the script. When adding a new source file, only update `CMakeLists.txt`.

## Design decisions

- **`quilt mail` diverges from original intentionally**: Output targets `git am`, not mailing lists. No `--send`, no cover letter, `--from`/`--sender` required. Cover-letter options (`-m`, `-M`, `--subject`, `--reply-to`) are accepted but silently ignored for compatibility with the original quilt's option set. See README.md "Differences from Quilt" for full details.
- **`quilt upgrade` is a no-op**: Only the version 2 `.pc/` format is supported. The command succeeds silently.
- **Commands that are implemented move out of `cmd_stubs.cpp`**: Stubs are only for truly unimplemented commands. Once a command has real behavior (even trivial like `upgrade`), it belongs in the appropriate `cmd_*.cpp` file.
- **Tests must not depend on user environment**: The test harness (`test/TestHarness.cmake`) sets `HOME` to a per-test temp directory on every invocation, preventing `~/.quiltrc` from interfering. Tests that need a quiltrc create one explicitly.
- **Tests should pass against both quilt.cpp and original quilt where possible**: Scenarios in `QUILT_TEST_SCENARIOS` run against both. Scenarios in `QUILT_TEST_SCENARIOS_NATIVE` (like `mail_*`) only run against quilt.cpp. When writing tests for shared scenarios, use options both implementations accept.
