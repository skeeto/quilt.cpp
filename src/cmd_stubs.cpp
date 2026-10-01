// This is free and unencumbered software released into the public domain.
#include "quilt.hpp"
#include "platform.hpp"

// Print the help for -h or --help ahead of any "--", else refuse to run
static int not_implemented(int argc, char **argv)
{
    for (int i = 1; i < argc; ++i) {
        std::string_view arg = argv[i];
        if (arg == "--") break;
        if (arg == "-h" || arg == "--help") return command_help(argv[0]);
    }
    err("quilt ");
    err(argv[0]);
    err_line(": not implemented");
    return 1;
}

int cmd_grep(QuiltState &, int argc, char **argv)  { return not_implemented(argc, argv); }
int cmd_setup(QuiltState &, int argc, char **argv) { return not_implemented(argc, argv); }
int cmd_shell(QuiltState &, int argc, char **argv) { return not_implemented(argc, argv); }
