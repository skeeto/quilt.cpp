// This is free and unencumbered software released into the public domain.
#include "quilt.hpp"
#include "platform.hpp"

// ---------------------------------------------------------------------------
// QuiltState method implementations
// ---------------------------------------------------------------------------

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

// ---------------------------------------------------------------------------
// I/O helpers
// ---------------------------------------------------------------------------

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

// ---------------------------------------------------------------------------
// Path utilities
// ---------------------------------------------------------------------------

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

// ---------------------------------------------------------------------------
// String utilities
// ---------------------------------------------------------------------------

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

// ---------------------------------------------------------------------------
// Series file I/O
// ---------------------------------------------------------------------------

std::vector<std::string> read_series(std::string_view path) {
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
        // Strip options after the patch name (e.g., "-p1")
        // The patch name is the first whitespace-delimited token
        auto sp = trimmed.find(' ');
        if (sp != std::string::npos) {
            trimmed = std::string(trimmed.substr(0, sp));
        }
        auto tab = trimmed.find('\t');
        if (tab != std::string::npos) {
            trimmed = std::string(trimmed.substr(0, tab));
        }
        if (!trimmed.empty()) {
            patches.push_back(std::move(trimmed));
        }
    }
    return patches;
}

bool write_series(std::string_view path, const std::vector<std::string> &patches) {
    std::string content;
    for (const auto &p : patches) {
        content += p;
        content += '\n';
    }
    return write_file(path, content);
}

// ---------------------------------------------------------------------------
// Applied patches DB (.pc/applied-patches)
// ---------------------------------------------------------------------------

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

// ---------------------------------------------------------------------------
// DB initialization
// ---------------------------------------------------------------------------

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
        write_file(version_path, "2\n");
    }
    // Write .quilt_patches
    std::string qp_path = path_join(pc, ".quilt_patches");
    if (!file_exists(qp_path)) {
        write_file(qp_path, q.patches_dir + "\n");
    }
    // Write .quilt_series
    std::string qs_path = path_join(pc, ".quilt_series");
    if (!file_exists(qs_path)) {
        write_file(qs_path, "series\n");
    }
    return true;
}

// ---------------------------------------------------------------------------
// State loading
// ---------------------------------------------------------------------------

QuiltState load_state() {
    QuiltState q;
    q.work_dir = get_cwd();
    q.patches_dir = "patches";
    q.pc_dir = ".pc";
    q.series_file = path_join(q.patches_dir, "series");

    // Check if .pc/ exists and read overrides
    std::string pc_abs = path_join(q.work_dir, q.pc_dir);
    if (is_directory(pc_abs)) {
        // Read .quilt_patches override
        std::string qp = trim(read_file(path_join(pc_abs, ".quilt_patches")));
        if (!qp.empty()) {
            q.patches_dir = qp;
            q.series_file = path_join(q.patches_dir, "series");
        }
        // Read .quilt_series override
        std::string qs = trim(read_file(path_join(pc_abs, ".quilt_series")));
        if (!qs.empty()) {
            q.series_file = path_join(q.patches_dir, qs);
        }
    }

    // Read series file
    std::string series_abs = path_join(q.work_dir, q.series_file);
    q.series = read_series(series_abs);

    // Read applied-patches file
    std::string applied_abs = path_join(q.work_dir, q.pc_dir, "applied-patches");
    q.applied = read_applied(applied_abs);

    return q;
}

// ---------------------------------------------------------------------------
// Patch file helpers
// ---------------------------------------------------------------------------

std::string pc_patch_dir(const QuiltState &q, std::string_view patch) {
    return path_join(q.work_dir, q.pc_dir, patch);
}

std::vector<std::string> files_in_patch(const QuiltState &q, std::string_view patch) {
    std::string dir = pc_patch_dir(q, patch);
    if (!is_directory(dir)) return {};
    return find_files_recursive(dir);
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
        delete_file(target);
        return true;
    }

    if (content.empty()) {
        // The backed-up file was empty or didn't exist before the patch
        // Check if the backup is a zero-length placeholder
        // If the original file didn't exist, remove the target
        delete_file(target);
        return true;
    }

    // Ensure target directory exists
    std::string target_dir = dirname(target);
    if (!is_directory(target_dir)) {
        make_dirs(target_dir);
    }

    return write_file(target, content);
}

std::string to_cstr(std::string_view s) {
    return std::string(s);
}

// ---------------------------------------------------------------------------
// quilt_main — entry point
// ---------------------------------------------------------------------------

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
    {"guard",      cmd_guard,      "Usage: quilt guard [-l] [patch] [-- guards]"},
    {"mail",       cmd_mail,       "Usage: quilt mail ..."},
    {"setup",      cmd_setup,      "Usage: quilt setup [-d path] series"},
    {"shell",      cmd_shell,      "Usage: quilt shell [command]"},
    {"snapshot",   cmd_snapshot,   "Usage: quilt snapshot [-d]"},
    {"upgrade",    cmd_upgrade,    "Usage: quilt upgrade"},
    {"init",       cmd_init,       "Usage: quilt init [-p patches_dir]"},
};

static constexpr int num_commands = sizeof(commands) / sizeof(commands[0]);

int quilt_main(int argc, char **argv) {
    // Handle no arguments
    if (argc < 2) {
        err_line("Usage: quilt <command> [options] [args]");
        err_line("Use \"quilt --help\" for a list of commands.");
        return 1;
    }

    std::string_view arg1 = argv[1];

    // Handle --version
    if (arg1 == "--version" || arg1 == "-v") {
        out_line("quilt version 0.1.0");
        return 0;
    }

    // Handle --help
    if (arg1 == "--help" || arg1 == "-h" || arg1 == "help") {
        out_line("Usage: quilt <command> [options] [args]");
        out_line("");
        out_line("Commands:");
        for (int i = 0; i < num_commands; ++i) {
            std::string line = "  ";
            line += commands[i].name;
            out_line(line);
        }
        return 0;
    }

    // Strip patches/ prefix from command if user accidentally typed it
    std::string cmd_name(arg1);

    // Find command
    Command *found = nullptr;
    for (int i = 0; i < num_commands; ++i) {
        if (cmd_name == commands[i].name) {
            found = &commands[i];
            break;
        }
    }

    if (!found) {
        err_line("quilt: unknown command '" + cmd_name + "'");
        err_line("Use \"quilt --help\" for a list of commands.");
        return 1;
    }

    // Load state
    QuiltState q = load_state();

    // Dispatch — argv for the command starts at argv+1
    // so argv[0] becomes the command name
    return found->fn(q, argc - 1, argv + 1);
}
