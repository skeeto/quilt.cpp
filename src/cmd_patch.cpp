// This is free and unencumbered software released into the public domain.
#include "quilt.hpp"
#include "platform.hpp"

#include <cstring>
#include <cstdlib>
#include <set>

// Forward declarations for helpers defined in core.cpp
extern bool ensure_pc_dir(QuiltState &q);
extern std::string pc_patch_dir(const QuiltState &q, std::string_view patch);
extern std::vector<std::string> files_in_patch(const QuiltState &q, std::string_view patch);
extern bool backup_file(QuiltState &q, std::string_view patch, std::string_view file);
extern bool restore_file(QuiltState &q, std::string_view patch, std::string_view file);
extern bool write_series(std::string_view path, const std::vector<std::string> &patches,
                         const std::map<std::string, int> &strip_levels);
extern bool write_applied(std::string_view path, const std::vector<std::string> &patches);

static std::string read_patch_header(std::string_view patch_path) {
    std::string content = read_file(patch_path);
    if (content.empty()) return "";

    std::string header;
    auto lines = split_lines(content);
    for (const auto &line : lines) {
        if (starts_with(line, "Index:") ||
            starts_with(line, "---") ||
            starts_with(line, "diff ")) {
            break;
        }
        header += line;
        header += '\n';
    }
    return header;
}

static std::string patch_path_display(const QuiltState &q, std::string_view patch) {
    return q.patches_dir + "/" + std::string(patch);
}

static std::string strip_patches_prefix(const QuiltState &q, std::string_view name) {
    std::string prefix = q.patches_dir + "/";
    if (starts_with(name, prefix)) {
        return std::string(name.substr(prefix.size()));
    }
    return std::string(name);
}

int cmd_init(QuiltState &q, int argc, char **) {
    if (argc != 1) {
        err_line("Usage: quilt init");
        return 1;
    }

    q.work_dir = get_cwd();
    q.pc_dir = ".pc";
    q.patches_dir = "patches";
    std::string env_pc = get_env("QUILT_PC");
    if (!env_pc.empty()) {
        q.pc_dir = env_pc;
    }
    std::string env_patches = get_env("QUILT_PATCHES");
    if (!env_patches.empty()) {
        q.patches_dir = env_patches;
    }
    std::string series_name = get_env("QUILT_SERIES");
    if (series_name.empty()) {
        series_name = "series";
    }
    q.series_file = path_join(q.patches_dir, series_name);

    if (!ensure_pc_dir(q)) {
        return 1;
    }

    std::string patches_abs = path_join(q.work_dir, q.patches_dir);
    if (!is_directory(patches_abs)) {
        if (!make_dirs(patches_abs)) {
            err_line("Failed to create " + patches_abs);
            return 1;
        }
    }

    std::string series_abs = path_join(q.work_dir, q.series_file);
    if (!file_exists(series_abs)) {
        if (!write_series(series_abs, {}, {})) {
            err_line("Failed to write series file.");
            return 1;
        }
    }

    std::string applied_abs = path_join(q.work_dir, q.pc_dir, "applied-patches");
    if (!file_exists(applied_abs)) {
        if (!write_applied(applied_abs, {})) {
            err_line("Failed to write applied-patches.");
            return 1;
        }
    }

    out_line("The quilt meta-data is now initialized.");
    return 0;
}

int cmd_new(QuiltState &q, int argc, char **argv) {
    // Parse options
    std::string patch_name;
    int i = 1;  // skip argv[0] which is "new"
    while (i < argc) {
        std::string_view arg = argv[i];
        if (arg == "-p" && i + 1 < argc) {
            // Store strip level for later; not used immediately
            i += 2;
            continue;
        }
        if (starts_with(arg, "-p")) {
            // -pN form
            i += 1;
            continue;
        }
        // First non-option argument is the patch name
        if (arg[0] != '-') {
            patch_name = std::string(arg);
            i += 1;
            break;
        }
        i += 1;
    }

    if (patch_name.empty()) {
        err_line("Usage: quilt new [-p n] patchname");
        return 1;
    }

    // Verify patch doesn't already exist in series
    if (q.find_in_series(patch_name).has_value()) {
        err_line("Patch " + patch_name + " already exists in series.");
        return 1;
    }

    // Ensure .pc/ directory exists
    if (!ensure_pc_dir(q)) return 1;

    // Ensure patches/ directory exists
    std::string patches_abs = path_join(q.work_dir, q.patches_dir);
    if (!is_directory(patches_abs)) {
        if (!make_dirs(patches_abs)) {
            err_line("Failed to create " + patches_abs);
            return 1;
        }
    }

    // Insert patch name into series (after current top, or at beginning)
    int top_idx = q.top_index();
    if (top_idx < 0) {
        // No applied patches — insert at beginning
        q.series.insert(q.series.begin(), patch_name);
    } else {
        // Insert after the current top
        q.series.insert(q.series.begin() + top_idx + 1, patch_name);
    }

    // Write series file
    std::string series_abs = path_join(q.work_dir, q.series_file);
    if (!write_series(series_abs, q.series, q.patch_strip_level)) {
        err_line("Failed to write series file.");
        return 1;
    }

    // Add to applied list and write applied-patches
    q.applied.push_back(patch_name);
    std::string applied_abs = path_join(q.work_dir, q.pc_dir, "applied-patches");
    if (!write_applied(applied_abs, q.applied)) {
        err_line("Failed to write applied-patches.");
        return 1;
    }

    // Create .pc/<patchname>/ directory
    std::string pc_dir = pc_patch_dir(q, patch_name);
    if (!is_directory(pc_dir)) {
        if (!make_dirs(pc_dir)) {
            err_line("Failed to create " + pc_dir);
            return 1;
        }
    }

    out_line("Patch " + patch_path_display(q, patch_name) + " is now on top");
    return 0;
}

int cmd_add(QuiltState &q, int argc, char **argv) {
    if (q.applied.empty()) {
        if (!q.series_file_exists) {
            err_line("No series file found");
            return 1;
        }
        err_line("No patches applied");
        return 1;
    }

    // Parse options
    std::string patch = q.applied.back();
    std::vector<std::string> files;
    int i = 1;
    while (i < argc) {
        std::string_view arg = argv[i];
        if (arg == "-P" && i + 1 < argc) {
            patch = strip_patches_prefix(q, argv[i + 1]);
            i += 2;
            continue;
        }
        if (arg[0] != '-') {
            files.emplace_back(arg);
        }
        i += 1;
    }

    if (files.empty()) {
        err_line("Usage: quilt add [-P patch] file ...");
        return 1;
    }

    for (const auto &file : files) {
        // Check if file is already tracked by this patch
        std::string backup_path = path_join(pc_patch_dir(q, patch), file);
        if (file_exists(backup_path)) {
            err_line("File " + file + " is already in patch " +
                     patch_path_display(q, patch));
            return 2;
        }

        // Backup the file
        if (!backup_file(q, patch, file)) {
            err_line("Failed to back up " + file);
            return 1;
        }

        out_line("File " + file + " added to patch " + patch_path_display(q, patch));
    }

    return 0;
}

int cmd_remove(QuiltState &q, int argc, char **argv) {
    if (q.applied.empty()) {
        err_line("No patches applied");
        return 1;
    }

    // Parse options
    std::string patch = q.applied.back();
    std::vector<std::string> files;
    int i = 1;
    while (i < argc) {
        std::string_view arg = argv[i];
        if (arg == "-P" && i + 1 < argc) {
            patch = strip_patches_prefix(q, argv[i + 1]);
            i += 2;
            continue;
        }
        if (arg[0] != '-') {
            files.emplace_back(arg);
        }
        i += 1;
    }

    if (files.empty()) {
        err_line("Usage: quilt remove [-P patch] file ...");
        return 1;
    }

    for (const auto &file : files) {
        // Check if file is tracked by this patch
        std::string backup_path = path_join(pc_patch_dir(q, patch), file);
        if (!file_exists(backup_path)) {
            err_line("File " + file + " is not in patch " +
                     patch_path_display(q, patch));
            return 1;
        }

        // Restore file from backup
        if (!restore_file(q, patch, file)) {
            err_line("Failed to restore " + file);
            return 1;
        }

        // Remove backup file
        delete_file(backup_path);

        out_line("File " + file + " removed from patch " +
                 patch_path_display(q, patch));
    }

    return 0;
}

int cmd_edit(QuiltState &q, int argc, char **argv) {
    if (q.applied.empty()) {
        err_line("No patches applied");
        return 1;
    }

    std::vector<std::string> files;
    for (int i = 1; i < argc; ++i) {
        files.emplace_back(argv[i]);
    }

    if (files.empty()) {
        err_line("Usage: quilt edit file ...");
        return 1;
    }

    std::string patch = q.applied.back();

    // Add each file to the top patch if not already tracked
    for (const auto &file : files) {
        std::string backup_path = path_join(pc_patch_dir(q, patch), file);
        if (!file_exists(backup_path)) {
            if (!backup_file(q, patch, file)) {
                err_line("Failed to back up " + file);
                return 1;
            }
            out_line("File " + file + " added to patch " + patch_path_display(q, patch));
        }
    }

    // Get editor from environment
    std::string editor = get_env("EDITOR");
    if (editor.empty()) {
        editor = "vi";
    }

    // Launch editor with all files as arguments
    std::vector<std::string> cmd_argv;
    cmd_argv.push_back(editor);
    for (const auto &file : files) {
        cmd_argv.push_back(path_join(q.work_dir, file));
    }

    return run_cmd_tty(cmd_argv);
}

static constexpr std::string_view SNAPSHOT_PATCH = ".snap";

static bool is_placeholder_copy(std::string_view path)
{
    return file_exists(path) && read_file(path).empty();
}

// p_format: "ab" for a/b labels, "0" for bare filenames, "1" (default) for dir.orig/dir
static std::string generate_path_diff(const QuiltState &q,
                                      std::string_view file,
                                      std::string_view old_path,
                                      bool old_placeholder,
                                      std::string_view new_path,
                                      bool new_placeholder,
                                      std::string_view p_format = "1",
                                      bool reverse = false) {
    bool old_missing = old_path.empty() || !file_exists(old_path) ||
        (old_placeholder && is_placeholder_copy(old_path));
    bool new_missing = new_path.empty() || !file_exists(new_path) ||
        (new_placeholder && is_placeholder_copy(new_path));

    std::string old_arg = old_missing ? "/dev/null" : std::string(old_path);
    std::string new_arg = new_missing ? "/dev/null" : std::string(new_path);

    std::string old_label;
    std::string new_label;
    if (p_format == "ab") {
        old_label = "a/" + std::string(file);
        new_label = "b/" + std::string(file);
    } else if (p_format == "0") {
        old_label = std::string(file);
        new_label = std::string(file);
    } else {
        std::string work_base = basename(q.work_dir);
        old_label = work_base + ".orig/" + std::string(file);
        new_label = work_base + "/" + std::string(file);
    }

    if (old_missing) {
        old_label = "/dev/null";
    }
    if (new_missing) {
        new_label = "/dev/null";
    }

    if (reverse) {
        std::swap(old_arg, new_arg);
        std::swap(old_label, new_label);
    }

    std::vector<std::string> cmd_argv = {"diff", "-u"};
    auto extra_diff_opts = shell_split(get_env("QUILT_DIFF_OPTS"));
    for (const auto &opt : extra_diff_opts) {
        cmd_argv.push_back(opt);
    }

    cmd_argv.push_back("--label");
    cmd_argv.push_back(old_label);
    cmd_argv.push_back("--label");
    cmd_argv.push_back(new_label);
    cmd_argv.push_back(old_arg);
    cmd_argv.push_back(new_arg);

    ProcessResult result = run_cmd(cmd_argv);
    if (result.exit_code == 2) {
        err_line("diff failed for " + std::string(file));
        return "";
    }

    return result.out;
}

static std::string generate_file_diff(const QuiltState &q, std::string_view patch,
                                      std::string_view file,
                                      std::string_view p_format = "1",
                                      bool reverse = false) {
    std::string backup_path = path_join(pc_patch_dir(q, patch), file);
    std::string working_path = path_join(q.work_dir, file);
    return generate_path_diff(q, file, backup_path, true, working_path, false,
                              p_format, reverse);
}

static std::map<std::string, std::string> split_patch_by_file(std::string_view content) {
    std::map<std::string, std::string> sections;
    auto lines = split_lines(content);
    std::string current_file;
    std::string current_section;

    auto flush = [&]() {
        if (!current_file.empty() && !current_section.empty()) {
            sections[current_file] = current_section;
        }
        current_file.clear();
        current_section.clear();
    };

    for (const auto &line : lines) {
        if (starts_with(line, "Index:") || starts_with(line, "diff ")) {
            flush();
            current_section += line + "\n";
        } else if (starts_with(line, "+++ ")) {
            // Extract filename from +++ line
            std::string_view rest = std::string_view(line).substr(4);
            if (starts_with(rest, "/dev/null")) {
                // skip
            } else {
                // Strip b/ prefix and trailing tab/timestamp
                if (starts_with(rest, "b/")) rest = rest.substr(2);
                auto tab = rest.find('\t');
                if (tab != std::string_view::npos) rest = rest.substr(0, tab);
                // Strip leading directory component (e.g., "dir.orig/")
                auto slash = rest.find('/');
                if (slash != std::string_view::npos) {
                    current_file = trim(rest.substr(slash + 1));
                } else {
                    current_file = trim(rest);
                }
            }
            current_section += line + "\n";
        } else if (starts_with(line, "===")) {
            current_section += line + "\n";
        } else if (starts_with(line, "--- ")) {
            current_section += line + "\n";
        } else {
            current_section += line + "\n";
        }
    }
    flush();
    return sections;
}

static void append_unique_files(std::vector<std::string> &dst,
                                std::set<std::string> &seen,
                                const std::vector<std::string> &src) {
    for (const auto &file : src) {
        if (seen.insert(file).second) {
            dst.push_back(file);
        }
    }
}

static std::vector<std::string> collect_files_for_patches(
    const QuiltState &q, const std::vector<std::string> &patches) {
    std::vector<std::string> files;
    std::set<std::string> seen;
    for (const auto &patch : patches) {
        append_unique_files(files, seen, files_in_patch(q, patch));
    }
    return files;
}

static std::vector<std::string> patch_range_for_diff(const QuiltState &q,
                                                     std::string_view last_patch) {
    if (last_patch.empty()) {
        return q.applied;
    }

    std::vector<std::string> patches;
    for (const auto &patch : q.applied) {
        patches.push_back(patch);
        if (patch == last_patch) {
            return patches;
        }
    }

    return {std::string(last_patch)};
}

static std::string first_patch_for_file(const QuiltState &q,
                                        const std::vector<std::string> &patches,
                                        std::string_view file) {
    for (const auto &patch : patches) {
        auto tracked = files_in_patch(q, patch);
        if (std::find(tracked.begin(), tracked.end(), file) != tracked.end()) {
            return patch;
        }
    }
    return "";
}

static std::string next_patch_for_file(const QuiltState &q,
                                       std::string_view patch,
                                       std::string_view file) {
    bool after_target = false;
    for (const auto &applied : q.applied) {
        if (after_target) {
            auto tracked = files_in_patch(q, applied);
            if (std::find(tracked.begin(), tracked.end(), file) != tracked.end()) {
                return applied;
            }
        }
        if (applied == patch) {
            after_target = true;
        }
    }
    return "";
}

static void apply_file_filter(std::vector<std::string> &tracked,
                              const std::vector<std::string> &file_filter) {
    if (file_filter.empty()) {
        return;
    }

    std::vector<std::string> filtered;
    for (const auto &tracked_file : tracked) {
        for (const auto &wanted_file : file_filter) {
            if (tracked_file == wanted_file) {
                filtered.push_back(tracked_file);
                break;
            }
        }
    }
    tracked = std::move(filtered);
}

int cmd_snapshot(QuiltState &q, int argc, char **argv) {
    bool remove_snapshot = false;

    for (int i = 1; i < argc; ++i) {
        std::string_view arg = argv[i];
        if (arg == "-d") {
            remove_snapshot = true;
            continue;
        }
        err_line("Usage: quilt snapshot [-d]");
        return 1;
    }

    std::string snap_dir = pc_patch_dir(q, SNAPSHOT_PATCH);
    if (is_directory(snap_dir) && !delete_dir_recursive(snap_dir)) {
        err_line("Failed to remove " + snap_dir);
        return 1;
    }

    if (remove_snapshot) {
        return 0;
    }

    if (!ensure_pc_dir(q)) {
        return 1;
    }
    if (!make_dirs(snap_dir)) {
        err_line("Failed to create " + snap_dir);
        return 1;
    }

    auto tracked = collect_files_for_patches(q, q.applied);
    for (const auto &file : tracked) {
        if (!backup_file(q, SNAPSHOT_PATCH, file)) {
            err_line("Failed to snapshot " + file);
            return 1;
        }
    }

    return 0;
}

int cmd_refresh(QuiltState &q, int argc, char **argv) {
    if (q.applied.empty()) {
        err_line("No patches applied");
        return 1;
    }

    // Parse options
    std::string patch;
    std::string p_format = "1";  // default: dir.orig/dir labels
    int i = 1;
    bool no_timestamps = !get_env("QUILT_NO_DIFF_TIMESTAMPS").empty();
    bool no_index = !get_env("QUILT_NO_DIFF_INDEX").empty();
    bool sort_files = false;
    bool force = false;
    (void)no_timestamps;

    while (i < argc) {
        std::string_view arg = argv[i];
        if (arg == "-p" && i + 1 < argc) {
            p_format = std::string(argv[i + 1]);
            i += 2;
            continue;
        }
        if (starts_with(arg, "-p") && arg.size() > 2) {
            p_format = std::string(arg.substr(2));
            i += 1;
            continue;
        }
        if (arg == "-f") {
            force = true;
            i += 1;
            continue;
        }
        if (arg == "--no-timestamps" || arg == "--no-timestamp") {
            no_timestamps = true;
            i += 1;
            continue;
        }
        if (arg == "--no-index") {
            no_index = true;
            i += 1;
            continue;
        }
        if (arg == "--sort") {
            sort_files = true;
            i += 1;
            continue;
        }
        // Non-option: patch name
        if (arg[0] != '-' && patch.empty()) {
            patch = std::string(arg);
        }
        i += 1;
    }

    if (patch.empty()) {
        patch = q.applied.back();
    }

    // Compute shadowed files (files modified by patches above this one)
    std::set<std::string> shadowed;
    if (patch != q.applied.back()) {
        bool above = false;
        for (const auto &a : q.applied) {
            if (above) {
                auto above_files = files_in_patch(q, a);
                for (const auto &f : above_files) {
                    shadowed.insert(f);
                }
            }
            if (a == patch) above = true;
        }
    }

    if (!shadowed.empty() && !force) {
        err_line("More recent patches modify files in patch " +
                 patch_path_display(q, patch) + ". Enforce refresh with -f.");
        return 1;
    }

    // Get files tracked by this patch
    auto tracked = files_in_patch(q, patch);
    if (sort_files) {
        std::sort(tracked.begin(), tracked.end());
    }

    // Read existing patch file for header and shadowed file preservation
    std::string patch_file = path_join(q.work_dir, q.patches_dir, patch);
    std::string old_content;
    std::string header;
    std::map<std::string, std::string> old_sections;
    if (file_exists(patch_file)) {
        old_content = read_file(patch_file);
        header = read_patch_header(patch_file);
        if (!shadowed.empty()) {
            old_sections = split_patch_by_file(old_content);
        }
    }

    // Generate diffs
    std::string work_base = basename(q.work_dir);
    std::string patch_content = header;

    for (const auto &file : tracked) {
        if (shadowed.count(file)) {
            // Preserve existing hunks for shadowed files
            auto it = old_sections.find(file);
            if (it != old_sections.end()) {
                patch_content += it->second;
            }
            continue;
        }
        std::string diff_out = generate_file_diff(q, patch, file, p_format);
        if (!diff_out.empty()) {
            if (!no_index) {
                patch_content += "Index: " + work_base + "/" + file + "\n";
                patch_content += "===================================================================\n";
            }
            patch_content += diff_out;
            // Ensure trailing newline
            if (!patch_content.empty() && patch_content.back() != '\n') {
                patch_content += '\n';
            }
        }
    }

    // Ensure patches directory exists
    std::string patches_abs = path_join(q.work_dir, q.patches_dir);
    if (!is_directory(patches_abs)) {
        make_dirs(patches_abs);
    }

    // Write the patch file
    if (!write_file(patch_file, patch_content)) {
        err_line("Failed to write patch file " + patch_file);
        return 1;
    }

    // Update .timestamp
    write_file(path_join(pc_patch_dir(q, patch), ".timestamp"), "");

    // Clear .needs_refresh marker if present
    std::string nr = path_join(pc_patch_dir(q, patch), ".needs_refresh");
    if (file_exists(nr)) {
        delete_file(nr);
    }

    out_line("Refreshed patch " + patch_path_display(q, patch));
    return 0;
}

int cmd_diff(QuiltState &q, int argc, char **argv) {
    if (q.applied.empty()) {
        err_line("No patches applied");
        return 1;
    }

    // Parse options
    std::string patch;
    std::string p_format = "1";
    std::vector<std::string> file_filter;
    bool no_timestamps = !get_env("QUILT_NO_DIFF_TIMESTAMPS").empty();
    bool no_index = !get_env("QUILT_NO_DIFF_INDEX").empty();
    bool since_refresh = false;
    bool against_snapshot = false;
    bool reverse = false;
    (void)no_timestamps;
    int i = 1;

    while (i < argc) {
        std::string_view arg = argv[i];
        if (arg == "-P" && i + 1 < argc) {
            patch = strip_patches_prefix(q, argv[i + 1]);
            i += 2;
            continue;
        }
        if (arg == "-p" && i + 1 < argc) {
            p_format = std::string(argv[i + 1]);
            i += 2;
            continue;
        }
        if (starts_with(arg, "-p") && arg.size() > 2) {
            p_format = std::string(arg.substr(2));
            i += 1;
            continue;
        }
        if (arg == "-u") {
            i += 1;
            continue;
        }
        if (arg == "-z") {
            since_refresh = true;
            i += 1;
            continue;
        }
        if (arg == "--snapshot") {
            against_snapshot = true;
            i += 1;
            continue;
        }
        if (arg == "-R") {
            reverse = true;
            i += 1;
            continue;
        }
        if (starts_with(arg, "-U")) {
            if (arg == "-U" && i + 1 < argc) {
                i += 2;
            } else {
                i += 1;
            }
            continue;
        }
        if (arg == "--no-timestamps" || arg == "--no-timestamp") {
            no_timestamps = true;
            i += 1;
            continue;
        }
        if (arg == "--no-index") {
            no_index = true;
            i += 1;
            continue;
        }
        // Non-option: file name or patch name
        if (arg[0] != '-') {
            file_filter.emplace_back(arg);
        }
        i += 1;
    }

    if (patch.empty()) {
        patch = q.applied.back();
    }

    if (since_refresh && against_snapshot) {
        err_line("Options `--snapshot' and `-z' cannot be combined.");
        return 1;
    }

    auto patches = patch_range_for_diff(q, patch);
    std::vector<std::string> tracked;
    if (against_snapshot) {
        std::string snap_dir = pc_patch_dir(q, SNAPSHOT_PATCH);
        if (!is_directory(snap_dir)) {
            err_line("No snapshot to diff against");
            return 1;
        }

        std::set<std::string> seen;
        append_unique_files(tracked, seen, files_in_patch(q, SNAPSHOT_PATCH));
        append_unique_files(tracked, seen, collect_files_for_patches(q, patches));
    } else {
        tracked = files_in_patch(q, patch);
    }

    apply_file_filter(tracked, file_filter);

    std::string work_base = basename(q.work_dir);

    if (since_refresh) {
        // diff -z: show changes since last refresh.
        // For each tracked file, reconstruct the "refreshed state" by applying
        // the stored patch to the backup, then diff that against the working file.
        std::string patch_file = path_join(q.work_dir, q.patches_dir, patch);
        std::string stored_content;
        std::map<std::string, std::string> stored_sections;
        if (file_exists(patch_file)) {
            stored_content = read_file(patch_file);
            stored_sections = split_patch_by_file(stored_content);
        }

        // Create temp directory for reconstructing refreshed state
        std::string tmp_dir = make_temp_dir();
        if (tmp_dir.empty()) {
            err_line("Failed to create temp directory");
            return 1;
        }

        for (const auto &file : tracked) {
            std::string backup_path = path_join(pc_patch_dir(q, patch), file);
            std::string working_path = path_join(q.work_dir, file);
            std::string tmp_file = path_join(tmp_dir, file);

            // Ensure temp subdirectory exists
            std::string tmp_file_dir = dirname(tmp_file);
            if (!is_directory(tmp_file_dir)) {
                make_dirs(tmp_file_dir);
            }

            // Copy backup to temp (empty backup = file didn't exist)
            if (file_exists(backup_path)) {
                std::string backup_content = read_file(backup_path);
                write_file(tmp_file, backup_content);
            } else {
                write_file(tmp_file, "");
            }

            // Apply stored patch section to temp file
            auto it = stored_sections.find(file);
            if (it != stored_sections.end() && !it->second.empty()) {
                // Build a minimal patch with correct paths for -p0
                std::string mini_patch = "--- " + file + "\n+++ " + file + "\n";
                // Extract just the hunk lines from the stored section
                auto section_lines = split_lines(it->second);
                bool in_hunk = false;
                for (const auto &sl : section_lines) {
                    if (starts_with(sl, "@@")) {
                        in_hunk = true;
                        mini_patch += sl + "\n";
                    } else if (in_hunk) {
                        mini_patch += sl + "\n";
                    }
                }
                if (in_hunk) {
                    ProcessResult patch_result{};
                    std::string saved_cwd = get_cwd();
                    if (set_cwd(tmp_dir)) {
                        std::vector<std::string> patch_cmd = {"patch", "-p0", "-E"};
                        patch_result = run_cmd_input(patch_cmd, mini_patch);
                        set_cwd(saved_cwd);
                    } else {
                        patch_result.exit_code = -1;
                        patch_result.err = "failed to enter temp directory";
                    }
                    (void)patch_result;
                }
            }

            // Now diff the reconstructed "refreshed" file against working file
            if (!file_exists(working_path) && !file_exists(tmp_file)) continue;

            std::string old_label, new_label;
            if (p_format == "ab") {
                old_label = "a/" + file;
                new_label = "b/" + file;
            } else if (p_format == "0") {
                old_label = file;
                new_label = file;
            } else {
                old_label = work_base + ".orig/" + file;
                new_label = work_base + "/" + file;
            }

            std::string old_f = tmp_file;
            std::string new_f = working_path;
            if (!file_exists(working_path)) new_f = "/dev/null";

            if (reverse) {
                std::swap(old_f, new_f);
                std::swap(old_label, new_label);
            }

            std::vector<std::string> diff_cmd = {"diff", "-u"};
            auto extra_diff_opts = shell_split(get_env("QUILT_DIFF_OPTS"));
            for (const auto &opt : extra_diff_opts) diff_cmd.push_back(opt);
            diff_cmd.push_back("--label");
            diff_cmd.push_back(old_label);
            diff_cmd.push_back("--label");
            diff_cmd.push_back(new_label);
            diff_cmd.push_back(old_f);
            diff_cmd.push_back(new_f);

            ProcessResult result = run_cmd(diff_cmd);
            if (result.exit_code == 1 && !result.out.empty()) {
                if (!no_index) {
                    out("Index: " + work_base + "/" + file + "\n");
                    out("===================================================================\n");
                }
                out(result.out);
            }
        }

        delete_dir_recursive(tmp_dir);
    } else if (against_snapshot) {
        for (const auto &file : tracked) {
            std::string old_path = path_join(pc_patch_dir(q, SNAPSHOT_PATCH), file);
            bool old_placeholder = true;
            if (!file_exists(old_path)) {
                std::string first_patch = first_patch_for_file(q, patches, file);
                if (first_patch.empty()) {
                    continue;
                }
                old_path = path_join(pc_patch_dir(q, first_patch), file);
            }

            std::string new_path = path_join(q.work_dir, file);
            bool new_placeholder = false;
            std::string shadowing_patch = next_patch_for_file(q, patch, file);
            if (!shadowing_patch.empty()) {
                new_path = path_join(pc_patch_dir(q, shadowing_patch), file);
                new_placeholder = true;
            }

            std::string diff_out = generate_path_diff(
                q, file, old_path, old_placeholder, new_path, new_placeholder,
                p_format, reverse);
            if (!diff_out.empty()) {
                if (!no_index) {
                    out("Index: " + work_base + "/" + file + "\n");
                    out("===================================================================\n");
                }
                out(diff_out);
            }
        }
    } else {
        for (const auto &file : tracked) {
            std::string diff_out = generate_file_diff(q, patch, file, p_format, reverse);
            if (!diff_out.empty()) {
                if (!no_index) {
                    out("Index: " + work_base + "/" + file + "\n");
                    out("===================================================================\n");
                }
                out(diff_out);
            }
        }
    }

    return 0;
}

int cmd_revert(QuiltState &q, int argc, char **argv) {
    if (q.applied.empty()) {
        err_line("No patches applied");
        return 1;
    }

    // Parse options
    std::string patch = q.applied.back();
    std::vector<std::string> files;
    int i = 1;
    while (i < argc) {
        std::string_view arg = argv[i];
        if (arg == "-P" && i + 1 < argc) {
            patch = strip_patches_prefix(q, argv[i + 1]);
            i += 2;
            continue;
        }
        if (arg[0] != '-') {
            files.emplace_back(arg);
        }
        i += 1;
    }

    if (files.empty()) {
        err_line("Usage: quilt revert [-P patch] file ...");
        return 1;
    }

    for (const auto &file : files) {
        // Check if file is tracked by the patch
        std::string backup_path = path_join(pc_patch_dir(q, patch), file);
        if (!file_exists(backup_path)) {
            err_line("File " + file + " is not in patch " +
                     patch_path_display(q, patch));
            return 1;
        }

        // Restore from backup but keep the backup
        std::string target = path_join(q.work_dir, file);
        std::string content = read_file(backup_path);
        if (content.empty()) {
            // Backup was empty placeholder — file didn't exist before, delete it
            delete_file(target);
        } else {
            // Ensure target directory exists
            std::string target_dir = dirname(target);
            if (!is_directory(target_dir)) {
                make_dirs(target_dir);
            }
            if (!write_file(target, content)) {
                err_line("Failed to restore " + file);
                return 1;
            }
        }

        out_line("Changes to " + file + " in patch " +
                 patch_path_display(q, patch) + " reverted");
    }

    return 0;
}
