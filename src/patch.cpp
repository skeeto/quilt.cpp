// This is free and unencumbered software released into the public domain.
//
// Built-in patch engine for applying unified diffs.
// Implements spiral search with offset tracking, fuzz matching,
// reverse application, merge conflict markers, and reject files.

#include "quilt.hpp"
#include "platform.hpp"
#include <algorithm>
#include <cstdio>
#include <cstdlib>

// ── Patch parsing data structures ──────────────────────────────────────

struct PatchHunk {
    ptrdiff_t old_start = 0;  // 1-based line from @@ header
    ptrdiff_t old_count = 0;
    ptrdiff_t new_start = 0;
    ptrdiff_t new_count = 0;
    std::vector<std::string> lines;  // prefixed with ' ', '+', '-'
    // Flags for "\ No newline at end of file" on old/new side
    bool old_no_newline = false;
    bool new_no_newline = false;
};

struct PatchFile {
    std::string old_path;
    std::string new_path;
    std::string target_path;   // after strip-level
    bool is_creation = false;  // old = /dev/null
    bool is_deletion = false;  // new = /dev/null
    std::vector<PatchHunk> hunks;
};

// ── Path stripping ─────────────────────────────────────────────────────

// Strip N leading path components.  Adjacent slashes count as one separator.
static std::string strip_path(std::string_view path, int strip)
{
    if (strip < 0) return std::string(path);

    std::string_view p = path;
    for (int i = 0; i < strip && !p.empty(); ++i) {
        // Skip to next slash
        ptrdiff_t slash = str_find(p, '/');
        if (slash < 0) {
            // No more slashes — strip everything
            return std::string(p);
        }
        p = p.substr(to_uz(slash) + 1);
        // Skip consecutive slashes
        while (!p.empty() && p[0] == '/') p = p.substr(1);
    }
    return std::string(p);
}

// Extract filename from a --- or +++ header line.
// Strips trailing tab+timestamp if present.
static std::string extract_path(std::string_view line)
{
    // line is everything after "--- " or "+++ "
    std::string_view rest = line;
    ptrdiff_t tab = str_find(rest, '\t');
    if (tab >= 0) {
        rest = rest.substr(0, to_uz(tab));
    }
    // Trim trailing whitespace
    while (!rest.empty() && (rest.back() == ' ' || rest.back() == '\r')) {
        rest = rest.substr(0, rest.size() - 1);
    }
    return std::string(rest);
}

// ── Unified diff parser ────────────────────────────────────────────────

// Parse a complete unified diff into a list of per-file patch descriptions.
static std::vector<PatchFile> parse_patch(std::string_view text, int strip_level,
                                           bool reverse)
{
    std::vector<PatchFile> files;
    auto lines = split_lines(text);
    ptrdiff_t n = std::ssize(lines);
    ptrdiff_t i = 0;

    while (i < n) {
        // Look for "--- " header
        if (!starts_with(lines[to_uz(i)], "--- ")) {
            ++i;
            continue;
        }

        // Peek ahead for "+++ "
        if (i + 1 >= n || !starts_with(lines[to_uz(i + 1)], "+++ ")) {
            ++i;
            continue;
        }

        PatchFile pf;
        std::string raw_old = extract_path(std::string_view(lines[to_uz(i)]).substr(4));
        std::string raw_new = extract_path(std::string_view(lines[to_uz(i + 1)]).substr(4));

        if (reverse) {
            std::swap(raw_old, raw_new);
        }

        pf.old_path = raw_old;
        pf.new_path = raw_new;
        pf.is_creation = (raw_old == "/dev/null");
        pf.is_deletion = (raw_new == "/dev/null");

        // Determine target path
        if (pf.is_creation) {
            pf.target_path = strip_path(raw_new, strip_level);
        } else {
            pf.target_path = strip_path(raw_old, strip_level);
        }

        i += 2;  // skip --- and +++ lines

        // Parse hunks
        while (i < n && starts_with(lines[to_uz(i)], "@@ ")) {
            PatchHunk hunk;

            // Parse @@ -old_start[,old_count] +new_start[,new_count] @@
            std::string_view hdr = std::string_view(lines[to_uz(i)]);
            ptrdiff_t at1 = str_find(hdr, '-', 3);
            if (at1 < 0) { ++i; continue; }

            // Parse old range
            ptrdiff_t pos = at1 + 1;
            ptrdiff_t comma = str_find(hdr, ',', pos);
            ptrdiff_t space = str_find(hdr, ' ', pos);
            ptrdiff_t plus_pos = str_find(hdr, '+', pos);

            if (comma >= 0 && comma < plus_pos) {
                hunk.old_start = std::atol(std::string(hdr.substr(to_uz(pos), to_uz(comma - pos))).c_str());
                hunk.old_count = std::atol(std::string(hdr.substr(to_uz(comma + 1), to_uz(plus_pos - comma - 2))).c_str());
            } else {
                hunk.old_start = std::atol(std::string(hdr.substr(to_uz(pos), to_uz(space - pos))).c_str());
                hunk.old_count = 1;
            }

            // Parse new range
            pos = plus_pos + 1;
            comma = str_find(hdr, ',', pos);
            ptrdiff_t end_at = str_find(hdr, ' ', pos);
            if (end_at < 0) end_at = std::ssize(hdr);

            if (comma >= 0 && comma < end_at) {
                hunk.new_start = std::atol(std::string(hdr.substr(to_uz(pos), to_uz(comma - pos))).c_str());
                hunk.new_count = std::atol(std::string(hdr.substr(to_uz(comma + 1), to_uz(end_at - comma - 1))).c_str());
            } else {
                hunk.new_start = std::atol(std::string(hdr.substr(to_uz(pos), to_uz(end_at - pos))).c_str());
                hunk.new_count = 1;
            }

            if (reverse) {
                std::swap(hunk.old_start, hunk.new_start);
                std::swap(hunk.old_count, hunk.new_count);
            }

            ++i;  // skip @@ line

            // Collect hunk body
            ptrdiff_t old_seen = 0, new_seen = 0;
            while (i < n) {
                std::string_view ln = lines[to_uz(i)];

                if (starts_with(ln, "\\ No newline at end of file") ||
                    starts_with(ln, "\\ no newline at end of file")) {
                    // Applies to the preceding line
                    if (!hunk.lines.empty()) {
                        char prev_prefix = hunk.lines.back()[0];
                        if (reverse) {
                            if (prev_prefix == '-')
                                hunk.new_no_newline = true;
                            else if (prev_prefix == '+')
                                hunk.old_no_newline = true;
                            else
                                hunk.old_no_newline = hunk.new_no_newline = true;
                        } else {
                            if (prev_prefix == '-')
                                hunk.old_no_newline = true;
                            else if (prev_prefix == '+')
                                hunk.new_no_newline = true;
                            else
                                hunk.old_no_newline = hunk.new_no_newline = true;
                        }
                    }
                    ++i;
                    continue;
                }

                if (ln.empty()) {
                    // Empty line in diff = context line (space was stripped)
                    if (old_seen >= hunk.old_count && new_seen >= hunk.new_count) break;
                    std::string line_str = " ";
                    hunk.lines.push_back(line_str);
                    old_seen++;
                    new_seen++;
                    ++i;
                    continue;
                }

                char prefix = ln[0];
                if (prefix == ' ' || prefix == '-' || prefix == '+') {
                    std::string line_str(ln);

                    if (reverse) {
                        if (prefix == '-') line_str[0] = '+';
                        else if (prefix == '+') line_str[0] = '-';
                    }

                    char actual_prefix = line_str[0];
                    if (actual_prefix == ' ') {
                        if (old_seen >= hunk.old_count && new_seen >= hunk.new_count) break;
                        old_seen++;
                        new_seen++;
                    } else if (actual_prefix == '-') {
                        if (old_seen >= hunk.old_count) break;
                        old_seen++;
                    } else { // '+'
                        if (new_seen >= hunk.new_count) break;
                        new_seen++;
                    }

                    hunk.lines.push_back(std::move(line_str));
                    ++i;
                } else {
                    // Start of next file section or unknown line
                    break;
                }
            }

            pf.hunks.push_back(std::move(hunk));
        }

        files.push_back(std::move(pf));
    }

    return files;
}

// ── Line-based file representation ─────────────────────────────────────

// Split file content into lines.  Each line does NOT include its trailing '\n'.
// Returns whether the file had a trailing newline.
struct FileContent {
    std::vector<std::string> lines;
    bool has_trailing_newline = true;
};

static FileContent load_file_lines(std::string_view path)
{
    FileContent fc;
    std::string content = read_file(path);
    if (content.empty()) {
        fc.has_trailing_newline = true;
        return fc;
    }

    fc.has_trailing_newline = (content.back() == '\n');

    ptrdiff_t start = 0;
    ptrdiff_t len = static_cast<ptrdiff_t>(content.size());
    for (ptrdiff_t i = 0; i < len; ++i) {
        if (content[to_uz(i)] == '\n') {
            fc.lines.push_back(content.substr(to_uz(start), to_uz(i - start)));
            start = i + 1;
        }
    }
    if (start < len) {
        fc.lines.push_back(content.substr(to_uz(start), to_uz(len - start)));
    }

    return fc;
}

// ── Hunk matching ──────────────────────────────────────────────────────

// Extract the context+deletion lines (the "old" side pattern) from a hunk.
// Returns pairs of (line_text, is_context) for matching purposes.
struct PatternLine {
    std::string_view text;  // line content (without prefix)
    bool is_context;        // true = context line, false = deletion line
};

static std::vector<PatternLine> get_old_pattern(const PatchHunk &hunk)
{
    std::vector<PatternLine> pattern;
    for (const auto &line : hunk.lines) {
        char prefix = line[0];
        std::string_view text(line);
        text = text.substr(1);
        if (prefix == ' ') {
            pattern.push_back({text, true});
        } else if (prefix == '-') {
            pattern.push_back({text, false});
        }
        // '+' lines are not part of the old-side pattern
    }
    return pattern;
}

// Try to match a hunk's old-side pattern against file lines starting at
// position `pos` (0-based), with `fuzz` context lines skipped at top/bottom.
// Returns true if the pattern matches.
static bool try_match(const std::vector<std::string> &file_lines,
                      ptrdiff_t pos,
                      const std::vector<PatternLine> &pattern,
                      int fuzz)
{
    ptrdiff_t pat_len = std::ssize(pattern);
    if (pat_len == 0) return true;

    // Count actual context lines at top and bottom of pattern
    ptrdiff_t prefix_ctx = 0;
    for (ptrdiff_t j = 0; j < pat_len; ++j) {
        if (pattern[to_uz(j)].is_context) ++prefix_ctx;
        else break;
    }
    ptrdiff_t suffix_ctx = 0;
    for (ptrdiff_t j = pat_len - 1; j >= 0; --j) {
        if (pattern[to_uz(j)].is_context) ++suffix_ctx;
        else break;
    }

    ptrdiff_t prefix_fuzz = std::min(static_cast<ptrdiff_t>(fuzz), prefix_ctx);
    ptrdiff_t suffix_fuzz = std::min(static_cast<ptrdiff_t>(fuzz), suffix_ctx);

    // Lines to match: skip prefix_fuzz from top, suffix_fuzz from bottom
    ptrdiff_t match_start = prefix_fuzz;
    ptrdiff_t match_end = pat_len - suffix_fuzz;

    // Adjust file position: we start matching at pos + prefix_fuzz
    ptrdiff_t file_pos = pos + prefix_fuzz;
    ptrdiff_t file_len = std::ssize(file_lines);

    for (ptrdiff_t j = match_start; j < match_end; ++j) {
        if (file_pos < 0 || file_pos >= file_len) return false;
        if (file_lines[to_uz(file_pos)] != pattern[to_uz(j)].text) return false;
        ++file_pos;
    }

    return true;
}

// Spiral search: find where a hunk matches in the file.
// Returns the 0-based file position, or -1 if not found.
// Updates cumulative_offset on success.
static ptrdiff_t locate_hunk(const std::vector<std::string> &file_lines,
                              const PatchHunk &hunk,
                              const std::vector<PatternLine> &pattern,
                              ptrdiff_t last_frozen_line,
                              ptrdiff_t cumulative_offset,
                              int max_fuzz)
{
    ptrdiff_t file_len = std::ssize(file_lines);
    ptrdiff_t pat_old_count = 0;
    for (const auto &pl : pattern) (void)pl, ++pat_old_count;
    pat_old_count = std::ssize(pattern);

    // First guess: hunk header's old_start (1-based) converted to 0-based + offset
    ptrdiff_t first_guess = hunk.old_start - 1 + cumulative_offset;

    // Clamp to valid range
    ptrdiff_t max_pos = file_len - pat_old_count;
    if (max_pos < 0) max_pos = 0;

    for (int fuzz = 0; fuzz <= max_fuzz; ++fuzz) {
        // Compute how many pattern lines we actually need to match
        ptrdiff_t prefix_ctx = 0;
        for (ptrdiff_t j = 0; j < pat_old_count; ++j) {
            if (pattern[to_uz(j)].is_context) ++prefix_ctx;
            else break;
        }
        ptrdiff_t suffix_ctx = 0;
        for (ptrdiff_t j = pat_old_count - 1; j >= 0; --j) {
            if (pattern[to_uz(j)].is_context) ++suffix_ctx;
            else break;
        }
        ptrdiff_t prefix_fuzz = std::min(static_cast<ptrdiff_t>(fuzz), prefix_ctx);
        ptrdiff_t suffix_fuzz = std::min(static_cast<ptrdiff_t>(fuzz), suffix_ctx);
        ptrdiff_t effective_pat_len = pat_old_count - prefix_fuzz - suffix_fuzz;

        ptrdiff_t max_search = file_len - effective_pat_len;
        if (effective_pat_len == 0) max_search = file_len;  // empty pattern matches anywhere

        // Try exact position first
        if (first_guess >= 0 && first_guess <= max_search &&
            first_guess > last_frozen_line - 1) {
            if (try_match(file_lines, first_guess, pattern, fuzz)) {
                return first_guess;
            }
        }

        // Spiral outward
        ptrdiff_t max_offset_forward = max_search - first_guess;
        ptrdiff_t max_offset_backward = first_guess - last_frozen_line;
        ptrdiff_t max_range = std::max(max_offset_forward, max_offset_backward);
        if (max_range < 0) max_range = 0;

        for (ptrdiff_t delta = 1; delta <= max_range; ++delta) {
            // Try forward
            ptrdiff_t pos = first_guess + delta;
            if (pos >= 0 && pos <= max_search && pos > last_frozen_line - 1) {
                if (try_match(file_lines, pos, pattern, fuzz)) {
                    return pos;
                }
            }

            // Try backward
            pos = first_guess - delta;
            if (pos >= 0 && pos <= max_search && pos > last_frozen_line - 1) {
                if (try_match(file_lines, pos, pattern, fuzz)) {
                    return pos;
                }
            }
        }
    }

    return -1;  // no match found
}

// ── Hunk application ───────────────────────────────────────────────────

// Get the new-side (replacement) lines from a hunk.
static std::vector<std::string_view> get_new_lines(const PatchHunk &hunk)
{
    std::vector<std::string_view> result;
    for (const auto &line : hunk.lines) {
        char prefix = line[0];
        if (prefix == ' ' || prefix == '+') {
            result.push_back(std::string_view(line).substr(1));
        }
    }
    return result;
}

// Build the output file content after applying all successfully matched hunks.
// hunks_positions[i] = 0-based file position where hunk i matched, or -1 if rejected.
static std::string build_output(const std::vector<std::string> &file_lines,
                                 bool has_trailing_newline,
                                 const PatchFile &pf,
                                 const std::vector<ptrdiff_t> &hunk_positions)
{
    std::string output;
    ptrdiff_t file_len = std::ssize(file_lines);
    ptrdiff_t last_copied = 0;  // next line to copy from input

    for (ptrdiff_t h = 0; h < std::ssize(pf.hunks); ++h) {
        ptrdiff_t pos = hunk_positions[to_uz(h)];
        if (pos < 0) continue;  // rejected hunk, skip

        const auto &hunk = pf.hunks[to_uz(h)];
        auto pattern = get_old_pattern(hunk);
        ptrdiff_t pat_len = std::ssize(pattern);
        auto new_lines = get_new_lines(hunk);

        // Copy unchanged lines from last_copied to pos
        for (ptrdiff_t j = last_copied; j < pos; ++j) {
            output += file_lines[to_uz(j)];
            output += '\n';
        }

        // Write replacement lines
        for (ptrdiff_t j = 0; j < std::ssize(new_lines); ++j) {
            output += new_lines[to_uz(j)];
            bool is_last_new_line = (j == std::ssize(new_lines) - 1);
            if (is_last_new_line && hunk.new_no_newline) {
                // Don't add trailing newline
            } else {
                output += '\n';
            }
        }

        last_copied = pos + pat_len;
    }

    // Copy remaining lines
    for (ptrdiff_t j = last_copied; j < file_len; ++j) {
        output += file_lines[to_uz(j)];
        if (j < file_len - 1) {
            output += '\n';
        } else {
            // Last line: preserve original trailing newline status
            // unless a hunk changed it
            if (has_trailing_newline) {
                output += '\n';
            }
        }
    }

    return output;
}

// ── Merge conflict markers ─────────────────────────────────────────────

// Build output with merge conflict markers for rejected hunks.
// Applies successful hunks normally, inserts conflict markers for failed ones.
static std::string build_merge_output(const std::vector<std::string> &file_lines,
                                       bool has_trailing_newline,
                                       const PatchFile &pf,
                                       const std::vector<ptrdiff_t> &hunk_positions,
                                       const std::string &merge_style)
{
    // For merge mode, we first apply successful hunks, then for rejected hunks
    // we insert conflict markers at the hunk's expected position.
    std::string output;
    ptrdiff_t file_len = std::ssize(file_lines);
    ptrdiff_t last_copied = 0;

    // Process all hunks in order
    for (ptrdiff_t h = 0; h < std::ssize(pf.hunks); ++h) {
        const auto &hunk = pf.hunks[to_uz(h)];
        ptrdiff_t pos = hunk_positions[to_uz(h)];

        if (pos >= 0) {
            // Successfully matched — apply normally
            auto pattern = get_old_pattern(hunk);
            ptrdiff_t pat_len = std::ssize(pattern);
            auto new_lines = get_new_lines(hunk);

            for (ptrdiff_t j = last_copied; j < pos; ++j) {
                output += file_lines[to_uz(j)];
                output += '\n';
            }
            for (ptrdiff_t j = 0; j < std::ssize(new_lines); ++j) {
                output += new_lines[to_uz(j)];
                bool is_last = (j == std::ssize(new_lines) - 1);
                if (is_last && hunk.new_no_newline) {
                    // no trailing newline
                } else {
                    output += '\n';
                }
            }
            last_copied = pos + pat_len;
        } else {
            // Rejected — insert conflict markers at expected position
            ptrdiff_t expected = hunk.old_start - 1;
            if (expected < last_copied) expected = last_copied;
            if (expected > file_len) expected = file_len;

            // Copy up to expected position
            for (ptrdiff_t j = last_copied; j < expected; ++j) {
                output += file_lines[to_uz(j)];
                output += '\n';
            }

            // Extract old-side (context + deletion) lines and new-side lines
            std::vector<std::string_view> old_context_lines;
            for (const auto &line : hunk.lines) {
                char prefix = line[0];
                if (prefix == ' ' || prefix == '-') {
                    old_context_lines.push_back(std::string_view(line).substr(1));
                }
            }
            auto new_lines = get_new_lines(hunk);

            output += "<<<<<<< current\n";

            // Show what's currently in the file at this position
            ptrdiff_t current_end = expected + std::ssize(old_context_lines);
            if (current_end > file_len) current_end = file_len;
            for (ptrdiff_t j = expected; j < current_end; ++j) {
                output += file_lines[to_uz(j)];
                output += '\n';
            }

            if (merge_style == "diff3") {
                output += "||||||| expected\n";
                for (const auto &ol : old_context_lines) {
                    output += ol;
                    output += '\n';
                }
            }

            output += "=======\n";

            for (const auto &nl : new_lines) {
                output += nl;
                output += '\n';
            }

            output += ">>>>>>> patch\n";

            last_copied = current_end;
        }
    }

    // Copy remaining
    for (ptrdiff_t j = last_copied; j < file_len; ++j) {
        output += file_lines[to_uz(j)];
        if (j < file_len - 1) {
            output += '\n';
        } else if (has_trailing_newline) {
            output += '\n';
        }
    }

    return output;
}

// ── Reject file generation ─────────────────────────────────────────────

// Format rejected hunks as a unified diff .rej file.
static std::string format_rejects(const PatchFile &pf,
                                   const std::vector<bool> &rejected)
{
    std::string result;
    bool has_any = false;

    for (ptrdiff_t h = 0; h < std::ssize(pf.hunks); ++h) {
        if (!rejected[to_uz(h)]) continue;
        const auto &hunk = pf.hunks[to_uz(h)];

        if (!has_any) {
            // Write file headers
            result += "--- ";
            result += pf.old_path;
            result += '\n';
            result += "+++ ";
            result += pf.new_path;
            result += '\n';
            has_any = true;
        }

        // Write hunk header
        char header[128];
        std::snprintf(header, sizeof(header), "@@ -%d,%d +%d,%d @@\n",
                     to_int(hunk.old_start), to_int(hunk.old_count),
                     to_int(hunk.new_start), to_int(hunk.new_count));
        result += header;

        // Write hunk lines
        for (const auto &line : hunk.lines) {
            result += line;
            result += '\n';
        }
        if (hunk.old_no_newline) {
            result += "\\ No newline at end of file\n";
        }
    }

    return result;
}

// ── Main patch engine ──────────────────────────────────────────────────

PatchResult builtin_patch(std::string_view patch_text, const PatchOptions &opts)
{
    PatchResult result;
    result.exit_code = 0;

    auto files = parse_patch(patch_text, opts.strip_level, opts.reverse);

    if (files.empty()) {
        return result;
    }

    bool had_rejects = false;

    for (const auto &pf : files) {
        if (pf.target_path.empty()) continue;

        if (!opts.quiet) {
            result.out += "patching file " + pf.target_path + "\n";
        }

        // Load current file contents
        FileContent fc;
        bool file_existed = file_exists(pf.target_path);

        if (pf.is_creation && file_existed) {
            // File exists but patch says it should be new — still try to apply
        }

        if (file_existed) {
            fc = load_file_lines(pf.target_path);
        } else if (!pf.is_creation) {
            // File doesn't exist and this isn't a creation patch
            result.err += "can't find file to patch at input line 0\n";
            if (!opts.force) {
                result.exit_code = 1;
                if (!opts.dry_run) {
                    had_rejects = true;
                    // Write all hunks as rejects
                    std::vector<bool> all_rejected(to_uz(std::ssize(pf.hunks)), true);
                    std::string rej_content = format_rejects(pf, all_rejected);
                    if (!rej_content.empty()) {
                        write_file(pf.target_path + ".rej", rej_content);
                    }
                }
                continue;
            }
        }

        // Try to match each hunk
        std::vector<ptrdiff_t> hunk_positions(to_uz(std::ssize(pf.hunks)), -1);
        std::vector<bool> rejected(to_uz(std::ssize(pf.hunks)), false);
        ptrdiff_t cumulative_offset = 0;
        ptrdiff_t last_frozen_line = 0;  // 0-based, exclusive: lines before this are frozen
        bool file_has_rejects = false;

        for (ptrdiff_t h = 0; h < std::ssize(pf.hunks); ++h) {
            const auto &hunk = pf.hunks[to_uz(h)];
            auto pattern = get_old_pattern(hunk);

            ptrdiff_t pos = locate_hunk(fc.lines, hunk, pattern,
                                         last_frozen_line, cumulative_offset,
                                         opts.fuzz);

            if (pos >= 0) {
                hunk_positions[to_uz(h)] = pos;
                ptrdiff_t pat_len = std::ssize(pattern);
                ptrdiff_t actual_offset = pos - (hunk.old_start - 1);

                if (actual_offset != cumulative_offset && !opts.quiet) {
                    char msg[256];
                    int fuzz_used = -1;
                    // Determine if fuzz was needed
                    if (opts.fuzz > 0) {
                        for (int f = 0; f <= opts.fuzz; ++f) {
                            if (try_match(fc.lines, pos, pattern, f)) {
                                fuzz_used = f;
                                break;
                            }
                        }
                    }
                    if (fuzz_used > 0) {
                        std::snprintf(msg, sizeof(msg),
                                     "Hunk #%d succeeded at %d with fuzz %d (offset %d lines).\n",
                                     to_int(h + 1), to_int(pos + 1), fuzz_used,
                                     to_int(actual_offset - cumulative_offset));
                    } else {
                        std::snprintf(msg, sizeof(msg),
                                     "Hunk #%d succeeded at %d (offset %d lines).\n",
                                     to_int(h + 1), to_int(pos + 1),
                                     to_int(actual_offset - cumulative_offset));
                    }
                    result.out += msg;
                } else if (opts.fuzz > 0 && !opts.quiet) {
                    // Check if fuzz was needed even at exact position
                    int fuzz_used = 0;
                    for (int f = 0; f <= opts.fuzz; ++f) {
                        if (try_match(fc.lines, pos, pattern, f)) {
                            fuzz_used = f;
                            break;
                        }
                    }
                    if (fuzz_used > 0) {
                        char msg[256];
                        std::snprintf(msg, sizeof(msg),
                                     "Hunk #%d succeeded at %d with fuzz %d.\n",
                                     to_int(h + 1), to_int(pos + 1), fuzz_used);
                        result.out += msg;
                    }
                }

                // Update offset and frozen line
                cumulative_offset = actual_offset;
                ptrdiff_t new_lines_count = 0;
                for (const auto &line : hunk.lines) {
                    if (line[0] == ' ' || line[0] == '+') ++new_lines_count;
                }
                last_frozen_line = pos + pat_len;
            } else {
                // Hunk failed
                rejected[to_uz(h)] = true;
                file_has_rejects = true;
                if (!opts.quiet) {
                    char msg[128];
                    std::snprintf(msg, sizeof(msg),
                                 "Hunk #%d FAILED at %d.\n",
                                 to_int(h + 1), to_int(hunk.old_start));
                    result.err += msg;
                }
            }
        }

        if (file_has_rejects) {
            had_rejects = true;
            result.exit_code = 1;
        }

        // Apply changes
        if (!opts.dry_run) {
            bool any_applied = false;
            for (ptrdiff_t h = 0; h < std::ssize(pf.hunks); ++h) {
                if (hunk_positions[to_uz(h)] >= 0) { any_applied = true; break; }
            }

            if (any_applied || pf.is_creation || (opts.merge && file_has_rejects)) {
                std::string new_content;

                if (opts.merge && file_has_rejects) {
                    new_content = build_merge_output(fc.lines, fc.has_trailing_newline,
                                                      pf, hunk_positions, opts.merge_style);
                } else {
                    new_content = build_output(fc.lines, fc.has_trailing_newline,
                                               pf, hunk_positions);
                }

                // Create parent directories if needed
                std::string dir = dirname(pf.target_path);
                if (!dir.empty() && dir != "." && !is_directory(dir)) {
                    make_dirs(dir);
                }

                // Check if we should remove the file (-E flag)
                if (opts.remove_empty && new_content.empty() && !pf.is_creation) {
                    if (file_existed) {
                        delete_file(pf.target_path);
                    }
                } else {
                    write_file(pf.target_path, new_content);
                }
            }

            // Write reject file if needed (and not in merge mode)
            if (file_has_rejects && !opts.merge) {
                std::string rej_content = format_rejects(pf, rejected);
                if (!rej_content.empty()) {
                    write_file(pf.target_path + ".rej", rej_content);
                }
                if (!opts.quiet) {
                    ptrdiff_t rej_count = 0;
                    for (bool r : rejected) if (r) ++rej_count;
                    char msg[256];
                    std::snprintf(msg, sizeof(msg),
                                 "%d out of %d hunk%s FAILED -- saving rejects to file %s.rej\n",
                                 to_int(rej_count), to_int(std::ssize(pf.hunks)),
                                 std::ssize(pf.hunks) == 1 ? "" : "s",
                                 pf.target_path.c_str());
                    result.err += msg;
                }
            }
        }
    }

    if (had_rejects) {
        result.exit_code = 1;
    }

    return result;
}
