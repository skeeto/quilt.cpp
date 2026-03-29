// This is free and unencumbered software released into the public domain.
#include "quilt.hpp"
#include "platform.hpp"

static int not_implemented(const char *name)
{
    err("quilt ");
    err(name);
    err_line(": not implemented");
    return 1;
}

int cmd_grep(QuiltState &, int, char **)     { return not_implemented("grep"); }
int cmd_shell(QuiltState &, int, char **)    { return not_implemented("shell"); }
