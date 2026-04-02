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
        p = p.substr(checked_cast<size_t>(slash) + 1);
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
        rest = rest.substr(0, checked_cast<size_t>(tab));
    }
    // Trim trailing whitespace
    while (!rest.empty() && (rest.back() == ' ' || rest.back() == '\r')) {
        rest = rest.substr(0, checked_cast<size_t>(std::ssize(rest) - 1));
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
        if (!lines[checked_cast<size_t>(i)].starts_with("--- ")) {
            ++i;
            continue;
        }

        // Peek ahead for "+++ "
        if (i + 1 >= n || !lines[checked_cast<size_t>(i + 1)].starts_with("+++ ")) {
            ++i;
            continue;
        }

        PatchFile pf;
        std::string raw_old = extract_path(std::string_view(lines[checked_cast<size_t>(i)]).substr(4));
        std::string raw_new = extract_path(std::string_view(lines[checked_cast<size_t>(i + 1)]).substr(4));

        if (reverse) {
            std::swap(raw_old, raw_new);
        }

        pf.old_path = raw_old;
        pf.new_path = raw_new;
        pf.is_creation = (raw_old == "/dev/null");
        pf.is_deletion = (raw_new == "/dev/null");

        // Determine target path
        // Prefer new path like GNU patch does for the common -p0 case
        // where old has a .orig suffix (e.g., "--- f.txt.orig" / "+++ f.txt")
        if (pf.is_creation) {
            pf.target_path = strip_path(raw_new, strip_level);
        } else if (pf.is_deletion) {
            pf.target_path = strip_path(raw_old, strip_level);
        } else {
            std::string stripped_old = strip_path(raw_old, strip_level);
            std::string stripped_new = strip_path(raw_new, strip_level);
            // Use new path when old has .orig suffix, otherwise use
            // the shorter path (GNU patch heuristic)
            if (stripped_old.ends_with(".orig")) {
                pf.target_path = stripped_new;
            } else if (stripped_new.size() <= stripped_old.size()) {
                pf.target_path = stripped_new;
            } else {
                pf.target_path = stripped_old;
            }
        }

        i += 2;  // skip --- and +++ lines

        // Parse hunks
        while (i < n && lines[checked_cast<size_t>(i)].starts_with("@@ ")) {
            PatchHunk hunk;

            // Parse @@ -old_start[,old_count] +new_start[,new_count] @@
            std::string_view hdr = std::string_view(lines[checked_cast<size_t>(i)]);
            ptrdiff_t at1 = str_find(hdr, '-', 3);
            if (at1 < 0) { ++i; continue; }

            // Parse old range
            ptrdiff_t pos = at1 + 1;
            ptrdiff_t comma = str_find(hdr, ',', pos);
            ptrdiff_t space = str_find(hdr, ' ', pos);
            ptrdiff_t plus_pos = str_find(hdr, '+', pos);

            // Need '+' marker and a space or comma delimiter before it
            if (plus_pos < 0) { ++i; continue; }

            if (comma >= 0 && comma < plus_pos && plus_pos - comma >= 2) {
                hunk.old_start = parse_int(hdr.substr(checked_cast<size_t>(pos), checked_cast<size_t>(comma - pos)));
                hunk.old_count = parse_int(hdr.substr(checked_cast<size_t>(comma + 1), checked_cast<size_t>(plus_pos - comma - 2)));
            } else if (space >= 0 && space < plus_pos) {
                hunk.old_start = parse_int(hdr.substr(checked_cast<size_t>(pos), checked_cast<size_t>(space - pos)));
                hunk.old_count = 1;
            } else {
                ++i; continue;
            }

            // Parse new range
            pos = plus_pos + 1;
            comma = str_find(hdr, ',', pos);
            ptrdiff_t end_at = str_find(hdr, ' ', pos);
            if (end_at < 0) end_at = std::ssize(hdr);

            if (end_at <= pos) { ++i; continue; }

            if (comma >= 0 && comma < end_at) {
                hunk.new_start = parse_int(hdr.substr(checked_cast<size_t>(pos), checked_cast<size_t>(comma - pos)));
                hunk.new_count = parse_int(hdr.substr(checked_cast<size_t>(comma + 1), checked_cast<size_t>(end_at - comma - 1)));
            } else {
                hunk.new_start = parse_int(hdr.substr(checked_cast<size_t>(pos), checked_cast<size_t>(end_at - pos)));
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
                std::string_view ln = lines[checked_cast<size_t>(i)];

                if (ln.starts_with("\\ No newline at end of file") ||
                    ln.starts_with("\\ no newline at end of file")) {
                    // Applies to the preceding line
                    if (!hunk.lines.empty()) {
                        // Prefixes are already swapped if reverse=true, so
                        // '-' is always the old side and '+' the new side.
                        char prev_prefix = hunk.lines.back()[0];
                        if (prev_prefix == '-')
                            hunk.old_no_newline = true;
                        else if (prev_prefix == '+')
                            hunk.new_no_newline = true;
                        else
                            hunk.old_no_newline = hunk.new_no_newline = true;
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
    bool crlf = false;  // true if original file used \r\n line endings
};

static FileContent load_file_lines(std::string_view content)
{
    FileContent fc;
    if (content.empty()) {
        fc.has_trailing_newline = true;
        return fc;
    }

    fc.has_trailing_newline = (content.back() == '\n');

    // Detect \r\n from the first line ending
    auto first_lf = str_find(content, '\n');
    if (first_lf > 0 && content[checked_cast<size_t>(first_lf - 1)] == '\r')
        fc.crlf = true;

    ptrdiff_t start = 0;
    ptrdiff_t len = std::ssize(content);
    for (ptrdiff_t i = 0; i < len; ++i) {
        if (content[checked_cast<size_t>(i)] == '\n') {
            ptrdiff_t end = i;
            if (end > start && content[checked_cast<size_t>(end - 1)] == '\r')
                --end;
            fc.lines.emplace_back(content.substr(checked_cast<size_t>(start), checked_cast<size_t>(end - start)));
            start = i + 1;
        }
    }
    if (start < len) {
        std::string tail(content.substr(checked_cast<size_t>(start), checked_cast<size_t>(len - start)));
        if (!tail.empty() && tail.back() == '\r')
            tail.pop_back();
        fc.lines.push_back(std::move(tail));
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

// Count prefix and suffix context lines from the full hunk (including +/-
// lines).  This gives the true context extent: prefix context is the number
// of ' ' lines before the first '+' or '-' line, and suffix context is the
// number of ' ' lines after the last '+' or '-' line.
struct HunkContext {
    ptrdiff_t prefix = 0;
    ptrdiff_t suffix = 0;
};

// Per-hunk fuzz amounts used when matching (for trimming during application).
struct HunkFuzz {
    ptrdiff_t prefix = 0;
    ptrdiff_t suffix = 0;
};

static HunkContext get_hunk_context(const PatchHunk &hunk)
{
    HunkContext ctx;
    for (const auto &line : hunk.lines) {
        if (line[0] == ' ') ++ctx.prefix;
        else break;
    }
    for (auto it = hunk.lines.rbegin(); it != hunk.lines.rend(); ++it) {
        if ((*it)[0] == ' ') ++ctx.suffix;
        else break;
    }
    return ctx;
}

// Try to match a hunk's old-side pattern against file lines starting at
// position `pos` (0-based), with `fuzz` context lines skipped at top/bottom.
// prefix_ctx/suffix_ctx are the real context extents from the full hunk.
// Returns true if the pattern matches.
static bool try_match(std::span<const std::string> file_lines,
                      ptrdiff_t pos,
                      const std::vector<PatternLine> &pattern,
                      int fuzz,
                      ptrdiff_t prefix_ctx,
                      ptrdiff_t suffix_ctx)
{
    ptrdiff_t pat_len = std::ssize(pattern);
    if (pat_len == 0) return true;

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
        if (file_lines[checked_cast<size_t>(file_pos)] != pattern[checked_cast<size_t>(j)].text) return false;
        ++file_pos;
    }

    return true;
}

// Spiral search: find where a hunk matches in the file.
// Returns the 0-based file position, or -1 if not found.
// Updates cumulative_offset on success.
static ptrdiff_t locate_hunk(std::span<const std::string> file_lines,
                              const PatchHunk &hunk,
                              const std::vector<PatternLine> &pattern,
                              ptrdiff_t last_frozen_line,
                              ptrdiff_t cumulative_offset,
                              int max_fuzz)
{
    ptrdiff_t file_len = std::ssize(file_lines);
    ptrdiff_t pat_old_count = std::ssize(pattern);

    // Get real prefix/suffix context from full hunk (not just old-side pattern)
    auto ctx = get_hunk_context(hunk);

    // First guess: hunk header's old_start (1-based) converted to 0-based + offset
    ptrdiff_t first_guess = hunk.old_start - 1 + cumulative_offset;

    // Clamp to valid range
    ptrdiff_t max_pos = file_len - pat_old_count;
    if (max_pos < 0) max_pos = 0;

    for (int fuzz = 0; fuzz <= max_fuzz; ++fuzz) {
        ptrdiff_t prefix_fuzz = std::min(static_cast<ptrdiff_t>(fuzz), ctx.prefix);
        ptrdiff_t suffix_fuzz = std::min(static_cast<ptrdiff_t>(fuzz), ctx.suffix);
        ptrdiff_t effective_pat_len = pat_old_count - prefix_fuzz - suffix_fuzz;

        ptrdiff_t max_search = file_len - effective_pat_len;
        if (effective_pat_len == 0) max_search = file_len;  // empty pattern matches anywhere

        // Try exact position first
        if (first_guess >= 0 && first_guess <= max_search &&
            first_guess > last_frozen_line - 1) {
            if (try_match(file_lines, first_guess, pattern, fuzz, ctx.prefix, ctx.suffix)) {
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
                if (try_match(file_lines, pos, pattern, fuzz, ctx.prefix, ctx.suffix)) {
                    return pos;
                }
            }

            // Try backward
            pos = first_guess - delta;
            if (pos >= 0 && pos <= max_search && pos > last_frozen_line - 1) {
                if (try_match(file_lines, pos, pattern, fuzz, ctx.prefix, ctx.suffix)) {
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
// hunk_fuzz[i] = fuzz amounts used for hunk i (to trim context from both sides).
static std::string build_output(std::span<const std::string> file_lines,
                                 bool has_trailing_newline,
                                 const PatchFile &pf,
                                 const std::vector<ptrdiff_t> &hunk_positions,
                                 const std::vector<HunkFuzz> &hunk_fuzz)
{
    std::string output;
    ptrdiff_t file_len = std::ssize(file_lines);
    ptrdiff_t last_copied = 0;  // next line to copy from input

    for (ptrdiff_t h = 0; h < std::ssize(pf.hunks); ++h) {
        ptrdiff_t pos = hunk_positions[checked_cast<size_t>(h)];
        if (pos < 0) continue;  // rejected hunk, skip

        const auto &hunk = pf.hunks[checked_cast<size_t>(h)];
        auto pattern = get_old_pattern(hunk);
        ptrdiff_t pat_len = std::ssize(pattern);
        auto new_lines = get_new_lines(hunk);

        // When fuzz was used, trim the fuzzed context lines from both sides.
        // The fuzzed prefix/suffix context lines were not matched against the
        // file, so we must not replace them.
        auto fz = hunk_fuzz[checked_cast<size_t>(h)];
        pos += fz.prefix;
        pat_len -= fz.prefix + fz.suffix;
        if (pat_len < 0) pat_len = 0;
        ptrdiff_t new_start = fz.prefix;
        ptrdiff_t new_end = std::ssize(new_lines) - fz.suffix;
        if (new_end < new_start) new_end = new_start;

        // Clamp to file bounds
        if (pos > file_len) pos = file_len;

        // Copy unchanged lines from last_copied to pos
        for (ptrdiff_t j = last_copied; j < pos; ++j) {
            output += file_lines[checked_cast<size_t>(j)];
            output += '\n';
        }

        // Write replacement lines (trimmed by fuzz)
        for (ptrdiff_t j = new_start; j < new_end; ++j) {
            output += new_lines[checked_cast<size_t>(j)];
            bool is_last_new_line = (j == new_end - 1);
            if (is_last_new_line && fz.suffix == 0 && hunk.new_no_newline) {
                // Don't add trailing newline (only when suffix not trimmed)
            } else {
                output += '\n';
            }
        }

        last_copied = pos + pat_len;
        if (last_copied > file_len) last_copied = file_len;
    }

    // Copy remaining lines
    for (ptrdiff_t j = last_copied; j < file_len; ++j) {
        output += file_lines[checked_cast<size_t>(j)];
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
static std::string build_merge_output(std::span<const std::string> file_lines,
                                       bool has_trailing_newline,
                                       const PatchFile &pf,
                                       const std::vector<ptrdiff_t> &hunk_positions,
                                       const std::vector<HunkFuzz> &hunk_fuzz,
                                       std::string_view merge_style)
{
    // For merge mode, we first apply successful hunks, then for rejected hunks
    // we insert conflict markers at the hunk's expected position.
    std::string output;
    ptrdiff_t file_len = std::ssize(file_lines);
    ptrdiff_t last_copied = 0;

    // Process all hunks in order
    for (ptrdiff_t h = 0; h < std::ssize(pf.hunks); ++h) {
        const auto &hunk = pf.hunks[checked_cast<size_t>(h)];
        ptrdiff_t pos = hunk_positions[checked_cast<size_t>(h)];

        if (pos >= 0) {
            // Successfully matched — apply normally
            if (pos > file_len) pos = file_len;
            auto pattern = get_old_pattern(hunk);
            ptrdiff_t pat_len = std::ssize(pattern);
            auto new_lines = get_new_lines(hunk);

            // Trim fuzzed context lines
            auto fz = hunk_fuzz[checked_cast<size_t>(h)];
            pos += fz.prefix;
            pat_len -= fz.prefix + fz.suffix;
            if (pat_len < 0) pat_len = 0;
            ptrdiff_t new_start = fz.prefix;
            ptrdiff_t new_end = std::ssize(new_lines) - fz.suffix;
            if (new_end < new_start) new_end = new_start;

            if (pos > file_len) pos = file_len;

            for (ptrdiff_t j = last_copied; j < pos; ++j) {
                output += file_lines[checked_cast<size_t>(j)];
                output += '\n';
            }
            for (ptrdiff_t j = new_start; j < new_end; ++j) {
                output += new_lines[checked_cast<size_t>(j)];
                bool is_last = (j == new_end - 1);
                if (is_last && fz.suffix == 0 && hunk.new_no_newline) {
                    // no trailing newline
                } else {
                    output += '\n';
                }
            }
            last_copied = pos + pat_len;
            if (last_copied > file_len) last_copied = file_len;
        } else {
            // Rejected — insert per-change conflict markers at expected position
            ptrdiff_t expected = hunk.old_start - 1;
            if (expected < last_copied) expected = last_copied;
            if (expected > file_len) expected = file_len;

            // Copy up to expected position
            for (ptrdiff_t j = last_copied; j < expected; ++j) {
                output += file_lines[checked_cast<size_t>(j)];
                output += '\n';
            }

            // Walk through hunk lines, emitting context outside markers
            // and changed regions inside markers.
            ptrdiff_t file_pos = expected;
            ptrdiff_t hi = 0;
            ptrdiff_t hunk_len = std::ssize(hunk.lines);

            while (hi < hunk_len) {
                char prefix = hunk.lines[checked_cast<size_t>(hi)][0];

                if (prefix == ' ') {
                    // Context line — emit the file's actual line
                    if (file_pos < file_len) {
                        output += file_lines[checked_cast<size_t>(file_pos)];
                        output += '\n';
                        ++file_pos;
                    }
                    ++hi;
                } else {
                    // Changed region — collect contiguous -/+ lines
                    std::vector<std::string_view> old_lines, new_change;
                    while (hi < hunk_len && hunk.lines[checked_cast<size_t>(hi)][0] == '-') {
                        old_lines.push_back(std::string_view(hunk.lines[checked_cast<size_t>(hi)]).substr(1));
                        ++hi;
                    }
                    while (hi < hunk_len && hunk.lines[checked_cast<size_t>(hi)][0] == '+') {
                        new_change.push_back(std::string_view(hunk.lines[checked_cast<size_t>(hi)]).substr(1));
                        ++hi;
                    }

                    output += "<<<<<<<\n";

                    // Current file content for the old-side span
                    ptrdiff_t span = std::ssize(old_lines);
                    ptrdiff_t end = file_pos + span;
                    if (end > file_len) end = file_len;
                    for (ptrdiff_t j = file_pos; j < end; ++j) {
                        output += file_lines[checked_cast<size_t>(j)];
                        output += '\n';
                    }

                    if (merge_style == "diff3") {
                        output += "|||||||\n";
                        for (const auto &ol : old_lines) {
                            output += ol;
                            output += '\n';
                        }
                    }

                    output += "=======\n";
                    for (const auto &nl : new_change) {
                        output += nl;
                        output += '\n';
                    }
                    output += ">>>>>>>\n";

                    file_pos = end;
                }
            }

            last_copied = file_pos;
        }
    }

    // Copy remaining
    for (ptrdiff_t j = last_copied; j < file_len; ++j) {
        output += file_lines[checked_cast<size_t>(j)];
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
        if (!rejected[checked_cast<size_t>(h)]) continue;
        const auto &hunk = pf.hunks[checked_cast<size_t>(h)];

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
        result += std::format("@@ -{},{} +{},{} @@\n",
                              hunk.old_start, hunk.old_count,
                              hunk.new_start, hunk.new_count);

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

    // Filesystem abstraction: use in-memory map when opts.fs is set
    auto fs_exists = [&](std::string_view p) -> bool {
        if (opts.fs) return opts.fs->contains(std::string(p));
        return file_exists(p);
    };
    auto fs_read = [&](std::string_view p) -> std::string {
        if (opts.fs) {
            auto it = opts.fs->find(std::string(p));
            return it != opts.fs->end() ? it->second : std::string{};
        }
        return read_file(p);
    };
    auto fs_write = [&](std::string_view p, std::string_view c) -> bool {
        if (opts.fs) { (*opts.fs)[std::string(p)] = std::string(c); return true; }
        return write_file(p, c);
    };
    auto fs_delete = [&](std::string_view p) -> bool {
        if (opts.fs) { opts.fs->erase(std::string(p)); return true; }
        return delete_file(p);
    };

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
        bool file_existed = fs_exists(pf.target_path);

        if (pf.is_creation && file_existed) {
            // File exists but patch says it should be new — still try to apply
        }

        if (file_existed) {
            fc = load_file_lines(fs_read(pf.target_path));
        } else if (!pf.is_creation) {
            // File doesn't exist and this isn't a creation patch
            result.err += "can't find file to patch at input line 0\n";
            if (!opts.force) {
                result.exit_code = 1;
                if (!opts.dry_run) {
                    had_rejects = true;
                    // Write all hunks as rejects
                    std::vector<bool> all_rejected(checked_cast<size_t>(std::ssize(pf.hunks)), true);
                    std::string rej_content = format_rejects(pf, all_rejected);
                    if (!rej_content.empty()) {
                        fs_write(pf.target_path + ".rej", rej_content);
                    }
                }
                continue;
            }
        }

        // Try to match each hunk
        std::vector<ptrdiff_t> hunk_positions(checked_cast<size_t>(std::ssize(pf.hunks)), -1);
        std::vector<HunkFuzz> hunk_fuzz(checked_cast<size_t>(std::ssize(pf.hunks)));
        std::vector<bool> rejected(checked_cast<size_t>(std::ssize(pf.hunks)), false);
        ptrdiff_t cumulative_offset = 0;
        ptrdiff_t last_frozen_line = 0;  // 0-based, exclusive: lines before this are frozen
        bool file_has_rejects = false;

        for (ptrdiff_t h = 0; h < std::ssize(pf.hunks); ++h) {
            const auto &hunk = pf.hunks[checked_cast<size_t>(h)];
            auto pattern = get_old_pattern(hunk);

            ptrdiff_t pos = locate_hunk(fc.lines, hunk, pattern,
                                         last_frozen_line, cumulative_offset,
                                         opts.fuzz);

            if (pos >= 0) {
                hunk_positions[checked_cast<size_t>(h)] = pos;
                ptrdiff_t pat_len = std::ssize(pattern);
                ptrdiff_t actual_offset = pos - (std::max(hunk.old_start, ptrdiff_t{1}) - 1);
                auto ctx = get_hunk_context(hunk);

                // Determine fuzz level used for this hunk
                int fuzz_used = 0;
                if (opts.fuzz > 0) {
                    for (int f = 0; f <= opts.fuzz; ++f) {
                        if (try_match(fc.lines, pos, pattern, f, ctx.prefix, ctx.suffix)) {
                            fuzz_used = f;
                            break;
                        }
                    }
                }

                // Record fuzz amounts for build_output trimming
                hunk_fuzz[checked_cast<size_t>(h)] = {
                    std::min(static_cast<ptrdiff_t>(fuzz_used), ctx.prefix),
                    std::min(static_cast<ptrdiff_t>(fuzz_used), ctx.suffix)
                };
                auto &fz = hunk_fuzz[checked_cast<size_t>(h)];

                if (actual_offset != cumulative_offset && !opts.quiet) {
                    if (fuzz_used > 0) {
                        result.out += std::format(
                            "Hunk #{} succeeded at {} with fuzz {} (offset {} lines).\n",
                            h + 1, pos + 1, fuzz_used, actual_offset - cumulative_offset);
                    } else {
                        result.out += std::format(
                            "Hunk #{} succeeded at {} (offset {} lines).\n",
                            h + 1, pos + 1, actual_offset - cumulative_offset);
                    }
                } else if (fuzz_used > 0 && !opts.quiet) {
                    result.out += std::format(
                        "Hunk #{} succeeded at {} with fuzz {}.\n",
                        h + 1, pos + 1, fuzz_used);
                }

                // Update offset and frozen line (adjusted for fuzz)
                cumulative_offset = actual_offset;
                last_frozen_line = pos + pat_len - fz.suffix;
            } else {
                // Hunk failed
                rejected[checked_cast<size_t>(h)] = true;
                file_has_rejects = true;
                if (!opts.quiet) {
                    if (opts.merge) {
                        result.err += std::format("Hunk #{} NOT MERGED at {}.\n",
                                                  h + 1, hunk.old_start);
                    } else {
                        result.err += std::format("Hunk #{} FAILED at {}.\n",
                                                  h + 1, hunk.old_start);
                    }
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
                if (hunk_positions[checked_cast<size_t>(h)] >= 0) { any_applied = true; break; }
            }

            if (any_applied || pf.is_creation || (opts.merge && file_has_rejects)) {
                std::string new_content;

                if (opts.merge && file_has_rejects) {
                    new_content = build_merge_output(fc.lines, fc.has_trailing_newline,
                                                      pf, hunk_positions, hunk_fuzz,
                                                      opts.merge_style);
                } else {
                    new_content = build_output(fc.lines, fc.has_trailing_newline,
                                               pf, hunk_positions, hunk_fuzz);
                }

                // Restore \r\n line endings if the original file used them
                if (fc.crlf) {
                    std::string crlf_content;
                    crlf_content.reserve(new_content.size() + new_content.size() / 40);
                    for (size_t k = 0; k < new_content.size(); ++k) {
                        if (new_content[k] == '\n' &&
                            (k == 0 || new_content[k - 1] != '\r')) {
                            crlf_content += '\r';
                        }
                        crlf_content += new_content[k];
                    }
                    new_content = std::move(crlf_content);
                }

                // Create parent directories if needed
                if (!opts.fs) {
                    std::string dir = dirname(pf.target_path);
                    if (!dir.empty() && dir != "." && !is_directory(dir)) {
                        make_dirs(dir);
                    }
                }

                // Check if we should remove the file (-E flag)
                if (opts.remove_empty && new_content.empty() && !pf.is_creation) {
                    if (file_existed) {
                        fs_delete(pf.target_path);
                    }
                } else {
                    fs_write(pf.target_path, new_content);
                }
            }

            // Write reject file if needed (and not in merge mode)
            if (file_has_rejects && !opts.merge) {
                std::string rej_content = format_rejects(pf, rejected);
                if (!rej_content.empty()) {
                    fs_write(pf.target_path + ".rej", rej_content);
                }
                if (!opts.quiet) {
                    ptrdiff_t rej_count = 0;
                    for (bool r : rejected) if (r) ++rej_count;
                    result.err += std::format(
                        "{} out of {} {} FAILED -- saving rejects to file {}.rej\n",
                        rej_count, std::ssize(pf.hunks),
                        std::ssize(pf.hunks) == 1 ? "hunk" : "hunks",
                        pf.target_path);
                }
            }
        }
    }

    if (had_rejects) {
        result.exit_code = 1;
    }

    return result;
}
