// This is free and unencumbered software released into the public domain.
#include "quilt.hpp"
#include "platform.hpp"

#include <cstring>
#include <cstdlib>
#include <set>

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
        if (!write_file(series_abs, "")) {
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
    std::string p_value;
    int i = 1;  // skip argv[0] which is "new"
    while (i < argc) {
        std::string_view arg = argv[i];
        if (arg == "-p" && i + 1 < argc) {
            p_value = argv[i + 1];
            i += 2;
            continue;
        }
        if (arg.starts_with("-p") && std::ssize(arg) > 2) {
            p_value = std::string(arg.substr(2));
            i += 1;
            continue;
        }
        // First non-option argument is the patch name
        if (arg[0] != '-') {
            patch_name = std::string(arg);
            i += 1;
            break;
        }
        err("Unrecognized option: "); err_line(arg);
        return 1;
    }

    if (patch_name.empty()) {
        err_line("Usage: quilt new [-p n] patchname");
        return 1;
    }

    // Verify patch doesn't already exist in series
    if (q.find_in_series(patch_name).has_value()) {
        err("Patch "); err(patch_name); err_line(" already exists in series.");
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

    if (!q.applied.empty() && q.top_index() < 0) {
        err_line("The series file no longer matches the applied patches. Please run 'quilt pop -a'.");
        return 1;
    }

    // Validate strip level
    if (!p_value.empty() && p_value != "0" && p_value != "1") {
        err_line("Cannot create patches with -p" + p_value +
                 ", please specify -p0 or -p1 instead");
        return 1;
    }

    // Insert into the series after the current top, recording only -p0
    if (!insert_in_series(q, patch_name, p_value == "0" ? "-p0" : "",
                          q.patch_after_top())) {
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
    // Parse options
    std::string_view patch_arg;
    std::vector<std::string> files;
    int i = 1;
    while (i < argc) {
        std::string_view arg = argv[i];
        if (arg == "-P" && i + 1 < argc) {
            patch_arg = argv[i + 1];
            i += 2;
            continue;
        }
        if (!arg.starts_with('-')) {
            files.push_back(subdir_path(q, arg));
        } else {
            err("Unrecognized option: "); err_line(arg);
            return 1;
        }
        i += 1;
    }

    if (files.empty()) {
        err_line("Usage: quilt add [-P patch] file ...");
        return 1;
    }

    // No -P, or an empty one, means the top patch
    auto found = find_applied_patch(q, patch_arg);
    if (!found) return 1;
    std::string_view patch = *found;

    for (const auto &file : files) {
        // Check if file is already tracked by this patch
        std::string backup_path = path_join(pc_patch_dir(q, patch), file);
        if (file_exists(backup_path)) {
            err("File "); err(file); err(" is already in patch ");
            err_line(patch_path_display(q, patch));
            return 2;
        }

        // Check if file is modified by any patch applied after this one
        bool found_patch = false;
        for (const auto &ap : q.applied) {
            if (!found_patch) {
                if (ap == patch) found_patch = true;
                continue;
            }
            std::string later_backup = path_join(pc_patch_dir(q, ap), file);
            if (file_exists(later_backup)) {
                err("File "); err(file); err(" modified by patch ");
                err_line(patch_path_display(q, ap));
                return 1;
            }
        }

        // Backup the file
        if (!backup_file(q, patch, file)) {
            err("Failed to back up "); err_line(file);
            return 1;
        }

        out("File "); out(file); out(" added to patch ");
        out_line(patch_path_display(q, patch));
    }

    return 0;
}

int cmd_remove(QuiltState &q, int argc, char **argv) {
    // Parse options
    std::string_view patch_arg;
    std::vector<std::string> files;
    int i = 1;
    while (i < argc) {
        std::string_view arg = argv[i];
        if (arg == "-P" && i + 1 < argc) {
            patch_arg = argv[i + 1];
            i += 2;
            continue;
        }
        if (!arg.starts_with('-')) {
            files.push_back(subdir_path(q, arg));
        } else {
            err("Unrecognized option: "); err_line(arg);
            return 1;
        }
        i += 1;
    }

    if (files.empty()) {
        err_line("Usage: quilt remove [-P patch] file ...");
        return 1;
    }

    // No -P, or an empty one, means the top patch
    auto found = find_applied_patch(q, patch_arg);
    if (!found) return 1;
    std::string_view patch = *found;

    for (const auto &file : files) {
        // Check if file is tracked by this patch
        std::string backup_path = path_join(pc_patch_dir(q, patch), file);
        if (!file_exists(backup_path)) {
            err("File "); err(file); err(" is not in patch ");
            err_line(patch_path_display(q, patch));
            return 1;
        }

        // Restore file from backup
        if (!restore_file(q, patch, file)) {
            err("Failed to restore "); err_line(file);
            return 1;
        }

        // Remove backup file
        delete_file(backup_path);

        out("File "); out(file); out(" removed from patch ");
        out_line(patch_path_display(q, patch));
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
        std::string_view arg = argv[i];
        if (arg[0] == '-') {
            err("Unrecognized option: "); err_line(arg);
            return 1;
        }
        files.push_back(subdir_path(q, arg));
    }

    if (files.empty()) {
        err_line("Usage: quilt edit file ...");
        return 1;
    }

    std::string_view patch = q.applied.back();

    // Add each file to the top patch if not already tracked
    for (const auto &file : files) {
        std::string backup_path = path_join(pc_patch_dir(q, patch), file);
        if (!file_exists(backup_path)) {
            if (!backup_file(q, patch, file)) {
                err("Failed to back up "); err_line(file);
                return 1;
            }
            out("File "); out(file); out(" added to patch ");
            out_line(patch_path_display(q, patch));
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

// Convert unified diff output to context diff format.  This allows
// quilt to produce -c/-C output even when the external diff command
// (e.g. busybox) only supports unified format.
static std::string unified_to_context(std::string_view unified)
{
    auto lines = split_lines(unified);
    std::string result;
    ptrdiff_t n = std::ssize(lines);
    ptrdiff_t i = 0;

    // File headers: unified --- becomes context ***, unified +++ becomes context ---
    while (i < n && !lines[checked_cast<size_t>(i)].starts_with("--- ")) ++i;
    if (i < n) { result += "*** " + lines[checked_cast<size_t>(i)].substr(4) + "\n"; ++i; }
    if (i < n && lines[checked_cast<size_t>(i)].starts_with("+++ ")) {
        result += "--- " + lines[checked_cast<size_t>(i)].substr(4) + "\n"; ++i;
    }

    while (i < n) {
        if (!lines[checked_cast<size_t>(i)].starts_with("@@ ")) { ++i; continue; }

        // Parse @@ -os[,oc] +ns[,nc] @@
        int os = 0, oc = 1, ns = 0, nc = 1;
        {
            std::string_view hdr = lines[checked_cast<size_t>(i)];
            ptrdiff_t at1 = str_find(hdr, '-', 3);
            if (at1 >= 0) {
                ptrdiff_t p = at1 + 1;
                ptrdiff_t c = str_find(hdr, ',', p);
                ptrdiff_t pp = str_find(hdr, '+', p);
                if (pp >= 0) {
                    if (c >= 0 && c < pp) {
                        os = checked_cast<int>(parse_int(hdr.substr(checked_cast<size_t>(p), checked_cast<size_t>(c - p))));
                        oc = checked_cast<int>(parse_int(hdr.substr(checked_cast<size_t>(c + 1), checked_cast<size_t>(pp - c - 2))));
                    } else {
                        os = checked_cast<int>(parse_int(hdr.substr(checked_cast<size_t>(p), checked_cast<size_t>(pp - p - 1))));
                    }
                    p = pp + 1;
                    c = str_find(hdr, ',', p);
                    ptrdiff_t end = str_find(hdr, ' ', p);
                    if (end < 0) end = std::ssize(hdr);
                    if (c >= 0 && c < end) {
                        ns = checked_cast<int>(parse_int(hdr.substr(checked_cast<size_t>(p), checked_cast<size_t>(c - p))));
                        nc = checked_cast<int>(parse_int(hdr.substr(checked_cast<size_t>(c + 1), checked_cast<size_t>(end - c - 1))));
                    } else {
                        ns = checked_cast<int>(parse_int(hdr.substr(checked_cast<size_t>(p), checked_cast<size_t>(end - p))));
                    }
                }
            }
        }
        ++i;

        // Collect unified hunk body lines with their types
        struct UL { char type; std::string text; };
        std::vector<UL> body;
        while (i < n && !lines[checked_cast<size_t>(i)].starts_with("@@ ")) {
            std::string_view ln = lines[checked_cast<size_t>(i)];
            body.push_back({ln.empty() ? ' ' : ln[0],
                            ln.empty() ? std::string{} : std::string(ln.substr(1))});
            ++i;
        }

        // Build old-side and new-side lines with context-diff prefixes.
        // Adjacent -/+ runs form "change" blocks and get '!' prefix.
        std::vector<std::pair<char, std::string>> old_side, new_side;
        for (ptrdiff_t k = 0; k < std::ssize(body); ) {
            if (body[checked_cast<size_t>(k)].type == ' ') {
                old_side.push_back({' ', body[checked_cast<size_t>(k)].text});
                new_side.push_back({' ', body[checked_cast<size_t>(k)].text});
                ++k;
            } else if (body[checked_cast<size_t>(k)].type == '-') {
                ptrdiff_t ds = k;
                while (k < std::ssize(body) && body[checked_cast<size_t>(k)].type == '-') ++k;
                ptrdiff_t as = k;
                while (k < std::ssize(body) && body[checked_cast<size_t>(k)].type == '+') ++k;
                bool change = (as > ds && k > as);
                for (ptrdiff_t m = ds; m < as; ++m)
                    old_side.push_back({change ? '!' : '-', body[checked_cast<size_t>(m)].text});
                for (ptrdiff_t m = as; m < k; ++m)
                    new_side.push_back({change ? '!' : '+', body[checked_cast<size_t>(m)].text});
            } else if (body[checked_cast<size_t>(k)].type == '+') {
                new_side.push_back({'+', body[checked_cast<size_t>(k)].text});
                ++k;
            } else {
                ++k;
            }
        }

        int oe = oc == 0 ? os : os + oc - 1;
        int ne = nc == 0 ? ns : ns + nc - 1;

        result += "***************\n";
        result += std::format("*** {},{} ****\n", os, oe);
        bool has_old = false;
        for (auto &[p, t] : old_side) if (p != ' ') { has_old = true; break; }
        if (has_old)
            for (auto &[p, t] : old_side)
                result += std::string(1, p) + " " + t + "\n";

        result += std::format("--- {},{} ----\n", ns, ne);
        bool has_new = false;
        for (auto &[p, t] : new_side) if (p != ' ') { has_new = true; break; }
        if (has_new)
            for (auto &[p, t] : new_side)
                result += std::string(1, p) + " " + t + "\n";
    }

    return result;
}

static constexpr std::string_view SNAPSHOT_PATCH = ".snap";

static bool is_placeholder_copy(std::string_view path)
{
    return file_exists(path) && read_file(path).empty();
}

// Detect binary content (null bytes in the first 8 KB)
static bool is_binary_data(std::string_view data)
{
    return str_find(data.substr(0, 8192), '\0') >= 0;
}

// Parse QUILT_DIFF_OPTS and extract context line count if present.
// Returns the context line count (-1 if not specified in opts).
static int parse_diff_opts_context(std::span<const std::string> opts)
{
    for (ptrdiff_t i = 0; i < std::ssize(opts); ++i) {
        const auto &o = opts[checked_cast<size_t>(i)];
        if (o.starts_with("-U") && std::ssize(o) > 2) {
            return checked_cast<int>(parse_int(std::string_view(o).substr(2)));
        }
        if (o == "-U" && i + 1 < std::ssize(opts)) {
            return checked_cast<int>(parse_int(opts[checked_cast<size_t>(i + 1)]));
        }
    }
    return -1;
}

// p_format: "ab" for a/b labels, "0" for bare filenames, "1" (default) for dir.orig/dir
// Format a file modification time as "YYYY-MM-DD HH:MM:SS.000000000 +HHMM".
static std::string format_file_timestamp(std::string_view path) {
    int64_t mt = file_mtime(path);
    if (mt <= 0) return "";
    DateTime dt = local_time(mt);
    int off_h = dt.utc_offset / 3600;
    int off_m = (std::abs(dt.utc_offset) % 3600) / 60;
    return std::format("\t{:04d}-{:02d}-{:02d} {:02d}:{:02d}:{:02d}.000000000 {:+03d}{:02d}",
                       dt.year, dt.month, dt.day,
                       dt.hour, dt.min, dt.sec, off_h, off_m);
}

static std::string generate_path_diff(const QuiltState &q,
                                      std::string_view file,
                                      std::string_view old_path,
                                      bool old_placeholder,
                                      std::string_view new_path,
                                      bool new_placeholder,
                                      std::string_view p_format = "1",
                                      bool reverse = false,
                                      std::span<const std::string> diff_cmd_base = {},
                                      int context_lines = 3,
                                      DiffFormat diff_format = DiffFormat::unified,
                                      bool no_timestamps = false,
                                      DiffAlgorithm diff_algorithm = DiffAlgorithm::myers) {
    bool old_missing = old_path.empty() || !file_exists(old_path) ||
        (old_placeholder && is_placeholder_copy(old_path));
    bool new_missing = new_path.empty() || !file_exists(new_path) ||
        (new_placeholder && is_placeholder_copy(new_path));

    // Identical files never differ, binary or not. Only a changed binary
    // file is reported, which callers treat as a failed diff.
    std::string old_data = old_missing ? std::string() : read_file(old_path);
    std::string new_data = new_missing ? std::string() : read_file(new_path);
    if (old_data == new_data) {
        return {};
    }
    if (is_binary_data(old_data) || is_binary_data(new_data)) {
        return "Binary files differ\n";
    }

    // As in the original quilt, labels follow the files after the swap
    if (reverse) {
        std::swap(old_path, new_path);
        std::swap(old_missing, new_missing);
    }

    std::string old_arg = old_missing ? "/dev/null" : std::string(old_path);
    std::string new_arg = new_missing ? "/dev/null" : std::string(new_path);

    std::string old_label;
    std::string new_label;
    if (p_format == "ab") {
        old_label = "a/" + std::string(file);
        new_label = "b/" + std::string(file);
    } else if (p_format == "0") {
        old_label = std::string(file) + ".orig";
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
        // A -p0 deletion names the file itself, so it can be applied
        if (p_format == "0") old_label = new_label;
        new_label = "/dev/null";
    }

    // Append file timestamps unless suppressed
    if (!no_timestamps) {
        if (!old_missing)
            old_label += format_file_timestamp(old_path);
        if (!new_missing)
            new_label += format_file_timestamp(new_path);
    }

    // Use built-in diff when no external diff utility is specified
    if (diff_cmd_base.empty()) {
        int ctx = context_lines;
        // QUILT_DIFF_OPTS may override context lines
        auto extra_diff_opts = shell_split(get_env("QUILT_DIFF_OPTS"));
        int opts_ctx = parse_diff_opts_context(extra_diff_opts);
        if (opts_ctx >= 0) ctx = opts_ctx;

        DiffResult result = builtin_diff(old_arg, new_arg, ctx,
                                          old_label, new_label, diff_format,
                                          diff_algorithm);
        return result.output;
    }

    // External diff utility path
    std::vector<std::string> cmd_argv(diff_cmd_base.begin(), diff_cmd_base.end());
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
        return {};
    }

    return result.out;
}

static std::string generate_file_diff(const QuiltState &q, std::string_view patch,
                                      std::string_view file,
                                      std::string_view p_format = "1",
                                      bool reverse = false,
                                      std::span<const std::string> diff_cmd_base = {},
                                      int context_lines = 3,
                                      DiffFormat diff_format = DiffFormat::unified,
                                      bool no_timestamps = false,
                                      DiffAlgorithm diff_algorithm = DiffAlgorithm::myers) {
    std::string backup_path = path_join(pc_patch_dir(q, patch), file);
    std::string working_path = path_join(q.work_dir, file);
    return generate_path_diff(q, file, backup_path, true, working_path, false,
                              p_format, reverse, diff_cmd_base,
                              context_lines, diff_format, no_timestamps,
                              diff_algorithm);
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
        if (line.starts_with("Index:") || line.starts_with("diff ")) {
            flush();
            current_section += line + "\n";
        } else if (line.starts_with("+++ ")) {
            // Extract filename from +++ line
            std::string_view rest = std::string_view(line).substr(4);
            if (rest.starts_with("/dev/null")) {
                // File deletion: current_file already set from --- line
            } else {
                // Strip b/ prefix and trailing tab/timestamp
                if (rest.starts_with("b/")) rest = rest.substr(2);
                auto tab = str_find(rest, '\t');
                if (tab >= 0) rest = rest.substr(0, checked_cast<size_t>(tab));
                // Strip leading directory component (e.g., "dir.orig/")
                auto slash = str_find(rest, '/');
                if (slash >= 0) {
                    current_file = trim(rest.substr(checked_cast<size_t>(slash + 1)));
                } else {
                    current_file = trim(rest);
                }
            }
            current_section += line + "\n";
        } else if (line.starts_with("===")) {
            current_section += line + "\n";
        } else if (line.starts_with("--- ")) {
            // For file deletions (+++ /dev/null), we get the name from ---
            if (current_file.empty()) {
                std::string_view rest = std::string_view(line).substr(4);
                if (!rest.starts_with("/dev/null")) {
                    if (rest.starts_with("a/")) rest = rest.substr(2);
                    auto tab = str_find(rest, '\t');
                    if (tab >= 0) rest = rest.substr(0, checked_cast<size_t>(tab));
                    auto slash = str_find(rest, '/');
                    if (slash >= 0) {
                        current_file = trim(rest.substr(checked_cast<size_t>(slash + 1)));
                    } else {
                        current_file = trim(rest);
                    }
                }
            }
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
                                std::span<const std::string> src) {
    for (const auto &file : src) {
        if (seen.insert(file).second) {
            dst.push_back(file);
        }
    }
}

static std::vector<std::string> collect_files_for_patches(
    const QuiltState &q, std::span<const std::string> patches) {
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
                                        std::span<const std::string> patches,
                                        std::string_view file) {
    for (const auto &patch : patches) {
        auto tracked = files_in_patch(q, patch);
        if (std::ranges::find(tracked, file) != tracked.end()) {
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
            if (std::ranges::find(tracked, file) != tracked.end()) {
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
                              std::span<const std::string> file_filter) {
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

    if (!q.series_file_exists) {
        err_line("No series file found");
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

// Built-in diffstat: parse unified diff, produce a summary matching
// the output format of the external diffstat(1) utility.
static std::string generate_diffstat(std::string_view diff)
{
    struct FileStat {
        std::string name;
        ptrdiff_t added   = 0;
        ptrdiff_t removed = 0;
    };

    std::vector<FileStat> stats;
    auto lines = split_lines(diff);

    for (ptrdiff_t i = 0; i < std::ssize(lines); ++i) {
        const auto &line = lines[checked_cast<size_t>(i)];

        // Detect file header: "--- a/file" followed by "+++ b/file"
        if (line.starts_with("--- ") &&
            i + 1 < std::ssize(lines) &&
            lines[checked_cast<size_t>(i + 1)].starts_with("+++ ")) {
            const auto &plus_line = lines[checked_cast<size_t>(i + 1)];

            // Extract filename from +++ line, strip "b/" prefix
            auto name = plus_line.substr(4);
            // Strip trailing timestamp (tab-separated)
            auto tab = str_find(name, '\t');
            if (tab >= 0) name = name.substr(0, checked_cast<size_t>(tab));
            // Strip one leading path component (a/ or b/ prefix)
            auto slash = str_find(name, '/');
            if (slash >= 0) name = name.substr(checked_cast<size_t>(slash + 1));
            // /dev/null means new or deleted file — use --- line instead
            if (name == "dev/null" || plus_line.substr(4).starts_with("/dev/null")) {
                name = lines[checked_cast<size_t>(i)].substr(4);
                tab = str_find(name, '\t');
                if (tab >= 0) name = name.substr(0, checked_cast<size_t>(tab));
                slash = str_find(name, '/');
                if (slash >= 0) name = name.substr(checked_cast<size_t>(slash + 1));
            }

            stats.push_back({std::string(name), 0, 0});
            i += 1;  // skip +++ line
            continue;
        }

        if (stats.empty()) continue;

        if (line.starts_with("+") && !line.starts_with("+++"))
            stats.back().added++;
        else if (line.starts_with("-") && !line.starts_with("---"))
            stats.back().removed++;
    }

    if (stats.empty()) return {};

    // Leading "---" separator (matches git format-patch / original quilt)
    std::string result = "---\n";

    // Find max filename width and max change count
    ptrdiff_t max_name = 0;
    ptrdiff_t max_changes = 0;
    for (const auto &s : stats) {
        max_name = std::max(max_name, std::ssize(s.name));
        max_changes = std::max(max_changes, s.added + s.removed);
    }

    // Format change count to find its width (minimum 4, matching diffstat)
    auto num_width = std::max(std::ssize(std::to_string(max_changes)),
                              static_cast<ptrdiff_t>(4));

    // Bar graph width: fit in ~72 columns after " name | num "
    //   1 (leading space) + max_name + 3 (" | ") + num_width + 1 (space)
    ptrdiff_t used = 1 + max_name + 3 + num_width + 1;
    ptrdiff_t bar_width = std::max(static_cast<ptrdiff_t>(1),
                                   static_cast<ptrdiff_t>(72) - used);

    // Scale factor for bar graph
    double scale = (max_changes > bar_width)
        ? static_cast<double>(bar_width) / static_cast<double>(max_changes)
        : 1.0;

    ptrdiff_t total_added = 0, total_removed = 0;
    ptrdiff_t total_files = std::ssize(stats);

    for (const auto &s : stats) {
        total_added += s.added;
        total_removed += s.removed;

        ptrdiff_t changes = s.added + s.removed;
        ptrdiff_t plus_bars = static_cast<ptrdiff_t>(
            static_cast<double>(s.added) * scale + 0.5);
        ptrdiff_t minus_bars = static_cast<ptrdiff_t>(
            static_cast<double>(s.removed) * scale + 0.5);

        // Ensure at least 1 bar for non-zero counts
        if (s.added > 0 && plus_bars == 0) plus_bars = 1;
        if (s.removed > 0 && minus_bars == 0) minus_bars = 1;

        // Cap total bars at scaled width
        ptrdiff_t total_bars = plus_bars + minus_bars;
        ptrdiff_t limit = static_cast<ptrdiff_t>(
            static_cast<double>(changes) * scale + 0.5);
        if (limit < 1 && changes > 0) limit = 1;
        if (total_bars > limit) {
            // Reduce the larger portion
            if (plus_bars > minus_bars)
                plus_bars = limit - minus_bars;
            else
                minus_bars = limit - plus_bars;
        }

        result += ' ';
        result += s.name;
        for (ptrdiff_t j = std::ssize(s.name); j < max_name; ++j)
            result += ' ';
        result += " | ";
        auto num_str = std::to_string(changes);
        for (ptrdiff_t j = std::ssize(num_str); j < num_width; ++j)
            result += ' ';
        result += num_str;
        result += ' ';
        for (ptrdiff_t j = 0; j < plus_bars; ++j) result += '+';
        for (ptrdiff_t j = 0; j < minus_bars; ++j) result += '-';
        result += '\n';
    }

    // Summary line
    result += ' ';
    result += std::to_string(total_files);
    result += (total_files == 1) ? " file changed" : " files changed";
    if (total_added > 0) {
        result += ", ";
        result += std::to_string(total_added);
        result += (total_added == 1) ? " insertion(+)" : " insertions(+)";
    }
    if (total_removed > 0) {
        result += ", ";
        result += std::to_string(total_removed);
        result += (total_removed == 1) ? " deletion(-)" : " deletions(-)";
    }
    result += '\n';

    return result;
}

// Remove an existing diffstat section from a patch header.
// Detects "---" separator followed by " file | N ++--" lines ending
// with a "N file(s) changed" summary line.
static std::string remove_diffstat_section(std::string_view header) {
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
            // Look ahead to confirm this is a diffstat block
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
                // If we hit an empty line or non-diffstat line, stop
                if (l.empty() || (l[0] != ' ' && str_find(l, '|') < 0))
                    break;
            }
            if (found_summary) {
                // Skip the entire diffstat block including summary
                i = summary_end;
                // Also skip a trailing blank line after diffstat
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

// Split text into lines, each keeping its '\n' terminator (the last line
// may have none).
static std::vector<std::string_view> split_lines_keep_eol(std::string_view s)
{
    std::vector<std::string_view> lines;
    while (!s.empty()) {
        ptrdiff_t nl = str_find(s, '\n');
        ptrdiff_t len = nl < 0 ? std::ssize(s) : nl + 1;
        lines.push_back(s.substr(0, checked_cast<size_t>(len)));
        s.remove_prefix(checked_cast<size_t>(len));
    }
    return lines;
}

// Length of the run of spaces and tabs ending a line, just before its '\n'
// (if any), not counting into the first `keep` bytes. As in upstream, '\r'
// is not whitespace here, so a CRLF line is left alone.
static ptrdiff_t trailing_ws_len(std::string_view line, ptrdiff_t keep)
{
    if (line.ends_with('\n')) line.remove_suffix(1);
    keep = std::min(keep, std::ssize(line));
    std::string_view tail = line.substr(checked_cast<size_t>(keep));
    auto last = tail.find_last_not_of(" \t");
    if (last == std::string_view::npos) return std::ssize(tail);
    return std::ssize(tail) - checked_cast<ptrdiff_t>(last) - 1;
}

// Append a line less the `n` bytes just before its '\n' (if any).
static void append_without_trailing_ws(std::string &out,
                                       std::string_view line, ptrdiff_t n)
{
    bool eol = line.ends_with('\n');
    if (eol) line.remove_suffix(1);
    out += line.substr(0, checked_cast<size_t>(std::ssize(line) - n));
    if (eol) out += '\n';
}

// Parse a decimal number at s[pos], advancing pos past it.
static ptrdiff_t parse_diff_num(std::string_view s, ptrdiff_t &pos)
{
    ptrdiff_t n = 0;
    auto first = s.data() + pos;
    auto [ptr, ec] = std::from_chars(first, s.data() + s.size(), n);
    pos += ptr - first;
    return n;
}

static bool char_at_is(std::string_view s, ptrdiff_t pos, char c)
{
    return pos < std::ssize(s) && s[checked_cast<size_t>(pos)] == c;
}

static bool digit_at(std::string_view s, ptrdiff_t pos)
{
    return pos < std::ssize(s) && s[checked_cast<size_t>(pos)] >= '0' &&
           s[checked_cast<size_t>(pos)] <= '9';
}

// Strip trailing whitespace from the lines a single-file diff (unified or
// context format) adds, like upstream's remove-trailing-ws script. Returns
// the line numbers, in the new file, of the lines that were stripped.
static std::vector<ptrdiff_t> strip_diff_trailing_ws(std::string &diff)
{
    std::vector<ptrdiff_t> stripped_lines;
    auto lines = split_lines_keep_eol(diff);
    std::string result;
    ptrdiff_t n = std::ssize(lines);
    ptrdiff_t i = 0;
    auto line_at = [&](ptrdiff_t k) { return lines[checked_cast<size_t>(k)]; };

    // Strip a line that adds content after a `keep`-byte prefix
    auto take_added = [&](std::string_view line, ptrdiff_t keep,
                          ptrdiff_t line_number) {
        ptrdiff_t ws = trailing_ws_len(line, keep);
        if (ws > 0) stripped_lines.push_back(line_number);
        append_without_trailing_ws(result, line, ws);
    };

    bool context = false;
    for (; i < n; ++i) {
        result += line_at(i);
        if (line_at(i).starts_with("--- ")) { ++i; break; }
        if (line_at(i).starts_with("*** ")) { context = true; ++i; break; }
    }

    while (i < n) {
        std::string_view line = line_at(i++);
        result += line;
        if (!context && line.starts_with("@@ -") && digit_at(line, 4)) {
            // @@ -a[,b] +c[,d] @@
            ptrdiff_t pos = 4;
            parse_diff_num(line, pos);
            ptrdiff_t removed = 1, added = 1;
            if (char_at_is(line, pos, ',')) removed = parse_diff_num(line, ++pos);
            if (!char_at_is(line, pos, ' ') || !char_at_is(line, pos + 1, '+') ||
                !digit_at(line, pos + 2)) {
                continue;
            }
            pos += 2;
            ptrdiff_t line_number = parse_diff_num(line, pos);
            if (char_at_is(line, pos, ',')) added = parse_diff_num(line, ++pos);
            while ((removed > 0 || added > 0) && i < n) {
                std::string_view hl = line_at(i++);
                if (hl.starts_with('+')) {
                    take_added(hl, 1, line_number);
                    added--;
                    line_number++;
                    continue;
                }
                if (hl.starts_with('-')) {
                    removed--;
                } else if (hl.starts_with(' ') || hl == "\n") {
                    removed--;
                    added--;
                    line_number++;
                }
                result += hl;
            }
        } else if (context && line.starts_with("--- ") && digit_at(line, 4) &&
                   line.ends_with(" ----\n")) {
            // --- c[,d] ----
            ptrdiff_t pos = 4;
            ptrdiff_t line_number = parse_diff_num(line, pos);
            ptrdiff_t last_line = line_number;
            if (char_at_is(line, pos, ',')) last_line = parse_diff_num(line, ++pos);
            for (; line_number <= last_line && i < n; ++line_number) {
                std::string_view hl = line_at(i++);
                if (hl.starts_with("+ ") || hl.starts_with("! ")) {
                    take_added(hl, 2, line_number);
                } else {
                    result += hl;
                }
                if (hl.starts_with("****") || hl.starts_with("*** ")) break;
            }
        }
    }

    diff = std::move(result);
    return stripped_lines;
}

// Remove trailing spaces and tabs from the given (ascending, 1-based) lines
// of a file, leaving all other bytes alone. The file is rewritten only if
// something changed.
static bool strip_file_trailing_ws(const std::string &path,
                                   std::span<const ptrdiff_t> line_numbers)
{
    std::string content = read_file(path);
    std::string result;
    ptrdiff_t lineno = 0;
    auto next = line_numbers.begin();
    for (auto line : split_lines_keep_eol(content)) {
        ++lineno;
        while (next != line_numbers.end() && *next < lineno) ++next;
        ptrdiff_t ws = 0;
        if (next != line_numbers.end() && *next == lineno) {
            ws = trailing_ws_len(line, 0);
        }
        append_without_trailing_ws(result, line, ws);
    }
    if (result == content) return true;
    return write_file(path, result);
}

// Like upstream change_db_strip_level, record in the series the strip level
// a refreshed patch was written with. Refresh always writes forward, so -R
// is dropped too.
static bool record_strip_level(QuiltState &q, const std::string &patch,
                               int strip_level) {
    if (!set_series_strip_level(q, patch, strip_level)) {
        err_line("Failed to write series file.");
        return false;
    }
    return true;
}

int cmd_refresh(QuiltState &q, int argc, char **argv) {
    // Parse options
    std::optional<std::string_view> patch_arg;
    int positional_count = 0;
    std::string p_format;
    int i = 1;
    bool no_timestamps = !get_env("QUILT_NO_DIFF_TIMESTAMPS").empty();
    bool no_index = !get_env("QUILT_NO_DIFF_INDEX").empty();
    bool sort_files = true;
    bool force = false;
    std::string diff_type;
    std::string context_num;
    bool opt_fork = false;
    std::string fork_name;
    bool opt_diffstat = false;
    bool opt_backup = false;
    bool opt_strip_whitespace = false;
    DiffAlgorithm diff_algorithm = DiffAlgorithm::myers;
    {
        auto env_algo = get_env("QUILT_DIFF_ALGORITHM");
        if (!env_algo.empty()) {
            auto parsed = parse_diff_algorithm(env_algo);
            if (!parsed) {
                err("Unknown diff algorithm: "); err_line(env_algo);
                return 1;
            }
            diff_algorithm = *parsed;
        }
    }

    while (i < argc) {
        std::string_view arg = argv[i];
        if (arg == "-p" && i + 1 < argc) {
            p_format = std::string(argv[i + 1]);
            i += 2;
            continue;
        }
        if (arg.starts_with("-p") && std::ssize(arg) > 2) {
            p_format = std::string(arg.substr(2));
            i += 1;
            continue;
        }
        if (arg == "-f") {
            force = true;
            i += 1;
            continue;
        }
        if (arg == "-u") {
            diff_type = "u";
            context_num.clear();
            i += 1;
            continue;
        }
        if (arg.starts_with("-U")) {
            diff_type = "U";
            if (arg == "-U" && i + 1 < argc) {
                context_num = argv[i + 1];
                i += 2;
            } else {
                context_num = std::string(arg.substr(2));
                i += 1;
            }
            continue;
        }
        if (arg == "-c") {
            diff_type = "c";
            context_num.clear();
            i += 1;
            continue;
        }
        if (arg.starts_with("-C")) {
            diff_type = "C";
            if (arg == "-C" && i + 1 < argc) {
                context_num = argv[i + 1];
                i += 2;
            } else {
                context_num = std::string(arg.substr(2));
                i += 1;
            }
            continue;
        }
        if (arg.starts_with("-z")) {
            opt_fork = true;
            if (std::ssize(arg) > 2) {
                fork_name = strip_patches_prefix(q, arg.substr(2));
            }
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
        if (arg == "--diffstat") {
            opt_diffstat = true;
            i += 1;
            continue;
        }
        if (arg == "--backup") {
            opt_backup = true;
            i += 1;
            continue;
        }
        if (arg == "--strip-trailing-whitespace") {
            opt_strip_whitespace = true;
            i += 1;
            continue;
        }
        if (arg.starts_with("--diff-algorithm=")) {
            auto name = arg.substr(17);
            auto algo = parse_diff_algorithm(name);
            if (!algo) {
                err("Unknown diff algorithm: "); err_line(name);
                return 1;
            }
            diff_algorithm = *algo;
            i += 1;
            continue;
        }
        if (arg == "--diff-algorithm" && i + 1 < argc) {
            std::string_view name = argv[i + 1];
            auto algo = parse_diff_algorithm(name);
            if (!algo) {
                err("Unknown diff algorithm: "); err_line(name);
                return 1;
            }
            diff_algorithm = *algo;
            i += 2;
            continue;
        }
        if (arg.starts_with('-')) {
            err("Unrecognized option: "); err_line(arg);
            return 1;
        }
        // Non-option: patch name, given even when empty
        patch_arg = arg;
        ++positional_count;
        i += 1;
    }

    if (positional_count > 1) {
        err_line("Usage: quilt refresh [-p n|-p ab] [-u|-U num|-c|-C num] "
                 "[-z[new_name]] [-f] [--no-timestamps] [--no-index] "
                 "[--diffstat] [--sort] [--backup] "
                 "[--strip-trailing-whitespace] [patch]");
        return 1;
    }
    if (!q.series_file_exists) {
        err_line("No series file found");
        return 1;
    }

    // Like upstream, look up the patch first, so that an unknown name is
    // reported as such. No argument, or an empty one, means the top patch.
    auto found = find_applied_patch(q, patch_arg.value_or(""));
    if (!found) return 1;
    std::string patch = *found;

    // Like upstream, -z forks only the top patch, and only when no patch
    // is named, even if the name is the top patch's or empty
    if (opt_fork && patch_arg) {
        err_line("Can only refresh the topmost patch with -z currently");
        return 1;
    }

    // Like the original quilt, validate the effective strip level, which
    // may come from the series file.
    if (p_format.empty()) {
        p_format = q.get_p_format(patch);
    }
    if (p_format != "0" && p_format != "1" && p_format != "ab") {
        err("Cannot refresh patches with -p"); err(p_format);
        err_line(", please specify -p0, -p1, or -pab instead");
        return 1;
    }
    int strip_level = p_format == "0" ? 0 : 1;

    // Compute diff format and context lines
    DiffFormat diff_format = DiffFormat::unified;
    int ctx_lines = 3;
    if (diff_type == "c") {
        diff_format = DiffFormat::context;
    } else if (diff_type == "C") {
        diff_format = DiffFormat::context;
        ctx_lines = checked_cast<int>(parse_int(context_num));
    } else if (diff_type == "U") {
        ctx_lines = checked_cast<int>(parse_int(context_num));
    }

    // Fork before refresh if -z was given
    // Unlike standalone "fork" (which replaces the original), refresh -z
    // inserts a new patch *after* the original and refreshes the fork.
    // The original patch keeps its content. The fork captures only the
    // delta between the original's refreshed state and the current working
    // tree. Like upstream, the fork joins the series only once its patch is
    // written, so a fork with nothing in it leaves everything as it was.
    std::string fork_of;
    if (opt_fork) {
        std::string old_name(patch);

        std::string new_name = fork_name.empty() ? next_filename(old_name) : fork_name;

        if (file_exists(path_join(q.work_dir, q.patches_dir, new_name))) {
            err("Patch "); err(patch_path_display(q, new_name));
            err_line(" exists already");
            return 1;
        }
        if (q.find_in_series(new_name)) {
            err("Patch "); err(new_name); err_line(" already exists in series");
            return 1;
        }

        auto idx = q.find_in_series(old_name);
        if (!idx) {
            err("Patch "); err(old_name); err_line(" is not in series");
            return 1;
        }

        // Create the fork's .pc/ directory with backups representing the
        // file state *after* the original patch (i.e., the intermediate
        // state between the two patches).  Reconstruct this by applying
        // the original patch to the backup copies in an in-memory FS.
        std::string old_pc = pc_patch_dir(q, old_name);
        std::string new_pc = pc_patch_dir(q, new_name);
        if (is_directory(new_pc)) delete_dir_recursive(new_pc);
        make_dirs(new_pc);

        std::string orig_patch_path = path_join(q.work_dir, q.patches_dir, old_name);
        std::string orig_patch_content = read_file(orig_patch_path);
        int orig_strip = q.get_strip_level(old_name);
        auto orig_files = files_in_patch(q, old_name);

        // Build in-memory FS from backup copies, apply original patch
        std::map<std::string, std::string> memfs;
        for (const auto &file : orig_files) {
            std::string backup_path = path_join(old_pc, file);
            if (file_exists(backup_path) && !is_placeholder_copy(backup_path)) {
                memfs[file] = read_file(backup_path);
            }
        }
        if (!orig_patch_content.empty()) {
            PatchOptions popts;
            popts.strip_level = orig_strip;
            popts.quiet = true;
            popts.fs = &memfs;
            if (q.patch_reversed.contains(old_name)) popts.reverse = true;
            builtin_patch(orig_patch_content, popts);
        }

        // Write the intermediate states to the fork's .pc/ directory
        for (const auto &file : orig_files) {
            std::string fork_backup = path_join(new_pc, file);
            std::string fork_dir = dirname(fork_backup);
            if (!is_directory(fork_dir)) make_dirs(fork_dir);

            auto it = memfs.find(file);
            if (it != memfs.end()) {
                write_file(fork_backup, it->second);
            } else {
                // File was deleted by patch or not present — write empty placeholder
                write_file(fork_backup, "");
            }
        }

        patch = new_name;
        fork_of = old_name;
    }

    // An unfinished fork leaves nothing behind
    auto fail = [&] {
        if (!fork_of.empty()) delete_dir_recursive(pc_patch_dir(q, patch));
        return 1;
    };

    // Compute shadowed files (files modified by patches above this one)
    // For each shadowed file, record the first patch above that tracks it
    // (needed to find its backup as the "new" side of the diff).
    std::set<std::string> shadowed;
    std::map<std::string, std::string> shadow_next_patch;
    if (fork_of.empty() && patch != q.applied.back()) {
        bool above = false;
        for (const auto &a : q.applied) {
            if (above) {
                auto above_files = files_in_patch(q, a);
                for (const auto &f : above_files) {
                    if (!shadowed.contains(f)) {
                        shadow_next_patch[f] = a;
                    }
                    shadowed.insert(f);
                }
            }
            if (a == patch) above = true;
        }
    }

    if (!shadowed.empty() && !force) {
        err("More recent patches modify files in patch ");
        err(patch_path_display(q, patch)); err_line(". Enforce refresh with -f.");
        return 1;
    }

    // Get files tracked by this patch
    auto tracked = files_in_patch(q, patch);
    if (sort_files) {
        std::ranges::sort(tracked);
    }

    // Read existing patch file for header
    std::string patch_file = path_join(q.work_dir, q.patches_dir, patch);
    std::string old_content;
    std::string header;
    if (file_exists(patch_file)) {
        old_content = read_file(patch_file);
        header = patch_header(old_content);
    }

    // Backup old patch file if requested
    if (opt_backup && file_exists(patch_file)) {
        copy_file(patch_file, patch_file + "~");
    }

    // Generate diffs
    std::string work_base = basename(q.work_dir);
    std::string patch_content = header;
    // The patch with trailing whitespace stripped from added lines, which
    // --strip-trailing-whitespace writes if it strips the files too
    std::string stripped_content = header;
    // Added lines (per file) with trailing whitespace, reported once every
    // diff has succeeded. Like upstream, which checks the whole generated
    // patch, this includes files shadowed by later patches.
    std::map<std::string, std::vector<ptrdiff_t>> ws_lines;
    bool files_were_shadowed = false;

    auto append_diff = [&](std::string &content, const std::string &file,
                           const std::string &diff) {
        if (diff.empty()) return;
        if (!no_index) {
            std::string idx_name;
            if (p_format == "0") idx_name = file;
            else if (p_format == "ab") idx_name = "b/" + file;
            else idx_name = work_base + "/" + file;
            content += "Index: " + idx_name + "\n";
            content += "===================================================================\n";
        }
        content += diff;
        // Ensure trailing newline
        if (content.back() != '\n') content += '\n';
    };

    for (const auto &file : tracked) {
        std::string diff_out;
        auto next = shadow_next_patch.find(file);
        if (next != shadow_next_patch.end()) {
            // Diff this patch's backup against the next patch's backup
            std::string this_backup = path_join(pc_patch_dir(q, patch), file);
            std::string next_backup = path_join(pc_patch_dir(q, next->second), file);
            diff_out = generate_path_diff(q, file,
                this_backup, true, next_backup, true,
                p_format, false, {}, ctx_lines, diff_format, no_timestamps,
                diff_algorithm);
            files_were_shadowed = true;
        } else {
            diff_out = generate_file_diff(q, patch, file, p_format,
                                          false, {}, ctx_lines,
                                          diff_format, no_timestamps,
                                          diff_algorithm);
        }
        if (diff_out.starts_with("Binary files ")) {
            err("Diff failed on file '"); err(file); err_line("', aborting");
            return fail();
        }
        // Like upstream, complain for this and every later file once one is
        // shadowed, but strip them all anyway
        if (files_were_shadowed && opt_strip_whitespace) {
            err_line("Cannot use --strip-trailing-whitespace on a patch that has shadowed files.");
        }
        std::string stripped = diff_out;
        auto lines = strip_diff_trailing_ws(stripped);
        if (!lines.empty()) ws_lines[file] = std::move(lines);
        append_diff(patch_content, file, diff_out);
        if (opt_strip_whitespace) append_diff(stripped_content, file, stripped);
    }

    // Like upstream, there is something in the patch when the diff is not
    // empty. The header may hold lines that look like a diff.
    bool has_diff = std::ssize(patch_content) != std::ssize(header);

    if (!fork_of.empty() && !has_diff) {
        err("Nothing in patch "); err_line(patch_path_display(q, patch));
        return fail();
    }

    // Like upstream's remove-trailing-ws, report (or strip) the files in name
    // order. A file that cannot be opened stops the stripping, and the patch
    // is then written unstripped.
    bool strip_patch = opt_strip_whitespace;
    for (const auto &[file, lines] : ws_lines) {
        std::string list;
        for (auto n : lines) {
            if (!list.empty()) list += ',';
            list += std::to_string(n);
        }
        if (!opt_strip_whitespace) {
            err(std::ssize(lines) == 1 ? "Warning: trailing whitespace in line "
                                       : "Warning: trailing whitespace in lines ");
            err(list); err(" of "); err_line(file);
            continue;
        }
        err(std::ssize(lines) == 1 ? "Removing trailing whitespace from line "
                                   : "Removing trailing whitespace from lines ");
        err(list); err(" of "); err_line(file);
        // A shadowed file's line numbers are those of the next patch's
        // backup, but like upstream (which has a FIXME for this), they are
        // stripped in the working file, which may be a later patch's line.
        // A file that a later patch deleted is missing.
        std::string path = path_join(q.work_dir, file);
        if (!file_exists(path)) {
            err(file); err_line(": No such file or directory");
            strip_patch = false;
            break;
        }
        if (!strip_file_trailing_ws(path, lines)) {
            err("Failed to write "); err_line(file);
            return fail();
        }
    }
    if (strip_patch) patch_content = std::move(stripped_content);

    // Add diffstat to header if requested
    if (opt_diffstat) {
        std::string diff_portion = patch_content.substr(checked_cast<size_t>(std::ssize(header)));
        if (!diff_portion.empty()) {
            std::string ds_out = generate_diffstat(diff_portion);
            if (!ds_out.empty()) {
                std::string clean_header = remove_diffstat_section(header);
                // Remove trailing blank lines from header
                while (std::ssize(clean_header) > 1 &&
                       clean_header[checked_cast<size_t>(std::ssize(clean_header) - 1)] == '\n' &&
                       clean_header[checked_cast<size_t>(std::ssize(clean_header) - 2)] == '\n') {
                    clean_header.pop_back();
                }
                patch_content = clean_header;
                if (!patch_content.empty() && patch_content.back() != '\n')
                    patch_content += '\n';
                patch_content += ds_out;
                if (!ds_out.empty() && ds_out.back() != '\n')
                    patch_content += '\n';
                patch_content += '\n';
                patch_content += diff_portion;
            }
        }
    }

    // Like upstream, refreshing clears the .needs_refresh marker left by a
    // forced push, even when the patch file does not change
    std::string nr = path_join(pc_patch_dir(q, patch), ".needs_refresh");

    // Leave an existing patch file alone if its content is unchanged, even
    // when there is nothing in it. Like upstream, "Nothing in patch" is only
    // for a patch file that gets written.
    if (patch_content == old_content && file_exists(patch_file)) {
        if (file_exists(nr)) {
            delete_file(nr);
        }
        out("Patch "); out(patch_path_display(q, patch));
        out_line(" is unchanged");
        return record_strip_level(q, patch, strip_level) ? 0 : 1;
    }

    // Ensure patches directory exists
    std::string patch_dir = dirname(patch_file);
    if (!is_directory(patch_dir)) {
        make_dirs(patch_dir);
    }

    // Write the patch file
    if (!write_file(patch_file, patch_content)) {
        err_line("Failed to write patch file " + patch_file);
        return fail();
    }

    if (!fork_of.empty()) {
        // Like upstream, insert the fork after the original (the top) with
        // the original's options. Refresh then records the strip level the
        // fork is written with, which defaults to the original's, and drops -R.
        if (!insert_in_series(q, patch, series_patch_args(q, fork_of),
                              q.patch_after_top())) {
            err_line("Failed to write series file.");
            delete_file(patch_file);
            return fail();
        }

        // Update applied: add fork after original
        q.applied.push_back(patch);
        std::string applied_path = path_join(q.work_dir, q.pc_dir, "applied-patches");
        write_applied(applied_path, q.applied);

        // The fork message replaces the "Refreshed patch" message
        out_line("Fork of patch " + patch_path_display(q, fork_of) +
                 " created as " + patch_path_display(q, patch));
    }

    // Update .timestamp
    write_file(path_join(pc_patch_dir(q, patch), ".timestamp"), "");

    // Clear .needs_refresh marker if present
    if (file_exists(nr)) {
        delete_file(nr);
    }

    if (fork_of.empty()) {
        if (!has_diff) {
            out("Nothing in patch "); out_line(patch_path_display(q, patch));
        } else {
            out("Refreshed patch "); out_line(patch_path_display(q, patch));
        }
    }
    return record_strip_level(q, patch, strip_level) ? 0 : 1;
}

int cmd_diff(QuiltState &q, int argc, char **argv) {
    // Parse options
    std::string_view patch_arg;
    std::string p_format;
    std::vector<std::string> file_filter;
    bool no_timestamps = !get_env("QUILT_NO_DIFF_TIMESTAMPS").empty();
    bool no_index = !get_env("QUILT_NO_DIFF_INDEX").empty();
    bool since_refresh = false;
    bool against_snapshot = false;
    bool reverse = false;
    bool sort_files = true;
    std::string diff_utility;
    std::optional<std::string_view> combine_arg;
    std::string diff_type = "u";
    std::string context_num;
    DiffAlgorithm diff_algorithm = DiffAlgorithm::myers;
    {
        auto env_algo = get_env("QUILT_DIFF_ALGORITHM");
        if (!env_algo.empty()) {
            auto parsed = parse_diff_algorithm(env_algo);
            if (!parsed) {
                err("Unknown diff algorithm: "); err_line(env_algo);
                return 1;
            }
            diff_algorithm = *parsed;
        }
    }
    int i = 1;

    while (i < argc) {
        std::string_view arg = argv[i];
        if (arg == "-P" && i + 1 < argc) {
            patch_arg = argv[i + 1];
            i += 2;
            continue;
        }
        if (arg == "-p" && i + 1 < argc) {
            p_format = std::string(argv[i + 1]);
            i += 2;
            continue;
        }
        if (arg.starts_with("-p") && std::ssize(arg) > 2) {
            p_format = std::string(arg.substr(2));
            i += 1;
            continue;
        }
        if (arg == "-u") {
            diff_type = "u";
            context_num.clear();
            i += 1;
            continue;
        }
        if (arg == "-c") {
            diff_type = "c";
            context_num.clear();
            i += 1;
            continue;
        }
        if (arg.starts_with("-C")) {
            diff_type = "C";
            if (arg == "-C" && i + 1 < argc) {
                context_num = argv[i + 1];
                i += 2;
            } else {
                context_num = std::string(arg.substr(2));
                i += 1;
            }
            continue;
        }
        if (arg.starts_with("-U")) {
            diff_type = "U";
            if (arg == "-U" && i + 1 < argc) {
                context_num = argv[i + 1];
                i += 2;
            } else {
                context_num = std::string(arg.substr(2));
                i += 1;
            }
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
        if (arg == "--combine" && i + 1 < argc) {
            combine_arg = argv[i + 1];
            i += 2;
            continue;
        }
        if (arg.starts_with("--combine=")) {
            combine_arg = arg.substr(10);
            i += 1;
            continue;
        }
        if (arg.starts_with("--diff=")) {
            diff_utility = std::string(arg.substr(7));
            i += 1;
            continue;
        }
        if (arg.starts_with("--diff-algorithm=")) {
            auto name = arg.substr(17);
            auto algo = parse_diff_algorithm(name);
            if (!algo) {
                err("Unknown diff algorithm: "); err_line(name);
                return 1;
            }
            diff_algorithm = *algo;
            i += 1;
            continue;
        }
        if (arg == "--diff-algorithm" && i + 1 < argc) {
            std::string_view name = argv[i + 1];
            auto algo = parse_diff_algorithm(name);
            if (!algo) {
                err("Unknown diff algorithm: "); err_line(name);
                return 1;
            }
            diff_algorithm = *algo;
            i += 2;
            continue;
        }
        if (arg == "--color" || arg.starts_with("--color=")) {
            if (!valid_color_option(arg)) {
                err_line("Usage: quilt diff [-p n|-p ab] [-u|-U num|-c|-C num] "
                         "[--combine patch|-z] [-R] [-P patch] [--snapshot] "
                         "[--diff=utility] [--no-timestamps] [--no-index] [--sort] "
                         "[--color[=always|auto|never]] [file ...]");
                return 1;
            }
            i += 1;
            continue;
        }
        if (arg.starts_with('-')) {
            err("Unrecognized option: "); err_line(arg);
            return 1;
        }
        // Non-option: file name. Like upstream, an empty name names no
        // file, unless the subdirectory prefix makes it one.
        std::string file = subdir_path(q, arg);
        if (!file.empty()) file_filter.push_back(std::move(file));
        i += 1;
    }

    if (!q.series_file_exists) {
        err_line("No series file found");
        return 1;
    }

    // Resolve --combine before -P, in the same order as upstream. Neither
    // "-" nor an empty name is looked up: "-" means the first applied
    // patch, and an empty name matches no patch in the range below.
    std::string combine_start;
    if (combine_arg && !combine_arg->empty() && *combine_arg != "-") {
        auto found = find_applied_patch(q, *combine_arg);
        if (!found) return 1;
        combine_start = *found;
    }

    if (since_refresh && against_snapshot) {
        err_line("Options `--snapshot' and `-z' cannot be combined.");
        return 1;
    }

    if (combine_arg && since_refresh) {
        err_line("Options `--combine' and `-z' cannot be combined.");
        return 1;
    }

    if (combine_arg && against_snapshot) {
        err_line("Options `--combine' and `--snapshot' cannot be combined.");
        return 1;
    }

    // No -P, or an empty one, means the top patch
    auto found = find_applied_patch(q, patch_arg);
    if (!found) return 1;
    std::string patch = *found;

    if (combine_arg) {
        if (*combine_arg == "-") {
            combine_start = q.applied.front();
        }
        if (combine_start.empty() ||
            std::ranges::find(q.applied, combine_start) > std::ranges::find(q.applied, patch)) {
            err("Patch "); err(format_patch(q, combine_start));
            err(" not applied before patch "); err_line(format_patch(q, patch));
            return 1;
        }
    }

    // Like the original quilt, validate the effective strip level, which
    // may come from the series file.
    if (p_format.empty()) {
        p_format = q.get_p_format(patch);
    }
    if (p_format != "0" && p_format != "1" && p_format != "ab") {
        err("Cannot diff patches with -p"); err(p_format);
        err_line(", please specify -p0, -p1, or -pab instead");
        return 1;
    }

    // Determine diff format and context lines for builtin diff
    DiffFormat diff_format = DiffFormat::unified;
    int ctx_lines = 3;
    if (diff_type == "c") {
        diff_format = DiffFormat::context;
    } else if (diff_type == "C") {
        diff_format = DiffFormat::context;
        ctx_lines = checked_cast<int>(parse_int(context_num));
    } else if (diff_type == "U") {
        ctx_lines = checked_cast<int>(parse_int(context_num));
    }

    // Build diff command base for external diff utility (empty = use builtin)
    bool convert_to_context = false;
    std::vector<std::string> diff_cmd_base;
    if (!diff_utility.empty()) {
        auto parts = split_on_whitespace(diff_utility);
        for (auto &p : parts) diff_cmd_base.push_back(std::move(p));
        // External diff: always request unified, convert to context in-process
        convert_to_context = (diff_type == "c" || diff_type == "C");
        if (diff_type == "U" || diff_type == "C") {
            diff_cmd_base.push_back("-U");
            diff_cmd_base.push_back(context_num);
        } else {
            diff_cmd_base.push_back("-u");
        }
    }

    auto emit_diff = [&](std::string_view d) {
        if (convert_to_context)
            out(unified_to_context(d));
        else
            out(d);
    };

    // A changed binary file is reported as "Binary files differ". The
    // original quilt aborts the whole command when diff fails, but with an
    // external --diff utility it ignores the utility's exit status.
    auto abort_on_binary = [&](std::string_view diff_out, std::string_view file) {
        if (diff_cmd_base.empty() && diff_out.starts_with("Binary files ")) {
            err("Diff failed on file '"); err(file); err_line("', aborting");
            return true;
        }
        return false;
    };

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
    } else if (!combine_start.empty()) {
        // Collect files across the combine range
        std::vector<std::string> combine_range;
        bool in_range = false;
        for (const auto &a : q.applied) {
            if (a == combine_start) in_range = true;
            if (in_range) combine_range.push_back(a);
            if (a == patch) break;
        }
        tracked = collect_files_for_patches(q, combine_range);
    } else {
        tracked = files_in_patch(q, patch);
    }

    apply_file_filter(tracked, file_filter);

    if (sort_files) {
        std::ranges::sort(tracked);
    }

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

        bool files_were_shadowed = false;

        for (const auto &file : tracked) {
            std::string backup_path = path_join(pc_patch_dir(q, patch), file);
            std::string working_path = path_join(q.work_dir, file);
            std::string tmp_file = path_join(tmp_dir, file);

            // Ensure temp subdirectory exists
            std::string tmp_file_dir = dirname(tmp_file);
            if (!is_directory(tmp_file_dir)) {
                make_dirs(tmp_file_dir);
            }

            // Rebuild the refreshed state as the original quilt does: start
            // from the backup (an empty backup means the file did not
            // exist), then apply this file's section of the stored patch.
            // The result is removed only if the section deletes the file;
            // a file the patch merely empties stays as an empty file.
            if (file_exists(backup_path) && !is_placeholder_copy(backup_path)) {
                write_file(tmp_file, read_file(backup_path));
            }

            // Apply stored patch section to temp file
            auto it = stored_sections.find(file);
            if (it != stored_sections.end() && !it->second.empty()) {
                // Build a minimal patch with correct paths for -p0
                std::string mini_patch = "--- " + file + "\n+++ " + file + "\n";
                // Extract just the hunk lines from the stored section
                auto section_lines = split_lines(it->second);
                bool in_hunk = false;
                bool deletes_file = false;
                for (const auto &sl : section_lines) {
                    if (sl.starts_with("@@")) {
                        in_hunk = true;
                        mini_patch += sl + "\n";
                    } else if (in_hunk) {
                        mini_patch += sl + "\n";
                    } else if (sl.starts_with("+++ /dev/null")) {
                        deletes_file = true;
                    }
                }
                if (in_hunk) {
                    if (!file_exists(tmp_file)) write_file(tmp_file, "");
                    std::string saved_cwd = get_cwd();
                    if (set_cwd(tmp_dir)) {
                        PatchOptions po;
                        po.strip_level = 0;
                        po.quiet = true;
                        builtin_patch(mini_patch, po);
                        set_cwd(saved_cwd);
                    }
                    if (deletes_file) delete_file(tmp_file);
                }
            }

            // Diff the reconstructed "refreshed" file against the working
            // file or, if a later applied patch modifies this file, against
            // that patch's backup. The original quilt warns about shadowed
            // files after the loop.
            std::string new_src = working_path;
            std::string shadowing_patch = next_patch_for_file(q, patch, file);
            if (!shadowing_patch.empty()) {
                files_were_shadowed = true;
                new_src = path_join(pc_patch_dir(q, shadowing_patch), file);
            }
            if (!file_exists(new_src) && !file_exists(tmp_file)) continue;

            std::string old_label, new_label;
            if (p_format == "ab") {
                old_label = "a/" + file;
                new_label = "b/" + file;
            } else if (p_format == "0") {
                old_label = file + ".orig";
                new_label = file;
            } else {
                old_label = work_base + ".orig/" + file;
                new_label = work_base + "/" + file;
            }

            std::string old_f = tmp_file;
            std::string new_f = new_src;
            if (reverse) {
                std::swap(old_f, new_f);
            }
            // As in the original quilt, a missing or empty old file and a
            // missing new file are diffed as /dev/null.
            if (!file_exists(old_f) || read_file(old_f).empty()) {
                old_f = "/dev/null";
                old_label = "/dev/null";
            }
            if (!file_exists(new_f)) {
                if (p_format == "0") old_label = new_label;
                new_f = "/dev/null";
                new_label = "/dev/null";
            }

            std::string diff_out;
            if (diff_cmd_base.empty()) {
                std::string old_data = old_f == "/dev/null" ? std::string() : read_file(old_f);
                std::string new_data = new_f == "/dev/null" ? std::string() : read_file(new_f);
                if (old_data != new_data &&
                    (is_binary_data(old_data) || is_binary_data(new_data))) {
                    diff_out = "Binary files differ\n";
                } else {
                    // Use built-in diff
                    int ctx = ctx_lines;
                    auto extra_diff_opts = shell_split(get_env("QUILT_DIFF_OPTS"));
                    int opts_ctx = parse_diff_opts_context(extra_diff_opts);
                    if (opts_ctx >= 0) ctx = opts_ctx;

                    DiffResult dr = builtin_diff(old_f, new_f, ctx,
                                                 old_label, new_label, diff_format,
                                                 diff_algorithm);
                    diff_out = std::move(dr.output);
                }
            } else {
                std::vector<std::string> diff_cmd = diff_cmd_base;
                auto extra_diff_opts = shell_split(get_env("QUILT_DIFF_OPTS"));
                for (const auto &opt : extra_diff_opts) diff_cmd.push_back(opt);
                diff_cmd.push_back("--label");
                diff_cmd.push_back(old_label);
                diff_cmd.push_back("--label");
                diff_cmd.push_back(new_label);
                diff_cmd.push_back(old_f);
                diff_cmd.push_back(new_f);

                ProcessResult result = run_cmd(diff_cmd);
                if (result.exit_code == 1) {
                    diff_out = std::move(result.out);
                }
            }
            if (abort_on_binary(diff_out, file)) {
                delete_dir_recursive(tmp_dir);
                return 1;
            }
            if (!diff_out.empty()) {
                if (!no_index) {
                    out("Index: " + (p_format == "0" ? file : p_format == "ab" ? "b/" + file : work_base + "/" + file) + "\n");
                    out("===================================================================\n");
                }
                emit_diff(diff_out);
            }
        }

        if (files_were_shadowed) {
            err("Warning: more recent patches modify files in patch ");
            err_line(patch_path_display(q, patch));
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
                p_format, reverse, diff_cmd_base, ctx_lines, diff_format,
                no_timestamps, diff_algorithm);
            if (abort_on_binary(diff_out, file)) return 1;
            if (!diff_out.empty()) {
                if (!no_index) {
                    out("Index: " + (p_format == "0" ? file : p_format == "ab" ? "b/" + file : work_base + "/" + file) + "\n");
                    out("===================================================================\n");
                }
                emit_diff(diff_out);
            }
        }
    } else if (!combine_start.empty()) {
        // --combine: diff backup from the earliest patch in range against working file
        for (const auto &file : tracked) {
            // Find the earliest patch in the combine range that tracks this file
            std::string earliest;
            bool in_range = false;
            for (const auto &a : q.applied) {
                if (a == combine_start) in_range = true;
                if (in_range) {
                    auto fip = files_in_patch(q, a);
                    if (std::ranges::find(fip, file) != fip.end()) {
                        earliest = a;
                        break;
                    }
                }
                if (a == patch) break;
            }
            if (earliest.empty()) continue;

            std::string old_path = path_join(pc_patch_dir(q, earliest), file);
            std::string new_path = path_join(q.work_dir, file);
            bool new_placeholder = false;

            // If a patch above the range shadows this file, use its backup
            std::string shadowing_patch = next_patch_for_file(q, patch, file);
            if (!shadowing_patch.empty()) {
                new_path = path_join(pc_patch_dir(q, shadowing_patch), file);
                new_placeholder = true;
            }

            std::string diff_out = generate_path_diff(
                q, file, old_path, true, new_path, new_placeholder,
                p_format, reverse, diff_cmd_base, ctx_lines, diff_format,
                no_timestamps, diff_algorithm);
            if (abort_on_binary(diff_out, file)) return 1;
            if (!diff_out.empty()) {
                if (!no_index) {
                    out("Index: " + (p_format == "0" ? file : p_format == "ab" ? "b/" + file : work_base + "/" + file) + "\n");
                    out("===================================================================\n");
                }
                emit_diff(diff_out);
            }
        }
    } else {
        // Warn if more recent patches modify files in this patch
        bool warned_shadowing = false;
        for (const auto &file : tracked) {
            std::string shadowing = next_patch_for_file(q, patch, file);
            if (!shadowing.empty() && !warned_shadowing) {
                err("Warning: more recent patches modify files in patch ");
                err_line(patch_path_display(q, patch));
                warned_shadowing = true;
            }

            std::string old_path = path_join(pc_patch_dir(q, patch), file);
            std::string new_path = path_join(q.work_dir, file);
            bool new_placeholder = false;

            // If a patch above this one shadows the file, use its backup
            if (!shadowing.empty()) {
                new_path = path_join(pc_patch_dir(q, shadowing), file);
                new_placeholder = true;
            }

            std::string diff_out = generate_path_diff(
                q, file, old_path, true, new_path, new_placeholder,
                p_format, reverse, diff_cmd_base, ctx_lines, diff_format,
                no_timestamps, diff_algorithm);
            if (abort_on_binary(diff_out, file)) return 1;
            if (!diff_out.empty()) {
                if (!no_index) {
                    out("Index: " + (p_format == "0" ? file : p_format == "ab" ? "b/" + file : work_base + "/" + file) + "\n");
                    out("===================================================================\n");
                }
                emit_diff(diff_out);
            }
        }
    }

    return 0;
}

// The backup of a file named as the user typed it. Unlike path_join,
// concatenation keeps an absolute name inside the .pc directory, as
// upstream's "$QUILT_PC/$patch/$file" does.
static std::string revert_backup_path(const QuiltState &q, std::string_view patch,
                                      std::string_view file) {
    return pc_patch_dir(q, patch) + "/" + std::string(file);
}

// Like upstream's file_in_patch: the backup must be a regular file, and
// it is looked up through the filesystem, so "./f" and "d/../f" find the
// backup of "f".
static bool revert_file_in_patch(const QuiltState &q, std::string_view patch,
                                 std::string_view file) {
    std::string path = revert_backup_path(q, patch, file);
    return file_exists(path) && !is_directory(path);
}

// Lexically normalize a relative path ("./f", "d//f", "d/../f" become
// "f"), the form builtin_patch uses for file names.
static std::string normalize_relative_path(std::string_view path) {
    std::vector<std::string_view> parts;
    while (!path.empty()) {
        ptrdiff_t slash = str_find(path, '/');
        std::string_view part = path;
        if (slash < 0) {
            path = {};
        } else {
            part = path.substr(0, checked_cast<size_t>(slash));
            path.remove_prefix(checked_cast<size_t>(slash + 1));
        }
        if (part.empty() || part == ".") continue;
        if (part == ".." && !parts.empty() && parts.back() != "..") {
            parts.pop_back();
        } else {
            parts.push_back(part);
        }
    }
    std::string result;
    for (auto part : parts) {
        if (!result.empty()) result += '/';
        result += part;
    }
    return result;
}

int cmd_revert(QuiltState &q, int argc, char **argv) {
    // Parse options
    std::string_view patch_arg;
    std::vector<std::string> files;
    int i = 1;
    while (i < argc) {
        std::string_view arg = argv[i];
        if (arg == "-P" && i + 1 < argc) {
            patch_arg = argv[i + 1];
            i += 2;
            continue;
        }
        if (!arg.starts_with('-')) {
            files.push_back(subdir_path(q, arg));
        } else {
            err("Unrecognized option: "); err_line(arg);
            return 1;
        }
        i += 1;
    }

    if (files.empty()) {
        err_line("Usage: quilt revert [-P patch] file ...");
        return 1;
    }

    // No -P, or an empty one, means the top patch
    auto found = find_applied_patch(q, patch_arg);
    if (!found) return 1;
    std::string patch = *found;

    // Check every file before changing any, reporting each problem
    int status = 0;
    for (const auto &file : files) {
        if (!revert_file_in_patch(q, patch, file)) {
            err("File "); err(file); err(" is not in patch ");
            err_line(patch_path_display(q, patch));
            status = 1;
            continue;
        }
        auto later = std::ranges::find(q.applied, patch);
        for (++later; later != q.applied.end(); ++later) {
            if (revert_file_in_patch(q, *later, file)) {
                out("File "); out(file); out(" modified by patch ");
                out_line(patch_path_display(q, *later));
                status = 1;
                break;
            }
        }
    }
    if (status != 0) return status;

    // Read the patch file to apply its hunks to backup content
    std::string patch_file = path_join(q.work_dir, q.patches_dir, patch);
    std::string patch_text = read_file(patch_file);
    int strip_level = q.patch_strip_level.count(patch)
        ? q.patch_strip_level.at(patch) : 1;

    for (const auto &file : files) {
        // Build the clean post-patch state by applying patch to backup,
        // under the name the patch uses for the file
        std::string backup_content = read_file(revert_backup_path(q, patch, file));
        std::string name = normalize_relative_path(file);
        std::map<std::string, std::string> memfs;
        memfs[name] = backup_content;
        PatchOptions opts;
        opts.strip_level = strip_level;
        opts.reverse = q.patch_reversed.contains(patch);
        opts.quiet = true;
        opts.fs = &memfs;
        builtin_patch(patch_text, opts);

        std::string clean_content = memfs.count(name) ? memfs[name] : "";

        // Check if current file matches clean state (unchanged)
        std::string target = path_join(q.work_dir, file);
        std::string current = file_exists(target) ? read_file(target) : "";
        if (current == clean_content) {
            out("File "); out(file);
            out_line(" is unchanged");
            continue;
        }

        // Write the clean post-patch state
        if (clean_content.empty()) {
            // Post-patch state is empty — either file was deleted by patch
            // or didn't exist.  Remove the working-tree copy.
            delete_file(target);
            out("Changes to "); out(file); out(" in patch ");
            out(patch_path_display(q, patch)); out_line(" reverted");
            continue;
        }

        std::string target_dir = dirname(target);
        if (!is_directory(target_dir)) {
            make_dirs(target_dir);
        }
        if (!write_file(target, clean_content)) {
            err("Failed to restore "); err_line(file);
            return 1;
        }

        out("Changes to "); out(file); out(" in patch ");
        out(patch_path_display(q, patch)); out_line(" reverted");
    }

    return 0;
}
