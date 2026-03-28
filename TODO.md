# TODO

## Test coverage

Done.

## Man page

Done. Fixed fuzz default (was 0, should be 2) and a fuzz bug where
add-only hunks miscounted prefix/suffix context.

Not yet implemented (noted, not bugs):
- Pager support (`QUILT_PAGER`, `LESS`)
- `QUILT_COLORS` / `--color` output
- `--trace` (accepted, ignored)
- `graph -T ps` (PostScript output)
- `grep`, `setup`, `shell` commands (stubs)
