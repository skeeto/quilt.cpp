// This is free and unencumbered software released into the public domain.
#pragma once
#include <string>
#include <string_view>
#include <vector>
#include <cstdint>

// Process execution
struct ProcessResult {
    int  exit_code;
    std::string out;
    std::string err;
};

ProcessResult run_cmd(const std::vector<std::string> &argv);
ProcessResult run_cmd_input(const std::vector<std::string> &argv,
                            std::string_view stdin_data);
int run_cmd_tty(const std::vector<std::string> &argv);

// File system operations
std::string read_file(std::string_view path);
bool write_file(std::string_view path, std::string_view content);
bool append_file(std::string_view path, std::string_view content);
bool copy_file(std::string_view src, std::string_view dst);
bool rename_path(std::string_view old_path, std::string_view new_path);
bool delete_file(std::string_view path);
bool delete_dir_recursive(std::string_view path);
bool make_dir(std::string_view path);
bool make_dirs(std::string_view path);
bool file_exists(std::string_view path);
bool is_directory(std::string_view path);
int64_t file_mtime(std::string_view path);  // -1 on failure

struct DirEntry {
    std::string name;
    bool        is_dir;
};
std::vector<DirEntry> list_dir(std::string_view path);

// Find all regular files recursively under a directory (relative paths)
std::vector<std::string> find_files_recursive(std::string_view dir);

// Create a new unique temporary directory; returns its path, or empty on failure
std::string make_temp_dir();

// Environment
std::string get_env(std::string_view name);
void set_env(std::string_view name, std::string_view value);
std::string get_home_dir();
std::string get_cwd();
bool set_cwd(std::string_view path);

// I/O
void fd_write_stdout(std::string_view s);
void fd_write_stderr(std::string_view s);

// Read all of stdin
std::string read_stdin();

// Time
struct DateTime {
    int year;       // e.g. 2026
    int month;      // 1-12
    int day;        // 1-31
    int hour;       // 0-23
    int min;        // 0-59
    int sec;        // 0-59
    int weekday;    // 0=Sun, 1=Mon, ..., 6=Sat
    int utc_offset; // seconds east of UTC
};

int64_t current_time();                    // seconds since Unix epoch
DateTime local_time(int64_t timestamp);    // broken-down local time + UTC offset

// Entry point called by platform main
int quilt_main(int argc, char **argv);
