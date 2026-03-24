// This is free and unencumbered software released into the public domain.
#include "quilt.hpp"
#include "platform.hpp"

// Forward declarations for helpers defined in core.cpp
extern std::vector<Str> read_series(StrView path);
extern bool write_series(StrView path, const std::vector<Str> &patches);
extern std::vector<Str> read_applied(StrView path);
extern bool write_applied(StrView path, const std::vector<Str> &patches);
extern bool ensure_pc_dir(QuiltState &q);
extern Str pc_patch_dir(const QuiltState &q, StrView patch);
extern std::vector<Str> files_in_patch(const QuiltState &q, StrView patch);
extern bool backup_file(QuiltState &q, StrView patch, StrView file);
extern bool restore_file(QuiltState &q, StrView patch, StrView file);

// ---------------------------------------------------------------------------
// Helper: strip "patches/" prefix from user-provided patch name
// ---------------------------------------------------------------------------

static Str strip_patches_prefix(const QuiltState &q, StrView name) {
    Str prefix = q.patches_dir + "/";
    if (starts_with(name, prefix)) {
        return Str(name.substr(prefix.size()));
    }
    return Str(name);
}

// ---------------------------------------------------------------------------
// Helper: parse a patch file to extract filenames from +++ lines
// ---------------------------------------------------------------------------

static std::vector<Str> parse_patch_files(StrView content) {
    std::vector<Str> files;
    auto lines = split_lines(content);
    for (const auto &line : lines) {
        if (!starts_with(line, "+++ ")) continue;
        Str path = Str(StrView(line).substr(4));
        // Strip trailing tab and anything after (timestamps)
        auto tab = path.find('\t');
        if (tab != Str::npos) {
            path = Str(path.substr(0, tab));
        }
        // Strip b/ prefix
        if (starts_with(path, "b/")) {
            path = Str(StrView(path).substr(2));
        }
        // Skip /dev/null
        if (path == "/dev/null") continue;
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

// ---------------------------------------------------------------------------
// Helper: extract header from a patch file
// Header is everything before the first diff/Index/---/=== line.
// ---------------------------------------------------------------------------

static Str extract_header(StrView content) {
    Str header;
    auto lines = split_lines(content);
    for (const auto &line : lines) {
        if (starts_with(line, "Index:") ||
            starts_with(line, "--- ") ||
            starts_with(line, "diff ") ||
            starts_with(line, "===")) {
            break;
        }
        header += line;
        header += '\n';
    }
    return header;
}

// ---------------------------------------------------------------------------
// Helper: replace header in a patch file (everything before first diff line)
// ---------------------------------------------------------------------------

static Str replace_header(StrView content, StrView new_header) {
    Str result;
    auto lines = split_lines(content);
    bool in_diff = false;
    // Find where diffs start
    size_t diff_start = 0;
    for (size_t i = 0; i < lines.size(); ++i) {
        if (starts_with(lines[i], "Index:") ||
            starts_with(lines[i], "--- ") ||
            starts_with(lines[i], "diff ") ||
            starts_with(lines[i], "===")) {
            diff_start = i;
            in_diff = true;
            break;
        }
    }

    result += Str(new_header);
    // Ensure header ends with newline if non-empty
    if (!result.empty() && result.back() != '\n') {
        result += '\n';
    }

    if (in_diff) {
        for (size_t i = diff_start; i < lines.size(); ++i) {
            result += lines[i];
            result += '\n';
        }
    }
    return result;
}

// ---------------------------------------------------------------------------
// Helper: pop patches down to (and including) a target patch
// Returns 0 on success, 1 on error.
// ---------------------------------------------------------------------------

static int pop_to_patch(QuiltState &q, StrView patch) {
    // Pop all applied patches from top until patch is removed
    Str applied_path = path_join(q.work_dir, q.pc_dir, "applied-patches");
    while (!q.applied.empty()) {
        Str top = q.applied.back();
        // Restore files
        auto tracked = files_in_patch(q, top);
        for (const auto &f : tracked) {
            restore_file(q, top, f);
        }
        // Remove .pc/<patch>/ directory
        Str pc_dir = pc_patch_dir(q, top);
        delete_dir_recursive(pc_dir);
        q.applied.pop_back();
        write_applied(applied_path, q.applied);

        if (top == patch) break;
    }
    return 0;
}

// ---------------------------------------------------------------------------
// cmd_delete
// ---------------------------------------------------------------------------

int cmd_delete(QuiltState &q, int argc, char **argv) {
    bool opt_remove = false;
    bool opt_backup = false;
    bool opt_next = false;
    Str patch_arg;

    for (int i = 1; i < argc; ++i) {
        StrView arg = argv[i];
        if (arg == "-r") {
            opt_remove = true;
        } else if (arg == "--backup") {
            opt_backup = true;
        } else if (arg == "-n") {
            opt_next = true;
        } else if (arg[0] != '-') {
            patch_arg = strip_patches_prefix(q, arg);
        }
    }

    Str patch;
    if (!patch_arg.empty()) {
        patch = patch_arg;
    } else if (opt_next) {
        // Next unapplied patch
        int top_idx = q.top_index();
        int next_idx = top_idx + 1;
        if (next_idx >= (int)q.series.size()) {
            err_line("No next patch");
            return 1;
        }
        patch = q.series[next_idx];
    } else {
        // Topmost applied patch
        if (q.applied.empty()) {
            err_line("No patch applied");
            return 1;
        }
        patch = q.applied.back();
    }

    // Verify patch is in series
    auto idx = q.find_in_series(patch);
    if (!idx) {
        err_line("Patch " + patch + " is not in series");
        return 1;
    }

    // If patch is applied, pop it (and everything above it)
    if (q.is_applied(patch)) {
        int rc = pop_to_patch(q, patch);
        if (rc != 0) return rc;
    }

    // Remove from series
    q.series.erase(q.series.begin() + *idx);
    Str series_abs = path_join(q.work_dir, q.series_file);
    write_series(series_abs, q.series);

    // Optionally remove the patch file
    if (opt_remove) {
        Str patch_file = path_join(q.work_dir, q.patches_dir, patch);
        if (opt_backup) {
            Str backup = patch_file + "~";
            rename_path(patch_file, backup);
        } else {
            delete_file(patch_file);
        }
    }

    out_line("Removed patch " + path_join(q.patches_dir, patch));
    return 0;
}

// ---------------------------------------------------------------------------
// cmd_rename
// ---------------------------------------------------------------------------

int cmd_rename(QuiltState &q, int argc, char **argv) {
    Str old_patch;
    Str new_name;

    for (int i = 1; i < argc; ++i) {
        StrView arg = argv[i];
        if (arg == "-P" && i + 1 < argc) {
            old_patch = strip_patches_prefix(q, argv[++i]);
        } else if (arg[0] != '-') {
            new_name = strip_patches_prefix(q, arg);
        }
    }

    // Default to top patch
    if (old_patch.empty()) {
        if (q.applied.empty()) {
            err_line("No patch applied");
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
        err_line("Patch " + old_patch + " is not in series");
        return 1;
    }

    // Verify new name doesn't exist in series
    auto new_idx = q.find_in_series(new_name);
    if (new_idx) {
        err_line("Patch " + new_name + " already exists in series");
        return 1;
    }

    // Rename in series
    q.series[*idx] = new_name;
    Str series_abs = path_join(q.work_dir, q.series_file);
    write_series(series_abs, q.series);

    // Rename patch file
    Str old_file = path_join(q.work_dir, q.patches_dir, old_patch);
    Str new_file = path_join(q.work_dir, q.patches_dir, new_name);
    if (file_exists(old_file)) {
        // Ensure target directory exists
        Str new_dir = dirname(new_file);
        if (!is_directory(new_dir)) {
            make_dirs(new_dir);
        }
        rename_path(old_file, new_file);
    }

    // If patch is applied: rename in applied-patches and .pc/ dir
    if (q.is_applied(old_patch)) {
        for (auto &a : q.applied) {
            if (a == old_patch) {
                a = new_name;
                break;
            }
        }
        Str applied_path = path_join(q.work_dir, q.pc_dir, "applied-patches");
        write_applied(applied_path, q.applied);

        Str old_pc = pc_patch_dir(q, old_patch);
        Str new_pc = pc_patch_dir(q, new_name);
        if (is_directory(old_pc)) {
            rename_path(old_pc, new_pc);
        }
    }

    out_line("Patch " + path_join(q.patches_dir, old_patch) +
             " renamed to " + path_join(q.patches_dir, new_name));
    return 0;
}

// ---------------------------------------------------------------------------
// cmd_import
// ---------------------------------------------------------------------------

int cmd_import(QuiltState &q, int argc, char **argv) {
    int strip_level = -1;
    Str target_name;
    bool force = false;
    char dup_mode = 0;  // o=overwrite, a=append, n=next
    (void)strip_level; (void)dup_mode;
    std::vector<Str> patchfiles;

    for (int i = 1; i < argc; ++i) {
        StrView arg = argv[i];
        if (arg == "-p" && i + 1 < argc) {
            strip_level = std::stoi(Str(argv[++i]));
        } else if (arg == "-P" && i + 1 < argc) {
            target_name = strip_patches_prefix(q, argv[++i]);
        } else if (arg == "-f") {
            force = true;
        } else if (arg == "-d" && i + 1 < argc) {
            dup_mode = argv[++i][0];
        } else if (arg[0] != '-') {
            patchfiles.emplace_back(arg);
        }
    }

    if (patchfiles.empty()) {
        err_line("Usage: quilt import [-p num] [-P patch] [-f] [-d {o|a|n}] patchfile ...");
        return 1;
    }

    ensure_pc_dir(q);

    // Ensure patches dir exists
    Str patches_abs = path_join(q.work_dir, q.patches_dir);
    if (!is_directory(patches_abs)) {
        make_dirs(patches_abs);
    }

    Str series_abs = path_join(q.work_dir, q.series_file);

    for (const auto &patchfile : patchfiles) {
        // Determine target name
        Str name;
        if (!target_name.empty()) {
            name = target_name;
        } else {
            name = basename(patchfile);
        }

        Str dest = path_join(q.work_dir, q.patches_dir, name);

        // Check if target exists in series
        auto existing = q.find_in_series(name);
        if (existing && !force) {
            err_line("Patch " + path_join(q.patches_dir, name) +
                     " already exists in series, use -f to override");
            return 1;
        }

        // Copy patchfile to patches/<name>
        if (!copy_file(patchfile, dest)) {
            err_line("Failed to copy " + patchfile + " to " + dest);
            return 1;
        }

        // Add to series if not already present
        if (!existing) {
            // Insert after top applied patch, or at end if none applied
            int top_idx = q.top_index();
            if (top_idx >= 0 && top_idx + 1 < (int)q.series.size()) {
                q.series.insert(q.series.begin() + top_idx + 1, name);
            } else {
                q.series.push_back(name);
            }
            write_series(series_abs, q.series);
        }

        out_line("Importing patch " + patchfile +
                 " (stored as " + path_join(q.patches_dir, name) + ")");
    }

    return 0;
}

// ---------------------------------------------------------------------------
// cmd_header
// ---------------------------------------------------------------------------

int cmd_header(QuiltState &q, int argc, char **argv) {
    enum Mode { PRINT, APPEND, REPLACE, EDIT };
    Mode mode = PRINT;
    bool opt_backup = false;
    Str patch_arg;

    for (int i = 1; i < argc; ++i) {
        StrView arg = argv[i];
        if (arg == "-a") {
            mode = APPEND;
        } else if (arg == "-r") {
            mode = REPLACE;
        } else if (arg == "-e") {
            mode = EDIT;
        } else if (arg == "--backup") {
            opt_backup = true;
        } else if (arg == "--dep3" || arg == "--strip-diffstat" ||
                   arg == "--strip-trailing-whitespace") {
            // Recognized but not implemented in this version
        } else if (arg[0] != '-') {
            patch_arg = strip_patches_prefix(q, arg);
        }
    }

    // Determine patch
    Str patch;
    if (!patch_arg.empty()) {
        patch = patch_arg;
    } else if (!q.applied.empty()) {
        patch = q.applied.back();
    } else if (!q.series.empty()) {
        patch = q.series.front();
    } else {
        err_line("No patch in series");
        return 1;
    }

    Str patch_file = path_join(q.work_dir, q.patches_dir, patch);
    Str content = read_file(patch_file);

    if (mode == PRINT) {
        Str header = extract_header(content);
        out(header);
        return 0;
    }

    if (mode == APPEND) {
        Str stdin_data = read_stdin();
        Str old_header = extract_header(content);
        Str new_header = old_header + stdin_data;
        if (opt_backup) {
            copy_file(patch_file, patch_file + "~");
        }
        Str new_content = replace_header(content, new_header);
        write_file(patch_file, new_content);
        return 0;
    }

    if (mode == REPLACE) {
        Str stdin_data = read_stdin();
        if (opt_backup) {
            copy_file(patch_file, patch_file + "~");
        }
        Str new_content = replace_header(content, stdin_data);
        write_file(patch_file, new_content);
        return 0;
    }

    if (mode == EDIT) {
        Str editor = get_env("EDITOR");
        if (editor.empty()) editor = "vi";

        Str header = extract_header(content);
        Str tmp_file = path_join(q.work_dir, ".pc/.quilt_header_tmp");
        write_file(tmp_file, header);

        ProcessResult r = run_cmd({editor, tmp_file});
        if (r.exit_code != 0) {
            delete_file(tmp_file);
            err_line("Editor exited with error");
            return 1;
        }

        Str new_header = read_file(tmp_file);
        delete_file(tmp_file);

        if (opt_backup) {
            copy_file(patch_file, patch_file + "~");
        }
        Str new_content = replace_header(content, new_header);
        write_file(patch_file, new_content);
        return 0;
    }

    return 0;
}

// ---------------------------------------------------------------------------
// cmd_files
// ---------------------------------------------------------------------------

int cmd_files(QuiltState &q, int argc, char **argv) {
    bool opt_verbose = false;
    bool opt_all = false;
    Str patch_arg;

    for (int i = 1; i < argc; ++i) {
        StrView arg = argv[i];
        if (arg == "-v") {
            opt_verbose = true;
        } else if (arg == "-a") {
            opt_all = true;
        } else if (arg == "-l" || arg == "--combine") {
            // Recognized but simplified — skip combine argument
            if (arg == "--combine" && i + 1 < argc) ++i;
        } else if (arg[0] != '-') {
            patch_arg = strip_patches_prefix(q, arg);
        }
    }

    // Build list of patches to show files for
    std::vector<Str> patches_to_show;
    if (opt_all) {
        patches_to_show = q.applied;
    } else {
        Str patch;
        if (!patch_arg.empty()) {
            patch = patch_arg;
        } else if (!q.applied.empty()) {
            patch = q.applied.back();
        } else {
            err_line("No patch applied");
            return 1;
        }
        patches_to_show.push_back(patch);
    }

    for (const auto &patch : patches_to_show) {
        std::vector<Str> file_list;

        if (q.is_applied(patch)) {
            file_list = files_in_patch(q, patch);
        } else {
            // Parse the patch file
            Str patch_file = path_join(q.work_dir, q.patches_dir, patch);
            Str content = read_file(patch_file);
            file_list = parse_patch_files(content);
        }

        // Sort for consistent output
        std::sort(file_list.begin(), file_list.end());

        for (const auto &f : file_list) {
            if (opt_verbose) {
                out_line(f + "\t" + path_join(q.patches_dir, patch));
            } else {
                out_line(f);
            }
        }
    }

    return 0;
}

// ---------------------------------------------------------------------------
// cmd_patches
// ---------------------------------------------------------------------------

int cmd_patches(QuiltState &q, int argc, char **argv) {
    bool opt_verbose = false;
    std::vector<Str> target_files;

    for (int i = 1; i < argc; ++i) {
        StrView arg = argv[i];
        if (arg == "-v") {
            opt_verbose = true;
        } else if (arg == "--color") {
            // Recognized but not implemented
        } else if (arg[0] != '-') {
            target_files.emplace_back(arg);
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
            Str pc_dir = pc_patch_dir(q, patch);
            for (const auto &tf : target_files) {
                Str check = path_join(pc_dir, tf);
                if (file_exists(check)) {
                    touches = true;
                    break;
                }
            }
        } else {
            // Parse patch file for references
            Str patch_file = path_join(q.work_dir, q.patches_dir, patch);
            Str content = read_file(patch_file);
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
            Str display = path_join(q.patches_dir, patch);
            if (opt_verbose) {
                // Show applied status
                if (q.is_applied(patch)) {
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

// ---------------------------------------------------------------------------
// cmd_fold
// ---------------------------------------------------------------------------

int cmd_fold(QuiltState &q, int argc, char **argv) {
    bool opt_reverse = false;
    bool opt_quiet = false;
    bool opt_force = false;
    int strip_level = 1;

    for (int i = 1; i < argc; ++i) {
        StrView arg = argv[i];
        if (arg == "-R") {
            opt_reverse = true;
        } else if (arg == "-q") {
            opt_quiet = true;
        } else if (arg == "-f") {
            opt_force = true;
        } else if (arg == "-p" && i + 1 < argc) {
            strip_level = std::stoi(Str(argv[++i]));
        }
    }

    if (q.applied.empty()) {
        err_line("No patch applied");
        return 1;
    }

    Str top = q.applied.back();
    Str stdin_data = read_stdin();

    if (stdin_data.empty()) {
        err_line("No patch data on stdin");
        return 1;
    }

    // Parse the incoming patch to find affected files
    auto affected_files = parse_patch_files(stdin_data);

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

    // Build patch command
    std::vector<Str> cmd = {"patch", "-p" + std::to_string(strip_level)};
    if (opt_reverse) cmd.push_back("-R");
    if (opt_force) cmd.push_back("-f");
    if (opt_quiet) cmd.push_back("-s");

    ProcessResult r = run_cmd_input(cmd, stdin_data);
    if (r.exit_code != 0) {
        if (!r.out.empty()) err(r.out);
        if (!r.err.empty()) err(r.err);
        return 1;
    }

    if (!opt_quiet && !r.out.empty()) {
        out(r.out);
    }

    return 0;
}

// ---------------------------------------------------------------------------
// cmd_fork
// ---------------------------------------------------------------------------

int cmd_fork(QuiltState &q, int argc, char **argv) {
    if (q.applied.empty()) {
        err_line("No patch applied");
        return 1;
    }

    Str old_name = q.applied.back();
    Str new_name;

    for (int i = 1; i < argc; ++i) {
        StrView arg = argv[i];
        if (arg[0] != '-') {
            new_name = strip_patches_prefix(q, arg);
            break;
        }
    }

    // Generate default name if none given: add "-2" before extension
    if (new_name.empty()) {
        auto dot = old_name.rfind('.');
        if (dot != Str::npos && dot > 0) {
            new_name = old_name.substr(0, dot) + "-2" + old_name.substr(dot);
        } else {
            new_name = old_name + "-2";
        }
    }

    // Check that the new name doesn't already exist in series
    if (q.find_in_series(new_name)) {
        err_line("Patch " + new_name + " already exists in series");
        return 1;
    }

    // Copy patch file
    Str old_file = path_join(q.work_dir, q.patches_dir, old_name);
    Str new_file = path_join(q.work_dir, q.patches_dir, new_name);
    if (file_exists(old_file)) {
        Str new_dir = dirname(new_file);
        if (!is_directory(new_dir)) {
            make_dirs(new_dir);
        }
        copy_file(old_file, new_file);
    }

    // Replace old name with new name in series
    auto idx = q.find_in_series(old_name);
    if (idx) {
        q.series[*idx] = new_name;
        Str series_abs = path_join(q.work_dir, q.series_file);
        write_series(series_abs, q.series);
    }

    // Replace in applied-patches
    for (auto &a : q.applied) {
        if (a == old_name) {
            a = new_name;
            break;
        }
    }
    Str applied_path = path_join(q.work_dir, q.pc_dir, "applied-patches");
    write_applied(applied_path, q.applied);

    // Rename .pc/ directory
    Str old_pc = pc_patch_dir(q, old_name);
    Str new_pc = pc_patch_dir(q, new_name);
    if (is_directory(old_pc)) {
        rename_path(old_pc, new_pc);
    }

    out_line("Fork of patch " + path_join(q.patches_dir, old_name) +
             " created as " + path_join(q.patches_dir, new_name));
    return 0;
}
