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


[w64devkit]: https://github.com/skeeto/w64devkit
[Quilt]: https://savannah.nongnu.org/projects/quilt
