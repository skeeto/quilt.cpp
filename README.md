# Quilt.cpp: implementation of Quilt in C++

Quilt.cpp is a clone of [Quilt][] in C++17. The original is implemented
primarily as Bash scripts, with associated unix utilities, with a few
components in Perl. It does not run natively on Windows. Quilt.cpp is a
native application designed to within on [w64devkit][], still requiring
external `diff` and `patch` programs.

This project is a clean-room AI rewrite. AI generated the tests based on
the Quilt documentation, online tutorials, and observing its behavior in
various scenarios. The tests then served as a conformance suite for its
own from-scratch Quilt implementation.

## Build

    $ cmake -B build
    $ cmake --build build

Tip: Set `CMAKE_BUILD_PARALLEL_LEVEL` for faster builds. To build the
Windows amalgamation source, `quilt.cpp`, for easy distribution:

    $ cmake --build -t amalgam

Then with `g++` or `clang++`:

    $ c++ -std=c++17 -municode -o quilt.exe quilt.cpp -lshell32

Or with `cl` or `clang-cl`:

    $ cl /std:c++17 quilt.cpp shell32.lib

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
matches `git format-patch --stdout` so that subjects, commit messages,
and authorship round-trip cleanly through `git am`.

Specific differences:

* **No `--send`**: Only `--mbox` is supported. Using `--send` produces an
  error. If you need to send, pipe the mbox through your MTA.
* **No cover letter**: The original always prepends a message numbered
  0/N. Since `git am` treats this as a real (empty) commit, it is omitted
  entirely. The options that existed to populate the cover letter (`-m`,
  `-M`, `--subject`, `--reply-to`) are rejected.
* **`--from` or `--sender` required**: The original falls back to the
  system's local email address. This implementation requires an explicit
  address to ensure the resulting commits have correct authorship.
* **Mbox separator matches Git**: Each message begins with
  `From 0000...0 Mon Sep 17 00:00:00 2001` (the same fixed line Git
  uses) rather than the traditional `From addr date` envelope.

Options that work the same as the original: `--mbox`, `--prefix`,
`--from`, `--sender`, `--to`, `--cc`, `--bcc`, and the `first`/`last`
patch range arguments (including `-` for first/last in series).


[w64devkit]: https://github.com/skeeto/w64devkit
[Quilt]: https://savannah.nongnu.org/projects/quilt
