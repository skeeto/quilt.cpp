// This is free and unencumbered software released into the public domain.
#include "quilt.hpp"
#include "platform.hpp"

int QuiltState::top_index() const {
    if (applied.empty()) return -1;
    const std::string &top = applied.back();
    for (int i = 0; i < (int)series.size(); ++i) {
        if (series[i] == top) return i;
    }
    return -1;
}

bool QuiltState::is_applied(std::string_view patch) const {
    for (const auto &a : applied) {
        if (a == patch) return true;
    }
    return false;
}

std::optional<int> QuiltState::find_in_series(std::string_view patch) const {
    for (int i = 0; i < (int)series.size(); ++i) {
        if (series[i] == patch) return i;
    }
    return std::nullopt;
}

int QuiltState::get_strip_level(std::string_view patch) const {
    auto it = patch_strip_level.find(std::string(patch));
    if (it != patch_strip_level.end()) return it->second;
    return 1;
}

void out(std::string_view s) {
    fd_write_stdout(s);
}

void out_line(std::string_view s) {
    fd_write_stdout(s);
    fd_write_stdout("\n");
}

void err(std::string_view s) {
    fd_write_stderr(s);
}

void err_line(std::string_view s) {
    fd_write_stderr(s);
    fd_write_stderr("\n");
}

std::string path_join(std::string_view a, std::string_view b) {
    if (a.empty()) return std::string(b);
    if (b.empty()) return std::string(a);
    if (a.back() == '/') return std::string(a) + std::string(b);
    return std::string(a) + "/" + std::string(b);
}

std::string path_join(std::string_view a, std::string_view b, std::string_view c) {
    return path_join(path_join(a, b), c);
}

std::string basename(std::string_view path) {
    if (path.empty()) return "";
    // Strip trailing slashes
    while (path.size() > 1 && path.back() == '/')
        path.remove_suffix(1);
    auto pos = path.rfind('/');
    if (pos == std::string_view::npos) return std::string(path);
    return std::string(path.substr(pos + 1));
}

std::string dirname(std::string_view path) {
    if (path.empty()) return ".";
    // Strip trailing slashes
    while (path.size() > 1 && path.back() == '/')
        path.remove_suffix(1);
    auto pos = path.rfind('/');
    if (pos == std::string_view::npos) return ".";
    if (pos == 0) return "/";
    return std::string(path.substr(0, pos));
}

std::string strip_trailing_slash(std::string_view s) {
    while (!s.empty() && s.back() == '/')
        s.remove_suffix(1);
    return s.empty() ? std::string("/") : std::string(s);
}

std::string trim(std::string_view s) {
    while (!s.empty() && (s.front() == ' ' || s.front() == '\t' ||
                          s.front() == '\r' || s.front() == '\n'))
        s.remove_prefix(1);
    while (!s.empty() && (s.back() == ' ' || s.back() == '\t' ||
                          s.back() == '\r' || s.back() == '\n'))
        s.remove_suffix(1);
    return std::string(s);
}

std::vector<std::string> split_lines(std::string_view s) {
    std::vector<std::string> lines;
    while (!s.empty()) {
        auto pos = s.find('\n');
        if (pos == std::string_view::npos) {
            lines.emplace_back(s);
            break;
        }
        lines.emplace_back(s.substr(0, pos));
        s.remove_prefix(pos + 1);
    }
    return lines;
}

bool starts_with(std::string_view s, std::string_view prefix) {
    if (prefix.size() > s.size()) return false;
    return s.substr(0, prefix.size()) == prefix;
}

bool ends_with(std::string_view s, std::string_view suffix) {
    if (suffix.size() > s.size()) return false;
    return s.substr(s.size() - suffix.size()) == suffix;
}

std::vector<std::string> split_on_whitespace(std::string_view s) {
    std::vector<std::string> tokens;
    size_t i = 0;
    while (i < s.size()) {
        while (i < s.size() && (s[i] == ' ' || s[i] == '\t'))
            ++i;
        if (i >= s.size()) break;
        size_t start = i;
        while (i < s.size() && s[i] != ' ' && s[i] != '\t')
            ++i;
        tokens.emplace_back(s.substr(start, i - start));
    }
    return tokens;
}

static bool is_varname_start(char c) {
    return (c >= 'A' && c <= 'Z') || (c >= 'a' && c <= 'z') || c == '_';
}

static bool is_varname_char(char c) {
    return is_varname_start(c) || (c >= '0' && c <= '9');
}

static std::string expand_var(std::string_view s, size_t &i) {
    // i points just past '$'
    std::string name;
    if (i < s.size() && s[i] == '{') {
        ++i; // skip '{'
        while (i < s.size() && s[i] != '}') {
            name += s[i++];
        }
        if (i < s.size()) ++i; // skip '}'
    } else {
        while (i < s.size() && is_varname_char(s[i])) {
            name += s[i++];
        }
    }
    if (name.empty()) return "$";
    return get_env(name);
}

std::vector<std::string> shell_split(std::string_view s) {
    std::vector<std::string> tokens;
    size_t i = 0;
    while (i < s.size()) {
        // Skip whitespace between tokens
        while (i < s.size() && (s[i] == ' ' || s[i] == '\t'))
            ++i;
        if (i >= s.size()) break;

        std::string tok;
        // Accumulate segments until unquoted whitespace
        while (i < s.size() && s[i] != ' ' && s[i] != '\t') {
            if (s[i] == '\'') {
                // Single-quoted: literal, no escapes, no variable expansion
                ++i;
                while (i < s.size() && s[i] != '\'')
                    tok += s[i++];
                if (i < s.size()) ++i; // skip closing '
            } else if (s[i] == '"') {
                // Double-quoted: backslash escapes and variable expansion
                ++i;
                while (i < s.size() && s[i] != '"') {
                    if (s[i] == '\\' && i + 1 < s.size()) {
                        char next = s[i + 1];
                        if (next == '"' || next == '\\' || next == '$') {
                            tok += next;
                            i += 2;
                            continue;
                        }
                    }
                    if (s[i] == '$') {
                        ++i;
                        tok += expand_var(s, i);
                        continue;
                    }
                    tok += s[i++];
                }
                if (i < s.size()) ++i; // skip closing "
            } else if (s[i] == '$') {
                // Unquoted variable expansion
                ++i;
                tok += expand_var(s, i);
            } else if (s[i] == '\\' && i + 1 < s.size()) {
                // Unquoted backslash escape
                tok += s[i + 1];
                i += 2;
            } else {
                tok += s[i++];
            }
        }
        if (!tok.empty()) {
            tokens.push_back(std::move(tok));
        }
    }
    return tokens;
}

std::vector<std::string> read_series(std::string_view path,
                                     std::map<std::string, int> *strip_levels) {
    std::vector<std::string> patches;
    std::string content = read_file(path);
    if (content.empty()) return patches;
    auto lines = split_lines(content);
    for (auto &line : lines) {
        std::string trimmed = trim(line);
        if (trimmed.empty()) continue;
        if (trimmed[0] == '#') continue;
        // Strip inline comments
        auto hash = trimmed.find(" #");
        if (hash != std::string::npos) {
            trimmed = trim(std::string_view(trimmed).substr(0, hash));
        }
        // Split into tokens
        auto tokens = split_on_whitespace(trimmed);
        if (tokens.empty()) continue;
        std::string name = tokens[0];
        // Parse options (e.g., "-p0", "-p 0")
        int strip = 1;
        for (size_t i = 1; i < tokens.size(); ++i) {
            if (tokens[i] == "-p" && i + 1 < tokens.size()) {
                strip = std::stoi(tokens[i + 1]);
                ++i;
            } else if (starts_with(tokens[i], "-p") && tokens[i].size() > 2) {
                strip = std::stoi(tokens[i].substr(2));
            }
        }
        if (strip_levels && strip != 1) {
            (*strip_levels)[name] = strip;
        }
        patches.push_back(std::move(name));
    }
    return patches;
}

bool write_series(std::string_view path, const std::vector<std::string> &patches,
                  const std::map<std::string, int> &strip_levels) {
    std::string content;
    for (const auto &p : patches) {
        content += p;
        auto it = strip_levels.find(p);
        if (it != strip_levels.end() && it->second != 1) {
            content += " -p";
            content += std::to_string(it->second);
        }
        content += '\n';
    }
    return write_file(path, content);
}

std::vector<std::string> read_applied(std::string_view path) {
    std::vector<std::string> patches;
    std::string content = read_file(path);
    if (content.empty()) return patches;
    auto lines = split_lines(content);
    for (auto &line : lines) {
        std::string trimmed = trim(line);
        if (!trimmed.empty()) {
            patches.push_back(std::move(trimmed));
        }
    }
    return patches;
}

bool write_applied(std::string_view path, const std::vector<std::string> &patches) {
    std::string content;
    for (const auto &p : patches) {
        content += p;
        content += '\n';
    }
    return write_file(path, content);
}

bool ensure_pc_dir(QuiltState &q) {
    std::string pc = path_join(q.work_dir, q.pc_dir);
    if (!is_directory(pc)) {
        if (!make_dirs(pc)) {
            err_line("Failed to create " + pc);
            return false;
        }
    }
    // Write .version
    std::string version_path = path_join(pc, ".version");
    if (!file_exists(version_path)) {
        if (!write_file(version_path, "2\n")) {
            err_line("Failed to write " + version_path);
            return false;
        }
    }
    // Write .quilt_patches
    std::string qp_path = path_join(pc, ".quilt_patches");
    if (!file_exists(qp_path)) {
        if (!write_file(qp_path, q.patches_dir + "\n")) {
            err_line("Failed to write " + qp_path);
            return false;
        }
    }
    // Write .quilt_series
    std::string qs_path = path_join(pc, ".quilt_series");
    if (!file_exists(qs_path)) {
        std::string series_name = get_env("QUILT_SERIES");
        if (series_name.empty()) series_name = "series";
        if (!write_file(qs_path, series_name + "\n")) {
            err_line("Failed to write " + qs_path);
            return false;
        }
    }
    return true;
}

// Parse a simplified subset of bash KEY=VALUE assignments from a quiltrc file.
// Supports: KEY=value, KEY="value", KEY='value', export KEY=value
// Skips comments (#), blank lines, and lines that aren't assignments.
static std::map<std::string, std::string> parse_quiltrc(std::string_view content) {
    std::map<std::string, std::string> result;
    auto lines = split_lines(content);
    for (auto &line : lines) {
        std::string_view sv = line;
        // Strip leading whitespace
        while (!sv.empty() && (sv.front() == ' ' || sv.front() == '\t'))
            sv.remove_prefix(1);
        // Skip blank lines and comments
        if (sv.empty() || sv.front() == '#') continue;
        // Strip optional "export " prefix
        if (sv.size() > 7 && sv.substr(0, 7) == "export ") {
            sv.remove_prefix(7);
            while (!sv.empty() && (sv.front() == ' ' || sv.front() == '\t'))
                sv.remove_prefix(1);
        }
        // Find '=' for KEY=VALUE
        auto eq = sv.find('=');
        if (eq == std::string_view::npos || eq == 0) continue;
        // Validate key: must be alphanumeric/underscore
        std::string_view key = sv.substr(0, eq);
        bool valid_key = true;
        for (char c : key) {
            if (!((c >= 'A' && c <= 'Z') || (c >= 'a' && c <= 'z') ||
                  (c >= '0' && c <= '9') || c == '_')) {
                valid_key = false;
                break;
            }
        }
        if (!valid_key) continue;
        // Parse value
        std::string_view rest = sv.substr(eq + 1);
        std::string value;
        if (!rest.empty() && rest.front() == '"') {
            // Double-quoted: handle \" and \\ escapes
            rest.remove_prefix(1);
            while (!rest.empty() && rest.front() != '"') {
                if (rest.front() == '\\' && rest.size() > 1) {
                    char next = rest[1];
                    if (next == '"' || next == '\\') {
                        value += next;
                        rest.remove_prefix(2);
                        continue;
                    }
                }
                value += rest.front();
                rest.remove_prefix(1);
            }
        } else if (!rest.empty() && rest.front() == '\'') {
            // Single-quoted: literal, no escapes
            rest.remove_prefix(1);
            while (!rest.empty() && rest.front() != '\'') {
                value += rest.front();
                rest.remove_prefix(1);
            }
        } else {
            // Unquoted: ends at whitespace, line ending, or #
            while (!rest.empty() && rest.front() != ' ' && rest.front() != '\t' &&
                   rest.front() != '\r' && rest.front() != '\n' &&
                   rest.front() != '#') {
                value += rest.front();
                rest.remove_prefix(1);
            }
        }
        result[std::string(key)] = value;
    }
    return result;
}

// Load and parse the quiltrc file. If quiltrc_path is empty, use default
// search order (~/.quiltrc, /etc/quilt.quiltrc). If "-", skip loading.
static std::map<std::string, std::string> load_quiltrc(const std::string &quiltrc_path) {
    if (quiltrc_path == "-") return {};

    if (!quiltrc_path.empty()) {
        std::string content = read_file(quiltrc_path);
        if (!content.empty()) return parse_quiltrc(content);
        return {};
    }

    // Default search order
    std::string home = get_home_dir();
    if (!home.empty()) {
        std::string user_rc = path_join(home, ".quiltrc");
        std::string content = read_file(user_rc);
        if (!content.empty()) return parse_quiltrc(content);
    }

    std::string sys_rc = "/etc/quilt.quiltrc";
    std::string content = read_file(sys_rc);
    if (!content.empty()) return parse_quiltrc(content);

    return {};
}

QuiltState load_state() {
    QuiltState q;
    q.patches_dir = "patches";
    q.pc_dir = ".pc";

    // Read environment variable overrides
    std::string env_pc = get_env("QUILT_PC");
    if (!env_pc.empty()) q.pc_dir = env_pc;
    std::string env_patches = get_env("QUILT_PATCHES");
    if (!env_patches.empty()) q.patches_dir = env_patches;

    // Read QUILT_SERIES override for series filename
    std::string env_series = get_env("QUILT_SERIES");

    // Upward directory scan: find project root containing .pc/ or patches/
    std::string cwd = get_cwd();
    std::string scan = cwd;
    while (true) {
        if (is_directory(path_join(scan, q.pc_dir)) ||
            is_directory(path_join(scan, q.patches_dir))) {
            break;
        }
        std::string parent = dirname(scan);
        if (parent == scan) {
            // Reached filesystem root without finding anything; use cwd
            scan = cwd;
            break;
        }
        scan = parent;
    }
    q.work_dir = scan;
    if (q.work_dir != cwd) {
        set_cwd(q.work_dir);
    }

    // Check if .pc/ exists and read overrides
    std::string pc_abs = path_join(q.work_dir, q.pc_dir);
    if (is_directory(pc_abs)) {
        // Read .quilt_patches override
        std::string qp = trim(read_file(path_join(pc_abs, ".quilt_patches")));
        if (!qp.empty()) {
            q.patches_dir = qp;
        }
        // Read .quilt_series override
        std::string qs = trim(read_file(path_join(pc_abs, ".quilt_series")));
        if (!qs.empty()) {
            q.series_file = path_join(q.patches_dir, qs);
        }
    }

    // Series file search order (when not overridden by .quilt_series)
    if (q.series_file.empty()) {
        std::string series_name = env_series.empty() ? "series" : env_series;
        std::string s1 = path_join(q.work_dir, series_name);
        std::string s2 = path_join(q.work_dir, q.patches_dir, series_name);
        std::string s3 = path_join(q.work_dir, q.pc_dir, series_name);
        if (file_exists(s1)) {
            q.series_file = series_name;
        } else if (file_exists(s2)) {
            q.series_file = path_join(q.patches_dir, series_name);
        } else if (file_exists(s3)) {
            q.series_file = path_join(q.pc_dir, series_name);
        } else {
            q.series_file = path_join(q.patches_dir, series_name);
        }
    }

    // Read series file
    std::string series_abs = path_join(q.work_dir, q.series_file);
    q.series_file_exists = file_exists(series_abs);
    q.series = read_series(series_abs, &q.patch_strip_level);

    // Read applied-patches file
    std::string applied_abs = path_join(q.work_dir, q.pc_dir, "applied-patches");
    q.applied = read_applied(applied_abs);

    return q;
}

std::string pc_patch_dir(const QuiltState &q, std::string_view patch) {
    return path_join(q.work_dir, q.pc_dir, patch);
}

std::vector<std::string> files_in_patch(const QuiltState &q, std::string_view patch) {
    std::string dir = pc_patch_dir(q, patch);
    if (!is_directory(dir)) return {};
    auto all = find_files_recursive(dir);
    std::vector<std::string> result;
    for (auto &f : all) {
        // Skip quilt metadata files (e.g. .timestamp, .needs_refresh)
        auto slash = f.rfind('/');
        std::string_view base = (slash != std::string::npos)
            ? std::string_view(f).substr(slash + 1)
            : std::string_view(f);
        if (!base.empty() && base[0] == '.') continue;
        result.push_back(std::move(f));
    }
    return result;
}

bool backup_file(QuiltState &q, std::string_view patch, std::string_view file) {
    std::string src = path_join(q.work_dir, file);
    std::string dst = path_join(pc_patch_dir(q, patch), file);

    // Ensure destination directory exists
    std::string dst_dir = dirname(dst);
    if (!is_directory(dst_dir)) {
        if (!make_dirs(dst_dir)) {
            err_line("Failed to create directory: " + dst_dir);
            return false;
        }
    }

    if (file_exists(src)) {
        return copy_file(src, dst);
    } else {
        // File doesn't exist yet; create an empty placeholder
        return write_file(dst, "");
    }
}

bool restore_file(QuiltState &q, std::string_view patch, std::string_view file) {
    std::string backup = path_join(pc_patch_dir(q, patch), file);
    std::string target = path_join(q.work_dir, file);

    if (!file_exists(backup)) {
        err_line("No backup for " + std::string(file));
        return false;
    }

    std::string content = read_file(backup);
    if (content.empty() && !file_exists(backup)) {
        // Backup was a placeholder for a file that didn't exist — remove the target
        if (file_exists(target) && !delete_file(target)) {
            err_line("Failed to remove " + target);
            return false;
        }
        return true;
    }

    if (content.empty()) {
        // The backed-up file was empty or didn't exist before the patch
        // Check if the backup is a zero-length placeholder
        // If the original file didn't exist, remove the target
        if (file_exists(target) && !delete_file(target)) {
            err_line("Failed to remove " + target);
            return false;
        }
        return true;
    }

    // Ensure target directory exists
    std::string target_dir = dirname(target);
    if (!is_directory(target_dir)) {
        if (!make_dirs(target_dir)) {
            err_line("Failed to create directory: " + target_dir);
            return false;
        }
    }

    return write_file(target, content);
}

std::string to_cstr(std::string_view s) {
    return std::string(s);
}

static Command commands[] = {
    {"new",        cmd_new,        "Usage: quilt new [-p n] patchname"},
    {"add",        cmd_add,        "Usage: quilt add [-P patch] file ..."},
    {"push",       cmd_push,       "Usage: quilt push [-a] [-f] [-q] [patch]"},
    {"pop",        cmd_pop,        "Usage: quilt pop [-a] [-f] [-q] [patch]"},
    {"refresh",    cmd_refresh,    "Usage: quilt refresh [-p n] [-f] [patch]"},
    {"diff",       cmd_diff,       "Usage: quilt diff [-p n] [-z] [patch]"},
    {"series",     cmd_series,     "Usage: quilt series [-v]"},
    {"applied",    cmd_applied,    "Usage: quilt applied [patch]"},
    {"unapplied",  cmd_unapplied,  "Usage: quilt unapplied [patch]"},
    {"top",        cmd_top,        "Usage: quilt top"},
    {"next",       cmd_next,       "Usage: quilt next [patch]"},
    {"previous",   cmd_previous,   "Usage: quilt previous [patch]"},
    {"delete",     cmd_delete,     "Usage: quilt delete [-r] [patch]"},
    {"rename",     cmd_rename,     "Usage: quilt rename [-P patch] new_name"},
    {"import",     cmd_import,     "Usage: quilt import [-p n] [-P patch] file"},
    {"header",     cmd_header,     "Usage: quilt header [-a|-r|-e] [patch]"},
    {"files",      cmd_files,      "Usage: quilt files [-v] [-a] [patch]"},
    {"patches",    cmd_patches,    "Usage: quilt patches [-v] file"},
    {"edit",       cmd_edit,       "Usage: quilt edit file ..."},
    {"revert",     cmd_revert,     "Usage: quilt revert [-P patch] file ..."},
    {"remove",     cmd_remove,     "Usage: quilt remove [-P patch] file ..."},
    {"fold",       cmd_fold,       "Usage: quilt fold [-R] [-q] [-f] [-p n]"},
    {"fork",       cmd_fork,       "Usage: quilt fork [new_name]"},
    // Stubs
    {"annotate",   cmd_annotate,   "Usage: quilt annotate [-P patch] file"},
    {"grep",       cmd_grep,       "Usage: quilt grep [-h|options] pattern"},
    {"graph",      cmd_graph,      "Usage: quilt graph [--lines file]"},
    {"mail",       cmd_mail,       "Usage: quilt mail {--mbox file} [--prefix prefix] [--sender ...] [--from ...] [--to ...] [--cc ...] [--bcc ...] [first_patch [last_patch]]"},
    {"setup",      cmd_setup,      "Usage: quilt setup [-d path] series"},
    {"shell",      cmd_shell,      "Usage: quilt shell [command]"},
    {"snapshot",   cmd_snapshot,   "Usage: quilt snapshot [-d]"},
    {"upgrade",    cmd_upgrade,    "Usage: quilt upgrade"},
    {"init",       cmd_init,       "Usage: quilt init [-p patches_dir]"},
};

static constexpr int num_commands = sizeof(commands) / sizeof(commands[0]);

static std::string to_upper(std::string_view s) {
    std::string result(s);
    for (char &c : result) {
        if (c >= 'a' && c <= 'z') c -= 32;
    }
    return result;
}

int quilt_main(int argc, char **argv) {
    // --- Phase 1: Extract global options (--quiltrc) from argv ---
    std::string quiltrc_path;   // empty = default search, "-" = disabled
    bool quiltrc_set = false;
    std::vector<char *> clean_argv;
    clean_argv.push_back(argv[0]);
    for (int i = 1; i < argc; ++i) {
        std::string_view a = argv[i];
        if (a == "--quiltrc" && i + 1 < argc) {
            quiltrc_path = argv[i + 1];
            quiltrc_set = true;
            ++i; // skip the argument
            continue;
        }
        if (starts_with(a, "--quiltrc=")) {
            quiltrc_path = std::string(a.substr(10));
            quiltrc_set = true;
            continue;
        }
        clean_argv.push_back(argv[i]);
    }
    int clean_argc = (int)clean_argv.size();

    // Handle no arguments
    if (clean_argc < 2) {
        err_line("Usage: quilt [--quiltrc file] <command> [options] [args]");
        err_line("Use \"quilt --help\" for a list of commands.");
        return 1;
    }

    std::string_view arg1 = clean_argv[1];

    // Handle --version
    if (arg1 == "--version" || arg1 == "-v") {
        out_line("quilt version 0.1.0");
        return 0;
    }

    // Handle --help
    if (arg1 == "--help" || arg1 == "-h" || arg1 == "help") {
        out_line("Usage: quilt [--quiltrc file] <command> [options] [args]");
        out_line("");
        out_line("Commands:");
        for (int i = 0; i < num_commands; ++i) {
            std::string line = "  ";
            line += commands[i].name;
            out_line(line);
        }
        return 0;
    }

    // --- Phase 2: Load quiltrc and populate environment ---
    auto rc_vars = load_quiltrc(quiltrc_set ? quiltrc_path : std::string());
    // Apply quiltrc values to environment. GNU quilt sources quiltrc into the
    // command process, so assignments there override inherited environment
    // values unless the rc itself chooses otherwise.
    for (auto &kv : rc_vars) {
        set_env(kv.first, kv.second);
    }

    // --- Phase 3: Find command ---
    std::string cmd_name(arg1);

    // Find command (supports unique prefix abbreviation)
    Command *found = nullptr;
    int match_count = 0;
    for (int i = 0; i < num_commands; ++i) {
        if (cmd_name == commands[i].name) {
            found = &commands[i];
            match_count = 1;
            break;
        }
        if (starts_with(std::string_view(commands[i].name), cmd_name)) {
            found = &commands[i];
            match_count++;
        }
    }

    if (match_count > 1) {
        err_line("quilt: command '" + cmd_name + "' is ambiguous");
        return 1;
    }

    if (!found) {
        err_line("quilt: unknown command '" + cmd_name + "'");
        err_line("Use \"quilt --help\" for a list of commands.");
        return 1;
    }

    // Handle per-command -h/--help before dispatching
    for (int i = 2; i < clean_argc; ++i) {
        std::string_view a = clean_argv[i];
        if (a == "-h" || a == "--help") {
            out_line(found->usage);
            return 0;
        }
    }

    // --- Phase 4: Load state ---
    QuiltState q = load_state();
    q.config = rc_vars;
    // Merge env overrides into config
    for (auto &kv : rc_vars) {
        std::string env_val = get_env(kv.first);
        if (!env_val.empty()) {
            q.config[kv.first] = env_val;
        }
    }

    // --- Phase 5: Inject QUILT_COMMAND_ARGS ---
    std::string args_key = "QUILT_" + to_upper(found->name) + "_ARGS";
    std::string cmd_args = get_env(args_key);
    auto extra_args = shell_split(cmd_args);

    // Build the final argv for the command: [cmd_name, extra_args..., user_args...]
    // Command argv starts at clean_argv+1
    std::vector<std::string> final_argv_storage;
    std::vector<char *> final_argv;

    final_argv_storage.push_back(std::string(found->name));
    for (auto &ea : extra_args) {
        final_argv_storage.push_back(ea);
    }
    for (int i = 2; i < clean_argc; ++i) {
        final_argv_storage.push_back(clean_argv[i]);
    }

    for (auto &s : final_argv_storage) {
        final_argv.push_back(const_cast<char *>(s.c_str()));
    }

    // Dispatch
    return found->fn(q, (int)final_argv.size(), final_argv.data());
}
