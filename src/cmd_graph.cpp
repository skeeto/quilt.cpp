// This is free and unencumbered software released into the public domain.
#include "quilt.hpp"
#include "platform.hpp"
#include <cmath>
#include <iomanip>
#include <map>
#include <optional>
#include <regex>
#include <set>
#include <sstream>

extern std::string pc_patch_dir(const QuiltState &q, std::string_view patch);
extern std::vector<std::string> files_in_patch(const QuiltState &q, std::string_view patch);

namespace {

struct LineRanges {
    bool computed = false;
    std::vector<int> left;
    std::vector<int> right;
};

struct GraphNode {
    int number = 0;
    std::string name;
    std::map<std::string, LineRanges> files;
    std::vector<std::string> attrs;
};

struct EdgeData {
    std::vector<std::string> names;
};

using EdgeKey = std::pair<int, int>;

std::string strip_patches_prefix(const QuiltState &q, std::string_view name) {
    std::string prefix = q.patches_dir + "/";
    if (starts_with(name, prefix)) {
        return std::string(name.substr(prefix.size()));
    }
    return std::string(name);
}

bool is_number(std::string_view value) {
    if (value.empty()) return false;
    for (char c : value) {
        if (c < '0' || c > '9') return false;
    }
    return true;
}

bool is_zero_length_file(std::string_view path) {
    return file_exists(path) && read_file(path).empty();
}

std::string dot_escape(std::string_view text) {
    std::string escaped;
    escaped.reserve(text.size());
    for (char c : text) {
        if (c == '\\' || c == '"') {
            escaped += '\\';
            escaped += c;
        } else if (c == '\n') {
            escaped += "\\n";
        } else {
            escaped += c;
        }
    }
    return escaped;
}

int parse_hunk_count(const std::ssub_match &match) {
    if (!match.matched || match.str().empty()) {
        return 1;
    }
    return std::stoi(match.str());
}

LineRanges parse_ranges(std::string_view diff_text) {
    static const std::regex hunk_regex(
        R"(^@@ -([0-9]+)(?:,([0-9]+))? \+([0-9]+)(?:,([0-9]+))? @@)");

    LineRanges ranges;
    ranges.computed = true;
    for (const auto &line : split_lines(diff_text)) {
        std::smatch match;
        if (!std::regex_search(line, match, hunk_regex)) continue;

        int old_start = std::stoi(match[1].str());
        int old_count = parse_hunk_count(match[2]);
        int new_start = std::stoi(match[3].str());
        int new_count = parse_hunk_count(match[4]);

        ranges.left.push_back(new_start);
        ranges.left.push_back(new_start + new_count);
        ranges.right.push_back(old_start);
        ranges.right.push_back(old_start + old_count);
    }
    return ranges;
}

std::optional<int> next_patch_for_file(const std::vector<GraphNode> &nodes,
                                       int index,
                                       std::string_view file) {
    for (int i = index + 1; i < static_cast<int>(nodes.size()); ++i) {
        if (nodes[i].files.find(std::string(file)) != nodes[i].files.end()) {
            return i;
        }
    }
    return std::nullopt;
}

void compute_ranges(const QuiltState &q,
                    std::vector<GraphNode> &nodes,
                    int index,
                    std::string_view file,
                    int context_lines) {
    auto it = nodes[index].files.find(std::string(file));
    if (it == nodes[index].files.end() || it->second.computed) return;

    LineRanges &ranges = it->second;
    ranges.computed = true;

    std::string old_path = path_join(pc_patch_dir(q, nodes[index].name), file);
    std::string new_path;
    auto next = next_patch_for_file(nodes, index, file);
    if (next.has_value()) {
        new_path = path_join(pc_patch_dir(q, nodes[*next].name), file);
    } else {
        new_path = path_join(q.work_dir, file);
    }

    bool old_missing = is_zero_length_file(old_path);
    bool new_missing = is_zero_length_file(new_path);
    if (old_missing && new_missing) {
        return;
    }

    std::vector<std::string> diff_cmd = {
        "diff",
        "-U" + std::to_string(context_lines),
        old_missing ? "/dev/null" : old_path,
        new_missing ? "/dev/null" : new_path,
    };
    ProcessResult diff = run_cmd(diff_cmd);
    if (diff.exit_code == 2) {
        return;
    }

    ranges = parse_ranges(diff.out);
}

bool is_conflict(const QuiltState &q,
                 std::vector<GraphNode> &nodes,
                 int from,
                 int to,
                 std::string_view file,
                 int context_lines) {
    compute_ranges(q, nodes, from, file, context_lines);
    compute_ranges(q, nodes, to, file, context_lines);

    const auto file_key = std::string(file);
    const auto &a = nodes[from].files[file_key].right;
    const auto &b = nodes[to].files[file_key].left;

    size_t ia = 0;
    size_t ib = 0;
    while (ia < a.size() && ib < b.size()) {
        size_t rem_a = a.size() - ia;
        size_t rem_b = b.size() - ib;
        if (a[ia] < b[ib]) {
            if ((rem_b % 2u) == 1u) return true;
            ++ia;
        } else if (a[ia] > b[ib]) {
            if ((rem_a % 2u) == 1u) return true;
            ++ib;
        } else {
            if ((rem_a % 2u) == (rem_b % 2u)) return true;
            ++ia;
            ++ib;
        }
    }
    return false;
}

void add_edge(std::map<EdgeKey, EdgeData> &edges,
              int earlier,
              int later,
              std::string_view file) {
    auto &edge = edges[{earlier, later}];
    edge.names.emplace_back(file);
}

std::set<int> collect_reachable(const std::map<EdgeKey, EdgeData> &edges,
                                int start,
                                bool forward) {
    std::map<int, std::vector<int>> adjacency;
    for (const auto &[key, value] : edges) {
        (void)value;
        int from = key.first;
        int to = key.second;
        if (forward) {
            adjacency[from].push_back(to);
        } else {
            adjacency[to].push_back(from);
        }
    }

    std::set<int> seen;
    std::vector<int> stack = {start};
    while (!stack.empty()) {
        int node = stack.back();
        stack.pop_back();
        if (!seen.insert(node).second) continue;
        auto it = adjacency.find(node);
        if (it == adjacency.end()) continue;
        for (int next : it->second) {
            stack.push_back(next);
        }
    }
    return seen;
}

bool has_alternate_path(int from,
                        int to,
                        const std::map<int, std::vector<int>> &adjacency,
                        EdgeKey skip_edge) {
    std::vector<int> stack = {from};
    std::set<int> seen;
    while (!stack.empty()) {
        int node = stack.back();
        stack.pop_back();
        if (!seen.insert(node).second) continue;

        auto it = adjacency.find(node);
        if (it == adjacency.end()) continue;
        for (int next : it->second) {
            if (EdgeKey{node, next} == skip_edge) continue;
            if (next == to) return true;
            stack.push_back(next);
        }
    }
    return false;
}

void reduce_edges(std::map<EdgeKey, EdgeData> &edges) {
    std::map<int, std::vector<int>> adjacency;
    for (const auto &[key, value] : edges) {
        (void)value;
        adjacency[key.first].push_back(key.second);
    }

    std::vector<EdgeKey> to_remove;
    for (const auto &[key, value] : edges) {
        (void)value;
        if (has_alternate_path(key.first, key.second, adjacency, key)) {
            to_remove.push_back(key);
        }
    }

    for (const auto &key : to_remove) {
        edges.erase(key);
    }
}

std::string format_len_attr(int from, int to) {
    std::ostringstream value;
    value << std::fixed << std::setprecision(2)
          << std::log(static_cast<double>(std::abs(to - from) + 3));
    return "len=\"" + value.str() + "\"";
}

std::string render_dot(const std::vector<GraphNode> &nodes,
                       std::map<EdgeKey, EdgeData> edges,
                       std::set<int> used_nodes,
                       bool reduce,
                       bool edge_labels) {
    if (reduce) {
        reduce_edges(edges);
        used_nodes.clear();
        for (const auto &[key, value] : edges) {
            (void)value;
            used_nodes.insert(key.first);
            used_nodes.insert(key.second);
        }
    }

    std::string dot = "digraph dependencies {\n";
    for (const auto &node : nodes) {
        if (used_nodes.find(node.number) == used_nodes.end()) continue;

        std::vector<std::string> attrs = node.attrs;
        attrs.push_back("label=\"" + dot_escape(node.name) + "\"");

        dot += "\tn" + std::to_string(node.number);
        if (!attrs.empty()) {
            dot += " [";
            for (size_t i = 0; i < attrs.size(); ++i) {
                if (i != 0) dot += ",";
                dot += attrs[i];
            }
            dot += "]";
        }
        dot += ";\n";
    }

    for (auto &[key, edge] : edges) {
        std::sort(edge.names.begin(), edge.names.end());
        edge.names.erase(std::unique(edge.names.begin(), edge.names.end()), edge.names.end());

        std::vector<std::string> attrs;
        if (edge_labels && !edge.names.empty()) {
            std::string label;
            for (size_t i = 0; i < edge.names.size(); ++i) {
                if (i != 0) label += "\\n";
                label += dot_escape(edge.names[i]);
            }
            attrs.push_back("label=\"" + label + "\"");
        }
        attrs.push_back(format_len_attr(key.first, key.second));

        dot += "\tn" + std::to_string(key.first) + " -> n" + std::to_string(key.second);
        dot += " [";
        for (size_t i = 0; i < attrs.size(); ++i) {
            if (i != 0) dot += ",";
            dot += attrs[i];
        }
        dot += "];\n";
    }

    dot += "}\n";
    return dot;
}

} // namespace

int cmd_graph(QuiltState &q, int argc, char **argv) {
    bool opt_all = false;
    bool opt_reduce = false;
    bool opt_edge_labels = false;
    std::optional<int> opt_lines;
    std::string patch_arg;

    for (int i = 1; i < argc; ++i) {
        std::string_view arg = argv[i];
        if (arg == "--all") {
            opt_all = true;
        } else if (arg == "--reduce") {
            opt_reduce = true;
        } else if (arg == "--lines") {
            opt_lines = 2;
            if (i + 1 < argc && is_number(argv[i + 1])) {
                opt_lines = std::stoi(argv[++i]);
            }
        } else if (starts_with(arg, "--lines=")) {
            std::string value(arg.substr(8));
            if (!is_number(value)) {
                err_line("Usage: quilt graph [--all] [--reduce] [--lines[=num]] [--edge-labels=files] [-T ps] [patch]");
                return 1;
            }
            opt_lines = std::stoi(value);
        } else if (arg == "--edge-labels") {
            if (i + 1 >= argc || std::string_view(argv[i + 1]) != "files") {
                err_line("Usage: quilt graph [--all] [--reduce] [--lines[=num]] [--edge-labels=files] [-T ps] [patch]");
                return 1;
            }
            opt_edge_labels = true;
            ++i;
        } else if (arg == "--edge-labels=files") {
            opt_edge_labels = true;
        } else if (arg == "-T") {
            if (i + 1 >= argc || std::string_view(argv[i + 1]) != "ps") {
                err_line("Usage: quilt graph [--all] [--reduce] [--lines[=num]] [--edge-labels=files] [-T ps] [patch]");
                return 1;
            }
            ++i;
            err_line("quilt graph -T ps: not implemented");
            return 1;
        } else if (arg == "-Tps") {
            err_line("quilt graph -T ps: not implemented");
            return 1;
        } else if (!arg.empty() && arg[0] == '-') {
            err_line("Usage: quilt graph [--all] [--reduce] [--lines[=num]] [--edge-labels=files] [-T ps] [patch]");
            return 1;
        } else if (!patch_arg.empty()) {
            err_line("Usage: quilt graph [--all] [--reduce] [--lines[=num]] [--edge-labels=files] [-T ps] [patch]");
            return 1;
        } else {
            patch_arg = strip_patches_prefix(q, arg);
        }
    }

    if (!patch_arg.empty() && opt_all) {
        err_line("Usage: quilt graph [--all] [--reduce] [--lines[=num]] [--edge-labels=files] [-T ps] [patch]");
        return 1;
    }

    std::string selected_patch;
    if (!opt_all) {
        if (q.applied.empty()) {
            if (!q.series_file_exists) {
                err_line("No series file found");
            } else if (q.series.empty()) {
                err_line("No patches in series");
            } else {
                err_line("No patches applied");
            }
            return 1;
        }

        selected_patch = patch_arg.empty() ? q.applied.back() : patch_arg;
        if (!q.find_in_series(selected_patch).has_value()) {
            err_line("Patch " + selected_patch + " is not in series");
            return 1;
        }
        if (!q.is_applied(selected_patch)) {
            err_line("Patch " + selected_patch + " is not applied");
            return 1;
        }
    } else if (q.applied.empty()) {
        err_line("No patches applied");
        return 1;
    }

    std::vector<GraphNode> nodes;
    nodes.reserve(q.applied.size());
    for (size_t i = 0; i < q.applied.size(); ++i) {
        const std::string &patch = q.applied[i];
        auto files = files_in_patch(q, patch);
        std::sort(files.begin(), files.end());

        GraphNode node;
        node.number = static_cast<int>(i);
        node.name = patch;
        for (const auto &file : files) {
            node.files.emplace(file, LineRanges{});
        }
        nodes.push_back(std::move(node));
    }

    std::set<int> used_nodes;
    if (!selected_patch.empty()) {
        auto selected = std::find_if(nodes.begin(), nodes.end(),
                                     [&](const GraphNode &node) {
                                         return node.name == selected_patch;
                                     });
        if (selected == nodes.end()) {
            err_line("Patch " + selected_patch + " is not applied");
            return 1;
        }

        selected->attrs.push_back("style=bold");

        std::set<std::string> selected_files;
        for (const auto &[file, ranges] : selected->files) {
            (void)ranges;
            selected_files.insert(file);
        }
        for (auto &node : nodes) {
            for (auto it = node.files.begin(); it != node.files.end(); ) {
                if (selected_files.find(it->first) == selected_files.end()) {
                    it = node.files.erase(it);
                } else {
                    ++it;
                }
            }
        }
    }

    std::map<std::string, std::vector<int>> files_seen;
    std::map<EdgeKey, EdgeData> edges;
    for (auto &node : nodes) {
        for (const auto &[file, ranges] : node.files) {
            (void)ranges;
            auto seen_it = files_seen.find(file);
            if (seen_it != files_seen.end()) {
                std::optional<int> dependency;
                if (opt_lines.has_value()) {
                    for (auto prev = seen_it->second.rbegin();
                         prev != seen_it->second.rend();
                         ++prev) {
                        if (is_conflict(q, nodes, node.number, *prev, file, *opt_lines)) {
                            dependency = *prev;
                            break;
                        }
                    }
                } else {
                    dependency = seen_it->second.back();
                }

                if (dependency.has_value()) {
                    add_edge(edges, *dependency, node.number, file);
                    used_nodes.insert(*dependency);
                    used_nodes.insert(node.number);
                }
            }
            files_seen[file].push_back(node.number);
        }
    }

    if (!selected_patch.empty()) {
        int selected_index = -1;
        for (const auto &node : nodes) {
            if (node.name == selected_patch) {
                selected_index = node.number;
                break;
            }
        }

        std::set<int> reachable = collect_reachable(edges, selected_index, true);
        std::set<int> reverse = collect_reachable(edges, selected_index, false);
        reachable.insert(reverse.begin(), reverse.end());

        for (auto it = edges.begin(); it != edges.end(); ) {
            if (reachable.find(it->first.first) == reachable.end() ||
                reachable.find(it->first.second) == reachable.end()) {
                it = edges.erase(it);
            } else {
                ++it;
            }
        }
        used_nodes = std::move(reachable);
    }

    std::string dot = render_dot(nodes, edges, used_nodes, opt_reduce, opt_edge_labels);
    out(dot);
    return 0;
}
