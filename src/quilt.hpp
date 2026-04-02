// This is free and unencumbered software released into the public domain.
#pragma once
#include <cassert>
#include <charconv>
#include <format>
#include <cstddef>
#include <cstdint>
#include <cstring>
#include <algorithm>
#include <functional>
#include <iterator>
#include <map>
#include <set>
#include <optional>
#include <span>
#include <string>
#include <string_view>
#include <utility>
#include <vector>

// Checked integer cast: asserts value is representable in the target type.
template<typename To, typename From>
constexpr To checked_cast(From value) {
    static_assert(std::is_integral_v<To> && std::is_integral_v<From>);
    assert(std::in_range<To>(value));
    return static_cast<To>(value);
}

// Parse a decimal integer from a string_view. Returns 0 on failure.
inline ptrdiff_t parse_int(std::string_view s) {
    ptrdiff_t val = 0;
    std::from_chars(s.data(), s.data() + s.size(), val);
    return val;
}

// find/rfind wrappers returning ptrdiff_t (-1 for not-found).
inline ptrdiff_t str_find(std::string_view s, char c, ptrdiff_t pos = 0) {
    auto r = s.find(c, checked_cast<size_t>(pos));
    return r == std::string_view::npos ? ptrdiff_t{-1} : static_cast<ptrdiff_t>(r);
}
inline ptrdiff_t str_find(std::string_view s, std::string_view needle, ptrdiff_t pos = 0) {
    auto r = s.find(needle, checked_cast<size_t>(pos));
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
    std::string subdir;          // cwd relative to work_dir (empty at root)
    bool series_file_exists = false;

    std::vector<std::string> series;   // ordered patch names from series file
    std::vector<std::string> applied;  // applied patch names from .pc/applied-patches
    std::map<std::string, int> patch_strip_level;  // per-patch strip level from series
    std::set<std::string> patch_reversed;          // patches marked -R in series
    std::map<std::string, std::string> config;     // merged quiltrc + env settings

    // Computed helpers
    ptrdiff_t top_index() const;     // index of topmost applied in series (-1 if none)
    bool is_applied(std::string_view patch) const;
    std::optional<ptrdiff_t> find_in_series(std::string_view patch) const;
    int get_strip_level(std::string_view patch) const;  // returns 1 if not set
    std::string get_p_format(std::string_view patch) const;  // "0" or "1"
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
std::vector<std::string> split_on_whitespace(std::string_view s);
std::vector<std::string> shell_split(std::string_view s);

// Built-in patch engine
struct PatchOptions {
    int strip_level = 1;       // -pN
    int fuzz = 2;              // --fuzz=N (default 2)
    bool reverse = false;      // -R
    bool dry_run = false;      // --dry-run
    bool force = false;        // -f
    bool remove_empty = false; // -E
    bool quiet = false;        // -s
    bool merge = false;        // --merge
    std::string merge_style;   // "" or "diff3"
    // In-memory filesystem for fuzz testing. When non-null, all file I/O
    // in builtin_patch uses this map instead of real syscalls.
    // Key present = file exists, value = content.
    std::map<std::string, std::string> *fs = nullptr;
};

struct PatchResult {
    int exit_code;             // 0=success, 1=rejects
    std::string out;           // stdout-equivalent messages
    std::string err;           // stderr-equivalent messages
};

PatchResult builtin_patch(std::string_view patch_text, const PatchOptions &opts);

// Built-in diff engine
enum class DiffFormat { unified, context };
enum class DiffAlgorithm { myers, minimal, patience, histogram };

std::optional<DiffAlgorithm> parse_diff_algorithm(std::string_view name);

struct DiffResult {
    int exit_code;       // 0 = identical, 1 = different
    std::string output;  // formatted diff text
};

DiffResult builtin_diff(std::string_view old_path, std::string_view new_path,
                         int context_lines = 3,
                         std::string_view old_label = {},
                         std::string_view new_label = {},
                         DiffFormat format = DiffFormat::unified,
                         DiffAlgorithm algorithm = DiffAlgorithm::myers,
                         std::map<std::string, std::string> *fs = nullptr);

// Patch name helpers — shared across command files
inline std::string_view strip_patches_prefix(const QuiltState &q, std::string_view name) {
    if (name.starts_with(q.patches_dir) &&
        std::ssize(name) > std::ssize(q.patches_dir) &&
        name[checked_cast<size_t>(std::ssize(q.patches_dir))] == '/') {
        return name.substr(checked_cast<size_t>(std::ssize(q.patches_dir) + 1));
    }
    return name;
}

std::string format_patch(const QuiltState &q, std::string_view name);

inline std::string patch_path_display(const QuiltState &q, std::string_view name) {
    return format_patch(q, name);
}

// Resolve a user-provided file path relative to the current subdirectory.
inline std::string subdir_path(const QuiltState &q, std::string_view file) {
    if (q.subdir.empty()) return std::string(file);
    return q.subdir + "/" + std::string(file);
}

// Core helpers — defined in core.cpp
bool ensure_pc_dir(QuiltState &q);
std::string pc_patch_dir(const QuiltState &q, std::string_view patch);
std::vector<std::string> files_in_patch(const QuiltState &q, std::string_view patch);
bool backup_file(QuiltState &q, std::string_view patch, std::string_view file);
bool restore_file(QuiltState &q, std::string_view patch, std::string_view file);
std::vector<std::string> read_series(std::string_view path,
                                     std::map<std::string, int> *strip_levels,
                                     std::set<std::string> *reversed);
bool write_series(std::string_view path, std::span<const std::string> patches,
                  const std::map<std::string, int> &strip_levels,
                  const std::set<std::string> &reversed);
std::vector<std::string> read_applied(std::string_view path);
bool write_applied(std::string_view path, std::span<const std::string> patches);

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

// Command implementations — cmd_patch.cpp (continued)
int cmd_snapshot(QuiltState &q, int argc, char **argv);
int cmd_init(QuiltState &q, int argc, char **argv);

// Command implementations — cmd_manage.cpp (continued)
int cmd_upgrade(QuiltState &q, int argc, char **argv);

// Command implementations — cmd_annotate.cpp
int cmd_annotate(QuiltState &q, int argc, char **argv);

// Command implementations — cmd_graph.cpp
int cmd_graph(QuiltState &q, int argc, char **argv);

// Command stubs — cmd_stubs.cpp
int cmd_grep(QuiltState &q, int argc, char **argv);
int cmd_setup(QuiltState &q, int argc, char **argv);
int cmd_shell(QuiltState &q, int argc, char **argv);
