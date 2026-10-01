// This is free and unencumbered software released into the public domain.
#include "quilt.hpp"
#include "platform.hpp"

ptrdiff_t QuiltState::top_index() const {
    if (applied.empty()) return -1;
    const std::string &top = applied.back();
    for (ptrdiff_t i = 0; i < std::ssize(series); ++i) {
        if (series[checked_cast<size_t>(i)] == top) return i;
    }
    return -1;
}

std::string QuiltState::patch_after_top() const {
    ptrdiff_t next = 0;
    if (!applied.empty()) {
        ptrdiff_t top = top_index();
        if (top < 0) return {};
        next = top + 1;
    }
    if (next >= std::ssize(series)) return {};
    return series[checked_cast<size_t>(next)];
}

bool QuiltState::is_applied(std::string_view patch) const {
    for (const auto &a : applied) {
        if (a == patch) return true;
    }
    return false;
}

std::optional<ptrdiff_t> QuiltState::find_in_series(std::string_view patch) const {
    for (ptrdiff_t i = 0; i < std::ssize(series); ++i) {
        if (series[checked_cast<size_t>(i)] == patch) return i;
    }
    return std::nullopt;
}

int QuiltState::get_strip_level(std::string_view patch) const {
    auto it = patch_strip_level.find(std::string(patch));
    if (it != patch_strip_level.end()) return it->second;
    return 1;
}

std::string QuiltState::get_p_format(std::string_view patch) const {
    return std::to_string(get_strip_level(patch));
}

void out(std::string_view s) {
    fd_write_stdout(s);
}

void out_line(std::string_view s) {
    fd_write_stdout(s);
    fd_write_stdout("\n");
}

void err(std::string_view s) {
    fd_write_stderr(s);
}

void err_line(std::string_view s) {
    fd_write_stderr(s);
    fd_write_stderr("\n");
}

static bool is_absolute_path(std::string_view p) {
    if (!p.empty() && p[0] == '/') return true;
    // Windows: drive letter (e.g. C:\, D:/)
    if (p.size() >= 3 && ((p[0] >= 'A' && p[0] <= 'Z') ||
                           (p[0] >= 'a' && p[0] <= 'z')) &&
        p[1] == ':' && (p[2] == '/' || p[2] == '\\')) return true;
    return false;
}

std::string path_join(std::string_view a, std::string_view b) {
    if (a.empty()) return std::string(b);
    if (b.empty()) return std::string(a);
    if (is_absolute_path(b)) return std::string(b);
    if (a.back() == '/' || a.back() == '\\') return std::string(a) + std::string(b);
    return std::string(a) + "/" + std::string(b);
}

std::string path_join(std::string_view a, std::string_view b, std::string_view c) {
    return path_join(path_join(a, b), c);
}

std::string basename(std::string_view path) {
    if (path.empty()) return "";
    // Strip trailing slashes
    while (std::ssize(path) > 1 && path.back() == '/')
        path.remove_suffix(1);
    auto pos = str_rfind(path, '/');
    if (pos < 0) return std::string(path);
    return std::string(path.substr(checked_cast<size_t>(pos + 1)));
}

std::string dirname(std::string_view path) {
    if (path.empty()) return ".";
    // Strip trailing slashes
    while (std::ssize(path) > 1 && path.back() == '/')
        path.remove_suffix(1);
    auto pos = str_rfind(path, '/');
    if (pos < 0) return ".";
    if (pos == 0) return "/";
    return std::string(path.substr(0, checked_cast<size_t>(pos)));
}

std::string strip_trailing_slash(std::string_view s) {
    while (!s.empty() && s.back() == '/')
        s.remove_suffix(1);
    return s.empty() ? std::string("/") : std::string(s);
}

std::string format_patch(const QuiltState &q, std::string_view name) {
    if (!get_env("QUILT_PATCHES_PREFIX").empty()) {
        return q.patches_dir + "/" + std::string(name);
    }
    return std::string(name);
}

std::string next_filename(std::string_view patch) {
    // Set aside one compression suffix, then one patch suffix
    std::string_view base = patch;
    for (std::string_view ext : {".gz", ".bz2", ".xz", ".lzma", ".lz", ".zst"}) {
        if (base.ends_with(ext)) {
            base.remove_suffix(ext.size());
            break;
        }
    }
    for (std::string_view ext : {".diff", ".dif", ".patch"}) {
        if (base.ends_with(ext)) {
            base.remove_suffix(ext.size());
            break;
        }
    }
    std::string_view ext = patch.substr(base.size());

    // Take a trailing "-N" as decimal even with leading zeros, which
    // upstream's shell arithmetic reads as octal
    std::string_view stem = base;
    while (!stem.empty() && stem.back() >= '0' && stem.back() <= '9')
        stem.remove_suffix(1);
    std::string_view digits = base.substr(stem.size());
    std::string num = "1";
    if (!digits.empty() && stem.ends_with('-')) {
        while (std::ssize(digits) > 1 && digits.front() == '0')
            digits.remove_prefix(1);
        num = digits;
        stem.remove_suffix(1);
    } else {
        stem = base;
    }

    // Count up in the string itself, so that no N is too long
    auto it = num.rbegin();
    for (; it != num.rend() && *it == '9'; ++it)
        *it = '0';
    if (it == num.rend()) num.insert(num.begin(), '1');
    else ++*it;

    return std::string(stem) + "-" + num + std::string(ext);
}

std::optional<std::string> find_patch(const QuiltState &q, std::string_view name) {
    // A bare "patches/" strips to nothing, which names no patch
    std::string_view patch = strip_patches_prefix(q, name);
    if (!patch.empty() && q.find_in_series(patch)) {
        return std::string(patch);
    }
    if (!q.series_file_exists) {
        err_line("No series file found");
    } else if (q.series.empty()) {
        err_line("No patches in series");
    } else {
        // Upstream echoes the name as given here, but not below
        err("Patch "); err(name); err_line(" is not in series");
    }
    return std::nullopt;
}

std::optional<std::string> find_top_patch(const QuiltState &q) {
    // Upstream checks for the series file, and that it still matches the
    // applied patches, before running any command that looks up a patch
    if (!q.series_file_exists) {
        err_line("No series file found");
        return std::nullopt;
    }
    if (!q.applied.empty()) {
        if (!q.find_in_series(q.applied.back())) {
            err_line("The series file no longer matches the applied patches. "
                     "Please run 'quilt pop -a'.");
            return std::nullopt;
        }
        return q.applied.back();
    }
    if (q.series.empty()) {
        err_line("No patches in series");
    } else {
        err_line("No patches applied");
    }
    return std::nullopt;
}

std::optional<std::string> find_patch_in_series(const QuiltState &q, std::string_view name) {
    return name.empty() ? find_top_patch(q) : find_patch(q, name);
}

std::optional<std::string> find_applied_patch(const QuiltState &q, std::string_view name) {
    if (name.empty()) return find_top_patch(q);
    auto patch = find_patch(q, name);
    if (patch && !q.is_applied(*patch)) {
        err("Patch "); err(format_patch(q, *patch)); err_line(" is not applied");
        return std::nullopt;
    }
    return patch;
}

bool valid_color_value(std::string_view when) {
    return when.empty() || when == "always" || when == "auto" ||
           when == "tty" || when == "never";
}

std::string trim(std::string_view s) {
    while (!s.empty() && (s.front() == ' ' || s.front() == '\t' ||
                          s.front() == '\r' || s.front() == '\n'))
        s.remove_prefix(1);
    while (!s.empty() && (s.back() == ' ' || s.back() == '\t' ||
                          s.back() == '\r' || s.back() == '\n'))
        s.remove_suffix(1);
    return std::string(s);
}

std::vector<std::string> split_lines(std::string_view s) {
    std::vector<std::string> lines;
    while (!s.empty()) {
        auto pos = str_find(s, '\n');
        if (pos < 0) {
            if (!s.empty() && s.back() == '\r')
                s.remove_suffix(1);
            lines.emplace_back(s);
            break;
        }
        auto end = checked_cast<size_t>(pos);
        if (end > 0 && s[end - 1] == '\r')
            --end;
        lines.emplace_back(s.substr(0, end));
        s.remove_prefix(checked_cast<size_t>(pos + 1));
    }
    return lines;
}

// /^<tag>[ \t][^ \t]/ for a tag of "***", "---" or "+++"
static bool is_file_label(std::string_view line, std::string_view tag) {
    return std::ssize(line) >= 5 && line.starts_with(tag) &&
           (line[3] == ' ' || line[3] == '\t') &&
           line[4] != ' ' && line[4] != '\t';
}

// /^Index:[ \t][^ \t]|^diff -/
static bool is_diff_start(std::string_view line) {
    return line.starts_with("diff -") ||
           (std::ssize(line) >= 8 && line.starts_with("Index:") &&
            (line[6] == ' ' || line[6] == '\t') &&
            line[7] != ' ' && line[7] != '\t');
}

struct PatchSplit {
    ptrdiff_t header_end;  // the header is [0, header_end)
    ptrdiff_t body_start;  // the body is [body_start, end)
};

// The state machine shared by upstream's patch_header and patch_body awk
// scripts. A "*** x" or "--- x" line starts the body only when the next
// line is "--- y" or "+++ y" respectively. When it is not, the held line
// goes to the header, and the next line cannot be held in turn, though it
// may still be an "Index: x" or "diff -" line. A line still held at the
// end of input is in neither part.
static PatchSplit split_patch(std::string_view s) {
    std::string_view confirm;  // the label that confirms the held line
    ptrdiff_t held = 0;
    ptrdiff_t n = std::ssize(s);
    for (ptrdiff_t pos = 0, next = 0; pos < n; pos = next) {
        ptrdiff_t nl = str_find(s, '\n', pos);
        ptrdiff_t end = nl < 0 ? n : nl;
        next = nl < 0 ? n : nl + 1;
        std::string_view line = s.substr(checked_cast<size_t>(pos),
                                         checked_cast<size_t>(end - pos));
        if (confirm.empty()) {
            if (is_file_label(line, "***")) confirm = "---";
            else if (is_file_label(line, "---")) confirm = "+++";
            if (!confirm.empty()) {
                held = pos;
                continue;
            }
        } else if (is_file_label(line, confirm)) {
            return {held, held};
        } else {
            confirm = {};
        }
        if (is_diff_start(line)) return {pos, pos};
    }
    return {confirm.empty() ? n : held, n};
}

// Like awk's print, end the last line with a newline
static std::string awk_lines(std::string_view s) {
    std::string r(s);
    if (!r.empty() && r.back() != '\n') r += '\n';
    return r;
}

std::string patch_header(std::string_view patch) {
    auto split = split_patch(patch);
    return awk_lines(patch.substr(0, checked_cast<size_t>(split.header_end)));
}

std::string patch_body(std::string_view patch) {
    auto split = split_patch(patch);
    return awk_lines(patch.substr(checked_cast<size_t>(split.body_start)));
}

// Remove the first line from s and return it without its '\n'
static std::string_view take_line(std::string_view &s) {
    ptrdiff_t nl = str_find(s, '\n');
    ptrdiff_t len = nl < 0 ? std::ssize(s) : nl;
    std::string_view line = s.substr(0, checked_cast<size_t>(len));
    s.remove_prefix(checked_cast<size_t>(nl < 0 ? len : len + 1));
    return line;
}

// /^#? .* files? changed/, how upstream's diffstat summary patterns start
static bool is_diffstat_summary(std::string_view line) {
    ptrdiff_t p = line.starts_with('#') ? 1 : 0;
    return std::ssize(line) > p && line[checked_cast<size_t>(p)] == ' ' &&
           (str_find(line, " file changed", p + 1) >= 0 ||
            str_find(line, " files changed", p + 1) >= 0);
}

// Like upstream: lines matching /#? .* \| / are held until a line matching
// /^#? .* files? changed/ drops them and itself, or any other line puts
// them back. The awk script has no END rule, so lines still held at the
// end are lost.
std::string strip_diffstat(std::string_view header) {
    std::string result;
    std::string held;
    while (!header.empty()) {
        std::string_view line = take_line(header);
        ptrdiff_t space = str_find(line, ' ');
        if (space >= 0 && str_find(line, " | ", space + 1) >= 0) {
            held += line;
            held += '\n';
            continue;
        }
        if (is_diffstat_summary(line)) {
            held.clear();
            continue;
        }
        result += held;
        result += line;
        result += '\n';
        held.clear();
    }
    return result;
}

// /^#? .* \|  *[1-9][0-9]* /, upstream refresh's diffstat file line
static bool is_diffstat_file_line(std::string_view line) {
    ptrdiff_t n = std::ssize(line);
    ptrdiff_t p = line.starts_with('#') ? 1 : 0;
    if (n <= p || line[checked_cast<size_t>(p)] != ' ') return false;
    auto at = [&](ptrdiff_t i) { return line[checked_cast<size_t>(i)]; };
    for (ptrdiff_t bar = str_find(line, " |", p + 1); bar >= 0;
         bar = str_find(line, " |", bar + 1)) {
        ptrdiff_t i = bar + 2;
        if (i >= n || at(i) != ' ') continue;
        while (i < n && at(i) == ' ') ++i;
        if (i >= n || at(i) < '1' || at(i) > '9') continue;
        while (i < n && at(i) >= '0' && at(i) <= '9') ++i;
        if (i < n && at(i) == ' ') return true;
    }
    return false;
}

// Like upstream refresh --diffstat's awk script: diffstat file lines are
// held. A summary line drops them and itself for the new diffstat, with
// each line prefixed by "#" when the summary line starts with one. Any
// other line puts the held lines back. With no summary line, the held
// lines stay, and "---", the new diffstat and a line holding just the last
// line's "#" prefix (if any) are added at the end, so an empty header
// becomes "---", the diffstat and a blank line. Every other byte, CRs and
// blank lines included, is kept.
std::string replace_diffstat(std::string_view header, std::string_view diffstat) {
    std::string result;
    std::string held;
    std::string_view prefix;
    bool replaced = false;
    auto put_diffstat = [&] {
        for (std::string_view s = diffstat; !s.empty();) {
            ptrdiff_t nl = str_find(s, '\n');
            ptrdiff_t len = nl < 0 ? std::ssize(s) : nl + 1;
            result += prefix;
            result += s.substr(0, checked_cast<size_t>(len));
            s.remove_prefix(checked_cast<size_t>(len));
        }
    };
    while (!header.empty()) {
        std::string_view line = take_line(header);
        prefix = line.starts_with('#') ? "#" : "";
        if (is_diffstat_file_line(line)) {
            held += line;
            held += '\n';
            continue;
        }
        if (is_diffstat_summary(line)) {
            put_diffstat();
            replaced = true;
            held.clear();
            continue;
        }
        result += held;
        result += line;
        result += '\n';
        held.clear();
    }
    result += held;
    if (!replaced) {
        result += "---\n";
        put_diffstat();
        result += prefix;
        result += '\n';
    }
    return result;
}


std::vector<std::string> split_on_whitespace(std::string_view s) {
    std::vector<std::string> tokens;
    ptrdiff_t i = 0;
    while (i < std::ssize(s)) {
        while (i < std::ssize(s) && (s[checked_cast<size_t>(i)] == ' ' || s[checked_cast<size_t>(i)] == '\t'))
            ++i;
        if (i >= std::ssize(s)) break;
        ptrdiff_t start = i;
        while (i < std::ssize(s) && s[checked_cast<size_t>(i)] != ' ' && s[checked_cast<size_t>(i)] != '\t')
            ++i;
        tokens.emplace_back(s.substr(checked_cast<size_t>(start), checked_cast<size_t>(i - start)));
    }
    return tokens;
}

static bool is_varname_start(char c) {
    return (c >= 'A' && c <= 'Z') || (c >= 'a' && c <= 'z') || c == '_';
}

static bool is_varname_char(char c) {
    return is_varname_start(c) || (c >= '0' && c <= '9');
}

static std::string expand_var(std::string_view s, ptrdiff_t &i) {
    // i points just past '$'
    std::string name;
    if (i < std::ssize(s) && s[checked_cast<size_t>(i)] == '{') {
        ++i; // skip '{'
        while (i < std::ssize(s) && s[checked_cast<size_t>(i)] != '}') {
            name += s[checked_cast<size_t>(i++)];
        }
        if (i < std::ssize(s)) ++i; // skip '}'
    } else {
        while (i < std::ssize(s) && is_varname_char(s[checked_cast<size_t>(i)])) {
            name += s[checked_cast<size_t>(i++)];
        }
    }
    if (name.empty()) return "$";
    return get_env(name);
}

std::vector<std::string> shell_split(std::string_view s) {
    std::vector<std::string> tokens;
    ptrdiff_t i = 0;
    while (i < std::ssize(s)) {
        // Skip whitespace between tokens
        while (i < std::ssize(s) && (s[checked_cast<size_t>(i)] == ' ' || s[checked_cast<size_t>(i)] == '\t'))
            ++i;
        if (i >= std::ssize(s)) break;

        std::string tok;
        // Accumulate segments until unquoted whitespace
        while (i < std::ssize(s) && s[checked_cast<size_t>(i)] != ' ' && s[checked_cast<size_t>(i)] != '\t') {
            if (s[checked_cast<size_t>(i)] == '\'') {
                // Single-quoted: literal, no escapes, no variable expansion
                ++i;
                while (i < std::ssize(s) && s[checked_cast<size_t>(i)] != '\'')
                    tok += s[checked_cast<size_t>(i++)];
                if (i < std::ssize(s)) ++i; // skip closing '
            } else if (s[checked_cast<size_t>(i)] == '"') {
                // Double-quoted: backslash escapes and variable expansion
                ++i;
                while (i < std::ssize(s) && s[checked_cast<size_t>(i)] != '"') {
                    if (s[checked_cast<size_t>(i)] == '\\' && i + 1 < std::ssize(s)) {
                        char next = s[checked_cast<size_t>(i + 1)];
                        if (next == '"' || next == '\\' || next == '$') {
                            tok += next;
                            i += 2;
                            continue;
                        }
                    }
                    if (s[checked_cast<size_t>(i)] == '$') {
                        ++i;
                        tok += expand_var(s, i);
                        continue;
                    }
                    tok += s[checked_cast<size_t>(i++)];
                }
                if (i < std::ssize(s)) ++i; // skip closing "
            } else if (s[checked_cast<size_t>(i)] == '$') {
                // Unquoted variable expansion
                ++i;
                tok += expand_var(s, i);
            } else if (s[checked_cast<size_t>(i)] == '\\' && i + 1 < std::ssize(s)) {
                // Unquoted backslash escape
                tok += s[checked_cast<size_t>(i + 1)];
                i += 2;
            } else {
                tok += s[checked_cast<size_t>(i++)];
            }
        }
        if (!tok.empty()) {
            tokens.push_back(std::move(tok));
        }
    }
    return tokens;
}

static std::vector<std::string> parse_series(std::string_view content,
                                             std::map<std::string, int> *strip_levels,
                                             std::set<std::string> *reversed) {
    std::vector<std::string> patches;
    auto lines = split_lines(content);
    for (auto &line : lines) {
        std::string trimmed = trim(line);
        if (trimmed.empty()) continue;
        if (trimmed[0] == '#') continue;
        // Strip inline comments
        auto hash = str_find(std::string_view(trimmed), " #");
        if (hash >= 0) {
            trimmed = trim(std::string_view(trimmed).substr(0, checked_cast<size_t>(hash)));
        }
        // Split into tokens
        auto tokens = split_on_whitespace(trimmed);
        if (tokens.empty()) continue;
        std::string name = tokens[0];
        // Parse options (e.g., "-p0", "-p 0", "-R")
        int strip = 1;
        bool is_reversed = false;
        for (ptrdiff_t i = 1; i < std::ssize(tokens); ++i) {
            if (tokens[checked_cast<size_t>(i)] == "-p" && i + 1 < std::ssize(tokens)) {
                strip = checked_cast<int>(parse_int(tokens[checked_cast<size_t>(i + 1)]));
                ++i;
            } else if (tokens[checked_cast<size_t>(i)].starts_with("-p") && std::ssize(tokens[checked_cast<size_t>(i)]) > 2) {
                strip = checked_cast<int>(parse_int(tokens[checked_cast<size_t>(i)].substr(2)));
            } else if (tokens[checked_cast<size_t>(i)] == "-R") {
                is_reversed = true;
            }
        }
        if (strip_levels && strip != 1) {
            (*strip_levels)[name] = strip;
        }
        if (reversed && is_reversed) {
            reversed->insert(name);
        }
        patches.push_back(std::move(name));
    }
    return patches;
}

std::vector<std::string> read_series(std::string_view path,
                                     std::map<std::string, int> *strip_levels,
                                     std::set<std::string> *reversed) {
    return parse_series(read_file(path), strip_levels, reversed);
}

// Split series file content into lines, each keeping its line ending, so
// that edits reproduce untouched lines byte for byte.
static std::vector<std::string_view> series_lines(std::string_view content) {
    std::vector<std::string_view> lines;
    while (!content.empty()) {
        auto nl = str_find(content, '\n');
        auto len = nl < 0 ? std::ssize(content) : nl + 1;
        lines.push_back(content.substr(0, checked_cast<size_t>(len)));
        content.remove_prefix(checked_cast<size_t>(len));
    }
    return lines;
}

// The patch a series line names, as read_series sees it: the first word of
// the trimmed line, unless the line is blank or a comment, in which case it
// is empty.
static std::string_view series_line_patch(std::string_view line) {
    auto is_space = [](char c) {
        return c == ' ' || c == '\t' || c == '\r' || c == '\n';
    };
    while (!line.empty() && is_space(line.front())) line.remove_prefix(1);
    while (!line.empty() && is_space(line.back())) line.remove_suffix(1);
    ptrdiff_t len = 0;
    while (len < std::ssize(line) && line[checked_cast<size_t>(len)] != ' ' &&
           line[checked_cast<size_t>(len)] != '\t') {
        ++len;
    }
    std::string_view name = line.substr(0, checked_cast<size_t>(len));
    return name.starts_with('#') ? std::string_view{} : name;
}

// Write an edited series file, then reload the in-memory series from it.
static bool store_series(QuiltState &q, std::string_view path,
                         std::string_view content) {
    if (!write_file(path, content)) return false;
    q.series_file_exists = true;
    q.patch_strip_level.clear();
    q.patch_reversed.clear();
    q.series = parse_series(content, &q.patch_strip_level, &q.patch_reversed);
    return true;
}

bool insert_in_series(QuiltState &q, std::string_view patch,
                      std::string_view opts, std::string_view before) {
    std::string path = path_join(q.work_dir, q.series_file);
    std::string content = read_file(path);
    auto lines = series_lines(content);

    // The new line follows the file's line endings
    std::string_view eol = !lines.empty() && lines[0].ends_with("\r\n") ? "\r\n" : "\n";
    std::string entry(patch);
    if (!opts.empty()) {
        entry += ' ';
        entry += opts;
    }
    entry += eol;

    std::string result;
    bool inserted = false;
    for (auto line : lines) {
        if (!inserted && !before.empty() && series_line_patch(line) == before) {
            result += entry;
            inserted = true;
        }
        result += line;
    }
    if (!inserted) {
        if (!result.empty() && !result.ends_with('\n')) result += eol;
        result += entry;
    }
    return store_series(q, path, result);
}

bool remove_from_series(QuiltState &q, std::string_view patch) {
    std::string path = path_join(q.work_dir, q.series_file);
    std::string content = read_file(path);
    std::string result;
    for (auto line : series_lines(content)) {
        auto name = series_line_patch(line);
        if (name.empty() || name != patch) result += line;
    }
    return store_series(q, path, result);
}

bool rename_in_series(QuiltState &q, std::string_view from, std::string_view to) {
    std::string path = path_join(q.work_dir, q.series_file);
    std::string content = read_file(path);
    std::string result;
    for (auto line : series_lines(content)) {
        auto name = series_line_patch(line);
        if (name.empty() || name != from) {
            result += line;
            continue;
        }
        // Keep the indentation, options, and comment around the name
        auto at = name.data() - line.data();
        result += line.substr(0, checked_cast<size_t>(at));
        result += to;
        result += line.substr(checked_cast<size_t>(at + std::ssize(name)));
    }
    return store_series(q, path, result);
}

std::string series_patch_args(const QuiltState &q, std::string_view patch) {
    std::string content = read_file(path_join(q.work_dir, q.series_file));
    for (auto line : series_lines(content)) {
        auto name = series_line_patch(line);
        if (name.empty() || name != patch) continue;
        auto end = name.data() - line.data() + std::ssize(name);
        std::string args;
        for (const auto &tok : split_on_whitespace(trim(line.substr(checked_cast<size_t>(end))))) {
            if (tok.starts_with('#')) break;
            if (!args.empty()) args += ' ';
            args += tok;
        }
        return args;
    }
    return {};
}

bool set_series_strip_level(QuiltState &q, std::string_view patch,
                            int strip_level) {
    std::string path = path_join(q.work_dir, q.series_file);
    std::string content = read_file(path);
    std::string result;
    bool changed = false;
    for (auto line : series_lines(content)) {
        auto name = series_line_patch(line);
        if (name.empty() || name != patch) {
            result += line;
            continue;
        }

        // Split off the line ending and inline comment as read_series does
        std::string_view body = line;
        if (body.ends_with('\n')) body.remove_suffix(1);
        if (body.ends_with('\r')) body.remove_suffix(1);
        std::string_view eol = line.substr(body.size());
        std::string_view comment;
        auto hash = str_find(body, " #");
        if (hash >= 0) {
            comment = body.substr(checked_cast<size_t>(hash + 1));
            body = body.substr(0, checked_cast<size_t>(hash));
        }
        auto tokens = split_on_whitespace(body);

        // Drop -R and any -p option ("-pN" or "-p N"), then put the new
        // level where the old one was, or right after the name.
        std::vector<std::string> opts;
        ptrdiff_t level_at = -1;
        for (ptrdiff_t i = 1; i < std::ssize(tokens); ++i) {
            const auto &tok = tokens[checked_cast<size_t>(i)];
            if (tok == "-R") continue;
            if (tok.starts_with("-p")) {
                if (tok == "-p" && i + 1 < std::ssize(tokens)) ++i;
                if (level_at < 0) level_at = std::ssize(opts);
                continue;
            }
            opts.push_back(tok);
        }
        if (strip_level != 1) {
            opts.insert(opts.begin() + std::max(level_at, ptrdiff_t{0}),
                        "-p" + std::to_string(strip_level));
        }
        if (std::equal(opts.begin(), opts.end(), tokens.begin() + 1, tokens.end())) {
            result += line;
            continue;
        }

        result += tokens[0];
        for (const auto &opt : opts) {
            result += ' ';
            result += opt;
        }
        if (!comment.empty()) {
            result += ' ';
            result += comment;
        }
        result += eol;
        changed = true;
    }
    return !changed || store_series(q, path, result);
}

std::vector<std::string> read_applied(std::string_view path) {
    std::vector<std::string> patches;
    std::string content = read_file(path);
    if (content.empty()) return patches;
    auto lines = split_lines(content);
    for (auto &line : lines) {
        std::string trimmed = trim(line);
        if (!trimmed.empty()) {
            patches.push_back(std::move(trimmed));
        }
    }
    return patches;
}

bool write_applied(std::string_view path, std::span<const std::string> patches) {
    std::string content;
    for (const auto &p : patches) {
        content += p;
        content += '\n';
    }
    return write_file(path, content);
}

bool ensure_pc_dir(QuiltState &q) {
    std::string pc = path_join(q.work_dir, q.pc_dir);
    if (!is_directory(pc)) {
        if (!make_dirs(pc)) {
            err_line("Failed to create " + pc);
            return false;
        }
    }
    // Write .version
    std::string version_path = path_join(pc, ".version");
    if (!file_exists(version_path)) {
        if (!write_file(version_path, "2\n")) {
            err_line("Failed to write " + version_path);
            return false;
        }
    }
    // Write .quilt_patches
    std::string qp_path = path_join(pc, ".quilt_patches");
    if (!file_exists(qp_path)) {
        if (!write_file(qp_path, q.patches_dir + "\n")) {
            err_line("Failed to write " + qp_path);
            return false;
        }
    }
    // Write .quilt_series
    std::string qs_path = path_join(pc, ".quilt_series");
    if (!file_exists(qs_path)) {
        std::string series_name = get_env("QUILT_SERIES");
        if (series_name.empty()) series_name = "series";
        if (!write_file(qs_path, series_name + "\n")) {
            err_line("Failed to write " + qs_path);
            return false;
        }
    }
    return true;
}

// Parse a simplified subset of bash KEY=VALUE assignments from a quiltrc file.
// Supports: KEY=value, KEY="value", KEY='value', export KEY=value
// Skips comments (#), blank lines, and lines that aren't assignments.
static std::map<std::string, std::string> parse_quiltrc(std::string_view content) {
    std::map<std::string, std::string> result;
    auto lines = split_lines(content);
    for (auto &line : lines) {
        std::string_view sv = line;
        // Strip leading whitespace
        while (!sv.empty() && (sv.front() == ' ' || sv.front() == '\t'))
            sv.remove_prefix(1);
        // Skip blank lines and comments
        if (sv.empty() || sv.front() == '#') continue;
        // Strip optional "export " prefix
        if (std::ssize(sv) > 7 && sv.substr(0, 7) == "export ") {
            sv.remove_prefix(7);
            while (!sv.empty() && (sv.front() == ' ' || sv.front() == '\t'))
                sv.remove_prefix(1);
        }
        // Find '=' for KEY=VALUE
        auto eq = str_find(sv, '=');
        if (eq <= 0) continue;
        // Validate key: must be alphanumeric/underscore
        std::string_view key = sv.substr(0, checked_cast<size_t>(eq));
        bool valid_key = true;
        for (char c : key) {
            if (!((c >= 'A' && c <= 'Z') || (c >= 'a' && c <= 'z') ||
                  (c >= '0' && c <= '9') || c == '_')) {
                valid_key = false;
                break;
            }
        }
        if (!valid_key) continue;
        // Parse value
        std::string_view rest = sv.substr(checked_cast<size_t>(eq + 1));
        std::string value;
        if (!rest.empty() && rest.front() == '"') {
            // Double-quoted: handle \" and \\ escapes
            rest.remove_prefix(1);
            while (!rest.empty() && rest.front() != '"') {
                if (rest.front() == '\\' && std::ssize(rest) > 1) {
                    char next = rest[1];
                    if (next == '"' || next == '\\') {
                        value += next;
                        rest.remove_prefix(2);
                        continue;
                    }
                }
                value += rest.front();
                rest.remove_prefix(1);
            }
        } else if (!rest.empty() && rest.front() == '\'') {
            // Single-quoted: literal, no escapes
            rest.remove_prefix(1);
            while (!rest.empty() && rest.front() != '\'') {
                value += rest.front();
                rest.remove_prefix(1);
            }
        } else {
            // Unquoted: ends at whitespace, line ending, or #
            while (!rest.empty() && rest.front() != ' ' && rest.front() != '\t' &&
                   rest.front() != '\r' && rest.front() != '\n' &&
                   rest.front() != '#') {
                value += rest.front();
                rest.remove_prefix(1);
            }
        }
        result[std::string(key)] = value;
    }
    return result;
}

// Load and parse the quiltrc file. If quiltrc_path is empty, use default
// search order (~/.quiltrc, /etc/quilt.quiltrc). If "-", skip loading.
static std::map<std::string, std::string> load_quiltrc(std::string_view quiltrc_path) {
    if (quiltrc_path == "-") return {};

    if (!quiltrc_path.empty()) {
        std::string content = read_file(quiltrc_path);
        if (!content.empty()) return parse_quiltrc(content);
        return {};
    }

    // Default search order
    std::string home = get_home_dir();
    if (!home.empty()) {
        std::string user_rc = path_join(home, ".quiltrc");
        std::string content = read_file(user_rc);
        if (!content.empty()) return parse_quiltrc(content);
    }

    std::string sys_rc = get_system_quiltrc();
    std::string content = read_file(sys_rc);
    if (!content.empty()) return parse_quiltrc(content);

    return {};
}

QuiltState load_state() {
    QuiltState q;
    q.patches_dir = "patches";
    q.pc_dir = ".pc";

    // Read environment variable overrides
    std::string env_pc = get_env("QUILT_PC");
    if (!env_pc.empty()) q.pc_dir = env_pc;
    std::string env_patches = get_env("QUILT_PATCHES");
    if (!env_patches.empty()) q.patches_dir = env_patches;

    // Read QUILT_SERIES override for series filename
    std::string env_series = get_env("QUILT_SERIES");

    // Upward directory scan: find project root containing .pc/ or patches/
    // Only use relative paths for scanning; absolute paths are used as-is.
    std::string cwd = get_cwd();
    std::string scan = cwd;
    bool patches_dir_is_abs = is_absolute_path(q.patches_dir);
    while (true) {
        if (is_directory(path_join(scan, q.pc_dir)) ||
            (!patches_dir_is_abs && is_directory(path_join(scan, q.patches_dir)))) {
            break;
        }
        std::string parent = dirname(scan);
        if (parent == scan) {
            // Reached filesystem root without finding anything; use cwd
            scan = cwd;
            break;
        }
        scan = parent;
    }
    q.work_dir = scan;
    if (q.work_dir != cwd) {
        // Compute subdirectory: strip work_dir prefix + '/' from cwd
        q.subdir = cwd.substr(q.work_dir.size() + 1);
        set_cwd(q.work_dir);
    }

    // Check if .pc/ exists and read overrides
    std::string pc_abs = path_join(q.work_dir, q.pc_dir);
    std::string series_name_override;
    if (is_directory(pc_abs)) {
        // Read .quilt_patches override
        std::string qp = trim(read_file(path_join(pc_abs, ".quilt_patches")));
        if (!qp.empty()) {
            q.patches_dir = qp;
        }
        // Read .quilt_series override
        std::string qs = trim(read_file(path_join(pc_abs, ".quilt_series")));
        if (!qs.empty()) {
            series_name_override = qs;
        }
    }

    // Series file search order (when not overridden by .quilt_series)
    if (q.series_file.empty()) {
        std::string series_name = !series_name_override.empty()
            ? series_name_override
            : (env_series.empty() ? "series" : env_series);
        std::string s1 = path_join(q.work_dir, series_name);
        std::string s2 = path_join(q.work_dir, q.patches_dir, series_name);
        std::string s3 = path_join(q.work_dir, q.pc_dir, series_name);
        if (file_exists(s3)) {
            q.series_file = path_join(q.pc_dir, series_name);
        } else if (file_exists(s1)) {
            q.series_file = series_name;
        } else if (file_exists(s2)) {
            q.series_file = path_join(q.patches_dir, series_name);
        } else {
            q.series_file = path_join(q.patches_dir, series_name);
        }
    }

    // Read series file
    std::string series_abs = path_join(q.work_dir, q.series_file);
    q.series_file_exists = file_exists(series_abs);
    q.series = read_series(series_abs, &q.patch_strip_level, &q.patch_reversed);

    // Read applied-patches file
    std::string applied_abs = path_join(q.work_dir, q.pc_dir, "applied-patches");
    q.applied = read_applied(applied_abs);

    return q;
}

std::string pc_patch_dir(const QuiltState &q, std::string_view patch) {
    return path_join(q.work_dir, q.pc_dir, patch);
}

std::vector<std::string> files_in_patch(const QuiltState &q, std::string_view patch) {
    std::string dir = pc_patch_dir(q, patch);
    if (!is_directory(dir)) return {};
    auto all = find_files_recursive(dir);
    std::vector<std::string> result;
    for (auto &f : all) {
        // Skip quilt metadata, which lives only at the top level of
        // .pc/<patch>/. Other dotfiles (.gitignore, sub/.hidden) are
        // tracked files.
        if (f == ".timestamp" || f == ".needs_refresh") continue;
        result.push_back(std::move(f));
    }
    return result;
}

bool backup_file(QuiltState &q, std::string_view patch, std::string_view file) {
    std::string src = path_join(q.work_dir, file);
    std::string dst = path_join(pc_patch_dir(q, patch), file);

    // Ensure destination directory exists
    std::string dst_dir = dirname(dst);
    if (!is_directory(dst_dir)) {
        if (!make_dirs(dst_dir)) {
            err_line("Failed to create directory: " + dst_dir);
            return false;
        }
    }

    if (file_exists(src)) {
        return copy_file(src, dst);
    } else {
        // File doesn't exist yet; create an empty placeholder
        return write_file(dst, "");
    }
}

bool restore_file(QuiltState &q, std::string_view patch, std::string_view file) {
    std::string backup = path_join(pc_patch_dir(q, patch), file);
    std::string target = path_join(q.work_dir, file);

    if (!file_exists(backup)) {
        err("No backup for "); err_line(file);
        return false;
    }

    std::string content = read_file(backup);
    if (content.empty()) {
        // Zero-length backup = file didn't exist before the patch — remove target
        if (file_exists(target) && !delete_file(target)) {
            err_line("Failed to remove " + target);
            return false;
        }
        return true;
    }

    // Ensure target directory exists
    std::string target_dir = dirname(target);
    if (!is_directory(target_dir)) {
        if (!make_dirs(target_dir)) {
            err_line("Failed to create directory: " + target_dir);
            return false;
        }
    }

    return write_file(target, content);
}

std::string to_cstr(std::string_view s) {
    return std::string(s);
}

static Command commands[] = {
    {"new", cmd_new,
     "Usage: quilt new [-p n] {patchname}",
     "Usage: quilt new [-p n] patchname\n"
     "\n"
     "Create a new empty patch and insert it after the topmost applied\n"
     "patch in the series. The new patch becomes the top of the stack\n"
     "immediately, but no patch file is written until quilt refresh.\n"
     "\n"
     "Options:\n"
     "  -p n        Set the strip level for the patch (default: 1).\n",
     "Create a new empty patch"},

    {"add", cmd_add,
     "Usage: quilt add [-P patch] {file} ...",
     "Usage: quilt add [-P patch] file ...\n"
     "\n"
     "Register files with the topmost patch by backing up their current\n"
     "contents. Files must be added before modification so that quilt\n"
     "can capture the pre-change state. Use quilt edit to add and open\n"
     "files in a single step.\n"
     "\n"
     "Options:\n"
     "  -P patch    Add files to the named patch instead of the top.\n",
     "Add files to the topmost patch"},

    {"push", cmd_push,
     "Usage: quilt push [-afqvm] [--fuzz=N] [--merge[=merge|diff3]] "
     "[--leave-rejects] [--color[=always|auto|never]] [--refresh] [num|patch]",
     "Usage: quilt push [-afqv] [--fuzz=N] [-m] [--merge[=merge|diff3]]\n"
     "       [--leave-rejects] [--refresh] [num|patch]\n"
     "\n"
     "Apply the next unapplied patch from the series. Without arguments,\n"
     "applies one patch. With a patch name, applies patches up to and\n"
     "including it. With a number, applies that many patches.\n"
     "\n"
     "Options:\n"
     "  -a                      Apply all unapplied patches.\n"
     "  -f                      Force apply even when the patch has rejects.\n"
     "  -q                      Quiet; print only error messages.\n"
     "  -v                      Verbose; pass --verbose to patch.\n"
     "  --fuzz=N                Set the maximum fuzz factor for patch.\n"
     "  -m, --merge[=merge|diff3]\n"
     "                          Merge using patch's merge mode.\n"
     "  --leave-rejects         Leave .rej files in the working tree.\n"
     "  --refresh               Refresh each patch after applying.\n",
     "Apply patches to the source tree"},

    {"pop", cmd_pop,
     "Usage: quilt pop [-afRqv] [--refresh] [num|patch]",
     "Usage: quilt pop [-afRqv] [--refresh] [num|patch]\n"
     "\n"
     "Remove the topmost applied patch by restoring files from backup.\n"
     "Without arguments, removes one patch. With a patch name, removes\n"
     "patches until the named patch is on top. With a number, removes\n"
     "that many patches.\n"
     "\n"
     "Options:\n"
     "  -a          Remove all applied patches.\n"
     "  -f          Force removal even if the patch needs refresh.\n"
     "  -R          Always verify that the patch removes cleanly.\n"
     "  -q          Quiet; print only error messages.\n"
     "  -v          Verbose; print file-level restore messages.\n"
     "  --refresh   Automatically refresh every patch before it gets unapplied.\n",
     "Remove applied patches from the stack"},

    {"refresh", cmd_refresh,
     "Usage: quilt refresh [-p n|-p ab] [-u|-U num|-c|-C num] [-z[new_name]] "
     "[-f] [--no-timestamps] [--no-index] [--diffstat] [--sort] [--backup] "
     "[--strip-trailing-whitespace] [patch]",
     "Usage: quilt refresh [-p n] [-u | -U num | -c | -C num] [-z [new_name]]\n"
     "       [-f] [--no-timestamps] [--no-index] [--diffstat] [--sort]\n"
     "       [--strip-trailing-whitespace] [--backup]\n"
     "       [--diff-algorithm={myers|minimal|patience|histogram}] [patch]\n"
     "\n"
     "Regenerate the topmost or named patch by diffing backup copies in\n"
     ".pc/ against the current working tree. This is what actually writes\n"
     "the patch file; changes are not recorded until you refresh.\n"
     "\n"
     "Options:\n"
     "  -p n              Set the path label style (0, 1, or ab).\n"
     "  -u                Create a unified diff (default).\n"
     "  -U num            Create a unified diff with num lines of context.\n"
     "  -c                Create a context diff.\n"
     "  -C num            Create a context diff with num lines of context.\n"
     "  -z [new_name]     Create a new patch (fork) containing the changes;\n"
     "                    the current patch is left as-is.\n"
     "  -f                Refresh even when files are shadowed by patches\n"
     "                    applied above.\n"
     "  --no-timestamps   Omit timestamps from diff headers.\n"
     "  --no-index        Omit Index: lines from the patch.\n"
     "  --diffstat        Add a diffstat section to the patch header.\n"
     "  --sort            Sort files alphabetically in the patch.\n"
     "  --strip-trailing-whitespace\n"
     "                    Strip trailing whitespace from each line.\n"
     "  --backup          Save the old patch file as name~ before updating.\n"
     "  --diff-algorithm=name\n"
     "                    Select the diff algorithm: myers (default),\n"
     "                    minimal, patience, or histogram.\n"
     "\n"
     "The QUILT_DIFF_ALGORITHM environment variable sets the default\n"
     "algorithm (overridden by --diff-algorithm on the command line).\n",
     "Regenerate a patch from working tree changes"},

    {"diff", cmd_diff,
     "Usage: quilt diff [-p n|-p ab] [-u|-U num|-c|-C num] "
     "[--combine patch|-z] [-R] [-P patch] [--snapshot] [--diff=utility] "
     "[--no-timestamps] [--no-index] [--sort] [--color[=always|auto|never]] "
     "[file ...]",
     "Usage: quilt diff [-p n] [-u | -U num | -c | -C num]\n"
     "       [--combine patch] [-P patch] [-z] [-R] [--snapshot]\n"
     "       [--diff=utility] [--no-timestamps] [--no-index] [--sort]\n"
     "       [--diff-algorithm={myers|minimal|patience|histogram}] [file ...]\n"
     "\n"
     "Show the diff that quilt refresh would produce for the topmost or\n"
     "named patch. Without -z, shows the full patch content (backup vs.\n"
     "working tree). With -z, shows only uncommitted changes since the\n"
     "last refresh.\n"
     "\n"
     "Options:\n"
     "  -p n              Set the path label style (0, 1, or ab).\n"
     "  -u                Create a unified diff (default).\n"
     "  -U num            Create a unified diff with num lines of context.\n"
     "  -c                Create a context diff.\n"
     "  -C num            Create a context diff with num lines of context.\n"
     "  --combine patch   Create a combined diff for all patches between\n"
     "                    this patch and the topmost or specified patch.\n"
     "                    A patch name of '-' is the first applied patch.\n"
     "  -P patch          Show the diff for the named patch.\n"
     "  -z                Show only changes since the last refresh.\n"
     "  -R                Produce a reverse diff.\n"
     "  --snapshot        Diff against a previously saved snapshot.\n"
     "  --diff=utility    Use the specified diff utility instead of the\n"
     "                    built-in diff engine.\n"
     "  --no-timestamps   Omit timestamps from diff headers.\n"
     "  --no-index        Omit Index: lines from the output.\n"
     "  --sort            Sort files alphabetically in the output.\n"
     "  --diff-algorithm=name\n"
     "                    Select the diff algorithm: myers (default),\n"
     "                    minimal, patience, or histogram.\n"
     "\n"
     "The QUILT_DIFF_ALGORITHM environment variable sets the default\n"
     "algorithm (overridden by --diff-algorithm on the command line).\n",
     "Show the diff of the topmost or a specified patch"},

    {"series", cmd_series,
     "Usage: quilt series [--color[=always|auto|never]] [-v]",
     "Usage: quilt series [-v]\n"
     "\n"
     "List all patches in the series file, both applied and unapplied.\n"
     "\n"
     "Options:\n"
     "  -v          Mark applied patches with + and the top with =.\n",
     "List all patches in the series"},

    {"applied", cmd_applied,
     "Usage: quilt applied [patch]",
     "Usage: quilt applied [patch]\n"
     "\n"
     "List the currently applied patches in stack order. With a patch\n"
     "name, lists all applied patches up to and including it.\n",
     "List applied patches"},

    {"unapplied", cmd_unapplied,
     "Usage: quilt unapplied [patch]",
     "Usage: quilt unapplied [patch]\n"
     "\n"
     "List the patches that have not been applied yet. With a patch\n"
     "name, lists all patches after the named one in the series.\n",
     "List patches not yet applied"},

    {"top", cmd_top,
     "Usage: quilt top",
     "Usage: quilt top\n"
     "\n"
     "Print the name of the topmost applied patch.\n",
     "Show the topmost applied patch"},

    {"next", cmd_next,
     "Usage: quilt next [patch]",
     "Usage: quilt next [patch]\n"
     "\n"
     "Print the patch after the topmost applied patch, or after the\n"
     "named patch in the series.\n",
     "Show the next patch after the top or a given patch"},

    {"previous", cmd_previous,
     "Usage: quilt previous [patch]",
     "Usage: quilt previous [patch]\n"
     "\n"
     "Print the patch before the topmost applied patch, or before the\n"
     "named patch in the series.\n",
     "Show the patch before the top or a given patch"},

    {"delete", cmd_delete,
     "Usage: quilt delete [-r] [--backup] [patch|-n]",
     "Usage: quilt delete [-r] [--backup] [patch|-n]\n"
     "\n"
     "Remove the topmost applied patch or a named unapplied patch from\n"
     "the series. The patch file is kept unless -r is given.\n"
     "\n"
     "Options:\n"
     "  -r          Remove the patch file as well.\n"
     "  --backup    Rename the patch file to name~ instead of deleting.\n"
     "  -n          Delete the next unapplied patch instead of the top.\n",
     "Remove a patch from the series"},

    {"rename", cmd_rename,
     "Usage: quilt rename [-P patch] new_name",
     "Usage: quilt rename [-P patch] new_name\n"
     "\n"
     "Rename the topmost or named patch. Updates the series file and\n"
     "renames the patch file in the patches directory.\n"
     "\n"
     "Options:\n"
     "  -P patch    Rename the named patch instead of the top.\n",
     "Rename a patch"},

    {"import", cmd_import,
     "Usage: quilt import [-p num] [-R] [-P patch] [-f] [-d "
     "{o|a|n}] patchfile ...",
     "Usage: quilt import [-p n] [-R] [-P name] [-f] [-d {o|a|n}] file ...\n"
     "\n"
     "Copy an external patch file into the patches directory and add it\n"
     "to the series after the topmost applied patch. The patch is not\n"
     "applied; use quilt push afterward.\n"
     "\n"
     "Options:\n"
     "  -p n        Set the strip level for the imported patch.\n"
     "  -R          Apply patch in reverse.\n"
     "  -P name     Use this name instead of the original filename.\n"
     "  -f          Overwrite if a patch with the same name exists.\n"
     "  -d {o|a|n}  When overwriting: keep old, append all, or use\n"
     "              new header.\n",
     "Import an external patch into the series"},

    {"header", cmd_header,
     "Usage: quilt header [-a|-r|-e] [--backup] [--strip-diffstat] "
     "[--strip-trailing-whitespace] [patch]",
     "Usage: quilt header [-a|-r|-e] [--backup] [--dep3]\n"
     "       [--strip-diffstat] [--strip-trailing-whitespace] [patch]\n"
     "\n"
     "Print the header (description) of the topmost or named patch.\n"
     "The header is all text in the patch file before the first diff.\n"
     "\n"
     "Options:\n"
     "  -a                Append text from standard input to the header.\n"
     "  -r                Replace the header with text from standard input.\n"
     "  -e                Open the header in $EDITOR.\n"
     "  --backup          Save the old patch file as name~ before modifying.\n"
     "  --dep3            Insert DEP-3 template when editing empty headers.\n"
     "  --strip-diffstat  Remove the diffstat section from the header.\n"
     "  --strip-trailing-whitespace\n"
     "                    Strip trailing whitespace from each header line.\n",
     "Print or modify a patch header"},

    {"files", cmd_files,
     "Usage: quilt files [-v] [-a] [-l] [--combine patch] [patch]",
     "Usage: quilt files [-v] [-a] [-l] [--combine patch] [patch]\n"
     "\n"
     "List the files that the topmost or named patch modifies.\n"
     "\n"
     "Options:\n"
     "  -v              Show the patch name alongside each filename.\n"
     "  -a              List files for all applied patches, not just one.\n"
     "  -l              Add patch name to output lines.\n"
     "  --combine patch List files for a range of patches.\n",
     "List files modified by a patch"},

    {"patches", cmd_patches,
     "Usage: quilt patches [-v] [--color[=always|auto|never]] {file} "
     "[files...]",
     "Usage: quilt patches [-v] file ...\n"
     "\n"
     "List the patches that modify the given file or files. Searches\n"
     "both applied patches (via .pc/ metadata) and unapplied patches\n"
     "(by parsing patch files).\n"
     "\n"
     "Options:\n"
     "  -v          Mark applied patches in the output.\n",
     "List patches that modify a given file"},

    {"edit", cmd_edit,
     "Usage: quilt edit file ...",
     "Usage: quilt edit file ...\n"
     "\n"
     "Add files to the topmost patch and open them in $EDITOR. This is\n"
     "a shortcut for quilt add followed by $EDITOR, and is the safest\n"
     "way to modify tracked files.\n",
     "Add files to the topmost patch and open an editor"},

    {"revert", cmd_revert,
     "Usage: quilt revert [-P patch] {file} ...",
     "Usage: quilt revert [-P patch] file ...\n"
     "\n"
     "Discard uncommitted changes to files by restoring them from the\n"
     "backup copies in .pc/. Only reverts changes not yet captured by\n"
     "quilt refresh.\n"
     "\n"
     "Options:\n"
     "  -P patch    Revert files in the named patch instead of the top.\n",
     "Discard working tree changes to files in a patch"},

    {"remove", cmd_remove,
     "Usage: quilt remove [-P patch] {file} ...",
     "Usage: quilt remove [-P patch] file ...\n"
     "\n"
     "Remove files from the topmost or named patch and restore them\n"
     "from backup. The opposite of quilt add.\n"
     "\n"
     "Options:\n"
     "  -P patch    Remove files from the named patch instead of the top.\n",
     "Remove files from the topmost patch"},

    {"fold", cmd_fold,
     "Usage: quilt fold [-R] [-q] [-f] [-p strip-level]",
     "Usage: quilt fold [-R] [-q] [-f] [-p n]\n"
     "\n"
     "Fold a diff read from standard input into the topmost patch.\n"
     "Files touched by the incoming diff are automatically added to\n"
     "the patch. Run quilt refresh afterward to update the patch file.\n"
     "\n"
     "Options:\n"
     "  -R          Apply the diff in reverse.\n"
     "  -q          Quiet; print only error messages.\n"
     "  -f          Force apply even when the diff has rejects.\n"
     "  -p n        Set the strip level for the incoming diff.\n",
     "Fold a diff from stdin into the topmost patch"},

    {"fork", cmd_fork,
     "Usage: quilt fork [new_name]",
     "Usage: quilt fork [new_name]\n"
     "\n"
     "Copy the topmost patch to a new name. The series is updated to\n"
     "reference the copy; the original file is kept but removed from\n"
     "the series. If no name is given, -2 goes ahead of any .diff or\n"
     ".patch suffix, or a -N already there counts up (patch.diff,\n"
     "patch-2.diff, patch-3.diff).\n",
     "Create a copy of the topmost patch under a new name"},

    // Implemented analysis commands
    {"annotate", cmd_annotate,
     "Usage: quilt annotate [-P patch] {file}",
     "Usage: quilt annotate [-P patch] file\n"
     "\n"
     "Show which applied patch last modified each line of a file,\n"
     "similar to git blame. Works by comparing successive backup\n"
     "copies in .pc/.\n"
     "\n"
     "Options:\n"
     "  -P patch    Stop at the named patch instead of the top.\n",
     "Show which patch modified each line of a file"},

    {"graph", cmd_graph,
     "Usage: quilt graph [--all] [--reduce] [--lines[=num]] "
     "[--edge-labels=files] [-T ps] [patch]",
     "Usage: quilt graph [--all] [--reduce] [--lines[=num]]\n"
     "                   [--edge-labels=files] [patch]\n"
     "\n"
     "Print a dot-format dependency graph of applied patches. Two\n"
     "patches are dependent if they modify the same file, or with\n"
     "--lines, if their changes overlap.\n"
     "\n"
     "Options:\n"
     "  --all             Include all applied patches (default: only\n"
     "                    dependencies of the top or named patch).\n"
     "  --reduce          Remove transitive edges from the graph.\n"
     "  --lines[=num]     Compute line-level dependencies using num\n"
     "                    lines of context (default: 2).\n"
     "  --edge-labels=files  Label edges with shared filenames.\n",
     "Print a dot dependency graph of applied patches"},

    {"mail", cmd_mail,
     "Usage: quilt mail {--mbox file} [--prefix prefix] [--sender ...] "
     "[--from ...] [--to ...] [--cc ...] [--bcc ...] "
     "[first_patch [last_patch]]",
     "Usage: quilt mail {--mbox file} [--prefix prefix] [--sender addr]\n"
     "                  [--from addr] [--to addr] [--cc addr] [--bcc addr]\n"
     "                  [first_patch [last_patch]]\n"
     "\n"
     "Generate an mbox file containing one message per patch in the\n"
     "given range. Output is intended for git am. Either --from or\n"
     "--sender is required.\n"
     "\n"
     "Options:\n"
     "  --mbox file       Write output to file (required).\n"
     "  --prefix prefix   Subject line prefix (default: PATCH).\n"
     "  --sender addr     Set the envelope sender address.\n"
     "  --from addr       Set the From: header address.\n"
     "  --to addr         Add a To: recipient (repeatable).\n"
     "  --cc addr         Add a Cc: recipient (repeatable).\n"
     "  --bcc addr        Add a Bcc: recipient (repeatable).\n",
     "Generate an mbox file from a range of patches"},

    // Stubs
    {"grep", cmd_grep,
     "Usage: quilt grep [-h|options] {pattern}",
     "Usage: quilt grep [-h|options] pattern\n"
     "\n"
     "Search source files, skipping patches/ and .pc/ directories.\n"
     "Not yet implemented.\n",
     "Search source files (not implemented)"},

    {"setup", cmd_setup,
     "Usage: quilt setup [-d path-prefix] [-v] [--sourcedir dir] [--fuzz=N] "
     "[--spec-filter FILTER] [--slow|--fast] {specfile|seriesfile}",
     "Usage: quilt setup [-d path] series\n"
     "\n"
     "Initialize a source tree from a series file or RPM spec.\n"
     "Not yet implemented.\n",
     "Set up a source tree from a series file (not implemented)"},

    {"shell", cmd_shell,
     "Usage: quilt shell [command]",
     "Usage: quilt shell [command]\n"
     "\n"
     "Open a shell or run a command in the quilt environment.\n"
     "Not yet implemented.\n",
     "Open a subshell (not implemented)"},

    {"snapshot", cmd_snapshot,
     "Usage: quilt snapshot [-d]",
     "Usage: quilt snapshot [-d]\n"
     "\n"
     "Save a copy of the current working tree state for later\n"
     "comparison with quilt diff --snapshot.\n"
     "\n"
     "Options:\n"
     "  -d          Remove the current snapshot instead of creating one.\n",
     "Save a snapshot of the working tree for later diff"},

    {"upgrade", cmd_upgrade,
     "Usage: quilt upgrade",
     "Usage: quilt upgrade\n"
     "\n"
     "Upgrade quilt metadata in .pc/ to the current format. This is\n"
     "a no-op because only the version 2 format is supported.\n",
     "Upgrade quilt metadata to the current format"},

    {"init", cmd_init,
     "Usage: quilt init",
     "Usage: quilt init\n"
     "\n"
     "Initialize quilt metadata in the current directory. This is\n"
     "optional since any quilt command creates .pc/ and patches/ as\n"
     "needed, but it lets you establish the project root before\n"
     "working from a subdirectory.\n",
     "Initialize quilt metadata in the current directory"},
};

static constexpr int num_commands = sizeof(commands) / sizeof(commands[0]);

static const Command *find_command(std::string_view name) {
    for (const auto &c : commands) {
        if (name == c.name) return &c;
    }
    return nullptr;
}

int usage_error(std::string_view command) {
    if (const Command *c = find_command(command)) err_line(c->synopsis);
    return 1;
}

int command_help(std::string_view command) {
    if (const Command *c = find_command(command)) out_line(c->usage);
    return 0;
}

// The option that --name names: an exact match, or else the only option
// that name abbreviates, where upstream's options beat quilt.cpp's
// extensions. Without one, return the candidates, which may be none.
static const LongOpt *match_long_option(std::span<const LongOpt> longopts,
                                        std::string_view name,
                                        std::vector<const LongOpt *> &candidates)
{
    for (const auto &opt : longopts) {
        if (opt.name == name) return &opt;
        if (!name.empty() && opt.name.starts_with(name)) candidates.push_back(&opt);
    }
    if (std::ranges::any_of(candidates, [](auto *c) { return !c->extension; })) {
        std::erase_if(candidates, [](auto *c) { return c->extension; });
    }
    if (candidates.empty()) return nullptr;
    // Like getopt_long, names for the same option are no ambiguity
    const LongOpt *first = candidates.front();
    bool same = std::ranges::all_of(candidates, [&](auto *c) {
        return c->key == first->key && c->arg == first->arg;
    });
    return same ? first : nullptr;
}

std::optional<ParsedArgs> parse_options(int argc, char **argv,
                                        std::string_view shortopts,
                                        std::span<const LongOpt> longopts)
{
    std::string_view command = argv[0];
    std::vector<LongOpt> all_longopts(longopts.begin(), longopts.end());
    all_longopts.push_back({"help", OptArg::none, 'h', true});

    // Like getopt(1), report every bad option before giving up
    bool ok = true;
    auto complain = [&](std::string_view what) {
        err("quilt "); err(command); err(": "); err_line(what);
        ok = false;
    };

    ParsedArgs parsed;
    for (int i = 1; i < argc; ++i) {
        std::string_view arg = argv[i];
        if (arg == "--") {
            while (++i < argc) parsed.operands.emplace_back(argv[i]);
            break;
        }
        if (std::ssize(arg) < 2 || arg[0] != '-') {
            parsed.operands.push_back(arg);
            continue;
        }

        if (arg[1] == '-') {
            std::string_view body = arg.substr(2);
            ptrdiff_t eq = str_find(body, '=');
            std::string_view name = body.substr(0, eq < 0 ? body.size() : checked_cast<size_t>(eq));
            std::vector<const LongOpt *> candidates;
            const LongOpt *opt = match_long_option(all_longopts, name, candidates);
            if (!opt) {
                std::string what;
                if (candidates.empty()) {
                    what = "unrecognized option '" + std::string(arg) + "'";
                } else {
                    what = "option '" + std::string(arg) + "' is ambiguous; possibilities:";
                    for (auto *c : candidates) what += " '--" + std::string(c->name) + "'";
                }
                complain(what);
                continue;
            }
            std::string_view value;
            if (eq >= 0) {
                if (opt->arg == OptArg::none) {
                    complain("option '--" + std::string(opt->name) + "' doesn't allow an argument");
                    continue;
                }
                value = body.substr(checked_cast<size_t>(eq + 1));
            } else if (opt->arg == OptArg::required) {
                if (i + 1 >= argc) {
                    complain("option '--" + std::string(opt->name) + "' requires an argument");
                    continue;
                }
                value = argv[++i];
            }
            parsed.options.push_back({opt->key, value});
            continue;
        }

        for (ptrdiff_t j = 1; j < std::ssize(arg); ++j) {
            char letter = arg[checked_cast<size_t>(j)];
            ptrdiff_t at = letter == ':' ? -1 : str_find(shortopts, letter);
            if (at < 0) {
                complain(std::string("invalid option -- '") + letter + "'");
                continue;
            }
            int key = static_cast<unsigned char>(letter);
            auto colon_at = [&](ptrdiff_t k) {
                return k < std::ssize(shortopts) && shortopts[checked_cast<size_t>(k)] == ':';
            };
            if (!colon_at(at + 1)) {
                parsed.options.push_back({key, {}});
                continue;
            }
            // The rest of the word is the value, or, for a required one,
            // the next word, whatever it is
            std::string_view value = arg.substr(checked_cast<size_t>(j + 1));
            if (value.empty() && !colon_at(at + 2)) {
                if (i + 1 >= argc) {
                    complain(std::string("option requires an argument -- '") + letter + "'");
                    break;
                }
                value = argv[++i];
            }
            parsed.options.push_back({key, value});
            break;
        }
    }

    if (!ok) {
        usage_error(command);
        return std::nullopt;
    }
    return parsed;
}

static std::string to_upper(std::string_view s) {
    std::string result(s);
    for (char &c : result) {
        if (c >= 'a' && c <= 'z') c -= 32;
    }
    return result;
}

int quilt_main(int argc, char **argv) {
    // --- Phase 1: Extract global options (--quiltrc) from argv ---
    std::string quiltrc_path;   // empty = default search, "-" = disabled
    bool quiltrc_set = false;
    std::vector<char *> clean_argv;
    clean_argv.push_back(argv[0]);
    for (int i = 1; i < argc; ++i) {
        std::string_view a = argv[i];
        if (a == "--quiltrc" && i + 1 < argc) {
            quiltrc_path = argv[i + 1];
            quiltrc_set = true;
            ++i; // skip the argument
            continue;
        }
        if (a.starts_with("--quiltrc=")) {
            quiltrc_path = std::string(a.substr(10));
            quiltrc_set = true;
            continue;
        }
        if (a == "--trace") {
            continue;  // accepted but ignored
        }
        clean_argv.push_back(argv[i]);
    }
    int clean_argc = checked_cast<int>(std::ssize(clean_argv));

    // Handle no arguments
    if (clean_argc < 2) {
        err_line("Usage: quilt [--quiltrc file] <command> [options] [args]");
        err_line("Use \"quilt --help\" for a list of commands.");
        return 1;
    }

    std::string_view arg1 = clean_argv[1];

    // Handle --version
    if (arg1 == "--version" || arg1 == "-v") {
        out_line(QUILT_VERSION);
        return 0;
    }

    // Handle --help
    if (arg1 == "--help" || arg1 == "-h" || arg1 == "help") {
        out_line("Usage: quilt [--quiltrc file] <command> [options] [args]");
        out_line("");
        out_line("Commands:");
        ptrdiff_t max_len = 0;
        for (int i = 0; i < num_commands; ++i) {
            ptrdiff_t len = std::ssize(std::string_view(commands[i].name));
            if (len > max_len) max_len = len;
        }
        for (int i = 0; i < num_commands; ++i) {
            std::string line = "  ";
            line += commands[i].name;
            line.append(checked_cast<size_t>(max_len + 2 - std::ssize(std::string_view(commands[i].name))), ' ');
            line += commands[i].description;
            out_line(line);
        }
        out_line("");
        out_line("Use \"quilt <command> --help\" for details on a specific command.");
        return 0;
    }

    // --- Phase 2: Load quiltrc and populate environment ---
    auto rc_vars = load_quiltrc(quiltrc_set ? quiltrc_path : std::string());
    // Apply quiltrc values to environment. GNU quilt sources quiltrc into the
    // command process, so assignments there override inherited environment
    // values unless the rc itself chooses otherwise.
    for (auto &kv : rc_vars) {
        set_env(kv.first, kv.second);
    }

    // --- Phase 3: Find command ---
    std::string cmd_name(arg1);

    // Find command (supports unique prefix abbreviation)
    Command *found = nullptr;
    int match_count = 0;
    for (int i = 0; i < num_commands; ++i) {
        if (cmd_name == commands[i].name) {
            found = &commands[i];
            match_count = 1;
            break;
        }
        if (std::string_view(commands[i].name).starts_with(cmd_name)) {
            found = &commands[i];
            match_count++;
        }
    }

    if (match_count > 1) {
        err_line("quilt: command '" + cmd_name + "' is ambiguous");
        return 1;
    }

    if (!found) {
        err_line("quilt: unknown command '" + cmd_name + "'");
        err_line("Use \"quilt --help\" for a list of commands.");
        return 1;
    }

    // Handle per-command -h/--help before dispatching
    for (int i = 2; i < clean_argc; ++i) {
        std::string_view a = clean_argv[checked_cast<size_t>(i)];
        if (a == "-h" || a == "--help") {
            out_line(found->usage);
            return 0;
        }
    }

    // --- Phase 4: Load state ---
    std::string original_cwd = get_cwd();
    QuiltState q = load_state();
    if (std::string_view(found->name) == "init" && get_cwd() != original_cwd) {
        set_cwd(original_cwd);
    }
    q.config = rc_vars;
    // Merge env overrides into config
    for (auto &kv : rc_vars) {
        std::string env_val = get_env(kv.first);
        if (!env_val.empty()) {
            q.config[kv.first] = env_val;
        }
    }

    // --- Phase 5: Inject QUILT_COMMAND_ARGS ---
    std::string args_key = "QUILT_" + to_upper(found->name) + "_ARGS";
    std::string cmd_args = get_env(args_key);
    auto extra_args = shell_split(cmd_args);

    // Build the final argv for the command: [cmd_name, extra_args..., user_args...]
    // Command argv starts at clean_argv+1
    std::vector<std::string> final_argv_storage;
    std::vector<char *> final_argv;

    final_argv_storage.push_back(std::string(found->name));
    for (auto &ea : extra_args) {
        final_argv_storage.push_back(ea);
    }
    for (int i = 2; i < clean_argc; ++i) {
        final_argv_storage.push_back(clean_argv[checked_cast<size_t>(i)]);
    }

    for (auto &s : final_argv_storage) {
        final_argv.push_back(const_cast<char *>(s.c_str()));
    }

    // Dispatch
    return found->fn(q, checked_cast<int>(std::ssize(final_argv)), final_argv.data());
}
