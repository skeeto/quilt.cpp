// This is free and unencumbered software released into the public domain.
//
// libFuzzer harness for shell_split().
// Exercises the shell-like argument splitter used for QUILT_*_ARGS
// environment variables: single/double quoting, backslash escapes,
// and $VAR/${VAR} expansion.

#include "quilt.hpp"
#include <cstdint>
#include <cstddef>
#include <string_view>

extern "C" int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size)
{
    std::string_view input(reinterpret_cast<const char *>(data), size);
    shell_split(input);
    return 0;
}
