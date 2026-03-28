# Sanitizer support via compiler feature detection.
# Include after the target is defined, then call:
#   target_sanitizers(<target>)

include(CheckCXXCompilerFlag)
include(CheckCXXSourceCompiles)

function(target_sanitizers target)
    # ASan
    set(CMAKE_REQUIRED_LINK_OPTIONS "-fsanitize=address")
    check_cxx_compiler_flag(-fsanitize=address HAS_SANITIZE_ADDRESS)
    unset(CMAKE_REQUIRED_LINK_OPTIONS)
    if(HAS_SANITIZE_ADDRESS)
        target_compile_options(${target} PRIVATE
            $<$<CONFIG:Debug>:-fsanitize=address>)
        target_link_options(${target} PRIVATE
            $<$<CONFIG:Debug>:-fsanitize=address>)
    endif()

    # UBSan: prefer full runtime, fall back to trap-only
    set(CMAKE_REQUIRED_LINK_OPTIONS "-fsanitize=undefined")
    check_cxx_compiler_flag(-fsanitize=undefined HAS_SANITIZE_UNDEFINED)
    unset(CMAKE_REQUIRED_LINK_OPTIONS)
    if(HAS_SANITIZE_UNDEFINED)
        target_compile_options(${target} PRIVATE
            $<$<CONFIG:Debug>:-fsanitize=undefined>)
        target_link_options(${target} PRIVATE
            $<$<CONFIG:Debug>:-fsanitize=undefined>)
    else()
        set(CMAKE_REQUIRED_FLAGS "-fsanitize=undefined -fsanitize-trap")
        check_cxx_source_compiles("int main() {}" HAS_SANITIZE_UNDEFINED_TRAP)
        unset(CMAKE_REQUIRED_FLAGS)
        if(HAS_SANITIZE_UNDEFINED_TRAP)
            target_compile_options(${target} PRIVATE
                $<$<CONFIG:Debug>:-fsanitize=undefined -fsanitize-trap>)
        endif()
    endif()
endfunction()
