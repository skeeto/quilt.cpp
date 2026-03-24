// This is free and unencumbered software released into the public domain.
#include "quilt.hpp"
#include "platform.hpp"

#include <cstring>
#include <cstdlib>

// Forward declarations for helpers defined in core.cpp
extern bool ensure_pc_dir(QuiltState &q);
extern Str pc_patch_dir(const QuiltState &q, StrView patch);
extern std::vector<Str> files_in_patch(const QuiltState &q, StrView patch);
extern bool backup_file(QuiltState &q, StrView patch, StrView file);
extern bool restore_file(QuiltState &q, StrView patch, StrView file);
extern bool write_series(StrView path, const std::vector<Str> &patches);
extern bool write_applied(StrView path, const std::vector<Str> &patches);

// ---------------------------------------------------------------------------
// Helper: read the existing patch header (text before first diff content)
// ---------------------------------------------------------------------------

static Str read_patch_header(StrView patch_path) {
    Str content = read_file(patch_path);
    if (content.empty()) return "";

    Str header;
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

// ---------------------------------------------------------------------------
// cmd_new — create a new patch
// ---------------------------------------------------------------------------

int cmd_new(QuiltState &q, int argc, char **argv) {
    // Parse options
    Str patch_name;
    int i = 1;  // skip argv[0] which is "new"
    while (i < argc) {
        StrView arg = argv[i];
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
        patch_name = Str(arg);
        i += 1;
        break;
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
    Str patches_abs = path_join(q.work_dir, q.patches_dir);
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
    Str series_abs = path_join(q.work_dir, q.series_file);
    if (!write_series(series_abs, q.series)) {
        err_line("Failed to write series file.");
        return 1;
    }

    // Add to applied list and write applied-patches
    q.applied.push_back(patch_name);
    Str applied_abs = path_join(q.work_dir, q.pc_dir, "applied-patches");
    if (!write_applied(applied_abs, q.applied)) {
        err_line("Failed to write applied-patches.");
        return 1;
    }

    // Create .pc/<patchname>/ directory
    Str pc_dir = pc_patch_dir(q, patch_name);
    if (!is_directory(pc_dir)) {
        if (!make_dirs(pc_dir)) {
            err_line("Failed to create " + pc_dir);
            return 1;
        }
    }

    out_line("Patch " + path_join(q.patches_dir, patch_name) + " is now on top");
    return 0;
}

// ---------------------------------------------------------------------------
// cmd_add — add files to the topmost patch
// ---------------------------------------------------------------------------

int cmd_add(QuiltState &q, int argc, char **argv) {
    if (q.applied.empty()) {
        err_line("No patches applied");
        return 1;
    }

    // Parse options
    Str patch = q.applied.back();
    std::vector<Str> files;
    int i = 1;
    while (i < argc) {
        StrView arg = argv[i];
        if (arg == "-P" && i + 1 < argc) {
            patch = Str(argv[i + 1]);
            i += 2;
            continue;
        }
        files.emplace_back(arg);
        i += 1;
    }

    if (files.empty()) {
        err_line("Usage: quilt add [-P patch] file ...");
        return 1;
    }

    Str patch_display = path_join(q.patches_dir, patch);

    for (const auto &file : files) {
        // Check if file is already tracked by this patch
        Str backup_path = path_join(pc_patch_dir(q, patch), file);
        if (file_exists(backup_path)) {
            err_line("File " + file + " is already in patch " + patch_display);
            return 2;
        }

        // Backup the file
        if (!backup_file(q, patch, file)) {
            err_line("Failed to back up " + file);
            return 1;
        }

        out_line("File " + file + " added to patch " + patch_display);
    }

    return 0;
}

// ---------------------------------------------------------------------------
// cmd_remove — remove files from a patch
// ---------------------------------------------------------------------------

int cmd_remove(QuiltState &q, int argc, char **argv) {
    if (q.applied.empty()) {
        err_line("No patches applied");
        return 1;
    }

    // Parse options
    Str patch = q.applied.back();
    std::vector<Str> files;
    int i = 1;
    while (i < argc) {
        StrView arg = argv[i];
        if (arg == "-P" && i + 1 < argc) {
            patch = Str(argv[i + 1]);
            i += 2;
            continue;
        }
        files.emplace_back(arg);
        i += 1;
    }

    if (files.empty()) {
        err_line("Usage: quilt remove [-P patch] file ...");
        return 1;
    }

    Str patch_display = path_join(q.patches_dir, patch);

    for (const auto &file : files) {
        // Check if file is tracked by this patch
        Str backup_path = path_join(pc_patch_dir(q, patch), file);
        if (!file_exists(backup_path)) {
            err_line("File " + file + " is not in patch " + patch_display);
            return 1;
        }

        // Restore file from backup
        if (!restore_file(q, patch, file)) {
            err_line("Failed to restore " + file);
            return 1;
        }

        // Remove backup file
        delete_file(backup_path);

        out_line("File " + file + " removed from patch " + patch_display);
    }

    return 0;
}

// ---------------------------------------------------------------------------
// cmd_edit — add files to top patch and open editor
// ---------------------------------------------------------------------------

int cmd_edit(QuiltState &q, int argc, char **argv) {
    if (q.applied.empty()) {
        err_line("No patches applied");
        return 1;
    }

    std::vector<Str> files;
    for (int i = 1; i < argc; ++i) {
        files.emplace_back(argv[i]);
    }

    if (files.empty()) {
        err_line("Usage: quilt edit file ...");
        return 1;
    }

    Str patch = q.applied.back();
    Str patch_display = path_join(q.patches_dir, patch);

    // Add each file to the top patch if not already tracked
    for (const auto &file : files) {
        Str backup_path = path_join(pc_patch_dir(q, patch), file);
        if (!file_exists(backup_path)) {
            if (!backup_file(q, patch, file)) {
                err_line("Failed to back up " + file);
                return 1;
            }
            out_line("File " + file + " added to patch " + patch_display);
        }
    }

    // Get editor from environment
    Str editor = get_env("EDITOR");
    if (editor.empty()) {
        editor = "vi";
    }

    // Launch editor with all files as arguments
    std::vector<Str> cmd_argv;
    cmd_argv.push_back(editor);
    for (const auto &file : files) {
        cmd_argv.push_back(path_join(q.work_dir, file));
    }

    ProcessResult result = run_cmd(cmd_argv);
    return result.exit_code;
}

// ---------------------------------------------------------------------------
// Helper: generate diff for a single file
// ---------------------------------------------------------------------------

static Str generate_file_diff(const QuiltState &q, StrView patch, StrView file) {
    Str backup_path = path_join(pc_patch_dir(q, patch), file);
    Str working_path = path_join(q.work_dir, file);

    Str old_path;
    Str new_path;
    bool backup_empty = false;

    // Check if backup is an empty placeholder (file was new)
    if (file_exists(backup_path)) {
        Str content = read_file(backup_path);
        if (content.empty()) {
            backup_empty = true;
        }
    }

    if (backup_empty) {
        old_path = "/dev/null";
    } else {
        old_path = backup_path;
    }

    if (!file_exists(working_path)) {
        new_path = "/dev/null";
    } else {
        new_path = working_path;
    }

    // Build label arguments for nice headers
    Str work_base = basename(q.work_dir);
    Str old_label = work_base + ".orig/" + Str(file);
    Str new_label = work_base + "/" + Str(file);

    if (backup_empty) {
        old_label = "/dev/null";
    }
    if (!file_exists(working_path)) {
        new_label = "/dev/null";
    }

    std::vector<Str> cmd_argv = {
        "diff", "-u",
        "--label", old_label,
        "--label", new_label,
        old_path, new_path
    };

    ProcessResult result = run_cmd(cmd_argv);
    // diff returns 0 (no diff), 1 (differences), 2 (trouble)
    if (result.exit_code == 2) {
        err_line("diff failed for " + Str(file));
        return "";
    }

    return result.out;
}

// ---------------------------------------------------------------------------
// cmd_refresh — regenerate the patch file from working tree changes
// ---------------------------------------------------------------------------

int cmd_refresh(QuiltState &q, int argc, char **argv) {
    if (q.applied.empty()) {
        err_line("No patches applied");
        return 1;
    }

    // Parse options
    Str patch;
    int i = 1;
    bool no_timestamps = false;
    bool no_index = false;
    bool sort_files = false;
    bool force = false;
    (void)no_timestamps; (void)force;

    while (i < argc) {
        StrView arg = argv[i];
        if (arg == "-p" && i + 1 < argc) {
            i += 2;
            continue;
        }
        if (starts_with(arg, "-p")) {
            i += 1;
            continue;
        }
        if (arg == "-f") {
            force = true;
            i += 1;
            continue;
        }
        if (arg == "--no-timestamps") {
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
        if (patch.empty()) {
            patch = Str(arg);
        }
        i += 1;
    }

    if (patch.empty()) {
        patch = q.applied.back();
    }

    // Get files tracked by this patch
    auto tracked = files_in_patch(q, patch);
    if (sort_files) {
        std::sort(tracked.begin(), tracked.end());
    }

    // Read existing patch header if any
    Str patch_file = path_join(q.work_dir, q.patches_dir, patch);
    Str header;
    if (file_exists(patch_file)) {
        header = read_patch_header(patch_file);
    }

    // Generate diffs
    Str work_base = basename(q.work_dir);
    Str patch_content = header;

    for (const auto &file : tracked) {
        Str diff_out = generate_file_diff(q, patch, file);
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
    Str patches_abs = path_join(q.work_dir, q.patches_dir);
    if (!is_directory(patches_abs)) {
        make_dirs(patches_abs);
    }

    // Write the patch file
    if (!write_file(patch_file, patch_content)) {
        err_line("Failed to write patch file " + patch_file);
        return 1;
    }

    out_line("Refreshed patch " + path_join(q.patches_dir, patch));
    return 0;
}

// ---------------------------------------------------------------------------
// cmd_diff — show diff for a patch
// ---------------------------------------------------------------------------

int cmd_diff(QuiltState &q, int argc, char **argv) {
    if (q.applied.empty()) {
        err_line("No patches applied");
        return 1;
    }

    // Parse options
    Str patch;
    std::vector<Str> file_filter;
    bool no_timestamps = false;
    bool no_index = false;
    (void)no_timestamps;
    int i = 1;

    while (i < argc) {
        StrView arg = argv[i];
        if (arg == "-P" && i + 1 < argc) {
            patch = Str(argv[i + 1]);
            i += 2;
            continue;
        }
        if (arg == "-p" && i + 1 < argc) {
            i += 2;
            continue;
        }
        if (starts_with(arg, "-p")) {
            i += 1;
            continue;
        }
        if (arg == "-u") {
            i += 1;
            continue;
        }
        if (arg == "-z") {
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
        if (arg == "--no-timestamps") {
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
        file_filter.emplace_back(arg);
        i += 1;
    }

    if (patch.empty()) {
        patch = q.applied.back();
    }

    // Get files tracked by this patch
    auto tracked = files_in_patch(q, patch);

    // If file filter given, restrict to those files
    if (!file_filter.empty()) {
        std::vector<Str> filtered;
        for (const auto &t : tracked) {
            for (const auto &f : file_filter) {
                if (t == f) {
                    filtered.push_back(t);
                    break;
                }
            }
        }
        tracked = std::move(filtered);
    }

    Str work_base = basename(q.work_dir);

    for (const auto &file : tracked) {
        Str diff_out = generate_file_diff(q, patch, file);
        if (!diff_out.empty()) {
            if (!no_index) {
                out("Index: " + work_base + "/" + file + "\n");
                out("===================================================================\n");
            }
            out(diff_out);
        }
    }

    return 0;
}

// ---------------------------------------------------------------------------
// cmd_revert — revert working file changes but keep backup
// ---------------------------------------------------------------------------

int cmd_revert(QuiltState &q, int argc, char **argv) {
    if (q.applied.empty()) {
        err_line("No patches applied");
        return 1;
    }

    // Parse options
    Str patch = q.applied.back();
    std::vector<Str> files;
    int i = 1;
    while (i < argc) {
        StrView arg = argv[i];
        if (arg == "-P" && i + 1 < argc) {
            patch = Str(argv[i + 1]);
            i += 2;
            continue;
        }
        files.emplace_back(arg);
        i += 1;
    }

    if (files.empty()) {
        err_line("Usage: quilt revert [-P patch] file ...");
        return 1;
    }

    Str patch_display = path_join(q.patches_dir, patch);

    for (const auto &file : files) {
        // Check if file is tracked by the patch
        Str backup_path = path_join(pc_patch_dir(q, patch), file);
        if (!file_exists(backup_path)) {
            err_line("File " + file + " is not in patch " + patch_display);
            return 1;
        }

        // Restore from backup but keep the backup
        Str target = path_join(q.work_dir, file);
        Str content = read_file(backup_path);
        if (content.empty()) {
            // Backup was empty placeholder — file didn't exist before, delete it
            delete_file(target);
        } else {
            // Ensure target directory exists
            Str target_dir = dirname(target);
            if (!is_directory(target_dir)) {
                make_dirs(target_dir);
            }
            if (!write_file(target, content)) {
                err_line("Failed to restore " + file);
                return 1;
            }
        }

        out_line("File " + file + " reverted");
    }

    return 0;
}
