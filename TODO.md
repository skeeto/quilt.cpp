# TODO: Unimplemented flags and features

Comparison of `docs/quilt.1` (original quilt manpage) against quilt.cpp source.
Each entry notes the flag, which command it belongs to, and its current status.

Legend:
- **missing** — not parsed at all
- **parsed, ignored** — option is consumed but has no effect
- **parsed, rejected** — option is consumed and returns an error
- **stub** — entire command is unimplemented

## Global options

- [ ] `--trace` — missing. Shell trace mode; may need a C++ equivalent (verbose logging?).

## push (`cmd_stack.cpp`)

- [x] `-v` — Verbose output.
- [x] `--fuzz=N` — Set maximum fuzz factor for patch(1).
- [x] `-m` / `--merge[=merge|diff3]` — Use patch(1) merge mode.
- [x] `--leave-rejects` — Keep .rej files even without `-f`.
- [ ] `--color[=always|auto|never]` — missing. Colorize patch(1) output.
- [x] `--refresh` — Auto-refresh after each successful push.

## pop (`cmd_stack.cpp`)

- [x] `-v` — missing. Verbose output.
- [x] `-R` — parsed, ignored. Should verify patch removes cleanly instead of relying on timestamps.
- [x] `--refresh` — missing. Auto-refresh before each pop.

## series (`cmd_stack.cpp`)

- [ ] `--color[=always|auto|never]` — missing. Colorize applied/unapplied patches.

## diff (`cmd_patch.cpp`)

- [x] `-c` / `-C num` — implemented. Context diff format.
- [x] `-U num` — implemented. Unified context line count passed to diff.
- [x] `--combine patch` — implemented. Combined diff across a range of patches.
- [x] `--diff=utility` — implemented. Use alternate diff program.
- [x] `--sort` — implemented. Sort files alphabetically.
- [ ] `--color[=always|auto|never]` — missing. Syntax coloring.

## refresh (`cmd_patch.cpp`)

- [ ] `-u` / `-U num` — missing. Unified diff with custom context lines.
- [ ] `-c` / `-C num` — missing. Context diff format.
- [ ] `-z[new_name]` — missing. Fork changes to a new patch instead of refreshing.
- [ ] `--diffstat` — missing. Add/replace diffstat section in patch header.
- [ ] `--backup` — missing. Save old patch as `patch~`.
- [ ] `--strip-trailing-whitespace` — missing. Strip trailing whitespace.

## new (`cmd_patch.cpp`)

- [ ] `-p n` / `-p ab` — parsed, ignored. Strip level is consumed but not stored or written to the series file.

## import (`cmd_manage.cpp`)

- [ ] `-R` — missing. Mark imported patch as reversed in the series file.
- [ ] `-p num` — parsed, ignored. Strip level is consumed but not written to the series file.
- [ ] `-d {o|a|n}` — parsed, ignored. Duplicate header mode has no effect.

## header (`cmd_manage.cpp`)

- [ ] `--dep3` — parsed, ignored. Should insert DEP-3 template when editing.
- [ ] `--strip-diffstat` — parsed, ignored. Should strip diffstat from header.
- [ ] `--strip-trailing-whitespace` — parsed, ignored. Should strip trailing whitespace.

## files (`cmd_manage.cpp`)

- [ ] `-l` — parsed, ignored. Should prefix each file with its patch name.
- [ ] `--combine patch` — parsed, ignored. Should list files for a range of patches.

## patches (`cmd_manage.cpp`)

- [ ] `--color[=always|auto|never]` — parsed, ignored. Should colorize applied/unapplied patches.

## graph (`cmd_graph.cpp`)

- [ ] `-T ps` — parsed, rejected. PostScript output via Graphviz.

## mail (`cmd_mail.cpp`)

These are intentional divergences (see README.md "Differences from Quilt"):

- [ ] `--send` — parsed, rejected. Direct sending not supported; output targets `git am`.
- [ ] `--subject` — parsed, ignored. Cover letter not generated.
- [ ] `-m text` — parsed, ignored. Cover letter not generated.
- [ ] `-M file` — parsed, ignored. Cover letter not generated.
- [ ] `--reply-to` — parsed, ignored. Cover letter not generated.
- [ ] `--charset` — parsed, ignored. Always UTF-8.
- [ ] `--signature` — parsed, ignored.

## Stub commands (`cmd_stubs.cpp`)

These commands exist but immediately return "not yet implemented":

- [ ] `grep` — recursive source search, skipping patches/ and .pc/.
- [ ] `setup` — initialize source tree from RPM spec or series file.
- [ ] `shell` — open a subshell in the quilt environment.
