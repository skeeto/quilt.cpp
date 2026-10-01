// This is free and unencumbered software released into the public domain.
//
// libFuzzer harness for round-trip diff->patch correctness.
// Generates a diff between two fuzzed strings with every diff algorithm
// in both unified and context format, applies each patch to the first
// string, and asserts the result matches the second.

#include "quilt.hpp"
#include <cstdint>
#include <cstddef>
#include <cstdio>
#include <cstdlib>
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

    static constexpr struct { DiffAlgorithm algorithm; const char *name; }
    algorithms[] = {
        {DiffAlgorithm::myers,     "myers"},
        {DiffAlgorithm::minimal,   "minimal"},
        {DiffAlgorithm::patience,  "patience"},
        {DiffAlgorithm::histogram, "histogram"},
    };
    static constexpr struct { DiffFormat format; const char *name; }
    formats[] = {
        {DiffFormat::unified, "unified"},
        {DiffFormat::context, "context"},
    };

    for (auto [algorithm, algorithm_name] : algorithms) {
        for (auto [format, format_name] : formats) {
            std::map<std::string, std::string> fs;
            fs["old"] = old_content;
            fs["new"] = new_content;

            // Label both sides with the same name so the patch engine
            // targets one file regardless of its old/new name heuristic.
            DiffResult dr = builtin_diff("old", "new", 3, "a/file", "b/file",
                                         format, algorithm, &fs);

            // If identical, nothing to test
            if (dr.exit_code == 0) return 0;

            fs.clear();
            fs["file"] = old_content;
            PatchOptions opts;
            opts.strip_level = 1;
            opts.fuzz        = 0;
            opts.quiet       = true;
            opts.fs          = &fs;

            PatchResult pr = builtin_patch(dr.output, opts);

            // Assert round-trip: patched old must equal new
            auto it = fs.find("file");
            if (pr.exit_code != 0 || it == fs.end() ||
                it->second != new_content) {
                std::fprintf(stderr,
                             "round-trip failed: algorithm=%s format=%s "
                             "patch exit=%d\n%s%s%s",
                             algorithm_name, format_name, pr.exit_code,
                             dr.output.c_str(), pr.out.c_str(),
                             pr.err.c_str());
                std::abort();
            }
        }
    }

    return 0;
}
