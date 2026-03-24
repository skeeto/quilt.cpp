// This is free and unencumbered software released into the public domain.
#include "quilt.hpp"
#include "platform.hpp"

// Forward declarations for core.cpp helpers not in headers
extern bool ensure_pc_dir(QuiltState &q);
extern bool write_applied(StrView path, const std::vector<Str> &patches);
extern Str pc_patch_dir(const QuiltState &q, StrView patch);
extern std::vector<Str> files_in_patch(const QuiltState &q, StrView patch);
extern bool backup_file(QuiltState &q, StrView patch, StrView file);
extern bool restore_file(QuiltState &q, StrView patch, StrView file);

// ---------------------------------------------------------------------------
// Helpers
// ---------------------------------------------------------------------------

static Str strip_patches_prefix(const QuiltState &q, StrView name) {
    Str prefix = q.patches_dir + "/";
    if (starts_with(name, prefix)) return Str(name.substr(prefix.size()));
    return Str(name);
}

static Str format_patch(const QuiltState &q, StrView name) {
    return q.patches_dir + "/" + Str(name);
}

static void write_applied_patches(QuiltState &q) {
    Str path = path_join(q.work_dir, q.pc_dir, "applied-patches");
    write_applied(path, q.applied);
}

// Parse affected files from a unified diff.
// Looks for "+++ b/file" lines (or "+++ file" without b/ prefix).
static std::vector<Str> parse_patch_files(StrView content) {
    std::vector<Str> files;
    auto lines = split_lines(content);
    for (const auto &line : lines) {
        if (!starts_with(line, "+++ ")) continue;
        StrView rest = StrView(line).substr(4);
        // Skip /dev/null
        if (starts_with(rest, "/dev/null")) continue;
        // Strip "b/" prefix if present
        if (starts_with(rest, "b/")) {
            rest = rest.substr(2);
        }
        // Strip trailing tab and timestamp (e.g., "\t2024-01-01 ...")
        auto tab = rest.find('\t');
        if (tab != StrView::npos) {
            rest = rest.substr(0, tab);
        }
        Str f = trim(rest);
        if (!f.empty()) {
            files.push_back(std::move(f));
        }
    }
    return files;
}

// ---------------------------------------------------------------------------
// cmd_series
// ---------------------------------------------------------------------------

int cmd_series(QuiltState &q, int argc, char **argv) {
    bool verbose = false;
    for (int i = 1; i < argc; ++i) {
        StrView arg = argv[i];
        if (arg == "-v") verbose = true;
    }

    for (const auto &patch : q.series) {
        if (verbose) {
            if (q.is_applied(patch)) {
                out("= ");
            } else {
                out("  ");
            }
        }
        out_line(format_patch(q, patch));
    }
    return 0;
}

// ---------------------------------------------------------------------------
// cmd_applied
// ---------------------------------------------------------------------------

int cmd_applied(QuiltState &q, int argc, char **argv) {
    Str target;
    for (int i = 1; i < argc; ++i) {
        StrView arg = argv[i];
        if (arg[0] != '-') {
            target = strip_patches_prefix(q, arg);
        }
    }

    if (!target.empty()) {
        // Print all applied patches up to and including target
        auto idx = q.find_in_series(target);
        if (!idx.has_value()) {
            err_line("Patch " + format_patch(q, target) + " is not in series");
            return 1;
        }
        for (const auto &a : q.applied) {
            out_line(format_patch(q, a));
            if (a == target) break;
        }
        return 0;
    }

    if (q.applied.empty()) {
        err_line("No patches applied");
        return 1;
    }

    for (const auto &a : q.applied) {
        out_line(format_patch(q, a));
    }
    return 0;
}

// ---------------------------------------------------------------------------
// cmd_unapplied
// ---------------------------------------------------------------------------

int cmd_unapplied(QuiltState &q, int argc, char **argv) {
    Str target;
    for (int i = 1; i < argc; ++i) {
        StrView arg = argv[i];
        if (arg[0] != '-') {
            target = strip_patches_prefix(q, arg);
        }
    }

    int start_idx;
    if (!target.empty()) {
        auto idx = q.find_in_series(target);
        if (!idx.has_value()) {
            err_line("Patch " + format_patch(q, target) + " is not in series");
            return 1;
        }
        start_idx = idx.value() + 1;
    } else {
        int top = q.top_index();
        start_idx = top + 1;
    }

    if (start_idx >= (int)q.series.size()) {
        Str top_name = q.applied.empty() ? Str("??") : q.applied.back();
        err_line("File series fully applied, ends at patch " + format_patch(q, top_name));
        return 1;
    }

    for (int i = start_idx; i < (int)q.series.size(); ++i) {
        out_line(format_patch(q, q.series[i]));
    }
    return 0;
}

// ---------------------------------------------------------------------------
// cmd_top
// ---------------------------------------------------------------------------

int cmd_top(QuiltState &q, int argc, char **argv) {
    (void)argc; (void)argv;
    if (q.applied.empty()) {
        err_line("No patches applied");
        return 2;
    }
    out_line(format_patch(q, q.applied.back()));
    return 0;
}

// ---------------------------------------------------------------------------
// cmd_next
// ---------------------------------------------------------------------------

int cmd_next(QuiltState &q, int argc, char **argv) {
    Str target;
    for (int i = 1; i < argc; ++i) {
        StrView arg = argv[i];
        if (arg[0] != '-') {
            target = strip_patches_prefix(q, arg);
        }
    }

    int after_idx;
    if (!target.empty()) {
        auto idx = q.find_in_series(target);
        if (!idx.has_value()) {
            err_line("Patch " + format_patch(q, target) + " is not in series");
            return 2;
        }
        after_idx = idx.value() + 1;
    } else {
        int top = q.top_index();
        after_idx = top + 1;
    }

    if (after_idx >= (int)q.series.size()) {
        Str top_name = q.applied.empty() ? Str("??") : q.applied.back();
        err_line("File series fully applied, ends at patch " + format_patch(q, top_name));
        return 2;
    }

    out_line(format_patch(q, q.series[after_idx]));
    return 0;
}

// ---------------------------------------------------------------------------
// cmd_previous
// ---------------------------------------------------------------------------

int cmd_previous(QuiltState &q, int argc, char **argv) {
    Str target;
    for (int i = 1; i < argc; ++i) {
        StrView arg = argv[i];
        if (arg[0] != '-') {
            target = strip_patches_prefix(q, arg);
        }
    }

    if (!target.empty()) {
        auto idx = q.find_in_series(target);
        if (!idx.has_value()) {
            err_line("Patch " + format_patch(q, target) + " is not in series");
            return 2;
        }
        if (idx.value() == 0) {
            err_line("This is the first patch");
            return 2;
        }
        out_line(format_patch(q, q.series[idx.value() - 1]));
        return 0;
    }

    if (q.applied.empty()) {
        err_line("No patches applied");
        return 2;
    }

    if (q.applied.size() == 1) {
        err_line("This is the first patch");
        return 2;
    }

    out_line(format_patch(q, q.applied[q.applied.size() - 2]));
    return 0;
}

// ---------------------------------------------------------------------------
// cmd_push
// ---------------------------------------------------------------------------

int cmd_push(QuiltState &q, int argc, char **argv) {
    bool push_all = false;
    bool force = false;
    bool quiet = false;
    Str target;

    for (int i = 1; i < argc; ++i) {
        StrView arg = argv[i];
        if (arg == "-a") { push_all = true; }
        else if (arg == "-f") { force = true; }
        else if (arg == "-q") { quiet = true; }
        else if (arg[0] != '-') {
            target = strip_patches_prefix(q, arg);
        }
    }

    int top = q.top_index();
    int start_idx = top + 1;

    if (start_idx >= (int)q.series.size()) {
        err_line("File series fully applied, ends at patch " +
                 format_patch(q, q.applied.back()));
        return 2;
    }

    int end_idx;  // inclusive
    if (push_all) {
        end_idx = (int)q.series.size() - 1;
    } else if (!target.empty()) {
        auto idx = q.find_in_series(target);
        if (!idx.has_value()) {
            err_line("Patch " + format_patch(q, target) + " is not in series");
            return 1;
        }
        end_idx = idx.value();
        if (end_idx < start_idx) {
            err_line("Patch " + format_patch(q, target) + " is already applied");
            return 1;
        }
    } else {
        end_idx = start_idx;
    }

    if (!ensure_pc_dir(q)) return 1;

    Str last_applied;
    for (int i = start_idx; i <= end_idx; ++i) {
        const Str &name = q.series[i];
        Str display = format_patch(q, name);

        if (!quiet) {
            out_line("Applying patch " + display);
        }

        // Read patch file
        Str patch_path = path_join(q.work_dir, q.patches_dir, name);
        Str patch_content = read_file(patch_path);
        if (patch_content.empty() && !file_exists(patch_path)) {
            err_line("Patch " + display + " does not exist");
            return 1;
        }

        // Parse affected files and back them up
        auto affected = parse_patch_files(patch_content);
        Str pc_dir = pc_patch_dir(q, name);
        if (!is_directory(pc_dir)) {
            make_dirs(pc_dir);
        }

        for (const auto &file : affected) {
            backup_file(q, name, file);
        }

        // Apply the patch using external patch command
        std::vector<Str> patch_args = {"patch", "-p1", "-E", "--no-backup-if-mismatch"};
        if (force) {
            patch_args.push_back("--force");
        }

        ProcessResult result = run_cmd_input(patch_args, patch_content);

        if (!quiet && !result.out.empty()) {
            out(result.out);
        }

        if (result.exit_code != 0) {
            if (!result.err.empty()) {
                err(result.err);
            }
            err_line("Patch " + display + " does not apply (enforce with -f)");
            if (!force) {
                // Still record the patch as applied so the user can fix it
                q.applied.push_back(name);
                write_applied_patches(q);
                // Create .timestamp
                write_file(path_join(pc_dir, ".timestamp"), "");
                return 1;
            }
        }

        // Record as applied
        q.applied.push_back(name);
        write_applied_patches(q);

        // Create .timestamp
        write_file(path_join(pc_dir, ".timestamp"), "");

        last_applied = name;
    }

    if (!quiet && !last_applied.empty()) {
        out_line("\nNow at patch " + format_patch(q, last_applied));
    }
    return 0;
}

// ---------------------------------------------------------------------------
// cmd_pop
// ---------------------------------------------------------------------------

int cmd_pop(QuiltState &q, int argc, char **argv) {
    bool pop_all = false;
    bool force = false;
    bool quiet = false;
    Str target;

    for (int i = 1; i < argc; ++i) {
        StrView arg = argv[i];
        if (arg == "-a") { pop_all = true; }
        else if (arg == "-f") { force = true; }
        else if (arg == "-q") { quiet = true; }
        else if (arg == "-R") { /* no-op, default behavior */ }
        else if (arg[0] != '-') {
            target = strip_patches_prefix(q, arg);
        }
    }

    (void)force;

    if (q.applied.empty()) {
        err_line("No patches applied");
        return 2;
    }

    int stop_idx;  // index in applied to stop BEFORE (exclusive); pop down to this
    if (pop_all) {
        stop_idx = 0;
    } else if (!target.empty()) {
        // Find target in applied list
        int found = -1;
        for (int i = 0; i < (int)q.applied.size(); ++i) {
            if (q.applied[i] == target) {
                found = i;
                break;
            }
        }
        if (found < 0) {
            err_line("Patch " + format_patch(q, target) + " is not applied");
            return 1;
        }
        // Pop down to (but not including) the target patch
        stop_idx = found + 1;
        if (stop_idx >= (int)q.applied.size()) {
            err_line("Patch " + format_patch(q, target) + " is currently on top");
            return 2;
        }
    } else {
        // Pop just the top patch
        stop_idx = (int)q.applied.size() - 1;
    }

    // Pop from the top down to stop_idx
    while ((int)q.applied.size() > stop_idx) {
        const Str &name = q.applied.back();
        Str display = format_patch(q, name);

        if (!quiet) {
            out_line("Removing patch " + display);
        }

        // Restore backed-up files
        auto files = files_in_patch(q, name);
        for (const auto &file : files) {
            if (!quiet) {
                out_line("Restoring " + file);
            }
            restore_file(q, name, file);
        }

        // Remove the backup directory
        Str pc_dir = pc_patch_dir(q, name);
        delete_dir_recursive(pc_dir);

        // Remove from applied list
        q.applied.pop_back();
        write_applied_patches(q);
    }

    if (!quiet) {
        if (q.applied.empty()) {
            out_line("\nNo patches applied");
        } else {
            out_line("\nNow at patch " + format_patch(q, q.applied.back()));
        }
    }
    return 0;
}
