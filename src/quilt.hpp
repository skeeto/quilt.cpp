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
    // Patch after the topmost applied one (the first patch if none is
    // applied), which new patches go in front of; empty at the series end.
    std::string patch_after_top() const;
    bool is_applied(std::string_view patch) const;
    std::optional<ptrdiff_t> find_in_series(std::string_view patch) const;
    int get_strip_level(std::string_view patch) const;  // returns 1 if not set
    std::string get_p_format(std::string_view patch) const;  // strip level as "-p" value
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

// A patch's description and its diff, split as upstream's patch_header and
// patch_body split them, and a description without its diffstat, as
// upstream's strip_diffstat. Like those awk scripts, these keep every byte,
// CRs included, but end a nonempty result with a newline.
std::string patch_header(std::string_view patch);
std::string patch_body(std::string_view patch);
std::string strip_diffstat(std::string_view header);
// A description with its diffstat replaced by (or, if it has none,
// followed by) a new one, as upstream's refresh --diffstat does it
std::string replace_diffstat(std::string_view header, std::string_view diffstat);

// Built-in patch engine.  Like GNU patch given the -f that quilt always
// passes, it never asks questions: it applies what it can and skips
// missing files the patch does not create.
struct PatchOptions {
    int strip_level = 1;       // -pN
    int fuzz = 2;              // --fuzz=N (default 2), see set_fuzz_option
    bool reverse = false;      // -R
    bool dry_run = false;      // --dry-run
    bool remove_empty = false; // -E
    bool quiet = false;        // -s
    bool merge = false;        // --merge
    std::string merge_style;   // "" or "diff3"
    // A bad option, such as a fuzz factor that is not a number, which like
    // GNU patch ends the patch before it touches any file
    std::string option_error;
    // In-memory filesystem for fuzz testing. When non-null, all file I/O
    // in builtin_patch uses this map instead of real syscalls.
    // Key present = file exists, value = content.
    std::map<std::string, std::string> *fs = nullptr;
};

struct PatchResult {
    int exit_code;             // 0=success, 1=rejects, 2=fatal
    // Like GNU patch, every message in order on stdout, and only a fatal
    // error, which ends the patch, on stderr
    std::string out;
    std::string err;
    // Files left alone that GNU patch would not have backed up: missing
    // files the patch does not create, or every file when a bad option
    // ends the patch before it starts
    std::vector<std::string> skipped;
};

PatchResult builtin_patch(std::string_view patch_text, const PatchOptions &opts);

// Set the fuzz factor from a --fuzz option's value, read as GNU patch
// reads it: an optional sign, then digits, and not negative. A factor too
// large for an int is clamped, since no hunk can use more fuzz than it has
// context. A bad value, the first one only, goes in opts.option_error.
void set_fuzz_option(PatchOptions &opts, std::string_view value);
// Set the strip level from a -p option's value, read the same way.
void set_strip_option(PatchOptions &opts, std::string_view value);

// Files builtin_patch would modify, without duplicates, in patch order.
// A deleted file (+++ /dev/null) is named by its --- line.
std::vector<std::string> patch_target_files(std::string_view patch_text,
                                            int strip_level, bool reverse = false);

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

// Default name for a fork of patch, like upstream's next_filename: a
// trailing "-N" ahead of any .diff, .dif, or .patch and compression suffix
// counts up, otherwise "-2" goes there (p.patch -> p-2.patch -> p-3.patch).
std::string next_filename(std::string_view patch);

// Patch lookups, like upstream's functions of the same names. Pass a
// patch argument as given: these strip the patches/ prefix themselves.
// Decide whether an argument was given before stripping, since a bare
// "patches/" is an argument that names no patch, not a request for the
// top patch. On failure, each prints the reason and returns nullopt.
//
// find_patch: the named patch must be in the series.
// find_top_patch: the topmost applied patch, which must be in the series.
// find_patch_in_series: find_patch, except an empty name means the top patch.
// find_applied_patch: find_patch_in_series, and the patch must be applied.
std::optional<std::string> find_patch(const QuiltState &q, std::string_view name);
std::optional<std::string> find_top_patch(const QuiltState &q);
std::optional<std::string> find_patch_in_series(const QuiltState &q, std::string_view name);
std::optional<std::string> find_applied_patch(const QuiltState &q, std::string_view name);

// Whether when, the value of a --color option, is valid. Like upstream, it
// may be empty, always, auto, tty, or never. Quilt.cpp never colors its
// output, so commands discard the option once it checks out.
bool valid_color_value(std::string_view when);

// Command-line options, parsed like the util-linux getopt(1) that upstream
// runs over each command's arguments, QUILT_<CMD>_ARGS first:
//
// - Short options may be grouped (-qa). A value goes attached (-p0) or in
//   the next word (-p 0), whatever that word is. An optional value, as in
//   "z::", only goes attached, and is empty when absent.
// - Long options take a value after "=" (--fuzz=2), or, when required, in
//   the next word (--fuzz 2). A unique prefix names an option (--leave).
//   When an upstream option and a quilt.cpp extension share the prefix,
//   the upstream option wins.
// - Options and operands mix in any order. "--" ends the options, and ""
//   and "-" are operands.
// - Every command takes --help as -h, a quilt.cpp extension.
enum class OptArg : unsigned char { none, required, optional };

struct LongOpt {
    std::string_view name;
    OptArg arg;
    int key;                 // a short option letter for an alias, else >= 256
    bool extension = false;  // quilt.cpp only, so upstream options win ties
};

struct ParsedOption {
    int key;                 // the short option letter or LongOpt::key
    std::string_view value;  // empty when absent
};

struct ParsedArgs {
    std::vector<ParsedOption> options;   // in command-line order
    std::vector<std::string_view> operands;
};

// Parse argv[1..argc), where argv[0] is the command's name. On a bad
// option, print what is wrong and the command's usage, as upstream does,
// and return nullopt, upon which the command exits with status 1.
std::optional<ParsedArgs> parse_options(int argc, char **argv,
                                        std::string_view shortopts,
                                        std::span<const LongOpt> longopts = {});

// Print the command's usage line on stderr, for wrong arguments, and
// return 1, upstream's exit status for them.
int usage_error(std::string_view command);
// Print the command's help on stdout, for -h, and return 0.
int command_help(std::string_view command);

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
// Line-preserving series edits, like upstream's insert_in_series,
// remove_from_series, rename_in_series, and change_db_strip_level. Only the
// patch's own line changes, so comments, blank lines, and options on other
// lines survive. Each reloads q.series, q.patch_strip_level, and
// q.patch_reversed from the edited file.
//
// insert_in_series adds "patch opts" in front of before's line, or at the
// end when before is empty. set_series_strip_level records strip_level
// (omitted when 1) and drops -R on patch's line, keeping its other options.
bool insert_in_series(QuiltState &q, std::string_view patch,
                      std::string_view opts, std::string_view before);
bool remove_from_series(QuiltState &q, std::string_view patch);
bool rename_in_series(QuiltState &q, std::string_view from, std::string_view to);
bool set_series_strip_level(QuiltState &q, std::string_view patch,
                            int strip_level);
// The options on patch's series line, without any comment.
std::string series_patch_args(const QuiltState &q, std::string_view patch);
std::vector<std::string> read_applied(std::string_view path);
bool write_applied(std::string_view path, std::span<const std::string> patches);

// Command function type
using CmdFn = int (*)(QuiltState &q, int argc, char **argv);

struct Command {
    const char *name;
    CmdFn       fn;
    const char *synopsis;     // usage line for wrong arguments, as upstream's
    const char *usage;        // full help, for -h
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
