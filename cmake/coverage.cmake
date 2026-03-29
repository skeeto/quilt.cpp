# Coverage instrumentation via compiler feature detection.
# Include after the target is defined, then call:
#   target_coverage(<target>)

include(CheckCXXCompilerFlag)

function(target_coverage target)
    set(CMAKE_REQUIRED_LINK_OPTIONS "--coverage")
    check_cxx_compiler_flag(--coverage HAS_COVERAGE)
    unset(CMAKE_REQUIRED_LINK_OPTIONS)
    if(HAS_COVERAGE)
        target_compile_options(${target} PRIVATE --coverage)
        target_link_options(${target} PRIVATE --coverage)
    else()
        message(WARNING "Compiler does not support --coverage; ENABLE_COVERAGE has no effect")
    endif()
endfunction()
