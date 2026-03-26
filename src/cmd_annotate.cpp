// This is free and unencumbered software released into the public domain.
#include "quilt.hpp"
#include "platform.hpp"

#include <optional>

extern std::string pc_patch_dir(const QuiltState &q, std::string_view patch);
extern std::vector<std::string> files_in_patch(const QuiltState &q, std::string_view patch);

namespace {

struct AnnotateOptions {
    std::string patch;
    std::string file;
};

std::string strip_patches_prefix(const QuiltState &q, std::string_view name)
{
    std::string prefix = q.patches_dir + "/";
    if (starts_with(name, prefix)) {
        return std::string(name.substr(prefix.size()));
    }
    return std::string(name);
}

std::string print_patch_name(const QuiltState &q, std::string_view patch)
{
    if (!get_env("QUILT_PATCHES_PREFIX").empty()) {
        return q.patches_dir + "/" + std::string(patch);
    }
    return std::string(patch);
}

bool path_has_content(std::string_view path)
{
    return file_exists(path) && !read_file(path).empty();
}

std::vector<std::string> read_lines(std::string_view path)
{
    if (!path_has_content(path)) {
        return {};
    }
    return split_lines(read_file(path));
}

std::string next_patch_for_file(const QuiltState &q,
                                std::string_view patch,
                                std::string_view file)
{
    bool after_target = false;
    for (const auto &applied : q.applied) {
        if (after_target) {
            auto tracked = files_in_patch(q, applied);
            if (std::find(tracked.begin(), tracked.end(), file) != tracked.end()) {
                return applied;
            }
        }
        if (applied == patch) {
            after_target = true;
        }
    }
    return "";
}

std::vector<std::string> reannotate_lines(const std::vector<std::string> &old_lines,
                                          const std::vector<std::string> &old_annotations,
                                          const std::vector<std::string> &new_lines,
                                          std::string_view annotation)
{
    const size_t m = old_lines.size();
    const size_t n = new_lines.size();
    std::vector<std::vector<int>> dp(m + 1, std::vector<int>(n + 1, 0));

    for (size_t i = m; i-- > 0;) {
        for (size_t j = n; j-- > 0;) {
            if (old_lines[i] == new_lines[j]) {
                dp[i][j] = dp[i + 1][j + 1] + 1;
            } else {
                dp[i][j] = std::max(dp[i + 1][j], dp[i][j + 1]);
            }
        }
    }

    std::vector<std::string> result;
    result.reserve(n);
    size_t i = 0;
    size_t j = 0;
    while (i < m || j < n) {
        if (i < m && j < n && old_lines[i] == new_lines[j]) {
            result.push_back(i < old_annotations.size() ? old_annotations[i] : "");
            ++i;
            ++j;
        } else if (j < n && (i == m || dp[i][j + 1] >= dp[i + 1][j])) {
            result.emplace_back(annotation);
            ++j;
        } else {
            ++i;
        }
    }
    return result;
}

std::optional<AnnotateOptions> parse_options(const QuiltState &q, int argc, char **argv)
{
    AnnotateOptions opts;
    for (int i = 1; i < argc; ++i) {
        std::string_view arg = argv[i];
        if (arg == "-P" && i + 1 < argc) {
            opts.patch = strip_patches_prefix(q, argv[i + 1]);
            ++i;
            continue;
        }
        if (!arg.empty() && arg[0] == '-') {
            return std::nullopt;
        }
        if (!opts.file.empty()) {
            return std::nullopt;
        }
        opts.file = std::string(arg);
    }

    if (opts.file.empty()) {
        return std::nullopt;
    }
    return opts;
}

int no_applied_patches_error(const QuiltState &q)
{
    if (!q.series_file_exists) {
        err_line("No series file found");
    } else if (q.series.empty()) {
        err_line("No patches in series");
    } else {
        err_line("No patches applied");
    }
    return 1;
}

} // namespace

int cmd_annotate(QuiltState &q, int argc, char **argv)
{
    auto opts = parse_options(q, argc, argv);
    if (!opts.has_value()) {
        err_line("Usage: quilt annotate [-P patch] file");
        return 1;
    }

    if (q.applied.empty()) {
        return no_applied_patches_error(q);
    }

    std::string stop_patch = opts->patch.empty() ? q.applied.back() : opts->patch;
    if (!q.find_in_series(stop_patch).has_value()) {
        err_line("Patch " + stop_patch + " is not in series");
        return 1;
    }
    if (!q.is_applied(stop_patch)) {
        err_line("Patch " + stop_patch + " is not applied");
        return 1;
    }

    std::vector<std::string> patches;
    std::vector<std::string> files;
    std::string next_patch;

    for (const auto &patch : q.applied) {
        std::string old_file = path_join(pc_patch_dir(q, patch), opts->file);
        if (file_exists(old_file)) {
            patches.push_back(patch);
            files.push_back(old_file);
        }
        if (patch == stop_patch) {
            next_patch = next_patch_for_file(q, stop_patch, opts->file);
            break;
        }
    }

    if (next_patch.empty()) {
        files.push_back(path_join(q.work_dir, opts->file));
    } else {
        files.push_back(path_join(pc_patch_dir(q, next_patch), opts->file));
    }

    if (patches.empty()) {
        std::string target = files.back();
        if (!file_exists(target)) {
            err_line("File " + opts->file + " does not exist");
            return 1;
        }
        for (const auto &line : read_lines(target)) {
            out("\t" + line + "\n");
        }
        return 0;
    }

    std::vector<std::string> annotations(read_lines(files.front()).size(), "");
    for (size_t i = 0; i < patches.size(); ++i) {
        annotations = reannotate_lines(read_lines(files[i]), annotations,
                                       read_lines(files[i + 1]),
                                       std::to_string(i + 1));
    }

    auto final_lines = read_lines(files.back());
    for (size_t i = 0; i < annotations.size(); ++i) {
        std::string line = i < final_lines.size() ? final_lines[i] : "";
        out(annotations[i] + "\t" + line + "\n");
    }

    out("\n");
    for (size_t i = 0; i < patches.size(); ++i) {
        out(std::to_string(i + 1) + "\t" + print_patch_name(q, patches[i]) + "\n");
    }
    return 0;
}
