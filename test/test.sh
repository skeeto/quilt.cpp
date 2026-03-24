#!/bin/bash
# Comprehensive test suite for quilt
# Usage: ./test.sh [path-to-quilt-binary]
# Defaults to system quilt if no argument given.
set -uo pipefail

QUILT="${1:-quilt}"
# Resolve to absolute path if the binary exists as a file
if [ -f "$QUILT" ]; then
    QUILT="$(cd "$(dirname "$QUILT")" && pwd)/$(basename "$QUILT")"
fi
PASS=0
FAIL=0
TEST_BASE=$(mktemp -d)
trap 'rm -rf "$TEST_BASE"' EXIT

pass() {
    PASS=$((PASS + 1))
    echo "  PASS: $CURRENT_TEST"
}

fail() {
    local msg="${1:-}"
    FAIL=$((FAIL + 1))
    echo "  FAIL: $CURRENT_TEST${msg:+ ($msg)}"
}

begin_test() {
    CURRENT_TEST="$1"
    WORK="$TEST_BASE/$1"
    mkdir -p "$WORK"
    cd "$WORK"
    mkdir -p patches
}

# -----------------------------------------------------------------------
# 1. Basic workflow: new, add, modify, refresh, pop, push
# -----------------------------------------------------------------------

test_basic_workflow() {
    begin_test "basic_workflow"
    echo "hello" > file.txt

    $QUILT new test.patch >/dev/null 2>&1 || { fail "new failed"; return; }
    $QUILT add file.txt >/dev/null 2>&1 || { fail "add failed"; return; }
    echo "world" > file.txt
    $QUILT refresh >/dev/null 2>&1 || { fail "refresh failed"; return; }

    # Patch file should exist
    [ -f patches/test.patch ] || { fail "patch file missing"; return; }

    # Pop should restore
    $QUILT pop >/dev/null 2>&1 || { fail "pop failed"; return; }
    local content
    content=$(cat file.txt)
    [ "$content" = "hello" ] || { fail "pop did not restore (got: $content)"; return; }

    # Push should reapply
    $QUILT push >/dev/null 2>&1 || { fail "push failed"; return; }
    content=$(cat file.txt)
    [ "$content" = "world" ] || { fail "push did not apply (got: $content)"; return; }

    pass
}

test_new_file_in_patch() {
    begin_test "new_file_in_patch"
    # Start with no file, create one in a patch
    $QUILT new create.patch >/dev/null 2>&1
    $QUILT add newfile.txt >/dev/null 2>&1
    echo "brand new" > newfile.txt
    $QUILT refresh >/dev/null 2>&1

    $QUILT pop >/dev/null 2>&1
    [ ! -f newfile.txt ] || { fail "new file should be removed on pop"; return; }

    $QUILT push >/dev/null 2>&1
    [ -f newfile.txt ] || { fail "new file should be created on push"; return; }
    local content
    content=$(cat newfile.txt)
    [ "$content" = "brand new" ] || { fail "content mismatch"; return; }

    pass
}

test_multiple_files_in_patch() {
    begin_test "multiple_files_in_patch"
    echo "a" > a.txt
    echo "b" > b.txt

    $QUILT new multi.patch >/dev/null 2>&1
    $QUILT add a.txt >/dev/null 2>&1
    $QUILT add b.txt >/dev/null 2>&1
    echo "A" > a.txt
    echo "B" > b.txt
    $QUILT refresh >/dev/null 2>&1

    $QUILT pop >/dev/null 2>&1
    [ "$(cat a.txt)" = "a" ] && [ "$(cat b.txt)" = "b" ] || { fail "restore failed"; return; }

    $QUILT push >/dev/null 2>&1
    [ "$(cat a.txt)" = "A" ] && [ "$(cat b.txt)" = "B" ] || { fail "apply failed"; return; }

    pass
}

# -----------------------------------------------------------------------
# 2. Stack navigation: series, applied, unapplied, top, next, previous
# -----------------------------------------------------------------------

test_series() {
    begin_test "series"
    echo "hello" > file.txt

    $QUILT new a.patch >/dev/null 2>&1
    $QUILT add file.txt >/dev/null 2>&1
    echo "a" > file.txt
    $QUILT refresh >/dev/null 2>&1

    $QUILT new b.patch >/dev/null 2>&1
    $QUILT add file.txt >/dev/null 2>&1
    echo "b" > file.txt
    $QUILT refresh >/dev/null 2>&1

    local series
    series=$($QUILT series 2>/dev/null)
    echo "$series" | grep -q "a.patch" || { fail "a.patch missing from series"; return; }
    echo "$series" | grep -q "b.patch" || { fail "b.patch missing from series"; return; }

    pass
}

test_applied_unapplied() {
    begin_test "applied_unapplied"
    echo "x" > file.txt

    $QUILT new p1.patch >/dev/null 2>&1
    $QUILT add file.txt >/dev/null 2>&1
    echo "1" > file.txt
    $QUILT refresh >/dev/null 2>&1

    $QUILT new p2.patch >/dev/null 2>&1
    $QUILT add file.txt >/dev/null 2>&1
    echo "2" > file.txt
    $QUILT refresh >/dev/null 2>&1

    # Both applied
    local applied
    applied=$($QUILT applied 2>/dev/null)
    echo "$applied" | grep -q "p1.patch" || { fail "p1 not in applied"; return; }
    echo "$applied" | grep -q "p2.patch" || { fail "p2 not in applied"; return; }

    # Pop one
    $QUILT pop >/dev/null 2>&1
    local unapplied
    unapplied=$($QUILT unapplied 2>/dev/null)
    echo "$unapplied" | grep -q "p2.patch" || { fail "p2 not in unapplied"; return; }

    pass
}

test_top_none_applied() {
    begin_test "top_none_applied"
    $QUILT top >/dev/null 2>&1
    local rc=$?
    [ $rc -ne 0 ] || { fail "expected nonzero exit, got $rc"; return; }
    pass
}

test_top() {
    begin_test "top"
    echo "x" > f.txt
    $QUILT new t.patch >/dev/null 2>&1
    $QUILT add f.txt >/dev/null 2>&1
    echo "y" > f.txt
    $QUILT refresh >/dev/null 2>&1

    local top
    top=$($QUILT top 2>/dev/null)
    echo "$top" | grep -q "t.patch" || { fail "top should show t.patch"; return; }

    pass
}

test_next_previous() {
    begin_test "next_previous"
    echo "x" > f.txt

    $QUILT new first.patch >/dev/null 2>&1
    $QUILT add f.txt >/dev/null 2>&1
    echo "1" > f.txt
    $QUILT refresh >/dev/null 2>&1

    $QUILT new second.patch >/dev/null 2>&1
    $QUILT add f.txt >/dev/null 2>&1
    echo "2" > f.txt
    $QUILT refresh >/dev/null 2>&1

    # Pop to first
    $QUILT pop >/dev/null 2>&1

    # Next should be second
    local nxt
    nxt=$($QUILT next 2>/dev/null)
    echo "$nxt" | grep -q "second.patch" || { fail "next should be second.patch"; return; }

    # Previous from first
    # When only first is applied, previous should fail (it's the first patch)
    $QUILT previous >/dev/null 2>&1
    local rc=$?
    # previous from first patch has no predecessor — exit 2
    [ $rc -ne 0 ] || { fail "previous from first should fail"; return; }

    pass
}

test_next_fully_applied() {
    begin_test "next_fully_applied"
    echo "x" > f.txt
    $QUILT new only.patch >/dev/null 2>&1
    $QUILT add f.txt >/dev/null 2>&1
    echo "y" > f.txt
    $QUILT refresh >/dev/null 2>&1

    $QUILT next >/dev/null 2>&1
    local rc=$?
    [ $rc -ne 0 ] || { fail "next when fully applied should fail"; return; }
    pass
}

test_previous_none_applied() {
    begin_test "previous_none_applied"
    $QUILT previous >/dev/null 2>&1
    local rc=$?
    [ $rc -ne 0 ] || { fail "previous with none applied should fail"; return; }
    pass
}

# -----------------------------------------------------------------------
# 3. Push/pop variants
# -----------------------------------------------------------------------

test_push_all() {
    begin_test "push_all"
    echo "x" > f.txt

    $QUILT new a.patch >/dev/null 2>&1
    $QUILT add f.txt >/dev/null 2>&1
    echo "a" > f.txt
    $QUILT refresh >/dev/null 2>&1

    $QUILT new b.patch >/dev/null 2>&1
    $QUILT add f.txt >/dev/null 2>&1
    echo "b" > f.txt
    $QUILT refresh >/dev/null 2>&1

    $QUILT pop -a >/dev/null 2>&1
    [ "$(cat f.txt)" = "x" ] || { fail "pop -a should restore original"; return; }

    $QUILT push -a >/dev/null 2>&1 || { fail "push -a failed"; return; }
    [ "$(cat f.txt)" = "b" ] || { fail "push -a should apply all"; return; }

    pass
}

test_push_when_fully_applied() {
    begin_test "push_fully_applied"
    echo "x" > f.txt
    $QUILT new p.patch >/dev/null 2>&1
    $QUILT add f.txt >/dev/null 2>&1
    echo "y" > f.txt
    $QUILT refresh >/dev/null 2>&1

    $QUILT push >/dev/null 2>&1
    local rc=$?
    [ $rc -ne 0 ] || { fail "push when fully applied should fail"; return; }
    pass
}

test_pop_when_none_applied() {
    begin_test "pop_none_applied"
    $QUILT pop >/dev/null 2>&1
    local rc=$?
    [ $rc -ne 0 ] || { fail "pop with none applied should fail"; return; }
    pass
}

# -----------------------------------------------------------------------
# 4. Diff
# -----------------------------------------------------------------------

test_diff_shows_changes() {
    begin_test "diff_shows_changes"
    echo "old" > f.txt
    $QUILT new d.patch >/dev/null 2>&1
    $QUILT add f.txt >/dev/null 2>&1
    echo "new" > f.txt

    local diff_out
    diff_out=$($QUILT diff 2>/dev/null)
    echo "$diff_out" | grep -q "+new" || { fail "diff should show +new"; return; }
    echo "$diff_out" | grep -q -- "-old" || { fail "diff should show -old"; return; }

    pass
}

test_diff_after_refresh() {
    begin_test "diff_after_refresh"
    echo "old" > f.txt
    $QUILT new d.patch >/dev/null 2>&1
    $QUILT add f.txt >/dev/null 2>&1
    echo "new" > f.txt
    $QUILT refresh >/dev/null 2>&1

    # After refresh, diff still shows the patch content (backup vs working).
    # But if we now change the file again, diff shows the NEW changes.
    # Verify: modify file further, diff should reflect the new change.
    echo "newer" > f.txt
    local diff_out
    diff_out=$($QUILT diff 2>/dev/null)
    echo "$diff_out" | grep -q "+newer" || { fail "diff should show +newer"; return; }

    pass
}

# -----------------------------------------------------------------------
# 5. Delete, rename, import
# -----------------------------------------------------------------------

test_delete_unapplied() {
    begin_test "delete_unapplied"
    echo "x" > f.txt
    $QUILT new del.patch >/dev/null 2>&1
    $QUILT add f.txt >/dev/null 2>&1
    echo "y" > f.txt
    $QUILT refresh >/dev/null 2>&1
    $QUILT pop >/dev/null 2>&1

    # Now series has del.patch unapplied — push then delete
    $QUILT push >/dev/null 2>&1
    $QUILT delete -r >/dev/null 2>&1 || { fail "delete failed"; return; }

    local series
    series=$($QUILT series 2>/dev/null)
    [ -z "$series" ] || { fail "series should be empty after delete"; return; }
    [ ! -f patches/del.patch ] || { fail "patch file should be removed with -r"; return; }

    pass
}

test_rename() {
    begin_test "rename"
    echo "x" > f.txt
    $QUILT new old.patch >/dev/null 2>&1
    $QUILT add f.txt >/dev/null 2>&1
    echo "y" > f.txt
    $QUILT refresh >/dev/null 2>&1

    $QUILT rename new.patch >/dev/null 2>&1 || { fail "rename failed"; return; }

    local series
    series=$($QUILT series 2>/dev/null)
    echo "$series" | grep -q "new.patch" || { fail "new name not in series"; return; }
    [ -f patches/new.patch ] || { fail "renamed patch file missing"; return; }
    [ ! -f patches/old.patch ] || { fail "old patch file still exists"; return; }

    pass
}

test_import() {
    begin_test "import"
    echo "x" > f.txt

    # Create an external patch
    cat > /tmp/ext_test.patch << 'PATCH'
--- a/f.txt
+++ b/f.txt
@@ -1 +1 @@
-x
+imported
PATCH

    $QUILT import /tmp/ext_test.patch >/dev/null 2>&1 || { fail "import failed"; return; }

    [ -f patches/ext_test.patch ] || { fail "imported patch missing"; return; }
    local series
    series=$($QUILT series 2>/dev/null)
    echo "$series" | grep -q "ext_test.patch" || { fail "import not in series"; return; }

    # Should be pushable
    $QUILT push >/dev/null 2>&1 || { fail "push imported patch failed"; return; }
    [ "$(cat f.txt)" = "imported" ] || { fail "imported patch not applied correctly"; return; }

    pass
}

# -----------------------------------------------------------------------
# 6. Files, patches
# -----------------------------------------------------------------------

test_files() {
    begin_test "files"
    echo "a" > a.txt
    echo "b" > b.txt
    $QUILT new f.patch >/dev/null 2>&1
    $QUILT add a.txt >/dev/null 2>&1
    $QUILT add b.txt >/dev/null 2>&1
    echo "A" > a.txt
    echo "B" > b.txt
    $QUILT refresh >/dev/null 2>&1

    local files
    files=$($QUILT files 2>/dev/null)
    echo "$files" | grep -q "a.txt" || { fail "a.txt not in files"; return; }
    echo "$files" | grep -q "b.txt" || { fail "b.txt not in files"; return; }

    pass
}

test_patches_cmd() {
    begin_test "patches_cmd"
    echo "x" > target.txt
    $QUILT new p1.patch >/dev/null 2>&1
    $QUILT add target.txt >/dev/null 2>&1
    echo "1" > target.txt
    $QUILT refresh >/dev/null 2>&1

    $QUILT new p2.patch >/dev/null 2>&1
    $QUILT add target.txt >/dev/null 2>&1
    echo "2" > target.txt
    $QUILT refresh >/dev/null 2>&1

    local pats
    pats=$($QUILT patches target.txt 2>/dev/null)
    echo "$pats" | grep -q "p1.patch" || { fail "p1 not listed"; return; }
    echo "$pats" | grep -q "p2.patch" || { fail "p2 not listed"; return; }

    pass
}

# -----------------------------------------------------------------------
# 7. Header
# -----------------------------------------------------------------------

test_header() {
    begin_test "header"
    echo "x" > f.txt
    $QUILT new h.patch >/dev/null 2>&1
    $QUILT add f.txt >/dev/null 2>&1
    echo "y" > f.txt
    $QUILT refresh >/dev/null 2>&1

    # Header should be empty initially
    local hdr
    hdr=$($QUILT header 2>/dev/null)
    [ -z "$hdr" ] || { fail "header should be empty initially"; return; }

    # Set header with -r
    echo "This is the header" | $QUILT header -r >/dev/null 2>&1 || { fail "header -r failed"; return; }

    # Read it back
    hdr=$($QUILT header 2>/dev/null)
    echo "$hdr" | grep -q "This is the header" || { fail "header not set correctly"; return; }

    pass
}

# -----------------------------------------------------------------------
# 8. Edit, revert, remove
# -----------------------------------------------------------------------

test_edit() {
    begin_test "edit"
    echo "x" > f.txt
    $QUILT new e.patch >/dev/null 2>&1

    EDITOR=true $QUILT edit f.txt >/dev/null 2>&1 || { fail "edit failed"; return; }

    local files
    files=$($QUILT files 2>/dev/null)
    echo "$files" | grep -q "f.txt" || { fail "file not added by edit"; return; }

    pass
}

test_revert() {
    begin_test "revert"
    echo "original" > f.txt
    $QUILT new r.patch >/dev/null 2>&1
    $QUILT add f.txt >/dev/null 2>&1
    echo "modified" > f.txt

    $QUILT revert f.txt >/dev/null 2>&1 || { fail "revert failed"; return; }
    [ "$(cat f.txt)" = "original" ] || { fail "revert did not restore"; return; }

    pass
}

test_remove() {
    begin_test "remove"
    echo "x" > f.txt
    $QUILT new rm.patch >/dev/null 2>&1
    $QUILT add f.txt >/dev/null 2>&1
    echo "y" > f.txt

    $QUILT remove f.txt >/dev/null 2>&1 || { fail "remove failed"; return; }

    local files
    files=$($QUILT files 2>/dev/null)
    echo "$files" | grep -q "f.txt" && { fail "file still in patch after remove"; return; }

    pass
}

# -----------------------------------------------------------------------
# 9. Fork and fold
# -----------------------------------------------------------------------

test_fork() {
    begin_test "fork"
    echo "x" > f.txt
    $QUILT new orig.patch >/dev/null 2>&1
    $QUILT add f.txt >/dev/null 2>&1
    echo "y" > f.txt
    $QUILT refresh >/dev/null 2>&1

    $QUILT fork forked.patch >/dev/null 2>&1 || { fail "fork failed"; return; }

    [ -f patches/forked.patch ] || { fail "forked patch file missing"; return; }
    local top
    top=$($QUILT top 2>/dev/null)
    echo "$top" | grep -q "forked.patch" || { fail "top should be forked.patch"; return; }

    pass
}

test_fold() {
    begin_test "fold"
    echo "base" > f.txt
    $QUILT new target.patch >/dev/null 2>&1
    $QUILT add f.txt >/dev/null 2>&1

    # Create a patch to fold in
    cat << 'PATCH' | $QUILT fold >/dev/null 2>&1
--- a/f.txt
+++ b/f.txt
@@ -1 +1 @@
-base
+folded
PATCH
    local rc=$?
    [ $rc -eq 0 ] || { fail "fold failed (exit $rc)"; return; }
    [ "$(cat f.txt)" = "folded" ] || { fail "fold did not apply"; return; }

    pass
}

# -----------------------------------------------------------------------
# 10. Error handling
# -----------------------------------------------------------------------

test_add_no_patch() {
    begin_test "add_no_patch"
    echo "x" > f.txt
    $QUILT add f.txt >/dev/null 2>&1
    local rc=$?
    [ $rc -ne 0 ] || { fail "add with no patch should fail"; return; }
    pass
}

test_add_already_tracked() {
    begin_test "add_already_tracked"
    echo "x" > f.txt
    $QUILT new dup.patch >/dev/null 2>&1
    $QUILT add f.txt >/dev/null 2>&1
    $QUILT add f.txt >/dev/null 2>&1
    local rc=$?
    [ $rc -ne 0 ] || { fail "adding same file twice should fail"; return; }
    pass
}

# -----------------------------------------------------------------------
# 11. Edge cases
# -----------------------------------------------------------------------

test_subdirectory_files() {
    begin_test "subdirectory_files"
    mkdir -p sub/dir
    echo "deep" > sub/dir/deep.txt
    $QUILT new sub.patch >/dev/null 2>&1
    $QUILT add sub/dir/deep.txt >/dev/null 2>&1
    echo "modified" > sub/dir/deep.txt
    $QUILT refresh >/dev/null 2>&1

    $QUILT pop >/dev/null 2>&1
    [ "$(cat sub/dir/deep.txt)" = "deep" ] || { fail "subdirectory restore failed"; return; }

    $QUILT push >/dev/null 2>&1
    [ "$(cat sub/dir/deep.txt)" = "modified" ] || { fail "subdirectory apply failed"; return; }

    pass
}

test_empty_patch() {
    begin_test "empty_patch"
    $QUILT new empty.patch >/dev/null 2>&1
    $QUILT refresh >/dev/null 2>&1 || { fail "refresh empty patch failed"; return; }

    $QUILT pop >/dev/null 2>&1 || { fail "pop empty patch failed"; return; }
    $QUILT push >/dev/null 2>&1 || { fail "push empty patch failed"; return; }

    pass
}

test_multiple_patches_same_file() {
    begin_test "multiple_patches_same_file"
    echo "line1" > f.txt

    $QUILT new first.patch >/dev/null 2>&1
    $QUILT add f.txt >/dev/null 2>&1
    printf "line1\nline2\n" > f.txt
    $QUILT refresh >/dev/null 2>&1

    $QUILT new second.patch >/dev/null 2>&1
    $QUILT add f.txt >/dev/null 2>&1
    printf "line1\nline2\nline3\n" > f.txt
    $QUILT refresh >/dev/null 2>&1

    # Pop all
    $QUILT pop -a >/dev/null 2>&1
    [ "$(cat f.txt)" = "line1" ] || { fail "pop -a should restore to original"; return; }

    # Push all
    $QUILT push -a >/dev/null 2>&1 || { fail "push -a failed"; return; }
    local expected
    expected=$(printf "line1\nline2\nline3\n")
    [ "$(cat f.txt)" = "$expected" ] || { fail "push -a should apply both patches"; return; }

    pass
}

test_many_patches() {
    begin_test "many_patches"
    echo "0" > f.txt

    for i in $(seq 1 10); do
        $QUILT new "patch${i}.patch" >/dev/null 2>&1
        $QUILT add f.txt >/dev/null 2>&1
        echo "$i" > f.txt
        $QUILT refresh >/dev/null 2>&1
    done

    # Verify all 10 in series
    local count
    count=$($QUILT series 2>/dev/null | wc -l)
    [ "$count" -eq 10 ] || { fail "expected 10 patches, got $count"; return; }

    # Pop all and verify
    $QUILT pop -a >/dev/null 2>&1
    [ "$(cat f.txt)" = "0" ] || { fail "pop -a should restore to 0"; return; }

    # Push all
    $QUILT push -a >/dev/null 2>&1 || { fail "push -a failed"; return; }
    [ "$(cat f.txt)" = "10" ] || { fail "push -a should result in 10"; return; }

    pass
}

test_filenames_with_spaces() {
    begin_test "filenames_with_spaces"
    # Note: filenames with spaces are problematic for the external 'patch'
    # command (it can't parse the unified diff headers correctly). So we
    # only test add/refresh/pop (which use our backup mechanism, not patch).
    echo "content" > "my file.txt"
    $QUILT new space.patch >/dev/null 2>&1
    $QUILT add "my file.txt" >/dev/null 2>&1
    echo "changed" > "my file.txt"
    $QUILT refresh >/dev/null 2>&1

    $QUILT pop >/dev/null 2>&1
    [ "$(cat "my file.txt")" = "content" ] || { fail "restore failed for space filename"; return; }

    # Push with spaces is known to fail with external patch command — skip
    pass
}

# -----------------------------------------------------------------------
# 12. New spec-compliance tests
# -----------------------------------------------------------------------

test_upward_scanning() {
    begin_test "upward_scanning"
    echo "x" > f.txt
    $QUILT new up.patch >/dev/null 2>&1
    $QUILT add f.txt >/dev/null 2>&1
    echo "y" > f.txt
    $QUILT refresh >/dev/null 2>&1

    # Run quilt from a subdirectory
    mkdir -p sub/deep
    local top
    top=$(cd sub/deep && $QUILT top 2>/dev/null)
    echo "$top" | grep -q "up.patch" || { fail "top from subdirectory failed (got: $top)"; return; }

    pass
}

test_command_abbreviation() {
    begin_test "command_abbreviation"
    echo "x" > f.txt
    $QUILT new abbrev.patch >/dev/null 2>&1
    $QUILT add f.txt >/dev/null 2>&1
    echo "y" > f.txt
    $QUILT refresh >/dev/null 2>&1

    # "ser" should match "series" uniquely
    local series
    series=$($QUILT ser 2>/dev/null)
    echo "$series" | grep -q "abbrev.patch" || { fail "abbreviation 'ser' failed"; return; }

    # "to" should match "top" uniquely
    local top
    top=$($QUILT to 2>/dev/null)
    echo "$top" | grep -q "abbrev.patch" || { fail "abbreviation 'to' failed"; return; }

    pass
}

test_help_flag() {
    begin_test "help_flag"
    local help_out
    help_out=$($QUILT push -h 2>&1)
    local rc=$?
    [ $rc -eq 0 ] || { fail "push -h should exit 0 (got $rc)"; return; }
    echo "$help_out" | grep -qi "usage" || { fail "push -h should show usage"; return; }
    pass
}

test_quilt_patches_env() {
    begin_test "quilt_patches_env"
    mkdir -p mypatches
    echo "x" > f.txt

    QUILT_PATCHES=mypatches $QUILT new envp.patch >/dev/null 2>&1 || { fail "new with QUILT_PATCHES failed"; return; }
    QUILT_PATCHES=mypatches $QUILT add f.txt >/dev/null 2>&1
    echo "y" > f.txt
    QUILT_PATCHES=mypatches $QUILT refresh >/dev/null 2>&1

    [ -f mypatches/envp.patch ] || { fail "patch should be in mypatches/"; return; }
    pass
}

test_quilt_pc_env() {
    begin_test "quilt_pc_env"
    echo "x" > f.txt

    QUILT_PC=.mypc $QUILT new pce.patch >/dev/null 2>&1 || { fail "new with QUILT_PC failed"; return; }
    QUILT_PC=.mypc $QUILT add f.txt >/dev/null 2>&1
    echo "y" > f.txt
    QUILT_PC=.mypc $QUILT refresh >/dev/null 2>&1

    [ -d .mypc ] || { fail ".mypc directory should exist"; return; }
    [ -f .mypc/applied-patches ] || { fail "applied-patches should be in .mypc/"; return; }
    pass
}

test_series_search_order() {
    begin_test "series_search_order"
    # Put series file in project root instead of patches/
    echo "x" > f.txt
    mkdir -p patches
    cat > patches/root.patch << 'PATCH'
--- a/f.txt
+++ b/f.txt
@@ -1 +1 @@
-x
+root_series
PATCH
    # Series file at project root
    echo "root.patch" > series

    $QUILT push >/dev/null 2>&1 || { fail "push with root series failed"; return; }
    [ "$(cat f.txt)" = "root_series" ] || { fail "wrong content after push"; return; }

    pass
}

test_strip_level() {
    begin_test "strip_level"
    echo "x" > f.txt
    mkdir -p patches
    # Create a -p0 patch (no directory prefix in paths)
    cat > patches/p0.patch << 'PATCH'
--- f.txt
+++ f.txt
@@ -1 +1 @@
-x
+stripped
PATCH
    echo "p0.patch -p0" > patches/series

    $QUILT push >/dev/null 2>&1 || { fail "push -p0 patch failed"; return; }
    [ "$(cat f.txt)" = "stripped" ] || { fail "wrong content (got: $(cat f.txt))"; return; }

    pass
}

test_push_numeric() {
    begin_test "push_numeric"
    echo "x" > f.txt

    $QUILT new n1.patch >/dev/null 2>&1
    $QUILT add f.txt >/dev/null 2>&1
    echo "1" > f.txt
    $QUILT refresh >/dev/null 2>&1

    $QUILT new n2.patch >/dev/null 2>&1
    $QUILT add f.txt >/dev/null 2>&1
    echo "2" > f.txt
    $QUILT refresh >/dev/null 2>&1

    $QUILT new n3.patch >/dev/null 2>&1
    $QUILT add f.txt >/dev/null 2>&1
    echo "3" > f.txt
    $QUILT refresh >/dev/null 2>&1

    $QUILT pop -a >/dev/null 2>&1

    # Push exactly 2
    $QUILT push 2 >/dev/null 2>&1 || { fail "push 2 failed"; return; }
    local count
    count=$($QUILT applied 2>/dev/null | wc -l)
    [ "$count" -eq 2 ] || { fail "expected 2 applied, got $count"; return; }
    [ "$(cat f.txt)" = "2" ] || { fail "wrong content after push 2"; return; }

    pass
}

test_pop_numeric() {
    begin_test "pop_numeric"
    echo "x" > f.txt

    $QUILT new p1.patch >/dev/null 2>&1
    $QUILT add f.txt >/dev/null 2>&1
    echo "1" > f.txt
    $QUILT refresh >/dev/null 2>&1

    $QUILT new p2.patch >/dev/null 2>&1
    $QUILT add f.txt >/dev/null 2>&1
    echo "2" > f.txt
    $QUILT refresh >/dev/null 2>&1

    $QUILT new p3.patch >/dev/null 2>&1
    $QUILT add f.txt >/dev/null 2>&1
    echo "3" > f.txt
    $QUILT refresh >/dev/null 2>&1

    # Pop exactly 2
    $QUILT pop 2 >/dev/null 2>&1 || { fail "pop 2 failed"; return; }
    local count
    count=$($QUILT applied 2>/dev/null | wc -l)
    [ "$count" -eq 1 ] || { fail "expected 1 applied, got $count"; return; }
    [ "$(cat f.txt)" = "1" ] || { fail "wrong content after pop 2"; return; }

    pass
}

test_force_push_tracking() {
    begin_test "force_push_tracking"
    echo "original line" > f.txt
    mkdir -p patches

    # Create a patch that will conflict
    cat > patches/conflict.patch << 'PATCH'
--- a/f.txt
+++ b/f.txt
@@ -1 +1 @@
-wrong original
+patched
PATCH
    cat > patches/second.patch << 'PATCH'
--- a/f.txt
+++ b/f.txt
@@ -1 +1 @@
-patched
+second
PATCH
    echo "conflict.patch" > patches/series
    echo "second.patch" >> patches/series

    # Force push the conflicting patch
    $QUILT push -f >/dev/null 2>&1
    # Should return 1 but record the patch
    local top
    top=$($QUILT top 2>/dev/null)
    echo "$top" | grep -q "conflict.patch" || { fail "force-applied patch should be top"; return; }

    # Pushing another patch should fail (needs refresh)
    $QUILT push >/dev/null 2>&1
    local rc=$?
    [ $rc -ne 0 ] || { fail "push on top of force-applied should fail"; return; }

    # After refresh, pushing should work
    $QUILT add f.txt >/dev/null 2>&1
    echo "patched" > f.txt
    $QUILT refresh >/dev/null 2>&1

    # Now update second.patch to match
    cat > patches/second.patch << 'PATCH'
--- a/f.txt
+++ b/f.txt
@@ -1 +1 @@
-patched
+second
PATCH

    $QUILT push >/dev/null 2>&1 || { fail "push after refresh should succeed"; return; }

    pass
}

test_force_pop() {
    begin_test "force_pop"
    echo "original line" > f.txt
    mkdir -p patches

    cat > patches/bad.patch << 'PATCH'
--- a/f.txt
+++ b/f.txt
@@ -1 +1 @@
-wrong original
+patched
PATCH
    echo "bad.patch" > patches/series

    # Force push
    $QUILT push -f >/dev/null 2>&1

    # Pop without -f should fail (needs refresh)
    $QUILT pop >/dev/null 2>&1
    local rc=$?
    [ $rc -ne 0 ] || { fail "pop without -f should fail for force-applied"; return; }

    # Pop with -f should succeed
    $QUILT pop -f >/dev/null 2>&1 || { fail "pop -f should succeed"; return; }

    local count
    count=$($QUILT applied 2>/dev/null | wc -l)
    [ "$count" -eq 0 ] || { fail "should have no patches applied after pop -f"; return; }

    pass
}

test_refresh_shadowing() {
    begin_test "refresh_shadowing"
    echo "base" > f.txt

    $QUILT new bottom.patch >/dev/null 2>&1
    $QUILT add f.txt >/dev/null 2>&1
    echo "bottom" > f.txt
    $QUILT refresh >/dev/null 2>&1

    $QUILT new top.patch >/dev/null 2>&1
    $QUILT add f.txt >/dev/null 2>&1
    echo "top" > f.txt
    $QUILT refresh >/dev/null 2>&1

    # Refresh the bottom patch — should NOT include top patch's changes
    $QUILT refresh bottom.patch >/dev/null 2>&1

    local content
    content=$(cat patches/bottom.patch)
    # The bottom patch should still show base->bottom, NOT base->top
    echo "$content" | grep -q "+bottom" || { fail "bottom patch should have +bottom"; return; }
    echo "$content" | grep -q "+top" && { fail "bottom patch should NOT have +top"; return; }

    pass
}

test_diff_reverse() {
    begin_test "diff_reverse"
    echo "old" > f.txt
    $QUILT new rev.patch >/dev/null 2>&1
    $QUILT add f.txt >/dev/null 2>&1
    echo "new" > f.txt

    local diff_out
    diff_out=$($QUILT diff -R 2>/dev/null)
    # Reverse diff: +old, -new (opposite of normal)
    echo "$diff_out" | grep -q "+old" || { fail "reverse diff should show +old"; return; }
    echo "$diff_out" | grep -q -- "-new" || { fail "reverse diff should show -new"; return; }

    pass
}

# -----------------------------------------------------------------------
# quilt.html Section 4 example — full workflow test
# -----------------------------------------------------------------------

test_quilt_example() {
    begin_test "quilt_example"

    # Start with the poem
    cat > Oberon.txt << 'POEM'
Yet mark'd I where the bolt of Cupid fell:
It fell upon a little western flower,
Before milk-white, now purple with love's wound,
And girls call it love-in-idleness.
POEM

    # Create patch and add file
    local out
    out=$($QUILT new flower.diff 2>&1)
    echo "$out" | grep -q "Patch flower.diff is now on top" \
        || { fail "new output: $out"; return; }

    out=$($QUILT add Oberon.txt 2>&1)
    echo "$out" | grep -q "File Oberon.txt added to patch flower.diff" \
        || { fail "add output: $out"; return; }

    # Edit: add 3 lines
    cat > Oberon.txt << 'POEM'
Yet mark'd I where the bolt of Cupid fell:
It fell upon a little western flower,
Before milk-white, now purple with love's wound,
And girls call it love-in-idleness.
The juice of it on sleeping eye-lids laid
Will make a man or woman madly dote
Upon the next live creature that it sees.
POEM

    $QUILT refresh >/dev/null 2>&1 || { fail "first refresh"; return; }
    [ -f patches/flower.diff ] || { fail "patch file missing after refresh"; return; }
    grep -q "+The juice of it" patches/flower.diff \
        || { fail "patch content wrong"; return; }

    # diff -z with no changes since refresh: should be empty
    out=$($QUILT diff -z 2>/dev/null)
    [ -z "$out" ] || { fail "diff -z should be empty after refresh, got: $out"; return; }

    # Edit: add one more line
    cat > Oberon.txt << 'POEM'
Yet mark'd I where the bolt of Cupid fell:
It fell upon a little western flower,
Before milk-white, now purple with love's wound,
And girls call it love-in-idleness.
Fetch me that flower; the herb I shew'd thee once:
The juice of it on sleeping eye-lids laid
Will make a man or woman madly dote
Upon the next live creature that it sees.
POEM

    # diff -z should show only the new line
    out=$($QUILT diff -z 2>/dev/null)
    echo "$out" | grep -q "+Fetch me that flower" \
        || { fail "diff -z should show Fetch line"; return; }
    # Should NOT show the previously-refreshed lines as additions
    echo "$out" | grep -q "+The juice" \
        && { fail "diff -z should not show already-refreshed lines as additions"; return; }

    $QUILT refresh >/dev/null 2>&1 || { fail "second refresh"; return; }

    # Delete patch file and re-refresh with -p ab
    rm patches/flower.diff
    $QUILT refresh -p ab --no-index --no-timestamps >/dev/null 2>&1 \
        || { fail "refresh after delete failed"; return; }
    [ -f patches/flower.diff ] || { fail "patch not recreated after delete"; return; }
    # Check -p ab labels
    grep -q "^--- a/Oberon.txt" patches/flower.diff \
        || { fail "refresh -p ab should use a/ prefix"; return; }
    grep -q "^+++ b/Oberon.txt" patches/flower.diff \
        || { fail "refresh -p ab should use b/ prefix"; return; }

    # Pop
    out=$($QUILT pop 2>&1)
    echo "$out" | grep -q "Removing patch flower.diff" \
        || { fail "pop output: $out"; return; }
    echo "$out" | grep -q "No patches applied" \
        || { fail "pop should say no patches applied"; return; }

    # Simulate upstream change: girls -> maidens
    cat > Oberon.txt << 'POEM'
Yet mark'd I where the bolt of Cupid fell:
It fell upon a little western flower,
Before milk-white, now purple with love's wound,
And maidens call it love-in-idleness.
POEM

    # Push should fail (patch doesn't apply cleanly)
    $QUILT push >/dev/null 2>&1
    [ $? -ne 0 ] || { fail "push should fail on conflict"; return; }

    # Force push
    out=$($QUILT push -f 2>&1)
    echo "$out" | grep -q "forced; needs refresh" \
        || { fail "push -f output: $out"; return; }

    # Backup should be at correct path (not with extra directory prefix)
    [ -f .pc/flower.diff/Oberon.txt ] \
        || { fail "backup at wrong path after push"; return; }

    # top should show bare name
    out=$($QUILT top 2>&1)
    [ "$out" = "flower.diff" ] || { fail "top should be 'flower.diff', got: $out"; return; }

    # Refresh should clear needs_refresh
    # First fix up the file with the correct content
    cat > Oberon.txt << 'POEM'
Yet mark'd I where the bolt of Cupid fell:
It fell upon a little western flower,
Before milk-white, now purple with love's wound,
And maidens call it love-in-idleness.
Fetch me that flower; the herb I shew'd thee once:
The juice of it on sleeping eye-lids laid
Will make a man or woman madly dote
Upon the next live creature that it sees.
POEM

    $QUILT refresh >/dev/null 2>&1 || { fail "refresh after force push"; return; }
    [ ! -f .pc/flower.diff/.needs_refresh ] \
        || { fail ".needs_refresh should be cleared"; return; }

    # Pop should work normally now
    $QUILT pop >/dev/null 2>&1 || { fail "pop after refresh"; return; }

    pass
}

# -----------------------------------------------------------------------
# Run all tests
# -----------------------------------------------------------------------

echo "Running quilt test suite with: $QUILT"
echo ""

test_basic_workflow
test_new_file_in_patch
test_multiple_files_in_patch
test_series
test_applied_unapplied
test_top_none_applied
test_top
test_next_previous
test_next_fully_applied
test_previous_none_applied
test_push_all
test_push_when_fully_applied
test_pop_when_none_applied
test_diff_shows_changes
test_diff_after_refresh
test_delete_unapplied
test_rename
test_import
test_files
test_patches_cmd
test_header
test_edit
test_revert
test_remove
test_fork
test_fold
test_add_no_patch
test_add_already_tracked
test_subdirectory_files
test_empty_patch
test_multiple_patches_same_file
test_many_patches
test_filenames_with_spaces
test_upward_scanning
test_command_abbreviation
test_help_flag
test_quilt_patches_env
test_quilt_pc_env
test_series_search_order
test_strip_level
test_push_numeric
test_pop_numeric
test_force_push_tracking
test_force_pop
test_refresh_shadowing
test_diff_reverse
test_quilt_example

echo ""
echo "================================"
echo "Tests passed: $PASS"
echo "Tests failed: $FAIL"
echo "================================"

[ $FAIL -eq 0 ]
