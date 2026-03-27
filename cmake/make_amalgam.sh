#!/bin/sh
# cmake/make_amalgam.sh
# Generates quilt.cpp: a single-file amalgamation of all sources (Windows platform).
# Usage: sh cmake/make_amalgam.sh <source-root> <output> <sources...>
set -e
src_dir=$1; shift
output=$1; shift
# Remaining arguments are the source files (relative to source-root)
files=""
for f; do files="$files $f"; done
awk -v src_dir="$src_dir" -v file_list="$files" '
BEGIN {
    nf = split(file_list, files)

    printf "// quilt.cpp \342\200\224 single-file amalgamation (Windows platform)\n"
    printf "// $ c++ -std=c++20 -o quilt.exe quilt.cpp -lshell32\n"
    printf "// This is free and unencumbered software released into the public domain.\n\n"

    for (fi = 1; fi <= nf; fi++) {
        path = src_dir "/" files[fi]
        printf "// === %s ===\n\n", files[fi]
        skip = 0; depth = 0; brace_open = 0

        while ((getline line < path) > 0) {
            if (line ~ /^#pragma once/)                   continue
            if (line ~ /^#include[ \t]+"quilt\.hpp"/)    continue
            if (line ~ /^#include[ \t]+"platform\.hpp"/) continue

            if (skip) {
                for (ci = 1; ci <= length(line); ci++) {
                    c = substr(line, ci, 1)
                    if (c == "{") { depth++; brace_open = 1 }
                    else if (c == "}") depth--
                }
                if (brace_open && depth <= 0) { skip=0; depth=0; brace_open=0 }
                continue
            }

            if (line ~ /^static /) {
                tmp = line
                sub(/^static[ \t]+/, "", tmp)
                paren = index(tmp, "(")
                if (paren > 0) {
                    before = substr(tmp, 1, paren - 1)
                    gsub(/[^a-zA-Z0-9_]/, " ", before)
                    nw = split(before, wds)
                    if (nw > 0) {
                        fname = wds[nw]
                        if (fname in seen) {
                            skip=1; depth=0; brace_open=0
                            for (ci = 1; ci <= length(line); ci++) {
                                c = substr(line, ci, 1)
                                if (c == "{") { depth++; brace_open=1 }
                                else if (c == "}") depth--
                            }
                            if (brace_open && depth <= 0) skip = 0
                            continue
                        }
                        seen[fname] = 1
                    }
                }
            }
            print line
        }
        close(path)
        print ""
    }
}
' /dev/null > "$output"
