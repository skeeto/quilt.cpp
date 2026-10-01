# Quilt.cpp: implementation of Quilt in C++

Quilt.cpp is a clone of [Quilt][] in C++20. The original is a collection
of Bash scripts driving Coreutils, plus a bit of Perl. It does not support
native Windows. In contrast, Quilt.cpp is a standalone, native application
intended to complement [w64devkit][]. It embeds a `diff` and `patch`, and
so does not depend on any external tool except `$EDITOR`.

This project is a clean-room AI rewrite. AI generated the tests based on
the Quilt documentation, online tutorials, and observing the original's
behavior in various scenarios. The tests then served as a conformance
suite for its own from-scratch Quilt implementation. **Every line outside
this `README.md` is written by AI.** The original, feature complete — less
deliberately omitted features listed below — was written with Claude Code
over the course of four days.

## Build

    $ cmake -B build
    $ cmake --build build

Tip: Set `CMAKE_BUILD_PARALLEL_LEVEL` for faster builds. To build the
Windows amalgamation source, `quilt.cpp`, for easy distribution:

    $ cmake --build -t amalgam

Then later without any build system:

    $ c++ -std=c++20 -o quilt.exe quilt.cpp -lshell32

Or with MSVC:

    $ cl /std:c++20 /EHsc quilt.cpp shell32.lib

## Tests

    $ cmake --build -build -t test

Tip: Set `CTEST_PARALLEL_LEVEL` for faster builds. Run tests against any
Quilt using `QUILT_TEST_EXECUTABLE`:

    $ cmake -B build -DQUILT_TEST_EXECUTABLE=/bin/quilt
    $ cmake --build -build -t test

The purpose is validate the tests against the original Quilt.

## Differences from Quilt

### `quilt mail`

The original Quilt `mail` command is designed for emailing patches to
mailing lists. It supports `--send` (direct SMTP via `sendmail`) and
`--mbox` (write to a file), and it always generates a cover letter as the
first message (patch 0/N), opening `$EDITOR` for its contents.

Quilt.cpp targets a different workflow: generating an mbox that can be
applied on another machine with `git am`. The output format closely
matches `git format-patch --stdout` so that subjects, commit messages, and
authorship round-trip through `git am`. `--send` is unsupported.

To avoid passing `--from` every invocation, set a default in `~/.quiltrc`:

    QUILT_MAIL_ARGS='--from "First Last <user@example.com>" --mbox patches.mbox'

### Built-in diff engine and `--diff-algorithm`

Quilt.cpp includes a built-in diff engine and does not require an
external `diff` program. The `diff` and `refresh` commands accept
`--diff-algorithm={myers|minimal|patience|histogram}` to select the
algorithm, following the same convention as `git diff --diff-algorithm`.

The `QUILT_DIFF_ALGORITHM` environment variable sets the default
algorithm, overridden by the command-line flag. Unlike putting
`--diff-algorithm` in `QUILT_REFRESH_ARGS`, this variable is safely
ignored by the original Quilt, so it can be set in `~/.quiltrc`:

    QUILT_DIFF_ALGORITHM=patience

### Shell-like splitting for `QUILT_*_ARGS`

The original Quilt is a Bash script, and variables like `QUILT_MAIL_ARGS`
are `eval`'d with full shell syntax. Quilt.cpp implements a purpose-built
splitter that covers the useful subset: single quotes (literal, no
escapes), double quotes (with `\"`, `\\`, `\$` escapes), `$VAR` and
`${VAR}` expansion, and backslash escapes in unquoted text. Adjacent
quoted and unquoted segments merge into a single token, just as in a
shell. This applies to all `QUILT_*_ARGS` and `QUILT_*_OPTS` variables.

### Default fork names

`fork` and `refresh -z` count up a `-N` suffix in decimal, so `p-08.patch`
forks to `p-9.patch` and `p-010.patch` to `p-11.patch`, where the original
Quilt's shell arithmetic reads it as octal (and fails on `08` and `09`).

### Header merging in `quilt import -f`

When `import -f` replaces a patch without `-d`, the original Quilt keeps
the old header if the new version has none, takes the new version if the
old one has none, and refuses when both have headers that differ. Two of
its quirks are not reproduced. When the headers match, it writes the old
header followed by the whole new version, so the header appears twice;
Quilt.cpp writes the new version as it is. And once it keeps the old
header or takes the new version for one patch, that choice carries over
to the later patches named in the same command, which can drop a header
or skip the check for differing ones; Quilt.cpp chooses for each patch
separately.

### Deliberately omitted features

Quilt.cpp omits `setup` because it's an old, RPM-specific workflow that
won't benefit from this rewrite. It omits `grep` because it's merely a
wrapper around an external `grep`, which exists mainly because it's easy
to do from a shell script. The `shell` command is to help work around the
Quilt's untracked-file limitations, but it's blunt, and like grep it's a
natural outgrowth of the original's shell-script nature.

There is no built-in pager support. `LESS` and `QUILT_PAGER` do nothing.

The `--color` option is parsed, validated, and discarded. Like Quilt's,
it may be given alone or as `--color=` with an empty value, `always`,
`auto`, `tty`, or `never`. `QUILT_COLORS` is not examined. Quilt.cpp does
not produce color output because it is not intended for children.

## Fuzz Testing

There are [libFuzzer][] harnesses for the patch engine, the
shell-like argument splitter, and a round-trip diff-patch correctness
test. Build them with a non-Apple Clang that includes the fuzzer
runtime:

    $ cmake -B build-fuzz -DENABLE_FUZZ=ON \
          -DCMAKE_CXX_COMPILER=clang++ -DCMAKE_BUILD_TYPE=Debug
    $ cmake --build build-fuzz -t fuzz_patch -t fuzz_shell_split \
          -t fuzz_roundtrip -t fuzz_roundtrip_fuzz
    $ ASAN_OPTIONS=detect_container_overflow=0 \
          ./build-fuzz/fuzz_patch fuzz/corpus/ -max_len=65536
    $ ASAN_OPTIONS=detect_container_overflow=0 \
          ./build-fuzz/fuzz_shell_split fuzz/corpus_shell_split/ -max_len=4096
    $ ASAN_OPTIONS=detect_container_overflow=0 \
          ./build-fuzz/fuzz_roundtrip fuzz/corpus_roundtrip/ -max_len=2048
    $ ASAN_OPTIONS=detect_container_overflow=0 \
          ./build-fuzz/fuzz_roundtrip_fuzz fuzz/corpus_roundtrip_fuzz/ -max_len=2048

`fuzz_patch` exercises patch parsing, hunk matching, output building,
merge conflict markers, and reject generation. An in-memory filesystem
(`PatchOptions::fs`) prevents the fuzzer from touching the real
filesystem despite arbitrary filenames in fuzz-generated patches.

`fuzz_shell_split` exercises the `shell_split()` parser used for
`QUILT_*_ARGS` environment variables, covering single/double quoting,
backslash escapes, and `$VAR`/`${VAR}` expansion.

`fuzz_roundtrip` generates a diff between two fuzzed strings with each
diff algorithm (myers, minimal, patience, histogram) in both unified
and context format, applies each resulting patch to the first string,
and asserts the result matches the second. This catches semantic
correctness bugs that crash-only fuzzing misses.

`fuzz_roundtrip_fuzz` generates a valid diff with each algorithm, then
mutates the "old" content to simulate source drift before applying the
patch with fuzz matching (fuzz 1–3). This exercises the offset-search
and context-trimming logic on well-formed patches without crashing.

The normal build compiles these four harnesses without linking them, so
an API change that would break them fails there too.

`fuzz_differential` is a standalone differential tester (not
libFuzzer). It generates random sequences of quilt operations and runs
them against both quilt.cpp and the system-installed `quilt`, comparing
exit codes and final filesystem state. Requires `quilt` to be
installed:

    $ cmake --build build-fuzz -t fuzz_differential
    $ ./build-fuzz/fuzz_differential \
          --quilt-cpp ./build/quilt --quilt-system quilt \
          --iterations 1000 --seed 1

[libFuzzer]: https://llvm.org/docs/LibFuzzer.html


[Quilt]: https://savannah.nongnu.org/projects/quilt
[w64devkit]: https://github.com/skeeto/w64devkit
