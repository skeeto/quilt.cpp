// This is free and unencumbered software released into the public domain.
#include "quilt.hpp"
#include "platform.hpp"

#include <cstring>
#include <cstdlib>
#include <set>

static std::string read_patch_header(std::string_view patch_path) {
    std::string content = read_file(patch_path);
    if (content.empty()) return "";

    std::string header;
    auto lines = split_lines(content);
    for (const auto &line : lines) {
        if (line.starts_with("Index:") ||
            line.starts_with("---") ||
            line.starts_with("diff ")) {
            break;
        }
        header += line;
        header += '\n';
    }
    return header;
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
        if (!write_series(series_abs, {}, {}, {})) {
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

    // Insert patch name into series (after current top, or at beginning)
    ptrdiff_t top_idx = q.top_index();
    if (!q.applied.empty() && top_idx < 0) {
        err_line("The series file no longer matches the applied patches. Please run 'quilt pop -a'.");
        return 1;
    }
    if (top_idx < 0) {
        // No applied patches — insert at beginning
        q.series.insert(q.series.begin(), patch_name);
    } else {
        // Insert after the current top
        q.series.insert(q.series.begin() + top_idx + 1, patch_name);
    }

    // Validate strip level
    if (!p_value.empty() && p_value != "0" && p_value != "1") {
        err_line("Cannot create patches with -p" + p_value +
                 ", please specify -p0 or -p1 instead");
        return 1;
    }

    // Store strip level
    if (!p_value.empty() && p_value != "1") {
        q.patch_strip_level[patch_name] = std::stoi(p_value);
    }

    // Write series file
    std::string series_abs = path_join(q.work_dir, q.series_file);
    if (!write_series(series_abs, q.series, q.patch_strip_level, q.patch_reversed)) {
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
    std::string_view patch = q.applied.back();
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

    if (!q.is_applied(patch)) {
        err("Patch "); err(format_patch(q, patch)); err_line(" is not applied");
        return 1;
    }

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
    if (q.applied.empty()) {
        err_line("No patches applied");
        return 1;
    }

    // Parse options
    std::string_view patch = q.applied.back();
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

    if (!q.is_applied(patch)) {
        err("Patch "); err(format_patch(q, patch)); err_line(" is not applied");
        return 1;
    }

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
                                      bool no_timestamps = false) {
    bool old_missing = old_path.empty() || !file_exists(old_path) ||
        (old_placeholder && is_placeholder_copy(old_path));
    bool new_missing = new_path.empty() || !file_exists(new_path) ||
        (new_placeholder && is_placeholder_copy(new_path));

    // Detect binary files (null bytes in first 8 KB)
    auto is_binary = [](std::string_view path) {
        std::string data = read_file(path);
        size_t check_len = data.size() < 8192 ? data.size() : 8192;
        return data.find('\0', 0) < check_len;
    };
    if ((!old_missing && is_binary(old_path)) ||
        (!new_missing && is_binary(new_path))) {
        return "Binary files differ\n";
    }

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

    // Append file timestamps unless suppressed
    if (!no_timestamps) {
        if (!old_missing)
            old_label += format_file_timestamp(old_path);
        if (!new_missing)
            new_label += format_file_timestamp(new_path);
    }

    if (reverse) {
        std::swap(old_arg, new_arg);
    }

    // Use built-in diff when no external diff utility is specified
    if (diff_cmd_base.empty()) {
        int ctx = context_lines;
        // QUILT_DIFF_OPTS may override context lines
        auto extra_diff_opts = shell_split(get_env("QUILT_DIFF_OPTS"));
        int opts_ctx = parse_diff_opts_context(extra_diff_opts);
        if (opts_ctx >= 0) ctx = opts_ctx;

        DiffResult result = builtin_diff(old_arg, new_arg, ctx,
                                          old_label, new_label, diff_format);
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
                                      bool no_timestamps = false) {
    std::string backup_path = path_join(pc_patch_dir(q, patch), file);
    std::string working_path = path_join(q.work_dir, file);
    return generate_path_diff(q, file, backup_path, true, working_path, false,
                              p_format, reverse, diff_cmd_base,
                              context_lines, diff_format, no_timestamps);
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

// Strip trailing whitespace from diff output lines.
// Returns the cleaned diff and emits warnings to stderr.

int cmd_refresh(QuiltState &q, int argc, char **argv) {
    if (q.applied.empty()) {
        err_line("No patches applied");
        return 1;
    }

    // Parse options
    std::string patch;
    std::string p_format;
    bool explicit_p = false;
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

    while (i < argc) {
        std::string_view arg = argv[i];
        if (arg == "-p" && i + 1 < argc) {
            p_format = std::string(argv[i + 1]);
            explicit_p = true;
            i += 2;
            continue;
        }
        if (arg.starts_with("-p") && std::ssize(arg) > 2) {
            p_format = std::string(arg.substr(2));
            explicit_p = true;
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
        if (arg[0] == '-') {
            err("Unrecognized option: "); err_line(arg);
            return 1;
        }
        // Non-option: patch name
        if (patch.empty()) {
            patch = arg;
        }
        i += 1;
    }

    if (patch.empty()) {
        patch = q.applied.back();
    }

    if (!explicit_p) {
        p_format = q.get_p_format(patch);
    }

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
    // tree.
    if (opt_fork) {
        if (patch != q.applied.back()) {
            err_line("Can only use -z with the topmost applied patch");
            return 1;
        }
        std::string old_name(patch);

        // Generate fork name
        std::string new_name;
        if (!fork_name.empty()) {
            new_name = fork_name;
        } else {
            auto dot = str_rfind(old_name, '.');
            if (dot > 0) {
                new_name = old_name.substr(0, checked_cast<size_t>(dot)) + "-2" + old_name.substr(checked_cast<size_t>(dot));
            } else {
                new_name = old_name + "-2";
            }
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

        // Write .timestamp for the fork
        write_file(path_join(new_pc, ".timestamp"), "");

        // Migrate per-patch metadata to fork
        auto sl_it = q.patch_strip_level.find(old_name);
        if (sl_it != q.patch_strip_level.end()) {
            q.patch_strip_level[new_name] = sl_it->second;
        }
        if (q.patch_reversed.contains(old_name)) {
            q.patch_reversed.insert(new_name);
        }

        // Insert new patch after original in series
        q.series.insert(q.series.begin() + *idx + 1, new_name);
        std::string series_abs = path_join(q.work_dir, q.series_file);
        if (!write_series(series_abs, q.series, q.patch_strip_level, q.patch_reversed)) {
            err_line("Failed to write series file.");
            return 1;
        }

        // Update applied: add fork after original
        q.applied.push_back(new_name);
        std::string applied_path = path_join(q.work_dir, q.pc_dir, "applied-patches");
        write_applied(applied_path, q.applied);

        out_line("Fork of patch " + patch_path_display(q, old_name) +
                 " created as " + patch_path_display(q, new_name));
        patch = new_name;
    }

    // Compute shadowed files (files modified by patches above this one)
    // For each shadowed file, record the first patch above that tracks it
    // (needed to find its backup as the "new" side of the diff).
    std::set<std::string> shadowed;
    std::map<std::string, std::string> shadow_next_patch;
    if (patch != q.applied.back()) {
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
        header = read_patch_header(patch_file);
    }

    // Backup old patch file if requested
    if (opt_backup && file_exists(patch_file)) {
        copy_file(patch_file, patch_file + "~");
    }

    // Generate diffs
    std::string work_base = basename(q.work_dir);
    std::string patch_content = header;

    for (const auto &file : tracked) {
        if (shadowed.contains(file)) {
            // Diff this patch's backup against the next patch's backup
            auto it = shadow_next_patch.find(file);
            if (it != shadow_next_patch.end()) {
                std::string this_backup = path_join(pc_patch_dir(q, patch), file);
                std::string next_backup = path_join(pc_patch_dir(q, it->second), file);
                std::string diff_out = generate_path_diff(q, file,
                    this_backup, true, next_backup, true,
                    p_format, false, {}, ctx_lines, diff_format, no_timestamps);
                if (!diff_out.empty()) {
                    if (!no_index) {
                        std::string idx_name;
                        if (p_format == "0") idx_name = file;
                        else if (p_format == "ab") idx_name = "b/" + file;
                        else idx_name = basename(q.work_dir) + "/" + file;
                        patch_content += "Index: " + idx_name + "\n";
                        patch_content += "===================================================================\n";
                    }
                    patch_content += diff_out;
                    if (!patch_content.empty() && patch_content.back() != '\n') {
                        patch_content += '\n';
                    }
                }
            }
            continue;
        }
        // Strip trailing whitespace from working file before diffing
        if (opt_strip_whitespace) {
            std::string working_path = path_join(q.work_dir, file);
            if (file_exists(working_path)) {
                std::string content = read_file(working_path);
                std::string stripped;
                auto lines = split_lines(content);
                int lineno = 0;
                for (const auto &line : lines) {
                    lineno++;
                    std::string_view l = line;
                    auto end = l.find_last_not_of(" \t");
                    if (end == std::string::npos) {
                        if (!l.empty()) {
                            out_line("Removing trailing whitespace from line "
                                     + std::to_string(lineno) + " of " + file);
                        }
                        stripped += '\n';
                    } else if (static_cast<ptrdiff_t>(end) + 1 < std::ssize(l)) {
                        out_line("Removing trailing whitespace from line "
                                 + std::to_string(lineno) + " of " + file);
                        stripped += l.substr(0, end + 1);
                        stripped += '\n';
                    } else {
                        stripped += l;
                        stripped += '\n';
                    }
                }
                if (stripped != content) {
                    write_file(working_path, stripped);
                }
            }
        }

        std::string diff_out = generate_file_diff(q, patch, file, p_format,
                                                   false, {}, ctx_lines,
                                                   diff_format, no_timestamps);
        if (diff_out.starts_with("Binary files ")) {
            err("Diff failed on file '"); err(file); err_line("', aborting");
            return 1;
        }
        if (!diff_out.empty()) {
            if (!no_index) {
                std::string idx_name;
                if (p_format == "0") idx_name = file;
                else if (p_format == "ab") idx_name = "b/" + file;
                else idx_name = work_base + "/" + file;
                patch_content += "Index: " + idx_name + "\n";
                patch_content += "===================================================================\n";
            }
            patch_content += diff_out;
            // Ensure trailing newline
            if (!patch_content.empty() && patch_content.back() != '\n') {
                patch_content += '\n';
            }
        }
    }

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

    // Check if patch has no diff hunks
    bool has_diff = false;
    for (auto &line : split_lines(patch_content)) {
        if (line.starts_with("--- ") || line.starts_with("diff ")) {
            has_diff = true;
            break;
        }
    }

    // Check if patch content is unchanged (only skip write if file exists)
    if (patch_content == old_content && file_exists(patch_file)) {
        if (!has_diff) {
            out("Nothing in patch "); out_line(patch_path_display(q, patch));
        } else {
            out("Patch "); out(patch_path_display(q, patch));
            out_line(" is unchanged");
        }
        return 0;
    }

    // Ensure patches directory exists
    std::string patch_dir = dirname(patch_file);
    if (!is_directory(patch_dir)) {
        make_dirs(patch_dir);
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

    if (!has_diff) {
        out("Nothing in patch "); out_line(patch_path_display(q, patch));
    } else {
        out("Refreshed patch "); out_line(patch_path_display(q, patch));
    }
    return 0;
}

int cmd_diff(QuiltState &q, int argc, char **argv) {
    if (q.applied.empty()) {
        err_line("No patches applied");
        return 1;
    }

    // Parse options
    std::string_view patch;
    std::string p_format;
    bool explicit_p = false;
    std::vector<std::string> file_filter;
    bool no_timestamps = !get_env("QUILT_NO_DIFF_TIMESTAMPS").empty();
    bool no_index = !get_env("QUILT_NO_DIFF_INDEX").empty();
    bool since_refresh = false;
    bool against_snapshot = false;
    bool reverse = false;
    bool sort_files = true;
    std::string diff_utility;
    std::string combine_patch;
    std::string diff_type = "u";
    std::string context_num;
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
            explicit_p = true;
            i += 2;
            continue;
        }
        if (arg.starts_with("-p") && std::ssize(arg) > 2) {
            p_format = std::string(arg.substr(2));
            explicit_p = true;
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
            combine_patch = argv[i + 1];
            i += 2;
            continue;
        }
        if (arg.starts_with("--combine=")) {
            combine_patch = std::string(arg.substr(10));
            i += 1;
            continue;
        }
        if (arg.starts_with("--diff=")) {
            diff_utility = std::string(arg.substr(7));
            i += 1;
            continue;
        }
        if (arg == "--color" || arg.starts_with("--color=")) {
            if (arg.starts_with("--color=")) {
                auto val = arg.substr(8);
                if (val != "always" && val != "auto" && val != "never") {
                    err("Invalid --color value: "); err_line(val);
                    return 1;
                }
            }
            i += 1;
            continue;
        }
        if (arg[0] == '-') {
            err("Unrecognized option: "); err_line(arg);
            return 1;
        }
        // Non-option: file name or patch name
        if (arg[0] != '-') {
            file_filter.push_back(subdir_path(q, arg));
        }
        i += 1;
    }

    if (patch.empty()) {
        patch = q.applied.back();
    }

    if (!explicit_p) {
        p_format = q.get_p_format(patch);
    }

    if (since_refresh && against_snapshot) {
        err_line("Options `--snapshot' and `-z' cannot be combined.");
        return 1;
    }

    if (!combine_patch.empty() && since_refresh) {
        err_line("Options `--combine' and `-z' cannot be combined.");
        return 1;
    }

    if (!combine_patch.empty() && against_snapshot) {
        err_line("Options `--combine' and `--snapshot' cannot be combined.");
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

    // Resolve --combine patch name
    std::string combine_start;
    if (!combine_patch.empty()) {
        if (combine_patch == "-") {
            combine_start = q.applied.front();
        } else {
            combine_start = strip_patches_prefix(q, combine_patch);
        }
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
                    if (sl.starts_with("@@")) {
                        in_hunk = true;
                        mini_patch += sl + "\n";
                    } else if (in_hunk) {
                        mini_patch += sl + "\n";
                    }
                }
                if (in_hunk) {
                    std::string saved_cwd = get_cwd();
                    if (set_cwd(tmp_dir)) {
                        PatchOptions po;
                        po.strip_level = 0;
                        po.remove_empty = true;
                        po.quiet = true;
                        builtin_patch(mini_patch, po);
                        set_cwd(saved_cwd);
                    }
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
            }

            std::string diff_out;
            if (diff_cmd_base.empty()) {
                // Use built-in diff
                int ctx = ctx_lines;
                auto extra_diff_opts = shell_split(get_env("QUILT_DIFF_OPTS"));
                int opts_ctx = parse_diff_opts_context(extra_diff_opts);
                if (opts_ctx >= 0) ctx = opts_ctx;

                DiffResult dr = builtin_diff(old_f, new_f, ctx,
                                             old_label, new_label, diff_format);
                diff_out = std::move(dr.output);
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
            if (!diff_out.empty()) {
                if (!no_index) {
                    out("Index: " + (p_format == "0" ? file : p_format == "ab" ? "b/" + file : work_base + "/" + file) + "\n");
                    out("===================================================================\n");
                }
                emit_diff(diff_out);
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
                p_format, reverse, diff_cmd_base, ctx_lines, diff_format,
                no_timestamps);
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
                no_timestamps);
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
                no_timestamps);
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

int cmd_revert(QuiltState &q, int argc, char **argv) {
    if (q.applied.empty()) {
        err_line("No patches applied");
        return 1;
    }

    // Parse options
    std::string_view patch = q.applied.back();
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

    if (!q.is_applied(patch)) {
        err("Patch "); err(format_patch(q, patch)); err_line(" is not applied");
        return 1;
    }

    // Check if any later applied patch also modifies these files
    bool found_patch = false;
    for (const auto &ap : q.applied) {
        if (!found_patch) {
            if (ap == patch) found_patch = true;
            continue;
        }
        // ap is a patch applied after 'patch'
        auto later_files = files_in_patch(q, ap);
        for (const auto &file : files) {
            for (const auto &lf : later_files) {
                if (lf == file) {
                    err("File "); err(file);
                    err(" modified by patch ");
                    err_line(patch_path_display(q, ap));
                    return 1;
                }
            }
        }
    }

    // Read the patch file to apply its hunks to backup content
    std::string patch_file = path_join(q.work_dir, q.patches_dir, patch);
    std::string patch_text = read_file(patch_file);
    int strip_level = q.patch_strip_level.count(std::string(patch))
        ? q.patch_strip_level.at(std::string(patch)) : 1;

    for (const auto &file : files) {
        // Check if file is tracked by the patch
        std::string backup_path = path_join(pc_patch_dir(q, patch), file);
        if (!file_exists(backup_path)) {
            err("File "); err(file); err(" is not in patch ");
            err_line(patch_path_display(q, patch));
            return 1;
        }

        // Build the clean post-patch state by applying patch to backup
        std::string backup_content = read_file(backup_path);
        std::map<std::string, std::string> memfs;
        memfs[file] = backup_content;
        PatchOptions opts;
        opts.strip_level = strip_level;
        opts.quiet = true;
        opts.fs = &memfs;
        builtin_patch(patch_text, opts);

        std::string clean_content = memfs.count(file) ? memfs[file] : "";

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
