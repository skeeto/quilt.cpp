// This is free and unencumbered software released into the public domain.
#include "quilt.hpp"
#include "platform.hpp"

#include <ctime>
#include <cstdio>

// Forward declarations for helpers defined in core.cpp
extern std::vector<std::string> read_series(std::string_view path,
                                            std::map<std::string, int> *strip_levels);

static std::string extract_header(std::string_view content) {
    std::string header;
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

static std::string extract_diff(std::string_view content) {
    auto lines = split_lines(content);
    std::string diff;
    bool in_diff = false;
    for (const auto &line : lines) {
        if (!in_diff) {
            if (starts_with(line, "Index:") ||
                starts_with(line, "--- ") ||
                starts_with(line, "diff ") ||
                starts_with(line, "===")) {
                in_diff = true;
            }
        }
        if (in_diff) {
            diff += line;
            diff += '\n';
        }
    }
    return diff;
}

static bool has_non_ascii(std::string_view s) {
    for (char ch : s) {
        if (static_cast<unsigned char>(ch) > 127) return true;
    }
    return false;
}

// RFC 2047 quoted-printable encoding for a header value
static std::string rfc2047_encode(std::string_view s) {
    // Encode as =?UTF-8?q?...?=
    // Characters that must be encoded: non-ASCII, =, ?, _, space
    std::string result = "=?UTF-8?q?";
    ptrdiff_t line_len = 10; // length of "=?UTF-8?q?"
    for (char ch : s) {
        auto c = static_cast<unsigned char>(ch);
        std::string encoded;
        if (c == '=' || c == '?' || c == '_' || c == ' ' || c > 127) {
            char buf[4];
            std::snprintf(buf, sizeof(buf), "=%02X", c);
            encoded = buf;
        } else {
            encoded = std::string(1, ch);
        }
        // Line wrap: if adding this would exceed ~75 chars, close and start new encoded word
        if (line_len + std::ssize(encoded) + 2 > 75) { // 2 for "?="
            result += "?=\n =?UTF-8?q?";
            line_len = 12; // " =?UTF-8?q?"
        }
        result += encoded;
        line_len += std::ssize(encoded);
    }
    result += "?=";
    return result;
}

// Format RFC 2822 date from a time_t
static std::string format_rfc2822_date(time_t t) {
    struct tm local_tm;
    localtime_r(&t, &local_tm);

    // Compute UTC offset
    struct tm utc_tm;
    gmtime_r(&t, &utc_tm);
    // Difference in seconds
    long local_sec = local_tm.tm_hour * 3600L + local_tm.tm_min * 60L + local_tm.tm_sec;
    long utc_sec = utc_tm.tm_hour * 3600L + utc_tm.tm_min * 60L + utc_tm.tm_sec;
    long diff = local_sec - utc_sec;
    // Adjust for day boundary
    int day_diff = local_tm.tm_yday - utc_tm.tm_yday;
    if (day_diff > 1) day_diff = -1;   // year boundary: local is Dec 31, utc is Jan 1
    if (day_diff < -1) day_diff = 1;   // year boundary: local is Jan 1, utc is Dec 31
    diff += day_diff * 86400L;

    int tz_hours = (int)(diff / 3600);
    int tz_mins = (int)((diff % 3600) / 60);
    if (tz_mins < 0) tz_mins = -tz_mins;

    static const char *days[] = {"Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"};
    static const char *months[] = {"Jan", "Feb", "Mar", "Apr", "May", "Jun",
                                   "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"};

    char buf[64];
    std::snprintf(buf, sizeof(buf), "%s, %d %s %d %02d:%02d:%02d %+03d%02d",
                  days[local_tm.tm_wday],
                  local_tm.tm_mday,
                  months[local_tm.tm_mon],
                  local_tm.tm_year + 1900,
                  local_tm.tm_hour, local_tm.tm_min, local_tm.tm_sec,
                  tz_hours, tz_mins);
    return buf;
}

// Generate a Message-ID
static std::string make_message_id(time_t t, int seq, std::string_view from) {
    // Extract domain from the from address
    std::string domain = "localhost";
    auto at = str_find(from, '@');
    if (at >= 0) {
        auto end = str_find(from, '>', at);
        if (end < 0) end = std::ssize(from);
        domain = std::string(from.substr(to_uz(at + 1), to_uz(end - at - 1)));
    }

    char buf[128];
    std::snprintf(buf, sizeof(buf), "<%ld.%d@%s>",
                  (long)t, seq, domain.c_str());
    return buf;
}

// Compute the width needed for zero-padded patch numbers
static int num_width(int n) {
    if (n < 10) return 1;
    if (n < 100) return 2;
    if (n < 1000) return 3;
    return 4;
}

int cmd_mail(QuiltState &q, int argc, char **argv) {
    std::string mbox_file;
    std::string from_addr;
    std::string sender_addr;
    std::string prefix = "PATCH";
    std::vector<std::string> to_addrs;
    std::vector<std::string> cc_addrs;
    std::vector<std::string> bcc_addrs;
    std::vector<std::string> positional;

    for (int i = 1; i < argc; ++i) {
        std::string_view arg = argv[i];
        if (arg == "--mbox" && i + 1 < argc) {
            mbox_file = argv[++i];
        } else if (arg == "--send") {
            err_line("quilt mail: send mode is not supported; use --mbox");
            return 1;
        } else if (arg == "--sender" && i + 1 < argc) {
            sender_addr = argv[++i];
        } else if (arg == "--from" && i + 1 < argc) {
            from_addr = argv[++i];
        } else if (arg == "--prefix" && i + 1 < argc) {
            prefix = argv[++i];
        } else if (arg == "--to" && i + 1 < argc) {
            to_addrs.emplace_back(argv[++i]);
        } else if (arg == "--cc" && i + 1 < argc) {
            cc_addrs.emplace_back(argv[++i]);
        } else if (arg == "--bcc" && i + 1 < argc) {
            bcc_addrs.emplace_back(argv[++i]);
        } else if (arg == "--subject" && i + 1 < argc) {
            ++i; // consume and ignore (cover letter not generated)
        } else if (arg == "-m" && i + 1 < argc) {
            ++i; // consume and ignore (cover letter not generated)
        } else if (arg == "-M" && i + 1 < argc) {
            ++i; // consume and ignore (cover letter not generated)
        } else if (arg == "--reply-to" && i + 1 < argc) {
            ++i; // consume and ignore (cover letter not generated)
        } else if (arg == "--charset" && i + 1 < argc) {
            ++i; // consume and ignore
        } else if (arg == "--signature" && i + 1 < argc) {
            ++i; // consume and ignore
        } else if (arg == "-h" || arg == "--help") {
            out_line("Usage: quilt mail {--mbox file} [--prefix prefix] "
                     "[--sender ...] [--from ...] [--to ...] [--cc ...] "
                     "[--bcc ...] [first_patch [last_patch]]");
            return 0;
        } else if (arg[0] != '-' || arg == "-") {
            positional.emplace_back(arg);
        } else {
            err("quilt mail: unknown option: ");
            err_line(arg);
            return 1;
        }
    }

    if (mbox_file.empty()) {
        err_line("quilt mail: --mbox is required");
        return 1;
    }

    // Determine From address
    std::string effective_from = from_addr;
    if (effective_from.empty()) {
        effective_from = sender_addr;
    }
    if (effective_from.empty()) {
        err_line("quilt mail: --from or --sender is required");
        return 1;
    }

    if (q.series.empty()) {
        err_line("No patches in series");
        return 1;
    }

    // Resolve patch range
    ptrdiff_t first_idx = 0;
    ptrdiff_t last_idx = std::ssize(q.series) - 1;

    if (std::ssize(positional) == 1) {
        // Single patch
        std::string name = positional[0];
        if (name == "-") {
            // "-" as single arg means all patches
        } else {
            auto idx = q.find_in_series(name);
            if (!idx) {
                err_line("Patch " + name + " is not in series");
                return 1;
            }
            first_idx = *idx;
            last_idx = *idx;
        }
    } else if (std::ssize(positional) == 2) {
        std::string first_name = positional[0];
        std::string last_name = positional[1];

        if (first_name == "-") {
            first_idx = 0;
        } else {
            auto idx = q.find_in_series(first_name);
            if (!idx) {
                err_line("Patch " + first_name + " is not in series");
                return 1;
            }
            first_idx = *idx;
        }

        if (last_name == "-") {
            last_idx = std::ssize(q.series) - 1;
        } else {
            auto idx = q.find_in_series(last_name);
            if (!idx) {
                err_line("Patch " + last_name + " is not in series");
                return 1;
            }
            last_idx = *idx;
        }

        if (first_idx > last_idx) {
            err_line("quilt mail: first patch must come before last patch in series");
            return 1;
        }
    } else if (std::ssize(positional) > 2) {
        err_line("Usage: quilt mail {--mbox file} [options] [first_patch [last_patch]]");
        return 1;
    }

    ptrdiff_t total = last_idx - first_idx + 1;
    int width = num_width(to_int(total));
    time_t base_time = std::time(nullptr);

    std::string mbox;

    for (ptrdiff_t i = first_idx; i <= last_idx; ++i) {
        const std::string &patch = q.series[to_uz(i)];
        std::string patch_file = path_join(q.work_dir, q.patches_dir, patch);
        std::string content = read_file(patch_file);

        if (content.empty()) {
            err("Warning: patch ");
            err(patch);
            err_line(" is empty, skipping");
            continue;
        }

        // Extract header and diff
        std::string header = extract_header(content);
        std::string diff = extract_diff(content);

        // Split header into subject (first line) and body (rest)
        std::string subject_text;
        std::string body;
        if (!header.empty()) {
            auto hdr_lines = split_lines(header);
            // Find first non-empty line for subject
            ptrdiff_t subj_line = 0;
            while (subj_line < std::ssize(hdr_lines) && trim(hdr_lines[to_uz(subj_line)]).empty()) {
                subj_line++;
            }
            if (subj_line < std::ssize(hdr_lines)) {
                subject_text = trim(hdr_lines[to_uz(subj_line)]);
                // Remaining lines become body
                for (ptrdiff_t j = subj_line + 1; j < std::ssize(hdr_lines); ++j) {
                    body += hdr_lines[to_uz(j)];
                    body += '\n';
                }
            }
        }

        // If no header at all, use patch name as subject
        if (subject_text.empty()) {
            subject_text = patch;
        }

        // Build Subject with prefix
        std::string subject_prefix;
        if (total == 1) {
            subject_prefix = "[" + prefix + "]";
        } else {
            int seq = to_int(i - first_idx + 1);
            char num_buf[32];
            std::snprintf(num_buf, sizeof(num_buf), "[%s %0*d/%d]",
                          prefix.c_str(), width, seq, to_int(total));
            subject_prefix = num_buf;
        }

        std::string full_subject = subject_prefix + " " + subject_text;

        // RFC 2047 encode subject if needed
        std::string subject_header;
        if (has_non_ascii(full_subject)) {
            subject_header = "Subject: " + rfc2047_encode(full_subject);
        } else {
            subject_header = "Subject: " + full_subject;
        }

        time_t msg_time = base_time + (i - first_idx);
        int seq = to_int(i - first_idx + 1);

        // Build message
        std::string msg;

        // Mbox separator
        msg += "From 0000000000000000000000000000000000000000 Mon Sep 17 00:00:00 2001\n";

        // From header
        msg += "From: " + effective_from + "\n";

        // Date header
        msg += "Date: " + format_rfc2822_date(msg_time) + "\n";

        // Subject header
        msg += subject_header + "\n";

        // Message-ID
        msg += "Message-ID: " + make_message_id(msg_time, seq, effective_from) + "\n";

        // MIME headers if non-ASCII in body
        if (has_non_ascii(header) || has_non_ascii(diff) || has_non_ascii(full_subject)) {
            msg += "MIME-Version: 1.0\n";
            msg += "Content-Type: text/plain; charset=UTF-8\n";
            msg += "Content-Transfer-Encoding: 8bit\n";
        }

        // Optional To/Cc/Bcc
        for (const auto &addr : to_addrs) {
            msg += "To: " + addr + "\n";
        }
        for (const auto &addr : cc_addrs) {
            msg += "Cc: " + addr + "\n";
        }
        for (const auto &addr : bcc_addrs) {
            msg += "Bcc: " + addr + "\n";
        }

        // Blank line separating headers from body
        msg += "\n";

        // Body (remaining header text)
        if (!body.empty()) {
            // Trim leading blank lines from body
            std::string_view bv = body;
            while (starts_with(bv, "\n")) {
                bv = bv.substr(1);
            }
            if (!bv.empty()) {
                msg += bv;
                if (bv.back() != '\n') {
                    msg += '\n';
                }
            }
        }

        // Separator
        msg += "---\n";

        // Diff content
        if (!diff.empty()) {
            msg += diff;
            if (diff.back() != '\n') {
                msg += '\n';
            }
        }

        // Trailer (like git's "-- \n2.53.0\n")
        msg += "-- \nquilt\n\n";

        mbox += msg;
    }

    if (!write_file(mbox_file, mbox)) {
        err_line("Failed to write mbox file: " + mbox_file);
        return 1;
    }

    out("Wrote ");
    out(std::to_string(total));
    out(" patch");
    if (total != 1) out("es");
    out(" to ");
    out_line(mbox_file);

    return 0;
}
