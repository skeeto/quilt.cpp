cmake_minimum_required(VERSION 3.16)

if(NOT DEFINED SCENARIO OR SCENARIO STREQUAL "")
    message(FATAL_ERROR "SCENARIO is required")
endif()

if(NOT DEFINED QUILT_TEST_SOURCE_DIR OR QUILT_TEST_SOURCE_DIR STREQUAL "")
    message(FATAL_ERROR "QUILT_TEST_SOURCE_DIR is required")
endif()

if(NOT DEFINED QUILT_TEST_BINARY_DIR OR QUILT_TEST_BINARY_DIR STREQUAL "")
    message(FATAL_ERROR "QUILT_TEST_BINARY_DIR is required")
endif()

include("${QUILT_TEST_SOURCE_DIR}/test/TestHarness.cmake")
include("${QUILT_TEST_SOURCE_DIR}/test/Scenarios.cmake")

qt_run_named_scenario("${SCENARIO}")
