// This is free and unencumbered software released into the public domain.
#pragma once
#define _POSIX_THREAD_SAFE_FUNCTIONS
#include <cassert>
#include <climits>
#include <cstddef>
#include <cstdint>
#include <cstring>
#include <algorithm>
#include <functional>
#include <iterator>
#include <map>
#include <optional>
#include <string>
#include <string_view>
#include <vector>

// Signed-to-unsigned boundary: asserts non-negative, casts to size_t.
inline size_t to_uz(ptrdiff_t n) {
    assert(n >= 0);
    return static_cast<size_t>(n);
}

// Signed-to-int boundary: asserts value fits in int range.
inline int to_int(ptrdiff_t n) {
    assert(n >= 0 && n <= INT_MAX);
    return static_cast<int>(n);
}

// find/rfind wrappers returning ptrdiff_t (-1 for not-found).
inline ptrdiff_t str_find(std::string_view s, char c, ptrdiff_t pos = 0) {
    auto r = s.find(c, to_uz(pos));
    return r == std::string_view::npos ? ptrdiff_t{-1} : static_cast<ptrdiff_t>(r);
}
inline ptrdiff_t str_find(std::string_view s, std::string_view needle, ptrdiff_t pos = 0) {
    auto r = s.find(needle, to_uz(pos));
    return r == std::string_view::npos ? ptrdiff_t{-1} : static_cast<ptrdiff_t>(r);
}
inline ptrdiff_t str_rfind(std::string_view s, char c) {
    auto r = s.rfind(c);
    return r == std::string_view::npos ? ptrdiff_t{-1} : static_cast<ptrdiff_t>(r);
}

// Quilt .pc/ directory state
struct QuiltState {
    std::string work_dir;        // project root
    std::string patches_dir;     // typically "patches"
    std::string pc_dir;          // typically ".pc"
    std::string series_file;     // "patches/series"
    bool series_file_exists = false;

    std::vector<std::string> series;   // ordered patch names from series file
    std::vector<std::string> applied;  // applied patch names from .pc/applied-patches
    std::map<std::string, int> patch_strip_level;  // per-patch strip level from series
    std::map<std::string, std::string> config;     // merged quiltrc + env settings

    // Computed helpers
    ptrdiff_t top_index() const;     // index of topmost applied in series (-1 if none)
    bool is_applied(std::string_view patch) const;
    std::optional<ptrdiff_t> find_in_series(std::string_view patch) const;
    int get_strip_level(std::string_view patch) const;  // returns 1 if not set
};

// I/O helpers
void out(std::string_view s);
void out_line(std::string_view s);
void err(std::string_view s);
void err_line(std::string_view s);

// Path utilities
std::string path_join(std::string_view a, std::string_view b);
std::string path_join(std::string_view a, std::string_view b, std::string_view c);
std::string basename(std::string_view path);
std::string dirname(std::string_view path);
std::string strip_trailing_slash(std::string_view s);

// String utilities
std::string trim(std::string_view s);
std::vector<std::string> split_lines(std::string_view s);
bool starts_with(std::string_view s, std::string_view prefix);
bool ends_with(std::string_view s, std::string_view suffix);
std::vector<std::string> split_on_whitespace(std::string_view s);
std::vector<std::string> shell_split(std::string_view s);

// Command function type
using CmdFn = int (*)(QuiltState &q, int argc, char **argv);

struct Command {
    const char *name;
    CmdFn       fn;
    const char *usage;
    const char *description;
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

// Command implementations — cmd_mail.cpp
int cmd_mail(QuiltState &q, int argc, char **argv);

// Command stubs — cmd_stubs.cpp
int cmd_annotate(QuiltState &q, int argc, char **argv);
int cmd_grep(QuiltState &q, int argc, char **argv);
int cmd_graph(QuiltState &q, int argc, char **argv);
int cmd_guard(QuiltState &q, int argc, char **argv);
int cmd_setup(QuiltState &q, int argc, char **argv);
int cmd_shell(QuiltState &q, int argc, char **argv);
int cmd_snapshot(QuiltState &q, int argc, char **argv);
int cmd_upgrade(QuiltState &q, int argc, char **argv);
int cmd_init(QuiltState &q, int argc, char **argv);
