# CLAUDE.md
This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.
## Project

A C++17 reimplementation of [quilt](https://savannah.nongnu.org/projects/quilt), the patch management tool.
Builds a single `quilt` binary that manages a stack of patches against a source tree. Public domain              (Unlicense).
## Build

```bash
# Linux (native)
cmake -B build -DCMAKE_BUILD_TYPE=Release
cmake --build build

# Windows cross-compile (mingw-w64, produces static .exe)                                                        cmake -B build-win32 -DCMAKE_TOOLCHAIN_FILE=cmake/mingw-w64.cmake
cmake --build build-win32                                                                                      
Test

cmake --build build                                                                                              ctest --test-dir build          # or: bash test/test.sh build/quilt
Tests are a single bash script (test/test.sh) that exercises every implemented command. It takes the quilt       binary path as its argument and runs in a temp directory.
Architecture

All internal strings are UTF-8. The type aliases Str and StrView (defined in quilt.hpp) are used throughout.

Headers

- quilt.hpp — precompiled header and shared interface. Defines QuiltState, string/path utilities, Command        dispatch table type, and all cmd_* function declarations.
- platform.hpp — platform abstraction layer: process execution (run_cmd, run_cmd_input), filesystem ops,         environment, and I/O. Declares quilt_main().                                                                   
Source files                                                                                                   
- core.cpp — QuiltState methods, string/path utilities, series/applied-patches file I/O, backup/restore file     helpers, quilt_main() entry point with command dispatch table.
- cmd_stack.cpp — stack navigation and push/pop: series, applied, unapplied, top, next, previous, push, pop.     - cmd_patch.cpp — patch content commands: new, add, remove, edit, refresh, diff, revert.
- cmd_manage.cpp — patch management: delete, rename, import, header, files, patches, fold, fork.                 - cmd_stubs.cpp — unimplemented commands that return "not yet implemented": annotate, grep, graph, guard, mail,   setup, shell, snapshot, upgrade, init.                                                                          - platform_posix.cpp — POSIX implementation (fork/exec, POSIX file I/O). Contains main().
- platform_win32.cpp — Win32 implementation (CreateProcess, wide-char APIs, UTF-16 conversion). Contains         wmain().                                                                                                                                                                                                                          Key design patterns                                                                                            
- Platform selection at build time: CMakeLists.txt links exactly one of platform_posix.cpp or
platform_win32.cpp. No #ifdef in shared code.
- Backup-based patch tracking: Push/pop works by backing up files into .pc/<patchname>/ before applying
patches. Pop restores from these backups. The external patch command is used for applying diffs; diff is used    for generating them.
- Core helpers accessed via extern: Functions like ensure_pc_dir, backup_file, restore_file, write_series,       write_applied, pc_patch_dir, and files_in_patch are defined in core.cpp but not declared in headers — command    files use extern forward declarations.
- Command signature: Every command is int cmd_*(QuiltState &q, int argc, char **argv) where argv[0] is the       command name. Commands do their own option parsing with simple loops.                                          
