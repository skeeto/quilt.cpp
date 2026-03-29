// This is free and unencumbered software released into the public domain.
#include "platform.hpp"

#include <cerrno>
#include <cstdlib>
#include <cstring>
#include <ctime>

#include <dirent.h>
#include <fcntl.h>
#include <pwd.h>
#include <sys/stat.h>
#include <sys/wait.h>
#include <unistd.h>

static std::string null_terminated(std::string_view sv)
{
    return std::string(sv);
}

static void write_all(int fd, const void *buf, size_t len)
{
    const char *p = static_cast<const char *>(buf);
    while (len > 0) {
        ssize_t n = ::write(fd, p, len);
        if (n < 0) {
            if (errno == EINTR) continue;
            break;
        }
        p   += n;
        len -= static_cast<size_t>(n);
    }
}

static std::string read_all_fd(int fd)
{
    std::string result;
    char buf[4096];
    for (;;) {
        ssize_t n = ::read(fd, buf, sizeof(buf));
        if (n < 0) {
            if (errno == EINTR) continue;
            break;
        }
        if (n == 0) break;
        result.append(buf, static_cast<size_t>(n));
    }
    return result;
}

static ProcessResult run_cmd_impl(const std::vector<std::string> &argv,
                                  const char *stdin_data, size_t stdin_len)
{
    ProcessResult result{};

    if (argv.empty()) {
        result.exit_code = -1;
        return result;
    }

    // Pipes: [0]=read, [1]=write
    int stdout_pipe[2];
    int stderr_pipe[2];
    int stdin_pipe[2];

    if (::pipe(stdout_pipe) != 0 || ::pipe(stderr_pipe) != 0) {
        result.exit_code = -1;
        return result;
    }

    bool need_stdin = (stdin_data != nullptr);
    if (need_stdin) {
        if (::pipe(stdin_pipe) != 0) {
            ::close(stdout_pipe[0]); ::close(stdout_pipe[1]);
            ::close(stderr_pipe[0]); ::close(stderr_pipe[1]);
            result.exit_code = -1;
            return result;
        }
    }

    pid_t pid = ::fork();
    if (pid < 0) {
        result.exit_code = -1;
        ::close(stdout_pipe[0]); ::close(stdout_pipe[1]);
        ::close(stderr_pipe[0]); ::close(stderr_pipe[1]);
        if (need_stdin) { ::close(stdin_pipe[0]); ::close(stdin_pipe[1]); }
        return result;
    }

    if (pid == 0) {
        // Child
        ::dup2(stdout_pipe[1], STDOUT_FILENO);
        ::dup2(stderr_pipe[1], STDERR_FILENO);
        ::close(stdout_pipe[0]); ::close(stdout_pipe[1]);
        ::close(stderr_pipe[0]); ::close(stderr_pipe[1]);

        if (need_stdin) {
            ::dup2(stdin_pipe[0], STDIN_FILENO);
            ::close(stdin_pipe[0]); ::close(stdin_pipe[1]);
        }

        // Build argv for execvp
        std::vector<char *> args;
        args.reserve(checked_cast<size_t>(std::ssize(argv) + 1));
        for (auto &a : argv)
            args.push_back(const_cast<char *>(a.c_str()));
        args.push_back(nullptr);

        ::execvp(args[0], args.data());
        ::_exit(127);
    }

    // Parent
    ::close(stdout_pipe[1]);
    ::close(stderr_pipe[1]);

    if (need_stdin) {
        ::close(stdin_pipe[0]);
        write_all(stdin_pipe[1], stdin_data, stdin_len);
        ::close(stdin_pipe[1]);
    }

    result.out = read_all_fd(stdout_pipe[0]);
    result.err = read_all_fd(stderr_pipe[0]);
    ::close(stdout_pipe[0]);
    ::close(stderr_pipe[0]);

    int status = 0;
    while (::waitpid(pid, &status, 0) < 0) {
        if (errno != EINTR) break;
    }

    if (WIFEXITED(status))
        result.exit_code = WEXITSTATUS(status);
    else
        result.exit_code = -1;

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

    pid_t pid = ::fork();
    if (pid < 0) return -1;

    if (pid == 0) {
        // Child inherits stdin/stdout/stderr from parent
        std::vector<char *> args;
        args.reserve(checked_cast<size_t>(std::ssize(argv) + 1));
        for (auto &a : argv)
            args.push_back(const_cast<char *>(a.c_str()));
        args.push_back(nullptr);
        ::execvp(args[0], args.data());
        ::_exit(127);
    }

    int status = 0;
    while (::waitpid(pid, &status, 0) < 0) {
        if (errno != EINTR) return -1;
    }
    return WIFEXITED(status) ? WEXITSTATUS(status) : -1;
}

std::string read_file(std::string_view path)
{
    std::string p = null_terminated(path);
    int fd = ::open(p.c_str(), O_RDONLY);
    if (fd < 0) return {};

    std::string contents = read_all_fd(fd);
    ::close(fd);
    return contents;
}

bool write_file(std::string_view path, std::string_view content)
{
    std::string p = null_terminated(path);
    int fd = ::open(p.c_str(), O_WRONLY | O_CREAT | O_TRUNC, 0644);
    if (fd < 0) return false;

    const char *buf = content.data();
    size_t remaining = content.size();
    while (remaining > 0) {
        ssize_t n = ::write(fd, buf, remaining);
        if (n < 0) {
            if (errno == EINTR) continue;
            ::close(fd);
            return false;
        }
        buf       += n;
        remaining -= static_cast<size_t>(n);
    }
    ::close(fd);
    return true;
}

bool append_file(std::string_view path, std::string_view content)
{
    std::string p = null_terminated(path);
    int fd = ::open(p.c_str(), O_WRONLY | O_CREAT | O_APPEND, 0644);
    if (fd < 0) return false;

    const char *buf = content.data();
    size_t remaining = content.size();
    while (remaining > 0) {
        ssize_t n = ::write(fd, buf, remaining);
        if (n < 0) {
            if (errno == EINTR) continue;
            ::close(fd);
            return false;
        }
        buf       += n;
        remaining -= static_cast<size_t>(n);
    }
    ::close(fd);
    return true;
}

bool copy_file(std::string_view src, std::string_view dst)
{
    std::string contents = read_file(src);
    // Distinguish "empty file" from "failed to open" by checking existence
    if (contents.empty() && !file_exists(src))
        return false;
    return write_file(dst, contents);
}

bool rename_path(std::string_view old_path, std::string_view new_path)
{
    std::string o = null_terminated(old_path);
    std::string n = null_terminated(new_path);
    return ::rename(o.c_str(), n.c_str()) == 0;
}

bool delete_file(std::string_view path)
{
    std::string p = null_terminated(path);
    return ::unlink(p.c_str()) == 0;
}

bool delete_dir_recursive(std::string_view path)
{
    std::string p = null_terminated(path);
    DIR *d = ::opendir(p.c_str());
    if (!d) return false;

    struct dirent *ent;
    bool ok = true;
    while ((ent = ::readdir(d)) != nullptr) {
        if (std::strcmp(ent->d_name, ".") == 0 ||
            std::strcmp(ent->d_name, "..") == 0)
            continue;

        std::string child = p + "/" + ent->d_name;
        struct stat st;
        if (::lstat(child.c_str(), &st) != 0) { ok = false; continue; }

        if (S_ISDIR(st.st_mode)) {
            if (!delete_dir_recursive(child)) ok = false;
        } else {
            if (::unlink(child.c_str()) != 0) ok = false;
        }
    }
    ::closedir(d);

    if (::rmdir(p.c_str()) != 0) ok = false;
    return ok;
}

bool make_dir(std::string_view path)
{
    std::string p = null_terminated(path);
    return ::mkdir(p.c_str(), 0755) == 0;
}

bool make_dirs(std::string_view path)
{
    std::string p = null_terminated(path);
    if (p.empty()) return false;

    // Walk through the path and create each component
    for (ptrdiff_t i = 1; i < std::ssize(p); ++i) {
        if (p[checked_cast<size_t>(i)] == '/') {
            p[checked_cast<size_t>(i)] = '\0';
            if (::mkdir(p.c_str(), 0755) != 0 && errno != EEXIST)
                return false;
            p[checked_cast<size_t>(i)] = '/';
        }
    }
    if (::mkdir(p.c_str(), 0755) != 0 && errno != EEXIST)
        return false;
    return true;
}

bool file_exists(std::string_view path)
{
    std::string p = null_terminated(path);
    struct stat st;
    return ::stat(p.c_str(), &st) == 0;
}

bool is_directory(std::string_view path)
{
    std::string p = null_terminated(path);
    struct stat st;
    if (::stat(p.c_str(), &st) != 0) return false;
    return S_ISDIR(st.st_mode);
}

bool create_symlink(std::string_view target, std::string_view link_path)
{
    std::string t = null_terminated(target);
    std::string l = null_terminated(link_path);
    return ::symlink(t.c_str(), l.c_str()) == 0;
}

int64_t file_mtime(std::string_view path)
{
    std::string p = null_terminated(path);
    struct stat st;
    if (::stat(p.c_str(), &st) != 0) return -1;
    return static_cast<int64_t>(st.st_mtime);
}

std::vector<DirEntry> list_dir(std::string_view path)
{
    std::vector<DirEntry> entries;
    std::string p = null_terminated(path);
    DIR *d = ::opendir(p.c_str());
    if (!d) return entries;

    struct dirent *ent;
    while ((ent = ::readdir(d)) != nullptr) {
        if (std::strcmp(ent->d_name, ".") == 0 ||
            std::strcmp(ent->d_name, "..") == 0)
            continue;

        DirEntry e;
        e.name = ent->d_name;

        std::string child = p + "/" + e.name;
        struct stat st;
        if (::stat(child.c_str(), &st) == 0)
            e.is_dir = S_ISDIR(st.st_mode);
        else
            e.is_dir = false;

        entries.push_back(std::move(e));
    }
    ::closedir(d);
    return entries;
}

static void find_files_impl(const std::string &base,
                             const std::string &prefix,
                             std::vector<std::string> &out)
{
    DIR *d = ::opendir(base.c_str());
    if (!d) return;

    struct dirent *ent;
    while ((ent = ::readdir(d)) != nullptr) {
        if (std::strcmp(ent->d_name, ".") == 0 ||
            std::strcmp(ent->d_name, "..") == 0)
            continue;

        std::string full = base + "/" + ent->d_name;
        std::string rel  = prefix.empty()
                           ? std::string(ent->d_name)
                           : prefix + "/" + ent->d_name;

        struct stat st;
        if (::lstat(full.c_str(), &st) != 0) continue;

        if (S_ISDIR(st.st_mode)) {
            find_files_impl(full, rel, out);
        } else if (S_ISREG(st.st_mode)) {
            out.push_back(rel);
        }
    }
    ::closedir(d);
}

std::vector<std::string> find_files_recursive(std::string_view dir)
{
    std::vector<std::string> result;
    std::string p = null_terminated(dir);
    find_files_impl(p, "", result);
    return result;
}

std::string make_temp_dir()
{
    const char *tmpdir = std::getenv("TMPDIR");
    std::string base = tmpdir ? tmpdir : "/tmp";
    std::string tmpl = base + "/quilt-XXXXXX";
    std::vector<char> buf(tmpl.begin(), tmpl.end());
    buf.push_back('\0');
    char *result = ::mkdtemp(buf.data());
    return result ? std::string(result) : std::string();
}

std::string get_env(std::string_view name)
{
    std::string n = null_terminated(name);
    const char *val = std::getenv(n.c_str());
    return val ? std::string(val) : std::string();
}

void set_env(std::string_view name, std::string_view value)
{
    std::string n = null_terminated(name);
    std::string v = null_terminated(value);
    ::setenv(n.c_str(), v.c_str(), 1);
}

std::string get_home_dir()
{
    const char *home = std::getenv("HOME");
    if (home) return std::string(home);
    struct passwd *pw = ::getpwuid(::getuid());
    if (pw && pw->pw_dir) return std::string(pw->pw_dir);
    return {};
}

std::string get_cwd()
{
    char buf[4096];
    if (::getcwd(buf, sizeof(buf)))
        return std::string(buf);
    return {};
}

bool set_cwd(std::string_view path)
{
    std::string p = null_terminated(path);
    return ::chdir(p.c_str()) == 0;
}

void fd_write_stdout(std::string_view s)
{
    write_all(STDOUT_FILENO, s.data(), s.size());
}

void fd_write_stderr(std::string_view s)
{
    write_all(STDERR_FILENO, s.data(), s.size());
}

std::string read_stdin()
{
    return read_all_fd(STDIN_FILENO);
}

int64_t current_time()
{
    return static_cast<int64_t>(std::time(nullptr));
}

DateTime local_time(int64_t timestamp)
{
    time_t t = static_cast<time_t>(timestamp);
    struct tm local_tm;
    localtime_r(&t, &local_tm);

    struct tm utc_tm;
    gmtime_r(&t, &utc_tm);

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

int main(int argc, char **argv)
{
    return quilt_main(argc, argv);
}
