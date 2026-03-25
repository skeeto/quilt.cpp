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
    target_link_options(quilt PRIVATE -static -municode)
    target_link_libraries(quilt PRIVATE shell32)
endif()

# Amalgamation: single-file Windows build
# Build explicitly with: cmake --build <dir> --target amalgam
set(AMALGAM_SOURCES
    src/quilt.hpp src/platform.hpp
    src/core.cpp src/cmd_stack.cpp src/cmd_patch.cpp
    src/cmd_manage.cpp src/cmd_stubs.cpp src/platform_win32.cpp
)
add_custom_command(
    OUTPUT ${CMAKE_BINARY_DIR}/quilt.cpp
    COMMAND sh ${CMAKE_SOURCE_DIR}/cmake/make_amalgam.sh
            ${CMAKE_SOURCE_DIR}
            ${CMAKE_BINARY_DIR}/quilt.cpp
    DEPENDS ${AMALGAM_SOURCES} cmake/make_amalgam.sh
    COMMENT "Generating quilt.cpp amalgamation"
    VERBATIM
)
add_custom_target(amalgam DEPENDS ${CMAKE_BINARY_DIR}/quilt.cpp)

# Testing
enable_testing()
add_test(
    NAME quilt_build
    COMMAND ${CMAKE_COMMAND} --build . --target quilt
    WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
)
set_tests_properties(quilt_build PROPERTIES FIXTURES_SETUP quilt_binary)

add_test(
    NAME quilt_tests
    COMMAND sh ${CMAKE_CURRENT_SOURCE_DIR}/test/test.sh $<TARGET_FILE:quilt>
    WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
)
set_tests_properties(quilt_tests PROPERTIES FIXTURES_REQUIRED quilt_binary)
