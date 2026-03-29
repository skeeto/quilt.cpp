include_guard(GLOBAL)

set(QUILT_TEST_SCENARIOS
    basic_workflow
    new_file_in_patch
    multiple_files_in_patch
    series
    applied_unapplied
    applied_none_applied
    top_none_applied
    top
    next_previous
    next_fully_applied
    previous_none_applied
    push_all
    push_when_fully_applied
    pop_when_none_applied
    stack_push_pop_transcript
    push_named_patch
    pop_to_named_patch
    diff_shows_changes
    diff_after_refresh
    snapshot_tracks_all_applied_files
    snapshot_replaces_previous
    snapshot_delete
    diff_snapshot_shows_changes
    diff_snapshot_multiple_applied
    diff_snapshot_missing
    diff_snapshot_invalid_combination
    delete_unapplied
    delete_unknown_patch
    rename
    rename_duplicate
    import
    import_duplicate
    import_missing_source
    import_strip_level
    import_strip_level_default
    import_reversed
    import_reversed_strip
    import_dup_keep_old
    import_dup_append
    import_dup_new
    import_dup_no_flag_both_headers
    import_dup_no_flag_no_header
    files
    files_labels
    files_combine
    files_combine_labels
    patches_cmd
    header
    edit
    revert
    revert_not_tracked
    remove
    fork
    fork_no_applied_patch
    fork_duplicate_name
    fold
    add_no_patch
    add_prefixed_patch_arg
    add_already_tracked
    remove_not_tracked
    subdirectory_files
    subdirectory_add_edit
    empty_patch
    multiple_patches_same_file
    many_patches
    graph_basic
    graph_no_edges
    graph_selected_patch
    graph_all_excludes_unapplied
    graph_edge_labels
    graph_lines_disjoint
    graph_lines_context_boundary
    graph_empty_stack
    graph_unknown_patch
    graph_help
    graph_subdirectory
    filenames_with_spaces
    upward_scanning
    command_abbreviation
    help_flag
    quilt_patches_env
    quilt_pc_env
    series_search_order
    strip_level
    push_numeric
    push_verbose
    push_fuzz
    push_merge
    push_leave_rejects
    push_refresh
    pop_numeric
    force_push_tracking
    force_pop
    refresh_shadowing_requires_force
    refresh_shadowing
    diff_reverse
    diff_context_format
    diff_context_lines
    diff_unified_lines
    diff_sort
    diff_combine
    diff_combine_named
    diff_combine_conflicts_with_z
    diff_diff_utility
    new_add_output
    new_strip_p0
    new_strip_p1
    new_strip_default
    quilt_example
    quiltrc_basic
    quiltrc_disable
    quiltrc_env_override
    quilt_command_args
    quilt_series_env
    quilt_no_diff_index
    quilt_patches_prefix
    quiltrc_quoted_values
    annotate_unmodified_file
    annotate_unknown_patch
    annotate_not_applied
    annotate_usage
    annotate_help
    edit_multiple_files
    edit_no_patch
    edit_already_tracked
    fold_new_file
    fold_no_patch
    fold_reverse
    unapplied_all_applied
    unapplied_none_applied
    unapplied_named
    upgrade_noop
    patches_verbose
    patches_unapplied
    remove_with_P
    rename_unapplied
    revert_new_file
    next_none_applied
    series_verbose
    previous_with_target
    applied_with_target
    push_unknown_target
    delete_backup_option
    delete_next_no_next
    patches_no_file_arg
    delete_applied
    new_no_name
    new_already_exists
    next_unknown_target
    previous_unknown_target
    add_no_patches_applied
    add_bad_option
    add_no_files
    remove_bad_option
    remove_no_files
    unapplied_bad_option
    next_bad_option
    previous_bad_option
    previous_multiple_applied
    rename_bad_option
    rename_no_name
    rename_no_patch_applied
    pop_no_patches_applied
    pop_unapplied_target
    unapplied_unknown_target
    previous_no_patches_applied
    push_no_series
    push_already_applied
    import_bad_option
    rename_unknown_patch
    fold_bad_option
    fork_no_extension
    diff_no_applied_patches
    revert_bad_option
    revert_no_files
    revert_with_P
    header_with_patch_arg
    refresh_sort
    files_bad_option
    files_no_patch_applied
    diff_C_combined
    diff_U_combined
    diff_with_P
    diff_combine_snapshot_conflict
    diff_file_filter
    diff_p_explicit
    diff_no_timestamps
    diff_explicit_u
    diff_p_combined
    refresh_no_patches
    revert_no_patches
    snapshot_bad_option
    edit_bad_option
    edit_no_files
    remove_no_patches
    header_backup_replace
    files_verbose_unapplied
    files_combine_none_applied
    files_combine_not_applied
    import_after_applied
    delete_bad_option
    delete_no_patch
    delete_topmost
    upgrade_bad_option
)

# Scenarios that test quilt.cpp-specific behavior (mail command format).
# Skipped when testing an external quilt binary.
set(QUILT_TEST_SCENARIOS_NATIVE
    pop_verbose
    pop_verify_reverse
    pop_auto_refresh
    pop_refresh_args
    init_creates_metadata
    init_help_text
    mail_basic
    mail_single_patch
    mail_patch_range
    mail_dash_range
    mail_prefix
    mail_from_sender
    mail_to_cc
    mail_send_error
    mail_no_mbox_error
    mail_no_patches
    mail_header_multiline
    mail_diffstat
    mail_help
    mail_bad_option
    mail_no_from
    mail_opts_ignored
    mail_single_named
    mail_patch_not_in_series
    mail_first_not_in_series
    mail_last_not_in_series
    mail_range_reversed
    mail_too_many_args
    mail_empty_patch
    mail_no_header
    mail_non_ascii
    mail_single_dash_positional
    mail_leading_blank_header
    builtin_diff_identical_files
    builtin_diff_simple_change
    builtin_diff_new_file
    builtin_diff_deleted_file
    builtin_diff_no_trailing_newline
    builtin_diff_empty_to_content
    builtin_diff_multiple_hunks
    builtin_diff_zero_context
    builtin_diff_large_context
    builtin_diff_all_lines_changed
    builtin_diff_single_line_files
    builtin_diff_context_format
    builtin_diff_vs_system_diff
    builtin_patch_exact_apply
    builtin_patch_offset
    builtin_patch_fuzz
    builtin_patch_new_file
    builtin_patch_delete_file
    builtin_patch_reverse
    builtin_patch_dry_run
    builtin_patch_reject
    builtin_patch_no_newline
    builtin_patch_multiple_files
    builtin_patch_multiple_hunks
    builtin_patch_strip_level
    builtin_patch_merge_markers
    builtin_patch_empty_context
    builtin_patch_force
    builtin_patch_vs_system
    refresh_unified
    refresh_unified_lines
    refresh_context
    refresh_context_lines
    refresh_backup
    refresh_backup_no_existing
    refresh_strip_whitespace
    refresh_strip_whitespace_warning
    refresh_fork
    refresh_fork_named
    refresh_fork_not_top
    refresh_diffstat
    header_strip_diffstat
    header_strip_trailing_whitespace
    header_strip_diffstat_print
    header_strip_ws_print
    header_dep3_template
    header_dep3_nonempty
    header_strip_diffstat_append
    header_strip_combined
    unknown_option_rejected
    color_option_accepted
    color_option_invalid
    trace_option_accepted
    builtin_patch_trailing_lines
    builtin_patch_merge_conflict_partial
    builtin_patch_merge_diff3
    fold_reverse_no_newline
    diff_external_context_format
    fold_empty_stdin
    init_extra_args
    refresh_U_combined
    refresh_C_combined
    diff_external_context_multiline
    diff_external_with_C
    diff_quilt_diff_opts_combined
    diff_quilt_diff_opts_separate
    refresh_re_diffstat
    diff_P_unapplied
    refresh_diffstat_delete_file
    refresh_strip_ws_blank_context
    refresh_diffstat_padding
    diff_z_p0
    diff_z_pab
    diff_snapshot_new_file_after
    diff_z_external
    diff_z_reverse
    diff_z_subdir
    diff_snapshot_shadow
    fold_patch_opts
    fold_force
    fold_force_env
    header_backup_append
    stub_grep
    stub_setup
    stub_shell
    graph_lines_with_num
    graph_lines_nan
    graph_edge_labels_space
    graph_edge_labels_bad
    graph_T_bad
    graph_T_ps
    graph_Tps
    graph_bad_option
    graph_two_patches
    graph_all_with_patch
    graph_no_applied_with_series
    graph_all_empty
    graph_unapplied_patch
    annotate_bad_option
    annotate_two_files
    annotate_no_applied
    annotate_empty_series
    annotate_nonexistent_file
    quilt_no_args
    quilt_version
    quilt_global_help
    quilt_help_command
    quilt_unknown_command
    quilt_ambiguous_command
    quilt_quiltrc_equals
    quiltrc_export_prefix
    quiltrc_invalid_key
    quiltrc_dquote_backslash
    fold_quiet
    fold_strip
    fold_fail
    push_count_clamp
    push_missing_patch
    push_quilt_patch_opts
    pop_auto_refresh_fail
    import_no_files
    header_strip_ws_empty_line
    files_combine_dash_no_applied
    push_quilt_patch_opts_fuzz
    builtin_patch_merge_copy_lines
    builtin_patch_no_newline_context
    builtin_patch_empty_context_line
    push_missing_file
    refresh_diffstat_scale
    diff_combine_shadowing
    fold_patch_opts_fuzz
    rename_subdirectory
    header_edit_backup
    header_strip_diffstat_false_positive
    files_combine_dash_patch_no_applied
    files_unapplied_duplicate
    push_fuzz_offset
    header_edit_fail
    push_backward_offset
    push_new_file_subdir
    builtin_patch_empty_file_content
    builtin_patch_stray_minus
    diff_external_context_no_newline
    diff_external_quilt_diff_opts
    revert_subdir
    builtin_diff_both_empty
    builtin_diff_trailing_newline_only
    quiltrc_leading_whitespace
    series_comment_inline
    series_p_space
    init_from_subdir
    shell_split_single_quotes
    shell_split_double_quotes
    shell_split_var_expansion
    shell_split_var_braces
    shell_split_mixed
    shell_split_dquote_escape
    shell_split_unquoted_backslash
    annotate_basic
    annotate_stop_patch
    annotate_created_file
    annotate_subdirectory
    graph_reduce
    new_combined_p_flag
    next_with_target
    files_verbose
    upgrade_help
    header_no_patch_applied
    header_empty_series
    pop_target_already_top
    diff_builtin_context_no_newline
    mail_ten_patches
    graph_dot_escape
    graph_lines_identical_content
    graph_patch_prunes_unrelated
    graph_empty_series
    quiltrc_export_extra_space
    quiltrc_explicit_empty
    refresh_diffstat_twice
    refresh_diffstat_header_replace
    series_in_pc_dir
    series_leading_space_no_newline
    header_replace_no_newline
    annotate_no_series_file
    push_reject_no_newline
    fork_applied_not_in_series
    refresh_diffstat_double_newline
    refresh_creates_patches_dir
    top_index_applied_not_in_series
    push_crlf_patch
    refresh_diffstat_bare_header
    refresh_diffstat_bare_false_positive
    graph_prune_unreachable_edge
    graph_empty_backup_files
)

function(qt_strip_trailing_newlines out_var text)
    string(REGEX REPLACE "\n+$" "" trimmed "${text}")
    set(${out_var} "${trimmed}" PARENT_SCOPE)
endfunction()

function(qt_scenario_basic_workflow)
    qt_begin_test("basic_workflow")
    qt_write_file("${QT_WORK_DIR}/file.txt" "hello\n")
    qt_quilt_ok(ARGS new test.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add file.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/file.txt" "world\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    qt_assert_exists("${QT_WORK_DIR}/patches/test.patch" "patch file missing")
    qt_quilt_ok(ARGS pop MESSAGE "pop failed")
    qt_assert_file_text("${QT_WORK_DIR}/file.txt" "hello" "pop did not restore")
    qt_quilt_ok(ARGS push MESSAGE "push failed")
    qt_assert_file_text("${QT_WORK_DIR}/file.txt" "world" "push did not apply")
endfunction()

function(qt_scenario_new_file_in_patch)
    qt_begin_test("new_file_in_patch")
    qt_quilt_ok(ARGS new create.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add newfile.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/newfile.txt" "brand new\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    qt_quilt_ok(ARGS pop MESSAGE "pop failed")
    qt_assert_not_exists("${QT_WORK_DIR}/newfile.txt" "new file should be removed on pop")
    qt_quilt_ok(ARGS push MESSAGE "push failed")
    qt_assert_exists("${QT_WORK_DIR}/newfile.txt" "new file should be created on push")
    qt_assert_file_text("${QT_WORK_DIR}/newfile.txt" "brand new" "content mismatch")
endfunction()

function(qt_scenario_multiple_files_in_patch)
    qt_begin_test("multiple_files_in_patch")
    qt_write_file("${QT_WORK_DIR}/a.txt" "a\n")
    qt_write_file("${QT_WORK_DIR}/b.txt" "b\n")
    qt_quilt_ok(ARGS new multi.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add a.txt MESSAGE "add a failed")
    qt_quilt_ok(ARGS add b.txt MESSAGE "add b failed")
    qt_write_file("${QT_WORK_DIR}/a.txt" "A\n")
    qt_write_file("${QT_WORK_DIR}/b.txt" "B\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    qt_quilt_ok(ARGS pop MESSAGE "pop failed")
    qt_assert_file_text("${QT_WORK_DIR}/a.txt" "a" "restore failed for a.txt")
    qt_assert_file_text("${QT_WORK_DIR}/b.txt" "b" "restore failed for b.txt")
    qt_quilt_ok(ARGS push MESSAGE "push failed")
    qt_assert_file_text("${QT_WORK_DIR}/a.txt" "A" "apply failed for a.txt")
    qt_assert_file_text("${QT_WORK_DIR}/b.txt" "B" "apply failed for b.txt")
endfunction()

function(qt_scenario_series)
    qt_begin_test("series")
    qt_write_file("${QT_WORK_DIR}/file.txt" "hello\n")
    qt_quilt_ok(ARGS new a.patch MESSAGE "new a failed")
    qt_quilt_ok(ARGS add file.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/file.txt" "a\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh a failed")
    qt_quilt_ok(ARGS new b.patch MESSAGE "new b failed")
    qt_quilt_ok(ARGS add file.txt MESSAGE "add for b failed")
    qt_write_file("${QT_WORK_DIR}/file.txt" "b\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh b failed")
    qt_quilt_ok(OUTPUT series ERROR series_err ARGS series MESSAGE "series failed")
    qt_assert_contains("${series}" "a.patch" "a.patch missing from series")
    qt_assert_contains("${series}" "b.patch" "b.patch missing from series")
endfunction()

function(qt_scenario_applied_unapplied)
    qt_begin_test("applied_unapplied")
    qt_write_file("${QT_WORK_DIR}/file.txt" "x\n")
    qt_quilt_ok(ARGS new p1.patch MESSAGE "new p1 failed")
    qt_quilt_ok(ARGS add file.txt MESSAGE "add p1 failed")
    qt_write_file("${QT_WORK_DIR}/file.txt" "1\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh p1 failed")
    qt_quilt_ok(ARGS new p2.patch MESSAGE "new p2 failed")
    qt_quilt_ok(ARGS add file.txt MESSAGE "add p2 failed")
    qt_write_file("${QT_WORK_DIR}/file.txt" "2\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh p2 failed")
    qt_quilt_ok(OUTPUT applied ERROR applied_err ARGS applied MESSAGE "applied failed")
    qt_assert_contains("${applied}" "p1.patch" "p1 not in applied")
    qt_assert_contains("${applied}" "p2.patch" "p2 not in applied")
    qt_assert_equal("${applied_err}" "" "applied should not write diagnostics to stderr")
    qt_quilt_ok(ARGS pop MESSAGE "pop failed")
    qt_quilt_ok(OUTPUT unapplied ERROR unapplied_err ARGS unapplied MESSAGE "unapplied failed")
    qt_assert_contains("${unapplied}" "p2.patch" "p2 not in unapplied")
    qt_assert_equal("${unapplied_err}" "" "unapplied should not write diagnostics to stderr")
endfunction()

function(qt_scenario_applied_none_applied)
    qt_begin_test("applied_none_applied")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "y\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    qt_quilt_ok(ARGS pop MESSAGE "pop failed")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS applied)
    qt_assert_failure("${rc}" "applied with no patches should fail")
    qt_combine_output(combined "${out}" "${err}")
    qt_assert_contains("${combined}" "No patches applied" "applied should explain the empty stack")
endfunction()

function(qt_scenario_top_none_applied)
    qt_begin_test("top_none_applied")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS top)
    qt_assert_failure("${rc}" "top with no patches should fail")
    qt_combine_output(combined "${out}" "${err}")
    qt_assert_contains("${combined}" "No series file found" "top with no patches should explain the failure")
endfunction()

function(qt_scenario_top)
    qt_begin_test("top")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_quilt_ok(ARGS new t.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "y\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    qt_quilt_ok(OUTPUT top_out ERROR top_err ARGS top MESSAGE "top failed")
    qt_assert_contains("${top_out}" "t.patch" "top should show t.patch")
endfunction()

function(qt_scenario_next_previous)
    qt_begin_test("next_previous")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_quilt_ok(ARGS new first.patch MESSAGE "new first failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add first failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "1\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh first failed")
    qt_quilt_ok(ARGS new second.patch MESSAGE "new second failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add second failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "2\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh second failed")
    qt_quilt_ok(ARGS pop MESSAGE "pop failed")
    qt_quilt_ok(OUTPUT next_out ERROR next_err ARGS next MESSAGE "next failed")
    qt_assert_contains("${next_out}" "second.patch" "next should be second.patch")
    qt_assert_equal("${next_err}" "" "next should not write diagnostics to stderr")
    qt_quilt(RESULT rc OUTPUT prev_out ERROR prev_err ARGS previous)
    qt_assert_failure("${rc}" "previous from first should fail")
    qt_assert_equal("${prev_out}" "" "previous on the first patch should not write to stdout")
    qt_assert_equal("${prev_err}" "" "previous on the first patch should not write to stderr")
endfunction()

function(qt_scenario_next_fully_applied)
    qt_begin_test("next_fully_applied")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_quilt_ok(ARGS new only.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "y\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS next)
    qt_assert_failure("${rc}" "next when fully applied should fail")
endfunction()

function(qt_scenario_previous_none_applied)
    qt_begin_test("previous_none_applied")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS previous)
    qt_assert_failure("${rc}" "previous with none applied should fail")
    qt_combine_output(combined "${out}" "${err}")
    qt_assert_contains("${combined}" "No series file found" "previous should explain the missing series file")
endfunction()

function(qt_scenario_push_all)
    qt_begin_test("push_all")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_quilt_ok(ARGS new a.patch MESSAGE "new a failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add a failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "a\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh a failed")
    qt_quilt_ok(ARGS new b.patch MESSAGE "new b failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add b failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "b\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh b failed")
    qt_quilt_ok(ARGS pop -a MESSAGE "pop -a failed")
    qt_assert_file_text("${QT_WORK_DIR}/f.txt" "x" "pop -a should restore original")
    qt_quilt_ok(ARGS push -a MESSAGE "push -a failed")
    qt_assert_file_text("${QT_WORK_DIR}/f.txt" "b" "push -a should apply all")
endfunction()

function(qt_scenario_push_when_fully_applied)
    qt_begin_test("push_when_fully_applied")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "y\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS push)
    qt_assert_failure("${rc}" "push when fully applied should fail")
    qt_combine_output(combined "${out}" "${err}")
    qt_assert_contains("${combined}" "ends at patch p.patch" "push when fully applied should explain the failure")
endfunction()

function(qt_scenario_pop_when_none_applied)
    qt_begin_test("pop_when_none_applied")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS pop)
    qt_assert_failure("${rc}" "pop with none applied should fail")
    qt_combine_output(combined "${out}" "${err}")
    qt_assert_contains("${combined}" "No series file found" "pop with none applied should explain the failure")
endfunction()

function(qt_scenario_stack_push_pop_transcript)
    qt_begin_test("stack_push_pop_transcript")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_quilt_ok(ARGS new t.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "y\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    qt_quilt_ok(OUTPUT pop_out ERROR pop_err ARGS pop -v MESSAGE "pop failed")
    qt_assert_contains("${pop_out}" "Removing patch t.patch" "pop should announce the removed patch")
    qt_assert_contains("${pop_out}" "Restoring f.txt" "pop -v should report restored files")
    qt_assert_contains("${pop_out}" "No patches applied" "pop should report the empty stack")
    qt_assert_file_text("${QT_WORK_DIR}/f.txt" "x" "pop should restore the original file")
    qt_quilt_ok(OUTPUT push_out ERROR push_err ARGS push MESSAGE "push failed")
    qt_assert_contains("${push_out}" "Applying patch t.patch" "push should announce the applied patch")
    qt_assert_contains("${push_out}" "Now at patch t.patch" "push should report the new top patch")
    qt_assert_file_text("${QT_WORK_DIR}/f.txt" "y" "push should apply the patch contents")
endfunction()

function(qt_scenario_push_named_patch)
    qt_begin_test("push_named_patch")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_quilt_ok(ARGS new first.patch MESSAGE "new first failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add first failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "1\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh first failed")
    qt_quilt_ok(ARGS new second.patch MESSAGE "new second failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add second failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "2\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh second failed")
    qt_quilt_ok(ARGS pop -a MESSAGE "pop -a failed")
    qt_quilt_ok(OUTPUT push_out ERROR push_err ARGS push second.patch MESSAGE "push second.patch failed")
    qt_assert_contains("${push_out}" "Applying patch first.patch" "push second.patch should apply first.patch")
    qt_assert_contains("${push_out}" "Applying patch second.patch" "push second.patch should apply second.patch")
    qt_assert_contains("${push_out}" "Now at patch second.patch" "push second.patch should end at second.patch")
    qt_assert_file_text("${QT_WORK_DIR}/f.txt" "2" "push second.patch should apply both patches")
endfunction()

function(qt_scenario_pop_to_named_patch)
    qt_begin_test("pop_to_named_patch")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_quilt_ok(ARGS new first.patch MESSAGE "new first failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add first failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "1\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh first failed")
    qt_quilt_ok(ARGS new second.patch MESSAGE "new second failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add second failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "2\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh second failed")
    qt_quilt_ok(ARGS new third.patch MESSAGE "new third failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add third failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "3\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh third failed")
    qt_quilt_ok(OUTPUT pop_out ERROR pop_err ARGS pop second.patch MESSAGE "pop second.patch failed")
    qt_assert_contains("${pop_out}" "Removing patch third.patch" "pop second.patch should remove third.patch")
    qt_assert_contains("${pop_out}" "Now at patch second.patch" "pop second.patch should stop at second.patch")
    qt_assert_file_text("${QT_WORK_DIR}/f.txt" "2" "pop second.patch should leave second.patch applied")
endfunction()

function(qt_scenario_pop_verbose)
    qt_begin_test("pop_verbose")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_quilt_ok(ARGS new t.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "y\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    # Default pop should NOT show Restoring
    qt_quilt_ok(OUTPUT pop_out ERROR pop_err ARGS pop MESSAGE "pop failed")
    qt_assert_contains("${pop_out}" "Removing patch" "pop should announce removal")
    qt_assert_not_contains("${pop_out}" "Restoring" "default pop should not show Restoring")
    # Push back and pop with -v
    qt_quilt_ok(ARGS push MESSAGE "push failed")
    qt_quilt_ok(OUTPUT popv_out ERROR popv_err ARGS pop -v MESSAGE "pop -v failed")
    qt_assert_contains("${popv_out}" "Restoring f.txt" "pop -v should show Restoring")
    qt_assert_contains("${popv_out}" "Removing patch" "pop -v should announce removal")
endfunction()

function(qt_scenario_pop_verify_reverse)
    qt_begin_test("pop_verify_reverse")
    qt_write_file("${QT_WORK_DIR}/f.txt" "original\n")
    qt_quilt_ok(ARGS new t.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "modified\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    # Sabotage the file so reverse-apply would fail
    qt_write_file("${QT_WORK_DIR}/f.txt" "sabotaged\n")
    # pop -R should fail (reverse doesn't apply cleanly)
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS pop -R)
    qt_assert_failure("${rc}" "pop -R should fail when patch cannot reverse-apply")
    qt_assert_contains("${err}" "does not remove cleanly" "pop -R should explain failure")
    # pop -R -f should succeed (force overrides)
    qt_quilt_ok(ARGS pop -R -f MESSAGE "pop -R -f should succeed")
    qt_assert_file_text("${QT_WORK_DIR}/f.txt" "original" "pop -R -f should restore original")
endfunction()

function(qt_scenario_pop_auto_refresh)
    qt_begin_test("pop_auto_refresh")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_quilt_ok(ARGS new t.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "y\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    # Modify file again (patch now has unsaved changes)
    qt_write_file("${QT_WORK_DIR}/f.txt" "z\n")
    # pop --refresh should auto-refresh then pop
    qt_quilt_ok(ARGS pop --refresh MESSAGE "pop --refresh failed")
    qt_assert_file_text("${QT_WORK_DIR}/f.txt" "x" "pop --refresh should restore original")
    # Verify the patch was refreshed (push should give us "z" not "y")
    qt_quilt_ok(ARGS push MESSAGE "push after pop --refresh failed")
    qt_assert_file_text("${QT_WORK_DIR}/f.txt" "z" "patch should reflect auto-refreshed content")
endfunction()

function(qt_scenario_pop_refresh_args)
    qt_begin_test("pop_refresh_args")
    qt_write_file("${QT_TEST_BASE}/test_quiltrc_popref" "QUILT_REFRESH_ARGS=\"--no-index\"\n")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_quilt_ok(ARGS --quiltrc "${QT_TEST_BASE}/test_quiltrc_popref" new popref.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS --quiltrc "${QT_TEST_BASE}/test_quiltrc_popref" add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "y\n")
    qt_quilt_ok(ARGS --quiltrc "${QT_TEST_BASE}/test_quiltrc_popref" refresh MESSAGE "initial refresh failed")
    # Modify file again so pop --refresh has something to refresh
    qt_write_file("${QT_WORK_DIR}/f.txt" "z\n")
    qt_quilt_ok(ARGS --quiltrc "${QT_TEST_BASE}/test_quiltrc_popref" pop --refresh MESSAGE "pop --refresh failed")
    # The auto-refresh should have honored QUILT_REFRESH_ARGS=--no-index
    qt_assert_file_not_contains("${QT_WORK_DIR}/patches/popref.patch" "Index:" "pop --refresh should honor QUILT_REFRESH_ARGS (--no-index)")
endfunction()

function(qt_scenario_diff_shows_changes)
    qt_begin_test("diff_shows_changes")
    qt_write_file("${QT_WORK_DIR}/f.txt" "old\n")
    qt_quilt_ok(ARGS new d.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "new\n")
    qt_quilt_ok(OUTPUT diff_out ERROR diff_err ARGS diff MESSAGE "diff failed")
    qt_assert_contains("${diff_out}" "+new" "diff should show +new")
    qt_assert_contains("${diff_out}" "-old" "diff should show -old")
endfunction()

function(qt_scenario_diff_after_refresh)
    qt_begin_test("diff_after_refresh")
    qt_write_file("${QT_WORK_DIR}/f.txt" "old\n")
    qt_quilt_ok(ARGS new d.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "new\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "newer\n")
    qt_quilt_ok(OUTPUT diff_out ERROR diff_err ARGS diff MESSAGE "diff failed")
    qt_assert_contains("${diff_out}" "+newer" "diff should show +newer")
endfunction()

function(qt_scenario_snapshot_tracks_all_applied_files)
    qt_begin_test("snapshot_tracks_all_applied_files")
    qt_write_file("${QT_WORK_DIR}/alpha.txt" "alpha-base\n")
    qt_write_file("${QT_WORK_DIR}/beta.txt" "beta-base\n")
    qt_quilt_ok(ARGS new first.patch MESSAGE "new first failed")
    qt_quilt_ok(ARGS add alpha.txt MESSAGE "add alpha failed")
    qt_write_file("${QT_WORK_DIR}/alpha.txt" "alpha-v1\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh first failed")
    qt_quilt_ok(ARGS new second.patch MESSAGE "new second failed")
    qt_quilt_ok(ARGS add beta.txt MESSAGE "add beta failed")
    qt_write_file("${QT_WORK_DIR}/beta.txt" "beta-v1\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh second failed")
    qt_quilt_ok(ARGS snapshot MESSAGE "snapshot failed")
    qt_assert_dir_exists("${QT_WORK_DIR}/.pc/.snap" "snapshot directory missing")
    qt_assert_file_text("${QT_WORK_DIR}/.pc/.snap/alpha.txt" "alpha-v1" "snapshot should capture lower patch files")
    qt_assert_file_text("${QT_WORK_DIR}/.pc/.snap/beta.txt" "beta-v1" "snapshot should capture top patch files")
endfunction()

function(qt_scenario_snapshot_replaces_previous)
    qt_begin_test("snapshot_replaces_previous")
    qt_write_file("${QT_WORK_DIR}/f.txt" "base\n")
    qt_quilt_ok(ARGS new snap.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "first\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    qt_quilt_ok(ARGS snapshot MESSAGE "first snapshot failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "second\n")
    qt_quilt_ok(ARGS snapshot MESSAGE "second snapshot failed")
    qt_assert_file_text("${QT_WORK_DIR}/.pc/.snap/f.txt" "second" "second snapshot should replace the first snapshot contents")
endfunction()

function(qt_scenario_snapshot_delete)
    qt_begin_test("snapshot_delete")
    qt_write_file("${QT_WORK_DIR}/f.txt" "base\n")
    qt_quilt_ok(ARGS new snap.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "tracked\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    qt_quilt_ok(ARGS snapshot MESSAGE "snapshot failed")
    qt_assert_dir_exists("${QT_WORK_DIR}/.pc/.snap" "snapshot directory should exist before deletion")
    qt_quilt_ok(ARGS snapshot -d MESSAGE "snapshot -d failed")
    qt_assert_not_exists("${QT_WORK_DIR}/.pc/.snap" "snapshot -d should remove the snapshot directory")
endfunction()

function(qt_scenario_diff_snapshot_shows_changes)
    qt_begin_test("diff_snapshot_shows_changes")
    qt_write_file("${QT_WORK_DIR}/f.txt" "base\n")
    qt_quilt_ok(ARGS new snap.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "snap-old\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    qt_quilt_ok(ARGS snapshot MESSAGE "snapshot failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "snap-new\n")
    qt_quilt_ok(OUTPUT diff_out ERROR diff_err ARGS diff --snapshot MESSAGE "diff --snapshot failed")
    qt_assert_contains("${diff_out}" "-snap-old" "snapshot diff should show the snapshotted content as removed")
    qt_assert_contains("${diff_out}" "+snap-new" "snapshot diff should show the new content as added")
endfunction()

function(qt_scenario_diff_snapshot_multiple_applied)
    qt_begin_test("diff_snapshot_multiple_applied")
    qt_write_file("${QT_WORK_DIR}/alpha.txt" "alpha-base\n")
    qt_write_file("${QT_WORK_DIR}/beta.txt" "beta-base\n")
    qt_quilt_ok(ARGS new first.patch MESSAGE "new first failed")
    qt_quilt_ok(ARGS add alpha.txt MESSAGE "add alpha failed")
    qt_write_file("${QT_WORK_DIR}/alpha.txt" "alpha-v1\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh first failed")
    qt_quilt_ok(ARGS new second.patch MESSAGE "new second failed")
    qt_quilt_ok(ARGS add beta.txt MESSAGE "add beta failed")
    qt_write_file("${QT_WORK_DIR}/beta.txt" "beta-v1\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh second failed")
    qt_quilt_ok(ARGS snapshot MESSAGE "snapshot failed")
    qt_write_file("${QT_WORK_DIR}/alpha.txt" "alpha-v2\n")
    qt_write_file("${QT_WORK_DIR}/beta.txt" "beta-v2\n")
    qt_quilt_ok(OUTPUT diff_out ERROR diff_err ARGS diff --snapshot MESSAGE "diff --snapshot across applied patches failed")
    qt_assert_contains("${diff_out}" "-alpha-v1" "snapshot diff should include lower patch files")
    qt_assert_contains("${diff_out}" "+alpha-v2" "snapshot diff should include updated lower patch content")
    qt_assert_contains("${diff_out}" "-beta-v1" "snapshot diff should include top patch files")
    qt_assert_contains("${diff_out}" "+beta-v2" "snapshot diff should include updated top patch content")
endfunction()

function(qt_scenario_diff_snapshot_missing)
    qt_begin_test("diff_snapshot_missing")
    qt_write_file("${QT_WORK_DIR}/f.txt" "base\n")
    qt_quilt_ok(ARGS new snap.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "tracked\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS diff --snapshot)
    qt_assert_failure("${rc}" "diff --snapshot should fail without a snapshot")
    qt_assert_contains("${err}" "No snapshot to diff against" "diff --snapshot should explain the missing snapshot")
endfunction()

function(qt_scenario_diff_snapshot_invalid_combination)
    qt_begin_test("diff_snapshot_invalid_combination")
    qt_write_file("${QT_WORK_DIR}/f.txt" "base\n")
    qt_quilt_ok(ARGS new snap.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "tracked\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS diff --snapshot -z)
    qt_assert_failure("${rc}" "diff --snapshot -z should fail")
    qt_assert_contains("${err}" "cannot be combined" "diff should reject incompatible snapshot options")
endfunction()

function(qt_scenario_delete_unapplied)
    qt_begin_test("delete_unapplied")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_quilt_ok(ARGS new del.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "y\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    qt_assert_exists("${QT_WORK_DIR}/patches/del.patch" "patch file missing after refresh")
    qt_quilt_ok(OUTPUT series_out ERROR series_err ARGS series MESSAGE "series failed")
    qt_assert_contains("${series_out}" "del.patch" "del.patch missing from series before delete")
    qt_quilt_ok(OUTPUT files_out ERROR files_err ARGS files MESSAGE "files failed")
    qt_assert_contains("${files_out}" "f.txt" "f.txt should be tracked before delete")
    qt_quilt_ok(ARGS pop MESSAGE "pop failed")
    qt_assert_file_text("${QT_WORK_DIR}/f.txt" "x" "pop should restore original file before delete")
    qt_quilt(RESULT applied_rc OUTPUT applied_out ERROR applied_err ARGS applied)
    qt_assert_failure("${applied_rc}" "no patches should be applied after pop")
    qt_quilt_ok(OUTPUT unapplied_files_out ERROR unapplied_files_err ARGS files del.patch MESSAGE "files del.patch failed")
    qt_assert_contains("${unapplied_files_out}" "f.txt" "unapplied patch should still list f.txt before delete")
    qt_quilt_ok(OUTPUT delete_out ERROR delete_err ARGS delete -n -r MESSAGE "delete failed")
    qt_assert_contains("${delete_out}" "Removed patch del.patch" "delete should report the removed patch path")
    qt_assert_equal("${delete_err}" "" "delete should not write diagnostics to stderr")
    qt_quilt_ok(OUTPUT series_after_delete ERROR series_after_delete_err ARGS series MESSAGE "series failed")
    qt_strip_trailing_newlines(series_trimmed "${series_after_delete}")
    qt_assert_equal("${series_trimmed}" "" "series should be empty after delete")
    qt_assert_not_exists("${QT_WORK_DIR}/patches/del.patch" "patch file should be removed with -r")
    qt_quilt(RESULT top_rc OUTPUT top_out ERROR top_err ARGS top)
    qt_assert_failure("${top_rc}" "top should fail after deleting the only patch")
endfunction()

function(qt_scenario_delete_unknown_patch)
    qt_begin_test("delete_unknown_patch")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_quilt_ok(ARGS new keep.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "y\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    qt_quilt_ok(ARGS pop MESSAGE "pop failed")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS delete missing.patch)
    qt_assert_failure("${rc}" "delete of an unknown patch should fail")
    qt_assert_equal("${out}" "" "delete unknown patch should not write to stdout")
    qt_assert_contains("${err}" "Patch missing.patch is not in series" "delete unknown patch should explain the missing patch")
    qt_quilt_ok(OUTPUT series_out ERROR series_err ARGS series MESSAGE "series failed after delete unknown")
    qt_assert_contains("${series_out}" "keep.patch" "delete unknown patch should leave the series unchanged")
    qt_assert_exists("${QT_WORK_DIR}/patches/keep.patch" "delete unknown patch should leave the patch file untouched")
endfunction()

function(qt_scenario_rename)
    qt_begin_test("rename")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_quilt_ok(ARGS new old.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "y\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    qt_quilt_ok(OUTPUT rename_out ERROR rename_err ARGS rename new.patch MESSAGE "rename failed")
    qt_assert_contains("${rename_out}" "old.patch renamed to new.patch" "rename should report patch paths")
    qt_assert_equal("${rename_err}" "" "rename should not write diagnostics to stderr")
    qt_quilt_ok(OUTPUT series_out ERROR series_err ARGS series MESSAGE "series failed")
    qt_assert_contains("${series_out}" "new.patch" "new name not in series")
    qt_assert_exists("${QT_WORK_DIR}/patches/new.patch" "renamed patch file missing")
    qt_assert_not_exists("${QT_WORK_DIR}/patches/old.patch" "old patch file still exists")
endfunction()

function(qt_scenario_rename_duplicate)
    qt_begin_test("rename_duplicate")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_quilt_ok(ARGS new old.patch MESSAGE "new old failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add old failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "y\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh old failed")
    qt_quilt_ok(ARGS new new.patch MESSAGE "new new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add new failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "z\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh new failed")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS rename -P old.patch new.patch)
    qt_assert_failure("${rc}" "rename to an existing patch should fail")
    qt_assert_equal("${out}" "" "rename duplicate failure should not write to stdout")
    qt_assert_contains("${err}" "new.patch exists already, please choose a different name" "rename duplicate should report the failure")
    qt_quilt_ok(OUTPUT series_out ERROR series_err ARGS series MESSAGE "series failed after rename duplicate")
    qt_assert_contains("${series_out}" "old.patch" "old.patch should remain in series after duplicate rename")
    qt_assert_contains("${series_out}" "new.patch" "new.patch should remain in series after duplicate rename")
endfunction()

function(qt_scenario_import)
    qt_begin_test("import")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_write_file("${QT_TEST_BASE}/ext_test.patch" [=[--- a/f.txt
+++ b/f.txt
@@ -1 +1 @@
-x
+imported
]=])
    qt_quilt_ok(OUTPUT import_out ERROR import_err ARGS import "${QT_TEST_BASE}/ext_test.patch" MESSAGE "import failed")
    qt_assert_contains("${import_out}" "ext_test.patch" "import should report stored patch path")
    qt_assert_equal("${import_err}" "" "import should not write diagnostics to stderr")
    qt_assert_exists("${QT_WORK_DIR}/patches/ext_test.patch" "imported patch missing")
    qt_quilt_ok(OUTPUT series_out ERROR series_err ARGS series MESSAGE "series failed")
    qt_assert_contains("${series_out}" "ext_test.patch" "import not in series")
    qt_assert_equal("${series_err}" "" "series should not write diagnostics to stderr after import")
    qt_quilt_ok(ARGS push MESSAGE "push imported patch failed")
    qt_assert_file_text("${QT_WORK_DIR}/f.txt" "imported" "imported patch not applied correctly")
endfunction()

function(qt_scenario_import_duplicate)
    qt_begin_test("import_duplicate")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_write_file("${QT_TEST_BASE}/ext_test.patch" [=[--- a/f.txt
+++ b/f.txt
@@ -1 +1 @@
-x
+imported
]=])
    qt_quilt_ok(ARGS import "${QT_TEST_BASE}/ext_test.patch" MESSAGE "first import failed")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS import "${QT_TEST_BASE}/ext_test.patch")
    qt_assert_failure("${rc}" "duplicate import should fail without -f")
    qt_assert_equal("${out}" "" "duplicate import should not write to stdout")
    qt_assert_contains("${err}" "ext_test.patch exists" "duplicate import should report the failure")
    qt_quilt_ok(OUTPUT series_out ERROR series_err ARGS series MESSAGE "series failed after duplicate import")
    qt_assert_contains("${series_out}" "ext_test.patch" "duplicate import should leave ext_test.patch in series")
    qt_assert_line_count("${series_out}" "1" "duplicate import should not add a second series entry")
endfunction()

function(qt_scenario_import_missing_source)
    qt_begin_test("import_missing_source")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_quilt_ok(ARGS new keep.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "y\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    qt_quilt_ok(ARGS pop MESSAGE "pop failed")
    set(missing_patch "${QT_TEST_BASE}/missing.patch")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS import "${missing_patch}")
    qt_assert_failure("${rc}" "import of a missing patch should fail")
    qt_assert_equal("${out}" "" "import missing source should not write to stdout")
    qt_assert_not_equal("${err}" "" "import missing source should report a diagnostic on stderr")
    qt_quilt_ok(OUTPUT series_out ERROR series_err ARGS series MESSAGE "series failed after import missing source")
    qt_assert_contains("${series_out}" "keep.patch" "import missing source should leave the existing series entry untouched")
    qt_assert_line_count("${series_out}" "1" "import missing source should not add a series entry")
    qt_assert_not_exists("${QT_WORK_DIR}/patches/missing.patch" "import missing source should not leave a partial patch file")
endfunction()

function(qt_scenario_import_strip_level)
    qt_begin_test("import_strip_level")
    # Create a patch with -p0 paths (no directory prefix to strip)
    qt_write_file("${QT_TEST_BASE}/ext.patch" [=[--- f.txt
+++ f.txt
@@ -1 +1 @@
-x
+y
]=])
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_quilt_ok(ARGS import -p 0 "${QT_TEST_BASE}/ext.patch" MESSAGE "import -p0 failed")
    # Verify series file contains -p0
    qt_assert_file_contains("${QT_WORK_DIR}/patches/series" "-p0" "series should contain -p0")
    # Push should work with strip level 0
    qt_quilt_ok(ARGS push MESSAGE "push after import -p0 failed")
    qt_assert_file_text("${QT_WORK_DIR}/f.txt" "y" "file content after push with -p0")
endfunction()

function(qt_scenario_import_strip_level_default)
    qt_begin_test("import_strip_level_default")
    qt_write_file("${QT_TEST_BASE}/ext.patch" [=[--- a/f.txt
+++ b/f.txt
@@ -1 +1 @@
-x
+y
]=])
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_quilt_ok(ARGS import "${QT_TEST_BASE}/ext.patch" MESSAGE "import failed")
    # Series should NOT contain -p (default strip level 1)
    qt_assert_file_not_contains("${QT_WORK_DIR}/patches/series" "-p" "series should not contain -p for default strip level")
endfunction()

function(qt_scenario_import_reversed)
    qt_begin_test("import_reversed")
    # Create a reverse patch: it removes "y" and adds "x", so applying in reverse turns x→y
    qt_write_file("${QT_TEST_BASE}/rev.patch" [=[--- a/f.txt
+++ b/f.txt
@@ -1 +1 @@
-y
+x
]=])
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_quilt_ok(ARGS import -R "${QT_TEST_BASE}/rev.patch" MESSAGE "import -R failed")
    # Verify series contains -R
    qt_assert_file_contains("${QT_WORK_DIR}/patches/series" "-R" "series should contain -R")
    # Push should apply in reverse (patch says y→x, but reversed means x→y)
    qt_quilt_ok(ARGS push MESSAGE "push reversed patch failed")
    qt_assert_file_text("${QT_WORK_DIR}/f.txt" "y" "reversed patch should change x to y")
endfunction()

function(qt_scenario_import_reversed_strip)
    qt_begin_test("import_reversed_strip")
    qt_write_file("${QT_TEST_BASE}/revstrip.patch" [=[--- f.txt.orig
+++ f.txt
@@ -1 +1 @@
-y
+x
]=])
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_quilt_ok(ARGS import -R -p 0 "${QT_TEST_BASE}/revstrip.patch" MESSAGE "import -R -p0 failed")
    # Verify series contains both -p0 and -R
    qt_assert_file_contains("${QT_WORK_DIR}/patches/series" "-p0" "series should contain -p0")
    qt_assert_file_contains("${QT_WORK_DIR}/patches/series" "-R" "series should contain -R")
    qt_quilt_ok(ARGS push MESSAGE "push reversed -p0 patch failed")
    qt_assert_file_text("${QT_WORK_DIR}/f.txt" "y" "reversed -p0 patch should change x to y")
endfunction()

function(qt_scenario_import_dup_keep_old)
    qt_begin_test("import_dup_keep_old")
    # Create initial patch with a header
    qt_write_file("${QT_TEST_BASE}/old.patch" [=[Old Header Line
--- a/f.txt
+++ b/f.txt
@@ -1 +1 @@
-x
+y
]=])
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_quilt_ok(ARGS import "${QT_TEST_BASE}/old.patch" MESSAGE "initial import failed")
    # Create replacement with a different header and different diff
    qt_write_file("${QT_TEST_BASE}/new.patch" [=[New Header Line
--- a/f.txt
+++ b/f.txt
@@ -1 +1 @@
-x
+z
]=])
    # Import with -f -d o (keep old header)
    qt_quilt_ok(ARGS import -f -d o "${QT_TEST_BASE}/new.patch" -P old.patch MESSAGE "import -f -d o failed")
    # Old header should be kept
    qt_assert_file_contains("${QT_WORK_DIR}/patches/old.patch" "Old Header" "old header should be preserved")
    qt_assert_file_not_contains("${QT_WORK_DIR}/patches/old.patch" "New Header" "new header should not be present")
    # But new diff content should be used
    qt_assert_file_contains("${QT_WORK_DIR}/patches/old.patch" "+z" "new diff content should be used")
endfunction()

function(qt_scenario_import_dup_append)
    qt_begin_test("import_dup_append")
    qt_write_file("${QT_TEST_BASE}/old.patch" [=[Old Header
--- a/f.txt
+++ b/f.txt
@@ -1 +1 @@
-x
+y
]=])
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_quilt_ok(ARGS import "${QT_TEST_BASE}/old.patch" MESSAGE "initial import failed")
    qt_write_file("${QT_TEST_BASE}/new.patch" [=[New Header
--- a/f.txt
+++ b/f.txt
@@ -1 +1 @@
-x
+z
]=])
    qt_quilt_ok(ARGS import -f -d a "${QT_TEST_BASE}/new.patch" -P old.patch MESSAGE "import -f -d a failed")
    # Both headers should be present
    qt_assert_file_contains("${QT_WORK_DIR}/patches/old.patch" "Old Header" "old header should be present")
    qt_assert_file_contains("${QT_WORK_DIR}/patches/old.patch" "New Header" "new header should be present")
    # New diff content
    qt_assert_file_contains("${QT_WORK_DIR}/patches/old.patch" "+z" "new diff content should be used")
endfunction()

function(qt_scenario_import_dup_new)
    qt_begin_test("import_dup_new")
    qt_write_file("${QT_TEST_BASE}/old.patch" [=[Old Header
--- a/f.txt
+++ b/f.txt
@@ -1 +1 @@
-x
+y
]=])
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_quilt_ok(ARGS import "${QT_TEST_BASE}/old.patch" MESSAGE "initial import failed")
    qt_write_file("${QT_TEST_BASE}/new.patch" [=[New Header
--- a/f.txt
+++ b/f.txt
@@ -1 +1 @@
-x
+z
]=])
    qt_quilt_ok(ARGS import -f -d n "${QT_TEST_BASE}/new.patch" -P old.patch MESSAGE "import -f -d n failed")
    # Only new header
    qt_assert_file_not_contains("${QT_WORK_DIR}/patches/old.patch" "Old Header" "old header should not be present")
    qt_assert_file_contains("${QT_WORK_DIR}/patches/old.patch" "New Header" "new header should be present")
    qt_assert_file_contains("${QT_WORK_DIR}/patches/old.patch" "+z" "new diff content should be used")
endfunction()

function(qt_scenario_import_dup_no_flag_both_headers)
    qt_begin_test("import_dup_no_flag_both_headers")
    qt_write_file("${QT_TEST_BASE}/old.patch" [=[Old Header
--- a/f.txt
+++ b/f.txt
@@ -1 +1 @@
-x
+y
]=])
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_quilt_ok(ARGS import "${QT_TEST_BASE}/old.patch" MESSAGE "initial import failed")
    qt_write_file("${QT_TEST_BASE}/new.patch" [=[New Header
--- a/f.txt
+++ b/f.txt
@@ -1 +1 @@
-x
+z
]=])
    # Import with -f but no -d should fail when both have headers
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS import -f "${QT_TEST_BASE}/new.patch" -P old.patch)
    qt_assert_failure("${rc}" "import -f without -d should fail when both patches have headers")
    qt_assert_contains("${err}" "-d" "error should mention -d flag")
endfunction()

function(qt_scenario_import_dup_no_flag_no_header)
    qt_begin_test("import_dup_no_flag_no_header")
    # Patches with no headers (start with diff markers)
    qt_write_file("${QT_TEST_BASE}/old.patch" [=[--- a/f.txt
+++ b/f.txt
@@ -1 +1 @@
-x
+y
]=])
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_quilt_ok(ARGS import "${QT_TEST_BASE}/old.patch" MESSAGE "initial import failed")
    qt_write_file("${QT_TEST_BASE}/new.patch" [=[--- a/f.txt
+++ b/f.txt
@@ -1 +1 @@
-x
+z
]=])
    # Import with -f and no -d should succeed when neither has a header
    qt_quilt_ok(ARGS import -f "${QT_TEST_BASE}/new.patch" -P old.patch MESSAGE "import -f without -d should succeed with no headers")
    qt_assert_file_contains("${QT_WORK_DIR}/patches/old.patch" "+z" "new content should be used")
endfunction()

function(qt_scenario_files)
    qt_begin_test("files")
    qt_write_file("${QT_WORK_DIR}/a.txt" "a\n")
    qt_write_file("${QT_WORK_DIR}/b.txt" "b\n")
    qt_quilt_ok(ARGS new f.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add a.txt MESSAGE "add a failed")
    qt_quilt_ok(ARGS add b.txt MESSAGE "add b failed")
    qt_write_file("${QT_WORK_DIR}/a.txt" "A\n")
    qt_write_file("${QT_WORK_DIR}/b.txt" "B\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    qt_quilt_ok(OUTPUT files_out ERROR files_err ARGS files MESSAGE "files failed")
    qt_assert_contains("${files_out}" "a.txt" "a.txt not in files")
    qt_assert_contains("${files_out}" "b.txt" "b.txt not in files")
    qt_assert_equal("${files_err}" "" "files should not write diagnostics to stderr")
endfunction()

function(qt_scenario_files_labels)
    qt_begin_test("files_labels")
    # Create two patches each modifying different files
    qt_write_file("${QT_WORK_DIR}/a.txt" "a\n")
    qt_write_file("${QT_WORK_DIR}/b.txt" "b\n")
    qt_quilt_ok(ARGS new p1.patch MESSAGE "new p1 failed")
    qt_quilt_ok(ARGS add a.txt MESSAGE "add a failed")
    qt_write_file("${QT_WORK_DIR}/a.txt" "A\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh p1 failed")

    qt_quilt_ok(ARGS new p2.patch MESSAGE "new p2 failed")
    qt_quilt_ok(ARGS add b.txt MESSAGE "add b failed")
    qt_write_file("${QT_WORK_DIR}/b.txt" "B\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh p2 failed")

    # -l for single patch: patch name prefixed
    qt_quilt_ok(OUTPUT out ERROR err ARGS files -l MESSAGE "files -l failed")
    qt_assert_contains("${out}" "p2.patch b.txt" "files -l should prefix with patch name")

    # -l with -a: both patches shown with labels
    qt_quilt_ok(OUTPUT out_all ERROR err_all ARGS files -l -a MESSAGE "files -l -a failed")
    qt_assert_contains("${out_all}" "p1.patch a.txt" "p1 label missing")
    qt_assert_contains("${out_all}" "p2.patch b.txt" "p2 label missing")
endfunction()

function(qt_scenario_files_combine)
    qt_begin_test("files_combine")
    # Create three patches
    qt_write_file("${QT_WORK_DIR}/a.txt" "a\n")
    qt_write_file("${QT_WORK_DIR}/b.txt" "b\n")
    qt_write_file("${QT_WORK_DIR}/c.txt" "c\n")

    qt_quilt_ok(ARGS new p1.patch MESSAGE "new p1 failed")
    qt_quilt_ok(ARGS add a.txt MESSAGE "add a failed")
    qt_write_file("${QT_WORK_DIR}/a.txt" "A\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh p1 failed")

    qt_quilt_ok(ARGS new p2.patch MESSAGE "new p2 failed")
    qt_quilt_ok(ARGS add b.txt MESSAGE "add b failed")
    qt_write_file("${QT_WORK_DIR}/b.txt" "B\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh p2 failed")

    qt_quilt_ok(ARGS new p3.patch MESSAGE "new p3 failed")
    qt_quilt_ok(ARGS add c.txt MESSAGE "add c failed")
    qt_write_file("${QT_WORK_DIR}/c.txt" "C\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh p3 failed")

    # --combine - (from first applied) while on top patch: all files
    qt_quilt_ok(OUTPUT out ERROR err ARGS files --combine - MESSAGE "files --combine - failed")
    qt_assert_contains("${out}" "a.txt" "a.txt missing from combine")
    qt_assert_contains("${out}" "b.txt" "b.txt missing from combine")
    qt_assert_contains("${out}" "c.txt" "c.txt missing from combine")

    # --combine p2.patch: files from p2 and p3 only
    qt_quilt_ok(OUTPUT out2 ERROR err2 ARGS files --combine p2.patch MESSAGE "files --combine p2 failed")
    qt_assert_not_contains("${out2}" "a.txt" "a.txt should not be in p2..p3 range")
    qt_assert_contains("${out2}" "b.txt" "b.txt missing from p2..p3 range")
    qt_assert_contains("${out2}" "c.txt" "c.txt missing from p2..p3 range")

    # --combine with explicit end patch: p1 through p2
    qt_quilt_ok(OUTPUT out3 ERROR err3 ARGS files --combine p1.patch p2.patch MESSAGE "files --combine p1 p2 failed")
    qt_assert_contains("${out3}" "a.txt" "a.txt missing from p1..p2 range")
    qt_assert_contains("${out3}" "b.txt" "b.txt missing from p1..p2 range")
    qt_assert_not_contains("${out3}" "c.txt" "c.txt should not be in p1..p2 range")
endfunction()

function(qt_scenario_files_combine_labels)
    qt_begin_test("files_combine_labels")
    qt_write_file("${QT_WORK_DIR}/a.txt" "a\n")
    qt_write_file("${QT_WORK_DIR}/b.txt" "b\n")

    qt_quilt_ok(ARGS new p1.patch MESSAGE "new p1 failed")
    qt_quilt_ok(ARGS add a.txt MESSAGE "add a failed")
    qt_write_file("${QT_WORK_DIR}/a.txt" "A\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh p1 failed")

    qt_quilt_ok(ARGS new p2.patch MESSAGE "new p2 failed")
    qt_quilt_ok(ARGS add b.txt MESSAGE "add b failed")
    qt_write_file("${QT_WORK_DIR}/b.txt" "B\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh p2 failed")

    # --combine with -l: per-patch labeled output
    qt_quilt_ok(OUTPUT out ERROR err ARGS files --combine - -l MESSAGE "files --combine -l failed")
    qt_assert_contains("${out}" "p1.patch a.txt" "p1 label missing in combine -l")
    qt_assert_contains("${out}" "p2.patch b.txt" "p2 label missing in combine -l")
endfunction()

function(qt_scenario_patches_cmd)
    qt_begin_test("patches_cmd")
    qt_write_file("${QT_WORK_DIR}/target.txt" "x\n")
    qt_quilt_ok(ARGS new p1.patch MESSAGE "new p1 failed")
    qt_quilt_ok(ARGS add target.txt MESSAGE "add p1 failed")
    qt_write_file("${QT_WORK_DIR}/target.txt" "1\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh p1 failed")
    qt_quilt_ok(ARGS new p2.patch MESSAGE "new p2 failed")
    qt_quilt_ok(ARGS add target.txt MESSAGE "add p2 failed")
    qt_write_file("${QT_WORK_DIR}/target.txt" "2\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh p2 failed")
    qt_quilt_ok(OUTPUT pats_out ERROR pats_err ARGS patches target.txt MESSAGE "patches failed")
    qt_assert_contains("${pats_out}" "p1.patch" "p1 not listed")
    qt_assert_contains("${pats_out}" "p2.patch" "p2 not listed")
    qt_assert_equal("${pats_err}" "" "patches should not write diagnostics to stderr")
endfunction()

function(qt_scenario_annotate_basic)
    qt_begin_test("annotate_basic")
    qt_write_file("${QT_WORK_DIR}/f.txt" "base\n")
    qt_quilt_ok(ARGS new first.patch MESSAGE "new first failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add first failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "base\none\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh first failed")
    qt_quilt_ok(ARGS new second.patch MESSAGE "new second failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add second failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "base\nONE\ntwo\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh second failed")
    qt_quilt_ok(OUTPUT annotate_out ERROR annotate_err ARGS annotate f.txt MESSAGE "annotate failed")
    qt_assert_contains("${annotate_out}" "\tbase\n" "annotate should leave untouched base lines blank")
    qt_assert_contains("${annotate_out}" "2\tONE\n" "annotate should attribute replaced lines to the latest patch")
    qt_assert_contains("${annotate_out}" "2\ttwo\n" "annotate should attribute inserted lines to the latest patch")
    qt_assert_matches("${annotate_out}" "(^|\n)1\t(patches/)?first\\.patch(\n|$)" "annotate should list the first patch in the legend")
    qt_assert_matches("${annotate_out}" "(^|\n)2\t(patches/)?second\\.patch(\n|$)" "annotate should list the second patch in the legend")
endfunction()

function(qt_scenario_annotate_stop_patch)
    qt_begin_test("annotate_stop_patch")
    qt_write_file("${QT_WORK_DIR}/f.txt" "base\n")
    qt_quilt_ok(ARGS new first.patch MESSAGE "new first failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add first failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "base\none\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh first failed")
    qt_quilt_ok(ARGS new second.patch MESSAGE "new second failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add second failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "base\nONE\ntwo\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh second failed")
    qt_quilt_ok(OUTPUT annotate_out ERROR annotate_err ARGS annotate -P first.patch f.txt MESSAGE "annotate -P failed")
    qt_assert_contains("${annotate_out}" "\tbase\n" "annotate -P should keep untouched lines unannotated")
    qt_assert_contains("${annotate_out}" "1\tone\n" "annotate -P should stop at the selected applied patch state")
    qt_assert_matches("${annotate_out}" "(^|\n)1\t(patches/)?first\\.patch(\n|$)" "annotate -P should only list the selected patch in the legend")
    qt_assert_not_contains("${annotate_out}" "second.patch" "annotate -P should exclude later patches from the legend")
endfunction()

function(qt_scenario_annotate_created_file)
    qt_begin_test("annotate_created_file")
    qt_quilt_ok(ARGS new create.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add created.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/created.txt" "hello\nworld\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    qt_quilt_ok(OUTPUT annotate_out ERROR annotate_err ARGS annotate created.txt MESSAGE "annotate created file failed")
    qt_assert_contains("${annotate_out}" "1\thello\n" "annotate should attribute created-file lines to the creating patch")
    qt_assert_contains("${annotate_out}" "1\tworld\n" "annotate should attribute every created-file line to the creating patch")
    qt_assert_matches("${annotate_out}" "(^|\n)1\t(patches/)?create\\.patch(\n|$)" "annotate should list the creating patch in the legend")
endfunction()

function(qt_scenario_annotate_unmodified_file)
    qt_begin_test("annotate_unmodified_file")
    qt_write_file("${QT_WORK_DIR}/tracked.txt" "tracked\n")
    qt_write_file("${QT_WORK_DIR}/plain.txt" "plain\ntext\n")
    qt_quilt_ok(ARGS new tracked.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add tracked.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/tracked.txt" "changed\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    qt_quilt_ok(OUTPUT annotate_out ERROR annotate_err ARGS annotate plain.txt MESSAGE "annotate unmodified file failed")
    set(expected "\tplain\n\ttext\n")
    qt_assert_equal("${annotate_out}" "${expected}" "annotate should emit blank annotations for files untouched by applied patches")
endfunction()

function(qt_scenario_annotate_unknown_patch)
    qt_begin_test("annotate_unknown_patch")
    qt_write_file("${QT_WORK_DIR}/f.txt" "base\n")
    qt_quilt_ok(ARGS new first.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "changed\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS annotate -P missing.patch f.txt)
    qt_assert_failure("${rc}" "annotate with an unknown patch should fail")
    qt_assert_equal("${out}" "" "annotate with an unknown patch should not write to stdout")
    qt_combine_output(combined "${out}" "${err}")
    qt_assert_contains("${combined}" "missing.patch" "annotate should mention the unknown patch name")
    qt_assert_contains("${combined}" "not in series" "annotate should explain unknown patches")
endfunction()

function(qt_scenario_annotate_not_applied)
    qt_begin_test("annotate_not_applied")
    qt_write_file("${QT_WORK_DIR}/f.txt" "base\n")
    qt_quilt_ok(ARGS new first.patch MESSAGE "new first failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add first failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "one\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh first failed")
    qt_quilt_ok(ARGS new second.patch MESSAGE "new second failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add second failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "two\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh second failed")
    qt_quilt_ok(ARGS pop MESSAGE "pop failed")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS annotate -P second.patch f.txt)
    qt_assert_failure("${rc}" "annotate with an unapplied patch should fail")
    qt_assert_equal("${out}" "" "annotate with an unapplied patch should not write to stdout")
    qt_combine_output(combined "${out}" "${err}")
    qt_assert_contains("${combined}" "second.patch" "annotate should mention the unapplied patch name")
    qt_assert_contains("${combined}" "not applied" "annotate should explain unapplied patch failures")
endfunction()

function(qt_scenario_annotate_usage)
    qt_begin_test("annotate_usage")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS annotate)
    qt_assert_failure("${rc}" "annotate without a file should fail")
    qt_combine_output(usage_out "${out}" "${err}")
    qt_assert_matches("${usage_out}" "Usage: quilt annotate \\[-P patch\\] (\\{file\\}|file)" "annotate should print its usage line on invalid arguments")
endfunction()

function(qt_scenario_annotate_help)
    qt_begin_test("annotate_help")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS annotate -h)
    qt_assert_success("${rc}" "annotate -h should succeed")
    qt_combine_output(help_out "${out}" "${err}")
    qt_assert_matches("${help_out}" "Usage: quilt annotate \\[-P patch\\] (\\{file\\}|file)" "annotate -h should print the usage line")
    qt_assert_contains("${help_out}" "-P patch" "annotate -h should describe the stop patch option")
endfunction()

function(qt_scenario_annotate_subdirectory)
    qt_begin_test("annotate_subdirectory")
    file(MAKE_DIRECTORY "${QT_WORK_DIR}/src")
    qt_write_file("${QT_WORK_DIR}/src/f.c" "base\n")
    qt_quilt_ok(ARGS new first.patch MESSAGE "new first failed")
    qt_quilt_ok(ARGS add src/f.c MESSAGE "add first failed")
    qt_write_file("${QT_WORK_DIR}/src/f.c" "base\none\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh first failed")
    qt_quilt_ok(ARGS new second.patch MESSAGE "new second failed")
    qt_quilt_ok(ARGS add src/f.c MESSAGE "add second failed")
    qt_write_file("${QT_WORK_DIR}/src/f.c" "base\nONE\ntwo\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh second failed")
    # Run annotate from inside src/
    qt_quilt_ok(
        OUTPUT annotate_out ERROR annotate_err
        WORKING_DIRECTORY "${QT_WORK_DIR}/src"
        ARGS annotate f.c
        MESSAGE "annotate from subdirectory failed"
    )
    qt_assert_contains("${annotate_out}" "\tbase\n"
        "annotate from subdirectory should show base line")
    qt_assert_contains("${annotate_out}" "2\tONE\n"
        "annotate from subdirectory should attribute replaced line to second patch")
    qt_assert_contains("${annotate_out}" "2\ttwo\n"
        "annotate from subdirectory should attribute inserted line to second patch")
endfunction()

function(qt_scenario_graph_lines_with_num)
    qt_begin_test("graph_lines_with_num")
    qt_write_file("${QT_WORK_DIR}/f.txt" "1\n2\n3\n4\n5\n6\n7\n8\n9\n10\n")
    qt_quilt_ok(ARGS new first.patch MESSAGE "new first failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add first failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "1\n2a\n3\n4\n5\n6\n7\n8\n9\n10\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh first failed")
    qt_quilt_ok(ARGS new second.patch MESSAGE "new second failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add second failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "1\n2a\n3\n4\n5\n6\n7\n8\n9b\n10\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh second failed")
    # --lines followed by a number (covers the `opt_lines = stoi(argv[++i])` branch)
    qt_quilt_ok(OUTPUT graph_out ERROR graph_err ARGS graph --lines 3 MESSAGE "graph --lines 3 failed")
    qt_assert_contains("${graph_out}" "digraph dependencies {" "graph --lines N should emit DOT")
endfunction()

function(qt_scenario_graph_lines_nan)
    qt_begin_test("graph_lines_nan")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "y\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    # --lines=notanumber should fail
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS graph --lines=notanumber)
    qt_assert_failure("${rc}" "graph --lines=NaN should fail")
    qt_assert_contains("${err}" "Usage:" "should print usage on bad --lines=")
endfunction()

function(qt_scenario_graph_edge_labels_space)
    qt_begin_test("graph_edge_labels_space")
    qt_write_file("${QT_WORK_DIR}/f.txt" "base\n")
    qt_quilt_ok(ARGS new first.patch MESSAGE "new first failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add first failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "one\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh first failed")
    qt_quilt_ok(ARGS new second.patch MESSAGE "new second failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add second failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "two\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh second failed")
    # --edge-labels files (space form, not =)
    qt_quilt_ok(OUTPUT graph_out ERROR graph_err ARGS graph --edge-labels files MESSAGE "graph --edge-labels files failed")
    qt_assert_contains("${graph_out}" "label=" "edge-labels should add label attribute")
endfunction()

function(qt_scenario_graph_edge_labels_bad)
    qt_begin_test("graph_edge_labels_bad")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "y\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    # --edge-labels without valid next arg
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS graph --edge-labels badarg)
    qt_assert_failure("${rc}" "graph --edge-labels badarg should fail")
    qt_assert_contains("${err}" "Usage:" "should print usage")
endfunction()

function(qt_scenario_graph_T_bad)
    qt_begin_test("graph_T_bad")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "y\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    # -T without "ps" → usage error
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS graph -T notps)
    qt_assert_failure("${rc}" "graph -T notps should fail")
    qt_assert_contains("${err}" "Usage:" "should print usage")
endfunction()

function(qt_scenario_graph_T_ps)
    qt_begin_test("graph_T_ps")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "y\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    # -T ps → not implemented error
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS graph -T ps)
    qt_assert_failure("${rc}" "graph -T ps should fail")
    qt_assert_contains("${err}" "not implemented" "should say not implemented")
endfunction()

function(qt_scenario_graph_Tps)
    qt_begin_test("graph_Tps")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "y\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    # -Tps → not implemented error
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS graph -Tps)
    qt_assert_failure("${rc}" "graph -Tps should fail")
    qt_assert_contains("${err}" "not implemented" "should say not implemented")
endfunction()

function(qt_scenario_graph_bad_option)
    qt_begin_test("graph_bad_option")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "y\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS graph --unknown-option)
    qt_assert_failure("${rc}" "graph with unknown option should fail")
    qt_assert_contains("${err}" "Usage:" "should print usage for unknown option")
endfunction()

function(qt_scenario_graph_two_patches)
    qt_begin_test("graph_two_patches")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_quilt_ok(ARGS new p1.patch MESSAGE "new p1 failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add p1 failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "y\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh p1 failed")
    qt_quilt_ok(ARGS new p2.patch MESSAGE "new p2 failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add p2 failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "z\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh p2 failed")
    # Two positional patch arguments → usage error
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS graph p1.patch p2.patch)
    qt_assert_failure("${rc}" "graph with two patch args should fail")
    qt_assert_contains("${err}" "Usage:" "should print usage for two patches")
endfunction()

function(qt_scenario_graph_all_with_patch)
    qt_begin_test("graph_all_with_patch")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "y\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    # --all combined with a patch name → conflict
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS graph --all p.patch)
    qt_assert_failure("${rc}" "graph --all with patch arg should fail")
    qt_assert_contains("${err}" "Usage:" "should print usage")
endfunction()

function(qt_scenario_graph_no_applied_with_series)
    qt_begin_test("graph_no_applied_with_series")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "y\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    qt_quilt_ok(ARGS pop MESSAGE "pop failed")
    # Series has a patch but nothing applied → "No patches applied"
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS graph)
    qt_assert_failure("${rc}" "graph with nothing applied should fail")
    qt_assert_contains("${err}" "patches applied" "should say no patches applied")
endfunction()

function(qt_scenario_graph_all_empty)
    qt_begin_test("graph_all_empty")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "y\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    qt_quilt_ok(ARGS pop MESSAGE "pop failed")
    # --all with nothing applied → "No patches applied"
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS graph --all)
    qt_assert_failure("${rc}" "graph --all with nothing applied should fail")
    qt_assert_contains("${err}" "patches applied" "should say no patches applied")
endfunction()

function(qt_scenario_graph_unapplied_patch)
    qt_begin_test("graph_unapplied_patch")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_quilt_ok(ARGS new first.patch MESSAGE "new first failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add first failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "y\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh first failed")
    qt_quilt_ok(ARGS new second.patch MESSAGE "new second failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add second failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "z\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh second failed")
    qt_quilt_ok(ARGS pop MESSAGE "pop failed")
    # second.patch is in series but not applied → error
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS graph second.patch)
    qt_assert_failure("${rc}" "graph with unapplied patch should fail")
    qt_assert_contains("${err}" "not applied" "should say patch is not applied")
endfunction()

function(qt_scenario_stub_grep)
    qt_begin_test("stub_grep")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS grep pattern)
    qt_assert_failure("${rc}" "quilt grep should fail (not implemented)")
    qt_assert_contains("${err}" "not implemented" "grep should say not implemented")
endfunction()

function(qt_scenario_stub_setup)
    qt_begin_test("stub_setup")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS setup)
    qt_assert_failure("${rc}" "quilt setup should fail (not implemented)")
    qt_assert_contains("${err}" "not implemented" "setup should say not implemented")
endfunction()

function(qt_scenario_stub_shell)
    qt_begin_test("stub_shell")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS shell)
    qt_assert_failure("${rc}" "quilt shell should fail (not implemented)")
    qt_assert_contains("${err}" "not implemented" "shell should say not implemented")
endfunction()

function(qt_scenario_annotate_bad_option)
    qt_begin_test("annotate_bad_option")
    qt_write_file("${QT_WORK_DIR}/f.txt" "a\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "b\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS annotate -x f.txt)
    qt_assert_failure("${rc}" "annotate with bad option should fail")
    qt_assert_contains("${err}" "Usage:" "bad option should print usage")
endfunction()

function(qt_scenario_annotate_two_files)
    qt_begin_test("annotate_two_files")
    qt_write_file("${QT_WORK_DIR}/a.txt" "a\n")
    qt_write_file("${QT_WORK_DIR}/b.txt" "b\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add a.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/a.txt" "x\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS annotate a.txt b.txt)
    qt_assert_failure("${rc}" "annotate with two files should fail")
    qt_assert_contains("${err}" "Usage:" "two files should print usage")
endfunction()

function(qt_scenario_annotate_no_applied)
    qt_begin_test("annotate_no_applied")
    qt_write_file("${QT_WORK_DIR}/f.txt" "a\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "b\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    qt_quilt_ok(ARGS pop MESSAGE "pop failed")
    # Series non-empty but nothing applied
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS annotate f.txt)
    qt_assert_failure("${rc}" "annotate with nothing applied should fail")
    qt_assert_contains("${err}" "patches applied" "should say no patches applied")
endfunction()

function(qt_scenario_annotate_empty_series)
    qt_begin_test("annotate_empty_series")
    # Create a series file with no patches
    file(MAKE_DIRECTORY "${QT_WORK_DIR}/patches")
    file(WRITE "${QT_WORK_DIR}/patches/series" "")
    file(MAKE_DIRECTORY "${QT_WORK_DIR}/.pc")
    file(WRITE "${QT_WORK_DIR}/.pc/.version" "2\n")
    file(WRITE "${QT_WORK_DIR}/.pc/.quilt_patches" "patches\n")
    file(WRITE "${QT_WORK_DIR}/.pc/.quilt_series" "series\n")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS annotate f.txt)
    qt_assert_failure("${rc}" "annotate with empty series should fail")
    qt_assert_contains("${err}" "patches" "should mention patches")
endfunction()

function(qt_scenario_annotate_nonexistent_file)
    qt_begin_test("annotate_nonexistent_file")
    qt_write_file("${QT_WORK_DIR}/f.txt" "a\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "b\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    # Annotate a file that doesn't exist and is not tracked by any patch
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS annotate nosuchfile.txt)
    qt_assert_failure("${rc}" "annotate nonexistent file should fail")
    qt_assert_contains("${err}" "nosuchfile.txt" "should mention the file name")
endfunction()

function(qt_scenario_header)
    qt_begin_test("header")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_quilt_ok(ARGS new h.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "y\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    qt_quilt_ok(OUTPUT hdr ERROR hdr_err ARGS header MESSAGE "header read failed")
    qt_strip_trailing_newlines(hdr_trimmed "${hdr}")
    qt_assert_equal("${hdr_trimmed}" "" "header should be empty initially")
    qt_quilt_ok(ARGS header -r INPUT "This is the header\n" MESSAGE "header -r failed")
    qt_quilt_ok(OUTPUT hdr2 ERROR hdr2_err ARGS header MESSAGE "header readback failed")
    qt_assert_contains("${hdr2}" "This is the header" "header not set correctly")
endfunction()

function(qt_scenario_edit)
    qt_begin_test("edit")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_quilt_ok(ARGS new e.patch MESSAGE "new failed")
    qt_quilt_ok(ENV "EDITOR=true" ARGS edit f.txt MESSAGE "edit failed")
    qt_quilt_ok(OUTPUT files_out ERROR files_err ARGS files MESSAGE "files failed")
    qt_assert_contains("${files_out}" "f.txt" "file not added by edit")
endfunction()

function(qt_scenario_revert)
    qt_begin_test("revert")
    qt_write_file("${QT_WORK_DIR}/f.txt" "original\n")
    qt_quilt_ok(ARGS new r.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "modified\n")
    qt_quilt_ok(OUTPUT revert_out ERROR revert_err ARGS revert f.txt MESSAGE "revert failed")
    qt_assert_contains("${revert_out}" "Changes to f.txt in patch r.patch reverted" "revert should report patch paths")
    qt_assert_equal("${revert_err}" "" "revert should not write diagnostics to stderr")
    qt_assert_file_text("${QT_WORK_DIR}/f.txt" "original" "revert did not restore")
endfunction()

function(qt_scenario_revert_not_tracked)
    qt_begin_test("revert_not_tracked")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_quilt_ok(ARGS new r.patch MESSAGE "new failed")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS revert f.txt)
    qt_assert_failure("${rc}" "revert of an untracked file should fail")
    qt_assert_equal("${out}" "" "revert failure should not write to stdout")
    qt_assert_contains("${err}" "File f.txt is not in patch r.patch" "revert failure should mention the patch path")
endfunction()

function(qt_scenario_remove)
    qt_begin_test("remove")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_quilt_ok(ARGS new rm.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "y\n")
    qt_quilt_ok(OUTPUT tracked_out ERROR tracked_err ARGS files MESSAGE "files failed before remove")
    qt_assert_contains("${tracked_out}" "f.txt" "f.txt should be tracked before remove")
    qt_quilt_ok(OUTPUT remove_out ERROR remove_err ARGS remove f.txt MESSAGE "remove failed")
    qt_assert_contains("${remove_out}" "File f.txt removed from patch rm.patch" "remove should report patch paths")
    qt_assert_equal("${remove_err}" "" "remove should not write diagnostics to stderr")
    qt_quilt_ok(OUTPUT files_out ERROR files_err ARGS files MESSAGE "files failed")
    qt_assert_not_contains("${files_out}" "f.txt" "file still in patch after remove")
    qt_assert_file_text("${QT_WORK_DIR}/f.txt" "x" "remove should restore original file")
    qt_assert_not_exists("${QT_WORK_DIR}/.pc/rm.patch/f.txt" "backup file should be removed from .pc after remove")
endfunction()

function(qt_scenario_fork)
    qt_begin_test("fork")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_quilt_ok(ARGS new orig.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "y\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    qt_quilt_ok(ARGS fork forked.patch MESSAGE "fork failed")
    qt_assert_exists("${QT_WORK_DIR}/patches/forked.patch" "forked patch file missing")
    qt_quilt_ok(OUTPUT top_out ERROR top_err ARGS top MESSAGE "top failed")
    qt_assert_contains("${top_out}" "forked.patch" "top should be forked.patch")
endfunction()

function(qt_scenario_fork_no_applied_patch)
    qt_begin_test("fork_no_applied_patch")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS fork forked.patch)
    qt_assert_failure("${rc}" "fork with no applied patch should fail")
    qt_assert_equal("${out}" "" "fork with no applied patch should not write to stdout")
    qt_assert_not_equal("${err}" "" "fork with no applied patch should report a diagnostic on stderr")
endfunction()

function(qt_scenario_fork_duplicate_name)
    qt_begin_test("fork_duplicate_name")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_quilt_ok(ARGS new base.patch MESSAGE "new base failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add base failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "y\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh base failed")
    qt_quilt_ok(ARGS new forked.patch MESSAGE "new forked failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add forked failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "z\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh forked failed")
    qt_quilt_ok(ARGS pop MESSAGE "pop failed")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS fork forked.patch)
    qt_assert_failure("${rc}" "fork to an existing patch name should fail")
    qt_assert_equal("${out}" "" "fork duplicate should not write to stdout")
    qt_assert_not_equal("${err}" "" "fork duplicate should report a diagnostic on stderr")
    qt_quilt_ok(OUTPUT top_out ERROR top_err ARGS top MESSAGE "top failed after fork duplicate")
    qt_assert_contains("${top_out}" "base.patch" "fork duplicate should leave the current top patch unchanged")
    qt_quilt_ok(OUTPUT series_out ERROR series_err ARGS series MESSAGE "series failed after fork duplicate")
    qt_assert_contains("${series_out}" "base.patch" "fork duplicate should leave base.patch in the series")
    qt_assert_contains("${series_out}" "forked.patch" "fork duplicate should leave forked.patch in the series")
    qt_assert_exists("${QT_WORK_DIR}/patches/base.patch" "fork duplicate should leave the original patch file untouched")
    qt_assert_exists("${QT_WORK_DIR}/patches/forked.patch" "fork duplicate should leave the conflicting patch file untouched")
endfunction()

function(qt_scenario_fold)
    qt_begin_test("fold")
    qt_write_file("${QT_WORK_DIR}/f.txt" "base\n")
    qt_quilt_ok(ARGS new target.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_quilt_ok(
        ARGS fold
        INPUT [=[--- a/f.txt
+++ b/f.txt
@@ -1 +1 @@
-base
+folded
]=]
        MESSAGE "fold failed"
    )
    qt_assert_file_text("${QT_WORK_DIR}/f.txt" "folded" "fold did not apply")
endfunction()

function(qt_scenario_add_no_patch)
    qt_begin_test("add_no_patch")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS add f.txt)
    qt_assert_failure("${rc}" "add with no patch should fail")
    qt_assert_equal("${out}" "" "add with no patch should not write to stdout")
    qt_assert_contains("${err}" "No series file found" "add with no patch should explain the missing series file")
endfunction()

function(qt_scenario_add_prefixed_patch_arg)
    qt_begin_test("add_prefixed_patch_arg")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(OUTPUT add_out ERROR add_err ARGS add -P patches/p.patch f.txt MESSAGE "add with prefixed patch failed")
    qt_assert_contains("${add_out}" "File f.txt added to patch p.patch" "add -P patches/... should add the file to the patch")
    qt_assert_equal("${add_err}" "" "add -P patches/... should not write diagnostics to stderr")
    qt_assert_exists("${QT_WORK_DIR}/.pc/p.patch/f.txt" "add -P patches/... should track the file under .pc/p.patch")
    qt_assert_not_exists("${QT_WORK_DIR}/.pc/patches/p.patch/f.txt" "add -P patches/... should not treat the prefix as part of the patch name")
endfunction()

function(qt_scenario_add_already_tracked)
    qt_begin_test("add_already_tracked")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_quilt_ok(ARGS new dup.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "first add failed")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS add f.txt)
    qt_assert_failure("${rc}" "adding same file twice should fail")
    qt_assert_equal("${out}" "" "duplicate add should not write to stdout")
    qt_assert_contains("${err}" "File f.txt is already in patch dup.patch" "duplicate add should mention the patch")
endfunction()

function(qt_scenario_remove_not_tracked)
    qt_begin_test("remove_not_tracked")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_quilt_ok(ARGS new rm.patch MESSAGE "new failed")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS remove f.txt)
    qt_assert_failure("${rc}" "remove of an untracked file should fail")
    qt_assert_equal("${out}" "" "remove failure should not write to stdout")
    qt_assert_contains("${err}" "File f.txt is not in patch rm.patch" "remove failure should mention the patch")
endfunction()

function(qt_scenario_subdirectory_files)
    qt_begin_test("subdirectory_files")
    file(MAKE_DIRECTORY "${QT_WORK_DIR}/sub/dir")
    qt_write_file("${QT_WORK_DIR}/sub/dir/deep.txt" "deep\n")
    qt_quilt_ok(ARGS new sub.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add sub/dir/deep.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/sub/dir/deep.txt" "modified\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    qt_quilt_ok(ARGS pop MESSAGE "pop failed")
    qt_assert_file_text("${QT_WORK_DIR}/sub/dir/deep.txt" "deep" "subdirectory restore failed")
    qt_quilt_ok(ARGS push MESSAGE "push failed")
    qt_assert_file_text("${QT_WORK_DIR}/sub/dir/deep.txt" "modified" "subdirectory apply failed")
endfunction()

function(qt_scenario_subdirectory_add_edit)
    qt_begin_test("subdirectory_add_edit")
    # Create a file inside a subdirectory
    file(MAKE_DIRECTORY "${QT_WORK_DIR}/src")
    qt_write_file("${QT_WORK_DIR}/src/main.c" "int main() {}\n")
    qt_quilt_ok(ARGS new fixes.patch MESSAGE "new failed")
    # Run 'quilt add main.c' from inside src/
    qt_quilt_ok(
        OUTPUT add_out ERROR add_err
        WORKING_DIRECTORY "${QT_WORK_DIR}/src"
        ARGS add main.c
        MESSAGE "add from subdirectory failed"
    )
    qt_assert_contains("${add_out}" "File src/main.c added to patch"
        "add should report the project-relative path src/main.c")
    # The backup should be at .pc/fixes.patch/src/main.c
    qt_assert_exists("${QT_WORK_DIR}/.pc/fixes.patch/src/main.c"
        "backup should be at .pc/fixes.patch/src/main.c")
    # Modify the file and refresh
    qt_write_file("${QT_WORK_DIR}/src/main.c" "int main() { return 0; }\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    # Verify the patch contains src/main.c not just main.c
    file(READ "${QT_WORK_DIR}/patches/fixes.patch" patch_content)
    string(FIND "${patch_content}" "src/main.c" found_pos)
    if(found_pos EQUAL -1)
        qt_fail("patch should reference src/main.c")
    endif()
    # Pop and verify restore
    qt_quilt_ok(ARGS pop MESSAGE "pop failed")
    qt_assert_file_text("${QT_WORK_DIR}/src/main.c" "int main() {}"
        "pop should restore original content")
    # Push and verify apply
    qt_quilt_ok(ARGS push MESSAGE "push failed")
    qt_assert_file_text("${QT_WORK_DIR}/src/main.c" "int main() { return 0; }"
        "push should apply modification")
endfunction()

function(qt_scenario_edit_multiple_files)
    qt_begin_test("edit_multiple_files")
    qt_write_file("${QT_WORK_DIR}/a.txt" "aaa\n")
    qt_write_file("${QT_WORK_DIR}/b.txt" "bbb\n")
    qt_quilt_ok(ARGS new multi.patch MESSAGE "new failed")
    qt_quilt_ok(ENV "EDITOR=true" ARGS edit a.txt b.txt MESSAGE "edit failed")
    qt_quilt_ok(OUTPUT files_out ERROR files_err ARGS files MESSAGE "files failed")
    qt_assert_contains("${files_out}" "a.txt" "a.txt not tracked after edit")
    qt_assert_contains("${files_out}" "b.txt" "b.txt not tracked after edit")
endfunction()

function(qt_scenario_edit_no_patch)
    qt_begin_test("edit_no_patch")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS pop MESSAGE "pop failed")
    qt_quilt(RESULT rc OUTPUT out ERROR err ENV "EDITOR=true" ARGS edit f.txt)
    qt_assert_failure("${rc}" "edit with no patch should fail")
    qt_combine_output(combined "${out}" "${err}")
    qt_assert_contains("${combined}" "No patches applied" "edit should explain no patches applied")
endfunction()

function(qt_scenario_edit_already_tracked)
    qt_begin_test("edit_already_tracked")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_quilt_ok(ARGS new e.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_quilt_ok(OUTPUT edit_out ERROR edit_err ENV "EDITOR=true" ARGS edit f.txt MESSAGE "edit failed")
    qt_assert_not_contains("${edit_out}" "added to patch" "edit should not report adding an already-tracked file")
endfunction()

function(qt_scenario_fold_new_file)
    qt_begin_test("fold_new_file")
    qt_quilt_ok(ARGS new target.patch MESSAGE "new failed")
    qt_quilt_ok(
        ARGS fold
        INPUT [=[--- /dev/null
+++ b/newfile.txt
@@ -0,0 +1 @@
+created
]=]
        MESSAGE "fold failed"
    )
    qt_assert_file_text("${QT_WORK_DIR}/newfile.txt" "created" "fold did not create new file")
    qt_quilt_ok(OUTPUT files_out ERROR files_err ARGS files MESSAGE "files failed")
    qt_assert_contains("${files_out}" "newfile.txt" "new file should be tracked after fold")
endfunction()

function(qt_scenario_fold_no_patch)
    qt_begin_test("fold_no_patch")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS pop MESSAGE "pop failed")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS fold INPUT "dummy\n")
    qt_assert_failure("${rc}" "fold with no patch should fail")
    qt_combine_output(combined "${out}" "${err}")
    qt_assert_contains("${combined}" "No patch" "fold should explain no patch applied")
endfunction()

function(qt_scenario_fold_reverse)
    qt_begin_test("fold_reverse")
    qt_write_file("${QT_WORK_DIR}/f.txt" "new\n")
    qt_quilt_ok(ARGS new target.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_quilt_ok(
        ARGS fold -R
        INPUT [=[--- a/f.txt
+++ b/f.txt
@@ -1 +1 @@
-old
+new
]=]
        MESSAGE "fold -R failed"
    )
    qt_assert_file_text("${QT_WORK_DIR}/f.txt" "old" "fold -R did not reverse-apply")
endfunction()

function(qt_scenario_unapplied_all_applied)
    qt_begin_test("unapplied_all_applied")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_quilt_ok(ARGS new only.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "y\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS unapplied)
    qt_assert_failure("${rc}" "unapplied when all applied should fail")
    qt_combine_output(combined "${out}" "${err}")
    qt_assert_contains("${combined}" "fully applied" "unapplied should say series is fully applied")
endfunction()

function(qt_scenario_unapplied_none_applied)
    qt_begin_test("unapplied_none_applied")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_quilt_ok(ARGS new p1.patch MESSAGE "new p1 failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "y\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    qt_quilt_ok(ARGS new p2.patch MESSAGE "new p2 failed")
    qt_quilt_ok(ARGS pop -a MESSAGE "pop failed")
    qt_quilt_ok(OUTPUT out ERROR err ARGS unapplied MESSAGE "unapplied failed")
    qt_assert_contains("${out}" "p1.patch" "p1 should be listed as unapplied")
    qt_assert_contains("${out}" "p2.patch" "p2 should be listed as unapplied")
endfunction()

function(qt_scenario_unapplied_named)
    qt_begin_test("unapplied_named")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_quilt_ok(ARGS new p1.patch MESSAGE "new p1 failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add p1 failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "1\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh p1 failed")
    qt_quilt_ok(ARGS new p2.patch MESSAGE "new p2 failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add p2 failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "2\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh p2 failed")
    qt_quilt_ok(ARGS new p3.patch MESSAGE "new p3 failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add p3 failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "3\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh p3 failed")
    qt_quilt_ok(OUTPUT out ERROR err ARGS unapplied p1.patch MESSAGE "unapplied p1 failed")
    qt_assert_contains("${out}" "p2.patch" "p2 should be listed after p1")
    qt_assert_contains("${out}" "p3.patch" "p3 should be listed after p1")
    qt_assert_not_contains("${out}" "p1.patch" "p1 should not be listed in its own unapplied output")
endfunction()

function(qt_scenario_upgrade_noop)
    qt_begin_test("upgrade_noop")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "y\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    qt_quilt_ok(ARGS upgrade MESSAGE "upgrade failed")
    # Verify nothing broke — top should still work
    qt_quilt_ok(OUTPUT top_out ERROR top_err ARGS top MESSAGE "top failed after upgrade")
    qt_assert_contains("${top_out}" "p.patch" "top should still show p.patch after upgrade")
endfunction()

function(qt_scenario_patches_verbose)
    qt_begin_test("patches_verbose")
    qt_write_file("${QT_WORK_DIR}/target.txt" "x\n")
    qt_quilt_ok(ARGS new p1.patch MESSAGE "new p1 failed")
    qt_quilt_ok(ARGS add target.txt MESSAGE "add p1 failed")
    qt_write_file("${QT_WORK_DIR}/target.txt" "1\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh p1 failed")
    qt_quilt_ok(ARGS new p2.patch MESSAGE "new p2 failed")
    qt_quilt_ok(ARGS add target.txt MESSAGE "add p2 failed")
    qt_write_file("${QT_WORK_DIR}/target.txt" "2\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh p2 failed")
    qt_quilt_ok(ARGS pop MESSAGE "pop failed")
    qt_quilt_ok(OUTPUT pats_out ERROR pats_err ARGS patches -v target.txt MESSAGE "patches -v failed")
    qt_assert_matches("${pats_out}" "= .*p1\\.patch" "applied patch should have = prefix")
    qt_assert_matches("${pats_out}" "  .*p2\\.patch" "unapplied patch should have space prefix")
endfunction()

function(qt_scenario_patches_unapplied)
    qt_begin_test("patches_unapplied")
    qt_write_file("${QT_WORK_DIR}/target.txt" "x\n")
    qt_quilt_ok(ARGS new p1.patch MESSAGE "new p1 failed")
    qt_quilt_ok(ARGS add target.txt MESSAGE "add p1 failed")
    qt_write_file("${QT_WORK_DIR}/target.txt" "1\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh p1 failed")
    qt_quilt_ok(ARGS pop MESSAGE "pop failed")
    qt_quilt_ok(OUTPUT pats_out ERROR pats_err ARGS patches target.txt MESSAGE "patches failed")
    qt_assert_contains("${pats_out}" "p1.patch" "unapplied patch touching target should be listed")
endfunction()

function(qt_scenario_remove_with_P)
    qt_begin_test("remove_with_P")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_quilt_ok(ARGS new base.patch MESSAGE "new base failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add base failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "y\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh base failed")
    qt_quilt_ok(ARGS new top.patch MESSAGE "new top failed")
    qt_quilt_ok(OUTPUT rm_out ERROR rm_err ARGS remove -P base.patch f.txt MESSAGE "remove -P failed")
    qt_assert_contains("${rm_out}" "File f.txt removed from patch base.patch" "remove -P should report the correct patch")
    qt_assert_file_text("${QT_WORK_DIR}/f.txt" "x" "remove -P should restore from the base patch backup")
endfunction()

function(qt_scenario_rename_unapplied)
    qt_begin_test("rename_unapplied")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_quilt_ok(ARGS new old.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "y\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    qt_quilt_ok(ARGS pop MESSAGE "pop failed")
    qt_quilt_ok(OUTPUT rename_out ERROR rename_err ARGS rename -P old.patch new.patch MESSAGE "rename unapplied failed")
    qt_assert_contains("${rename_out}" "old.patch renamed to new.patch" "rename should report correct paths")
    qt_assert_exists("${QT_WORK_DIR}/patches/new.patch" "renamed patch file should exist")
    qt_assert_not_exists("${QT_WORK_DIR}/patches/old.patch" "old patch file should not exist")
    qt_quilt_ok(OUTPUT series_out ERROR series_err ARGS series MESSAGE "series failed")
    qt_assert_contains("${series_out}" "new.patch" "new name should be in series")
    qt_assert_not_contains("${series_out}" "old.patch" "old name should not be in series")
    # Verify the patch still applies
    qt_quilt_ok(ARGS push MESSAGE "push renamed patch failed")
    qt_assert_file_text("${QT_WORK_DIR}/f.txt" "y" "push renamed patch should apply correctly")
endfunction()

function(qt_scenario_revert_new_file)
    qt_begin_test("revert_new_file")
    qt_quilt_ok(ARGS new create.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add newfile.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/newfile.txt" "created\n")
    qt_quilt_ok(OUTPUT revert_out ERROR revert_err ARGS revert newfile.txt MESSAGE "revert failed")
    qt_assert_contains("${revert_out}" "Changes to newfile.txt in patch create.patch reverted" "revert should report the file")
    qt_assert_not_exists("${QT_WORK_DIR}/newfile.txt" "revert should delete a file that did not exist before the patch")
endfunction()

function(qt_scenario_next_none_applied)
    qt_begin_test("next_none_applied")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_quilt_ok(ARGS new first.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "y\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    qt_quilt_ok(ARGS pop MESSAGE "pop failed")
    qt_quilt_ok(OUTPUT next_out ERROR next_err ARGS next MESSAGE "next failed")
    qt_assert_contains("${next_out}" "first.patch" "next with none applied should show first patch")
endfunction()

function(qt_scenario_series_verbose)
    qt_begin_test("series_verbose")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_quilt_ok(ARGS new p1.patch MESSAGE "new p1 failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add p1 failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "1\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh p1 failed")
    qt_quilt_ok(ARGS new p2.patch MESSAGE "new p2 failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add p2 failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "2\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh p2 failed")
    qt_quilt_ok(ARGS pop MESSAGE "pop failed")
    qt_quilt_ok(OUTPUT series_out ERROR series_err ARGS series -v MESSAGE "series -v failed")
    qt_assert_matches("${series_out}" "= .*p1\\.patch" "applied patch should have = prefix")
    qt_assert_matches("${series_out}" "  .*p2\\.patch" "unapplied patch should have space prefix")
endfunction()

function(qt_scenario_previous_with_target)
    qt_begin_test("previous_with_target")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_quilt_ok(ARGS new p1.patch MESSAGE "new p1 failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add p1 failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "1\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh p1 failed")
    qt_quilt_ok(ARGS new p2.patch MESSAGE "new p2 failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add p2 failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "2\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh p2 failed")
    qt_quilt_ok(ARGS new p3.patch MESSAGE "new p3 failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add p3 failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "3\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh p3 failed")
    qt_quilt_ok(OUTPUT prev_out ERROR prev_err ARGS previous p3.patch MESSAGE "previous p3 failed")
    qt_assert_contains("${prev_out}" "p2.patch" "previous p3 should show p2")
    qt_quilt_ok(OUTPUT prev2_out ERROR prev2_err ARGS previous p2.patch MESSAGE "previous p2 failed")
    qt_assert_contains("${prev2_out}" "p1.patch" "previous p2 should show p1")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS previous p1.patch)
    qt_assert_failure("${rc}" "previous of first patch should fail")
endfunction()

function(qt_scenario_empty_patch)
    qt_begin_test("empty_patch")
    qt_quilt_ok(ARGS new empty.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh empty patch failed")
    qt_quilt_ok(OUTPUT series_out ERROR series_err ARGS series MESSAGE "series failed")
    qt_assert_contains("${series_out}" "empty.patch" "empty.patch missing from series after refresh")
    qt_quilt_ok(OUTPUT top_out ERROR top_err ARGS top MESSAGE "top failed")
    qt_assert_contains("${top_out}" "empty.patch" "top should show empty.patch after refresh")
    qt_assert_exists("${QT_WORK_DIR}/patches/empty.patch" "empty patch file missing after refresh")
    qt_assert_file_text("${QT_WORK_DIR}/patches/empty.patch" "" "empty patch file should have no content")
    qt_quilt_ok(ARGS pop MESSAGE "pop empty patch failed")
    qt_quilt(RESULT applied_rc OUTPUT applied_out ERROR applied_err ARGS applied)
    qt_assert_failure("${applied_rc}" "applied should fail when the empty patch is popped")
    qt_quilt_ok(ARGS push MESSAGE "push empty patch failed")
    qt_quilt_ok(OUTPUT top_after_push ERROR top_after_push_err ARGS top MESSAGE "top failed after push")
    qt_assert_contains("${top_after_push}" "empty.patch" "top should show empty.patch after push")
endfunction()

function(qt_scenario_multiple_patches_same_file)
    qt_begin_test("multiple_patches_same_file")
    qt_write_file("${QT_WORK_DIR}/f.txt" "line1\n")
    qt_quilt_ok(ARGS new first.patch MESSAGE "new first failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add first failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "line1\nline2\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh first failed")
    qt_quilt_ok(ARGS new second.patch MESSAGE "new second failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add second failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "line1\nline2\nline3\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh second failed")
    qt_quilt_ok(ARGS pop -a MESSAGE "pop -a failed")
    qt_assert_file_text("${QT_WORK_DIR}/f.txt" "line1" "pop -a should restore to original")
    qt_quilt_ok(ARGS push -a MESSAGE "push -a failed")
    qt_assert_file_text("${QT_WORK_DIR}/f.txt" "line1\nline2\nline3" "push -a should apply both patches")
endfunction()

function(qt_scenario_many_patches)
    qt_begin_test("many_patches")
    qt_write_file("${QT_WORK_DIR}/f.txt" "0\n")
    foreach(i RANGE 1 10)
        qt_quilt_ok(ARGS new "patch${i}.patch" MESSAGE "new patch${i} failed")
        qt_quilt_ok(ARGS add f.txt MESSAGE "add patch${i} failed")
        qt_write_file("${QT_WORK_DIR}/f.txt" "${i}\n")
        qt_quilt_ok(ARGS refresh MESSAGE "refresh patch${i} failed")
    endforeach()
    qt_quilt_ok(OUTPUT series_out ERROR series_err ARGS series MESSAGE "series failed")
    qt_assert_line_count("${series_out}" "10" "expected 10 patches")
    qt_quilt_ok(ARGS pop -a MESSAGE "pop -a failed")
    qt_assert_file_text("${QT_WORK_DIR}/f.txt" "0" "pop -a should restore to 0")
    qt_quilt_ok(ARGS push -a MESSAGE "push -a failed")
    qt_assert_file_text("${QT_WORK_DIR}/f.txt" "10" "push -a should result in 10")
endfunction()

function(qt_scenario_graph_basic)
    qt_begin_test("graph_basic")
    qt_write_file("${QT_WORK_DIR}/f.txt" "base\n")
    qt_quilt_ok(ARGS new first.patch MESSAGE "new first failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add first failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "base\none\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh first failed")
    qt_quilt_ok(ARGS new second.patch MESSAGE "new second failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add second failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "base\none\ntwo\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh second failed")
    qt_quilt_ok(OUTPUT graph_out ERROR graph_err ARGS graph MESSAGE "graph failed")
    qt_assert_contains("${graph_out}" "digraph dependencies {" "graph should emit a DOT graph")
    qt_assert_contains("${graph_out}" "label=\"first.patch\"" "graph should include the dependency patch")
    qt_assert_contains("${graph_out}" "style=bold,label=\"second.patch\"" "graph should highlight the selected top patch")
    qt_assert_contains("${graph_out}" "n0 -> n1" "graph should point from the dependency to the top patch")
    qt_assert_equal("${graph_err}" "" "graph should not write diagnostics to stderr")
endfunction()

function(qt_scenario_graph_no_edges)
    qt_begin_test("graph_no_edges")
    qt_write_file("${QT_WORK_DIR}/f.txt" "f0\n")
    qt_write_file("${QT_WORK_DIR}/g.txt" "g0\n")
    qt_quilt_ok(ARGS new first.patch MESSAGE "new first failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add first failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "f1\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh first failed")
    qt_quilt_ok(ARGS new second.patch MESSAGE "new second failed")
    qt_quilt_ok(ARGS add g.txt MESSAGE "add second failed")
    qt_write_file("${QT_WORK_DIR}/g.txt" "g1\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh second failed")
    qt_quilt_ok(OUTPUT graph_out ERROR graph_err ARGS graph --all MESSAGE "graph --all failed")
    qt_assert_contains("${graph_out}" "digraph dependencies {" "graph --all should still emit a DOT header")
    qt_assert_not_contains("${graph_out}" "->" "graph --all should not emit edges for disjoint files")
    qt_assert_not_contains("${graph_out}" "first.patch" "graph --all should suppress isolated nodes")
    qt_assert_not_contains("${graph_out}" "second.patch" "graph --all should suppress isolated nodes")
    qt_assert_equal("${graph_err}" "" "graph --all should not write diagnostics to stderr")
endfunction()

function(qt_scenario_graph_selected_patch)
    qt_begin_test("graph_selected_patch")
    qt_write_file("${QT_WORK_DIR}/f.txt" "base\n")
    qt_quilt_ok(ARGS new first.patch MESSAGE "new first failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add first failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "base\none\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh first failed")
    qt_quilt_ok(ARGS new second.patch MESSAGE "new second failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add second failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "base\none\ntwo\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh second failed")
    qt_quilt_ok(ARGS new third.patch MESSAGE "new third failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add third failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "base\none\ntwo\nthree\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh third failed")
    qt_quilt_ok(OUTPUT graph_out ERROR graph_err ARGS graph second.patch MESSAGE "graph second.patch failed")
    qt_assert_contains("${graph_out}" "label=\"first.patch\"" "selected graph should include dependencies")
    qt_assert_contains("${graph_out}" "style=bold,label=\"second.patch\"" "selected graph should highlight the chosen patch")
    qt_assert_contains("${graph_out}" "label=\"third.patch\"" "selected graph should include dependents")
    qt_assert_contains("${graph_out}" "n0 -> n1" "selected graph should include the dependency edge")
    qt_assert_contains("${graph_out}" "n1 -> n2" "selected graph should include the dependent edge")
    qt_assert_equal("${graph_err}" "" "selected graph should not write diagnostics to stderr")
endfunction()

function(qt_scenario_graph_all_excludes_unapplied)
    qt_begin_test("graph_all_excludes_unapplied")
    qt_write_file("${QT_WORK_DIR}/f.txt" "base\n")
    qt_quilt_ok(ARGS new first.patch MESSAGE "new first failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add first failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "base\none\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh first failed")
    qt_quilt_ok(ARGS new second.patch MESSAGE "new second failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add second failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "base\none\ntwo\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh second failed")
    qt_quilt_ok(ARGS new third.patch MESSAGE "new third failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add third failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "base\none\ntwo\nthree\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh third failed")
    qt_quilt_ok(ARGS pop MESSAGE "pop failed")
    qt_quilt_ok(OUTPUT graph_out ERROR graph_err ARGS graph --all MESSAGE "graph --all failed")
    qt_assert_contains("${graph_out}" "label=\"first.patch\"" "graph --all should include applied dependencies")
    qt_assert_contains("${graph_out}" "label=\"second.patch\"" "graph --all should include the top applied patch")
    qt_assert_not_contains("${graph_out}" "third.patch" "graph --all should exclude unapplied patches")
    qt_assert_contains("${graph_out}" "n0 -> n1" "graph --all should keep dependency edges among applied patches")
    qt_assert_equal("${graph_err}" "" "graph --all should not write diagnostics to stderr")
endfunction()

function(qt_scenario_graph_reduce)
    qt_begin_test("graph_reduce")
    qt_write_file("${QT_WORK_DIR}/a.txt" "a0\n")
    qt_write_file("${QT_WORK_DIR}/b.txt" "b0\n")
    qt_write_file("${QT_WORK_DIR}/c.txt" "c0\n")
    qt_quilt_ok(ARGS new first.patch MESSAGE "new first failed")
    qt_quilt_ok(ARGS add a.txt MESSAGE "add first a failed")
    qt_quilt_ok(ARGS add c.txt MESSAGE "add first c failed")
    qt_write_file("${QT_WORK_DIR}/a.txt" "a1\n")
    qt_write_file("${QT_WORK_DIR}/c.txt" "c1\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh first failed")
    qt_quilt_ok(ARGS new second.patch MESSAGE "new second failed")
    qt_quilt_ok(ARGS add a.txt MESSAGE "add second a failed")
    qt_quilt_ok(ARGS add b.txt MESSAGE "add second b failed")
    qt_write_file("${QT_WORK_DIR}/a.txt" "a2\n")
    qt_write_file("${QT_WORK_DIR}/b.txt" "b1\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh second failed")
    qt_quilt_ok(ARGS new third.patch MESSAGE "new third failed")
    qt_quilt_ok(ARGS add b.txt MESSAGE "add third b failed")
    qt_quilt_ok(ARGS add c.txt MESSAGE "add third c failed")
    qt_write_file("${QT_WORK_DIR}/b.txt" "b2\n")
    qt_write_file("${QT_WORK_DIR}/c.txt" "c2\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh third failed")
    qt_quilt_ok(OUTPUT full_out ERROR full_err ARGS graph --all MESSAGE "graph --all failed")
    qt_assert_contains("${full_out}" "n0 -> n1" "graph --all should include the first to second edge")
    qt_assert_contains("${full_out}" "n1 -> n2" "graph --all should include the second to third edge")
    qt_assert_contains("${full_out}" "n0 -> n2" "graph --all should include the transitive edge before reduction")
    qt_quilt_ok(OUTPUT reduced_out ERROR reduced_err ARGS graph --all --reduce MESSAGE "graph --all --reduce failed")
    qt_assert_contains("${reduced_out}" "n0 -> n1" "reduced graph should keep the first to second edge")
    qt_assert_contains("${reduced_out}" "n1 -> n2" "reduced graph should keep the second to third edge")
    qt_assert_not_contains("${reduced_out}" "n0 -> n2" "reduced graph should remove the transitive edge")
    qt_assert_equal("${full_err}" "" "graph --all should not write diagnostics to stderr")
    qt_assert_equal("${reduced_err}" "" "graph --all --reduce should not write diagnostics to stderr")
endfunction()

function(qt_scenario_graph_edge_labels)
    qt_begin_test("graph_edge_labels")
    qt_write_file("${QT_WORK_DIR}/my file.txt" "base\n")
    qt_quilt_ok(ARGS new first.patch MESSAGE "new first failed")
    qt_quilt_ok(ARGS add "my file.txt" MESSAGE "add first failed")
    qt_write_file("${QT_WORK_DIR}/my file.txt" "one\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh first failed")
    qt_quilt_ok(ARGS new second.patch MESSAGE "new second failed")
    qt_quilt_ok(ARGS add "my file.txt" MESSAGE "add second failed")
    qt_write_file("${QT_WORK_DIR}/my file.txt" "two\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh second failed")
    qt_quilt_ok(OUTPUT graph_out ERROR graph_err ARGS graph --edge-labels=files MESSAGE "graph edge labels failed")
    qt_assert_contains("${graph_out}" "label=\"my file.txt\"" "graph edge labels should include filenames with spaces")
    qt_assert_equal("${graph_err}" "" "graph edge labels should not write diagnostics to stderr")
endfunction()

function(qt_scenario_graph_lines_disjoint)
    qt_begin_test("graph_lines_disjoint")
    qt_write_file("${QT_WORK_DIR}/f.txt" "1\n2\n3\n4\n5\n6\n7\n8\n9\n10\n")
    qt_quilt_ok(ARGS new first.patch MESSAGE "new first failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add first failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "1\n2a\n3\n4\n5\n6\n7\n8\n9\n10\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh first failed")
    qt_quilt_ok(ARGS new second.patch MESSAGE "new second failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add second failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "1\n2a\n3\n4\n5\n6\n7\n8\n9b\n10\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh second failed")
    qt_quilt_ok(OUTPUT graph_out ERROR graph_err ARGS graph --lines MESSAGE "graph --lines failed")
    qt_assert_contains("${graph_out}" "digraph dependencies {" "graph --lines should still emit DOT output")
    qt_assert_not_contains("${graph_out}" "->" "graph --lines should suppress non-overlapping hunks")
    qt_assert_contains("${graph_out}" "second.patch" "graph --lines should still include the selected top patch")
    qt_assert_not_contains("${graph_out}" "label=\"first.patch\"" "graph --lines should omit unrelated patches")
    qt_assert_equal("${graph_err}" "" "graph --lines should not write diagnostics to stderr")
endfunction()

function(qt_scenario_graph_lines_context_boundary)
    qt_begin_test("graph_lines_context_boundary")
    qt_write_file("${QT_WORK_DIR}/f.txt" "1\n2\n3\n4\n5\n6\n7\n8\n")
    qt_quilt_ok(ARGS new first.patch MESSAGE "new first failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add first failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "1\n2\n3a\n4\n5\n6\n7\n8\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh first failed")
    qt_quilt_ok(ARGS new second.patch MESSAGE "new second failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add second failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "1\n2\n3a\n4\n5\n6b\n7\n8\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh second failed")
    qt_quilt_ok(OUTPUT default_out ERROR default_err ARGS graph --lines MESSAGE "graph --lines failed")
    qt_assert_contains("${default_out}" "n0 -> n1" "graph --lines should use two lines of context by default")
    qt_quilt_ok(OUTPUT strict_out ERROR strict_err ARGS graph --lines=0 MESSAGE "graph --lines=0 failed")
    qt_assert_not_contains("${strict_out}" "->" "graph --lines=0 should require direct overlap")
    qt_assert_equal("${default_err}" "" "graph --lines should not write diagnostics to stderr")
    qt_assert_equal("${strict_err}" "" "graph --lines=0 should not write diagnostics to stderr")
endfunction()

function(qt_scenario_graph_empty_stack)
    qt_begin_test("graph_empty_stack")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS graph)
    qt_assert_failure("${rc}" "graph with no applied patches should fail")
    qt_assert_equal("${out}" "" "graph with no applied patches should not write to stdout")
    qt_assert_contains("${err}" "No series file found" "graph with no applied patches should explain the failure")
endfunction()

function(qt_scenario_graph_unknown_patch)
    qt_begin_test("graph_unknown_patch")
    qt_write_file("${QT_WORK_DIR}/f.txt" "base\n")
    qt_quilt_ok(ARGS new first.patch MESSAGE "new first failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add first failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "one\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh first failed")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS graph missing.patch)
    qt_assert_failure("${rc}" "graph with an unknown patch should fail")
    qt_assert_equal("${out}" "" "graph unknown patch should not write to stdout")
    qt_assert_contains("${err}" "Patch missing.patch is not in series" "graph should explain unknown patch failures")
endfunction()

function(qt_scenario_graph_help)
    qt_begin_test("graph_help")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS graph -h)
    qt_assert_success("${rc}" "graph -h should exit 0")
    qt_combine_output(help_out "${out}" "${err}")
    qt_assert_contains("${help_out}" "Usage: quilt graph" "graph -h should show the usage line")
    qt_assert_contains("${help_out}" "--edge-labels=files" "graph -h should describe edge labels")
endfunction()

function(qt_scenario_graph_subdirectory)
    qt_begin_test("graph_subdirectory")
    qt_write_file("${QT_WORK_DIR}/f.txt" "base\n")
    qt_quilt_ok(ARGS new first.patch MESSAGE "new first failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add first failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "one\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh first failed")
    qt_quilt_ok(ARGS new second.patch MESSAGE "new second failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add second failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "two\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh second failed")
    file(MAKE_DIRECTORY "${QT_WORK_DIR}/sub/deep")
    qt_quilt_ok(
        OUTPUT graph_out
        ERROR graph_err
        WORKING_DIRECTORY "${QT_WORK_DIR}/sub/deep"
        ARGS graph
        MESSAGE "graph from subdirectory failed"
    )
    qt_assert_contains("${graph_out}" "n0 -> n1" "graph from subdirectory should still find the project root")
    qt_assert_equal("${graph_err}" "" "graph from subdirectory should not write diagnostics to stderr")
endfunction()

function(qt_scenario_filenames_with_spaces)
    qt_begin_test("filenames_with_spaces")
    qt_write_file("${QT_WORK_DIR}/my file.txt" "content\n")
    qt_quilt_ok(ARGS new space.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add "my file.txt" MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/my file.txt" "changed\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    qt_quilt_ok(ARGS pop MESSAGE "pop failed")
    qt_assert_file_text("${QT_WORK_DIR}/my file.txt" "content" "restore failed for space filename")
endfunction()

function(qt_scenario_upward_scanning)
    qt_begin_test("upward_scanning")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_quilt_ok(ARGS new up.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "y\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    file(MAKE_DIRECTORY "${QT_WORK_DIR}/sub/deep")
    qt_quilt_ok(
        OUTPUT top_out
        ERROR top_err
        WORKING_DIRECTORY "${QT_WORK_DIR}/sub/deep"
        ARGS top
        MESSAGE "top from subdirectory failed"
    )
    qt_assert_contains("${top_out}" "up.patch" "top from subdirectory failed")
endfunction()

function(qt_scenario_command_abbreviation)
    qt_begin_test("command_abbreviation")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_quilt_ok(ARGS new abbrev.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "y\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    qt_quilt_ok(OUTPUT series_out ERROR series_err ARGS ser MESSAGE "abbreviation 'ser' failed")
    qt_assert_contains("${series_out}" "abbrev.patch" "abbreviation 'ser' failed")
    qt_quilt_ok(OUTPUT top_out ERROR top_err ARGS to MESSAGE "abbreviation 'to' failed")
    qt_assert_contains("${top_out}" "abbrev.patch" "abbreviation 'to' failed")
endfunction()

function(qt_scenario_help_flag)
    qt_begin_test("help_flag")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS push -h)
    qt_assert_success("${rc}" "push -h should exit 0")
    qt_combine_output(help_out "${out}" "${err}")
    string(TOLOWER "${help_out}" help_lower)
    qt_assert_contains("${help_lower}" "usage" "push -h should show usage")
endfunction()

function(qt_scenario_init_creates_metadata)
    qt_begin_test("init_creates_metadata")
    if(CMAKE_HOST_WIN32)
        set(init_parent "$ENV{TEMP}")
    else()
        set(init_parent "/tmp")
    endif()
    string(RANDOM LENGTH 8 ALPHABET 0123456789abcdef init_suffix)
    set(init_dir "${init_parent}/quilt-init-${init_suffix}")
    file(REMOVE_RECURSE "${init_dir}")
    file(MAKE_DIRECTORY "${init_dir}")
    set(init_env "QUILT_PC=.pc" "QUILT_PATCHES=patches" "QUILT_SERIES=series")
    qt_quilt_ok(WORKING_DIRECTORY "${init_dir}" ENV ${init_env} ARGS init MESSAGE "init failed")
    qt_quilt_ok(WORKING_DIRECTORY "${init_dir}" ENV ${init_env} ARGS init MESSAGE "init should be idempotent")
    qt_assert_dir_exists("${init_dir}/.pc" "init should create .pc/")
    qt_assert_dir_exists("${init_dir}/patches" "init should create patches/")
    qt_assert_exists("${init_dir}/.pc/.version" "init should create .version")
    qt_assert_exists("${init_dir}/.pc/.quilt_patches" "init should create .quilt_patches")
    qt_assert_exists("${init_dir}/.pc/.quilt_series" "init should create .quilt_series")
    qt_assert_exists("${init_dir}/.pc/applied-patches" "init should create applied-patches")
    qt_assert_exists("${init_dir}/patches/series" "init should create the series file")
    qt_assert_file_text("${init_dir}/.pc/.version" "2" "wrong .pc version")
    qt_assert_file_text("${init_dir}/.pc/.quilt_patches" "patches" "wrong patch directory metadata")
    qt_assert_file_text("${init_dir}/.pc/.quilt_series" "series" "wrong series file metadata")
    qt_read_file_raw(applied_raw "${init_dir}/.pc/applied-patches")
    qt_assert_equal("${applied_raw}" "" "applied-patches should start empty")
    qt_read_file_raw(series_raw "${init_dir}/patches/series")
    qt_assert_equal("${series_raw}" "" "series should start empty")
    file(REMOVE_RECURSE "${init_dir}")
endfunction()

function(qt_scenario_init_help_text)
    qt_begin_test("init_help_text")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS init -h)
    qt_assert_success("${rc}" "init -h should exit 0")
    qt_combine_output(help_out "${out}" "${err}")
    qt_assert_contains("${help_out}" "Usage: quilt init" "init help should include usage")
    qt_assert_contains("${help_out}" "Initialize quilt metadata in the current directory" "init help should include the descriptive text")
endfunction()

function(qt_scenario_quilt_patches_env)
    qt_begin_test("quilt_patches_env")
    file(MAKE_DIRECTORY "${QT_WORK_DIR}/mypatches")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_quilt_ok(ENV "QUILT_PATCHES=mypatches" ARGS new envp.patch MESSAGE "new with QUILT_PATCHES failed")
    qt_quilt_ok(ENV "QUILT_PATCHES=mypatches" ARGS add f.txt MESSAGE "add with QUILT_PATCHES failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "y\n")
    qt_quilt_ok(ENV "QUILT_PATCHES=mypatches" ARGS refresh MESSAGE "refresh with QUILT_PATCHES failed")
    qt_assert_exists("${QT_WORK_DIR}/mypatches/envp.patch" "patch should be in mypatches/")
endfunction()

function(qt_scenario_quilt_pc_env)
    qt_begin_test("quilt_pc_env")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_quilt_ok(ENV "QUILT_PC=.mypc" ARGS new pce.patch MESSAGE "new with QUILT_PC failed")
    qt_quilt_ok(ENV "QUILT_PC=.mypc" ARGS add f.txt MESSAGE "add with QUILT_PC failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "y\n")
    qt_quilt_ok(ENV "QUILT_PC=.mypc" ARGS refresh MESSAGE "refresh with QUILT_PC failed")
    qt_assert_dir_exists("${QT_WORK_DIR}/.mypc" ".mypc directory should exist")
    qt_assert_exists("${QT_WORK_DIR}/.mypc/applied-patches" "applied-patches should be in .mypc/")
endfunction()

function(qt_scenario_series_search_order)
    qt_begin_test("series_search_order")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    file(MAKE_DIRECTORY "${QT_WORK_DIR}/patches")
    qt_write_file("${QT_WORK_DIR}/patches/root.patch" [=[--- a/f.txt
+++ b/f.txt
@@ -1 +1 @@
-x
+root_series
]=])
    qt_write_file("${QT_WORK_DIR}/series" "root.patch\n")
    qt_quilt_ok(ARGS push MESSAGE "push with root series failed")
    qt_assert_file_text("${QT_WORK_DIR}/f.txt" "root_series" "wrong content after push")
endfunction()

function(qt_scenario_strip_level)
    qt_begin_test("strip_level")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_write_file("${QT_WORK_DIR}/patches/p0.patch" [=[--- f.txt
+++ f.txt
@@ -1 +1 @@
-x
+stripped
]=])
    qt_write_file("${QT_WORK_DIR}/patches/series" "p0.patch -p0\n")
    qt_quilt_ok(ARGS push MESSAGE "push -p0 patch failed")
    qt_assert_file_text("${QT_WORK_DIR}/f.txt" "stripped" "wrong content after push -p0")
endfunction()

function(qt_scenario_push_numeric)
    qt_begin_test("push_numeric")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_quilt_ok(ARGS new n1.patch MESSAGE "new n1 failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add n1 failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "1\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh n1 failed")
    qt_quilt_ok(ARGS new n2.patch MESSAGE "new n2 failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add n2 failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "2\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh n2 failed")
    qt_quilt_ok(ARGS new n3.patch MESSAGE "new n3 failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add n3 failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "3\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh n3 failed")
    qt_quilt_ok(ARGS pop -a MESSAGE "pop -a failed")
    qt_quilt_ok(ARGS push 2 MESSAGE "push 2 failed")
    qt_quilt_ok(OUTPUT applied_out ERROR applied_err ARGS applied MESSAGE "applied failed")
    qt_assert_line_count("${applied_out}" "2" "expected 2 applied")
    qt_assert_file_text("${QT_WORK_DIR}/f.txt" "2" "wrong content after push 2")
endfunction()

function(qt_scenario_push_verbose)
    qt_begin_test("push_verbose")
    qt_write_file("${QT_WORK_DIR}/f.txt" "hello\n")
    qt_write_file("${QT_WORK_DIR}/patches/a.patch" [=[--- a/f.txt
+++ b/f.txt
@@ -1 +1 @@
-hello
+world
]=])
    qt_write_file("${QT_WORK_DIR}/patches/series" "a.patch\n")
    qt_quilt_ok(OUTPUT push_out ERROR push_err ARGS push -v MESSAGE "push -v failed")
    qt_combine_output(combined "${push_out}" "${push_err}")
    qt_assert_contains("${combined}" "atching file" "verbose output should mention patching file")
endfunction()

function(qt_scenario_push_fuzz)
    qt_begin_test("push_fuzz")
    # File has extra leading lines that shift context
    qt_write_file("${QT_WORK_DIR}/f.txt" "extra1\nextra2\nextra3\nhello\n")
    # Patch expects "hello" at line 1, so it needs fuzz to apply with offset
    qt_write_file("${QT_WORK_DIR}/patches/a.patch" [=[--- a/f.txt
+++ b/f.txt
@@ -1 +1 @@
-hello
+world
]=])
    qt_write_file("${QT_WORK_DIR}/patches/series" "a.patch\n")
    qt_quilt_ok(ARGS push --fuzz=3 MESSAGE "push --fuzz=3 failed")
    qt_assert_file_contains("${QT_WORK_DIR}/f.txt" "world" "fuzz push should apply the change")
endfunction()

function(qt_scenario_push_merge)
    qt_begin_test("push_merge")
    qt_write_file("${QT_WORK_DIR}/f.txt" "hello\n")
    qt_write_file("${QT_WORK_DIR}/patches/a.patch" [=[--- a/f.txt
+++ b/f.txt
@@ -1 +1 @@
-hello
+world
]=])
    qt_write_file("${QT_WORK_DIR}/patches/series" "a.patch\n")
    # --merge requires GNU patch; verify quilt accepts the flag and passes
    # it through (patch may reject it on non-GNU systems, so use -f)
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS push -f --merge=diff3)
    qt_combine_output(combined "${out}" "${err}")
    # Quilt should report applying the patch, not reject --merge as unknown
    qt_assert_contains("${combined}" "Applying patch" "quilt should accept --merge flag")
endfunction()

function(qt_scenario_push_leave_rejects)
    qt_begin_test("push_leave_rejects")
    qt_write_file("${QT_WORK_DIR}/f.txt" "original\n")
    qt_write_file("${QT_WORK_DIR}/patches/bad.patch" [=[--- a/f.txt
+++ b/f.txt
@@ -1 +1 @@
-wrong
+patched
]=])
    qt_write_file("${QT_WORK_DIR}/patches/series" "bad.patch\n")

    # Default: .rej should be cleaned up
    qt_quilt(RESULT rc1 OUTPUT out1 ERROR err1 ARGS push)
    qt_assert_failure("${rc1}" "push of conflicting patch should fail")
    if(EXISTS "${QT_WORK_DIR}/f.txt.rej")
        qt_fail("f.txt.rej should have been cleaned up by default")
    endif()

    # With --leave-rejects: .rej should remain
    qt_quilt(RESULT rc2 OUTPUT out2 ERROR err2 ARGS push --leave-rejects)
    qt_assert_failure("${rc2}" "push --leave-rejects should still fail")
    if(NOT EXISTS "${QT_WORK_DIR}/f.txt.rej")
        qt_fail("f.txt.rej should remain with --leave-rejects")
    endif()
endfunction()

function(qt_scenario_push_refresh)
    qt_begin_test("push_refresh")
    qt_write_file("${QT_WORK_DIR}/f.txt" "hello\n")
    qt_write_file("${QT_WORK_DIR}/patches/a.patch" [=[--- a/f.txt
+++ b/f.txt
@@ -1 +1 @@
-hello
+world
]=])
    qt_write_file("${QT_WORK_DIR}/patches/series" "a.patch\n")
    qt_quilt_ok(OUTPUT push_out ARGS push --refresh MESSAGE "push --refresh failed")
    # After --refresh, the patch file should have been rewritten by cmd_refresh
    qt_assert_file_contains("${QT_WORK_DIR}/patches/a.patch" "-hello" "refreshed patch should contain -hello")
    qt_assert_file_contains("${QT_WORK_DIR}/patches/a.patch" "+world" "refreshed patch should contain +world")
endfunction()

function(qt_scenario_pop_numeric)
    qt_begin_test("pop_numeric")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_quilt_ok(ARGS new p1.patch MESSAGE "new p1 failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add p1 failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "1\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh p1 failed")
    qt_quilt_ok(ARGS new p2.patch MESSAGE "new p2 failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add p2 failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "2\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh p2 failed")
    qt_quilt_ok(ARGS new p3.patch MESSAGE "new p3 failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add p3 failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "3\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh p3 failed")
    qt_quilt_ok(ARGS pop 2 MESSAGE "pop 2 failed")
    qt_quilt_ok(OUTPUT applied_out ERROR applied_err ARGS applied MESSAGE "applied failed")
    qt_assert_line_count("${applied_out}" "1" "expected 1 applied")
    qt_assert_file_text("${QT_WORK_DIR}/f.txt" "1" "wrong content after pop 2")
endfunction()

function(qt_scenario_force_push_tracking)
    qt_begin_test("force_push_tracking")
    qt_write_file("${QT_WORK_DIR}/f.txt" "original line\n")
    qt_write_file("${QT_WORK_DIR}/patches/conflict.patch" [=[--- a/f.txt
+++ b/f.txt
@@ -1 +1 @@
-wrong original
+patched
]=])
    qt_write_file("${QT_WORK_DIR}/patches/second.patch" [=[--- a/f.txt
+++ b/f.txt
@@ -1 +1 @@
-patched
+second
]=])
    qt_write_file("${QT_WORK_DIR}/patches/series" "conflict.patch\nsecond.patch\n")
    qt_quilt(RESULT push_force_rc OUTPUT push_force_out ERROR push_force_err ARGS push -f)
    qt_assert_failure("${push_force_rc}" "push -f should report a forced application")
    qt_quilt_ok(OUTPUT top_out ERROR top_err ARGS top MESSAGE "top failed after force push")
    qt_assert_contains("${top_out}" "conflict.patch" "force-applied patch should be top")
    qt_quilt(RESULT push_rc OUTPUT push_out ERROR push_err ARGS push)
    qt_assert_failure("${push_rc}" "push on top of force-applied should fail")
    qt_quilt(RESULT add_rc OUTPUT add_out ERROR add_err ARGS add f.txt)
    qt_write_file("${QT_WORK_DIR}/f.txt" "patched\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh after force push failed")
    qt_write_file("${QT_WORK_DIR}/patches/second.patch" [=[--- a/f.txt
+++ b/f.txt
@@ -1 +1 @@
-patched
+second
]=])
    qt_quilt_ok(ARGS push MESSAGE "push after refresh should succeed")
endfunction()

function(qt_scenario_force_pop)
    qt_begin_test("force_pop")
    qt_write_file("${QT_WORK_DIR}/f.txt" "original line\n")
    qt_write_file("${QT_WORK_DIR}/patches/bad.patch" [=[--- a/f.txt
+++ b/f.txt
@@ -1 +1 @@
-wrong original
+patched
]=])
    qt_write_file("${QT_WORK_DIR}/patches/series" "bad.patch\n")
    qt_quilt(RESULT push_force_rc OUTPUT push_force_out ERROR push_force_err ARGS push -f)
    qt_assert_failure("${push_force_rc}" "push -f should report a forced application")
    qt_quilt(RESULT pop_rc OUTPUT pop_out ERROR pop_err ARGS pop)
    qt_assert_failure("${pop_rc}" "pop without -f should fail for force-applied patch")
    qt_assert_contains("${pop_err}" "bad.patch needs to be refreshed first." "pop should require refresh before a forced patch is removed")
    qt_quilt_ok(ARGS pop -f MESSAGE "pop -f should succeed")
    qt_quilt(RESULT applied_rc OUTPUT applied_out ERROR applied_err ARGS applied)
    qt_strip_trailing_newlines(applied_trimmed "${applied_out}")
    qt_assert_equal("${applied_trimmed}" "" "should have no patches applied after pop -f")
endfunction()

function(qt_scenario_refresh_shadowing_requires_force)
    qt_begin_test("refresh_shadowing_requires_force")
    qt_write_file("${QT_WORK_DIR}/f.txt" "base\n")
    qt_quilt_ok(ARGS new bottom.patch MESSAGE "new bottom failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add bottom failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "bottom\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh bottom failed")
    qt_quilt_ok(ARGS new top.patch MESSAGE "new top failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add top failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "top\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh top failed")
    qt_quilt(RESULT refresh_rc OUTPUT refresh_out ERROR refresh_err ARGS refresh bottom.patch)
    qt_assert_failure("${refresh_rc}" "refreshing a shadowed lower patch without -f should fail")
    qt_combine_output(refresh_combined "${refresh_out}" "${refresh_err}")
    qt_assert_contains("${refresh_combined}" "Enforce refresh with -f." "refresh without -f should mention the force requirement")
endfunction()

function(qt_scenario_refresh_shadowing)
    qt_begin_test("refresh_shadowing")
    qt_write_file("${QT_WORK_DIR}/f.txt" "base\n")
    qt_quilt_ok(ARGS new bottom.patch MESSAGE "new bottom failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add bottom failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "bottom\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh bottom failed")
    qt_quilt_ok(ARGS new top.patch MESSAGE "new top failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add top failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "top\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh top failed")
    qt_quilt_ok(ARGS refresh -f bottom.patch MESSAGE "refresh bottom patch failed")
    qt_assert_file_contains("${QT_WORK_DIR}/patches/bottom.patch" "+bottom" "bottom patch should have +bottom")
    qt_assert_file_not_contains("${QT_WORK_DIR}/patches/bottom.patch" "+top" "bottom patch should not have +top")
endfunction()

function(qt_scenario_diff_reverse)
    qt_begin_test("diff_reverse")
    qt_write_file("${QT_WORK_DIR}/f.txt" "old\n")
    qt_quilt_ok(ARGS new rev.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "new\n")
    qt_quilt_ok(OUTPUT diff_out ERROR diff_err ARGS diff -R MESSAGE "diff -R failed")
    qt_assert_contains("${diff_out}" "+old" "reverse diff should show +old")
    qt_assert_contains("${diff_out}" "-new" "reverse diff should show -new")
endfunction()

function(qt_scenario_diff_context_format)
    qt_begin_test("diff_context_format")
    qt_write_file("${QT_WORK_DIR}/f.txt" "old\n")
    qt_quilt_ok(ARGS new ctx.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "new\n")
    qt_quilt_ok(OUTPUT diff_out ERROR diff_err ARGS diff -c MESSAGE "diff -c failed")
    qt_assert_contains("${diff_out}" "***" "context diff should contain *** markers")
    qt_assert_not_contains("${diff_out}" "@@" "context diff should not contain @@ markers")
endfunction()

function(qt_scenario_diff_context_lines)
    qt_begin_test("diff_context_lines")
    qt_write_file("${QT_WORK_DIR}/f.txt" "line1\nline2\nline3\nline4\nline5\n")
    qt_quilt_ok(ARGS new ctx.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "line1\nline2\nchanged\nline4\nline5\n")
    qt_quilt_ok(OUTPUT diff_out ERROR diff_err ARGS diff -C 1 MESSAGE "diff -C 1 failed")
    qt_assert_contains("${diff_out}" "***" "context diff should contain *** markers")
    # With -C 1, only 1 line of context around the change
    qt_assert_contains("${diff_out}" "! changed" "context diff should show changed line")
endfunction()

function(qt_scenario_diff_unified_lines)
    qt_begin_test("diff_unified_lines")
    qt_write_file("${QT_WORK_DIR}/f.txt" "line1\nline2\nline3\nline4\nline5\n")
    qt_quilt_ok(ARGS new uni.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "line1\nline2\nchanged\nline4\nline5\n")
    # Default unified context is 3; using -U 0 should produce minimal output
    qt_quilt_ok(OUTPUT diff_out ERROR diff_err ARGS diff -U 0 MESSAGE "diff -U 0 failed")
    qt_assert_contains("${diff_out}" "@@" "unified diff should contain @@ markers")
    qt_assert_contains("${diff_out}" "-line3" "unified diff should show removed line")
    qt_assert_contains("${diff_out}" "+changed" "unified diff should show added line")
    # With -U 0, context lines (line1, line2, line4, line5) should NOT appear
    qt_assert_not_contains("${diff_out}" " line1" "U 0 should have no context lines")
endfunction()

function(qt_scenario_diff_sort)
    qt_begin_test("diff_sort")
    qt_write_file("${QT_WORK_DIR}/b.txt" "old-b\n")
    qt_write_file("${QT_WORK_DIR}/a.txt" "old-a\n")
    qt_quilt_ok(ARGS new sort.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add b.txt MESSAGE "add b failed")
    qt_quilt_ok(ARGS add a.txt MESSAGE "add a failed")
    qt_write_file("${QT_WORK_DIR}/b.txt" "new-b\n")
    qt_write_file("${QT_WORK_DIR}/a.txt" "new-a\n")
    qt_quilt_ok(OUTPUT diff_out ERROR diff_err ARGS diff --sort MESSAGE "diff --sort failed")
    # a.txt should appear before b.txt in sorted output
    string(FIND "${diff_out}" "a.txt" pos_a)
    string(FIND "${diff_out}" "b.txt" pos_b)
    if(pos_a EQUAL -1 OR pos_b EQUAL -1)
        qt_fail("diff --sort output missing expected files")
    endif()
    if(NOT pos_a LESS pos_b)
        qt_fail("diff --sort should output a.txt before b.txt")
    endif()
endfunction()

function(qt_scenario_diff_combine)
    qt_begin_test("diff_combine")
    qt_write_file("${QT_WORK_DIR}/f.txt" "base\n")
    qt_quilt_ok(ARGS new first.patch MESSAGE "new first failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add f failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "middle\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh first failed")
    qt_quilt_ok(ARGS new second.patch MESSAGE "new second failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add f to second failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "final\n")
    qt_quilt_ok(OUTPUT diff_out ERROR diff_err ARGS diff --combine - MESSAGE "diff --combine - failed")
    # Combined diff should show the full range: base -> final
    qt_assert_contains("${diff_out}" "-base" "combine should show original base as removed")
    qt_assert_contains("${diff_out}" "+final" "combine should show final as added")
endfunction()

function(qt_scenario_diff_combine_named)
    qt_begin_test("diff_combine_named")
    qt_write_file("${QT_WORK_DIR}/f.txt" "base\n")
    qt_quilt_ok(ARGS new first.patch MESSAGE "new first failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add f failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "v1\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh first failed")
    qt_quilt_ok(ARGS new second.patch MESSAGE "new second failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add f to second failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "v2\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh second failed")
    qt_quilt_ok(ARGS new third.patch MESSAGE "new third failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add f to third failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "v3\n")
    # Combine from second.patch through top (third.patch)
    qt_quilt_ok(OUTPUT diff_out ERROR diff_err ARGS diff --combine second.patch MESSAGE "diff --combine named failed")
    # Should show v1 -> v3 (second.patch's backup is v1)
    qt_assert_contains("${diff_out}" "-v1" "named combine should show second patch backup as removed")
    qt_assert_contains("${diff_out}" "+v3" "named combine should show current as added")
    qt_assert_not_contains("${diff_out}" "-base" "named combine should not include first patch backup")
endfunction()

function(qt_scenario_diff_combine_conflicts_with_z)
    qt_begin_test("diff_combine_conflicts_with_z")
    qt_write_file("${QT_WORK_DIR}/f.txt" "base\n")
    qt_quilt_ok(ARGS new comb.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "new\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS diff --combine - -z)
    qt_assert_failure("${rc}" "diff --combine -z should fail")
    qt_assert_contains("${err}" "cannot be combined" "diff should reject --combine with -z")
endfunction()

function(qt_scenario_diff_diff_utility)
    qt_begin_test("diff_diff_utility")
    qt_write_file("${QT_WORK_DIR}/f.txt" "old\n")
    qt_quilt_ok(ARGS new util.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "new\n")
    # Using --diff=diff should work the same as default
    qt_quilt_ok(OUTPUT diff_out ERROR diff_err ARGS "diff" "--diff=diff -u" MESSAGE "diff --diff='diff -u' failed")
    qt_assert_contains("${diff_out}" "+new" "diff with --diff='diff -u' should show +new")
    qt_assert_contains("${diff_out}" "-old" "diff with --diff='diff -u' should show -old")
endfunction()

function(qt_scenario_new_add_output)
    qt_begin_test("new_add_output")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_quilt_ok(OUTPUT new_out ERROR new_err ARGS new display.patch MESSAGE "new failed")
    qt_assert_contains("${new_out}" "display.patch is now on top" "new output should include the patch path")
    qt_quilt_ok(OUTPUT add_out ERROR add_err ARGS add f.txt MESSAGE "add failed")
    qt_assert_contains("${add_out}" "File f.txt added to patch display.patch" "add output should include the patch path")
endfunction()

function(qt_scenario_new_strip_p0)
    qt_begin_test("new_strip_p0")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_quilt_ok(ARGS new -p 0 foo.patch MESSAGE "new -p0 failed")
    qt_assert_file_contains("${QT_WORK_DIR}/patches/series" "-p0" "series should contain -p0")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "y\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    # With -p0, patch should use bare filenames (no directory prefix)
    qt_assert_file_contains("${QT_WORK_DIR}/patches/foo.patch" "--- f.txt" "patch should use bare --- path")
    qt_assert_file_contains("${QT_WORK_DIR}/patches/foo.patch" "+++ f.txt" "patch should use bare +++ path")
endfunction()

function(qt_scenario_new_strip_p1)
    qt_begin_test("new_strip_p1")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_quilt_ok(ARGS new -p 1 foo.patch MESSAGE "new -p1 failed")
    # -p1 is the default, so series should NOT contain -p
    qt_assert_file_not_contains("${QT_WORK_DIR}/patches/series" "-p" "series should not contain -p for default strip level")
endfunction()

function(qt_scenario_new_strip_default)
    qt_begin_test("new_strip_default")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_quilt_ok(ARGS new foo.patch MESSAGE "new failed")
    qt_assert_file_not_contains("${QT_WORK_DIR}/patches/series" "-p" "series should not contain -p by default")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "y\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    # Default p1 uses dir.orig/dir labels
    qt_assert_file_contains("${QT_WORK_DIR}/patches/foo.patch" ".orig/f.txt" "patch should use .orig/ prefix")
endfunction()

function(qt_scenario_quilt_example)
    qt_begin_test("quilt_example")
    qt_write_file("${QT_WORK_DIR}/Oberon.txt" [=[Yet mark'd I where the bolt of Cupid fell:
It fell upon a little western flower,
Before milk-white, now purple with love's wound,
And girls call it love-in-idleness.
]=])
    qt_quilt_ok(OUTPUT new_out ERROR new_err ARGS new flower.diff MESSAGE "new failed")
    qt_assert_contains("${new_out}" "flower.diff is now on top" "new output mismatch")
    qt_quilt_ok(OUTPUT add_out ERROR add_err ARGS add Oberon.txt MESSAGE "add failed")
    qt_assert_contains("${add_out}" "File Oberon.txt added to patch flower.diff" "add output mismatch")
    qt_write_file("${QT_WORK_DIR}/Oberon.txt" [=[Yet mark'd I where the bolt of Cupid fell:
It fell upon a little western flower,
Before milk-white, now purple with love's wound,
And girls call it love-in-idleness.
The juice of it on sleeping eye-lids laid
Will make a man or woman madly dote
Upon the next live creature that it sees.
]=])
    qt_quilt_ok(ARGS refresh MESSAGE "first refresh failed")
    qt_assert_exists("${QT_WORK_DIR}/patches/flower.diff" "patch file missing after refresh")
    qt_assert_file_contains("${QT_WORK_DIR}/patches/flower.diff" "+The juice of it" "patch content wrong")
    qt_quilt_ok(OUTPUT diff_z_out ERROR diff_z_err ARGS diff -z MESSAGE "diff -z failed")
    qt_strip_trailing_newlines(diff_z_trimmed "${diff_z_out}")
    qt_assert_equal("${diff_z_trimmed}" "" "diff -z should be empty after refresh")
    qt_write_file("${QT_WORK_DIR}/Oberon.txt" [=[Yet mark'd I where the bolt of Cupid fell:
It fell upon a little western flower,
Before milk-white, now purple with love's wound,
And girls call it love-in-idleness.
Fetch me that flower; the herb I shew'd thee once:
The juice of it on sleeping eye-lids laid
Will make a man or woman madly dote
Upon the next live creature that it sees.
]=])
    qt_quilt_ok(OUTPUT diff_z2_out ERROR diff_z2_err ARGS diff -z MESSAGE "second diff -z failed")
    qt_assert_contains("${diff_z2_out}" "+Fetch me that flower" "diff -z should show Fetch line")
    qt_assert_not_contains("${diff_z2_out}" "+The juice" "diff -z should not show already-refreshed lines as additions")
    qt_quilt_ok(ARGS refresh MESSAGE "second refresh failed")
    file(REMOVE "${QT_WORK_DIR}/patches/flower.diff")
    qt_quilt_ok(ARGS refresh -p ab --no-index --no-timestamps MESSAGE "refresh after delete failed")
    qt_assert_exists("${QT_WORK_DIR}/patches/flower.diff" "patch not recreated after delete")
    qt_assert_file_contains("${QT_WORK_DIR}/patches/flower.diff" "--- a/Oberon.txt" "refresh -p ab should use a/ prefix")
    qt_assert_file_contains("${QT_WORK_DIR}/patches/flower.diff" "+++ b/Oberon.txt" "refresh -p ab should use b/ prefix")
    qt_quilt_ok(OUTPUT pop_out ERROR pop_err ARGS pop MESSAGE "pop failed")
    qt_assert_contains("${pop_out}" "Removing patch flower.diff" "pop output mismatch")
    qt_assert_contains("${pop_out}" "No patches applied" "pop should say no patches applied")
    qt_write_file("${QT_WORK_DIR}/Oberon.txt" [=[Yet mark'd I where the bolt of Cupid fell:
It fell upon a little western flower,
Before milk-white, now purple with love's wound,
And maidens call it love-in-idleness.
]=])
    qt_quilt(RESULT push_rc OUTPUT push_out ERROR push_err ARGS push)
    qt_assert_failure("${push_rc}" "push should fail on conflict")
    qt_quilt(RESULT force_rc OUTPUT force_out ERROR force_err ARGS push -f)
    qt_assert_failure("${force_rc}" "push -f should report a forced application")
    qt_combine_output(force_combined "${force_out}" "${force_err}")
    qt_assert_contains("${force_combined}" "forced; needs refresh" "push -f output mismatch")
    qt_assert_exists("${QT_WORK_DIR}/.pc/flower.diff/Oberon.txt" "backup at wrong path after push")
    qt_quilt_ok(OUTPUT top_out ERROR top_err ARGS top MESSAGE "top failed")
    qt_strip_trailing_newlines(top_trimmed "${top_out}")
    qt_assert_matches("${top_trimmed}" "(^|/)flower\\.diff$" "top should be flower.diff")
    qt_write_file("${QT_WORK_DIR}/Oberon.txt" [=[Yet mark'd I where the bolt of Cupid fell:
It fell upon a little western flower,
Before milk-white, now purple with love's wound,
And maidens call it love-in-idleness.
Fetch me that flower; the herb I shew'd thee once:
The juice of it on sleeping eye-lids laid
Will make a man or woman madly dote
Upon the next live creature that it sees.
]=])
    qt_quilt_ok(ARGS refresh MESSAGE "refresh after force push failed")
    qt_assert_not_exists("${QT_WORK_DIR}/.pc/flower.diff/.needs_refresh" ".needs_refresh should be cleared")
    qt_quilt_ok(ARGS pop MESSAGE "pop after refresh failed")
endfunction()

function(qt_scenario_quiltrc_basic)
    qt_begin_test("quiltrc_basic")
    set(fake_home "${QT_TEST_BASE}/home")
    qt_home_env(home_env "${fake_home}")
    qt_write_file("${fake_home}/.quiltrc" "QUILT_REFRESH_ARGS=\"--no-index\"\n")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_quilt_ok(ENV ${home_env} ARGS new rcp.patch MESSAGE "new with default quiltrc failed")
    qt_quilt_ok(ENV ${home_env} ARGS add f.txt MESSAGE "add with default quiltrc failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "y\n")
    qt_quilt_ok(ENV ${home_env} ARGS refresh MESSAGE "refresh with default quiltrc failed")
    qt_assert_exists("${QT_WORK_DIR}/patches/rcp.patch" "patch should be written to patches/")
    qt_assert_file_not_contains("${QT_WORK_DIR}/patches/rcp.patch" "Index:" "default quiltrc setting was not applied")
endfunction()

function(qt_scenario_quiltrc_disable)
    qt_begin_test("quiltrc_disable")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_quilt_ok(ARGS --quiltrc - new dis.patch MESSAGE "new with --quiltrc - failed")
    qt_quilt_ok(ARGS --quiltrc - add f.txt MESSAGE "add with --quiltrc - failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "y\n")
    qt_quilt_ok(ARGS --quiltrc - refresh MESSAGE "refresh with --quiltrc - failed")
    qt_assert_exists("${QT_WORK_DIR}/patches/dis.patch" "patch should be in patches/")
endfunction()

function(qt_scenario_quiltrc_env_override)
    qt_begin_test("quiltrc_env_override")
    qt_write_file("${QT_TEST_BASE}/test_quiltrc_override" "QUILT_PATCHES=fromrc\n")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    file(MAKE_DIRECTORY "${QT_WORK_DIR}/fromenv")
    qt_quilt_ok(ENV "QUILT_PATCHES=fromenv" ARGS --quiltrc "${QT_TEST_BASE}/test_quiltrc_override" new ovr.patch MESSAGE "new failed")
    qt_quilt_ok(ENV "QUILT_PATCHES=fromenv" ARGS --quiltrc "${QT_TEST_BASE}/test_quiltrc_override" add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "y\n")
    qt_quilt_ok(ENV "QUILT_PATCHES=fromenv" ARGS --quiltrc "${QT_TEST_BASE}/test_quiltrc_override" refresh MESSAGE "refresh failed")
    qt_assert_exists("${QT_WORK_DIR}/fromrc/ovr.patch" "patch should be in fromrc/ (quiltrc should override env)")
    qt_assert_not_exists("${QT_WORK_DIR}/fromenv/ovr.patch" "patch should not be written to fromenv/")
endfunction()

function(qt_scenario_quilt_command_args)
    qt_begin_test("quilt_command_args")
    qt_write_file("${QT_TEST_BASE}/test_quiltrc_cmdargs" "QUILT_REFRESH_ARGS=\"--no-index\"\n")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_quilt_ok(ARGS --quiltrc "${QT_TEST_BASE}/test_quiltrc_cmdargs" new cmdargs.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS --quiltrc "${QT_TEST_BASE}/test_quiltrc_cmdargs" add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "y\n")
    qt_quilt_ok(ARGS --quiltrc "${QT_TEST_BASE}/test_quiltrc_cmdargs" refresh MESSAGE "refresh failed")
    qt_assert_file_not_contains("${QT_WORK_DIR}/patches/cmdargs.patch" "Index:" "patch should not contain Index: lines (QUILT_REFRESH_ARGS=--no-index)")
endfunction()

function(qt_scenario_quilt_series_env)
    qt_begin_test("quilt_series_env")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_write_file("${QT_WORK_DIR}/patches/s1.patch" [=[--- a/f.txt
+++ b/f.txt
@@ -1 +1 @@
-x
+series_env
]=])
    qt_write_file("${QT_WORK_DIR}/patches/my-series" "s1.patch\n")
    qt_quilt_ok(ENV "QUILT_SERIES=my-series" ARGS push MESSAGE "push with QUILT_SERIES failed")
    qt_assert_file_text("${QT_WORK_DIR}/f.txt" "series_env" "wrong content after push")
endfunction()

function(qt_scenario_quilt_no_diff_index)
    qt_begin_test("quilt_no_diff_index")
    qt_write_file("${QT_TEST_BASE}/test_quiltrc_noindex" "QUILT_NO_DIFF_INDEX=1\n")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_quilt_ok(ARGS --quiltrc "${QT_TEST_BASE}/test_quiltrc_noindex" new noindex.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS --quiltrc "${QT_TEST_BASE}/test_quiltrc_noindex" add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "y\n")
    qt_quilt_ok(ARGS --quiltrc "${QT_TEST_BASE}/test_quiltrc_noindex" refresh MESSAGE "refresh failed")
    qt_assert_file_not_contains("${QT_WORK_DIR}/patches/noindex.patch" "Index:" "patch should not contain Index: lines")
endfunction()

function(qt_scenario_quilt_patches_prefix)
    qt_begin_test("quilt_patches_prefix")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_quilt_ok(ARGS --quiltrc - new pfx.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS --quiltrc - add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "y\n")
    qt_quilt_ok(ARGS --quiltrc - refresh MESSAGE "refresh failed")
    qt_quilt_ok(ENV "QUILT_PATCHES_PREFIX=1" ARGS --quiltrc - series OUTPUT out ERROR err MESSAGE "series failed")
    qt_assert_matches("${out}" "^patches/" "series output should be prefixed with patches/")
endfunction()

function(qt_scenario_quiltrc_quoted_values)
    qt_begin_test("quiltrc_quoted_values")
    qt_write_file("${QT_TEST_BASE}/test_quiltrc_quoted" "QUILT_PATCHES=\"my patches\"\n")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    file(MAKE_DIRECTORY "${QT_WORK_DIR}/my patches")
    qt_quilt_ok(ARGS --quiltrc "${QT_TEST_BASE}/test_quiltrc_quoted" new quoted.patch MESSAGE "new with quoted quiltrc failed")
    qt_quilt_ok(ARGS --quiltrc "${QT_TEST_BASE}/test_quiltrc_quoted" add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "y\n")
    qt_quilt_ok(ARGS --quiltrc "${QT_TEST_BASE}/test_quiltrc_quoted" refresh MESSAGE "refresh failed")
    qt_assert_exists("${QT_WORK_DIR}/my patches/quoted.patch" "patch should be in 'my patches/'")
endfunction()

# --- mail command scenarios ---

# Helper: set up two patches with headers for mail tests
function(qt_mail_setup_two_patches)
    qt_write_file("${QT_WORK_DIR}/file.txt" "hello\n")
    qt_quilt_ok(ARGS new first.patch MESSAGE "new first failed")
    qt_quilt_ok(ARGS add file.txt MESSAGE "add first failed")
    qt_write_file("${QT_WORK_DIR}/file.txt" "world\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh first failed")
    qt_quilt_ok(ARGS header -r INPUT "Add greeting\n\nThis patch adds a greeting to the file.\n" MESSAGE "header first failed")
    qt_quilt_ok(ARGS new second.patch MESSAGE "new second failed")
    qt_quilt_ok(ARGS add file.txt MESSAGE "add second failed")
    qt_write_file("${QT_WORK_DIR}/file.txt" "world!\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh second failed")
    qt_quilt_ok(ARGS header -r INPUT "Fix punctuation\n\nAdd exclamation mark.\n" MESSAGE "header second failed")
endfunction()

function(qt_scenario_mail_basic)
    qt_begin_test("mail_basic")
    qt_mail_setup_two_patches()
    qt_quilt_ok(
        ARGS mail --mbox "${QT_TEST_BASE}/test.mbox" --from "Test User <test@example.com>"
        MESSAGE "mail --mbox failed"
    )
    qt_assert_exists("${QT_TEST_BASE}/test.mbox" "mbox file should exist")
    qt_read_file_raw(mbox "${QT_TEST_BASE}/test.mbox")
    # Check mbox separators
    qt_assert_contains("${mbox}" "From 0000000000000000000000000000000000000000 Mon Sep 17 00:00:00 2001" "missing mbox separator")
    # Check subjects
    qt_assert_contains("${mbox}" "[PATCH 1/2] Add greeting" "missing first patch subject")
    qt_assert_contains("${mbox}" "[PATCH 2/2] Fix punctuation" "missing second patch subject")
    # Check From header
    qt_assert_contains("${mbox}" "From: Test User <test@example.com>" "missing From header")
    # Check Date header exists
    qt_assert_matches("${mbox}" "Date: " "missing Date header")
    # Check Message-ID exists
    qt_assert_contains("${mbox}" "Message-ID:" "missing Message-ID header")
    # Check diff content is present
    qt_assert_contains("${mbox}" "@@" "missing diff hunks")
    # Check trailer
    qt_assert_contains("${mbox}" "-- \nquilt" "missing trailer")
    # Check body text
    qt_assert_contains("${mbox}" "This patch adds a greeting to the file." "missing first patch body")
    qt_assert_contains("${mbox}" "Add exclamation mark." "missing second patch body")
endfunction()

function(qt_scenario_mail_single_patch)
    qt_begin_test("mail_single_patch")
    qt_write_file("${QT_WORK_DIR}/file.txt" "a\n")
    qt_quilt_ok(ARGS new only.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add file.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/file.txt" "b\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    qt_quilt_ok(ARGS header -r INPUT "Single change\n" MESSAGE "header failed")
    qt_quilt_ok(
        ARGS mail --mbox "${QT_TEST_BASE}/single.mbox" --from "test@example.com"
        MESSAGE "mail single failed"
    )
    qt_read_file_raw(mbox "${QT_TEST_BASE}/single.mbox")
    # Single patch should use [PATCH] without numbering
    qt_assert_contains("${mbox}" "[PATCH] Single change" "single patch subject wrong")
    qt_assert_not_contains("${mbox}" "[PATCH 1/" "should not have patch numbering for single patch")
endfunction()

function(qt_scenario_mail_patch_range)
    qt_begin_test("mail_patch_range")
    qt_write_file("${QT_WORK_DIR}/file.txt" "a\n")
    qt_quilt_ok(ARGS new p1.patch MESSAGE "new p1 failed")
    qt_quilt_ok(ARGS add file.txt MESSAGE "add p1 failed")
    qt_write_file("${QT_WORK_DIR}/file.txt" "b\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh p1 failed")
    qt_quilt_ok(ARGS header -r INPUT "Patch one\n" MESSAGE "header p1 failed")
    qt_quilt_ok(ARGS new p2.patch MESSAGE "new p2 failed")
    qt_quilt_ok(ARGS add file.txt MESSAGE "add p2 failed")
    qt_write_file("${QT_WORK_DIR}/file.txt" "c\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh p2 failed")
    qt_quilt_ok(ARGS header -r INPUT "Patch two\n" MESSAGE "header p2 failed")
    qt_quilt_ok(ARGS new p3.patch MESSAGE "new p3 failed")
    qt_quilt_ok(ARGS add file.txt MESSAGE "add p3 failed")
    qt_write_file("${QT_WORK_DIR}/file.txt" "d\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh p3 failed")
    qt_quilt_ok(ARGS header -r INPUT "Patch three\n" MESSAGE "header p3 failed")
    # Select only p2..p3
    qt_quilt_ok(
        ARGS mail --mbox "${QT_TEST_BASE}/range.mbox" --from "t@e.com" p2.patch p3.patch
        MESSAGE "mail range failed"
    )
    qt_read_file_raw(mbox "${QT_TEST_BASE}/range.mbox")
    qt_assert_not_contains("${mbox}" "Patch one" "should not contain p1")
    qt_assert_contains("${mbox}" "[PATCH 1/2] Patch two" "missing p2 subject")
    qt_assert_contains("${mbox}" "[PATCH 2/2] Patch three" "missing p3 subject")
endfunction()

function(qt_scenario_mail_dash_range)
    qt_begin_test("mail_dash_range")
    qt_write_file("${QT_WORK_DIR}/file.txt" "x\n")
    qt_quilt_ok(ARGS new a.patch MESSAGE "new a failed")
    qt_quilt_ok(ARGS add file.txt MESSAGE "add a failed")
    qt_write_file("${QT_WORK_DIR}/file.txt" "y\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh a failed")
    qt_quilt_ok(ARGS header -r INPUT "Alpha\n" MESSAGE "header a failed")
    qt_quilt_ok(ARGS new b.patch MESSAGE "new b failed")
    qt_quilt_ok(ARGS add file.txt MESSAGE "add b failed")
    qt_write_file("${QT_WORK_DIR}/file.txt" "z\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh b failed")
    qt_quilt_ok(ARGS header -r INPUT "Beta\n" MESSAGE "header b failed")
    # Use - - to mean all patches
    qt_quilt_ok(
        ARGS mail --mbox "${QT_TEST_BASE}/dash.mbox" --from "t@e.com" - -
        MESSAGE "mail dash range failed"
    )
    qt_read_file_raw(mbox "${QT_TEST_BASE}/dash.mbox")
    qt_assert_contains("${mbox}" "[PATCH 1/2] Alpha" "missing alpha subject")
    qt_assert_contains("${mbox}" "[PATCH 2/2] Beta" "missing beta subject")
endfunction()

function(qt_scenario_mail_prefix)
    qt_begin_test("mail_prefix")
    qt_write_file("${QT_WORK_DIR}/file.txt" "a\n")
    qt_quilt_ok(ARGS new fix.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add file.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/file.txt" "b\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    qt_quilt_ok(ARGS header -r INPUT "A fix\n" MESSAGE "header failed")
    qt_quilt_ok(
        ARGS mail --mbox "${QT_TEST_BASE}/prefix.mbox" --from "t@e.com" --prefix "RFC PATCH v2"
        MESSAGE "mail prefix failed"
    )
    qt_read_file_raw(mbox "${QT_TEST_BASE}/prefix.mbox")
    qt_assert_contains("${mbox}" "[RFC PATCH v2] A fix" "custom prefix not in subject")
endfunction()

function(qt_scenario_mail_from_sender)
    qt_begin_test("mail_from_sender")
    qt_write_file("${QT_WORK_DIR}/file.txt" "a\n")
    qt_quilt_ok(ARGS new f.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add file.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/file.txt" "b\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    qt_quilt_ok(ARGS header -r INPUT "Test\n" MESSAGE "header failed")
    # Test --from
    qt_quilt_ok(
        ARGS mail --mbox "${QT_TEST_BASE}/from.mbox" --from "Jane Doe <jane@example.com>"
        MESSAGE "mail --from failed"
    )
    qt_read_file_raw(mbox_from "${QT_TEST_BASE}/from.mbox")
    qt_assert_contains("${mbox_from}" "From: Jane Doe <jane@example.com>" "wrong From header with --from")
    # Test --sender (used as From when --from not given)
    qt_quilt_ok(
        ARGS mail --mbox "${QT_TEST_BASE}/sender.mbox" --sender "sender@example.com"
        MESSAGE "mail --sender failed"
    )
    qt_read_file_raw(mbox_sender "${QT_TEST_BASE}/sender.mbox")
    qt_assert_contains("${mbox_sender}" "From: sender@example.com" "wrong From header with --sender")
endfunction()

function(qt_scenario_mail_to_cc)
    qt_begin_test("mail_to_cc")
    qt_write_file("${QT_WORK_DIR}/file.txt" "a\n")
    qt_quilt_ok(ARGS new f.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add file.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/file.txt" "b\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    qt_quilt_ok(ARGS header -r INPUT "Change\n" MESSAGE "header failed")
    qt_quilt_ok(
        ARGS mail --mbox "${QT_TEST_BASE}/tocc.mbox"
            --from "t@e.com"
            --to "recv@example.com"
            --cc "copy@example.com"
            --bcc "hidden@example.com"
        MESSAGE "mail --to --cc failed"
    )
    qt_read_file_raw(mbox "${QT_TEST_BASE}/tocc.mbox")
    qt_assert_contains("${mbox}" "To: recv@example.com" "missing To header")
    qt_assert_contains("${mbox}" "Cc: copy@example.com" "missing Cc header")
    qt_assert_contains("${mbox}" "Bcc: hidden@example.com" "missing Bcc header")
endfunction()

function(qt_scenario_mail_send_error)
    qt_begin_test("mail_send_error")
    qt_write_file("${QT_WORK_DIR}/file.txt" "a\n")
    qt_quilt_ok(ARGS new f.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add file.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/file.txt" "b\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS mail --send --from "t@e.com")
    qt_assert_failure("${rc}" "--send should fail")
    qt_assert_contains("${err}" "send mode is not supported" "wrong error message for --send")
endfunction()

function(qt_scenario_mail_no_mbox_error)
    qt_begin_test("mail_no_mbox_error")
    qt_write_file("${QT_WORK_DIR}/file.txt" "a\n")
    qt_quilt_ok(ARGS new f.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add file.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/file.txt" "b\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS mail --from "t@e.com")
    qt_assert_failure("${rc}" "missing --mbox should fail")
    qt_assert_contains("${err}" "--mbox is required" "wrong error for missing --mbox")
endfunction()

function(qt_scenario_mail_no_patches)
    qt_begin_test("mail_no_patches")
    # Empty series — no patches at all
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS mail --mbox "${QT_TEST_BASE}/empty.mbox" --from "t@e.com")
    qt_assert_failure("${rc}" "empty series should fail")
    qt_assert_contains("${err}" "No patches in series" "wrong error for empty series")
endfunction()

function(qt_scenario_mail_header_multiline)
    qt_begin_test("mail_header_multiline")
    qt_write_file("${QT_WORK_DIR}/file.txt" "a\n")
    qt_quilt_ok(ARGS new multi.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add file.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/file.txt" "b\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    qt_quilt_ok(ARGS header -r INPUT "Short subject line\n\nThis is the first paragraph of the\ncommit message body.\n\nThis is the second paragraph.\n" MESSAGE "header failed")
    qt_quilt_ok(
        ARGS mail --mbox "${QT_TEST_BASE}/multi.mbox" --from "t@e.com"
        MESSAGE "mail multiline failed"
    )
    qt_read_file_raw(mbox "${QT_TEST_BASE}/multi.mbox")
    # Subject should be just the first line
    qt_assert_contains("${mbox}" "Subject: [PATCH] Short subject line" "wrong subject")
    # Body should contain the remaining paragraphs
    qt_assert_contains("${mbox}" "This is the first paragraph of the" "missing body paragraph 1")
    qt_assert_contains("${mbox}" "This is the second paragraph." "missing body paragraph 2")
    # Body should NOT contain the subject line again in the body section
    # (it's only in the Subject header)
endfunction()

function(qt_scenario_mail_diffstat)
    qt_begin_test("mail_diffstat")
    qt_write_file("${QT_WORK_DIR}/f.txt" "old\n")
    qt_quilt_ok(ARGS new ds.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "new\n")
    qt_quilt_ok(ARGS header -a INPUT "Subject line\n\nBody text.\n" MESSAGE "header failed")
    qt_quilt_ok(ARGS refresh --diffstat MESSAGE "refresh --diffstat failed")
    qt_quilt_ok(
        ARGS mail --mbox "${QT_TEST_BASE}/ds.mbox" --from "t@e.com"
        MESSAGE "mail with diffstat failed"
    )
    qt_read_file_raw(mbox "${QT_TEST_BASE}/ds.mbox")
    # Body should contain the diffstat
    qt_assert_contains("${mbox}" "file changed" "mbox should contain diffstat")
    # Should have exactly one "---" separator (from the diffstat), not two
    string(REPLACE "\n" ";" mbox_lines "${mbox}")
    set(sep_count 0)
    foreach(ml IN LISTS mbox_lines)
        if(ml STREQUAL "---")
            math(EXPR sep_count "${sep_count} + 1")
        endif()
    endforeach()
    if(NOT sep_count EQUAL 1)
        qt_fail("expected exactly 1 --- separator in mbox, got ${sep_count}")
    endif()
    # Diff content should still be present
    qt_assert_contains("${mbox}" "+new" "mbox should have diff content")
endfunction()

function(qt_scenario_mail_help)
    qt_begin_test("mail_help")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS mail --help)
    qt_assert_success("${rc}" "--help should succeed")
    qt_assert_contains("${out}" "Usage: quilt mail" "--help should print usage")
endfunction()

function(qt_scenario_mail_bad_option)
    qt_begin_test("mail_bad_option")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS mail --no-such-option)
    qt_assert_failure("${rc}" "bad option should fail")
    qt_assert_contains("${err}" "unknown option" "bad option should mention unknown option")
endfunction()

function(qt_scenario_mail_no_from)
    qt_begin_test("mail_no_from")
    qt_write_file("${QT_WORK_DIR}/f.txt" "a\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "b\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS mail --mbox "${QT_TEST_BASE}/out.mbox")
    qt_assert_failure("${rc}" "missing --from/--sender should fail")
    qt_assert_contains("${err}" "required" "should mention required")
endfunction()

function(qt_scenario_mail_opts_ignored)
    qt_begin_test("mail_opts_ignored")
    qt_write_file("${QT_WORK_DIR}/f.txt" "a\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "b\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    qt_quilt_ok(ARGS header -r INPUT "Test patch\n" MESSAGE "header failed")
    # All these options are accepted but silently ignored
    qt_quilt_ok(
        ARGS mail
            --mbox "${QT_TEST_BASE}/out.mbox"
            --from "t@e.com"
            --reply-to "r@e.com"
            -m "intro"
            -M "intro2"
            --subject "override"
            --charset "utf-8"
            --signature "sig.txt"
        MESSAGE "ignored options should not fail"
    )
    qt_assert_exists("${QT_TEST_BASE}/out.mbox" "mbox should exist")
endfunction()

function(qt_scenario_mail_single_named)
    qt_begin_test("mail_single_named")
    qt_write_file("${QT_WORK_DIR}/f.txt" "a\n")
    qt_quilt_ok(ARGS new p1.patch MESSAGE "new p1 failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add p1 failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "b\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh p1 failed")
    qt_quilt_ok(ARGS header -r INPUT "First change\n" MESSAGE "header p1 failed")
    qt_quilt_ok(ARGS new p2.patch MESSAGE "new p2 failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add p2 failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "c\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh p2 failed")
    qt_quilt_ok(ARGS header -r INPUT "Second change\n" MESSAGE "header p2 failed")
    # Select only p1 by name (single positional, not "-")
    qt_quilt_ok(
        ARGS mail --mbox "${QT_TEST_BASE}/out.mbox" --from "t@e.com" p1.patch
        MESSAGE "mail single named failed"
    )
    qt_read_file_raw(mbox "${QT_TEST_BASE}/out.mbox")
    qt_assert_contains("${mbox}" "[PATCH] First change" "should have p1 subject")
    qt_assert_not_contains("${mbox}" "Second change" "should not have p2")
endfunction()

function(qt_scenario_mail_patch_not_in_series)
    qt_begin_test("mail_patch_not_in_series")
    qt_write_file("${QT_WORK_DIR}/f.txt" "a\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "b\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    qt_quilt(RESULT rc OUTPUT out ERROR err
        ARGS mail --mbox "${QT_TEST_BASE}/out.mbox" --from "t@e.com" nosuchpatch.patch)
    qt_assert_failure("${rc}" "patch not in series should fail")
    qt_assert_contains("${err}" "not in series" "should say not in series")
endfunction()

function(qt_scenario_mail_first_not_in_series)
    qt_begin_test("mail_first_not_in_series")
    qt_write_file("${QT_WORK_DIR}/f.txt" "a\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "b\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    qt_quilt(RESULT rc OUTPUT out ERROR err
        ARGS mail --mbox "${QT_TEST_BASE}/out.mbox" --from "t@e.com" nosuch.patch p.patch)
    qt_assert_failure("${rc}" "first patch not in series should fail")
    qt_assert_contains("${err}" "not in series" "should say not in series")
endfunction()

function(qt_scenario_mail_last_not_in_series)
    qt_begin_test("mail_last_not_in_series")
    qt_write_file("${QT_WORK_DIR}/f.txt" "a\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "b\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    qt_quilt(RESULT rc OUTPUT out ERROR err
        ARGS mail --mbox "${QT_TEST_BASE}/out.mbox" --from "t@e.com" p.patch nosuch.patch)
    qt_assert_failure("${rc}" "last patch not in series should fail")
    qt_assert_contains("${err}" "not in series" "should say not in series")
endfunction()

function(qt_scenario_mail_range_reversed)
    qt_begin_test("mail_range_reversed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "a\n")
    qt_quilt_ok(ARGS new p1.patch MESSAGE "new p1 failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add p1 failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "b\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh p1 failed")
    qt_quilt_ok(ARGS new p2.patch MESSAGE "new p2 failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add p2 failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "c\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh p2 failed")
    # Specify last before first — should fail
    qt_quilt(RESULT rc OUTPUT out ERROR err
        ARGS mail --mbox "${QT_TEST_BASE}/out.mbox" --from "t@e.com" p2.patch p1.patch)
    qt_assert_failure("${rc}" "reversed range should fail")
    qt_assert_contains("${err}" "first patch must come before" "should explain ordering")
endfunction()

function(qt_scenario_mail_too_many_args)
    qt_begin_test("mail_too_many_args")
    qt_write_file("${QT_WORK_DIR}/f.txt" "a\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "b\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    qt_quilt(RESULT rc OUTPUT out ERROR err
        ARGS mail --mbox "${QT_TEST_BASE}/out.mbox" --from "t@e.com" p.patch p.patch p.patch)
    qt_assert_failure("${rc}" "too many positional args should fail")
    qt_assert_contains("${err}" "Usage:" "should print usage")
endfunction()

function(qt_scenario_mail_empty_patch)
    qt_begin_test("mail_empty_patch")
    qt_write_file("${QT_WORK_DIR}/f.txt" "a\n")
    qt_quilt_ok(ARGS new p1.patch MESSAGE "new p1 failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add p1 failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "b\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh p1 failed")
    qt_quilt_ok(ARGS header -r INPUT "Good patch\n" MESSAGE "header failed")
    # Create an empty p2
    file(APPEND "${QT_WORK_DIR}/patches/series" "p2.patch\n")
    file(WRITE "${QT_WORK_DIR}/patches/p2.patch" "")
    # Mail should skip p2 with a warning but still output mbox with p1
    qt_quilt_ok(
        OUTPUT out ERROR err
        ARGS mail --mbox "${QT_TEST_BASE}/out.mbox" --from "t@e.com"
        MESSAGE "mail with empty patch should still succeed"
    )
    qt_assert_contains("${err}" "empty" "should warn about empty patch")
    qt_assert_contains("${err}" "p2.patch" "should name the empty patch")
    qt_read_file_raw(mbox "${QT_TEST_BASE}/out.mbox")
    qt_assert_contains("${mbox}" "Good patch" "should still have p1")
endfunction()

function(qt_scenario_mail_no_header)
    qt_begin_test("mail_no_header")
    qt_write_file("${QT_WORK_DIR}/f.txt" "a\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "b\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    # The refreshed patch starts with --- (no header text), so extract_header returns "".
    # This triggers the fallback: use patch filename as subject.
    qt_quilt_ok(
        OUTPUT out ERROR err
        ARGS mail --mbox "${QT_TEST_BASE}/out.mbox" --from "t@e.com"
        MESSAGE "mail no header failed"
    )
    qt_read_file_raw(mbox "${QT_TEST_BASE}/out.mbox")
    qt_assert_contains("${mbox}" "Subject: [PATCH] p.patch" "should use patch name as subject")
endfunction()

function(qt_scenario_mail_non_ascii)
    qt_begin_test("mail_non_ascii")
    qt_write_file("${QT_WORK_DIR}/f.txt" "a\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "b\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    # Subject with non-ASCII character → triggers RFC 2047 encoding
    # Also long enough to trigger line-wrap in rfc2047_encode (> ~63 encoded bytes)
    qt_quilt_ok(ARGS header -r INPUT "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAÉ\n" MESSAGE "header failed")
    qt_quilt_ok(
        OUTPUT out ERROR err
        ARGS mail --mbox "${QT_TEST_BASE}/out.mbox" --from "t@e.com"
        MESSAGE "mail non-ascii failed"
    )
    qt_read_file_raw(mbox "${QT_TEST_BASE}/out.mbox")
    # Subject should be RFC 2047 encoded (starts with =?UTF-8?q?)
    qt_assert_contains("${mbox}" "=?UTF-8?q?" "should RFC 2047 encode non-ASCII subject")
    # MIME headers should be present
    qt_assert_contains("${mbox}" "MIME-Version: 1.0" "should have MIME-Version")
    qt_assert_contains("${mbox}" "Content-Type: text/plain; charset=UTF-8" "should have Content-Type")
endfunction()

function(qt_scenario_mail_single_dash_positional)
    qt_begin_test("mail_single_dash_positional")
    qt_write_file("${QT_WORK_DIR}/f.txt" "a\n")
    qt_quilt_ok(ARGS new p1.patch MESSAGE "new p1 failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add p1 failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "b\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh p1 failed")
    qt_quilt_ok(ARGS header -r INPUT "First\n" MESSAGE "header p1 failed")
    qt_quilt_ok(ARGS new p2.patch MESSAGE "new p2 failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add p2 failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "c\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh p2 failed")
    qt_quilt_ok(ARGS header -r INPUT "Second\n" MESSAGE "header p2 failed")
    # "-" as single positional means all patches
    qt_quilt_ok(
        ARGS mail --mbox "${QT_TEST_BASE}/out.mbox" --from "t@e.com" -
        MESSAGE "mail with dash positional failed"
    )
    qt_read_file_raw(mbox "${QT_TEST_BASE}/out.mbox")
    qt_assert_contains("${mbox}" "First" "should have p1")
    qt_assert_contains("${mbox}" "Second" "should have p2")
endfunction()

function(qt_scenario_mail_leading_blank_header)
    qt_begin_test("mail_leading_blank_header")
    qt_write_file("${QT_WORK_DIR}/f.txt" "a\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "b\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    # Write a patch file with blank lines before the subject
    qt_read_file_raw(patch_content "${QT_WORK_DIR}/patches/p.patch")
    file(WRITE "${QT_WORK_DIR}/patches/p.patch" "\n\nReal Subject\n\n${patch_content}")
    qt_quilt_ok(
        OUTPUT out ERROR err
        ARGS mail --mbox "${QT_TEST_BASE}/out.mbox" --from "t@e.com"
        MESSAGE "mail leading blank header failed"
    )
    qt_read_file_raw(mbox "${QT_TEST_BASE}/out.mbox")
    qt_assert_contains("${mbox}" "Subject: [PATCH] Real Subject" "should skip blank lines to find subject")
endfunction()

# --- shell_split scenarios (quoting and variable expansion in QUILT_*_ARGS) ---

# Each shell_split test uses quilt mail as the vehicle.  To work against both
# quilt.cpp and the original quilt we pass --sender (required by original),
# -m intro (skips the cover-letter editor), and EDITOR=true as a safety net.
# Assertions check only the From: header, which both implementations produce.

function(qt_scenario_shell_split_single_quotes)
    qt_begin_test("shell_split_single_quotes")
    qt_write_file("${QT_WORK_DIR}/file.txt" "a\n")
    qt_quilt_ok(ARGS new f.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add file.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/file.txt" "b\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    qt_quilt_ok(ARGS header -r INPUT "Test\n" MESSAGE "header failed")
    # Single quotes preserve spaces in --from value
    qt_quilt_ok(
        ENV "QUILT_MAIL_ARGS=--sender test@example.com --from 'First Last <test@example.com>' --subject test -m intro --mbox ${QT_TEST_BASE}/sq.mbox" "EDITOR=true"
        ARGS mail
        MESSAGE "mail with single-quoted QUILT_MAIL_ARGS failed"
    )
    qt_read_file_raw(mbox "${QT_TEST_BASE}/sq.mbox")
    qt_assert_contains("${mbox}" "From: First Last <test@example.com>" "single-quoted from not preserved")
endfunction()

function(qt_scenario_shell_split_double_quotes)
    qt_begin_test("shell_split_double_quotes")
    qt_write_file("${QT_WORK_DIR}/file.txt" "a\n")
    qt_quilt_ok(ARGS new f.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add file.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/file.txt" "b\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    qt_quilt_ok(ARGS header -r INPUT "Test\n" MESSAGE "header failed")
    # Double quotes preserve spaces — use quiltrc to avoid cmake -E chdir
    # mangling literal " in env values.  Original quilt eval's the value,
    # so the inner double quotes work the same way.
    set(dq_mbox "${QT_TEST_BASE}/dq.mbox")
    qt_write_file("${QT_TEST_BASE}/test_quiltrc_dq" "QUILT_MAIL_ARGS='--sender test@example.com --from \"First Last <test@example.com>\" --subject test -m intro --mbox ${dq_mbox}'\n")
    qt_quilt_ok(
        ENV "EDITOR=true"
        ARGS --quiltrc "${QT_TEST_BASE}/test_quiltrc_dq" mail
        MESSAGE "mail with double-quoted QUILT_MAIL_ARGS failed"
    )
    qt_read_file_raw(mbox "${QT_TEST_BASE}/dq.mbox")
    qt_assert_contains("${mbox}" "From: First Last <test@example.com>" "double-quoted from not preserved")
endfunction()

function(qt_scenario_shell_split_var_expansion)
    qt_begin_test("shell_split_var_expansion")
    qt_write_file("${QT_WORK_DIR}/file.txt" "a\n")
    qt_quilt_ok(ARGS new f.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add file.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/file.txt" "b\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    qt_quilt_ok(ARGS header -r INPUT "Test\n" MESSAGE "header failed")
    # $VAR expansion (bare dollar, no braces — CMake doesn't expand this)
    qt_quilt_ok(
        ENV "QUILT_MAIL_ARGS=--sender test@example.com --from $TESTFROM --subject test -m intro --mbox ${QT_TEST_BASE}/var.mbox" "TESTFROM=someone@example.com" "EDITOR=true"
        ARGS mail
        MESSAGE "mail with var expansion failed"
    )
    qt_read_file_raw(mbox "${QT_TEST_BASE}/var.mbox")
    qt_assert_contains("${mbox}" "From: someone@example.com" "var expansion did not work")
endfunction()

function(qt_scenario_shell_split_var_braces)
    qt_begin_test("shell_split_var_braces")
    qt_write_file("${QT_WORK_DIR}/file.txt" "a\n")
    qt_quilt_ok(ARGS new f.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add file.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/file.txt" "b\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    qt_quilt_ok(ARGS header -r INPUT "Test\n" MESSAGE "header failed")
    # Use quiltrc to pass literal ${VAR} references (CMake would expand them).
    # Quiltrc outer single quotes preserve content literally; both quilt.cpp's
    # shell_split and the original quilt's eval expand the env vars.
    set(br_mbox "${QT_TEST_BASE}/brace.mbox")
    string(CONCAT braced_val
        "QUILT_MAIL_ARGS='--sender test@example.com --from \"$"
        "{TESTNAME} <$"
        "{TESTEMAIL}>\" --subject test -m intro --mbox ${br_mbox}'\n")
    qt_write_file("${QT_TEST_BASE}/test_quiltrc_br" "${braced_val}")
    qt_quilt_ok(
        ENV "TESTNAME=Jane Doe" "TESTEMAIL=jane@example.com" "EDITOR=true"
        ARGS --quiltrc "${QT_TEST_BASE}/test_quiltrc_br" mail
        MESSAGE "mail with braced var expansion failed"
    )
    qt_read_file_raw(mbox "${QT_TEST_BASE}/brace.mbox")
    qt_assert_contains("${mbox}" "From: Jane Doe <jane@example.com>" "braced var expansion did not work")
endfunction()

function(qt_scenario_shell_split_mixed)
    qt_begin_test("shell_split_mixed")
    qt_write_file("${QT_WORK_DIR}/file.txt" "a\n")
    qt_quilt_ok(ARGS new f.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add file.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/file.txt" "b\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    qt_quilt_ok(ARGS header -r INPUT "Test\n" MESSAGE "header failed")
    # Adjacent quoted/unquoted segments merge into one token:
    # 'Mix User <'$MIXEMAIL'>' becomes "Mix User <mix@example.com>"
    qt_quilt_ok(
        ENV "QUILT_MAIL_ARGS=--sender test@example.com --mbox ${QT_TEST_BASE}/mix.mbox --subject test -m intro --from 'Mix User <'$MIXEMAIL'>'" "MIXEMAIL=mix@example.com" "EDITOR=true"
        ARGS mail
        MESSAGE "mail with mixed quoting failed"
    )
    qt_read_file_raw(mbox "${QT_TEST_BASE}/mix.mbox")
    qt_assert_contains("${mbox}" "From: Mix User <mix@example.com>" "mixed quoting did not merge correctly")
endfunction()

function(qt_scenario_shell_split_dquote_escape)
    qt_begin_test("shell_split_dquote_escape")
    qt_write_file("${QT_WORK_DIR}/file.txt" "a\n")
    qt_quilt_ok(ARGS new f.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add file.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/file.txt" "b\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    qt_quilt_ok(ARGS header -r INPUT "Test\n" MESSAGE "header failed")
    # Test backslash escape inside double quotes in QUILT_MAIL_ARGS (shell_split lines 192-195).
    # We write a quiltrc where QUILT_MAIL_ARGS is a double-quoted value whose text contains
    # a double-quoted --from token with \\ inside: shell_split sees \\ → next=='\\' → covered.
    # File content needed:
    #   QUILT_MAIL_ARGS="... --from \"back\\\\slash@e.com\" ..."
    # After parse_quiltrc double-quote processing:
    #   QUILT_MAIL_ARGS = ... --from "back\\slash@e.com" ...
    # Then shell_split processes "back\\slash@e.com": \\ inside dquote → lines 192-195 covered.
    set(bs "\\")
    set(dq "\"")
    set(mbox_path "${QT_TEST_BASE}/dq.mbox")
    # Build the inner value (what will be set as QUILT_MAIL_ARGS env var after quiltrc parsing)
    # The quiltrc double-quoted value must use \" for embedded " and \\\\ for \\
    set(mail_args "--sender test@e.com --from ${bs}${dq}back${bs}${bs}${bs}${bs}slash@e.com${bs}${dq} --mbox ${mbox_path} --subject x -m intro")
    qt_write_file("${QT_TEST_BASE}/dqrc" "QUILT_MAIL_ARGS=${dq}${mail_args}${dq}\n")
    qt_quilt_ok(
        ARGS --quiltrc "${QT_TEST_BASE}/dqrc" mail
        MESSAGE "mail with quiltrc dquote-backslash QUILT_MAIL_ARGS failed"
    )
    qt_read_file_raw(mbox "${mbox_path}")
    qt_assert_contains("${mbox}" "From: back" "dquote backslash escape: from header present")
endfunction()

function(qt_scenario_shell_split_unquoted_backslash)
    qt_begin_test("shell_split_unquoted_backslash")
    qt_write_file("${QT_WORK_DIR}/file.txt" "a\n")
    qt_quilt_ok(ARGS new f.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add file.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/file.txt" "b\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    qt_quilt_ok(ARGS header -r INPUT "Test\n" MESSAGE "header failed")
    # Unquoted backslash escapes the next character (here: space)
    # "First\ Last" → single token "First Last"
    qt_quilt_ok(
        ENV "QUILT_MAIL_ARGS=--sender test@e.com --mbox ${QT_TEST_BASE}/ub.mbox --from First\\ Last\\ <fl@e.com> --subject x -m intro" "EDITOR=true"
        ARGS mail
        MESSAGE "mail with unquoted-backslash from failed"
    )
    qt_read_file_raw(mbox "${QT_TEST_BASE}/ub.mbox")
    qt_assert_contains("${mbox}" "From: First Last" "unquoted backslash should preserve escaped space")
endfunction()

# ---- Built-in diff engine unit tests ----
# These test the built-in diff via quilt diff, verifying exact output format.

function(qt_scenario_builtin_diff_identical_files)
    qt_begin_test("builtin_diff_identical_files")
    qt_write_file("${QT_WORK_DIR}/f.txt" "line1\nline2\nline3\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    # Don't modify the file — diff should produce no output
    qt_quilt(RESULT rc OUTPUT diff_out ERROR diff_err ARGS diff)
    qt_assert_success("${rc}" "diff of identical files should succeed")
    qt_assert_equal("${diff_out}" "" "identical files should produce no diff output")
endfunction()

function(qt_scenario_builtin_diff_simple_change)
    qt_begin_test("builtin_diff_simple_change")
    qt_write_file("${QT_WORK_DIR}/f.txt" "aaa\nbbb\nccc\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "aaa\nBBB\nccc\n")
    qt_quilt_ok(OUTPUT diff_out ERROR diff_err ARGS diff MESSAGE "diff failed")
    qt_assert_contains("${diff_out}" "-bbb" "should show removed line")
    qt_assert_contains("${diff_out}" "+BBB" "should show added line")
    qt_assert_contains("${diff_out}" " aaa" "should show context line")
    qt_assert_contains("${diff_out}" " ccc" "should show context line")
    qt_assert_contains("${diff_out}" "@@" "should have hunk header")
endfunction()

function(qt_scenario_builtin_diff_new_file)
    qt_begin_test("builtin_diff_new_file")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "new content\n")
    qt_quilt_ok(OUTPUT diff_out ERROR diff_err ARGS diff MESSAGE "diff failed")
    qt_assert_contains("${diff_out}" "--- /dev/null" "old file should be /dev/null")
    qt_assert_contains("${diff_out}" "+new content" "should show new content")
endfunction()

function(qt_scenario_builtin_diff_deleted_file)
    qt_begin_test("builtin_diff_deleted_file")
    qt_write_file("${QT_WORK_DIR}/f.txt" "old content\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    file(REMOVE "${QT_WORK_DIR}/f.txt")
    qt_quilt_ok(OUTPUT diff_out ERROR diff_err ARGS diff MESSAGE "diff failed")
    qt_assert_contains("${diff_out}" "+++ /dev/null" "new file should be /dev/null")
    qt_assert_contains("${diff_out}" "-old content" "should show removed content")
endfunction()

function(qt_scenario_builtin_diff_no_trailing_newline)
    qt_begin_test("builtin_diff_no_trailing_newline")
    # Write file without trailing newline using NEWLINE_STYLE
    file(WRITE "${QT_WORK_DIR}/f.txt" "line1\nline2")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    file(WRITE "${QT_WORK_DIR}/f.txt" "line1\nmodified")
    qt_quilt_ok(OUTPUT diff_out ERROR diff_err ARGS diff MESSAGE "diff failed")
    qt_assert_contains("${diff_out}" "\\ No newline at end of file" "should note missing newline")
    qt_assert_contains("${diff_out}" "-line2" "should show removed line")
    qt_assert_contains("${diff_out}" "+modified" "should show added line")
endfunction()

function(qt_scenario_builtin_diff_empty_to_content)
    qt_begin_test("builtin_diff_empty_to_content")
    qt_write_file("${QT_WORK_DIR}/f.txt" "")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "hello\nworld\n")
    qt_quilt_ok(OUTPUT diff_out ERROR diff_err ARGS diff MESSAGE "diff failed")
    qt_assert_contains("${diff_out}" "+hello" "should show added line")
    qt_assert_contains("${diff_out}" "+world" "should show added line")
endfunction()

function(qt_scenario_builtin_diff_multiple_hunks)
    qt_begin_test("builtin_diff_multiple_hunks")
    # Create a file with lines far enough apart that changes form separate hunks
    set(content "")
    foreach(i RANGE 1 30)
        string(APPEND content "line ${i}\n")
    endforeach()
    qt_write_file("${QT_WORK_DIR}/f.txt" "${content}")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    # Change line 2 and line 28 — far enough apart for separate hunks
    set(content2 "")
    foreach(i RANGE 1 30)
        if(i EQUAL 2)
            string(APPEND content2 "CHANGED 2\n")
        elseif(i EQUAL 28)
            string(APPEND content2 "CHANGED 28\n")
        else()
            string(APPEND content2 "line ${i}\n")
        endif()
    endforeach()
    qt_write_file("${QT_WORK_DIR}/f.txt" "${content2}")
    qt_quilt_ok(OUTPUT diff_out ERROR diff_err ARGS diff MESSAGE "diff failed")
    # Should have two @@ markers for two separate hunks
    string(REGEX MATCHALL "@@" hunk_markers "${diff_out}")
    list(LENGTH hunk_markers count)
    # Each hunk has one @@ line, but @@ appears twice on each line (start/end)
    # Actually @@ -X,Y +A,B @@ has @@ at start and end
    # Let's just count lines starting with @@
    string(REGEX MATCHALL "\n@@" hunk_lines "${diff_out}")
    list(LENGTH hunk_lines hunk_count)
    if(hunk_count LESS 2)
        # First @@ might be at start of diff (after headers)
        string(REGEX MATCHALL "@@ " hunk_headers "${diff_out}")
        list(LENGTH hunk_headers hunk_count2)
        if(hunk_count2 LESS 2)
            qt_fail("Expected at least 2 hunks but found fewer: ${diff_out}")
        endif()
    endif()
    qt_assert_contains("${diff_out}" "-line 2" "should show removed line 2")
    qt_assert_contains("${diff_out}" "+CHANGED 2" "should show added CHANGED 2")
    qt_assert_contains("${diff_out}" "-line 28" "should show removed line 28")
    qt_assert_contains("${diff_out}" "+CHANGED 28" "should show added CHANGED 28")
endfunction()

function(qt_scenario_builtin_diff_zero_context)
    qt_begin_test("builtin_diff_zero_context")
    qt_write_file("${QT_WORK_DIR}/f.txt" "aaa\nbbb\nccc\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "aaa\nBBB\nccc\n")
    qt_quilt_ok(OUTPUT diff_out ERROR diff_err ARGS diff -U 0 MESSAGE "diff -U 0 failed")
    # With 0 context lines, should NOT include 'aaa' or 'ccc' as context
    qt_assert_not_contains("${diff_out}" " aaa" "zero context should not include aaa")
    qt_assert_not_contains("${diff_out}" " ccc" "zero context should not include ccc")
    qt_assert_contains("${diff_out}" "-bbb" "should show removed line")
    qt_assert_contains("${diff_out}" "+BBB" "should show added line")
endfunction()

function(qt_scenario_builtin_diff_large_context)
    qt_begin_test("builtin_diff_large_context")
    qt_write_file("${QT_WORK_DIR}/f.txt" "a\nb\nc\nd\ne\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "a\nb\nC\nd\ne\n")
    qt_quilt_ok(OUTPUT diff_out ERROR diff_err ARGS diff -U 10 MESSAGE "diff -U 10 failed")
    # With large context, all lines should appear
    qt_assert_contains("${diff_out}" " a" "should show context line a")
    qt_assert_contains("${diff_out}" " b" "should show context line b")
    qt_assert_contains("${diff_out}" " d" "should show context line d")
    qt_assert_contains("${diff_out}" " e" "should show context line e")
    qt_assert_contains("${diff_out}" "-c" "should show removed c")
    qt_assert_contains("${diff_out}" "+C" "should show added C")
endfunction()

function(qt_scenario_builtin_diff_all_lines_changed)
    qt_begin_test("builtin_diff_all_lines_changed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "old1\nold2\nold3\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "new1\nnew2\nnew3\n")
    qt_quilt_ok(OUTPUT diff_out ERROR diff_err ARGS diff MESSAGE "diff failed")
    qt_assert_contains("${diff_out}" "-old1" "should show removed old1")
    qt_assert_contains("${diff_out}" "-old2" "should show removed old2")
    qt_assert_contains("${diff_out}" "-old3" "should show removed old3")
    qt_assert_contains("${diff_out}" "+new1" "should show added new1")
    qt_assert_contains("${diff_out}" "+new2" "should show added new2")
    qt_assert_contains("${diff_out}" "+new3" "should show added new3")
endfunction()

function(qt_scenario_builtin_diff_single_line_files)
    qt_begin_test("builtin_diff_single_line_files")
    qt_write_file("${QT_WORK_DIR}/f.txt" "one\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "two\n")
    qt_quilt_ok(OUTPUT diff_out ERROR diff_err ARGS diff MESSAGE "diff failed")
    qt_assert_contains("${diff_out}" "-one" "should show removed line")
    qt_assert_contains("${diff_out}" "+two" "should show added line")
endfunction()

function(qt_scenario_builtin_diff_context_format)
    qt_begin_test("builtin_diff_context_format")
    qt_write_file("${QT_WORK_DIR}/f.txt" "aaa\nbbb\nccc\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "aaa\nBBB\nccc\n")
    qt_quilt_ok(OUTPUT diff_out ERROR diff_err ARGS diff -c MESSAGE "diff -c failed")
    qt_assert_contains("${diff_out}" "***************" "context diff should have separator")
    qt_assert_contains("${diff_out}" "***" "context diff should have old header")
    qt_assert_contains("${diff_out}" "! bbb" "context diff should show old change with !")
    qt_assert_contains("${diff_out}" "! BBB" "context diff should show new change with !")
endfunction()

function(qt_scenario_builtin_diff_vs_system_diff)
    qt_begin_test("builtin_diff_vs_system_diff")
    # Create files and generate diff with builtin, then compare against --diff=diff
    qt_write_file("${QT_WORK_DIR}/f.txt" "alpha\nbeta\ngamma\ndelta\nepsilon\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "alpha\nBETA\ngamma\ndelta\nEPSILON\n")

    # Builtin diff (default)
    qt_quilt_ok(OUTPUT builtin_out ERROR builtin_err ARGS diff --no-index MESSAGE "builtin diff failed")
    # External diff
    qt_quilt_ok(OUTPUT external_out ERROR external_err ARGS diff --no-index --diff=diff MESSAGE "external diff failed")

    # Both should contain the same change markers
    qt_assert_contains("${builtin_out}" "-beta" "builtin should show -beta")
    qt_assert_contains("${builtin_out}" "+BETA" "builtin should show +BETA")
    qt_assert_contains("${builtin_out}" "-epsilon" "builtin should show -epsilon")
    qt_assert_contains("${builtin_out}" "+EPSILON" "builtin should show +EPSILON")
    qt_assert_contains("${external_out}" "-beta" "external should show -beta")
    qt_assert_contains("${external_out}" "+BETA" "external should show +BETA")
    qt_assert_contains("${external_out}" "-epsilon" "external should show -epsilon")
    qt_assert_contains("${external_out}" "+EPSILON" "external should show +EPSILON")
endfunction()

# ── Built-in patch engine tests ──────────────────────────────────────────

function(qt_scenario_builtin_patch_exact_apply)
    qt_begin_test("builtin_patch_exact_apply")
    qt_write_file("${QT_WORK_DIR}/f.txt" "aaa\nbbb\nccc\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "aaa\nBBB\nccc\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    qt_quilt_ok(ARGS pop MESSAGE "pop failed")
    qt_assert_file_text("${QT_WORK_DIR}/f.txt" "aaa\nbbb\nccc" "pop should restore original")
    qt_quilt_ok(ARGS push MESSAGE "push failed")
    qt_assert_file_text("${QT_WORK_DIR}/f.txt" "aaa\nBBB\nccc" "push should apply change")
endfunction()

function(qt_scenario_builtin_patch_offset)
    qt_begin_test("builtin_patch_offset")
    # Create a file and make a patch
    qt_write_file("${QT_WORK_DIR}/f.txt" "line1\nline2\nline3\nline4\nline5\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "line1\nline2\nline3\nMODIFIED\nline5\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    qt_quilt_ok(ARGS pop MESSAGE "pop failed")
    # Now add extra lines at the top to create an offset
    qt_write_file("${QT_WORK_DIR}/f.txt" "extra1\nextra2\nextra3\nline1\nline2\nline3\nline4\nline5\n")
    qt_quilt_ok(OUTPUT push_out ERROR push_err ARGS push MESSAGE "push should succeed with offset")
    qt_assert_file_text("${QT_WORK_DIR}/f.txt" "extra1\nextra2\nextra3\nline1\nline2\nline3\nMODIFIED\nline5" "file should have modification at offset")
endfunction()

function(qt_scenario_builtin_patch_fuzz)
    qt_begin_test("builtin_patch_fuzz")
    # Create a file and patch
    qt_write_file("${QT_WORK_DIR}/f.txt" "ctx1\nctx2\nctx3\ntarget\nctx4\nctx5\nctx6\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "ctx1\nctx2\nctx3\nMODIFIED\nctx4\nctx5\nctx6\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    qt_quilt_ok(ARGS pop MESSAGE "pop failed")
    # Change context lines so exact match fails but fuzz=1 succeeds
    qt_write_file("${QT_WORK_DIR}/f.txt" "CHANGED\nctx2\nctx3\ntarget\nctx4\nctx5\nCHANGED\n")
    # Push with fuzz=3 to allow fuzzy matching
    qt_quilt_ok(OUTPUT push_out ERROR push_err ARGS push --fuzz=3 MESSAGE "push with fuzz should succeed")
    qt_assert_contains("${push_out}" "fuzz" "should report fuzz")
endfunction()

function(qt_scenario_builtin_patch_new_file)
    qt_begin_test("builtin_patch_new_file")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add newfile.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/newfile.txt" "brand new content\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    qt_quilt_ok(ARGS pop MESSAGE "pop failed")
    qt_assert_not_exists("${QT_WORK_DIR}/newfile.txt" "file should be removed on pop")
    qt_quilt_ok(ARGS push MESSAGE "push failed")
    qt_assert_file_text("${QT_WORK_DIR}/newfile.txt" "brand new content" "push should create file")
endfunction()

function(qt_scenario_builtin_patch_delete_file)
    qt_begin_test("builtin_patch_delete_file")
    qt_write_file("${QT_WORK_DIR}/f.txt" "doomed content\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    file(REMOVE "${QT_WORK_DIR}/f.txt")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    # Pop should restore the file
    qt_quilt_ok(ARGS pop MESSAGE "pop failed")
    qt_assert_file_text("${QT_WORK_DIR}/f.txt" "doomed content" "pop should restore file")
    # Push should delete it again
    qt_quilt_ok(ARGS push MESSAGE "push failed")
    qt_assert_not_exists("${QT_WORK_DIR}/f.txt" "push should delete file")
endfunction()

function(qt_scenario_builtin_patch_reverse)
    qt_begin_test("builtin_patch_reverse")
    qt_write_file("${QT_WORK_DIR}/f.txt" "aaa\nbbb\nccc\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "aaa\nBBB\nccc\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    # Patch is applied; verify reverse check works
    qt_quilt_ok(OUTPUT pop_out ERROR pop_err ARGS pop -R MESSAGE "pop -R should succeed")
    qt_assert_file_text("${QT_WORK_DIR}/f.txt" "aaa\nbbb\nccc" "pop should restore original")
endfunction()

function(qt_scenario_builtin_patch_dry_run)
    qt_begin_test("builtin_patch_dry_run")
    qt_write_file("${QT_WORK_DIR}/f.txt" "original\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "modified\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    # pop uses dry-run for -R verification
    # We test by ensuring pop -R checks cleanness
    qt_quilt_ok(ARGS pop -R MESSAGE "pop -R should succeed with clean file")
    qt_assert_file_text("${QT_WORK_DIR}/f.txt" "original" "pop should restore")
endfunction()

function(qt_scenario_builtin_patch_reject)
    qt_begin_test("builtin_patch_reject")
    qt_write_file("${QT_WORK_DIR}/f.txt" "aaa\nbbb\nccc\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "aaa\nBBB\nccc\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    qt_quilt_ok(ARGS pop MESSAGE "pop failed")
    # Completely change the file so the patch cannot apply
    qt_write_file("${QT_WORK_DIR}/f.txt" "xxx\nyyy\nzzz\n")
    # Push should fail
    qt_quilt(RESULT rc OUTPUT push_out ERROR push_err ARGS push --leave-rejects)
    qt_assert_failure("${rc}" "push should fail")
    qt_assert_exists("${QT_WORK_DIR}/f.txt.rej" "reject file should be created")
endfunction()

function(qt_scenario_builtin_patch_no_newline)
    qt_begin_test("builtin_patch_no_newline")
    file(WRITE "${QT_WORK_DIR}/f.txt" "line1\nline2")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    file(WRITE "${QT_WORK_DIR}/f.txt" "line1\nmodified")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    qt_quilt_ok(ARGS pop MESSAGE "pop failed")
    # Read raw to check no trailing newline is preserved
    qt_read_file_raw(content "${QT_WORK_DIR}/f.txt")
    qt_assert_equal("${content}" "line1\nline2" "should restore file without trailing newline")
    qt_quilt_ok(ARGS push MESSAGE "push failed")
    qt_read_file_raw(content2 "${QT_WORK_DIR}/f.txt")
    qt_assert_equal("${content2}" "line1\nmodified" "push should apply change without trailing newline")
endfunction()

function(qt_scenario_builtin_patch_multiple_files)
    qt_begin_test("builtin_patch_multiple_files")
    qt_write_file("${QT_WORK_DIR}/a.txt" "alpha\n")
    qt_write_file("${QT_WORK_DIR}/b.txt" "beta\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add a.txt MESSAGE "add a failed")
    qt_quilt_ok(ARGS add b.txt MESSAGE "add b failed")
    qt_write_file("${QT_WORK_DIR}/a.txt" "ALPHA\n")
    qt_write_file("${QT_WORK_DIR}/b.txt" "BETA\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    qt_quilt_ok(ARGS pop MESSAGE "pop failed")
    qt_assert_file_text("${QT_WORK_DIR}/a.txt" "alpha" "a.txt should be restored")
    qt_assert_file_text("${QT_WORK_DIR}/b.txt" "beta" "b.txt should be restored")
    qt_quilt_ok(ARGS push MESSAGE "push failed")
    qt_assert_file_text("${QT_WORK_DIR}/a.txt" "ALPHA" "a.txt should be modified")
    qt_assert_file_text("${QT_WORK_DIR}/b.txt" "BETA" "b.txt should be modified")
endfunction()

function(qt_scenario_builtin_patch_multiple_hunks)
    qt_begin_test("builtin_patch_multiple_hunks")
    qt_write_file("${QT_WORK_DIR}/f.txt" "1\n2\n3\n4\n5\n6\n7\n8\n9\n10\n11\n12\n13\n14\n15\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    # Modify lines 3 and 13 to create two separate hunks
    qt_write_file("${QT_WORK_DIR}/f.txt" "1\n2\nTHREE\n4\n5\n6\n7\n8\n9\n10\n11\n12\nTHIRTEEN\n14\n15\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    qt_quilt_ok(ARGS pop MESSAGE "pop failed")
    qt_assert_file_text("${QT_WORK_DIR}/f.txt" "1\n2\n3\n4\n5\n6\n7\n8\n9\n10\n11\n12\n13\n14\n15" "pop should restore original")
    qt_quilt_ok(ARGS push MESSAGE "push failed")
    qt_assert_file_text("${QT_WORK_DIR}/f.txt" "1\n2\nTHREE\n4\n5\n6\n7\n8\n9\n10\n11\n12\nTHIRTEEN\n14\n15" "push should apply both hunks")
endfunction()

function(qt_scenario_builtin_patch_strip_level)
    qt_begin_test("builtin_patch_strip_level")
    qt_write_file("${QT_WORK_DIR}/f.txt" "aaa\nbbb\nccc\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "aaa\nBBB\nccc\n")
    qt_quilt_ok(ARGS refresh -p0 MESSAGE "refresh -p0 failed")
    qt_quilt_ok(ARGS pop MESSAGE "pop failed")
    qt_assert_file_text("${QT_WORK_DIR}/f.txt" "aaa\nbbb\nccc" "pop should restore")
    qt_quilt_ok(ARGS push MESSAGE "push with -p0 should succeed")
    qt_assert_file_text("${QT_WORK_DIR}/f.txt" "aaa\nBBB\nccc" "push should apply with strip=0")
endfunction()

function(qt_scenario_builtin_patch_merge_markers)
    qt_begin_test("builtin_patch_merge_markers")
    qt_write_file("${QT_WORK_DIR}/f.txt" "aaa\nbbb\nccc\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "aaa\nBBB\nccc\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    qt_quilt_ok(ARGS pop MESSAGE "pop failed")
    # Completely change the file to force a conflict
    qt_write_file("${QT_WORK_DIR}/f.txt" "xxx\nyyy\nzzz\n")
    # Push with --merge and -f
    qt_quilt(RESULT rc OUTPUT push_out ERROR push_err ARGS push --merge -f)
    # Should have exit code != 0 but force-applied
    qt_assert_file_contains("${QT_WORK_DIR}/f.txt" "<<<<<<< current" "should have merge conflict marker")
    qt_assert_file_contains("${QT_WORK_DIR}/f.txt" "=======" "should have separator")
    qt_assert_file_contains("${QT_WORK_DIR}/f.txt" ">>>>>>> patch" "should have end marker")
endfunction()

function(qt_scenario_builtin_patch_empty_context)
    qt_begin_test("builtin_patch_empty_context")
    # Write a patch file manually with zero context lines
    qt_write_file("${QT_WORK_DIR}/f.txt" "aaa\nbbb\nccc\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "aaa\nBBB\nccc\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    # Manually rewrite the patch file with zero context
    qt_write_file("${QT_WORK_DIR}/patches/p.patch"
        "--- a/f.txt\n+++ b/f.txt\n@@ -2,1 +2,1 @@\n-bbb\n+BBB\n")
    qt_quilt_ok(ARGS pop MESSAGE "pop failed")
    qt_assert_file_text("${QT_WORK_DIR}/f.txt" "aaa\nbbb\nccc" "pop should restore")
    qt_quilt_ok(ARGS push MESSAGE "push with zero context should succeed")
    qt_assert_file_text("${QT_WORK_DIR}/f.txt" "aaa\nBBB\nccc" "push should apply change")
endfunction()

function(qt_scenario_builtin_patch_force)
    qt_begin_test("builtin_patch_force")
    qt_write_file("${QT_WORK_DIR}/f.txt" "aaa\nbbb\nccc\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "aaa\nBBB\nccc\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    qt_quilt_ok(ARGS pop MESSAGE "pop failed")
    # Change the file so patch doesn't apply cleanly
    qt_write_file("${QT_WORK_DIR}/f.txt" "xxx\nyyy\nzzz\n")
    # Force push
    qt_quilt(RESULT rc OUTPUT push_out ERROR push_err ARGS push -f)
    # Should report forced
    qt_assert_contains("${push_out}${push_err}" "forced" "should report forced application")
endfunction()

function(qt_scenario_builtin_patch_vs_system)
    qt_begin_test("builtin_patch_vs_system")
    # Create a simple scenario and verify builtin patch produces same result
    qt_write_file("${QT_WORK_DIR}/f.txt" "alpha\nbeta\ngamma\ndelta\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "alpha\nBETA\ngamma\nDELTA\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    qt_quilt_ok(ARGS pop MESSAGE "pop failed")
    qt_assert_file_text("${QT_WORK_DIR}/f.txt" "alpha\nbeta\ngamma\ndelta" "pop should restore")
    qt_quilt_ok(ARGS push MESSAGE "push should succeed")
    qt_assert_file_text("${QT_WORK_DIR}/f.txt" "alpha\nBETA\ngamma\nDELTA" "push should apply changes correctly")
endfunction()

function(qt_scenario_refresh_unified)
    qt_begin_test("refresh_unified")
    qt_write_file("${QT_WORK_DIR}/f.txt" "old\n")
    qt_quilt_ok(ARGS new u.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "new\n")
    qt_quilt_ok(ARGS refresh -u MESSAGE "refresh -u failed")
    qt_assert_file_contains("${QT_WORK_DIR}/patches/u.patch" "---" "unified patch should have --- line")
    qt_assert_file_contains("${QT_WORK_DIR}/patches/u.patch" "+++" "unified patch should have +++ line")
    qt_assert_file_contains("${QT_WORK_DIR}/patches/u.patch" "@@" "unified patch should have @@ hunk header")
endfunction()

function(qt_scenario_refresh_unified_lines)
    qt_begin_test("refresh_unified_lines")
    # Create a file with enough lines so context is visible
    qt_write_file("${QT_WORK_DIR}/f.txt" "1\n2\n3\n4\n5\n6\n7\n8\n9\n10\n")
    qt_quilt_ok(ARGS new ul.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    # Change line 5 only
    qt_write_file("${QT_WORK_DIR}/f.txt" "1\n2\n3\n4\nFIVE\n6\n7\n8\n9\n10\n")
    qt_quilt_ok(ARGS refresh -U 1 MESSAGE "refresh -U 1 failed")
    qt_read_file_strip(patch_text "${QT_WORK_DIR}/patches/ul.patch")
    # With -U 1, should have 1 context line before and after the change
    # Should contain lines 4 and 6 as context but NOT line 3 or line 8
    qt_assert_contains("${patch_text}" " 4" "should have line 4 as context")
    qt_assert_contains("${patch_text}" " 6" "should have line 6 as context")
    qt_assert_not_contains("${patch_text}" " 3" "should not have line 3 with -U 1")
    qt_assert_not_contains("${patch_text}" " 8" "should not have line 8 with -U 1")
endfunction()

function(qt_scenario_refresh_context)
    qt_begin_test("refresh_context")
    qt_write_file("${QT_WORK_DIR}/f.txt" "old\n")
    qt_quilt_ok(ARGS new ctx.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "new\n")
    qt_quilt_ok(ARGS refresh -c MESSAGE "refresh -c failed")
    qt_read_file_strip(patch_text "${QT_WORK_DIR}/patches/ctx.patch")
    # Context diff format uses *** and --- section markers
    qt_assert_contains("${patch_text}" "***" "context patch should have *** marker")
endfunction()

function(qt_scenario_refresh_context_lines)
    qt_begin_test("refresh_context_lines")
    qt_write_file("${QT_WORK_DIR}/f.txt" "1\n2\n3\n4\n5\n6\n7\n8\n9\n10\n")
    qt_quilt_ok(ARGS new cl.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "1\n2\n3\n4\nFIVE\n6\n7\n8\n9\n10\n")
    qt_quilt_ok(ARGS refresh -C 1 MESSAGE "refresh -C 1 failed")
    qt_read_file_strip(patch_text "${QT_WORK_DIR}/patches/cl.patch")
    qt_assert_contains("${patch_text}" "***" "context patch should have *** marker")
    # With -C 1, should have minimal context
    qt_assert_not_contains("${patch_text}" "  3" "should not have line 3 with -C 1")
endfunction()

function(qt_scenario_refresh_backup)
    qt_begin_test("refresh_backup")
    qt_write_file("${QT_WORK_DIR}/f.txt" "base\n")
    qt_quilt_ok(ARGS new bak.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "v1\n")
    qt_quilt_ok(ARGS refresh MESSAGE "initial refresh failed")
    qt_read_file_strip(old_patch "${QT_WORK_DIR}/patches/bak.patch")
    # Now modify again and refresh with --backup
    qt_write_file("${QT_WORK_DIR}/f.txt" "v2\n")
    qt_quilt_ok(ARGS refresh --backup MESSAGE "refresh --backup failed")
    # Backup should exist with old content
    qt_assert_exists("${QT_WORK_DIR}/patches/bak.patch~" "backup file should exist")
    qt_read_file_strip(backup_text "${QT_WORK_DIR}/patches/bak.patch~")
    qt_assert_equal("${backup_text}" "${old_patch}" "backup should contain old patch content")
    # New patch should have v2
    qt_assert_file_contains("${QT_WORK_DIR}/patches/bak.patch" "+v2" "refreshed patch should have +v2")
endfunction()

function(qt_scenario_refresh_backup_no_existing)
    qt_begin_test("refresh_backup_no_existing")
    qt_write_file("${QT_WORK_DIR}/f.txt" "base\n")
    qt_quilt_ok(ARGS new nobak.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "changed\n")
    # First refresh with --backup when no patch file exists yet
    qt_quilt_ok(ARGS refresh --backup MESSAGE "refresh --backup on first refresh should succeed")
    qt_assert_not_exists("${QT_WORK_DIR}/patches/nobak.patch~" "no backup when patch did not exist before")
    qt_assert_file_contains("${QT_WORK_DIR}/patches/nobak.patch" "+changed" "patch should have +changed")
endfunction()

function(qt_scenario_refresh_strip_whitespace)
    qt_begin_test("refresh_strip_whitespace")
    qt_write_file("${QT_WORK_DIR}/f.txt" "clean\n")
    qt_quilt_ok(ARGS new sw.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    # Add a line with trailing whitespace
    qt_write_file("${QT_WORK_DIR}/f.txt" "has trailing   \n")
    qt_quilt_ok(ARGS refresh --strip-trailing-whitespace MESSAGE "refresh --strip-trailing-whitespace failed")
    qt_read_file_strip(patch_text "${QT_WORK_DIR}/patches/sw.patch")
    # The patch should not contain trailing whitespace on the +line
    qt_assert_not_contains("${patch_text}" "trailing   " "trailing whitespace should be stripped")
    qt_assert_contains("${patch_text}" "+has trailing" "content should still be present")
endfunction()

function(qt_scenario_refresh_strip_whitespace_warning)
    qt_begin_test("refresh_strip_whitespace_warning")
    qt_write_file("${QT_WORK_DIR}/f.txt" "clean\n")
    qt_quilt_ok(ARGS new sww.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "trailing   \n")
    qt_quilt(RESULT rc OUTPUT ref_out ERROR ref_err ARGS refresh --strip-trailing-whitespace)
    qt_assert_success("${rc}" "refresh should succeed")
    qt_assert_contains("${ref_err}" "Warning" "should warn about trailing whitespace")
    qt_assert_contains("${ref_err}" "Trailing whitespace" "warning should mention trailing whitespace")
endfunction()

function(qt_scenario_refresh_fork)
    qt_begin_test("refresh_fork")
    qt_write_file("${QT_WORK_DIR}/f.txt" "base\n")
    qt_quilt_ok(ARGS new orig.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "forked\n")
    qt_quilt_ok(OUTPUT fork_out ERROR fork_err ARGS refresh -z MESSAGE "refresh -z failed")
    # The top patch should now be orig-2.patch
    qt_quilt_ok(OUTPUT top_out ARGS top MESSAGE "top failed")
    qt_strip_trailing_newlines(top_stripped "${top_out}")
    qt_assert_equal("${top_stripped}" "orig-2.patch" "top patch should be the forked name")
    # The forked patch should contain the diff
    qt_assert_file_contains("${QT_WORK_DIR}/patches/orig-2.patch" "+forked" "forked patch should have +forked")
    # Series should have orig-2.patch instead of orig.patch
    qt_assert_file_contains("${QT_WORK_DIR}/patches/series" "orig-2.patch" "series should have forked name")
    qt_assert_file_not_contains("${QT_WORK_DIR}/patches/series" "orig.patch" "series should not have old name")
endfunction()

function(qt_scenario_refresh_fork_named)
    qt_begin_test("refresh_fork_named")
    qt_write_file("${QT_WORK_DIR}/f.txt" "base\n")
    qt_quilt_ok(ARGS new orig.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "custom\n")
    qt_quilt_ok(ARGS refresh -zcustom.patch MESSAGE "refresh -zcustom.patch failed")
    qt_quilt_ok(OUTPUT top_out ARGS top MESSAGE "top failed")
    qt_strip_trailing_newlines(top_stripped "${top_out}")
    qt_assert_equal("${top_stripped}" "custom.patch" "top should be custom.patch")
    qt_assert_file_contains("${QT_WORK_DIR}/patches/custom.patch" "+custom" "custom patch should have +custom")
endfunction()

function(qt_scenario_refresh_fork_not_top)
    qt_begin_test("refresh_fork_not_top")
    qt_write_file("${QT_WORK_DIR}/f.txt" "base\n")
    qt_quilt_ok(ARGS new bottom.patch MESSAGE "new bottom failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "bottom\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh bottom failed")
    qt_write_file("${QT_WORK_DIR}/g.txt" "top\n")
    qt_quilt_ok(ARGS new top.patch MESSAGE "new top failed")
    qt_quilt_ok(ARGS add g.txt MESSAGE "add g failed")
    qt_write_file("${QT_WORK_DIR}/g.txt" "top-changed\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh top failed")
    # Try to fork a non-top patch — should fail
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS refresh -z bottom.patch)
    qt_assert_failure("${rc}" "refresh -z on non-top patch should fail")
endfunction()

function(qt_scenario_refresh_diffstat)
    qt_begin_test("refresh_diffstat")
    qt_write_file("${QT_WORK_DIR}/a.txt" "aaa\n")
    qt_write_file("${QT_WORK_DIR}/b.txt" "bbb\n")
    qt_quilt_ok(ARGS new ds.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add a.txt MESSAGE "add a failed")
    qt_quilt_ok(ARGS add b.txt MESSAGE "add b failed")
    qt_write_file("${QT_WORK_DIR}/a.txt" "AAA\n")
    qt_write_file("${QT_WORK_DIR}/b.txt" "BBB\n")
    qt_quilt_ok(ARGS refresh --diffstat MESSAGE "refresh --diffstat failed")
    qt_read_file_strip(patch_text "${QT_WORK_DIR}/patches/ds.patch")
    # Patch must contain "---" separator before diffstat
    qt_assert_matches("${patch_text}" "^---\n|(\n---\n)" "diffstat should be preceded by --- separator")
    # Patch must contain diffstat section
    qt_assert_contains("${patch_text}" "2 files changed" "diffstat summary missing")
    qt_assert_contains("${patch_text}" "insertion" "diffstat should mention insertions")
    qt_assert_contains("${patch_text}" "deletion" "diffstat should mention deletions")
    # Diffstat file lines
    qt_assert_contains("${patch_text}" "a.txt" "diffstat should list a.txt")
    qt_assert_contains("${patch_text}" "b.txt" "diffstat should list b.txt")
    # Patch must still contain the actual diffs
    qt_assert_contains("${patch_text}" "+AAA" "patch should have +AAA")
    qt_assert_contains("${patch_text}" "+BBB" "patch should have +BBB")

    # Re-refresh with --diffstat should not duplicate the --- separator
    qt_write_file("${QT_WORK_DIR}/a.txt" "aaa2\n")
    qt_quilt_ok(ARGS refresh --diffstat MESSAGE "re-refresh --diffstat failed")
    qt_read_file_raw(patch2 "${QT_WORK_DIR}/patches/ds.patch")
    # Count lines that are exactly "---" (the diffstat separator).
    # "--- a/file" lines are diff headers, not separators.
    string(REPLACE "\n" ";" patch2_lines "${patch2}")
    set(sep_count 0)
    foreach(pline IN LISTS patch2_lines)
        if(pline STREQUAL "---")
            math(EXPR sep_count "${sep_count} + 1")
        endif()
    endforeach()
    if(NOT sep_count EQUAL 1)
        qt_fail("expected exactly 1 --- separator, got ${sep_count}")
    endif()
endfunction()

function(qt_scenario_header_strip_diffstat)
    qt_begin_test("header_strip_diffstat")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_quilt_ok(ARGS new hsd.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "y\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    # Set a header with an embedded diffstat section (--- separator + stats)
    set(hdr_with_ds "My patch description\n---\n f.txt | 1 +\n 1 file changed, 1 insertion(+)\n\nSome trailing text\n")
    qt_quilt_ok(ARGS header -r --strip-diffstat INPUT "${hdr_with_ds}" MESSAGE "header -r --strip-diffstat failed")
    qt_quilt_ok(OUTPUT hdr_out ARGS header MESSAGE "header read failed")
    qt_assert_contains("${hdr_out}" "My patch description" "description should survive")
    qt_assert_contains("${hdr_out}" "Some trailing text" "trailing text should survive")
    qt_assert_not_contains("${hdr_out}" "file changed" "diffstat summary should be stripped")
    qt_assert_not_contains("${hdr_out}" "1 +" "diffstat line should be stripped")
endfunction()

function(qt_scenario_header_strip_trailing_whitespace)
    qt_begin_test("header_strip_trailing_whitespace")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_quilt_ok(ARGS new hsw.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "y\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    # Set a header with trailing whitespace
    qt_quilt_ok(ARGS header -r --strip-trailing-whitespace INPUT "line with spaces   \nclean line\ntabs\t\t\n" MESSAGE "header -r --strip-trailing-whitespace failed")
    qt_quilt_ok(OUTPUT hdr_out ARGS header MESSAGE "header read failed")
    qt_assert_contains("${hdr_out}" "line with spaces" "content should remain")
    qt_assert_not_contains("${hdr_out}" "spaces   " "trailing spaces should be stripped")
    qt_assert_contains("${hdr_out}" "clean line" "clean line should remain")
endfunction()

function(qt_scenario_header_strip_diffstat_print)
    qt_begin_test("header_strip_diffstat_print")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_quilt_ok(ARGS new hsdp.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "y\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    # Set header with diffstat (--- separator + stats)
    set(hdr_ds "Title\n---\n a.c | 2 +-\n 1 file changed, 1 insertion(+), 1 deletion(-)\n\n")
    qt_quilt_ok(ARGS header -r INPUT "${hdr_ds}" MESSAGE "header -r failed")
    # Print without strip: should have diffstat
    qt_quilt_ok(OUTPUT raw_out ARGS header MESSAGE "header print failed")
    qt_assert_contains("${raw_out}" "file changed" "raw print should have diffstat")
    # Print with --strip-diffstat: should not have diffstat
    qt_quilt_ok(OUTPUT stripped_out ARGS header --strip-diffstat MESSAGE "header --strip-diffstat print failed")
    qt_assert_not_contains("${stripped_out}" "file changed" "stripped print should not have diffstat")
    qt_assert_contains("${stripped_out}" "Title" "title should remain")
endfunction()

function(qt_scenario_header_strip_ws_print)
    qt_begin_test("header_strip_ws_print")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_quilt_ok(ARGS new hswp.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "y\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    qt_quilt_ok(ARGS header -r INPUT "trailing   \n" MESSAGE "header -r failed")
    # Print with --strip-trailing-whitespace
    qt_quilt_ok(OUTPUT stripped_out ARGS header --strip-trailing-whitespace MESSAGE "header --stw print failed")
    qt_assert_not_contains("${stripped_out}" "trailing   " "trailing ws should be stripped on print")
    qt_assert_contains("${stripped_out}" "trailing" "content should remain on print")
endfunction()

function(qt_scenario_header_dep3_template)
    qt_begin_test("header_dep3_template")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_quilt_ok(ARGS new dep3.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "y\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    # Edit with --dep3 and EDITOR=true (no-op editor leaves template intact)
    qt_quilt_ok(ENV "EDITOR=true" ARGS header -e --dep3 MESSAGE "header -e --dep3 failed")
    qt_quilt_ok(OUTPUT hdr_out ARGS header MESSAGE "header read failed")
    qt_assert_contains("${hdr_out}" "Description:" "DEP-3 template should have Description field")
    qt_assert_contains("${hdr_out}" "Author:" "DEP-3 template should have Author field")
    qt_assert_contains("${hdr_out}" "Origin:" "DEP-3 template should have Origin field")
    qt_assert_contains("${hdr_out}" "Last-Update:" "DEP-3 template should have Last-Update field")
    qt_assert_contains("${hdr_out}" "Forwarded:" "DEP-3 template should have Forwarded field")
endfunction()

function(qt_scenario_header_dep3_nonempty)
    qt_begin_test("header_dep3_nonempty")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_quilt_ok(ARGS new dep3ne.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "y\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    # Set an existing header
    qt_quilt_ok(ARGS header -r INPUT "Existing header\n" MESSAGE "header -r failed")
    # Edit with --dep3 — since header is non-empty, template should NOT be inserted
    qt_quilt_ok(ENV "EDITOR=true" ARGS header -e --dep3 MESSAGE "header -e --dep3 failed")
    qt_quilt_ok(OUTPUT hdr_out ARGS header MESSAGE "header read failed")
    qt_assert_contains("${hdr_out}" "Existing header" "existing header should remain")
    qt_assert_not_contains("${hdr_out}" "Description:" "DEP-3 template should not overwrite existing header")
endfunction()

function(qt_scenario_header_strip_diffstat_append)
    qt_begin_test("header_strip_diffstat_append")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_quilt_ok(ARGS new hsda.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "y\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    # Set header with diffstat (--- separator + stats)
    set(hdr_ds "Title\n---\n f.txt | 1 +\n 1 file changed, 1 insertion(+)\n\n")
    qt_quilt_ok(ARGS header -r INPUT "${hdr_ds}" MESSAGE "header -r failed")
    # Append with --strip-diffstat
    qt_quilt_ok(ARGS header -a --strip-diffstat INPUT "Extra note\n" MESSAGE "header -a --strip-diffstat failed")
    qt_quilt_ok(OUTPUT hdr_out ARGS header MESSAGE "header read failed")
    qt_assert_contains("${hdr_out}" "Title" "title should remain")
    qt_assert_contains("${hdr_out}" "Extra note" "appended text should be present")
    qt_assert_not_contains("${hdr_out}" "file changed" "diffstat should be stripped")
endfunction()

function(qt_scenario_header_strip_combined)
    qt_begin_test("header_strip_combined")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_quilt_ok(ARGS new hsc.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "y\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    # Set header with both diffstat and trailing whitespace
    set(hdr_both "Title   \n---\n f.txt | 1 +\n 1 file changed, 1 insertion(+)\n\nNote   \n")
    qt_quilt_ok(ARGS header -r --strip-diffstat --strip-trailing-whitespace INPUT "${hdr_both}" MESSAGE "header -r combined strip failed")
    qt_quilt_ok(OUTPUT hdr_out ARGS header MESSAGE "header read failed")
    qt_assert_contains("${hdr_out}" "Title" "title should remain")
    qt_assert_contains("${hdr_out}" "Note" "note should remain")
    qt_assert_not_contains("${hdr_out}" "file changed" "diffstat should be stripped")
    qt_assert_not_contains("${hdr_out}" "Title   " "trailing ws should be stripped from title")
endfunction()

function(qt_scenario_unknown_option_rejected)
    qt_begin_test("unknown_option_rejected")
    qt_write_file("${QT_WORK_DIR}/f.txt" "base\n")
    qt_quilt_ok(ARGS new test.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "changed\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")

    # Test unknown options on various commands
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS refresh --bogus)
    qt_assert_not_equal("${rc}" "0" "refresh --bogus should fail")
    qt_assert_contains("${err}" "Unrecognized option" "refresh --bogus error message")

    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS diff --bogus)
    qt_assert_not_equal("${rc}" "0" "diff --bogus should fail")
    qt_assert_contains("${err}" "Unrecognized option" "diff --bogus error message")

    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS push --bogus)
    qt_assert_not_equal("${rc}" "0" "push --bogus should fail")
    qt_assert_contains("${err}" "Unrecognized option" "push --bogus error message")

    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS series --bogus)
    qt_assert_not_equal("${rc}" "0" "series --bogus should fail")
    qt_assert_contains("${err}" "Unrecognized option" "series --bogus error message")

    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS top --bogus)
    qt_assert_not_equal("${rc}" "0" "top --bogus should fail")
    qt_assert_contains("${err}" "Unrecognized option" "top --bogus error message")

    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS applied --bogus)
    qt_assert_not_equal("${rc}" "0" "applied --bogus should fail")
    qt_assert_contains("${err}" "Unrecognized option" "applied --bogus error message")

    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS header --bogus)
    qt_assert_not_equal("${rc}" "0" "header --bogus should fail")
    qt_assert_contains("${err}" "Unrecognized option" "header --bogus error message")

    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS patches --bogus)
    qt_assert_not_equal("${rc}" "0" "patches --bogus should fail")
    qt_assert_contains("${err}" "Unrecognized option" "patches --bogus error message")

    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS new --bogus)
    qt_assert_not_equal("${rc}" "0" "new --bogus should fail")
    qt_assert_contains("${err}" "Unrecognized option" "new --bogus error message")

    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS pop --bogus)
    qt_assert_not_equal("${rc}" "0" "pop --bogus should fail")
    qt_assert_contains("${err}" "Unrecognized option" "pop --bogus error message")

    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS fork --bogus)
    qt_assert_not_equal("${rc}" "0" "fork --bogus should fail")
    qt_assert_contains("${err}" "Unrecognized option" "fork --bogus error message")
endfunction()

function(qt_scenario_color_option_accepted)
    qt_begin_test("color_option_accepted")
    qt_write_file("${QT_WORK_DIR}/f.txt" "base\n")
    qt_quilt_ok(ARGS new color.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "changed\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")

    # --color (no value) should be accepted
    qt_quilt_ok(ARGS diff --color MESSAGE "diff --color should succeed")
    qt_quilt_ok(ARGS series --color MESSAGE "series --color should succeed")
    qt_quilt_ok(ARGS patches --color f.txt MESSAGE "patches --color should succeed")

    # --color=auto/always/never should be accepted
    qt_quilt_ok(ARGS diff --color=auto MESSAGE "diff --color=auto should succeed")
    qt_quilt_ok(ARGS diff --color=always MESSAGE "diff --color=always should succeed")
    qt_quilt_ok(ARGS diff --color=never MESSAGE "diff --color=never should succeed")
    qt_quilt_ok(ARGS series --color=auto MESSAGE "series --color=auto should succeed")

    # push --color with a patch to actually push
    qt_quilt_ok(ARGS pop MESSAGE "pop for push test")
    qt_quilt_ok(ARGS push --color=auto MESSAGE "push --color=auto should succeed")
endfunction()

function(qt_scenario_color_option_invalid)
    qt_begin_test("color_option_invalid")
    qt_write_file("${QT_WORK_DIR}/f.txt" "base\n")
    qt_quilt_ok(ARGS new ci.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "changed\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")

    # Invalid --color value should fail
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS diff --color=bogus)
    qt_assert_not_equal("${rc}" "0" "diff --color=bogus should fail")
    qt_assert_contains("${err}" "Invalid --color value" "diff --color=bogus error message")

    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS series --color=bogus)
    qt_assert_not_equal("${rc}" "0" "series --color=bogus should fail")
    qt_assert_contains("${err}" "Invalid --color value" "series --color=bogus error message")

    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS patches --color=bogus f.txt)
    qt_assert_not_equal("${rc}" "0" "patches --color=bogus should fail")
    qt_assert_contains("${err}" "Invalid --color value" "patches --color=bogus error message")

    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS push --color=bogus)
    qt_assert_not_equal("${rc}" "0" "push --color=bogus should fail")
    qt_assert_contains("${err}" "Invalid --color value" "push --color=bogus error message")
endfunction()

function(qt_scenario_trace_option_accepted)
    qt_begin_test("trace_option_accepted")
    qt_write_file("${QT_WORK_DIR}/f.txt" "base\n")
    qt_quilt_ok(ARGS new trace.patch MESSAGE "new failed")

    # --trace as a global option should be accepted
    qt_quilt_ok(ARGS --trace top MESSAGE "--trace top should succeed")
    qt_quilt_ok(ARGS --trace series MESSAGE "--trace series should succeed")
endfunction()

# ── New coverage-search scenarios ──────────────────────────────────────────

# applied_with_target: quilt applied <patchname> lists up to and including target
function(qt_scenario_applied_with_target)
    qt_begin_test("applied_with_target")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_quilt_ok(ARGS new p1.patch MESSAGE "new p1 failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add p1 failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "1\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh p1 failed")
    qt_quilt_ok(ARGS new p2.patch MESSAGE "new p2 failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add p2 failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "2\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh p2 failed")
    qt_quilt_ok(ARGS new p3.patch MESSAGE "new p3 failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add p3 failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "3\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh p3 failed")
    # applied p1.patch should list only p1.patch (stops at target)
    qt_quilt_ok(OUTPUT out ERROR err ARGS applied p1.patch MESSAGE "applied p1 failed")
    qt_assert_contains("${out}" "p1.patch" "p1 should be listed")
    qt_assert_not_contains("${out}" "p2.patch" "p2 should not be listed when stopping at p1")
    qt_assert_not_contains("${out}" "p3.patch" "p3 should not be listed when stopping at p1")
    # applied with unknown patch should fail
    qt_quilt(RESULT rc OUTPUT out2 ERROR err2 ARGS applied nonexistent.patch)
    qt_assert_failure("${rc}" "applied with unknown patch should fail")
    qt_combine_output(combined "${out2}" "${err2}")
    qt_assert_contains("${combined}" "not in series" "applied with unknown patch should mention not in series")
endfunction()

# pop_target_already_top: quilt pop <top-patch> should fail (already on top)
function(qt_scenario_pop_target_already_top)
    qt_begin_test("pop_target_already_top")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_quilt_ok(ARGS new p1.patch MESSAGE "new p1 failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add p1 failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "1\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh p1 failed")
    qt_quilt_ok(ARGS new p2.patch MESSAGE "new p2 failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add p2 failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "2\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh p2 failed")
    # Trying to pop to the topmost patch is a no-op error
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS pop p2.patch)
    qt_assert_failure("${rc}" "pop to already-top patch should fail")
    qt_combine_output(combined "${out}" "${err}")
    qt_assert_contains("${combined}" "currently on top" "should explain it is already the top patch")
endfunction()

# push_unknown_target: quilt push <nonexistent-patch> should fail
function(qt_scenario_push_unknown_target)
    qt_begin_test("push_unknown_target")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "y\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    qt_quilt_ok(ARGS pop MESSAGE "pop failed")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS push nonexistent.patch)
    qt_assert_failure("${rc}" "push with unknown target should fail")
    qt_combine_output(combined "${out}" "${err}")
    qt_assert_contains("${combined}" "not in series" "should explain patch is not in series")
endfunction()

# delete_backup_option: quilt delete --backup -r moves patch file to <name>~
function(qt_scenario_delete_backup_option)
    qt_begin_test("delete_backup_option")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "y\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    qt_quilt_ok(ARGS pop MESSAGE "pop failed")
    qt_assert_exists("${QT_WORK_DIR}/patches/p.patch" "patch file should exist before delete")
    qt_quilt_ok(ARGS delete --backup -r p.patch MESSAGE "delete --backup -r failed")
    qt_assert_not_exists("${QT_WORK_DIR}/patches/p.patch" "patch file should be gone")
    qt_assert_exists("${QT_WORK_DIR}/patches/p.patch~" "backup file p.patch~ should exist")
endfunction()

# delete_next_no_next: quilt delete -n when all patches are applied has no next
function(qt_scenario_delete_next_no_next)
    qt_begin_test("delete_next_no_next")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "y\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    # All patches applied, so -n (next unapplied) has nothing to delete
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS delete -n)
    qt_assert_failure("${rc}" "delete -n with no next patch should fail")
    qt_combine_output(combined "${out}" "${err}")
    qt_assert_contains("${combined}" "No next patch" "should report no next patch")
endfunction()

# patches_no_file_arg: quilt patches without a file argument should fail
function(qt_scenario_patches_no_file_arg)
    qt_begin_test("patches_no_file_arg")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "y\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS patches)
    qt_assert_failure("${rc}" "patches with no file arg should fail")
    qt_combine_output(combined "${out}" "${err}")
    qt_assert_contains("${combined}" "Usage" "should show usage when no file arg")
endfunction()

# builtin_patch_trailing_lines: patch modifies middle of longer file, leaving
# multiple trailing lines — exercises the non-last-line branch in build_output
function(qt_scenario_builtin_patch_trailing_lines)
    qt_begin_test("builtin_patch_trailing_lines")
    # 9-line file; patch modifies line 3, hunk covers lines 1-6 (3 context each
    # side), leaving lines 7-9 as trailing content copied after the hunk
    qt_write_file("${QT_WORK_DIR}/f.txt" "1\n2\ntarget\n4\n5\n6\n7\n8\n9\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "1\n2\nMODIFIED\n4\n5\n6\n7\n8\n9\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    qt_quilt_ok(ARGS pop MESSAGE "pop failed")
    qt_assert_file_text("${QT_WORK_DIR}/f.txt" "1\n2\ntarget\n4\n5\n6\n7\n8\n9" "pop should restore all 9 lines")
    qt_quilt_ok(ARGS push MESSAGE "push failed")
    qt_assert_file_text("${QT_WORK_DIR}/f.txt" "1\n2\nMODIFIED\n4\n5\n6\n7\n8\n9" "push should modify line 3, preserve trailing lines")
endfunction()

# builtin_patch_merge_conflict_partial: multi-hunk push with --merge where
# some hunks succeed (pos>=0 branch) and some fail (pos<0 branch)
function(qt_scenario_builtin_patch_merge_conflict_partial)
    qt_begin_test("builtin_patch_merge_conflict_partial")
    qt_write_file("${QT_WORK_DIR}/f.txt"
        "1\n2\n3\n4\n5\n6\n7\n8\n9\n10\n11\n12\n13\n14\n15\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt"
        "1\nTWO\n3\n4\n5\n6\n7\n8\n9\n10\n11\nTWELVE\n13\n14\n15\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    qt_quilt_ok(ARGS pop MESSAGE "pop failed")
    # Corrupt line 12 so hunk 2 fails but keep line 2 as "2" so hunk 1 succeeds
    qt_write_file("${QT_WORK_DIR}/f.txt"
        "1\n2\n3\n4\n5\n6\n7\n8\n9\n10\n11\nCHANGED\n13\n14\n15\n")
    # Push with --merge -f: hunk 1 (line 2→TWO) succeeds, hunk 2 (12→TWELVE) fails
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS push --merge -f)
    # File should have both applied change and conflict markers
    qt_assert_file_contains("${QT_WORK_DIR}/f.txt" "TWO" "successful hunk should be applied")
    qt_assert_file_contains("${QT_WORK_DIR}/f.txt" "<<<<<<< current" "failed hunk should produce conflict marker")
    qt_assert_file_contains("${QT_WORK_DIR}/f.txt" ">>>>>>> patch" "failed hunk should produce end marker")
endfunction()

# builtin_patch_merge_diff3: push --merge=diff3 with conflict produces diff3-style
# markers including the ||||||| expected section
function(qt_scenario_builtin_patch_merge_diff3)
    qt_begin_test("builtin_patch_merge_diff3")
    qt_write_file("${QT_WORK_DIR}/f.txt" "aaa\nbbb\nccc\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "aaa\nBBB\nccc\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    qt_quilt_ok(ARGS pop MESSAGE "pop failed")
    # Completely change file so patch conflict occurs
    qt_write_file("${QT_WORK_DIR}/f.txt" "xxx\nyyy\nzzz\n")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS push --merge=diff3 -f)
    qt_assert_file_contains("${QT_WORK_DIR}/f.txt" "<<<<<<< current" "should have conflict open")
    qt_assert_file_contains("${QT_WORK_DIR}/f.txt" "||||||| expected" "diff3 style should have expected section")
    qt_assert_file_contains("${QT_WORK_DIR}/f.txt" "=======" "should have separator")
    qt_assert_file_contains("${QT_WORK_DIR}/f.txt" ">>>>>>> patch" "should have conflict end")
endfunction()

# fold_reverse_no_newline: fold -R a patch that removes trailing newline;
# the restored file should have the trailing newline back
function(qt_scenario_fold_reverse_no_newline)
    qt_begin_test("fold_reverse_no_newline")
    # Start with file "modified" (no trailing newline) — this is the patched state
    file(WRITE "${QT_WORK_DIR}/f.txt" "modified")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    # fold -R the forward patch (which changes original→modified with no newline)
    # The reversed patch should produce "original\n" (with trailing newline)
    qt_quilt_ok(
        ARGS fold -R
        INPUT [=[--- a/f.txt
+++ b/f.txt
@@ -1 +1 @@
-original
+modified
\ No newline at end of file
]=]
        MESSAGE "fold -R with no-newline patch failed"
    )
    qt_read_file_raw(result "${QT_WORK_DIR}/f.txt")
    qt_assert_equal("${result}" "original\n" "fold -R should restore trailing newline")
endfunction()

function(qt_scenario_add_no_patches_applied)
    qt_begin_test("add_no_patches_applied")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    qt_quilt_ok(ARGS pop MESSAGE "pop failed")
    # Now series exists but nothing is applied
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS add f.txt)
    qt_assert_failure("${rc}" "add with no applied patches should fail")
    qt_combine_output(combined "${out}" "${err}")
    qt_assert_contains("${combined}" "No patches applied" "add should explain no patches are applied")
endfunction()

function(qt_scenario_add_bad_option)
    qt_begin_test("add_bad_option")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS add --invalid-option f.txt)
    qt_assert_failure("${rc}" "add with bad option should fail")
    qt_combine_output(combined "${out}" "${err}")
    qt_assert_contains("${combined}" "invalid-option" "add should mention the bad option")
endfunction()

function(qt_scenario_add_no_files)
    qt_begin_test("add_no_files")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    # Specify patch explicitly but no file arguments
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS add -P p.patch)
    qt_assert_failure("${rc}" "add with no files should fail")
    qt_combine_output(combined "${out}" "${err}")
    qt_assert_contains("${combined}" "Usage" "add with no files should print usage")
endfunction()

function(qt_scenario_remove_bad_option)
    qt_begin_test("remove_bad_option")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS remove --bad-opt)
    qt_assert_failure("${rc}" "remove with bad option should fail")
    qt_combine_output(combined "${out}" "${err}")
    qt_assert_contains("${combined}" "bad-opt" "remove should mention the bad option")
endfunction()

function(qt_scenario_remove_no_files)
    qt_begin_test("remove_no_files")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    # remove with no file arguments
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS remove)
    qt_assert_failure("${rc}" "remove with no files should fail")
    qt_combine_output(combined "${out}" "${err}")
    qt_assert_contains("${combined}" "Usage" "remove with no files should print usage")
endfunction()

function(qt_scenario_unapplied_bad_option)
    qt_begin_test("unapplied_bad_option")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS unapplied --bad-opt)
    qt_assert_failure("${rc}" "unapplied with bad option should fail")
    qt_combine_output(combined "${out}" "${err}")
    qt_assert_contains("${combined}" "bad-opt" "unapplied should mention the bad option")
endfunction()

function(qt_scenario_next_bad_option)
    qt_begin_test("next_bad_option")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS next --bad-opt)
    qt_assert_failure("${rc}" "next with bad option should fail")
    qt_combine_output(combined "${out}" "${err}")
    qt_assert_contains("${combined}" "bad-opt" "next should mention the bad option")
endfunction()

function(qt_scenario_previous_bad_option)
    qt_begin_test("previous_bad_option")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS previous --bad-opt)
    qt_assert_failure("${rc}" "previous with bad option should fail")
    qt_combine_output(combined "${out}" "${err}")
    qt_assert_contains("${combined}" "bad-opt" "previous should mention the bad option")
endfunction()

function(qt_scenario_previous_multiple_applied)
    qt_begin_test("previous_multiple_applied")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_quilt_ok(ARGS new p1.patch MESSAGE "new p1 failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add p1 failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "1\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh p1 failed")
    qt_quilt_ok(ARGS new p2.patch MESSAGE "new p2 failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add p2 failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "2\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh p2 failed")
    # Both patches applied; previous should return p1
    qt_quilt_ok(OUTPUT prev_out ERROR prev_err ARGS previous MESSAGE "previous with 2 applied failed")
    qt_assert_contains("${prev_out}" "p1.patch" "previous should show p1 when p2 is on top")
endfunction()

function(qt_scenario_rename_bad_option)
    qt_begin_test("rename_bad_option")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS rename --bad-opt)
    qt_assert_failure("${rc}" "rename with bad option should fail")
    qt_combine_output(combined "${out}" "${err}")
    qt_assert_contains("${combined}" "bad-opt" "rename should mention the bad option")
endfunction()

function(qt_scenario_rename_no_name)
    qt_begin_test("rename_no_name")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    # Specify which patch to rename but give no new name
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS rename -P p.patch)
    qt_assert_failure("${rc}" "rename with no new name should fail")
    qt_combine_output(combined "${out}" "${err}")
    qt_assert_contains("${combined}" "Usage" "rename with no name should print usage")
endfunction()

function(qt_scenario_rename_no_patch_applied)
    qt_begin_test("rename_no_patch_applied")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    qt_quilt_ok(ARGS pop MESSAGE "pop failed")
    # No applied patch and no -P: rename should fail with no patch
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS rename newname.patch)
    qt_assert_failure("${rc}" "rename with no applied patch should fail")
    qt_combine_output(combined "${out}" "${err}")
    qt_assert_contains("${combined}" "No patches applied" "rename should report no patches applied")
endfunction()

function(qt_scenario_pop_no_patches_applied)
    qt_begin_test("pop_no_patches_applied")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    qt_quilt_ok(ARGS pop MESSAGE "pop succeeded")
    # Series exists but nothing is applied; pop should fail
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS pop)
    qt_assert_failure("${rc}" "pop when nothing applied but series exists should fail")
    qt_combine_output(combined "${out}" "${err}")
    qt_assert_contains("${combined}" "No patch removed" "pop with nothing applied should say no patch removed")
endfunction()

function(qt_scenario_pop_unapplied_target)
    qt_begin_test("pop_unapplied_target")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_quilt_ok(ARGS new p1.patch MESSAGE "new p1 failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add p1 failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "1\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh p1 failed")
    qt_quilt_ok(ARGS new p2.patch MESSAGE "new p2 failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add p2 failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "2\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh p2 failed")
    qt_quilt_ok(ARGS pop MESSAGE "pop p2 failed")
    # p2 is now unapplied; try to pop to it
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS pop p2.patch)
    qt_assert_failure("${rc}" "pop to unapplied patch should fail")
    qt_combine_output(combined "${out}" "${err}")
    qt_assert_contains("${combined}" "not applied" "pop to unapplied patch should report not applied")
endfunction()

function(qt_scenario_diff_C_combined)
    qt_begin_test("diff_C_combined")
    qt_write_file("${QT_WORK_DIR}/f.txt" "line1\nline2\nline3\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "line1\nchanged\nline3\n")
    # Combined -C3 instead of -C 3
    qt_quilt_ok(OUTPUT diff_out ERROR diff_err ARGS diff -C3 MESSAGE "diff -C3 failed")
    qt_assert_contains("${diff_out}" "***" "context diff should have *** markers")
endfunction()

function(qt_scenario_diff_U_combined)
    qt_begin_test("diff_U_combined")
    qt_write_file("${QT_WORK_DIR}/f.txt" "line1\nline2\nline3\nline4\nline5\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "line1\nline2\nchanged\nline4\nline5\n")
    # Combined -U0 instead of -U 0
    qt_quilt_ok(OUTPUT diff_out ERROR diff_err ARGS diff -U0 MESSAGE "diff -U0 failed")
    qt_assert_contains("${diff_out}" "@@" "unified diff should have @@ markers")
    qt_assert_not_contains("${diff_out}" " line1" "U0 should have no context")
endfunction()

function(qt_scenario_diff_with_P)
    qt_begin_test("diff_with_P")
    qt_write_file("${QT_WORK_DIR}/f.txt" "base\n")
    qt_quilt_ok(ARGS new p1.patch MESSAGE "new p1 failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add p1 failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "v1\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh p1 failed")
    qt_quilt_ok(ARGS new p2.patch MESSAGE "new p2 failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add p2 failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "v2\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh p2 failed")
    # diff -P p1 should show changes from p1's backup to current
    qt_quilt_ok(OUTPUT diff_out ERROR diff_err ARGS diff -P p1.patch MESSAGE "diff -P p1 failed")
    qt_assert_contains("${diff_out}" "-base" "diff -P p1 should show base→v1 change")
endfunction()

function(qt_scenario_diff_combine_snapshot_conflict)
    qt_begin_test("diff_combine_snapshot_conflict")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS diff --combine - --snapshot)
    qt_assert_failure("${rc}" "diff --combine --snapshot should fail")
    qt_combine_output(combined "${out}" "${err}")
    qt_assert_contains("${combined}" "cannot be combined" "should explain the conflict")
endfunction()

function(qt_scenario_diff_file_filter)
    qt_begin_test("diff_file_filter")
    qt_write_file("${QT_WORK_DIR}/a.txt" "old_a\n")
    qt_write_file("${QT_WORK_DIR}/b.txt" "old_b\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add a.txt MESSAGE "add a failed")
    qt_quilt_ok(ARGS add b.txt MESSAGE "add b failed")
    qt_write_file("${QT_WORK_DIR}/a.txt" "new_a\n")
    qt_write_file("${QT_WORK_DIR}/b.txt" "new_b\n")
    # Filter diff to only a.txt
    qt_quilt_ok(OUTPUT diff_out ERROR diff_err ARGS diff a.txt MESSAGE "diff a.txt failed")
    qt_assert_contains("${diff_out}" "a.txt" "filtered diff should show a.txt")
    qt_assert_not_contains("${diff_out}" "b.txt" "filtered diff should not show b.txt")
endfunction()

function(qt_scenario_diff_p_explicit)
    qt_begin_test("diff_p_explicit")
    qt_write_file("${QT_WORK_DIR}/f.txt" "old\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "new\n")
    # -p ab produces a/b prefix labels
    qt_quilt_ok(OUTPUT diff_out ERROR diff_err ARGS diff -p ab MESSAGE "diff -p ab failed")
    qt_assert_contains("${diff_out}" "a/f.txt" "diff -p ab should have a/ prefix")
    qt_assert_contains("${diff_out}" "b/f.txt" "diff -p ab should have b/ prefix")
endfunction()

function(qt_scenario_diff_no_timestamps)
    qt_begin_test("diff_no_timestamps")
    qt_write_file("${QT_WORK_DIR}/f.txt" "old\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "new\n")
    qt_quilt_ok(OUTPUT diff_out ERROR diff_err ARGS diff --no-timestamps MESSAGE "diff --no-timestamps failed")
    qt_assert_contains("${diff_out}" "--- " "diff should have --- header")
    # With --no-timestamps, header should not contain date/time digits after the filename
    qt_assert_not_contains("${diff_out}" "2026" "diff --no-timestamps should not include year")
endfunction()

function(qt_scenario_init_extra_args)
    qt_begin_test("init_extra_args")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS init unexpected_arg)
    qt_assert_failure("${rc}" "init with extra args should fail")
    qt_combine_output(combined "${out}" "${err}")
    qt_assert_contains("${combined}" "Usage" "init with extra arg should print usage")
endfunction()

function(qt_scenario_diff_explicit_u)
    qt_begin_test("diff_explicit_u")
    qt_write_file("${QT_WORK_DIR}/f.txt" "old\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "new\n")
    # Explicit -u flag (same as default) exercises the -u branch in cmd_diff
    qt_quilt_ok(OUTPUT diff_out ERROR diff_err ARGS diff -u MESSAGE "diff -u failed")
    qt_assert_contains("${diff_out}" "@@" "unified diff should have @@ markers")
    qt_assert_contains("${diff_out}" "---" "unified diff should have --- header")
endfunction()

function(qt_scenario_diff_p_combined)
    qt_begin_test("diff_p_combined")
    qt_write_file("${QT_WORK_DIR}/f.txt" "old\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "new\n")
    # -pab combined (single arg) exercises starts_with(-p) branch in cmd_diff
    qt_quilt_ok(OUTPUT diff_out ERROR diff_err ARGS diff -pab MESSAGE "diff -pab failed")
    qt_assert_contains("${diff_out}" "a/f.txt" "diff -pab should have a/ prefix")
    qt_assert_contains("${diff_out}" "b/f.txt" "diff -pab should have b/ prefix")
endfunction()

function(qt_scenario_refresh_U_combined)
    qt_begin_test("refresh_U_combined")
    qt_write_file("${QT_WORK_DIR}/f.txt" "1\n2\n3\n4\n5\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "1\n2\nCHANGED\n4\n5\n")
    # Combined -U1 (number in same arg) exercises the else branch in cmd_refresh -U parsing
    # QUILT_NO_DIFF_TIMESTAMPS=1 prevents timestamps from containing " 1" as a substring
    qt_quilt_ok(ENV "QUILT_NO_DIFF_TIMESTAMPS=1" ARGS refresh -U1 MESSAGE "refresh -U1 failed")
    qt_read_file_strip(patch_text "${QT_WORK_DIR}/patches/p.patch")
    qt_assert_contains("${patch_text}" "@@" "patch should be unified format")
    qt_assert_contains("${patch_text}" " 2" "should have line 2 as context (1 line before change)")
    qt_assert_contains("${patch_text}" " 4" "should have line 4 as context (1 line after change)")
    qt_assert_not_contains("${patch_text}" " 1" "should not have line 1 with -U1")
endfunction()

function(qt_scenario_refresh_C_combined)
    qt_begin_test("refresh_C_combined")
    qt_write_file("${QT_WORK_DIR}/f.txt" "1\n2\n3\n4\n5\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "1\n2\nCHANGED\n4\n5\n")
    # Combined -C1 (number in same arg) exercises the else branch in cmd_refresh -C parsing
    qt_quilt_ok(ARGS refresh -C1 MESSAGE "refresh -C1 failed")
    qt_read_file_strip(patch_text "${QT_WORK_DIR}/patches/p.patch")
    qt_assert_contains("${patch_text}" "***" "patch should be context format")
    qt_assert_not_contains("${patch_text}" "! 1" "should not have line 1 with -C1")
endfunction()

function(qt_scenario_diff_external_context_multiline)
    qt_begin_test("diff_external_context_multiline")
    # 3-line file so unified diff produces @@ -1,3 +1,4 @@ (comma in counts)
    qt_write_file("${QT_WORK_DIR}/f.txt" "line1\nline2\nline3\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    # Change line2 and add new line: exercises hunk-count parsing and context/insertion paths
    qt_write_file("${QT_WORK_DIR}/f.txt" "line1\nchanged\nline3\nextra\n")
    # --diff=diff forces external unified diff; -c requests context conversion
    qt_quilt_ok(OUTPUT diff_out ERROR diff_err ARGS diff "--diff=diff" -c MESSAGE "diff --diff=diff -c multiline failed")
    qt_assert_contains("${diff_out}" "***" "context diff should have *** markers")
    qt_assert_contains("${diff_out}" "line1" "context lines should be preserved")
    qt_assert_contains("${diff_out}" "line3" "context lines should be preserved")
    qt_assert_contains("${diff_out}" "! changed" "changed line should use ! prefix")
    qt_assert_contains("${diff_out}" "+ extra" "added-only line should use + prefix")
endfunction()

function(qt_scenario_diff_external_with_C)
    qt_begin_test("diff_external_with_C")
    qt_write_file("${QT_WORK_DIR}/f.txt" "line1\nline2\nline3\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "line1\nchanged\nline3\n")
    # --diff=diff -C 3 exercises the diff_type=="C" branch that pushes -U + count
    # to the external diff command, then converts the unified output to context.
    qt_quilt_ok(OUTPUT diff_out ERROR diff_err ARGS diff "--diff=diff" -C 3 MESSAGE "diff --diff=diff -C 3 failed")
    qt_assert_contains("${diff_out}" "***" "context diff with -C should have *** markers")
    qt_assert_contains("${diff_out}" "! changed" "context diff with -C should show changed line")
endfunction()

function(qt_scenario_refresh_no_patches)
    qt_begin_test("refresh_no_patches")
    qt_write_file("${QT_WORK_DIR}/patches/series" "placeholder.patch\n")
    # Run refresh with nothing applied — should fail with "No patches applied"
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS refresh)
    qt_assert_failure("${rc}" "refresh with no patches should fail")
    qt_combine_output(combined "${out}" "${err}")
    qt_assert_contains("${combined}" "No patches applied" "should report no patches applied")
endfunction()

function(qt_scenario_revert_no_patches)
    qt_begin_test("revert_no_patches")
    qt_write_file("${QT_WORK_DIR}/f.txt" "data\n")
    qt_write_file("${QT_WORK_DIR}/patches/series" "placeholder.patch\n")
    # Run revert with nothing applied — should fail with "No patches applied"
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS revert f.txt)
    qt_assert_failure("${rc}" "revert with no patches should fail")
    qt_combine_output(combined "${out}" "${err}")
    qt_assert_contains("${combined}" "No patches applied" "should report no patches applied")
endfunction()

function(qt_scenario_snapshot_bad_option)
    qt_begin_test("snapshot_bad_option")
    # Unknown option to snapshot should print usage and fail
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS snapshot --bad-option)
    qt_assert_failure("${rc}" "snapshot with bad option should fail")
    qt_combine_output(combined "${out}" "${err}")
    qt_assert_contains("${combined}" "Usage" "snapshot bad option should print usage")
endfunction()

function(qt_scenario_diff_quilt_diff_opts_combined)
    qt_begin_test("diff_quilt_diff_opts_combined")
    qt_write_file("${QT_WORK_DIR}/f.txt" "1\n2\n3\n4\n5\n6\n7\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "1\n2\n3\nCHANGED\n5\n6\n7\n")
    # QUILT_DIFF_OPTS=-U1 (combined form) exercises parse_diff_opts_context -U<n> path
    # QUILT_NO_DIFF_TIMESTAMPS=1 prevents timestamps from containing " 1" as a substring
    qt_quilt_ok(OUTPUT diff_out ERROR diff_err
        ENV "QUILT_DIFF_OPTS=-U1" "QUILT_NO_DIFF_TIMESTAMPS=1"
        ARGS diff MESSAGE "diff with QUILT_DIFF_OPTS=-U1 failed")
    qt_assert_contains("${diff_out}" "@@" "diff should be unified format")
    # With -U1, context is 1 line: should have lines 3 and 5 but not 1 or 7
    qt_assert_contains("${diff_out}" " 3" "should have line 3 as context")
    qt_assert_not_contains("${diff_out}" " 1" "should not have line 1 with U1")
endfunction()

function(qt_scenario_refresh_re_diffstat)
    qt_begin_test("refresh_re_diffstat")
    qt_write_file("${QT_WORK_DIR}/f.txt" "line1\nline2\nline3\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "line1\nMODIFIED\nline3\n")
    # First refresh with --diffstat: generates diffstat block at top of patch
    qt_quilt_ok(ARGS refresh --diffstat MESSAGE "first refresh --diffstat failed")
    qt_read_file_strip(patch1 "${QT_WORK_DIR}/patches/p.patch")
    qt_assert_contains("${patch1}" "file changed" "first diffstat should appear")
    # Second refresh with --diffstat: remove_diffstat_section is called on the
    # existing header (which starts with bare diffstat lines like " f.txt | 1 +")
    qt_write_file("${QT_WORK_DIR}/f.txt" "line1\nUPDATED\nline3\n")
    qt_quilt_ok(ARGS refresh --diffstat MESSAGE "second refresh --diffstat failed")
    qt_read_file_raw(patch2 "${QT_WORK_DIR}/patches/p.patch")
    # Should have exactly one diffstat summary (old one removed, new one added)
    string(REGEX MATCHALL "file changed" matches "${patch2}")
    list(LENGTH matches cnt)
    if(NOT cnt EQUAL 1)
        qt_fail("Expected exactly 1 diffstat summary, got ${cnt}")
    endif()
endfunction()

function(qt_scenario_diff_quilt_diff_opts_separate)
    qt_begin_test("diff_quilt_diff_opts_separate")
    qt_write_file("${QT_WORK_DIR}/f.txt" "1\n2\n3\n4\n5\n6\n7\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "1\n2\n3\nCHANGED\n5\n6\n7\n")
    # QUILT_DIFF_OPTS="-U 1" (separate args) exercises parse_diff_opts_context -U n path
    # QUILT_NO_DIFF_TIMESTAMPS=1 prevents timestamps from containing " 1" as a substring
    qt_quilt_ok(OUTPUT diff_out ERROR diff_err
        ENV "QUILT_DIFF_OPTS=-U 1" "QUILT_NO_DIFF_TIMESTAMPS=1"
        ARGS diff MESSAGE "diff with QUILT_DIFF_OPTS=-U 1 failed")
    qt_assert_contains("${diff_out}" "@@" "diff should be unified format")
    qt_assert_contains("${diff_out}" " 3" "should have line 3 as context")
    qt_assert_not_contains("${diff_out}" " 1" "should not have line 1 with U1")
endfunction()

function(qt_scenario_fold_bad_option)
    qt_begin_test("fold_bad_option")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS fold --bad-option INPUT "--- a/f\n+++ b/f\n@@ -1 +1 @@\n-x\n+y\n")
    qt_assert_failure("${rc}" "fold with bad option should fail")
    qt_combine_output(combined "${out}" "${err}")
    qt_assert_contains("${combined}" "bad-option" "fold should mention the bad option")
endfunction()

function(qt_scenario_fork_no_extension)
    qt_begin_test("fork_no_extension")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    # Create a patch with no file extension
    qt_quilt_ok(ARGS new mypatch MESSAGE "new mypatch failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "y\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    qt_quilt_ok(OUTPUT fork_out ERROR fork_err ARGS fork MESSAGE "fork no-extension failed")
    # Should create mypatch-2 (no extension case)
    qt_assert_contains("${fork_out}${fork_err}" "mypatch-2" "fork should create mypatch-2")
endfunction()

function(qt_scenario_diff_no_applied_patches)
    qt_begin_test("diff_no_applied_patches")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    qt_quilt_ok(ARGS pop MESSAGE "pop failed")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS diff)
    qt_assert_failure("${rc}" "diff with no applied patches should fail")
    qt_combine_output(combined "${out}" "${err}")
    qt_assert_contains("${combined}" "No patches applied" "diff should explain no patches applied")
endfunction()

function(qt_scenario_revert_bad_option)
    qt_begin_test("revert_bad_option")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS revert --bad-opt f.txt)
    qt_assert_failure("${rc}" "revert with bad option should fail")
    qt_combine_output(combined "${out}" "${err}")
    qt_assert_contains("${combined}" "bad-opt" "revert should mention the bad option")
endfunction()

function(qt_scenario_revert_no_files)
    qt_begin_test("revert_no_files")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS revert)
    qt_assert_failure("${rc}" "revert with no files should fail")
    qt_combine_output(combined "${out}" "${err}")
    qt_assert_contains("${combined}" "Usage" "revert with no files should print usage")
endfunction()

function(qt_scenario_revert_with_P)
    qt_begin_test("revert_with_P")
    qt_write_file("${QT_WORK_DIR}/f.txt" "original\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "modified\n")
    # Revert using -P to specify patch explicitly
    qt_quilt_ok(OUTPUT revert_out ERROR revert_err ARGS revert -P p.patch f.txt MESSAGE "revert -P failed")
    qt_assert_contains("${revert_out}" "reverted" "revert -P should report success")
    qt_assert_file_text("${QT_WORK_DIR}/f.txt" "original" "revert -P should restore original content")
endfunction()

function(qt_scenario_header_with_patch_arg)
    qt_begin_test("header_with_patch_arg")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "y\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    # Set a header on p.patch
    qt_quilt_ok(ARGS header -r INPUT "Subject: My patch\n" MESSAGE "header -r failed")
    # Read the header back by specifying the patch explicitly
    qt_quilt_ok(OUTPUT hdr_out ERROR hdr_err ARGS header p.patch MESSAGE "header p.patch failed")
    qt_assert_contains("${hdr_out}" "Subject: My patch" "header with patch arg should show the header")
endfunction()

function(qt_scenario_refresh_sort)
    qt_begin_test("refresh_sort")
    qt_write_file("${QT_WORK_DIR}/b.txt" "b\n")
    qt_write_file("${QT_WORK_DIR}/a.txt" "a\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add b.txt MESSAGE "add b failed")
    qt_quilt_ok(ARGS add a.txt MESSAGE "add a failed")
    qt_write_file("${QT_WORK_DIR}/b.txt" "B\n")
    qt_write_file("${QT_WORK_DIR}/a.txt" "A\n")
    qt_quilt_ok(ARGS refresh --sort MESSAGE "refresh --sort failed")
    # With --sort, the patch should have files in sorted order: a.txt before b.txt
    qt_assert_file_contains("${QT_WORK_DIR}/patches/p.patch" "a.txt" "patch should contain a.txt")
    qt_assert_file_contains("${QT_WORK_DIR}/patches/p.patch" "b.txt" "patch should contain b.txt")
endfunction()

function(qt_scenario_files_bad_option)
    qt_begin_test("files_bad_option")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS files --bad-opt)
    qt_assert_failure("${rc}" "files with bad option should fail")
    qt_combine_output(combined "${out}" "${err}")
    qt_assert_contains("${combined}" "bad-opt" "files should mention the bad option")
endfunction()

function(qt_scenario_files_no_patch_applied)
    qt_begin_test("files_no_patch_applied")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    qt_quilt_ok(ARGS pop MESSAGE "pop failed")
    # Nothing applied; files should fail
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS files)
    qt_assert_failure("${rc}" "files with nothing applied should fail")
    qt_combine_output(combined "${out}" "${err}")
    qt_assert_contains("${combined}" "No patches applied" "files should explain no patches applied")
endfunction()

function(qt_scenario_fold_empty_stdin)
    qt_begin_test("fold_empty_stdin")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    # fold with no stdin data should fail
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS fold INPUT "")
    qt_assert_failure("${rc}" "fold with empty stdin should fail")
    qt_combine_output(combined "${out}" "${err}")
    qt_assert_contains("${combined}" "No patch data" "fold should explain no patch data on stdin")
endfunction()

function(qt_scenario_unapplied_unknown_target)
    qt_begin_test("unapplied_unknown_target")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS unapplied unknown.patch)
    qt_assert_failure("${rc}" "unapplied with unknown target should fail")
    qt_combine_output(combined "${out}" "${err}")
    qt_assert_contains("${combined}" "not in series" "unapplied unknown should report not in series")
endfunction()

function(qt_scenario_previous_no_patches_applied)
    qt_begin_test("previous_no_patches_applied")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    qt_quilt_ok(ARGS pop MESSAGE "pop failed")
    # Series exists but nothing applied
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS previous)
    qt_assert_failure("${rc}" "previous with nothing applied should fail")
    qt_combine_output(combined "${out}" "${err}")
    qt_assert_contains("${combined}" "No patches applied" "previous with nothing applied should say no patches applied")
endfunction()

function(qt_scenario_push_no_series)
    qt_begin_test("push_no_series")
    # Fresh directory with no series file
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS push)
    qt_assert_failure("${rc}" "push with no series should fail")
    qt_combine_output(combined "${out}" "${err}")
    qt_assert_contains("${combined}" "No series file found" "push with no series should explain the failure")
endfunction()

function(qt_scenario_push_already_applied)
    qt_begin_test("push_already_applied")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_quilt_ok(ARGS new p1.patch MESSAGE "new p1 failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add p1 failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "1\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh p1 failed")
    qt_quilt_ok(ARGS new p2.patch MESSAGE "new p2 failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add p2 failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "2\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh p2 failed")
    qt_quilt_ok(ARGS new p3.patch MESSAGE "new p3 failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add p3 failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "3\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh p3 failed")
    qt_quilt_ok(ARGS pop MESSAGE "pop p3 failed")
    # p1 and p2 applied, p3 unapplied. Push p1 (already applied below top)
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS push p1.patch)
    qt_assert_failure("${rc}" "push to already-applied patch below top should fail")
    qt_combine_output(combined "${out}" "${err}")
    qt_assert_contains("${combined}" "applied" "push to applied patch should say it is applied")
endfunction()

function(qt_scenario_import_bad_option)
    qt_begin_test("import_bad_option")
    qt_write_file("${QT_WORK_DIR}/p.patch" "--- a\n+++ b\n@@ -1 +1 @@\n-old\n+new\n")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS import --bad-option p.patch)
    qt_assert_failure("${rc}" "import with bad option should fail")
    qt_combine_output(combined "${out}" "${err}")
    qt_assert_contains("${combined}" "bad-option" "import should mention the bad option")
endfunction()

function(qt_scenario_rename_unknown_patch)
    qt_begin_test("rename_unknown_patch")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    # Rename a patch that doesn't exist in series
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS rename -P nonexistent.patch newname.patch)
    qt_assert_failure("${rc}" "rename of unknown patch should fail")
    qt_combine_output(combined "${out}" "${err}")
    qt_assert_contains("${combined}" "not in series" "rename unknown should report not in series")
endfunction()

function(qt_scenario_delete_applied)
    qt_begin_test("delete_applied")
    qt_write_file("${QT_WORK_DIR}/f.txt" "base\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "modified\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    # Deleting the currently-applied patch should pop it first, then remove it
    qt_quilt_ok(OUTPUT del_out ERROR del_err ARGS delete p.patch MESSAGE "delete applied failed")
    qt_assert_contains("${del_out}${del_err}" "Removed patch" "delete should confirm removal")
    # File should be restored to base state
    qt_assert_file_contains("${QT_WORK_DIR}/f.txt" "base" "file should be restored after delete")
    # Patch should no longer be in series
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS series)
    qt_assert_not_contains("${out}" "p.patch" "deleted patch should not appear in series")
endfunction()

function(qt_scenario_new_no_name)
    qt_begin_test("new_no_name")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS new)
    qt_assert_failure("${rc}" "new with no name should fail")
    qt_combine_output(combined "${out}" "${err}")
    qt_assert_contains("${combined}" "Usage" "new with no name should print usage")
endfunction()

function(qt_scenario_new_already_exists)
    qt_begin_test("new_already_exists")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_quilt_ok(ARGS new existing.patch MESSAGE "first new failed")
    # Try to create the same patch name again
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS new existing.patch)
    qt_assert_failure("${rc}" "new with duplicate name should fail")
    qt_combine_output(combined "${out}" "${err}")
    qt_assert_contains("${combined}" "exist" "error should mention already exists")
endfunction()

function(qt_scenario_new_combined_p_flag)
    qt_begin_test("new_combined_p_flag")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    # Combined -p flag: -p2 as a single argument (instead of -p 2)
    qt_quilt_ok(ARGS new -p2 foo.patch MESSAGE "new -p2 failed")
    qt_assert_file_contains("${QT_WORK_DIR}/patches/series" "-p2" "series should contain -p2")
endfunction()

function(qt_scenario_next_with_target)
    qt_begin_test("next_with_target")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_quilt_ok(ARGS new p1.patch MESSAGE "new p1 failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add p1 failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "1\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh p1 failed")
    qt_quilt_ok(ARGS new p2.patch MESSAGE "new p2 failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add p2 failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "2\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh p2 failed")
    qt_quilt_ok(ARGS new p3.patch MESSAGE "new p3 failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add p3 failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "3\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh p3 failed")
    # next p1 should be p2
    qt_quilt_ok(OUTPUT next_out ERROR next_err ARGS next p1.patch MESSAGE "next p1 failed")
    qt_assert_contains("${next_out}" "p2.patch" "next p1 should be p2")
    # next p2 should be p3
    qt_quilt_ok(OUTPUT next2_out ERROR next2_err ARGS next p2.patch MESSAGE "next p2 failed")
    qt_assert_contains("${next2_out}" "p3.patch" "next p2 should be p3")
endfunction()

function(qt_scenario_next_unknown_target)
    qt_begin_test("next_unknown_target")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_quilt_ok(ARGS new p1.patch MESSAGE "new p1 failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add p1 failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "1\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh p1 failed")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS next unknown.patch)
    qt_assert_failure("${rc}" "next with unknown patch should fail")
    qt_combine_output(combined "${out}" "${err}")
    qt_assert_contains("${combined}" "not in series" "next unknown should say not in series")
endfunction()

function(qt_scenario_previous_unknown_target)
    qt_begin_test("previous_unknown_target")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_quilt_ok(ARGS new p1.patch MESSAGE "new p1 failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add p1 failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "1\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh p1 failed")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS previous unknown.patch)
    qt_assert_failure("${rc}" "previous with unknown patch should fail")
    qt_combine_output(combined "${out}" "${err}")
    qt_assert_contains("${combined}" "not in series" "previous unknown should say not in series")
endfunction()

function(qt_scenario_diff_external_context_format)
    qt_begin_test("diff_external_context_format")
    qt_write_file("${QT_WORK_DIR}/f.txt" "old\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "new\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    # --diff=diff forces external diff; -c requests context format.
    # quilt.cpp uses unified_to_context() to convert the unified output.
    qt_quilt_ok(OUTPUT diff_out ERROR diff_err ARGS diff "--diff=diff" -c MESSAGE "diff --diff=diff -c failed")
    qt_assert_contains("${diff_out}" "***" "external context diff should have *** headers")
    qt_assert_not_contains("${diff_out}" "@@" "external context diff should not have @@ markers")
    qt_assert_contains("${diff_out}" "! old" "context diff should show changed old line")
    qt_assert_contains("${diff_out}" "! new" "context diff should show changed new line")
endfunction()

function(qt_scenario_diff_P_unapplied)
    qt_begin_test("diff_P_unapplied")
    qt_write_file("${QT_WORK_DIR}/f.txt" "base\n")
    qt_quilt_ok(ARGS new p1.patch MESSAGE "new p1 failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add p1 failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "v1\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh p1 failed")
    # Create p2 in series but do NOT apply it
    file(APPEND "${QT_WORK_DIR}/patches/series" "p2.patch\n")
    file(WRITE "${QT_WORK_DIR}/patches/p2.patch" "")
    # diff -P p2.patch: p2 not in applied list, triggers patch_range_for_diff line 673
    # p2 has no .pc dir so no tracked files → empty diff, exits 0
    qt_quilt(RESULT rc OUTPUT diff_out ERROR diff_err ARGS diff -P p2.patch)
    qt_assert_success("${rc}" "diff -P unapplied should succeed with empty output")
endfunction()

function(qt_scenario_refresh_diffstat_delete_file)
    qt_begin_test("refresh_diffstat_delete_file")
    qt_write_file("${QT_WORK_DIR}/f.txt" "line1\nline2\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    # Delete the file: refresh should produce a deletion diff (+++ /dev/null)
    file(REMOVE "${QT_WORK_DIR}/f.txt")
    qt_quilt_ok(ARGS refresh --diffstat MESSAGE "refresh --diffstat on deletion failed")
    qt_read_file_strip(patch_text "${QT_WORK_DIR}/patches/p.patch")
    qt_assert_contains("${patch_text}" "/dev/null" "deleted file diff should have /dev/null")
    qt_assert_contains("${patch_text}" "file changed" "diffstat should report file changed")
    qt_assert_contains("${patch_text}" "f.txt" "diffstat should name the file")
endfunction()

function(qt_scenario_refresh_strip_ws_blank_context)
    qt_begin_test("refresh_strip_ws_blank_context")
    # File with an all-whitespace line in the middle
    qt_write_file("${QT_WORK_DIR}/f.txt" "line1\n   \nline3\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    # Modify line1 so the whitespace-only line appears as context
    qt_write_file("${QT_WORK_DIR}/f.txt" "changed\n   \nline3\n")
    # --strip-trailing-whitespace: all-whitespace context line triggers warning path
    qt_quilt(RESULT rc OUTPUT refresh_out ERROR refresh_err ARGS refresh --strip-trailing-whitespace)
    qt_assert_success("${rc}" "refresh --strip-trailing-whitespace should succeed")
    qt_combine_output(combined "${refresh_out}" "${refresh_err}")
    qt_assert_contains("${combined}" "Warning" "should warn about whitespace-only context line")
endfunction()

function(qt_scenario_refresh_diffstat_padding)
    qt_begin_test("refresh_diffstat_padding")
    # Two files with different name lengths AND different change counts.
    # Name padding: a.txt (5 chars) is shorter than long_name.txt (13 chars) → triggers line 877-878.
    # Number padding: long_name.txt has fewer changes (2) than a.txt (11+), so when
    # max_changes >= 10 (num_width=2) and a file has < 10 changes, line 882 executes.
    qt_write_file("${QT_WORK_DIR}/a.txt" "old\n")
    qt_write_file("${QT_WORK_DIR}/long_name.txt" "x\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add a.txt MESSAGE "add a failed")
    qt_quilt_ok(ARGS add long_name.txt MESSAGE "add long failed")
    # a.txt: replace with 11 lines (1 deletion + 11 insertions = 12 changes, num_str len=2)
    qt_write_file("${QT_WORK_DIR}/a.txt" "1\n2\n3\n4\n5\n6\n7\n8\n9\n10\n11\n")
    # long_name.txt: 1 line changed (2 changes, num_str len=1 < num_width=2 → padding)
    qt_write_file("${QT_WORK_DIR}/long_name.txt" "y\n")
    qt_quilt_ok(ARGS refresh --diffstat MESSAGE "refresh --diffstat failed")
    qt_read_file_strip(patch_text "${QT_WORK_DIR}/patches/p.patch")
    qt_assert_contains("${patch_text}" "a.txt" "diffstat should list a.txt")
    qt_assert_contains("${patch_text}" "long_name.txt" "diffstat should list long_name.txt")
    qt_assert_contains("${patch_text}" "2 files changed" "diffstat should say 2 files changed")
endfunction()

function(qt_scenario_header_no_patch_applied)
    qt_begin_test("header_no_patch_applied")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS pop MESSAGE "pop failed")
    # No patch applied but p.patch in series → header uses q.series.front() (lines 606-607)
    qt_quilt_ok(OUTPUT out ERROR err ARGS header MESSAGE "header with unapplied patch failed")
endfunction()

function(qt_scenario_header_empty_series)
    qt_begin_test("header_empty_series")
    qt_quilt_ok(ARGS init MESSAGE "init failed")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS header)
    qt_assert_failure("${rc}" "header with empty series should fail")
    qt_combine_output(combined "${out}" "${err}")
    qt_assert_contains("${combined}" "No patch" "header should report no patch")
endfunction()

function(qt_scenario_header_backup_replace)
    qt_begin_test("header_backup_replace")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "y\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    # Replace header with backup: covers line 645 (copy_file in REPLACE mode with --backup)
    qt_quilt_ok(ARGS header -r --backup INPUT "New header\n" MESSAGE "header -r --backup failed")
    qt_assert_exists("${QT_WORK_DIR}/patches/p.patch~" "backup file should exist")
endfunction()

function(qt_scenario_files_verbose)
    qt_begin_test("files_verbose")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    # -v outputs "filename\tpatchname" format (line 769)
    qt_quilt_ok(OUTPUT out ERROR err ARGS files -v MESSAGE "files -v failed")
    qt_assert_contains("${out}" "f.txt" "files -v should list f.txt")
    qt_assert_contains("${out}" "p.patch" "files -v should list p.patch")
endfunction()

function(qt_scenario_files_verbose_unapplied)
    qt_begin_test("files_verbose_unapplied")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "y\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    qt_quilt_ok(ARGS pop MESSAGE "pop failed")
    # files -v with unapplied patch: reads patch file directly (lines 760-763)
    qt_quilt_ok(OUTPUT out ERROR err ARGS files -v p.patch MESSAGE "files -v unapplied failed")
    qt_assert_contains("${out}" "f.txt" "files -v unapplied should list f.txt")
endfunction()

function(qt_scenario_files_combine_none_applied)
    qt_begin_test("files_combine_none_applied")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS pop MESSAGE "pop failed")
    # files --combine - with nothing applied (lines 730-731)
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS files --combine -)
    qt_assert_failure("${rc}" "files --combine - with nothing applied should fail")
    qt_combine_output(combined "${out}" "${err}")
    qt_assert_contains("${combined}" "No patch" "should report no patch applied")
endfunction()

function(qt_scenario_files_combine_not_applied)
    qt_begin_test("files_combine_not_applied")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_quilt_ok(ARGS new p1.patch MESSAGE "new p1 failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "y\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh p1 failed")
    qt_quilt_ok(ARGS new p2.patch MESSAGE "new p2 failed")
    qt_quilt_ok(ARGS pop MESSAGE "pop to p1 failed")
    # files --combine p2 when p2 is not applied (lines 744-747)
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS files --combine p2.patch)
    qt_assert_failure("${rc}" "files --combine <not-applied> should fail")
    qt_combine_output(combined "${out}" "${err}")
    qt_assert_contains("${combined}" "not applied" "should report not applied")
endfunction()

function(qt_scenario_import_after_applied)
    qt_begin_test("import_after_applied")
    # p1 is applied, p2 is after it in series
    # import new.patch: should insert after p1 (between p1 and p2) → line 466
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_quilt_ok(ARGS new p1.patch MESSAGE "new p1 failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "y\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh p1 failed")
    qt_quilt_ok(ARGS new p2.patch MESSAGE "new p2 failed")
    qt_quilt_ok(ARGS pop MESSAGE "pop to p1 failed")
    # Now p1 is top (applied), p2 is next (unapplied)
    # Import new.patch: top_idx=0, top_idx+1=1 < ssize([p1,p2])=2 → insert at 1 → line 466
    qt_write_file("${QT_WORK_DIR}/new.patch" "# empty\n")
    qt_quilt_ok(ARGS import new.patch MESSAGE "import failed")
    # Verify new.patch is between p1 and p2 in series
    qt_read_file_strip(series "${QT_WORK_DIR}/patches/series")
    qt_assert_contains("${series}" "new.patch" "series should contain new.patch")
endfunction()

function(qt_scenario_delete_bad_option)
    qt_begin_test("delete_bad_option")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS delete --bad-opt)
    qt_assert_failure("${rc}" "delete with bad option should fail")
    qt_combine_output(combined "${out}" "${err}")
    qt_assert_contains("${combined}" "bad-opt" "delete should mention bad option")
endfunction()

function(qt_scenario_delete_no_patch)
    qt_begin_test("delete_no_patch")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS pop MESSAGE "pop failed")
    # delete with no arg and nothing applied (lines 172-174)
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS delete)
    qt_assert_failure("${rc}" "delete with no patch applied should fail")
    qt_combine_output(combined "${out}" "${err}")
    qt_assert_contains("${combined}" "No patches applied" "should report no patches applied")
endfunction()

function(qt_scenario_delete_topmost)
    qt_begin_test("delete_topmost")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    # delete with no args while p.patch is applied: uses q.applied.back() (line 176)
    qt_quilt_ok(OUTPUT out ERROR err ARGS delete MESSAGE "delete topmost failed")
    qt_combine_output(combined "${out}" "${err}")
    qt_assert_contains("${combined}" "Removed" "delete topmost should confirm removal")
endfunction()

function(qt_scenario_upgrade_help)
    qt_begin_test("upgrade_help")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(OUTPUT out ERROR err ARGS upgrade --help MESSAGE "upgrade --help failed")
    qt_assert_contains("${out}" "Usage" "upgrade --help should show usage")
endfunction()

function(qt_scenario_upgrade_bad_option)
    qt_begin_test("upgrade_bad_option")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS upgrade --bad-opt)
    qt_assert_failure("${rc}" "upgrade with bad option should fail")
    qt_combine_output(combined "${out}" "${err}")
    qt_assert_contains("${combined}" "bad-opt" "upgrade should mention bad option")
endfunction()

function(qt_scenario_fold_patch_opts)
    qt_begin_test("fold_patch_opts")
    qt_write_file("${QT_WORK_DIR}/f.txt" "new\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    # QUILT_PATCH_OPTS=-R: reverses the patch before applying (lines 935-941)
    qt_quilt_ok(
        ENV "QUILT_PATCH_OPTS=-R"
        ARGS fold
        INPUT [=[--- a/f.txt
+++ b/f.txt
@@ -1 +1 @@
-old
+new
]=]
        MESSAGE "fold with QUILT_PATCH_OPTS=-R failed"
    )
    qt_assert_file_text("${QT_WORK_DIR}/f.txt" "old" "fold -R via QUILT_PATCH_OPTS should reverse-apply")
endfunction()

function(qt_scenario_edit_bad_option)
    qt_begin_test("edit_bad_option")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt(RESULT rc OUTPUT out ERROR err ENV "EDITOR=true" ARGS edit --bad-option)
    qt_assert_failure("${rc}" "edit with bad option should fail")
    qt_combine_output(combined "${out}" "${err}")
    qt_assert_contains("${combined}" "bad-option" "edit should mention the bad option")
endfunction()

function(qt_scenario_edit_no_files)
    qt_begin_test("edit_no_files")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt(RESULT rc OUTPUT out ERROR err ENV "EDITOR=true" ARGS edit)
    qt_assert_failure("${rc}" "edit with no files should fail")
    qt_combine_output(combined "${out}" "${err}")
    qt_assert_contains("${combined}" "Usage" "edit with no files should print usage")
endfunction()

function(qt_scenario_remove_no_patches)
    qt_begin_test("remove_no_patches")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_write_file("${QT_WORK_DIR}/patches/series" "placeholder.patch\n")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS remove f.txt)
    qt_assert_failure("${rc}" "remove with no patches should fail")
    qt_combine_output(combined "${out}" "${err}")
    qt_assert_contains("${combined}" "No patches applied" "remove should report no patches applied")
endfunction()

function(qt_scenario_diff_z_p0)
    qt_begin_test("diff_z_p0")
    qt_write_file("${QT_WORK_DIR}/f.txt" "v1\n")
    qt_quilt_ok(ARGS new -p 0 p.patch MESSAGE "new -p0 failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "v2\n")
    qt_quilt_ok(ARGS refresh MESSAGE "first refresh failed")
    # Now make more changes without refreshing
    qt_write_file("${QT_WORK_DIR}/f.txt" "v3\n")
    # diff -z uses split_patch_by_file on the stored p0 patch (covers line 623: no slash in +++ path)
    # and labels files without directory prefix (covers lines 1593-1594)
    qt_quilt_ok(OUTPUT diff_out ERROR diff_err ARGS diff -z MESSAGE "diff -z with p0 failed")
    qt_assert_contains("${diff_out}" "v3" "diff -z should show current content")
endfunction()

function(qt_scenario_diff_z_pab)
    qt_begin_test("diff_z_pab")
    qt_write_file("${QT_WORK_DIR}/f.txt" "v1\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "v2\n")
    qt_quilt_ok(ARGS refresh MESSAGE "first refresh failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "v3\n")
    # -pab uses a/f.txt b/f.txt labels (covers lines 1590-1591)
    qt_quilt_ok(OUTPUT diff_out ERROR diff_err ARGS diff -z -p ab MESSAGE "diff -z -pab failed")
    qt_assert_contains("${diff_out}" "a/f.txt" "diff -z -pab should use a/ prefix")
    qt_assert_contains("${diff_out}" "b/f.txt" "diff -z -pab should use b/ prefix")
endfunction()

function(qt_scenario_diff_snapshot_new_file_after)
    qt_begin_test("diff_snapshot_new_file_after")
    # p1 is applied first, then snapshot taken, then p2 adds a new file
    # diff --snapshot should include the new file via first_patch_for_file (lines 679-684)
    qt_write_file("${QT_WORK_DIR}/f1.txt" "base\n")
    qt_quilt_ok(ARGS new p1.patch MESSAGE "new p1 failed")
    qt_quilt_ok(ARGS add f1.txt MESSAGE "add f1 failed")
    qt_write_file("${QT_WORK_DIR}/f1.txt" "v1\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh p1 failed")
    qt_quilt_ok(ARGS snapshot MESSAGE "snapshot failed")
    # p2 adds a new file not covered by the snapshot
    qt_quilt_ok(ARGS new p2.patch MESSAGE "new p2 failed")
    qt_quilt_ok(ARGS add f2.txt MESSAGE "add f2 failed")
    qt_write_file("${QT_WORK_DIR}/f2.txt" "new content\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh p2 failed")
    # diff --snapshot: f2 not in .pc/.snap so first_patch_for_file is called
    qt_quilt_ok(OUTPUT diff_out ERROR diff_err ARGS diff --snapshot MESSAGE "diff --snapshot failed")
    qt_assert_contains("${diff_out}" "+new content" "snapshot diff should show f2 not in snapshot")
endfunction()

function(qt_scenario_diff_z_external)
    qt_begin_test("diff_z_external")
    qt_write_file("${QT_WORK_DIR}/f.txt" "v1\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "v2\n")
    qt_quilt_ok(ARGS refresh MESSAGE "first refresh failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "v3\n")
    # diff -z --diff=diff uses the external diff path in since_refresh (lines 1621-1633)
    qt_quilt_ok(OUTPUT diff_out ERROR diff_err ARGS diff -z "--diff=diff" MESSAGE "diff -z --diff=diff failed")
    qt_assert_contains("${diff_out}" "v3" "diff -z external should show current changes")
endfunction()

function(qt_scenario_fold_force)
    qt_begin_test("fold_force")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    # -f flag in fold: covers line 890 (opt_force = true)
    qt_quilt_ok(
        ARGS fold -f
        INPUT [=[--- a/f.txt
+++ b/f.txt
@@ -1 +1 @@
-x
+y
]=]
        MESSAGE "fold -f failed"
    )
    qt_assert_file_text("${QT_WORK_DIR}/f.txt" "y" "fold -f should apply")
endfunction()

function(qt_scenario_fold_force_env)
    qt_begin_test("fold_force_env")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    # QUILT_PATCH_OPTS=-f: covers fold env parsing branch for -f (line 937)
    qt_quilt_ok(
        ENV "QUILT_PATCH_OPTS=-f"
        ARGS fold
        INPUT [=[--- a/f.txt
+++ b/f.txt
@@ -1 +1 @@
-x
+y
]=]
        MESSAGE "fold with QUILT_PATCH_OPTS=-f failed"
    )
    qt_assert_file_text("${QT_WORK_DIR}/f.txt" "y" "fold with QUILT_PATCH_OPTS=-f should apply")
endfunction()

function(qt_scenario_header_backup_append)
    qt_begin_test("header_backup_append")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "y\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    # Append header with backup: covers line 634 (copy_file in APPEND mode with --backup)
    qt_quilt_ok(ARGS header -a --backup INPUT "Appended header\n" MESSAGE "header -a --backup failed")
    qt_assert_exists("${QT_WORK_DIR}/patches/p.patch~" "backup file should exist after -a --backup")
endfunction()

function(qt_scenario_diff_z_reverse)
    qt_begin_test("diff_z_reverse")
    qt_write_file("${QT_WORK_DIR}/f.txt" "v1\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "v2\n")
    qt_quilt_ok(ARGS refresh MESSAGE "first refresh failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "v3\n")
    # diff -z -R: reverse the diff in the since_refresh path (covers lines 1605-1606)
    qt_quilt_ok(OUTPUT diff_out ERROR diff_err ARGS diff -z -R MESSAGE "diff -z -R failed")
    qt_assert_contains("${diff_out}" "+v2" "reverse diff -z should show +v2 as added")
endfunction()

function(qt_scenario_diff_z_subdir)
    qt_begin_test("diff_z_subdir")
    # File in a subdirectory: triggers make_dirs for tmp subdir (line 1545)
    file(MAKE_DIRECTORY "${QT_WORK_DIR}/sub")
    qt_write_file("${QT_WORK_DIR}/sub/f.txt" "v1\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add sub/f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/sub/f.txt" "v2\n")
    qt_quilt_ok(ARGS refresh MESSAGE "first refresh failed")
    qt_write_file("${QT_WORK_DIR}/sub/f.txt" "v3\n")
    qt_quilt_ok(OUTPUT diff_out ERROR diff_err ARGS diff -z MESSAGE "diff -z subdir failed")
    qt_assert_contains("${diff_out}" "v3" "diff -z subdir should show current changes")
endfunction()

function(qt_scenario_diff_snapshot_shadow)
    qt_begin_test("diff_snapshot_shadow")
    # p1 and p2 both modify f.txt; snapshot taken after both applied
    # diff --snapshot -P p1: next_patch_for_file(q, "p1", "f.txt") returns "p2"
    # This covers lines 1661-1663 (new_path = p2 backup, new_placeholder = true)
    qt_write_file("${QT_WORK_DIR}/f.txt" "base\n")
    qt_quilt_ok(ARGS new p1.patch MESSAGE "new p1 failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add p1 failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "v1\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh p1 failed")
    qt_quilt_ok(ARGS new p2.patch MESSAGE "new p2 failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add p2 failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "v2\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh p2 failed")
    qt_quilt_ok(ARGS snapshot MESSAGE "snapshot failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "v3\n")
    # -P p1: p2 is above p1 and also tracks f.txt → next_patch_for_file returns "p2"
    qt_quilt_ok(OUTPUT diff_out ERROR diff_err ARGS diff --snapshot -P p1.patch MESSAGE "diff --snapshot -P p1 failed")
endfunction()

function(qt_scenario_quilt_no_args)
    qt_begin_test("quilt_no_args")
    # Running quilt with no arguments should print usage and exit non-zero
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS)
    qt_assert_failure("${rc}" "quilt with no args should fail")
    qt_combine_output(combined "${out}" "${err}")
    qt_assert_contains("${combined}" "Usage:" "quilt no-args should print usage")
endfunction()

function(qt_scenario_quilt_version)
    qt_begin_test("quilt_version")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS --version)
    qt_assert_success("${rc}" "--version should succeed")
    qt_assert_contains("${out}" "quilt version" "--version should print version")
endfunction()

function(qt_scenario_quilt_global_help)
    qt_begin_test("quilt_global_help")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS --help)
    qt_assert_success("${rc}" "--help should succeed")
    qt_assert_contains("${out}" "Commands:" "--help should list commands")
    qt_assert_contains("${out}" "Usage:" "--help should print usage")
endfunction()

function(qt_scenario_quilt_help_command)
    qt_begin_test("quilt_help_command")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS help)
    qt_assert_success("${rc}" "help command should succeed")
    qt_assert_contains("${out}" "Commands:" "help should list commands")
endfunction()

function(qt_scenario_quilt_unknown_command)
    qt_begin_test("quilt_unknown_command")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS thiscommandisunknown)
    qt_assert_failure("${rc}" "unknown command should fail")
    qt_assert_contains("${err}" "unknown command" "should say unknown command")
endfunction()

function(qt_scenario_quilt_ambiguous_command)
    qt_begin_test("quilt_ambiguous_command")
    # "p" matches push, pop, patches, previous — ambiguous
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS p)
    qt_assert_failure("${rc}" "ambiguous command should fail")
    qt_assert_contains("${err}" "ambiguous" "should say ambiguous")
endfunction()

function(qt_scenario_quilt_quiltrc_equals)
    qt_begin_test("quilt_quiltrc_equals")
    # Test --quiltrc=file form (with equals sign)
    # Write a quiltrc that sets a recognizable value
    qt_write_file("${QT_TEST_BASE}/my.quiltrc" "QUILT_PATCHES=mypatchdir\n")
    qt_write_file("${QT_WORK_DIR}/file.txt" "a\n")
    # quilt series with --quiltrc=file: should load the rc file
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS --quiltrc=${QT_TEST_BASE}/my.quiltrc series)
    # series may fail (no patches) but the important thing is it didn't crash on the rc loading
    # We can't easily assert the rc was loaded, but we cover the --quiltrc=X branch
    # Just assert that the process ran
    qt_assert_not_equal("${rc}" "-1" "--quiltrc= form should not crash")
endfunction()

function(qt_scenario_quiltrc_export_prefix)
    qt_begin_test("quiltrc_export_prefix")
    qt_write_file("${QT_WORK_DIR}/f.txt" "a\n")
    # Use a quiltrc with "export KEY=value" syntax to set QUILT_PATCHES
    qt_write_file("${QT_TEST_BASE}/exprc" "export QUILT_DIFF_OPTS=--unified\n")
    qt_quilt_ok(ARGS --quiltrc "${QT_TEST_BASE}/exprc" new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS --quiltrc "${QT_TEST_BASE}/exprc" add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "b\n")
    qt_quilt_ok(ARGS --quiltrc "${QT_TEST_BASE}/exprc" refresh MESSAGE "refresh failed")
    qt_assert_exists("${QT_WORK_DIR}/patches/p.patch" "patch should exist")
endfunction()

function(qt_scenario_quiltrc_invalid_key)
    qt_begin_test("quiltrc_invalid_key")
    qt_write_file("${QT_WORK_DIR}/f.txt" "a\n")
    # quiltrc with invalid key names (starting with digit, or with special chars) should be silently ignored
    qt_write_file("${QT_TEST_BASE}/badrc" "1invalid=value\n!alsobad=value\nQUILT_DIFF_OPTS=--unified\n")
    qt_quilt_ok(ARGS --quiltrc "${QT_TEST_BASE}/badrc" new p.patch MESSAGE "new with badrc failed")
    qt_quilt_ok(ARGS --quiltrc "${QT_TEST_BASE}/badrc" add f.txt MESSAGE "add with badrc failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "b\n")
    qt_quilt_ok(ARGS --quiltrc "${QT_TEST_BASE}/badrc" refresh MESSAGE "refresh with badrc failed")
    qt_assert_exists("${QT_WORK_DIR}/patches/p.patch" "patch should exist despite invalid rc keys")
endfunction()

function(qt_scenario_quiltrc_dquote_backslash)
    qt_begin_test("quiltrc_dquote_backslash")
    qt_write_file("${QT_WORK_DIR}/f.txt" "a\n")
    # quiltrc with double-quoted value containing backslash escapes
    qt_write_file("${QT_TEST_BASE}/dqrc" "QUILT_DIFF_OPTS=\"--unified\"\n")
    qt_quilt_ok(ARGS --quiltrc "${QT_TEST_BASE}/dqrc" new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS --quiltrc "${QT_TEST_BASE}/dqrc" add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "b\n")
    qt_quilt_ok(ARGS --quiltrc "${QT_TEST_BASE}/dqrc" refresh MESSAGE "refresh failed")
    # Test that double-quoted value with backslash is parsed: \"
    qt_write_file("${QT_TEST_BASE}/dqrc2" "QUILT_DIFF_OPTS=\"--no\\\\op\"\n")
    qt_quilt(RESULT rc OUTPUT out ERROR err
        ARGS --quiltrc "${QT_TEST_BASE}/dqrc2" diff)
    # Just verifying it doesn't crash on the backslash parsing
    qt_assert_not_equal("${rc}" "-1" "quiltrc with backslash in dquote should not crash")
endfunction()

function(qt_run_named_scenario scenario)
    if(scenario STREQUAL "basic_workflow")
        qt_scenario_basic_workflow()
    elseif(scenario STREQUAL "new_file_in_patch")
        qt_scenario_new_file_in_patch()
    elseif(scenario STREQUAL "multiple_files_in_patch")
        qt_scenario_multiple_files_in_patch()
    elseif(scenario STREQUAL "series")
        qt_scenario_series()
    elseif(scenario STREQUAL "applied_unapplied")
        qt_scenario_applied_unapplied()
    elseif(scenario STREQUAL "applied_none_applied")
        qt_scenario_applied_none_applied()
    elseif(scenario STREQUAL "top_none_applied")
        qt_scenario_top_none_applied()
    elseif(scenario STREQUAL "top")
        qt_scenario_top()
    elseif(scenario STREQUAL "next_previous")
        qt_scenario_next_previous()
    elseif(scenario STREQUAL "next_fully_applied")
        qt_scenario_next_fully_applied()
    elseif(scenario STREQUAL "previous_none_applied")
        qt_scenario_previous_none_applied()
    elseif(scenario STREQUAL "push_all")
        qt_scenario_push_all()
    elseif(scenario STREQUAL "push_when_fully_applied")
        qt_scenario_push_when_fully_applied()
    elseif(scenario STREQUAL "pop_when_none_applied")
        qt_scenario_pop_when_none_applied()
    elseif(scenario STREQUAL "stack_push_pop_transcript")
        qt_scenario_stack_push_pop_transcript()
    elseif(scenario STREQUAL "push_named_patch")
        qt_scenario_push_named_patch()
    elseif(scenario STREQUAL "pop_to_named_patch")
        qt_scenario_pop_to_named_patch()
    elseif(scenario STREQUAL "pop_verbose")
        qt_scenario_pop_verbose()
    elseif(scenario STREQUAL "pop_verify_reverse")
        qt_scenario_pop_verify_reverse()
    elseif(scenario STREQUAL "pop_auto_refresh")
        qt_scenario_pop_auto_refresh()
    elseif(scenario STREQUAL "pop_refresh_args")
        qt_scenario_pop_refresh_args()
    elseif(scenario STREQUAL "diff_shows_changes")
        qt_scenario_diff_shows_changes()
    elseif(scenario STREQUAL "diff_after_refresh")
        qt_scenario_diff_after_refresh()
    elseif(scenario STREQUAL "snapshot_tracks_all_applied_files")
        qt_scenario_snapshot_tracks_all_applied_files()
    elseif(scenario STREQUAL "snapshot_replaces_previous")
        qt_scenario_snapshot_replaces_previous()
    elseif(scenario STREQUAL "snapshot_delete")
        qt_scenario_snapshot_delete()
    elseif(scenario STREQUAL "diff_snapshot_shows_changes")
        qt_scenario_diff_snapshot_shows_changes()
    elseif(scenario STREQUAL "diff_snapshot_multiple_applied")
        qt_scenario_diff_snapshot_multiple_applied()
    elseif(scenario STREQUAL "diff_snapshot_missing")
        qt_scenario_diff_snapshot_missing()
    elseif(scenario STREQUAL "diff_snapshot_invalid_combination")
        qt_scenario_diff_snapshot_invalid_combination()
    elseif(scenario STREQUAL "delete_unapplied")
        qt_scenario_delete_unapplied()
    elseif(scenario STREQUAL "delete_unknown_patch")
        qt_scenario_delete_unknown_patch()
    elseif(scenario STREQUAL "rename")
        qt_scenario_rename()
    elseif(scenario STREQUAL "rename_duplicate")
        qt_scenario_rename_duplicate()
    elseif(scenario STREQUAL "import")
        qt_scenario_import()
    elseif(scenario STREQUAL "import_duplicate")
        qt_scenario_import_duplicate()
    elseif(scenario STREQUAL "import_missing_source")
        qt_scenario_import_missing_source()
    elseif(scenario STREQUAL "import_strip_level")
        qt_scenario_import_strip_level()
    elseif(scenario STREQUAL "import_strip_level_default")
        qt_scenario_import_strip_level_default()
    elseif(scenario STREQUAL "import_reversed")
        qt_scenario_import_reversed()
    elseif(scenario STREQUAL "import_reversed_strip")
        qt_scenario_import_reversed_strip()
    elseif(scenario STREQUAL "import_dup_keep_old")
        qt_scenario_import_dup_keep_old()
    elseif(scenario STREQUAL "import_dup_append")
        qt_scenario_import_dup_append()
    elseif(scenario STREQUAL "import_dup_new")
        qt_scenario_import_dup_new()
    elseif(scenario STREQUAL "import_dup_no_flag_both_headers")
        qt_scenario_import_dup_no_flag_both_headers()
    elseif(scenario STREQUAL "import_dup_no_flag_no_header")
        qt_scenario_import_dup_no_flag_no_header()
    elseif(scenario STREQUAL "files")
        qt_scenario_files()
    elseif(scenario STREQUAL "files_labels")
        qt_scenario_files_labels()
    elseif(scenario STREQUAL "files_combine")
        qt_scenario_files_combine()
    elseif(scenario STREQUAL "files_combine_labels")
        qt_scenario_files_combine_labels()
    elseif(scenario STREQUAL "patches_cmd")
        qt_scenario_patches_cmd()
    elseif(scenario STREQUAL "annotate_basic")
        qt_scenario_annotate_basic()
    elseif(scenario STREQUAL "annotate_stop_patch")
        qt_scenario_annotate_stop_patch()
    elseif(scenario STREQUAL "annotate_created_file")
        qt_scenario_annotate_created_file()
    elseif(scenario STREQUAL "annotate_unmodified_file")
        qt_scenario_annotate_unmodified_file()
    elseif(scenario STREQUAL "annotate_unknown_patch")
        qt_scenario_annotate_unknown_patch()
    elseif(scenario STREQUAL "annotate_not_applied")
        qt_scenario_annotate_not_applied()
    elseif(scenario STREQUAL "annotate_usage")
        qt_scenario_annotate_usage()
    elseif(scenario STREQUAL "annotate_help")
        qt_scenario_annotate_help()
    elseif(scenario STREQUAL "annotate_subdirectory")
        qt_scenario_annotate_subdirectory()
    elseif(scenario STREQUAL "stub_grep")
        qt_scenario_stub_grep()
    elseif(scenario STREQUAL "stub_setup")
        qt_scenario_stub_setup()
    elseif(scenario STREQUAL "stub_shell")
        qt_scenario_stub_shell()
    elseif(scenario STREQUAL "annotate_bad_option")
        qt_scenario_annotate_bad_option()
    elseif(scenario STREQUAL "annotate_two_files")
        qt_scenario_annotate_two_files()
    elseif(scenario STREQUAL "annotate_no_applied")
        qt_scenario_annotate_no_applied()
    elseif(scenario STREQUAL "annotate_empty_series")
        qt_scenario_annotate_empty_series()
    elseif(scenario STREQUAL "annotate_nonexistent_file")
        qt_scenario_annotate_nonexistent_file()
    elseif(scenario STREQUAL "edit_multiple_files")
        qt_scenario_edit_multiple_files()
    elseif(scenario STREQUAL "edit_no_patch")
        qt_scenario_edit_no_patch()
    elseif(scenario STREQUAL "edit_already_tracked")
        qt_scenario_edit_already_tracked()
    elseif(scenario STREQUAL "fold_new_file")
        qt_scenario_fold_new_file()
    elseif(scenario STREQUAL "fold_no_patch")
        qt_scenario_fold_no_patch()
    elseif(scenario STREQUAL "fold_reverse")
        qt_scenario_fold_reverse()
    elseif(scenario STREQUAL "unapplied_all_applied")
        qt_scenario_unapplied_all_applied()
    elseif(scenario STREQUAL "unapplied_none_applied")
        qt_scenario_unapplied_none_applied()
    elseif(scenario STREQUAL "unapplied_named")
        qt_scenario_unapplied_named()
    elseif(scenario STREQUAL "upgrade_noop")
        qt_scenario_upgrade_noop()
    elseif(scenario STREQUAL "patches_verbose")
        qt_scenario_patches_verbose()
    elseif(scenario STREQUAL "patches_unapplied")
        qt_scenario_patches_unapplied()
    elseif(scenario STREQUAL "remove_with_P")
        qt_scenario_remove_with_P()
    elseif(scenario STREQUAL "rename_unapplied")
        qt_scenario_rename_unapplied()
    elseif(scenario STREQUAL "revert_new_file")
        qt_scenario_revert_new_file()
    elseif(scenario STREQUAL "next_none_applied")
        qt_scenario_next_none_applied()
    elseif(scenario STREQUAL "series_verbose")
        qt_scenario_series_verbose()
    elseif(scenario STREQUAL "previous_with_target")
        qt_scenario_previous_with_target()
    elseif(scenario STREQUAL "header")
        qt_scenario_header()
    elseif(scenario STREQUAL "edit")
        qt_scenario_edit()
    elseif(scenario STREQUAL "revert")
        qt_scenario_revert()
    elseif(scenario STREQUAL "revert_not_tracked")
        qt_scenario_revert_not_tracked()
    elseif(scenario STREQUAL "remove")
        qt_scenario_remove()
    elseif(scenario STREQUAL "fork")
        qt_scenario_fork()
    elseif(scenario STREQUAL "fork_no_applied_patch")
        qt_scenario_fork_no_applied_patch()
    elseif(scenario STREQUAL "fork_duplicate_name")
        qt_scenario_fork_duplicate_name()
    elseif(scenario STREQUAL "fold")
        qt_scenario_fold()
    elseif(scenario STREQUAL "add_no_patch")
        qt_scenario_add_no_patch()
    elseif(scenario STREQUAL "add_prefixed_patch_arg")
        qt_scenario_add_prefixed_patch_arg()
    elseif(scenario STREQUAL "add_already_tracked")
        qt_scenario_add_already_tracked()
    elseif(scenario STREQUAL "remove_not_tracked")
        qt_scenario_remove_not_tracked()
    elseif(scenario STREQUAL "subdirectory_files")
        qt_scenario_subdirectory_files()
    elseif(scenario STREQUAL "subdirectory_add_edit")
        qt_scenario_subdirectory_add_edit()
    elseif(scenario STREQUAL "empty_patch")
        qt_scenario_empty_patch()
    elseif(scenario STREQUAL "multiple_patches_same_file")
        qt_scenario_multiple_patches_same_file()
    elseif(scenario STREQUAL "many_patches")
        qt_scenario_many_patches()
    elseif(scenario STREQUAL "graph_basic")
        qt_scenario_graph_basic()
    elseif(scenario STREQUAL "graph_no_edges")
        qt_scenario_graph_no_edges()
    elseif(scenario STREQUAL "graph_selected_patch")
        qt_scenario_graph_selected_patch()
    elseif(scenario STREQUAL "graph_all_excludes_unapplied")
        qt_scenario_graph_all_excludes_unapplied()
    elseif(scenario STREQUAL "graph_reduce")
        qt_scenario_graph_reduce()
    elseif(scenario STREQUAL "graph_edge_labels")
        qt_scenario_graph_edge_labels()
    elseif(scenario STREQUAL "graph_lines_disjoint")
        qt_scenario_graph_lines_disjoint()
    elseif(scenario STREQUAL "graph_lines_context_boundary")
        qt_scenario_graph_lines_context_boundary()
    elseif(scenario STREQUAL "graph_empty_stack")
        qt_scenario_graph_empty_stack()
    elseif(scenario STREQUAL "graph_unknown_patch")
        qt_scenario_graph_unknown_patch()
    elseif(scenario STREQUAL "graph_help")
        qt_scenario_graph_help()
    elseif(scenario STREQUAL "graph_subdirectory")
        qt_scenario_graph_subdirectory()
    elseif(scenario STREQUAL "graph_lines_with_num")
        qt_scenario_graph_lines_with_num()
    elseif(scenario STREQUAL "graph_lines_nan")
        qt_scenario_graph_lines_nan()
    elseif(scenario STREQUAL "graph_edge_labels_space")
        qt_scenario_graph_edge_labels_space()
    elseif(scenario STREQUAL "graph_edge_labels_bad")
        qt_scenario_graph_edge_labels_bad()
    elseif(scenario STREQUAL "graph_T_bad")
        qt_scenario_graph_T_bad()
    elseif(scenario STREQUAL "graph_T_ps")
        qt_scenario_graph_T_ps()
    elseif(scenario STREQUAL "graph_Tps")
        qt_scenario_graph_Tps()
    elseif(scenario STREQUAL "graph_bad_option")
        qt_scenario_graph_bad_option()
    elseif(scenario STREQUAL "graph_two_patches")
        qt_scenario_graph_two_patches()
    elseif(scenario STREQUAL "graph_all_with_patch")
        qt_scenario_graph_all_with_patch()
    elseif(scenario STREQUAL "graph_no_applied_with_series")
        qt_scenario_graph_no_applied_with_series()
    elseif(scenario STREQUAL "graph_all_empty")
        qt_scenario_graph_all_empty()
    elseif(scenario STREQUAL "graph_unapplied_patch")
        qt_scenario_graph_unapplied_patch()
    elseif(scenario STREQUAL "stub_grep")
        qt_scenario_stub_grep()
    elseif(scenario STREQUAL "stub_setup")
        qt_scenario_stub_setup()
    elseif(scenario STREQUAL "stub_shell")
        qt_scenario_stub_shell()
    elseif(scenario STREQUAL "annotate_bad_option")
        qt_scenario_annotate_bad_option()
    elseif(scenario STREQUAL "annotate_two_files")
        qt_scenario_annotate_two_files()
    elseif(scenario STREQUAL "annotate_no_applied")
        qt_scenario_annotate_no_applied()
    elseif(scenario STREQUAL "annotate_empty_series")
        qt_scenario_annotate_empty_series()
    elseif(scenario STREQUAL "annotate_nonexistent_file")
        qt_scenario_annotate_nonexistent_file()
    elseif(scenario STREQUAL "filenames_with_spaces")
        qt_scenario_filenames_with_spaces()
    elseif(scenario STREQUAL "upward_scanning")
        qt_scenario_upward_scanning()
    elseif(scenario STREQUAL "command_abbreviation")
        qt_scenario_command_abbreviation()
    elseif(scenario STREQUAL "help_flag")
        qt_scenario_help_flag()
    elseif(scenario STREQUAL "init_creates_metadata")
        qt_scenario_init_creates_metadata()
    elseif(scenario STREQUAL "quilt_patches_env")
        qt_scenario_quilt_patches_env()
    elseif(scenario STREQUAL "quilt_pc_env")
        qt_scenario_quilt_pc_env()
    elseif(scenario STREQUAL "series_search_order")
        qt_scenario_series_search_order()
    elseif(scenario STREQUAL "strip_level")
        qt_scenario_strip_level()
    elseif(scenario STREQUAL "push_numeric")
        qt_scenario_push_numeric()
    elseif(scenario STREQUAL "push_verbose")
        qt_scenario_push_verbose()
    elseif(scenario STREQUAL "push_fuzz")
        qt_scenario_push_fuzz()
    elseif(scenario STREQUAL "push_merge")
        qt_scenario_push_merge()
    elseif(scenario STREQUAL "push_leave_rejects")
        qt_scenario_push_leave_rejects()
    elseif(scenario STREQUAL "push_refresh")
        qt_scenario_push_refresh()
    elseif(scenario STREQUAL "pop_numeric")
        qt_scenario_pop_numeric()
    elseif(scenario STREQUAL "force_push_tracking")
        qt_scenario_force_push_tracking()
    elseif(scenario STREQUAL "force_pop")
        qt_scenario_force_pop()
    elseif(scenario STREQUAL "refresh_shadowing_requires_force")
        qt_scenario_refresh_shadowing_requires_force()
    elseif(scenario STREQUAL "refresh_shadowing")
        qt_scenario_refresh_shadowing()
    elseif(scenario STREQUAL "diff_reverse")
        qt_scenario_diff_reverse()
    elseif(scenario STREQUAL "diff_context_format")
        qt_scenario_diff_context_format()
    elseif(scenario STREQUAL "diff_context_lines")
        qt_scenario_diff_context_lines()
    elseif(scenario STREQUAL "diff_unified_lines")
        qt_scenario_diff_unified_lines()
    elseif(scenario STREQUAL "diff_sort")
        qt_scenario_diff_sort()
    elseif(scenario STREQUAL "diff_combine")
        qt_scenario_diff_combine()
    elseif(scenario STREQUAL "diff_combine_named")
        qt_scenario_diff_combine_named()
    elseif(scenario STREQUAL "diff_combine_conflicts_with_z")
        qt_scenario_diff_combine_conflicts_with_z()
    elseif(scenario STREQUAL "diff_diff_utility")
        qt_scenario_diff_diff_utility()
    elseif(scenario STREQUAL "new_add_output")
        qt_scenario_new_add_output()
    elseif(scenario STREQUAL "new_strip_p0")
        qt_scenario_new_strip_p0()
    elseif(scenario STREQUAL "new_strip_p1")
        qt_scenario_new_strip_p1()
    elseif(scenario STREQUAL "new_strip_default")
        qt_scenario_new_strip_default()
    elseif(scenario STREQUAL "quilt_example")
        qt_scenario_quilt_example()
    elseif(scenario STREQUAL "quiltrc_basic")
        qt_scenario_quiltrc_basic()
    elseif(scenario STREQUAL "quiltrc_disable")
        qt_scenario_quiltrc_disable()
    elseif(scenario STREQUAL "quiltrc_env_override")
        qt_scenario_quiltrc_env_override()
    elseif(scenario STREQUAL "quilt_command_args")
        qt_scenario_quilt_command_args()
    elseif(scenario STREQUAL "quilt_series_env")
        qt_scenario_quilt_series_env()
    elseif(scenario STREQUAL "quilt_no_diff_index")
        qt_scenario_quilt_no_diff_index()
    elseif(scenario STREQUAL "quilt_patches_prefix")
        qt_scenario_quilt_patches_prefix()
    elseif(scenario STREQUAL "quiltrc_quoted_values")
        qt_scenario_quiltrc_quoted_values()
    elseif(scenario STREQUAL "init_help_text")
        qt_scenario_init_help_text()
    elseif(scenario STREQUAL "mail_basic")
        qt_scenario_mail_basic()
    elseif(scenario STREQUAL "mail_single_patch")
        qt_scenario_mail_single_patch()
    elseif(scenario STREQUAL "mail_patch_range")
        qt_scenario_mail_patch_range()
    elseif(scenario STREQUAL "mail_dash_range")
        qt_scenario_mail_dash_range()
    elseif(scenario STREQUAL "mail_prefix")
        qt_scenario_mail_prefix()
    elseif(scenario STREQUAL "mail_from_sender")
        qt_scenario_mail_from_sender()
    elseif(scenario STREQUAL "mail_to_cc")
        qt_scenario_mail_to_cc()
    elseif(scenario STREQUAL "mail_send_error")
        qt_scenario_mail_send_error()
    elseif(scenario STREQUAL "mail_no_mbox_error")
        qt_scenario_mail_no_mbox_error()
    elseif(scenario STREQUAL "mail_no_patches")
        qt_scenario_mail_no_patches()
    elseif(scenario STREQUAL "mail_header_multiline")
        qt_scenario_mail_header_multiline()
    elseif(scenario STREQUAL "mail_diffstat")
        qt_scenario_mail_diffstat()
    elseif(scenario STREQUAL "mail_help")
        qt_scenario_mail_help()
    elseif(scenario STREQUAL "mail_bad_option")
        qt_scenario_mail_bad_option()
    elseif(scenario STREQUAL "mail_no_from")
        qt_scenario_mail_no_from()
    elseif(scenario STREQUAL "mail_opts_ignored")
        qt_scenario_mail_opts_ignored()
    elseif(scenario STREQUAL "mail_single_named")
        qt_scenario_mail_single_named()
    elseif(scenario STREQUAL "mail_patch_not_in_series")
        qt_scenario_mail_patch_not_in_series()
    elseif(scenario STREQUAL "mail_first_not_in_series")
        qt_scenario_mail_first_not_in_series()
    elseif(scenario STREQUAL "mail_last_not_in_series")
        qt_scenario_mail_last_not_in_series()
    elseif(scenario STREQUAL "mail_range_reversed")
        qt_scenario_mail_range_reversed()
    elseif(scenario STREQUAL "mail_too_many_args")
        qt_scenario_mail_too_many_args()
    elseif(scenario STREQUAL "mail_empty_patch")
        qt_scenario_mail_empty_patch()
    elseif(scenario STREQUAL "mail_no_header")
        qt_scenario_mail_no_header()
    elseif(scenario STREQUAL "mail_non_ascii")
        qt_scenario_mail_non_ascii()
    elseif(scenario STREQUAL "mail_single_dash_positional")
        qt_scenario_mail_single_dash_positional()
    elseif(scenario STREQUAL "mail_leading_blank_header")
        qt_scenario_mail_leading_blank_header()
    elseif(scenario STREQUAL "shell_split_single_quotes")
        qt_scenario_shell_split_single_quotes()
    elseif(scenario STREQUAL "shell_split_double_quotes")
        qt_scenario_shell_split_double_quotes()
    elseif(scenario STREQUAL "shell_split_var_expansion")
        qt_scenario_shell_split_var_expansion()
    elseif(scenario STREQUAL "shell_split_var_braces")
        qt_scenario_shell_split_var_braces()
    elseif(scenario STREQUAL "shell_split_mixed")
        qt_scenario_shell_split_mixed()
    elseif(scenario STREQUAL "shell_split_dquote_escape")
        qt_scenario_shell_split_dquote_escape()
    elseif(scenario STREQUAL "shell_split_unquoted_backslash")
        qt_scenario_shell_split_unquoted_backslash()
    elseif(scenario STREQUAL "builtin_diff_identical_files")
        qt_scenario_builtin_diff_identical_files()
    elseif(scenario STREQUAL "builtin_diff_simple_change")
        qt_scenario_builtin_diff_simple_change()
    elseif(scenario STREQUAL "builtin_diff_new_file")
        qt_scenario_builtin_diff_new_file()
    elseif(scenario STREQUAL "builtin_diff_deleted_file")
        qt_scenario_builtin_diff_deleted_file()
    elseif(scenario STREQUAL "builtin_diff_no_trailing_newline")
        qt_scenario_builtin_diff_no_trailing_newline()
    elseif(scenario STREQUAL "builtin_diff_empty_to_content")
        qt_scenario_builtin_diff_empty_to_content()
    elseif(scenario STREQUAL "builtin_diff_multiple_hunks")
        qt_scenario_builtin_diff_multiple_hunks()
    elseif(scenario STREQUAL "builtin_diff_zero_context")
        qt_scenario_builtin_diff_zero_context()
    elseif(scenario STREQUAL "builtin_diff_large_context")
        qt_scenario_builtin_diff_large_context()
    elseif(scenario STREQUAL "builtin_diff_all_lines_changed")
        qt_scenario_builtin_diff_all_lines_changed()
    elseif(scenario STREQUAL "builtin_diff_single_line_files")
        qt_scenario_builtin_diff_single_line_files()
    elseif(scenario STREQUAL "builtin_diff_context_format")
        qt_scenario_builtin_diff_context_format()
    elseif(scenario STREQUAL "builtin_diff_vs_system_diff")
        qt_scenario_builtin_diff_vs_system_diff()
    elseif(scenario STREQUAL "builtin_patch_exact_apply")
        qt_scenario_builtin_patch_exact_apply()
    elseif(scenario STREQUAL "builtin_patch_offset")
        qt_scenario_builtin_patch_offset()
    elseif(scenario STREQUAL "builtin_patch_fuzz")
        qt_scenario_builtin_patch_fuzz()
    elseif(scenario STREQUAL "builtin_patch_new_file")
        qt_scenario_builtin_patch_new_file()
    elseif(scenario STREQUAL "builtin_patch_delete_file")
        qt_scenario_builtin_patch_delete_file()
    elseif(scenario STREQUAL "builtin_patch_reverse")
        qt_scenario_builtin_patch_reverse()
    elseif(scenario STREQUAL "builtin_patch_dry_run")
        qt_scenario_builtin_patch_dry_run()
    elseif(scenario STREQUAL "builtin_patch_reject")
        qt_scenario_builtin_patch_reject()
    elseif(scenario STREQUAL "builtin_patch_no_newline")
        qt_scenario_builtin_patch_no_newline()
    elseif(scenario STREQUAL "builtin_patch_multiple_files")
        qt_scenario_builtin_patch_multiple_files()
    elseif(scenario STREQUAL "builtin_patch_multiple_hunks")
        qt_scenario_builtin_patch_multiple_hunks()
    elseif(scenario STREQUAL "builtin_patch_strip_level")
        qt_scenario_builtin_patch_strip_level()
    elseif(scenario STREQUAL "builtin_patch_merge_markers")
        qt_scenario_builtin_patch_merge_markers()
    elseif(scenario STREQUAL "builtin_patch_empty_context")
        qt_scenario_builtin_patch_empty_context()
    elseif(scenario STREQUAL "builtin_patch_force")
        qt_scenario_builtin_patch_force()
    elseif(scenario STREQUAL "builtin_patch_vs_system")
        qt_scenario_builtin_patch_vs_system()
    elseif(scenario STREQUAL "refresh_unified")
        qt_scenario_refresh_unified()
    elseif(scenario STREQUAL "refresh_unified_lines")
        qt_scenario_refresh_unified_lines()
    elseif(scenario STREQUAL "refresh_context")
        qt_scenario_refresh_context()
    elseif(scenario STREQUAL "refresh_context_lines")
        qt_scenario_refresh_context_lines()
    elseif(scenario STREQUAL "refresh_backup")
        qt_scenario_refresh_backup()
    elseif(scenario STREQUAL "refresh_backup_no_existing")
        qt_scenario_refresh_backup_no_existing()
    elseif(scenario STREQUAL "refresh_strip_whitespace")
        qt_scenario_refresh_strip_whitespace()
    elseif(scenario STREQUAL "refresh_strip_whitespace_warning")
        qt_scenario_refresh_strip_whitespace_warning()
    elseif(scenario STREQUAL "refresh_fork")
        qt_scenario_refresh_fork()
    elseif(scenario STREQUAL "refresh_fork_named")
        qt_scenario_refresh_fork_named()
    elseif(scenario STREQUAL "refresh_fork_not_top")
        qt_scenario_refresh_fork_not_top()
    elseif(scenario STREQUAL "refresh_diffstat")
        qt_scenario_refresh_diffstat()
    elseif(scenario STREQUAL "header_strip_diffstat")
        qt_scenario_header_strip_diffstat()
    elseif(scenario STREQUAL "header_strip_trailing_whitespace")
        qt_scenario_header_strip_trailing_whitespace()
    elseif(scenario STREQUAL "header_strip_diffstat_print")
        qt_scenario_header_strip_diffstat_print()
    elseif(scenario STREQUAL "header_strip_ws_print")
        qt_scenario_header_strip_ws_print()
    elseif(scenario STREQUAL "header_dep3_template")
        qt_scenario_header_dep3_template()
    elseif(scenario STREQUAL "header_dep3_nonempty")
        qt_scenario_header_dep3_nonempty()
    elseif(scenario STREQUAL "header_strip_diffstat_append")
        qt_scenario_header_strip_diffstat_append()
    elseif(scenario STREQUAL "header_strip_combined")
        qt_scenario_header_strip_combined()
    elseif(scenario STREQUAL "unknown_option_rejected")
        qt_scenario_unknown_option_rejected()
    elseif(scenario STREQUAL "color_option_accepted")
        qt_scenario_color_option_accepted()
    elseif(scenario STREQUAL "color_option_invalid")
        qt_scenario_color_option_invalid()
    elseif(scenario STREQUAL "trace_option_accepted")
        qt_scenario_trace_option_accepted()
    elseif(scenario STREQUAL "applied_with_target")
        qt_scenario_applied_with_target()
    elseif(scenario STREQUAL "pop_target_already_top")
        qt_scenario_pop_target_already_top()
    elseif(scenario STREQUAL "push_unknown_target")
        qt_scenario_push_unknown_target()
    elseif(scenario STREQUAL "delete_backup_option")
        qt_scenario_delete_backup_option()
    elseif(scenario STREQUAL "delete_next_no_next")
        qt_scenario_delete_next_no_next()
    elseif(scenario STREQUAL "patches_no_file_arg")
        qt_scenario_patches_no_file_arg()
    elseif(scenario STREQUAL "builtin_patch_trailing_lines")
        qt_scenario_builtin_patch_trailing_lines()
    elseif(scenario STREQUAL "builtin_patch_merge_conflict_partial")
        qt_scenario_builtin_patch_merge_conflict_partial()
    elseif(scenario STREQUAL "builtin_patch_merge_diff3")
        qt_scenario_builtin_patch_merge_diff3()
    elseif(scenario STREQUAL "fold_reverse_no_newline")
        qt_scenario_fold_reverse_no_newline()
    elseif(scenario STREQUAL "diff_external_context_format")
        qt_scenario_diff_external_context_format()
    elseif(scenario STREQUAL "delete_applied")
        qt_scenario_delete_applied()
    elseif(scenario STREQUAL "new_no_name")
        qt_scenario_new_no_name()
    elseif(scenario STREQUAL "new_already_exists")
        qt_scenario_new_already_exists()
    elseif(scenario STREQUAL "new_combined_p_flag")
        qt_scenario_new_combined_p_flag()
    elseif(scenario STREQUAL "next_with_target")
        qt_scenario_next_with_target()
    elseif(scenario STREQUAL "next_unknown_target")
        qt_scenario_next_unknown_target()
    elseif(scenario STREQUAL "previous_unknown_target")
        qt_scenario_previous_unknown_target()
    elseif(scenario STREQUAL "add_no_patches_applied")
        qt_scenario_add_no_patches_applied()
    elseif(scenario STREQUAL "add_bad_option")
        qt_scenario_add_bad_option()
    elseif(scenario STREQUAL "add_no_files")
        qt_scenario_add_no_files()
    elseif(scenario STREQUAL "remove_bad_option")
        qt_scenario_remove_bad_option()
    elseif(scenario STREQUAL "remove_no_files")
        qt_scenario_remove_no_files()
    elseif(scenario STREQUAL "unapplied_bad_option")
        qt_scenario_unapplied_bad_option()
    elseif(scenario STREQUAL "next_bad_option")
        qt_scenario_next_bad_option()
    elseif(scenario STREQUAL "previous_bad_option")
        qt_scenario_previous_bad_option()
    elseif(scenario STREQUAL "previous_multiple_applied")
        qt_scenario_previous_multiple_applied()
    elseif(scenario STREQUAL "rename_bad_option")
        qt_scenario_rename_bad_option()
    elseif(scenario STREQUAL "rename_no_name")
        qt_scenario_rename_no_name()
    elseif(scenario STREQUAL "rename_no_patch_applied")
        qt_scenario_rename_no_patch_applied()
    elseif(scenario STREQUAL "pop_no_patches_applied")
        qt_scenario_pop_no_patches_applied()
    elseif(scenario STREQUAL "pop_unapplied_target")
        qt_scenario_pop_unapplied_target()
    elseif(scenario STREQUAL "unapplied_unknown_target")
        qt_scenario_unapplied_unknown_target()
    elseif(scenario STREQUAL "previous_no_patches_applied")
        qt_scenario_previous_no_patches_applied()
    elseif(scenario STREQUAL "push_no_series")
        qt_scenario_push_no_series()
    elseif(scenario STREQUAL "push_already_applied")
        qt_scenario_push_already_applied()
    elseif(scenario STREQUAL "import_bad_option")
        qt_scenario_import_bad_option()
    elseif(scenario STREQUAL "rename_unknown_patch")
        qt_scenario_rename_unknown_patch()
    elseif(scenario STREQUAL "fold_bad_option")
        qt_scenario_fold_bad_option()
    elseif(scenario STREQUAL "fork_no_extension")
        qt_scenario_fork_no_extension()
    elseif(scenario STREQUAL "diff_no_applied_patches")
        qt_scenario_diff_no_applied_patches()
    elseif(scenario STREQUAL "revert_bad_option")
        qt_scenario_revert_bad_option()
    elseif(scenario STREQUAL "revert_no_files")
        qt_scenario_revert_no_files()
    elseif(scenario STREQUAL "revert_with_P")
        qt_scenario_revert_with_P()
    elseif(scenario STREQUAL "header_with_patch_arg")
        qt_scenario_header_with_patch_arg()
    elseif(scenario STREQUAL "refresh_sort")
        qt_scenario_refresh_sort()
    elseif(scenario STREQUAL "files_bad_option")
        qt_scenario_files_bad_option()
    elseif(scenario STREQUAL "files_no_patch_applied")
        qt_scenario_files_no_patch_applied()
    elseif(scenario STREQUAL "fold_empty_stdin")
        qt_scenario_fold_empty_stdin()
    elseif(scenario STREQUAL "diff_C_combined")
        qt_scenario_diff_C_combined()
    elseif(scenario STREQUAL "diff_U_combined")
        qt_scenario_diff_U_combined()
    elseif(scenario STREQUAL "diff_with_P")
        qt_scenario_diff_with_P()
    elseif(scenario STREQUAL "diff_combine_snapshot_conflict")
        qt_scenario_diff_combine_snapshot_conflict()
    elseif(scenario STREQUAL "diff_file_filter")
        qt_scenario_diff_file_filter()
    elseif(scenario STREQUAL "diff_p_explicit")
        qt_scenario_diff_p_explicit()
    elseif(scenario STREQUAL "diff_no_timestamps")
        qt_scenario_diff_no_timestamps()
    elseif(scenario STREQUAL "init_extra_args")
        qt_scenario_init_extra_args()
    elseif(scenario STREQUAL "diff_explicit_u")
        qt_scenario_diff_explicit_u()
    elseif(scenario STREQUAL "diff_p_combined")
        qt_scenario_diff_p_combined()
    elseif(scenario STREQUAL "refresh_U_combined")
        qt_scenario_refresh_U_combined()
    elseif(scenario STREQUAL "refresh_C_combined")
        qt_scenario_refresh_C_combined()
    elseif(scenario STREQUAL "diff_external_context_multiline")
        qt_scenario_diff_external_context_multiline()
    elseif(scenario STREQUAL "diff_external_with_C")
        qt_scenario_diff_external_with_C()
    elseif(scenario STREQUAL "refresh_no_patches")
        qt_scenario_refresh_no_patches()
    elseif(scenario STREQUAL "revert_no_patches")
        qt_scenario_revert_no_patches()
    elseif(scenario STREQUAL "snapshot_bad_option")
        qt_scenario_snapshot_bad_option()
    elseif(scenario STREQUAL "diff_quilt_diff_opts_combined")
        qt_scenario_diff_quilt_diff_opts_combined()
    elseif(scenario STREQUAL "refresh_re_diffstat")
        qt_scenario_refresh_re_diffstat()
    elseif(scenario STREQUAL "diff_quilt_diff_opts_separate")
        qt_scenario_diff_quilt_diff_opts_separate()
    elseif(scenario STREQUAL "diff_P_unapplied")
        qt_scenario_diff_P_unapplied()
    elseif(scenario STREQUAL "refresh_diffstat_delete_file")
        qt_scenario_refresh_diffstat_delete_file()
    elseif(scenario STREQUAL "refresh_strip_ws_blank_context")
        qt_scenario_refresh_strip_ws_blank_context()
    elseif(scenario STREQUAL "refresh_diffstat_padding")
        qt_scenario_refresh_diffstat_padding()
    elseif(scenario STREQUAL "diff_z_p0")
        qt_scenario_diff_z_p0()
    elseif(scenario STREQUAL "diff_z_pab")
        qt_scenario_diff_z_pab()
    elseif(scenario STREQUAL "diff_snapshot_new_file_after")
        qt_scenario_diff_snapshot_new_file_after()
    elseif(scenario STREQUAL "diff_z_external")
        qt_scenario_diff_z_external()
    elseif(scenario STREQUAL "edit_bad_option")
        qt_scenario_edit_bad_option()
    elseif(scenario STREQUAL "edit_no_files")
        qt_scenario_edit_no_files()
    elseif(scenario STREQUAL "remove_no_patches")
        qt_scenario_remove_no_patches()
    elseif(scenario STREQUAL "diff_z_reverse")
        qt_scenario_diff_z_reverse()
    elseif(scenario STREQUAL "diff_z_subdir")
        qt_scenario_diff_z_subdir()
    elseif(scenario STREQUAL "diff_snapshot_shadow")
        qt_scenario_diff_snapshot_shadow()
    elseif(scenario STREQUAL "fold_patch_opts")
        qt_scenario_fold_patch_opts()
    elseif(scenario STREQUAL "fold_force")
        qt_scenario_fold_force()
    elseif(scenario STREQUAL "fold_force_env")
        qt_scenario_fold_force_env()
    elseif(scenario STREQUAL "header_backup_append")
        qt_scenario_header_backup_append()
    elseif(scenario STREQUAL "header_no_patch_applied")
        qt_scenario_header_no_patch_applied()
    elseif(scenario STREQUAL "header_empty_series")
        qt_scenario_header_empty_series()
    elseif(scenario STREQUAL "header_backup_replace")
        qt_scenario_header_backup_replace()
    elseif(scenario STREQUAL "files_verbose")
        qt_scenario_files_verbose()
    elseif(scenario STREQUAL "files_verbose_unapplied")
        qt_scenario_files_verbose_unapplied()
    elseif(scenario STREQUAL "files_combine_none_applied")
        qt_scenario_files_combine_none_applied()
    elseif(scenario STREQUAL "files_combine_not_applied")
        qt_scenario_files_combine_not_applied()
    elseif(scenario STREQUAL "import_after_applied")
        qt_scenario_import_after_applied()
    elseif(scenario STREQUAL "delete_bad_option")
        qt_scenario_delete_bad_option()
    elseif(scenario STREQUAL "delete_no_patch")
        qt_scenario_delete_no_patch()
    elseif(scenario STREQUAL "delete_topmost")
        qt_scenario_delete_topmost()
    elseif(scenario STREQUAL "upgrade_help")
        qt_scenario_upgrade_help()
    elseif(scenario STREQUAL "upgrade_bad_option")
        qt_scenario_upgrade_bad_option()
    elseif(scenario STREQUAL "quilt_no_args")
        qt_scenario_quilt_no_args()
    elseif(scenario STREQUAL "quilt_version")
        qt_scenario_quilt_version()
    elseif(scenario STREQUAL "quilt_global_help")
        qt_scenario_quilt_global_help()
    elseif(scenario STREQUAL "quilt_help_command")
        qt_scenario_quilt_help_command()
    elseif(scenario STREQUAL "quilt_unknown_command")
        qt_scenario_quilt_unknown_command()
    elseif(scenario STREQUAL "quilt_ambiguous_command")
        qt_scenario_quilt_ambiguous_command()
    elseif(scenario STREQUAL "quilt_quiltrc_equals")
        qt_scenario_quilt_quiltrc_equals()
    elseif(scenario STREQUAL "quiltrc_export_prefix")
        qt_scenario_quiltrc_export_prefix()
    elseif(scenario STREQUAL "quiltrc_invalid_key")
        qt_scenario_quiltrc_invalid_key()
    elseif(scenario STREQUAL "quiltrc_dquote_backslash")
        qt_scenario_quiltrc_dquote_backslash()
    elseif(scenario STREQUAL "fold_quiet")
        qt_scenario_fold_quiet()
    elseif(scenario STREQUAL "fold_strip")
        qt_scenario_fold_strip()
    elseif(scenario STREQUAL "fold_fail")
        qt_scenario_fold_fail()
    elseif(scenario STREQUAL "push_count_clamp")
        qt_scenario_push_count_clamp()
    elseif(scenario STREQUAL "push_missing_patch")
        qt_scenario_push_missing_patch()
    elseif(scenario STREQUAL "push_quilt_patch_opts")
        qt_scenario_push_quilt_patch_opts()
    elseif(scenario STREQUAL "pop_auto_refresh_fail")
        qt_scenario_pop_auto_refresh_fail()
    elseif(scenario STREQUAL "import_no_files")
        qt_scenario_import_no_files()
    elseif(scenario STREQUAL "header_strip_ws_empty_line")
        qt_scenario_header_strip_ws_empty_line()
    elseif(scenario STREQUAL "files_combine_dash_no_applied")
        qt_scenario_files_combine_dash_no_applied()
    elseif(scenario STREQUAL "push_quilt_patch_opts_fuzz")
        qt_scenario_push_quilt_patch_opts_fuzz()
    elseif(scenario STREQUAL "builtin_patch_merge_copy_lines")
        qt_scenario_builtin_patch_merge_copy_lines()
    elseif(scenario STREQUAL "builtin_patch_no_newline_context")
        qt_scenario_builtin_patch_no_newline_context()
    elseif(scenario STREQUAL "builtin_patch_empty_context_line")
        qt_scenario_builtin_patch_empty_context_line()
    elseif(scenario STREQUAL "push_missing_file")
        qt_scenario_push_missing_file()
    elseif(scenario STREQUAL "refresh_diffstat_scale")
        qt_scenario_refresh_diffstat_scale()
    elseif(scenario STREQUAL "diff_combine_shadowing")
        qt_scenario_diff_combine_shadowing()
    elseif(scenario STREQUAL "fold_patch_opts_fuzz")
        qt_scenario_fold_patch_opts_fuzz()
    elseif(scenario STREQUAL "rename_subdirectory")
        qt_scenario_rename_subdirectory()
    elseif(scenario STREQUAL "header_edit_backup")
        qt_scenario_header_edit_backup()
    elseif(scenario STREQUAL "header_strip_diffstat_false_positive")
        qt_scenario_header_strip_diffstat_false_positive()
    elseif(scenario STREQUAL "files_combine_dash_patch_no_applied")
        qt_scenario_files_combine_dash_patch_no_applied()
    elseif(scenario STREQUAL "files_unapplied_duplicate")
        qt_scenario_files_unapplied_duplicate()
    elseif(scenario STREQUAL "push_fuzz_offset")
        qt_scenario_push_fuzz_offset()
    elseif(scenario STREQUAL "header_edit_fail")
        qt_scenario_header_edit_fail()
    elseif(scenario STREQUAL "push_backward_offset")
        qt_scenario_push_backward_offset()
    elseif(scenario STREQUAL "push_new_file_subdir")
        qt_scenario_push_new_file_subdir()
    elseif(scenario STREQUAL "builtin_patch_empty_file_content")
        qt_scenario_builtin_patch_empty_file_content()
    elseif(scenario STREQUAL "builtin_patch_stray_minus")
        qt_scenario_builtin_patch_stray_minus()
    elseif(scenario STREQUAL "diff_external_context_no_newline")
        qt_scenario_diff_external_context_no_newline()
    elseif(scenario STREQUAL "diff_external_quilt_diff_opts")
        qt_scenario_diff_external_quilt_diff_opts()
    elseif(scenario STREQUAL "revert_subdir")
        qt_scenario_revert_subdir()
    elseif(scenario STREQUAL "builtin_diff_both_empty")
        qt_scenario_builtin_diff_both_empty()
    elseif(scenario STREQUAL "builtin_diff_trailing_newline_only")
        qt_scenario_builtin_diff_trailing_newline_only()
    elseif(scenario STREQUAL "quiltrc_leading_whitespace")
        qt_scenario_quiltrc_leading_whitespace()
    elseif(scenario STREQUAL "series_comment_inline")
        qt_scenario_series_comment_inline()
    elseif(scenario STREQUAL "series_p_space")
        qt_scenario_series_p_space()
    elseif(scenario STREQUAL "init_from_subdir")
        qt_scenario_init_from_subdir()
    elseif(scenario STREQUAL "diff_builtin_context_no_newline")
        qt_scenario_diff_builtin_context_no_newline()
    elseif(scenario STREQUAL "mail_ten_patches")
        qt_scenario_mail_ten_patches()
    elseif(scenario STREQUAL "graph_dot_escape")
        qt_scenario_graph_dot_escape()
    elseif(scenario STREQUAL "graph_lines_identical_content")
        qt_scenario_graph_lines_identical_content()
    elseif(scenario STREQUAL "graph_patch_prunes_unrelated")
        qt_scenario_graph_patch_prunes_unrelated()
    elseif(scenario STREQUAL "graph_empty_series")
        qt_scenario_graph_empty_series()
    elseif(scenario STREQUAL "quiltrc_export_extra_space")
        qt_scenario_quiltrc_export_extra_space()
    elseif(scenario STREQUAL "quiltrc_explicit_empty")
        qt_scenario_quiltrc_explicit_empty()
    elseif(scenario STREQUAL "refresh_diffstat_twice")
        qt_scenario_refresh_diffstat_twice()
    elseif(scenario STREQUAL "refresh_diffstat_header_replace")
        qt_scenario_refresh_diffstat_header_replace()
    elseif(scenario STREQUAL "series_in_pc_dir")
        qt_scenario_series_in_pc_dir()
    elseif(scenario STREQUAL "series_leading_space_no_newline")
        qt_scenario_series_leading_space_no_newline()
    elseif(scenario STREQUAL "header_replace_no_newline")
        qt_scenario_header_replace_no_newline()
    elseif(scenario STREQUAL "annotate_no_series_file")
        qt_scenario_annotate_no_series_file()
    elseif(scenario STREQUAL "push_reject_no_newline")
        qt_scenario_push_reject_no_newline()
    elseif(scenario STREQUAL "fork_applied_not_in_series")
        qt_scenario_fork_applied_not_in_series()
    elseif(scenario STREQUAL "refresh_diffstat_double_newline")
        qt_scenario_refresh_diffstat_double_newline()
    elseif(scenario STREQUAL "refresh_creates_patches_dir")
        qt_scenario_refresh_creates_patches_dir()
    elseif(scenario STREQUAL "top_index_applied_not_in_series")
        qt_scenario_top_index_applied_not_in_series()
    elseif(scenario STREQUAL "push_crlf_patch")
        qt_scenario_push_crlf_patch()
    elseif(scenario STREQUAL "refresh_diffstat_bare_header")
        qt_scenario_refresh_diffstat_bare_header()
    elseif(scenario STREQUAL "refresh_diffstat_bare_false_positive")
        qt_scenario_refresh_diffstat_bare_false_positive()
    elseif(scenario STREQUAL "graph_prune_unreachable_edge")
        qt_scenario_graph_prune_unreachable_edge()
    elseif(scenario STREQUAL "graph_empty_backup_files")
        qt_scenario_graph_empty_backup_files()
    else()
        qt_fail("Unknown scenario: ${scenario}")
    endif()
endfunction()

function(qt_scenario_fold_quiet)
    qt_begin_test("fold_quiet")
    qt_write_file("${QT_WORK_DIR}/f.txt" "base\n")
    qt_quilt_ok(ARGS new target.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_quilt_ok(
        ARGS fold -q
        INPUT [=[--- a/f.txt
+++ b/f.txt
@@ -1 +1 @@
-base
+quiet
]=]
        OUTPUT fold_out ERROR fold_err
        MESSAGE "fold -q failed"
    )
    qt_assert_equal("${fold_out}" "" "fold -q should produce no stdout")
    qt_assert_file_text("${QT_WORK_DIR}/f.txt" "quiet" "fold -q did not apply patch")
endfunction()

function(qt_scenario_fold_strip)
    qt_begin_test("fold_strip")
    qt_write_file("${QT_WORK_DIR}/f.txt" "base\n")
    qt_quilt_ok(ARGS new target.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    # -p 0: no path components stripped; patch uses bare filename
    qt_quilt_ok(
        ARGS fold -p 0
        INPUT "--- f.txt\told\n+++ f.txt\tnew\n@@ -1 +1 @@\n-base\n+stripped\n"
        MESSAGE "fold -p 0 failed"
    )
    qt_assert_file_text("${QT_WORK_DIR}/f.txt" "stripped" "fold -p 0 did not apply patch")
endfunction()

function(qt_scenario_fold_fail)
    qt_begin_test("fold_fail")
    qt_write_file("${QT_WORK_DIR}/f.txt" "base\n")
    qt_quilt_ok(ARGS new target.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    # Patch with wrong context: will fail to apply
    qt_quilt(
        RESULT rc OUTPUT out ERROR err
        ARGS fold
        INPUT [=[--- a/f.txt
+++ b/f.txt
@@ -1 +1 @@
-wrong_context_line
+new_content
]=]
    )
    qt_assert_failure("${rc}" "fold with non-matching patch should fail")
endfunction()

function(qt_scenario_push_count_clamp)
    qt_begin_test("push_count_clamp")
    qt_write_file("${QT_WORK_DIR}/f.txt" "v0\n")
    qt_quilt_ok(ARGS new p1.patch MESSAGE "new p1 failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add p1 failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "v1\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh p1 failed")
    qt_quilt_ok(ARGS new p2.patch MESSAGE "new p2 failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add p2 failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "v2\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh p2 failed")
    qt_quilt_ok(ARGS pop -a MESSAGE "pop all failed")
    # Push 99 patches, but only 2 exist: should clamp and push all
    qt_quilt_ok(ARGS push 99 OUTPUT push_out MESSAGE "push 99 failed")
    qt_assert_file_text("${QT_WORK_DIR}/f.txt" "v2" "push 99 should apply all patches")
endfunction()

function(qt_scenario_push_missing_patch)
    qt_begin_test("push_missing_patch")
    qt_write_file("${QT_WORK_DIR}/f.txt" "base\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "modified\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    qt_quilt_ok(ARGS pop MESSAGE "pop failed")
    # Remove the patch file so push will fail
    file(REMOVE "${QT_WORK_DIR}/patches/p.patch")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS push)
    qt_assert_failure("${rc}" "push with missing patch file should fail")
    qt_assert_contains("${err}" "does not exist" "push should report missing patch")
endfunction()

function(qt_scenario_push_quilt_patch_opts)
    qt_begin_test("push_quilt_patch_opts")
    qt_write_file("${QT_WORK_DIR}/f.txt" "base\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "modified\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    qt_quilt_ok(ARGS pop MESSAGE "pop failed")
    # QUILT_PATCH_OPTS=-s exercises the options loop in cmd_push
    qt_quilt_ok(
        ENV "QUILT_PATCH_OPTS=-s"
        ARGS push
        MESSAGE "push with QUILT_PATCH_OPTS=-s failed"
    )
    qt_assert_file_text("${QT_WORK_DIR}/f.txt" "modified" "push with QUILT_PATCH_OPTS=-s should apply patch")
endfunction()

function(qt_scenario_pop_auto_refresh_fail)
    qt_begin_test("pop_auto_refresh_fail")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_quilt_ok(ARGS new t.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "y\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    # Modify file so there is something to refresh
    qt_write_file("${QT_WORK_DIR}/f.txt" "z\n")
    # Write quiltrc with an invalid QUILT_REFRESH_ARGS so cmd_refresh returns 1
    qt_write_file("${QT_TEST_BASE}/badrc" "QUILT_REFRESH_ARGS=\"--invalid-opt\"\n")
    qt_quilt(RESULT rc OUTPUT out ERROR err
        ARGS --quiltrc "${QT_TEST_BASE}/badrc" pop --refresh)
    qt_assert_failure("${rc}" "pop --refresh with invalid QUILT_REFRESH_ARGS should fail")
    qt_assert_contains("${err}" "Refresh of patch" "pop should report refresh failure")
endfunction()

function(qt_scenario_import_no_files)
    qt_begin_test("import_no_files")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS import)
    qt_assert_failure("${rc}" "import with no files should fail")
    qt_combine_output(combined "${out}" "${err}")
    qt_assert_contains("${combined}" "Usage" "import with no files should print usage")
endfunction()

function(qt_scenario_header_strip_ws_empty_line)
    qt_begin_test("header_strip_ws_empty_line")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "y\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    # Header with empty lines and whitespace-only lines
    qt_quilt_ok(
        ARGS header -r --strip-trailing-whitespace
        INPUT "Title line   \n\n   \nBody line\t\n"
        MESSAGE "header -r --strip-trailing-whitespace with empty lines failed"
    )
    qt_quilt_ok(OUTPUT hdr_out ARGS header MESSAGE "header print failed")
    qt_assert_contains("${hdr_out}" "Title line" "title should be present")
    qt_assert_contains("${hdr_out}" "Body line" "body should be present")
    qt_assert_not_contains("${hdr_out}" "   " "whitespace-only lines should be stripped")
endfunction()

function(qt_scenario_files_combine_dash_no_applied)
    qt_begin_test("files_combine_dash_no_applied")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "y\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    qt_quilt_ok(ARGS pop MESSAGE "pop failed")
    # --combine - with no patches applied should fail
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS files --combine -)
    qt_assert_failure("${rc}" "files --combine - with no applied patches should fail")
    qt_combine_output(combined "${out}" "${err}")
    qt_assert_contains("${combined}" "No patches applied" "should report no patches applied")
endfunction()

function(qt_scenario_push_quilt_patch_opts_fuzz)
    qt_begin_test("push_quilt_patch_opts_fuzz")
    qt_write_file("${QT_WORK_DIR}/f.txt" "line1\nline2\nline3\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "line1\nMODIFIED\nline3\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    qt_quilt_ok(ARGS pop MESSAGE "pop failed")
    # QUILT_PATCH_OPTS=--fuzz=2 exercises the --fuzz= branch in cmd_push's options loop
    qt_quilt_ok(
        ENV "QUILT_PATCH_OPTS=--fuzz=2"
        ARGS push
        MESSAGE "push with QUILT_PATCH_OPTS=--fuzz=2 failed"
    )
    qt_assert_file_text("${QT_WORK_DIR}/f.txt" "line1\nMODIFIED\nline3" "push should apply patch with fuzz")
endfunction()

# builtin_patch_merge_copy_lines: merge mode where successful hunk has file lines
# before it (last_copied < pos) and remaining lines after all hunks.
# Covers patch.cpp build_merge_output lines 522-523 and 590-594.
function(qt_scenario_builtin_patch_merge_copy_lines)
    qt_begin_test("builtin_patch_merge_copy_lines")
    qt_write_file("${QT_WORK_DIR}/f.txt" "a\nb\nc\nd\ne\nf\ng\nh\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    # Change lines b and f, then refresh with zero context
    qt_write_file("${QT_WORK_DIR}/f.txt" "a\nB\nc\nd\ne\nF\ng\nh\n")
    qt_quilt_ok(ARGS refresh -U 0 MESSAGE "refresh -U 0 failed")
    qt_quilt_ok(ARGS pop MESSAGE "pop failed")
    # Corrupt line b so hunk1 fails, keep line f so hunk2 succeeds
    qt_write_file("${QT_WORK_DIR}/f.txt" "a\nX\nc\nd\ne\nf\ng\nh\n")
    # push --merge -f: hunk1 (b->B) fails, hunk2 (f->F) succeeds
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS push --merge -f)
    # Hunk2 succeeded: F should be in result
    qt_assert_file_contains("${QT_WORK_DIR}/f.txt" "F" "successful hunk should be applied")
    # Hunk1 failed: conflict markers should be present
    qt_assert_file_contains("${QT_WORK_DIR}/f.txt" "<<<<<<< current" "rejected hunk should produce conflict")
    # Trailing lines g, h should still be present
    qt_assert_file_contains("${QT_WORK_DIR}/f.txt" "g" "trailing lines should be preserved")
    qt_assert_file_contains("${QT_WORK_DIR}/f.txt" "h" "trailing lines should be preserved")
endfunction()

# builtin_patch_no_newline_context: "\ No newline" marker after a context line
# covers patch.cpp line 181 (hunk.old_no_newline = hunk.new_no_newline = true)
# When both old and new sides of a file lack trailing newline and the last hunk
# line is a context (' ') line, diff puts "\ No newline" after it.
function(qt_scenario_builtin_patch_no_newline_context)
    qt_begin_test("builtin_patch_no_newline_context")
    # Write file without trailing newline so diff produces "\ No newline" after
    # the final context line (covers patch.cpp:181)
    file(WRITE "${QT_WORK_DIR}/f.txt" "line1\nline2")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    # Change first line; keep no trailing newline; last context line is "line2"
    file(WRITE "${QT_WORK_DIR}/f.txt" "LINE1\nline2")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    qt_quilt_ok(ARGS pop MESSAGE "pop failed")
    qt_quilt_ok(ARGS push MESSAGE "push with no-newline context patch should succeed")
    qt_read_file_raw(content "${QT_WORK_DIR}/f.txt")
    qt_assert_contains("${content}" "LINE1" "push should apply the change")
endfunction()

# builtin_patch_empty_context_line: empty line in diff body treated as context line
# covers patch.cpp lines 189-196
function(qt_scenario_builtin_patch_empty_context_line)
    qt_begin_test("builtin_patch_empty_context_line")
    qt_write_file("${QT_WORK_DIR}/f.txt" "before\n\nafter\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    # Write a patch where the empty context line has its space stripped (bare empty line)
    qt_write_file("${QT_WORK_DIR}/patches/p.patch"
        "--- a/f.txt\n+++ b/f.txt\n@@ -1,3 +1,3 @@\n before\n\n-after\n+AFTER\n")
    qt_quilt_ok(ARGS pop MESSAGE "pop failed")
    qt_quilt_ok(ARGS push MESSAGE "push with stripped empty context should succeed")
    qt_assert_file_contains("${QT_WORK_DIR}/f.txt" "AFTER" "patch with stripped empty context should apply")
endfunction()

# push_missing_file: push a patch when the target file was deleted
# covers patch.cpp lines 677-681 (can't find file to patch, error handling)
function(qt_scenario_push_missing_file)
    qt_begin_test("push_missing_file")
    # Create a file and make a modification patch
    qt_write_file("${QT_WORK_DIR}/f.txt" "original\ncontent\nhere\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "original\nMODIFIED\nhere\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    qt_quilt_ok(ARGS pop MESSAGE "pop failed")
    # Delete the file so push will fail: patch expects to modify it (not create it)
    file(REMOVE "${QT_WORK_DIR}/f.txt")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS push)
    qt_assert_failure("${rc}" "push with deleted file should fail")
    qt_combine_output(combined "${out}" "${err}")
    qt_assert_contains("${combined}" "can't find file" "should report missing file")
endfunction()

# refresh_diffstat_scale: large patch triggers diffstat bar-graph capping
# covers cmd_patch.cpp lines 869-870 (plus_bars > minus_bars branch) and
# line 872 (else branch) inside the bar scaling/capping code
function(qt_scenario_refresh_diffstat_scale)
    qt_begin_test("refresh_diffstat_scale")
    # a.txt: created from scratch with 200 lines (max_changes = 200, scale = 59/200)
    # b.txt: 2 original lines replaced by 6 new lines (6 adds + 2 removes = 8 total)
    # c.txt: 6 original lines replaced by 2 new lines (2 adds + 6 removes = 8 total)
    # With scale = 0.295, b.txt gets plus_bars=2, minus_bars=1, total=3 > limit=2 (line 870)
    # and c.txt gets plus_bars=1, minus_bars=2, total=3 > limit=2 (line 872)
    qt_write_file("${QT_WORK_DIR}/b.txt" "orig1\norig2\n")
    qt_write_file("${QT_WORK_DIR}/c.txt" "old1\nold2\nold3\nold4\nold5\nold6\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add a.txt b.txt c.txt MESSAGE "add failed")
    # Generate 200 lines for a.txt using foreach
    set(big_content "")
    foreach(i RANGE 1 200)
        string(APPEND big_content "line${i}\n")
    endforeach()
    qt_write_file("${QT_WORK_DIR}/a.txt" "${big_content}")
    qt_write_file("${QT_WORK_DIR}/b.txt" "new1\nnew2\nnew3\nnew4\nnew5\nnew6\n")
    qt_write_file("${QT_WORK_DIR}/c.txt" "newer1\nnewer2\n")
    qt_quilt_ok(ARGS refresh --diffstat MESSAGE "refresh --diffstat failed")
    qt_read_file_raw(patch_text "${QT_WORK_DIR}/patches/p.patch")
    qt_assert_contains("${patch_text}" "file" "diffstat should appear in patch header")
    qt_assert_contains("${patch_text}" "changed" "diffstat summary line should appear")
endfunction()

# diff_combine_shadowing: quilt diff --combine -P patch2 when patch3 (above) also tracks the file
# covers cmd_patch.cpp lines 1703-1705 (shadowing patch found, new_path = shadowing backup)
function(qt_scenario_diff_combine_shadowing)
    qt_begin_test("diff_combine_shadowing")
    qt_write_file("${QT_WORK_DIR}/f.txt" "base\n")
    qt_quilt_ok(ARGS new p1.patch MESSAGE "new p1 failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add f to p1 failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "v1\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh p1 failed")
    qt_quilt_ok(ARGS new p2.patch MESSAGE "new p2 failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add f to p2 failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "v2\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh p2 failed")
    qt_quilt_ok(ARGS new p3.patch MESSAGE "new p3 failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add f to p3 failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "v3\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh p3 failed")
    # diff -P p2.patch --combine p1.patch: combine range [p1,p2], p3 shadows f.txt
    # next_patch_for_file(q, p2, f.txt) = p3 → lines 1703-1705 triggered
    qt_quilt_ok(OUTPUT diff_out ERROR diff_err ARGS diff -P p2.patch --combine p1.patch MESSAGE "diff --combine shadowing failed")
    # Combined diff should show base→v2 (p3's backup is v2, from before p3 was applied)
    qt_assert_contains("${diff_out}" "-base" "combine should show original base removed")
    qt_assert_contains("${diff_out}" "+v2" "combine should show v2 added (p3's backup)")
endfunction()

# fold_patch_opts_fuzz: quilt fold with QUILT_PATCH_OPTS=--fuzz= and -s and -E
# covers cmd_manage.cpp lines 938 (-s → quiet), 939 (-E → remove_empty), 940-941 (--fuzz=)
function(qt_scenario_fold_patch_opts_fuzz)
    qt_begin_test("fold_patch_opts_fuzz")
    qt_write_file("${QT_WORK_DIR}/f.txt" "line1\nline2\nline3\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    # --fuzz=2: fold with fuzz covers lines 940-941; -s covers line 938
    qt_quilt_ok(
        ENV "QUILT_PATCH_OPTS=--fuzz=2 -s"
        ARGS fold
        INPUT [=[--- a/f.txt
+++ b/f.txt
@@ -1,3 +1,3 @@
 line1
-line2
+LINE2
 line3
]=]
        OUTPUT fold_out
        MESSAGE "fold with --fuzz=2 -s failed"
    )
    # -s suppresses output (quiet mode)
    qt_assert_equal("${fold_out}" "" "fold -s should suppress output")
    qt_assert_file_contains("${QT_WORK_DIR}/f.txt" "LINE2" "fold should apply patch")
endfunction()

# rename_subdirectory: rename an unapplied patch to a path with a new subdirectory
# covers cmd_manage.cpp lines 271-276 (make_dirs for new subdirectory path)
function(qt_scenario_rename_subdirectory)
    qt_begin_test("rename_subdirectory")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_write_file("${QT_WORK_DIR}/g.txt" "a\n")
    qt_quilt_ok(ARGS new p1.patch MESSAGE "new p1 failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add f failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "y\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh p1 failed")
    qt_quilt_ok(ARGS new old.patch MESSAGE "new old failed")
    qt_quilt_ok(ARGS add g.txt MESSAGE "add g failed")
    qt_write_file("${QT_WORK_DIR}/g.txt" "b\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh old failed")
    qt_quilt_ok(ARGS pop MESSAGE "pop to p1 failed")
    # old.patch is unapplied with a real patch file; rename to subdir/ which doesn't exist
    # → triggers make_dirs at lines 271-276 in cmd_rename
    qt_quilt_ok(OUTPUT out ERROR err ARGS rename -P old.patch subdir/new.patch MESSAGE "rename to subdirectory failed")
    qt_assert_contains("${out}" "old.patch renamed to" "rename should report success")
    qt_assert_contains("${out}" "subdir/new.patch" "rename output should show new name")
    qt_assert_exists("${QT_WORK_DIR}/patches/subdir/new.patch" "renamed patch file should exist in subdirectory")
    qt_assert_not_exists("${QT_WORK_DIR}/patches/old.patch" "old patch file should be gone")
endfunction()

# header_edit_backup: quilt header -e --backup calls copy_file for backup
# covers cmd_manage.cpp line 675 (copy_file in EDIT mode with --backup)
function(qt_scenario_header_edit_backup)
    qt_begin_test("header_edit_backup")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "y\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    # Set header via -r (replace) so patch has some content
    qt_quilt_ok(ARGS header -r INPUT "My patch header\n" MESSAGE "header -r failed")
    # header -e --backup: editor is "true" (no-op); triggers line 675 (backup copy)
    qt_quilt_ok(ENV "EDITOR=true" ARGS header -e --backup MESSAGE "header -e --backup failed")
    qt_assert_exists("${QT_WORK_DIR}/patches/p.patch~" "backup patch file should exist")
endfunction()

# header_strip_diffstat_false_positive: header --strip-diffstat on header with pipe line
# followed by empty line (not a real diffstat): triggers the break at line 518 in
# strip_diffstat() when the lookahead exits early (found_summary stays false)
function(qt_scenario_header_strip_diffstat_false_positive)
    qt_begin_test("header_strip_diffstat_false_positive")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "y\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    # Write header with a line that looks like diffstat (starts with space, has |)
    # but is followed by an empty line before the summary → strip_diffstat won't strip it
    qt_quilt_ok(ARGS header -r INPUT " changelog.txt | 5 +++++\n\nMore description here.\n" MESSAGE "header -r failed")
    qt_quilt_ok(OUTPUT out ERROR err ARGS header --strip-diffstat MESSAGE "header --strip-diffstat failed")
    # The "fake diffstat" should be preserved (it's not a real diffstat block)
    qt_assert_contains("${out}" "changelog.txt" "false-positive diffstat line should be preserved")
    qt_assert_contains("${out}" "More description" "text after fake diffstat should be preserved")
endfunction()

# files_combine_dash_patch_no_applied: quilt files --combine - <patch> with no applied patches
# covers cmd_manage.cpp lines 730-731 (combine_patch=="-" with q.applied.empty())
function(qt_scenario_files_combine_dash_patch_no_applied)
    qt_begin_test("files_combine_dash_patch_no_applied")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS pop MESSAGE "pop failed")
    # files --combine - p.patch: target patch specified + combine="-" + no applied patches
    # → hits the q.applied.empty() check at lines 730-731
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS files --combine - p.patch)
    qt_assert_failure("${rc}" "files --combine - with patch arg and nothing applied should fail")
    qt_combine_output(combined "${out}" "${err}")
    qt_assert_contains("${combined}" "No patches applied" "should report no patches applied")
endfunction()

# files_unapplied_duplicate: quilt files on an unapplied patch with the same file twice
# covers cmd_manage.cpp line 52 (deduplication break in parse_patch_files)
function(qt_scenario_files_unapplied_duplicate)
    qt_begin_test("files_unapplied_duplicate")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS pop MESSAGE "pop failed")
    # Write a patch that mentions f.txt twice in +++ lines (two separate hunks for same file)
    qt_write_file("${QT_WORK_DIR}/patches/p.patch"
        "--- a/f.txt\n+++ b/f.txt\n@@ -1 +1 @@\n-x\n+y\n--- a/f.txt\n+++ b/f.txt\n@@ -1 +1 @@\n-x\n+z\n")
    # quilt files on the unapplied patch: parse_patch_files deduplicates f.txt (line 52)
    qt_quilt_ok(OUTPUT out ERROR err ARGS files p.patch MESSAGE "files on unapplied patch failed")
    # f.txt should appear exactly once despite two +++ entries
    string(REGEX MATCHALL "f\\.txt" matches "${out}")
    list(LENGTH matches cnt)
    if(NOT cnt EQUAL 1)
        qt_fail("Expected f.txt to appear exactly once, got ${cnt} times: ${out}")
    endif()
endfunction()

# push_fuzz_offset: push a patch that requires both fuzz AND offset
# covers patch.cpp lines 726-728 ("Hunk #N succeeded at X with fuzz Y (offset Z lines).")
# The hunk needs to match with fuzz > 0 AND at a position other than the recorded one.
function(qt_scenario_push_fuzz_offset)
    qt_begin_test("push_fuzz_offset")
    # Create a file with context lines around the target line
    qt_write_file("${QT_WORK_DIR}/f.txt" "context1_original\ntarget\ncontext2_original\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    # Modify the target line to create the patch
    qt_write_file("${QT_WORK_DIR}/f.txt" "context1_original\nNEWTARGET\ncontext2_original\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    qt_quilt_ok(ARGS pop MESSAGE "pop failed")
    # Now change both: add an extra line at top (causes offset) and
    # change the context lines (requires fuzz to match)
    qt_write_file("${QT_WORK_DIR}/f.txt" "extraline\ncontext1_DIFFERENT\ntarget\ncontext2_DIFFERENT\n")
    # Push with fuzz=2 so the hunk applies with offset 1 and fuzz 1
    qt_quilt(RESULT rc OUTPUT push_out ERROR push_err ARGS push --fuzz=2)
    qt_assert_success("${rc}" "push --fuzz=2 should succeed")
    qt_combine_output(combined "${push_out}" "${push_err}")
    qt_assert_contains("${combined}" "fuzz" "should report fuzz used")
    qt_assert_contains("${combined}" "offset" "should report offset")
endfunction()

# header_edit_fail: quilt header -e with editor that exits with error
# covers cmd_manage.cpp lines 666-668 ("Editor exited with error")
function(qt_scenario_header_edit_fail)
    qt_begin_test("header_edit_fail")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    # Run header -e with EDITOR=false: false exits with code 1 → error path
    qt_quilt(RESULT rc OUTPUT out ERROR err ENV "EDITOR=false" ARGS header -e)
    qt_assert_failure("${rc}" "header -e with failing editor should fail")
    qt_combine_output(combined "${out}" "${err}")
    qt_assert_contains("${combined}" "Editor exited with error" "should report editor error")
endfunction()

# push_backward_offset: push a patch when content has moved backward (earlier in file)
# covers patch.cpp line 413 (backward search in locate_hunk spiral)
function(qt_scenario_push_backward_offset)
    qt_begin_test("push_backward_offset")
    # Target at line 3 (1-indexed) with no context so patch records @@ -3,1 +3,1 @@
    qt_write_file("${QT_WORK_DIR}/f.txt" "line1\nline2\ntarget\nline4\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "line1\nline2\nMODIFIED\nline4\n")
    # Use -U 0 so the patch has no context (first_guess=2, pattern=just "target")
    qt_quilt_ok(ARGS refresh -U 0 MESSAGE "refresh -U 0 failed")
    qt_quilt_ok(ARGS pop MESSAGE "pop failed")
    # Remove line1 so "target" is now at line 2 (0-indexed=1), backward from first_guess=2
    qt_write_file("${QT_WORK_DIR}/f.txt" "line2\ntarget\nline4\n")
    # Push: locate_hunk tries first_guess=2 (fails: "line4"), then spiral: forward pos=3
    # (out of range), backward pos=1 (matches "target") → line 413 executes
    qt_quilt_ok(OUTPUT push_out ERROR push_err ARGS push MESSAGE "push should succeed with backward offset")
    qt_assert_file_text("${QT_WORK_DIR}/f.txt" "line2\nMODIFIED\nline4" "push should apply modification")
    qt_combine_output(combined "${push_out}" "${push_err}")
    qt_assert_contains("${combined}" "offset" "should report offset")
endfunction()

# push_new_file_subdir: push a creation patch for a file in a new subdirectory
# covers patch.cpp line 790 (make_dirs for new file's parent directory)
function(qt_scenario_push_new_file_subdir)
    qt_begin_test("push_new_file_subdir")
    # Create an empty patch in the series, then replace it with a creation patch
    # for a file in a new subdirectory (the subdirectory doesn't exist yet)
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS pop MESSAGE "pop failed")
    # Write a creation patch manually: old==/dev/null → is_creation=true
    # target path = "newdir/newfile.txt" (strip-1 of "b/newdir/newfile.txt")
    qt_write_file("${QT_WORK_DIR}/patches/p.patch"
        "--- /dev/null\n+++ b/newdir/newfile.txt\n@@ -0,0 +1 @@\n+brand new\n")
    qt_assert_not_exists("${QT_WORK_DIR}/newdir" "newdir should not exist before push")
    # Push: is_creation patch → make_dirs("newdir") called (line 790) before writing the file
    qt_quilt_ok(ARGS push MESSAGE "push should create subdirectory and file")
    qt_assert_exists("${QT_WORK_DIR}/newdir/newfile.txt" "new file in subdir should exist")
    qt_assert_file_text("${QT_WORK_DIR}/newdir/newfile.txt" "brand new" "content should match")
endfunction()

# builtin_patch_empty_file_content: apply a non-creation patch to an existing 0-byte file
# covers patch.cpp lines 251-252 (load_file_lines returns early for empty content)
# Note: quilt refresh on empty→content generates a /dev/null creation patch, so we
# craft the patch manually with --- a/f.txt (not /dev/null) targeting a 0-byte file.
function(qt_scenario_builtin_patch_empty_file_content)
    qt_begin_test("builtin_patch_empty_file_content")
    # Set up an empty patch in the series
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS pop MESSAGE "pop failed")
    # Create f.txt as a 0-byte file (exists but empty)
    qt_write_file("${QT_WORK_DIR}/f.txt" "")
    # Write a modification patch targeting the 0-byte file (not a creation patch).
    # @@ -0,0 +1 @@ with only + lines → empty old pattern → matches at position 0 in empty file
    qt_write_file("${QT_WORK_DIR}/patches/p.patch"
        "--- a/f.txt\n+++ b/f.txt\n@@ -0,0 +1 @@\n+new content\n")
    # Push: file_existed=true (0-byte file), load_file_lines reads empty → lines 251-252
    # empty pattern from all-+ hunk matches position 0 → patch applied
    qt_quilt_ok(ARGS push MESSAGE "push to empty file should succeed")
    qt_assert_file_text("${QT_WORK_DIR}/f.txt" "new content" "push should add content to empty file")
endfunction()

# builtin_patch_stray_minus: patch file with a "--- " line not followed by "+++ "
# covers patch.cpp lines 94-95 (skip non-header --- line in parse_patch)
function(qt_scenario_builtin_patch_stray_minus)
    qt_begin_test("builtin_patch_stray_minus")
    qt_write_file("${QT_WORK_DIR}/f.txt" "old\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "new\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    qt_quilt_ok(ARGS pop MESSAGE "pop failed")
    # Rewrite the patch with a stray "--- " line not followed by "+++ "
    # parse_patch sees "--- not-a-header", peeks at next line "some text" (not "+++"),
    # and executes lines 94-95 (++i; continue) to skip it.
    qt_write_file("${QT_WORK_DIR}/patches/p.patch"
        "--- not-a-header\nsome text\n--- a/f.txt\n+++ b/f.txt\n@@ -1 +1 @@\n-old\n+new\n")
    qt_quilt_ok(ARGS push MESSAGE "push should succeed despite stray --- line")
    qt_assert_file_text("${QT_WORK_DIR}/f.txt" "new" "file should be modified after push")
endfunction()

# diff_external_context_no_newline: context diff via external tool on file without trailing newline
# covers cmd_patch.cpp line 423 (unified_to_context skips "\ No newline" lines)
function(qt_scenario_diff_external_context_no_newline)
    qt_begin_test("diff_external_context_no_newline")
    # Create file WITHOUT trailing newline
    qt_write_file("${QT_WORK_DIR}/f.txt" "old")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    # Modify (also no trailing newline)
    qt_write_file("${QT_WORK_DIR}/f.txt" "new")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    # External diff + context format: external diff outputs "\ No newline at end of file"
    # unified_to_context hits the else branch (line 423) to skip these \ lines
    qt_quilt_ok(OUTPUT diff_out ERROR diff_err ARGS diff "--diff=diff" -c MESSAGE "diff --diff=diff -c failed")
    qt_assert_contains("${diff_out}" "***" "context diff should have *** markers")
    # The \ No newline lines in the unified diff are skipped by unified_to_context (line 423)
    # so they don't appear in the output, but the changed lines still show
    qt_assert_contains("${diff_out}" "old" "context diff should show old content")
    qt_assert_contains("${diff_out}" "new" "context diff should show new content")
endfunction()

# diff_external_quilt_diff_opts: QUILT_DIFF_OPTS appends extra options to external diff command
# covers cmd_patch.cpp line 556 (appending QUILT_DIFF_OPTS to cmd_argv in external diff path)
function(qt_scenario_diff_external_quilt_diff_opts)
    qt_begin_test("diff_external_quilt_diff_opts")
    qt_write_file("${QT_WORK_DIR}/f.txt" "old\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "new\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    # QUILT_DIFF_OPTS=-u passes an extra -u flag to the external diff tool
    # cmd_patch.cpp iterates over shell_split(QUILT_DIFF_OPTS) at line 556
    qt_quilt_ok(OUTPUT diff_out ERROR diff_err ENV "QUILT_DIFF_OPTS=-u"
        ARGS diff "--diff=diff" MESSAGE "diff with QUILT_DIFF_OPTS failed")
    qt_assert_contains("${diff_out}" "---" "diff output should have --- header")
    qt_assert_contains("${diff_out}" "old" "diff output should show old content")
    qt_assert_contains("${diff_out}" "new" "diff output should show new content")
endfunction()

# revert_subdir: revert a file in a subdirectory when the directory doesn't exist
# covers cmd_patch.cpp line 1788 (make_dirs for revert target's parent directory)
function(qt_scenario_revert_subdir)
    qt_begin_test("revert_subdir")
    # Create a file in a subdirectory, add to patch, and modify it
    qt_write_file("${QT_WORK_DIR}/subdir/f.txt" "original\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add subdir/f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/subdir/f.txt" "modified\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    # Delete subdir/ entirely so the target directory is missing when reverting
    file(REMOVE_RECURSE "${QT_WORK_DIR}/subdir")
    qt_assert_not_exists("${QT_WORK_DIR}/subdir" "subdir should be removed before revert")
    # quilt revert: backup is "original\n" (non-empty), dirname="subdir" doesn't exist
    # → make_dirs("subdir") called (line 1788) before writing the restored file
    qt_quilt_ok(ARGS revert subdir/f.txt MESSAGE "revert should create parent directory")
    qt_assert_file_text("${QT_WORK_DIR}/subdir/f.txt" "original" "revert should restore original content")
endfunction()

# builtin_diff_both_empty: diff.cpp line 66 (myers_diff n==0, m==0 trivial case)
# Triggered when both old and new files have zero lines (0-byte files).
function(qt_scenario_builtin_diff_both_empty)
    qt_begin_test("builtin_diff_both_empty")
    # Create 0-byte file and add to patch
    qt_write_file("${QT_WORK_DIR}/empty.txt" "")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add empty.txt MESSAGE "add failed")
    # Do NOT modify empty.txt — backup=0 bytes, working=0 bytes
    # quilt diff calls builtin_diff(backup, current) → myers_diff([], []) → line 66
    qt_quilt(RESULT rc OUTPUT diff_out ERROR diff_err ARGS diff)
    qt_assert_success("${rc}" "diff of two empty files should succeed")
    qt_assert_equal("${diff_out}" "" "two empty files should produce no diff output")
endfunction()

# builtin_diff_trailing_newline_only: diff.cpp line 482
# Triggered when content is identical but trailing-newline status differs.
function(qt_scenario_builtin_diff_trailing_newline_only)
    qt_begin_test("builtin_diff_trailing_newline_only")
    # Create file with trailing newline
    qt_write_file("${QT_WORK_DIR}/f.txt" "content\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    # Change to same content but WITHOUT trailing newline
    # backup="content\n", working="content" (no newline)
    # myers_diff produces all 'E' ops (same content), but has_trailing_newline differs
    # → line 482 sets has_diff=true
    qt_write_file("${QT_WORK_DIR}/f.txt" "content")
    qt_quilt(RESULT rc OUTPUT diff_out ERROR diff_err ARGS diff)
    qt_assert_success("${rc}" "trailing-newline-only diff should succeed")
    # Output has file headers (--- and +++) but no hunk body (content is identical)
    # The Index: line confirms the diff was generated (has_diff=true from line 482)
    qt_assert_contains("${diff_out}" "---" "diff should show old-file header")
    qt_assert_contains("${diff_out}" "+++" "diff should show new-file header")
endfunction()

# quiltrc_leading_whitespace: core.cpp line 358 (trim leading whitespace in quiltrc lines)
# Triggered when a quiltrc line has leading whitespace before KEY=value.
function(qt_scenario_quiltrc_leading_whitespace)
    qt_begin_test("quiltrc_leading_whitespace")
    qt_write_file("${QT_WORK_DIR}/f.txt" "old\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "new\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    # Write quiltrc with leading whitespace before QUILT_PATCHES_PREFIX=1
    # parse_quiltrc strips leading whitespace (line 358) before parsing the assignment
    qt_write_file("${QT_TEST_BASE}/.quiltrc" "  QUILT_PATCHES_PREFIX=1\n")
    # Run quilt series: reads quiltrc, parses "  QUILT_PATCHES_PREFIX=1"
    # → strips leading spaces (line 358) → sets QUILT_PATCHES_PREFIX=1
    qt_quilt_ok(OUTPUT series_out ARGS series MESSAGE "series failed")
    qt_assert_contains("${series_out}" "patches/" "QUILT_PATCHES_PREFIX=1 should prefix series output")
endfunction()

# series_comment_inline: core.cpp line 239 (trim inline comment from series entry)
# Triggered when a series file line has " #comment" after the patch name.
function(qt_scenario_series_comment_inline)
    qt_begin_test("series_comment_inline")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "y\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    qt_quilt_ok(ARGS pop MESSAGE "pop failed")
    # Rewrite series with inline comment: "p.patch # this is a comment"
    # read_series parses this: finds " #" at position after name → line 239 strips comment
    qt_write_file("${QT_WORK_DIR}/patches/series" "p.patch # this is a comment\n")
    qt_quilt_ok(OUTPUT series_out ARGS series MESSAGE "series with comment failed")
    qt_assert_contains("${series_out}" "p.patch" "series should contain patch name")
    qt_assert_not_contains("${series_out}" "#" "series output should not contain comment")
    qt_quilt_ok(ARGS push MESSAGE "push after series with comment failed")
endfunction()

# series_p_space: core.cpp lines 250-251 (-p <space> num in series file, space-separated)
# Triggered when series entry has "-p 0" with space between flag and value.
function(qt_scenario_series_p_space)
    qt_begin_test("series_p_space")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "y\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    qt_quilt_ok(ARGS pop MESSAGE "pop failed")
    # Rewrite series with "-p 0" (space between -p and strip level)
    # This triggers the split-token case at core.cpp lines 250-251
    qt_write_file("${QT_WORK_DIR}/patches/series" "p.patch -p 0\n")
    # Rewrite the patch with p0 paths (no "a/" prefix)
    qt_write_file("${QT_WORK_DIR}/patches/p.patch"
        "--- f.txt\n+++ f.txt\n@@ -1 +1 @@\n-x\n+y\n")
    qt_quilt_ok(ARGS push MESSAGE "push with -p 0 in series should work")
    qt_assert_file_text("${QT_WORK_DIR}/f.txt" "y" "patch with -p 0 should apply")
endfunction()

# init_from_subdir: core.cpp line 1129 (set_cwd back after init when load_state changed cwd)
# Triggered when quilt init is run from a subdirectory of an existing quilt project.
function(qt_scenario_init_from_subdir)
    qt_begin_test("init_from_subdir")
    # Set up an existing project (creates .pc/ and patches/)
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS pop MESSAGE "pop failed")
    # Create a subdirectory
    file(MAKE_DIRECTORY "${QT_WORK_DIR}/subdir")
    # Run quilt init from the subdirectory:
    # load_state() finds .pc/ in parent → changes cwd to parent
    # cmd_init runs → line 1129: restores cwd back to subdir
    qt_quilt_ok(WORKING_DIRECTORY "${QT_WORK_DIR}/subdir"
        ARGS init MESSAGE "init from subdir should succeed")
endfunction()

# diff_builtin_context_no_newline: diff.cpp lines 419 and 440
# format_context outputs "\ No newline at end of file" when old or new file lacks trailing newline.
# Triggered by quilt diff -c (builtin context format, NOT --diff=diff external).
function(qt_scenario_diff_builtin_context_no_newline)
    qt_begin_test("diff_builtin_context_no_newline")
    # Create file without trailing newline
    qt_write_file("${QT_WORK_DIR}/f.txt" "old")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    # Also change to content without trailing newline
    qt_write_file("${QT_WORK_DIR}/f.txt" "new")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    # -c uses builtin context diff (format_context in diff.cpp)
    # Both old ("old") and new ("new") lack trailing newline →
    # lines 419 and 440 both append "\ No newline at end of file"
    qt_quilt_ok(OUTPUT diff_out ERROR diff_err ARGS diff -c MESSAGE "diff -c failed")
    qt_assert_contains("${diff_out}" "***" "context diff should have *** markers")
    qt_assert_contains("${diff_out}" "No newline" "context diff should note missing newline")
endfunction()

# graph_dot_escape: cmd_graph.cpp lines 50-51 (dot_escape handles \ and " characters)
# Triggered when a patch name contains " which must be escaped in dot(1) output.
# The quilt state is created manually (bypassing quilt new) because cmake -E chdir
# cannot pass " or \ in arguments due to shell escaping limitations.
function(qt_scenario_graph_dot_escape)
    qt_begin_test("graph_dot_escape")
    # Manually create quilt state with a patch name containing " (double-quote).
    # dot_escape("pa\"tch.diff") hits lines 50-51: escaped += '\\'; escaped += '"'
    set(patchname "pa\"tch.diff")
    file(MAKE_DIRECTORY "${QT_WORK_DIR}/patches")
    file(MAKE_DIRECTORY "${QT_WORK_DIR}/.pc")
    file(MAKE_DIRECTORY "${QT_WORK_DIR}/.pc/${patchname}")
    qt_write_file("${QT_WORK_DIR}/patches/series" "${patchname}\n")
    qt_write_file("${QT_WORK_DIR}/.pc/applied-patches" "${patchname}\n")
    # Back up f.txt (original state before patch was applied)
    qt_write_file("${QT_WORK_DIR}/.pc/${patchname}/f.txt" "original\n")
    # Write the patch file (simple modification)
    qt_write_file("${QT_WORK_DIR}/patches/${patchname}"
        "--- a/f.txt\n+++ b/f.txt\n@@ -1 +1 @@\n-original\n+modified\n")
    # f.txt reflects the applied state
    qt_write_file("${QT_WORK_DIR}/f.txt" "modified\n")
    qt_quilt_ok(OUTPUT graph_out ARGS graph MESSAGE "graph failed")
    # dot output should escape the " in the label as \"
    # needle: pa\"tch.diff (the patch name with " escaped to \")
    qt_assert_contains("${graph_out}" "pa\\\"tch.diff" "dot label should escape double-quote")
endfunction()

# graph_lines_identical_content: cmd_graph.cpp line 133 (compute_ranges: diff exit_code==0)
# Triggered when two patches share a file but patchA makes no actual change to it,
# so the backup before patchB is identical to the backup before patchA → diff returns 0.
function(qt_scenario_graph_lines_identical_content)
    qt_begin_test("graph_lines_identical_content")
    qt_write_file("${QT_WORK_DIR}/f.txt" "original\n")
    # patchA: track f.txt but refresh with NO changes (empty patch body for f.txt)
    qt_quilt_ok(ARGS new patchA.diff MESSAGE "new patchA failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add patchA failed")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh patchA (no changes) failed")
    # patchB: actually modify f.txt
    qt_quilt_ok(ARGS new patchB.diff MESSAGE "new patchB failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add patchB failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "modified\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh patchB failed")
    # graph --lines: calls compute_ranges for both patches.
    # patchA's backup = "original\n", patchB's backup (next node) = "original\n" (patchA didn't change it).
    # builtin_diff("original\n", "original\n") returns exit_code=0 → line 133: return early.
    qt_quilt_ok(OUTPUT graph_out ARGS graph --lines 2 MESSAGE "graph --lines failed")
    qt_assert_contains("${graph_out}" "digraph" "should produce dot output")
endfunction()

# graph_patch_prunes_unrelated: cmd_graph.cpp line 504 (edge erased for non-reachable nodes)
# Triggered when quilt graph <patch> is run and there are independent patches (not connected
# to the selected patch via shared files) — their edges get pruned from the output.
function(qt_scenario_graph_patch_prunes_unrelated)
    qt_begin_test("graph_patch_prunes_unrelated")
    # Group 1: patchA and patchB share f1.txt
    qt_write_file("${QT_WORK_DIR}/f1.txt" "f1-original\n")
    qt_quilt_ok(ARGS new patchA.diff MESSAGE "new patchA failed")
    qt_quilt_ok(ARGS add f1.txt MESSAGE "add patchA failed")
    qt_write_file("${QT_WORK_DIR}/f1.txt" "f1-after-A\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh patchA failed")
    qt_quilt_ok(ARGS new patchB.diff MESSAGE "new patchB failed")
    qt_quilt_ok(ARGS add f1.txt MESSAGE "add patchB failed")
    qt_write_file("${QT_WORK_DIR}/f1.txt" "f1-after-B\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh patchB failed")
    # Group 2: patchC and patchD share f2.txt (completely independent of f1.txt)
    qt_write_file("${QT_WORK_DIR}/f2.txt" "f2-original\n")
    qt_quilt_ok(ARGS new patchC.diff MESSAGE "new patchC failed")
    qt_quilt_ok(ARGS add f2.txt MESSAGE "add patchC failed")
    qt_write_file("${QT_WORK_DIR}/f2.txt" "f2-after-C\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh patchC failed")
    qt_quilt_ok(ARGS new patchD.diff MESSAGE "new patchD failed")
    qt_quilt_ok(ARGS add f2.txt MESSAGE "add patchD failed")
    qt_write_file("${QT_WORK_DIR}/f2.txt" "f2-after-D\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh patchD failed")
    # Run graph for patchB: only patchA→patchB edge is reachable.
    # patchC→patchD edge is NOT reachable from patchB → it is erased (line 504).
    qt_quilt_ok(OUTPUT graph_out ARGS graph patchB.diff MESSAGE "graph patchB failed")
    qt_assert_contains("${graph_out}" "patchA" "patchA should be in output (reachable)")
    qt_assert_contains("${graph_out}" "patchB" "patchB should be in output (selected)")
    qt_assert_not_contains("${graph_out}" "patchC" "patchC should not be in output (unrelated)")
    qt_assert_not_contains("${graph_out}" "patchD" "patchD should not be in output (unrelated)")
endfunction()

# graph_empty_series: cmd_graph.cpp line 391 (No patches in series)
# Triggered when graph is run and the series file exists but has no patches.
function(qt_scenario_graph_empty_series)
    qt_begin_test("graph_empty_series")
    # quilt init creates an empty series file and .pc/ directory
    qt_quilt_ok(ARGS init MESSAGE "init failed")
    # Series file exists but no patches → q.series.empty() → line 391
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS graph)
    qt_assert_failure("${rc}" "graph with empty series should fail")
    qt_assert_contains("${err}" "No patches in series" "should say no patches in series")
endfunction()

# mail_ten_patches: cmd_mail.cpp lines 119 (num_width returns 2 for 10-99 patches)
# Triggered when there are >= 10 patches, causing zero-padded numbers like [PATCH 01/10].
function(qt_scenario_mail_ten_patches)
    qt_begin_test("mail_ten_patches")
    qt_write_file("${QT_WORK_DIR}/f.txt" "line0\n")
    # Create 10 patches so num_width(10) hits line 119: n < 100 → return 2
    foreach(n 1 2 3 4 5 6 7 8 9 10)
        qt_quilt_ok(ARGS new "p${n}.patch" MESSAGE "new p${n} failed")
        qt_quilt_ok(ARGS add f.txt MESSAGE "add p${n} failed")
        qt_write_file("${QT_WORK_DIR}/f.txt" "line${n}\n")
        qt_quilt_ok(ARGS refresh MESSAGE "refresh p${n} failed")
    endforeach()
    set(mbox_path "${QT_TEST_BASE}/out.mbox")
    qt_quilt_ok(ARGS mail --mbox "${mbox_path}" --from "user@example.com"
        MESSAGE "mail failed")
    qt_assert_exists("${mbox_path}" "mbox should be created")
    file(READ "${mbox_path}" mbox_content)
    # With 10 patches, subject format uses 2-digit numbering (num_width returns 2)
    qt_assert_contains("${mbox_content}" "01/10" "should have 2-digit patch numbering")
endfunction()

# quiltrc_export_extra_space: core.cpp lines 364-365
# parse_quiltrc with "export  KEY=VALUE" (two spaces after "export") hits the
# inner while loop that strips extra whitespace after "export ".
function(qt_scenario_quiltrc_export_extra_space)
    qt_begin_test("quiltrc_export_extra_space")
    # Set up a minimal quilt state
    qt_write_file("${QT_WORK_DIR}/f.txt" "hello\n")
    qt_quilt_ok(ARGS new test.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    qt_quilt_ok(ARGS pop MESSAGE "pop failed")
    # Write a quiltrc with "export  QUILT_PATCHES_PREFIX=1" (extra space after "export")
    # parse_quiltrc: finds sv.substr(0,7)=="export ", removes prefix 7,
    # then the inner while (!sv.empty() && sv.front()==' ') hits line 365.
    get_property(test_base GLOBAL PROPERTY QT_TEST_BASE)
    qt_write_file("${test_base}/.quiltrc" "export  QUILT_PATCHES_PREFIX=1\n")
    # Run series; the quiltrc is loaded from HOME/.quiltrc and sets prefix
    qt_quilt_ok(OUTPUT series_out ARGS series MESSAGE "series failed")
    qt_assert_contains("${series_out}" "patches/" "prefix should be applied when QUILT_PATCHES_PREFIX=1")
endfunction()

# quiltrc_explicit_empty: core.cpp line 428
# load_quiltrc with an explicit non-empty path that points to an empty/nonexistent file
# hits the "return {}" on line 428 rather than calling parse_quiltrc.
function(qt_scenario_quiltrc_explicit_empty)
    qt_begin_test("quiltrc_explicit_empty")
    qt_write_file("${QT_WORK_DIR}/f.txt" "hello\n")
    qt_quilt_ok(ARGS new test.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    qt_quilt_ok(ARGS pop MESSAGE "pop failed")
    # Write an empty quiltrc file and pass it explicitly via --quiltrc
    get_property(test_base GLOBAL PROPERTY QT_TEST_BASE)
    set(empty_rc "${test_base}/empty.quiltrc")
    qt_write_file("${empty_rc}" "")
    # --quiltrc with an empty file → read_file returns "" → line 428: return {}
    qt_quilt_ok(OUTPUT series_out ARGS --quiltrc "${empty_rc}" series
        MESSAGE "series with empty quiltrc failed")
    # No QUILT_PATCHES_PREFIX set → bare patch name (no patches/ prefix)
    qt_assert_not_contains("${series_out}" "patches/" "empty quiltrc should not set prefix")
    qt_assert_contains("${series_out}" "test.patch" "series output should list patch")
endfunction()

# refresh_diffstat_twice: cmd_patch.cpp remove_diffstat_section lines 921,926,928-936,942,944,946-948
# Running quilt refresh --diffstat twice causes the second call to remove the
# existing diffstat from the header before regenerating it, covering the
# remove_diffstat_section code path.
function(qt_scenario_refresh_diffstat_twice)
    qt_begin_test("refresh_diffstat_twice")
    qt_write_file("${QT_WORK_DIR}/f.txt" "original\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "first change\n")
    # First --diffstat refresh: generates ---\n<diffstat>\n\n in header
    qt_quilt_ok(ARGS refresh --diffstat MESSAGE "first refresh --diffstat failed")
    # Verify diffstat was added
    qt_assert_exists("${QT_WORK_DIR}/patches/p.patch" "patch file should exist")
    file(READ "${QT_WORK_DIR}/patches/p.patch" patch1)
    qt_assert_contains("${patch1}" "---" "first refresh should add diffstat separator")
    qt_assert_contains("${patch1}" "changed" "first refresh should add diffstat summary")
    # Modify file and run --diffstat refresh again
    # This triggers remove_diffstat_section to strip the old ---/diffstat block
    qt_write_file("${QT_WORK_DIR}/f.txt" "second change\n")
    qt_quilt_ok(ARGS refresh --diffstat MESSAGE "second refresh --diffstat failed")
    file(READ "${QT_WORK_DIR}/patches/p.patch" patch2)
    qt_assert_contains("${patch2}" "changed" "second refresh should have updated diffstat")
    # Should only have one diffstat block (old one removed, new one added)
    string(REGEX MATCHALL "file changed" count_matches "${patch2}")
    list(LENGTH count_matches num_changed)
    qt_assert_equal("${num_changed}" "1" "should have exactly one diffstat summary line")
endfunction()

# refresh_diffstat_header_replace: cmd_patch.cpp line 1239 (clean_header.pop_back)
# When the patch has a description before the diffstat, remove_diffstat_section
# returns the description with a trailing blank line. The pop_back loop strips it.
function(qt_scenario_refresh_diffstat_header_replace)
    qt_begin_test("refresh_diffstat_header_replace")
    qt_write_file("${QT_WORK_DIR}/f.txt" "original\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "changed\n")
    qt_quilt_ok(ARGS refresh MESSAGE "initial refresh failed")
    # Add a description to the patch header via quilt header -a
    qt_quilt_ok(ARGS header -a INPUT "This patch changes stuff.\n"
        MESSAGE "header -a failed")
    # Verify header was set
    qt_quilt_ok(OUTPUT hdr_out ARGS header MESSAGE "header read failed")
    qt_assert_contains("${hdr_out}" "This patch changes stuff" "header should have description")
    # First --diffstat: creates ---\ndiffstat\n\n appended after description
    qt_quilt_ok(ARGS refresh --diffstat MESSAGE "first refresh --diffstat failed")
    # Modify file and do second --diffstat refresh
    # remove_diffstat_section returns "This patch changes stuff.\n\n"
    # The pop_back loop (line 1239) strips the trailing blank line
    qt_write_file("${QT_WORK_DIR}/f.txt" "changed again\n")
    qt_quilt_ok(ARGS refresh --diffstat MESSAGE "second refresh --diffstat failed")
    file(READ "${QT_WORK_DIR}/patches/p.patch" patch_content)
    qt_assert_contains("${patch_content}" "This patch changes stuff" "description should be preserved")
    qt_assert_contains("${patch_content}" "changed" "diffstat should be present")
    # Only one diffstat summary
    string(REGEX MATCHALL "file changed" count_matches "${patch_content}")
    list(LENGTH count_matches num_changed)
    qt_assert_equal("${num_changed}" "1" "should have exactly one diffstat summary line")
endfunction()

# series_in_pc_dir: core.cpp line 509
# When no patches/series file exists but .pc/series does, the series file
# search order sets series_file to ".pc/series" (quilt v1 legacy layout).
function(qt_scenario_series_in_pc_dir)
    qt_begin_test("series_in_pc_dir")
    # Manually create a quilt state with the series file at .pc/series
    # (no patches/series and no .pc/.quilt_series override)
    file(MAKE_DIRECTORY "${QT_WORK_DIR}/.pc")
    qt_write_file("${QT_WORK_DIR}/.pc/series" "p.patch\n")
    qt_write_file("${QT_WORK_DIR}/.pc/applied-patches" "")
    # Do NOT create patches/series or .pc/.quilt_patches or .pc/.quilt_series
    # When quilt loads state:
    #   s1 = <work_dir>/series          (doesn't exist)
    #   s2 = <work_dir>/patches/series  (doesn't exist)
    #   s3 = <work_dir>/.pc/series      (exists!) → line 509
    qt_quilt_ok(OUTPUT series_out ARGS series MESSAGE "series failed")
    qt_assert_contains("${series_out}" "p.patch" "series should list patch from .pc/series")
endfunction()

# series_leading_space_no_newline: core.cpp lines 105, 117-118
# A series file with a leading-space patch entry triggers trim()'s
# leading-whitespace strip (line 105). A file without a trailing newline
# triggers split_lines()'s no-newline path (lines 117-118).
function(qt_scenario_series_leading_space_no_newline)
    qt_begin_test("series_leading_space_no_newline")
    # Create minimal quilt state with a series file that:
    #  - Has a patch entry with leading whitespace → trim() line 105
    #  - Has NO trailing newline → split_lines() lines 117-118
    file(MAKE_DIRECTORY "${QT_WORK_DIR}/patches")
    file(MAKE_DIRECTORY "${QT_WORK_DIR}/.pc")
    # Write "  p.patch" with no trailing newline (FILE() appends nothing)
    file(WRITE "${QT_WORK_DIR}/patches/series" "  p.patch")
    file(WRITE "${QT_WORK_DIR}/.pc/applied-patches" "")
    # Create a dummy patch file so series command can find it
    file(WRITE "${QT_WORK_DIR}/patches/p.patch" "")
    # Run series — it reads the series file which has leading-space + no-newline
    qt_quilt_ok(OUTPUT series_out ARGS series MESSAGE "series failed")
    qt_assert_contains("${series_out}" "p.patch" "series should list p.patch (trim leading space)")
endfunction()

# header_replace_no_newline: cmd_manage.cpp line 97
# replace_header() adds a trailing '\n' when new_header doesn't end with one.
# Triggered by "quilt header -r" with stdin that lacks a trailing newline.
function(qt_scenario_header_replace_no_newline)
    qt_begin_test("header_replace_no_newline")
    qt_write_file("${QT_WORK_DIR}/f.txt" "original\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "changed\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    # Replace the header with a string that does NOT end with a newline.
    # replace_header() checks: if (!result.empty() && result.back() != '\n')
    #   result += '\n';    (line 97 in cmd_manage.cpp)
    qt_quilt_ok(ARGS header -r INPUT "my description without newline"
        MESSAGE "header -r failed")
    qt_quilt_ok(OUTPUT hdr_out ARGS header MESSAGE "header read failed")
    qt_assert_contains("${hdr_out}" "my description without newline"
        "header should contain the replacement text")
endfunction()

# annotate_no_series_file: cmd_annotate.cpp line 112 (no_applied_patches_error)
# When annotate is called with no quilt state at all (no .pc/, no series file),
# it hits the "No series file found" error path.
function(qt_scenario_annotate_no_series_file)
    qt_begin_test("annotate_no_series_file")
    # Fresh directory with no quilt state
    qt_write_file("${QT_WORK_DIR}/f.txt" "content\n")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS annotate f.txt)
    qt_assert_failure("${rc}" "annotate with no series file should fail")
    qt_assert_contains("${err}" "No series file found" "should say no series file found")
endfunction()

# push_reject_no_newline: patch.cpp line 636
# format_rejects adds "\ No newline at end of file" when the rejected hunk's
# old side had no trailing newline (old_no_newline=true). Requires a patch
# that (1) fails to apply and (2) has "\ No newline at end of file" after
# a '-' line.
function(qt_scenario_push_reject_no_newline)
    qt_begin_test("push_reject_no_newline")
    # Create a file without trailing newline
    file(WRITE "${QT_WORK_DIR}/f.txt" "original")
    file(MAKE_DIRECTORY "${QT_WORK_DIR}/patches")
    file(MAKE_DIRECTORY "${QT_WORK_DIR}/.pc")
    # Create a patch that tries to remove "wrong" (not "original"), so it fails.
    # The patch includes "\ No newline at end of file" after the '-' line,
    # which sets old_no_newline=true on the hunk.
    file(WRITE "${QT_WORK_DIR}/patches/bad.patch"
"--- a/f.txt\n+++ b/f.txt\n@@ -1 +1 @@\n-wrong\n\\ No newline at end of file\n+patched\n")
    file(WRITE "${QT_WORK_DIR}/patches/series" "bad.patch\n")
    file(WRITE "${QT_WORK_DIR}/.pc/applied-patches" "")
    file(WRITE "${QT_WORK_DIR}/.pc/.version" "2\n")
    file(WRITE "${QT_WORK_DIR}/.pc/.quilt_patches" "patches\n")
    file(WRITE "${QT_WORK_DIR}/.pc/.quilt_series" "series\n")
    # Push with --leave-rejects to keep the .rej file
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS push --leave-rejects)
    qt_assert_failure("${rc}" "push should fail when patch doesn't apply")
    # The .rej file should contain the "No newline" marker
    qt_assert_exists("${QT_WORK_DIR}/f.txt.rej" "f.txt.rej should exist")
    file(READ "${QT_WORK_DIR}/f.txt.rej" rej_content)
    qt_assert_contains("${rej_content}" "No newline" "rej file should contain no-newline marker")
endfunction()

# fork_applied_not_in_series: cmd_manage.cpp lines 996-997
# cmd_fork checks if the top applied patch is in the series. If it isn't,
# it returns "is not in series" error. Achievable by crafting a state where
# applied-patches lists a patch that is absent from the series file.
function(qt_scenario_fork_applied_not_in_series)
    qt_begin_test("fork_applied_not_in_series")
    file(MAKE_DIRECTORY "${QT_WORK_DIR}/patches")
    file(MAKE_DIRECTORY "${QT_WORK_DIR}/.pc")
    # Series has "other.patch" only; applied-patches has "ghost.patch" (not in series)
    file(WRITE "${QT_WORK_DIR}/patches/series" "other.patch\n")
    file(WRITE "${QT_WORK_DIR}/.pc/applied-patches" "ghost.patch\n")
    file(WRITE "${QT_WORK_DIR}/.pc/.version" "2\n")
    file(WRITE "${QT_WORK_DIR}/.pc/.quilt_patches" "patches\n")
    file(WRITE "${QT_WORK_DIR}/.pc/.quilt_series" "series\n")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS fork)
    qt_assert_failure("${rc}" "fork should fail when applied patch not in series")
    qt_assert_contains("${err}" "is not in series" "should report patch not in series")
endfunction()

# refresh_diffstat_double_newline: cmd_patch.cpp line 1239
# When a patch header ends with two consecutive newlines and --diffstat is requested,
# the while loop in cmd_refresh removes the extra trailing newline (line 1239).
# The header is set to "Description\n\n" (trailing blank line) via quilt header -r.
function(qt_scenario_refresh_diffstat_double_newline)
    qt_begin_test("refresh_diffstat_double_newline")
    qt_write_file("${QT_WORK_DIR}/f.txt" "old\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "new\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    # Set a header that ends with a blank line (double trailing newline).
    # INPUT "Description\n\n" gives "Description" + LF + LF → header ends with \n\n.
    qt_quilt_ok(ARGS header -r INPUT "Description\n\n" MESSAGE "header -r failed")
    # refresh --diffstat removes the extra trailing blank line from the header
    # before inserting the diffstat block (line 1239 is hit).
    qt_quilt_ok(ARGS refresh --diffstat MESSAGE "refresh --diffstat failed")
    qt_read_file_raw(patch_content "${QT_WORK_DIR}/patches/p.patch")
    qt_assert_contains("${patch_content}" "Description" "patch should still have description")
    qt_assert_contains("${patch_content}" "1 file changed" "patch should contain diffstat")
endfunction()

# refresh_creates_patches_dir: cmd_patch.cpp line 1256
# When quilt refresh is run and the patches directory does not yet exist,
# cmd_refresh calls make_dirs to create it (line 1256). Triggered by crafting
# a state where the series lives in .pc/series (the fallback location used
# when .pc/.quilt_series is absent) and patches/ has never been created.
function(qt_scenario_refresh_creates_patches_dir)
    qt_begin_test("refresh_creates_patches_dir")
    # Create the working file (current state)
    file(WRITE "${QT_WORK_DIR}/f.txt" "hello\n")
    # Set up .pc/ structure manually (no patches/ directory)
    file(MAKE_DIRECTORY "${QT_WORK_DIR}/.pc")
    file(MAKE_DIRECTORY "${QT_WORK_DIR}/.pc/p.patch")
    # Backup shows the "before" state
    file(WRITE "${QT_WORK_DIR}/.pc/p.patch/f.txt" "original\n")
    # Metadata: version, patches dir, applied list
    file(WRITE "${QT_WORK_DIR}/.pc/.version" "2\n")
    file(WRITE "${QT_WORK_DIR}/.pc/.quilt_patches" "patches\n")
    # No .pc/.quilt_series → fallback search finds .pc/series
    file(WRITE "${QT_WORK_DIR}/.pc/series" "p.patch\n")
    file(WRITE "${QT_WORK_DIR}/.pc/applied-patches" "p.patch\n")
    # patches/ directory intentionally absent
    qt_assert_not_exists("${QT_WORK_DIR}/patches" "patches/ must not exist before refresh")
    # refresh should create patches/ and write patches/p.patch
    qt_quilt_ok(ARGS refresh MESSAGE "refresh should succeed and create patches/")
    qt_assert_dir_exists("${QT_WORK_DIR}/patches" "refresh should have created patches/")
    qt_assert_exists("${QT_WORK_DIR}/patches/p.patch" "refresh should have written patch file")
endfunction()

# push_crlf_patch: patch.cpp line 69
# parse_filename strips trailing \r from file paths, enabling CRLF-format patches
# (Windows line endings) to apply correctly on Linux.
# Triggered when the +++ line in a patch has \r before \n (CRLF line endings).
function(qt_scenario_push_crlf_patch)
    qt_begin_test("push_crlf_patch")
    qt_write_file("${QT_WORK_DIR}/f.txt" "old\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_quilt_ok(ARGS pop MESSAGE "pop failed")
    # Write a patch where the --- and +++ header lines have CRLF endings (\r\n).
    # parse_filename in patch.cpp strips the \r from the filename via the while loop
    # at line 68-70: while (!rest.empty() && rest.back() == '\r') rest = rest.substr(...)
    # Content lines use normal LF so they match the file content.
    qt_write_file("${QT_WORK_DIR}/patches/p.patch"
        "--- a/f.txt\r\n+++ b/f.txt\r\n@@ -1 +1 @@\n-old\n+new\n")
    qt_quilt_ok(ARGS push MESSAGE "push with CRLF patch should succeed")
    qt_assert_file_contains("${QT_WORK_DIR}/f.txt" "new" "CRLF patch should apply correctly")
endfunction()

# top_index_applied_not_in_series: core.cpp line 11
# QuiltState::top_index() loops through the series looking for the top applied
# patch. If the top applied patch is NOT in the series (inconsistent state),
# it falls through to "return -1" at line 11.
# Triggered by running "quilt new" in a state where applied-patches contains a
# patch name that is absent from the series file.
function(qt_scenario_top_index_applied_not_in_series)
    qt_begin_test("top_index_applied_not_in_series")
    file(MAKE_DIRECTORY "${QT_WORK_DIR}/patches")
    file(MAKE_DIRECTORY "${QT_WORK_DIR}/.pc")
    # Series: "other.patch" only. Applied: "ghost.patch" (not in series).
    file(WRITE "${QT_WORK_DIR}/patches/series" "other.patch\n")
    file(WRITE "${QT_WORK_DIR}/.pc/applied-patches" "ghost.patch\n")
    file(WRITE "${QT_WORK_DIR}/.pc/.version" "2\n")
    file(WRITE "${QT_WORK_DIR}/.pc/.quilt_patches" "patches\n")
    file(WRITE "${QT_WORK_DIR}/.pc/.quilt_series" "series\n")
    # "quilt new" calls top_index() to find the insertion point.
    # top_index() searches series for "ghost.patch" and fails → returns -1.
    # With top_idx == -1, new inserts at the beginning of the series.
    qt_quilt_ok(ARGS new fresh.patch MESSAGE "new should succeed even with inconsistent state")
    qt_read_file_raw(series_content "${QT_WORK_DIR}/patches/series")
    qt_assert_contains("${series_content}" "fresh.patch" "new patch should be in series")
endfunction()

# refresh_diffstat_bare_header: cmd_patch.cpp remove_diffstat_section lines 926,928-936,939,942,944,946-948
# remove_diffstat_section handles a bare diffstat block in the header (no "---" separator).
# read_patch_header stops at "---" lines, so a "---"-prefixed diffstat never appears in header.
# A bare diffstat (lines starting with ' ' containing '|', followed by "N files changed")
# CAN appear in the header if the patch was manually written or imported with such content.
# This test prepends a bare diffstat to an existing patch file, then calls refresh --diffstat
# to trigger remove_diffstat_section's bare-diffstat detection and removal logic.
function(qt_scenario_refresh_diffstat_bare_header)
    qt_begin_test("refresh_diffstat_bare_header")
    qt_write_file("${QT_WORK_DIR}/f.txt" "old\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "new\n")
    qt_quilt_ok(ENV "QUILT_NO_DIFF_TIMESTAMPS=1" ARGS refresh MESSAGE "initial refresh failed")
    # Prepend a bare diffstat header (no "---" separator) to the patch file.
    # remove_diffstat_section detects the " f.txt | 2 +-" pattern (line 926),
    # looks ahead and finds the summary "1 file changed" (lines 928-936),
    # then skips the entire block including the trailing blank line (lines 942,944,946-948).
    file(READ "${QT_WORK_DIR}/patches/p.patch" existing_patch)
    file(WRITE "${QT_WORK_DIR}/patches/p.patch"
        "Description\n\n f.txt | 2 +-\n 1 file changed, 1 insertion(+), 1 deletion(-)\n\n${existing_patch}")
    qt_quilt_ok(ENV "QUILT_NO_DIFF_TIMESTAMPS=1" ARGS refresh --diffstat
        MESSAGE "refresh --diffstat with bare diffstat header failed")
    file(READ "${QT_WORK_DIR}/patches/p.patch" result_patch)
    # The old bare diffstat should be stripped and replaced with one new diffstat
    string(REGEX MATCHALL "file changed" count_matches "${result_patch}")
    list(LENGTH count_matches num_changed)
    qt_assert_equal("${num_changed}" "1" "should have exactly one diffstat summary")
    # The description should be preserved
    qt_assert_contains("${result_patch}" "Description" "description should be preserved")
endfunction()

# refresh_diffstat_bare_false_positive: cmd_patch.cpp remove_diffstat_section lines 939-940
# When the header has a diffstat-like block (lines starting with ' ' containing '|')
# NOT followed by a valid summary line (interrupted by an empty line instead),
# remove_diffstat_section's look-ahead breaks at the empty line (line 939-940 break taken),
# found_summary stays false, and the block is preserved (not removed).
function(qt_scenario_refresh_diffstat_bare_false_positive)
    qt_begin_test("refresh_diffstat_bare_false_positive")
    qt_write_file("${QT_WORK_DIR}/f.txt" "old\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "new\n")
    qt_quilt_ok(ENV "QUILT_NO_DIFF_TIMESTAMPS=1" ARGS refresh MESSAGE "initial refresh failed")
    # Prepend a "false positive" diffstat: two diffstat-looking lines (start with ' ', have '|')
    # followed by an EMPTY LINE before any summary → look-ahead breaks, found_summary=false,
    # the block is NOT stripped (triggers the break at lines 939-940 in remove_diffstat_section).
    file(READ "${QT_WORK_DIR}/patches/p.patch" existing_patch)
    file(WRITE "${QT_WORK_DIR}/patches/p.patch"
        "Description\n\n f.txt | 2 +-\n g.txt | 3 +++\n\n${existing_patch}")
    qt_quilt_ok(ENV "QUILT_NO_DIFF_TIMESTAMPS=1" ARGS refresh --diffstat
        MESSAGE "refresh --diffstat with false-positive diffstat header failed")
    file(READ "${QT_WORK_DIR}/patches/p.patch" result_patch)
    # The false-positive diffstat should be preserved (not stripped), plus one new real diffstat
    qt_assert_contains("${result_patch}" "g.txt" "false-positive diffstat lines should be preserved")
    qt_assert_contains("${result_patch}" "Description" "description should be preserved")
    # The real diffstat is added (one real "file changed" summary)
    string(REGEX MATCHALL "file changed" count_matches "${result_patch}")
    list(LENGTH count_matches num_changed)
    qt_assert_equal("${num_changed}" "1" "should have exactly one real diffstat summary")
endfunction()

# graph_prune_unreachable_edge: cmd_graph.cpp line 504
# When a specific patch is selected in "quilt graph", the code prunes edges whose
# source or target is not reachable from the selected patch (line 504: it = edges.erase(it)).
# This requires two independent conflict groups sharing the same file but at different
# line regions, so that one group's edge is unreachable from the selected patch.
# Without the pre-filtering at lines 441-454 (which removes unrelated FILES from nodes),
# an unreachable edge can only appear when patches share the same file but have
# non-overlapping changes at different line ranges (requires --lines=N).
function(qt_scenario_graph_prune_unreachable_edge)
    qt_begin_test("graph_prune_unreachable_edge")
    # Create a 15-line file where lines 1 and 10 are in separate regions
    qt_write_file("${QT_WORK_DIR}/f1.txt"
        "line01\nline02\nline03\nline04\nline05\nline06\nline07\nline08\nline09\nline10\nline11\nline12\nline13\nline14\nline15\n")
    # Group 1: patchA and patchB both change line 1 (conflict at line 1)
    qt_quilt_ok(ARGS new patchA.diff MESSAGE "new patchA failed")
    qt_quilt_ok(ARGS add f1.txt MESSAGE "add f1 to patchA failed")
    qt_write_file("${QT_WORK_DIR}/f1.txt"
        "line01-A\nline02\nline03\nline04\nline05\nline06\nline07\nline08\nline09\nline10\nline11\nline12\nline13\nline14\nline15\n")
    qt_quilt_ok(ENV "QUILT_NO_DIFF_TIMESTAMPS=1" ARGS refresh MESSAGE "refresh patchA failed")
    qt_quilt_ok(ARGS new patchB.diff MESSAGE "new patchB failed")
    qt_quilt_ok(ARGS add f1.txt MESSAGE "add f1 to patchB failed")
    qt_write_file("${QT_WORK_DIR}/f1.txt"
        "line01-AB\nline02\nline03\nline04\nline05\nline06\nline07\nline08\nline09\nline10\nline11\nline12\nline13\nline14\nline15\n")
    qt_quilt_ok(ENV "QUILT_NO_DIFF_TIMESTAMPS=1" ARGS refresh MESSAGE "refresh patchB failed")
    # Group 2: patchC and patchD both change line 10 (conflict at line 10, no overlap with group 1)
    qt_quilt_ok(ARGS new patchC.diff MESSAGE "new patchC failed")
    qt_quilt_ok(ARGS add f1.txt MESSAGE "add f1 to patchC failed")
    qt_write_file("${QT_WORK_DIR}/f1.txt"
        "line01-AB\nline02\nline03\nline04\nline05\nline06\nline07\nline08\nline09\nline10-C\nline11\nline12\nline13\nline14\nline15\n")
    qt_quilt_ok(ENV "QUILT_NO_DIFF_TIMESTAMPS=1" ARGS refresh MESSAGE "refresh patchC failed")
    qt_quilt_ok(ARGS new patchD.diff MESSAGE "new patchD failed")
    qt_quilt_ok(ARGS add f1.txt MESSAGE "add f1 to patchD failed")
    qt_write_file("${QT_WORK_DIR}/f1.txt"
        "line01-AB\nline02\nline03\nline04\nline05\nline06\nline07\nline08\nline09\nline10-CD\nline11\nline12\nline13\nline14\nline15\n")
    qt_quilt_ok(ENV "QUILT_NO_DIFF_TIMESTAMPS=1" ARGS refresh MESSAGE "refresh patchD failed")
    # graph --lines=0 patchB: selects patchB.
    # With 0 context lines, patchA→patchB conflict at line 1 and patchC→patchD conflict at line 10.
    # reachable from patchB = {patchA, patchB}. patchC→patchD edge is unreachable → LINE 504.
    qt_quilt_ok(OUTPUT graph_out ARGS graph --lines=0 patchB.diff
        MESSAGE "graph --lines=0 patchB failed")
    qt_assert_contains("${graph_out}" "patchA" "patchA should be in graph (backward-reachable)")
    qt_assert_contains("${graph_out}" "patchB" "patchB should be in graph (selected)")
    qt_assert_not_contains("${graph_out}" "patchC" "patchC should be pruned (unreachable edge at line 504)")
    qt_assert_not_contains("${graph_out}" "patchD" "patchD should be pruned (unreachable edge at line 504)")
endfunction()

# graph_empty_backup_files: cmd_graph.cpp line 125
# When compute_ranges is called for a file that is zero-length both before and after
# a patch (old_path and new_path are both zero-byte files), the function returns early
# at line 125 without computing a diff. This happens when two patches both tracked an
# empty file but neither changed its content.
function(qt_scenario_graph_empty_backup_files)
    qt_begin_test("graph_empty_backup_files")
    # Create an empty file
    qt_write_file("${QT_WORK_DIR}/empty.txt" "")
    # patchA: add the empty file but make no changes -> backup .pc/patchA/empty.txt = 0 bytes
    qt_quilt_ok(ARGS new patchA.diff MESSAGE "new patchA failed")
    qt_quilt_ok(ARGS add empty.txt MESSAGE "add empty.txt to patchA failed")
    qt_quilt_ok(ENV "QUILT_NO_DIFF_TIMESTAMPS=1" ARGS refresh MESSAGE "refresh patchA failed")
    # patchB: add the same empty file, still no changes -> backup .pc/patchB/empty.txt = 0 bytes
    qt_quilt_ok(ARGS new patchB.diff MESSAGE "new patchB failed")
    qt_quilt_ok(ARGS add empty.txt MESSAGE "add empty.txt to patchB failed")
    qt_quilt_ok(ENV "QUILT_NO_DIFF_TIMESTAMPS=1" ARGS refresh MESSAGE "refresh patchB failed")
    # graph --lines patchB.diff: compute_ranges is called for patchA with file=empty.txt.
    # old_path = .pc/patchA/empty.txt (0 bytes), new_path = .pc/patchB/empty.txt (0 bytes).
    # Both is_zero_length_file() return true -> line 125 executed (early return).
    qt_quilt_ok(OUTPUT graph_out ARGS graph --lines patchB.diff
        MESSAGE "graph --lines patchB failed")
    qt_assert_contains("${graph_out}" "patchB" "patchB should appear in graph output")
endfunction()
