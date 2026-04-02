// This is free and unencumbered software released into the public domain.
//
// Built-in diff engine: Myers, minimal, and patience algorithms.
// Produces unified or context diff output, replacing the need for an
// external diff binary.

#include "quilt.hpp"
#include "platform.hpp"
#include <algorithm>
#include <cstdio>
#include <optional>
#include <unordered_map>

std::optional<DiffAlgorithm> parse_diff_algorithm(std::string_view name)
{
    if (name == "myers")     return DiffAlgorithm::myers;
    if (name == "minimal")   return DiffAlgorithm::minimal;
    if (name == "patience")  return DiffAlgorithm::patience;
    if (name == "histogram") return DiffAlgorithm::histogram;
    return std::nullopt;
}

// Approximate integer square root: next power of 2 >= sqrt(n).
// Matches libxdiff's xdl_bogosqrt().
static ptrdiff_t bogosqrt(ptrdiff_t n)
{
    ptrdiff_t r = 1;
    while (r * r < n)
        r <<= 1;
    return r;
}

// Split content into lines, preserving the information about whether
// the file ended with a newline.  Each element is one line WITHOUT its
// terminating '\n'.
struct FileLines {
    std::vector<std::string_view> lines;
    bool has_trailing_newline = true;
};

static FileLines split_file_lines(std::string_view content)
{
    FileLines fl;
    if (content.empty()) {
        fl.has_trailing_newline = true;  // empty file is fine
        return fl;
    }

    fl.has_trailing_newline = (content.back() == '\n');

    ptrdiff_t start = 0;
    ptrdiff_t len = std::ssize(content);
    for (ptrdiff_t i = 0; i < len; ++i) {
        if (content[checked_cast<size_t>(i)] == '\n') {
            fl.lines.push_back(content.substr(checked_cast<size_t>(start),
                                              checked_cast<size_t>(i - start)));
            start = i + 1;
        }
    }
    // If there's content after the last newline (no trailing newline)
    if (start < len) {
        fl.lines.push_back(content.substr(checked_cast<size_t>(start),
                                          checked_cast<size_t>(len - start)));
    }

    return fl;
}

// Myers diff algorithm.
// Returns a list of edit operations: 'E' (equal), 'D' (delete from old),
// 'I' (insert from new).
struct EditOp {
    char type;       // 'E', 'D', 'I'
    ptrdiff_t old_idx; // index in old_lines (-1 for Insert)
    ptrdiff_t new_idx; // index in new_lines (-1 for Delete)
};

// Backtrack through a Myers trace from (x,y) back to (0,0), building
// edit operations in reverse order.  Returns ops in forward order.
static std::vector<EditOp> backtrack_trace(
    const std::vector<std::vector<ptrdiff_t>> &trace,
    ptrdiff_t final_d, ptrdiff_t x, ptrdiff_t y, ptrdiff_t offset)
{
    std::vector<EditOp> ops;

    for (ptrdiff_t d = final_d; d > 0; --d) {
        const auto &prev_v = trace[checked_cast<size_t>(d)];
        ptrdiff_t k = x - y;

        ptrdiff_t prev_k;
        if (k == -d || (k != d && prev_v[checked_cast<size_t>(offset + k - 1)] < prev_v[checked_cast<size_t>(offset + k + 1)])) {
            prev_k = k + 1;  // came from insert (down)
        } else {
            prev_k = k - 1;  // came from delete (right)
        }

        ptrdiff_t prev_x = prev_v[checked_cast<size_t>(offset + prev_k)];
        ptrdiff_t prev_y = prev_x - prev_k;

        // Diagonal (equal lines) — add in reverse
        while (x > prev_x && y > prev_y) {
            --x;
            --y;
            ops.push_back({'E', x, y});
        }

        // The actual edit
        if (x > prev_x) {
            --x;
            ops.push_back({'D', x, -1});
        } else if (y > prev_y) {
            --y;
            ops.push_back({'I', -1, y});
        }
    }

    // Remaining diagonal at d=0
    while (x > 0 && y > 0) {
        --x;
        --y;
        ops.push_back({'E', x, y});
    }

    std::ranges::reverse(ops);
    return ops;
}

static std::vector<EditOp> myers_diff(
    std::span<const std::string_view> old_lines,
    std::span<const std::string_view> new_lines,
    DiffAlgorithm algorithm = DiffAlgorithm::myers)
{
    ptrdiff_t n = std::ssize(old_lines);
    ptrdiff_t m = std::ssize(new_lines);

    // Trivial cases
    if (n == 0 && m == 0) {
        return {};
    }
    if (n == 0) {
        std::vector<EditOp> ops;
        ops.reserve(checked_cast<size_t>(m));
        for (ptrdiff_t j = 0; j < m; ++j)
            ops.push_back({'I', -1, j});
        return ops;
    }
    if (m == 0) {
        std::vector<EditOp> ops;
        ops.reserve(checked_cast<size_t>(n));
        for (ptrdiff_t i = 0; i < n; ++i)
            ops.push_back({'D', i, -1});
        return ops;
    }

    // Myers' algorithm with linear-space trace recording.
    // We store the V array for each D step to reconstruct the path.
    ptrdiff_t max_d = n + m;
    // V is indexed by k + offset where k ranges from -max_d to max_d
    ptrdiff_t offset = max_d;
    ptrdiff_t v_size = 2 * max_d + 1;

    // Cost cap for myers mode (heuristic, matches libxdiff).
    // minimal mode searches the full O(ND) space.
    ptrdiff_t mxcost = max_d;
    if (algorithm == DiffAlgorithm::myers) {
        mxcost = bogosqrt(n + m);
        if (mxcost < 256) mxcost = 256;
        if (mxcost > max_d) mxcost = max_d;
    }

    // Store a copy of V for each d value to reconstruct the edit path
    std::vector<std::vector<ptrdiff_t>> trace;
    std::vector<ptrdiff_t> v(checked_cast<size_t>(v_size), -1);
    v[checked_cast<size_t>(offset + 1)] = 0;

    ptrdiff_t final_d = -1;
    for (ptrdiff_t d = 0; d <= max_d; ++d) {
        trace.push_back(v);  // save state before this round
        for (ptrdiff_t k = -d; k <= d; k += 2) {
            ptrdiff_t x;
            if (k == -d || (k != d && v[checked_cast<size_t>(offset + k - 1)] < v[checked_cast<size_t>(offset + k + 1)])) {
                x = v[checked_cast<size_t>(offset + k + 1)];  // move down (insert)
            } else {
                x = v[checked_cast<size_t>(offset + k - 1)] + 1;  // move right (delete)
            }
            ptrdiff_t y = x - k;

            // Follow diagonal (equal lines)
            while (x < n && y < m && old_lines[checked_cast<size_t>(x)] == new_lines[checked_cast<size_t>(y)]) {
                ++x;
                ++y;
            }

            v[checked_cast<size_t>(offset + k)] = x;

            if (x >= n && y >= m) {
                final_d = d;
                goto found;
            }
        }

        // Cost heuristic: if we've exceeded the budget, pick the
        // furthest-reaching endpoint and construct a suboptimal script.
        // This matches libxdiff's behavior for --diff-algorithm=myers.
        if (d >= mxcost && d < max_d) {
            // Find the diagonal with maximum progress (x + y)
            ptrdiff_t best_x = -1, best_y = -1;
            for (ptrdiff_t k = -d; k <= d; k += 2) {
                ptrdiff_t x = v[checked_cast<size_t>(offset + k)];
                if (x < 0) continue;
                ptrdiff_t y = x - k;
                if (x > n || y > m || y < 0) continue;
                if (best_x < 0 || (x + y) > (best_x + best_y)) {
                    best_x = x;
                    best_y = y;
                }
            }

            if (best_x >= 0) {
                // Backtrack from the best endpoint to (0,0)
                final_d = d;
                auto ops = backtrack_trace(trace, final_d, best_x, best_y, offset);

                // Recurse on the remaining portion with a fresh search
                // budget, so matching lines past the cutoff are found.
                auto tail_old = old_lines.subspan(checked_cast<size_t>(best_x));
                auto tail_new = new_lines.subspan(checked_cast<size_t>(best_y));
                auto tail_ops = myers_diff(tail_old, tail_new, algorithm);

                // Adjust indices back to the original coordinate space
                for (auto &op : tail_ops) {
                    if (op.old_idx >= 0) op.old_idx += best_x;
                    if (op.new_idx >= 0) op.new_idx += best_y;
                    ops.push_back(op);
                }
                return ops;
            }
        }
    }
found:

    return backtrack_trace(trace, final_d, n, m, offset);
}

// Patience diff algorithm.
//
// Anchors on lines that appear exactly once in each file, computes their
// longest increasing subsequence (LIS) via patience sorting, and recurses
// on the gaps between anchors.  Falls back to Myers (minimal) when no
// unique common lines exist.
static std::vector<EditOp> patience_diff(
    std::span<const std::string_view> old_lines,
    std::span<const std::string_view> new_lines)
{
    ptrdiff_t n = std::ssize(old_lines);
    ptrdiff_t m = std::ssize(new_lines);

    if (n == 0 && m == 0) return {};
    if (n == 0) {
        std::vector<EditOp> ops;
        for (ptrdiff_t j = 0; j < m; ++j)
            ops.push_back({'I', -1, j});
        return ops;
    }
    if (m == 0) {
        std::vector<EditOp> ops;
        for (ptrdiff_t i = 0; i < n; ++i)
            ops.push_back({'D', i, -1});
        return ops;
    }

    // Step 1: Match common prefix and suffix.
    ptrdiff_t prefix = 0;
    while (prefix < n && prefix < m &&
           old_lines[checked_cast<size_t>(prefix)] == new_lines[checked_cast<size_t>(prefix)])
        ++prefix;

    ptrdiff_t suffix = 0;
    while (suffix < (n - prefix) && suffix < (m - prefix) &&
           old_lines[checked_cast<size_t>(n - 1 - suffix)] == new_lines[checked_cast<size_t>(m - 1 - suffix)])
        ++suffix;

    ptrdiff_t inner_old_len = n - prefix - suffix;
    ptrdiff_t inner_new_len = m - prefix - suffix;

    // If prefix + suffix covers everything, no interior to diff.
    if (inner_old_len <= 0 && inner_new_len <= 0) {
        std::vector<EditOp> ops;
        for (ptrdiff_t i = 0; i < n; ++i)
            ops.push_back({'E', i, i});
        return ops;
    }

    // Step 2: Find unique common lines in the interior.
    // Map line content → (count_in_old, old_idx, count_in_new, new_idx).
    struct LineInfo {
        int old_count = 0;
        ptrdiff_t old_idx = -1;
        int new_count = 0;
        ptrdiff_t new_idx = -1;
    };
    std::unordered_map<std::string_view, LineInfo> line_map;

    for (ptrdiff_t i = 0; i < inner_old_len; ++i) {
        auto &info = line_map[old_lines[checked_cast<size_t>(prefix + i)]];
        info.old_count++;
        info.old_idx = i;  // keeps last occurrence, but we only care when count==1
    }
    for (ptrdiff_t j = 0; j < inner_new_len; ++j) {
        auto &info = line_map[new_lines[checked_cast<size_t>(prefix + j)]];
        info.new_count++;
        info.new_idx = j;
    }

    // Collect unique matches, sorted by old_idx (natural insertion order
    // from scanning, but we sort explicitly to be safe).
    struct Match { ptrdiff_t old_idx; ptrdiff_t new_idx; };
    std::vector<Match> unique_matches;
    for (const auto &[line, info] : line_map) {
        if (info.old_count == 1 && info.new_count == 1) {
            unique_matches.push_back({info.old_idx, info.new_idx});
        }
    }
    std::ranges::sort(unique_matches, {}, &Match::old_idx);

    // Step 3: LIS of new_idx values via patience sorting.
    // Each pile stores (new_idx, back_pointer into flat list).
    struct Card {
        ptrdiff_t new_idx;
        ptrdiff_t old_idx;
        ptrdiff_t back;  // index into cards[] of predecessor, or -1
    };
    std::vector<Card> cards;
    std::vector<ptrdiff_t> pile_tops;  // indices into cards[] for top of each pile

    for (const auto &match : unique_matches) {
        // Binary search: find leftmost pile whose top new_idx >= match.new_idx
        ptrdiff_t lo = 0, hi = std::ssize(pile_tops);
        while (lo < hi) {
            ptrdiff_t mid = lo + (hi - lo) / 2;
            if (cards[checked_cast<size_t>(pile_tops[checked_cast<size_t>(mid)])].new_idx < match.new_idx)
                lo = mid + 1;
            else
                hi = mid;
        }

        ptrdiff_t back = (lo > 0) ? pile_tops[checked_cast<size_t>(lo - 1)] : ptrdiff_t{-1};
        ptrdiff_t card_idx = std::ssize(cards);
        cards.push_back({match.new_idx, match.old_idx, back});

        if (lo == std::ssize(pile_tops))
            pile_tops.push_back(card_idx);
        else
            pile_tops[checked_cast<size_t>(lo)] = card_idx;
    }

    // Reconstruct LIS by walking back-pointers from the last pile's top.
    std::vector<Match> anchors;
    if (!pile_tops.empty()) {
        ptrdiff_t idx = pile_tops.back();
        while (idx >= 0) {
            const auto &c = cards[checked_cast<size_t>(idx)];
            anchors.push_back({c.old_idx, c.new_idx});
            idx = c.back;
        }
        std::ranges::reverse(anchors);
    }

    // If no unique anchors found, fall back to Myers (minimal) on the interior.
    if (anchors.empty()) {
        auto inner_old = old_lines.subspan(checked_cast<size_t>(prefix),
                                           checked_cast<size_t>(inner_old_len));
        auto inner_new = new_lines.subspan(checked_cast<size_t>(prefix),
                                           checked_cast<size_t>(inner_new_len));
        auto inner_ops = myers_diff(inner_old, inner_new, DiffAlgorithm::minimal);

        // Assemble: prefix + inner + suffix
        std::vector<EditOp> ops;
        for (ptrdiff_t i = 0; i < prefix; ++i)
            ops.push_back({'E', i, i});
        for (auto &op : inner_ops) {
            if (op.old_idx >= 0) op.old_idx += prefix;
            if (op.new_idx >= 0) op.new_idx += prefix;
            ops.push_back(op);
        }
        for (ptrdiff_t i = 0; i < suffix; ++i)
            ops.push_back({'E', n - suffix + i, m - suffix + i});
        return ops;
    }

    // Step 4: Recurse on gaps between anchors.
    std::vector<EditOp> ops;

    // Emit prefix
    for (ptrdiff_t i = 0; i < prefix; ++i)
        ops.push_back({'E', i, i});

    ptrdiff_t prev_old = 0;  // interior-relative
    ptrdiff_t prev_new = 0;

    for (const auto &anchor : anchors) {
        // Gap before this anchor
        ptrdiff_t gap_old_len = anchor.old_idx - prev_old;
        ptrdiff_t gap_new_len = anchor.new_idx - prev_new;

        if (gap_old_len > 0 || gap_new_len > 0) {
            auto gap_old = old_lines.subspan(checked_cast<size_t>(prefix + prev_old),
                                             checked_cast<size_t>(gap_old_len));
            auto gap_new = new_lines.subspan(checked_cast<size_t>(prefix + prev_new),
                                             checked_cast<size_t>(gap_new_len));
            auto gap_ops = patience_diff(gap_old, gap_new);
            for (auto &op : gap_ops) {
                if (op.old_idx >= 0) op.old_idx += prefix + prev_old;
                if (op.new_idx >= 0) op.new_idx += prefix + prev_new;
                ops.push_back(op);
            }
        }

        // Emit the anchor as an equal match
        ops.push_back({'E', prefix + anchor.old_idx, prefix + anchor.new_idx});
        prev_old = anchor.old_idx + 1;
        prev_new = anchor.new_idx + 1;
    }

    // Gap after last anchor
    ptrdiff_t tail_old_len = inner_old_len - prev_old;
    ptrdiff_t tail_new_len = inner_new_len - prev_new;
    if (tail_old_len > 0 || tail_new_len > 0) {
        auto tail_old = old_lines.subspan(checked_cast<size_t>(prefix + prev_old),
                                          checked_cast<size_t>(tail_old_len));
        auto tail_new = new_lines.subspan(checked_cast<size_t>(prefix + prev_new),
                                          checked_cast<size_t>(tail_new_len));
        auto tail_ops = patience_diff(tail_old, tail_new);
        for (auto &op : tail_ops) {
            if (op.old_idx >= 0) op.old_idx += prefix + prev_old;
            if (op.new_idx >= 0) op.new_idx += prefix + prev_new;
            ops.push_back(op);
        }
    }

    // Emit suffix
    for (ptrdiff_t i = 0; i < suffix; ++i)
        ops.push_back({'E', n - suffix + i, m - suffix + i});

    return ops;
}

// Histogram diff algorithm.
//
// Extends patience diff by relaxing the strict uniqueness requirement.
// Instead of only anchoring on lines unique in both files, histogram diff
// builds an occurrence-count index of the old file and finds the longest
// contiguous matching block anchored at the lowest-occurrence line.  It
// then recurses on the regions before and after the block.  Falls back to
// Myers (minimal) when no suitable anchor exists.
static constexpr int MAX_CHAIN_LENGTH = 64;
static constexpr int MAX_RECURSION = 1024;  // same as Git's MAX_CNT_RECURSIVE

static std::vector<EditOp> histogram_diff_impl(
    std::span<const std::string_view> old_lines,
    std::span<const std::string_view> new_lines,
    int depth)
{
    ptrdiff_t n = std::ssize(old_lines);
    ptrdiff_t m = std::ssize(new_lines);

    if (n == 0 && m == 0) return {};
    if (n == 0) {
        std::vector<EditOp> ops;
        for (ptrdiff_t j = 0; j < m; ++j)
            ops.push_back({'I', -1, j});
        return ops;
    }
    if (m == 0) {
        std::vector<EditOp> ops;
        for (ptrdiff_t i = 0; i < n; ++i)
            ops.push_back({'D', i, -1});
        return ops;
    }

    // Step 1: Match common prefix and suffix.
    ptrdiff_t prefix = 0;
    while (prefix < n && prefix < m &&
           old_lines[checked_cast<size_t>(prefix)] == new_lines[checked_cast<size_t>(prefix)])
        ++prefix;

    ptrdiff_t suffix = 0;
    while (suffix < (n - prefix) && suffix < (m - prefix) &&
           old_lines[checked_cast<size_t>(n - 1 - suffix)] == new_lines[checked_cast<size_t>(m - 1 - suffix)])
        ++suffix;

    ptrdiff_t inner_old_len = n - prefix - suffix;
    ptrdiff_t inner_new_len = m - prefix - suffix;

    if (inner_old_len <= 0 && inner_new_len <= 0) {
        std::vector<EditOp> ops;
        for (ptrdiff_t i = 0; i < n; ++i)
            ops.push_back({'E', i, i});
        return ops;
    }

    // If recursion is too deep, fall back to Myers to avoid O(N²) behavior
    // on files with many unique lines (where each split removes only one line).
    if (depth >= MAX_RECURSION) {
        auto inner_old = old_lines.subspan(checked_cast<size_t>(prefix),
                                           checked_cast<size_t>(inner_old_len));
        auto inner_new = new_lines.subspan(checked_cast<size_t>(prefix),
                                           checked_cast<size_t>(inner_new_len));
        auto inner_ops = myers_diff(inner_old, inner_new, DiffAlgorithm::minimal);
        std::vector<EditOp> ops;
        for (ptrdiff_t i = 0; i < prefix; ++i)
            ops.push_back({'E', i, i});
        for (auto &op : inner_ops) {
            if (op.old_idx >= 0) op.old_idx += prefix;
            if (op.new_idx >= 0) op.new_idx += prefix;
            ops.push_back(op);
        }
        for (ptrdiff_t i = 0; i < suffix; ++i)
            ops.push_back({'E', n - suffix + i, m - suffix + i});
        return ops;
    }

    // Step 2: Build histogram of old interior lines.
    // Map line content → (occurrence count, list of positions in old).
    // Also build a parallel count array for O(1) lookup during extension.
    struct HistEntry {
        int count = 0;
        std::vector<ptrdiff_t> positions;  // interior-relative positions in old
    };
    std::unordered_map<std::string_view, HistEntry> hist;
    std::vector<int> old_count(checked_cast<size_t>(inner_old_len));

    for (ptrdiff_t i = 0; i < inner_old_len; ++i) {
        auto &entry = hist[old_lines[checked_cast<size_t>(prefix + i)]];
        entry.count++;
        entry.positions.push_back(i);
    }
    for (ptrdiff_t i = 0; i < inner_old_len; ++i) {
        auto it = hist.find(old_lines[checked_cast<size_t>(prefix + i)]);
        old_count[checked_cast<size_t>(i)] = it->second.count;
    }

    // Step 3: Scan new interior lines to find the best contiguous matching block.
    // Best block: lowest min-occurrence-count, then longest.
    //
    // Key optimizations vs. naive approach:
    //  (a) Skip lines in B whose A-count exceeds the current best threshold.
    //  (b) Skip A-occurrences whose count exceeds the threshold.
    //  (c) After extending a block forward, advance j past the extension so
    //      positions already covered are not re-scanned.
    //  (d) Use precomputed old_count[] instead of hash lookups during extension.
    ptrdiff_t best_old_start = -1, best_new_start = -1, best_len = 0;
    int best_threshold = MAX_CHAIN_LENGTH + 1;

    for (ptrdiff_t j = 0; j < inner_new_len; ) {
        auto it = hist.find(new_lines[checked_cast<size_t>(prefix + j)]);
        if (it == hist.end()) { ++j; continue; }
        const auto &entry = it->second;
        if (entry.count > MAX_CHAIN_LENGTH || entry.count > best_threshold) {
            ++j; continue;   // (a) can't improve on current best
        }

        ptrdiff_t j_advance = 1;  // how far to advance j after this iteration

        for (ptrdiff_t pi = 0; pi < std::ssize(entry.positions); ++pi) {
            ptrdiff_t oi = entry.positions[checked_cast<size_t>(pi)];

            // Extend backwards
            ptrdiff_t back = 0;
            int min_occ = entry.count;
            while (oi - back - 1 >= 0 && j - back - 1 >= 0 &&
                   old_lines[checked_cast<size_t>(prefix + oi - back - 1)] ==
                   new_lines[checked_cast<size_t>(prefix + j - back - 1)]) {
                ++back;
                int occ = old_count[checked_cast<size_t>(oi - back)];
                if (occ < min_occ) min_occ = occ;
            }

            // Extend forwards (past the initial match at (oi, j))
            ptrdiff_t fwd = 0;
            while (oi + fwd + 1 < inner_old_len && j + fwd + 1 < inner_new_len &&
                   old_lines[checked_cast<size_t>(prefix + oi + fwd + 1)] ==
                   new_lines[checked_cast<size_t>(prefix + j + fwd + 1)]) {
                ++fwd;
                int occ = old_count[checked_cast<size_t>(oi + fwd)];
                if (occ < min_occ) min_occ = occ;
            }

            ptrdiff_t block_len = back + 1 + fwd;
            ptrdiff_t block_old_start = oi - back;
            ptrdiff_t block_new_start = j - back;

            // (c) Skip j past forward extension to avoid re-scanning
            if (fwd + 1 > j_advance)
                j_advance = fwd + 1;

            // Accept if lower occurrence threshold, or same threshold but longer
            if (min_occ < best_threshold ||
                (min_occ == best_threshold && block_len > best_len)) {
                best_threshold = min_occ;
                best_old_start = block_old_start;
                best_new_start = block_new_start;
                best_len = block_len;
            }
        }
        j += j_advance;
    }

    // Step 4: If no block found, fall back to Myers (minimal).
    auto inner_old = old_lines.subspan(checked_cast<size_t>(prefix),
                                       checked_cast<size_t>(inner_old_len));
    auto inner_new = new_lines.subspan(checked_cast<size_t>(prefix),
                                       checked_cast<size_t>(inner_new_len));

    if (best_len == 0) {
        auto inner_ops = myers_diff(inner_old, inner_new, DiffAlgorithm::minimal);
        std::vector<EditOp> ops;
        for (ptrdiff_t i = 0; i < prefix; ++i)
            ops.push_back({'E', i, i});
        for (auto &op : inner_ops) {
            if (op.old_idx >= 0) op.old_idx += prefix;
            if (op.new_idx >= 0) op.new_idx += prefix;
            ops.push_back(op);
        }
        for (ptrdiff_t i = 0; i < suffix; ++i)
            ops.push_back({'E', n - suffix + i, m - suffix + i});
        return ops;
    }

    // Step 5: Recurse on regions before and after the matching block.
    std::vector<EditOp> ops;

    // Emit prefix
    for (ptrdiff_t i = 0; i < prefix; ++i)
        ops.push_back({'E', i, i});

    // Region before the block
    if (best_old_start > 0 || best_new_start > 0) {
        auto before_old = old_lines.subspan(checked_cast<size_t>(prefix),
                                            checked_cast<size_t>(best_old_start));
        auto before_new = new_lines.subspan(checked_cast<size_t>(prefix),
                                            checked_cast<size_t>(best_new_start));
        auto before_ops = histogram_diff_impl(before_old, before_new, depth + 1);
        for (auto &op : before_ops) {
            if (op.old_idx >= 0) op.old_idx += prefix;
            if (op.new_idx >= 0) op.new_idx += prefix;
            ops.push_back(op);
        }
    }

    // Emit the matching block as Equal ops
    for (ptrdiff_t k = 0; k < best_len; ++k) {
        ops.push_back({'E', prefix + best_old_start + k,
                            prefix + best_new_start + k});
    }

    // Region after the block
    ptrdiff_t after_old_start = best_old_start + best_len;
    ptrdiff_t after_new_start = best_new_start + best_len;
    ptrdiff_t after_old_len = inner_old_len - after_old_start;
    ptrdiff_t after_new_len = inner_new_len - after_new_start;

    if (after_old_len > 0 || after_new_len > 0) {
        auto after_old = old_lines.subspan(checked_cast<size_t>(prefix + after_old_start),
                                           checked_cast<size_t>(after_old_len));
        auto after_new = new_lines.subspan(checked_cast<size_t>(prefix + after_new_start),
                                           checked_cast<size_t>(after_new_len));
        auto after_ops = histogram_diff_impl(after_old, after_new, depth + 1);
        for (auto &op : after_ops) {
            if (op.old_idx >= 0) op.old_idx += prefix + after_old_start;
            if (op.new_idx >= 0) op.new_idx += prefix + after_new_start;
            ops.push_back(op);
        }
    }

    // Emit suffix
    for (ptrdiff_t i = 0; i < suffix; ++i)
        ops.push_back({'E', n - suffix + i, m - suffix + i});

    return ops;
}

static std::vector<EditOp> histogram_diff(
    std::span<const std::string_view> old_lines,
    std::span<const std::string_view> new_lines)
{
    return histogram_diff_impl(old_lines, new_lines, 0);
}

// A hunk groups consecutive edits with surrounding context lines.
struct Hunk {
    ptrdiff_t old_start;  // 1-based
    ptrdiff_t old_count;
    ptrdiff_t new_start;  // 1-based
    ptrdiff_t new_count;
    std::vector<EditOp> ops;  // the operations in this hunk (including context)
};

static std::vector<Hunk> build_hunks(const std::vector<EditOp> &ops,
                                      ptrdiff_t context_lines)
{
    std::vector<Hunk> hunks;
    if (ops.empty()) return hunks;

    // Find ranges of change (non-Equal) ops
    struct ChangeRange { ptrdiff_t first; ptrdiff_t last; }; // inclusive indices into ops
    std::vector<ChangeRange> changes;
    for (ptrdiff_t i = 0; i < std::ssize(ops); ++i) {
        if (ops[checked_cast<size_t>(i)].type != 'E') {
            if (changes.empty() || i > changes.back().last + 1) {
                changes.push_back({i, i});
            } else {
                changes.back().last = i;
            }
        }
    }

    if (changes.empty()) return hunks;

    // Merge change ranges that overlap when context is added
    std::vector<ChangeRange> merged;
    merged.push_back(changes[0]);
    for (ptrdiff_t i = 1; i < std::ssize(changes); ++i) {
        // If the context windows overlap or are adjacent, merge
        if (changes[checked_cast<size_t>(i)].first - merged.back().last <= 2 * context_lines) {
            merged.back().last = changes[checked_cast<size_t>(i)].last;
        } else {
            merged.push_back(changes[checked_cast<size_t>(i)]);
        }
    }

    // Build hunks from merged ranges
    ptrdiff_t total_ops = std::ssize(ops);
    for (const auto &range : merged) {
        ptrdiff_t hunk_start = std::max(ptrdiff_t{0}, range.first - context_lines);
        ptrdiff_t hunk_end = std::min(total_ops - 1, range.last + context_lines);

        Hunk h;
        h.ops.assign(ops.begin() + hunk_start, ops.begin() + hunk_end + 1);

        // Compute old_start, old_count, new_start, new_count
        h.old_count = 0;
        h.new_count = 0;
        h.old_start = 0;
        h.new_start = 0;
        bool first_old = true, first_new = true;

        for (const auto &op : h.ops) {
            if (op.type == 'E') {
                if (first_old) { h.old_start = op.old_idx + 1; first_old = false; }
                if (first_new) { h.new_start = op.new_idx + 1; first_new = false; }
                h.old_count++;
                h.new_count++;
            } else if (op.type == 'D') {
                if (first_old) { h.old_start = op.old_idx + 1; first_old = false; }
                h.old_count++;
            } else { // 'I'
                if (first_new) { h.new_start = op.new_idx + 1; first_new = false; }
                h.new_count++;
            }
        }

        // If a side has no lines in the hunk (pure insert or pure delete),
        // find the position from the preceding ops in the full ops list.
        if (first_old) {
            // Pure insert: old_start = last old line before insertion point
            for (ptrdiff_t i = hunk_start - 1; i >= 0; --i) {
                auto &prev = ops[checked_cast<size_t>(i)];
                if (prev.old_idx >= 0) {
                    h.old_start = prev.old_idx + 1;  // 1-based
                    break;
                }
            }
        }
        if (first_new) {
            // Pure delete: new_start = last new line before deletion point
            for (ptrdiff_t i = hunk_start - 1; i >= 0; --i) {
                auto &prev = ops[checked_cast<size_t>(i)];
                if (prev.new_idx >= 0) {
                    h.new_start = prev.new_idx + 1;  // 1-based
                    break;
                }
            }
        }

        hunks.push_back(std::move(h));
    }

    return hunks;
}

// Format unified diff output
static std::string format_unified(
    std::span<const std::string_view> old_lines,
    std::span<const std::string_view> new_lines,
    bool old_has_trailing_nl,
    bool new_has_trailing_nl,
    const std::vector<Hunk> &hunks,
    std::string_view old_label,
    std::string_view new_label)
{
    std::string result;

    // File headers
    result += "--- ";
    result += old_label;
    result += '\n';
    result += "+++ ";
    result += new_label;
    result += '\n';

    ptrdiff_t old_total = std::ssize(old_lines);
    ptrdiff_t new_total = std::ssize(new_lines);

    for (const auto &hunk : hunks) {
        // Hunk header: @@ -old_start[,old_count] +new_start[,new_count] @@
        if (hunk.old_count == 1 && hunk.new_count == 1) {
            result += std::format("@@ -{} +{} @@\n",
                                  hunk.old_start, hunk.new_start);
        } else if (hunk.old_count == 1) {
            result += std::format("@@ -{} +{},{} @@\n",
                                  hunk.old_start, hunk.new_start, hunk.new_count);
        } else if (hunk.new_count == 1) {
            result += std::format("@@ -{},{} +{} @@\n",
                                  hunk.old_start, hunk.old_count, hunk.new_start);
        } else {
            result += std::format("@@ -{},{} +{},{} @@\n",
                                  hunk.old_start, hunk.old_count,
                                  hunk.new_start, hunk.new_count);
        }

        // Hunk body
        for (const auto &op : hunk.ops) {
            if (op.type == 'E') {
                bool last_old = (op.old_idx == old_total - 1);
                bool last_new = (op.new_idx == new_total - 1);
                bool old_need_annot = last_old && !old_has_trailing_nl;
                bool new_need_annot = last_new && !new_has_trailing_nl;
                // When the trailing-newline annotation differs between
                // sides, emit as D+I so each gets its own marker.
                if (old_need_annot != new_need_annot) {
                    result += '-';
                    result += old_lines[checked_cast<size_t>(op.old_idx)];
                    result += '\n';
                    if (!old_has_trailing_nl) {
                        result += "\\ No newline at end of file\n";
                    }
                    result += '+';
                    result += new_lines[checked_cast<size_t>(op.new_idx)];
                    result += '\n';
                    if (!new_has_trailing_nl) {
                        result += "\\ No newline at end of file\n";
                    }
                } else {
                    result += ' ';
                    result += old_lines[checked_cast<size_t>(op.old_idx)];
                    result += '\n';
                    if (last_old && !old_has_trailing_nl &&
                        last_new && !new_has_trailing_nl) {
                        result += "\\ No newline at end of file\n";
                    }
                }
            } else if (op.type == 'D') {
                result += '-';
                result += old_lines[checked_cast<size_t>(op.old_idx)];
                result += '\n';
                // Check if this is the last old line with no trailing newline
                if (op.old_idx == old_total - 1 && !old_has_trailing_nl) {
                    result += "\\ No newline at end of file\n";
                }
            } else { // 'I'
                result += '+';
                result += new_lines[checked_cast<size_t>(op.new_idx)];
                result += '\n';
                // Check if this is the last new line with no trailing newline
                if (op.new_idx == new_total - 1 && !new_has_trailing_nl) {
                    result += "\\ No newline at end of file\n";
                }
            }
        }
    }

    return result;
}

// Format context diff output
static std::string format_context(
    std::span<const std::string_view> old_lines,
    std::span<const std::string_view> new_lines,
    bool old_has_trailing_nl,
    bool new_has_trailing_nl,
    const std::vector<Hunk> &hunks,
    std::string_view old_label,
    std::string_view new_label)
{
    std::string result;

    // File headers
    result += "*** ";
    result += old_label;
    result += '\n';
    result += "--- ";
    result += new_label;
    result += '\n';

    ptrdiff_t old_total = std::ssize(old_lines);
    ptrdiff_t new_total = std::ssize(new_lines);

    for (const auto &hunk : hunks) {
        result += "***************\n";

        // Classify each edit group: adjacent D and I runs form "changes" (! prefix)
        // We need to build old-side and new-side lines with proper prefixes.
        struct SideLine { char prefix; std::string_view text; bool no_newline; };
        std::vector<SideLine> old_side, new_side;

        ptrdiff_t num_ops = std::ssize(hunk.ops);
        for (ptrdiff_t k = 0; k < num_ops; ) {
            const auto &op = hunk.ops[checked_cast<size_t>(k)];
            if (op.type == 'E') {
                bool onl = (op.old_idx == old_total - 1 && !old_has_trailing_nl &&
                            op.new_idx == new_total - 1 && !new_has_trailing_nl);
                old_side.push_back({' ', old_lines[checked_cast<size_t>(op.old_idx)], onl});
                new_side.push_back({' ', new_lines[checked_cast<size_t>(op.new_idx)], onl});
                ++k;
            } else {
                // Collect consecutive D then I runs
                ptrdiff_t ds = k;
                while (k < num_ops && hunk.ops[checked_cast<size_t>(k)].type == 'D') ++k;
                ptrdiff_t de = k;  // exclusive
                while (k < num_ops && hunk.ops[checked_cast<size_t>(k)].type == 'I') ++k;
                ptrdiff_t ie = k;  // exclusive

                bool is_change = (de > ds && ie > de);
                for (ptrdiff_t j = ds; j < de; ++j) {
                    auto &dop = hunk.ops[checked_cast<size_t>(j)];
                    bool onl = (dop.old_idx == old_total - 1 && !old_has_trailing_nl);
                    old_side.push_back({is_change ? '!' : '-',
                                       old_lines[checked_cast<size_t>(dop.old_idx)], onl});
                }
                for (ptrdiff_t j = de; j < ie; ++j) {
                    auto &iop = hunk.ops[checked_cast<size_t>(j)];
                    bool onl = (iop.new_idx == new_total - 1 && !new_has_trailing_nl);
                    new_side.push_back({is_change ? '!' : '+',
                                       new_lines[checked_cast<size_t>(iop.new_idx)], onl});
                }
            }
        }

        // Old range header
        ptrdiff_t oe = hunk.old_count == 0 ? hunk.old_start : hunk.old_start + hunk.old_count - 1;
        result += std::format("*** {},{} ****\n", hunk.old_start, oe);

        // Print old-side lines only if there are changes (not just context)
        bool has_old_changes = false;
        for (const auto &sl : old_side) {
            if (sl.prefix != ' ') { has_old_changes = true; break; }
        }
        if (has_old_changes) {
            for (const auto &sl : old_side) {
                result += sl.prefix;
                result += ' ';
                result += sl.text;
                result += '\n';
                if (sl.no_newline) {
                    result += "\\ No newline at end of file\n";
                }
            }
        }

        // New range header
        ptrdiff_t ne = hunk.new_count == 0 ? hunk.new_start : hunk.new_start + hunk.new_count - 1;
        result += std::format("--- {},{} ----\n", hunk.new_start, ne);

        // Print new-side lines only if there are changes
        bool has_new_changes = false;
        for (const auto &sl : new_side) {
            if (sl.prefix != ' ') { has_new_changes = true; break; }
        }
        if (has_new_changes) {
            for (const auto &sl : new_side) {
                result += sl.prefix;
                result += ' ';
                result += sl.text;
                result += '\n';
                if (sl.no_newline) {
                    result += "\\ No newline at end of file\n";
                }
            }
        }
    }

    return result;
}

DiffResult builtin_diff(std::string_view old_path, std::string_view new_path,
                         int context_lines,
                         std::string_view old_label, std::string_view new_label,
                         DiffFormat format,
                         DiffAlgorithm algorithm,
                         std::map<std::string, std::string> *fs)
{
    // Read files — treat /dev/null or non-existent as empty
    std::string old_content, new_content;
    bool old_is_null = (old_path == "/dev/null" || old_path.empty());
    bool new_is_null = (new_path == "/dev/null" || new_path.empty());

    auto fs_exists = [&](std::string_view p) -> bool {
        if (fs) return fs->contains(std::string(p));
        return file_exists(p);
    };
    auto fs_read = [&](std::string_view p) -> std::string {
        if (fs) {
            auto it = fs->find(std::string(p));
            return it != fs->end() ? it->second : std::string{};
        }
        return read_file(p);
    };

    if (!old_is_null && fs_exists(old_path)) {
        old_content = fs_read(old_path);
    }
    if (!new_is_null && fs_exists(new_path)) {
        new_content = fs_read(new_path);
    }

    // Split into lines
    auto old_fl = split_file_lines(old_content);
    auto new_fl = split_file_lines(new_content);

    // Run diff algorithm
    std::vector<EditOp> ops;
    if (algorithm == DiffAlgorithm::patience)
        ops = patience_diff(old_fl.lines, new_fl.lines);
    else if (algorithm == DiffAlgorithm::histogram)
        ops = histogram_diff(old_fl.lines, new_fl.lines);
    else
        ops = myers_diff(old_fl.lines, new_fl.lines, algorithm);

    // Check if there are any differences
    bool has_diff = false;
    for (const auto &op : ops) {
        if (op.type != 'E') { has_diff = true; break; }
    }

    // Also check trailing newline difference
    if (!has_diff && !old_fl.lines.empty() &&
        old_fl.has_trailing_newline != new_fl.has_trailing_newline) {
        has_diff = true;
    }

    if (!has_diff) {
        return {0, ""};
    }

    // When trailing newlines differ the last line must appear as a D+I
    // pair (not a context 'E') so each side gets the right "\ No newline"
    // annotation.  Replace the trailing 'E' with D+I before building hunks
    // so that build_hunks sees a real change and includes it in a hunk.
    if (!old_fl.lines.empty() &&
        old_fl.has_trailing_newline != new_fl.has_trailing_newline) {
        // Find the last 'E' op that covers the final line of both files
        for (ptrdiff_t i = std::ssize(ops) - 1; i >= 0; --i) {
            auto &op = ops[checked_cast<size_t>(i)];
            if (op.type == 'E' &&
                op.old_idx == std::ssize(old_fl.lines) - 1 &&
                op.new_idx == std::ssize(new_fl.lines) - 1) {
                // Replace with D then I
                EditOp d_op{'D', op.old_idx, -1};
                EditOp i_op{'I', -1, op.new_idx};
                ops[checked_cast<size_t>(i)] = d_op;
                ops.insert(ops.begin() + i + 1, i_op);
                break;
            }
            if (op.type == 'E') break;  // only check the last equal op
        }
    }

    // Use labels or default to paths
    std::string old_lbl = old_label.empty() ? std::string(old_path) : std::string(old_label);
    std::string new_lbl = new_label.empty() ? std::string(new_path) : std::string(new_label);

    // Build hunks
    auto hunks = build_hunks(ops, context_lines);

    std::string output;
    if (format == DiffFormat::context) {
        output = format_context(old_fl.lines, new_fl.lines,
                                old_fl.has_trailing_newline,
                                new_fl.has_trailing_newline,
                                hunks, old_lbl, new_lbl);
    } else {
        output = format_unified(old_fl.lines, new_fl.lines,
                                old_fl.has_trailing_newline,
                                new_fl.has_trailing_newline,
                                hunks, old_lbl, new_lbl);
    }

    return {1, std::move(output)};
}
