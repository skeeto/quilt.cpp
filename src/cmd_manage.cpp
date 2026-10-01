// This is free and unencumbered software released into the public domain.
#include "quilt.hpp"
#include "platform.hpp"


static bool write_applied_checked(const QuiltState &q,
                                  std::span<const std::string> applied) {
    std::string applied_path = path_join(q.work_dir, q.pc_dir, "applied-patches");
    if (!write_applied(applied_path, applied)) {
        err_line("Failed to write applied-patches.");
        return false;
    }
    // Like the original quilt, remove the file once the stack is empty.
    if (applied.empty()) delete_file(applied_path);
    return true;
}

// Files an unapplied patch would modify, per its series options
static std::vector<std::string> unapplied_patch_files(const QuiltState &q,
                                                      std::string_view patch) {
    std::string content = read_file(path_join(q.work_dir, q.patches_dir, patch));
    return patch_target_files(content, q.get_strip_level(patch),
                              q.patch_reversed.contains(std::string(patch)));
}

// Like upstream's merge_patches, build the new contents of a patch that
// import -f replaces, keeping the old (o), all (a) or new (n) header. The
// headers are compared, and the old one kept, without their diffstats.
// Without a mode, keep whichever header is not empty, or show how they
// differ and fail. Unlike upstream, matching headers take the new version
// as it is (upstream writes the header twice), and the mode chosen here is
// not kept for the next patch.
static std::optional<std::string> merge_patches(std::string_view old_patch,
                                                std::string_view new_patch,
                                                char mode) {
    std::string old_desc = strip_diffstat(patch_header(old_patch));
    std::string new_desc = strip_diffstat(patch_header(new_patch));

    if (!mode) {
        if (old_desc.empty() || old_desc == new_desc) {
            mode = 'n';
        } else if (new_desc.empty()) {
            mode = 'o';
        } else {
            std::map<std::string, std::string> fs = {{"a", old_desc},
                                                     {"b", new_desc}};
            std::string diff = builtin_diff("a", "b", 3, {}, {},
                                            DiffFormat::unified,
                                            DiffAlgorithm::myers, &fs).output;
            // Like sed -e '1,2d', drop the --- and +++ lines
            for (int i = 0; i < 2; ++i) {
                diff.erase(0, checked_cast<size_t>(str_find(diff, '\n') + 1));
            }
            err_line("Patch headers differ:");
            err(diff);
            err_line("Please use -d {o|a|n} to specify which patch "
                     "header(s) to keep.");
            return std::nullopt;
        }
    }

    std::string merged;
    if (mode != 'n') merged = old_desc;
    if (mode == 'a') merged += "---\n";
    if (mode == 'o') {
        merged += patch_body(new_patch);
    } else {
        merged += new_patch;
    }
    return merged;
}


int cmd_delete(QuiltState &q, int argc, char **argv) {
    enum { BACKUP = 256 };
    static constexpr LongOpt longopts[] = {
        {"backup", OptArg::none, BACKUP},
    };
    auto args = parse_options(argc, argv, "nrh", longopts);
    if (!args) return 1;
    bool opt_remove = false;
    bool opt_backup = false;
    bool opt_next = false;
    for (const auto &opt : args->options) {
        switch (opt.key) {
        case 'n': opt_next = true; break;
        case 'r': opt_remove = true; break;
        case 'h': return command_help(argv[0]);
        case BACKUP: opt_backup = true; break;
        }
    }
    const auto &operands = args->operands;
    if (std::ssize(operands) > 1 || (opt_next && !operands.empty())) {
        return usage_error(argv[0]);
    }
    std::string_view patch_arg;
    if (!operands.empty()) patch_arg = operands[0];

    std::string patch;
    if (opt_next) {
        // Next unapplied patch
        ptrdiff_t top_idx = q.top_index();
        ptrdiff_t next_idx = top_idx + 1;
        if (next_idx >= std::ssize(q.series)) {
            err_line("No next patch");
            return 1;
        }
        patch = q.series[checked_cast<size_t>(next_idx)];
    } else {
        // No argument, or an empty one, means the top patch
        auto found = find_patch_in_series(q, patch_arg);
        if (!found) return 1;
        patch = *found;
    }

    // If patch is applied, only allow deleting the topmost patch
    if (q.is_applied(patch)) {
        if (patch != q.applied.back()) {
            err("Patch "); err(patch_path_display(q, patch));
            err_line(" is currently applied");
            return 1;
        }
        // Pop the topmost patch silently (no per-file messages)
        auto tracked = files_in_patch(q, patch);
        if (tracked.empty()) {
            out_line("Patch " + patch_path_display(q, patch) +
                     " appears to be empty, removing");
        } else {
            out_line("Removing patch " + patch_path_display(q, patch));
        }
        for (const auto &f : tracked) {
            restore_file(q, patch, f);
        }
        std::string pc_dir = pc_patch_dir(q, patch);
        if (is_directory(pc_dir)) delete_dir_recursive(pc_dir);
        q.applied.pop_back();
        if (!write_applied_checked(q, q.applied)) return 1;
        if (!q.applied.empty()) {
            out_line("Now at patch " +
                     patch_path_display(q, q.applied.back()));
        } else {
            out_line("No patches applied");
        }
    }

    if (!remove_from_series(q, patch)) {
        err_line("Failed to write series file.");
        return 1;
    }

    // Optionally remove the patch file
    if (opt_remove) {
        std::string patch_file = path_join(q.work_dir, q.patches_dir, patch);
        if (opt_backup) {
            std::string backup = patch_file + "~";
            if (file_exists(patch_file) && !rename_path(patch_file, backup)) {
                err_line("Failed to rename " + patch_file + " to " + backup);
                return 1;
            }
        } else if (file_exists(patch_file) && !delete_file(patch_file)) {
            err_line("Failed to delete " + patch_file);
            return 1;
        }
    }

    out_line("Removed patch " + patch_path_display(q, patch));
    return 0;
}

int cmd_rename(QuiltState &q, int argc, char **argv) {
    auto args = parse_options(argc, argv, "P:h");
    if (!args) return 1;
    std::string_view old_arg;
    for (const auto &opt : args->options) {
        if (opt.key == 'h') return command_help(argv[0]);
        old_arg = opt.value;
    }
    if (std::ssize(args->operands) != 1) return usage_error(argv[0]);
    std::string new_name(strip_patches_prefix(q, args->operands[0]));

    // No -P, or an empty one, means the top patch
    auto found = find_patch_in_series(q, old_arg);
    if (!found) return 1;
    std::string old_patch = *found;

    // Like upstream, refuse a name in any use, so nothing is overwritten.
    // An empty name (from "" or "patches/") names the directories
    // themselves, so it is always in use.
    if (new_name.empty() || q.find_in_series(new_name) ||
        is_directory(pc_patch_dir(q, new_name)) ||
        file_exists(path_join(q.work_dir, q.patches_dir, new_name))) {
        err("Patch "); err(patch_path_display(q, new_name));
        err_line(" exists already, please choose a different name");
        return 1;
    }

    // Rename patch file
    std::string old_file = path_join(q.work_dir, q.patches_dir, old_patch);
    std::string new_file = path_join(q.work_dir, q.patches_dir, new_name);
    bool renamed_patch_file = false;
    if (file_exists(old_file)) {
        // Ensure target directory exists
        std::string new_dir = dirname(new_file);
        if (!is_directory(new_dir)) {
            if (!make_dirs(new_dir)) {
                err_line("Failed to create " + new_dir);
                return 1;
            }
        }
        if (!rename_path(old_file, new_file)) {
            err_line("Failed to rename " + old_file + " to " + new_file);
            return 1;
        }
        renamed_patch_file = true;
    }

    // If patch is applied: rename in applied-patches and .pc/ dir
    auto new_applied = q.applied;
    bool renamed_pc_dir = false;
    if (q.is_applied(old_patch)) {
        for (auto &a : new_applied) {
            if (a == old_patch) {
                a = new_name;
                break;
            }
        }
        std::string old_pc = pc_patch_dir(q, old_patch);
        std::string new_pc = pc_patch_dir(q, new_name);
        if (is_directory(old_pc)) {
            if (!rename_path(old_pc, new_pc)) {
                if (renamed_patch_file) {
                    rename_path(new_file, old_file);
                }
                err_line("Failed to rename " + old_pc + " to " + new_pc);
                return 1;
            }
            renamed_pc_dir = true;
        }
    }

    if (!rename_in_series(q, old_patch, new_name)) {
        err_line("Failed to write series file.");
        if (renamed_pc_dir) {
            rename_path(pc_patch_dir(q, new_name), pc_patch_dir(q, old_patch));
        }
        if (renamed_patch_file) {
            rename_path(new_file, old_file);
        }
        return 1;
    }

    if (q.is_applied(old_patch) && !write_applied_checked(q, new_applied)) {
        rename_in_series(q, new_name, old_patch);
        if (renamed_pc_dir) {
            rename_path(pc_patch_dir(q, new_name), pc_patch_dir(q, old_patch));
        }
        if (renamed_patch_file) {
            rename_path(new_file, old_file);
        }
        return 1;
    }

    if (q.is_applied(old_patch)) {
        q.applied = std::move(new_applied);
    }

    out("Patch "); out(patch_path_display(q, old_patch));
    out(" renamed to "); out_line(patch_path_display(q, new_name));
    return 0;
}

int cmd_import(QuiltState &q, int argc, char **argv) {
    std::string strip_arg;  // -p value, recorded verbatim in the series
    std::string target_name;
    bool force = false;
    char dup_mode = 0;  // -d: keep the o(ld), a(ll) or n(ew) header
    bool reversed = false;
    std::vector<std::string> patchfiles;

    auto args = parse_options(argc, argv, "P:d:fp:Rh");
    if (!args) return 1;
    for (const auto &opt : args->options) {
        switch (opt.key) {
        case 'P': target_name = strip_patches_prefix(q, opt.value); break;
        case 'p': strip_arg = opt.value; break;
        case 'R': reversed = true; break;
        case 'd':
            if (opt.value != "o" && opt.value != "a" && opt.value != "n") {
                return usage_error(argv[0]);
            }
            dup_mode = opt.value[0];
            break;
        case 'f': force = true; break;
        case 'h': return command_help(argv[0]);
        }
    }
    for (auto file : args->operands) patchfiles.emplace_back(file);

    // Like upstream, importing no patches does nothing
    if (patchfiles.empty()) return 0;

    if (!target_name.empty() && patchfiles.size() > 1) {
        err_line("Option `-P' can only be used when importing a single patch");
        return 1;
    }

    if (!ensure_pc_dir(q)) {
        return 1;
    }

    // Ensure patches dir exists
    std::string patches_abs = path_join(q.work_dir, q.patches_dir);
    if (!is_directory(patches_abs)) {
        if (!make_dirs(patches_abs)) {
            err_line("Failed to create " + patches_abs);
            return 1;
        }
    }

    // Like the original quilt, record -p as given (even -p1, or a value that
    // is not a number), and insert every patch in front of the same one,
    // keeping their order.
    std::string patch_args;
    if (!strip_arg.empty()) patch_args = "-p" + strip_arg;
    if (reversed) patch_args += patch_args.empty() ? "-R" : " -R";
    std::string before = q.patch_after_top();

    for (const auto &patchfile : patchfiles) {
        if (!file_exists(patchfile)) {
            err_line("Patch " + patchfile + " does not exist");
            return 1;
        }

        // Determine target name
        std::string name;
        if (!target_name.empty()) {
            name = target_name;
        } else {
            name = basename(patchfile);
        }

        std::string dest = path_join(q.work_dir, q.patches_dir, name);

        // Check if target exists in series
        auto existing = q.find_in_series(name);
        if (existing && q.is_applied(name)) {
            err_line("Patch " + patch_path_display(q, name) +
                     " is applied");
            return 1;
        }
        if (existing && !force) {
            err_line("Patch " + patch_path_display(q, name) +
                     " exists. Replace with -f.");
            return 1;
        }

        // Ensure parent directory of dest exists (for subdir patch names)
        std::string dest_dir = dirname(dest);
        if (!is_directory(dest_dir)) {
            if (!make_dirs(dest_dir)) {
                err_line("Failed to create " + dest_dir);
                return 1;
            }
        }

        // Copy patchfile to patches/<name>, merging the headers of a patch
        // it replaces unless -d n
        std::optional<std::string> merged;
        if (existing && dup_mode != 'n') {
            merged = merge_patches(read_file(dest), read_file(patchfile),
                                   dup_mode);
            if (!merged) return 1;
        }
        if (existing) {
            err_line("Replacing patch " + patch_path_display(q, name) +
                     " with new version");
        }
        if (merged ? !write_file(dest, *merged) : !copy_file(patchfile, dest)) {
            err_line("Failed to import patch " + patch_path_display(q, name));
            return 1;
        }

        // When replacing an existing patch the original quilt leaves the
        // series entry (and thus its -p/-R args) untouched.
        if (!existing && !insert_in_series(q, name, patch_args, before)) {
            err_line("Failed to write series file.");
            delete_file(dest);
            return 1;
        }

        if (!existing) {
            out_line("Importing patch " + patchfile +
                     " (stored as " + patch_path_display(q, name) + ")");
        }
    }

    return 0;
}

// Strip trailing spaces and tabs from each line of a header. Like upstream's
// sed -e 's:[ \t]*$::', this leaves a CR, and a missing final newline, alone.
static std::string strip_header_trailing_ws(std::string_view header) {
    std::string result;
    while (!header.empty()) {
        ptrdiff_t nl = str_find(header, '\n');
        ptrdiff_t len = nl < 0 ? std::ssize(header) : nl;
        std::string_view line = header.substr(0, checked_cast<size_t>(len));
        header.remove_prefix(checked_cast<size_t>(nl < 0 ? len : len + 1));
        while (!line.empty() && (line.back() == ' ' || line.back() == '\t'))
            line.remove_suffix(1);
        result += line;
        if (nl >= 0) result += '\n';
    }
    return result;
}

static constexpr const char *dep3_template =
    "Description: <short summary>\n"
    " <long description that can span multiple lines>\n"
    "Author: \n"
    "Origin: <upstream|backport|vendor|other>, <URL>\n"
    "Bug: <URL to upstream bug report>\n"
    "Bug-Debian: https://bugs.debian.org/<bugnumber>\n"
    "Forwarded: <URL|no|not-needed>\n"
    "Applied-Upstream: <version|URL|commit>\n"
    "Last-Update: <YYYY-MM-DD>\n";

int cmd_header(QuiltState &q, int argc, char **argv) {
    enum Mode { PRINT, APPEND, REPLACE, EDIT };
    Mode mode = PRINT;
    bool opt_backup = false;
    bool opt_dep3 = false;
    bool opt_strip_ds = false;
    bool opt_strip_ws = false;
    bool mode_conflict = false;
    // Repeating a mode is fine; combining different modes is not.
    auto set_mode = [&](Mode m) {
        if (mode != PRINT && mode != m) mode_conflict = true;
        mode = m;
    };

    enum { BACKUP = 256, STRIP_TRAILING_WHITESPACE, STRIP_DIFFSTAT, DEP3 };
    static constexpr LongOpt longopts[] = {
        {"backup", OptArg::none, BACKUP},
        {"strip-trailing-whitespace", OptArg::none, STRIP_TRAILING_WHITESPACE},
        {"strip-diffstat", OptArg::none, STRIP_DIFFSTAT},
        {"dep3", OptArg::none, DEP3, true},
    };
    auto args = parse_options(argc, argv, "areh", longopts);
    if (!args) return 1;
    for (const auto &opt : args->options) {
        switch (opt.key) {
        case 'a': set_mode(APPEND); break;
        case 'r': set_mode(REPLACE); break;
        case 'e': set_mode(EDIT); break;
        case BACKUP: opt_backup = true; break;
        case STRIP_DIFFSTAT: opt_strip_ds = true; break;
        case STRIP_TRAILING_WHITESPACE: opt_strip_ws = true; break;
        case DEP3: opt_dep3 = true; break;
        case 'h': return command_help(argv[0]);
        }
    }

    if (mode_conflict || std::ssize(args->operands) > 1) return usage_error(argv[0]);
    std::string_view patch_arg;
    if (!args->operands.empty()) patch_arg = args->operands[0];

    // No argument, or an empty one, means the top patch
    auto found = find_patch_in_series(q, patch_arg);
    if (!found) return 1;
    std::string patch = *found;

    std::string patch_file = path_join(q.work_dir, q.patches_dir, patch);
    std::string content = read_file(patch_file);

    // Helper to apply --strip-diffstat and --strip-trailing-whitespace
    auto apply_strip = [&](std::string h) {
        if (opt_strip_ds) h = strip_diffstat(h);
        if (opt_strip_ws) h = strip_header_trailing_ws(h);
        return h;
    };

    // Like upstream, end the new header with a newline (unless it ends with
    // a CR) before the strip options apply, then append the patch body.
    auto write_header = [&](std::string h) {
        if (!h.empty() && h.back() != '\n' && h.back() != '\r') h += '\n';
        if (opt_backup) {
            copy_file(patch_file, patch_file + "~");
        }
        write_file(patch_file, apply_strip(std::move(h)) + patch_body(content));
    };

    if (mode == PRINT) {
        std::string header = apply_strip(patch_header(content));
        out(header);
        return 0;
    }

    if (mode == APPEND) {
        std::string stdin_data = read_stdin();
        write_header(patch_header(content) + stdin_data);
        out_line("Appended text to header of patch " +
                 patch_path_display(q, patch));
        return 0;
    }

    if (mode == REPLACE) {
        write_header(read_stdin());
        out_line("Replaced header of patch " +
                 patch_path_display(q, patch));
        return 0;
    }

    if (mode == EDIT) {
        std::string editor = get_env("EDITOR");
        if (editor.empty()) editor = "vi";

        std::string header = patch_header(content);
        // Insert DEP-3 template if header is empty and --dep3 given
        if (opt_dep3 && trim(header).empty()) {
            header = dep3_template;
        }
        std::string tmp_file = path_join(q.work_dir, ".pc/.quilt_header_tmp");
        write_file(tmp_file, header);

        int rc = run_cmd_tty({editor, tmp_file});
        if (rc != 0) {
            delete_file(tmp_file);
            err_line("Editor exited with error");
            return 1;
        }

        std::string new_header = read_file(tmp_file);
        delete_file(tmp_file);

        write_header(std::move(new_header));
        out_line("Replaced header of patch " + patch_path_display(q, patch));
        return 0;
    }

    return 0;
}

int cmd_files(QuiltState &q, int argc, char **argv) {
    bool opt_verbose = false;
    bool opt_all = false;
    bool opt_labels = false;
    std::optional<std::string_view> combine_arg;

    enum { COMBINE = 256 };
    static constexpr LongOpt longopts[] = {
        {"combine", OptArg::required, COMBINE},
    };
    auto args = parse_options(argc, argv, "vhal", longopts);
    if (!args) return 1;
    for (const auto &opt : args->options) {
        switch (opt.key) {
        case 'v': opt_verbose = true; break;
        case 'a': opt_all = true; break;
        case 'l': opt_labels = true; break;
        case 'h': return command_help(argv[0]);
        case COMBINE: combine_arg = opt.value; break;
        }
    }
    if (std::ssize(args->operands) > 1) return usage_error(argv[0]);
    std::string_view patch_arg;
    if (!args->operands.empty()) patch_arg = args->operands[0];

    // Like upstream, resolve --combine first. Both "-" and an empty name
    // stand for the first applied patch, resolved below.
    std::string combine_start;
    if (combine_arg && !combine_arg->empty() && *combine_arg != "-") {
        auto found = find_patch(q, *combine_arg);
        if (!found) return 1;
        combine_start = *found;
    }

    // No argument, or an empty one, means the top patch
    auto found = find_patch_in_series(q, patch_arg);
    if (!found) return 1;
    std::string target_patch = *found;

    // Like upstream, --combine implies -a, and -a lists every patch in the
    // series from the first applied (or the --combine patch) through the
    // target, each on its own
    if (combine_arg) opt_all = true;
    std::vector<std::string> patches_to_show;
    if (opt_all) {
        std::string first = combine_start;
        if (first.empty() && !q.applied.empty()) first = q.applied.front();
        auto last = q.find_in_series(target_patch);
        ptrdiff_t start = -1;
        for (ptrdiff_t i = 0; last && i <= *last; ++i) {
            if (q.series[checked_cast<size_t>(i)] == first) { start = i; break; }
        }
        if (start < 0) {
            err_line("Patch " + format_patch(q, first) + " not applied before patch " +
                     format_patch(q, target_patch));
            return 1;
        }
        for (ptrdiff_t i = start; i <= *last; ++i) {
            patches_to_show.push_back(q.series[checked_cast<size_t>(i)]);
        }
    } else {
        patches_to_show.push_back(target_patch);
    }

    auto nonempty = [](const std::string &path) {
        return file_exists(path) && !read_file(path).empty();
    };
    bool use_status = opt_verbose && !opt_labels;
    for (const auto &patch : patches_to_show) {
        if (opt_all && use_status) out_line(patch);
        std::vector<std::string> file_list = q.is_applied(patch)
            ? files_in_patch(q, patch)
            : unapplied_patch_files(q, patch);
        std::ranges::sort(file_list);
        for (const auto &f : file_list) {
            std::string line;
            if (opt_labels) line = opt_verbose ? "[" + patch + "] " : patch + " ";
            if (use_status) {
                // Like upstream: - for a file the patch removes, + for one
                // it adds, judged by which side is empty or missing
                char status = ' ';
                bool backup = nonempty(path_join(pc_patch_dir(q, patch), f));
                bool current = nonempty(path_join(q.work_dir, f));
                if (backup && !current) status = '-';
                else if (!backup && current) status = '+';
                line += status;
                line += ' ';
            }
            out_line(line + f);
        }
    }

    return 0;
}

int cmd_patches(QuiltState &q, int argc, char **argv) {
    bool opt_verbose = false;
    enum { COLOR = 256 };
    static constexpr LongOpt longopts[] = {
        {"color", OptArg::optional, COLOR},
    };
    auto args = parse_options(argc, argv, "vh", longopts);
    if (!args) return 1;
    for (const auto &opt : args->options) {
        switch (opt.key) {
        case 'v': opt_verbose = true; break;
        case COLOR:
            if (!valid_color_value(opt.value)) return usage_error(argv[0]);
            break;
        case 'h': return command_help(argv[0]);
        }
    }
    if (args->operands.empty()) return usage_error(argv[0]);
    std::vector<std::string> target_files;
    for (auto file : args->operands) target_files.push_back(subdir_path(q, file));

    for (const auto &patch : q.series) {
        bool touches = false;

        if (q.is_applied(patch)) {
            // Check .pc/<patch>/<file>
            std::string pc_dir = pc_patch_dir(q, patch);
            for (const auto &tf : target_files) {
                std::string check = path_join(pc_dir, tf);
                if (file_exists(check)) {
                    touches = true;
                    break;
                }
            }
        } else {
            // Parse patch file for references
            auto patched_files = unapplied_patch_files(q, patch);
            for (const auto &tf : target_files) {
                for (const auto &pf : patched_files) {
                    if (pf == tf) {
                        touches = true;
                        break;
                    }
                }
                if (touches) break;
            }
        }

        if (touches) {
            std::string display = patch;
            if (opt_verbose) {
                // Show applied status: = for top, + for other applied, space for unapplied
                if (!q.applied.empty() && patch == q.applied.back()) {
                    out_line("= " + display);
                } else if (q.is_applied(patch)) {
                    out_line("+ " + display);
                } else {
                    out_line("  " + display);
                }
            } else {
                out_line(display);
            }
        }
    }

    return 0;
}

int cmd_fold(QuiltState &q, int argc, char **argv) {
    bool opt_reverse = false;
    bool opt_quiet = false;
    bool opt_force = false;
    std::string_view strip_arg;

    auto args = parse_options(argc, argv, "Rp:qfh");
    if (!args) return 1;
    for (const auto &opt : args->options) {
        switch (opt.key) {
        case 'R': opt_reverse = true; break;
        case 'f': opt_force = true; break;
        case 'p': strip_arg = opt.value; break;
        case 'q': opt_quiet = true; break;
        case 'h': return command_help(argv[0]);
        }
    }
    if (!args->operands.empty()) return usage_error(argv[0]);

    if (q.applied.empty()) {
        err_line("No patches applied");
        return 1;
    }

    std::string top = q.applied.back();
    std::string stdin_data = read_stdin();

    if (stdin_data.empty()) {
        return 0;
    }

    // Apply patch using built-in patch engine
    PatchOptions patch_opts;
    // Like upstream, an empty -p means the default, 1, and patch checks the
    // rest, refusing a strip level that is not a number
    if (!strip_arg.empty()) set_strip_option(patch_opts, strip_arg);
    patch_opts.reverse = opt_reverse;
    patch_opts.quiet = opt_quiet;
    auto extra_patch_opts = shell_split(get_env("QUILT_PATCH_OPTS"));
    for (const auto &opt : extra_patch_opts) {
        std::string_view o = opt;
        if (o == "-R") patch_opts.reverse = true;
        else if (o == "-s") patch_opts.quiet = true;
        else if (o == "-E") patch_opts.remove_empty = true;
        else if (o.starts_with("--fuzz=")) set_fuzz_option(patch_opts, o.substr(7));
    }

    // Like upstream's "patch -d $SUBDIR", file names in the patch are
    // relative to the subdirectory quilt was run from
    std::string patch_dir = path_join(q.work_dir, q.subdir);
    if (!set_cwd(patch_dir)) {
        err_line("Cannot change into directory " + patch_dir);
        return 1;
    }

    // Track new files in the current patch, including deletions. Snapshot
    // every target file so that a failed fold can be undone: backups of
    // files the top patch already tracks predate the top patch, not the fold.
    struct Snapshot {
        std::string file;
        bool existed;
        std::string content;
        bool added;  // backed up into the top patch by this fold
    };
    std::vector<Snapshot> snapshots;
    auto affected_files = patch_target_files(stdin_data, patch_opts.strip_level,
                                             patch_opts.reverse);
    auto currently_tracked = files_in_patch(q, top);
    auto is_tracked = [&](const std::string &f) {
        return std::ranges::find(currently_tracked, f) != currently_tracked.end();
    };
    for (auto &f : affected_files) {
        f = subdir_path(q, f);
        std::string path = path_join(q.work_dir, f);
        Snapshot s{f, file_exists(path), {}, !is_tracked(f)};
        if (s.existed) s.content = read_file(path);
        if (s.added) backup_file(q, top, f);
        snapshots.push_back(std::move(s));
    }

    PatchResult r = builtin_patch(stdin_data, patch_opts);
    set_cwd(q.work_dir);

    // GNU patch backs up only the files it patches, so leave the missing
    // files it skipped out of the patch
    for (const auto &skipped : r.skipped) {
        std::string f = subdir_path(q, skipped);
        if (!is_tracked(f)) {
            delete_file(path_join(pc_patch_dir(q, top), f));
        }
    }
    out(r.out);
    err(r.err);

    if (r.exit_code != 0 && !opt_force) {
        // Like upstream, restore the pre-fold state and drop the backups
        // this fold added. Reject files stay behind.
        std::string pc_dir = pc_patch_dir(q, top);
        for (const auto &s : snapshots) {
            std::string path = path_join(q.work_dir, s.file);
            bool exists = file_exists(path);
            if (exists != s.existed || (exists && read_file(path) != s.content)) {
                bool ok;
                if (s.existed) {
                    std::string dir = dirname(path);
                    ok = (is_directory(dir) || make_dirs(dir)) &&
                         write_file(path, s.content);
                } else {
                    ok = delete_file(path);
                }
                if (!ok) {
                    err("File "); err(s.file); err_line(" may be corrupted");
                }
            }
            if (s.added) {
                std::string backup = path_join(pc_dir, s.file);
                delete_file(backup);
                for (std::string dir = dirname(backup);
                     std::ssize(dir) > std::ssize(pc_dir); dir = dirname(dir)) {
                    if (!delete_dir(dir)) break;
                }
            }
        }
        return 1;
    }

    return 0;
}

int cmd_fork(QuiltState &q, int argc, char **argv) {
    auto args = parse_options(argc, argv, "h");
    if (!args) return 1;
    if (!args->options.empty()) return command_help(argv[0]);
    if (std::ssize(args->operands) > 1) return usage_error(argv[0]);
    std::optional<std::string> given_name;
    if (!args->operands.empty()) given_name = strip_patches_prefix(q, args->operands[0]);

    auto top = find_top_patch(q);
    if (!top) return 1;
    std::string old_name = *top;

    // An empty name, given as "" or as "patches/", is refused below since
    // .pc/ itself exists, as upstream does
    std::string new_name = given_name ? *given_name : next_filename(old_name);

    // Like upstream, refuse a name in any use, so nothing is overwritten
    if (q.find_in_series(new_name) || is_directory(pc_patch_dir(q, new_name)) ||
        file_exists(path_join(q.work_dir, q.patches_dir, new_name))) {
        err("Patch "); err(patch_path_display(q, new_name));
        err_line(" exists already, please choose a new name");
        return 1;
    }

    // Copy patch file
    std::string old_file = path_join(q.work_dir, q.patches_dir, old_name);
    std::string new_file = path_join(q.work_dir, q.patches_dir, new_name);
    bool copied_patch_file = false;
    if (file_exists(old_file)) {
        std::string new_dir = dirname(new_file);
        if (!is_directory(new_dir)) {
            if (!make_dirs(new_dir)) {
                err_line("Failed to create " + new_dir);
                return 1;
            }
        }
        if (!copy_file(old_file, new_file)) {
            err_line("Failed to copy " + old_file + " to " + new_file);
            return 1;
        }
        copied_patch_file = true;
    }

    // Rename .pc/ directory
    std::string old_pc = pc_patch_dir(q, old_name);
    std::string new_pc = pc_patch_dir(q, new_name);
    bool renamed_pc_dir = false;
    if (is_directory(old_pc)) {
        if (!rename_path(old_pc, new_pc)) {
            if (copied_patch_file) {
                delete_file(new_file);
            }
            err_line("Failed to rename " + old_pc + " to " + new_pc);
            return 1;
        }
        renamed_pc_dir = true;
    }

    if (!rename_in_series(q, old_name, new_name)) {
        err_line("Failed to write series file.");
        if (renamed_pc_dir) {
            rename_path(new_pc, old_pc);
        }
        if (copied_patch_file) {
            delete_file(new_file);
        }
        return 1;
    }

    auto new_applied = q.applied;
    for (auto &a : new_applied) {
        if (a == old_name) {
            a = new_name;
            break;
        }
    }
    if (!write_applied_checked(q, new_applied)) {
        rename_in_series(q, new_name, old_name);
        if (renamed_pc_dir) {
            rename_path(new_pc, old_pc);
        }
        if (copied_patch_file) {
            delete_file(new_file);
        }
        return 1;
    }

    q.applied = std::move(new_applied);

    out_line("Fork of patch " + patch_path_display(q, old_name) +
             " created as " + patch_path_display(q, new_name));
    return 0;
}

int cmd_upgrade(QuiltState &, int argc, char **argv)
{
    // Like upstream, take one argument, which means nothing
    auto args = parse_options(argc, argv, "h");
    if (!args) return 1;
    if (!args->options.empty()) return command_help(argv[0]);
    if (std::ssize(args->operands) > 1) return usage_error(argv[0]);
    return 0;
}
