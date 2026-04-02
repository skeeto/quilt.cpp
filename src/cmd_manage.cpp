// This is free and unencumbered software released into the public domain.
#include "quilt.hpp"
#include "platform.hpp"


static bool write_series_checked(const QuiltState &q,
                                 std::span<const std::string> series) {
    std::string series_abs = path_join(q.work_dir, q.series_file);
    if (!write_series(series_abs, series, q.patch_strip_level, q.patch_reversed)) {
        err_line("Failed to write series file.");
        return false;
    }
    return true;
}

static bool write_applied_checked(const QuiltState &q,
                                  std::span<const std::string> applied) {
    std::string applied_path = path_join(q.work_dir, q.pc_dir, "applied-patches");
    if (!write_applied(applied_path, applied)) {
        err_line("Failed to write applied-patches.");
        return false;
    }
    return true;
}

static std::vector<std::string> parse_patch_files(std::string_view content, int strip = 1) {
    std::vector<std::string> files;
    auto lines = split_lines(content);
    for (const auto &line : lines) {
        if (!line.starts_with("+++ ")) continue;
        std::string path = std::string(std::string_view(line).substr(4));
        // Strip trailing tab and anything after (timestamps)
        auto tab = str_find(path, '\t');
        if (tab >= 0) {
            path = std::string(path.substr(0, checked_cast<size_t>(tab)));
        }
        // Skip /dev/null
        if (path == "/dev/null") continue;
        path = trim(std::string_view(path));
        if (path.empty()) continue;
        // Strip N leading path components (like patch -pN)
        for (int i = 0; i < strip && !path.empty(); ++i) {
            auto slash = str_find(path, '/');
            if (slash >= 0) {
                path = path.substr(checked_cast<size_t>(slash) + 1);
            }
        }
        if (path.empty()) continue;
        // Deduplicate
        bool found = false;
        for (const auto &f : files) {
            if (f == path) { found = true; break; }
        }
        if (!found) {
            files.push_back(std::move(path));
        }
    }
    return files;
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

    for (int i = 1; i < argc; ++i) {
        std::string_view arg = argv[i];
        if (arg == "-r") {
            opt_remove = true;
        } else if (arg == "--backup") {
            opt_backup = true;
        } else if (arg == "-n") {
            opt_next = true;
        } else if (arg[0] == '-') {
            err("Unrecognized option: "); err_line(arg);
            return 1;
        } else {
            patch_arg = strip_patches_prefix(q, arg);
        }
    }

    std::string patch;
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
        out_line("Removing patch " + patch_path_display(q, patch));
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

    // Remove from series
    auto new_series = q.series;
    new_series.erase(new_series.begin() + *idx);
    if (!write_series_checked(q, new_series)) {
        return 1;
    }
    q.series = std::move(new_series);

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

    // Migrate per-patch metadata before writing series
    std::string old_key(old_patch);
    auto sl_it = q.patch_strip_level.find(old_key);
    int saved_strip = -1;
    bool saved_reversed = false;
    if (sl_it != q.patch_strip_level.end()) {
        saved_strip = sl_it->second;
        q.patch_strip_level[new_name] = sl_it->second;
        q.patch_strip_level.erase(sl_it);
    }
    if (q.patch_reversed.erase(old_key)) {
        saved_reversed = true;
        q.patch_reversed.insert(new_name);
    }

    auto new_series = q.series;
    new_series[checked_cast<size_t>(*idx)] = new_name;
    if (!write_series_checked(q, new_series)) {
        // Undo metadata migration
        if (saved_strip >= 0) {
            q.patch_strip_level[old_key] = saved_strip;
            q.patch_strip_level.erase(new_name);
        }
        if (saved_reversed) {
            q.patch_reversed.erase(new_name);
            q.patch_reversed.insert(old_key);
        }
        if (renamed_pc_dir) {
            rename_path(pc_patch_dir(q, new_name), pc_patch_dir(q, old_patch));
        }
        if (renamed_patch_file) {
            rename_path(new_file, old_file);
        }
        return 1;
    }

    if (q.is_applied(old_patch) && !write_applied_checked(q, new_applied)) {
        write_series_checked(q, q.series);
        if (saved_strip >= 0) {
            q.patch_strip_level[old_key] = saved_strip;
            q.patch_strip_level.erase(new_name);
        }
        if (saved_reversed) {
            q.patch_reversed.erase(new_name);
            q.patch_reversed.insert(old_key);
        }
        if (renamed_pc_dir) {
            rename_path(pc_patch_dir(q, new_name), pc_patch_dir(q, old_patch));
        }
        if (renamed_patch_file) {
            rename_path(new_file, old_file);
        }
        return 1;
    }

    q.series = std::move(new_series);
    if (q.is_applied(old_patch)) {
        q.applied = std::move(new_applied);
    }

    out("Patch "); out(patch_path_display(q, old_patch));
    out(" renamed to "); out_line(patch_path_display(q, new_name));
    return 0;
}

int cmd_import(QuiltState &q, int argc, char **argv) {
    int strip_level = -1;
    std::string target_name;
    bool force = false;
    char dup_mode = 0;  // o=overwrite, a=append, n=next
    bool reversed = false;
    std::vector<std::string> patchfiles;

    for (int i = 1; i < argc; ++i) {
        std::string_view arg = argv[i];
        if (arg == "-p" && i + 1 < argc) {
            strip_level = std::stoi(std::string(argv[++i]));
        } else if (arg == "-R") {
            reversed = true;
        } else if (arg == "-P" && i + 1 < argc) {
            target_name = strip_patches_prefix(q, argv[++i]);
        } else if (arg == "-f") {
            force = true;
        } else if (arg == "-d" && i + 1 < argc) {
            dup_mode = argv[++i][0];
        } else if (arg[0] == '-') {
            err("Unrecognized option: "); err_line(arg);
            return 1;
        } else {
            patchfiles.emplace_back(arg);
        }
    }

    if (patchfiles.empty()) {
        err_line("Usage: quilt import [-p num] [-R] [-P patch] [-f] [-d {o|a|n}] patchfile ...");
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

    for (const auto &patchfile : patchfiles) {
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
        if (existing && !force) {
            err_line("Patch " + patch_path_display(q, name) +
                     " exists. Replace with -f.");
            return 1;
        }
        if (existing && force && q.is_applied(name)) {
            err_line("Patch " + patch_path_display(q, name) +
                     " is applied");
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
            if (!old_hdr.empty() && !new_hdr.empty()) {
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

        // Update per-patch metadata
        if (strip_level >= 0 && strip_level != 1) {
            q.patch_strip_level[name] = strip_level;
        } else if (strip_level < 0) {
            q.patch_strip_level.erase(name);
        }
        if (reversed) {
            q.patch_reversed.insert(name);
        } else {
            q.patch_reversed.erase(name);
        }

        // Add to series if not already present
        if (!existing) {
            // Insert after top applied patch, or at end if none applied
            ptrdiff_t top_idx = q.top_index();
            auto new_series = q.series;
            if (top_idx >= 0 && top_idx + 1 < std::ssize(new_series)) {
                new_series.insert(new_series.begin() + top_idx + 1, name);
            } else {
                new_series.push_back(name);
            }
            if (!write_series_checked(q, new_series)) {
                delete_file(dest);
                return 1;
            }
            q.series = std::move(new_series);
        } else {
            // Overwriting existing patch — rewrite series for metadata update
            if (!write_series_checked(q, q.series)) {
                return 1;
            }
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

    for (int i = 1; i < argc; ++i) {
        std::string_view arg = argv[i];
        if (arg == "-a") {
            mode = APPEND;
        } else if (arg == "-r") {
            mode = REPLACE;
        } else if (arg == "-e") {
            mode = EDIT;
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
        }
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
    } else if (!opt_all) {
        err_line("No patches applied");
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

    // With labels (-l): iterate patches, output per-patch file listings
    if (opt_labels) {
        for (const auto &patch : patches_to_show) {
            std::vector<std::string> file_list;
            if (q.is_applied(patch)) {
                file_list = files_in_patch(q, patch);
            } else {
                std::string patch_file = path_join(q.work_dir, q.patches_dir, patch);
                std::string content = read_file(patch_file);
                file_list = parse_patch_files(content);
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
                std::string patch_file = path_join(q.work_dir, q.patches_dir, patch);
                std::string content = read_file(patch_file);
                file_list = parse_patch_files(content);
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
            std::string patch_file = path_join(q.work_dir, q.patches_dir, patch);
            std::string content = read_file(patch_file);
            auto patched_files = parse_patch_files(content);
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
            strip_level = std::stoi(std::string(argv[++i]));
        } else if (arg.starts_with("-p") && arg.size() > 2 &&
                   arg[2] >= '0' && arg[2] <= '9') {
            strip_level = std::stoi(std::string(arg.substr(2)));
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

    // Parse the incoming patch to find affected files
    auto affected_files = parse_patch_files(stdin_data, strip_level);

    // Track new files in the current patch
    auto currently_tracked = files_in_patch(q, top);
    for (const auto &f : affected_files) {
        bool already_tracked = false;
        for (const auto &t : currently_tracked) {
            if (t == f) { already_tracked = true; break; }
        }
        if (!already_tracked) {
            backup_file(q, top, f);
        }
    }

    // Apply patch using built-in patch engine
    PatchOptions patch_opts;
    patch_opts.strip_level = strip_level;
    patch_opts.reverse = opt_reverse;
    patch_opts.force = opt_force;
    patch_opts.quiet = opt_quiet;
    auto extra_patch_opts = shell_split(get_env("QUILT_PATCH_OPTS"));
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

    PatchResult r = builtin_patch(stdin_data, patch_opts);
    if (!opt_quiet && !r.out.empty()) {
        out(r.out);
    }
    if (!r.err.empty()) err(r.err);

    if (r.exit_code != 0 && !opt_force) {
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

    // Generate default name if none given: add "-2" before extension
    if (new_name.empty()) {
        auto dot = str_rfind(old_name, '.');
        if (dot > 0) {
            new_name = old_name.substr(0, checked_cast<size_t>(dot)) + "-2" + old_name.substr(checked_cast<size_t>(dot));
        } else {
            new_name = old_name + "-2";
        }
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

    // Migrate per-patch metadata before writing series
    auto sl_it = q.patch_strip_level.find(old_name);
    int saved_strip = -1;
    bool saved_reversed = false;
    if (sl_it != q.patch_strip_level.end()) {
        saved_strip = sl_it->second;
        q.patch_strip_level[new_name] = sl_it->second;
        q.patch_strip_level.erase(sl_it);
    }
    if (q.patch_reversed.erase(old_name)) {
        saved_reversed = true;
        q.patch_reversed.insert(new_name);
    }

    auto new_series = q.series;
    new_series[checked_cast<size_t>(*idx)] = new_name;
    if (!write_series_checked(q, new_series)) {
        if (saved_strip >= 0) {
            q.patch_strip_level[old_name] = saved_strip;
            q.patch_strip_level.erase(new_name);
        }
        if (saved_reversed) {
            q.patch_reversed.erase(new_name);
            q.patch_reversed.insert(old_name);
        }
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
        write_series_checked(q, q.series);
        if (saved_strip >= 0) {
            q.patch_strip_level[old_name] = saved_strip;
            q.patch_strip_level.erase(new_name);
        }
        if (saved_reversed) {
            q.patch_reversed.erase(new_name);
            q.patch_reversed.insert(old_name);
        }
        if (renamed_pc_dir) {
            rename_path(new_pc, old_pc);
        }
        if (copied_patch_file) {
            delete_file(new_file);
        }
        return 1;
    }

    q.series = std::move(new_series);
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
