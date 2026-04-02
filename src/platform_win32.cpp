// This is free and unencumbered software released into the public domain.
//
// Win32 platform implementation for quilt.
// Provides main entry point, UTF-16 <-> UTF-8 conversion at system
// boundaries, and Win32 implementations of the platform interface.
//
// This file is compiled only on Windows.  POSIX builds use
// platform_posix.cpp instead.  No #ifdef guards -- the build system
// selects exactly one platform source.

#include "platform.hpp"

#ifndef _WIN32
#error "platform_win32.cpp must only be compiled on Windows"
#endif

#ifndef WIN32_LEAN_AND_MEAN
#define WIN32_LEAN_AND_MEAN
#endif
#include <windows.h>
#include <shellapi.h>

#include <cctype>
#include <cstdlib>
#include <cstring>

static std::wstring utf8_to_wide(std::string_view s)
{
    if (s.empty()) return {};
    int len = MultiByteToWideChar(CP_UTF8, 0, s.data(),
                                  checked_cast<int>(std::ssize(s)), nullptr, 0);
    if (len <= 0) return {};
    std::wstring out(len, L'\0');
    MultiByteToWideChar(CP_UTF8, 0, s.data(), checked_cast<int>(std::ssize(s)),
                        out.data(), len);
    return out;
}

static std::string wide_to_utf8(const wchar_t *w, int wlen = -1)
{
    if (!w) return {};
    if (wlen < 0) wlen = checked_cast<int>(static_cast<ptrdiff_t>(wcslen(w)));
    if (wlen == 0) return {};
    int len = WideCharToMultiByte(CP_UTF8, 0, w, wlen,
                                  nullptr, 0, nullptr, nullptr);
    if (len <= 0) return {};
    std::string out(len, '\0');
    WideCharToMultiByte(CP_UTF8, 0, w, wlen,
                        out.data(), len, nullptr, nullptr);
    return out;
}

static std::string read_handle(HANDLE h)
{
    std::string result;
    char buf[4096];
    for (;;) {
        DWORD n = 0;
        if (!ReadFile(h, buf, sizeof(buf), &n, nullptr) || n == 0)
            break;
        result.append(buf, n);
    }
    return result;
}

static bool write_handle(HANDLE h, const void *data, size_t len)
{
    const char *p = static_cast<const char *>(data);
    while (len > 0) {
        DWORD written = 0;
        if (!WriteFile(h, p, (DWORD)len, &written, nullptr))
            return false;
        p   += written;
        len -= written;
    }
    return true;
}

// Write a UTF-8 string to a handle.  When the handle is a console,
// convert to UTF-16 and use WriteConsoleW so that non-ASCII text
// displays correctly.  For pipes/files, write raw UTF-8 bytes.
static bool write_console_or_file(HANDLE h, std::string_view s)
{
    DWORD mode;
    if (GetConsoleMode(h, &mode)) {
        std::wstring wide = utf8_to_wide(s);
        const wchar_t *p = wide.data();
        DWORD remaining = checked_cast<DWORD>(std::ssize(wide));
        while (remaining > 0) {
            DWORD written = 0;
            if (!WriteConsoleW(h, p, remaining, &written, nullptr))
                return false;
            p         += written;
            remaining -= written;
        }
        return true;
    }
    return write_handle(h, s.data(), s.size());
}

// Create an inheritable pipe.  read_end and write_end are set.
// inherit_which: 0 = read end inheritable, 1 = write end inheritable
static bool create_pipe(HANDLE &read_end, HANDLE &write_end,
                        int inherit_which)
{
    SECURITY_ATTRIBUTES sa{};
    sa.nLength = sizeof(sa);
    sa.bInheritHandle = TRUE;

    if (!CreatePipe(&read_end, &write_end, &sa, 0))
        return false;

    // Make the non-inherited end non-inheritable
    HANDLE &non_inherit = (inherit_which == 0) ? write_end : read_end;
    SetHandleInformation(non_inherit, HANDLE_FLAG_INHERIT, 0);
    return true;
}

static std::wstring build_cmdline(const std::vector<std::string> &argv)
{
    // Windows command-line quoting: wrap each arg in quotes, escape
    // internal quotes and backslashes before quotes.
    std::wstring cmdline;
    for (ptrdiff_t i = 0; i < std::ssize(argv); ++i) {
        if (i > 0) cmdline += L' ';

        std::wstring arg = utf8_to_wide(argv[checked_cast<size_t>(i)]);

        // Check if quoting is needed
        bool needs_quote = arg.empty();
        for (wchar_t c : arg) {
            if (c == L' ' || c == L'\t' || c == L'"') {
                needs_quote = true;
                break;
            }
        }

        if (!needs_quote) {
            cmdline += arg;
            continue;
        }

        cmdline += L'"';
        int num_backslashes = 0;
        for (wchar_t c : arg) {
            if (c == L'\\') {
                ++num_backslashes;
            } else if (c == L'"') {
                // Escape preceding backslashes and the quote
                for (int j = 0; j < num_backslashes; ++j)
                    cmdline += L'\\';
                cmdline += L'\\';
                cmdline += L'"';
                num_backslashes = 0;
            } else {
                num_backslashes = 0;
                cmdline += c;
            }
        }
        // Escape trailing backslashes before closing quote
        for (int j = 0; j < num_backslashes; ++j)
            cmdline += L'\\';
        cmdline += L'"';
    }
    return cmdline;
}

static ProcessResult run_cmd_impl(const std::vector<std::string> &argv,
                                  const char *stdin_data, size_t stdin_len)
{
    ProcessResult result{};

    if (argv.empty()) {
        result.exit_code = -1;
        return result;
    }

    // Create pipes for stdout, stderr, and optionally stdin
    HANDLE stdout_rd = INVALID_HANDLE_VALUE, stdout_wr = INVALID_HANDLE_VALUE;
    HANDLE stderr_rd = INVALID_HANDLE_VALUE, stderr_wr = INVALID_HANDLE_VALUE;
    HANDLE stdin_rd  = INVALID_HANDLE_VALUE, stdin_wr  = INVALID_HANDLE_VALUE;

    if (!create_pipe(stdout_rd, stdout_wr, 1)) {  // write end inheritable
        result.exit_code = -1;
        return result;
    }
    if (!create_pipe(stderr_rd, stderr_wr, 1)) {
        CloseHandle(stdout_rd); CloseHandle(stdout_wr);
        result.exit_code = -1;
        return result;
    }

    bool need_stdin = (stdin_data != nullptr);
    if (need_stdin) {
        if (!create_pipe(stdin_rd, stdin_wr, 0)) {  // read end inheritable
            CloseHandle(stdout_rd); CloseHandle(stdout_wr);
            CloseHandle(stderr_rd); CloseHandle(stderr_wr);
            result.exit_code = -1;
            return result;
        }
    }

    STARTUPINFOW si{};
    si.cb = sizeof(si);
    si.dwFlags = STARTF_USESTDHANDLES;
    si.hStdOutput = stdout_wr;
    si.hStdError  = stderr_wr;
    si.hStdInput  = need_stdin ? stdin_rd : GetStdHandle(STD_INPUT_HANDLE);

    PROCESS_INFORMATION pi{};

    std::wstring cmdline = build_cmdline(argv);

    BOOL ok = CreateProcessW(
        nullptr,                               // lpApplicationName
        cmdline.data(),                        // lpCommandLine (mutable)
        nullptr, nullptr,                      // process/thread security
        TRUE,                                  // inherit handles
        CREATE_NO_WINDOW,                      // creation flags
        nullptr,                               // environment
        nullptr,                               // current directory
        &si, &pi
    );

    // Close child-side handles in parent
    CloseHandle(stdout_wr);
    CloseHandle(stderr_wr);
    if (need_stdin) CloseHandle(stdin_rd);

    if (!ok) {
        result.exit_code = -1;
        result.err = "CreateProcessW failed: " + std::to_string(GetLastError());
        CloseHandle(stdout_rd);
        CloseHandle(stderr_rd);
        if (need_stdin) CloseHandle(stdin_wr);
        return result;
    }

    // Write stdin data
    if (need_stdin) {
        write_handle(stdin_wr, stdin_data, stdin_len);
        CloseHandle(stdin_wr);
    }

    // Read stdout and stderr
    result.out = read_handle(stdout_rd);
    result.err = read_handle(stderr_rd);
    CloseHandle(stdout_rd);
    CloseHandle(stderr_rd);

    // Wait for process
    WaitForSingleObject(pi.hProcess, INFINITE);

    DWORD exit_code = 0;
    GetExitCodeProcess(pi.hProcess, &exit_code);
    result.exit_code = static_cast<int>(exit_code);

    CloseHandle(pi.hProcess);
    CloseHandle(pi.hThread);

    return result;
}

ProcessResult run_cmd(const std::vector<std::string> &argv)
{
    return run_cmd_impl(argv, nullptr, 0);
}

ProcessResult run_cmd_input(const std::vector<std::string> &argv,
                            std::string_view stdin_data)
{
    return run_cmd_impl(argv, stdin_data.data(), stdin_data.size());
}

int run_cmd_tty(const std::vector<std::string> &argv)
{
    if (argv.empty()) return -1;

    STARTUPINFOW si{};
    si.cb = sizeof(si);
    // No STARTF_USESTDHANDLES — child inherits console

    PROCESS_INFORMATION pi{};
    std::wstring cmdline = build_cmdline(argv);

    BOOL ok = CreateProcessW(
        nullptr, cmdline.data(),
        nullptr, nullptr,
        FALSE, 0,
        nullptr, nullptr,
        &si, &pi
    );
    if (!ok) return -1;

    WaitForSingleObject(pi.hProcess, INFINITE);
    DWORD exit_code = 0;
    GetExitCodeProcess(pi.hProcess, &exit_code);
    CloseHandle(pi.hProcess);
    CloseHandle(pi.hThread);
    return static_cast<int>(exit_code);
}

std::string read_file(std::string_view path)
{
    std::wstring wpath = utf8_to_wide(path);
    HANDLE h = CreateFileW(wpath.c_str(), GENERIC_READ, FILE_SHARE_READ,
                           nullptr, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL,
                           nullptr);
    if (h == INVALID_HANDLE_VALUE) return {};

    std::string result = read_handle(h);
    CloseHandle(h);
    return result;
}

bool write_file(std::string_view path, std::string_view content)
{
    std::wstring wpath = utf8_to_wide(path);
    HANDLE h = CreateFileW(wpath.c_str(), GENERIC_WRITE, 0,
                           nullptr, CREATE_ALWAYS, FILE_ATTRIBUTE_NORMAL,
                           nullptr);
    if (h == INVALID_HANDLE_VALUE) return false;

    bool ok = write_handle(h, content.data(), content.size());
    CloseHandle(h);
    return ok;
}

bool append_file(std::string_view path, std::string_view content)
{
    std::wstring wpath = utf8_to_wide(path);
    HANDLE h = CreateFileW(wpath.c_str(), FILE_APPEND_DATA, 0,
                           nullptr, OPEN_ALWAYS, FILE_ATTRIBUTE_NORMAL,
                           nullptr);
    if (h == INVALID_HANDLE_VALUE) return false;

    bool ok = write_handle(h, content.data(), content.size());
    CloseHandle(h);
    return ok;
}

bool copy_file(std::string_view src, std::string_view dst)
{
    std::wstring wsrc = utf8_to_wide(src);
    std::wstring wdst = utf8_to_wide(dst);
    return CopyFileW(wsrc.c_str(), wdst.c_str(), FALSE) != 0;
}

bool rename_path(std::string_view old_path, std::string_view new_path)
{
    std::wstring wold = utf8_to_wide(old_path);
    std::wstring wnew = utf8_to_wide(new_path);
    return MoveFileExW(wold.c_str(), wnew.c_str(),
                       MOVEFILE_REPLACE_EXISTING) != 0;
}

bool delete_file(std::string_view path)
{
    std::wstring wpath = utf8_to_wide(path);
    return DeleteFileW(wpath.c_str()) != 0;
}

bool delete_dir_recursive(std::string_view path)
{
    std::wstring wpath = utf8_to_wide(path);
    std::wstring pattern = wpath + L"\\*";

    WIN32_FIND_DATAW fd;
    HANDLE hFind = FindFirstFileW(pattern.c_str(), &fd);
    if (hFind == INVALID_HANDLE_VALUE) return false;

    bool ok = true;
    do {
        if (wcscmp(fd.cFileName, L".") == 0 ||
            wcscmp(fd.cFileName, L"..") == 0)
            continue;

        std::wstring child = wpath + L"\\" + fd.cFileName;
        std::string child_utf8 = wide_to_utf8(child.c_str(),
                                              checked_cast<int>(std::ssize(child)));

        if (fd.dwFileAttributes & FILE_ATTRIBUTE_DIRECTORY) {
            if (!delete_dir_recursive(child_utf8)) ok = false;
        } else {
            if (!DeleteFileW(child.c_str())) ok = false;
        }
    } while (FindNextFileW(hFind, &fd));
    FindClose(hFind);

    if (!RemoveDirectoryW(wpath.c_str())) ok = false;
    return ok;
}

bool make_dir(std::string_view path)
{
    std::wstring wpath = utf8_to_wide(path);
    if (CreateDirectoryW(wpath.c_str(), nullptr)) return true;
    return GetLastError() == ERROR_ALREADY_EXISTS;
}

bool make_dirs(std::string_view path)
{
    if (path.empty()) return false;

    std::string p(path);
    // Normalize separators
    for (char &c : p) {
        if (c == '/') c = '\\';
    }

    ptrdiff_t start = 1;
    if (std::ssize(p) >= 3 && std::isalpha(static_cast<unsigned char>(p[0])) &&
        p[1] == ':' && p[2] == '\\') {
        start = 3;
    } else if (std::ssize(p) >= 2 && p[0] == '\\' && p[1] == '\\') {
        // Leave UNC handling to the normal loop after the \\server\share prefix.
        ptrdiff_t slash_count = 0;
        start = 2;
        for (ptrdiff_t i = 2; i < std::ssize(p); ++i) {
            if (p[checked_cast<size_t>(i)] == '\\') {
                ++slash_count;
                if (slash_count == 2) {
                    start = i + 1;
                    break;
                }
            }
        }
    }

    // Walk through path components, creating each.
    for (ptrdiff_t i = start; i < std::ssize(p); ++i) {
        if (p[checked_cast<size_t>(i)] == '\\') {
            p[checked_cast<size_t>(i)] = '\0';
            std::wstring wp = utf8_to_wide(p.c_str());
            if (!CreateDirectoryW(wp.c_str(), nullptr)) {
                if (GetLastError() != ERROR_ALREADY_EXISTS)
                    return false;
            }
            p[checked_cast<size_t>(i)] = '\\';
        }
    }
    std::wstring wp = utf8_to_wide(p);
    if (!CreateDirectoryW(wp.c_str(), nullptr)) {
        if (GetLastError() != ERROR_ALREADY_EXISTS)
            return false;
    }
    return true;
}

bool file_exists(std::string_view path)
{
    std::wstring wpath = utf8_to_wide(path);
    DWORD attr = GetFileAttributesW(wpath.c_str());
    return attr != INVALID_FILE_ATTRIBUTES;
}

bool is_directory(std::string_view path)
{
    std::wstring wpath = utf8_to_wide(path);
    DWORD attr = GetFileAttributesW(wpath.c_str());
    if (attr == INVALID_FILE_ATTRIBUTES) return false;
    return (attr & FILE_ATTRIBUTE_DIRECTORY) != 0;
}

int64_t file_mtime(std::string_view path)
{
    std::wstring wpath = utf8_to_wide(path);
    WIN32_FILE_ATTRIBUTE_DATA data;
    if (!GetFileAttributesExW(wpath.c_str(), GetFileExInfoStandard, &data))
        return -1;
    // FILETIME: 100-nanosecond intervals since 1601-01-01
    uint64_t ft = (static_cast<uint64_t>(data.ftLastWriteTime.dwHighDateTime) << 32)
                | data.ftLastWriteTime.dwLowDateTime;
    return static_cast<int64_t>((ft - 116444736000000000ULL) / 10000000ULL);
}

std::vector<DirEntry> list_dir(std::string_view path)
{
    std::vector<DirEntry> entries;
    std::wstring wpath = utf8_to_wide(path);
    std::wstring pattern = wpath + L"\\*";

    WIN32_FIND_DATAW fd;
    HANDLE hFind = FindFirstFileW(pattern.c_str(), &fd);
    if (hFind == INVALID_HANDLE_VALUE) return entries;

    do {
        if (wcscmp(fd.cFileName, L".") == 0 ||
            wcscmp(fd.cFileName, L"..") == 0)
            continue;

        DirEntry e;
        e.name   = wide_to_utf8(fd.cFileName);
        e.is_dir = (fd.dwFileAttributes & FILE_ATTRIBUTE_DIRECTORY) != 0;
        entries.push_back(std::move(e));
    } while (FindNextFileW(hFind, &fd));
    FindClose(hFind);

    return entries;
}

static void find_files_impl(const std::wstring &base,
                             const std::string &prefix,
                             std::vector<std::string> &out)
{
    std::wstring pattern = base + L"\\*";
    WIN32_FIND_DATAW fd;
    HANDLE hFind = FindFirstFileW(pattern.c_str(), &fd);
    if (hFind == INVALID_HANDLE_VALUE) return;

    do {
        if (wcscmp(fd.cFileName, L".") == 0 ||
            wcscmp(fd.cFileName, L"..") == 0)
            continue;

        std::string name = wide_to_utf8(fd.cFileName);
        std::wstring full = base + L"\\" + fd.cFileName;
        std::string rel = prefix.empty() ? name : prefix + "/" + name;

        if (fd.dwFileAttributes & FILE_ATTRIBUTE_DIRECTORY) {
            find_files_impl(full, rel, out);
        } else {
            out.push_back(rel);
        }
    } while (FindNextFileW(hFind, &fd));
    FindClose(hFind);
}

std::vector<std::string> find_files_recursive(std::string_view dir)
{
    std::vector<std::string> result;
    std::wstring wdir = utf8_to_wide(dir);
    find_files_impl(wdir, "", result);
    return result;
}

std::string make_temp_dir()
{
    wchar_t tmp_path[MAX_PATH + 1];
    if (!GetTempPathW(MAX_PATH + 1, tmp_path)) return {};

    DWORD pid = GetCurrentProcessId();
    static unsigned counter = 0;
    wchar_t tmp_dir[MAX_PATH + 1];
    for (int attempt = 0; attempt < 100; ++attempt) {
        unsigned n = counter++;
        swprintf(tmp_dir, MAX_PATH, L"%sqlt%lu_%u", tmp_path, (unsigned long)pid, n);
        if (CreateDirectoryW(tmp_dir, nullptr)) {
            std::string result = wide_to_utf8(tmp_dir);
            for (char &c : result)
                if (c == '\\') c = '/';
            return result;
        }
    }
    return {};
}

std::string get_env(std::string_view name)
{
    std::wstring wname = utf8_to_wide(name);
    // First call to get required buffer size
    DWORD len = GetEnvironmentVariableW(wname.c_str(), nullptr, 0);
    if (len == 0) return {};
    std::wstring buf(len, L'\0');
    GetEnvironmentVariableW(wname.c_str(), buf.data(), len);
    // Remove trailing null
    if (!buf.empty() && buf.back() == L'\0') buf.pop_back();
    return wide_to_utf8(buf.c_str(), checked_cast<int>(std::ssize(buf)));
}

void set_env(std::string_view name, std::string_view value)
{
    std::wstring wname = utf8_to_wide(name);
    std::wstring wvalue = utf8_to_wide(value);
    SetEnvironmentVariableW(wname.c_str(), wvalue.c_str());
}

std::string get_home_dir()
{
    std::string home = get_env("HOME");
    if (!home.empty()) return home;
    std::string up = get_env("USERPROFILE");
    if (!up.empty()) return up;
    std::string hd = get_env("HOMEDRIVE");
    std::string hp = get_env("HOMEPATH");
    if (!hd.empty() && !hp.empty()) return hd + hp;
    return {};
}

std::string get_system_quiltrc()
{
    wchar_t buf[MAX_PATH];
    DWORD len = GetModuleFileNameW(NULL, buf, MAX_PATH);
    if (len == 0 || len >= MAX_PATH) return {};
    std::wstring path(buf, len);
    // Strip exe filename
    auto pos = path.rfind(L'\\');
    if (pos == std::wstring::npos) return {};
    path.resize(pos);
    // Strip parent directory (e.g. bin/)
    pos = path.rfind(L'\\');
    if (pos == std::wstring::npos) return {};
    path.resize(pos);
    path += L"\\etc\\quilt.quiltrc";
    std::string result = wide_to_utf8(path.c_str(),
                                      checked_cast<int>(std::ssize(path)));
    for (char &c : result) {
        if (c == '\\') c = '/';
    }
    return result;
}

std::string get_cwd()
{
    DWORD len = GetCurrentDirectoryW(0, nullptr);
    if (len == 0) return {};
    std::wstring buf(len, L'\0');
    GetCurrentDirectoryW(len, buf.data());
    // Remove trailing null
    if (!buf.empty() && buf.back() == L'\0') buf.pop_back();
    std::string result = wide_to_utf8(buf.c_str(), checked_cast<int>(std::ssize(buf)));
    // Normalize backslashes to forward slashes for consistency
    for (char &c : result) {
        if (c == '\\') c = '/';
    }
    return result;
}

bool set_cwd(std::string_view path)
{
    std::wstring wpath = utf8_to_wide(path);
    return SetCurrentDirectoryW(wpath.c_str()) != 0;
}

void fd_write_stdout(std::string_view s)
{
    HANDLE h = GetStdHandle(STD_OUTPUT_HANDLE);
    if (h != INVALID_HANDLE_VALUE)
        write_console_or_file(h, s);
}

void fd_write_stderr(std::string_view s)
{
    HANDLE h = GetStdHandle(STD_ERROR_HANDLE);
    if (h != INVALID_HANDLE_VALUE)
        write_console_or_file(h, s);
}

bool stdout_is_tty()
{
    HANDLE h = GetStdHandle(STD_OUTPUT_HANDLE);
    return h != INVALID_HANDLE_VALUE && GetFileType(h) == FILE_TYPE_CHAR;
}

std::string read_stdin()
{
    HANDLE h = GetStdHandle(STD_INPUT_HANDLE);
    if (h == INVALID_HANDLE_VALUE) return {};
    return read_handle(h);
}

int64_t current_time()
{
    return _time64(nullptr);
}

DateTime local_time(int64_t timestamp)
{
    __time64_t t = static_cast<__time64_t>(timestamp);
    struct tm local_tm, utc_tm;
    _localtime64_s(&local_tm, &t);
    _gmtime64_s(&utc_tm, &t);

    long local_sec = local_tm.tm_hour * 3600L + local_tm.tm_min * 60L + local_tm.tm_sec;
    long utc_sec = utc_tm.tm_hour * 3600L + utc_tm.tm_min * 60L + utc_tm.tm_sec;
    long diff = local_sec - utc_sec;
    int day_diff = local_tm.tm_yday - utc_tm.tm_yday;
    if (day_diff > 1) day_diff = -1;
    if (day_diff < -1) day_diff = 1;
    diff += day_diff * 86400L;

    return {
        local_tm.tm_year + 1900,
        local_tm.tm_mon + 1,
        local_tm.tm_mday,
        local_tm.tm_hour,
        local_tm.tm_min,
        local_tm.tm_sec,
        local_tm.tm_wday,
        static_cast<int>(diff),
    };
}

int main(int, char **)
{
    // Use GetCommandLineW + CommandLineToArgvW for reliable parsing
    int argc = 0;
    wchar_t **wargv = CommandLineToArgvW(GetCommandLineW(), &argc);
    if (!wargv) return 1;

    // Convert to UTF-8
    std::vector<std::string> args_storage;
    args_storage.reserve(argc);
    for (int i = 0; i < argc; ++i)
        args_storage.push_back(wide_to_utf8(wargv[i]));
    LocalFree(wargv);

    std::vector<char *> argv_ptrs;
    argv_ptrs.reserve(argc + 1);
    for (auto &a : args_storage)
        argv_ptrs.push_back(a.data());
    argv_ptrs.push_back(nullptr);

    return quilt_main(argc, argv_ptrs.data());
}

