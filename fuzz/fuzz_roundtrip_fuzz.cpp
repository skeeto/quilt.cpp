// This is free and unencumbered software released into the public domain.
//
// libFuzzer harness for fuzz-matching code paths in builtin_patch.
// Generates a valid unified diff between two strings, mutates the
// "old" content to simulate source drift, then applies the patch with
// fuzz > 0.  No correctness assertion — just checking for crashes in
// the offset-search and context-trimming logic.

#include "quilt.hpp"
#include <cstdint>
#include <cstddef>
#include <map>
#include <string>
#include <string_view>

extern "C" int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size)
{
    if (size < 2) return 0;

    // Byte 0: bits 0-1 = fuzz level (1-3), bits 2-7 = old/new split fraction
    uint8_t hdr = data[0];
    int fuzz_level = (hdr & 3) + 1;            // 1, 2, or 3
    uint8_t split_frac = hdr >> 2;             // 6 bits → 0-63

    // Byte 1: mutation/content split fraction — what portion of remaining
    // data is content (old+new) vs mutation instructions
    uint8_t mut_frac = data[1];
    data += 2;
    size -= 2;

    size_t content_len = static_cast<size_t>(
        static_cast<double>(mut_frac) / 255.0 * static_cast<double>(size));
    if (content_len > size) content_len = size;
    size_t mut_len = size - content_len;

    const uint8_t *content = data;
    const uint8_t *mutations = data + content_len;

    // Split content into old + new
    size_t old_len = static_cast<size_t>(
        static_cast<double>(split_frac) / 63.0 * static_cast<double>(content_len));
    if (old_len > content_len) old_len = content_len;

    std::string old_content(reinterpret_cast<const char *>(content), old_len);
    std::string new_content(reinterpret_cast<const char *>(content + old_len),
                            content_len - old_len);

    // Skip \r (diff/patch line-ending disagreement)
    for (char c : old_content) if (c == '\r') return 0;
    for (char c : new_content) if (c == '\r') return 0;

    // Cap size to avoid Myers OOM
    if (old_content.size() + new_content.size() > 1024) return 0;

    // Generate diff from original old → new
    std::map<std::string, std::string> fs;
    fs["old"] = old_content;
    fs["new"] = new_content;

    DiffResult dr = builtin_diff("old", "new", 3, {}, {},
                                 DiffFormat::unified, &fs);
    if (dr.exit_code == 0) return 0;

    // Mutate old content to simulate source drift.  Each mutation byte
    // selects a position in old to XOR, spreading changes across the file.
    std::string mutated = old_content;
    if (!mutated.empty()) {
        for (size_t i = 0; i < mut_len; ++i) {
            size_t pos = mutations[i] % mutated.size();
            mutated[pos] ^= static_cast<char>(i + 1);
        }
        // Ensure no \r was introduced by mutation
        for (char &c : mutated) if (c == '\r') c = 'X';
    }

    // Apply patch to mutated old with fuzz matching
    fs["old"] = mutated;
    PatchOptions opts;
    opts.strip_level  = 0;
    opts.fuzz         = fuzz_level;
    opts.reverse      = false;
    opts.force        = true;   // keep going even if hunks fail
    opts.remove_empty = false;
    opts.merge        = false;
    opts.dry_run      = false;
    opts.quiet        = true;
    opts.fs           = &fs;

    builtin_patch(dr.output, opts);

    // No assertion — the value is exercising fuzz matching, offset search,
    // and context trimming on well-formed patches without crashing.
    return 0;
}
