#!/bin/sh
# cmake/make_amalgam.sh
# Generates quilt.cpp: a single-file amalgamation of all sources (Windows platform).
# Usage: sh cmake/make_amalgam.sh <source-root> <output> <sources...>
set -e
src_dir=$1; shift
output=$1; shift
version=$1; shift
# Remaining arguments are the source files (relative to source-root)
files=""
for f; do files="$files $f"; done
awk -v src_dir="$src_dir" -v file_list="$files" -v version="$version" '
# Several files define the same static helper, which in one translation
# unit would be a redefinition, so drop a static definition when it
# matches, apart from whitespace, one already written.  Keep any other,
# so that overloads survive, and so that two different functions with
# the same signature fail to compile rather than one replacing the other.
function emit(def,    key) {
    key = def
    gsub(/[ \t\r\n]+/, " ", key)
    if (!(key in seen)) {
        seen[key] = 1
        printf "%s", def
    }
}

BEGIN {
    nf = split(file_list, files)
    sq = sprintf("%c", 39)

    printf "// quilt.cpp \342\200\224 single-file amalgamation (Windows platform)\n"
    printf "// $ c++ -std=c++20 -o quilt.exe quilt.cpp -lshell32\n"
    printf "// $ cl /std:c++20 /EHsc quilt.cpp shell32.lib\n"
    printf "// This is free and unencumbered software released into the public domain.\n\n"
    printf "#define QUILT_VERSION \"%s\"\n\n", version

    for (fi = 1; fi <= nf; fi++) {
        path = src_dir "/" files[fi]
        printf "// === %s ===\n\n", files[fi]
        in_def = 0

        while ((getline line < path) > 0) {
            if (line ~ /^#pragma once/)                   continue
            if (line ~ /^#include[ \t]+"quilt\.hpp"/)    continue
            if (line ~ /^#include[ \t]+"platform\.hpp"/) continue

            if (!in_def && line ~ /^static / && index(line, "(") > 0) {
                in_def = 1; def = ""; depth = 0; brace_open = 0
            }
            if (!in_def) {
                print line
                continue
            }

            # A definition ends at the brace closing its body, and a
            # declaration at its semicolon.  Braces in literals and
            # comments do not count.
            def = def line "\n"
            code = line
            gsub(/\\./, "", code)
            gsub(sq "[^" sq "]*" sq, "", code)
            gsub(/"[^"]*"/, "", code)
            sub(/\/\/.*/, "", code)
            opens = gsub(/[{]/, "", code)
            depth += opens - gsub(/[}]/, "", code)
            if (opens > 0) brace_open = 1
            if ((brace_open && depth <= 0) || (!brace_open && code ~ /;[ \t]*$/)) {
                emit(def)
                in_def = 0
            }
        }
        if (in_def) emit(def)
        close(path)
        print ""
    }
}
' /dev/null > "$output"
