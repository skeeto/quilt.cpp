// This is free and unencumbered software released into the public domain.
//
// libFuzzer harness for the built-in patch engine.
// Exercises parsing, hunk matching, output building, merge markers,
// and reject generation without touching the real filesystem.

#include "quilt.hpp"
#include <cstdint>
#include <cstddef>
#include <map>
#include <string>
#include <string_view>

extern "C" int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size)
{
    if (size < 2) return 0;

    // Byte 0: split fraction — what portion of remaining data is file content
    // Byte 1: option bits
    uint8_t split_frac = data[0];
    uint8_t opt_bits   = data[1];
    data += 2;
    size -= 2;

    // Split remaining data into file content and patch text
    size_t file_len = static_cast<size_t>(
        static_cast<double>(split_frac) / 255.0 * static_cast<double>(size));
    if (file_len > size) file_len = size;

    std::string file_content(reinterpret_cast<const char *>(data), file_len);
    std::string patch_text(reinterpret_cast<const char *>(data + file_len),
                           size - file_len);

    // Populate in-memory filesystem
    std::map<std::string, std::string> fs;
    fs["file.c"] = std::move(file_content);

    // Decode options from opt_bits
    PatchOptions opts;
    opts.strip_level  = (opt_bits & 0x01) ? 0 : 1;
    opts.fuzz         = (opt_bits >> 1) & 0x03;       // 0-3
    opts.reverse      = (opt_bits & 0x08) != 0;
    opts.force        = (opt_bits & 0x10) != 0;
    opts.remove_empty = (opt_bits & 0x20) != 0;
    opts.merge        = (opt_bits & 0x40) != 0;
    if (opt_bits & 0x80) opts.merge_style = "diff3";
    opts.dry_run      = false;
    opts.quiet        = true;
    opts.fs           = &fs;

    builtin_patch(patch_text, opts);

    return 0;
}
