# Beyond Myers: patience, histogram, and minimal diff explained

Git ships four diff algorithms — `myers`, `minimal`, `patience`, and `histogram` — but only two are truly distinct algorithmic families. Patience and histogram replace Myers' edit-graph search with an anchor-based divide-and-conquer strategy, while minimal is simply Myers with its speed heuristics disabled. Each targets a different trade-off between speed, diff size, and human readability. This report documents all three in detail, assuming familiarity with Myers' O(ND) shortest-edit-script algorithm as described in his 1986 *Algorithmica* paper.

---

## Patience diff anchors on unique lines, not edit distance

Patience diff, designed by **Bram Cohen** (creator of BitTorrent) and first described on his LiveJournal blog in 2008–2010, is not a complete diff algorithm. It is a **matching and decomposition strategy** that identifies high-confidence anchor points between two files, splits the problem at those anchors, and delegates each remaining sub-region to a conventional diff algorithm (typically Myers). James Coglan put it precisely: "patience diff is not a diff algorithm in and of itself. What it really is is a method of matching up lines in two versions of a document in order to break them into smaller pieces, before using an actual diff algorithm like Myers on those pieces."

**The core divergence from Myers** is philosophical. Myers minimizes edit distance — the total count of inserted and deleted lines — treating all lines as interchangeable tokens. Patience diff instead seeks to preserve **structurally meaningful lines** by refusing to match low-information lines (blank lines, closing braces, `return` statements) that appear many times in both files. It only anchors on lines that occur exactly once in each file, which in source code tend to be function signatures, unique comments, and distinctive statements.

### The four-step procedure

Cohen's canonical description from his 2010 blog post gives four steps:

1. **Match common prefix.** Starting from the top, match identical leading lines in both files until a pair differs.
2. **Match common suffix.** Starting from the bottom, match identical trailing lines until a pair differs.
3. **Find unique common lines and compute their LIS.** Within the remaining unmatched interior, identify every line that appears **exactly once in file A** and **exactly once in file B** with identical content. These form a set of candidate match pairs (line_A, line_B). Sort them by position in file A (they already are, given sequential scanning) and compute the **longest increasing subsequence** (LIS) of their positions in file B. The resulting LIS gives a maximal set of non-crossing anchor matches.
4. **Recurse between anchors.** The anchors partition both files into sub-regions. Apply steps 1–4 recursively on each sub-region. Lines that were non-unique globally may become unique within a smaller context. When a sub-region contains **no unique common lines**, fall back to standard Myers diff on that region.

Cohen noted that in practice the recursion in step 4 "rarely if ever finds any more matches, and even when it does it isn't clear whether the extra matches produce a functionally superior diff," so his preferred variant simply applies prefix/suffix matching (steps 1–2) on each section between anchors and outputs the remainder as changed. Git's implementation in `xdiff/xpatience.c` does perform the full recursion.

### The patience sorting connection

The algorithm's name comes from **patience sorting**, the card-game algorithm used in step 3 to compute the LIS. The procedure deals match pairs (treated as cards with their file-B position as the value) into piles, placing each card on the leftmost pile whose top value is ≥ the current card's value, or starting a new pile if none qualifies. Back-pointers between piles allow reconstruction of the actual LIS. The number of piles equals the LIS length. Because pile tops always form a sorted sequence, binary search finds the correct pile in O(log U) time per element, giving **O(U log U)** total for U unique common lines. The mathematical foundation traces to Hammersley (1972), who first recognized that patience sorting computes LIS length, and to Aldous and Diaconis (1999), who published the landmark treatment connecting patience sorting to the Baik–Deift–Johansson theorem.

Coglan makes an important observation: "Although patience diff takes its name from this algorithm for finding the longest increasing subsequence, that's not really the interesting thing about it. Any other method could be used here and it would work about as well. The important thing is that it finds unique matching lines."

### What problem it solves

Cohen's motivating example is a file where functions are reordered. When one function is removed from the end and another added at the beginning, Myers will match `{`, `}`, and blank lines — which appear dozens of times in both files — across completely unrelated functions. Cohen wrote: "There will be a tendency for an LCS based diff algorithm to match up all of the curly brackets instead of the functions… The result is every bit as gross and useless as it sounds, and can easily force a merge conflict in cases which could have been resolved completely cleanly."

His classic `functhreehalves` example illustrates the same problem on a smaller scale. When inserting a new function between `func1()` and `func2()`, Myers produces:

```
 void func1() {
     x += 1
+}
+void functhreehalves() {
+    x += 1.5
 }
 void func2() {
```

This misleadingly detaches `func1`'s closing brace from its body. Patience diff produces the correct output because `}` is non-unique and never becomes an anchor:

```
 void func1() {
     x += 1
 }
+void functhreehalves() {
+    x += 1.5
+}
 void func2() {
```

Cohen also emphasized maintainability: "In principle one could tweak an LCS-based diff to always do the right thing here, but the algorithmic complexity of LCS make implementations of it essentially unmaintainable. That's another advantage of patience diff — it's simple and understandable."

### Complexity and implementation history

**Time complexity** for the patience-specific steps is **O(N log N)** (hashing all lines in O(N), then LIS in O(U log U) where U ≤ N). Each recursion level processes disjoint sub-problems summing to at most N lines. In the worst case — no unique common lines at all — patience immediately falls back to Myers, giving O(ND). **Space complexity** is O(N) for the hash tables and patience-sort stacks, plus whatever the Myers fallback requires for sub-problems.

The algorithm has an intellectual precursor in Paul Heckel's 1978 paper "A technique for isolating differences between files" (*Communications of the ACM*), which also identifies unique lines but uses them to detect moved blocks rather than as LIS anchors. No formal academic paper formalizes patience diff; it exists only in Cohen's blog posts and implementations.

**Bazaar** (bzr) was the first version control system to adopt patience diff as its default, around 2006–2007. A Launchpad bug report from that era shows a bzr developer noting: "Interestingly enough, my patience sorting diff branch handles it without problem… This is a good reason to switch to patience diff." The Python `patiencediff` package on PyPI was extracted from the Bazaar codebase.

**Git** gained patience diff through **Johannes Schindelin**, who submitted a 3-patch series titled "[PATCH 0/3] Teach Git about the patience diff algorithm" in late 2008. His commit message reads: "The patience diff algorithm produces slightly more intuitive output than the classic Myers algorithm, as it does not try to minimize the number of +/- lines first, but tries to preserve the lines that are unique." The implementation lives in `xdiff/xpatience.c` (~374 lines). Usage: `git diff --patience` or `git diff --diff-algorithm=patience`.

---

## Histogram diff extends patience to handle non-unique lines

Histogram diff was created by **Shawn O. Pearce** in 2010 as part of **JGit**, the Java implementation of Git. Pearce — the third most prolific contributor to Git by commit count, creator of Gerrit Code Review and git-gui — designed it as an extension of patience diff that avoids patience's primary weakness: the hard fallback to Myers when no unique lines exist. The copyright header reads `Copyright (C) 2010, Google Inc.` under the Eclipse Distribution License.

Pearce's canonical description, from the JGit `HistogramDiff.java` javadoc, states: "An extended form of Bram Cohen's patience diff algorithm. This implementation was derived by using the 4 rules that are outlined in Bram Cohen's blog, and then was further extended to support low-occurrence common elements." The critical behavioral difference: **"By always selecting a LCS position with the lowest occurrence count, this algorithm behaves exactly like Bram Cohen's patience diff whenever there is a unique common element available between the two sequences. When no unique elements exist, the lowest occurrence element is chosen instead."**

### How the algorithm works step by step

The procedure differs fundamentally from patience diff's LIS-based approach. Instead of finding all unique common lines and computing their longest increasing subsequence, histogram diff builds an occurrence-count index and searches for the single best contiguous matching block to use as a split point.

**Phase 1 — Build the histogram (scanA).** Iterate through all lines of file A (the old file) within the current region. For each line, compute a hash and insert it into a hash table. If the hash matches an existing entry and the lines are actually equal, chain the new position onto the front of that entry and increment its occurrence count. If no match exists, create a new entry with count 1. Crucially, if any hash bucket's chain length reaches **`max_chain_length` (hardcoded to 64)**, the algorithm aborts and falls back to Myers for this region.

**Phase 2 — Scan B to find the best split point (try_lcs).** Initialize a "best so far" threshold at `max_chain_length + 1` (meaning no match yet). For each line in file B, look it up in A's hash table. For each matching record in A whose occurrence count is at or below the current best threshold:

- From the matching position, **extend backwards**: while previous lines in both A and B match, move both pointers back. Track the minimum occurrence count (`rc`) of all lines in the extended region.
- **Extend forwards** symmetrically.
- This yields a maximal contiguous matching block.
- Accept this block as the new best candidate if it is **longer** than the current best, or if its minimum occurrence count `rc` is **lower** than the current best's threshold.

After scanning all of B, the algorithm has identified the **longest contiguous matching region anchored at the lowest-occurrence-count line**. Ray Gardner's 2025 analysis clarifies an important terminological point: despite the JGit javadoc's use of "LCS," this is actually a longest common **contiguous** subsequence (a substring match), not a longest common subsequence in the standard computer-science sense.

**Phase 3 — Recurse (histogram_diff).** If a valid split was found, recursively apply the algorithm to the region before the match and the region after it (the "after" recursion is optimized as tail recursion via `goto redo` in the C implementation). If no valid split was found but common elements exist (all exceeding the chain-length cap), fall back to Myers. If no common elements exist at all, mark the entire region as changed.

### The key improvement over patience

The distinction is sharpest when both files share many lines but none are unique. Consider a region of code where every line — variable assignments, `if` statements, loop constructs — appears at least twice. Patience diff finds no unique anchors and hands the entire region to Myers, losing all the benefits of anchor-based diffing. Histogram diff instead picks the **least common** line (say, one appearing twice rather than twenty times) as its anchor, still producing a structurally meaningful split. Pearce wrote: "This offers more readable diffs than simply falling back on the standard Myers' O(ND) algorithm would produce."

The `max_chain_length = 64` threshold serves as a safety valve. Lines appearing 65 or more times in file A are ignored entirely, preventing the quadratic (or worse) scan that would result from checking every occurrence. Gardner's adversarial testing showed that without this cap, worst-case behavior on artificial data (e.g., repeating `a,b,c` vs. `c,b,a` patterns) is **cubic**, though he notes "real-world data is not likely to be close to this bad."

### Complexity

The JGit javadoc states: "So long as `setMaxChainLength(int)` is a small constant (such as 64), the algorithm runs in **O(N × D)** time, where N is the sum of the input lengths and D is the number of edits in the resulting EditList." In the best case (similar files, small D), this approaches **O(N)** since the histogram build is O(N) and the scan is bounded by the chain-length cap. **Space complexity** is O(N) for the hash table and line-map arrays. A commit by Stefan Beller moved index allocation into `find_lcs` so memory is freed before recursion, preventing blowup on deeply recursive inputs.

In practice, histogram diff is **faster than both Myers and patience** on real repositories. Thomas Rast's performance benchmarks (added to git in commit `8555123`, March 2012) running `git log -p -3000` confirmed: "histogram diff slightly beats Myers, while patience is much slower than the others." The Gerrit Code Review release notes (v2.1.6) stated: "JGit's HistogramDiff implementation tends to run several times faster than the prior Myers O(ND) algorithm."

### Adoption history and real-world usage

Histogram diff was ported from JGit to C git by **Tay Ray Chuan** in commit `8c912eea` (July 12, 2011), released in **Git 1.7.7**. His commit message: "Port JGit's HistogramDiff algorithm over to C. Rough numbers (TODO) show that it is faster than its --patience cousin, as well as the default Meyers algorithm. The implementation has been reworked to use structs and pointers, instead of bitmasks, thus doing away with JGit's 2^28 line limit." The implementation lives in `xdiff/xhistogram.c` (~370 lines).

**JGit uses histogram as its default** merge algorithm (`MergeAlgorithm` defaults to `new HistogramDiff()`), and **Gerrit Code Review** uses it by default for all diff computations. **Git's merge-ort strategy** (the newer merge backend by Elijah Newren) explicitly selects histogram diff internally; Newren's commit notes: "I have some ideas for using a histogram diff to improve content merges… For now, just set it to histogram."

Nugroho et al.'s 2019 empirical study in *Empirical Software Engineering* ("How Different Are Different diff Algorithms in Git?") compared Myers and histogram across 14 open-source Java projects and found that **1.7% to 8.2%** of commits produced different code-churn metrics depending on the algorithm. Their recommendation: "We strongly recommend using the Histogram algorithm when mining Git repositories to consider differences in source code."

Usage: `git diff --histogram` or `git diff --diff-algorithm=histogram` or `git config --global diff.algorithm histogram`.

---

## Minimal is Myers without the speed heuristics

The `--minimal` flag is **not a separate algorithm**. It is the single bit flag `XDF_NEED_MINIMAL` (bit 0 in `xdiff/xdiff.h`) that forces git's Myers implementation to find the **true shortest edit script** by disabling two heuristic shortcuts that the default Myers mode uses for speed. Despite appearing as a peer alongside `patience` and `histogram` in `--diff-algorithm={myers|minimal|patience|histogram}`, both `myers` and `minimal` follow the identical code path in `xdl_do_diff()` — the dispatch in `xdiff/xdiffi.c` only branches for patience and histogram, with Myers and minimal falling through to the same implementation.

### What the default Myers heuristics do

Git's Myers implementation uses the linear-space divide-and-conquer variant from Section 4.2 of Myers' 1986 paper: simultaneous forward and backward traversal of the edit graph to find the "middle snake," then recursing on each half. The core function `xdl_split()` in `xdiff/xdiffi.c` (from Davide Libenzi's libxdiff, integrated into git in March 2006) contains this comment: "We might encounter expensive edge cases using this algorithm, so a little bit of heuristic is needed to cut the search and to return a suboptimal point."

Two heuristics can cause `xdl_split()` to return a **suboptimal** split point, producing a non-minimal diff. Both are bypassed by a single line of code:

```c
if (need_min)
    continue;
```

This `continue` skips all heuristic early-termination logic and forces the edit-cost loop to iterate until the forward and backward paths genuinely cross on the same diagonal — the true middle snake.

**Heuristic 1: The snake heuristic** fires when two conditions are met: the current edit cost `ec` exceeds **`XDL_HEUR_MIN_COST` (256)**, and during this iteration a "snake" (consecutive run of matching lines on a single diagonal) of length ≥ **`XDL_SNAKE_CNT` (20)** was found. When triggered, the algorithm samples current diagonals to find "interesting" paths — those where progress (measured as `i1 + i2`, penalized by distance from the mid-diagonal) exceeds **`XDL_K_HEUR` × ec** (4 times the current edit cost). If such a path exists and ends in a sufficiently long snake, it is returned as the split point immediately, even if a more optimal split exists further along.

**Heuristic 2: The cost heuristic** fires when `ec ≥ mxcost`, where `mxcost` is computed as `xdl_bogosqrt(ndiags)` (an approximate integer square root, specifically the next power of 2 above √N) with a minimum of **`XDL_MAX_COST_MIN` (256)**. The source comment reads: "Enough is enough. We spent too much time here and now we collect the furthest reaching path using the (i1 + i2) measure." The algorithm simply picks whichever forward or backward diagonal has made the most total progress and returns that as the split point — regardless of optimality.

Both heuristics propagate their minimality constraints through the recursive structure via `min_lo` and `min_hi` flags in the `xdpsplit_t` structure. When the true middle snake is found, both halves inherit `min_lo = min_hi = 1`. When a heuristic fires, only the half that was exhaustively searched inherits the minimality requirement; the other half is "relaxed."

### Complexity implications

| Mode | Time complexity | Practical bound |
|------|----------------|-----------------|
| `--minimal` (full Myers) | O(ND) | O(N²) when D ≈ N |
| Default Myers (heuristics) | ~O(N√N) | Capped by mxcost ≈ √N |

The cost heuristic limits each `xdl_split()` invocation to ~√N iterations, bounding total work to roughly **O(N√N)**. GNU diff's documentation states its equivalent heuristic (by Paul Eggert) limits cost to "O(N^1.5 log N) at the price of producing suboptimal output for large inputs with many differences." With `--minimal`, there is no upper bound on iterations per split — worst case is O(N²) for completely different files.

### When does output actually differ?

The heuristics only fire for **large, heavily changed files**. The snake heuristic requires at least 256 edits and a 20-line matching run; the cost heuristic requires edit cost to reach √N (minimum 256). For typical code changes with small edit distances, or files under ~500 lines with moderate changes, **the output is identical between `myers` and `minimal`**. Differences emerge with large configuration files or data files with many scattered single-line changes, significant file restructurings, or very large source files with widespread refactoring. One analysis found that on large Wikipedia article diffs, Myers produced 7990+/4463- while minimal produced 7712+/4185- — a measurably smaller diff, at the cost of significantly more computation time.

### Heritage from GNU diff

Git's `--minimal` directly parallels GNU diff's `--minimal` (`-d`) flag. The GNU Diffutils manual states: "The way that GNU diff determines which lines have changed always comes up with a near-minimal set of differences. Usually it is good enough for practical purposes. If the diff output is large, you might want diff to use a modified algorithm that sometimes produces a smaller set of differences. The `--minimal` (`-d`) option does this; however, it can also cause diff to run more slowly than usual, so it is not the default behavior." GNU diff's `analyze.c` uses a `TOO_EXPENSIVE` threshold with a `SNAKE_LIMIT` constant — conceptually identical to git's `mxcost` and `XDL_SNAKE_CNT`, with the heuristic attributed to Paul Eggert.

---

## How the three relate to each other and to Myers

The four algorithms form a clear taxonomy. Myers and minimal are the same algorithm with different termination conditions: Myers trades optimality for speed via the cost and snake heuristics, while minimal guarantees the true shortest edit script. Patience and histogram belong to a different family entirely — they decompose the problem using structural anchors before invoking Myers on residual sub-regions.

Patience and histogram differ in their anchor-selection strategy. Patience requires strict uniqueness (count = 1 in both files), computes a global LIS over all unique matches, and produces multiple non-crossing anchors in a single pass. Histogram relaxes the uniqueness requirement, accepts the lowest-occurrence line, finds the longest contiguous block around it, and splits on that single block before recursing. When unique lines exist, histogram behaves identically to patience. When they don't, histogram continues finding structural anchors where patience would surrender to Myers.

The quality trade-offs are nuanced. Patience and histogram generally produce more **human-readable** diffs for code, especially when functions are reordered or boilerplate lines dominate. Minimal produces the **smallest** diffs by line count but doesn't consider readability — it may still match braces across unrelated functions if doing so yields fewer total edits. Default Myers is fast and usually near-optimal, but can produce both larger and less readable diffs on pathological inputs.

Mercurial's decision to **remove** patience and histogram in 2018 (Phabricator D2573) offers a counterpoint. Developer Jun Wu argued that the indent heuristic (which adjusts hunk boundaries to avoid splitting at blank or whitespace-only lines) is "a more scientific way" to improve diff readability, and that patience introduces "greediness (i.e. incorrectness)" — it can produce larger diffs than Myers because it refuses to match non-unique lines that would reduce edit distance.

## Conclusion

These three algorithms represent distinct strategies for the same fundamental tension in diff computation. **Minimal** answers "what if we just let Myers run to completion?" — it is the theoretically pure form of Myers' 1986 algorithm, with git's heuristic shortcuts (the snake heuristic at ec > 256 and the cost cap at √N) removed, guaranteeing the shortest edit script at the expense of potentially quadratic runtime on large, heavily-changed files. **Patience** answers "what if we anchor on semantically meaningful lines?" — by restricting matches to lines unique in both files and computing their LIS via patience sorting, it avoids the brace-matching pathology that plagues Myers on code diffs. **Histogram** answers "what if patience didn't give up so easily?" — by extending patience's uniqueness requirement to a lowest-occurrence-count preference with a contiguous-block search, it maintains structural diffing even in regions with no unique lines, while running slightly faster than Myers in practice due to efficient hash-based decomposition. For most users working with source code, histogram offers the best combination of speed, diff quality, and robustness — which is why JGit, Gerrit, and git's merge-ort strategy all default to it.