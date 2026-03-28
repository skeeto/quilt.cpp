// This is free and unencumbered software released into the public domain.
#include "quilt.hpp"
#include "platform.hpp"

#include <optional>

namespace {

struct AnnotateOptions {
    std::string patch;
    std::string file;
};

static bool path_has_content(std::string_view path)
{
    return file_exists(path) && !read_file(path).empty();
}

static std::vector<std::string> read_lines(std::string_view path)
{
    if (!path_has_content(path)) {
        return {};
    }
    return split_lines(read_file(path));
}

static std::string next_patch_for_file(const QuiltState &q,
                                std::string_view patch,
                                std::string_view file)
{
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

static std::vector<std::string> reannotate_lines(std::span<const std::string> old_lines,
                                          std::span<const std::string> old_annotations,
                                          std::span<const std::string> new_lines,
                                          std::string_view annotation)
{
    const ptrdiff_t m = std::ssize(old_lines);
    const ptrdiff_t n = std::ssize(new_lines);
    std::vector<std::vector<int>> dp(checked_cast<size_t>(m + 1), std::vector<int>(checked_cast<size_t>(n + 1), 0));

    for (ptrdiff_t i = m; i-- > 0;) {
        for (ptrdiff_t j = n; j-- > 0;) {
            if (old_lines[checked_cast<size_t>(i)] == new_lines[checked_cast<size_t>(j)]) {
                dp[checked_cast<size_t>(i)][checked_cast<size_t>(j)] = dp[checked_cast<size_t>(i + 1)][checked_cast<size_t>(j + 1)] + 1;
            } else {
                dp[checked_cast<size_t>(i)][checked_cast<size_t>(j)] = std::max(dp[checked_cast<size_t>(i + 1)][checked_cast<size_t>(j)], dp[checked_cast<size_t>(i)][checked_cast<size_t>(j + 1)]);
            }
        }
    }

    std::vector<std::string> result;
    result.reserve(checked_cast<size_t>(n));
    ptrdiff_t i = 0;
    ptrdiff_t j = 0;
    while (i < m || j < n) {
        if (i < m && j < n && old_lines[checked_cast<size_t>(i)] == new_lines[checked_cast<size_t>(j)]) {
            result.push_back(i < std::ssize(old_annotations) ? old_annotations[checked_cast<size_t>(i)] : "");
            ++i;
            ++j;
        } else if (j < n && (i == m || dp[checked_cast<size_t>(i)][checked_cast<size_t>(j + 1)] >= dp[checked_cast<size_t>(i + 1)][checked_cast<size_t>(j)])) {
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
        opts.file = subdir_path(q, arg);
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

    std::vector<std::string> annotations(checked_cast<size_t>(std::ssize(read_lines(files.front()))), "");
    for (ptrdiff_t i = 0; i < std::ssize(patches); ++i) {
        annotations = reannotate_lines(read_lines(files[checked_cast<size_t>(i)]), annotations,
                                       read_lines(files[checked_cast<size_t>(i + 1)]),
                                       std::to_string(i + 1));
    }

    auto final_lines = read_lines(files.back());
    for (ptrdiff_t i = 0; i < std::ssize(annotations); ++i) {
        std::string line = i < std::ssize(final_lines) ? final_lines[checked_cast<size_t>(i)] : "";
        out(annotations[checked_cast<size_t>(i)] + "\t" + line + "\n");
    }

    out("\n");
    for (ptrdiff_t i = 0; i < std::ssize(patches); ++i) {
        out(std::to_string(i + 1) + "\t" + format_patch(q, patches[checked_cast<size_t>(i)]) + "\n");
    }
    return 0;
}
