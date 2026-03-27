// This is free and unencumbered software released into the public domain.
#include "quilt.hpp"
#include "platform.hpp"
#include <cstdlib>

// Forward declarations for core.cpp helpers not in headers
extern bool ensure_pc_dir(QuiltState &q);
extern bool write_applied(std::string_view path, const std::vector<std::string> &patches);
extern std::string pc_patch_dir(const QuiltState &q, std::string_view patch);
extern std::vector<std::string> files_in_patch(const QuiltState &q, std::string_view patch);
extern bool backup_file(QuiltState &q, std::string_view patch, std::string_view file);
extern bool restore_file(QuiltState &q, std::string_view patch, std::string_view file);

static std::string strip_patches_prefix(const QuiltState &q, std::string_view name) {
    std::string prefix = q.patches_dir + "/";
    if (starts_with(name, prefix)) return std::string(name.substr(prefix.size()));
    return std::string(name);
}

static std::string format_patch(const QuiltState &q, std::string_view name) {
    if (!get_env("QUILT_PATCHES_PREFIX").empty()) {
        return q.patches_dir + "/" + std::string(name);
    }
    return std::string(name);
}

static std::string patch_path_display(const QuiltState &q, std::string_view name) {
    return q.patches_dir + "/" + std::string(name);
}

static void write_applied_patches(QuiltState &q) {
    std::string path = path_join(q.work_dir, q.pc_dir, "applied-patches");
    write_applied(path, q.applied);
}

// Parse affected files from a unified diff, stripping path components
// to match what `patch -pN` would do.
static std::vector<std::string> parse_patch_files(std::string_view content, int strip = 1) {
    std::vector<std::string> files;
    auto lines = split_lines(content);
    for (const auto &line : lines) {
        if (!starts_with(line, "+++ ")) continue;
        std::string_view rest = std::string_view(line).substr(4);
        // Skip /dev/null
        if (starts_with(rest, "/dev/null")) continue;
        // Strip trailing tab and timestamp (e.g., "\t2024-01-01 ...")
        ptrdiff_t tab = str_find(rest, '\t');
        if (tab >= 0) {
            rest = rest.substr(0, to_uz(tab));
        }
        std::string f = trim(rest);
        // Strip N leading path components (like patch -pN)
        for (int i = 0; i < strip && !f.empty(); ++i) {
            ptrdiff_t slash = str_find(std::string_view(f), '/');
            if (slash >= 0) {
                f = f.substr(to_uz(slash) + 1);
            }
        }
        if (!f.empty()) {
            files.push_back(std::move(f));
        }
    }
    return files;
}

int cmd_series(QuiltState &q, int argc, char **argv) {
    bool verbose = false;
    for (int i = 1; i < argc; ++i) {
        std::string_view arg = argv[i];
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

int cmd_applied(QuiltState &q, int argc, char **argv) {
    std::string target;
    for (int i = 1; i < argc; ++i) {
        std::string_view arg = argv[i];
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

int cmd_unapplied(QuiltState &q, int argc, char **argv) {
    std::string target;
    for (int i = 1; i < argc; ++i) {
        std::string_view arg = argv[i];
        if (arg[0] != '-') {
            target = strip_patches_prefix(q, arg);
        }
    }

    ptrdiff_t start_idx;
    if (!target.empty()) {
        auto idx = q.find_in_series(target);
        if (!idx.has_value()) {
            err_line("Patch " + format_patch(q, target) + " is not in series");
            return 1;
        }
        start_idx = idx.value() + 1;
    } else {
        ptrdiff_t top = q.top_index();
        start_idx = top + 1;
    }

    if (start_idx >= std::ssize(q.series)) {
        std::string top_name = q.applied.empty() ? std::string("??") : q.applied.back();
        err_line("File series fully applied, ends at patch " + format_patch(q, top_name));
        return 1;
    }

    for (ptrdiff_t i = start_idx; i < std::ssize(q.series); ++i) {
        out_line(format_patch(q, q.series[to_uz(i)]));
    }
    return 0;
}

int cmd_top(QuiltState &q, int argc, char **argv) {
    (void)argc; (void)argv;
    if (!q.series_file_exists) {
        err_line("No series file found");
        return 1;
    }
    if (q.applied.empty()) {
        err_line("No patches applied");
        return 2;
    }
    out_line(format_patch(q, q.applied.back()));
    return 0;
}

int cmd_next(QuiltState &q, int argc, char **argv) {
    std::string target;
    for (int i = 1; i < argc; ++i) {
        std::string_view arg = argv[i];
        if (arg[0] != '-') {
            target = strip_patches_prefix(q, arg);
        }
    }

    ptrdiff_t after_idx;
    if (!target.empty()) {
        auto idx = q.find_in_series(target);
        if (!idx.has_value()) {
            err_line("Patch " + format_patch(q, target) + " is not in series");
            return 2;
        }
        after_idx = idx.value() + 1;
    } else {
        ptrdiff_t top = q.top_index();
        after_idx = top + 1;
    }

    if (after_idx >= std::ssize(q.series)) {
        std::string top_name = q.applied.empty() ? std::string("??") : q.applied.back();
        err_line("File series fully applied, ends at patch " + format_patch(q, top_name));
        return 2;
    }

    out_line(format_patch(q, q.series[to_uz(after_idx)]));
    return 0;
}

int cmd_previous(QuiltState &q, int argc, char **argv) {
    std::string target;
    for (int i = 1; i < argc; ++i) {
        std::string_view arg = argv[i];
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
            return 2;
        }
        out_line(format_patch(q, q.series[to_uz(idx.value() - 1)]));
        return 0;
    }

    if (!q.series_file_exists) {
        err_line("No series file found");
        return 1;
    }

    if (q.applied.empty()) {
        err_line("No patches applied");
        return 2;
    }

    if (std::ssize(q.applied) == 1) {
        return 2;
    }

    out_line(format_patch(q, q.applied[to_uz(std::ssize(q.applied) - 2)]));
    return 0;
}

int cmd_push(QuiltState &q, int argc, char **argv) {
    bool push_all = false;
    bool force = false;
    bool quiet = false;
    bool verbose = false;
    int fuzz = -1;
    bool merge = false;
    std::string merge_style;
    bool leave_rejects = false;
    bool do_refresh = false;
    int push_count = -1;
    std::string target;

    for (int i = 1; i < argc; ++i) {
        std::string_view arg = argv[i];
        if (arg == "-a") { push_all = true; }
        else if (arg == "-f") { force = true; }
        else if (arg == "-q") { quiet = true; }
        else if (arg == "-v") { verbose = true; }
        else if (starts_with(arg, "--fuzz=")) { fuzz = std::atoi(std::string(arg.substr(7)).c_str()); }
        else if (arg == "-m" || arg == "--merge") { merge = true; }
        else if (starts_with(arg, "--merge=")) { merge = true; merge_style = std::string(arg.substr(8)); }
        else if (arg == "--leave-rejects") { leave_rejects = true; }
        else if (arg == "--refresh") { do_refresh = true; }
        else if (arg[0] != '-') {
            // Try as number first
            char *endptr;
            long val = strtol(std::string(arg).c_str(), &endptr, 10);
            if (*endptr == '\0' && val > 0) {
                push_count = static_cast<int>(val);
            } else {
                target = strip_patches_prefix(q, arg);
            }
        }
    }

    // Refuse to push if top patch needs refresh (was force-applied)
    if (!q.applied.empty()) {
        std::string nr = path_join(pc_patch_dir(q, q.applied.back()), ".needs_refresh");
        if (file_exists(nr)) {
            err_line("The topmost patch " + patch_path_display(q, q.applied.back()) +
                     " needs to be refreshed first.");
            return 1;
        }
    }

    ptrdiff_t top = q.top_index();
    ptrdiff_t start_idx = top + 1;

    if (start_idx >= std::ssize(q.series)) {
        err_line("File series fully applied, ends at patch " +
                 patch_path_display(q, q.applied.back()));
        return 2;
    }

    ptrdiff_t end_idx;  // inclusive
    if (push_all) {
        end_idx = std::ssize(q.series) - 1;
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
    } else if (push_count > 0) {
        end_idx = start_idx + push_count - 1;
        if (end_idx >= std::ssize(q.series)) {
            end_idx = std::ssize(q.series) - 1;
        }
    } else {
        end_idx = start_idx;
    }

    if (!ensure_pc_dir(q)) return 1;

    // Read QUILT_PATCH_OPTS
    auto extra_patch_opts = shell_split(get_env("QUILT_PATCH_OPTS"));

    std::string last_applied;
    for (ptrdiff_t i = start_idx; i <= end_idx; ++i) {
        const std::string &name = q.series[to_uz(i)];
        std::string display = patch_path_display(q, name);

        if (!quiet) {
            out_line("Applying patch " + display);
        }

        // Read patch file
        std::string patch_path = path_join(q.work_dir, q.patches_dir, name);
        std::string patch_content = read_file(patch_path);
        if (patch_content.empty() && !file_exists(patch_path)) {
            err_line("Patch " + display + " does not exist");
            return 1;
        }

        // Parse affected files and back them up
        int strip_level = q.get_strip_level(name);
        auto affected = parse_patch_files(patch_content, strip_level);
        std::string pc_dir = pc_patch_dir(q, name);
        if (!is_directory(pc_dir)) {
            make_dirs(pc_dir);
        }

        for (const auto &file : affected) {
            backup_file(q, name, file);
        }

        // Apply the patch using external patch command
        std::vector<std::string> patch_args = {
            "patch", "-p" + std::to_string(strip_level), "-E", "--no-backup-if-mismatch"
        };
        if (force) {
            patch_args.push_back("--force");
        }
        if (verbose) {
            patch_args.push_back("--verbose");
        }
        if (fuzz >= 0) {
            patch_args.push_back("--fuzz=" + std::to_string(fuzz));
        }
        if (merge) {
            if (merge_style.empty()) {
                patch_args.push_back("--merge");
            } else {
                patch_args.push_back("--merge=" + merge_style);
            }
        }
        for (const auto &opt : extra_patch_opts) {
            patch_args.push_back(opt);
        }

        ProcessResult result = run_cmd_input(patch_args, patch_content);

        if (!quiet && !result.out.empty()) {
            out(result.out);
        }

        if (result.exit_code != 0) {
            if (!result.err.empty()) {
                err(result.err);
            }
            if (force) {
                // Force-applied: record as applied but mark as needing refresh
                q.applied.push_back(name);
                write_applied_patches(q);
                write_file(path_join(pc_dir, ".timestamp"), "");
                write_file(path_join(pc_dir, ".needs_refresh"), "");
                if (!quiet) {
                    out_line("Applied patch " + display + " (forced; needs refresh)");
                }
                return 1;
            } else {
                // Not forced: do not record, clean up backups
                err_line("Patch " + display + " does not apply (enforce with -f)");
                if (!leave_rejects) {
                    for (const auto &file : affected) {
                        std::string rej = path_join(q.work_dir, file + ".rej");
                        if (file_exists(rej)) {
                            delete_file(rej);
                        }
                    }
                }
                delete_dir_recursive(pc_dir);
                return 1;
            }
        }

        // Record as applied
        q.applied.push_back(name);
        write_applied_patches(q);

        // Create .timestamp
        write_file(path_join(pc_dir, ".timestamp"), "");

        if (do_refresh) {
            char arg0[] = "refresh";
            char *refresh_argv[] = {arg0, nullptr};
            int rr = cmd_refresh(q, 1, refresh_argv);
            if (rr != 0) return rr;
        }

        last_applied = name;
    }

    if (!quiet && !last_applied.empty()) {
        out_line("\nNow at patch " + patch_path_display(q, last_applied));
    }
    return 0;
}

int cmd_pop(QuiltState &q, int argc, char **argv) {
    bool pop_all = false;
    bool force = false;
    bool quiet = false;
    bool verbose = false;
    bool verify_reverse = false;
    bool auto_refresh = false;
    int pop_count = -1;
    std::string target;

    for (int i = 1; i < argc; ++i) {
        std::string_view arg = argv[i];
        if (arg == "-a") { pop_all = true; }
        else if (arg == "-f") { force = true; }
        else if (arg == "-q") { quiet = true; }
        else if (arg == "-v") { verbose = true; }
        else if (arg == "-R") { verify_reverse = true; }
        else if (arg == "--refresh") { auto_refresh = true; }
        else if (arg[0] != '-') {
            // Try as number first
            char *endptr;
            long val = strtol(std::string(arg).c_str(), &endptr, 10);
            if (*endptr == '\0' && val > 0) {
                pop_count = static_cast<int>(val);
            } else {
                target = strip_patches_prefix(q, arg);
            }
        }
    }

    if (q.applied.empty()) {
        if (!q.series_file_exists) {
            err_line("No series file found");
            return 1;
        }
        err_line("No patch removed");
        return 2;
    }

    ptrdiff_t stop_idx;  // index in applied to stop BEFORE (exclusive); pop down to this
    if (pop_all) {
        stop_idx = 0;
    } else if (!target.empty()) {
        // Find target in applied list
        ptrdiff_t found_idx = -1;
        for (ptrdiff_t i = 0; i < std::ssize(q.applied); ++i) {
            if (q.applied[to_uz(i)] == target) {
                found_idx = i;
                break;
            }
        }
        if (found_idx < 0) {
            err_line("Patch " + format_patch(q, target) + " is not applied");
            return 1;
        }
        // Pop down to (but not including) the target patch
        stop_idx = found_idx + 1;
        if (stop_idx >= std::ssize(q.applied)) {
            err_line("Patch " + format_patch(q, target) + " is currently on top");
            return 2;
        }
    } else if (pop_count > 0) {
        stop_idx = std::ssize(q.applied) - pop_count;
        if (stop_idx < 0) stop_idx = 0;
    } else {
        // Pop just the top patch
        stop_idx = std::ssize(q.applied) - 1;
    }

    // Pop from the top down to stop_idx
    while (std::ssize(q.applied) > stop_idx) {
        const std::string &name = q.applied.back();
        std::string display = patch_path_display(q, name);

        // Auto-refresh before popping if requested
        if (auto_refresh) {
            char cmd_name[] = "refresh";
            char *refresh_argv[] = {cmd_name};
            int rr = cmd_refresh(q, 1, refresh_argv);
            if (rr != 0) {
                err_line("Refresh of patch " + display + " failed, aborting pop");
                return 1;
            }
        }

        // Check if patch needs refresh (force-applied) and -f not given
        std::string pc_dir = pc_patch_dir(q, name);
        std::string nr = path_join(pc_dir, ".needs_refresh");
        if (file_exists(nr) && !force) {
            err_line("Patch " + display + " needs to be refreshed first.");
            return 1;
        }

        // Verify patch removes cleanly if -R given
        if (verify_reverse) {
            std::string patch_path = path_join(q.work_dir, q.patches_dir, name);
            std::string patch_content = read_file(patch_path);
            if (!patch_content.empty()) {
                int strip_level = q.get_strip_level(name);
                std::vector<std::string> verify_args = {
                    "patch", "-R", "-p" + std::to_string(strip_level),
                    "--dry-run", "-f"
                };
                ProcessResult vr = run_cmd_input(verify_args, patch_content);
                if (vr.exit_code != 0) {
                    if (!force) {
                        err_line("Patch " + display +
                                 " does not remove cleanly (enforce with -f)");
                        return 1;
                    }
                }
            }
        }

        if (!quiet) {
            out_line("Removing patch " + display);
        }

        // Restore backed-up files
        auto files = files_in_patch(q, name);
        for (const auto &file : files) {
            if (verbose && !quiet) {
                out_line("Restoring " + file);
            }
            restore_file(q, name, file);
        }

        // Remove the backup directory
        delete_dir_recursive(pc_dir);

        // Remove from applied list
        q.applied.pop_back();
        write_applied_patches(q);
    }

    if (!quiet) {
        if (q.applied.empty()) {
            out_line("\nNo patches applied");
        } else {
            out_line("\nNow at patch " + patch_path_display(q, q.applied.back()));
        }
    }
    return 0;
}
