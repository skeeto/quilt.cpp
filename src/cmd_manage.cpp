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

static std::string extract_header(std::string_view content) {
    std::string header;
    auto lines = split_lines(content);
    for (const auto &line : lines) {
        if (line.starts_with("Index:") ||
            line.starts_with("--- ") ||
            line.starts_with("diff ") ||
            line.starts_with("===")) {
            break;
        }
        header += line;
        header += '\n';
    }
    return header;
}

static std::string replace_header(std::string_view content, std::string_view new_header) {
    std::string result;
    auto lines = split_lines(content);
    bool in_diff = false;
    // Find where diffs start
    ptrdiff_t diff_start = 0;
    for (ptrdiff_t i = 0; i < std::ssize(lines); ++i) {
        if (lines[checked_cast<size_t>(i)].starts_with("Index:") ||
            lines[checked_cast<size_t>(i)].starts_with("--- ") ||
            lines[checked_cast<size_t>(i)].starts_with("diff ") ||
            lines[checked_cast<size_t>(i)].starts_with("===")) {
            diff_start = i;
            in_diff = true;
            break;
        }
    }

    result += std::string(new_header);
    // Ensure header ends with newline if non-empty
    if (!result.empty() && result.back() != '\n') {
        result += '\n';
    }

    if (in_diff) {
        for (ptrdiff_t i = diff_start; i < std::ssize(lines); ++i) {
            result += lines[checked_cast<size_t>(i)];
            result += '\n';
        }
    }
    return result;
}


int cmd_delete(QuiltState &q, int argc, char **argv) {
    bool opt_remove = false;
    bool opt_backup = false;
    bool opt_next = false;
    std::string_view patch_arg;
    int positional_count = 0;

    for (int i = 1; i < argc; ++i) {
        std::string_view arg = argv[i];
        if (arg == "-r") {
            opt_remove = true;
        } else if (arg == "--backup") {
            opt_backup = true;
        } else if (arg == "-n") {
            opt_next = true;
        } else if (arg.starts_with('-')) {
            err("Unrecognized option: "); err_line(arg);
            return 1;
        } else {
            patch_arg = strip_patches_prefix(q, arg);
            ++positional_count;
        }
    }

    std::string patch;
    if (positional_count > 1 || (opt_next && positional_count > 0)) {
        err_line("Usage: quilt delete [-r] [--backup] [patch|-n]");
        return 1;
    }
    if (!patch_arg.empty()) {
        patch = patch_arg;
    } else if (opt_next) {
        // Next unapplied patch
        ptrdiff_t top_idx = q.top_index();
        ptrdiff_t next_idx = top_idx + 1;
        if (next_idx >= std::ssize(q.series)) {
            err_line("No next patch");
            return 1;
        }
        patch = q.series[checked_cast<size_t>(next_idx)];
    } else {
        // Topmost applied patch
        if (q.applied.empty()) {
            err_line("No patches applied");
            return 1;
        }
        patch = q.applied.back();
    }

    // Verify patch is in series
    auto idx = q.find_in_series(patch);
    if (!idx) {
        err("Patch "); err(patch); err_line(" is not in series");
        return 1;
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
    std::string old_patch;
    std::string new_name;

    for (int i = 1; i < argc; ++i) {
        std::string_view arg = argv[i];
        if (arg == "-P" && i + 1 < argc) {
            old_patch = strip_patches_prefix(q, argv[++i]);
        } else if (arg[0] == '-') {
            err("Unrecognized option: "); err_line(arg);
            return 1;
        } else {
            new_name = strip_patches_prefix(q, arg);
        }
    }

    // Default to top patch
    if (old_patch.empty()) {
        if (q.applied.empty()) {
            err_line("No patches applied");
            return 1;
        }
        old_patch = q.applied.back();
    }

    if (new_name.empty()) {
        err_line("Usage: quilt rename [-P patch] new_name");
        return 1;
    }

    // Verify old patch exists in series
    auto idx = q.find_in_series(old_patch);
    if (!idx) {
        err("Patch "); err(old_patch); err_line(" is not in series");
        return 1;
    }

    // Verify new name doesn't exist in series
    auto new_idx = q.find_in_series(new_name);
    if (new_idx) {
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
    char dup_mode = 0;  // o=overwrite, a=append, n=next
    bool reversed = false;
    std::vector<std::string> patchfiles;

    constexpr std::string_view usage =
        "Usage: quilt import [-p num] [-R] [-P patch] [-f] [-d {o|a|n}] patchfile ...";

    // Parse like getopt(1) with "P:d:fp:Rh": options may be grouped (-fR),
    // take a value attached or as the next word (-p0, -p 0), and may follow
    // patch files. "--" ends the options.
    bool options_done = false;
    for (int i = 1; i < argc; ++i) {
        std::string_view arg = argv[i];
        if (options_done || std::ssize(arg) < 2 || arg[0] != '-') {
            patchfiles.emplace_back(arg);
            continue;
        }
        if (arg == "--") {
            options_done = true;
            continue;
        }
        for (ptrdiff_t j = 1; j < std::ssize(arg); ++j) {
            char opt = arg[checked_cast<size_t>(j)];
            if (opt == 'f') {
                force = true;
            } else if (opt == 'R') {
                reversed = true;
            } else if (opt == 'p' || opt == 'P' || opt == 'd') {
                std::string_view value;
                if (j + 1 < std::ssize(arg)) {
                    value = arg.substr(checked_cast<size_t>(j + 1));
                } else if (i + 1 < argc) {
                    value = argv[++i];
                } else {
                    err_line(usage);
                    return 1;
                }
                if (opt == 'p') {
                    strip_arg = value;
                } else if (opt == 'P') {
                    target_name = strip_patches_prefix(q, value);
                } else if (value == "o" || value == "a" || value == "n") {
                    dup_mode = value[0];
                } else {
                    err_line(usage);
                    return 1;
                }
                break;
            } else {
                err("Unrecognized option: "); err_line(arg);
                return 1;
            }
        }
    }

    if (patchfiles.empty()) {
        err_line(usage);
        return 1;
    }

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

        // Copy patchfile to patches/<name>, handling -d header mode
        if (existing && force && dup_mode && dup_mode != 'n') {
            // Merge headers based on -d mode
            std::string old_content = read_file(dest);
            std::string new_content = read_file(patchfile);
            std::string old_hdr = extract_header(old_content);
            std::string new_hdr = extract_header(new_content);
            std::string merged_header;
            if (dup_mode == 'o') {
                merged_header = old_hdr;
            } else if (dup_mode == 'a') {
                merged_header = old_hdr;
                if (!merged_header.empty() && merged_header.back() != '\n')
                    merged_header += '\n';
                merged_header += "---\n";
                merged_header += new_hdr;
            }
            std::string result = replace_header(new_content, merged_header);
            if (!write_file(dest, result)) {
                err_line("Failed to write " + dest);
                return 1;
            }
        } else if (existing && force && !dup_mode) {
            // Both patches exist and no -d flag: check if both have headers
            std::string old_content = read_file(dest);
            std::string new_content = read_file(patchfile);
            std::string old_hdr = extract_header(old_content);
            std::string new_hdr = extract_header(new_content);
            if (!old_hdr.empty() && !new_hdr.empty() && old_hdr != new_hdr) {
                err_line("Patch headers differ:");
                err_line("@@ -1 +1 @@");
                err_line("-" + old_hdr);
                err_line("+" + new_hdr);
                err_line("Please use -d {o|a|n} to specify which patch "
                         "header(s) to keep.");
                return 1;
            }
            if (!copy_file(patchfile, dest)) {
                err_line("Failed to copy " + patchfile + " to " + dest);
                return 1;
            }
        } else {
            if (!copy_file(patchfile, dest)) {
                err_line("Failed to copy " + patchfile + " to " + dest);
                return 1;
            }
        }

        // When replacing an existing patch the original quilt leaves the
        // series entry (and thus its -p/-R args) untouched.
        if (!existing && !insert_in_series(q, name, patch_args, before)) {
            err_line("Failed to write series file.");
            delete_file(dest);
            return 1;
        }

        if (existing && force) {
            out_line("Replacing patch " + patch_path_display(q, name) +
                     " with new version");
        } else {
            out_line("Importing patch " + patchfile +
                     " (stored as " + patch_path_display(q, name) + ")");
        }
    }

    return 0;
}

// Remove an existing diffstat section from a header.
// Detects "---" separator followed by " file | N ++--" lines ending
// with a "N file(s) changed" summary line.
static std::string strip_diffstat(std::string_view header) {
    auto lines = split_lines(header);
    std::string result;
    for (ptrdiff_t i = 0; i < std::ssize(lines); ++i) {
        const auto &line = lines[checked_cast<size_t>(i)];

        // Detect "---" separator followed by diffstat, or bare diffstat
        ptrdiff_t ds_start = i;
        if (line == "---" && i + 1 < std::ssize(lines)) {
            ds_start = i + 1;
        }

        const auto &first = lines[checked_cast<size_t>(ds_start)];
        if (!first.empty() && first[0] == ' ' &&
            str_find(first, '|') >= 0) {
            bool found_summary = false;
            ptrdiff_t summary_end = -1;
            for (ptrdiff_t j = ds_start; j < std::ssize(lines); ++j) {
                const auto &l = lines[checked_cast<size_t>(j)];
                if (l.find("changed") != std::string::npos &&
                    l.find("file") != std::string::npos) {
                    found_summary = true;
                    summary_end = j;
                    break;
                }
                if (l.empty() || (l[0] != ' ' && str_find(l, '|') < 0))
                    break;
            }
            if (found_summary) {
                // Keep the "---" separator if the diffstat followed it
                if (ds_start != i) {
                    result += line;
                    result += '\n';
                }
                i = summary_end;
                if (i + 1 < std::ssize(lines) && lines[checked_cast<size_t>(i + 1)].empty())
                    i++;
                continue;
            }
        }
        result += line;
        result += '\n';
    }
    return result;
}

// Strip trailing whitespace from each line of a header.
static std::string strip_header_trailing_ws(std::string_view header) {
    std::string result;
    auto lines = split_lines(header);
    for (const auto &line : lines) {
        if (line.empty()) {
            result += '\n';
            continue;
        }
        // Strip \r from CRLF before checking for trailing whitespace
        std::string_view l = line;
        if (!l.empty() && l.back() == '\r') l.remove_suffix(1);
        auto end = l.find_last_not_of(" \t");
        if (end == std::string::npos) {
            result += '\n';
        } else {
            result += l.substr(0, end + 1);
            result += '\n';
        }
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
    std::string_view patch_arg;
    bool mode_conflict = false;
    int positional_count = 0;
    // Repeating a mode is fine; combining different modes is not.
    auto set_mode = [&](Mode m) {
        if (mode != PRINT && mode != m) mode_conflict = true;
        mode = m;
    };

    for (int i = 1; i < argc; ++i) {
        std::string_view arg = argv[i];
        if (arg == "-a") {
            set_mode(APPEND);
        } else if (arg == "-r") {
            set_mode(REPLACE);
        } else if (arg == "-e") {
            set_mode(EDIT);
        } else if (arg == "--backup") {
            opt_backup = true;
        } else if (arg == "--dep3") {
            opt_dep3 = true;
        } else if (arg == "--strip-diffstat") {
            opt_strip_ds = true;
        } else if (arg == "--strip-trailing-whitespace") {
            opt_strip_ws = true;
        } else if (arg[0] == '-') {
            err("Unrecognized option: "); err_line(arg);
            return 1;
        } else {
            patch_arg = strip_patches_prefix(q, arg);
            ++positional_count;
        }
    }

    if (mode_conflict || positional_count > 1) {
        err_line("Usage: quilt header [-a|-r|-e] [--backup] [--strip-diffstat] [--strip-trailing-whitespace] [patch]");
        return 1;
    }

    // Determine patch
    std::string_view patch;
    if (!patch_arg.empty()) {
        patch = patch_arg;
        // Verify patch is in series
        if (!q.find_in_series(patch)) {
            err("Patch "); err(patch);
            err_line(" is not in series");
            return 1;
        }
    } else if (!q.applied.empty()) {
        patch = q.applied.back();
    } else {
        err_line("No patches applied");
        return 1;
    }

    std::string patch_file = path_join(q.work_dir, q.patches_dir, patch);
    std::string content = read_file(patch_file);

    // Helper to apply --strip-diffstat and --strip-trailing-whitespace
    auto apply_strip = [&](std::string h) {
        if (opt_strip_ds) h = strip_diffstat(h);
        if (opt_strip_ws) h = strip_header_trailing_ws(h);
        return h;
    };

    if (mode == PRINT) {
        std::string header = apply_strip(extract_header(content));
        out(header);
        return 0;
    }

    if (mode == APPEND) {
        std::string stdin_data = read_stdin();
        std::string old_header = extract_header(content);
        std::string new_header = apply_strip(old_header + stdin_data);
        if (opt_backup) {
            copy_file(patch_file, patch_file + "~");
        }
        std::string new_content = replace_header(content, new_header);
        write_file(patch_file, new_content);
        out_line("Appended text to header of patch " +
                 patch_path_display(q, patch));
        return 0;
    }

    if (mode == REPLACE) {
        std::string stdin_data = read_stdin();
        std::string new_header = apply_strip(stdin_data);
        if (opt_backup) {
            copy_file(patch_file, patch_file + "~");
        }
        std::string new_content = replace_header(content, new_header);
        write_file(patch_file, new_content);
        out_line("Replaced header of patch " +
                 patch_path_display(q, patch));
        return 0;
    }

    if (mode == EDIT) {
        std::string editor = get_env("EDITOR");
        if (editor.empty()) editor = "vi";

        std::string header = extract_header(content);
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

        std::string new_header = apply_strip(read_file(tmp_file));
        delete_file(tmp_file);

        if (opt_backup) {
            copy_file(patch_file, patch_file + "~");
        }
        std::string new_content = replace_header(content, new_header);
        write_file(patch_file, new_content);
        out_line("Replaced header of patch " + patch_path_display(q, patch));
        return 0;
    }

    return 0;
}

int cmd_files(QuiltState &q, int argc, char **argv) {
    bool opt_verbose = false;
    bool opt_all = false;
    bool opt_labels = false;
    std::string combine_patch;
    std::string_view patch_arg;

    for (int i = 1; i < argc; ++i) {
        std::string_view arg = argv[i];
        if (arg == "-v") {
            opt_verbose = true;
        } else if (arg == "-a") {
            opt_all = true;
        } else if (arg == "-l") {
            opt_labels = true;
        } else if (arg == "--combine" && i + 1 < argc) {
            combine_patch = argv[++i];
        } else if (arg[0] == '-') {
            err("Unrecognized option: "); err_line(arg);
            return 1;
        } else {
            patch_arg = strip_patches_prefix(q, arg);
        }
    }

    // Determine target patch (topmost or specified)
    std::string target_patch;
    if (!patch_arg.empty()) {
        target_patch = patch_arg;
    } else if (!q.applied.empty()) {
        target_patch = q.applied.back();
    } else {
        if (!q.series_file_exists) {
            err_line("No series file found");
        } else if (q.series.empty()) {
            err_line("No patches in series");
        } else {
            err_line("No patches applied");
        }
        return 1;
    }

    // Build list of patches to show files for
    std::vector<std::string> patches_to_show;
    if (opt_all) {
        patches_to_show = q.applied;
    } else if (!combine_patch.empty()) {
        // Range from combine_patch through target_patch
        std::string start = combine_patch;
        if (start == "-") {
            if (q.applied.empty()) {
                err_line("No patches applied");
                return 1;
            }
            start = q.applied.front();
        } else {
            start = strip_patches_prefix(q, start);
        }
        bool in_range = false;
        for (const auto &a : q.applied) {
            if (a == start) in_range = true;
            if (in_range) patches_to_show.push_back(a);
            if (a == target_patch) break;
        }
        if (!in_range || patches_to_show.empty()) {
            err("Patch ");
            err(start);
            err_line(" not applied");
            return 1;
        }
    } else {
        patches_to_show.push_back(target_patch);
    }

    // files -a <patch> with nothing applied
    if (patches_to_show.empty()) {
        err_line("No patches applied");
        return 1;
    }

    // With labels (-l): iterate patches, output per-patch file listings
    if (opt_labels) {
        for (const auto &patch : patches_to_show) {
            std::vector<std::string> file_list;
            if (q.is_applied(patch)) {
                file_list = files_in_patch(q, patch);
            } else {
                file_list = unapplied_patch_files(q, patch);
            }
            std::ranges::sort(file_list);
            for (const auto &f : file_list) {
                out_line(patch + " " + f);
            }
        }
    } else {
        // Collect all files across patches
        std::vector<std::string> all_files;
        for (const auto &patch : patches_to_show) {
            std::vector<std::string> file_list;
            if (q.is_applied(patch)) {
                file_list = files_in_patch(q, patch);
            } else {
                file_list = unapplied_patch_files(q, patch);
            }
            for (auto &f : file_list) {
                all_files.push_back(std::move(f));
            }
        }
        std::ranges::sort(all_files);
        for (const auto &f : all_files) {
            if (opt_verbose) {
                out_line("  " + f);
            } else {
                out_line(f);
            }
        }
    }

    return 0;
}

int cmd_patches(QuiltState &q, int argc, char **argv) {
    bool opt_verbose = false;
    std::vector<std::string> target_files;

    for (int i = 1; i < argc; ++i) {
        std::string_view arg = argv[i];
        if (arg == "-v") {
            opt_verbose = true;
        } else if (arg == "--color" || arg.starts_with("--color=")) {
            if (arg.starts_with("--color=")) {
                auto val = arg.substr(8);
                if (val != "always" && val != "auto" && val != "never") {
                    err("Invalid --color value: "); err_line(val);
                    return 1;
                }
            }
        } else if (arg[0] == '-') {
            err("Unrecognized option: "); err_line(arg);
            return 1;
        } else {
            target_files.push_back(subdir_path(q, arg));
        }
    }

    if (target_files.empty()) {
        err_line("Usage: quilt patches [-v] [--color] file [files...]");
        return 1;
    }

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
    int strip_level = 1;

    for (int i = 1; i < argc; ++i) {
        std::string_view arg = argv[i];
        if (arg == "-R") {
            opt_reverse = true;
        } else if (arg == "-q") {
            opt_quiet = true;
        } else if (arg == "-f") {
            opt_force = true;
        } else if (arg == "-p" && i + 1 < argc) {
            strip_level = checked_cast<int>(parse_int(argv[++i]));
        } else if (arg.starts_with("-p") && arg.size() > 2 &&
                   arg[2] >= '0' && arg[2] <= '9') {
            strip_level = checked_cast<int>(parse_int(arg.substr(2)));
        } else if (arg[0] == '-') {
            err("Unrecognized option: "); err_line(arg);
            return 1;
        }
    }

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
    patch_opts.strip_level = strip_level;
    patch_opts.reverse = opt_reverse;
    patch_opts.quiet = opt_quiet;
    auto extra_patch_opts = shell_split(get_env("QUILT_PATCH_OPTS"));
    for (const auto &opt : extra_patch_opts) {
        std::string_view o = opt;
        if (o == "-R") patch_opts.reverse = true;
        else if (o == "-s") patch_opts.quiet = true;
        else if (o == "-E") patch_opts.remove_empty = true;
        else if (o.starts_with("--fuzz=")) {
            patch_opts.fuzz = checked_cast<int>(parse_int(o.substr(7)));
        }
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
    if (q.applied.empty()) {
        err_line("No patches applied");
        return 1;
    }

    std::string old_name = q.applied.back();
    std::string new_name;

    for (int i = 1; i < argc; ++i) {
        std::string_view arg = argv[i];
        if (arg[0] == '-') {
            err("Unrecognized option: "); err_line(arg);
            return 1;
        }
        new_name = strip_patches_prefix(q, arg);
        break;
    }

    if (new_name.empty()) {
        new_name = next_filename(old_name);
    }

    // Check that the new name doesn't already exist in series
    if (q.find_in_series(new_name)) {
        err("Patch "); err(new_name); err_line(" already exists in series");
        return 1;
    }

    auto idx = q.find_in_series(old_name);
    if (!idx) {
        err("Patch "); err(old_name); err_line(" is not in series");
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

    out_line("Fork of patch " + old_name +
             " created as " + new_name);
    return 0;
}

int cmd_upgrade(QuiltState &, int argc, char **argv)
{
    for (int i = 1; i < argc; ++i) {
        std::string_view arg = argv[i];
        if (arg == "-h" || arg == "--help") {
            out_line("Usage: quilt upgrade");
            out_line("");
            out_line("Upgrade the metadata in the .pc/ directory from version 1 to");
            out_line("version 2. This command does nothing because quilt.cpp only");
            out_line("supports the version 2 format.");
            return 0;
        }
        if (arg[0] == '-') {
            err("Unrecognized option: "); err_line(arg);
            return 1;
        }
    }
    return 0;
}
