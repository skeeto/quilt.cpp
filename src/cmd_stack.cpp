// This is free and unencumbered software released into the public domain.
#include "quilt.hpp"
#include "platform.hpp"
#include <cstdlib>


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
        if (!line.starts_with("+++ ")) continue;
        std::string_view rest = std::string_view(line).substr(4);
        // Skip /dev/null
        if (rest.starts_with("/dev/null")) continue;
        // Strip trailing tab and timestamp (e.g., "\t2024-01-01 ...")
        ptrdiff_t tab = str_find(rest, '\t');
        if (tab >= 0) {
            rest = rest.substr(0, checked_cast<size_t>(tab));
        }
        std::string f = trim(rest);
        // Strip N leading path components (like patch -pN)
        for (int i = 0; i < strip && !f.empty(); ++i) {
            ptrdiff_t slash = str_find(std::string_view(f), '/');
            if (slash >= 0) {
                f = f.substr(checked_cast<size_t>(slash) + 1);
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
    // color: 0=never, 1=auto, 2=always
    int color_mode = 0;
    for (int i = 1; i < argc; ++i) {
        std::string_view arg = argv[i];
        if (arg == "-v") {
            verbose = true;
        } else if (arg == "--color") {
            color_mode = 1;  // auto
        } else if (arg.starts_with("--color=")) {
            auto val = arg.substr(8);
            if (val == "always") color_mode = 2;
            else if (val == "auto") color_mode = 1;
            else if (val == "never") color_mode = 0;
            else {
                err("Invalid --color value: "); err_line(val);
                return 1;
            }
        } else if (arg[0] == '-') {
            err("Unrecognized option: "); err_line(arg);
            return 1;
        }
    }

    bool use_color = (color_mode == 2) || (color_mode == 1 && stdout_is_tty());

    if (q.series.empty()) {
        if (q.series_file_exists) {
            // Empty series file: nothing to print, success
            return 0;
        } else {
            err_line("No series file found");
            return 1;
        }
    }

    for (const auto &patch : q.series) {
        if (verbose) {
            if (!q.applied.empty() && patch == q.applied.back()) {
                out("= ");
            } else if (q.is_applied(patch)) {
                out("+ ");
            } else {
                out("  ");
            }
        }
        std::string name = format_patch(q, patch);
        if (use_color) {
            if (!q.applied.empty() && patch == q.applied.back()) {
                out("\033[33m");  // yellow for top
            } else if (q.is_applied(patch)) {
                out("\033[32m");  // green for applied
            } else {
                out("\033[00m");  // default for unapplied
            }
            out(name);
            out_line("\033[00m");
        } else {
            out_line(name);
        }
    }
    return 0;
}

int cmd_applied(QuiltState &q, int argc, char **argv) {
    std::string_view target;
    for (int i = 1; i < argc; ++i) {
        std::string_view arg = argv[i];
        if (arg[0] == '-') {
            err("Unrecognized option: "); err_line(arg);
            return 1;
        }
        target = strip_patches_prefix(q, arg);
    }

    if (!target.empty()) {
        // Print all applied patches up to and including target
        auto idx = q.find_in_series(target);
        if (!idx.has_value()) {
            err("Patch "); err(format_patch(q, target)); err_line(" is not in series");
            return 1;
        }
        if (!q.is_applied(target)) {
            err("Patch "); err(format_patch(q, target)); err_line(" is not applied");
            return 1;
        }
        for (const auto &a : q.applied) {
            out_line(format_patch(q, a));
            if (a == target) break;
        }
        return 0;
    }

    if (q.series.empty()) {
        if (q.series_file_exists) {
            err_line("No patches in series");
        } else {
            err_line("No series file found");
        }
        return 1;
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
    std::string_view target;
    for (int i = 1; i < argc; ++i) {
        std::string_view arg = argv[i];
        if (arg[0] == '-') {
            err("Unrecognized option: "); err_line(arg);
            return 1;
        }
        target = strip_patches_prefix(q, arg);
    }

    if (q.series.empty()) {
        if (q.series_file_exists) {
            err_line("No patches in series");
        } else {
            err_line("No series file found");
        }
        return 1;
    }

    ptrdiff_t start_idx;
    if (!target.empty()) {
        auto idx = q.find_in_series(target);
        if (!idx.has_value()) {
            err("Patch "); err(format_patch(q, target)); err_line(" is not in series");
            return 1;
        }
        start_idx = idx.value() + 1;
    } else {
        ptrdiff_t top = q.top_index();
        start_idx = top + 1;
    }

    if (start_idx >= std::ssize(q.series)) {
        // With an explicit target patch, having no patches after it is not
        // an error — just print nothing.
        if (!target.empty()) {
            return 0;
        }
        std::string_view top_name = q.applied.empty() ? std::string_view("??") : std::string_view(q.applied.back());
        err("File series fully applied, ends at patch "); err_line(format_patch(q, top_name));
        return 1;
    }

    for (ptrdiff_t i = start_idx; i < std::ssize(q.series); ++i) {
        out_line(format_patch(q, q.series[checked_cast<size_t>(i)]));
    }
    return 0;
}

int cmd_top(QuiltState &q, int argc, char **argv) {
    for (int i = 1; i < argc; ++i) {
        std::string_view arg = argv[i];
        if (arg[0] == '-') {
            err("Unrecognized option: "); err_line(arg);
            return 1;
        }
    }
    if (q.series.empty()) {
        if (q.series_file_exists) {
            err_line("No patches in series");
            return 2;
        } else {
            err_line("No series file found");
            return 1;
        }
    }
    if (q.applied.empty()) {
        err_line("No patches applied");
        return 2;
    }
    out_line(format_patch(q, q.applied.back()));
    return 0;
}

int cmd_next(QuiltState &q, int argc, char **argv) {
    std::string_view target;
    for (int i = 1; i < argc; ++i) {
        std::string_view arg = argv[i];
        if (arg[0] == '-') {
            err("Unrecognized option: "); err_line(arg);
            return 1;
        }
        target = strip_patches_prefix(q, arg);
    }

    if (q.series.empty()) {
        if (q.series_file_exists) {
            err_line("No patches in series");
            return 2;
        } else {
            err_line("No series file found");
            return 1;
        }
    }

    ptrdiff_t after_idx;
    if (!target.empty()) {
        auto idx = q.find_in_series(target);
        if (!idx.has_value()) {
            err("Patch "); err(format_patch(q, target)); err_line(" is not in series");
            return 2;
        }
        // Original quilt: if the named patch is applied, error
        if (q.is_applied(target)) {
            err("Patch "); err(format_patch(q, target)); err_line(" is currently applied");
            return 2;
        }
        // If unapplied, return the patch itself (it's the "next" to be pushed)
        out_line(format_patch(q, target));
        return 0;
    } else {
        ptrdiff_t top = q.top_index();
        after_idx = top + 1;
    }

    if (after_idx >= std::ssize(q.series)) {
        std::string_view top_name = q.applied.empty() ? std::string_view("??") : std::string_view(q.applied.back());
        err("File series fully applied, ends at patch "); err_line(format_patch(q, top_name));
        return 2;
    }

    out_line(format_patch(q, q.series[checked_cast<size_t>(after_idx)]));
    return 0;
}

int cmd_previous(QuiltState &q, int argc, char **argv) {
    std::string_view target;
    for (int i = 1; i < argc; ++i) {
        std::string_view arg = argv[i];
        if (arg[0] == '-') {
            err("Unrecognized option: "); err_line(arg);
            return 1;
        }
        target = strip_patches_prefix(q, arg);
    }

    if (!target.empty()) {
        auto idx = q.find_in_series(target);
        if (!idx.has_value()) {
            err("Patch "); err(format_patch(q, target)); err_line(" is not in series");
            return 2;
        }
        if (idx.value() == 0) {
            return 2;
        }
        out_line(format_patch(q, q.series[checked_cast<size_t>(idx.value() - 1)]));
        return 0;
    }

    if (q.series.empty()) {
        if (q.series_file_exists) {
            err_line("No patches in series");
            return 2;
        } else {
            err_line("No series file found");
            return 1;
        }
    }

    if (q.applied.empty()) {
        err_line("No patches applied");
        return 1;
    }

    if (std::ssize(q.applied) == 1) {
        return 2;
    }

    out_line(format_patch(q, q.applied[checked_cast<size_t>(std::ssize(q.applied) - 2)]));
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
    std::string_view target;

    for (int i = 1; i < argc; ++i) {
        std::string_view arg = argv[i];
        if (arg == "-a") { push_all = true; }
        else if (arg == "-f") { force = true; }
        else if (arg == "-q" || arg == "--quiet") { quiet = true; }
        else if (arg == "-v" || arg == "--verbose") { verbose = true; }
        else if (arg.starts_with("--fuzz=")) { fuzz = checked_cast<int>(parse_int(arg.substr(7))); }
        else if (arg == "-m" || arg == "--merge") { merge = true; }
        else if (arg.starts_with("--merge=")) { merge = true; merge_style = std::string(arg.substr(8)); }
        else if (arg == "--leave-rejects") { leave_rejects = true; }
        else if (arg == "--refresh") { do_refresh = true; }
        else if (arg == "--color" || arg.starts_with("--color=")) {
            if (arg.starts_with("--color=")) {
                auto val = arg.substr(8);
                if (val != "always" && val != "auto" && val != "never") {
                    err("Invalid --color value: "); err_line(val);
                    return 1;
                }
            }
        }
        else if (arg[0] == '-') {
            err("Unrecognized option: "); err_line(arg);
            return 1;
        }
        else {
            // Try as number first
            int val = 0;
            auto [ptr, ec] = std::from_chars(arg.data(), arg.data() + arg.size(), val);
            if (ec == std::errc{} && ptr == arg.data() + arg.size() && val > 0) {
                push_count = val;
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

    if (q.series.empty()) {
        if (q.series_file_exists) {
            err_line("No patches in series");
        } else {
            err_line("No series file found");
        }
        return 2;
    }

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
            err("Patch "); err(format_patch(q, target)); err_line(" is not in series");
            return 1;
        }
        end_idx = idx.value();
        if (end_idx < start_idx) {
            err("Patch "); err(format_patch(q, target)); err_line(" is currently applied");
            return 2;
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
        const std::string &name = q.series[checked_cast<size_t>(i)];
        std::string display = patch_path_display(q, name);

        if (i > start_idx) {
            out_line("");
        }
        out_line("Applying patch " + display);

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

        // Apply the patch using built-in patch engine
        PatchOptions patch_opts;
        patch_opts.strip_level = strip_level;
        patch_opts.remove_empty = true;
        patch_opts.force = force;
        if (q.patch_reversed.contains(name)) patch_opts.reverse = true;
        if (fuzz >= 0) patch_opts.fuzz = fuzz;
        if (merge) {
            patch_opts.merge = true;
            patch_opts.merge_style = merge_style;
        }
        // Parse QUILT_PATCH_OPTS for additional options
        for (const auto &opt : extra_patch_opts) {
            std::string_view o = opt;
            if (o == "-R") patch_opts.reverse = true;
            else if (o == "-f" || o == "--force") patch_opts.force = true;
            else if (o == "-s") patch_opts.quiet = true;
            else if (o == "-E") patch_opts.remove_empty = true;
            else if (o.starts_with("--fuzz=")) {
                patch_opts.fuzz = checked_cast<int>(parse_int(o.substr(7)));
            }
        }

        // Print verbose file list ourselves instead of relying on
        // patch --verbose, which is not available on busybox.
        if (verbose && !quiet) {
            for (const auto &file : affected) {
                out_line("patching file " + file);
            }
        }

        // Suppress builtin_patch's own "patching file" messages when we do verbose ourselves
        if (verbose) patch_opts.quiet = true;

        PatchResult result = builtin_patch(patch_content, patch_opts);

        if (!quiet && !verbose && !result.out.empty()) {
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
                out_line("Applied patch " + display + " (forced; needs refresh)");
                return 1;
            } else {
                // Not forced: restore files from backups and clean up
                for (const auto &file : affected) {
                    restore_file(q, name, file);
                }
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

    if (!last_applied.empty()) {
        if (!quiet) out_line("");
        out_line("Now at patch " + patch_path_display(q, last_applied));
    }
    return 0;
}

int cmd_pop(QuiltState &q, int argc, char **argv) {
    bool pop_all = false;
    bool force = false;
    bool quiet = false;
    [[maybe_unused]] bool verbose = false;  // accepted for compat, pop is verbose by default
    bool auto_refresh = false;
    int pop_count = -1;
    std::string_view target;

    for (int i = 1; i < argc; ++i) {
        std::string_view arg = argv[i];
        if (arg == "-a") { pop_all = true; }
        else if (arg == "-f") { force = true; }
        else if (arg == "-q" || arg == "--quiet") { quiet = true; }
        else if (arg == "-v" || arg == "--verbose") { verbose = true; }
        else if (arg == "-R") { /* accepted for compat, always verified now */ }
        else if (arg == "--refresh") { auto_refresh = true; }
        else if (arg[0] == '-') {
            err("Unrecognized option: "); err_line(arg);
            return 1;
        }
        else {
            // Try as number first
            int val = 0;
            auto [ptr, ec] = std::from_chars(arg.data(), arg.data() + arg.size(), val);
            if (ec == std::errc{} && ptr == arg.data() + arg.size() && val > 0) {
                pop_count = val;
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
            if (q.applied[checked_cast<size_t>(i)] == target) {
                found_idx = i;
                break;
            }
        }
        if (found_idx < 0) {
            err("Patch "); err(format_patch(q, target)); err_line(" is not applied");
            return 1;
        }
        // Pop down to (but not including) the target patch
        stop_idx = found_idx + 1;
        if (stop_idx >= std::ssize(q.applied)) {
            err_line("No patch removed");
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
    bool first_pop = true;
    while (std::ssize(q.applied) > stop_idx) {
        const std::string &name = q.applied.back();
        std::string display = patch_path_display(q, name);

        // Auto-refresh before popping if requested
        if (auto_refresh) {
            auto extra = shell_split(get_env("QUILT_REFRESH_ARGS"));
            std::vector<std::string> r_storage;
            r_storage.push_back("refresh");
            for (auto &e : extra) r_storage.push_back(e);
            std::vector<char *> r_argv;
            for (auto &s : r_storage) r_argv.push_back(s.data());
            int rr = cmd_refresh(q, checked_cast<int>(std::ssize(r_argv)), r_argv.data());
            if (rr != 0) {
                err_line("Refresh of patch " + display + " failed, aborting pop");
                return 1;
            }
        }

        // Check if patch needs refresh (force-applied) and -f not given
        std::string pc_dir = pc_patch_dir(q, name);
        std::string nr = path_join(pc_dir, ".needs_refresh");
        if (file_exists(nr) && !force && !auto_refresh) {
            err_line("Patch " + display + " needs to be refreshed first.");
            return 1;
        }

        // Check if patch removes cleanly (detects dirty/unrefreshed changes)
        if (!force) {
            std::string patch_path = path_join(q.work_dir, q.patches_dir, name);
            std::string patch_content = read_file(patch_path);
            if (!patch_content.empty()) {
                int strip_level = q.get_strip_level(name);
                PatchOptions verify_opts;
                verify_opts.strip_level = strip_level;
                verify_opts.reverse = true;
                verify_opts.dry_run = true;
                verify_opts.force = true;
                verify_opts.quiet = true;
                PatchResult vr = builtin_patch(patch_content, verify_opts);
                if (vr.exit_code != 0) {
                    err_line("Patch " + display +
                             " does not remove cleanly (refresh it or enforce with -f)");
                    err_line("Hint: `quilt diff -z' will show the pending changes.");
                    return 1;
                }
            }
        }

        if (!first_pop) {
            out_line("");
        }
        out_line("Removing patch " + display);
        first_pop = false;

        // Restore backed-up files
        auto files = files_in_patch(q, name);
        for (const auto &file : files) {
            restore_file(q, name, file);
            if (!quiet) {
                // Show what happened to each file: "Removing" if the file
                // was deleted (created by the patch), "Restoring" otherwise.
                if (!file_exists(path_join(q.work_dir, file))) {
                    out_line("Removing " + file);
                } else {
                    out_line("Restoring " + file);
                }
            }
        }

        // Remove the backup directory
        delete_dir_recursive(pc_dir);

        // Remove from applied list
        q.applied.pop_back();
        write_applied_patches(q);
    }

    if (!quiet) out_line("");
    if (q.applied.empty()) {
        out_line("No patches applied");
    } else {
        out_line("Now at patch " + patch_path_display(q, q.applied.back()));
    }
    return 0;
}
