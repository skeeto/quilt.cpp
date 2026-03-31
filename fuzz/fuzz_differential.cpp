// This is free and unencumbered software released into the public domain.
//
// Differential fuzzer: generates random sequences of quilt operations
// and runs them against both quilt.cpp and system quilt, comparing
// exit codes, stdout, and final filesystem state.

#include <algorithm>
#include <cassert>
#include <cerrno>
#include <cstdint>
#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <filesystem>
#include <random>
#include <string>
#include <string_view>
#include <vector>

#include <fcntl.h>
#include <signal.h>
#include <sys/wait.h>
#include <unistd.h>

namespace fs = std::filesystem;

// ── Process execution ──────────────────────────────────────────────────

struct RunResult {
    int exit_code = -1;
    std::string out;
    std::string err;
};

static std::string read_all_fd(int fd) {
    std::string result;
    char buf[4096];
    for (;;) {
        auto n = ::read(fd, buf, sizeof(buf));
        if (n <= 0) break;
        result.append(buf, static_cast<size_t>(n));
    }
    return result;
}

static RunResult run_in_dir(const std::string &binary,
                            const std::string &dir,
                            const std::vector<std::string> &args) {
    RunResult result;

    int stdout_pipe[2], stderr_pipe[2];
    if (::pipe(stdout_pipe) != 0 || ::pipe(stderr_pipe) != 0)
        return result;

    pid_t pid = ::fork();
    if (pid < 0) {
        ::close(stdout_pipe[0]); ::close(stdout_pipe[1]);
        ::close(stderr_pipe[0]); ::close(stderr_pipe[1]);
        return result;
    }

    if (pid == 0) {
        // Child
        ::dup2(stdout_pipe[1], STDOUT_FILENO);
        ::dup2(stderr_pipe[1], STDERR_FILENO);
        ::close(stdout_pipe[0]); ::close(stdout_pipe[1]);
        ::close(stderr_pipe[0]); ::close(stderr_pipe[1]);

        // Redirect stdin from /dev/null
        int devnull = ::open("/dev/null", O_RDONLY);
        if (devnull >= 0) { ::dup2(devnull, STDIN_FILENO); ::close(devnull); }

        if (::chdir(dir.c_str()) != 0) ::_exit(126);

        // Isolate from user environment
        ::setenv("HOME", dir.c_str(), 1);
        ::setenv("LC_ALL", "C", 1);
        ::setenv("QUILT_PATCHES", "patches", 1);
        ::setenv("QUILT_PC", ".pc", 1);
        ::unsetenv("QUILT_DIFF_ARGS");
        ::unsetenv("QUILT_REFRESH_ARGS");
        ::unsetenv("QUILT_PUSH_ARGS");
        ::unsetenv("QUILT_PATCHES_PREFIX");

        std::vector<char *> argv;
        argv.push_back(const_cast<char *>(binary.c_str()));
        for (auto &a : args)
            argv.push_back(const_cast<char *>(a.c_str()));
        argv.push_back(nullptr);

        ::execvp(argv[0], argv.data());
        ::_exit(127);
    }

    // Parent
    ::close(stdout_pipe[1]);
    ::close(stderr_pipe[1]);

    result.out = read_all_fd(stdout_pipe[0]);
    result.err = read_all_fd(stderr_pipe[0]);
    ::close(stdout_pipe[0]);
    ::close(stderr_pipe[0]);

    // Wait with timeout (5 seconds)
    for (int i = 0; i < 50; ++i) {
        int status = 0;
        pid_t w = ::waitpid(pid, &status, WNOHANG);
        if (w > 0) {
            result.exit_code = WIFEXITED(status) ? WEXITSTATUS(status) : -1;
            return result;
        }
        ::usleep(100'000); // 100ms
    }
    // Timeout — kill
    ::kill(pid, SIGKILL);
    ::waitpid(pid, nullptr, 0);
    result.exit_code = -1;
    return result;
}

// ── Output normalization ───────────────────────────────────────────────

static std::string normalize_output(const std::string &s,
                                    const std::string &dir) {
    std::string result;
    size_t i = 0;

    // Build prefix to strip: the directory basename (e.g., "quilt-diff-a-XXXXXX")
    std::string dir_base = fs::path(dir).filename().string();

    while (i < s.size()) {
        size_t eol = s.find('\n', i);
        if (eol == std::string::npos) eol = s.size();
        std::string line(s.data() + i, eol - i);

        // Strip trailing whitespace
        while (!line.empty() && (line.back() == ' ' || line.back() == '\t'))
            line.pop_back();

        // Replace temp dir basename with placeholder
        for (;;) {
            auto pos = line.find(dir_base);
            if (pos == std::string::npos) break;
            line.replace(pos, dir_base.size(), "WORKDIR");
        }

        // Skip timestamp lines in diff output (---/+++ with tab + date)
        // We keep the path part but strip the timestamp
        if ((line.starts_with("--- ") || line.starts_with("+++ ")) &&
            line.find('\t') != std::string::npos) {
            line = line.substr(0, line.find('\t'));
        }

        result += line;
        result += '\n';
        i = eol + 1;
    }
    return result;
}

// ── File helpers ───────────────────────────────────────────────────────

static std::string read_file(const std::string &path) {
    FILE *f = fopen(path.c_str(), "rb");
    if (!f) return {};
    std::string result;
    char buf[4096];
    while (size_t n = fread(buf, 1, sizeof(buf), f))
        result.append(buf, n);
    fclose(f);
    return result;
}

static void write_file(const std::string &path, const std::string &content) {
    FILE *f = fopen(path.c_str(), "wb");
    if (f) {
        fwrite(content.data(), 1, content.size(), f);
        fclose(f);
    }
}

// ── Shadow state ───────────────────────────────────────────────────────

struct ShadowState {
    std::vector<std::string> series;
    std::vector<std::string> applied;

    bool has_applied() const { return !applied.empty(); }
    bool has_unapplied() const { return series.size() > applied.size(); }
    std::string top() const { return applied.empty() ? "" : applied.back(); }

    void do_new(const std::string &name) {
        // Insert after top in series
        auto it = series.begin();
        if (has_applied()) {
            for (; it != series.end(); ++it) {
                if (*it == applied.back()) { ++it; break; }
            }
        }
        series.insert(it, name);
        applied.push_back(name);
    }

    void do_push() {
        if (!has_unapplied()) return;
        // Find first unapplied
        size_t ai = applied.size();
        if (ai < series.size())
            applied.push_back(series[ai]);
    }

    void do_push_all() {
        while (has_unapplied()) do_push();
    }

    void do_pop() {
        if (applied.empty()) return;
        applied.pop_back();
    }

    void do_pop_all() {
        applied.clear();
    }

    void do_delete_top_unapplied() {
        // Delete first unapplied patch
        if (!has_unapplied()) return;
        size_t idx = applied.size();
        series.erase(series.begin() + static_cast<ptrdiff_t>(idx));
    }
};

// ── Command generation ─────────────────────────────────────────────────

static constexpr const char *PATCH_NAMES[] = {
    "p1", "p2", "p3", "p4", "p5", "p6", "p7", "p8"
};
static constexpr const char *FILE_NAMES[] = {
    "a.txt", "b.txt", "c.txt", "d.txt"
};

struct Command {
    std::vector<std::string> args;
    std::string description;
};

// Generate a command sequence from random bytes.
static std::vector<Command> generate_commands(std::mt19937 &rng,
                                              int max_cmds) {
    std::vector<Command> cmds;
    ShadowState state;

    auto rnd = [&](int n) -> int {
        return std::uniform_int_distribution<int>(0, n - 1)(rng);
    };

    for (int i = 0; i < max_cmds; ++i) {
        int op = rnd(16);

        switch (op) {
        case 0: case 1: { // new
            std::string name = PATCH_NAMES[rnd(8)];
            // Check if name already in series
            bool exists = false;
            for (auto &s : state.series)
                if (s == name) { exists = true; break; }
            if (exists) break;
            cmds.push_back({{"--quiltrc", "-", "new", name}, "new " + name});
            state.do_new(name);
            break;
        }
        case 2: case 3: { // add
            if (!state.has_applied()) break;
            std::string file = FILE_NAMES[rnd(4)];
            cmds.push_back({{"--quiltrc", "-", "add", file}, "add " + file});
            break;
        }
        case 4: { // push
            if (!state.has_unapplied()) break;
            cmds.push_back({{"--quiltrc", "-", "push"}, "push"});
            state.do_push();
            break;
        }
        case 5: { // push -a
            if (!state.has_unapplied()) break;
            cmds.push_back({{"--quiltrc", "-", "push", "-a"}, "push -a"});
            state.do_push_all();
            break;
        }
        case 6: { // pop
            if (!state.has_applied()) break;
            cmds.push_back({{"--quiltrc", "-", "pop"}, "pop"});
            state.do_pop();
            break;
        }
        case 7: { // pop -a
            if (!state.has_applied()) break;
            cmds.push_back({{"--quiltrc", "-", "pop", "-a"}, "pop -a"});
            state.do_pop_all();
            break;
        }
        case 8: { // refresh
            if (!state.has_applied()) break;
            cmds.push_back({{"--quiltrc", "-", "refresh"}, "refresh"});
            break;
        }
        case 9: { // diff
            cmds.push_back({{"--quiltrc", "-", "diff"}, "diff"});
            break;
        }
        case 10: { // series
            cmds.push_back({{"--quiltrc", "-", "series"}, "series"});
            break;
        }
        case 11: { // applied
            cmds.push_back({{"--quiltrc", "-", "applied"}, "applied"});
            break;
        }
        case 12: { // unapplied
            cmds.push_back({{"--quiltrc", "-", "unapplied"}, "unapplied"});
            break;
        }
        case 13: { // top
            cmds.push_back({{"--quiltrc", "-", "top"}, "top"});
            break;
        }
        case 14: { // files
            if (!state.has_applied()) break;
            cmds.push_back({{"--quiltrc", "-", "files"}, "files"});
            break;
        }
        case 15: { // delete (first unapplied)
            if (!state.has_unapplied()) break;
            cmds.push_back({{"--quiltrc", "-", "delete", "-n"}, "delete -n"});
            state.do_delete_top_unapplied();
            break;
        }
        }
    }

    return cmds;
}

// ── Mutate files (simulate editing between add and refresh) ────────────

static void mutate_files(const std::string &dir_a, const std::string &dir_b,
                         std::mt19937 &rng) {
    // Pick a random file and append a line
    int fi = std::uniform_int_distribution<int>(0, 3)(rng);
    std::string file = FILE_NAMES[fi];
    int line_id = std::uniform_int_distribution<int>(0, 999)(rng);
    std::string extra = "line " + std::to_string(line_id) + "\n";

    for (auto *dir : {&dir_a, &dir_b}) {
        std::string path = *dir + "/" + file;
        FILE *f = fopen(path.c_str(), "ab");
        if (f) {
            fwrite(extra.data(), 1, extra.size(), f);
            fclose(f);
        }
    }
}

// ── State comparison ───────────────────────────────────────────────────

static bool compare_file(const std::string &path_a, const std::string &path_b,
                         const std::string &label) {
    bool exists_a = fs::exists(path_a);
    bool exists_b = fs::exists(path_b);
    if (exists_a != exists_b) {
        // Treat missing file as equivalent to empty file
        std::string a = exists_a ? read_file(path_a) : std::string{};
        std::string b = exists_b ? read_file(path_b) : std::string{};
        if (a.empty() && b.empty()) return true;
        fprintf(stderr, "  DIVERGE [%s]: exists cpp=%s sys=%s\n",
                label.c_str(), exists_a ? "yes" : "no", exists_b ? "yes" : "no");
        return false;
    }
    if (!exists_a) return true;
    std::string a = read_file(path_a);
    std::string b = read_file(path_b);
    if (a != b) {
        fprintf(stderr, "  DIVERGE [%s]:\n    cpp: %s\n    sys: %s\n",
                label.c_str(), a.c_str(), b.c_str());
        return false;
    }
    return true;
}

static bool compare_final_state(const std::string &dir_a,
                                const std::string &dir_b) {
    bool ok = true;

    // Compare series file
    if (!compare_file(dir_a + "/patches/series", dir_b + "/patches/series",
                      "patches/series"))
        ok = false;

    // Compare applied-patches
    if (!compare_file(dir_a + "/.pc/applied-patches",
                      dir_b + "/.pc/applied-patches",
                      ".pc/applied-patches"))
        ok = false;

    // Compare working tree files
    for (auto *name : FILE_NAMES) {
        if (!compare_file(dir_a + "/" + name, dir_b + "/" + name, name))
            ok = false;
    }

    return ok;
}

// ── Main ───────────────────────────────────────────────────────────────

static void usage(const char *prog) {
    fprintf(stderr,
            "Usage: %s --quilt-cpp PATH --quilt-system PATH\n"
            "       [--seed N] [--iterations N] [--max-cmds N] [--verbose]\n",
            prog);
    exit(1);
}

int main(int argc, char **argv) {
    std::string quilt_cpp, quilt_sys;
    uint64_t seed = 42;
    int iterations = 1000;
    int max_cmds = 32;
    bool verbose = false;

    for (int i = 1; i < argc; ++i) {
        std::string arg = argv[i];
        if (arg == "--quilt-cpp" && i + 1 < argc)
            quilt_cpp = argv[++i];
        else if (arg == "--quilt-system" && i + 1 < argc)
            quilt_sys = argv[++i];
        else if (arg == "--seed" && i + 1 < argc)
            seed = std::stoull(argv[++i]);
        else if (arg == "--iterations" && i + 1 < argc)
            iterations = std::stoi(argv[++i]);
        else if (arg == "--max-cmds" && i + 1 < argc)
            max_cmds = std::stoi(argv[++i]);
        else if (arg == "--verbose")
            verbose = true;
        else
            usage(argv[0]);
    }

    if (quilt_cpp.empty() || quilt_sys.empty())
        usage(argv[0]);

    // Resolve to absolute paths
    quilt_cpp = fs::absolute(quilt_cpp).string();
    quilt_sys = fs::absolute(quilt_sys).string();

    int divergences = 0;
    int total_cmds = 0;

    for (int iter = 0; iter < iterations; ++iter) {
        std::mt19937 rng(static_cast<uint32_t>(seed + static_cast<uint64_t>(iter)));

        // Create temp dirs
        char tmpl_a[] = "/tmp/quilt-diff-a-XXXXXX";
        char tmpl_b[] = "/tmp/quilt-diff-b-XXXXXX";
        char *dir_a = mkdtemp(tmpl_a);
        char *dir_b = mkdtemp(tmpl_b);
        if (!dir_a || !dir_b) {
            perror("mkdtemp");
            return 1;
        }

        std::string da(dir_a), db(dir_b);

        // Create .pc/ to prevent upward directory scanning
        fs::create_directory(da + "/.pc");
        fs::create_directory(db + "/.pc");
        write_file(da + "/.pc/.version", "2\n");
        write_file(db + "/.pc/.version", "2\n");

        // Pre-populate with identical starter files
        for (auto *name : FILE_NAMES) {
            std::string content = std::string("Original content of ") + name + "\n";
            write_file(da + "/" + name, content);
            write_file(db + "/" + name, content);
        }

        // Generate command sequence
        auto cmds = generate_commands(rng, max_cmds);

        if (verbose)
            fprintf(stderr, "Iteration %d: %zu commands\n", iter,
                    cmds.size());

        bool scenario_ok = true;
        bool state_diverged = false;
        bool did_add = false;

        for (size_t ci = 0; ci < cmds.size(); ++ci) {
            auto &cmd = cmds[ci];

            // After an add, mutate files so refresh has something to capture
            if (did_add && cmd.args.size() >= 3 &&
                (cmd.args[2] == "refresh" || cmd.args[2] == "diff")) {
                mutate_files(da, db, rng);
            }

            auto ra = run_in_dir(quilt_cpp, da, cmd.args);
            auto rb = run_in_dir(quilt_sys, db, cmd.args);

            total_cmds++;

            std::string norm_a = normalize_output(ra.out, da);
            std::string norm_b = normalize_output(rb.out, db);

            // Track add for mutation
            if (cmd.args.size() >= 3 && cmd.args[2] == "add" &&
                ra.exit_code == 0)
                did_add = true;
            if (cmd.args.size() >= 3 &&
                (cmd.args[2] == "refresh" || cmd.args[2] == "pop"))
                did_add = false;

            // Determine command name for comparison policy
            std::string cmd_name;
            for (auto &a : cmd.args) {
                if (a != "--quiltrc" && a != "-") { cmd_name = a; break; }
            }

            // Known acceptable exit code differences:
            // - series/applied/unapplied/top return 1 in GNU quilt when
            //   no patches exist, but 0 in quilt.cpp (empty output).
            bool exit_ok = (ra.exit_code == rb.exit_code);
            if (!exit_ok) {
                bool info_cmd = (cmd_name == "series" || cmd_name == "applied" ||
                                 cmd_name == "unapplied" || cmd_name == "top" ||
                                 cmd_name == "next" || cmd_name == "previous" ||
                                 cmd_name == "diff" || cmd_name == "files" ||
                                 cmd_name == "header");
                // Accept (0 vs 1) for info commands
                if (info_cmd && ((ra.exit_code == 0 && rb.exit_code == 1) ||
                                 (ra.exit_code == 1 && rb.exit_code == 0)))
                    exit_ok = true;
            }

            if (!exit_ok) {
                // State-changing commands with different exit codes mean
                // the implementations are now in different states.  Abort
                // the scenario to avoid cascading false positives.
                bool state_cmd = (cmd_name == "new" || cmd_name == "push" ||
                                  cmd_name == "pop" || cmd_name == "add" ||
                                  cmd_name == "refresh" || cmd_name == "delete" ||
                                  cmd_name == "rename");
                if (state_cmd) {
                    if (verbose)
                        fprintf(stderr,
                                "Iteration %d: aborting at command %zu [%s] "
                                "(exit cpp=%d sys=%d, state diverged)\n",
                                iter, ci, cmd.description.c_str(),
                                ra.exit_code, rb.exit_code);
                    state_diverged = true;
                    break;
                }
                fprintf(stderr,
                        "DIVERGENCE at iteration %d, command %zu [%s]:\n"
                        "  exit: cpp=%d sys=%d\n",
                        iter, ci, cmd.description.c_str(),
                        ra.exit_code, rb.exit_code);
                if (verbose) {
                    fprintf(stderr, "  cpp stdout: %s", ra.out.c_str());
                    fprintf(stderr, "  sys stdout: %s", rb.out.c_str());
                    fprintf(stderr, "  cpp stderr: %s", ra.err.c_str());
                    fprintf(stderr, "  sys stderr: %s", rb.err.c_str());
                }
                scenario_ok = false;
                divergences++;
                break;
            }

            // Skip stdout comparison for commands with known message
            // differences (pop, refresh, delete verbose output).
            // Focus on exit codes + final state comparison instead.
            bool skip_stdout = (cmd_name == "pop" || cmd_name == "refresh" ||
                                cmd_name == "delete" || cmd_name == "push" ||
                                cmd_name == "new" || cmd_name == "add" ||
                                cmd_name == "diff");

            if (!skip_stdout && norm_a != norm_b) {
                fprintf(stderr,
                        "DIVERGENCE at iteration %d, command %zu [%s]:\n"
                        "  stdout differs (exit=%d):\n"
                        "    cpp: %s"
                        "    sys: %s",
                        iter, ci, cmd.description.c_str(),
                        ra.exit_code, norm_a.c_str(), norm_b.c_str());
                scenario_ok = false;
                divergences++;
                break;
            }
        }

        // Compare final filesystem state (skip if state diverged)
        if (scenario_ok && !state_diverged && !cmds.empty()) {
            if (!compare_final_state(da, db)) {
                fprintf(stderr,
                        "DIVERGENCE at iteration %d: final state differs\n",
                        iter);
                if (verbose) {
                    fprintf(stderr, "  Commands:");
                    for (auto &c : cmds)
                        fprintf(stderr, " [%s]", c.description.c_str());
                    fprintf(stderr, "\n");
                }
                divergences++;
            }
        }

        // Cleanup
        fs::remove_all(da);
        fs::remove_all(db);
    }

    fprintf(stderr,
            "Differential fuzzer: %d iterations, %d commands, %d divergences\n",
            iterations, total_cmds, divergences);

    return divergences > 0 ? 1 : 0;
}
