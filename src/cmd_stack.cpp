// This is free and unencumbered software released into the public domain.
#include "quilt.hpp"
#include "platform.hpp"
#include <cstdlib>


static void write_applied_patches(QuiltState &q) {
    std::string path = path_join(q.work_dir, q.pc_dir, "applied-patches");
    write_applied(path, q.applied);
    // Like the original quilt, remove the file once the stack is empty.
    // Truncating first means a failed removal leaves no stale entries.
    if (q.applied.empty()) delete_file(path);
}

// Apply the patch options from QUILT_PATCH_OPTS that the builtin engine
// understands.
static void apply_quilt_patch_opts(PatchOptions &opts, std::span<const std::string> extra)
{
    for (const auto &opt : extra) {
        std::string_view o = opt;
        if (o == "-R") opts.reverse = true;
        else if (o == "-s") opts.quiet = true;
        else if (o == "-E") opts.remove_empty = true;
        else if (o.starts_with("--fuzz=")) {
            opts.fuzz = checked_cast<int>(parse_int(o.substr(7)));
        }
    }
}

// Rewrite the " -- saving rejects to file X" ending of patch's messages for
// a reject file that push removes, as upstream push's cleanup_patch_output
// does: name the file with the rejects, from the last "patching file" line,
// or with -q, which hides those lines, drop the ending.
static std::string cleanup_patch_output(std::string_view text, bool quiet)
{
    std::string result;
    std::string_view file;
    for (;;) {
        ptrdiff_t nl = str_find(text, '\n');
        std::string_view line = nl < 0 ? text : text.substr(0, checked_cast<size_t>(nl));
        if (line.starts_with("patching file ")) {
            file = line.substr(14);
        }
        ptrdiff_t at = str_find(line, " -- saving rejects to ");
        if (at < 0) {
            result += line;
        } else {
            result += line.substr(0, checked_cast<size_t>(at));
            if (!quiet) {
                result += " -- rejects in file ";
                result += file;
            }
        }
        if (nl < 0) return result;
        result += '\n';
        text.remove_prefix(checked_cast<size_t>(nl + 1));
    }
}

// Check that the patch file accounts for every change to the patch's files,
// like upstream's check_for_pending_changes: apply the patch to the backups
// in memory and compare each result with the working tree.
static bool removes_cleanly(const QuiltState &q, std::string_view name,
                            std::span<const std::string> extra_patch_opts)
{
    std::string pc_dir = pc_patch_dir(q, name);
    auto files = files_in_patch(q, name);

    std::map<std::string, std::string> memfs;
    for (const auto &file : files) {
        // An empty backup means the file did not exist before the patch
        std::string backup = read_file(path_join(pc_dir, file));
        if (!backup.empty()) memfs[file] = std::move(backup);
    }

    std::string patch_content = read_file(path_join(q.work_dir, q.patches_dir, name));
    if (!patch_content.empty()) {
        PatchOptions opts;
        opts.strip_level = q.get_strip_level(name);
        if (q.patch_reversed.contains(std::string(name))) opts.reverse = true;
        apply_quilt_patch_opts(opts, extra_patch_opts);
        // The engine keeps whatever applies, so a force-applied patch
        // matches the partial result that push left behind
        opts.quiet = true;
        opts.fs = &memfs;
        builtin_patch(patch_content, opts);
    }

    for (const auto &file : files) {
        // A missing file compares as empty, like diff against /dev/null
        auto it = memfs.find(file);
        std::string_view expected = it != memfs.end() ? std::string_view(it->second) : "";
        if (read_file(path_join(q.work_dir, file)) != expected) return false;
    }
    return true;
}

// Like upstream push, check whether a patch that does not apply is applied
// already by applying it in reverse, here to copies of its files.  Set files
// to those the reverse patch would have backed up.
static bool reverse_applies(const QuiltState &q, std::string_view name,
                            std::string_view patch_content, PatchOptions opts,
                            std::span<const std::string> extra_patch_opts,
                            std::vector<std::string> &files)
{
    // Flip the series' direction, though as with patch given -R twice, a
    // -R in QUILT_PATCH_OPTS keeps the patch reversed
    opts.reverse = !q.patch_reversed.contains(std::string(name));
    apply_quilt_patch_opts(opts, extra_patch_opts);
    opts.quiet = true;

    files = patch_target_files(patch_content, opts.strip_level, opts.reverse);
    std::map<std::string, std::string> memfs;
    for (const auto &file : files) {
        std::string path = path_join(q.work_dir, file);
        if (file_exists(path)) memfs[file] = read_file(path);
    }
    opts.fs = &memfs;
    PatchResult result = builtin_patch(patch_content, opts);

    std::erase_if(files, [&](const std::string &file) {
        return std::ranges::find(result.skipped, file) != result.skipped.end();
    });
    return result.exit_code == 0;
}

// List the files that rolling back a patch restored from their backups, as
// upstream push -v does through backup-files: first those it removed, whose
// empty backups mean they were missing or empty, then the rest.
static void show_rollback(const QuiltState &q, std::span<const std::string> files)
{
    std::vector<std::string_view> restored;
    for (const auto &file : files) {
        if (read_file(path_join(q.work_dir, file)).empty()) {
            out_line("Removing " + file);
        } else {
            restored.push_back(file);
        }
    }
    for (auto file : restored) {
        out("Restoring ");
        out_line(file);
    }
}

int cmd_series(QuiltState &q, int argc, char **argv) {
    enum { COLOR = 256 };
    static constexpr LongOpt longopts[] = {
        {"color", OptArg::optional, COLOR},
    };
    auto args = parse_options(argc, argv, "vh", longopts);
    if (!args) return 1;
    bool verbose = false;
    for (const auto &opt : args->options) {
        switch (opt.key) {
        case 'v': verbose = true; break;
        case COLOR:
            if (!valid_color_value(opt.value)) return usage_error(argv[0]);
            break;
        case 'h': return command_help(argv[0]);
        }
    }
    if (!args->operands.empty()) return usage_error(argv[0]);

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
        out_line(format_patch(q, patch));
    }
    return 0;
}

int cmd_applied(QuiltState &q, int argc, char **argv) {
    // Upstream declares -n but never handles it, and loops forever on it,
    // so -n does nothing here
    auto args = parse_options(argc, argv, "nh");
    if (!args) return 1;
    for (const auto &opt : args->options) {
        if (opt.key == 'h') return command_help(argv[0]);
    }
    if (std::ssize(args->operands) > 1) return usage_error(argv[0]);
    std::string_view target;
    if (!args->operands.empty()) target = args->operands[0];

    if (!target.empty()) {
        // Print all applied patches up to and including target
        auto found = find_applied_patch(q, target);
        if (!found) return 1;
        for (const auto &a : q.applied) {
            out_line(format_patch(q, a));
            if (a == *found) break;
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
    auto args = parse_options(argc, argv, "h");
    if (!args) return 1;
    if (!args->options.empty()) return command_help(argv[0]);
    if (std::ssize(args->operands) > 1) return usage_error(argv[0]);
    std::optional<std::string_view> target;
    if (!args->operands.empty()) target = args->operands[0];

    if (q.series.empty()) {
        if (q.series_file_exists) {
            err_line("No patches in series");
        } else {
            err_line("No series file found");
        }
        return 1;
    }

    ptrdiff_t start_idx;
    if (target) {
        // Like upstream, a given name is looked up even when empty, which
        // means the top patch
        auto found = find_patch_in_series(q, *target);
        if (!found) return 1;
        start_idx = q.find_in_series(*found).value() + 1;
    } else {
        ptrdiff_t top = q.top_index();
        start_idx = top + 1;
    }

    if (start_idx >= std::ssize(q.series)) {
        // With an explicit target patch, having no patches after it is not
        // an error — just print nothing.
        if (target) {
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
    auto args = parse_options(argc, argv, "h");
    if (!args) return 1;
    if (!args->options.empty()) return command_help(argv[0]);
    if (!args->operands.empty()) return usage_error(argv[0]);
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
    auto args = parse_options(argc, argv, "h");
    if (!args) return 1;
    if (!args->options.empty()) return command_help(argv[0]);
    if (std::ssize(args->operands) > 1) return usage_error(argv[0]);
    std::string_view target;
    if (!args->operands.empty()) target = args->operands[0];

    if (!target.empty()) {
        auto found = find_patch(q, target);
        if (!found) return 1;
        // Original quilt: if the named patch is applied, error
        if (q.is_applied(*found)) {
            err("Patch "); err(format_patch(q, *found)); err_line(" is currently applied");
            return 2;
        }
        // If unapplied, return the patch itself (it's the "next" to be pushed)
        out_line(format_patch(q, *found));
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

    ptrdiff_t after_idx = q.top_index() + 1;

    if (after_idx >= std::ssize(q.series)) {
        std::string_view top_name = q.applied.empty() ? std::string_view("??") : std::string_view(q.applied.back());
        err("File series fully applied, ends at patch "); err_line(format_patch(q, top_name));
        return 2;
    }

    out_line(format_patch(q, q.series[checked_cast<size_t>(after_idx)]));
    return 0;
}

int cmd_previous(QuiltState &q, int argc, char **argv) {
    auto args = parse_options(argc, argv, "h");
    if (!args) return 1;
    if (!args->options.empty()) return command_help(argv[0]);
    if (std::ssize(args->operands) > 1) return usage_error(argv[0]);
    std::string_view target;
    if (!args->operands.empty()) target = args->operands[0];

    if (!target.empty()) {
        auto found = find_patch(q, target);
        if (!found) return 1;
        auto idx = q.find_in_series(*found);
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
    bool verbose = false;  // lists the files of each rollback, like upstream
    int fuzz = -1;
    bool merge = false;
    std::string merge_style;
    bool leave_rejects = false;
    bool do_refresh = false;
    int push_count = -1;
    std::string_view target;

    enum { FUZZ = 256, LEAVE_REJECTS, COLOR, REFRESH };
    static constexpr LongOpt longopts[] = {
        {"fuzz", OptArg::required, FUZZ},
        {"merge", OptArg::optional, 'm'},
        {"leave-rejects", OptArg::none, LEAVE_REJECTS},
        {"color", OptArg::optional, COLOR},
        {"refresh", OptArg::none, REFRESH},
        {"quiet", OptArg::none, 'q', true},
        {"verbose", OptArg::none, 'v', true},
    };
    auto args = parse_options(argc, argv, "fqvam::h", longopts);
    if (!args) return 1;
    for (const auto &opt : args->options) {
        switch (opt.key) {
        case 'f': force = true; break;
        case 'q': quiet = true; break;
        case 'v': verbose = true; break;
        case 'a': push_all = true; break;
        case 'h': return command_help(argv[0]);
        case FUZZ: fuzz = checked_cast<int>(parse_int(opt.value)); break;
        case 'm':
            if (!opt.value.empty() && opt.value != "merge" && opt.value != "diff3") {
                return usage_error(argv[0]);
            }
            merge = true;
            merge_style = opt.value == "diff3" ? "diff3" : "";
            break;
        case LEAVE_REJECTS: leave_rejects = true; break;
        case COLOR:
            if (!valid_color_value(opt.value)) return usage_error(argv[0]);
            break;
        case REFRESH: do_refresh = true; break;
        }
    }
    auto &operands = args->operands;
    if (std::ssize(operands) > 1 || (push_all && !operands.empty())) {
        return usage_error(argv[0]);
    }
    if (!operands.empty()) {
        // Try as number first
        std::string_view arg = operands[0];
        int val = 0;
        auto [ptr, ec] = std::from_chars(arg.data(), arg.data() + arg.size(), val);
        if (ec == std::errc{} && ptr == arg.data() + arg.size() && val > 0) {
            push_count = val;
        } else {
            target = arg;
        }
    }

    ptrdiff_t top = q.top_index();
    ptrdiff_t start_idx = top + 1;

    // Like upstream's find_unapplied_patch, find the named target, or else
    // the next patch, before checking anything else
    ptrdiff_t target_idx = -1;
    if (!push_all && !target.empty()) {
        auto found = find_patch(q, target);
        if (!found) return 1;
        target_idx = q.find_in_series(*found).value();
        if (target_idx < start_idx) {
            err("Patch "); err(format_patch(q, *found)); err_line(" is currently applied");
            return 2;
        }
    } else if (!q.series_file_exists) {
        err_line("No series file found");
        return 1;
    } else if (q.series.empty()) {
        err_line("No patches in series");
        return 2;
    } else if (start_idx >= std::ssize(q.series)) {
        err_line("File series fully applied, ends at patch " +
                 patch_path_display(q, q.applied.back()));
        return 2;
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

    ptrdiff_t end_idx;  // inclusive
    if (push_all) {
        end_idx = std::ssize(q.series) - 1;
    } else if (target_idx >= 0) {
        end_idx = target_idx;
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

        if (i > start_idx && !quiet) {
            out_line("");
        }
        out_line("Applying patch " + display);

        // Read patch file. A missing patch applies as an empty one.
        std::string patch_path = path_join(q.work_dir, q.patches_dir, name);
        bool patch_exists = file_exists(patch_path);
        std::string patch_content = patch_exists ? read_file(patch_path) : "";

        // Apply the patch using built-in patch engine
        PatchOptions patch_opts;
        patch_opts.strip_level = q.get_strip_level(name);
        if (q.patch_reversed.contains(name)) patch_opts.reverse = true;
        if (fuzz >= 0) patch_opts.fuzz = fuzz;
        if (merge) {
            patch_opts.merge = true;
            patch_opts.merge_style = merge_style;
        }
        patch_opts.quiet = quiet;
        apply_quilt_patch_opts(patch_opts, extra_patch_opts);

        // Back up every file the patch will modify, including deletions
        auto affected = patch_target_files(patch_content, patch_opts.strip_level,
                                           patch_opts.reverse);
        std::string pc_dir = pc_patch_dir(q, name);
        if (!is_directory(pc_dir)) {
            make_dirs(pc_dir);
        }

        for (const auto &file : affected) {
            backup_file(q, name, file);
        }

        PatchResult result = builtin_patch(patch_content, patch_opts);

        // GNU patch backs up only the files it patches, so forget the
        // missing files it skipped
        for (const auto &file : result.skipped) {
            delete_file(path_join(pc_dir, file));
            std::erase(affected, file);
        }

        // Like upstream, which runs patch with 2>&1, show all of patch's
        // output on stdout
        if (!force && !leave_rejects) {
            result.out = cleanup_patch_output(result.out, quiet);
        }
        out(result.out);
        out(result.err);

        bool failed = result.exit_code != 0;
        if (failed) {
            if (!force) {
                // Not forced: restore files from backups and clean up
                for (const auto &file : affected) {
                    restore_file(q, name, file);
                }
                if (verbose) show_rollback(q, affected);

                std::vector<std::string> reversed_files;
                if (reverse_applies(q, name, patch_content, patch_opts,
                                    extra_patch_opts, reversed_files)) {
                    out_line("Patch " + display + " can be reverse-applied");
                } else {
                    out_line("Patch " + display + " does not apply (enforce with -f)");
                }
                // Upstream rolls back its trial too
                if (verbose) show_rollback(q, reversed_files);

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

        // Record as applied; a forced patch is marked as needing refresh
        q.applied.push_back(name);
        write_applied_patches(q);
        write_file(path_join(pc_dir, ".timestamp"), "");
        if (failed) {
            write_file(path_join(pc_dir, ".needs_refresh"), "");
        }

        // Like upstream, these print even with -q
        if (!patch_exists) {
            out_line("Patch " + display + " does not exist; applied empty patch");
        } else if (affected.empty()) {
            out_line("Patch " + display + " appears to be empty; applied");
        } else if (failed) {
            out_line("Applied patch " + display + " (forced; needs refresh)");
        }
        if (failed) return 1;

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
    std::optional<std::string_view> target;

    enum { REFRESH = 256 };
    static constexpr LongOpt longopts[] = {
        {"refresh", OptArg::none, REFRESH},
        {"quiet", OptArg::none, 'q', true},
        {"verbose", OptArg::none, 'v', true},
    };
    auto args = parse_options(argc, argv, "fRqvah", longopts);
    if (!args) return 1;
    for (const auto &opt : args->options) {
        switch (opt.key) {
        case 'f': force = true; break;
        // -R (verify removal) is always done unless forced, so it only
        // cancels an earlier -f, as in the original quilt.
        case 'R': force = false; break;
        case 'q': quiet = true; break;
        case 'v': verbose = true; break;
        case 'a': pop_all = true; break;
        case 'h': return command_help(argv[0]);
        case REFRESH: auto_refresh = true; break;
        }
    }
    auto &operands = args->operands;
    if (std::ssize(operands) > 1 || (pop_all && !operands.empty())) {
        return usage_error(argv[0]);
    }
    if (!operands.empty()) {
        std::string_view arg = operands[0];
        if (!arg.empty() &&
            std::ranges::all_of(arg, [](char c) { return c >= '0' && c <= '9'; })) {
            // Any run of digits is a count, as in the original quilt
            auto [ptr, ec] = std::from_chars(arg.data(), arg.data() + arg.size(), pop_count);
            if (ec == std::errc::result_out_of_range) pop_all = true;
        } else {
            target = arg;
        }
    }

    if (q.applied.empty() && !q.series_file_exists) {
        err_line("No series file found");
        return 1;
    }

    if (force && auto_refresh) {
        err_line("Options -f and --refresh are mutually exclusive");
        return 1;
    }

    ptrdiff_t stop_idx;  // index in applied to stop BEFORE (exclusive); pop down to this
    if (pop_all) {
        stop_idx = 0;
    } else if (target) {
        // Like upstream, an empty name means the top patch, so nothing
        // is popped
        auto found = find_applied_patch(q, *target);
        if (!found) return 1;
        ptrdiff_t found_idx = std::ranges::find(q.applied, *found) - q.applied.begin();
        // Pop down to (but not including) the target patch
        stop_idx = found_idx + 1;
    } else if (pop_count >= 0) {
        stop_idx = std::ssize(q.applied) - pop_count;
        if (stop_idx < 0) stop_idx = 0;
    } else {
        // Pop just the top patch
        stop_idx = std::ssize(q.applied) - 1;
    }

    // Refuse to pop a force-applied top patch unless forced, even with
    // --refresh. Like the original quilt, this comes after the target
    // patch has been resolved.
    if (!force && !q.applied.empty()) {
        std::string top_nr = path_join(pc_patch_dir(q, q.applied.back()),
                                       ".needs_refresh");
        if (file_exists(top_nr)) {
            err_line("Patch " + patch_path_display(q, q.applied.back()) +
                     " needs to be refreshed first.");
            return 1;
        }
    }

    if (q.applied.empty() || stop_idx >= std::ssize(q.applied)) {
        err_line("No patch removed");
        return 2;
    }

    auto extra_patch_opts = shell_split(get_env("QUILT_PATCH_OPTS"));

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

        std::string pc_dir = pc_patch_dir(q, name);

        // Refuse to discard changes that are not in the patch file
        if (!force && !removes_cleanly(q, name, extra_patch_opts)) {
            err_line("Patch " + display +
                     " does not remove cleanly (refresh it or enforce with -f)");
            err_line("Hint: `quilt diff -z' will show the pending changes.");
            return 1;
        }

        // Restore backed-up files
        auto files = files_in_patch(q, name);

        if (!first_pop && !quiet) {
            out_line("");
        }
        if (files.empty()) {
            out_line("Patch " + display + " appears to be empty, removing");
        } else {
            out_line("Removing patch " + display);
        }
        first_pop = false;

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
