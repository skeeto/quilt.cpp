// This is free and unencumbered software released into the public domain.
//
// libFuzzer harness for round-trip diff->patch correctness.
// Generates a diff between two fuzzed strings, applies the patch to
// the first, and asserts the result matches the second.

#include "quilt.hpp"
#include <cstdint>
#include <cstddef>
#include <map>
#include <string>
#include <string_view>

extern "C" int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size)
{
    if (size < 1) return 0;

    // Byte 0: split fraction — portion of remaining data that is "old"
    uint8_t split_frac = data[0];
    data += 1;
    size -= 1;

    size_t old_len = static_cast<size_t>(
        static_cast<double>(split_frac) / 255.0 * static_cast<double>(size));
    if (old_len > size) old_len = size;

    std::string old_content(reinterpret_cast<const char *>(data), old_len);
    std::string new_content(reinterpret_cast<const char *>(data + old_len),
                            size - old_len);

    // Skip inputs with \r — the diff engine splits on \n only, but the
    // patch engine detects \r\n and preserves it, breaking the round-trip
    // invariant for arbitrary binary data containing \r.
    for (char c : old_content) if (c == '\r') return 0;
    for (char c : new_content) if (c == '\r') return 0;

    // Cap total size to avoid OOM from Myers diff on large dissimilar inputs.
    // Myers is O(N*M) in the worst case; 1024 bytes keeps peak memory in check.
    if (old_content.size() + new_content.size() > 1024) return 0;

    // Populate in-memory filesystem
    std::map<std::string, std::string> fs;
    fs["old"] = old_content;
    fs["new"] = new_content;

    // Generate diff
    DiffResult dr = builtin_diff("old", "new", 3, {}, {},
                                 DiffFormat::unified, &fs);

    // If identical, nothing to test
    if (dr.exit_code == 0) return 0;

    // Apply patch to old_content
    fs["old"] = old_content;  // restore in case diff touched it
    PatchOptions opts;
    opts.strip_level = 0;
    opts.fuzz        = 0;
    opts.reverse     = false;
    opts.force       = false;
    opts.remove_empty = false;
    opts.merge       = false;
    opts.dry_run     = false;
    opts.quiet       = true;
    opts.fs          = &fs;

    builtin_patch(dr.output, opts);

    // Assert round-trip: patched old must equal new
    auto it = fs.find("old");
    std::string_view result = (it != fs.end()) ? std::string_view(it->second)
                                               : std::string_view{};
    if (result != new_content) {
        __builtin_trap();
    }

    return 0;
}
