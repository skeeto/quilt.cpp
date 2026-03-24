// This is free and unencumbered software released into the public domain.
#pragma once
#include <cstdint>
#include <cstddef>
#include <cstring>
#include <string>
#include <vector>
#include <string_view>
#include <optional>
#include <functional>
#include <algorithm>

// UTF-8 string alias — all internal strings are UTF-8
using Str = std::string;
using StrView = std::string_view;

// Quilt .pc/ directory state
struct QuiltState {
    Str work_dir;        // project root
    Str patches_dir;     // typically "patches"
    Str pc_dir;          // typically ".pc"
    Str series_file;     // "patches/series"

    std::vector<Str> series;   // ordered patch names from series file
    std::vector<Str> applied;  // applied patch names from .pc/applied-patches

    // Computed helpers
    int top_index() const;     // index of topmost applied in series (-1 if none)
    bool is_applied(StrView patch) const;
    std::optional<int> find_in_series(StrView patch) const;
};

// I/O helpers
void out(StrView s);
void out_line(StrView s);
void err(StrView s);
void err_line(StrView s);

// Path utilities
Str path_join(StrView a, StrView b);
Str path_join(StrView a, StrView b, StrView c);
Str basename(StrView path);
Str dirname(StrView path);
Str strip_trailing_slash(StrView s);

// String utilities
Str trim(StrView s);
std::vector<Str> split_lines(StrView s);
bool starts_with(StrView s, StrView prefix);
bool ends_with(StrView s, StrView suffix);

// Command function type
using CmdFn = int (*)(QuiltState &q, int argc, char **argv);

struct Command {
    const char *name;
    CmdFn       fn;
    const char *usage;
};

// Command implementations — cmd_stack.cpp
int cmd_series(QuiltState &q, int argc, char **argv);
int cmd_applied(QuiltState &q, int argc, char **argv);
int cmd_unapplied(QuiltState &q, int argc, char **argv);
int cmd_top(QuiltState &q, int argc, char **argv);
int cmd_next(QuiltState &q, int argc, char **argv);
int cmd_previous(QuiltState &q, int argc, char **argv);
int cmd_push(QuiltState &q, int argc, char **argv);
int cmd_pop(QuiltState &q, int argc, char **argv);

// Command implementations — cmd_patch.cpp
int cmd_new(QuiltState &q, int argc, char **argv);
int cmd_add(QuiltState &q, int argc, char **argv);
int cmd_remove(QuiltState &q, int argc, char **argv);
int cmd_edit(QuiltState &q, int argc, char **argv);
int cmd_refresh(QuiltState &q, int argc, char **argv);
int cmd_diff(QuiltState &q, int argc, char **argv);
int cmd_revert(QuiltState &q, int argc, char **argv);

// Command implementations — cmd_manage.cpp
int cmd_delete(QuiltState &q, int argc, char **argv);
int cmd_rename(QuiltState &q, int argc, char **argv);
int cmd_import(QuiltState &q, int argc, char **argv);
int cmd_header(QuiltState &q, int argc, char **argv);
int cmd_files(QuiltState &q, int argc, char **argv);
int cmd_patches(QuiltState &q, int argc, char **argv);
int cmd_fold(QuiltState &q, int argc, char **argv);
int cmd_fork(QuiltState &q, int argc, char **argv);

// Command stubs — cmd_stubs.cpp
int cmd_annotate(QuiltState &q, int argc, char **argv);
int cmd_grep(QuiltState &q, int argc, char **argv);
int cmd_graph(QuiltState &q, int argc, char **argv);
int cmd_guard(QuiltState &q, int argc, char **argv);
int cmd_mail(QuiltState &q, int argc, char **argv);
int cmd_setup(QuiltState &q, int argc, char **argv);
int cmd_shell(QuiltState &q, int argc, char **argv);
int cmd_snapshot(QuiltState &q, int argc, char **argv);
int cmd_upgrade(QuiltState &q, int argc, char **argv);
int cmd_init(QuiltState &q, int argc, char **argv);
