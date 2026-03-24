cmake_minimum_required(VERSION 3.16)
project(quilt LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

# Core sources (platform-agnostic)
set(CORE_SOURCES
    src/core.cpp
    src/cmd_stack.cpp
    src/cmd_patch.cpp
    src/cmd_manage.cpp
    src/cmd_stubs.cpp
)

# Platform selection — link exactly one platform source
if(WIN32)
    list(APPEND CORE_SOURCES src/platform_win32.cpp)
else()
    list(APPEND CORE_SOURCES src/platform_posix.cpp)
endif()

add_executable(quilt ${CORE_SOURCES})
target_include_directories(quilt PRIVATE src)

# Precompiled header
target_precompile_headers(quilt PRIVATE src/quilt.hpp)

# Warnings
target_compile_options(quilt PRIVATE
    $<$<CXX_COMPILER_ID:GNU,Clang,AppleClang>:-Wall -Wextra>
)

# Static link on Windows (mingw-w64) so the .exe is self-contained
if(WIN32 AND CMAKE_CXX_COMPILER_ID STREQUAL "GNU")
    target_link_options(quilt PRIVATE -static)
    target_link_libraries(quilt PRIVATE shell32)
endif()

# Testing
enable_testing()
add_test(
    NAME quilt_tests
    COMMAND bash ${CMAKE_CURRENT_SOURCE_DIR}/test/test.sh $<TARGET_FILE:quilt>
    WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
)
