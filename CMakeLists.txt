cmake_minimum_required(VERSION 3.16)
project(quilt VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

set(CORE_SOURCES
    src/core.cpp
    src/diff.cpp
    src/patch.cpp
    src/cmd_stack.cpp
    src/cmd_annotate.cpp
    src/cmd_patch.cpp
    src/cmd_manage.cpp
    src/cmd_graph.cpp
    src/cmd_mail.cpp
    src/cmd_stubs.cpp
)

if(WIN32)
    list(APPEND CORE_SOURCES src/platform_win32.cpp)
else()
    list(APPEND CORE_SOURCES src/platform_posix.cpp)
endif()

add_executable(quilt ${CORE_SOURCES})
target_include_directories(quilt PRIVATE src)

target_precompile_headers(quilt PRIVATE src/quilt.hpp)

target_compile_definitions(quilt PRIVATE
    QUILT_VERSION="${PROJECT_VERSION}"
)

target_compile_options(quilt PRIVATE
    $<$<CXX_COMPILER_ID:GNU,Clang,AppleClang>:-Wall -Wextra -Wconversion>
)

option(ENABLE_COVERAGE "Build with gcov code-coverage instrumentation" OFF)

include(cmake/sanitizers.cmake)
if(NOT ENABLE_COVERAGE)
    target_sanitizers(quilt)
endif()

include(cmake/coverage.cmake)
if(ENABLE_COVERAGE)
    target_coverage(quilt)
endif()

include(CheckCXXSourceCompiles)
check_cxx_source_compiles("
    #include <cstddef>
    #if !defined(__GLIBCXX__)
    #error not libstdc++
    #endif
    int main() {}
" USING_LIBSTDCXX)

if(USING_LIBSTDCXX AND NOT ENABLE_COVERAGE)
    target_compile_definitions(quilt PRIVATE
        $<$<CONFIG:Debug>:_GLIBCXX_DEBUG>
    )
endif()

if(WIN32 AND CMAKE_CXX_COMPILER_ID STREQUAL "GNU")
    target_link_libraries(quilt PRIVATE shell32)
endif()

# Amalgamation: single-file Windows build
# $ cmake --build <dir> --target amalgam
set(AMALGAM_SOURCES
    src/quilt.hpp src/platform.hpp
    src/core.cpp src/diff.cpp src/patch.cpp src/cmd_stack.cpp src/cmd_annotate.cpp src/cmd_patch.cpp
    src/cmd_manage.cpp src/cmd_graph.cpp src/cmd_mail.cpp
    src/cmd_stubs.cpp src/platform_win32.cpp
)
add_custom_command(
    OUTPUT ${CMAKE_BINARY_DIR}/quilt.cpp
    COMMAND sh ${CMAKE_SOURCE_DIR}/cmake/make_amalgam.sh
            ${CMAKE_SOURCE_DIR}
            ${CMAKE_BINARY_DIR}/quilt.cpp
            ${PROJECT_VERSION}
            ${AMALGAM_SOURCES}
    DEPENDS ${AMALGAM_SOURCES} cmake/make_amalgam.sh
    COMMENT "Generating quilt.cpp amalgamation"
    VERBATIM
)
add_custom_target(amalgam DEPENDS ${CMAKE_BINARY_DIR}/quilt.cpp)

# Fuzz targets (requires clang with libFuzzer support)
option(ENABLE_FUZZ "Build fuzz testing targets" OFF)
if(ENABLE_FUZZ)
    set(FUZZ_SOURCES
        src/core.cpp
        src/diff.cpp
        src/patch.cpp
        src/cmd_stack.cpp
        src/cmd_annotate.cpp
        src/cmd_patch.cpp
        src/cmd_manage.cpp
        src/cmd_graph.cpp
        src/cmd_mail.cpp
        src/cmd_stubs.cpp
        src/platform_posix.cpp
    )

    add_executable(fuzz_patch fuzz/fuzz_patch.cpp ${FUZZ_SOURCES})
    target_include_directories(fuzz_patch PRIVATE src)
    target_precompile_headers(fuzz_patch PRIVATE src/quilt.hpp)
    target_compile_definitions(fuzz_patch PRIVATE
        FUZZING_BUILD_MODE_UNSAFE_FOR_PRODUCTION
        QUILT_VERSION="${PROJECT_VERSION}")
    target_compile_options(fuzz_patch PRIVATE
        -fsanitize=fuzzer,address,undefined)
    target_link_options(fuzz_patch PRIVATE
        -fsanitize=fuzzer,address,undefined)

    add_executable(fuzz_shell_split fuzz/fuzz_shell_split.cpp ${FUZZ_SOURCES})
    target_include_directories(fuzz_shell_split PRIVATE src)
    target_precompile_headers(fuzz_shell_split PRIVATE src/quilt.hpp)
    target_compile_definitions(fuzz_shell_split PRIVATE
        FUZZING_BUILD_MODE_UNSAFE_FOR_PRODUCTION
        QUILT_VERSION="${PROJECT_VERSION}")
    target_compile_options(fuzz_shell_split PRIVATE
        -fsanitize=fuzzer,address,undefined)
    target_link_options(fuzz_shell_split PRIVATE
        -fsanitize=fuzzer,address,undefined)

    add_executable(fuzz_roundtrip fuzz/fuzz_roundtrip.cpp ${FUZZ_SOURCES})
    target_include_directories(fuzz_roundtrip PRIVATE src)
    target_precompile_headers(fuzz_roundtrip PRIVATE src/quilt.hpp)
    target_compile_definitions(fuzz_roundtrip PRIVATE
        FUZZING_BUILD_MODE_UNSAFE_FOR_PRODUCTION
        QUILT_VERSION="${PROJECT_VERSION}")
    target_compile_options(fuzz_roundtrip PRIVATE
        -fsanitize=fuzzer,address,undefined)
    target_link_options(fuzz_roundtrip PRIVATE
        -fsanitize=fuzzer,address,undefined)

    add_executable(fuzz_roundtrip_fuzz fuzz/fuzz_roundtrip_fuzz.cpp ${FUZZ_SOURCES})
    target_include_directories(fuzz_roundtrip_fuzz PRIVATE src)
    target_precompile_headers(fuzz_roundtrip_fuzz PRIVATE src/quilt.hpp)
    target_compile_definitions(fuzz_roundtrip_fuzz PRIVATE
        FUZZING_BUILD_MODE_UNSAFE_FOR_PRODUCTION
        QUILT_VERSION="${PROJECT_VERSION}")
    target_compile_options(fuzz_roundtrip_fuzz PRIVATE
        -fsanitize=fuzzer,address,undefined)
    target_link_options(fuzz_roundtrip_fuzz PRIVATE
        -fsanitize=fuzzer,address,undefined)

    # Differential fuzzer — standalone binary, no sanitizers needed.
    # Compares quilt.cpp against system quilt via fork/exec.
    add_executable(fuzz_differential fuzz/fuzz_differential.cpp)
    target_compile_features(fuzz_differential PRIVATE cxx_std_20)
endif()

enable_testing()
set(QUILT_TEST_EXECUTABLE "" CACHE STRING
    "Path or command name for the quilt executable used by CTest."
)

include(${CMAKE_CURRENT_SOURCE_DIR}/test/Scenarios.cmake)

if(QUILT_TEST_EXECUTABLE STREQUAL "")
    set(quilt_test_command "$<TARGET_FILE:quilt>")
    set(quilt_test_requires_fixture TRUE)
    add_test(
        NAME quilt_build
        COMMAND ${CMAKE_COMMAND} --build . --target quilt
        WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
    )
    set_tests_properties(quilt_build PROPERTIES FIXTURES_SETUP quilt_binary)
else()
    set(quilt_test_command "${QUILT_TEST_EXECUTABLE}")
    set(quilt_test_requires_fixture FALSE)
endif()

set(all_scenarios ${QUILT_TEST_SCENARIOS})
if(QUILT_TEST_EXECUTABLE STREQUAL "")
    list(APPEND all_scenarios ${QUILT_TEST_SCENARIOS_NATIVE})
endif()

foreach(scenario IN LISTS all_scenarios)
    add_test(
        NAME quilt_${scenario}
        COMMAND ${CMAKE_COMMAND}
            -DSCENARIO=${scenario}
            -DQUILT_TEST_SOURCE_DIR=${CMAKE_CURRENT_SOURCE_DIR}
            -DQUILT_TEST_BINARY_DIR=${CMAKE_CURRENT_BINARY_DIR}
            -DQUILT_TEST_EXECUTABLE=${quilt_test_command}
            -P ${CMAKE_CURRENT_SOURCE_DIR}/test/RunScenario.cmake
        WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
    )
    if(quilt_test_requires_fixture)
        set_tests_properties(
            quilt_${scenario} PROPERTIES FIXTURES_REQUIRED quilt_binary
        )
    endif()
endforeach()
