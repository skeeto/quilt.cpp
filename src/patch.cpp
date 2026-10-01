// This is free and unencumbered software released into the public domain.
//
// Built-in patch engine for applying unified and context diffs.
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
    // How surely the patch says the file is absent before (old) and after
    // (new) it, as GNU patch judges: 0 not at all, 1 when the first hunk's
    // range on that side starts at line 0, 2 when the header also names
    // /dev/null or gives the epoch as the file's timestamp, as diff -N does
    int old_absent = 0;
    int new_absent = 0;
    // 1-based line where the text leading up to the first hunk begins,
    // after the previous file's last hunk, as GNU patch quotes it
    ptrdiff_t text_line = 0;
    ptrdiff_t hunk_line = 0;   // 1-based line of the first hunk header
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

// ── Diff parser ────────────────────────────────────────────────────────

// Remove prefix from the front of s, returning whether it was there.
static bool take(std::string_view &s, std::string_view prefix)
{
    if (!s.starts_with(prefix)) return false;
    s.remove_prefix(prefix.size());
    return true;
}

// Remove a decimal number from the front of s.
static bool take_number(std::string_view &s, ptrdiff_t &n)
{
    if (s.empty() || s[0] < '0' || s[0] > '9') return false;
    auto [end, ec] = std::from_chars(s.data(), s.data() + s.size(), n);
    if (ec != std::errc{}) return false;
    s.remove_prefix(checked_cast<size_t>(end - s.data()));
    return true;
}

// Whether a diff header's timestamp is the epoch, which diff -N gives a
// missing file.  Like GNU patch, match any time within the range of local
// time offsets of it, -25:00 to +26:00.  Reads the forms diff writes for -u,
// "1970-01-01 00:00:00.000000000 +0000", and -c, "Thu Jan  1 00:00:00 1970".
static bool is_epoch_timestamp(std::string_view s)
{
    ptrdiff_t year = 0, month = 0, day = 0, hour = 0, minute = 0, second = 0;
    auto skip_spaces = [&] { while (take(s, " ")) {} };
    auto take_time = [&] {
        return take_number(s, hour) && take(s, ":") && take_number(s, minute) &&
               take(s, ":") && take_number(s, second);
    };

    skip_spaces();
    if (take_number(s, year)) {
        if (!take(s, "-") || !take_number(s, month) || !take(s, "-") ||
            !take_number(s, day) || !take(s, " ") || !take_time()) {
            return false;
        }
        if (take(s, ".")) {
            while (!s.empty() && s[0] >= '0' && s[0] <= '9') s.remove_prefix(1);
        }
    } else {
        // Skip the weekday
        ptrdiff_t space = str_find(s, ' ');
        if (space < 0) return false;
        s.remove_prefix(checked_cast<size_t>(space));
        skip_spaces();
        static constexpr std::string_view months = "JanFebMarAprMayJunJulAugSepOctNovDec";
        if (std::ssize(s) < 3) return false;
        ptrdiff_t m = str_find(months, s.substr(0, 3));
        if (m < 0 || m % 3 != 0) return false;
        month = m / 3 + 1;
        s.remove_prefix(3);
        skip_spaces();
        if (!take_number(s, day) || !take(s, " ") || !take_time()) return false;
        skip_spaces();
        if (!take_number(s, year)) return false;
    }

    ptrdiff_t zone = 0;
    skip_spaces();
    bool west = take(s, "-");
    if (west || take(s, "+")) {
        ptrdiff_t hhmm = 0;
        if (!take_number(s, hhmm) || hhmm > 2459) return false;
        zone = (hhmm / 100 * 60 + hhmm % 100) * 60 * (west ? -1 : 1);
    }

    if (day > 31 || hour > 23 || minute > 59 || second > 60) return false;
    ptrdiff_t days;
    if (year == 1969 && month == 12) days = day - 32;
    else if (year == 1970 && month == 1) days = day - 1;
    else return false;  // too far from the epoch in any time zone
    ptrdiff_t t = ((days * 24 + hour) * 60 + minute) * 60 + second - zone;
    return -25 * 60 * 60 < t && t < 26 * 60 * 60;
}

// How surely a file header and the start of the first hunk's range on the
// same side say that the file is absent; see PatchFile.  A /dev/null name
// counts even without hunks, so such a header still creates or deletes.
static int absence(std::string_view header, ptrdiff_t first_start)
{
    if (extract_path(header) == "/dev/null") return 2;
    if (first_start != 0) return 0;
    ptrdiff_t tab = str_find(header, '\t');
    if (tab >= 0 && is_epoch_timestamp(header.substr(checked_cast<size_t>(tab) + 1))) {
        return 2;
    }
    return 1;
}

static bool is_no_newline_marker(std::string_view line)
{
    return line.starts_with("\\ No newline at end of file") ||
           line.starts_with("\\ no newline at end of file");
}

// GNU patch's message for a line it cannot parse.  It prints the line with
// its newline, so the message ends in a blank line.
static std::string malformed(ptrdiff_t lineno, std::string_view line)
{
    return std::format("malformed patch at line {}: {}\n", lineno, line);
}

static std::string malformed(std::span<const std::string> lines, ptrdiff_t i)
{
    return malformed(i + 1, lines[checked_cast<size_t>(i)]);
}

// Parse a unified hunk header "@@ -start[,count] +start[,count] @@" as
// leniently as GNU patch: the spaces are optional, and anything may follow
// the first '@' of the closing "@@".
static bool parse_unified_range(std::string_view s, PatchHunk &hunk)
{
    hunk.old_count = hunk.new_count = 1;
    if (!take(s, "@@ -") || !take_number(s, hunk.old_start)) return false;
    if (take(s, ",") && !take_number(s, hunk.old_count)) return false;
    take(s, " ");
    if (!take(s, "+") || !take_number(s, hunk.new_start)) return false;
    if (take(s, ",") && !take_number(s, hunk.new_count)) return false;
    take(s, " ");
    return s.starts_with("@");
}

// Parse the unified hunk whose header is lines[i], advancing i past it.
// Like GNU patch, read exactly the lines that the header's counts call for,
// so a hunk that ends early, at a line that does not fit or at the end of
// the patch, is malformed.
static bool parse_unified_hunk(std::span<const std::string> lines, ptrdiff_t &i,
                               PatchHunk &hunk, std::string &error)
{
    if (!parse_unified_range(lines[checked_cast<size_t>(i)], hunk)) {
        error = malformed(lines, i);
        return false;
    }
    ++i;

    ptrdiff_t n = std::ssize(lines);
    ptrdiff_t old_left = hunk.old_count, new_left = hunk.new_count;
    while (old_left > 0 || new_left > 0) {
        // When the patch ends with at most three new lines missing, GNU
        // patch assumes that blank context lines were chopped off, and
        // blames the patch's last line if they do not fit
        std::string_view ln = " ";
        ptrdiff_t lineno = n;
        if (i < n) {
            lineno = i + 1;
            ln = lines[checked_cast<size_t>(i++)];
        } else if (new_left > 3) {
            error = "unexpected end of file in patch";
            return false;
        }

        if (ln.starts_with('#')) continue;  // GNU patch skips comments

        // A blank line, or one that starts with a tab, is a context line
        // whose leading space was lost.  GNU patch also takes '=' for ' '.
        std::string line;
        if (ln.empty() || ln[0] == '\t') {
            line = " " + std::string(ln);
        } else if (ln[0] == '=') {
            line = " " + std::string(ln.substr(1));
        } else {
            line = std::string(ln);
        }
        char mark = line[0];
        bool fits = mark == '-' ? old_left > 0
                  : mark == '+' ? new_left > 0
                  : mark == ' ' && old_left > 0 && new_left > 0;
        if (!fits) {
            error = malformed(lineno, ln);
            return false;
        }
        if (mark != '+') old_left--;
        if (mark != '-') new_left--;
        hunk.lines.push_back(std::move(line));

        // "\ No newline at end of file" applies to the line before it.  GNU
        // patch accepts it only after the last line of a side, but the
        // built-in diff has written it after earlier lines too.
        while (i < n && is_no_newline_marker(lines[checked_cast<size_t>(i)])) {
            if (mark != '+') hunk.old_no_newline = true;
            if (mark != '-') hunk.new_no_newline = true;
            ++i;
        }
    }
    return true;
}

// Parse a context hunk range "*** start[,end] ****" or "--- start[,end] ----",
// where mark is "***" or "---".  A lone number names one line, or none if
// it is 0.
static bool parse_context_range(std::string_view s, std::string_view mark,
                                ptrdiff_t &start, ptrdiff_t &count)
{
    if (!take(s, mark) || !take(s, " ") || !take_number(s, start)) return false;
    count = start ? 1 : 0;
    if (take(s, ",")) {
        ptrdiff_t end = 0;
        if (!take_number(s, end) || end < start) return false;
        count = end - start + 1;
    }
    return take(s, " ") && s.starts_with(mark);
}

// One section of a context hunk: lines with their markers (' ', '-', '+'
// or '!'), and whether the last line lacks a newline.
struct ContextLine {
    char mark;
    std::string_view text;
};

struct ContextSection {
    std::vector<ContextLine> lines;
    bool no_newline = false;
};

// Split a context hunk line "m text" whose marker m is one of marks.  diff -T
// puts a tab after the marker instead of a space, and a blank line can lose
// its trailing whitespace, leaving just the marker or nothing at all.
static bool split_context_line(std::string_view ln, std::string_view marks,
                               ContextLine &cl)
{
    if (ln.empty()) {
        cl = {' ', {}};
        return true;
    }
    if (str_find(marks, ln[0]) < 0) return false;
    if (std::ssize(ln) > 1 && ln[1] != ' ' && ln[1] != '\t') return false;
    cl = {ln[0], ln.substr(std::ssize(ln) > 1 ? 2 : 1)};
    return true;
}

// Parse the context hunk whose "***************" line is lines[i], advancing
// i past it, and convert it to unified form.  diff omits a section that has
// no changes, in which case the section is the other one's context lines.
static bool parse_context_hunk(std::span<const std::string> lines, ptrdiff_t &i,
                               PatchHunk &hunk, std::string &error)
{
    ptrdiff_t n = std::ssize(lines);
    auto at = [&](ptrdiff_t k) -> std::string_view {
        return lines[checked_cast<size_t>(k)];
    };

    ++i;
    ptrdiff_t range_line = i;
    if (i >= n) {
        error = "unexpected end of file in patch";
        return false;
    }
    if (!parse_context_range(at(i), "***", hunk.old_start, hunk.old_count)) {
        error = malformed(lines, i);
        return false;
    }

    ContextSection old_sec, new_sec;
    for (++i; i < n && !at(i).starts_with("--- "); ++i) {
        ContextLine cl;
        if (is_no_newline_marker(at(i))) {
            old_sec.no_newline = true;
        } else if (split_context_line(at(i), " -!", cl)) {
            old_sec.lines.push_back(cl);
        } else {
            error = malformed(lines, i);
            return false;
        }
    }
    if (i >= n) {
        error = "unexpected end of file in patch";
        return false;
    }
    if (!parse_context_range(at(i), "---", hunk.new_start, hunk.new_count)) {
        error = malformed(lines, i);
        return false;
    }

    // Unlike the old section, the new section has no terminator, so stop
    // after the lines its range names.  A first line that is not part of
    // it means the section was omitted.  That includes a blank line, unless
    // a change ('!') in the old section requires a new section.
    bool may_omit = std::ranges::none_of(old_sec.lines, [](const ContextLine &cl) {
        return cl.mark == '!';
    });
    for (++i; i < n && std::ssize(new_sec.lines) < hunk.new_count; ++i) {
        ContextLine cl;
        if (is_no_newline_marker(at(i))) {
            new_sec.no_newline = true;
            continue;
        }
        if (new_sec.lines.empty() && at(i).empty() && may_omit) break;
        if (!split_context_line(at(i), " +!", cl)) {
            if (new_sec.lines.empty()) break;
            error = malformed(lines, i);
            return false;
        }
        new_sec.lines.push_back(cl);
    }
    if (i < n && is_no_newline_marker(at(i))) {
        new_sec.no_newline = true;
        ++i;
    }

    auto context_of = [](const ContextSection &sec) {
        ContextSection ctx;
        for (const auto &cl : sec.lines) {
            if (cl.mark == ' ') ctx.lines.push_back(cl);
        }
        ctx.no_newline = sec.no_newline && !sec.lines.empty() &&
                         sec.lines.back().mark == ' ';
        return ctx;
    };
    if (old_sec.lines.empty()) {
        old_sec = context_of(new_sec);
    } else if (new_sec.lines.empty()) {
        new_sec = context_of(old_sec);
    }

    // A lone line number with no lines names the empty range after that
    // line, as diff -C0 writes for a pure insertion or deletion.  The other
    // section has the change then, or the hunk ended before its lines.
    auto fits = [](ptrdiff_t &count, ptrdiff_t actual, ptrdiff_t other) {
        if (actual == 0 && count == 1 && other > 0) count = 0;
        return actual == count;
    };
    if (!fits(hunk.old_count, std::ssize(old_sec.lines), std::ssize(new_sec.lines)) ||
        !fits(hunk.new_count, std::ssize(new_sec.lines), std::ssize(old_sec.lines))) {
        error = std::format("replacement text or line numbers mangled in hunk at line {}",
                            range_line + 1);
        return false;
    }

    // Interleave the sections, pairing up their context lines
    ptrdiff_t old_n = std::ssize(old_sec.lines);
    ptrdiff_t new_n = std::ssize(new_sec.lines);
    ptrdiff_t o = 0, w = 0;
    for (;;) {
        for (; o < old_n && old_sec.lines[checked_cast<size_t>(o)].mark != ' '; ++o) {
            hunk.lines.push_back("-" + std::string(old_sec.lines[checked_cast<size_t>(o)].text));
        }
        for (; w < new_n && new_sec.lines[checked_cast<size_t>(w)].mark != ' '; ++w) {
            hunk.lines.push_back("+" + std::string(new_sec.lines[checked_cast<size_t>(w)].text));
        }
        if (o == old_n && w == new_n) break;
        if (o == old_n || w == new_n ||
            old_sec.lines[checked_cast<size_t>(o)].text !=
                new_sec.lines[checked_cast<size_t>(w)].text) {
            error = std::format("context mangled in hunk at line {}", range_line + 1);
            return false;
        }
        hunk.lines.push_back(" " + std::string(old_sec.lines[checked_cast<size_t>(o)].text));
        ++o;
        ++w;
    }
    hunk.old_no_newline = old_sec.no_newline;
    hunk.new_no_newline = new_sec.no_newline;
    return true;
}

// Swap a hunk's old and new sides, as patch -R does.
static void reverse_hunk(PatchHunk &hunk)
{
    std::swap(hunk.old_start, hunk.new_start);
    std::swap(hunk.old_count, hunk.new_count);
    std::swap(hunk.old_no_newline, hunk.new_no_newline);
    for (auto &line : hunk.lines) {
        if (line[0] == '-') line[0] = '+';
        else if (line[0] == '+') line[0] = '-';
    }
}

// Parse the lines of a complete unified or context diff into a list of
// per-file patch descriptions.  A hunk that does not parse ends parsing,
// with GNU patch's message for it in error.
static std::vector<PatchFile> parse_patch(std::span<const std::string> lines,
                                           int strip_level, bool reverse,
                                           std::string &error)
{
    std::vector<PatchFile> files;
    ptrdiff_t n = std::ssize(lines);
    auto at = [&](ptrdiff_t k) -> std::string_view {
        return lines[checked_cast<size_t>(k)];
    };

    ptrdiff_t i = 0;
    ptrdiff_t text_line = 1;
    while (i < n) {
        // A unified diff names the files on "--- " and "+++ " lines, and a
        // context diff on "*** " and "--- " lines before its first hunk
        bool unified = at(i).starts_with("--- ") &&
                       i + 1 < n && at(i + 1).starts_with("+++ ");
        bool context = at(i).starts_with("*** ") &&
                       i + 2 < n && at(i + 1).starts_with("--- ") &&
                       at(i + 2).starts_with("***************");
        if (!unified && !context) {
            ++i;
            continue;
        }

        PatchFile pf;
        std::string_view old_header = at(i).substr(4);
        std::string_view new_header = at(i + 1).substr(4);

        if (reverse) {
            std::swap(old_header, new_header);
        }

        std::string raw_old = extract_path(old_header);
        std::string raw_new = extract_path(new_header);
        pf.old_path = raw_old;
        pf.new_path = raw_new;

        // Determine target path
        // Prefer new path like GNU patch does for the common -p0 case
        // where old has a .orig suffix (e.g., "--- f.txt.orig" / "+++ f.txt")
        if (raw_old == "/dev/null") {
            pf.target_path = strip_path(raw_new, strip_level);
        } else if (raw_new == "/dev/null") {
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

        i += 2;  // skip the file header lines
        pf.text_line = text_line;
        pf.hunk_line = i + 1;

        std::string_view hunk_start = unified ? "@@ " : "***************";
        while (i < n && at(i).starts_with(hunk_start)) {
            PatchHunk hunk;
            bool ok = unified ? parse_unified_hunk(lines, i, hunk, error)
                              : parse_context_hunk(lines, i, hunk, error);
            if (!ok) return files;
            if (reverse) reverse_hunk(hunk);
            pf.hunks.push_back(std::move(hunk));
        }

        // GNU patch judges from the first hunk alone
        const PatchHunk *first = pf.hunks.empty() ? nullptr : &pf.hunks[0];
        pf.old_absent = absence(old_header, first ? first->old_start : -1);
        pf.new_absent = absence(new_header, first ? first->new_start : -1);

        // Like GNU patch, ignore file headers with no hunk after them, so
        // the text leading up to the next file includes them
        if (!pf.hunks.empty()) {
            files.push_back(std::move(pf));
            text_line = i + 1;
        }
    }

    return files;
}

std::vector<std::string> patch_target_files(std::string_view patch_text,
                                            int strip_level, bool reverse)
{
    std::vector<std::string> result;
    std::string error;  // a patch that does not parse will not apply anyway
    auto lines = split_lines(patch_text);
    for (auto &pf : parse_patch(lines, strip_level, reverse, error)) {
        if (pf.target_path.empty()) continue;
        if (std::ranges::find(result, pf.target_path) != result.end()) continue;
        result.push_back(std::move(pf.target_path));
    }
    return result;
}

// Remove directories left empty by deleting path, like GNU patch.
static void remove_empty_parents(std::string_view path)
{
    for (std::string dir = dirname(path); dir != "." && dir != "/";
         dir = dirname(dir)) {
        if (!delete_dir(dir)) break;
    }
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

// 0-based file position of the hunk's old range.  An empty range names the
// line it follows, as in "@@ -5,0 +6 @@" or "*** 5 ****" from diff -U0/-C0.
static ptrdiff_t old_range_pos(const PatchHunk &hunk)
{
    if (hunk.old_count == 0) return hunk.old_start;
    return std::max(hunk.old_start, ptrdiff_t{1}) - 1;
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

    // First guess: the position the hunk header names, plus the offset
    ptrdiff_t first_guess = old_range_pos(hunk) + cumulative_offset;

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

        // Spiral outward.  Start at the first offset that reaches a
        // position the checks below accept, so a guess far past the end
        // of the file, from a hunk header with a huge line number, doesn't
        // step through every line in between.
        ptrdiff_t max_offset_forward = max_search - first_guess;
        ptrdiff_t max_offset_backward = first_guess - last_frozen_line;
        ptrdiff_t max_range = std::max(max_offset_forward, max_offset_backward);
        if (max_range < 0) max_range = 0;
        ptrdiff_t min_range = std::max({ptrdiff_t{1},
                                        last_frozen_line - first_guess,
                                        first_guess - max_search});

        for (ptrdiff_t delta = min_range; delta <= max_range; ++delta) {
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
            ptrdiff_t expected = old_range_pos(hunk);
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

    std::string parse_error;
    auto lines = split_lines(patch_text);
    auto files = parse_patch(lines, opts.strip_level, opts.reverse, parse_error);

    // A hunk that does not parse is fatal, so apply none of the patch
    if (!parse_error.empty()) {
        result.exit_code = 2;
        result.err = "patch: **** " + parse_error + "\n";
        return result;
    }

    // Like GNU patch, empty input applies nothing, but input with no hunk
    // at all is fatal, even with -f or -s
    if (files.empty()) {
        if (!patch_text.empty()) {
            result.exit_code = 2;
            result.err = "patch: **** Only garbage was found in the patch input.\n";
        }
        return result;
    }

    bool had_rejects = false;
    std::vector<std::string> patched;  // targets of the sections not skipped

    for (const auto &pf : files) {
        if (pf.target_path.empty()) continue;

        bool file_existed = fs_exists(pf.target_path);
        std::string original = file_existed ? fs_read(pf.target_path) : std::string{};
        bool is_empty = original.empty();

        // Like GNU patch given -f, as quilt always does, warn about a
        // patch that creates a file with contents, or deletes or empties
        // one that is missing or empty, then apply it anyway
        bool looks_reversed = is_empty ? pf.new_absent > 0 : pf.old_absent == 2;
        if (looks_reversed && !opts.quiet) {
            result.out += std::format(
                "The next patch{} would {} the file {},\nwhich {}!  Applying it anyway.\n",
                opts.reverse ? ", when reversed," : "",
                !file_existed ? "delete" : is_empty ? "empty out" : "create",
                pf.target_path,
                !file_existed ? "does not exist" : is_empty ? "is already empty"
                                                            : "already exists");
        }

        // A missing file is patched as empty when the patch creates it, or
        // when GNU patch would have warned above.  Otherwise, like GNU patch
        // given -f, as quilt always does, quote the text leading up to the
        // first hunk and skip the file without writing rejects.  As with -s,
        // quiet drops only the first two lines.
        if (!file_existed && !pf.old_absent && !looks_reversed) {
            if (!opts.quiet) {
                result.err += std::format(
                    "can't find file to patch at input line {}\n"
                    "Perhaps you used the wrong -p or --strip option?\n",
                    pf.hunk_line);
            }
            result.err += "The text leading up to this was:\n"
                          "--------------------------\n";
            for (ptrdiff_t k = pf.text_line; k < pf.hunk_line; ++k) {
                result.err += "|" + lines[checked_cast<size_t>(k - 1)] + "\n";
            }
            ptrdiff_t nhunks = std::ssize(pf.hunks);
            result.err += std::format(
                "--------------------------\n"
                "No file to patch.  Skipping patch.\n"
                "{} out of {} {} ignored\n",
                nhunks, nhunks, nhunks == 1 ? "hunk" : "hunks");
            result.exit_code = 1;
            if (std::ranges::find(result.skipped, pf.target_path) == result.skipped.end()) {
                result.skipped.push_back(pf.target_path);
            }
            continue;
        }
        patched.push_back(pf.target_path);

        if (!opts.quiet) {
            result.out += "patching file " + pf.target_path + "\n";
        }
        FileContent fc = load_file_lines(original);

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

            // Like GNU patch, outside merge mode refuse a hunk at the top
            // of a file with contents when the patch surely creates it
            bool refused = !opts.merge && pos == 0 && pf.old_absent == 2 && !is_empty;

            if (pos >= 0 && !refused) {
                hunk_positions[checked_cast<size_t>(h)] = pos;
                ptrdiff_t pat_len = std::ssize(pattern);
                ptrdiff_t actual_offset = pos - old_range_pos(hunk);
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
                    // Like GNU patch, only +1 is singular; -1 stays "lines"
                    ptrdiff_t offset = actual_offset - cumulative_offset;
                    const char *plural = offset == 1 ? "" : "s";
                    if (fuzz_used > 0) {
                        result.out += std::format(
                            "Hunk #{} succeeded at {} with fuzz {} (offset {} line{}).\n",
                            h + 1, pos + 1, fuzz_used, offset, plural);
                    } else {
                        result.out += std::format(
                            "Hunk #{} succeeded at {} (offset {} line{}).\n",
                            h + 1, pos + 1, offset, plural);
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
                                                  h + 1, refused ? pos + 1 : hunk.old_start);
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

            bool creating = !file_existed && pf.old_absent;
            if (any_applied || creating || (opts.merge && file_has_rejects)) {
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

                // Remove a file left empty when -E is given or the patch
                // surely deletes it, like GNU patch outside POSIX mode
                if ((opts.remove_empty || pf.new_absent == 2) &&
                    new_content.empty() && !pf.old_absent) {
                    if (file_existed && fs_delete(pf.target_path) && !opts.fs) {
                        remove_empty_parents(pf.target_path);
                    }
                } else {
                    if (pf.new_absent == 2 && !new_content.empty() &&
                        !(opts.merge && file_has_rejects)) {
                        result.exit_code = 1;
                        if (!opts.quiet) {
                            result.err += "Not deleting file " + pf.target_path +
                                          " as content differs from patch\n";
                        }
                    }
                    fs_write(pf.target_path, new_content);
                }
            }

            // Write reject file if needed (and not in merge mode)
            if (file_has_rejects && !opts.merge) {
                std::string rej_content = format_rejects(pf, rejected);
                if (!rej_content.empty()) {
                    fs_write(pf.target_path + ".rej", rej_content);
                }
                // Like GNU patch, even with -s
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

    if (had_rejects) {
        result.exit_code = 1;
    }

    // Another section may have patched a skipped file, say by creating it
    std::erase_if(result.skipped, [&](const std::string &file) {
        return std::ranges::find(patched, file) != patched.end();
    });

    return result;
}
