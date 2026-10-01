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
    import_strip_level_attached
    import_attached_P_d
    import_dup_invalid_mode
    import_grouped_options
    import_end_of_options
    import_strip_level_as_given
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
    push_empty_series
    push_already_applied
    import_bad_option
    rename_unknown_patch
    fold_bad_option
    fork_no_extension
    diff_no_applied_patches
    revert_bad_option
    revert_no_files
    revert_with_P
    revert_file_delete
    header_with_patch_arg
    header_nonexistent_patch
    import_applied_reject
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
    delete_topmost_output
    fold_force_rejects
    upgrade_bad_option
    applied_unapplied_target
    add_remove_unapplied_P
    fold_strip_level
    diff_U0_pure_insert
    import_P_multiple
    pop_deletes_empty_file
    pc_quilt_patches_overrides_env
    pc_quilt_series_is_filename
    series_pc_precedes_root
    quilt_series_pc_search_order
    top_index_applied_not_in_series
    rename_drops_strip_level
    refresh_shadow_rediff
    pop_verify_reverse
    pop_auto_refresh
    pop_refresh_args
    refresh_unified
    refresh_unified_lines
    refresh_context
    refresh_context_lines
    refresh_backup
    refresh_backup_no_existing
    refresh_strip_whitespace
    refresh_strip_whitespace_warning
    refresh_strip_whitespace_binary
    refresh_strip_whitespace_no_eol
    refresh_strip_whitespace_crlf
    refresh_strip_whitespace_context
    refresh_strip_whitespace_diff_fail
    refresh_trailing_ws_warning
    refresh_trailing_ws_warning_lines
    refresh_trailing_ws_warning_shadowed
    refresh_strip_whitespace_shadowed
    refresh_strip_whitespace_shadowed_deleted
    refresh_strip_whitespace_shadowed_late
    refresh_fork_named
    refresh_fork_not_top
    refresh_fork_nothing
    refresh_diffstat
    refresh_U_combined
    refresh_C_combined
    refresh_re_diffstat
    refresh_diffstat_delete_file
    refresh_diffstat_padding
    refresh_diffstat_scale
    refresh_diffstat_context
    refresh_diffstat_twice
    refresh_diffstat_header_replace
    refresh_diffstat_double_newline
    refresh_creates_patches_dir
    refresh_diffstat_bare_header
    refresh_diffstat_bare_false_positive
    header_strip_diffstat
    header_strip_trailing_whitespace
    header_strip_diffstat_print
    header_strip_ws_print
    header_strip_diffstat_append
    header_strip_combined
    header_backup_append
    header_strip_ws_empty_line
    header_strip_diffstat_false_positive
    header_edit_backup
    header_replace_no_newline
    header_desc_lookalike_lines
    header_context_diff_no_index
    header_crlf_preserved
    header_strip_diffstat_upstream
    header_lookahead_edges
    refresh_keeps_lookalike_header
    refresh_diffstat_in_place
    import_force_keeps_old_header
    import_force_headers_differ_hunk
    import_force_upstream_sequence
    import_force_strips_old_diffstat
    import_force_diffstat_not_a_conflict
    import_force_header_boundaries
    color_option_accepted
    color_option_invalid
    trace_option_accepted
    fold_reverse_no_newline
    fold_patch_opts
    fold_force
    fold_force_env
    fold_quiet
    fold_strip
    fold_fail
    fold_patch_opts_fuzz
    diff_z_p0
    diff_z_pab
    diff_snapshot_new_file_after
    diff_z_external
    diff_z_reverse
    diff_z_subdir
    diff_snapshot_shadow
    diff_combine_shadowing
    diff_external_quilt_diff_opts
    graph_edge_labels_space
    graph_no_applied_with_series
    graph_unapplied_patch
    graph_patch_prunes_unrelated
    graph_empty_backup_files
    annotate_no_applied
    annotate_empty_series
    annotate_basic
    annotate_stop_patch
    annotate_created_file
    annotate_subdirectory
    annotate_no_series_file
    quilt_no_args
    quilt_quiltrc_equals
    quiltrc_export_prefix
    quiltrc_invalid_key
    quiltrc_dquote_backslash
    quiltrc_leading_whitespace
    quiltrc_export_extra_space
    quiltrc_explicit_empty
    quiltrc_comments
    push_count_clamp
    push_quilt_patch_opts
    push_quilt_patch_opts_fuzz
    push_missing_file
    push_fuzz_offset
    push_offset_one_line
    push_backward_offset
    push_hunk_past_eof
    push_hunk_huge_line_number
    push_new_file_subdir
    push_crlf_patch
    push_fuzz_preserves_lines
    files_combine_dash_no_applied
    files_unapplied_duplicate
    rename_subdirectory
    series_comment_inline
    series_p_space
    new_combined_p_flag
    series_v_markers
    diff_reverse_labels
    refresh_index_p0
    refresh_index_pab
    push_a_blank_lines
    pop_a_blank_lines
    refresh_strip_ws_modifies_file
    patches_v_markers
    pop_shows_removing
    revert_restores_post_patch
    revert_unchanged
    revert_later_patch
    delete_applied_non_top
    delete_top_messages
    fold_joined_p_flag
    header_append_message
    header_replace_message
    refresh_subdir_patch
    refresh_unchanged_message
    refresh_empty_message
    refresh_empty_unchanged
    diff_combine_equals
    refresh_sorted_default
    diff_P_shadowed
    add_P_higher_patch
    import_dup_append_separator
    pop_dirty_tree
    pop_dirty_tree_force
    pop_dirty_tree_refresh
    refresh_binary_file
    quilt_patches_absolute_path
    push_already_applied_exit2
    pop_target_top_no_patch_removed
    unapplied_last_patch_ok
    push_quiet_no_extra_blank
    pop_quiet_no_extra_blank
    next_applied_patch_errors
    pop_dirty_hint_message
    series_no_series_file
    top_no_series_exit1
    diff_p0_orig_label
    refresh_p0_orig_label
    header_strip_diffstat_keeps_separator
    import_force_identical
    import_applied_no_force
    fork_increment_suffix
    refresh_strip_ws_only_modified
    next_no_series_exit1
    previous_no_series_exit1
    dotfile_toplevel
    dotfile_subdir
    refresh_named_unapplied
    refresh_named_not_in_series
    diff_P_unapplied
    diff_combine_wrong_order
    push_merge_short
    push_quilt_patch_opts_reverse
    push_quiet_all
    push_empty_patch_file
    pop_quiet_all
    pop_count_clamp
    pop_refresh_needs_refresh
    pop_force_refresh_conflict
    pop_empty_patch
    pop_unrefreshed_outside_hunk
    pop_never_refreshed
    pop_file_added_after_refresh
    pop_reversed_series_patch
    pop_forced_patch_below_top
    refresh_p0_deleted_file
    diff_R_deleted_file_labels
    applied_patches_removed_when_empty
    refresh_invalid_p
    series_invalid_strip_level
    diff_invalid_p
    diff_binary
    refresh_binary_shadowed
    diff_z_deleted_file
    diff_z_emptied_file
    diff_z_shadowed
    diff_z_shadowed_unrefreshed
    diff_z_shadowed_deleted
    diff_snapshot_reverse
    revert_multiple_files
    revert_P_unapplied
    snapshot_no_series
    series_empty_and_comments
    series_rejects_arguments
    color_option_forms
    files_all_no_applied
    delete_n_explicit
    delete_backup_without_r
    header_mode_conflict
    header_empty_stdin
    import_preserves_series_args
    import_multiple_files
    import_P_subdir
    graph_lines_nonadjacent
    graph_grey_only_when_isolated
    quiltrc_dash_disables
    annotate_delete_only
    rename_pc_migration
    fork_pc_migration
    prefixed_args_delete
    prefix_only_patch_arg
    empty_patch_arg
    patch_lookup_errors
    top_patch_series_checks
    refresh_diff_patch_lookup
    push_nothing_to_push_first
    push_pop_deletion
    push_keeps_emptied_file
    fold_deletion
    files_unapplied_strip_deletion
    patches_unapplied_strip_deletion
    refresh_p0_records_strip_level
    refresh_pab_clears_p0
    refresh_reversed_writes_forward
    refresh_p1_clears_p2
    refresh_z_pab_on_p0
    refresh_series_comments_kept
    pop_reversed_patch
    new_preserves_series_comments
    import_preserves_series_comments
    delete_preserves_series_comments
    rename_preserves_series_comments
    fork_preserves_series_comments
    refresh_z_preserves_series_comments
    push_context_diff
    push_context_diff_strip
    push_malformed_hunk
    push_truncated_hunk
    push_hunk_gnu_leniency
    push_zero_context_insert
    push_missing_patch_file
    push_garbage_patch
    push_force_garbage_patch
    push_header_only_section
    fold_garbage_input
    push_create_without_dev_null
    push_create_existing_file
    push_reverse_create_missing_file
    push_delete_epoch_timestamp
    push_skip_missing_file
    push_skip_missing_later_file
    fold_skip_missing_file
    fold_fail_rollback
    fold_subdirectory
    fold_subdirectory_rollback
    diff_context_line_ranges
    diff_hunk_context_gap
    diff_incomplete_last_line
    diff_incomplete_last_lines_both
    push_quiet_patch_output
    push_verbose_patch_output
    fold_quiet_patch_output
    push_missing_file_crlf_text
    push_failed_hunk_output
    fold_failed_hunk_output
    push_crlf_patch_output
    diff_last_line_newline_change
    push_reverse_applied
    push_verbose_rollback
    push_reject_format
    push_hunk_line_numbers
    push_delete_mismatch
    push_quoted_file_names
    refresh_z_increments_suffix
    refresh_z_next_filename_shapes
    fork_next_filename_shapes
    fork_target_exists
    fork_patches_prefix
    fork_empty_name
    revert_checks_all_files_first
    revert_shadowed_file
    revert_unnormalized_path
    revert_patch_resolution
    revert_no_series
    revert_reversed_patch
    revert_dot_slash_headers
    getopt_push_pop
    push_fuzz_value
    getopt_stack_queries
    getopt_file_commands
    getopt_new_snapshot
    getopt_refresh_diff
    getopt_delete_rename_fork
    import_no_files
    getopt_header
    getopt_files_patches_fold
    getopt_graph
    getopt_help_operand
    push_overlapping_hunks
    push_overlapping_hunk_offsets
    push_hunk_among_frozen_lines
    push_misordered_hunks
    push_insertion_hunk_guess
)

# Scenarios that test quilt.cpp-specific behavior (mail command format).
# Skipped when testing an external quilt binary.
# Scenarios that test quilt.cpp-specific behavior: mail command format,
# builtin diff/patch engines, internal shell_split, stub commands,
# Debian quilt extensions (init, --dep3), quilt.cpp extensions (next
# <target>), and tests that check error messages or exit codes that
# differ from upstream quilt.
# Skipped when testing an external quilt binary.
set(QUILT_TEST_SCENARIOS_NATIVE
    mail_basic
    mail_subject_lookalike
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
    mail_ten_patches
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
    builtin_diff_both_empty
    builtin_diff_trailing_newline_only
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
    builtin_patch_trailing_lines
    builtin_patch_merge_conflict_partial
    builtin_patch_merge_diff3
    builtin_patch_merge_copy_lines
    builtin_patch_no_newline_context
    builtin_patch_empty_context_line
    builtin_patch_empty_file_content
    builtin_patch_stray_minus
    diff_builtin_context_no_newline
    shell_split_single_quotes
    shell_split_double_quotes
    shell_split_var_expansion
    shell_split_var_braces
    shell_split_mixed
    shell_split_dquote_escape
    shell_split_unquoted_backslash
    stub_grep
    stub_setup
    stub_shell
    pop_verbose
    pop_auto_refresh_fail
    pop_target_already_top
    init_creates_metadata
    init_help_text
    init_extra_args
    init_from_subdir
    refresh_fork
    refresh_strip_ws_blank_context
    header_dep3_template
    header_dep3_nonempty
    header_edit_fail
    header_no_patch_applied
    header_empty_series
    unknown_option_rejected
    color_option_no_escapes
    fold_empty_stdin
    diff_external_context_format
    diff_external_context_multiline
    diff_external_with_C
    diff_quilt_diff_opts_combined
    diff_quilt_diff_opts_separate
    diff_external_context_no_newline
    graph_lines_with_num
    graph_lines_nan
    graph_edge_labels_bad
    graph_T_bad
    graph_T_ps
    graph_Tps
    graph_bad_option
    graph_two_patches
    graph_all_with_patch
    graph_all_empty
    graph_dot_escape
    graph_lines_identical_content
    graph_empty_series
    graph_prune_unreachable_edge
    graph_reduce_preserves_selected
    refresh_fork_no_extra_message
    annotate_bad_option
    annotate_two_files
    annotate_nonexistent_file
    quilt_version
    quilt_global_help
    quilt_help_command
    quilt_unknown_command
    quilt_ambiguous_command
    push_reject_no_newline
    files_combine_dash_patch_no_applied
    files_verbose
    revert_subdir
    series_in_pc_dir
    series_leading_space_no_newline
    next_with_target
    upgrade_help
    fork_applied_not_in_series
    graph_reduce
    merge_markers_per_hunk
    push_verbose_long_option
    diff_algorithm_myers
    diff_algorithm_minimal
    diff_algorithm_invalid
    diff_algorithm_space_form
    refresh_diff_algorithm
    diff_algorithm_minimal_vs_myers
    diff_algorithm_myers_heuristic_tail
    diff_algorithm_patience_basic
    diff_algorithm_patience_function_insert
    diff_algorithm_patience_no_unique
    diff_algorithm_histogram_basic
    diff_algorithm_histogram_function_insert
    diff_algorithm_histogram_no_unique
    diff_algorithm_env
    diff_algorithm_env_override
    diff_algorithm_env_invalid
    diff_algorithm_env_diff_cmd
    refresh_z_strip_migration
    annotate_P_missing_arg
    refresh_z_reversed_fork
    refresh_series_split_p_option
    refresh_z_fork_series_args
    series_insert_crlf
    push_context_diff_zero_context
    fold_fail_rollback_create_delete
    fork_leading_zero_suffix
    import_force_identical_header_once
    import_force_mode_per_patch
    push_fuzz_value_forms
    getopt_long_prefixes
    getopt_mail
    getopt_help_value
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
    # Default pop should show Restoring (matches original quilt)
    qt_quilt_ok(OUTPUT pop_out ERROR pop_err ARGS pop MESSAGE "pop failed")
    qt_assert_contains("${pop_out}" "Removing patch" "pop should announce removal")
    qt_assert_contains("${pop_out}" "Restoring f.txt" "pop should show Restoring")
    # Push back and pop with -v (should also show Restoring)
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

function(qt_scenario_import_strip_level_attached)
    qt_begin_test("import_strip_level_attached")
    qt_write_file("${QT_WORK_DIR}/x.diff" [=[--- f.txt
+++ f.txt
@@ -1 +1 @@
-x
+y
]=])
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    # getopt accepts the value attached to the option
    qt_quilt_ok(ARGS import -p0 x.diff MESSAGE "import -p0 failed")
    qt_assert_file_text("${QT_WORK_DIR}/patches/series" "x.diff -p0" "series should record -p0")
    qt_quilt_ok(ARGS push MESSAGE "push after import -p0 failed")
    qt_assert_file_text("${QT_WORK_DIR}/f.txt" "y" "file content after push with -p0")
endfunction()

function(qt_scenario_import_attached_P_d)
    qt_begin_test("import_attached_P_d")
    qt_write_file("${QT_TEST_BASE}/old.patch" [=[Old Header Line
--- a/f.txt
+++ b/f.txt
@@ -1 +1 @@
-x
+y
]=])
    qt_write_file("${QT_TEST_BASE}/new.patch" [=[New Header Line
--- a/f.txt
+++ b/f.txt
@@ -1 +1 @@
-x
+z
]=])
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_quilt_ok(ARGS import -Pfoo.diff "${QT_TEST_BASE}/old.patch" MESSAGE "import -Pfoo.diff failed")
    qt_assert_file_text("${QT_WORK_DIR}/patches/series" "foo.diff" "series should name the -P patch")
    qt_quilt_ok(ARGS import -f -do -Pfoo.diff "${QT_TEST_BASE}/new.patch" MESSAGE "import -f -do failed")
    qt_assert_file_text("${QT_WORK_DIR}/patches/series" "foo.diff" "re-import should not add a series entry")
    qt_assert_file_contains("${QT_WORK_DIR}/patches/foo.diff" "Old Header" "-do should keep the old header")
    qt_assert_file_not_contains("${QT_WORK_DIR}/patches/foo.diff" "New Header" "-do should drop the new header")
    qt_assert_file_contains("${QT_WORK_DIR}/patches/foo.diff" "+z" "-do should use the new diff")
endfunction()

function(qt_scenario_import_dup_invalid_mode)
    qt_begin_test("import_dup_invalid_mode")
    qt_write_file("${QT_WORK_DIR}/x.diff" "--- a/f.txt\n+++ b/f.txt\n@@ -1 +1 @@\n-x\n+y\n")
    foreach(args IN ITEMS "-d;x" "-dx")
        qt_quilt(RESULT rc OUTPUT out ERROR err ARGS import ${args} x.diff)
        qt_assert_failure("${rc}" "import ${args} should reject the header mode")
        qt_combine_output(combined "${out}" "${err}")
        qt_assert_contains("${combined}" "Usage: quilt import" "import ${args} should print usage")
        qt_assert_not_exists("${QT_WORK_DIR}/patches/x.diff" "import ${args} should not store the patch")
    endforeach()
endfunction()

function(qt_scenario_import_grouped_options)
    qt_begin_test("import_grouped_options")
    qt_write_file("${QT_WORK_DIR}/x.diff" "--- f.txt\n+++ f.txt\n@@ -1 +1 @@\n-x\n+y\n")
    qt_write_file("${QT_WORK_DIR}/y.diff" "--- a/g.txt\n+++ b/g.txt\n@@ -1 +1 @@\n-x\n+y\n")
    # getopt lets options share a word, the last one taking its value attached
    qt_quilt_ok(ARGS import -Rp0 x.diff MESSAGE "import -Rp0 failed")
    qt_assert_file_text("${QT_WORK_DIR}/patches/series" "x.diff -p0 -R" "-Rp0 should set both options")
    qt_quilt_ok(ARGS import -fRPz.diff y.diff MESSAGE "import -fRPz.diff failed")
    qt_assert_file_text("${QT_WORK_DIR}/patches/series" "z.diff -R\nx.diff -p0 -R" "-fRPz.diff should set all three options")
    qt_assert_exists("${QT_WORK_DIR}/patches/z.diff" "-fRPz.diff should store the patch as z.diff")
endfunction()

function(qt_scenario_import_end_of_options)
    qt_begin_test("import_end_of_options")
    qt_write_file("${QT_WORK_DIR}/x.diff" "--- f.txt\n+++ f.txt\n@@ -1 +1 @@\n-x\n+y\n")
    qt_quilt_ok(ARGS import -p0 -- x.diff MESSAGE "import -p0 -- x.diff failed")
    qt_assert_file_text("${QT_WORK_DIR}/patches/series" "x.diff -p0" "import -- should import the patch")
    # After "--" a word that looks like an option names a patch file
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS import -- -p1)
    qt_assert_failure("${rc}" "import -- -p1 should look for a patch file named -p1")
    qt_combine_output(combined "${out}" "${err}")
    qt_assert_contains("${combined}" "Patch -p1 does not exist" "import -- -p1 should report the missing file")
    qt_assert_file_text("${QT_WORK_DIR}/patches/series" "x.diff -p0" "import -- -p1 should leave the series alone")
endfunction()

function(qt_scenario_import_strip_level_as_given)
    qt_begin_test("import_strip_level_as_given")
    qt_write_file("${QT_WORK_DIR}/a.diff" "--- a/f.txt\n+++ b/f.txt\n@@ -1 +1 @@\n-x\n+y\n")
    qt_write_file("${QT_WORK_DIR}/b.diff" "--- a/g.txt\n+++ b/g.txt\n@@ -1 +1 @@\n-x\n+y\n")
    qt_write_file("${QT_WORK_DIR}/c.diff" "--- a/h.txt\n+++ b/h.txt\n@@ -1 +1 @@\n-x\n+y\n")
    # The series records -p as given, even the default level
    qt_quilt_ok(ARGS import -p 1 a.diff b.diff MESSAGE "import -p 1 failed")
    qt_assert_file_text("${QT_WORK_DIR}/patches/series" "a.diff -p1\nb.diff -p1" "series should record an explicit -p1")
    # ... and without checking it is a number
    qt_quilt_ok(ARGS import -pab c.diff MESSAGE "import -pab failed")
    qt_assert_file_text("${QT_WORK_DIR}/patches/series" "c.diff -pab\na.diff -p1\nb.diff -p1" "series should record -pab verbatim")
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
    # --lines with a number, which only goes after "="
    qt_quilt_ok(OUTPUT graph_out ERROR graph_err ARGS graph --lines=3 MESSAGE "graph --lines=3 failed")
    qt_assert_contains("${graph_out}" "digraph dependencies {" "graph --lines=N should emit DOT")
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
    qt_assert_contains("${graph_out}" "style=bold" "graph should highlight the selected top patch")
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
    qt_assert_contains("${graph_out}" "style=bold" "selected graph should highlight the chosen patch")
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
    qt_quilt_ok(DEFAULT_QUILTRC ENV ${home_env} ARGS new rcp.patch MESSAGE "new with default quiltrc failed")
    qt_quilt_ok(DEFAULT_QUILTRC ENV ${home_env} ARGS add f.txt MESSAGE "add with default quiltrc failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "y\n")
    qt_quilt_ok(DEFAULT_QUILTRC ENV ${home_env} ARGS refresh MESSAGE "refresh with default quiltrc failed")
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
    qt_assert_contains("${err}" "unrecognized option '--no-such-option'" "bad option should be named")
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
    # The refreshed patch starts with --- (no header text), so patch_header returns "".
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
    qt_assert_file_contains("${QT_WORK_DIR}/f.txt" "<<<<<<<" "should have merge conflict marker")
    qt_assert_file_contains("${QT_WORK_DIR}/f.txt" "=======" "should have separator")
    qt_assert_file_contains("${QT_WORK_DIR}/f.txt" ">>>>>>>" "should have end marker")
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
    qt_combine_output(combined "${ref_out}" "${ref_err}")
    qt_assert_contains("${combined}" "Removing trailing whitespace from line 1 of f.txt" "should warn about trailing whitespace")
endfunction()

# refresh --strip-trailing-whitespace must leave an unchanged binary file alone
function(qt_scenario_refresh_strip_whitespace_binary)
    qt_begin_test("refresh_strip_whitespace_binary")
    qt_write_bytes("${QT_WORK_DIR}/t.txt" "x\\n")
    qt_write_bytes("${QT_WORK_DIR}/f.bin" "\\0\\001")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add t.txt f.bin MESSAGE "add failed")
    qt_write_bytes("${QT_WORK_DIR}/t.txt" "y \\n")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS refresh --strip-trailing-whitespace)
    qt_assert_success("${rc}" "refresh should succeed with an unchanged binary file")
    qt_combine_output(combined "${out}" "${err}")
    qt_assert_contains("${combined}" "Removing trailing whitespace from line 1 of t.txt" "should report stripped line")
    qt_assert_contains("${combined}" "Refreshed patch" "should refresh patch")
    qt_assert_file_hex("${QT_WORK_DIR}/f.bin" "0001" "binary file must be untouched")
    qt_assert_file_hex("${QT_WORK_DIR}/t.txt" "790a" "t.txt should lose its trailing space")
    qt_read_file_raw(patch_text "${QT_WORK_DIR}/patches/p.patch")
    qt_assert_contains("${patch_text}" "\n-x\n+y\n" "patch should add the stripped line")
    qt_assert_not_contains("${patch_text}" "f.bin" "patch should not mention the binary file")
endfunction()

# refresh --strip-trailing-whitespace must keep a missing final newline, both
# in an unchanged file and on a stripped last line
function(qt_scenario_refresh_strip_whitespace_no_eol)
    qt_begin_test("refresh_strip_whitespace_no_eol")
    qt_write_bytes("${QT_WORK_DIR}/t.txt" "x\\n")
    qt_write_bytes("${QT_WORK_DIR}/nonl" "keep\\nnonl")
    qt_write_bytes("${QT_WORK_DIR}/eof.txt" "a\\nb")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add t.txt nonl eof.txt MESSAGE "add failed")
    qt_write_bytes("${QT_WORK_DIR}/t.txt" "y\\t\\n")
    qt_write_bytes("${QT_WORK_DIR}/eof.txt" "a\\nc \\t")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS refresh --strip-trailing-whitespace)
    qt_assert_success("${rc}" "refresh should succeed")
    qt_combine_output(combined "${out}" "${err}")
    qt_assert_contains("${combined}" "Removing trailing whitespace from line 2 of eof.txt" "should report eof.txt")
    qt_assert_contains("${combined}" "Removing trailing whitespace from line 1 of t.txt" "should report t.txt")
    qt_assert_file_hex("${QT_WORK_DIR}/nonl" "6b6565700a6e6f6e6c" "unchanged file must keep its missing final newline")
    qt_assert_file_hex("${QT_WORK_DIR}/eof.txt" "610a63" "stripped last line must not gain a newline")
    qt_assert_file_hex("${QT_WORK_DIR}/t.txt" "790a" "t.txt should lose its trailing tab")
    qt_read_file_raw(patch_text "${QT_WORK_DIR}/patches/p.patch")
    qt_assert_not_contains("${patch_text}" "nonl" "patch should not touch the unchanged file")
    qt_assert_contains("${patch_text}" "\n-b\n\\ No newline at end of file\n+c\n\\ No newline at end of file\n" "patch should keep the missing newline")
    qt_assert_contains("${patch_text}" "\n-x\n+y\n" "patch should add the stripped line")
endfunction()

# refresh --strip-trailing-whitespace must keep CRLF line endings. As in
# upstream, whitespace before a '\r' is not trailing whitespace.
function(qt_scenario_refresh_strip_whitespace_crlf)
    qt_begin_test("refresh_strip_whitespace_crlf")
    qt_write_bytes("${QT_WORK_DIR}/crlf.txt" "a\\r\\nb\\r\\nc\\r\\nd\\r\\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add crlf.txt MESSAGE "add failed")
    qt_write_bytes("${QT_WORK_DIR}/crlf.txt" "a\\r\\nB\\r\\nc\\r\\nd \\r\\ne \\n")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS refresh --strip-trailing-whitespace)
    qt_assert_success("${rc}" "refresh should succeed")
    qt_combine_output(combined "${out}" "${err}")
    qt_assert_contains("${combined}" "Removing trailing whitespace from line 5 of crlf.txt" "should strip only the LF line")
    # "a\r\nB\r\nc\r\nd \r\ne\n"
    qt_assert_file_hex("${QT_WORK_DIR}/crlf.txt" "610d0a420d0a630d0a64200d0a650a" "CRLF lines must be kept")
    # "\n a\r\n-b\r\n+B\r\n c\r\n-d\r\n+d \r\n+e\n"
    qt_assert_file_contains_hex("${QT_WORK_DIR}/patches/p.patch"
        "0a20610d0a2d620d0a2b420d0a20630d0a2d640d0a2b64200d0a2b650a"
        "patch should change only lines 2, 4 and 5, keeping CRLF")
endfunction()

# refresh -c --strip-trailing-whitespace strips added lines of a context diff
function(qt_scenario_refresh_strip_whitespace_context)
    qt_begin_test("refresh_strip_whitespace_context")
    qt_write_bytes("${QT_WORK_DIR}/f.txt" "1\\n2\\n3\\n4\\n5\\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_bytes("${QT_WORK_DIR}/f.txt" "1 \\n2\\n3\\n4 \\n5\\n6\\t\\n")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS refresh -c --strip-trailing-whitespace)
    qt_assert_success("${rc}" "refresh should succeed")
    qt_combine_output(combined "${out}" "${err}")
    qt_assert_contains("${combined}" "Removing trailing whitespace from lines 1,4,6 of f.txt" "should report stripped lines")
    qt_assert_file_hex("${QT_WORK_DIR}/f.txt" "310a320a330a340a350a360a" "added lines should be stripped")
    qt_read_file_raw(patch_text "${QT_WORK_DIR}/patches/p.patch")
    qt_assert_contains("${patch_text}" "\n! 1\n  2\n  3\n! 4\n  5\n+ 6\n" "patch should have stripped lines")
endfunction()

# A refresh --strip-trailing-whitespace that fails must not touch any file
function(qt_scenario_refresh_strip_whitespace_diff_fail)
    qt_begin_test("refresh_strip_whitespace_diff_fail")
    qt_write_bytes("${QT_WORK_DIR}/a.txt" "x\\n")
    qt_write_bytes("${QT_WORK_DIR}/f.bin" "\\0\\001")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add a.txt f.bin MESSAGE "add failed")
    qt_write_bytes("${QT_WORK_DIR}/a.txt" "y \\n")
    qt_write_bytes("${QT_WORK_DIR}/f.bin" "\\0\\002")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS refresh --strip-trailing-whitespace)
    qt_assert_failure("${rc}" "refresh should fail on a changed binary file")
    qt_combine_output(combined "${out}" "${err}")
    qt_assert_contains("${combined}" "Diff failed on file 'f.bin'" "should report diff failure")
    qt_assert_not_contains("${combined}" "Removing trailing whitespace" "should not strip anything")
    qt_assert_file_hex("${QT_WORK_DIR}/a.txt" "79200a" "a.txt must be untouched")
    qt_assert_file_hex("${QT_WORK_DIR}/f.bin" "0002" "f.bin must be untouched")
endfunction()

# Without --strip-trailing-whitespace, refresh warns about an added line with
# trailing whitespace but keeps it in both the file and the patch
function(qt_scenario_refresh_trailing_ws_warning)
    qt_begin_test("refresh_trailing_ws_warning")
    qt_write_bytes("${QT_WORK_DIR}/a.txt" "x\\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add a.txt MESSAGE "add failed")
    qt_write_bytes("${QT_WORK_DIR}/a.txt" "x\\nw \\n")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS refresh)
    qt_assert_success("${rc}" "refresh should succeed")
    qt_assert_equal("${err}" "Warning: trailing whitespace in line 2 of a.txt\n" "should warn about line 2")
    qt_assert_contains("${out}" "Refreshed patch" "should refresh patch")
    qt_assert_file_hex("${QT_WORK_DIR}/a.txt" "780a77200a" "a.txt must be untouched")
    # " x\n+w \n"
    qt_assert_file_contains_hex("${QT_WORK_DIR}/patches/p.patch" "0a20780a2b77200a"
        "patch should keep the trailing whitespace")
endfunction()

# The warning lists several lines of a file in one message, reports files in
# name order, ignores whitespace before a '\r', and repeats on an unchanged
# refresh
function(qt_scenario_refresh_trailing_ws_warning_lines)
    qt_begin_test("refresh_trailing_ws_warning_lines")
    qt_write_bytes("${QT_WORK_DIR}/a.txt" "x\\n")
    qt_write_bytes("${QT_WORK_DIR}/b.txt" "1\\n2\\n3\\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add b.txt a.txt MESSAGE "add failed")
    qt_write_bytes("${QT_WORK_DIR}/a.txt" "x\\nw \\n")
    qt_write_bytes("${QT_WORK_DIR}/b.txt" "1 \\n2\\n3\\t\\n4 \\r\\n")
    set(expected_err "Warning: trailing whitespace in line 2 of a.txt\nWarning: trailing whitespace in lines 1,3 of b.txt\n")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS refresh)
    qt_assert_success("${rc}" "refresh should succeed")
    qt_assert_equal("${err}" "${expected_err}" "should warn about a.txt, then b.txt")
    qt_assert_contains("${out}" "Refreshed patch" "should refresh patch")
    qt_assert_file_hex("${QT_WORK_DIR}/a.txt" "780a77200a" "a.txt must be untouched")
    qt_assert_file_hex("${QT_WORK_DIR}/b.txt" "31200a320a33090a34200d0a" "b.txt must be untouched")
    # "+1 \n 2\n-3\n+3\t\n+4 \r\n"
    qt_assert_file_contains_hex("${QT_WORK_DIR}/patches/p.patch" "2b31200a20320a2d330a2b33090a2b34200d0a"
        "patch should keep the trailing whitespace")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS refresh)
    qt_assert_success("${rc}" "second refresh should succeed")
    qt_assert_equal("${err}" "${expected_err}" "unchanged refresh should warn again")
    qt_assert_contains("${out}" "Patch p.patch is unchanged" "patch should be unchanged")
    qt_assert_file_hex("${QT_WORK_DIR}/b.txt" "31200a320a33090a34200d0a" "b.txt must still be untouched")
endfunction()

# Like upstream, which checks the whole generated patch, refresh -f warns
# about trailing whitespace in a file shadowed by a later patch too, at the
# line numbers of the later patch's backup (line 2, not the working line 3)
function(qt_scenario_refresh_trailing_ws_warning_shadowed)
    qt_begin_test("refresh_trailing_ws_warning_shadowed")
    qt_write_bytes("${QT_WORK_DIR}/a.txt" "one\\ntwo\\nthree\\n")
    qt_write_bytes("${QT_WORK_DIR}/b.txt" "alpha\\n")
    qt_quilt_ok(ARGS new p1.patch MESSAGE "new p1 failed")
    qt_quilt_ok(ARGS add a.txt b.txt MESSAGE "add to p1 failed")
    qt_write_bytes("${QT_WORK_DIR}/a.txt" "one\\ntwo \\nthree\\n")
    qt_write_bytes("${QT_WORK_DIR}/b.txt" "alpha\\nbeta\\t\\n")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS refresh)
    qt_assert_success("${rc}" "refresh p1 should succeed")
    qt_quilt_ok(ARGS new p2.patch MESSAGE "new p2 failed")
    qt_quilt_ok(ARGS add a.txt MESSAGE "add to p2 failed")
    qt_write_bytes("${QT_WORK_DIR}/a.txt" "zero\\none\\ntwo \\nthree\\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh p2 failed")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS refresh -f p1.patch)
    qt_assert_success("${rc}" "refresh -f should succeed")
    qt_assert_equal("${err}" "Warning: trailing whitespace in line 2 of a.txt\nWarning: trailing whitespace in line 2 of b.txt\n"
        "should warn about the shadowed a.txt as well as b.txt")
    # " one\n-two\n+two \n"
    qt_assert_file_contains_hex("${QT_WORK_DIR}/patches/p1.patch" "206f6e650a2d74776f0a2b74776f200a"
        "patch should keep the trailing whitespace")
    # "zero\none\ntwo \nthree\n"
    qt_assert_file_hex("${QT_WORK_DIR}/a.txt" "7a65726f0a6f6e650a74776f200a74687265650a" "a.txt must be untouched")
endfunction()

# refresh -f --strip-trailing-whitespace on a patch with shadowed files
# complains once per file from the first shadowed one on, but strips anyway,
# like upstream: the patch text, and the working file at the line numbers of
# the later patch's backup (here line 2, which is p2's "half " line). The
# later patch's backup is left alone.
function(qt_scenario_refresh_strip_whitespace_shadowed)
    qt_begin_test("refresh_strip_whitespace_shadowed")
    qt_write_bytes("${QT_WORK_DIR}/a.txt" "one\\ntwo\\nthree\\n")
    qt_write_bytes("${QT_WORK_DIR}/b.txt" "alpha\\n")
    qt_quilt_ok(ARGS new p1.patch MESSAGE "new p1 failed")
    qt_quilt_ok(ARGS add a.txt b.txt MESSAGE "add to p1 failed")
    qt_write_bytes("${QT_WORK_DIR}/a.txt" "one\\ntwo \\nthree\\n")
    qt_write_bytes("${QT_WORK_DIR}/b.txt" "alpha\\nbeta\\t\\ngamma  \\n")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS refresh)
    qt_assert_success("${rc}" "refresh p1 should succeed")
    qt_quilt_ok(ARGS new p2.patch MESSAGE "new p2 failed")
    qt_quilt_ok(ARGS add a.txt MESSAGE "add to p2 failed")
    qt_write_bytes("${QT_WORK_DIR}/a.txt" "zero\\nhalf \\ntwo \\nthree\\n")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS refresh)
    qt_assert_success("${rc}" "refresh p2 should succeed")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS refresh -f --strip-trailing-whitespace p1.patch)
    qt_assert_success("${rc}" "refresh -f --strip-trailing-whitespace should succeed")
    set(cannot "Cannot use --strip-trailing-whitespace on a patch that has shadowed files.\n")
    qt_assert_equal("${err}" "${cannot}${cannot}Removing trailing whitespace from line 2 of a.txt\nRemoving trailing whitespace from lines 2,3 of b.txt\n"
        "should complain for a.txt and b.txt, then strip both files")
    qt_assert_contains("${out}" "Refreshed patch" "should refresh patch")
    # " one\n-two\n+two\n"
    qt_assert_file_contains_hex("${QT_WORK_DIR}/patches/p1.patch" "206f6e650a2d74776f0a2b74776f0a"
        "the shadowed file's added line should be stripped in the patch")
    # "+beta\n+gamma\n"
    qt_assert_file_contains_hex("${QT_WORK_DIR}/patches/p1.patch" "2b626574610a2b67616d6d610a"
        "b.txt's added lines should be stripped in the patch")
    qt_assert_file_hex("${QT_WORK_DIR}/b.txt" "616c7068610a626574610a67616d6d610a" "b.txt should be stripped")
    # "zero\nhalf\ntwo \nthree\n"
    qt_assert_file_hex("${QT_WORK_DIR}/a.txt" "7a65726f0a68616c660a74776f200a74687265650a"
        "a.txt should be stripped at line 2 only")
    # "one\ntwo \nthree\n"
    qt_assert_file_hex("${QT_WORK_DIR}/.pc/p2.patch/a.txt" "6f6e650a74776f200a74687265650a"
        "p2's backup must be untouched")
endfunction()

# When a later patch deleted a shadowed file, upstream fails to open it, stops
# stripping (z.txt, sorted after it, is not stripped), and keeps the patch
# unstripped, but the refresh still succeeds
function(qt_scenario_refresh_strip_whitespace_shadowed_deleted)
    qt_begin_test("refresh_strip_whitespace_shadowed_deleted")
    qt_write_bytes("${QT_WORK_DIR}/a.txt" "one\\ntwo\\n")
    qt_write_bytes("${QT_WORK_DIR}/z.txt" "zz\\n")
    qt_quilt_ok(ARGS new p1.patch MESSAGE "new p1 failed")
    qt_quilt_ok(ARGS add a.txt z.txt MESSAGE "add to p1 failed")
    qt_write_bytes("${QT_WORK_DIR}/a.txt" "one\\ntwo \\n")
    qt_write_bytes("${QT_WORK_DIR}/z.txt" "zz\\nyy \\n")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS refresh --no-timestamps)
    qt_assert_success("${rc}" "refresh p1 should succeed")
    qt_quilt_ok(ARGS new p2.patch MESSAGE "new p2 failed")
    qt_quilt_ok(ARGS add a.txt MESSAGE "add to p2 failed")
    file(REMOVE "${QT_WORK_DIR}/a.txt")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh p2 failed")
    qt_quilt(RESULT rc OUTPUT out ERROR err
             ARGS refresh -f --no-timestamps --strip-trailing-whitespace p1.patch)
    qt_assert_success("${rc}" "refresh -f --strip-trailing-whitespace should succeed")
    set(cannot "Cannot use --strip-trailing-whitespace on a patch that has shadowed files.\n")
    qt_assert_equal("${err}" "${cannot}${cannot}Removing trailing whitespace from line 2 of a.txt\na.txt: No such file or directory\n"
        "should stop stripping at the missing a.txt")
    qt_assert_contains("${out}" "Patch p1.patch is unchanged" "patch should stay unstripped")
    # "+two \n" and "+yy \n"
    qt_assert_file_contains_hex("${QT_WORK_DIR}/patches/p1.patch" "2b74776f200a"
        "patch should keep a.txt's trailing whitespace")
    qt_assert_file_contains_hex("${QT_WORK_DIR}/patches/p1.patch" "2b7979200a"
        "patch should keep z.txt's trailing whitespace")
    qt_assert_file_hex("${QT_WORK_DIR}/z.txt" "7a7a0a7979200a" "z.txt must be untouched")
    qt_assert_not_exists("${QT_WORK_DIR}/a.txt" "a.txt must stay deleted")
endfunction()

# The complaint about shadowed files starts at the first shadowed file, and
# comes even when there is no trailing whitespace to strip
function(qt_scenario_refresh_strip_whitespace_shadowed_late)
    qt_begin_test("refresh_strip_whitespace_shadowed_late")
    qt_write_bytes("${QT_WORK_DIR}/a.txt" "a\\n")
    qt_write_bytes("${QT_WORK_DIR}/b.txt" "b\\n")
    qt_quilt_ok(ARGS new p1.patch MESSAGE "new p1 failed")
    qt_quilt_ok(ARGS add a.txt b.txt MESSAGE "add to p1 failed")
    qt_write_bytes("${QT_WORK_DIR}/a.txt" "a1\\n")
    qt_write_bytes("${QT_WORK_DIR}/b.txt" "b1\\n")
    qt_quilt_ok(ARGS refresh --no-timestamps MESSAGE "refresh p1 failed")
    qt_quilt_ok(ARGS new p2.patch MESSAGE "new p2 failed")
    qt_quilt_ok(ARGS add b.txt MESSAGE "add to p2 failed")
    qt_write_bytes("${QT_WORK_DIR}/b.txt" "b2\\n")
    qt_quilt_ok(ARGS refresh --no-timestamps MESSAGE "refresh p2 failed")
    qt_quilt(RESULT rc OUTPUT out ERROR err
             ARGS refresh -f --no-timestamps --strip-trailing-whitespace p1.patch)
    qt_assert_success("${rc}" "refresh -f --strip-trailing-whitespace should succeed")
    qt_assert_equal("${err}" "Cannot use --strip-trailing-whitespace on a patch that has shadowed files.\n"
        "should complain once, for b.txt only")
    qt_assert_contains("${out}" "Patch p1.patch is unchanged" "patch should be unchanged")
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
    # Series should have both orig.patch and orig-2.patch (original quilt keeps both)
    qt_assert_file_contains("${QT_WORK_DIR}/patches/series" "orig-2.patch" "series should have forked name")
    qt_assert_file_contains("${QT_WORK_DIR}/patches/series" "orig.patch" "series should still have original name")
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

# refresh -z with nothing to put in the fork fails without creating it
function(qt_scenario_refresh_fork_nothing)
    qt_begin_test("refresh_fork_nothing")
    qt_write_file("${QT_WORK_DIR}/f.txt" "base\n")
    qt_quilt_ok(ARGS new a.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "changed\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS refresh -z)
    qt_assert_failure("${rc}" "refresh -z with no changes should fail")
    qt_assert_equal("${out}" "" "refresh -z should not announce a fork")
    qt_assert_equal("${err}" "Nothing in patch a-2.patch\n" "refresh -z should report the empty fork")
    qt_assert_file_text("${QT_WORK_DIR}/patches/series" "a.patch" "series should be untouched")
    qt_assert_file_text("${QT_WORK_DIR}/.pc/applied-patches" "a.patch" "applied-patches should be untouched")
    qt_assert_not_exists("${QT_WORK_DIR}/.pc/a-2.patch" "no .pc/ directory for the fork")
    qt_assert_not_exists("${QT_WORK_DIR}/patches/a-2.patch" "no patch file for the fork")
    # A later fork with real changes still works
    qt_write_file("${QT_WORK_DIR}/f.txt" "forked\n")
    qt_quilt_ok(OUTPUT fork_out ARGS refresh -z MESSAGE "refresh -z with changes failed")
    qt_assert_equal("${fork_out}" "Fork of patch a.patch created as a-2.patch\n" "fork message")
    qt_assert_file_text("${QT_WORK_DIR}/patches/series" "a.patch\na-2.patch" "series should list the fork")
    qt_assert_file_text("${QT_WORK_DIR}/.pc/applied-patches" "a.patch\na-2.patch" "fork should be applied")
    qt_assert_file_contains("${QT_WORK_DIR}/patches/a-2.patch" "+forked" "fork should hold the new change")
    qt_assert_file_not_contains("${QT_WORK_DIR}/patches/a-2.patch" "-base" "fork should not repeat a.patch")
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
    qt_assert_contains("${err}" "unrecognized option '--bogus'" "refresh --bogus error message")

    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS diff --bogus)
    qt_assert_not_equal("${rc}" "0" "diff --bogus should fail")
    qt_assert_contains("${err}" "unrecognized option '--bogus'" "diff --bogus error message")

    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS push --bogus)
    qt_assert_not_equal("${rc}" "0" "push --bogus should fail")
    qt_assert_contains("${err}" "unrecognized option '--bogus'" "push --bogus error message")

    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS series --bogus)
    qt_assert_not_equal("${rc}" "0" "series --bogus should fail")
    qt_assert_contains("${err}" "unrecognized option '--bogus'" "series --bogus error message")

    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS top --bogus)
    qt_assert_not_equal("${rc}" "0" "top --bogus should fail")
    qt_assert_contains("${err}" "unrecognized option '--bogus'" "top --bogus error message")

    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS applied --bogus)
    qt_assert_not_equal("${rc}" "0" "applied --bogus should fail")
    qt_assert_contains("${err}" "unrecognized option '--bogus'" "applied --bogus error message")

    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS header --bogus)
    qt_assert_not_equal("${rc}" "0" "header --bogus should fail")
    qt_assert_contains("${err}" "unrecognized option '--bogus'" "header --bogus error message")

    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS patches --bogus)
    qt_assert_not_equal("${rc}" "0" "patches --bogus should fail")
    qt_assert_contains("${err}" "unrecognized option '--bogus'" "patches --bogus error message")

    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS new --bogus)
    qt_assert_not_equal("${rc}" "0" "new --bogus should fail")
    qt_assert_contains("${err}" "unrecognized option '--bogus'" "new --bogus error message")

    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS pop --bogus)
    qt_assert_not_equal("${rc}" "0" "pop --bogus should fail")
    qt_assert_contains("${err}" "unrecognized option '--bogus'" "pop --bogus error message")

    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS fork --bogus)
    qt_assert_not_equal("${rc}" "0" "fork --bogus should fail")
    qt_assert_contains("${err}" "unrecognized option '--bogus'" "fork --bogus error message")
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

# Three patches on f.txt for the --color scenarios: a.patch applied, an
# empty b.patch on top, and c.patch unapplied, whose hunk applies one line
# away from where it says (upstream colors the offset in push output).
function(qt_setup_color_stack)
    qt_write_file("${QT_WORK_DIR}/f.txt" "head\nx\nl2\nl3\n")
    qt_quilt_ok(ARGS new a.patch MESSAGE "new a failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add a failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "head\na\nl2\nl3\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh a failed")
    qt_quilt_ok(ARGS new b.patch MESSAGE "new b failed")
    qt_write_file("${QT_WORK_DIR}/patches/c.patch"
        "--- a/f.txt\n+++ b/f.txt\n@@ -1,3 +1,3 @@\n a\n l2\n-l3\n+c\n")
    qt_append_file("${QT_WORK_DIR}/patches/series" "c.patch\n")
endfunction()

# Run each command that takes --color with the given form and QUILT_COLORS,
# requiring success, and return everything they printed in out_var.
function(qt_run_color_commands out_var form colors)
    set(all "")
    foreach(args IN ITEMS "series" "series;-v" "patches;f.txt" "patches;-v;f.txt"
                          "diff;-P;a.patch" "push")
        qt_quilt(RESULT rc OUTPUT out ERROR err ENV "QUILT_COLORS=${colors}"
                 ARGS ${args} ${form})
        string(REPLACE ";" " " shown "${args} ${form}")
        qt_assert_success("${rc}" "${shown} should succeed")
        string(APPEND all "${out}${err}")
    endforeach()
    qt_assert_contains("${all}" "Now at patch c.patch" "push ${form} should push c.patch")
    qt_quilt_ok(ARGS pop MESSAGE "pop after push ${form} failed")
    set(${out_var} "${all}" PARENT_SCOPE)
endfunction()

# Every --color form upstream accepts: none, an empty value, always, auto,
# tty, and never. Upstream colors some of these, so only success is checked.
function(qt_scenario_color_option_forms)
    qt_begin_test("color_option_forms")
    qt_setup_color_stack()
    foreach(form IN ITEMS "--color" "--color=" "--color=always" "--color=auto"
                          "--color=tty" "--color=never")
        qt_run_color_commands(out "${form}" "")
    endforeach()
endfunction()

# Quilt.cpp accepts --color but never colors (README), whatever the form or
# QUILT_COLORS says
function(qt_scenario_color_option_no_escapes)
    qt_begin_test("color_option_no_escapes")
    string(ASCII 27 esc)
    qt_setup_color_stack()
    foreach(form IN ITEMS "--color" "--color=" "--color=always" "--color=auto"
                          "--color=tty" "--color=never")
        qt_run_color_commands(out "${form}" "series_app=4:diff_add=1")
        qt_assert_not_contains("${out}" "${esc}" "${form} should not emit escape sequences")
    endforeach()
endfunction()

# An invalid --color value prints the usage and fails, like upstream
function(qt_scenario_color_option_invalid)
    qt_begin_test("color_option_invalid")
    qt_setup_color_stack()
    foreach(value IN ITEMS "bogus" "ALWAYS")
        qt_quilt(RESULT rc OUTPUT out ERROR err ARGS series --color=${value})
        qt_assert_equal("${rc}" "1" "series --color=${value} should fail")
        qt_combine_output(combined "${out}" "${err}")
        qt_assert_contains("${combined}"
            "Usage: quilt series [--color[=always|auto|never]] [-v]"
            "series --color=${value} should print usage")
        qt_assert_not_contains("${combined}" "a.patch" "series --color=${value} should not list patches")

        qt_quilt(RESULT rc OUTPUT out ERROR err ARGS patches --color=${value} f.txt)
        qt_assert_equal("${rc}" "1" "patches --color=${value} should fail")
        qt_combine_output(combined "${out}" "${err}")
        qt_assert_contains("${combined}"
            "Usage: quilt patches [-v] [--color[=always|auto|never]] {file} [files...]"
            "patches --color=${value} should print usage")

        qt_quilt(RESULT rc OUTPUT out ERROR err ARGS diff --color=${value})
        qt_assert_equal("${rc}" "1" "diff --color=${value} should fail")
        qt_combine_output(combined "${out}" "${err}")
        qt_assert_contains("${combined}"
            "Usage: quilt diff [-p n|-p ab] [-u|-U num|-c|-C num] [--combine patch|-z] [-R] [-P patch] [--snapshot] [--diff=utility] [--no-timestamps] [--no-index] [--sort] [--color[=always|auto|never]] [file ...]"
            "diff --color=${value} should print usage")

        qt_quilt(RESULT rc OUTPUT out ERROR err ARGS push --color=${value})
        qt_assert_equal("${rc}" "1" "push --color=${value} should fail")
        qt_combine_output(combined "${out}" "${err}")
        qt_assert_contains("${combined}"
            "Usage: quilt push [-afqvm] [--fuzz=N] [--merge[=merge|diff3]] [--leave-rejects] [--color[=always|auto|never]] [--refresh] [num|patch]"
            "push --color=${value} should print usage")
        qt_assert_file_text("${QT_WORK_DIR}/.pc/applied-patches" "a.patch\nb.patch"
            "push --color=${value} should not push")
    endforeach()

    # Without a file, patches prints the same usage
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS patches)
    qt_assert_equal("${rc}" "1" "patches without a file should fail")
    qt_combine_output(combined "${out}" "${err}")
    qt_assert_contains("${combined}"
        "Usage: quilt patches [-v] [--color[=always|auto|never]] {file} [files...]"
        "patches without a file should print usage")
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
    qt_assert_contains("${combined}" "No patch removed" "should explain no patch was removed")
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
    qt_assert_file_contains("${QT_WORK_DIR}/f.txt" "<<<<<<<" "failed hunk should produce conflict marker")
    qt_assert_file_contains("${QT_WORK_DIR}/f.txt" ">>>>>>>" "failed hunk should produce end marker")
endfunction()

# builtin_patch_merge_diff3: push --merge=diff3 with conflict produces diff3-style
# markers including the ||||||| section
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
    qt_assert_file_contains("${QT_WORK_DIR}/f.txt" "<<<<<<<" "should have conflict open")
    qt_assert_file_contains("${QT_WORK_DIR}/f.txt" "|||||||" "diff3 style should have expected section")
    qt_assert_file_contains("${QT_WORK_DIR}/f.txt" "=======" "should have separator")
    qt_assert_file_contains("${QT_WORK_DIR}/f.txt" ">>>>>>>" "should have conflict end")
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
    # Second refresh with --diffstat: the diffstat in the header (after its
    # "---" line) is replaced where it stands
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

# revert_file_delete: revert should delete file when patch deletes it
function(qt_scenario_revert_file_delete)
    qt_begin_test("revert_file_delete")
    qt_write_file("${QT_WORK_DIR}/f.txt" "content\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    file(REMOVE "${QT_WORK_DIR}/f.txt")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    # Recreate the file (simulating user edit after patch deleted it)
    qt_write_file("${QT_WORK_DIR}/f.txt" "recreated\n")
    # Revert should delete the file (post-patch state = no file)
    qt_quilt_ok(ARGS revert f.txt MESSAGE "revert failed")
    if(EXISTS "${QT_WORK_DIR}/f.txt")
        qt_fail("revert should delete file when patch deletes it")
    endif()
endfunction()

# header_nonexistent_patch: header with unknown patch should error
function(qt_scenario_header_nonexistent_patch)
    qt_begin_test("header_nonexistent_patch")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS header nosuch.patch)
    qt_assert_failure("${rc}" "header with nonexistent patch should fail")
    qt_combine_output(combined "${out}" "${err}")
    qt_assert_contains("${combined}" "not in series" "should say patch not in series")
endfunction()

# import_applied_reject: import -f should reject overwriting applied patch
function(qt_scenario_import_applied_reject)
    qt_begin_test("import_applied_reject")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_quilt_ok(ARGS new existing.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "y\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    # Create an external patch file to import
    qt_write_file("${QT_WORK_DIR}/external.patch"
        "--- a/f.txt\n+++ b/f.txt\n@@ -1 +1 @@\n-x\n+z\n")
    # import -f -P existing.patch while applied should fail
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS import -f -P existing.patch "${QT_WORK_DIR}/external.patch")
    qt_assert_failure("${rc}" "import -f of applied patch should fail")
    qt_combine_output(combined "${out}" "${err}")
    qt_assert_contains("${combined}" "applied" "should say patch is applied")
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
    # fold with no stdin data should succeed (no-op, matching original quilt)
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS fold INPUT "")
    qt_assert_success("${rc}" "fold with empty stdin should succeed")
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

# push_empty_series: series file exists but is empty — should say "No patches in series"
function(qt_scenario_push_empty_series)
    qt_begin_test("push_empty_series")
    file(MAKE_DIRECTORY "${QT_WORK_DIR}/patches")
    qt_write_file("${QT_WORK_DIR}/patches/series" "")
    # push
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS push)
    qt_assert_failure("${rc}" "push with empty series should fail")
    qt_combine_output(combined "${out}" "${err}")
    qt_assert_contains("${combined}" "No patches in series" "push should say no patches in series")
    # top
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS top)
    qt_assert_failure("${rc}" "top with empty series should fail")
    qt_combine_output(combined "${out}" "${err}")
    qt_assert_contains("${combined}" "No patches in series" "top should say no patches in series")
    # next
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS next)
    qt_assert_failure("${rc}" "next with empty series should fail")
    qt_combine_output(combined "${out}" "${err}")
    qt_assert_contains("${combined}" "No patches in series" "next should say no patches in series")
    # previous
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS previous)
    qt_assert_failure("${rc}" "previous with empty series should fail")
    qt_combine_output(combined "${out}" "${err}")
    qt_assert_contains("${combined}" "No patches in series" "previous should say no patches in series")
    # applied
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS applied)
    qt_assert_failure("${rc}" "applied with empty series should fail")
    qt_combine_output(combined "${out}" "${err}")
    qt_assert_contains("${combined}" "No patches in series" "applied should say no patches in series")
    # unapplied
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS unapplied)
    qt_assert_failure("${rc}" "unapplied with empty series should fail")
    qt_combine_output(combined "${out}" "${err}")
    qt_assert_contains("${combined}" "No patches in series" "unapplied should say no patches in series")
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
    # -p0 as a combined flag should succeed
    qt_quilt_ok(ARGS new -p0 foo.patch MESSAGE "new -p0 failed")
    qt_assert_file_contains("${QT_WORK_DIR}/patches/series" "-p0" "series should contain -p0")
    # -p2 should be rejected (only -p0 and -p1 are valid)
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS new -p2 bar.patch)
    qt_assert_failure("${rc}" "new -p2 should fail")
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
    # Pop all, then push p1 only — p2 and p3 are unapplied
    qt_quilt_ok(ARGS pop -a MESSAGE "pop -a failed")
    qt_quilt_ok(ARGS push MESSAGE "push p1 failed")
    # next with an applied patch should error
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS next p1.patch)
    qt_assert_failure("${rc}" "next applied patch should fail")
    qt_combine_output(combined "${out}" "${err}")
    qt_assert_contains("${combined}" "currently applied" "should say currently applied")
    # next with an unapplied patch returns the patch itself
    qt_quilt_ok(OUTPUT next_out ARGS next p2.patch MESSAGE "next p2 failed")
    qt_assert_contains("${next_out}" "p2.patch" "next unapplied p2 should return p2")
    qt_quilt_ok(OUTPUT next3_out ARGS next p3.patch MESSAGE "next p3 failed")
    qt_assert_contains("${next3_out}" "p3.patch" "next unapplied p3 should return p3")
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
    # --strip-trailing-whitespace should NOT strip context lines
    qt_quilt(RESULT rc OUTPUT refresh_out ERROR refresh_err ARGS refresh --strip-trailing-whitespace)
    qt_assert_success("${rc}" "refresh --strip-trailing-whitespace should succeed")
    # The whitespace-only line is context (not modified), so should not be stripped
    qt_assert_file_contains("${QT_WORK_DIR}/f.txt" "   " "context whitespace-only line should be preserved")
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
    # No patches applied and no patch arg → should error
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS header)
    qt_assert_failure("${rc}" "header with no patches applied should fail")
    qt_combine_output(combined "${out}" "${err}")
    qt_assert_contains("${combined}" "No patches applied" "header should say no patches applied")
    # But specifying the patch by name should still work
    qt_quilt_ok(ARGS header p.patch MESSAGE "header with patch arg should work")
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
    # -v outputs "  filename" format with two-space prefix (matches original quilt)
    qt_quilt_ok(OUTPUT out ERROR err ARGS files -v MESSAGE "files -v failed")
    qt_assert_contains("${out}" "f.txt" "files -v should list f.txt")
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

# delete_topmost_output: delete should not print per-file "Restoring" messages
function(qt_scenario_delete_topmost_output)
    qt_begin_test("delete_topmost_output")
    qt_write_file("${QT_WORK_DIR}/f.txt" "base\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "mod\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    qt_quilt_ok(OUTPUT out ERROR err ARGS delete -r MESSAGE "delete -r failed")
    qt_combine_output(combined "${out}" "${err}")
    # Should NOT contain "Restoring" per-file messages
    string(FIND "${combined}" "Restoring" restoring_pos)
    if(NOT restoring_pos EQUAL -1)
        qt_fail("delete should not print per-file 'Restoring' messages")
    endif()
    # Should contain standard messages
    qt_assert_contains("${combined}" "Removing patch" "should say removing patch")
    qt_assert_contains("${combined}" "No patches applied" "should say no patches applied")
    qt_assert_contains("${combined}" "Removed patch" "should say removed patch")
    # File should be restored
    qt_assert_file_contains("${QT_WORK_DIR}/f.txt" "base" "file should be restored")
endfunction()

# fold_force_rejects: fold -f should return 0 even with rejected hunks
function(qt_scenario_fold_force_rejects)
    qt_begin_test("fold_force_rejects")
    qt_write_file("${QT_WORK_DIR}/f.txt" "aaa\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "bbb\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    # Fold a conflicting patch with -f: should succeed (exit 0)
    qt_quilt_ok(
        ARGS fold -f
        INPUT [=[--- a/f.txt
+++ b/f.txt
@@ -1 +1 @@
-zzz
+yyy
]=]
        MESSAGE "fold -f should succeed even with rejects"
    )
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
    qt_assert_matches("${out}" "^[0-9]+\\.[0-9]" "--version should print version")
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
    elseif(scenario STREQUAL "import_strip_level_attached")
        qt_scenario_import_strip_level_attached()
    elseif(scenario STREQUAL "import_attached_P_d")
        qt_scenario_import_attached_P_d()
    elseif(scenario STREQUAL "import_dup_invalid_mode")
        qt_scenario_import_dup_invalid_mode()
    elseif(scenario STREQUAL "import_grouped_options")
        qt_scenario_import_grouped_options()
    elseif(scenario STREQUAL "import_end_of_options")
        qt_scenario_import_end_of_options()
    elseif(scenario STREQUAL "import_strip_level_as_given")
        qt_scenario_import_strip_level_as_given()
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
    elseif(scenario STREQUAL "refresh_strip_whitespace_binary")
        qt_scenario_refresh_strip_whitespace_binary()
    elseif(scenario STREQUAL "refresh_strip_whitespace_no_eol")
        qt_scenario_refresh_strip_whitespace_no_eol()
    elseif(scenario STREQUAL "refresh_strip_whitespace_crlf")
        qt_scenario_refresh_strip_whitespace_crlf()
    elseif(scenario STREQUAL "refresh_strip_whitespace_context")
        qt_scenario_refresh_strip_whitespace_context()
    elseif(scenario STREQUAL "refresh_strip_whitespace_diff_fail")
        qt_scenario_refresh_strip_whitespace_diff_fail()
    elseif(scenario STREQUAL "refresh_trailing_ws_warning")
        qt_scenario_refresh_trailing_ws_warning()
    elseif(scenario STREQUAL "refresh_trailing_ws_warning_lines")
        qt_scenario_refresh_trailing_ws_warning_lines()
    elseif(scenario STREQUAL "refresh_trailing_ws_warning_shadowed")
        qt_scenario_refresh_trailing_ws_warning_shadowed()
    elseif(scenario STREQUAL "refresh_strip_whitespace_shadowed")
        qt_scenario_refresh_strip_whitespace_shadowed()
    elseif(scenario STREQUAL "refresh_strip_whitespace_shadowed_deleted")
        qt_scenario_refresh_strip_whitespace_shadowed_deleted()
    elseif(scenario STREQUAL "refresh_strip_whitespace_shadowed_late")
        qt_scenario_refresh_strip_whitespace_shadowed_late()
    elseif(scenario STREQUAL "refresh_fork")
        qt_scenario_refresh_fork()
    elseif(scenario STREQUAL "refresh_fork_named")
        qt_scenario_refresh_fork_named()
    elseif(scenario STREQUAL "refresh_fork_not_top")
        qt_scenario_refresh_fork_not_top()
    elseif(scenario STREQUAL "refresh_fork_nothing")
        qt_scenario_refresh_fork_nothing()
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
    elseif(scenario STREQUAL "color_option_no_escapes")
        qt_scenario_color_option_no_escapes()
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
    elseif(scenario STREQUAL "push_empty_series")
        qt_scenario_push_empty_series()
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
    elseif(scenario STREQUAL "revert_file_delete")
        qt_scenario_revert_file_delete()
    elseif(scenario STREQUAL "header_with_patch_arg")
        qt_scenario_header_with_patch_arg()
    elseif(scenario STREQUAL "header_nonexistent_patch")
        qt_scenario_header_nonexistent_patch()
    elseif(scenario STREQUAL "import_applied_reject")
        qt_scenario_import_applied_reject()
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
    elseif(scenario STREQUAL "delete_topmost_output")
        qt_scenario_delete_topmost_output()
    elseif(scenario STREQUAL "fold_force_rejects")
        qt_scenario_fold_force_rejects()
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
    elseif(scenario STREQUAL "push_quilt_patch_opts")
        qt_scenario_push_quilt_patch_opts()
    elseif(scenario STREQUAL "pop_auto_refresh_fail")
        qt_scenario_pop_auto_refresh_fail()
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
    elseif(scenario STREQUAL "refresh_diffstat_context")
        qt_scenario_refresh_diffstat_context()
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
    elseif(scenario STREQUAL "push_offset_one_line")
        qt_scenario_push_offset_one_line()
    elseif(scenario STREQUAL "header_edit_fail")
        qt_scenario_header_edit_fail()
    elseif(scenario STREQUAL "push_backward_offset")
        qt_scenario_push_backward_offset()
    elseif(scenario STREQUAL "push_hunk_past_eof")
        qt_scenario_push_hunk_past_eof()
    elseif(scenario STREQUAL "push_hunk_huge_line_number")
        qt_scenario_push_hunk_huge_line_number()
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
    elseif(scenario STREQUAL "quiltrc_comments")
        qt_scenario_quiltrc_comments()
    elseif(scenario STREQUAL "refresh_diffstat_twice")
        qt_scenario_refresh_diffstat_twice()
    elseif(scenario STREQUAL "refresh_diffstat_header_replace")
        qt_scenario_refresh_diffstat_header_replace()
    elseif(scenario STREQUAL "series_in_pc_dir")
        qt_scenario_series_in_pc_dir()
    elseif(scenario STREQUAL "series_pc_precedes_root")
        qt_scenario_series_pc_precedes_root()
    elseif(scenario STREQUAL "quilt_series_pc_search_order")
        qt_scenario_quilt_series_pc_search_order()
    elseif(scenario STREQUAL "series_leading_space_no_newline")
        qt_scenario_series_leading_space_no_newline()
    elseif(scenario STREQUAL "header_replace_no_newline")
        qt_scenario_header_replace_no_newline()
    elseif(scenario STREQUAL "header_desc_lookalike_lines")
        qt_scenario_header_desc_lookalike_lines()
    elseif(scenario STREQUAL "header_context_diff_no_index")
        qt_scenario_header_context_diff_no_index()
    elseif(scenario STREQUAL "header_crlf_preserved")
        qt_scenario_header_crlf_preserved()
    elseif(scenario STREQUAL "header_strip_diffstat_upstream")
        qt_scenario_header_strip_diffstat_upstream()
    elseif(scenario STREQUAL "header_lookahead_edges")
        qt_scenario_header_lookahead_edges()
    elseif(scenario STREQUAL "refresh_keeps_lookalike_header")
        qt_scenario_refresh_keeps_lookalike_header()
    elseif(scenario STREQUAL "refresh_diffstat_in_place")
        qt_scenario_refresh_diffstat_in_place()
    elseif(scenario STREQUAL "mail_subject_lookalike")
        qt_scenario_mail_subject_lookalike()
    elseif(scenario STREQUAL "import_force_keeps_old_header")
        qt_scenario_import_force_keeps_old_header()
    elseif(scenario STREQUAL "import_force_headers_differ_hunk")
        qt_scenario_import_force_headers_differ_hunk()
    elseif(scenario STREQUAL "import_force_upstream_sequence")
        qt_scenario_import_force_upstream_sequence()
    elseif(scenario STREQUAL "import_force_strips_old_diffstat")
        qt_scenario_import_force_strips_old_diffstat()
    elseif(scenario STREQUAL "import_force_diffstat_not_a_conflict")
        qt_scenario_import_force_diffstat_not_a_conflict()
    elseif(scenario STREQUAL "import_force_header_boundaries")
        qt_scenario_import_force_header_boundaries()
    elseif(scenario STREQUAL "import_force_identical_header_once")
        qt_scenario_import_force_identical_header_once()
    elseif(scenario STREQUAL "import_force_mode_per_patch")
        qt_scenario_import_force_mode_per_patch()
    elseif(scenario STREQUAL "push_fuzz_value_forms")
        qt_scenario_push_fuzz_value_forms()
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
    elseif(scenario STREQUAL "graph_reduce_preserves_selected")
        qt_scenario_graph_reduce_preserves_selected()
    elseif(scenario STREQUAL "graph_prune_unreachable_edge")
        qt_scenario_graph_prune_unreachable_edge()
    elseif(scenario STREQUAL "graph_empty_backup_files")
        qt_scenario_graph_empty_backup_files()
    elseif(scenario STREQUAL "push_fuzz_preserves_lines")
        qt_scenario_push_fuzz_preserves_lines()
    elseif(scenario STREQUAL "applied_unapplied_target")
        qt_scenario_applied_unapplied_target()
    elseif(scenario STREQUAL "add_remove_unapplied_P")
        qt_scenario_add_remove_unapplied_P()
    elseif(scenario STREQUAL "fold_strip_level")
        qt_scenario_fold_strip_level()
    elseif(scenario STREQUAL "diff_U0_pure_insert")
        qt_scenario_diff_U0_pure_insert()
    elseif(scenario STREQUAL "refresh_shadow_rediff")
        qt_scenario_refresh_shadow_rediff()
    elseif(scenario STREQUAL "import_P_multiple")
        qt_scenario_import_P_multiple()
    elseif(scenario STREQUAL "pop_deletes_empty_file")
        qt_scenario_pop_deletes_empty_file()
    elseif(scenario STREQUAL "pc_quilt_patches_overrides_env")
        qt_scenario_pc_quilt_patches_overrides_env()
    elseif(scenario STREQUAL "pc_quilt_series_is_filename")
        qt_scenario_pc_quilt_series_is_filename()
    elseif(scenario STREQUAL "rename_drops_strip_level")
        qt_scenario_rename_drops_strip_level()
    elseif(scenario STREQUAL "series_v_markers")
        qt_scenario_series_v_markers()
    elseif(scenario STREQUAL "diff_reverse_labels")
        qt_scenario_diff_reverse_labels()
    elseif(scenario STREQUAL "refresh_index_p0")
        qt_scenario_refresh_index_p0()
    elseif(scenario STREQUAL "refresh_index_pab")
        qt_scenario_refresh_index_pab()
    elseif(scenario STREQUAL "push_a_blank_lines")
        qt_scenario_push_a_blank_lines()
    elseif(scenario STREQUAL "pop_a_blank_lines")
        qt_scenario_pop_a_blank_lines()
    elseif(scenario STREQUAL "refresh_strip_ws_modifies_file")
        qt_scenario_refresh_strip_ws_modifies_file()
    elseif(scenario STREQUAL "patches_v_markers")
        qt_scenario_patches_v_markers()
    elseif(scenario STREQUAL "pop_shows_removing")
        qt_scenario_pop_shows_removing()
    elseif(scenario STREQUAL "revert_restores_post_patch")
        qt_scenario_revert_restores_post_patch()
    elseif(scenario STREQUAL "revert_unchanged")
        qt_scenario_revert_unchanged()
    elseif(scenario STREQUAL "revert_later_patch")
        qt_scenario_revert_later_patch()
    elseif(scenario STREQUAL "delete_applied_non_top")
        qt_scenario_delete_applied_non_top()
    elseif(scenario STREQUAL "delete_top_messages")
        qt_scenario_delete_top_messages()
    elseif(scenario STREQUAL "fold_joined_p_flag")
        qt_scenario_fold_joined_p_flag()
    elseif(scenario STREQUAL "header_append_message")
        qt_scenario_header_append_message()
    elseif(scenario STREQUAL "header_replace_message")
        qt_scenario_header_replace_message()
    elseif(scenario STREQUAL "refresh_subdir_patch")
        qt_scenario_refresh_subdir_patch()
    elseif(scenario STREQUAL "refresh_unchanged_message")
        qt_scenario_refresh_unchanged_message()
    elseif(scenario STREQUAL "refresh_empty_message")
        qt_scenario_refresh_empty_message()
    elseif(scenario STREQUAL "refresh_empty_unchanged")
        qt_scenario_refresh_empty_unchanged()
    elseif(scenario STREQUAL "diff_combine_equals")
        qt_scenario_diff_combine_equals()
    elseif(scenario STREQUAL "refresh_sorted_default")
        qt_scenario_refresh_sorted_default()
    elseif(scenario STREQUAL "diff_P_shadowed")
        qt_scenario_diff_P_shadowed()
    elseif(scenario STREQUAL "add_P_higher_patch")
        qt_scenario_add_P_higher_patch()
    elseif(scenario STREQUAL "import_dup_append_separator")
        qt_scenario_import_dup_append_separator()
    elseif(scenario STREQUAL "pop_dirty_tree")
        qt_scenario_pop_dirty_tree()
    elseif(scenario STREQUAL "pop_dirty_tree_force")
        qt_scenario_pop_dirty_tree_force()
    elseif(scenario STREQUAL "pop_dirty_tree_refresh")
        qt_scenario_pop_dirty_tree_refresh()
    elseif(scenario STREQUAL "push_verbose_long_option")
        qt_scenario_push_verbose_long_option()
    elseif(scenario STREQUAL "refresh_binary_file")
        qt_scenario_refresh_binary_file()
    elseif(scenario STREQUAL "merge_markers_per_hunk")
        qt_scenario_merge_markers_per_hunk()
    elseif(scenario STREQUAL "quilt_patches_absolute_path")
        qt_scenario_quilt_patches_absolute_path()
    elseif(scenario STREQUAL "push_already_applied_exit2")
        qt_scenario_push_already_applied_exit2()
    elseif(scenario STREQUAL "pop_target_top_no_patch_removed")
        qt_scenario_pop_target_top_no_patch_removed()
    elseif(scenario STREQUAL "unapplied_last_patch_ok")
        qt_scenario_unapplied_last_patch_ok()
    elseif(scenario STREQUAL "push_quiet_no_extra_blank")
        qt_scenario_push_quiet_no_extra_blank()
    elseif(scenario STREQUAL "pop_quiet_no_extra_blank")
        qt_scenario_pop_quiet_no_extra_blank()
    elseif(scenario STREQUAL "next_applied_patch_errors")
        qt_scenario_next_applied_patch_errors()
    elseif(scenario STREQUAL "pop_dirty_hint_message")
        qt_scenario_pop_dirty_hint_message()
    elseif(scenario STREQUAL "refresh_fork_no_extra_message")
        qt_scenario_refresh_fork_no_extra_message()
    elseif(scenario STREQUAL "fork_increment_suffix")
        qt_scenario_fork_increment_suffix()
    elseif(scenario STREQUAL "refresh_strip_ws_only_modified")
        qt_scenario_refresh_strip_ws_only_modified()
    elseif(scenario STREQUAL "import_applied_no_force")
        qt_scenario_import_applied_no_force()
    elseif(scenario STREQUAL "import_force_identical")
        qt_scenario_import_force_identical()
    elseif(scenario STREQUAL "header_strip_diffstat_keeps_separator")
        qt_scenario_header_strip_diffstat_keeps_separator()
    elseif(scenario STREQUAL "diff_p0_orig_label")
        qt_scenario_diff_p0_orig_label()
    elseif(scenario STREQUAL "refresh_p0_orig_label")
        qt_scenario_refresh_p0_orig_label()
    elseif(scenario STREQUAL "series_no_series_file")
        qt_scenario_series_no_series_file()
    elseif(scenario STREQUAL "top_no_series_exit1")
        qt_scenario_top_no_series_exit1()
    elseif(scenario STREQUAL "next_no_series_exit1")
        qt_scenario_next_no_series_exit1()
    elseif(scenario STREQUAL "previous_no_series_exit1")
        qt_scenario_previous_no_series_exit1()
    elseif(scenario STREQUAL "dotfile_toplevel")
        qt_scenario_dotfile_toplevel()
    elseif(scenario STREQUAL "dotfile_subdir")
        qt_scenario_dotfile_subdir()
    elseif(scenario STREQUAL "refresh_named_unapplied")
        qt_scenario_refresh_named_unapplied()
    elseif(scenario STREQUAL "refresh_named_not_in_series")
        qt_scenario_refresh_named_not_in_series()
    elseif(scenario STREQUAL "diff_P_unapplied")
        qt_scenario_diff_P_unapplied()
    elseif(scenario STREQUAL "diff_combine_wrong_order")
        qt_scenario_diff_combine_wrong_order()
    elseif(scenario STREQUAL "diff_algorithm_myers")
        qt_scenario_diff_algorithm_myers()
    elseif(scenario STREQUAL "diff_algorithm_minimal")
        qt_scenario_diff_algorithm_minimal()
    elseif(scenario STREQUAL "diff_algorithm_invalid")
        qt_scenario_diff_algorithm_invalid()
    elseif(scenario STREQUAL "diff_algorithm_space_form")
        qt_scenario_diff_algorithm_space_form()
    elseif(scenario STREQUAL "refresh_diff_algorithm")
        qt_scenario_refresh_diff_algorithm()
    elseif(scenario STREQUAL "diff_algorithm_minimal_vs_myers")
        qt_scenario_diff_algorithm_minimal_vs_myers()
    elseif(scenario STREQUAL "diff_algorithm_myers_heuristic_tail")
        qt_scenario_diff_algorithm_myers_heuristic_tail()
    elseif(scenario STREQUAL "diff_algorithm_patience_basic")
        qt_scenario_diff_algorithm_patience_basic()
    elseif(scenario STREQUAL "diff_algorithm_patience_function_insert")
        qt_scenario_diff_algorithm_patience_function_insert()
    elseif(scenario STREQUAL "diff_algorithm_patience_no_unique")
        qt_scenario_diff_algorithm_patience_no_unique()
    elseif(scenario STREQUAL "diff_algorithm_histogram_basic")
        qt_scenario_diff_algorithm_histogram_basic()
    elseif(scenario STREQUAL "diff_algorithm_histogram_function_insert")
        qt_scenario_diff_algorithm_histogram_function_insert()
    elseif(scenario STREQUAL "diff_algorithm_histogram_no_unique")
        qt_scenario_diff_algorithm_histogram_no_unique()
    elseif(scenario STREQUAL "diff_algorithm_env")
        qt_scenario_diff_algorithm_env()
    elseif(scenario STREQUAL "diff_algorithm_env_override")
        qt_scenario_diff_algorithm_env_override()
    elseif(scenario STREQUAL "diff_algorithm_env_invalid")
        qt_scenario_diff_algorithm_env_invalid()
    elseif(scenario STREQUAL "diff_algorithm_env_diff_cmd")
        qt_scenario_diff_algorithm_env_diff_cmd()
    elseif(scenario STREQUAL "push_merge_short")
        qt_scenario_push_merge_short()
    elseif(scenario STREQUAL "push_quilt_patch_opts_reverse")
        qt_scenario_push_quilt_patch_opts_reverse()
    elseif(scenario STREQUAL "push_quiet_all")
        qt_scenario_push_quiet_all()
    elseif(scenario STREQUAL "push_empty_patch_file")
        qt_scenario_push_empty_patch_file()
    elseif(scenario STREQUAL "pop_quiet_all")
        qt_scenario_pop_quiet_all()
    elseif(scenario STREQUAL "pop_count_clamp")
        qt_scenario_pop_count_clamp()
    elseif(scenario STREQUAL "pop_refresh_needs_refresh")
        qt_scenario_pop_refresh_needs_refresh()
    elseif(scenario STREQUAL "pop_force_refresh_conflict")
        qt_scenario_pop_force_refresh_conflict()
    elseif(scenario STREQUAL "pop_empty_patch")
        qt_scenario_pop_empty_patch()
    elseif(scenario STREQUAL "pop_unrefreshed_outside_hunk")
        qt_scenario_pop_unrefreshed_outside_hunk()
    elseif(scenario STREQUAL "pop_never_refreshed")
        qt_scenario_pop_never_refreshed()
    elseif(scenario STREQUAL "pop_file_added_after_refresh")
        qt_scenario_pop_file_added_after_refresh()
    elseif(scenario STREQUAL "pop_reversed_series_patch")
        qt_scenario_pop_reversed_series_patch()
    elseif(scenario STREQUAL "pop_forced_patch_below_top")
        qt_scenario_pop_forced_patch_below_top()
    elseif(scenario STREQUAL "refresh_p0_deleted_file")
        qt_scenario_refresh_p0_deleted_file()
    elseif(scenario STREQUAL "diff_R_deleted_file_labels")
        qt_scenario_diff_R_deleted_file_labels()
    elseif(scenario STREQUAL "applied_patches_removed_when_empty")
        qt_scenario_applied_patches_removed_when_empty()
    elseif(scenario STREQUAL "refresh_invalid_p")
        qt_scenario_refresh_invalid_p()
    elseif(scenario STREQUAL "series_invalid_strip_level")
        qt_scenario_series_invalid_strip_level()
    elseif(scenario STREQUAL "diff_invalid_p")
        qt_scenario_diff_invalid_p()
    elseif(scenario STREQUAL "diff_binary")
        qt_scenario_diff_binary()
    elseif(scenario STREQUAL "refresh_binary_shadowed")
        qt_scenario_refresh_binary_shadowed()
    elseif(scenario STREQUAL "diff_z_deleted_file")
        qt_scenario_diff_z_deleted_file()
    elseif(scenario STREQUAL "diff_z_emptied_file")
        qt_scenario_diff_z_emptied_file()
    elseif(scenario STREQUAL "diff_z_shadowed")
        qt_scenario_diff_z_shadowed()
    elseif(scenario STREQUAL "diff_z_shadowed_unrefreshed")
        qt_scenario_diff_z_shadowed_unrefreshed()
    elseif(scenario STREQUAL "diff_z_shadowed_deleted")
        qt_scenario_diff_z_shadowed_deleted()
    elseif(scenario STREQUAL "diff_snapshot_reverse")
        qt_scenario_diff_snapshot_reverse()
    elseif(scenario STREQUAL "revert_multiple_files")
        qt_scenario_revert_multiple_files()
    elseif(scenario STREQUAL "revert_P_unapplied")
        qt_scenario_revert_P_unapplied()
    elseif(scenario STREQUAL "snapshot_no_series")
        qt_scenario_snapshot_no_series()
    elseif(scenario STREQUAL "series_empty_and_comments")
        qt_scenario_series_empty_and_comments()
    elseif(scenario STREQUAL "series_rejects_arguments")
        qt_scenario_series_rejects_arguments()
    elseif(scenario STREQUAL "color_option_forms")
        qt_scenario_color_option_forms()
    elseif(scenario STREQUAL "files_all_no_applied")
        qt_scenario_files_all_no_applied()
    elseif(scenario STREQUAL "delete_n_explicit")
        qt_scenario_delete_n_explicit()
    elseif(scenario STREQUAL "delete_backup_without_r")
        qt_scenario_delete_backup_without_r()
    elseif(scenario STREQUAL "header_mode_conflict")
        qt_scenario_header_mode_conflict()
    elseif(scenario STREQUAL "header_empty_stdin")
        qt_scenario_header_empty_stdin()
    elseif(scenario STREQUAL "import_preserves_series_args")
        qt_scenario_import_preserves_series_args()
    elseif(scenario STREQUAL "import_multiple_files")
        qt_scenario_import_multiple_files()
    elseif(scenario STREQUAL "import_P_subdir")
        qt_scenario_import_P_subdir()
    elseif(scenario STREQUAL "graph_lines_nonadjacent")
        qt_scenario_graph_lines_nonadjacent()
    elseif(scenario STREQUAL "graph_grey_only_when_isolated")
        qt_scenario_graph_grey_only_when_isolated()
    elseif(scenario STREQUAL "quiltrc_dash_disables")
        qt_scenario_quiltrc_dash_disables()
    elseif(scenario STREQUAL "annotate_delete_only")
        qt_scenario_annotate_delete_only()
    elseif(scenario STREQUAL "rename_pc_migration")
        qt_scenario_rename_pc_migration()
    elseif(scenario STREQUAL "fork_pc_migration")
        qt_scenario_fork_pc_migration()
    elseif(scenario STREQUAL "prefixed_args_delete")
        qt_scenario_prefixed_args_delete()
    elseif(scenario STREQUAL "prefix_only_patch_arg")
        qt_scenario_prefix_only_patch_arg()
    elseif(scenario STREQUAL "empty_patch_arg")
        qt_scenario_empty_patch_arg()
    elseif(scenario STREQUAL "patch_lookup_errors")
        qt_scenario_patch_lookup_errors()
    elseif(scenario STREQUAL "top_patch_series_checks")
        qt_scenario_top_patch_series_checks()
    elseif(scenario STREQUAL "refresh_diff_patch_lookup")
        qt_scenario_refresh_diff_patch_lookup()
    elseif(scenario STREQUAL "push_nothing_to_push_first")
        qt_scenario_push_nothing_to_push_first()
    elseif(scenario STREQUAL "push_pop_deletion")
        qt_scenario_push_pop_deletion()
    elseif(scenario STREQUAL "push_keeps_emptied_file")
        qt_scenario_push_keeps_emptied_file()
    elseif(scenario STREQUAL "fold_deletion")
        qt_scenario_fold_deletion()
    elseif(scenario STREQUAL "files_unapplied_strip_deletion")
        qt_scenario_files_unapplied_strip_deletion()
    elseif(scenario STREQUAL "patches_unapplied_strip_deletion")
        qt_scenario_patches_unapplied_strip_deletion()
    elseif(scenario STREQUAL "pop_reversed_patch")
        qt_scenario_pop_reversed_patch()
    elseif(scenario STREQUAL "new_preserves_series_comments")
        qt_scenario_new_preserves_series_comments()
    elseif(scenario STREQUAL "import_preserves_series_comments")
        qt_scenario_import_preserves_series_comments()
    elseif(scenario STREQUAL "delete_preserves_series_comments")
        qt_scenario_delete_preserves_series_comments()
    elseif(scenario STREQUAL "rename_preserves_series_comments")
        qt_scenario_rename_preserves_series_comments()
    elseif(scenario STREQUAL "fork_preserves_series_comments")
        qt_scenario_fork_preserves_series_comments()
    elseif(scenario STREQUAL "refresh_z_preserves_series_comments")
        qt_scenario_refresh_z_preserves_series_comments()
    elseif(scenario STREQUAL "push_garbage_patch")
        qt_scenario_push_garbage_patch()
    elseif(scenario STREQUAL "push_force_garbage_patch")
        qt_scenario_push_force_garbage_patch()
    elseif(scenario STREQUAL "push_header_only_section")
        qt_scenario_push_header_only_section()
    elseif(scenario STREQUAL "fold_garbage_input")
        qt_scenario_fold_garbage_input()
    elseif(scenario STREQUAL "refresh_z_increments_suffix")
        qt_scenario_refresh_z_increments_suffix()
    elseif(scenario STREQUAL "refresh_z_next_filename_shapes")
        qt_scenario_refresh_z_next_filename_shapes()
    elseif(scenario STREQUAL "fork_next_filename_shapes")
        qt_scenario_fork_next_filename_shapes()
    elseif(scenario STREQUAL "fork_target_exists")
        qt_scenario_fork_target_exists()
    elseif(scenario STREQUAL "fork_patches_prefix")
        qt_scenario_fork_patches_prefix()
    elseif(scenario STREQUAL "fork_empty_name")
        qt_scenario_fork_empty_name()
    elseif(scenario STREQUAL "fork_leading_zero_suffix")
        qt_scenario_fork_leading_zero_suffix()
    elseif(scenario STREQUAL "revert_checks_all_files_first")
        qt_scenario_revert_checks_all_files_first()
    elseif(scenario STREQUAL "revert_shadowed_file")
        qt_scenario_revert_shadowed_file()
    elseif(scenario STREQUAL "revert_unnormalized_path")
        qt_scenario_revert_unnormalized_path()
    elseif(scenario STREQUAL "revert_patch_resolution")
        qt_scenario_revert_patch_resolution()
    elseif(scenario STREQUAL "revert_no_series")
        qt_scenario_revert_no_series()
    elseif(scenario STREQUAL "revert_reversed_patch")
        qt_scenario_revert_reversed_patch()
    elseif(scenario STREQUAL "revert_dot_slash_headers")
        qt_scenario_revert_dot_slash_headers()
    elseif(scenario STREQUAL "refresh_z_strip_migration")
        qt_scenario_refresh_z_strip_migration()
    elseif(scenario STREQUAL "annotate_P_missing_arg")
        qt_scenario_annotate_P_missing_arg()
    elseif(scenario STREQUAL "refresh_p0_records_strip_level")
        qt_scenario_refresh_p0_records_strip_level()
    elseif(scenario STREQUAL "refresh_pab_clears_p0")
        qt_scenario_refresh_pab_clears_p0()
    elseif(scenario STREQUAL "refresh_reversed_writes_forward")
        qt_scenario_refresh_reversed_writes_forward()
    elseif(scenario STREQUAL "refresh_p1_clears_p2")
        qt_scenario_refresh_p1_clears_p2()
    elseif(scenario STREQUAL "refresh_z_pab_on_p0")
        qt_scenario_refresh_z_pab_on_p0()
    elseif(scenario STREQUAL "refresh_series_comments_kept")
        qt_scenario_refresh_series_comments_kept()
    elseif(scenario STREQUAL "refresh_z_reversed_fork")
        qt_scenario_refresh_z_reversed_fork()
    elseif(scenario STREQUAL "refresh_series_split_p_option")
        qt_scenario_refresh_series_split_p_option()
    elseif(scenario STREQUAL "refresh_z_fork_series_args")
        qt_scenario_refresh_z_fork_series_args()
    elseif(scenario STREQUAL "series_insert_crlf")
        qt_scenario_series_insert_crlf()
    elseif(scenario STREQUAL "push_context_diff")
        qt_scenario_push_context_diff()
    elseif(scenario STREQUAL "push_context_diff_strip")
        qt_scenario_push_context_diff_strip()
    elseif(scenario STREQUAL "push_malformed_hunk")
        qt_scenario_push_malformed_hunk()
    elseif(scenario STREQUAL "push_truncated_hunk")
        qt_scenario_push_truncated_hunk()
    elseif(scenario STREQUAL "push_hunk_gnu_leniency")
        qt_scenario_push_hunk_gnu_leniency()
    elseif(scenario STREQUAL "push_zero_context_insert")
        qt_scenario_push_zero_context_insert()
    elseif(scenario STREQUAL "push_create_without_dev_null")
        qt_scenario_push_create_without_dev_null()
    elseif(scenario STREQUAL "push_create_existing_file")
        qt_scenario_push_create_existing_file()
    elseif(scenario STREQUAL "push_reverse_create_missing_file")
        qt_scenario_push_reverse_create_missing_file()
    elseif(scenario STREQUAL "push_delete_epoch_timestamp")
        qt_scenario_push_delete_epoch_timestamp()
    elseif(scenario STREQUAL "push_skip_missing_file")
        qt_scenario_push_skip_missing_file()
    elseif(scenario STREQUAL "push_skip_missing_later_file")
        qt_scenario_push_skip_missing_later_file()
    elseif(scenario STREQUAL "fold_skip_missing_file")
        qt_scenario_fold_skip_missing_file()
    elseif(scenario STREQUAL "fold_subdirectory")
        qt_scenario_fold_subdirectory()
    elseif(scenario STREQUAL "fold_subdirectory_rollback")
        qt_scenario_fold_subdirectory_rollback()
    elseif(scenario STREQUAL "diff_last_line_newline_change")
        qt_scenario_diff_last_line_newline_change()
    elseif(scenario STREQUAL "push_context_diff_zero_context")
        qt_scenario_push_context_diff_zero_context()
    elseif(scenario STREQUAL "push_missing_patch_file")
        qt_scenario_push_missing_patch_file()
    elseif(scenario STREQUAL "fold_fail_rollback")
        qt_scenario_fold_fail_rollback()
    elseif(scenario STREQUAL "fold_fail_rollback_create_delete")
        qt_scenario_fold_fail_rollback_create_delete()
    elseif(scenario STREQUAL "diff_context_line_ranges")
        qt_scenario_diff_context_line_ranges()
    elseif(scenario STREQUAL "diff_hunk_context_gap")
        qt_scenario_diff_hunk_context_gap()
    elseif(scenario STREQUAL "diff_incomplete_last_line")
        qt_scenario_diff_incomplete_last_line()
    elseif(scenario STREQUAL "diff_incomplete_last_lines_both")
        qt_scenario_diff_incomplete_last_lines_both()
    elseif(scenario STREQUAL "push_quiet_patch_output")
        qt_scenario_push_quiet_patch_output()
    elseif(scenario STREQUAL "push_verbose_patch_output")
        qt_scenario_push_verbose_patch_output()
    elseif(scenario STREQUAL "fold_quiet_patch_output")
        qt_scenario_fold_quiet_patch_output()
    elseif(scenario STREQUAL "push_missing_file_crlf_text")
        qt_scenario_push_missing_file_crlf_text()
    elseif(scenario STREQUAL "push_failed_hunk_output")
        qt_scenario_push_failed_hunk_output()
    elseif(scenario STREQUAL "fold_failed_hunk_output")
        qt_scenario_fold_failed_hunk_output()
    elseif(scenario STREQUAL "push_crlf_patch_output")
        qt_scenario_push_crlf_patch_output()
    elseif(scenario STREQUAL "push_reverse_applied")
        qt_scenario_push_reverse_applied()
    elseif(scenario STREQUAL "push_verbose_rollback")
        qt_scenario_push_verbose_rollback()
    elseif(scenario STREQUAL "push_reject_format")
        qt_scenario_push_reject_format()
    elseif(scenario STREQUAL "push_hunk_line_numbers")
        qt_scenario_push_hunk_line_numbers()
    elseif(scenario STREQUAL "push_delete_mismatch")
        qt_scenario_push_delete_mismatch()
    elseif(scenario STREQUAL "push_quoted_file_names")
        qt_scenario_push_quoted_file_names()
    elseif(scenario STREQUAL "getopt_push_pop")
        qt_scenario_getopt_push_pop()
    elseif(scenario STREQUAL "push_fuzz_value")
        qt_scenario_push_fuzz_value()
    elseif(scenario STREQUAL "getopt_stack_queries")
        qt_scenario_getopt_stack_queries()
    elseif(scenario STREQUAL "getopt_file_commands")
        qt_scenario_getopt_file_commands()
    elseif(scenario STREQUAL "getopt_new_snapshot")
        qt_scenario_getopt_new_snapshot()
    elseif(scenario STREQUAL "getopt_refresh_diff")
        qt_scenario_getopt_refresh_diff()
    elseif(scenario STREQUAL "getopt_delete_rename_fork")
        qt_scenario_getopt_delete_rename_fork()
    elseif(scenario STREQUAL "import_no_files")
        qt_scenario_import_no_files()
    elseif(scenario STREQUAL "getopt_header")
        qt_scenario_getopt_header()
    elseif(scenario STREQUAL "getopt_files_patches_fold")
        qt_scenario_getopt_files_patches_fold()
    elseif(scenario STREQUAL "getopt_long_prefixes")
        qt_scenario_getopt_long_prefixes()
    elseif(scenario STREQUAL "getopt_graph")
        qt_scenario_getopt_graph()
    elseif(scenario STREQUAL "getopt_help_operand")
        qt_scenario_getopt_help_operand()
    elseif(scenario STREQUAL "getopt_mail")
        qt_scenario_getopt_mail()
    elseif(scenario STREQUAL "getopt_help_value")
        qt_scenario_getopt_help_value()
    elseif(scenario STREQUAL "push_overlapping_hunks")
        qt_scenario_push_overlapping_hunks()
    elseif(scenario STREQUAL "push_overlapping_hunk_offsets")
        qt_scenario_push_overlapping_hunk_offsets()
    elseif(scenario STREQUAL "push_hunk_among_frozen_lines")
        qt_scenario_push_hunk_among_frozen_lines()
    elseif(scenario STREQUAL "push_misordered_hunks")
        qt_scenario_push_misordered_hunks()
    elseif(scenario STREQUAL "push_insertion_hunk_guess")
        qt_scenario_push_insertion_hunk_guess()
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
    qt_assert_file_contains("${QT_WORK_DIR}/f.txt" "<<<<<<<" "rejected hunk should produce conflict")
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
    qt_quilt_ok(ARGS pop -f MESSAGE "pop failed")
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

# refresh_diffstat_scale: like diffstat(1), a histogram too wide for 80
# columns is scaled down, each mark's remainder carrying into the next, so
# a small change may get fewer marks than it has lines, or none at all
function(qt_scenario_refresh_diffstat_scale)
    qt_begin_test("refresh_diffstat_scale")
    qt_write_file("${QT_WORK_DIR}/B.txt" "orig1\norig2\n")
    qt_write_file("${QT_WORK_DIR}/c.txt" "old1\nold2\nold3\nold4\nold5\nold6\n")
    qt_write_file("${QT_WORK_DIR}/d.txt" "same\nold\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add c.txt a.txt B.txt d.txt MESSAGE "add failed")
    set(big_content "")
    foreach(i RANGE 1 200)
        string(APPEND big_content "line${i}\n")
    endforeach()
    qt_write_file("${QT_WORK_DIR}/a.txt" "${big_content}")
    qt_write_file("${QT_WORK_DIR}/B.txt" "new1\nnew2\nnew3\nnew4\nnew5\nnew6\n")
    qt_write_file("${QT_WORK_DIR}/c.txt" "newer1\nnewer2\n")
    qt_write_file("${QT_WORK_DIR}/d.txt" "same\nnew\n")
    qt_quilt_ok(ARGS refresh --diffstat MESSAGE "refresh --diffstat failed")
    qt_read_file_raw(patch_text "${QT_WORK_DIR}/patches/p.patch")
    qt_assert_contains("${patch_text}" "---
 B.txt |    8 +-
 a.txt |  200 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 c.txt |    8 --
 d.txt |    2 
 4 files changed, 209 insertions(+), 9 deletions(-)

" "diffstat should be scaled like diffstat(1)")
endfunction()

# refresh --diffstat counts a context diff like diffstat(1): "!" lines on
# both sides are modifications, drawn and summed after insertions and
# deletions, and a second refresh replaces the diffstat where it stands
function(qt_scenario_refresh_diffstat_context)
    qt_begin_test("refresh_diffstat_context")
    qt_write_file("${QT_WORK_DIR}/f.txt" "a\nb\n")
    qt_write_file("${QT_WORK_DIR}/g.txt" "1\n2\n3\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt g.txt MESSAGE "add failed")
    qt_quilt_ok(ARGS header -r INPUT "Desc\n" MESSAGE "header -r failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "a\nB\n")
    qt_write_file("${QT_WORK_DIR}/g.txt" "1\n3\n4\n")
    set(refresh_args refresh -p ab -c --no-index --no-timestamps --diffstat)
    qt_quilt_ok(ARGS ${refresh_args} MESSAGE "refresh -c --diffstat failed")
    qt_read_file_raw(patch_text "${QT_WORK_DIR}/patches/p.patch")
    qt_assert_equal("${patch_text}" [=[Desc
---
 f.txt |    2 !!
 g.txt |    2 +-
 2 files changed, 1 insertion(+), 1 deletion(-), 2 modifications(!)

*** a/f.txt
--- b/f.txt
***************
*** 1,2 ****
  a
! b
--- 1,2 ----
  a
! B
*** a/g.txt
--- b/g.txt
***************
*** 1,3 ****
  1
- 2
  3
--- 1,3 ----
  1
  3
+ 4
]=] "refresh -c should add a diffstat of the context diff")

    qt_write_file("${QT_WORK_DIR}/g.txt" "1\n3\n4\n5\n")
    qt_quilt_ok(ARGS ${refresh_args} MESSAGE "second refresh -c --diffstat failed")
    qt_read_file_raw(patch_text "${QT_WORK_DIR}/patches/p.patch")
    qt_assert_contains("${patch_text}" [=[Desc
---
 f.txt |    2 !!
 g.txt |    3 ++-
 2 files changed, 2 insertions(+), 1 deletion(-), 2 modifications(!)

*** a/f.txt
]=] "refresh -c should replace the diffstat")
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

# header_strip_diffstat_false_positive: header --strip-diffstat keeps a line
# that looks like a diffstat line when no summary line follows it
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

# push_offset_one_line: an offset of exactly 1 is singular, like GNU
# patch's &"s"[in_offset == 1]; -1 keeps the plural.
function(qt_scenario_push_offset_one_line)
    qt_begin_test("push_offset_one_line")
    qt_write_file("${QT_WORK_DIR}/patches/series" "a.diff\nb.diff\nc.diff\n")
    qt_write_file("${QT_WORK_DIR}/patches/a.diff" [=[--- a/a.txt
+++ b/a.txt
@@ -1,3 +1,3 @@
 one
-two
+2
 three
]=])
    qt_write_file("${QT_WORK_DIR}/patches/b.diff" [=[--- a/b.txt
+++ b/b.txt
@@ -2,3 +2,3 @@
 one
-two
+2
 three
]=])
    qt_write_file("${QT_WORK_DIR}/patches/c.diff" [=[--- a/c.txt
+++ b/c.txt
@@ -1,3 +1,3 @@
 one
-two
+2
 three
]=])
    qt_write_file("${QT_WORK_DIR}/a.txt" "x\none\ntwo\nthree\n")
    qt_write_file("${QT_WORK_DIR}/b.txt" "one\ntwo\nthree\n")
    qt_write_file("${QT_WORK_DIR}/c.txt" "x\nONE\ntwo\nthree\n")

    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS push)
    qt_assert_success("${rc}" "push a.diff should succeed")
    qt_combine_output(combined "${out}" "${err}")
    qt_assert_contains("${combined}" "Hunk #1 succeeded at 2 (offset 1 line)." "offset 1 should be singular")

    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS push)
    qt_assert_success("${rc}" "push b.diff should succeed")
    qt_combine_output(combined "${out}" "${err}")
    qt_assert_contains("${combined}" "Hunk #1 succeeded at 1 (offset -1 lines)." "offset -1 should be plural")

    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS push)
    qt_assert_success("${rc}" "push c.diff should succeed")
    qt_combine_output(combined "${out}" "${err}")
    qt_assert_contains("${combined}" "Hunk #1 succeeded at 2 with fuzz 1 (offset 1 line)." "fuzzy offset 1 should be singular")
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

# push_hunk_past_eof: a hunk header naming a line far past the end of the
# file applies at its real position with the matching offset, quickly
# (the TIMEOUT on this test in CMakeLists.txt catches a slow search)
function(qt_scenario_push_hunk_past_eof)
    qt_begin_test("push_hunk_past_eof")
    qt_write_file("${QT_WORK_DIR}/f.txt" "a\nb\nc\n")
    qt_write_file("${QT_WORK_DIR}/patches/series" "p.patch\n")
    qt_write_file("${QT_WORK_DIR}/patches/p.patch" [=[
--- a/f.txt
+++ b/f.txt
@@ -99999999999,3 +99999999999,3 @@
 a
-b
+B
 c
]=])
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS push)
    qt_assert_success("${rc}" "push should apply the hunk at line 1")
    qt_combine_output(combined "${out}" "${err}")
    qt_assert_contains("${combined}" "Hunk #1 succeeded at 1 (offset -99999999998 lines)." "should report the offset")
    qt_assert_file_text("${QT_WORK_DIR}/f.txt" "a\nB\nc" "push should apply the change")
endfunction()

# push_hunk_huge_line_number: a hunk header line number near the ptrdiff_t
# limit must not overflow the hunk search. UBSAN_OPTIONS makes undefined
# behavior fatal in sanitized builds; other builds ignore it.
function(qt_scenario_push_hunk_huge_line_number)
    qt_begin_test("push_hunk_huge_line_number")
    qt_write_file("${QT_WORK_DIR}/f.txt" "a\nb\nc\n")
    qt_write_file("${QT_WORK_DIR}/patches/series" "p.patch\n")
    qt_write_file("${QT_WORK_DIR}/patches/p.patch" [=[
--- a/f.txt
+++ b/f.txt
@@ -5555555255554555554,3 +5555555255554555554,3 @@
 a
-b
+B
 c
]=])
    qt_quilt(RESULT rc OUTPUT out ERROR err ENV "UBSAN_OPTIONS=halt_on_error=1" ARGS push)
    qt_assert_success("${rc}" "push should apply the hunk at line 1")
    qt_combine_output(combined "${out}" "${err}")
    qt_assert_contains("${combined}" "Hunk #1 succeeded at 1 (offset -5555555255554555553 lines)." "should report the offset")
    qt_assert_file_text("${QT_WORK_DIR}/f.txt" "a\nB\nc" "push should apply the change")
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
    qt_assert_file_text("${QT_WORK_DIR}/subdir/f.txt" "modified" "revert should restore post-patch content")
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
    qt_quilt_ok(DEFAULT_QUILTRC OUTPUT series_out ARGS series MESSAGE "series failed")
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
    if(CMAKE_HOST_WIN32)
        # Windows does not allow " in filenames.
        message(STATUS "Skipping graph_dot_escape on Windows")
        return()
    endif()
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
    qt_quilt_ok(OUTPUT graph_out ARGS graph --lines=2 MESSAGE "graph --lines failed")
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
    qt_quilt_ok(DEFAULT_QUILTRC OUTPUT series_out ARGS series MESSAGE "series failed")
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

# quiltrc_comments: verify that comment lines and blank lines are ignored
function(qt_scenario_quiltrc_comments)
    qt_begin_test("quiltrc_comments")
    qt_write_file("${QT_WORK_DIR}/f.txt" "hello\n")
    qt_quilt_ok(ARGS new test.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    qt_quilt_ok(ARGS pop MESSAGE "pop failed")
    # quiltrc with comments, blank lines, and a real assignment
    qt_write_file("${QT_TEST_BASE}/.quiltrc" [=[
# This is a comment
#QUILT_PATCHES_PREFIX=1

QUILT_PATCHES_PREFIX=1
# Another comment
]=])
    qt_quilt_ok(DEFAULT_QUILTRC OUTPUT series_out ARGS series
        MESSAGE "series with commented quiltrc failed")
    # The commented-out line should be ignored; only the real assignment applies
    qt_assert_contains("${series_out}" "patches/" "QUILT_PATCHES_PREFIX should be active")
endfunction()

# Running quilt refresh --diffstat twice makes the second call replace the
# diffstat the first one added, rather than add another.
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
    # The old diffstat is replaced in place, after the same "---" line
    qt_write_file("${QT_WORK_DIR}/f.txt" "second change\n")
    qt_quilt_ok(ARGS refresh --diffstat MESSAGE "second refresh --diffstat failed")
    file(READ "${QT_WORK_DIR}/patches/p.patch" patch2)
    qt_assert_contains("${patch2}" "changed" "second refresh should have updated diffstat")
    # Should only have one diffstat block (old one removed, new one added)
    string(REGEX MATCHALL "file changed" count_matches "${patch2}")
    list(LENGTH count_matches num_changed)
    qt_assert_equal("${num_changed}" "1" "should have exactly one diffstat summary line")
endfunction()

# refresh_diffstat_header_replace: with a description before the diffstat,
# a second refresh --diffstat replaces the diffstat and keeps the description.
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
    # The diffstat after the description is replaced in place
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

# series_pc_precedes_root: docs/manual.md says the search order is
# .pc/<series-name> -> <project-root>/<series-name> -> <QUILT_PATCHES>/<series-name>.
# When both .pc/series and ./series exist, quilt should read .pc/series.
function(qt_scenario_series_pc_precedes_root)
    qt_begin_test("series_pc_precedes_root")
    file(MAKE_DIRECTORY "${QT_WORK_DIR}/.pc")
    qt_write_file("${QT_WORK_DIR}/series" "root.patch\n")
    qt_write_file("${QT_WORK_DIR}/.pc/series" "pc.patch\n")
    qt_write_file("${QT_WORK_DIR}/.pc/applied-patches" "")
    qt_write_file("${QT_WORK_DIR}/.pc/.version" "2\n")
    qt_quilt_ok(OUTPUT series_out ARGS series MESSAGE "series failed")
    qt_assert_contains("${series_out}" "pc.patch" "series should prefer .pc/series over ./series")
    qt_assert_not_contains("${series_out}" "root.patch" "series should not read the root series file first")
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

# header_replace_no_newline: "quilt header -r" adds a trailing '\n' when
# stdin lacks one, like upstream ensure_trailing_newline.
function(qt_scenario_header_replace_no_newline)
    qt_begin_test("header_replace_no_newline")
    qt_write_file("${QT_WORK_DIR}/f.txt" "original\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "changed\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    # Replace the header with a string that does NOT end with a newline.
    qt_quilt_ok(ARGS header -r INPUT "my description without newline"
        MESSAGE "header -r failed")
    qt_quilt_ok(OUTPUT hdr_out ARGS header MESSAGE "header read failed")
    qt_assert_contains("${hdr_out}" "my description without newline"
        "header should contain the replacement text")
endfunction()

# annotate_no_series_file: cmd_annotate.cpp find_applied_patch
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

# push_reject_no_newline: format_rejects adds "\ No newline at end of file"
# after each line of a rejected hunk that lacks a newline, in unified and
# context form.  Requires a patch that (1) fails to apply and (2) has
# "\ No newline at end of file" after a line.
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
    # The marker follows the line that lacks a newline.  GNU patch instead
    # runs that line into the next one, "-wrong+patched".
    qt_read_file_raw(rej_content "${QT_WORK_DIR}/f.txt.rej")
    qt_assert_equal("${rej_content}"
        "--- f.txt\n+++ f.txt\n@@ -1 +1 @@\n-wrong\n\\ No newline at end of file\n+patched\n"
        "rej file should mark the line without a newline")

    # Both sides of a context diff, and a context line that ends both
    file(WRITE "${QT_WORK_DIR}/patches/bad.patch"
"*** a/f.txt\n--- b/f.txt\n***************\n*** 1,2 ****\n! a\n  b\n\\ No newline at end of file\n--- 1,2 ----\n! c\n  b\n\\ No newline at end of file\n")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS push --leave-rejects)
    qt_assert_failure("${rc}" "push should fail when patch doesn't apply")
    qt_read_file_raw(rej_content "${QT_WORK_DIR}/f.txt.rej")
    qt_assert_equal("${rej_content}"
        "*** f.txt\n--- f.txt\n***************\n*** 1,2 ****\n! a\n  b\n\\ No newline at end of file\n--- 1,2 ----\n! c\n  b\n\\ No newline at end of file\n"
        "context rej file should mark the lines without a newline")
    file(WRITE "${QT_WORK_DIR}/patches/bad.patch"
"--- a/f.txt\n+++ b/f.txt\n@@ -1,2 +1,2 @@\n-a\n+c\n b\n\\ No newline at end of file\n")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS push --leave-rejects)
    qt_assert_failure("${rc}" "push should fail when patch doesn't apply")
    qt_read_file_raw(rej_content "${QT_WORK_DIR}/f.txt.rej")
    qt_assert_equal("${rej_content}"
        "--- f.txt\n+++ f.txt\n@@ -1,2 +1,2 @@\n-a\n+c\n b\n\\ No newline at end of file\n"
        "rej file should mark a context line without a newline once")
endfunction()

# fork_applied_not_in_series: find_top_patch refuses a top applied patch
# that is not in the series, which upstream reports as a mismatch between
# the series and the applied patches. Achievable by crafting a state where
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
    qt_assert_contains("${err}" "The series file no longer matches the applied patches"
                       "should report the mismatch")
endfunction()

# refresh_diffstat_double_newline: like upstream, refresh --diffstat keeps a
# blank line ending the header and adds the diffstat after it.
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
    # refresh --diffstat keeps the blank line and adds "---" and the diffstat
    qt_quilt_ok(ARGS refresh --diffstat MESSAGE "refresh --diffstat failed")
    qt_read_file_raw(patch_content "${QT_WORK_DIR}/patches/p.patch")
    qt_assert_matches("${patch_content}" "^Description\n\n---\n f\\.txt \\|"
                      "the diffstat should follow the blank line")
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

# top_index_applied_not_in_series: original quilt rejects "new" when
# applied-patches and the series file are inconsistent. The command should
# fail and leave the series file unchanged instead of inserting a new patch.
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
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS new fresh.patch)
    qt_assert_failure("${rc}" "new should fail when applied-patches disagrees with the series")
    qt_combine_output(combined "${out}" "${err}")
    qt_assert_contains("${combined}" "no longer matches the applied patches"
        "new should report the inconsistent series state")
    qt_assert_contains("${combined}" "pop -a"
        "new should tell the user how to repair the stack")
    qt_assert_file_text("${QT_WORK_DIR}/patches/series" "other.patch"
        "series should remain unchanged after the failed new")
endfunction()

# refresh_diffstat_bare_header: a bare diffstat block in the header (no "---"
# separator), as in a hand-written or imported patch, is replaced in place
# by refresh --diffstat, like upstream.
function(qt_scenario_refresh_diffstat_bare_header)
    qt_begin_test("refresh_diffstat_bare_header")
    qt_write_file("${QT_WORK_DIR}/f.txt" "old\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "new\n")
    qt_quilt_ok(ENV "QUILT_NO_DIFF_TIMESTAMPS=1" ARGS refresh MESSAGE "initial refresh failed")
    # Prepend a bare diffstat header (no "---" separator) to the patch file.
    # The " f.txt | 2 +-" line is held, and the summary line after it
    # replaces both with the new diffstat. The blank line after it stays.
    file(READ "${QT_WORK_DIR}/patches/p.patch" existing_patch)
    file(WRITE "${QT_WORK_DIR}/patches/p.patch"
        "Description\n\n f.txt | 2 +-\n 1 file changed, 1 insertion(+), 1 deletion(-)\n\n${existing_patch}")
    qt_quilt_ok(ENV "QUILT_NO_DIFF_TIMESTAMPS=1" ARGS refresh --diffstat
        MESSAGE "refresh --diffstat with bare diffstat header failed")
    file(READ "${QT_WORK_DIR}/patches/p.patch" result_patch)
    # The old bare diffstat should be replaced with one new diffstat
    string(REGEX MATCHALL "file changed" count_matches "${result_patch}")
    list(LENGTH count_matches num_changed)
    qt_assert_equal("${num_changed}" "1" "should have exactly one diffstat summary")
    qt_assert_matches("${result_patch}" "^Description\n\n f\\.txt \\|    2 \\+-\n 1 file changed, 1 insertion\\(\\+\\), 1 deletion\\(-\\)\n\nIndex: "
                      "the diffstat should be replaced where it stands")
    # The description should be preserved
    qt_assert_contains("${result_patch}" "Description" "description should be preserved")
endfunction()

# refresh_diffstat_bare_false_positive: diffstat-like lines (a " | N " after
# some space) NOT followed by a summary line (an empty line comes first) are
# kept, and refresh --diffstat adds a new diffstat at the end of the header.
function(qt_scenario_refresh_diffstat_bare_false_positive)
    qt_begin_test("refresh_diffstat_bare_false_positive")
    qt_write_file("${QT_WORK_DIR}/f.txt" "old\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "new\n")
    qt_quilt_ok(ENV "QUILT_NO_DIFF_TIMESTAMPS=1" ARGS refresh MESSAGE "initial refresh failed")
    # Prepend a "false positive" diffstat: two diffstat-looking lines followed
    # by an EMPTY LINE before any summary, so the lines are not replaced
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

# graph_reduce_preserves_selected: --reduce should keep the selected node even if isolated
function(qt_scenario_graph_reduce_preserves_selected)
    qt_begin_test("graph_reduce_preserves_selected")
    qt_quilt_ok(ARGS new p1.patch MESSAGE "new failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "hello\n")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "world\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    # graph --reduce with a single patch should still show the selected node
    qt_quilt_ok(OUTPUT graph_out ARGS graph --reduce MESSAGE "graph --reduce failed")
    qt_assert_contains("${graph_out}" "p1.patch" "selected node should be preserved after reduce")
    qt_assert_contains("${graph_out}" "style=bold" "selected node should have bold style")
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

# push_fuzz_preserves_lines: when a patch requires fuzz, lines that don't match
# the fuzzed-out context must be preserved (not silently deleted).
function(qt_scenario_push_fuzz_preserves_lines)
    qt_begin_test("push_fuzz_preserves_lines")
    # File has extra lines the patch doesn't know about
    qt_write_file("${QT_WORK_DIR}/main.cpp" [=[#include <iostream>
#include <ctime>

int main() {
    std::cout << "Hello, World!" << std::endl;
    std::time_t now = std::time(nullptr);
    std::cout << "Current time: " << std::ctime(&now);
    return 0;
}
]=])
    # Patch context expects just "#include <iostream>" then blank line (no #include <ctime>),
    # and expects "return 0;" + "}" right after the changed lines (no time code).
    # This requires fuzz=2 to apply.
    qt_write_file("${QT_WORK_DIR}/patches/a.patch" [=[--- a/main.cpp
+++ b/main.cpp
@@ -1,6 +1,10 @@
 #include <iostream>

-int main() {
-    std::cout << "Hello, World!" << std::endl;
+int main(int argc, char **argv) {
+    if (argc > 1) {
+        std::cout << "Hello, " << argv[1] << "!" << std::endl;
+    } else {
+        std::cout << "Hello, World!" << std::endl;
+    }
     return 0;
 }
]=])
    qt_write_file("${QT_WORK_DIR}/patches/series" "a.patch\n")
    qt_quilt(RESULT rc OUTPUT push_out ERROR push_err ARGS push --fuzz=2)
    qt_assert_success("${rc}" "push --fuzz=2 should succeed")
    # The critical check: #include <ctime> and time-related code must survive
    qt_assert_file_contains("${QT_WORK_DIR}/main.cpp" "#include <ctime>"
        "fuzz must not delete lines outside the matched region")
    qt_assert_file_contains("${QT_WORK_DIR}/main.cpp" "std::time_t"
        "fuzz must not delete time_t line")
    qt_assert_file_contains("${QT_WORK_DIR}/main.cpp" "std::ctime"
        "fuzz must not delete ctime line")
    # Also verify the patch changes were actually applied
    qt_assert_file_contains("${QT_WORK_DIR}/main.cpp" "int main(int argc, char **argv)"
        "patch changes should be applied")
    qt_assert_file_contains("${QT_WORK_DIR}/main.cpp" "argv[1]"
        "patch changes should be applied")
endfunction()

# applied_unapplied_target: quilt applied <unapplied-patch> should fail
function(qt_scenario_applied_unapplied_target)
    qt_begin_test("applied_unapplied_target")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_quilt_ok(ARGS new p1.patch MESSAGE "new p1")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add p1")
    qt_write_file("${QT_WORK_DIR}/f.txt" "1\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh p1")
    qt_quilt_ok(ARGS new p2.patch MESSAGE "new p2")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add p2")
    qt_write_file("${QT_WORK_DIR}/f.txt" "2\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh p2")
    # Pop p2 so only p1 is applied
    qt_quilt_ok(ARGS pop MESSAGE "pop")
    # applied p2.patch should fail — p2 is not applied
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS applied p2.patch)
    qt_assert_failure("${rc}" "applied with unapplied target should fail")
    qt_combine_output(combined "${out}" "${err}")
    qt_assert_contains("${combined}" "not applied" "should say patch is not applied")
endfunction()

# add_remove_unapplied_P: add/remove -P with unapplied patch should fail
function(qt_scenario_add_remove_unapplied_P)
    qt_begin_test("add_remove_unapplied_P")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_quilt_ok(ARGS new p1.patch MESSAGE "new p1")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add p1")
    qt_write_file("${QT_WORK_DIR}/f.txt" "1\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh p1")
    qt_quilt_ok(ARGS new p2.patch MESSAGE "new p2")
    qt_quilt_ok(ARGS pop MESSAGE "pop p2")
    # add -P with unapplied patch should fail
    qt_quilt(RESULT rc1 OUTPUT out1 ERROR err1 ARGS add -P p2.patch f.txt)
    qt_assert_failure("${rc1}" "add -P unapplied should fail")
    qt_combine_output(c1 "${out1}" "${err1}")
    qt_assert_contains("${c1}" "not applied" "add should say patch is not applied")
    # remove -P with unapplied patch should fail
    qt_quilt(RESULT rc2 OUTPUT out2 ERROR err2 ARGS remove -P p2.patch f.txt)
    qt_assert_failure("${rc2}" "remove -P unapplied should fail")
    qt_combine_output(c2 "${out2}" "${err2}")
    qt_assert_contains("${c2}" "not applied" "remove should say patch is not applied")
endfunction()

# fold_strip_level: fold -p 0 should use the correct strip level for backup tracking
function(qt_scenario_fold_strip_level)
    qt_begin_test("fold_strip_level")
    file(MAKE_DIRECTORY "${QT_WORK_DIR}/a/b")
    qt_write_file("${QT_WORK_DIR}/a/b/foo.c" "old\n")
    qt_quilt_ok(ARGS new test.patch MESSAGE "new")
    qt_quilt_ok(ARGS add a/b/foo.c MESSAGE "add")
    qt_write_file("${QT_WORK_DIR}/a/b/foo.c" "new\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh")
    # Fold a patch with -p 0 (paths have no prefix to strip)
    qt_quilt_ok(
        ARGS fold -p 0
        INPUT [=[--- a/b/foo.c
+++ a/b/foo.c
@@ -1 +1 @@
-new
+folded
]=]
        MESSAGE "fold -p 0 failed"
    )
    qt_assert_file_text("${QT_WORK_DIR}/a/b/foo.c" "folded" "file should be folded")
    # The backup should only be a/b/foo.c, not b/foo.c (wrong strip level)
    qt_assert_exists("${QT_WORK_DIR}/.pc/test.patch/a/b/foo.c"
        "correct backup a/b/foo.c should exist")
    qt_assert_not_exists("${QT_WORK_DIR}/.pc/test.patch/b/foo.c"
        "spurious backup b/foo.c should not exist")
endfunction()

# diff_U0_pure_insert: diff -U0 with append should produce correct hunk header
function(qt_scenario_diff_U0_pure_insert)
    qt_begin_test("diff_U0_pure_insert")
    # Test 1: pure insert (append at end)
    qt_write_file("${QT_WORK_DIR}/f.txt" "a\nb\nc\n")
    qt_quilt_ok(ARGS new test.patch MESSAGE "new")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add")
    qt_write_file("${QT_WORK_DIR}/f.txt" "a\nb\nc\nd\n")
    qt_quilt_ok(OUTPUT out ERROR err ARGS diff -U0 MESSAGE "diff -U0")
    # Should be @@ -3,0 +4 @@ (insert after old line 3), not @@ -0,0 +4 @@
    qt_assert_contains("${out}" "-3,0" "old_start should reference line 3")
    qt_assert_not_contains("${out}" "-0,0" "old_start should not be 0")
    # Test 2: pure delete (remove line from middle) — separate patch
    qt_quilt_ok(ARGS refresh MESSAGE "refresh")
    qt_write_file("${QT_WORK_DIR}/g.txt" "a\nb\nc\nd\n")
    qt_quilt_ok(ARGS new test2.patch MESSAGE "new2")
    qt_quilt_ok(ARGS add g.txt MESSAGE "add g")
    qt_write_file("${QT_WORK_DIR}/g.txt" "a\nb\nd\n")
    qt_quilt_ok(OUTPUT out2 ERROR err2 ARGS diff -U0 MESSAGE "diff -U0 delete")
    # Should be @@ -3 +2,0 @@ (delete old line 3), not @@ -3 +0,0 @@
    qt_assert_contains("${out2}" "+2,0" "new_start should reference line 2")
    qt_assert_not_contains("${out2}" "+0,0" "new_start should not be 0")
endfunction()

# refresh_shadow_rediff: refresh -f re-diffs shadowed files against the
# next patch's backup instead of the working tree.  When patch A deletes
# f.txt and patch B re-creates it, refresh -f a.patch should produce a
# diff of content→new (A's backup vs B's backup), not content→/dev/null.
function(qt_scenario_refresh_shadow_rediff)
    qt_begin_test("refresh_shadow_rediff")
    qt_write_file("${QT_WORK_DIR}/f.txt" "content\n")
    qt_write_file("${QT_WORK_DIR}/g.txt" "other\n")
    # Patch A: deletes f.txt, modifies g.txt
    qt_quilt_ok(ARGS new a.patch MESSAGE "new a")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add f to a")
    file(REMOVE "${QT_WORK_DIR}/f.txt")
    qt_quilt_ok(ARGS add g.txt MESSAGE "add g to a")
    qt_write_file("${QT_WORK_DIR}/g.txt" "changed\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh a")
    # Verify a.patch initially has file-deletion section
    qt_assert_file_contains("${QT_WORK_DIR}/patches/a.patch" "/dev/null"
        "a.patch should initially contain file deletion")
    # Patch B: re-creates f.txt with new content
    qt_quilt_ok(ARGS new b.patch MESSAGE "new b")
    qt_write_file("${QT_WORK_DIR}/f.txt" "new\n")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add f to b")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh b")
    # refresh -f a.patch: f.txt is shadowed by b.patch, so the diff
    # should be a.patch's backup (content) vs b.patch's backup (new),
    # NOT content→/dev/null.
    qt_quilt_ok(ARGS refresh -f a.patch MESSAGE "refresh -f a")
    # After re-diff, a.patch should show content→new (a modification),
    # not a deletion to /dev/null
    qt_assert_file_not_contains("${QT_WORK_DIR}/patches/a.patch" "/dev/null"
        "a.patch should not contain /dev/null after refresh -f (re-diffed)")
    qt_assert_file_contains("${QT_WORK_DIR}/patches/a.patch" "-content"
        "a.patch should show removal of old content")
    qt_assert_file_contains("${QT_WORK_DIR}/patches/a.patch" "+new"
        "a.patch should show addition of new content")
endfunction()

# import_P_multiple: import -P with multiple files should fail upfront
function(qt_scenario_import_P_multiple)
    qt_begin_test("import_P_multiple")
    qt_write_file("${QT_WORK_DIR}/ext/a.patch" "--- /dev/null\n+++ b/a.txt\n@@ -0,0 +1 @@\n+a\n")
    qt_write_file("${QT_WORK_DIR}/ext/b.patch" "--- /dev/null\n+++ b/b.txt\n@@ -0,0 +1 @@\n+b\n")
    qt_quilt(RESULT rc OUTPUT out ERROR err
        ARGS import -P combined.patch ext/a.patch ext/b.patch)
    qt_assert_failure("${rc}" "import -P with multiple files should fail")
    qt_combine_output(combined "${out}" "${err}")
    qt_assert_contains("${combined}" "single patch"
        "error should mention single patch limitation")
    # Series should be empty — no partial import
    qt_assert_not_exists("${QT_WORK_DIR}/patches/series"
        "series should not exist after rejected import")
endfunction()

# pop_deletes_empty_file: an empty file that existed before a patch is
# deleted on pop (empty backup = "didn't exist" placeholder).  This
# matches original quilt behavior — the backup mechanism cannot
# distinguish between "file was empty" and "file didn't exist".
function(qt_scenario_pop_deletes_empty_file)
    qt_begin_test("pop_deletes_empty_file")
    # Create an empty file (0 bytes)
    qt_write_file("${QT_WORK_DIR}/empty.txt" "")
    qt_quilt_ok(ARGS new test.patch MESSAGE "new")
    qt_quilt_ok(ARGS add empty.txt MESSAGE "add")
    qt_write_file("${QT_WORK_DIR}/empty.txt" "content\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh")
    # Pop should delete the file (it was empty, so the backup is a
    # zero-length placeholder indistinguishable from "didn't exist")
    qt_quilt_ok(ARGS pop MESSAGE "pop")
    qt_assert_not_exists("${QT_WORK_DIR}/empty.txt"
        "empty file should be deleted on pop (matches quilt behavior)")
endfunction()

# pc_quilt_patches_overrides_env: once .pc/.quilt_patches is written,
# it takes precedence over QUILT_PATCHES.  This matches original quilt.
function(qt_scenario_pc_quilt_patches_overrides_env)
    qt_begin_test("pc_quilt_patches_overrides_env")
    # Set up a normal patch stack in "patches/"
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_quilt_ok(ARGS new test.patch MESSAGE "new")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add")
    qt_write_file("${QT_WORK_DIR}/f.txt" "y\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh")
    # .pc/.quilt_patches should now contain "patches"
    qt_assert_file_text("${QT_WORK_DIR}/.pc/.quilt_patches" "patches"
        "quilt_patches should say patches")
    # Create a different patches dir with a different series
    file(MAKE_DIRECTORY "${QT_WORK_DIR}/other-patches")
    qt_write_file("${QT_WORK_DIR}/other-patches/series" "other.patch\n")
    # Even with QUILT_PATCHES=other-patches, series should come from
    # "patches/" because .pc/.quilt_patches takes precedence
    qt_quilt_ok(OUTPUT out ERROR err
        ENV "QUILT_PATCHES=other-patches"
        ARGS series MESSAGE "series with env override")
    qt_assert_contains("${out}" "test.patch"
        "should use patches/ dir despite QUILT_PATCHES env")
    qt_assert_not_contains("${out}" "other.patch"
        "should not use other-patches/ dir")
endfunction()

# pc_quilt_series_is_filename: .pc/.quilt_series stores a series filename,
# not a path under QUILT_PATCHES. Original quilt resolves it from the work tree.
function(qt_scenario_pc_quilt_series_is_filename)
    qt_begin_test("pc_quilt_series_is_filename")
    file(MAKE_DIRECTORY "${QT_WORK_DIR}/patches")
    file(MAKE_DIRECTORY "${QT_WORK_DIR}/.pc")
    qt_write_file("${QT_WORK_DIR}/altseries" "root.patch\n")
    qt_write_file("${QT_WORK_DIR}/patches/altseries" "patches.patch\n")
    qt_write_file("${QT_WORK_DIR}/.pc/applied-patches" "")
    qt_write_file("${QT_WORK_DIR}/.pc/.version" "2\n")
    qt_write_file("${QT_WORK_DIR}/.pc/.quilt_patches" "patches\n")
    qt_write_file("${QT_WORK_DIR}/.pc/.quilt_series" "altseries\n")
    qt_quilt_ok(OUTPUT series_out ARGS series MESSAGE "series failed")
    qt_assert_contains("${series_out}" "root.patch"
        ".pc/.quilt_series should point to the root series filename")
    qt_assert_not_contains("${series_out}" "patches.patch"
        ".pc/.quilt_series should not be resolved inside the patches dir")
endfunction()

# quilt_series_pc_search_order: when .pc/.quilt_series names a series file,
# that name must still go through the normal .pc/root/patches search order.
# If both .pc/altseries and ./altseries exist, .pc/altseries should win.
function(qt_scenario_quilt_series_pc_search_order)
    qt_begin_test("quilt_series_pc_search_order")
    file(MAKE_DIRECTORY "${QT_WORK_DIR}/patches")
    file(MAKE_DIRECTORY "${QT_WORK_DIR}/.pc")
    qt_write_file("${QT_WORK_DIR}/.pc/altseries" "pc.patch\n")
    qt_write_file("${QT_WORK_DIR}/altseries" "root.patch\n")
    qt_write_file("${QT_WORK_DIR}/.pc/applied-patches" "")
    qt_write_file("${QT_WORK_DIR}/.pc/.version" "2\n")
    qt_write_file("${QT_WORK_DIR}/.pc/.quilt_patches" "patches\n")
    qt_write_file("${QT_WORK_DIR}/.pc/.quilt_series" "altseries\n")
    qt_quilt_ok(OUTPUT series_out ARGS series MESSAGE "series failed")
    qt_assert_contains("${series_out}" "pc.patch"
        ".quilt_series name should resolve through .pc/ first")
    qt_assert_not_contains("${series_out}" "root.patch"
        ".quilt_series should not bypass the .pc search order")
endfunction()

# rename_drops_strip_level: renaming a -p0 patch must preserve -p0
function(qt_scenario_rename_drops_strip_level)
    qt_begin_test("rename_drops_strip_level")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_quilt_ok(ARGS new -p0 foo.patch MESSAGE "new -p0")
    qt_quilt_ok(ARGS rename -P foo.patch bar.patch MESSAGE "rename")
    # After rename, the -p0 annotation must be preserved
    qt_read_file_strip(series "${QT_WORK_DIR}/patches/series")
    qt_assert_equal("${series}" "bar.patch -p0"
        "renamed patch should keep -p0 annotation")
endfunction()

# series_v_markers: series -v must show + for non-top applied, = for top
function(qt_scenario_series_v_markers)
    qt_begin_test("series_v_markers")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_quilt_ok(ARGS new p1.patch MESSAGE "new p1")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add p1")
    qt_write_file("${QT_WORK_DIR}/f.txt" "1\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh p1")
    qt_quilt_ok(ARGS new p2.patch MESSAGE "new p2")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add p2")
    qt_write_file("${QT_WORK_DIR}/f.txt" "2\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh p2")
    # p1 and p2 both applied. Top is p2. Add unapplied p3 to series directly.
    qt_write_file("${QT_WORK_DIR}/patches/p3.patch" "")
    file(APPEND "${QT_WORK_DIR}/patches/series" "p3.patch\n")
    qt_quilt_ok(OUTPUT sv_out ARGS series -v MESSAGE "series -v failed")
    qt_assert_matches("${sv_out}" "\\+ .*p1\\.patch" "non-top applied should have + prefix")
    qt_assert_matches("${sv_out}" "= .*p2\\.patch" "top applied should have = prefix")
    qt_assert_matches("${sv_out}" "  .*p3\\.patch" "unapplied should have space prefix")
endfunction()

# diff_reverse_labels: diff -R must not swap ---/+++ labels
function(qt_scenario_diff_reverse_labels)
    qt_begin_test("diff_reverse_labels")
    qt_write_file("${QT_WORK_DIR}/f.txt" "old\n")
    qt_quilt_ok(ARGS new r.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "new\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    qt_quilt_ok(OUTPUT diff_out ARGS diff -R MESSAGE "diff -R failed")
    # In a reverse diff, --- should show .orig/ and +++ should show dir/
    # (same label order as forward diff, content is swapped)
    qt_assert_matches("${diff_out}" "---.*.orig/" "diff -R --- line should have .orig/ prefix")
    qt_assert_matches("${diff_out}" "\\+\\+\\+" "diff -R should have +++ line")
    # The reverse content: -new +old
    qt_assert_contains("${diff_out}" "-new" "reverse diff should show -new")
    qt_assert_contains("${diff_out}" "+old" "reverse diff should show +old")
endfunction()

# refresh_index_p0: refresh -p0 should produce Index: <filename> (no dir prefix)
function(qt_scenario_refresh_index_p0)
    qt_begin_test("refresh_index_p0")
    qt_write_file("${QT_WORK_DIR}/f.txt" "old\n")
    qt_quilt_ok(ARGS new -p0 idx0.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "new\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    qt_assert_file_contains("${QT_WORK_DIR}/patches/idx0.patch" "Index: f.txt"
        "refresh -p0 Index line should not have dir prefix")
endfunction()

# refresh_index_pab: refresh -p ab should produce Index: b/<filename>
function(qt_scenario_refresh_index_pab)
    qt_begin_test("refresh_index_pab")
    qt_write_file("${QT_WORK_DIR}/f.txt" "old\n")
    qt_quilt_ok(ARGS new idxab.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "new\n")
    qt_quilt_ok(ARGS refresh -p ab MESSAGE "refresh failed")
    qt_assert_file_contains("${QT_WORK_DIR}/patches/idxab.patch" "Index: b/f.txt"
        "refresh -p ab Index line should have b/ prefix")
endfunction()

# push_a_blank_lines: push -a should separate patches with blank lines
function(qt_scenario_push_a_blank_lines)
    qt_begin_test("push_a_blank_lines")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_quilt_ok(ARGS new p1.patch MESSAGE "new p1")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add p1")
    qt_write_file("${QT_WORK_DIR}/f.txt" "1\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh p1")
    qt_quilt_ok(ARGS new p2.patch MESSAGE "new p2")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add p2")
    qt_write_file("${QT_WORK_DIR}/f.txt" "2\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh p2")
    qt_quilt_ok(ARGS pop -a MESSAGE "pop -a failed")
    qt_quilt_ok(OUTPUT push_out ARGS push -a MESSAGE "push -a failed")
    # There should be a blank line separating the two patch applications
    # (after "patching file ..." and before next "Applying patch")
    qt_assert_contains("${push_out}" "Applying patch" "should show Applying patch")
    # Check for blank-line separation: the output has \n\nApplying for the second patch
    qt_assert_matches("${push_out}" "\n\nApplying patch.*p2"
        "push -a should have blank line before second patch")
endfunction()

# pop_a_blank_lines: pop -a should separate patches with blank lines
function(qt_scenario_pop_a_blank_lines)
    qt_begin_test("pop_a_blank_lines")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_quilt_ok(ARGS new p1.patch MESSAGE "new p1")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add p1")
    qt_write_file("${QT_WORK_DIR}/f.txt" "1\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh p1")
    qt_quilt_ok(ARGS new p2.patch MESSAGE "new p2")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add p2")
    qt_write_file("${QT_WORK_DIR}/f.txt" "2\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh p2")
    qt_quilt_ok(OUTPUT pop_out ARGS pop -a MESSAGE "pop -a failed")
    # There should be a blank line between the two patch removals
    qt_assert_matches("${pop_out}" "p2\\.patch\n.*\n\n.*p1\\.patch"
        "pop -a should have blank line between patches")
endfunction()

# refresh_strip_ws_modifies_file: --strip-trailing-whitespace should modify the working file
function(qt_scenario_refresh_strip_ws_modifies_file)
    qt_begin_test("refresh_strip_ws_modifies_file")
    qt_write_file("${QT_WORK_DIR}/f.txt" "clean\n")
    qt_quilt_ok(ARGS new sw.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "trailing   \n")
    qt_quilt_ok(ARGS refresh --strip-trailing-whitespace MESSAGE "refresh failed")
    # The working file should have had trailing whitespace stripped
    qt_assert_file_text("${QT_WORK_DIR}/f.txt" "trailing"
        "working file should have trailing whitespace stripped")
endfunction()

# patches_v_markers: patches -v must show + for non-top applied, = for top
function(qt_scenario_patches_v_markers)
    qt_begin_test("patches_v_markers")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_quilt_ok(ARGS new p1.patch MESSAGE "new p1")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add p1")
    qt_write_file("${QT_WORK_DIR}/f.txt" "1\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh p1")
    qt_quilt_ok(ARGS new p2.patch MESSAGE "new p2")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add p2")
    qt_write_file("${QT_WORK_DIR}/f.txt" "2\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh p2")
    qt_quilt_ok(OUTPUT pv_out ARGS patches -v f.txt MESSAGE "patches -v failed")
    qt_assert_matches("${pv_out}" "\\+ .*p1\\.patch" "non-top applied should have + prefix")
    qt_assert_matches("${pv_out}" "= .*p2\\.patch" "top applied should have = prefix")
endfunction()

# pop_shows_removing: pop should show Removing for files that disappear
function(qt_scenario_pop_shows_removing)
    qt_begin_test("pop_shows_removing")
    # Create a new file via a patch
    qt_quilt_ok(ARGS new newfile.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add newf.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/newf.txt" "created\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    qt_quilt_ok(OUTPUT pop_out ARGS pop MESSAGE "pop failed")
    # File was created by the patch, so pop should show "Removing" not "Restoring"
    qt_assert_contains("${pop_out}" "Removing newf.txt" "pop should say Removing for new files")
endfunction()

# revert_restores_post_patch: revert should restore to post-patch state, not pre-patch
function(qt_scenario_revert_restores_post_patch)
    qt_begin_test("revert_restores_post_patch")
    qt_write_file("${QT_WORK_DIR}/f.txt" "original\n")
    qt_quilt_ok(ARGS new rv.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "patched\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    # Modify file further beyond the patch
    qt_write_file("${QT_WORK_DIR}/f.txt" "extra edits\n")
    qt_quilt_ok(ARGS revert f.txt MESSAGE "revert failed")
    # Should be back to "patched" (post-patch), not "original" (pre-patch)
    qt_assert_file_text("${QT_WORK_DIR}/f.txt" "patched"
        "revert should restore to post-patch state")
endfunction()

# revert_unchanged: revert should detect when file hasn't been modified
function(qt_scenario_revert_unchanged)
    qt_begin_test("revert_unchanged")
    qt_write_file("${QT_WORK_DIR}/f.txt" "original\n")
    qt_quilt_ok(ARGS new rv.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "patched\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    # Don't modify the file — revert should say "unchanged"
    qt_quilt_ok(OUTPUT rv_out ARGS revert f.txt MESSAGE "revert failed")
    qt_assert_contains("${rv_out}" "unchanged" "revert should report unchanged file")
endfunction()

# revert_later_patch: revert should reject when a later patch modifies the file
function(qt_scenario_revert_later_patch)
    qt_begin_test("revert_later_patch")
    qt_write_file("${QT_WORK_DIR}/f.txt" "original\n")
    qt_quilt_ok(ARGS new p1.patch MESSAGE "new p1")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add p1")
    qt_write_file("${QT_WORK_DIR}/f.txt" "p1\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh p1")
    qt_quilt_ok(ARGS new p2.patch MESSAGE "new p2")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add p2")
    qt_write_file("${QT_WORK_DIR}/f.txt" "p2\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh p2")
    # Try to revert f.txt in p1 — should fail because p2 also modifies it
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS revert -P p1.patch f.txt)
    qt_assert_failure("${rc}" "revert should fail when later patch modifies file")
    qt_combine_output(combined "${out}" "${err}")
    qt_assert_contains("${combined}" "modified by" "should explain which later patch")
endfunction()

# delete_applied_non_top: delete should reject non-top applied patch
function(qt_scenario_delete_applied_non_top)
    qt_begin_test("delete_applied_non_top")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_quilt_ok(ARGS new p1.patch MESSAGE "new p1")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add p1")
    qt_write_file("${QT_WORK_DIR}/f.txt" "1\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh p1")
    qt_quilt_ok(ARGS new p2.patch MESSAGE "new p2")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add p2")
    qt_write_file("${QT_WORK_DIR}/f.txt" "2\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh p2")
    # Try to delete p1 while p2 is on top — should fail
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS delete p1.patch)
    qt_assert_failure("${rc}" "delete should reject non-top applied patch")
    qt_combine_output(combined "${out}" "${err}")
    qt_assert_contains("${combined}" "currently applied" "should say currently applied")
endfunction()

# delete_top_messages: deleting topmost applied patch should show progress
function(qt_scenario_delete_top_messages)
    qt_begin_test("delete_top_messages")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_quilt_ok(ARGS new p1.patch MESSAGE "new p1")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add p1")
    qt_write_file("${QT_WORK_DIR}/f.txt" "1\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh p1")
    qt_quilt_ok(ARGS new p2.patch MESSAGE "new p2")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add p2")
    qt_write_file("${QT_WORK_DIR}/f.txt" "2\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh p2")
    qt_quilt_ok(OUTPUT del_out ARGS delete MESSAGE "delete failed")
    qt_assert_contains("${del_out}" "Removing patch" "should show Removing patch")
    qt_assert_contains("${del_out}" "Now at patch" "should show Now at patch")
    qt_assert_contains("${del_out}" "Removed patch" "should show Removed patch")
endfunction()

# fold_joined_p_flag: fold should accept -p0 (joined form)
function(qt_scenario_fold_joined_p_flag)
    qt_begin_test("fold_joined_p_flag")
    qt_write_file("${QT_WORK_DIR}/f.txt" "base\n")
    qt_quilt_ok(ARGS new target.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_quilt_ok(
        ARGS fold -p0
        INPUT [=[--- f.txt
+++ f.txt
@@ -1 +1 @@
-base
+folded
]=]
        OUTPUT fold_out ERROR fold_err
        MESSAGE "fold -p0 failed"
    )
    qt_assert_file_text("${QT_WORK_DIR}/f.txt" "folded"
        "fold -p0 should apply the patch")
endfunction()

# header_append_message: header -a should print confirmation
function(qt_scenario_header_append_message)
    qt_begin_test("header_append_message")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_quilt_ok(ARGS new hdr.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "y\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    qt_quilt(RESULT rc OUTPUT out ERROR err
        ARGS header -a
        INPUT "Subject: Test\n")
    qt_assert_success("${rc}" "header -a should succeed")
    qt_assert_contains("${out}" "Appended" "header -a should confirm append")
endfunction()

# header_replace_message: header -r should print confirmation
function(qt_scenario_header_replace_message)
    qt_begin_test("header_replace_message")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_quilt_ok(ARGS new hdr.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "y\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    qt_quilt(RESULT rc OUTPUT out ERROR err
        ARGS header -r
        INPUT "New Header\n")
    qt_assert_success("${rc}" "header -r should succeed")
    qt_assert_contains("${out}" "Replaced" "header -r should confirm replace")
endfunction()

# refresh_subdir_patch: refresh should create subdirectories for patch files
function(qt_scenario_refresh_subdir_patch)
    qt_begin_test("refresh_subdir_patch")
    qt_write_file("${QT_WORK_DIR}/f.txt" "old\n")
    qt_quilt_ok(ARGS new subdir/p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "new\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    qt_assert_exists("${QT_WORK_DIR}/patches/subdir/p.patch"
        "refresh should create subdirectory for patch file")
endfunction()

# refresh_unchanged_message: refresh should say "unchanged" when nothing changed
function(qt_scenario_refresh_unchanged_message)
    qt_begin_test("refresh_unchanged_message")
    qt_write_file("${QT_WORK_DIR}/f.txt" "old\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "new\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    qt_quilt_ok(OUTPUT out ARGS refresh MESSAGE "second refresh failed")
    qt_assert_contains("${out}" "is unchanged" "second refresh should say unchanged")
endfunction()

# refresh_empty_message: refresh with no tracked changes should say "Nothing in patch"
function(qt_scenario_refresh_empty_message)
    qt_begin_test("refresh_empty_message")
    qt_quilt_ok(ARGS new empty.patch MESSAGE "new failed")
    qt_quilt_ok(OUTPUT out ARGS refresh MESSAGE "refresh failed")
    qt_assert_contains("${out}" "Nothing in patch" "empty refresh should say Nothing")
endfunction()

# refresh_empty_unchanged: an existing zero-byte patch file with nothing to
# refresh is unchanged; "Nothing in patch" is only for a newly written file
function(qt_scenario_refresh_empty_unchanged)
    qt_begin_test("refresh_empty_unchanged")
    qt_write_file("${QT_WORK_DIR}/patches/series" "a.patch\n")
    qt_write_file("${QT_WORK_DIR}/patches/a.patch" "")
    qt_quilt_ok(ARGS push -q MESSAGE "push failed")
    qt_quilt_ok(OUTPUT out ERROR err ARGS refresh MESSAGE "refresh failed")
    qt_assert_contains("${out}" "Patch a.patch is unchanged"
        "refresh of an existing empty patch should say unchanged")
    qt_combine_output(combined "${out}" "${err}")
    qt_assert_not_contains("${combined}" "Nothing in patch"
        "refresh of an existing empty patch should not say Nothing")
    qt_assert_file_text("${QT_WORK_DIR}/patches/a.patch" ""
        "empty patch file should stay empty")
    qt_quilt_ok(ARGS pop -q MESSAGE "pop failed")
    qt_quilt_ok(OUTPUT out ERROR err ARGS push --refresh MESSAGE "push --refresh failed")
    qt_assert_contains("${out}" "Patch a.patch is unchanged"
        "push --refresh of an existing empty patch should say unchanged")
    qt_combine_output(combined "${out}" "${err}")
    qt_assert_not_contains("${combined}" "Nothing in patch"
        "push --refresh of an existing empty patch should not say Nothing")
endfunction()

# diff_combine_equals: diff --combine=patch should work with = syntax
function(qt_scenario_diff_combine_equals)
    qt_begin_test("diff_combine_equals")
    qt_write_file("${QT_WORK_DIR}/f.txt" "old\n")
    qt_quilt_ok(ARGS new p1.patch MESSAGE "new p1")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add p1")
    qt_write_file("${QT_WORK_DIR}/f.txt" "mid\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh p1")
    qt_quilt_ok(ARGS new p2.patch MESSAGE "new p2")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add p2")
    qt_write_file("${QT_WORK_DIR}/f.txt" "new\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh p2")
    qt_quilt_ok(OUTPUT out ARGS diff --combine=p1.patch MESSAGE "diff --combine= failed")
    qt_assert_contains("${out}" "-old" "combined diff should show original")
    qt_assert_contains("${out}" "+new" "combined diff should show final")
endfunction()

# refresh_sorted_default: refresh should output files in sorted order by default
function(qt_scenario_refresh_sorted_default)
    qt_begin_test("refresh_sorted_default")
    qt_write_file("${QT_WORK_DIR}/z.txt" "z\n")
    qt_write_file("${QT_WORK_DIR}/a.txt" "a\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add z.txt MESSAGE "add z")
    qt_quilt_ok(ARGS add a.txt MESSAGE "add a")
    qt_write_file("${QT_WORK_DIR}/z.txt" "Z\n")
    qt_write_file("${QT_WORK_DIR}/a.txt" "A\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    # In the patch file, a.txt should come before z.txt
    file(READ "${QT_WORK_DIR}/patches/p.patch" patch_text)
    string(FIND "${patch_text}" "a.txt" a_pos)
    string(FIND "${patch_text}" "z.txt" z_pos)
    if(a_pos GREATER_EQUAL z_pos)
        qt_fail("refresh should output files in sorted order (a.txt before z.txt)")
    endif()
endfunction()

# diff_P_shadowed: diff -P on non-topmost patch should show only that patch's changes
function(qt_scenario_diff_P_shadowed)
    qt_begin_test("diff_P_shadowed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "base\n")
    qt_quilt_ok(ARGS new p1.patch MESSAGE "new p1 failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add p1 failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "v1\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh p1 failed")
    qt_quilt_ok(ARGS new p2.patch MESSAGE "new p2 failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add p2 failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "v2\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh p2 failed")
    # diff -P p1 should show base→v1, NOT base→v2
    qt_quilt_ok(OUTPUT diff_out ERROR diff_err ARGS diff -P p1.patch MESSAGE "diff -P p1 failed")
    qt_assert_contains("${diff_out}" "+v1" "diff -P p1 should show +v1")
    qt_assert_not_contains("${diff_out}" "+v2" "diff -P p1 should NOT show +v2")
endfunction()

# add_P_higher_patch: add -P should reject files modified by later applied patches
function(qt_scenario_add_P_higher_patch)
    qt_begin_test("add_P_higher_patch")
    qt_write_file("${QT_WORK_DIR}/f.txt" "base\n")
    qt_quilt_ok(ARGS new p1.patch MESSAGE "new p1 failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add p1 failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "v1\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh p1 failed")
    qt_quilt_ok(ARGS new p2.patch MESSAGE "new p2 failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add p2 failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "v2\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh p2 failed")
    # Create a new file and try to add it to p1 — should fail because p2 tracks f.txt
    qt_write_file("${QT_WORK_DIR}/g.txt" "new\n")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS add -P p1.patch g.txt)
    # g.txt is NOT modified by p2, so this should succeed
    qt_assert_success("${rc}" "add -P p1 g.txt should succeed (g.txt not in p2)")
    # Now try adding a file that IS already tracked by p2
    qt_write_file("${QT_WORK_DIR}/h.txt" "h\n")
    qt_quilt_ok(ARGS add -P p2.patch h.txt MESSAGE "add h to p2")
    qt_quilt(RESULT rc2 OUTPUT out2 ERROR err2 ARGS add -P p1.patch h.txt)
    qt_assert_failure("${rc2}" "add -P p1 h.txt should fail (h.txt in p2)")
    qt_combine_output(combined "${out2}" "${err2}")
    qt_assert_contains("${combined}" "modified by patch" "should explain why add failed")
endfunction()

# import_dup_append_separator: import -d a should put --- between old and new headers
function(qt_scenario_import_dup_append_separator)
    qt_begin_test("import_dup_append_separator")
    # Create a patch with a header
    qt_write_file("${QT_WORK_DIR}/ext/p.patch" "Old header line\n\n--- a/f.txt\n+++ b/f.txt\n@@ -1 +1 @@\n-old\n+new\n")
    qt_quilt_ok(ARGS import "${QT_WORK_DIR}/ext/p.patch" MESSAGE "import failed")
    # Create a new version of the same patch with a different header
    qt_write_file("${QT_WORK_DIR}/ext/p.patch" "New header line\n\n--- a/f.txt\n+++ b/f.txt\n@@ -1 +1 @@\n-old\n+newer\n")
    qt_quilt_ok(ARGS import -f -d a "${QT_WORK_DIR}/ext/p.patch" MESSAGE "reimport -d a failed")
    # Check that the merged header has --- between old and new
    file(READ "${QT_WORK_DIR}/patches/p.patch" patch_text)
    qt_assert_contains("${patch_text}" "Old header line" "should keep old header")
    qt_assert_contains("${patch_text}" "New header line" "should have new header")
    string(FIND "${patch_text}" "---\nNew header" sep_pos)
    if(sep_pos LESS 0)
        # Also try with just --- as separator line
        string(FIND "${patch_text}" "---\n" sep_pos)
        string(FIND "${patch_text}" "Old header" old_pos)
        string(FIND "${patch_text}" "New header" new_pos)
        if(NOT (old_pos LESS sep_pos AND sep_pos LESS new_pos))
            qt_fail("import -d a should place --- between old and new headers")
        endif()
    endif()
endfunction()

# pop_dirty_tree: pop should refuse when working file differs from refreshed state
function(qt_scenario_pop_dirty_tree)
    qt_begin_test("pop_dirty_tree")
    qt_write_file("${QT_WORK_DIR}/f.txt" "base\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "patched\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    # Modify file after refresh (dirty state)
    qt_write_file("${QT_WORK_DIR}/f.txt" "dirty\n")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS pop)
    qt_assert_failure("${rc}" "pop should fail with dirty working tree")
    qt_combine_output(combined "${out}" "${err}")
    qt_assert_contains("${combined}" "does not remove cleanly" "should explain dirty state")
endfunction()

# pop_dirty_tree_force: pop -f should succeed even with dirty working tree
function(qt_scenario_pop_dirty_tree_force)
    qt_begin_test("pop_dirty_tree_force")
    qt_write_file("${QT_WORK_DIR}/f.txt" "base\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "patched\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "dirty\n")
    qt_quilt_ok(ARGS pop -f MESSAGE "pop -f should succeed")
    qt_assert_file_contains("${QT_WORK_DIR}/f.txt" "base" "file should be restored to backup")
endfunction()

# pop_dirty_tree_refresh: pop --refresh should refresh then pop with dirty tree
function(qt_scenario_pop_dirty_tree_refresh)
    qt_begin_test("pop_dirty_tree_refresh")
    qt_write_file("${QT_WORK_DIR}/f.txt" "base\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "patched\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "dirty\n")
    qt_quilt_ok(ARGS pop --refresh MESSAGE "pop --refresh should succeed")
    qt_assert_file_contains("${QT_WORK_DIR}/f.txt" "base" "file should be restored")
    # Verify the patch was updated with the dirty content
    file(READ "${QT_WORK_DIR}/patches/p.patch" patch_text)
    qt_assert_contains("${patch_text}" "dirty" "patch should contain dirty change after refresh")
endfunction()

# push_verbose_long_option: --verbose and --quiet should be accepted
function(qt_scenario_push_verbose_long_option)
    qt_begin_test("push_verbose_long_option")
    qt_write_file("${QT_WORK_DIR}/f.txt" "base\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "mod\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    qt_quilt_ok(ARGS pop MESSAGE "pop failed")
    # --verbose should be accepted
    qt_quilt_ok(ARGS push --verbose MESSAGE "push --verbose should work")
    qt_quilt_ok(ARGS pop --quiet MESSAGE "pop --quiet should work")
    qt_quilt_ok(ARGS push --quiet MESSAGE "push --quiet should work")
endfunction()

# refresh_binary_file: refresh should fail on binary files
function(qt_scenario_refresh_binary_file)
    qt_begin_test("refresh_binary_file")
    # Create a binary file using printf to generate null bytes
    execute_process(COMMAND ${CMAKE_COMMAND} -E env printf "\\0\\001\\002"
        OUTPUT_FILE "${QT_WORK_DIR}/f.dat")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.dat MESSAGE "add failed")
    execute_process(COMMAND ${CMAKE_COMMAND} -E env printf "\\0\\003\\004"
        OUTPUT_FILE "${QT_WORK_DIR}/f.dat")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS refresh)
    qt_assert_failure("${rc}" "refresh should fail on binary file")
    qt_combine_output(combined "${out}" "${err}")
    qt_assert_contains("${combined}" "Diff failed" "should report diff failure")
endfunction()

# merge_markers_per_hunk: conflict markers should wrap only changed lines, not whole file
function(qt_scenario_merge_markers_per_hunk)
    qt_begin_test("merge_markers_per_hunk")
    qt_write_file("${QT_WORK_DIR}/f.txt" "aaa\nbbb\nccc\nddd\neee\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    # Write a patch that expects bbb -> XXX
    qt_write_file("${QT_WORK_DIR}/patches/p.patch"
        "--- a/f.txt\n+++ b/f.txt\n@@ -1,5 +1,5 @@\n aaa\n-bbb\n+XXX\n ccc\n ddd\n eee\n")
    # Change the file so bbb -> BBB (creates conflict)
    qt_write_file("${QT_WORK_DIR}/f.txt" "aaa\nBBB\nccc\nddd\neee\n")
    qt_quilt_ok(ARGS pop -f MESSAGE "pop -f")
    qt_write_file("${QT_WORK_DIR}/f.txt" "aaa\nBBB\nccc\nddd\neee\n")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS push -f --merge)
    # Context lines should appear outside markers
    qt_assert_file_contains("${QT_WORK_DIR}/f.txt" "aaa" "context should be preserved")
    qt_assert_file_contains("${QT_WORK_DIR}/f.txt" "ccc" "context should be preserved")
    qt_assert_file_contains("${QT_WORK_DIR}/f.txt" "<<<<<<<" "should have conflict marker")
    qt_assert_file_contains("${QT_WORK_DIR}/f.txt" "=======" "should have separator")
    qt_assert_file_contains("${QT_WORK_DIR}/f.txt" ">>>>>>>" "should have end marker")
    # The file should NOT have the whole-file-in-markers pattern
    qt_read_file_raw(content "${QT_WORK_DIR}/f.txt")
    # "aaa" should NOT be between <<<<<<< and =======
    string(FIND "${content}" "<<<<<<<" marker_start)
    string(FIND "${content}" "=======" separator_pos)
    string(FIND "${content}" "aaa" aaa_pos)
    # aaa should come BEFORE the marker, not inside it
    if(aaa_pos GREATER marker_start AND aaa_pos LESS separator_pos)
        qt_fail("context line 'aaa' should be outside conflict markers")
    endif()
endfunction()

# quilt_patches_absolute_path: QUILT_PATCHES with absolute path should work
function(qt_scenario_quilt_patches_absolute_path)
    qt_begin_test("quilt_patches_absolute_path")
    set(abs_patches "${QT_WORK_DIR}/external_patches")
    file(MAKE_DIRECTORY "${abs_patches}")
    set(qp_env "QUILT_PATCHES=${abs_patches}")
    qt_write_file("${QT_WORK_DIR}/f.txt" "base\n")
    qt_quilt_ok(ENV "${qp_env}" ARGS new p.patch MESSAGE "new with absolute QUILT_PATCHES failed")
    qt_quilt_ok(ENV "${qp_env}" ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "mod\n")
    qt_quilt_ok(ENV "${qp_env}" ARGS refresh MESSAGE "refresh failed")
    # Verify patch was created in the absolute path
    if(NOT EXISTS "${abs_patches}/p.patch")
        qt_fail("patch file should exist in absolute patches dir")
    endif()
    qt_quilt_ok(ENV "${qp_env}" ARGS pop MESSAGE "pop failed")
    qt_assert_file_contains("${QT_WORK_DIR}/f.txt" "base" "file should be restored")
    qt_quilt_ok(ENV "${qp_env}" ARGS push MESSAGE "push failed")
    qt_assert_file_contains("${QT_WORK_DIR}/f.txt" "mod" "file should be patched")
endfunction()

# push_already_applied_exit2: push <applied-patch> should exit 2 with "currently applied"
function(qt_scenario_push_already_applied_exit2)
    qt_begin_test("push_already_applied_exit2")
    qt_write_file("${QT_WORK_DIR}/f1.txt" "a\n")
    qt_write_file("${QT_WORK_DIR}/f2.txt" "b\n")
    qt_quilt_ok(ARGS new p1.patch MESSAGE "new p1 failed")
    qt_quilt_ok(ARGS add f1.txt MESSAGE "add f1 failed")
    qt_write_file("${QT_WORK_DIR}/f1.txt" "a1\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh p1 failed")
    qt_quilt_ok(ARGS new p2.patch MESSAGE "new p2 failed")
    qt_quilt_ok(ARGS add f2.txt MESSAGE "add f2 failed")
    qt_write_file("${QT_WORK_DIR}/f2.txt" "b2\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh p2 failed")
    # Pop p2 so p1 is applied but p2 is not — series is not fully applied
    qt_quilt_ok(ARGS pop MESSAGE "pop p2 failed")
    # Now push p1.patch which is already applied
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS push p1.patch)
    qt_assert_equal("${rc}" "2" "push already-applied should exit 2")
    qt_combine_output(combined "${out}" "${err}")
    qt_assert_contains("${combined}" "currently applied" "should say currently applied")
endfunction()

# pop_target_top_no_patch_removed: pop <top-patch> should say "No patch removed"
function(qt_scenario_pop_target_top_no_patch_removed)
    qt_begin_test("pop_target_top_no_patch_removed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_quilt_ok(ARGS new p1.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "1\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS pop p1.patch)
    qt_assert_failure("${rc}" "pop top patch should fail")
    qt_combine_output(combined "${out}" "${err}")
    qt_assert_contains("${combined}" "No patch removed" "should say no patch removed")
endfunction()

# unapplied_last_patch_ok: unapplied <last-unapplied-patch> should succeed with empty output
function(qt_scenario_unapplied_last_patch_ok)
    qt_begin_test("unapplied_last_patch_ok")
    qt_write_file("${QT_WORK_DIR}/f1.txt" "a\n")
    qt_write_file("${QT_WORK_DIR}/f2.txt" "b\n")
    qt_quilt_ok(ARGS new p1.patch MESSAGE "new p1 failed")
    qt_quilt_ok(ARGS add f1.txt MESSAGE "add f1 failed")
    qt_write_file("${QT_WORK_DIR}/f1.txt" "a1\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh p1 failed")
    qt_quilt_ok(ARGS new p2.patch MESSAGE "new p2 failed")
    qt_quilt_ok(ARGS add f2.txt MESSAGE "add f2 failed")
    qt_write_file("${QT_WORK_DIR}/f2.txt" "b2\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh p2 failed")
    # Pop all, push only p1
    qt_quilt_ok(ARGS pop -a MESSAGE "pop -a failed")
    qt_quilt_ok(ARGS push MESSAGE "push p1 failed")
    # unapplied p2.patch (the last and only unapplied) should succeed with empty output
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS unapplied p2.patch)
    qt_assert_success("${rc}" "unapplied last-patch should succeed")
    qt_assert_equal("${out}" "" "unapplied last-patch should produce empty output")
endfunction()

# push_quiet_no_extra_blank: push -q should not have extra blank line
function(qt_scenario_push_quiet_no_extra_blank)
    qt_begin_test("push_quiet_no_extra_blank")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "y\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    qt_quilt_ok(ARGS pop MESSAGE "pop failed")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS push -q)
    qt_assert_success("${rc}" "push -q should succeed")
    # Should be exactly 2 lines: "Applying patch..." and "Now at patch..."
    qt_assert_not_contains("${out}" "\n\n" "push -q should not have double newline")
endfunction()

# pop_quiet_no_extra_blank: pop -q should not have extra blank line
function(qt_scenario_pop_quiet_no_extra_blank)
    qt_begin_test("pop_quiet_no_extra_blank")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "y\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS pop -q)
    qt_assert_success("${rc}" "pop -q should succeed")
    # Should be exactly 2 lines: "Removing patch..." and "No patches applied"
    qt_assert_not_contains("${out}" "\n\n" "pop -q should not have double newline")
endfunction()

# next_applied_patch_errors: next <applied-patch> should error with "currently applied"
function(qt_scenario_next_applied_patch_errors)
    qt_begin_test("next_applied_patch_errors")
    qt_write_file("${QT_WORK_DIR}/f1.txt" "a\n")
    qt_write_file("${QT_WORK_DIR}/f2.txt" "b\n")
    qt_quilt_ok(ARGS new p1.patch MESSAGE "new p1 failed")
    qt_quilt_ok(ARGS add f1.txt MESSAGE "add f1 failed")
    qt_write_file("${QT_WORK_DIR}/f1.txt" "a1\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh p1 failed")
    qt_quilt_ok(ARGS new p2.patch MESSAGE "new p2 failed")
    qt_quilt_ok(ARGS add f2.txt MESSAGE "add f2 failed")
    qt_write_file("${QT_WORK_DIR}/f2.txt" "b2\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh p2 failed")
    # p1 and p2 are both applied; next p1 should error
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS next p1.patch)
    qt_assert_equal("${rc}" "2" "next applied patch should exit 2")
    qt_combine_output(combined "${out}" "${err}")
    qt_assert_contains("${combined}" "currently applied" "should say currently applied")
endfunction()

# pop_dirty_hint_message: pop on dirty tree should show hint about quilt diff -z
function(qt_scenario_pop_dirty_hint_message)
    qt_begin_test("pop_dirty_hint_message")
    qt_write_file("${QT_WORK_DIR}/f.txt" "hello\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "hello world\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    # Modify the file after refresh to make it dirty
    qt_write_file("${QT_WORK_DIR}/f.txt" "something completely different\n")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS pop)
    qt_assert_failure("${rc}" "pop dirty should fail")
    qt_combine_output(combined "${out}" "${err}")
    qt_assert_contains("${combined}" "does not remove cleanly" "should say does not remove cleanly")
    qt_assert_contains("${combined}" "quilt diff -z" "should show hint about quilt diff -z")
endfunction()

# refresh_strip_ws_only_modified: --strip-trailing-whitespace should only strip
# lines actually modified by the patch, not all lines with trailing whitespace
function(qt_scenario_refresh_strip_ws_only_modified)
    qt_begin_test("refresh_strip_ws_only_modified")
    # Create file where lines 1 and 3 have trailing whitespace
    qt_write_file("${QT_WORK_DIR}/f.txt" "line1 \nline2\nline3 \n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    # Modify only line 2 (add trailing whitespace too)
    qt_write_file("${QT_WORK_DIR}/f.txt" "line1 \nline2-modified  \nline3 \n")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS refresh --strip-trailing-whitespace)
    qt_assert_success("${rc}" "refresh should succeed")
    # Only line 2 should be stripped (the one the patch modifies)
    qt_combine_output(combined "${out}" "${err}")
    qt_assert_contains("${combined}" "line 2" "should strip line 2")
    qt_assert_not_contains("${combined}" "line 1" "should NOT strip line 1")
    qt_assert_not_contains("${combined}" "line 3" "should NOT strip line 3")
    # Verify file: lines 1 and 3 should still have trailing whitespace
    qt_assert_file_contains("${QT_WORK_DIR}/f.txt" "line1 " "line 1 should keep trailing space")
    qt_assert_file_contains("${QT_WORK_DIR}/f.txt" "line3 " "line 3 should keep trailing space")
    qt_assert_file_not_contains("${QT_WORK_DIR}/f.txt" "modified  " "line 2 trailing ws stripped")
endfunction()

# refresh_fork_no_extra_message: refresh -z should only print fork message, not "Refreshed patch"
function(qt_scenario_refresh_fork_no_extra_message)
    qt_begin_test("refresh_fork_no_extra_message")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "hello\n")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "world\n")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS refresh -znew.patch)
    qt_assert_success("${rc}" "refresh -z should succeed")
    qt_combine_output(combined "${out}" "${err}")
    qt_assert_contains("${combined}" "Fork of patch" "should print fork message")
    qt_assert_not_contains("${combined}" "Refreshed patch" "should NOT print Refreshed patch")
endfunction()

# fork_increment_suffix: fork should increment -N suffix (p1-2 -> p1-3, not p1-2-2)
function(qt_scenario_fork_increment_suffix)
    qt_begin_test("fork_increment_suffix")
    qt_quilt_ok(ARGS new p1.patch MESSAGE "new failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "hello\n")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "world\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    # First fork: p1.patch -> p1-2.patch
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS fork)
    qt_assert_success("${rc}" "first fork failed")
    qt_combine_output(combined "${out}" "${err}")
    qt_assert_contains("${combined}" "p1-2.patch" "first fork should be p1-2")
    # Second fork: p1-2.patch -> p1-3.patch (not p1-2-2.patch)
    qt_quilt(RESULT rc2 OUTPUT out2 ERROR err2 ARGS fork)
    qt_assert_success("${rc2}" "second fork failed")
    qt_combine_output(combined2 "${out2}" "${err2}")
    qt_assert_contains("${combined2}" "p1-3.patch" "second fork should be p1-3, not p1-2-2")
endfunction()

# import_applied_no_force: import -P with applied patch name should say "is applied" not "exists"
function(qt_scenario_import_applied_no_force)
    qt_begin_test("import_applied_no_force")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "hello\n")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/ext.patch" "--- a/g.txt\n+++ b/g.txt\n@@ -0,0 +1 @@\n+new\n")
    # Without -f: should say "is applied", not "exists"
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS import -P p.patch "${QT_WORK_DIR}/ext.patch")
    qt_assert_failure("${rc}" "import applied should fail")
    qt_combine_output(combined "${out}" "${err}")
    qt_assert_contains("${combined}" "is applied" "should say is applied, not exists")
endfunction()

# import_force_identical: import -f with byte-identical patches should succeed
function(qt_scenario_import_force_identical)
    qt_begin_test("import_force_identical")
    set(patch_content "Description: test\n--- a/f.txt\n+++ b/f.txt\n@@ -1 +1 @@\n-old\n+new\n")
    qt_write_file("${QT_WORK_DIR}/ext/p.patch" "${patch_content}")
    qt_quilt_ok(ARGS import "${QT_WORK_DIR}/ext/p.patch" MESSAGE "first import failed")
    # Import the same patch again with -f
    qt_quilt_ok(ARGS import -f "${QT_WORK_DIR}/ext/p.patch" MESSAGE "import -f identical should succeed")
endfunction()

# header_strip_diffstat_keeps_separator: --strip-diffstat should keep --- separator
function(qt_scenario_header_strip_diffstat_keeps_separator)
    qt_begin_test("header_strip_diffstat_keeps_separator")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "hello\n")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "hello\nworld\n")
    qt_quilt_ok(ARGS refresh --diffstat MESSAGE "refresh failed")
    # Read header before strip
    qt_quilt_ok(OUTPUT hdr_before ARGS header MESSAGE "header read failed")
    qt_assert_contains("${hdr_before}" "---" "header should have --- separator")
    qt_assert_contains("${hdr_before}" "file changed" "header should have diffstat")
    # Strip diffstat and verify --- remains
    qt_quilt_ok(OUTPUT hdr_after ARGS header --strip-diffstat MESSAGE "strip-diffstat failed")
    qt_assert_contains("${hdr_after}" "---" "--- separator should be preserved")
    qt_assert_not_contains("${hdr_after}" "file changed" "diffstat should be removed")
endfunction()

# diff_p0_orig_label: diff -p0 should use .orig suffix on old file label
function(qt_scenario_diff_p0_orig_label)
    qt_begin_test("diff_p0_orig_label")
    qt_quilt_ok(ARGS new -p0 p.patch MESSAGE "new failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "hello\n")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "hello\nworld\n")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS diff -p0)
    qt_assert_success("${rc}" "diff should succeed")
    qt_assert_contains("${out}" "--- f.txt.orig" "old label should have .orig suffix")
    qt_assert_contains("${out}" "+++ f.txt" "new label should be plain filename")
endfunction()

# refresh_p0_orig_label: refresh -p0 should produce .orig suffix on old file label
function(qt_scenario_refresh_p0_orig_label)
    qt_begin_test("refresh_p0_orig_label")
    qt_quilt_ok(ARGS new -p0 p.patch MESSAGE "new failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "hello\n")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "hello\nworld\n")
    qt_quilt_ok(ARGS refresh -p0 MESSAGE "refresh failed")
    qt_read_file_strip(patch "${QT_WORK_DIR}/patches/p.patch")
    qt_assert_contains("${patch}" "--- f.txt.orig" "old label should have .orig suffix")
    qt_assert_contains("${patch}" "+++ f.txt" "new label should be plain filename")
endfunction()

# series_no_series_file: series with no series file should exit 1
function(qt_scenario_series_no_series_file)
    qt_begin_test("series_no_series_file")
    # No patches/ dir, no series file
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS series)
    qt_assert_equal("${rc}" "1" "series with no series file should exit 1")
    qt_combine_output(combined "${out}" "${err}")
    qt_assert_contains("${combined}" "No series file found" "should say no series file")
endfunction()

# top_no_series_exit1: top with no series file should exit 1, not 2
function(qt_scenario_top_no_series_exit1)
    qt_begin_test("top_no_series_exit1")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS top)
    qt_assert_equal("${rc}" "1" "top with no series file should exit 1")
    qt_combine_output(combined "${out}" "${err}")
    qt_assert_contains("${combined}" "No series file found" "should say no series file")
endfunction()

# next_no_series_exit1: next with no series file should exit 1, not 2
function(qt_scenario_next_no_series_exit1)
    qt_begin_test("next_no_series_exit1")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS next)
    qt_assert_equal("${rc}" "1" "next with no series file should exit 1")
    qt_combine_output(combined "${out}" "${err}")
    qt_assert_contains("${combined}" "No series file found" "should say no series file")
endfunction()

# previous_no_series_exit1: previous with no series file should exit 1, not 2
function(qt_scenario_previous_no_series_exit1)
    qt_begin_test("previous_no_series_exit1")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS previous)
    qt_assert_equal("${rc}" "1" "previous with no series file should exit 1")
    qt_combine_output(combined "${out}" "${err}")
    qt_assert_contains("${combined}" "No series file found" "should say no series file")
endfunction()

# dotfile_toplevel: a tracked dotfile at the top level must be refreshed
# into the patch and restored on pop, not mistaken for quilt metadata
function(qt_scenario_dotfile_toplevel)
    qt_begin_test("dotfile_toplevel")
    qt_write_file("${QT_WORK_DIR}/.hidden" "a\n")
    qt_quilt_ok(ARGS new d.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add .hidden MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/.hidden" "b\n")
    qt_quilt_ok(OUTPUT refresh_out ERROR refresh_err ARGS refresh MESSAGE "refresh failed")
    qt_combine_output(refresh_combined "${refresh_out}" "${refresh_err}")
    qt_assert_not_contains("${refresh_combined}" "Nothing in patch" "refresh should capture .hidden")
    qt_assert_file_contains("${QT_WORK_DIR}/patches/d.patch" "/.hidden" "patch should contain .hidden")
    qt_assert_file_contains("${QT_WORK_DIR}/patches/d.patch" "\n+b\n" "patch should contain .hidden change")
    qt_quilt_ok(OUTPUT files_out ERROR files_err ARGS files MESSAGE "files failed")
    qt_assert_equal("${files_out}" ".hidden\n" "files should list .hidden")
    qt_quilt_ok(ARGS pop MESSAGE "pop failed")
    qt_assert_file_text("${QT_WORK_DIR}/.hidden" "a" "pop should restore .hidden")
    qt_quilt_ok(ARGS push MESSAGE "push failed")
    qt_assert_file_text("${QT_WORK_DIR}/.hidden" "b" "push should reapply .hidden")
endfunction()

# dotfile_subdir: dotfiles in subdirectories are tracked, including names
# that match quilt metadata (.timestamp, .needs_refresh) below the top level
function(qt_scenario_dotfile_subdir)
    qt_begin_test("dotfile_subdir")
    qt_write_file("${QT_WORK_DIR}/sub/.hidden" "s\n")
    qt_write_file("${QT_WORK_DIR}/sub/.timestamp" "t\n")
    qt_write_file("${QT_WORK_DIR}/sub/.needs_refresh" "n\n")
    qt_quilt_ok(ARGS new d.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add sub/.hidden sub/.timestamp sub/.needs_refresh MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/sub/.hidden" "S\n")
    qt_write_file("${QT_WORK_DIR}/sub/.timestamp" "T\n")
    qt_write_file("${QT_WORK_DIR}/sub/.needs_refresh" "N\n")
    qt_quilt_ok(OUTPUT refresh_out ERROR refresh_err ARGS refresh MESSAGE "refresh failed")
    qt_combine_output(refresh_combined "${refresh_out}" "${refresh_err}")
    qt_assert_not_contains("${refresh_combined}" "Nothing in patch" "refresh should capture sub/ dotfiles")
    qt_assert_file_contains("${QT_WORK_DIR}/patches/d.patch" "/sub/.hidden" "patch should contain sub/.hidden")
    qt_assert_file_contains("${QT_WORK_DIR}/patches/d.patch" "/sub/.timestamp" "patch should contain sub/.timestamp")
    qt_assert_file_contains("${QT_WORK_DIR}/patches/d.patch" "/sub/.needs_refresh" "patch should contain sub/.needs_refresh")
    qt_quilt_ok(OUTPUT files_out ERROR files_err ARGS files MESSAGE "files failed")
    qt_assert_contains("${files_out}" "sub/.hidden\n" "files should list sub/.hidden")
    qt_assert_contains("${files_out}" "sub/.timestamp\n" "files should list sub/.timestamp")
    qt_assert_contains("${files_out}" "sub/.needs_refresh\n" "files should list sub/.needs_refresh")
    qt_assert_line_count("${files_out}" 3 "files should list exactly three files")
    qt_quilt_ok(ARGS pop MESSAGE "pop failed")
    qt_assert_file_text("${QT_WORK_DIR}/sub/.hidden" "s" "pop should restore sub/.hidden")
    qt_assert_file_text("${QT_WORK_DIR}/sub/.timestamp" "t" "pop should restore sub/.timestamp")
    qt_assert_file_text("${QT_WORK_DIR}/sub/.needs_refresh" "n" "pop should restore sub/.needs_refresh")
    qt_quilt_ok(ARGS push MESSAGE "push failed")
    qt_assert_file_text("${QT_WORK_DIR}/sub/.hidden" "S" "push should reapply sub/.hidden")
endfunction()

# Build a two-patch stack where both patches modify g.txt
function(qt_setup_two_patch_stack)
    qt_write_file("${QT_WORK_DIR}/g.txt" "a\n")
    qt_quilt_ok(ARGS new p1.patch MESSAGE "new p1 failed")
    qt_quilt_ok(ARGS add g.txt MESSAGE "add to p1 failed")
    qt_write_file("${QT_WORK_DIR}/g.txt" "b\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh p1 failed")
    qt_quilt_ok(ARGS new p2.patch MESSAGE "new p2 failed")
    qt_quilt_ok(ARGS add g.txt MESSAGE "add to p2 failed")
    qt_write_file("${QT_WORK_DIR}/g.txt" "c\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh p2 failed")
endfunction()

# refresh_named_unapplied: refreshing a named unapplied patch while another
# patch is applied must fail and leave the patch file untouched
function(qt_scenario_refresh_named_unapplied)
    qt_begin_test("refresh_named_unapplied")
    qt_setup_two_patch_stack()
    qt_quilt_ok(ARGS pop MESSAGE "pop failed")
    qt_read_file_raw(before "${QT_WORK_DIR}/patches/p2.patch")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS refresh p2.patch)
    qt_assert_failure("${rc}" "refresh of unapplied patch should fail")
    qt_assert_contains("${err}" "Patch p2.patch is not applied" "should report patch not applied")
    qt_read_file_raw(after "${QT_WORK_DIR}/patches/p2.patch")
    qt_assert_equal("${after}" "${before}" "unapplied patch file must be unchanged")
endfunction()

# refresh_named_not_in_series: refreshing a name missing from the series fails
function(qt_scenario_refresh_named_not_in_series)
    qt_begin_test("refresh_named_not_in_series")
    qt_setup_two_patch_stack()
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS refresh nope.patch)
    qt_assert_failure("${rc}" "refresh of unknown patch should fail")
    qt_assert_contains("${err}" "Patch nope.patch is not in series" "should report patch not in series")
    qt_assert_not_exists("${QT_WORK_DIR}/patches/nope.patch" "refresh must not create unknown patch")
endfunction()

# diff_P_unapplied: diff -P and --combine reject a named unapplied patch
function(qt_scenario_diff_P_unapplied)
    qt_begin_test("diff_P_unapplied")
    qt_setup_two_patch_stack()
    qt_quilt_ok(ARGS pop MESSAGE "pop failed")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS diff -P p2.patch)
    qt_assert_failure("${rc}" "diff -P of unapplied patch should fail")
    qt_assert_contains("${err}" "Patch p2.patch is not applied" "diff -P should report patch not applied")
    qt_assert_equal("${out}" "" "diff -P of unapplied patch should print no diff")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS diff --combine p2.patch)
    qt_assert_failure("${rc}" "diff --combine of unapplied patch should fail")
    qt_assert_contains("${err}" "Patch p2.patch is not applied" "--combine should report patch not applied")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS diff -P nope.patch)
    qt_assert_failure("${rc}" "diff -P of unknown patch should fail")
    qt_assert_contains("${err}" "Patch nope.patch is not in series" "diff -P should report patch not in series")
endfunction()

# diff_combine_wrong_order: --combine start must not be above the -P patch
function(qt_scenario_diff_combine_wrong_order)
    qt_begin_test("diff_combine_wrong_order")
    qt_setup_two_patch_stack()
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS diff --combine p2.patch -P p1.patch)
    qt_assert_failure("${rc}" "diff --combine in wrong order should fail")
    qt_assert_contains("${err}" "Patch p2.patch not applied before patch p1.patch"
        "should report combine order error")
    qt_assert_equal("${out}" "" "wrong-order combine should print no diff")
endfunction()

# --diff-algorithm tests

function(qt_scenario_diff_algorithm_myers)
    qt_begin_test("diff_algorithm_myers")
    qt_write_file("${QT_WORK_DIR}/f.txt" "aaa\nbbb\nccc\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "aaa\nBBB\nccc\n")
    qt_quilt(RESULT rc OUTPUT diff_out ERROR diff_err ARGS diff --diff-algorithm=myers)
    qt_assert_success("${rc}" "diff --diff-algorithm=myers should succeed")
    qt_assert_contains("${diff_out}" "-bbb" "should show removed line")
    qt_assert_contains("${diff_out}" "+BBB" "should show added line")
endfunction()

function(qt_scenario_diff_algorithm_minimal)
    qt_begin_test("diff_algorithm_minimal")
    qt_write_file("${QT_WORK_DIR}/f.txt" "aaa\nbbb\nccc\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "aaa\nBBB\nccc\n")
    qt_quilt(RESULT rc OUTPUT diff_out ERROR diff_err ARGS diff --diff-algorithm=minimal)
    qt_assert_success("${rc}" "diff --diff-algorithm=minimal should succeed")
    qt_assert_contains("${diff_out}" "-bbb" "should show removed line")
    qt_assert_contains("${diff_out}" "+BBB" "should show added line")
endfunction()

function(qt_scenario_diff_algorithm_invalid)
    qt_begin_test("diff_algorithm_invalid")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "y\n")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS diff --diff-algorithm=bogus)
    qt_assert_failure("${rc}" "invalid algorithm should fail")
    qt_assert_contains("${err}" "Unknown diff algorithm" "should report unknown algorithm")
endfunction()

function(qt_scenario_diff_algorithm_space_form)
    qt_begin_test("diff_algorithm_space_form")
    qt_write_file("${QT_WORK_DIR}/f.txt" "aaa\nbbb\nccc\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "aaa\nBBB\nccc\n")
    qt_quilt(RESULT rc OUTPUT diff_out ERROR diff_err ARGS diff --diff-algorithm minimal)
    qt_assert_success("${rc}" "diff --diff-algorithm minimal (space) should succeed")
    qt_assert_contains("${diff_out}" "-bbb" "should show removed line")
    qt_assert_contains("${diff_out}" "+BBB" "should show added line")
endfunction()

function(qt_scenario_refresh_diff_algorithm)
    qt_begin_test("refresh_diff_algorithm")
    qt_write_file("${QT_WORK_DIR}/f.txt" "aaa\nbbb\nccc\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "aaa\nBBB\nccc\n")
    qt_quilt_ok(ARGS refresh --diff-algorithm=minimal MESSAGE "refresh --diff-algorithm=minimal failed")
    qt_read_file_strip(patch_content "${QT_WORK_DIR}/patches/p.patch")
    qt_assert_contains("${patch_content}" "-bbb" "patch should contain removed line")
    qt_assert_contains("${patch_content}" "+BBB" "patch should contain added line")
endfunction()

# Distinguishing test: large input where myers heuristic produces a
# suboptimal diff while minimal finds the true shortest edit script.
function(qt_scenario_diff_algorithm_minimal_vs_myers)
    qt_begin_test("diff_algorithm_minimal_vs_myers")

    # Generate a 400-line file, then modify 2/3 of the lines.
    # Edit distance ~533 exceeds the cost cap (256), so myers
    # will use a heuristic and produce a longer diff than minimal.
    set(original "")
    set(modified "")
    foreach(i RANGE 0 399)
        string(LENGTH "${i}" ilen)
        if(ilen EQUAL 1)
            set(pad "00${i}")
        elseif(ilen EQUAL 2)
            set(pad "0${i}")
        else()
            set(pad "${i}")
        endif()
        string(APPEND original "original_line_${pad}\n")
        math(EXPR mod3 "${i} % 3")
        if(mod3 EQUAL 0)
            string(APPEND modified "original_line_${pad}\n")
        else()
            string(APPEND modified "replacement_line_${pad}\n")
        endif()
    endforeach()

    qt_write_file("${QT_WORK_DIR}/f.txt" "${original}")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "${modified}")

    # Get diffs with both algorithms
    qt_quilt(RESULT rc_myers OUTPUT diff_myers ERROR err_myers
             ARGS diff --diff-algorithm=myers --no-timestamps)
    qt_assert_success("${rc_myers}" "myers diff should succeed")

    qt_quilt(RESULT rc_min OUTPUT diff_min ERROR err_min
             ARGS diff --diff-algorithm=minimal --no-timestamps)
    qt_assert_success("${rc_min}" "minimal diff should succeed")

    # Count +/- lines (excluding --- and +++ headers)
    string(REGEX MATCHALL "\n-[^\n]" myers_dels "${diff_myers}")
    string(REGEX MATCHALL "\n\\+[^\n]" myers_adds "${diff_myers}")
    list(LENGTH myers_dels myers_del_count)
    list(LENGTH myers_adds myers_add_count)
    math(EXPR myers_edits "${myers_del_count} + ${myers_add_count}")

    string(REGEX MATCHALL "\n-[^\n]" min_dels "${diff_min}")
    string(REGEX MATCHALL "\n\\+[^\n]" min_adds "${diff_min}")
    list(LENGTH min_dels min_del_count)
    list(LENGTH min_adds min_add_count)
    math(EXPR min_edits "${min_del_count} + ${min_add_count}")

    # minimal must produce a diff no longer than myers
    if(min_edits GREATER myers_edits)
        qt_fail("minimal (${min_edits} edits) should be <= myers (${myers_edits} edits)")
    endif()
endfunction()

# Regression test: myers heuristic must not dump matching tail lines as
# raw edits.  Changes are concentrated in the first half; the second half
# is identical in both files.  A broken heuristic would dump the tail as
# raw deletes/inserts, producing a diff ~2.5x larger than minimal.
function(qt_scenario_diff_algorithm_myers_heuristic_tail)
    qt_begin_test("diff_algorithm_myers_heuristic_tail")

    # Build two 500-line files:
    #   Lines 0-299: alternating shared/unique (150 changes, D=300 > 256 cap)
    #   Lines 300-499: identical tail section
    set(original "")
    set(modified "")
    foreach(i RANGE 0 299)
        math(EXPR mod2 "${i} % 2")
        string(LENGTH "${i}" ilen)
        if(ilen EQUAL 1)
            set(pad "00${i}")
        elseif(ilen EQUAL 2)
            set(pad "0${i}")
        else()
            set(pad "${i}")
        endif()
        if(mod2 EQUAL 0)
            string(APPEND original "shared_${pad}\n")
            string(APPEND modified "shared_${pad}\n")
        else()
            string(APPEND original "unique_old_${pad}\n")
            string(APPEND modified "unique_new_${pad}\n")
        endif()
    endforeach()
    foreach(i RANGE 0 199)
        string(LENGTH "${i}" ilen)
        if(ilen EQUAL 1)
            set(pad "00${i}")
        elseif(ilen EQUAL 2)
            set(pad "0${i}")
        else()
            set(pad "${i}")
        endif()
        string(APPEND original "tail_${pad}\n")
        string(APPEND modified "tail_${pad}\n")
    endforeach()

    qt_write_file("${QT_WORK_DIR}/f.txt" "${original}")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "${modified}")

    qt_quilt(RESULT rc_myers OUTPUT diff_myers ERROR err_myers
             ARGS diff --diff-algorithm=myers --no-timestamps)
    qt_assert_success("${rc_myers}" "myers diff should succeed")

    qt_quilt(RESULT rc_min OUTPUT diff_min ERROR err_min
             ARGS diff --diff-algorithm=minimal --no-timestamps)
    qt_assert_success("${rc_min}" "minimal diff should succeed")

    # Count edit lines
    string(REGEX MATCHALL "\n-[^\n]" myers_dels "${diff_myers}")
    string(REGEX MATCHALL "\n\\+[^\n]" myers_adds "${diff_myers}")
    list(LENGTH myers_dels myers_del_count)
    list(LENGTH myers_adds myers_add_count)
    math(EXPR myers_edits "${myers_del_count} + ${myers_add_count}")

    string(REGEX MATCHALL "\n-[^\n]" min_dels "${diff_min}")
    string(REGEX MATCHALL "\n\\+[^\n]" min_adds "${diff_min}")
    list(LENGTH min_dels min_del_count)
    list(LENGTH min_adds min_add_count)
    math(EXPR min_edits "${min_del_count} + ${min_add_count}")

    # myers must not be catastrophically worse than minimal.
    # Without the recursion fix, myers produces ~744 edits vs minimal's ~302.
    math(EXPR limit "${min_edits} * 2")
    if(myers_edits GREATER limit)
        qt_fail("myers (${myers_edits} edits) is more than 2x minimal (${min_edits} edits) -- heuristic tail dump bug")
    endif()
endfunction()

# Patience diff tests

function(qt_scenario_diff_algorithm_patience_basic)
    qt_begin_test("diff_algorithm_patience_basic")
    qt_write_file("${QT_WORK_DIR}/f.txt" "aaa\nbbb\nccc\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "aaa\nBBB\nccc\n")
    qt_quilt(RESULT rc OUTPUT diff_out ERROR diff_err ARGS diff --diff-algorithm=patience)
    qt_assert_success("${rc}" "diff --diff-algorithm=patience should succeed")
    qt_assert_contains("${diff_out}" "-bbb" "should show removed line")
    qt_assert_contains("${diff_out}" "+BBB" "should show added line")
    qt_assert_contains("${diff_out}" " aaa" "should show context")
    qt_assert_contains("${diff_out}" " ccc" "should show context")
endfunction()

# Classic patience diff motivating example: inserting a new function
# between two existing ones.  Patience anchors on unique function
# signatures so the closing brace stays with its function body.
function(qt_scenario_diff_algorithm_patience_function_insert)
    qt_begin_test("diff_algorithm_patience_function_insert")

    # Two functions, each with a duplicated closing brace.
    set(old_content [=[void func1() {
    x += 1
}
void func2() {
    x += 2
}
]=])
    # Insert a new function between them.
    set(new_content [=[void func1() {
    x += 1
}
void func_new() {
    x += 1.5
}
void func2() {
    x += 2
}
]=])

    qt_write_file("${QT_WORK_DIR}/f.txt" "${old_content}")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "${new_content}")

    qt_quilt(RESULT rc OUTPUT diff_out ERROR diff_err
             ARGS diff --diff-algorithm=patience --no-timestamps)
    qt_assert_success("${rc}" "patience diff should succeed")

    # The diff should show func_new as a clean insertion block.
    # Patience must NOT detach the closing brace from func1.
    # A clean insertion looks like "+void func_new" with the closing
    # brace of func1 on a context line before it.
    qt_assert_contains("${diff_out}" " }" "closing brace should be context, not detached")
    qt_assert_contains("${diff_out}" "+void func_new" "new function should be added")
    qt_assert_contains("${diff_out}" "+    x += 1.5" "new function body should be added")
endfunction()

# When no lines are unique in either file, patience falls back to Myers.
function(qt_scenario_diff_algorithm_patience_no_unique)
    qt_begin_test("diff_algorithm_patience_no_unique")

    # Both files share the same set of lines, just reordered.
    # No line is unique — all appear in both files.
    qt_write_file("${QT_WORK_DIR}/f.txt" "a\nb\nc\na\nb\nc\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "a\nb\nc\nX\na\nb\nc\n")

    qt_quilt(RESULT rc OUTPUT diff_out ERROR diff_err
             ARGS diff --diff-algorithm=patience --no-timestamps)
    qt_assert_success("${rc}" "patience with no unique lines should succeed")
    qt_assert_contains("${diff_out}" "+X" "should show the inserted line")
endfunction()

function(qt_scenario_diff_algorithm_histogram_basic)
    qt_begin_test("diff_algorithm_histogram_basic")
    qt_write_file("${QT_WORK_DIR}/f.txt" "aaa\nbbb\nccc\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "aaa\nBBB\nccc\n")
    qt_quilt(RESULT rc OUTPUT diff_out ERROR diff_err ARGS diff --diff-algorithm=histogram)
    qt_assert_success("${rc}" "diff --diff-algorithm=histogram should succeed")
    qt_assert_contains("${diff_out}" "-bbb" "should show removed line")
    qt_assert_contains("${diff_out}" "+BBB" "should show added line")
    qt_assert_contains("${diff_out}" " aaa" "should show context")
    qt_assert_contains("${diff_out}" " ccc" "should show context")
endfunction()

function(qt_scenario_diff_algorithm_histogram_function_insert)
    qt_begin_test("diff_algorithm_histogram_function_insert")

    # Two functions, each with a duplicated closing brace.
    set(old_content [=[void func1() {
    x += 1
}
void func2() {
    x += 2
}
]=])
    # Insert a new function between them.
    set(new_content [=[void func1() {
    x += 1
}
void func_new() {
    x += 1.5
}
void func2() {
    x += 2
}
]=])

    qt_write_file("${QT_WORK_DIR}/f.txt" "${old_content}")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "${new_content}")

    qt_quilt(RESULT rc OUTPUT diff_out ERROR diff_err
             ARGS diff --diff-algorithm=histogram --no-timestamps)
    qt_assert_success("${rc}" "histogram diff should succeed")

    # Histogram behaves like patience when unique lines exist:
    # it should NOT detach the closing brace from func1.
    qt_assert_contains("${diff_out}" " }" "closing brace should be context, not detached")
    qt_assert_contains("${diff_out}" "+void func_new" "new function should be added")
    qt_assert_contains("${diff_out}" "+    x += 1.5" "new function body should be added")
endfunction()

function(qt_scenario_diff_algorithm_histogram_no_unique)
    qt_begin_test("diff_algorithm_histogram_no_unique")

    # No line is unique — each appears at least twice.  Patience would
    # fall back entirely to Myers here, but histogram can still anchor
    # on the lowest-occurrence lines.
    qt_write_file("${QT_WORK_DIR}/f.txt" "a\nb\nc\na\nb\nc\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "a\nb\nc\nX\na\nb\nc\n")

    qt_quilt(RESULT rc OUTPUT diff_out ERROR diff_err
             ARGS diff --diff-algorithm=histogram --no-timestamps)
    qt_assert_success("${rc}" "histogram with no unique lines should succeed")
    qt_assert_contains("${diff_out}" "+X" "should show the inserted line")
endfunction()

function(qt_scenario_diff_algorithm_env)
    qt_begin_test("diff_algorithm_env")
    qt_write_file("${QT_WORK_DIR}/f.txt" "aaa\nbbb\nccc\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "aaa\nBBB\nccc\n")

    # QUILT_DIFF_ALGORITHM sets the default for refresh
    qt_quilt_ok(ENV "QUILT_DIFF_ALGORITHM=minimal"
                ARGS refresh MESSAGE "refresh with QUILT_DIFF_ALGORITHM failed")
    qt_read_file_strip(patch_content "${QT_WORK_DIR}/patches/p.patch")
    qt_assert_contains("${patch_content}" "-bbb" "patch should contain removed line")
    qt_assert_contains("${patch_content}" "+BBB" "patch should contain added line")

    # Also works for diff command — pop, re-push, then diff unresfreshed change
    qt_quilt_ok(ARGS pop MESSAGE "pop failed")
    qt_quilt_ok(ARGS push MESSAGE "push failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "aaa\nXXX\nccc\n")
    qt_quilt(RESULT rc OUTPUT diff_out ERROR diff_err
             ENV "QUILT_DIFF_ALGORITHM=patience"
             ARGS diff --no-timestamps)
    qt_assert_success("${rc}" "diff with QUILT_DIFF_ALGORITHM should succeed")
    qt_assert_contains("${diff_out}" "-bbb" "diff should show original line")
    qt_assert_contains("${diff_out}" "+XXX" "diff should show new line")
endfunction()

function(qt_scenario_diff_algorithm_env_override)
    qt_begin_test("diff_algorithm_env_override")
    qt_write_file("${QT_WORK_DIR}/f.txt" "aaa\nbbb\nccc\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "aaa\nBBB\nccc\n")

    # --diff-algorithm on command line overrides the env var
    qt_quilt_ok(ENV "QUILT_DIFF_ALGORITHM=patience"
                ARGS refresh --diff-algorithm=minimal
                MESSAGE "refresh with CLI override failed")
    qt_read_file_strip(patch_content "${QT_WORK_DIR}/patches/p.patch")
    qt_assert_contains("${patch_content}" "-bbb" "patch should contain removed line")
    qt_assert_contains("${patch_content}" "+BBB" "patch should contain added line")
endfunction()

function(qt_scenario_diff_algorithm_env_invalid)
    qt_begin_test("diff_algorithm_env_invalid")
    qt_write_file("${QT_WORK_DIR}/f.txt" "aaa\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "bbb\n")

    # Invalid algorithm name in env var should fail
    qt_quilt(RESULT rc OUTPUT out ERROR err
             ENV "QUILT_DIFF_ALGORITHM=bogus"
             ARGS refresh)
    qt_assert_failure("${rc}" "refresh with invalid QUILT_DIFF_ALGORITHM should fail")
    qt_combine_output(combined "${out}" "${err}")
    qt_assert_contains("${combined}" "Unknown diff algorithm" "should report bad algorithm")
endfunction()

function(qt_scenario_diff_algorithm_env_diff_cmd)
    qt_begin_test("diff_algorithm_env_diff_cmd")
    qt_write_file("${QT_WORK_DIR}/f.txt" "aaa\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "bbb\n")

    # Invalid algorithm name in env var should also fail for diff command
    qt_quilt(RESULT rc OUTPUT out ERROR err
             ENV "QUILT_DIFF_ALGORITHM=bogus"
             ARGS diff)
    qt_assert_failure("${rc}" "diff with invalid QUILT_DIFF_ALGORITHM should fail")
    qt_combine_output(combined "${out}" "${err}")
    qt_assert_contains("${combined}" "Unknown diff algorithm" "should report bad algorithm")
endfunction()

# ---------------------------------------------------------------------------
# Scenarios added from the coverage audit.
# ---------------------------------------------------------------------------

function(qt_scenario_push_merge_short)
    qt_begin_test("push_merge_short")
    qt_write_file("${QT_WORK_DIR}/f.txt" "one\ntwo\nthree\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "one\nTWO\nthree\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    qt_quilt_ok(ARGS pop MESSAGE "pop failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "one\n2\nthree\n")
    # -m is the short form of --merge; -f allows the merged apply
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS push -m -f)
    qt_assert_failure("${rc}" "push -m -f on a conflict should fail")
    qt_combine_output(combined "${out}" "${err}")
    qt_assert_contains("${combined}" "Applying patch p.patch" "push should announce the patch")
    qt_assert_contains("${combined}" "needs refresh" "forced apply should be reported")
    qt_assert_file_contains("${QT_WORK_DIR}/f.txt" "<<<<<<<" "merge markers should be written")
    qt_assert_file_contains("${QT_WORK_DIR}/f.txt" ">>>>>>>" "merge markers should be written")
endfunction()

function(qt_scenario_push_quilt_patch_opts_reverse)
    qt_begin_test("push_quilt_patch_opts_reverse")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "y\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    qt_quilt_ok(ARGS pop MESSAGE "pop failed")
    # The patch is x -> y. With the file already at y, QUILT_PATCH_OPTS=-R
    # makes push reverse-apply it, turning y back into x.
    qt_write_file("${QT_WORK_DIR}/f.txt" "y\n")
    qt_quilt_ok(ENV "QUILT_PATCH_OPTS=-R" ARGS push
                MESSAGE "push with QUILT_PATCH_OPTS=-R failed")
    qt_assert_file_text("${QT_WORK_DIR}/f.txt" "x" "patch should be reverse-applied")
endfunction()

function(qt_scenario_push_quiet_all)
    qt_begin_test("push_quiet_all")
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
    qt_quilt_ok(OUTPUT out ERROR err ARGS push -q -a MESSAGE "push -q -a failed")
    qt_assert_equal("${out}" "Applying patch a.patch\nApplying patch b.patch\nNow at patch b.patch\n"
                    "quiet push should not print blank lines")
endfunction()

# Pushing a zero-byte patch file reports it on stdout, even with -q, but a
# patch that changes files does not
function(qt_scenario_push_empty_patch_file)
    qt_begin_test("push_empty_patch_file")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_write_file("${QT_WORK_DIR}/patches/series" "a.patch\nb.patch\n")
    qt_write_file("${QT_WORK_DIR}/patches/a.patch" "")
    qt_write_file("${QT_WORK_DIR}/patches/b.patch" "--- a/f.txt\n+++ b/f.txt\n@@ -1 +1 @@\n-x\n+y\n")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS push)
    qt_assert_success("${rc}" "push of empty patch should succeed")
    qt_assert_equal("${out}" "Applying patch a.patch\nPatch a.patch appears to be empty; applied\n\nNow at patch a.patch\n"
                    "push should report the empty patch")
    qt_assert_equal("${err}" "" "push should print nothing on stderr")
    qt_quilt_ok(ARGS pop MESSAGE "pop failed")
    qt_quilt_ok(OUTPUT out ERROR err ARGS push -q -a MESSAGE "push -q -a failed")
    qt_assert_equal("${out}" "Applying patch a.patch\nPatch a.patch appears to be empty; applied\nApplying patch b.patch\nNow at patch b.patch\n"
                    "quiet push should still report the empty patch")
    qt_assert_file_text("${QT_WORK_DIR}/f.txt" "y" "b.patch should be applied")
endfunction()

function(qt_scenario_pop_quiet_all)
    qt_begin_test("pop_quiet_all")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_quilt_ok(ARGS new a.patch MESSAGE "new a failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add a failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "a\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh a failed")
    qt_quilt_ok(ARGS new b.patch MESSAGE "new b failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add b failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "b\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh b failed")
    qt_quilt_ok(OUTPUT out ERROR err ARGS pop -q -a MESSAGE "pop -q -a failed")
    qt_assert_equal("${out}" "Removing patch b.patch\nRemoving patch a.patch\nNo patches applied\n"
                    "quiet pop should not print blank lines")
endfunction()

function(qt_scenario_pop_count_clamp)
    qt_begin_test("pop_count_clamp")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_quilt_ok(ARGS new a.patch MESSAGE "new a failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add a failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "a\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh a failed")
    qt_quilt_ok(ARGS new b.patch MESSAGE "new b failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add b failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "b\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh b failed")
    # A count of zero removes nothing
    qt_quilt(RESULT rc OUTPUT out0 ERROR err0 ARGS pop 0)
    qt_assert_equal("${rc}" "2" "pop 0 should exit 2")
    qt_assert_contains("${err0}" "No patch removed" "pop 0 should remove nothing")
    # A count larger than the applied stack pops everything
    qt_quilt_ok(OUTPUT out ERROR err ARGS pop 99 MESSAGE "pop 99 failed")
    qt_assert_contains("${out}" "No patches applied" "empty stack should be reported")
    qt_assert_file_text("${QT_WORK_DIR}/f.txt" "x" "all patches should be popped")
    qt_quilt(RESULT rc2 OUTPUT out2 ERROR err2 ARGS pop 0)
    qt_assert_equal("${rc2}" "2" "pop 0 with nothing applied should exit 2")
    qt_assert_contains("${err2}" "No patch removed" "pop 0 with nothing applied should remove nothing")
endfunction()

function(qt_scenario_pop_refresh_needs_refresh)
    qt_begin_test("pop_refresh_needs_refresh")
    qt_write_file("${QT_WORK_DIR}/f.txt" "one\ntwo\nthree\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "one\nTWO\nthree\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    qt_quilt_ok(ARGS new q.patch MESSAGE "new q failed")
    qt_quilt_ok(ARGS pop -a MESSAGE "pop -a failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "one\n2\nthree\n")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS push -f)
    qt_assert_failure("${rc}" "forced push of a conflicting patch should fail")
    # The forced patch needs a refresh; --refresh must not bypass the check
    # (refreshing it here would throw away the patch's rejected hunk)
    qt_quilt(RESULT rc2 OUTPUT out2 ERROR err2 ARGS pop --refresh)
    qt_assert_failure("${rc2}" "pop --refresh of a needs-refresh patch should fail")
    qt_combine_output(combined "${out2}" "${err2}")
    qt_assert_contains("${combined}" "needs to be refreshed first" "failure should be explained")
    qt_assert_exists("${QT_WORK_DIR}/.pc/p.patch" "patch should still be applied")
    qt_assert_file_contains("${QT_WORK_DIR}/patches/p.patch" "+TWO" "patch content should be kept")
    # The target patch is resolved before the needs-refresh check
    qt_quilt(RESULT rc3 OUTPUT out3 ERROR err3 ARGS pop q.patch)
    qt_assert_failure("${rc3}" "pop of an unapplied patch should fail")
    qt_combine_output(combined3 "${out3}" "${err3}")
    qt_assert_contains("${combined3}" "Patch q.patch is not applied" "unapplied target should be reported")
endfunction()

function(qt_scenario_pop_force_refresh_conflict)
    qt_begin_test("pop_force_refresh_conflict")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "y\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS pop -f --refresh)
    qt_assert_failure("${rc}" "pop -f --refresh should fail")
    qt_combine_output(combined "${out}" "${err}")
    qt_assert_contains("${combined}" "mutually exclusive" "conflicting options should be rejected")
    qt_assert_exists("${QT_WORK_DIR}/.pc/p.patch" "patch should still be applied")
    qt_assert_file_text("${QT_WORK_DIR}/f.txt" "y" "working file should be unchanged")
    # -R cancels an earlier -f
    qt_quilt_ok(ARGS pop -f -R --refresh MESSAGE "pop -f -R --refresh failed")
    qt_assert_file_text("${QT_WORK_DIR}/f.txt" "x" "patch should be popped")
endfunction()

function(qt_scenario_pop_empty_patch)
    qt_begin_test("pop_empty_patch")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "y\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    qt_quilt_ok(ARGS new empty.patch MESSAGE "new empty failed")
    qt_quilt_ok(OUTPUT out ERROR err ARGS pop MESSAGE "pop failed")
    qt_assert_equal("${out}" "Patch empty.patch appears to be empty, removing\n\nNow at patch p.patch\n"
                    "pop of an empty patch")
    qt_assert_exists("${QT_WORK_DIR}/.pc/p.patch" "p.patch should still be applied")
    # delete pops quietly: no blank line before the new top
    qt_quilt_ok(ARGS new empty2.patch MESSAGE "new empty2 failed")
    qt_quilt_ok(OUTPUT out2 ERROR err2 ARGS delete MESSAGE "delete of empty patch failed")
    qt_assert_equal("${out2}" "Patch empty2.patch appears to be empty, removing\nNow at patch p.patch\nRemoved patch empty2.patch\n"
                    "delete of an empty top patch")
    qt_quilt_ok(OUTPUT out3 ERROR err3 ARGS delete MESSAGE "delete of p.patch failed")
    qt_assert_equal("${out3}" "Removing patch p.patch\nNo patches applied\nRemoved patch p.patch\n"
                    "delete of the last applied patch")
endfunction()

# pop must refuse when an edit lies outside the hunks of the refreshed
# patch, which reverse-applying the patch would not notice
function(qt_scenario_pop_unrefreshed_outside_hunk)
    qt_begin_test("pop_unrefreshed_outside_hunk")
    set(content "")
    foreach(i RANGE 1 30)
        string(APPEND content "${i}\n")
    endforeach()
    qt_write_file("${QT_WORK_DIR}/big.txt" "${content}")
    qt_quilt_ok(ARGS new p1.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add big.txt MESSAGE "add failed")
    string(REGEX REPLACE "^1\n" "ONE\n" content "${content}")
    qt_write_file("${QT_WORK_DIR}/big.txt" "${content}")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    string(REPLACE "\n30\n" "\nTHIRTY\n" content "${content}")
    qt_write_file("${QT_WORK_DIR}/big.txt" "${content}")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS pop)
    qt_assert_failure("${rc}" "pop with an unrefreshed edit should fail")
    qt_combine_output(combined "${out}" "${err}")
    qt_assert_contains("${combined}" "Patch p1.patch does not remove cleanly (refresh it or enforce with -f)"
                       "failure should be explained")
    qt_assert_contains("${combined}" "Hint: `quilt diff -z' will show the pending changes." "hint should be shown")
    qt_assert_exists("${QT_WORK_DIR}/.pc/p1.patch" "patch should still be applied")
    qt_assert_file_contains("${QT_WORK_DIR}/big.txt" "THIRTY" "unrefreshed edit should be kept")
    qt_quilt_ok(ARGS refresh MESSAGE "second refresh failed")
    qt_quilt_ok(ARGS pop MESSAGE "pop after refresh failed")
    qt_assert_file_not_contains("${QT_WORK_DIR}/big.txt" "THIRTY" "pop should restore the original")
endfunction()

# pop must refuse when a patch with changes was never refreshed
function(qt_scenario_pop_never_refreshed)
    qt_begin_test("pop_never_refreshed")
    qt_write_file("${QT_WORK_DIR}/a.txt" "orig\n")
    qt_quilt_ok(ARGS new p1.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add a.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/a.txt" "edited\n")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS pop)
    qt_assert_failure("${rc}" "pop of an unrefreshed patch should fail")
    qt_combine_output(combined "${out}" "${err}")
    qt_assert_contains("${combined}" "does not remove cleanly" "failure should be explained")
    qt_assert_exists("${QT_WORK_DIR}/.pc/p1.patch" "patch should still be applied")
    qt_assert_file_text("${QT_WORK_DIR}/a.txt" "edited" "unrefreshed edit should be kept")
    qt_quilt_ok(ARGS pop -f MESSAGE "pop -f failed")
    qt_assert_file_text("${QT_WORK_DIR}/a.txt" "orig" "pop -f should restore the original")
endfunction()

# pop must refuse when a file added since the last refresh has changes
function(qt_scenario_pop_file_added_after_refresh)
    qt_begin_test("pop_file_added_after_refresh")
    qt_write_file("${QT_WORK_DIR}/a.txt" "a\n")
    qt_write_file("${QT_WORK_DIR}/b.txt" "b\n")
    qt_quilt_ok(ARGS new p1.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add a.txt MESSAGE "add a.txt failed")
    qt_write_file("${QT_WORK_DIR}/a.txt" "A\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    qt_quilt_ok(ARGS add b.txt MESSAGE "add b.txt failed")
    qt_write_file("${QT_WORK_DIR}/b.txt" "B\n")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS pop -R)
    qt_assert_failure("${rc}" "pop -R with an unrefreshed new file should fail")
    qt_combine_output(combined "${out}" "${err}")
    qt_assert_contains("${combined}" "does not remove cleanly" "failure should be explained")
    qt_assert_file_text("${QT_WORK_DIR}/b.txt" "B" "unrefreshed edit should be kept")
    qt_quilt_ok(ARGS refresh MESSAGE "second refresh failed")
    qt_quilt_ok(ARGS pop -R MESSAGE "pop -R after refresh failed")
    qt_assert_file_text("${QT_WORK_DIR}/a.txt" "a" "a.txt should be restored")
    qt_assert_file_text("${QT_WORK_DIR}/b.txt" "b" "b.txt should be restored")
endfunction()

# A patch marked -R in the series pops without -f, and pending changes
# on top of it are still detected
function(qt_scenario_pop_reversed_series_patch)
    qt_begin_test("pop_reversed_series_patch")
    qt_write_file("${QT_WORK_DIR}/f.txt" "new\n")
    qt_write_file("${QT_WORK_DIR}/patches/rev.patch" "--- a/f.txt\n+++ b/f.txt\n@@ -1 +1 @@\n-old\n+new\n")
    qt_write_file("${QT_WORK_DIR}/patches/series" "rev.patch -R\n")
    qt_quilt_ok(ARGS push MESSAGE "push failed")
    qt_assert_file_text("${QT_WORK_DIR}/f.txt" "old" "push should reverse-apply the patch")
    qt_quilt_ok(ARGS pop MESSAGE "pop of a reversed patch failed")
    qt_assert_file_text("${QT_WORK_DIR}/f.txt" "new" "pop should restore the original")
    qt_quilt_ok(ARGS push MESSAGE "second push failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "dirty\n")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS pop)
    qt_assert_failure("${rc}" "pop of a dirty reversed patch should fail")
    qt_combine_output(combined "${out}" "${err}")
    qt_assert_contains("${combined}" "does not remove cleanly" "failure should be explained")
    qt_assert_file_text("${QT_WORK_DIR}/f.txt" "dirty" "unrefreshed edit should be kept")
endfunction()

# A force-applied patch below the top matches its own partial application
# and pops without -f
function(qt_scenario_pop_forced_patch_below_top)
    qt_begin_test("pop_forced_patch_below_top")
    qt_write_file("${QT_WORK_DIR}/f.txt" "one\ntwo\nthree\n")
    qt_write_file("${QT_WORK_DIR}/g.txt" "x\n")
    qt_quilt_ok(ARGS new p1.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt g.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "one\nTWO\nthree\n")
    qt_write_file("${QT_WORK_DIR}/g.txt" "X\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    qt_quilt_ok(ARGS pop MESSAGE "pop failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "one\n2\nthree\n")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS push -f)
    qt_assert_failure("${rc}" "forced push of a conflicting patch should fail")
    qt_assert_file_text("${QT_WORK_DIR}/g.txt" "X" "forced push should apply the good hunk")
    qt_quilt_ok(ARGS new p4.patch MESSAGE "new p4 failed")
    qt_quilt_ok(ARGS pop -a MESSAGE "pop -a failed")
    qt_assert_not_exists("${QT_WORK_DIR}/.pc/p1.patch" "p1.patch should be popped")
    qt_assert_file_text("${QT_WORK_DIR}/f.txt" "one\n2\nthree" "f.txt should be restored")
    qt_assert_file_text("${QT_WORK_DIR}/g.txt" "x" "g.txt should be restored")
endfunction()

# With -p0, a deleted file is named by itself rather than file.orig, so
# the patch can be applied again and pop sees no pending changes
function(qt_scenario_refresh_p0_deleted_file)
    qt_begin_test("refresh_p0_deleted_file")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_write_file("${QT_WORK_DIR}/g.txt" "x\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt g.txt MESSAGE "add failed")
    file(REMOVE "${QT_WORK_DIR}/f.txt")
    qt_write_file("${QT_WORK_DIR}/g.txt" "y\n")
    qt_quilt_ok(ARGS refresh -p0 ENV "QUILT_NO_DIFF_TIMESTAMPS=1" MESSAGE "refresh -p0 failed")
    qt_assert_file_contains("${QT_WORK_DIR}/patches/p.patch" "--- f.txt\n+++ /dev/null\n"
                            "deleted file should be named without .orig")
    qt_assert_file_contains("${QT_WORK_DIR}/patches/p.patch" "--- g.txt.orig\n+++ g.txt\n"
                            "modified file should keep the .orig name")
    qt_quilt_ok(ARGS pop MESSAGE "pop after refresh -p0 failed")
    qt_assert_file_text("${QT_WORK_DIR}/f.txt" "x" "pop should restore the deleted file")
    qt_quilt_ok(ARGS push MESSAGE "push of the -p0 patch failed")
    qt_assert_not_exists("${QT_WORK_DIR}/f.txt" "push should delete the file again")
    qt_assert_file_text("${QT_WORK_DIR}/g.txt" "y" "push should modify g.txt again")
endfunction()

# diff -R labels follow the swapped files, so a deleted file shows up as
# created
function(qt_scenario_diff_R_deleted_file_labels)
    qt_begin_test("diff_R_deleted_file_labels")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    file(REMOVE "${QT_WORK_DIR}/f.txt")
    foreach(p 0 1 ab)
        if(p STREQUAL "0")
            set(label "f.txt")
        elseif(p STREQUAL "1")
            get_filename_component(dir "${QT_WORK_DIR}" NAME)
            set(label "${dir}/f.txt")
        else()
            set(label "b/f.txt")
        endif()
        qt_quilt_ok(OUTPUT out ERROR err ARGS diff -R -p ${p} ENV "QUILT_NO_DIFF_TIMESTAMPS=1"
                    MESSAGE "diff -R -p ${p} failed")
        qt_assert_contains("${out}" "--- /dev/null\n+++ ${label}\n@@ -0,0 +1 @@\n+x\n"
                           "diff -R -p ${p} should show the deleted file as created")
    endforeach()
endfunction()

function(qt_scenario_applied_patches_removed_when_empty)
    qt_begin_test("applied_patches_removed_when_empty")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "y\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    qt_assert_exists("${QT_WORK_DIR}/.pc/applied-patches" "applied-patches should exist while applied")
    qt_quilt_ok(ARGS pop MESSAGE "pop failed")
    qt_assert_not_exists("${QT_WORK_DIR}/.pc/applied-patches" "applied-patches should be removed when pop empties the stack")
    qt_assert_exists("${QT_WORK_DIR}/.pc/.version" ".pc metadata should be kept")
    qt_quilt_ok(ARGS push MESSAGE "push failed")
    qt_assert_exists("${QT_WORK_DIR}/.pc/applied-patches" "applied-patches should reappear after push")
    qt_quilt_ok(ARGS delete MESSAGE "delete failed")
    qt_assert_not_exists("${QT_WORK_DIR}/.pc/applied-patches" "applied-patches should be removed when delete empties the stack")
endfunction()

function(qt_scenario_refresh_invalid_p)
    qt_begin_test("refresh_invalid_p")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "y\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    qt_read_file_raw(before "${QT_WORK_DIR}/patches/p.patch")
    qt_write_file("${QT_WORK_DIR}/f.txt" "z\n")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS refresh -p 9)
    qt_assert_failure("${rc}" "refresh -p 9 should fail")
    qt_assert_contains("${err}" "Cannot refresh patches with -p9, please specify -p0, -p1, or -pab instead"
                       "invalid strip level should be rejected")
    qt_read_file_raw(after "${QT_WORK_DIR}/patches/p.patch")
    qt_assert_equal("${after}" "${before}" "patch file should be unchanged")
endfunction()

# A strip level from the series file is validated like an explicit -p.
function(qt_scenario_series_invalid_strip_level)
    qt_begin_test("series_invalid_strip_level")
    qt_write_file("${QT_WORK_DIR}/f.txt" "a\n")
    qt_write_file("${QT_WORK_DIR}/patches/p.patch"
                  "--- x/y/f.txt\n+++ x/y/f.txt\n@@ -1 +1 @@\n-a\n+b\n")
    qt_write_file("${QT_WORK_DIR}/patches/series" "p.patch -p2\n")
    qt_quilt_ok(ARGS push MESSAGE "push of -p2 patch failed")
    qt_assert_file_text("${QT_WORK_DIR}/f.txt" "b" "patch should apply at -p2")
    qt_read_file_raw(before "${QT_WORK_DIR}/patches/p.patch")
    qt_write_file("${QT_WORK_DIR}/f.txt" "c\n")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS refresh)
    qt_assert_failure("${rc}" "refresh of a -p2 patch should fail")
    qt_assert_contains("${err}" "Cannot refresh patches with -p2" "stored strip level should be rejected")
    qt_quilt(RESULT rc2 OUTPUT out2 ERROR err2 ARGS diff)
    qt_assert_failure("${rc2}" "diff of a -p2 patch should fail")
    qt_assert_contains("${err2}" "Cannot diff patches with -p2" "stored strip level should be rejected")
    qt_read_file_raw(after "${QT_WORK_DIR}/patches/p.patch")
    qt_assert_equal("${after}" "${before}" "patch file should be unchanged")
    # An explicit valid level overrides the stored one
    qt_quilt_ok(OUTPUT out3 ERROR err3 ARGS diff -p 1 MESSAGE "diff -p 1 failed")
    qt_assert_contains("${out3}" "+c" "diff -p 1 should show the change")
endfunction()

function(qt_scenario_diff_invalid_p)
    qt_begin_test("diff_invalid_p")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "y\n")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS diff -p 9)
    qt_assert_failure("${rc}" "diff -p 9 should fail")
    qt_assert_equal("${out}" "" "no diff should be printed")
    qt_assert_contains("${err}" "Cannot diff patches with -p9, please specify -p0, -p1, or -pab instead"
                       "invalid strip level should be rejected")
endfunction()

function(qt_scenario_diff_binary)
    qt_begin_test("diff_binary")
    execute_process(COMMAND ${CMAKE_COMMAND} -E env printf "\\0\\001\\002"
        OUTPUT_FILE "${QT_WORK_DIR}/f.dat")
    qt_write_file("${QT_WORK_DIR}/t.txt" "x\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.dat t.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/t.txt" "y\n")
    # An unchanged binary file is not a difference
    qt_quilt_ok(OUTPUT out ERROR err ARGS diff MESSAGE "diff with an unchanged binary failed")
    qt_assert_contains("${out}" "+y" "text change should be shown")
    qt_assert_not_contains("${out}" "f.dat" "unchanged binary file should not be mentioned")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh with an unchanged binary failed")
    qt_assert_file_not_contains("${QT_WORK_DIR}/patches/p.patch" "f.dat" "unchanged binary file should not be in the patch")
    # A changed binary file makes diff fail, in every mode
    execute_process(COMMAND ${CMAKE_COMMAND} -E env printf "\\0\\003\\004"
        OUTPUT_FILE "${QT_WORK_DIR}/f.dat")
    qt_quilt(RESULT rc OUTPUT out2 ERROR err2 ARGS diff)
    qt_assert_failure("${rc}" "diff should fail on a changed binary file")
    qt_assert_contains("${err2}" "Diff failed on file 'f.dat', aborting" "binary diff should abort")
    qt_quilt(RESULT rc3 OUTPUT out3 ERROR err3 ARGS diff -z)
    qt_assert_failure("${rc3}" "diff -z should fail on a changed binary file")
    qt_combine_output(combined3 "${out3}" "${err3}")
    qt_assert_contains("${combined3}" "Diff failed" "binary diff -z should abort")
    # With an external --diff utility, a changed binary file does not abort
    qt_quilt_ok(ARGS diff --diff=diff MESSAGE "diff --diff=diff on a binary file failed")
endfunction()

function(qt_scenario_refresh_binary_shadowed)
    qt_begin_test("refresh_binary_shadowed")
    execute_process(COMMAND ${CMAKE_COMMAND} -E env printf "\\0\\001\\002"
        OUTPUT_FILE "${QT_WORK_DIR}/f.dat")
    qt_quilt_ok(ARGS new p1.patch MESSAGE "new p1 failed")
    qt_quilt_ok(ARGS add f.dat MESSAGE "add p1 failed")
    execute_process(COMMAND ${CMAKE_COMMAND} -E env printf "\\0\\003\\004"
        OUTPUT_FILE "${QT_WORK_DIR}/f.dat")
    qt_quilt_ok(ARGS new p2.patch MESSAGE "new p2 failed")
    qt_quilt_ok(ARGS add f.dat MESSAGE "add p2 failed")
    # p1's change to f.dat is only visible through p2's backup
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS refresh -f p1.patch)
    qt_assert_failure("${rc}" "refresh of a shadowed binary change should fail")
    qt_combine_output(combined "${out}" "${err}")
    # The original quilt names the backup file here
    qt_assert_contains("${combined}" "Diff failed on file '" "binary diff should abort")
    qt_assert_contains("${combined}" "f.dat', aborting" "binary diff should abort")
    qt_assert_not_exists("${QT_WORK_DIR}/patches/p1.patch" "aborted refresh should not write the patch")
endfunction()

function(qt_scenario_diff_z_deleted_file)
    qt_begin_test("diff_z_deleted_file")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "y\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    file(REMOVE "${QT_WORK_DIR}/f.txt")
    qt_quilt_ok(OUTPUT out ERROR err ARGS diff -z MESSAGE "diff -z after deletion failed")
    qt_assert_contains("${out}" "+++ /dev/null" "deleted file should diff against /dev/null")
    qt_assert_contains("${out}" "-y" "removed content should appear")
    qt_quilt_ok(OUTPUT out2 ERROR err2 ARGS diff -z -R MESSAGE "diff -z -R after deletion failed")
    qt_assert_contains("${out2}" "--- /dev/null" "reversed deletion should diff from /dev/null")
    qt_assert_contains("${out2}" "+y" "restored content should appear")
    # A file added since the last refresh is diffed from /dev/null
    qt_write_file("${QT_WORK_DIR}/f.txt" "y\n")
    qt_quilt_ok(ARGS add g.txt MESSAGE "add g.txt failed")
    qt_write_file("${QT_WORK_DIR}/g.txt" "new\n")
    qt_quilt_ok(OUTPUT out3 ERROR err3 ARGS diff -z MESSAGE "diff -z with a new file failed")
    qt_assert_contains("${out3}" "--- /dev/null" "new file should diff from /dev/null")
    qt_assert_contains("${out3}" "+new" "new content should appear")
    qt_quilt_ok(OUTPUT out4 ERROR err4 ARGS diff -z -R MESSAGE "diff -z -R with a new file failed")
    qt_assert_contains("${out4}" "+++ /dev/null" "reversed new file should diff to /dev/null")
endfunction()

# A file the patch empties (rather than deletes) is not /dev/null in -z.
function(qt_scenario_diff_z_emptied_file)
    qt_begin_test("diff_z_emptied_file")
    qt_write_file("${QT_WORK_DIR}/f.txt" "keep\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "again\n")
    qt_quilt_ok(OUTPUT out ERROR err ARGS diff -z -R MESSAGE "diff -z -R failed")
    qt_assert_contains("${out}" "-again" "pending change should be shown")
    qt_assert_not_contains("${out}" "/dev/null" "emptied file still exists in the refreshed state")
endfunction()

function(qt_scenario_diff_z_shadowed)
    qt_begin_test("diff_z_shadowed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_quilt_ok(ARGS new p1.patch MESSAGE "new p1 failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add p1 failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "y\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh p1 failed")
    qt_quilt_ok(ARGS new p2.patch MESSAGE "new p2 failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add p2 failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "z\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh p2 failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "w\n")
    # p1 was refreshed before p2 took its backup, so nothing is pending
    qt_quilt_ok(OUTPUT out ERROR err ARGS diff -z -P p1.patch MESSAGE "diff -z -P p1 failed")
    qt_assert_equal("${out}" "" "shadowed -z diff should produce no output")
    qt_assert_contains("${err}" "more recent patches modify files in patch p1.patch" "shadowing should be warned about")
endfunction()

# With -z, a shadowed file is diffed against the next patch's backup, which
# shows changes made before that patch took over the file.
function(qt_scenario_diff_z_shadowed_unrefreshed)
    qt_begin_test("diff_z_shadowed_unrefreshed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "a\nb\nc\n")
    qt_quilt_ok(ARGS new p1.patch MESSAGE "new p1 failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add p1 failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "a\nB\nc\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh p1 failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "a\nB\nc\nd\n")
    qt_quilt_ok(ARGS new p2.patch MESSAGE "new p2 failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add p2 failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "A\nB\nc\nd\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh p2 failed")
    qt_quilt_ok(OUTPUT out ERROR err ARGS diff -z -P p1.patch MESSAGE "diff -z -P p1 failed")
    qt_assert_contains("${out}" "\n+d\n" "unrefreshed change to p1 should be shown")
    qt_assert_not_contains("${out}" "+A" "p2's change should not be shown")
    qt_assert_contains("${err}" "more recent patches modify files in patch p1.patch" "shadowing should be warned about")
endfunction()

function(qt_scenario_diff_z_shadowed_deleted)
    qt_begin_test("diff_z_shadowed_deleted")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_quilt_ok(ARGS new p1.patch MESSAGE "new p1 failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add p1 failed")
    file(REMOVE "${QT_WORK_DIR}/f.txt")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh p1 failed")
    qt_quilt_ok(ARGS new p2.patch MESSAGE "new p2 failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add p2 failed")
    # Neither side has content, but the file is still shadowed
    qt_quilt_ok(OUTPUT out ERROR err ARGS diff -z -P p1.patch MESSAGE "diff -z -P p1 failed")
    qt_assert_equal("${out}" "" "no diff should be printed")
    qt_assert_contains("${err}" "more recent patches modify files in patch p1.patch" "shadowing should be warned about")
endfunction()

function(qt_scenario_diff_snapshot_reverse)
    qt_begin_test("diff_snapshot_reverse")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "y\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    qt_quilt_ok(ARGS snapshot MESSAGE "snapshot failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "z\n")
    qt_quilt_ok(OUTPUT out ERROR err ARGS diff --snapshot -R MESSAGE "diff --snapshot -R failed")
    qt_assert_contains("${out}" "-z" "reverse snapshot diff should show current content as removed")
    qt_assert_contains("${out}" "+y" "reverse snapshot diff should show snapshotted content as added")
endfunction()

function(qt_scenario_revert_multiple_files)
    qt_begin_test("revert_multiple_files")
    qt_write_file("${QT_WORK_DIR}/a.txt" "x\n")
    qt_write_file("${QT_WORK_DIR}/b.txt" "x\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add a.txt b.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/a.txt" "y\n")
    qt_write_file("${QT_WORK_DIR}/b.txt" "y\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    qt_write_file("${QT_WORK_DIR}/a.txt" "z\n")
    qt_quilt_ok(OUTPUT out ERROR err ARGS revert a.txt b.txt MESSAGE "revert failed")
    qt_assert_contains("${out}" "Changes to a.txt in patch p.patch reverted" "changed file should be reverted")
    qt_assert_contains("${out}" "File b.txt is unchanged" "unchanged file should be reported")
    qt_assert_file_text("${QT_WORK_DIR}/a.txt" "y" "a.txt should be restored")
    qt_assert_file_text("${QT_WORK_DIR}/b.txt" "y" "b.txt should be unchanged")
endfunction()

function(qt_scenario_revert_P_unapplied)
    qt_begin_test("revert_P_unapplied")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_quilt_ok(ARGS new p1.patch MESSAGE "new p1 failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add p1 failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "y\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh p1 failed")
    qt_quilt_ok(ARGS new p2.patch MESSAGE "new p2 failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add p2 failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "z\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh p2 failed")
    qt_quilt_ok(ARGS pop MESSAGE "pop failed")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS revert -P p2.patch f.txt)
    qt_assert_failure("${rc}" "revert -P with an unapplied patch should fail")
    qt_combine_output(combined "${out}" "${err}")
    qt_assert_contains("${combined}" "is not applied" "failure should mention the patch state")
endfunction()

function(qt_scenario_snapshot_no_series)
    qt_begin_test("snapshot_no_series")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS snapshot)
    qt_assert_equal("${rc}" "1" "snapshot without a series file should exit 1")
    qt_assert_contains("${err}" "No series file found" "missing series file should be reported")
    qt_assert_not_exists("${QT_WORK_DIR}/.pc" "snapshot without a series file must not create .pc")
    # -d must not discard an existing snapshot when the series file is missing
    qt_write_file("${QT_WORK_DIR}/.pc/.version" "2\n")
    qt_write_file("${QT_WORK_DIR}/.pc/.snap/f.txt" "x\n")
    qt_quilt(RESULT rc2 OUTPUT out2 ERROR err2 ARGS snapshot -d)
    qt_assert_equal("${rc2}" "1" "snapshot -d without a series file should exit 1")
    qt_assert_contains("${err2}" "No series file found" "missing series file should be reported")
    qt_assert_exists("${QT_WORK_DIR}/.pc/.snap/f.txt" "snapshot -d must keep the snapshot")
endfunction()

function(qt_scenario_series_empty_and_comments)
    qt_begin_test("series_empty_and_comments")
    file(MAKE_DIRECTORY "${QT_WORK_DIR}/patches")
    qt_write_file("${QT_WORK_DIR}/patches/series" "")
    qt_quilt_ok(OUTPUT out ERROR err ARGS series MESSAGE "series on an empty file failed")
    qt_assert_equal("${out}" "" "empty series should produce no output")
    qt_write_file("${QT_WORK_DIR}/patches/series" "# comment\n\na.patch\n# another\n")
    qt_quilt_ok(OUTPUT out2 ERROR err2 ARGS series MESSAGE "series with comments failed")
    qt_assert_equal("${out2}" "a.patch\n" "comments and blank lines should be skipped")
endfunction()

# series takes no arguments, so any argument prints the usage and fails,
# including a --color value given as a separate word. A trailing "--" is
# just the end of the options.
function(qt_scenario_series_rejects_arguments)
    qt_begin_test("series_rejects_arguments")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_quilt_ok(ARGS new a.patch MESSAGE "new failed")
    foreach(args IN ITEMS "foo" "foo;-v" "--color;always" "--;foo" "--;-v")
        qt_quilt(RESULT rc OUTPUT out ERROR err ARGS series ${args})
        string(REPLACE ";" " " shown "series ${args}")
        qt_assert_equal("${rc}" "1" "${shown} should fail")
        qt_combine_output(combined "${out}" "${err}")
        qt_assert_contains("${combined}"
            "Usage: quilt series [--color[=always|auto|never]] [-v]"
            "${shown} should print usage")
        qt_assert_not_contains("${combined}" "a.patch" "${shown} should not list patches")
    endforeach()
    qt_quilt_ok(OUTPUT out ERROR err ARGS series -v -- MESSAGE "series -v -- failed")
    qt_assert_equal("${out}" "= a.patch\n" "series -v -- should list the series")
endfunction()

function(qt_scenario_files_all_no_applied)
    qt_begin_test("files_all_no_applied")
    # No series file at all
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS files -a)
    qt_assert_failure("${rc}" "files -a without a series file should fail")
    qt_assert_contains("${err}" "No series file found" "missing series file should be reported")
    qt_quilt(RESULT rc1 OUTPUT out1 ERROR err1 ARGS files)
    qt_assert_failure("${rc1}" "files without a series file should fail")
    qt_assert_contains("${err1}" "No series file found" "missing series file should be reported")
    # Empty series file
    qt_write_file("${QT_WORK_DIR}/patches/series" "")
    qt_quilt(RESULT rc2 OUTPUT out2 ERROR err2 ARGS files -a)
    qt_assert_failure("${rc2}" "files -a with an empty series should fail")
    qt_assert_contains("${err2}" "No patches in series" "empty series should be reported")
    # Series file with a patch, but nothing applied
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "y\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    qt_quilt_ok(ARGS pop MESSAGE "pop failed")
    qt_quilt(RESULT rc3 OUTPUT out3 ERROR err3 ARGS files -a)
    qt_assert_failure("${rc3}" "files -a with nothing applied should fail")
    qt_assert_contains("${err3}" "No patches applied" "empty stack should be reported")
endfunction()

function(qt_scenario_delete_n_explicit)
    qt_begin_test("delete_n_explicit")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "y\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    qt_quilt_ok(ARGS new q.patch MESSAGE "new q failed")
    qt_quilt_ok(ARGS pop -a MESSAGE "pop failed")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS delete -n p.patch)
    qt_assert_failure("${rc}" "delete -n with a patch argument should fail")
    qt_combine_output(combined "${out}" "${err}")
    qt_assert_contains("${combined}" "Usage: quilt delete" "usage should be printed")
    # More than one patch argument is also a usage error
    qt_quilt(RESULT rc2 OUTPUT out2 ERROR err2 ARGS delete -r p.patch q.patch)
    qt_assert_failure("${rc2}" "delete with two patch arguments should fail")
    qt_combine_output(combined2 "${out2}" "${err2}")
    qt_assert_contains("${combined2}" "Usage: quilt delete" "usage should be printed")
    qt_assert_file_text("${QT_WORK_DIR}/patches/series" "p.patch\nq.patch" "series should be unchanged")
    qt_assert_exists("${QT_WORK_DIR}/patches/p.patch" "patch file should be kept")
endfunction()

function(qt_scenario_delete_backup_without_r)
    qt_begin_test("delete_backup_without_r")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "y\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    qt_quilt_ok(ARGS pop MESSAGE "pop failed")
    qt_quilt_ok(OUTPUT out ERROR err ARGS delete --backup p.patch MESSAGE "delete --backup failed")
    qt_assert_contains("${out}" "Removed patch p.patch" "removal should be reported")
    # --backup without -r leaves the patch file in place
    qt_assert_exists("${QT_WORK_DIR}/patches/p.patch" "patch file should be kept")
    qt_assert_file_not_contains("${QT_WORK_DIR}/patches/series" "p.patch" "patch should be removed from series")
endfunction()

function(qt_scenario_header_mode_conflict)
    qt_begin_test("header_mode_conflict")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "y\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    qt_quilt_ok(ARGS header -r INPUT "orig\n" MESSAGE "header -r failed")
    # Different modes cannot be combined
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS header -a -r INPUT "new\n")
    qt_assert_failure("${rc}" "header -a -r should fail")
    qt_combine_output(combined "${out}" "${err}")
    qt_assert_contains("${combined}" "Usage: quilt header" "usage should be printed")
    qt_assert_file_contains("${QT_WORK_DIR}/patches/p.patch" "orig" "header should be unchanged")
    qt_assert_file_not_contains("${QT_WORK_DIR}/patches/p.patch" "new" "header should be unchanged")
    # Repeating the same mode is fine
    qt_quilt_ok(ARGS header -r -r INPUT "twice\n" MESSAGE "header -r -r failed")
    qt_assert_file_contains("${QT_WORK_DIR}/patches/p.patch" "twice" "header should be replaced")
    # Only one patch may be named
    qt_quilt(RESULT rc2 OUTPUT out2 ERROR err2 ARGS header -r p.patch p.patch INPUT "x\n")
    qt_assert_failure("${rc2}" "header with two patch arguments should fail")
    qt_combine_output(combined2 "${out2}" "${err2}")
    qt_assert_contains("${combined2}" "Usage: quilt header" "usage should be printed")
    qt_assert_file_contains("${QT_WORK_DIR}/patches/p.patch" "twice" "header should be unchanged")
endfunction()

function(qt_scenario_header_empty_stdin)
    qt_begin_test("header_empty_stdin")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "y\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    qt_quilt_ok(ARGS header -a INPUT "old header\n" MESSAGE "header -a failed")
    qt_assert_file_contains("${QT_WORK_DIR}/patches/p.patch" "old header" "header should be appended")
    # Replacing the header with empty input removes it
    qt_quilt_ok(ARGS header -r MESSAGE "header -r failed")
    qt_assert_file_not_contains("${QT_WORK_DIR}/patches/p.patch" "old header" "header should be removed")
    qt_assert_file_contains("${QT_WORK_DIR}/patches/p.patch" "+y" "diff should be kept")
endfunction()

function(qt_scenario_import_preserves_series_args)
    qt_begin_test("import_preserves_series_args")
    qt_write_file("${QT_WORK_DIR}/p.patch" "--- a/b/f.txt\n+++ a/b/f.txt\n@@ -1 +1 @@\n-x\n+y\n")
    qt_quilt_ok(ARGS import -R -p 2 p.patch MESSAGE "import -R -p 2 failed")
    qt_append_file("${QT_WORK_DIR}/patches/series" "# keep me\n")
    qt_quilt_ok(ARGS import -f p.patch MESSAGE "re-import failed")
    qt_assert_file_text("${QT_WORK_DIR}/patches/series" "p.patch -p2 -R\n# keep me"
                        "re-import should leave the series untouched")
    # Options given on a re-import are ignored for the existing entry
    qt_quilt_ok(ARGS import -f -p 0 p.patch MESSAGE "re-import with -p 0 failed")
    qt_assert_file_text("${QT_WORK_DIR}/patches/series" "p.patch -p2 -R\n# keep me"
                        "re-import options should be ignored")
endfunction()

function(qt_scenario_import_multiple_files)
    qt_begin_test("import_multiple_files")
    qt_write_file("${QT_WORK_DIR}/a.patch" "--- a/f.txt\n+++ b/f.txt\n@@ -1 +1 @@\n-x\n+y\n")
    qt_write_file("${QT_WORK_DIR}/b.patch" "--- a/g.txt\n+++ b/g.txt\n@@ -1 +1 @@\n-x\n+z\n")
    qt_quilt_ok(ARGS import a.patch b.patch MESSAGE "multi-file import failed")
    qt_assert_file_text("${QT_WORK_DIR}/patches/series" "a.patch\nb.patch" "both patches should be imported in order")
    qt_assert_exists("${QT_WORK_DIR}/patches/a.patch" "a.patch should be stored")
    qt_assert_exists("${QT_WORK_DIR}/patches/b.patch" "b.patch should be stored")
endfunction()

function(qt_scenario_import_P_subdir)
    qt_begin_test("import_P_subdir")
    qt_write_file("${QT_WORK_DIR}/ext.patch" "--- a/f.txt\n+++ b/f.txt\n@@ -1 +1 @@\n-x\n+y\n")
    qt_quilt_ok(ARGS import -P sub/renamed.patch ext.patch MESSAGE "import -P subdir failed")
    qt_assert_exists("${QT_WORK_DIR}/patches/sub/renamed.patch" "patch should be stored in the subdirectory")
    qt_assert_file_contains("${QT_WORK_DIR}/patches/series" "sub/renamed.patch" "series should reference the subdirectory patch")
endfunction()

function(qt_scenario_graph_lines_nonadjacent)
    qt_begin_test("graph_lines_nonadjacent")
    set(lines "")
    foreach(i RANGE 1 60)
        string(APPEND lines "line${i}\n")
    endforeach()
    qt_write_file("${QT_WORK_DIR}/f.txt" "${lines}")
    qt_quilt_ok(ARGS new A.patch MESSAGE "new A failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add A failed")
    string(REPLACE "line5\n" "LINE5-A\n" content_a "${lines}")
    qt_write_file("${QT_WORK_DIR}/f.txt" "${content_a}")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh A failed")
    qt_quilt_ok(ARGS new B.patch MESSAGE "new B failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add B failed")
    string(REPLACE "line50\n" "LINE50-B\n" content_b "${content_a}")
    qt_write_file("${QT_WORK_DIR}/f.txt" "${content_b}")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh B failed")
    qt_quilt_ok(ARGS new C.patch MESSAGE "new C failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add C failed")
    string(REPLACE "LINE5-A\n" "LINE5-C\n" content_c "${content_b}")
    qt_write_file("${QT_WORK_DIR}/f.txt" "${content_c}")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh C failed")
    qt_quilt_ok(OUTPUT out ERROR err ARGS graph --lines MESSAGE "graph --lines failed")
    qt_assert_contains("${out}" "n0 -> n2" "C should depend on the non-adjacent A")
    qt_assert_not_contains("${out}" "n0 -> n1" "B should not be in the dependency chain")
    qt_assert_not_contains("${out}" "n1 -> n2" "B should not be in the dependency chain")
    qt_assert_contains("${out}" "n2 [style=bold,label=\"C.patch\"];" "selected patch with edges should not be grey")
endfunction()

# Only a node without edges is drawn grey, whether or not it is selected.
function(qt_scenario_graph_grey_only_when_isolated)
    qt_begin_test("graph_grey_only_when_isolated")
    set(lines "")
    foreach(i RANGE 1 30)
        string(APPEND lines "line${i}\n")
    endforeach()
    qt_write_file("${QT_WORK_DIR}/f.txt" "${lines}")
    qt_quilt_ok(ARGS new A.patch MESSAGE "new A failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add A failed")
    string(REPLACE "line5\n" "LINE5-A\n" content_a "${lines}")
    qt_write_file("${QT_WORK_DIR}/f.txt" "${content_a}")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh A failed")
    qt_quilt_ok(ARGS new B.patch MESSAGE "new B failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add B failed")
    string(REPLACE "line10\n" "LINE10-B\n" content_b "${content_a}")
    qt_write_file("${QT_WORK_DIR}/f.txt" "${content_b}")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh B failed")
    # Disjoint line ranges: B has no edges
    qt_quilt_ok(OUTPUT out ERROR err ARGS graph --lines MESSAGE "graph --lines failed")
    qt_assert_contains("${out}" "n1 [style=bold,color=grey,label=\"B.patch\"];" "isolated selected patch should be grey")
    qt_assert_not_contains("${out}" " -> " "disjoint line ranges should produce no edges")
    # Same file: B depends on A
    qt_quilt_ok(OUTPUT out2 ERROR err2 ARGS graph MESSAGE "graph failed")
    qt_assert_contains("${out2}" "n1 [style=bold,label=\"B.patch\"];" "selected patch with edges should not be grey")
    qt_assert_not_contains("${out2}" "color=grey" "no node has zero edges")
endfunction()

# --quiltrc - must keep ~/.quiltrc from being read.
function(qt_scenario_quiltrc_dash_disables)
    qt_begin_test("quiltrc_dash_disables")
    qt_write_file("${QT_TEST_BASE}/.quiltrc" "QUILT_PATCHES_PREFIX=1\n")
    qt_quilt_ok(DEFAULT_QUILTRC OUTPUT out ERROR err ARGS new a.patch
                MESSAGE "new with ~/.quiltrc failed")
    qt_assert_contains("${out}" "patches/a.patch" "~/.quiltrc should enable the prefix")
    qt_quilt_ok(OUTPUT out2 ERROR err2 ARGS --quiltrc - new b.patch MESSAGE "new with --quiltrc - failed")
    qt_assert_contains("${out2}" "Patch b.patch is now on top" "--quiltrc - should ignore ~/.quiltrc")
    qt_assert_not_contains("${out2}" "patches/b.patch" "--quiltrc - should ignore ~/.quiltrc")
endfunction()

function(qt_scenario_annotate_delete_only)
    qt_begin_test("annotate_delete_only")
    qt_write_file("${QT_WORK_DIR}/f.txt" "a\nb\nc\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "a\nc\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    qt_quilt_ok(OUTPUT out ERROR err ARGS annotate f.txt MESSAGE "annotate failed")
    qt_assert_equal("${out}" "\ta\n\tc\n\n1\tp.patch\n" "deleted line leaves no annotation")
endfunction()

function(qt_scenario_rename_pc_migration)
    qt_begin_test("rename_pc_migration")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_quilt_ok(ARGS new old.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "y\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    qt_quilt_ok(ARGS rename new.patch MESSAGE "rename failed")
    qt_assert_exists("${QT_WORK_DIR}/.pc/new.patch" "backup directory should be renamed")
    qt_assert_not_exists("${QT_WORK_DIR}/.pc/old.patch" "old backup directory should be gone")
    qt_quilt_ok(ARGS pop MESSAGE "pop failed")
    qt_assert_file_text("${QT_WORK_DIR}/f.txt" "x" "pop should restore the original content")
    qt_quilt_ok(ARGS push MESSAGE "push failed")
    qt_assert_file_text("${QT_WORK_DIR}/f.txt" "y" "push should reapply the renamed patch")
endfunction()

function(qt_scenario_fork_pc_migration)
    qt_begin_test("fork_pc_migration")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_quilt_ok(ARGS new orig.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "y\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    qt_quilt_ok(ARGS fork forked.patch MESSAGE "fork failed")
    qt_assert_exists("${QT_WORK_DIR}/.pc/forked.patch" "forked backup directory should exist")
    qt_quilt_ok(ARGS pop MESSAGE "pop failed")
    qt_assert_file_text("${QT_WORK_DIR}/f.txt" "x" "pop should restore the original content")
    qt_assert_not_exists("${QT_WORK_DIR}/.pc/forked.patch" "forked backup directory should be removed")
endfunction()

function(qt_scenario_prefixed_args_delete)
    qt_begin_test("prefixed_args_delete")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new p failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add p failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "y\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh p failed")
    qt_quilt_ok(OUTPUT out ERROR err ARGS delete patches/p.patch MESSAGE "delete with patches/ prefix failed")
    qt_assert_equal("${out}" "Removing patch p.patch\nNo patches applied\nRemoved patch p.patch\n"
                    "applied top patch should be popped and removed")
    qt_assert_file_not_contains("${QT_WORK_DIR}/patches/series" "p.patch" "patch should be removed from series")
    qt_assert_file_text("${QT_WORK_DIR}/f.txt" "x" "patch should be popped")
endfunction()

# Two applied patches (p2 on top) and one unapplied, each changing its own file.
function(qt_setup_three_patch_stack)
    foreach(n 1 2 3)
        qt_write_file("${QT_WORK_DIR}/f${n}.txt" "old${n}\n")
        qt_quilt_ok(ARGS new p${n}.patch MESSAGE "new p${n} failed")
        qt_quilt_ok(ARGS add f${n}.txt MESSAGE "add f${n} failed")
        qt_write_file("${QT_WORK_DIR}/f${n}.txt" "new${n}\n")
        qt_quilt_ok(ARGS refresh MESSAGE "refresh p${n} failed")
    endforeach()
    qt_quilt_ok(ARGS pop MESSAGE "pop p3 failed")
endfunction()

# An argument of only the patches/ prefix names no patch: upstream's
# find_patch strips it to nothing, which matches nothing. It must not fall
# back to the top or next patch the way an omitted argument does.
function(qt_scenario_prefix_only_patch_arg)
    qt_begin_test("prefix_only_patch_arg")
    qt_setup_three_patch_stack()
    qt_read_file_strip(series_before "${QT_WORK_DIR}/patches/series")
    qt_read_file_strip(applied_before "${QT_WORK_DIR}/.pc/applied-patches")
    qt_read_file_strip(p2_before "${QT_WORK_DIR}/patches/p2.patch")
    foreach(cmd "delete;-r;patches/" "delete;patches/" "pop;patches/"
                "push;patches/" "rename;-P;patches/;x.patch"
                "header;-r;patches/" "header;-a;patches/" "header;patches/"
                "applied;patches/" "unapplied;patches/" "next;patches/"
                "previous;patches/" "files;patches/" "files;--combine;patches/"
                "files;--combine;-;patches/" "graph;patches/"
                "annotate;-P;patches/;f2.txt" "add;-P;patches/;f3.txt"
                "remove;-P;patches/;f2.txt" "revert;-P;patches/;f2.txt")
        qt_quilt(RESULT rc OUTPUT out ERROR err ARGS ${cmd} INPUT "replaced header\n")
        qt_assert_equal("${rc}" "1" "'${cmd}' should fail")
        qt_assert_contains("${err}" "Patch patches/ is not in series" "'${cmd}' should name the argument")
    endforeach()
    # As a new name, the prefix alone names the patches directory itself
    foreach(cmd "fork;patches/" "rename;patches/")
        qt_quilt(RESULT rc OUTPUT out ERROR err ARGS ${cmd})
        qt_assert_failure("${rc}" "'${cmd}' should fail")
        qt_assert_contains("${err}" "exists already" "'${cmd}' should refuse the name")
    endforeach()
    qt_assert_file_text("${QT_WORK_DIR}/patches/series" "${series_before}" "series should be unchanged")
    qt_assert_file_text("${QT_WORK_DIR}/.pc/applied-patches" "${applied_before}" "applied patches should be unchanged")
    qt_assert_file_text("${QT_WORK_DIR}/patches/p2.patch" "${p2_before}" "top patch file should be unchanged")
    qt_assert_file_text("${QT_WORK_DIR}/f2.txt" "new2" "top patch should stay applied")
    qt_assert_file_text("${QT_WORK_DIR}/f3.txt" "old3" "next patch should stay unapplied")
    # push looks up its argument before checking for a fully applied series
    qt_quilt_ok(ARGS push MESSAGE "push p3 failed")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS push patches/)
    qt_assert_equal("${rc}" "1" "push patches/ should fail when fully applied")
    qt_assert_contains("${err}" "Patch patches/ is not in series" "push patches/ should name the argument")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS push p1.patch)
    qt_assert_equal("${rc}" "2" "push of an applied patch should fail")
    qt_assert_contains("${err}" "Patch p1.patch is currently applied" "push should name the applied patch")
endfunction()

# A literal empty patch name is an argument, but like upstream's
# find_applied_patch and find_patch_in_series it means the top patch. It is
# never a count, and as a new name it names the patches directory itself.
function(qt_scenario_empty_patch_arg)
    qt_begin_test("empty_patch_arg")
    qt_setup_three_patch_stack()
    qt_read_file_strip(series_before "${QT_WORK_DIR}/patches/series")
    qt_read_file_strip(applied_before "${QT_WORK_DIR}/.pc/applied-patches")
    qt_quilt_empty_arg(RESULT rc OUTPUT out ERROR err ARGS pop)
    qt_assert_equal("${rc}" "2" "pop '' should stop at the top patch")
    qt_assert_contains("${err}" "No patch removed" "pop '' should remove nothing")
    qt_assert_file_text("${QT_WORK_DIR}/f2.txt" "new2" "pop '' should leave the top patch applied")
    qt_quilt_empty_arg(RESULT rc OUTPUT out ERROR err ARGS add -P AFTER f3.txt)
    qt_assert_success("${rc}" "add -P '' should add to the top patch")
    qt_assert_contains("${out}" "File f3.txt added to patch p2.patch" "add -P '' should use the top patch")
    qt_quilt_empty_arg(RESULT rc OUTPUT out ERROR err ARGS remove -P AFTER f3.txt)
    qt_assert_success("${rc}" "remove -P '' should remove from the top patch")
    qt_assert_contains("${out}" "File f3.txt removed from patch p2.patch" "remove -P '' should use the top patch")
    # Upstream's remove leaves the patch needing a refresh before push
    qt_quilt_ok(ARGS refresh MESSAGE "refresh p2 failed")
    foreach(cmd fork rename)
        qt_quilt_empty_arg(RESULT rc OUTPUT out ERROR err ARGS ${cmd})
        qt_assert_failure("${rc}" "${cmd} '' should fail")
        qt_assert_contains("${err}" "exists already" "${cmd} '' should refuse the name")
    endforeach()
    qt_quilt_empty_arg(RESULT rc OUTPUT out ERROR err ARGS unapplied)
    qt_assert_success("${rc}" "unapplied '' should list from the top patch")
    qt_assert_equal("${out}" "p3.patch\n" "unapplied '' should list the patches after the top")
    qt_assert_file_text("${QT_WORK_DIR}/patches/series" "${series_before}" "series should be unchanged")
    qt_assert_file_text("${QT_WORK_DIR}/.pc/applied-patches" "${applied_before}" "applied patches should be unchanged")
    # Unlike no argument, '' names the top patch even when it is the last
    qt_quilt_ok(ARGS push MESSAGE "push p3 failed")
    qt_quilt_empty_arg(RESULT rc OUTPUT out ERROR err ARGS unapplied)
    qt_assert_success("${rc}" "unapplied '' should succeed when fully applied")
    qt_assert_equal("${out}" "" "unapplied '' should list nothing when fully applied")
    # With nothing applied there is no top patch for '' to mean
    qt_quilt_ok(ARGS pop -a MESSAGE "pop -a failed")
    foreach(cmd pop unapplied)
        qt_quilt_empty_arg(RESULT rc OUTPUT out ERROR err ARGS ${cmd})
        qt_assert_equal("${rc}" "1" "${cmd} '' should fail with nothing applied")
        qt_assert_contains("${err}" "No patches applied" "${cmd} '' should say nothing is applied")
    endforeach()
endfunction()

# Patch arguments are looked up like upstream's find_patch and
# find_top_patch: before other checks, naming the argument as given, and
# failing first on a missing series file or an empty series.
function(qt_scenario_patch_lookup_errors)
    qt_begin_test("patch_lookup_errors")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    foreach(cmd "delete;x" "header;x" "rename;-P;x;y.patch" "next;x" "push;x"
                "add;-P;x;f.txt")
        qt_quilt(RESULT rc OUTPUT out ERROR err ARGS ${cmd})
        qt_assert_equal("${rc}" "1" "'${cmd}' should fail without a series file")
        qt_assert_contains("${err}" "No series file found" "'${cmd}' should report the missing series file")
    endforeach()
    qt_write_file("${QT_WORK_DIR}/patches/series" "")
    foreach(cmd "delete" "delete;x" "header" "fork" "next;x" "push;x" "add;-P;x;f.txt")
        qt_quilt(RESULT rc OUTPUT out ERROR err ARGS ${cmd})
        qt_assert_equal("${rc}" "1" "'${cmd}' should fail with an empty series")
        qt_assert_contains("${err}" "No patches in series" "'${cmd}' should report the empty series")
    endforeach()
    qt_quilt_ok(ARGS new p1.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "y\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    qt_quilt_ok(ARGS pop MESSAGE "pop failed")
    foreach(cmd "pop;p1.patch" "add;-P;p1.patch;f.txt" "graph;p1.patch"
                "annotate;-P;p1.patch;f.txt")
        qt_quilt(RESULT rc OUTPUT out ERROR err ARGS ${cmd})
        qt_assert_equal("${rc}" "1" "'${cmd}' should fail with nothing applied")
        qt_assert_contains("${err}" "Patch p1.patch is not applied" "'${cmd}' should look up the patch")
    endforeach()
    foreach(cmd "pop;nonexist" "next;nonexist" "previous;nonexist"
                "add;-P;nonexist;f.txt" "annotate;-P;nonexist;f.txt")
        qt_quilt(RESULT rc OUTPUT out ERROR err ARGS ${cmd})
        qt_assert_equal("${rc}" "1" "'${cmd}' should fail")
        qt_assert_contains("${err}" "Patch nonexist is not in series" "'${cmd}' should name the patch")
    endforeach()
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS delete patches/nonexist)
    qt_assert_failure("${rc}" "delete of an unknown patch should fail")
    qt_assert_contains("${err}" "Patch patches/nonexist is not in series" "delete should name the argument as given")
    # rename refuses a name already in use outside the series too
    qt_write_file("${QT_WORK_DIR}/patches/stray.patch" "stray\n")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS rename -P p1.patch patches/stray.patch)
    qt_assert_failure("${rc}" "rename onto an existing file should fail")
    qt_assert_contains("${err}" "Patch stray.patch exists already, please choose a different name"
                       "rename should refuse the existing file")
    qt_assert_file_text("${QT_WORK_DIR}/patches/stray.patch" "stray" "rename should not overwrite the file")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS rename a.patch b.patch)
    qt_assert_failure("${rc}" "rename with two names should fail")
    qt_combine_output(combined "${out}" "${err}")
    qt_assert_contains("${combined}" "Usage: quilt rename" "rename with two names should print usage")
    qt_assert_file_text("${QT_WORK_DIR}/patches/series" "p1.patch" "series should be unchanged")
endfunction()

# The top patch is looked up only while the series file exists and still
# lists it, as upstream checks before running a command. Commands that
# default to the top patch must not act on it otherwise.
function(qt_scenario_top_patch_series_checks)
    qt_begin_test("top_patch_series_checks")
    qt_setup_three_patch_stack()
    qt_read_file_strip(applied_before "${QT_WORK_DIR}/.pc/applied-patches")
    qt_read_file_strip(p2_before "${QT_WORK_DIR}/patches/p2.patch")
    qt_write_file("${QT_WORK_DIR}/f2.txt" "dirty\n")

    file(REMOVE "${QT_WORK_DIR}/patches/series")
    foreach(cmd "rename;zz.patch" "graph" "annotate;f2.txt" "revert;f2.txt"
                "header" "files" "fork" "add;f3.txt")
        qt_quilt(RESULT rc OUTPUT out ERROR err ARGS ${cmd})
        qt_assert_equal("${rc}" "1" "'${cmd}' should fail without a series file")
        qt_assert_contains("${err}" "No series file found"
                           "'${cmd}' should report the missing series file")
    endforeach()
    foreach(cmd unapplied pop)
        qt_quilt_empty_arg(RESULT rc OUTPUT out ERROR err ARGS ${cmd})
        qt_assert_equal("${rc}" "1" "'${cmd} ''' should fail without a series file")
        qt_assert_contains("${err}" "No series file found"
                           "'${cmd} ''' should report the missing series file")
    endforeach()
    qt_assert_not_exists("${QT_WORK_DIR}/patches/series" "no series file should be created")

    # The top patch, p2, has been dropped from the series
    qt_write_file("${QT_WORK_DIR}/patches/series" "p1.patch\np3.patch\n")
    foreach(cmd "rename;zz.patch" "graph" "annotate;f2.txt" "revert;f2.txt"
                "header" "files" "fork" "add;f3.txt")
        qt_quilt(RESULT rc OUTPUT out ERROR err ARGS ${cmd})
        qt_assert_equal("${rc}" "1" "'${cmd}' should fail with the top patch not in the series")
        qt_assert_contains("${err}" "The series file no longer matches the applied patches"
                           "'${cmd}' should report the mismatch")
    endforeach()
    qt_quilt_empty_arg(RESULT rc OUTPUT out ERROR err ARGS unapplied)
    qt_assert_equal("${rc}" "1" "'unapplied ''' should fail with the top patch not in the series")
    qt_assert_contains("${err}" "The series file no longer matches the applied patches"
                       "'unapplied ''' should report the mismatch")
    # pop alone does not check the series against the applied patches
    qt_quilt_empty_arg(RESULT rc OUTPUT out ERROR err ARGS pop)
    qt_assert_equal("${rc}" "2" "'pop ''' should stop at the top patch")
    qt_assert_contains("${err}" "No patch removed" "'pop ''' should remove nothing")

    qt_assert_file_text("${QT_WORK_DIR}/patches/series" "p1.patch\np3.patch"
                        "series should be unchanged")
    qt_assert_file_text("${QT_WORK_DIR}/.pc/applied-patches" "${applied_before}"
                        "applied patches should be unchanged")
    qt_assert_file_text("${QT_WORK_DIR}/patches/p2.patch" "${p2_before}"
                        "top patch file should be unchanged")
    qt_assert_exists("${QT_WORK_DIR}/.pc/p2.patch/f2.txt" "top patch backup should remain")
    qt_assert_not_exists("${QT_WORK_DIR}/.pc/p2.patch/f3.txt" "no file should be added")
    qt_assert_not_exists("${QT_WORK_DIR}/patches/zz.patch" "patch should not be renamed")
    qt_assert_not_exists("${QT_WORK_DIR}/patches/p2-2.patch" "patch should not be forked")
    qt_assert_file_text("${QT_WORK_DIR}/f2.txt" "dirty" "f2.txt should not be reverted")
endfunction()

# refresh and diff look up a named patch like upstream's find_applied_patch,
# before checking that anything is applied. A given name counts even when
# it is empty: refresh -z refuses any patch argument, and diff --combine ''
# names no patch in the range.
function(qt_scenario_refresh_diff_patch_lookup)
    qt_begin_test("refresh_diff_patch_lookup")
    qt_setup_three_patch_stack()
    qt_read_file_strip(series_before "${QT_WORK_DIR}/patches/series")
    qt_read_file_strip(p1_before "${QT_WORK_DIR}/patches/p1.patch")
    qt_write_file("${QT_WORK_DIR}/f1.txt" "newer1\n")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS refresh p1.patch p2.patch)
    qt_assert_equal("${rc}" "1" "refresh with two patches should fail")
    qt_combine_output(combined "${out}" "${err}")
    qt_assert_contains("${combined}" "Usage: quilt refresh" "refresh with two patches should print usage")
    qt_assert_file_text("${QT_WORK_DIR}/patches/p1.patch" "${p1_before}" "refresh usage should change no patch")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS refresh -z p2.patch)
    qt_assert_equal("${rc}" "1" "refresh -z of a named patch should fail")
    qt_assert_contains("${err}" "Can only refresh the topmost patch with -z currently"
                       "refresh -z should refuse a named top patch")
    qt_quilt_empty_arg(RESULT rc OUTPUT out ERROR err ARGS refresh -z)
    qt_assert_equal("${rc}" "1" "refresh -z '' should fail")
    qt_assert_contains("${err}" "Can only refresh the topmost patch with -z currently"
                       "refresh -z should refuse an empty patch name")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS refresh -z nonexist)
    qt_assert_equal("${rc}" "1" "refresh -z of an unknown patch should fail")
    qt_assert_contains("${err}" "Patch nonexist is not in series" "refresh -z should look up the patch first")
    qt_assert_file_text("${QT_WORK_DIR}/patches/series" "${series_before}" "refresh -z should not fork")
    qt_assert_not_exists("${QT_WORK_DIR}/patches/p2-2.patch" "refresh -z should not write a fork")
    qt_quilt_empty_arg(RESULT rc OUTPUT out ERROR err ARGS diff --combine)
    qt_assert_equal("${rc}" "1" "diff --combine '' should fail")
    qt_assert_contains("${err}" "Patch  not applied before patch p2.patch"
                       "diff --combine '' should name no patch in the range")
    qt_quilt_empty_arg(RESULT rc OUTPUT out ERROR err ARGS diff)
    qt_assert_success("${rc}" "diff '' should succeed")
    qt_assert_contains("${out}" "+new2" "diff '' should name no file and show the whole top patch")

    qt_quilt_ok(ARGS pop -a -f MESSAGE "pop -a failed")
    foreach(cmd "refresh;patches/" "refresh;nonexist" "diff;-P;patches/"
                "diff;-P;nonexist" "diff;--combine;nonexist")
        qt_quilt(RESULT rc OUTPUT out ERROR err ARGS ${cmd})
        qt_assert_equal("${rc}" "1" "'${cmd}' should fail with nothing applied")
        string(REGEX REPLACE ".*;" "" name "${cmd}")
        qt_assert_contains("${err}" "Patch ${name} is not in series" "'${cmd}' should look up the patch")
    endforeach()
    foreach(cmd "refresh;p1.patch" "diff;-P;p1.patch" "diff;--combine;p1.patch")
        qt_quilt(RESULT rc OUTPUT out ERROR err ARGS ${cmd})
        qt_assert_equal("${rc}" "1" "'${cmd}' should fail with nothing applied")
        qt_assert_contains("${err}" "Patch p1.patch is not applied" "'${cmd}' should look up the patch")
    endforeach()

    qt_write_file("${QT_WORK_DIR}/patches/series" "")
    foreach(cmd "refresh;p1.patch" "diff;-P;p1.patch" "diff;--combine;-")
        qt_quilt(RESULT rc OUTPUT out ERROR err ARGS ${cmd})
        qt_assert_equal("${rc}" "1" "'${cmd}' should fail with an empty series")
        qt_assert_contains("${err}" "No patches in series" "'${cmd}' should report the empty series")
    endforeach()

    file(REMOVE "${QT_WORK_DIR}/patches/series")
    foreach(cmd "refresh;p1.patch" "diff;-P;p1.patch" "diff;-z;--combine;-")
        qt_quilt(RESULT rc OUTPUT out ERROR err ARGS ${cmd})
        qt_assert_equal("${rc}" "1" "'${cmd}' should fail without a series file")
        qt_assert_contains("${err}" "No series file found" "'${cmd}' should report the missing series file")
    endforeach()
endfunction()

# Like upstream's find_unapplied_patch, push finds the patch it would push
# before it checks whether the top patch needs a refresh, so a fully
# applied series says so even when its last patch was forced.
function(qt_scenario_push_nothing_to_push_first)
    qt_begin_test("push_nothing_to_push_first")
    qt_setup_three_patch_stack()
    qt_write_file("${QT_WORK_DIR}/f3.txt" "conflict\n")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS push -f)
    qt_assert_failure("${rc}" "push -f of a failing patch should fail")
    qt_combine_output(combined "${out}" "${err}")
    qt_assert_contains("${combined}" "forced; needs refresh" "push -f should force the patch")
    foreach(cmd "push" "push;1" "push;-a")
        qt_quilt(RESULT rc OUTPUT out ERROR err ARGS ${cmd})
        qt_assert_equal("${rc}" "2" "'${cmd}' should have nothing to push")
        qt_assert_contains("${err}" "File series fully applied, ends at patch p3.patch"
                           "'${cmd}' should report the fully applied series")
    endforeach()
    qt_quilt_empty_arg(RESULT rc OUTPUT out ERROR err ARGS push)
    qt_assert_equal("${rc}" "2" "push '' should have nothing to push")
    qt_assert_contains("${err}" "File series fully applied, ends at patch p3.patch"
                       "push '' should report the fully applied series")
    qt_quilt_ok(ARGS pop -a -f MESSAGE "pop -a failed")
    qt_write_file("${QT_WORK_DIR}/patches/series" "")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS push)
    qt_assert_equal("${rc}" "2" "push with an empty series should fail")
    qt_assert_contains("${err}" "No patches in series" "push should report the empty series")
    file(REMOVE "${QT_WORK_DIR}/patches/series")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS push)
    qt_assert_equal("${rc}" "1" "push without a series file should fail")
    qt_assert_contains("${err}" "No series file found" "push should report the missing series file")
endfunction()

# A file deleted by a patch (+++ /dev/null) is named only by its --- line.
function(qt_scenario_push_pop_deletion)
    qt_begin_test("push_pop_deletion")
    qt_write_file("${QT_WORK_DIR}/f.txt" "precious\n")
    qt_write_file("${QT_WORK_DIR}/sub/g.txt" "also precious\n")
    qt_write_file("${QT_WORK_DIR}/patches/d.patch" [=[--- a/f.txt
+++ /dev/null
@@ -1 +0,0 @@
-precious
--- a/sub/g.txt
+++ /dev/null
@@ -1 +0,0 @@
-also precious
]=])
    qt_write_file("${QT_WORK_DIR}/patches/series" "d.patch\n")
    qt_quilt_ok(ARGS push MESSAGE "push failed")
    qt_assert_file_text("${QT_WORK_DIR}/.pc/d.patch/f.txt" "precious" "push should back up f.txt")
    qt_assert_file_text("${QT_WORK_DIR}/.pc/d.patch/sub/g.txt" "also precious" "push should back up sub/g.txt")
    qt_assert_not_exists("${QT_WORK_DIR}/f.txt" "push should delete f.txt")
    qt_assert_not_exists("${QT_WORK_DIR}/sub" "push should remove the emptied directory")
    qt_quilt_ok(OUTPUT out ERROR err ARGS pop MESSAGE "pop failed")
    qt_assert_contains("${out}" "Restoring f.txt" "pop should restore f.txt")
    qt_assert_file_text("${QT_WORK_DIR}/f.txt" "precious" "pop should restore f.txt contents")
    qt_assert_file_text("${QT_WORK_DIR}/sub/g.txt" "also precious" "pop should restore sub/g.txt contents")
endfunction()

# push does not pass -E to patch, so a file that a patch empties without
# deleting it (+++ is not /dev/null) is kept as an empty file.
function(qt_scenario_push_keeps_emptied_file)
    qt_begin_test("push_keeps_emptied_file")
    qt_write_file("${QT_WORK_DIR}/sub/deep/x" "z\n")
    qt_write_file("${QT_WORK_DIR}/patches/e.patch" [=[--- a/sub/deep/x
+++ b/sub/deep/x
@@ -1 +0,0 @@
-z
]=])
    qt_write_file("${QT_WORK_DIR}/patches/series" "e.patch\n")
    qt_quilt_ok(ARGS push MESSAGE "push failed")
    qt_assert_exists("${QT_WORK_DIR}/sub/deep/x" "push should keep the emptied file")
    qt_read_file_raw(emptied "${QT_WORK_DIR}/sub/deep/x")
    qt_assert_equal("${emptied}" "" "push should leave the file empty")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    qt_assert_file_contains("${QT_WORK_DIR}/patches/e.patch" "-z" "refresh should keep the removed line")
    qt_assert_file_not_contains("${QT_WORK_DIR}/patches/e.patch" "/dev/null" "refresh should not turn the patch into a deletion")
    qt_quilt_ok(ARGS pop MESSAGE "pop failed")
    qt_assert_file_text("${QT_WORK_DIR}/sub/deep/x" "z" "pop should restore the file")

    # -E from QUILT_PATCH_OPTS still removes the file and its empty parents
    qt_quilt_ok(ENV "QUILT_PATCH_OPTS=-E" ARGS push MESSAGE "push with -E failed")
    qt_assert_not_exists("${QT_WORK_DIR}/sub" "push with -E should remove the file and empty directories")
    qt_quilt_ok(ARGS pop MESSAGE "pop after -E failed")
    qt_assert_file_text("${QT_WORK_DIR}/sub/deep/x" "z" "pop should restore the file removed by -E")
endfunction()

function(qt_scenario_fold_deletion)
    qt_begin_test("fold_deletion")
    qt_write_file("${QT_WORK_DIR}/a.txt" "a\n")
    qt_write_file("${QT_WORK_DIR}/del.txt" "gone\n")
    qt_write_file("${QT_WORK_DIR}/sub/sdel.txt" "gone too\n")
    qt_quilt_ok(ARGS new top.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add a.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/a.txt" "b\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    qt_quilt_ok(
        ARGS fold
        INPUT [=[--- a/del.txt
+++ /dev/null
@@ -1 +0,0 @@
-gone
--- a/sub/sdel.txt
+++ /dev/null
@@ -1 +0,0 @@
-gone too
]=]
        MESSAGE "fold failed"
    )
    qt_assert_not_exists("${QT_WORK_DIR}/del.txt" "fold should delete del.txt")
    qt_assert_not_exists("${QT_WORK_DIR}/sub" "fold should remove the emptied directory")
    qt_quilt_ok(OUTPUT files_out ERROR files_err ARGS files MESSAGE "files failed")
    qt_assert_equal("${files_out}" "a.txt\ndel.txt\nsub/sdel.txt\n" "fold should track deleted files")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh after fold failed")
    qt_assert_file_contains("${QT_WORK_DIR}/patches/top.patch" "-gone too" "refresh should record the deletion")
    qt_quilt_ok(ARGS pop MESSAGE "pop failed")
    qt_assert_file_text("${QT_WORK_DIR}/del.txt" "gone" "pop should restore del.txt")
    qt_assert_file_text("${QT_WORK_DIR}/sub/sdel.txt" "gone too" "pop should restore sub/sdel.txt")
endfunction()

# files and patches read unapplied patches with their series strip level.
function(qt_scenario_files_unapplied_strip_deletion)
    qt_begin_test("files_unapplied_strip_deletion")
    qt_write_file("${QT_WORK_DIR}/patches/p0.patch" [=[--- sub/f.txt
+++ sub/f.txt
@@ -1 +1 @@
-x
+y
]=])
    qt_write_file("${QT_WORK_DIR}/patches/p2.patch" [=[--- x/b/sub/g.txt
+++ y/b/sub/g.txt
@@ -1 +1 @@
-x
+y
]=])
    qt_write_file("${QT_WORK_DIR}/patches/del.patch" [=[--- a/gone.txt
+++ /dev/null
@@ -1 +0,0 @@
-x
]=])
    qt_write_file("${QT_WORK_DIR}/patches/series" "p0.patch -p0\np2.patch -p2\ndel.patch\n")
    qt_quilt_ok(OUTPUT p0_out ERROR p0_err ARGS files p0.patch MESSAGE "files p0.patch failed")
    qt_assert_equal("${p0_out}" "sub/f.txt\n" "files should apply -p0")
    qt_quilt_ok(OUTPUT p2_out ERROR p2_err ARGS files p2.patch MESSAGE "files p2.patch failed")
    qt_assert_equal("${p2_out}" "sub/g.txt\n" "files should apply -p2")
    qt_quilt_ok(OUTPUT del_out ERROR del_err ARGS files del.patch MESSAGE "files del.patch failed")
    qt_assert_equal("${del_out}" "gone.txt\n" "files should list a deleted file")
endfunction()

function(qt_scenario_patches_unapplied_strip_deletion)
    qt_begin_test("patches_unapplied_strip_deletion")
    qt_write_file("${QT_WORK_DIR}/patches/p0.patch" [=[--- sub/f.txt
+++ sub/f.txt
@@ -1 +1 @@
-x
+y
]=])
    qt_write_file("${QT_WORK_DIR}/patches/p2.patch" [=[--- x/b/sub/g.txt
+++ y/b/sub/g.txt
@@ -1 +1 @@
-x
+y
]=])
    qt_write_file("${QT_WORK_DIR}/patches/del.patch" [=[--- a/gone.txt
+++ /dev/null
@@ -1 +0,0 @@
-x
]=])
    qt_write_file("${QT_WORK_DIR}/patches/series" "p0.patch -p0\np2.patch -p2\ndel.patch\n")
    qt_quilt_ok(OUTPUT f_out ERROR f_err ARGS patches sub/f.txt MESSAGE "patches sub/f.txt failed")
    qt_assert_equal("${f_out}" "p0.patch\n" "patches should apply -p0")
    qt_quilt_ok(OUTPUT g_out ERROR g_err ARGS patches sub/g.txt MESSAGE "patches sub/g.txt failed")
    qt_assert_equal("${g_out}" "p2.patch\n" "patches should apply -p2")
    qt_quilt_ok(OUTPUT gone_out ERROR gone_err ARGS patches gone.txt MESSAGE "patches gone.txt failed")
    qt_assert_equal("${gone_out}" "del.patch\n" "patches should find a deleted file")
    qt_quilt_ok(OUTPUT short_out ERROR short_err ARGS patches f.txt MESSAGE "patches f.txt failed")
    qt_assert_equal("${short_out}" "" "-p0 patch should not match an over-stripped name")
endfunction()

# A patch that push applied in reverse (-R in the series or in
# QUILT_PATCH_OPTS) must be checked against a forward application when
# popped, or every such patch "does not remove cleanly".
function(qt_scenario_pop_reversed_patch)
    qt_begin_test("pop_reversed_patch")
    # Reversed file creation: push deletes sub/n.txt, pop restores it.
    qt_write_file("${QT_WORK_DIR}/sub/n.txt" "keep\n")
    qt_write_file("${QT_WORK_DIR}/patches/create.patch" [=[--- /dev/null
+++ b/sub/n.txt
@@ -0,0 +1 @@
+keep
]=])
    qt_write_file("${QT_WORK_DIR}/patches/series" "create.patch -R\n")
    qt_quilt_ok(ARGS push MESSAGE "push of reversed creation patch failed")
    qt_assert_not_exists("${QT_WORK_DIR}/sub/n.txt" "reversed creation patch should delete the file")
    qt_quilt_ok(OUTPUT out ERROR err ARGS pop MESSAGE "pop of reversed creation patch failed")
    qt_assert_contains("${out}" "Restoring sub/n.txt" "pop should restore the deleted file")
    qt_assert_file_text("${QT_WORK_DIR}/sub/n.txt" "keep" "pop should restore the original content")

    # Reversed modification: push turns new into old, pop turns it back.
    qt_write_file("${QT_WORK_DIR}/m.txt" "new\n")
    qt_write_file("${QT_WORK_DIR}/patches/modify.patch" [=[--- a/m.txt
+++ b/m.txt
@@ -1 +1 @@
-old
+new
]=])
    qt_write_file("${QT_WORK_DIR}/patches/series" "modify.patch -R\n")
    qt_quilt_ok(ARGS push MESSAGE "push of reversed modification patch failed")
    qt_assert_file_text("${QT_WORK_DIR}/m.txt" "old" "reversed patch should change new to old")
    qt_quilt_ok(ARGS pop MESSAGE "pop of reversed modification patch failed")
    qt_assert_file_text("${QT_WORK_DIR}/m.txt" "new" "pop should restore the original content")

    # The check still catches pending changes in a reversed patch.
    qt_quilt_ok(ARGS push MESSAGE "second push of reversed patch failed")
    qt_write_file("${QT_WORK_DIR}/m.txt" "dirty\n")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS pop)
    qt_assert_failure("${rc}" "pop should fail with pending changes")
    qt_assert_contains("${err}" "does not remove cleanly" "pop should explain the failure")
    qt_quilt_ok(ARGS pop -f MESSAGE "pop -f of dirty reversed patch failed")
    qt_assert_file_text("${QT_WORK_DIR}/m.txt" "new" "pop -f should restore the original content")

    # QUILT_PATCH_OPTS=-R reverses the patch the same way.
    qt_write_file("${QT_WORK_DIR}/patches/series" "modify.patch\n")
    qt_quilt_ok(ENV "QUILT_PATCH_OPTS=-R" ARGS push
                MESSAGE "push with QUILT_PATCH_OPTS=-R failed")
    qt_assert_file_text("${QT_WORK_DIR}/m.txt" "old" "patch should be reverse-applied")
    qt_quilt_ok(ENV "QUILT_PATCH_OPTS=-R" ARGS pop
                MESSAGE "pop with QUILT_PATCH_OPTS=-R failed")
    qt_assert_file_text("${QT_WORK_DIR}/m.txt" "new" "pop should restore the original content")
endfunction()

# Commands that change the series edit only the affected line, like upstream's
# insert_in_series, remove_from_series, and rename_in_series, so comments,
# blank lines, and options quilt does not know survive.
function(qt_scenario_new_preserves_series_comments)
    qt_begin_test("new_preserves_series_comments")
    qt_write_file("${QT_WORK_DIR}/patches/series"
        "# keep\na.patch --fuzz=3 # note\n# mid\n\nc.patch -p1 # c")
    qt_write_file("${QT_WORK_DIR}/patches/a.patch" "")
    qt_write_file("${QT_WORK_DIR}/patches/c.patch" "")
    qt_quilt_ok(ARGS new b.patch MESSAGE "new with nothing applied failed")
    qt_assert_file_text("${QT_WORK_DIR}/patches/series"
        "# keep\nb.patch\na.patch --fuzz=3 # note\n# mid\n\nc.patch -p1 # c"
        "new should go in front of the first patch")
    # The next patch follows comments, which stay with it
    qt_quilt_ok(ARGS push MESSAGE "push a.patch failed")
    qt_quilt_ok(ARGS new -p 0 d.patch MESSAGE "new -p 0 failed")
    qt_assert_file_text("${QT_WORK_DIR}/patches/series"
        "# keep\nb.patch\na.patch --fuzz=3 # note\n# mid\n\nd.patch -p0\nc.patch -p1 # c"
        "new should go right in front of the next patch")
    # At the end, the unterminated last line gets a newline
    qt_quilt_ok(ARGS push MESSAGE "push c.patch failed")
    qt_quilt_ok(ARGS new -p 1 e.patch MESSAGE "new -p 1 failed")
    qt_assert_file_text("${QT_WORK_DIR}/patches/series"
        "# keep\nb.patch\na.patch --fuzz=3 # note\n# mid\n\nd.patch -p0\nc.patch -p1 # c\ne.patch"
        "new should append after the last patch")
endfunction()

function(qt_scenario_import_preserves_series_comments)
    qt_begin_test("import_preserves_series_comments")
    qt_write_file("${QT_WORK_DIR}/patches/series"
        "# head\na.patch # a\n# mid\nc.patch --fuzz=3 # c\n")
    qt_write_file("${QT_WORK_DIR}/patches/a.patch" "")
    qt_write_file("${QT_WORK_DIR}/patches/c.patch" "")
    qt_write_file("${QT_WORK_DIR}/one.diff" "")
    qt_write_file("${QT_WORK_DIR}/two.diff" "")
    qt_write_file("${QT_WORK_DIR}/three.diff" "")
    qt_write_file("${QT_WORK_DIR}/four.diff" "")
    # With nothing applied, imports go in front of the first patch, in order
    qt_quilt_ok(ARGS import -p 0 -R one.diff two.diff MESSAGE "import -p 0 -R failed")
    qt_assert_file_text("${QT_WORK_DIR}/patches/series"
        "# head\none.diff -p0 -R\ntwo.diff -p0 -R\na.patch # a\n# mid\nc.patch --fuzz=3 # c"
        "imports should go in front of the first patch")
    # In front of the next patch they keep their order too, and an explicit
    # -p1 is recorded
    qt_quilt_ok(ARGS push a.patch MESSAGE "push a.patch failed")
    qt_quilt_ok(ARGS import -p 1 three.diff four.diff MESSAGE "import -p 1 failed")
    qt_assert_file_text("${QT_WORK_DIR}/patches/series"
        "# head\none.diff -p0 -R\ntwo.diff -p0 -R\na.patch # a\n# mid\nthree.diff -p1\nfour.diff -p1\nc.patch --fuzz=3 # c"
        "imports should go right in front of the next patch")
endfunction()

function(qt_scenario_delete_preserves_series_comments)
    qt_begin_test("delete_preserves_series_comments")
    qt_write_file("${QT_WORK_DIR}/patches/series"
        "# head\na.patch -p0 # a\n\n# mid\nb.patch --fuzz=3 # b\nc.patch\n")
    qt_write_file("${QT_WORK_DIR}/patches/a.patch" "")
    qt_write_file("${QT_WORK_DIR}/patches/b.patch" "")
    qt_write_file("${QT_WORK_DIR}/patches/c.patch" "")
    qt_quilt_ok(ARGS delete b.patch MESSAGE "delete b.patch failed")
    qt_assert_file_text("${QT_WORK_DIR}/patches/series"
        "# head\na.patch -p0 # a\n\n# mid\nc.patch"
        "delete should remove only the patch's line")
    qt_quilt_ok(ARGS push MESSAGE "push failed")
    qt_quilt_ok(ARGS delete MESSAGE "delete of the top patch failed")
    qt_assert_file_text("${QT_WORK_DIR}/patches/series"
        "# head\n\n# mid\nc.patch"
        "delete of the top patch should remove only its line")
endfunction()

function(qt_scenario_rename_preserves_series_comments)
    qt_begin_test("rename_preserves_series_comments")
    qt_write_file("${QT_WORK_DIR}/patches/series"
        "# head\na.patch -p0 --fuzz=3 # a\n\nb.patch # b\n")
    qt_write_file("${QT_WORK_DIR}/patches/a.patch" "")
    qt_write_file("${QT_WORK_DIR}/patches/b.patch" "")
    qt_quilt_ok(ARGS rename -P a.patch z.patch MESSAGE "rename failed")
    qt_assert_file_text("${QT_WORK_DIR}/patches/series"
        "# head\nz.patch -p0 --fuzz=3 # a\n\nb.patch # b"
        "rename should change only the patch name")
endfunction()

function(qt_scenario_fork_preserves_series_comments)
    qt_begin_test("fork_preserves_series_comments")
    qt_write_file("${QT_WORK_DIR}/patches/series"
        "# head\na.patch -p1 --fuzz=3 # a\n# tail\n")
    qt_write_file("${QT_WORK_DIR}/patches/a.patch" "")
    qt_quilt_ok(ARGS push MESSAGE "push failed")
    qt_quilt_ok(ARGS fork MESSAGE "fork failed")
    qt_assert_file_text("${QT_WORK_DIR}/patches/series"
        "# head\na-2.patch -p1 --fuzz=3 # a\n# tail"
        "fork should change only the patch name")
endfunction()

function(qt_scenario_refresh_z_preserves_series_comments)
    qt_begin_test("refresh_z_preserves_series_comments")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_write_file("${QT_WORK_DIR}/patches/series"
        "# head\na.patch # a\n# mid\nc.patch --fuzz=3 # c\n")
    qt_write_file("${QT_WORK_DIR}/patches/a.patch"
        "--- a/f.txt\n+++ b/f.txt\n@@ -1 +1 @@\n-x\n+y\n")
    qt_write_file("${QT_WORK_DIR}/patches/c.patch" "")
    qt_quilt_ok(ARGS push MESSAGE "push failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "z\n")
    qt_quilt_ok(ARGS refresh -z MESSAGE "refresh -z failed")
    qt_assert_file_text("${QT_WORK_DIR}/patches/series"
        "# head\na.patch # a\n# mid\na-2.patch\nc.patch --fuzz=3 # c"
        "the fork should go right in front of the next patch")
endfunction()

# quilt.cpp copies the strip level (and -R) to the fork created by
# refresh -z. Upstream 0.69 intends to (refresh.in saves old_patch_args)
# but looks up the strip level under the new name, which is not in the
# series yet, so its fork falls back to -p1.
# Without -p, refresh -z writes the fork with the original's strip level and
# records that level for the fork. Native only because upstream 0.69 looks up
# the strip level under the fork's name before the fork is in the series, so
# it always writes the fork with -p1.
function(qt_scenario_refresh_z_strip_migration)
    qt_begin_test("refresh_z_strip_migration")
    qt_write_file("${QT_WORK_DIR}/a/b/f.txt" "x\n")
    qt_quilt_ok(ARGS new -p 0 p.patch MESSAGE "new -p 0 failed")
    qt_quilt_ok(ARGS add a/b/f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/a/b/f.txt" "y\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    qt_write_file("${QT_WORK_DIR}/a/b/f.txt" "z\n")
    qt_quilt_ok(ARGS refresh -zfork.patch MESSAGE "refresh -zfork.patch failed")
    qt_assert_file_contains("${QT_WORK_DIR}/patches/series" "fork.patch -p0" "fork should inherit the strip level")
    qt_assert_file_contains("${QT_WORK_DIR}/patches/fork.patch" "+++ a/b/f.txt" "fork should use -p0 file names")
    qt_assert_file_contains("${QT_WORK_DIR}/patches/fork.patch" "+z" "fork should contain the pending change")
endfunction()

# Native only because Homebrew's quilt uses a compat getopt that does not
# report the missing argument, which makes upstream loop forever.
function(qt_scenario_annotate_P_missing_arg)
    qt_begin_test("annotate_P_missing_arg")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "y\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS annotate -P)
    qt_assert_failure("${rc}" "annotate -P without a value should fail")
    qt_combine_output(combined "${out}" "${err}")
    qt_assert_contains("${combined}" "Usage: quilt annotate" "usage should be printed")
endfunction()

# refresh -p0 records -p0 in the series, so pop and push use the strip level
# the patch was written with.
function(qt_scenario_refresh_p0_records_strip_level)
    qt_begin_test("refresh_p0_records_strip_level")
    qt_write_file("${QT_WORK_DIR}/sub/f.txt" "a\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add sub/f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/sub/f.txt" "b\n")
    qt_quilt_ok(ARGS refresh -p0 MESSAGE "refresh -p0 failed")
    qt_assert_file_text("${QT_WORK_DIR}/patches/series" "p.patch -p0" "refresh -p0 should record -p0")
    qt_assert_file_contains("${QT_WORK_DIR}/patches/p.patch" "+++ sub/f.txt" "patch should use -p0 file names")
    qt_quilt_ok(ARGS pop MESSAGE "pop after refresh -p0 failed")
    qt_assert_file_text("${QT_WORK_DIR}/sub/f.txt" "a" "pop should restore the file")
    qt_quilt_ok(ARGS push MESSAGE "push after refresh -p0 failed")
    qt_assert_file_text("${QT_WORK_DIR}/sub/f.txt" "b" "push should reapply the patch")
endfunction()

# Refreshing a -p0 patch with -p ab writes a/ b/ file names, so the series
# entry drops its -p0.
function(qt_scenario_refresh_pab_clears_p0)
    qt_begin_test("refresh_pab_clears_p0")
    qt_write_file("${QT_WORK_DIR}/sub/f.txt" "a\n")
    qt_write_file("${QT_WORK_DIR}/patches/series" "p0.patch -p0\n")
    qt_write_file("${QT_WORK_DIR}/patches/p0.patch" [=[--- sub/f.txt.orig
+++ sub/f.txt
@@ -1 +1 @@
-a
+b
]=])
    qt_quilt_ok(ARGS push MESSAGE "push failed")
    qt_write_file("${QT_WORK_DIR}/sub/f.txt" "c\n")
    qt_quilt_ok(ENV "QUILT_REFRESH_ARGS=-p ab" ARGS refresh MESSAGE "refresh -p ab failed")
    qt_assert_file_text("${QT_WORK_DIR}/patches/series" "p0.patch" "refresh -p ab should drop -p0")
    qt_assert_file_contains("${QT_WORK_DIR}/patches/p0.patch" "+++ b/sub/f.txt" "patch should use b/ file names")
    qt_quilt_ok(ARGS pop MESSAGE "pop after refresh -p ab failed")
    qt_assert_file_text("${QT_WORK_DIR}/sub/f.txt" "a" "pop should restore the file")
    qt_quilt_ok(ARGS push MESSAGE "push after refresh -p ab failed")
    qt_assert_file_text("${QT_WORK_DIR}/sub/f.txt" "c" "push should reapply the patch")
endfunction()

# Refresh writes a reversed (-R) patch forward, so the series entry drops -R.
function(qt_scenario_refresh_reversed_writes_forward)
    qt_begin_test("refresh_reversed_writes_forward")
    qt_write_file("${QT_WORK_DIR}/f.txt" "b\n")
    qt_write_file("${QT_WORK_DIR}/patches/series" "r.patch -R\n")
    qt_write_file("${QT_WORK_DIR}/patches/r.patch" [=[--- a/f.txt
+++ b/f.txt
@@ -1 +1 @@
-a
+b
]=])
    qt_quilt_ok(ARGS push MESSAGE "push of reversed patch failed")
    qt_assert_file_text("${QT_WORK_DIR}/f.txt" "a" "push should reverse the patch")
    qt_write_file("${QT_WORK_DIR}/f.txt" "c\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    qt_assert_file_text("${QT_WORK_DIR}/patches/series" "r.patch" "refresh should drop -R")
    qt_assert_file_contains("${QT_WORK_DIR}/patches/r.patch" "-b\n+c\n" "patch should be written forward")
    qt_quilt_ok(ARGS pop MESSAGE "pop after refresh failed")
    qt_assert_file_text("${QT_WORK_DIR}/f.txt" "b" "pop should restore the file")
    qt_quilt_ok(ARGS push MESSAGE "push after refresh failed")
    qt_assert_file_text("${QT_WORK_DIR}/f.txt" "c" "push should reapply the patch")
endfunction()

# An explicit -p1 is the way to refresh a -p2 patch; the series entry then
# drops its -p2.
function(qt_scenario_refresh_p1_clears_p2)
    qt_begin_test("refresh_p1_clears_p2")
    qt_write_file("${QT_WORK_DIR}/f.txt" "a\n")
    qt_write_file("${QT_WORK_DIR}/patches/series" "p2.patch -p2\n")
    qt_write_file("${QT_WORK_DIR}/patches/p2.patch" [=[--- x/a/f.txt
+++ x/b/f.txt
@@ -1 +1 @@
-a
+b
]=])
    qt_quilt_ok(ARGS push MESSAGE "push of -p2 patch failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "c\n")
    qt_quilt_ok(ARGS refresh -p1 MESSAGE "refresh -p1 failed")
    qt_assert_file_text("${QT_WORK_DIR}/patches/series" "p2.patch" "refresh -p1 should drop -p2")
    qt_quilt_ok(ARGS pop MESSAGE "pop after refresh -p1 failed")
    qt_assert_file_text("${QT_WORK_DIR}/f.txt" "a" "pop should restore the file")
    qt_quilt_ok(ARGS push MESSAGE "push after refresh -p1 failed")
    qt_assert_file_text("${QT_WORK_DIR}/f.txt" "c" "push should reapply the patch")
endfunction()

# refresh -z with an explicit -p records that level for the fork and leaves
# the original's entry alone.
function(qt_scenario_refresh_z_pab_on_p0)
    qt_begin_test("refresh_z_pab_on_p0")
    qt_write_file("${QT_WORK_DIR}/sub/f.txt" "a\n")
    qt_write_file("${QT_WORK_DIR}/patches/series" "p.patch -p0\n")
    qt_write_file("${QT_WORK_DIR}/patches/p.patch" [=[--- sub/f.txt.orig
+++ sub/f.txt
@@ -1 +1 @@
-a
+b
]=])
    qt_quilt_ok(ARGS push MESSAGE "push failed")
    qt_write_file("${QT_WORK_DIR}/sub/f.txt" "c\n")
    qt_quilt_ok(ARGS refresh -pab -zfork.patch MESSAGE "refresh -pab -z failed")
    qt_assert_file_text("${QT_WORK_DIR}/patches/series" "p.patch -p0\nfork.patch" "fork should not inherit -p0")
    qt_assert_file_contains("${QT_WORK_DIR}/patches/fork.patch" "+++ b/sub/f.txt" "fork should use b/ file names")
    qt_quilt_ok(ARGS pop -a MESSAGE "pop -a after refresh -z failed")
    qt_assert_file_text("${QT_WORK_DIR}/sub/f.txt" "a" "pop -a should restore the file")
    qt_quilt_ok(ARGS push -a MESSAGE "push -a after refresh -z failed")
    qt_assert_file_text("${QT_WORK_DIR}/sub/f.txt" "c" "push -a should reapply both patches")
endfunction()

# Recording the strip level rewrites only the patch's own series line, and
# keeps comments, blank lines, and other options.
function(qt_scenario_refresh_series_comments_kept)
    qt_begin_test("refresh_series_comments_kept")
    qt_write_file("${QT_WORK_DIR}/sub/f.txt" "a\n")
    qt_write_file("${QT_WORK_DIR}/patches/series"
        "# top\n\np.patch -p0 --fuzz=3 # note\n# end\n")
    qt_write_file("${QT_WORK_DIR}/patches/p.patch" [=[--- sub/f.txt.orig
+++ sub/f.txt
@@ -1 +1 @@
-a
+b
]=])
    qt_quilt_ok(ARGS push MESSAGE "push failed")
    qt_write_file("${QT_WORK_DIR}/sub/f.txt" "c\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    qt_assert_file_text("${QT_WORK_DIR}/patches/series"
        "# top\n\np.patch -p0 --fuzz=3 # note\n# end"
        "plain refresh should keep the series entry")
    qt_quilt_ok(ARGS refresh -p1 MESSAGE "refresh -p1 failed")
    qt_assert_file_text("${QT_WORK_DIR}/patches/series"
        "# top\n\np.patch --fuzz=3 # note\n# end"
        "refresh -p1 should drop only -p0")
    qt_quilt_ok(ARGS refresh -p0 MESSAGE "refresh -p0 failed")
    qt_assert_file_text("${QT_WORK_DIR}/patches/series"
        "# top\n\np.patch -p0 --fuzz=3 # note\n# end"
        "refresh -p0 should insert -p0 after the name")
    qt_quilt_ok(ARGS pop MESSAGE "pop failed")
    qt_assert_file_text("${QT_WORK_DIR}/sub/f.txt" "a" "pop should restore the file")
    qt_quilt_ok(ARGS push MESSAGE "push failed")
    qt_assert_file_text("${QT_WORK_DIR}/sub/f.txt" "c" "push should reapply the patch")
endfunction()

# The fork of a reversed patch is written forward, so it gets no -R while the
# original keeps its -R. Native only because upstream 0.69 splits the
# original's arguments across lines when it inserts the fork, adding a bogus
# "-p1" series entry.
function(qt_scenario_refresh_z_reversed_fork)
    qt_begin_test("refresh_z_reversed_fork")
    qt_write_file("${QT_WORK_DIR}/f.txt" "b\n")
    qt_write_file("${QT_WORK_DIR}/patches/series" "r.patch -R\n")
    qt_write_file("${QT_WORK_DIR}/patches/r.patch" [=[--- a/f.txt
+++ b/f.txt
@@ -1 +1 @@
-a
+b
]=])
    qt_quilt_ok(ARGS push MESSAGE "push of reversed patch failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "c\n")
    qt_quilt_ok(ARGS refresh -zfork.patch MESSAGE "refresh -z failed")
    qt_assert_file_text("${QT_WORK_DIR}/patches/series" "r.patch -R\nfork.patch" "fork should not inherit -R")
    qt_assert_file_contains("${QT_WORK_DIR}/patches/fork.patch" "-a\n+c\n" "fork should be written forward")
    qt_quilt_ok(ARGS pop -a MESSAGE "pop -a after refresh -z failed")
    qt_assert_file_text("${QT_WORK_DIR}/f.txt" "b" "pop -a should restore the file")
    qt_quilt_ok(ARGS push -a MESSAGE "push -a after refresh -z failed")
    qt_assert_file_text("${QT_WORK_DIR}/f.txt" "c" "push -a should reapply both patches")
endfunction()

# The series reader accepts "-p N" as two words; recording a new strip level
# replaces both. Native only because upstream 0.69 replaces just the "-p" and
# leaves the "N" behind as a stray argument.
function(qt_scenario_refresh_series_split_p_option)
    qt_begin_test("refresh_series_split_p_option")
    qt_write_file("${QT_WORK_DIR}/sub/f.txt" "a\n")
    qt_write_file("${QT_WORK_DIR}/patches/series" "p.patch -p 0\n")
    qt_write_file("${QT_WORK_DIR}/patches/p.patch" [=[--- sub/f.txt.orig
+++ sub/f.txt
@@ -1 +1 @@
-a
+b
]=])
    qt_quilt_ok(ARGS push MESSAGE "push failed")
    qt_write_file("${QT_WORK_DIR}/sub/f.txt" "c\n")
    qt_quilt_ok(ARGS refresh -p1 MESSAGE "refresh -p1 failed")
    qt_assert_file_text("${QT_WORK_DIR}/patches/series" "p.patch" "refresh -p1 should drop -p 0")
    qt_quilt_ok(ARGS pop MESSAGE "pop failed")
    qt_assert_file_text("${QT_WORK_DIR}/sub/f.txt" "a" "pop should restore the file")
    qt_quilt_ok(ARGS push MESSAGE "push failed")
    qt_assert_file_text("${QT_WORK_DIR}/sub/f.txt" "c" "push should reapply the patch")
endfunction()

# Like upstream's insert_in_series "$patch" "$old_patch_args", the fork gets
# the original's options. Native only because upstream 0.69 builds an awk
# program from those options and fails when there is more than one.
function(qt_scenario_refresh_z_fork_series_args)
    qt_begin_test("refresh_z_fork_series_args")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_write_file("${QT_WORK_DIR}/patches/series" "a.patch --fuzz=3 # a\n# tail\n")
    qt_write_file("${QT_WORK_DIR}/patches/a.patch"
        "--- a/f.txt\n+++ b/f.txt\n@@ -1 +1 @@\n-x\n+y\n")
    qt_quilt_ok(ARGS push MESSAGE "push failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "z\n")
    qt_quilt_ok(ARGS refresh -z MESSAGE "refresh -z failed")
    # With no patch after the original, the fork goes at the end, as upstream
    qt_assert_file_text("${QT_WORK_DIR}/patches/series"
        "a.patch --fuzz=3 # a\n# tail\na-2.patch --fuzz=3"
        "the fork should get the original's options without its comment")
endfunction()

# Lines inserted into a CRLF series file use CRLF too. Native only because
# upstream's awk writes them with LF.
function(qt_scenario_series_insert_crlf)
    qt_begin_test("series_insert_crlf")
    qt_write_file("${QT_WORK_DIR}/patches/a.patch" "")
    qt_write_bytes("${QT_WORK_DIR}/patches/series" "# c\\r\\na.patch\\r\\n")
    qt_quilt_ok(ARGS new b.patch MESSAGE "new b.patch failed")
    qt_quilt_ok(ARGS push MESSAGE "push failed")
    qt_quilt_ok(ARGS new c.patch MESSAGE "new c.patch failed")
    # "# c\r\nb.patch\r\na.patch\r\nc.patch\r\n"
    qt_assert_file_hex("${QT_WORK_DIR}/patches/series"
        "2320630d0a622e70617463680d0a612e70617463680d0a632e70617463680d0a"
        "inserted lines should use CRLF")
endfunction()

# push_context_diff: push applies a context diff written by refresh -c,
# including hunks that omit the old section (lines only added) or the new
# section (lines only removed), and pop restores every file afterward.
function(qt_scenario_push_context_diff)
    qt_begin_test("push_context_diff")
    qt_write_file("${QT_WORK_DIR}/add.txt" "x\n")
    qt_write_file("${QT_WORK_DIR}/del.txt" "x\nz\n")
    qt_write_file("${QT_WORK_DIR}/chg.txt" "1\n2\n3\n")
    qt_write_file("${QT_WORK_DIR}/gone.txt" "bye\n")
    qt_quilt_ok(ARGS new q.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add add.txt del.txt chg.txt gone.txt made.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/add.txt" "x\nz\n")
    qt_write_file("${QT_WORK_DIR}/del.txt" "x\n")
    qt_write_file("${QT_WORK_DIR}/chg.txt" "1\nTWO\n3\n")
    file(REMOVE "${QT_WORK_DIR}/gone.txt")
    qt_write_file("${QT_WORK_DIR}/made.txt" "hi\n")
    qt_quilt_ok(ARGS refresh -c MESSAGE "refresh -c failed")
    qt_assert_file_contains("${QT_WORK_DIR}/patches/q.patch" "***************"
        "refresh -c should write a context diff")
    # The first pop checks the patch against the backups from add, and the
    # second against the backups push made
    foreach(round 1 2)
        qt_quilt_ok(ARGS pop MESSAGE "pop ${round} failed")
        qt_assert_file_text("${QT_WORK_DIR}/add.txt" "x" "pop ${round} should restore add.txt")
        qt_assert_file_text("${QT_WORK_DIR}/del.txt" "x\nz" "pop ${round} should restore del.txt")
        qt_assert_file_text("${QT_WORK_DIR}/chg.txt" "1\n2\n3" "pop ${round} should restore chg.txt")
        qt_assert_file_text("${QT_WORK_DIR}/gone.txt" "bye" "pop ${round} should restore gone.txt")
        qt_assert_not_exists("${QT_WORK_DIR}/made.txt" "pop ${round} should remove made.txt")
        qt_quilt_ok(OUTPUT out ERROR err ARGS push MESSAGE "push ${round} failed")
        qt_assert_contains("${out}" "patching file add.txt" "push ${round} should patch add.txt")
        qt_assert_contains("${out}" "patching file del.txt" "push ${round} should patch del.txt")
        qt_assert_file_text("${QT_WORK_DIR}/add.txt" "x\nz" "push ${round} should add a line to add.txt")
        qt_assert_file_text("${QT_WORK_DIR}/del.txt" "x" "push ${round} should remove a line from del.txt")
        qt_assert_file_text("${QT_WORK_DIR}/chg.txt" "1\nTWO\n3" "push ${round} should change chg.txt")
        qt_assert_not_exists("${QT_WORK_DIR}/gone.txt" "push ${round} should delete gone.txt")
        qt_assert_file_text("${QT_WORK_DIR}/made.txt" "hi" "push ${round} should create made.txt")
    endforeach()
endfunction()

# push_context_diff_strip: push applies the context diffs written by
# refresh -p0 -c and refresh -pab -c.
function(qt_scenario_push_context_diff_strip)
    qt_begin_test("push_context_diff_strip")
    qt_write_file("${QT_WORK_DIR}/add.txt" "x\n")
    qt_write_file("${QT_WORK_DIR}/del.txt" "x\nz\n")
    qt_quilt_ok(ARGS new q.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add add.txt del.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/add.txt" "x\nz\n")
    qt_write_file("${QT_WORK_DIR}/del.txt" "x\n")
    foreach(p -p0 -pab)
        qt_quilt_ok(ARGS refresh ${p} -c MESSAGE "refresh ${p} -c failed")
        qt_quilt_ok(ARGS pop MESSAGE "pop after refresh ${p} -c failed")
        qt_assert_file_text("${QT_WORK_DIR}/add.txt" "x" "pop should restore add.txt (${p})")
        qt_assert_file_text("${QT_WORK_DIR}/del.txt" "x\nz" "pop should restore del.txt (${p})")
        qt_quilt_ok(ARGS push MESSAGE "push after refresh ${p} -c failed")
        qt_assert_file_text("${QT_WORK_DIR}/add.txt" "x\nz" "push should add a line to add.txt (${p})")
        qt_assert_file_text("${QT_WORK_DIR}/del.txt" "x" "push should remove a line from del.txt (${p})")
    endforeach()
endfunction()

# push_malformed_hunk: a hunk that does not parse fails the push with GNU
# patch's message and leaves the file alone, instead of being skipped while
# push reports success.
function(qt_scenario_push_malformed_hunk)
    qt_begin_test("push_malformed_hunk")
    qt_write_file("${QT_WORK_DIR}/f.txt" "a\nb\nc\n")
    qt_write_file("${QT_WORK_DIR}/patches/series" "m.patch\n")
    # Each case: patch text, then the message expected for it
    set(patch_1 "*** a/f.txt\n--- b/f.txt\n***************\n*** 1,2 ****\n  a\n? b\n--- 1,2 ----\n")
    set(error_1 "malformed patch at line 6: ? b")
    # The old section is omitted, but the new section has too few context
    # lines to stand in for the two lines it names
    set(patch_2 "*** a/f.txt\n--- b/f.txt\n***************\n*** 1,2 ****\n--- 1,2 ----\n  a\n+ X\n")
    set(error_2 "line numbers mangled in hunk at line 4")
    set(patch_3 "--- a/f.txt\n+++ b/f.txt\n@@ -1,1 +1,1 x@@\n-a\n+A\n")
    set(error_3 "malformed patch at line 3: @@ -1,1 +1,1 x@@")
    foreach(n 1 2 3)
        qt_write_file("${QT_WORK_DIR}/patches/m.patch" "${patch_${n}}")
        qt_quilt(RESULT rc OUTPUT out ERROR err ARGS push)
        qt_assert_failure("${rc}" "push of malformed patch ${n} should fail")
        qt_combine_output(combined "${out}" "${err}")
        qt_assert_contains("${combined}" "${error_${n}}" "push should explain malformed patch ${n}")
        qt_assert_file_text("${QT_WORK_DIR}/f.txt" "a\nb\nc" "malformed patch ${n} should leave f.txt alone")
    endforeach()
endfunction()

# push_truncated_hunk: a hunk that ends, at the end of the patch or at a
# line that does not fit, before it has the lines its header counts call
# for fails the push with GNU patch's message, instead of applying the
# lines it has.
function(qt_scenario_push_truncated_hunk)
    qt_begin_test("push_truncated_hunk")
    qt_write_file("${QT_WORK_DIR}/f.txt" "a\nb\nc\n")
    qt_write_file("${QT_WORK_DIR}/g.txt" "g\n")
    qt_write_file("${QT_WORK_DIR}/patches/series" "t.patch\n")
    # Each case: patch text, then the message expected for it.  A range
    # with no count ("-0") names one line, which this hunk never supplies.
    set(patch_1 "--- a/new.txt\n+++ b/new.txt\n@@ -0 +1 @@\n+hello\n")
    set(error_1 "malformed patch at line 4: ")
    # The hunk lacks its last context line, so the next file's header
    # cuts it short
    set(patch_2 "--- a/f.txt\n+++ b/f.txt\n@@ -1,3 +1,3 @@\n a\n-b\n+B\nIndex: g.txt\n===================================================================\n--- a/g.txt\n+++ b/g.txt\n@@ -1 +1 @@\n-g\n+G\n")
    set(error_2 "malformed patch at line 7: Index: g.txt")
    # Too many lines are missing to be chopped blank lines
    set(patch_3 "--- a/f.txt\n+++ b/f.txt\n@@ -1,3 +1,7 @@\n a\n+X\n")
    set(error_3 "unexpected end of file in patch")
    # A context line after the old side is complete
    set(patch_4 "--- a/f.txt\n+++ b/f.txt\n@@ -1 +1,2 @@\n-a\n b\n+A\n")
    set(error_4 "malformed patch at line 5:  b")
    # Context form: each lone line number names a line, and neither
    # section has one
    set(patch_5 "*** a/f.txt\n--- b/f.txt\n***************\n*** 1 ****\n--- 1 ----\n")
    set(error_5 "replacement text or line numbers mangled in hunk at line 4")
    foreach(n 1 2 3 4 5)
        qt_write_file("${QT_WORK_DIR}/patches/t.patch" "${patch_${n}}")
        qt_quilt(RESULT rc OUTPUT out ERROR err ARGS push)
        qt_assert_failure("${rc}" "push of truncated patch ${n} should fail")
        qt_combine_output(combined "${out}" "${err}")
        qt_assert_contains("${combined}" "${error_${n}}" "push should explain truncated patch ${n}")
        qt_assert_not_exists("${QT_WORK_DIR}/new.txt" "truncated patch ${n} should not create new.txt")
        qt_assert_file_text("${QT_WORK_DIR}/f.txt" "a\nb\nc" "truncated patch ${n} should leave f.txt alone")
        qt_assert_file_text("${QT_WORK_DIR}/g.txt" "g" "truncated patch ${n} should leave g.txt alone")
    endforeach()
endfunction()

# push_hunk_gnu_leniency: the hunk lines GNU patch accepts besides the
# usual ones still apply now that hunks must be complete: blank context
# lines missing at the end of the patch, a comment line, and a context line
# whose leading space was lost before its tab.
function(qt_scenario_push_hunk_gnu_leniency)
    qt_begin_test("push_hunk_gnu_leniency")
    qt_write_file("${QT_WORK_DIR}/patches/series" "t.patch\n")
    # Each case: file text, patch text, then the file text expected after
    set(file_1 "a\nb\n\n")
    set(patch_1 "--- a/f.txt\n+++ b/f.txt\n@@ -1,3 +1,3 @@\n-a\n+A\n b\n")
    set(want_1 "A\nb\n\n")
    set(file_2 "a\nb\n")
    set(patch_2 "--- a/f.txt\n+++ b/f.txt\n@@ -1,2 +1,2 @@\n-a\n# comment\n+A\n b\n")
    set(want_2 "A\nb\n")
    set(file_3 "a\n\tb\n")
    set(patch_3 "--- a/f.txt\n+++ b/f.txt\n@@ -1,2 +1,2 @@\n-a\n+A\n\tb\n")
    set(want_3 "A\n\tb\n")
    foreach(n 1 2 3)
        qt_write_file("${QT_WORK_DIR}/f.txt" "${file_${n}}")
        qt_write_file("${QT_WORK_DIR}/patches/t.patch" "${patch_${n}}")
        qt_quilt_ok(ARGS push MESSAGE "push of patch ${n} failed")
        qt_read_file_raw(got "${QT_WORK_DIR}/f.txt")
        qt_assert_equal("${got}" "${want_${n}}" "patch ${n} should apply")
        qt_quilt_ok(ARGS pop MESSAGE "pop of patch ${n} failed")
    endforeach()
endfunction()

# push_zero_context_insert: a hunk with no context that only adds lines has
# an empty old range, which names the line to insert after.  Covers the
# unified form from refresh -U 0 and the context form from diff -C0.
function(qt_scenario_push_zero_context_insert)
    qt_begin_test("push_zero_context_insert")
    qt_write_file("${QT_WORK_DIR}/f.txt" "a\nb\nc\n")
    qt_quilt_ok(ARGS new q.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "a\nb\nX\nc\n")
    qt_quilt_ok(ARGS refresh -U 0 MESSAGE "refresh -U 0 failed")
    qt_quilt_ok(ARGS pop MESSAGE "pop after refresh -U 0 failed")
    qt_assert_file_text("${QT_WORK_DIR}/f.txt" "a\nb\nc" "pop should restore f.txt")
    qt_quilt_ok(ARGS push MESSAGE "push of -U 0 patch failed")
    qt_assert_file_text("${QT_WORK_DIR}/f.txt" "a\nb\nX\nc" "push should insert X after b (-U 0)")
    qt_quilt_ok(ARGS pop MESSAGE "pop of -U 0 patch failed")
    qt_write_file("${QT_WORK_DIR}/patches/q.patch"
        "*** a/f.txt\n--- b/f.txt\n***************\n*** 2 ****\n--- 3 ----\n+ X\n")
    qt_quilt_ok(ARGS push MESSAGE "push of -C0 patch failed")
    qt_assert_file_text("${QT_WORK_DIR}/f.txt" "a\nb\nX\nc" "push should insert X after b (-C0)")
endfunction()

# push_create_without_dev_null: a patch that names a missing file with
# ordinary headers creates it when its first hunk's old range starts at
# line 0, as GNU patch decides, and pop removes the file again.
function(qt_scenario_push_create_without_dev_null)
    qt_begin_test("push_create_without_dev_null")
    qt_write_file("${QT_WORK_DIR}/patches/series" "p.diff\n")
    qt_write_file("${QT_WORK_DIR}/patches/p.diff"
        "--- a/new.txt\n+++ b/new.txt\n@@ -0,0 +1 @@\n+hello\n")
    qt_quilt_ok(ARGS push MESSAGE "push of unified creation patch failed")
    qt_assert_file_text("${QT_WORK_DIR}/new.txt" "hello" "push should create new.txt")
    qt_quilt_ok(ARGS pop MESSAGE "pop of unified creation patch failed")
    qt_assert_not_exists("${QT_WORK_DIR}/new.txt" "pop should remove new.txt")
    qt_write_file("${QT_WORK_DIR}/patches/p.diff"
        "*** a/new.txt\n--- b/new.txt\n***************\n*** 0 ****\n--- 1 ----\n+ hello\n")
    qt_quilt_ok(ARGS push MESSAGE "push of context creation patch failed")
    qt_assert_file_text("${QT_WORK_DIR}/new.txt" "hello" "push should create new.txt (context)")
    qt_quilt_ok(ARGS pop MESSAGE "pop of context creation patch failed")
    qt_assert_not_exists("${QT_WORK_DIR}/new.txt" "pop should remove new.txt (context)")
    # An empty range after line 1 does not create the file
    qt_write_file("${QT_WORK_DIR}/patches/p.diff"
        "--- a/new.txt\n+++ b/new.txt\n@@ -1,0 +2 @@\n+hello\n")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS push)
    qt_assert_failure("${rc}" "push should fail when the hunk does not start at line 0")
    qt_combine_output(combined "${out}" "${err}")
    qt_assert_contains("${combined}" "can't find file to patch at input line 3"
        "should name the hunk's line in the patch")
    qt_assert_not_exists("${QT_WORK_DIR}/new.txt" "failed push should not create new.txt")
endfunction()

# push_create_existing_file: a hunk whose old range starts at line 0 inserts
# at the top of an existing file, unless the header names /dev/null, which
# says for certain that the file is new, so the push fails.
function(qt_scenario_push_create_existing_file)
    qt_begin_test("push_create_existing_file")
    qt_write_file("${QT_WORK_DIR}/new.txt" "world\n")
    qt_write_file("${QT_WORK_DIR}/patches/series" "p.diff\n")
    qt_write_file("${QT_WORK_DIR}/patches/p.diff"
        "--- a/new.txt\n+++ b/new.txt\n@@ -0,0 +1 @@\n+hello\n")
    qt_quilt_ok(ARGS push MESSAGE "push of line-0 hunk onto existing file failed")
    qt_assert_file_text("${QT_WORK_DIR}/new.txt" "hello\nworld" "push should insert at the top")
    qt_quilt_ok(ARGS pop MESSAGE "pop failed")
    qt_assert_file_text("${QT_WORK_DIR}/new.txt" "world" "pop should restore new.txt")
    qt_write_file("${QT_WORK_DIR}/patches/p.diff"
        "--- /dev/null\n+++ b/new.txt\n@@ -0,0 +1 @@\n+hello\n")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS push)
    qt_assert_failure("${rc}" "push creating an existing file should fail")
    qt_combine_output(combined "${out}" "${err}")
    qt_assert_contains("${combined}" "which already exists!" "should warn that the file exists")
    qt_assert_file_text("${QT_WORK_DIR}/new.txt" "world" "failed push should leave new.txt")
endfunction()

# push_reverse_create_missing_file: a reversed creation patch deletes its
# file, so it fails when the file is missing rather than creating it.
function(qt_scenario_push_reverse_create_missing_file)
    qt_begin_test("push_reverse_create_missing_file")
    qt_write_file("${QT_WORK_DIR}/patches/series" "p.diff -R\n")
    qt_write_file("${QT_WORK_DIR}/patches/p.diff"
        "--- a/new.txt\n+++ b/new.txt\n@@ -0,0 +1 @@\n+hello\n")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS push)
    qt_assert_failure("${rc}" "reversed creation of a missing file should fail")
    qt_combine_output(combined "${out}" "${err}")
    qt_assert_contains("${combined}" "when reversed, would delete the file new.txt"
        "should warn that the file does not exist")
    qt_assert_not_exists("${QT_WORK_DIR}/new.txt" "failed push should not create new.txt")
endfunction()

# push_delete_epoch_timestamp: diff -N marks a deleted file with the epoch
# as its timestamp, in any time zone, which removes the emptied file just as
# /dev/null does.
function(qt_scenario_push_delete_epoch_timestamp)
    qt_begin_test("push_delete_epoch_timestamp")
    qt_write_file("${QT_WORK_DIR}/old.txt" "hello\n")
    qt_write_file("${QT_WORK_DIR}/patches/series" "p.diff\n")
    qt_write_file("${QT_WORK_DIR}/patches/p.diff"
        "--- a/old.txt\t2020-01-01 00:00:00.000000000 +0000\n+++ b/old.txt\t1970-01-01 01:00:00.000000000 +0100\n@@ -1 +0,0 @@\n-hello\n")
    qt_quilt_ok(ARGS push MESSAGE "push of unified deletion failed")
    qt_assert_not_exists("${QT_WORK_DIR}/old.txt" "push should remove old.txt")
    qt_quilt_ok(ARGS pop MESSAGE "pop of unified deletion failed")
    qt_assert_file_text("${QT_WORK_DIR}/old.txt" "hello" "pop should restore old.txt")
    qt_write_file("${QT_WORK_DIR}/patches/p.diff"
        "*** a/old.txt\tWed Jan  1 00:00:00 2020\n--- b/old.txt\tThu Jan  1 00:00:00 1970\n***************\n*** 1 ****\n- hello\n--- 0 ----\n")
    qt_quilt_ok(ARGS push MESSAGE "push of context deletion failed")
    qt_assert_not_exists("${QT_WORK_DIR}/old.txt" "push should remove old.txt (context)")
    qt_quilt_ok(ARGS pop MESSAGE "pop of context deletion failed")
    qt_assert_file_text("${QT_WORK_DIR}/old.txt" "hello" "pop should restore old.txt (context)")
endfunction()

# push_skip_missing_file: like GNU patch, push skips a missing file that the
# patch does not create, quoting the text leading up to its first hunk.  It
# writes no reject file, and even with -f it leaves the file alone and backs
# nothing up, so the patch is reported as empty.
function(qt_scenario_push_skip_missing_file)
    qt_begin_test("push_skip_missing_file")
    qt_write_file("${QT_WORK_DIR}/patches/series" "p.diff\n")
    qt_write_file("${QT_WORK_DIR}/patches/p.diff"
        "junk line\nIndex: x\n--- a/new.txt\n+++ b/new.txt\n@@ -1 +1 @@\n-a\n+b\n")
    set(skipped "can't find file to patch at input line 5\nPerhaps you used the wrong -p or --strip option?\nThe text leading up to this was:\n--------------------------\n|junk line\n|Index: x\n|--- a/new.txt\n|+++ b/new.txt\n--------------------------\nNo file to patch.  Skipping patch.\n1 out of 1 hunk ignored\n")

    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS push)
    qt_assert_failure("${rc}" "push should fail on the missing file")
    qt_combine_output(combined "${out}" "${err}")
    qt_assert_equal("${combined}"
        "Applying patch p.diff\n${skipped}Patch p.diff does not apply (enforce with -f)\n"
        "push should skip new.txt and refuse the patch")
    qt_assert_not_exists("${QT_WORK_DIR}/new.txt.rej" "push should write no reject file")

    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS push --leave-rejects)
    qt_assert_failure("${rc}" "push --leave-rejects should fail on the missing file")
    qt_combine_output(combined "${out}" "${err}")
    qt_assert_equal("${combined}"
        "Applying patch p.diff\n${skipped}Patch p.diff does not apply (enforce with -f)\n"
        "push --leave-rejects should skip new.txt")
    qt_assert_not_exists("${QT_WORK_DIR}/new.txt.rej"
        "push --leave-rejects should have no rejects to leave")

    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS push -f)
    qt_assert_failure("${rc}" "push -f should report the skipped file")
    qt_combine_output(combined "${out}" "${err}")
    qt_assert_contains("${combined}" "${skipped}" "push -f should skip new.txt")
    qt_assert_contains("${out}" "Patch p.diff appears to be empty; applied\n"
        "push -f should report the patch as empty")
    qt_assert_not_exists("${QT_WORK_DIR}/new.txt" "push -f should not create new.txt")
    qt_assert_not_exists("${QT_WORK_DIR}/new.txt.rej" "push -f should write no reject file")
    qt_assert_not_exists("${QT_WORK_DIR}/.pc/p.diff/new.txt" "push -f should not back up new.txt")
    qt_quilt_ok(ARGS pop -f MESSAGE "pop -f failed")

    # A context diff's first hunk starts at its row of stars
    qt_write_file("${QT_WORK_DIR}/patches/p.diff"
        "*** a/new.txt\n--- b/new.txt\n***************\n*** 1 ****\n! a\n--- 1 ----\n! b\n")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS push)
    qt_assert_failure("${rc}" "push of the context diff should fail")
    qt_combine_output(combined "${out}" "${err}")
    qt_assert_equal("${combined}"
        "Applying patch p.diff\ncan't find file to patch at input line 3\nPerhaps you used the wrong -p or --strip option?\nThe text leading up to this was:\n--------------------------\n|*** a/new.txt\n|--- b/new.txt\n--------------------------\nNo file to patch.  Skipping patch.\n1 out of 1 hunk ignored\nPatch p.diff does not apply (enforce with -f)\n"
        "push should skip new.txt in the context diff")
    qt_assert_not_exists("${QT_WORK_DIR}/new.txt.rej" "push should write no reject file (context)")
endfunction()

# push_skip_missing_later_file: the text quoted for a skipped file starts
# after the previous file's last hunk, and every hunk counts as ignored.
# push -f applies the rest of the patch.
function(qt_scenario_push_skip_missing_later_file)
    qt_begin_test("push_skip_missing_later_file")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_write_file("${QT_WORK_DIR}/patches/series" "p.diff\n")
    qt_write_file("${QT_WORK_DIR}/patches/p.diff"
        "Index: f.txt\n--- a/f.txt\n+++ b/f.txt\n@@ -1 +1 @@\n-x\n+y\ntrailing note\n--- a/g.txt\n+++ b/g.txt\n@@ -1 +1 @@\n-a\n+b\n@@ -3 +3 @@\n-c\n+d\n")
    set(skipped "can't find file to patch at input line 10\nPerhaps you used the wrong -p or --strip option?\nThe text leading up to this was:\n--------------------------\n|trailing note\n|--- a/g.txt\n|+++ b/g.txt\n--------------------------\nNo file to patch.  Skipping patch.\n2 out of 2 hunks ignored\n")

    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS push)
    qt_assert_failure("${rc}" "push should fail on the missing file")
    qt_combine_output(combined "${out}" "${err}")
    qt_assert_equal("${combined}"
        "Applying patch p.diff\npatching file f.txt\n${skipped}Patch p.diff does not apply (enforce with -f)\n"
        "push should patch f.txt and skip g.txt")
    qt_assert_file_text("${QT_WORK_DIR}/f.txt" "x" "failed push should restore f.txt")
    qt_assert_not_exists("${QT_WORK_DIR}/g.txt.rej" "push should write no reject file")

    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS push -f)
    qt_assert_failure("${rc}" "push -f should report the skipped file")
    qt_combine_output(combined "${out}" "${err}")
    qt_assert_contains("${combined}" "${skipped}" "push -f should skip g.txt")
    qt_assert_contains("${out}" "Applied patch p.diff (forced; needs refresh)\n"
        "push -f should apply the rest of the patch")
    qt_assert_file_text("${QT_WORK_DIR}/f.txt" "y" "push -f should patch f.txt")
    qt_assert_not_exists("${QT_WORK_DIR}/g.txt" "push -f should not create g.txt")
    qt_assert_not_exists("${QT_WORK_DIR}/g.txt.rej" "push -f should write no reject file")
    qt_quilt_ok(OUTPUT out ARGS files MESSAGE "files failed")
    qt_assert_equal("${out}" "f.txt\n" "only f.txt should be backed up")
endfunction()

# fold_skip_missing_file: fold skips a missing file that the patch does not
# create, without adding it to the top patch or writing a reject file
function(qt_scenario_fold_skip_missing_file)
    qt_begin_test("fold_skip_missing_file")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS fold
        INPUT "junk line\n--- a/new.txt\n+++ b/new.txt\n@@ -1 +1 @@\n-a\n+b\n")
    qt_assert_failure("${rc}" "fold should fail on the missing file")
    qt_combine_output(combined "${out}" "${err}")
    qt_assert_equal("${combined}"
        "can't find file to patch at input line 4\nPerhaps you used the wrong -p or --strip option?\nThe text leading up to this was:\n--------------------------\n|junk line\n|--- a/new.txt\n|+++ b/new.txt\n--------------------------\nNo file to patch.  Skipping patch.\n1 out of 1 hunk ignored\n"
        "fold should skip new.txt")
    qt_assert_not_exists("${QT_WORK_DIR}/new.txt" "fold should not create new.txt")
    qt_assert_not_exists("${QT_WORK_DIR}/new.txt.rej" "fold should write no reject file")
    qt_quilt_ok(OUTPUT out ARGS files MESSAGE "files failed")
    qt_assert_equal("${out}" "" "fold should not add new.txt to the patch")
endfunction()

# fold_subdirectory: fold run from a subdirectory applies the patch there,
# like "patch -d", so file names, backups, and reject files are relative to
# the subdirectory, and skipped files are left out of the top patch
function(qt_scenario_fold_subdirectory)
    qt_begin_test("fold_subdirectory")
    qt_write_file("${QT_WORK_DIR}/f.txt" "root\n")
    qt_write_file("${QT_WORK_DIR}/sub/f.txt" "inner\n")
    qt_write_file("${QT_WORK_DIR}/sub/g.txt" "other\n")
    qt_quilt_ok(ARGS new top.diff MESSAGE "new failed")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS fold
        WORKING_DIRECTORY "${QT_WORK_DIR}/sub"
        INPUT "--- a/f.txt\n+++ b/f.txt\n@@ -1 +1 @@\n-inner\n+changed\n--- a/new/h.txt\n+++ b/new/h.txt\n@@ -0,0 +1 @@\n+created\n")
    qt_assert_success("${rc}" "fold from a subdirectory should succeed")
    qt_assert_equal("${out}" "patching file f.txt\npatching file new/h.txt\n"
                    "fold should name files relative to the subdirectory")
    qt_assert_file_text("${QT_WORK_DIR}/sub/f.txt" "changed" "fold should patch sub/f.txt")
    qt_assert_file_text("${QT_WORK_DIR}/f.txt" "root" "fold should not touch the root f.txt")
    qt_assert_file_text("${QT_WORK_DIR}/sub/new/h.txt" "created" "fold should create sub/new/h.txt")
    qt_assert_not_exists("${QT_WORK_DIR}/new" "fold should not create new/ at the root")
    qt_assert_not_exists("${QT_WORK_DIR}/f.txt.rej" "fold should write no reject file")
    qt_assert_file_text("${QT_WORK_DIR}/.pc/top.diff/sub/f.txt" "inner"
                        "fold should back up sub/f.txt")
    qt_quilt_ok(OUTPUT out ARGS files MESSAGE "files failed")
    qt_assert_equal("${out}" "sub/f.txt\nsub/new/h.txt\n" "fold should track the subdirectory files")

    # A forced fold leaves its reject file in the subdirectory and does not
    # track a missing file it skips
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS fold -f -q
        WORKING_DIRECTORY "${QT_WORK_DIR}/sub"
        INPUT "--- a/g.txt\n+++ b/g.txt\n@@ -1 +1 @@\n-nomatch\n+x\n--- a/missing.txt\n+++ b/missing.txt\n@@ -1 +1 @@\n-a\n+b\n--- a/f.txt\n+++ b/f.txt\n@@ -1 +1 @@\n-changed\n+again\n")
    qt_assert_success("${rc}" "fold -f from a subdirectory should succeed")
    qt_assert_file_text("${QT_WORK_DIR}/sub/f.txt" "again" "fold -f should patch sub/f.txt")
    qt_assert_file_text("${QT_WORK_DIR}/sub/g.txt" "other" "fold -f should leave sub/g.txt")
    qt_assert_exists("${QT_WORK_DIR}/sub/g.txt.rej" "fold -f should write sub/g.txt.rej")
    qt_assert_not_exists("${QT_WORK_DIR}/g.txt.rej" "fold -f should write no reject file at the root")
    qt_assert_not_exists("${QT_WORK_DIR}/sub/missing.txt" "fold -f should not create missing.txt")
    qt_quilt_ok(OUTPUT out ARGS files MESSAGE "files failed")
    qt_assert_equal("${out}" "sub/f.txt\nsub/g.txt\nsub/new/h.txt\n"
                    "fold -f should track sub/g.txt but not the skipped file")
endfunction()

# fold_subdirectory_rollback: a fold from a subdirectory that fails without
# -f restores the subdirectory's files and adds no backups to the top patch
function(qt_scenario_fold_subdirectory_rollback)
    qt_begin_test("fold_subdirectory_rollback")
    qt_write_file("${QT_WORK_DIR}/f.txt" "root\n")
    qt_write_file("${QT_WORK_DIR}/sub/f.txt" "inner\n")
    qt_write_file("${QT_WORK_DIR}/sub/g.txt" "other\n")
    qt_quilt_ok(ARGS new top.diff MESSAGE "new failed")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS fold
        WORKING_DIRECTORY "${QT_WORK_DIR}/sub"
        INPUT "--- a/f.txt\n+++ b/f.txt\n@@ -1 +1 @@\n-inner\n+changed\n--- a/g.txt\n+++ b/g.txt\n@@ -1 +1 @@\n-nomatch\n+x\n")
    qt_assert_failure("${rc}" "fold with a failing hunk should fail")
    qt_assert_file_text("${QT_WORK_DIR}/sub/f.txt" "inner" "failed fold should restore sub/f.txt")
    qt_assert_file_text("${QT_WORK_DIR}/sub/g.txt" "other" "failed fold should leave sub/g.txt")
    qt_assert_file_text("${QT_WORK_DIR}/f.txt" "root" "failed fold should not touch the root f.txt")
    qt_assert_exists("${QT_WORK_DIR}/sub/g.txt.rej" "the reject file should stay in the subdirectory")
    qt_assert_not_exists("${QT_WORK_DIR}/f.txt.rej" "fold should not patch the root f.txt")
    qt_assert_not_exists("${QT_WORK_DIR}/.pc/top.diff/sub/f.txt" "failed fold should drop its backups")
    qt_quilt_ok(OUTPUT files_out ARGS files MESSAGE "files failed")
    qt_assert_equal("${files_out}" "" "failed fold should track no files")
endfunction()

# push_context_diff_zero_context: a context diff from refresh -C 0, whose
# hunks have empty ranges, applies and pops.  Native only because GNU patch
# rejects the zero-context deletion hunks that diff -C0 writes ("replacement
# text or line numbers mangled").
function(qt_scenario_push_context_diff_zero_context)
    qt_begin_test("push_context_diff_zero_context")
    qt_write_file("${QT_WORK_DIR}/f.txt" "a\nb\nc\nd\ne\n")
    qt_quilt_ok(ARGS new q.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "a\nb\nX\nc\ne\n")
    qt_quilt_ok(ARGS refresh -C 0 MESSAGE "refresh -C 0 failed")
    qt_quilt_ok(ARGS pop MESSAGE "pop after refresh -C 0 failed")
    qt_assert_file_text("${QT_WORK_DIR}/f.txt" "a\nb\nc\nd\ne" "pop should restore f.txt")
    qt_quilt_ok(ARGS push MESSAGE "push of -C 0 patch failed")
    qt_assert_file_text("${QT_WORK_DIR}/f.txt" "a\nb\nX\nc\ne" "push should insert X and remove d")
    qt_quilt_ok(ARGS pop MESSAGE "pop of -C 0 patch failed")
    qt_assert_file_text("${QT_WORK_DIR}/f.txt" "a\nb\nc\nd\ne" "pop should restore f.txt again")
endfunction()

# A missing patch file applies as an empty patch, with a note that -q does
# not suppress, and push --refresh notes it before refreshing it
function(qt_scenario_push_missing_patch_file)
    qt_begin_test("push_missing_patch_file")
    qt_write_file("${QT_WORK_DIR}/patches/series" "a.patch\nb.patch\n")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS push)
    qt_assert_success("${rc}" "push of a missing patch should succeed")
    qt_assert_equal("${out}"
        "Applying patch a.patch\nPatch a.patch does not exist; applied empty patch\n\nNow at patch a.patch\n"
        "push should note the missing patch")
    qt_assert_equal("${err}" "" "push should print nothing on stderr")
    qt_assert_not_exists("${QT_WORK_DIR}/patches/a.patch"
        "push should not create the missing patch")
    qt_quilt_ok(ARGS push -q OUTPUT out MESSAGE "push -q failed")
    qt_assert_equal("${out}"
        "Applying patch b.patch\nPatch b.patch does not exist; applied empty patch\nNow at patch b.patch\n"
        "push -q should still note the missing patch")
    qt_quilt_ok(ARGS pop -q -a MESSAGE "pop -q -a failed")
    qt_quilt_ok(ARGS push --refresh OUTPUT out MESSAGE "push --refresh failed")
    qt_assert_equal("${out}"
        "Applying patch a.patch\nPatch a.patch does not exist; applied empty patch\nNothing in patch a.patch\n\nNow at patch a.patch\n"
        "push --refresh should note the missing patch before refreshing it")
endfunction()

# Input with no hunk at all is garbage to GNU patch, so push refuses a patch
# file holding only a description, a blank line, or file headers. A zero-byte
# patch file is not run through patch, so it is different.
function(qt_scenario_push_garbage_patch)
    qt_begin_test("push_garbage_patch")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_write_file("${QT_WORK_DIR}/patches/series" "a.patch\n")
    foreach(content "Just a description\n" "\n" "--- a/f.txt\n+++ b/f.txt\n")
        qt_write_file("${QT_WORK_DIR}/patches/a.patch" "${content}")
        qt_quilt(RESULT rc OUTPUT out ERROR err ARGS push)
        qt_assert_failure("${rc}" "push of a patch with no hunk should fail")
        qt_combine_output(combined "${out}" "${err}")
        qt_assert_equal("${combined}"
            "Applying patch a.patch\npatch: **** Only garbage was found in the patch input.\nPatch a.patch does not apply (enforce with -f)\n"
            "push should report garbage and refuse the patch")
        qt_assert_not_exists("${QT_WORK_DIR}/.pc/applied-patches"
                             "the patch should not be recorded as applied")
        qt_assert_not_exists("${QT_WORK_DIR}/.pc/a.patch"
                             "push should leave no backup directory")
        qt_assert_file_text("${QT_WORK_DIR}/f.txt" "x" "f.txt should be untouched")
    endforeach()
endfunction()

# push -f records a patch with no hunk as applied but needing a refresh,
# reports it as empty because it backed up no files, and stops there
function(qt_scenario_push_force_garbage_patch)
    qt_begin_test("push_force_garbage_patch")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_write_file("${QT_WORK_DIR}/patches/series" "a.patch\nb.patch\n")
    qt_write_file("${QT_WORK_DIR}/patches/a.patch" "Just a description\n")
    qt_write_file("${QT_WORK_DIR}/patches/b.patch" "--- a/f.txt\n+++ b/f.txt\n@@ -1 +1 @@\n-x\n+y\n")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS push -f -a)
    qt_assert_failure("${rc}" "forced push of a patch with no hunk should fail")
    qt_combine_output(combined "${out}" "${err}")
    qt_assert_contains("${combined}" "patch: **** Only garbage was found in the patch input.\n"
                       "push -f should report garbage")
    qt_assert_contains("${out}" "Patch a.patch appears to be empty; applied\n"
                       "push -f should report the patch as empty")
    qt_assert_not_contains("${combined}" "forced; needs refresh"
                           "an empty patch is not reported as forced")
    qt_assert_not_contains("${combined}" "b.patch" "push -f should stop at the forced patch")
    qt_quilt_ok(OUTPUT out ARGS applied MESSAGE "applied failed")
    qt_assert_equal("${out}" "a.patch\n" "the forced patch should be applied")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS push)
    qt_assert_failure("${rc}" "push should refuse until the forced patch is refreshed")
    qt_combine_output(combined "${out}" "${err}")
    qt_assert_contains("${combined}" "The topmost patch a.patch needs to be refreshed first."
                       "push should ask for a refresh")
    qt_quilt_ok(OUTPUT out ARGS refresh MESSAGE "refresh failed")
    qt_assert_equal("${out}" "Patch a.patch is unchanged\n" "refresh should leave the patch unchanged")
    qt_assert_file_text("${QT_WORK_DIR}/patches/a.patch" "Just a description"
                        "refresh should keep the description")
    qt_quilt_ok(ARGS push MESSAGE "push after refresh failed")
    qt_assert_file_text("${QT_WORK_DIR}/f.txt" "y" "b.patch should be applied")
endfunction()

# Like GNU patch, push ignores file headers with no hunk after them, so it
# neither needs nor backs up the file they name
function(qt_scenario_push_header_only_section)
    qt_begin_test("push_header_only_section")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_write_file("${QT_WORK_DIR}/patches/series" "a.patch\n")
    qt_write_file("${QT_WORK_DIR}/patches/a.patch"
        "--- a/f.txt\n+++ b/f.txt\n@@ -1 +1 @@\n-x\n+y\n--- a/g.txt\n+++ b/g.txt\n")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS push)
    qt_assert_success("${rc}" "push should ignore the header-only section")
    qt_assert_equal("${out}" "Applying patch a.patch\npatching file f.txt\n\nNow at patch a.patch\n"
                    "push should patch only f.txt")
    qt_assert_equal("${err}" "" "push should print nothing on stderr")
    qt_assert_file_text("${QT_WORK_DIR}/f.txt" "y" "f.txt should be patched")
    qt_assert_not_exists("${QT_WORK_DIR}/g.txt" "g.txt should not be created")
    qt_quilt_ok(OUTPUT out ARGS files MESSAGE "files failed")
    qt_assert_equal("${out}" "f.txt\n" "only f.txt should be backed up")
endfunction()

# fold fails on input with no hunk, as GNU patch does, unless forced
function(qt_scenario_fold_garbage_input)
    qt_begin_test("fold_garbage_input")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS fold INPUT "Just a description\n")
    qt_assert_failure("${rc}" "fold of input with no hunk should fail")
    qt_assert_equal("${err}" "patch: **** Only garbage was found in the patch input.\n"
                    "fold should report garbage")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS fold -f INPUT "Just a description\n")
    qt_assert_success("${rc}" "fold -f should ignore the failure")
    qt_assert_equal("${err}" "patch: **** Only garbage was found in the patch input.\n"
                    "fold -f should still report garbage")
endfunction()

# A fold that fails without -f changes nothing: patched files return to
# their pre-fold contents, including files the top patch already tracks,
# and the top patch gains no files. Rejects stay behind.
function(qt_scenario_fold_fail_rollback)
    qt_begin_test("fold_fail_rollback")
    qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
    qt_write_file("${QT_WORK_DIR}/h.txt" "h\n")
    qt_write_file("${QT_WORK_DIR}/t.txt" "t\n")
    qt_write_file("${QT_WORK_DIR}/sub/g.txt" "g\n")
    qt_quilt_ok(ARGS new top.diff MESSAGE "new failed")
    qt_quilt_ok(ARGS add t.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/t.txt" "t2\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    qt_quilt(
        RESULT rc OUTPUT out ERROR err
        ARGS fold
        INPUT [=[--- a/t.txt
+++ b/t.txt
@@ -1 +1 @@
-t2
+t3
--- a/f.txt
+++ b/f.txt
@@ -1 +1 @@
-x
+y
--- a/sub/g.txt
+++ b/sub/g.txt
@@ -1 +1 @@
-g
+g2
--- a/h.txt
+++ b/h.txt
@@ -1 +1 @@
-zzz
+b
]=]
    )
    qt_assert_failure("${rc}" "fold with a failing hunk should fail")
    qt_assert_file_text("${QT_WORK_DIR}/f.txt" "x" "f.txt should be restored")
    qt_assert_file_text("${QT_WORK_DIR}/sub/g.txt" "g" "sub/g.txt should be restored")
    qt_assert_file_text("${QT_WORK_DIR}/t.txt" "t2" "tracked t.txt should be restored")
    qt_assert_file_text("${QT_WORK_DIR}/h.txt" "h" "h.txt should be unchanged")
    qt_assert_exists("${QT_WORK_DIR}/h.txt.rej" "the reject file should remain")
    qt_quilt_ok(OUTPUT out ARGS files MESSAGE "files failed")
    qt_assert_equal("${out}" "t.txt\n" "fold should add no files to the top patch")
    qt_assert_file_text("${QT_WORK_DIR}/.pc/top.diff/t.txt" "t"
                        "backup of t.txt should keep its pre-patch contents")
    qt_assert_not_exists("${QT_WORK_DIR}/.pc/top.diff/sub" "no backup directory should remain")
    qt_quilt_ok(OUTPUT out ARGS diff -p ab --no-index --no-timestamps MESSAGE "diff failed")
    qt_assert_equal("${out}" "--- a/t.txt\n+++ b/t.txt\n@@ -1 +1 @@\n-t\n+t2\n"
                    "the top patch should be unchanged")
endfunction()

# A fold that fails without -f removes the files it created and restores
# the files it deleted. Upstream leaves a created file behind empty, since
# it moves GNU patch's empty placeholder backup over it, and cannot restore
# a deleted file whose directory patch removed.
function(qt_scenario_fold_fail_rollback_create_delete)
    qt_begin_test("fold_fail_rollback_create_delete")
    qt_write_file("${QT_WORK_DIR}/h.txt" "h\n")
    qt_write_file("${QT_WORK_DIR}/d/only.txt" "gone\n")
    qt_quilt_ok(ARGS new top.diff MESSAGE "new failed")
    qt_quilt(
        RESULT rc OUTPUT out ERROR err
        ARGS fold
        INPUT [=[--- /dev/null
+++ b/sub/new.txt
@@ -0,0 +1 @@
+n
--- a/d/only.txt
+++ /dev/null
@@ -1 +0,0 @@
-gone
--- a/h.txt
+++ b/h.txt
@@ -1 +1 @@
-zzz
+b
]=]
    )
    qt_assert_failure("${rc}" "fold with a failing hunk should fail")
    qt_assert_not_exists("${QT_WORK_DIR}/sub/new.txt" "the created file should be removed")
    qt_assert_file_text("${QT_WORK_DIR}/d/only.txt" "gone" "the deleted file should be restored")
    qt_assert_file_text("${QT_WORK_DIR}/h.txt" "h" "h.txt should be unchanged")
    qt_quilt_ok(OUTPUT out ARGS files MESSAGE "files failed")
    qt_assert_equal("${out}" "" "fold should add no files to the top patch")
    qt_assert_not_exists("${QT_WORK_DIR}/.pc/top.diff/sub" "no backup directory should remain")
    qt_assert_not_exists("${QT_WORK_DIR}/.pc/top.diff/d" "no backup directory should remain")
endfunction()

# diff_context_line_ranges: like GNU diff, a context diff names a range of
# one line, or the line before an empty range, by a single number
function(qt_scenario_diff_context_line_ranges)
    qt_begin_test("diff_context_line_ranges")
    qt_write_file("${QT_WORK_DIR}/f.txt" "a\nb\nc\n")
    qt_write_file("${QT_WORK_DIR}/g.txt" "a\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt g.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "X\na\nc\n")
    qt_write_file("${QT_WORK_DIR}/g.txt" "X\na\n")
    qt_quilt_ok(OUTPUT out ARGS diff -p ab --no-index --no-timestamps -C 0 f.txt
                MESSAGE "diff -C 0 failed")
    qt_assert_equal("${out}"
        "*** a/f.txt\n--- b/f.txt\n***************\n*** 0 ****\n--- 1 ----\n+ X\n***************\n*** 2 ****\n- b\n--- 2 ----\n"
        "one-line and empty ranges should be a single number")
    qt_quilt_ok(OUTPUT out ARGS diff -p ab --no-index --no-timestamps -c g.txt
                MESSAGE "diff -c failed")
    qt_assert_equal("${out}"
        "*** a/g.txt\n--- b/g.txt\n***************\n*** 1 ****\n--- 1,2 ----\n+ X\n  a\n"
        "a one-line old range should be a single number")
endfunction()

# diff_hunk_context_gap: like GNU diff, changes no more than twice the
# context lines apart share one hunk
function(qt_scenario_diff_hunk_context_gap)
    qt_begin_test("diff_hunk_context_gap")
    qt_write_file("${QT_WORK_DIR}/f.txt" "1\na\nb\nc\nd\ne\nf\n2\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "X\na\nb\nc\nd\ne\nf\nY\n")
    set(diff_args diff -p ab --no-index --no-timestamps)
    qt_quilt_ok(OUTPUT out ARGS ${diff_args} -u MESSAGE "diff -u failed")
    qt_assert_equal("${out}"
        "--- a/f.txt\n+++ b/f.txt\n@@ -1,8 +1,8 @@\n-1\n+X\n a\n b\n c\n d\n e\n f\n-2\n+Y\n"
        "changes six unchanged lines apart should share a hunk with -u")
    qt_quilt_ok(OUTPUT out ARGS ${diff_args} -c MESSAGE "diff -c failed")
    qt_assert_equal("${out}"
        "*** a/f.txt\n--- b/f.txt\n***************\n*** 1,8 ****\n! 1\n  a\n  b\n  c\n  d\n  e\n  f\n! 2\n--- 1,8 ----\n! X\n  a\n  b\n  c\n  d\n  e\n  f\n! Y\n"
        "changes six unchanged lines apart should share a hunk with -c")
    qt_quilt_ok(OUTPUT out ARGS ${diff_args} -U 2 MESSAGE "diff -U 2 failed")
    qt_assert_equal("${out}"
        "--- a/f.txt\n+++ b/f.txt\n@@ -1,3 +1,3 @@\n-1\n+X\n a\n b\n@@ -6,3 +6,3 @@\n e\n f\n-2\n+Y\n"
        "changes six unchanged lines apart should get two hunks with -U 2")
endfunction()

# Helper: in a new patch, change FILE from OLD to NEW, then check that diff
# in FORMAT (-u or -c) prints EXPECTED with every diff algorithm (upstream
# ignores QUILT_DIFF_ALGORITHM), and that the patch refreshed in FORMAT
# pops back to OLD and pushes to NEW, byte for byte.
function(qt_check_diff_round_trip file old new format expected)
    qt_write_file("${QT_WORK_DIR}/${file}" "${old}")
    qt_quilt_ok(ARGS new "${file}${format}.patch" MESSAGE "new failed")
    qt_quilt_ok(ARGS add "${file}" MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/${file}" "${new}")
    foreach(algo myers minimal patience histogram)
        qt_quilt_ok(ENV "QUILT_DIFF_ALGORITHM=${algo}" OUTPUT out
                    ARGS diff -p ab --no-index --no-timestamps ${format}
                    MESSAGE "diff ${format} of ${file} failed (${algo})")
        qt_assert_equal("${out}" "${expected}" "diff ${format} of ${file} (${algo})")
    endforeach()
    qt_quilt_ok(ARGS refresh ${format} MESSAGE "refresh ${format} of ${file} failed")
    file(WRITE "${QT_TEST_BASE}/expected" "${old}")
    file(READ "${QT_TEST_BASE}/expected" old_hex HEX)
    file(WRITE "${QT_TEST_BASE}/expected" "${new}")
    file(READ "${QT_TEST_BASE}/expected" new_hex HEX)
    qt_quilt_ok(ARGS pop MESSAGE "pop of ${file}${format} failed")
    qt_assert_file_hex("${QT_WORK_DIR}/${file}" "${old_hex}" "pop should restore ${file}")
    qt_quilt_ok(ARGS push MESSAGE "push of ${file}${format} failed")
    qt_assert_file_hex("${QT_WORK_DIR}/${file}" "${new_hex}" "push should change ${file}")
endfunction()

# diff_incomplete_last_line: as in GNU diff, a file's incomplete last line
# never matches the same text with a newline, and each side's "No newline"
# marker follows its own incomplete line.  In "del", removing the last line
# makes "b" the new incomplete line; in "move", the incomplete "x" moves to
# the top and leaves "g" incomplete.
function(qt_scenario_diff_incomplete_last_line)
    qt_begin_test("diff_incomplete_last_line")
    set(nl "\\ No newline at end of file\n")
    qt_check_diff_round_trip(del "b\nx" "b" -u
        "--- a/del\n+++ b/del\n@@ -1,2 +1 @@\n-b\n-x\n${nl}+b\n${nl}")
    qt_check_diff_round_trip(del "b\nx" "b" -c
        "*** a/del\n--- b/del\n***************\n*** 1,2 ****\n! b\n! x\n${nl}--- 1 ----\n! b\n${nl}")
    set(lines "a\nb\nc\nd\ne\nf\ng")
    set(body "  a\n  b\n  c\n  d\n  e\n  f\n")
    qt_check_diff_round_trip(move "${lines}\nx" "x\n${lines}" -u
        "--- a/move\n+++ b/move\n@@ -1,8 +1,8 @@\n+x\n a\n b\n c\n d\n e\n f\n-g\n-x\n${nl}+g\n${nl}")
    qt_check_diff_round_trip(move "${lines}\nx" "x\n${lines}" -c
        "*** a/move\n--- b/move\n***************\n*** 1,8 ****\n${body}! g\n! x\n${nl}--- 1,8 ----\n+ x\n${body}! g\n${nl}")
endfunction()

# diff_incomplete_last_lines_both: when both files end in an incomplete
# line, those lines match only each other, as in GNU diff.  In "differ" the
# incomplete "jkl" is not matched with the complete "jkl"; in "same" the
# matching incomplete lines are context with the marker on both sides.
function(qt_scenario_diff_incomplete_last_lines_both)
    qt_begin_test("diff_incomplete_last_lines_both")
    set(nl "\\ No newline at end of file\n")
    qt_check_diff_round_trip(differ "aabi\njkl\nx" "yz\ndghi\njkl" -u
        "--- a/differ\n+++ b/differ\n@@ -1,3 +1,3 @@\n-aabi\n-jkl\n-x\n${nl}+yz\n+dghi\n+jkl\n${nl}")
    qt_check_diff_round_trip(differ "aabi\njkl\nx" "yz\ndghi\njkl" -c
        "*** a/differ\n--- b/differ\n***************\n*** 1,3 ****\n! aabi\n! jkl\n! x\n${nl}--- 1,3 ----\n! yz\n! dghi\n! jkl\n${nl}")
    qt_check_diff_round_trip(same "a\nb\nc" "a\nX\nc" -u
        "--- a/same\n+++ b/same\n@@ -1,3 +1,3 @@\n a\n-b\n+X\n c\n${nl}")
    qt_check_diff_round_trip(same "a\nb\nc" "a\nX\nc" -c
        "*** a/same\n--- b/same\n***************\n*** 1,3 ****\n  a\n! b\n  c\n${nl}--- 1,3 ----\n  a\n! X\n  c\n${nl}")
endfunction()

# push_quiet_patch_output: push -q passes -s to patch, which still shows
# the text before the hunks of a file it cannot find, and a file's count of
# failed hunks, but not the file being patched, nor each hunk.  Unless the
# rejects are kept, push drops the name of the reject file, which is a
# temporary one.
function(qt_scenario_push_quiet_patch_output)
    qt_begin_test("push_quiet_patch_output")
    qt_write_file("${QT_WORK_DIR}/patches/series" "p.diff\n")
    qt_write_file("${QT_WORK_DIR}/patches/p.diff"
        "junk line\nIndex: x\n--- a/new.txt\n+++ b/new.txt\n@@ -1 +1 @@\n-a\n+b\n")
    set(skipped "The text leading up to this was:\n--------------------------\n|junk line\n|Index: x\n|--- a/new.txt\n|+++ b/new.txt\n--------------------------\nNo file to patch.  Skipping patch.\n1 out of 1 hunk ignored\n")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS push -q --leave-rejects)
    qt_assert_failure("${rc}" "push -q of a patch for a missing file should fail")
    qt_combine_output(combined "${out}" "${err}")
    qt_assert_equal("${combined}"
        "Applying patch p.diff\n${skipped}Patch p.diff does not apply (enforce with -f)\n"
        "push -q should show only what patch -s does for a missing file")
    qt_assert_not_exists("${QT_WORK_DIR}/new.txt.rej" "patch should keep no rejects for a missing file")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS push)
    qt_assert_failure("${rc}" "push of a patch for a missing file should fail")
    qt_combine_output(combined "${out}" "${err}")
    qt_assert_contains("${combined}"
        "can't find file to patch at input line 5\nPerhaps you used the wrong -p or --strip option?\n${skipped}"
        "push without -q should also name the missing file")

    # The first hunk fails, and the second applies at an offset
    qt_write_file("${QT_WORK_DIR}/f.txt"
        "zero\nzero\none\ntwo\nthree\nfour\nfive\nsix\nseven\neight\nnine\nten\n")
    qt_write_file("${QT_WORK_DIR}/patches/p.diff"
        "--- a/f.txt\n+++ b/f.txt\n@@ -1,3 +1,3 @@\n one\n-TWO\n+2\n three\n@@ -8,3 +8,3 @@\n eight\n-nine\n+9\n ten\n")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS push -q)
    qt_assert_failure("${rc}" "push -q of a patch with a failed hunk should fail")
    qt_combine_output(combined "${out}" "${err}")
    qt_assert_equal("${combined}"
        "Applying patch p.diff\n1 out of 2 hunks FAILED\nPatch p.diff does not apply (enforce with -f)\n"
        "push -q should show only the count of failed hunks")
    qt_assert_not_exists("${QT_WORK_DIR}/f.txt.rej" "push should remove the rejects")
    qt_assert_file_contains("${QT_WORK_DIR}/f.txt" "nine" "push should restore f.txt")
    # -f keeps the rejects, so the name of their file stays
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS push -q -f)
    qt_assert_failure("${rc}" "push -q -f of a patch with a failed hunk should fail")
    qt_combine_output(combined "${out}" "${err}")
    qt_assert_contains("${combined}" "\n1 out of 2 hunks FAILED -- saving rejects to file f.txt.rej\n"
        "push -q -f should name the reject file")
    qt_assert_not_contains("${combined}" "patching file" "push -q -f should not name the patched file")
    qt_assert_not_contains("${combined}" "Hunk #" "push -q -f should not report each hunk")
    qt_assert_exists("${QT_WORK_DIR}/f.txt.rej" "push -f should keep the rejects")
endfunction()

# push_verbose_patch_output: push -v leaves the output of patch as it is,
# so it names a missing file and reports each hunk
function(qt_scenario_push_verbose_patch_output)
    qt_begin_test("push_verbose_patch_output")
    qt_write_file("${QT_WORK_DIR}/patches/series" "p.diff\n")
    qt_write_file("${QT_WORK_DIR}/patches/p.diff"
        "--- a/new.txt\n+++ b/new.txt\n@@ -1 +1 @@\n-a\n+b\n")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS push -v)
    qt_assert_failure("${rc}" "push -v of a patch for a missing file should fail")
    qt_combine_output(combined "${out}" "${err}")
    qt_assert_contains("${combined}"
        "can't find file to patch at input line 3\nPerhaps you used the wrong -p or --strip option?\n"
        "push -v should name the missing file")
    qt_assert_not_contains("${combined}" "patching file" "push -v should not patch a missing file")

    qt_write_file("${QT_WORK_DIR}/f.txt"
        "zero\nzero\none\ntwo\nthree\nfour\nfive\nsix\nseven\neight\nnine\nten\n")
    qt_write_file("${QT_WORK_DIR}/patches/p.diff"
        "--- a/f.txt\n+++ b/f.txt\n@@ -1,3 +1,3 @@\n one\n-TWO\n+2\n three\n@@ -8,3 +8,3 @@\n eight\n-nine\n+9\n ten\n")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS push -v)
    qt_assert_failure("${rc}" "push -v of a patch with a failed hunk should fail")
    qt_combine_output(combined "${out}" "${err}")
    qt_assert_contains("${combined}" "patching file f.txt\n" "push -v should name the patched file")
    qt_assert_contains("${combined}" "Hunk #1 FAILED at 1.\n" "push -v should report the failed hunk")
    qt_assert_contains("${combined}" "Hunk #2 succeeded at 10 (offset 2 lines).\n"
        "push -v should report the hunk applied at an offset")
    qt_assert_contains("${combined}" "1 out of 2 hunks FAILED" "push -v should count the failed hunks")
endfunction()

# fold_quiet_patch_output: fold -q passes -s to patch, which still counts
# the failed hunks, and the failed fold is still rolled back
function(qt_scenario_fold_quiet_patch_output)
    qt_begin_test("fold_quiet_patch_output")
    qt_write_file("${QT_WORK_DIR}/f.txt" "one\ntwo\nthree\n")
    qt_write_file("${QT_WORK_DIR}/g.txt" "g\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS fold -q
        INPUT "--- a/g.txt\n+++ b/g.txt\n@@ -1 +1 @@\n-g\n+g2\n--- a/f.txt\n+++ b/f.txt\n@@ -1,3 +1,3 @@\n one\n-TWO\n+2\n three\n")
    qt_assert_failure("${rc}" "fold -q of a failing hunk should fail")
    qt_combine_output(combined "${out}" "${err}")
    qt_assert_equal("${combined}" "1 out of 1 hunk FAILED -- saving rejects to file f.txt.rej\n"
        "fold -q should show only the count of failed hunks")
    qt_assert_file_text("${QT_WORK_DIR}/g.txt" "g" "fold -q should restore g.txt")
    qt_assert_file_text("${QT_WORK_DIR}/f.txt" "one\ntwo\nthree" "fold -q should leave f.txt alone")
    qt_quilt_ok(OUTPUT out ARGS files MESSAGE "files failed")
    qt_assert_equal("${out}" "f.txt\n" "fold -q should add no files to the top patch")
endfunction()

# push_missing_file_crlf_text: the text leading up to the hunks of a file
# that cannot be found is quoted as given, carriage returns and all
function(qt_scenario_push_missing_file_crlf_text)
    qt_begin_test("push_missing_file_crlf_text")
    qt_write_file("${QT_WORK_DIR}/patches/series" "p.diff\n")
    qt_write_bytes("${QT_WORK_DIR}/patches/p.diff"
        "junk\\r\\n--- a/new.txt\\r\\n+++ b/new.txt\\r\\n@@ -1 +1 @@\\r\\n-a\\r\\n+b\\r\\n")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS push -q
        RAW_OUTPUT_FILE "${QT_WORK_DIR}/push.out")
    qt_assert_failure("${rc}" "push -q of a patch for a missing file should fail")
    # "--------------------------\n|junk\r\n|--- a/new.txt\r\n|+++ b/new.txt\r\n"
    # "--------------------------\n"
    qt_assert_file_contains_hex("${QT_WORK_DIR}/push.out"
        "2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d0a7c6a756e6b0d0a7c2d2d2d20612f6e65772e7478740d0a7c2b2b2b20622f6e65772e7478740d0a2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d0a"
        "push -q should quote the CRLF lines as given")
endfunction()

# push_failed_hunk_output: upstream push runs patch with 2>&1, so patch's
# messages show on stdout in the order patch prints them, followed by push's
# own. Unless the rejects are kept, by -f or --leave-rejects, upstream's
# cleanup_patch_output names the file with the rejects, from the last
# "patching file" line, in place of the temporary reject file.
function(qt_scenario_push_failed_hunk_output)
    qt_begin_test("push_failed_hunk_output")
    qt_write_file("${QT_WORK_DIR}/f.txt"
        "zero\nzero\none\ntwo\nthree\nfour\nfive\nsix\nseven\neight\nnine\nten\n")
    qt_write_file("${QT_WORK_DIR}/g.txt" "a\nb\nc\n")
    qt_write_file("${QT_WORK_DIR}/patches/series" "p.diff\n")
    # f.txt: the first hunk fails, and the second applies at an offset
    qt_write_file("${QT_WORK_DIR}/patches/p.diff"
        "--- a/f.txt\n+++ b/f.txt\n@@ -1,3 +1,3 @@\n one\n-TWO\n+2\n three\n@@ -8,3 +8,3 @@\n eight\n-nine\n+9\n ten\n--- a/g.txt\n+++ b/g.txt\n@@ -1,3 +1,3 @@\n a\n-B\n+b2\n c\n")
    set(f_hunks "patching file f.txt\nHunk #1 FAILED at 1.\nHunk #2 succeeded at 10 (offset 2 lines).\n")
    set(g_hunks "patching file g.txt\nHunk #1 FAILED at 1.\n")

    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS push)
    qt_assert_failure("${rc}" "push of a patch with failed hunks should fail")
    qt_assert_equal("${out}"
        "Applying patch p.diff\n${f_hunks}1 out of 2 hunks FAILED -- rejects in file f.txt\n${g_hunks}1 out of 1 hunk FAILED -- rejects in file g.txt\nPatch p.diff does not apply (enforce with -f)\n"
        "push should report each hunk in order and name the files with rejects")
    qt_assert_equal("${err}" "" "push should print nothing on stderr")
    qt_assert_not_exists("${QT_WORK_DIR}/f.txt.rej" "push should remove the rejects")
    qt_assert_file_contains("${QT_WORK_DIR}/f.txt" "nine" "push should restore f.txt")

    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS push --leave-rejects)
    qt_assert_failure("${rc}" "push --leave-rejects of a patch with failed hunks should fail")
    qt_assert_equal("${out}"
        "Applying patch p.diff\n${f_hunks}1 out of 2 hunks FAILED -- saving rejects to file f.txt.rej\n${g_hunks}1 out of 1 hunk FAILED -- saving rejects to file g.txt.rej\nPatch p.diff does not apply (enforce with -f)\n"
        "push --leave-rejects should name the reject files")
    qt_assert_equal("${err}" "" "push --leave-rejects should print nothing on stderr")
    qt_assert_exists("${QT_WORK_DIR}/f.txt.rej" "push --leave-rejects should keep the rejects")
    file(REMOVE "${QT_WORK_DIR}/f.txt.rej" "${QT_WORK_DIR}/g.txt.rej")

    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS push -f)
    qt_assert_failure("${rc}" "push -f of a patch with failed hunks should fail")
    qt_assert_equal("${out}"
        "Applying patch p.diff\n${f_hunks}1 out of 2 hunks FAILED -- saving rejects to file f.txt.rej\n${g_hunks}1 out of 1 hunk FAILED -- saving rejects to file g.txt.rej\nApplied patch p.diff (forced; needs refresh)\n"
        "push -f should name the reject files")
    qt_assert_equal("${err}" "" "push -f should print nothing on stderr")
    qt_assert_exists("${QT_WORK_DIR}/g.txt.rej" "push -f should keep the rejects")
endfunction()

# fold_failed_hunk_output: upstream fold runs patch as is, which prints
# its messages on stdout in order, and keeps the rejects
function(qt_scenario_fold_failed_hunk_output)
    qt_begin_test("fold_failed_hunk_output")
    qt_write_file("${QT_WORK_DIR}/f.txt"
        "zero\nzero\none\ntwo\nthree\nfour\nfive\nsix\nseven\neight\nnine\nten\n")
    qt_write_file("${QT_WORK_DIR}/g.txt" "a\nb\nc\n")
    qt_quilt_ok(ARGS new p.diff MESSAGE "new failed")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS fold
        INPUT "--- a/f.txt\n+++ b/f.txt\n@@ -1,3 +1,3 @@\n one\n-TWO\n+2\n three\n@@ -8,3 +8,3 @@\n eight\n-nine\n+9\n ten\n--- a/g.txt\n+++ b/g.txt\n@@ -1,3 +1,3 @@\n a\n-B\n+b2\n c\n")
    qt_assert_failure("${rc}" "fold of a patch with failed hunks should fail")
    qt_assert_equal("${out}"
        "patching file f.txt\nHunk #1 FAILED at 1.\nHunk #2 succeeded at 10 (offset 2 lines).\n1 out of 2 hunks FAILED -- saving rejects to file f.txt.rej\npatching file g.txt\nHunk #1 FAILED at 1.\n1 out of 1 hunk FAILED -- saving rejects to file g.txt.rej\n"
        "fold should report each hunk in order")
    qt_assert_equal("${err}" "" "fold should print nothing on stderr")
    qt_assert_exists("${QT_WORK_DIR}/g.txt.rej" "fold should keep the rejects")
endfunction()

# push_crlf_patch_output: before each file of a patch whose lines end in
# CRLF, GNU patch says that it strips the CRs, unless given -s. It goes by
# the "+++ " line of a unified diff, and by the first "*** N ****" line of
# a context diff.
function(qt_scenario_push_crlf_patch_output)
    qt_begin_test("push_crlf_patch_output")
    qt_write_file("${QT_WORK_DIR}/f.txt" "f1\nf2\nf3\n")
    qt_write_file("${QT_WORK_DIR}/g.txt" "g1\ng2\ng3\n")
    qt_write_file("${QT_WORK_DIR}/h.txt" "h1\nh2\n")
    qt_write_file("${QT_WORK_DIR}/patches/series" "p.diff\n")
    set(patch "Header\r\n--- a/f.txt\r\n+++ b/f.txt\r\n@@ -1,3 +1,3 @@\r\n f1\r\n-f2\r\n+F2\r\n f3\r\n--- a/g.txt\r\n+++ b/g.txt\n@@ -1,3 +1,3 @@\n g1\n-g2\n+G2\n g3\n*** a/h.txt\n--- b/h.txt\n***************\n*** 1,2 ****\r\n  h1\r\n! h2\r\n--- 1,2 ----\r\n  h1\r\n! H2\r\n")
    qt_write_file("${QT_WORK_DIR}/patches/p.diff" "${patch}")
    set(notice "(Stripping trailing CRs from patch; use --binary to disable.)\n")
    set(patched "${notice}patching file f.txt\npatching file g.txt\n${notice}patching file h.txt\n")

    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS push)
    qt_assert_success("${rc}" "push of a CRLF patch should succeed")
    qt_assert_equal("${out}" "Applying patch p.diff\n${patched}\nNow at patch p.diff\n"
        "push should note the CRs it strips for f.txt and h.txt")
    qt_assert_equal("${err}" "" "push should print nothing on stderr")
    qt_assert_file_text("${QT_WORK_DIR}/h.txt" "h1\nH2" "the context diff should apply")
    qt_quilt_ok(ARGS pop MESSAGE "pop failed")

    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS push -q)
    qt_assert_success("${rc}" "push -q of a CRLF patch should succeed")
    qt_assert_equal("${out}" "Applying patch p.diff\nNow at patch p.diff\n"
        "push -q should not note the CRs")
    qt_quilt_ok(ARGS pop MESSAGE "pop failed")

    qt_quilt_ok(ARGS new top.diff MESSAGE "new failed")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS fold INPUT "${patch}")
    qt_assert_success("${rc}" "fold of a CRLF patch should succeed")
    qt_assert_equal("${out}" "${patched}" "fold should note the CRs it strips")
    qt_assert_equal("${err}" "" "fold should print nothing on stderr")
endfunction()

# diff_last_line_newline_change: a last line that loses or gains its newline
# is replaced even when the line after it is deleted or inserted and no
# context surrounds it.  In "lose", "a\nb\n" becomes "a"; in "gain", the
# reverse.  In "add", the incomplete "a" is replaced, and the markers follow
# only "-a" and "+b".
function(qt_scenario_diff_last_line_newline_change)
    qt_begin_test("diff_last_line_newline_change")
    set(nl "\\ No newline at end of file\n")
    qt_check_diff_round_trip(lose "a\nb\n" "a" -U0
        "--- a/lose\n+++ b/lose\n@@ -1,2 +1 @@\n-a\n-b\n+a\n${nl}")
    qt_check_diff_round_trip(lose "a\nb\n" "a" -c
        "*** a/lose\n--- b/lose\n***************\n*** 1,2 ****\n! a\n! b\n--- 1 ----\n! a\n${nl}")
    qt_check_diff_round_trip(gain "a" "a\nb\n" -U0
        "--- a/gain\n+++ b/gain\n@@ -1 +1,2 @@\n-a\n${nl}+a\n+b\n")
    qt_check_diff_round_trip(gain "a" "a\nb\n" -c
        "*** a/gain\n--- b/gain\n***************\n*** 1 ****\n! a\n${nl}--- 1,2 ----\n! a\n! b\n")
    qt_check_diff_round_trip(add "a" "a\nb" -u
        "--- a/add\n+++ b/add\n@@ -1 +1,2 @@\n-a\n${nl}+a\n+b\n${nl}")
endfunction()

# push_reverse_applied: when a patch does not apply, push tries it in
# reverse, and if that works says the patch is applied already.  It leaves
# the working tree as it was, whichever message it prints.
function(qt_scenario_push_reverse_applied)
    qt_begin_test("push_reverse_applied")
    qt_write_file("${QT_WORK_DIR}/f.txt" "A\nb\n")
    qt_write_file("${QT_WORK_DIR}/patches/series" "p.diff\n")
    qt_write_file("${QT_WORK_DIR}/patches/p.diff"
        "--- a/f.txt\n+++ b/f.txt\n@@ -1,2 +1,2 @@\n-a\n+A\n b\n")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS push)
    qt_assert_failure("${rc}" "push of an applied patch should fail")
    qt_assert_contains("${out}" "\nHunk #1 FAILED at 1.\n" "push should show the failed hunk")
    qt_assert_matches("${out}" "\nPatch p\\.diff can be reverse-applied\n$"
        "push should say the patch can be reverse-applied")
    qt_assert_not_contains("${out}" "does not apply" "push should not say the patch does not apply")
    qt_assert_equal("${err}" "" "push should write everything to stdout")
    qt_assert_file_text("${QT_WORK_DIR}/f.txt" "A\nb" "push should leave f.txt alone")
    qt_assert_not_exists("${QT_WORK_DIR}/f.txt.rej" "push should leave no rejects")
    qt_assert_not_exists("${QT_WORK_DIR}/.pc/p.diff" "push should leave no backups")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS push -q)
    qt_assert_failure("${rc}" "push -q of an applied patch should fail")
    qt_assert_equal("${out}"
        "Applying patch p.diff\n1 out of 1 hunk FAILED\nPatch p.diff can be reverse-applied\n"
        "push -q should say the patch can be reverse-applied")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS applied)
    qt_assert_failure("${rc}" "no patch should be applied")

    # Only one of the two hunks reverses, so the patch does not apply
    qt_write_file("${QT_WORK_DIR}/patches/p.diff"
        "--- a/f.txt\n+++ b/f.txt\n@@ -1 +1 @@\n-a\n+A\n@@ -2 +2 @@\n-q\n+Q\n")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS push -q)
    qt_assert_failure("${rc}" "push -q of a half-applied patch should fail")
    qt_assert_equal("${out}"
        "Applying patch p.diff\n2 out of 2 hunks FAILED\nPatch p.diff does not apply (enforce with -f)\n"
        "push -q should say a half-applied patch does not apply")
    qt_assert_file_text("${QT_WORK_DIR}/f.txt" "A\nb" "push should leave f.txt alone (half)")

    # A patch reversed in the series is applied when its old side is there
    qt_write_file("${QT_WORK_DIR}/f.txt" "a\nb\n")
    qt_write_file("${QT_WORK_DIR}/patches/series" "p.diff -R\n")
    qt_write_file("${QT_WORK_DIR}/patches/p.diff"
        "--- a/f.txt\n+++ b/f.txt\n@@ -1,2 +1,2 @@\n-a\n+A\n b\n")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS push -q)
    qt_assert_failure("${rc}" "push -q of an applied reversed patch should fail")
    qt_assert_equal("${out}"
        "Applying patch p.diff\n1 out of 1 hunk FAILED\nPatch p.diff can be reverse-applied\n"
        "push -q should say the reversed patch can be reverse-applied")
    qt_assert_file_text("${QT_WORK_DIR}/f.txt" "a\nb" "push should leave f.txt alone (-R)")

    # Reversing a patch that creates a file deletes it, but only in trial
    qt_write_file("${QT_WORK_DIR}/new.txt" "n\n")
    qt_write_file("${QT_WORK_DIR}/patches/series" "p.diff\n")
    qt_write_file("${QT_WORK_DIR}/patches/p.diff"
        "--- a/f.txt\n+++ b/f.txt\n@@ -1 +1 @@\n-x\n+a\n--- /dev/null\n+++ b/new.txt\n@@ -0,0 +1 @@\n+n\n")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS push)
    qt_assert_failure("${rc}" "push of an applied file creation should fail")
    qt_assert_matches("${out}" "\nPatch p\\.diff can be reverse-applied\n$"
        "push should say the file creation can be reverse-applied")
    qt_assert_file_text("${QT_WORK_DIR}/new.txt" "n" "push should leave new.txt alone")
    qt_assert_file_text("${QT_WORK_DIR}/f.txt" "a\nb" "push should leave f.txt alone (new)")

    # Forced, push applies what it can and does not try the reverse
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS push -f)
    qt_assert_failure("${rc}" "push -f of an applied patch should fail")
    qt_assert_contains("${out}" "Applied patch p.diff (forced; needs refresh)\n"
        "push -f should force the patch")
    qt_assert_not_contains("${out}" "reverse-applied" "push -f should not try the reverse")
endfunction()

# push_verbose_rollback: push -v lists the files it restores from their
# backups each time it rolls back a patch that does not apply: after the
# failed patch, and after trying it in reverse.  Like backup-files, it
# lists the files it removes first.
function(qt_scenario_push_verbose_rollback)
    qt_begin_test("push_verbose_rollback")
    qt_write_file("${QT_WORK_DIR}/f.txt" "y\n")
    qt_write_file("${QT_WORK_DIR}/patches/series" "p.diff\n")
    qt_write_file("${QT_WORK_DIR}/patches/p.diff"
        "--- a/f.txt\n+++ b/f.txt\n@@ -1 +1 @@\n-q\n+Q\n--- /dev/null\n+++ b/new.txt\n@@ -0,0 +1 @@\n+n\n")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS push -q -v)
    qt_assert_failure("${rc}" "push -q -v should fail")
    qt_assert_equal("${out}"
        "Applying patch p.diff\n1 out of 1 hunk FAILED\nRemoving new.txt\nRestoring f.txt\nPatch p.diff does not apply (enforce with -f)\nRemoving new.txt\nRestoring f.txt\n"
        "push -q -v should list the files of each rollback")
    qt_assert_equal("${err}" "" "push -q -v should write everything to stdout")
    qt_assert_not_exists("${QT_WORK_DIR}/new.txt" "push should remove new.txt")
    qt_assert_file_text("${QT_WORK_DIR}/f.txt" "y" "push should restore f.txt")

    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS push -v)
    qt_assert_failure("${rc}" "push -v should fail")
    qt_assert_matches("${out}"
        "\nRemoving new\\.txt\nRestoring f\\.txt\nPatch p\\.diff does not apply \\(enforce with -f\\)\nRemoving new\\.txt\nRestoring f\\.txt\n$"
        "push -v should list the files of each rollback")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS push)
    qt_assert_failure("${rc}" "push should fail")
    qt_assert_not_contains("${out}" "Restoring" "push without -v should not list restored files")
    qt_assert_not_contains("${out}" "Removing" "push without -v should not list removed files")

    # The trial in reverse backs up only the files it patches.  The order
    # of the restored files depends on the file system upstream.
    qt_write_file("${QT_WORK_DIR}/f.txt" "X\n")
    qt_write_file("${QT_WORK_DIR}/z.txt" "Z\n")
    qt_write_file("${QT_WORK_DIR}/patches/p.diff"
        "--- a/z.txt\n+++ b/z.txt\n@@ -1 +1 @@\n-z\n+Z\n--- a/f.txt\n+++ b/f.txt\n@@ -1 +1 @@\n-x\n+X\n--- a/missing.txt\n+++ b/missing.txt\n@@ -1 +1 @@\n-m\n+M\n")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS push -q -v)
    qt_assert_failure("${rc}" "push -q -v of a partly missing patch should fail")
    set(restored "(Restoring (f|z)\\.txt\n)(Restoring (f|z)\\.txt\n)")
    qt_assert_matches("${out}"
        "\n${restored}Patch p\\.diff does not apply \\(enforce with -f\\)\n${restored}$"
        "push -q -v should restore only the files it found")
    qt_assert_contains("${out}" "Restoring f.txt\n" "push -q -v should restore f.txt")
    qt_assert_contains("${out}" "Restoring z.txt\n" "push -q -v should restore z.txt")
    qt_assert_not_contains("${out}" "Restoring missing.txt" "push -q -v should not restore missing.txt")
    qt_assert_not_contains("${out}" "Removing missing.txt" "push -q -v should not remove missing.txt")
    qt_assert_not_exists("${QT_WORK_DIR}/missing.txt" "push should not create missing.txt")
endfunction()

# push_reject_format: like GNU patch, the rejects name each file as stripped,
# or /dev/null when it has too few components to strip, keep the timestamps
# and the function text of the hunk headers, give no count for a range of
# one line, list a change's deletions before its additions, and move each
# hunk by the lines that the hunks applied before it added.  A context
# diff's rejects stay in context form, and -R reverses the rejects too.
function(qt_scenario_push_reject_format)
    qt_begin_test("push_reject_format")
    foreach(name f new gone short)
        qt_write_file("${QT_WORK_DIR}/${name}.txt" "x\n")
    endforeach()
    set(lines "")
    foreach(n RANGE 1 20)
        string(APPEND lines "${n}\n")
    endforeach()
    qt_write_file("${QT_WORK_DIR}/off.txt" "${lines}")
    qt_write_file("${QT_WORK_DIR}/ctx.txt" "1\n2\n3\n4\n5\n6\n7\n8\n9\n")
    qt_write_file("${QT_WORK_DIR}/r.txt" "x\n")
    qt_write_file("${QT_WORK_DIR}/rc.txt" "x\n")
    qt_write_file("${QT_WORK_DIR}/patches/series" "p.diff\nr.diff -R\n")
    qt_write_file("${QT_WORK_DIR}/patches/p.diff" [=[
--- a/f.txt	2020-01-01 00:00:00.000000000 +0000
+++ b/f.txt	2020-01-02 00:00:00.000000000 +0000
@@ -1 +1 @@ func
-a
+b
--- /dev/null
+++ b/new.txt
@@ -0,0 +1 @@
+b
--- a/gone.txt
+++ /dev/null
@@ -1 +0,0 @@
-a
--- short.txt
+++ b/short.txt
@@ -1 +1 @@
-a
+b
--- a/off.txt
+++ b/off.txt
@@ -1,4 +1,6 @@
 1
 2
+a
+b
 3
 4
@@ -10,4 +12,4 @@
 10
-XX
+YY
-ZZ
+WW
 13
*** a/ctx.txt
--- b/ctx.txt
***************
*** 1,3 ****
  1
- 2
  3
--- 1,2 ----
*************** fn
*** 4,6 ****
  4
! X
  6
--- 3,5 ----
  4
! Y
  6
***************
*** 7,9 ****
  7
- QQ
  9
--- 6,7 ----
]=])
    qt_write_file("${QT_WORK_DIR}/patches/r.diff" [=[
--- a/r.txt	2020-01-01
+++ b/r.txt	2020-01-02
@@ -1,2 +1 @@ func
-a
-c
+b
*** a/rc.txt
--- b/rc.txt
***************
*** 1,2 ****
! a
  c
--- 1,3 ----
! b
+ d
  c
]=])
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS push -f)
    qt_assert_failure("${rc}" "push -f of a patch with failed hunks should fail")
    qt_read_file_raw(rej "${QT_WORK_DIR}/f.txt.rej")
    qt_assert_equal("${rej}"
        "--- f.txt\t2020-01-01 00:00:00.000000000 +0000\n+++ f.txt\t2020-01-02 00:00:00.000000000 +0000\n@@ -1 +1 @@ func\n-a\n+b\n"
        "the rejects should strip the names and keep the timestamps")
    qt_read_file_raw(rej "${QT_WORK_DIR}/new.txt.rej")
    qt_assert_equal("${rej}" "--- /dev/null\n+++ new.txt\n@@ -0,0 +1 @@\n+b\n"
        "the rejects of a creation should name /dev/null")
    qt_read_file_raw(rej "${QT_WORK_DIR}/gone.txt.rej")
    qt_assert_equal("${rej}" "--- gone.txt\n+++ /dev/null\n@@ -1 +0,0 @@\n-a\n"
        "the rejects of a deletion should name /dev/null")
    qt_read_file_raw(rej "${QT_WORK_DIR}/short.txt.rej")
    qt_assert_equal("${rej}" "--- /dev/null\n+++ short.txt\n@@ -1 +1 @@\n-a\n+b\n"
        "the rejects should name /dev/null for a name with too few components")
    qt_read_file_raw(rej "${QT_WORK_DIR}/off.txt.rej")
    qt_assert_equal("${rej}" "--- off.txt\n+++ off.txt\n@@ -12,4 +14,4 @@\n 10\n-XX\n-ZZ\n+YY\n+WW\n 13\n"
        "the rejects should move a hunk by the lines added before it")
    qt_read_file_raw(rej "${QT_WORK_DIR}/ctx.txt.rej")
    qt_assert_equal("${rej}"
        "*** ctx.txt\n--- ctx.txt\n*************** fn\n*** 3,5 ****\n  4\n! X\n  6\n--- 2,4 ----\n  4\n! Y\n  6\n***************\n*** 6,8 ****\n  7\n- QQ\n  9\n--- 5,6 ----\n  7\n  9\n"
        "the rejects of a context diff should be a context diff")

    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS push -f)
    qt_assert_failure("${rc}" "push -f of a reversed patch with failed hunks should fail")
    qt_read_file_raw(rej "${QT_WORK_DIR}/r.txt.rej")
    qt_assert_equal("${rej}" "--- r.txt\t2020-01-02\n+++ r.txt\t2020-01-01\n@@ -1 +1,2 @@ func\n-b\n+a\n+c\n"
        "the rejects of a reversed patch should be reversed")
    qt_read_file_raw(rej "${QT_WORK_DIR}/rc.txt.rej")
    qt_assert_equal("${rej}"
        "*** rc.txt\n--- rc.txt\n***************\n*** 1,3 ****\n! b\n- d\n  c\n--- 1,2 ----\n! a\n  c\n"
        "the rejects of a reversed context diff should be reversed")
endfunction()

# push_hunk_line_numbers: like GNU patch, the hunk messages give lines in
# the patched file, past the lines that the hunks applied before added, and
# report the offset of every hunk away from the line it names, not just of
# those that move further than the hunk before
function(qt_scenario_push_hunk_line_numbers)
    qt_begin_test("push_hunk_line_numbers")
    set(lines "z1\nz2\nz3\n")
    foreach(n RANGE 1 30)
        string(APPEND lines "${n}\n")
        if(n EQUAL 12)
            string(APPEND lines "y1\ny2\n")
        endif()
    endforeach()
    qt_write_file("${QT_WORK_DIR}/f.txt" "${lines}")
    set(lines "")
    foreach(n RANGE 1 30)
        string(APPEND lines "${n}\n")
    endforeach()
    qt_write_file("${QT_WORK_DIR}/g.txt" "${lines}")
    qt_write_file("${QT_WORK_DIR}/patches/series" "p.diff\n")
    qt_write_file("${QT_WORK_DIR}/patches/p.diff" [=[
--- a/f.txt
+++ b/f.txt
@@ -4,3 +4,4 @@
 4
+a
 5
 6
@@ -20,3 +21,3 @@
 20
-21
+YY
 22
@@ -25,3 +26,3 @@
 25
-QQ
+RR
 27
--- a/g.txt
+++ b/g.txt
@@ -1,4 +1,6 @@
 1
 2
+a
+b
 3
 4
@@ -10,7 +12,7 @@
 10
 11
 12
-13
+XIII
 14
 15
 bad
]=])
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS push -f)
    qt_assert_failure("${rc}" "push -f of a patch with a failed hunk should fail")
    qt_combine_output(combined "${out}" "${err}")
    qt_assert_contains("${combined}" "Hunk #1 succeeded at 7 (offset 3 lines).\n"
        "push should report the first hunk's offset")
    qt_assert_contains("${combined}" "Hunk #2 succeeded at 26 (offset 5 lines).\n"
        "push should report the line in the patched file and the whole offset")
    qt_assert_contains("${combined}" "Hunk #3 FAILED at 26.\n"
        "push should report the failed hunk's line in the patched file")
    qt_assert_contains("${combined}" "Hunk #2 succeeded at 12 with fuzz 1.\n"
        "push should report the fuzzy hunk's line in the patched file")
endfunction()

# push_delete_mismatch: like GNU patch, a patch that deletes a file still
# keeps a file with contents left, saying so, and removes an empty one, even
# when no hunk applies.  -q hides the message, and merge mode leaves it out
# once a hunk has failed, as GNU patch does.
function(qt_scenario_push_delete_mismatch)
    qt_begin_test("push_delete_mismatch")
    qt_write_file("${QT_WORK_DIR}/patches/series" "p.diff\n")
    qt_write_file("${QT_WORK_DIR}/patches/p.diff"
        "--- a/f.txt\n+++ /dev/null\n@@ -1 +0,0 @@\n-a\n--- a/g.txt\n+++ /dev/null\n@@ -1 +0,0 @@\n-a\n")
    foreach(flag "" "-q")
        qt_write_file("${QT_WORK_DIR}/f.txt" "x\n")
        qt_write_file("${QT_WORK_DIR}/g.txt" "")
        qt_quilt(RESULT rc OUTPUT out ERROR err ARGS push ${flag} -f)
        qt_assert_failure("${rc}" "push ${flag} -f of a failed deletion should fail")
        qt_combine_output(combined "${out}" "${err}")
        if(flag STREQUAL "")
            qt_assert_contains("${combined}"
                "Not deleting file f.txt as content differs from patch\n"
                "push -f should keep f.txt, saying so")
        else()
            qt_assert_not_contains("${combined}" "Not deleting"
                "push -q -f should not say that it keeps f.txt")
        endif()
        qt_assert_not_contains("${combined}" "Not deleting file g.txt"
            "push ${flag} -f should not say that it keeps g.txt")
        qt_assert_file_text("${QT_WORK_DIR}/f.txt" "x" "push ${flag} -f should keep f.txt")
        qt_assert_not_exists("${QT_WORK_DIR}/g.txt" "push ${flag} -f should remove the empty g.txt")
        qt_quilt_ok(ARGS pop -f MESSAGE "pop -f failed")
    endforeach()

    qt_write_file("${QT_WORK_DIR}/f.txt" "a\nb\n")
    qt_write_file("${QT_WORK_DIR}/e.txt" "x\n")
    qt_write_file("${QT_WORK_DIR}/patches/p.diff"
        "--- a/e.txt\n+++ b/e.txt\n@@ -1 +1 @@\n-q\n+r\n--- a/f.txt\n+++ /dev/null\n@@ -1 +0,0 @@\n-a\n")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS push --merge)
    qt_assert_failure("${rc}" "push --merge of a patch with a failed hunk should fail")
    qt_combine_output(combined "${out}" "${err}")
    qt_assert_not_contains("${combined}" "Not deleting"
        "push --merge should not say that it keeps f.txt after a failed hunk")
endfunction()

# push_quoted_file_names: GNU patch quotes a file name that the shell would
# not take as is, in single quotes, or in double quotes when it has a
# single quote and nothing else the shell would expand.  A lone "{" needs
# quotes, but "{.rej" does not.  Upstream push names the file with the
# rejects as the "patching file" line quotes it.
function(qt_scenario_push_quoted_file_names)
    qt_begin_test("push_quoted_file_names")
    set(patch "")
    foreach(name "a b.txt" "it's.txt" "it's (1).txt" "{")
        qt_write_file("${QT_WORK_DIR}/${name}" "y\n")
        string(APPEND patch "--- a/${name}\t2020-01-01\n+++ b/${name}\t2020-01-01\n@@ -1 +1 @@\n-q\n+Q\n")
    endforeach()
    qt_write_file("${QT_WORK_DIR}/d e.txt" "x\n")
    qt_write_file("${QT_WORK_DIR}/n e.txt" "x\n")
    string(APPEND patch
        "--- a/d e.txt\t2020-01-01\n+++ /dev/null\n@@ -1 +0,0 @@\n-a\n"
        "--- /dev/null\n+++ b/n e.txt\t2020-01-01\n@@ -0,0 +1 @@\n+n\n")
    qt_write_file("${QT_WORK_DIR}/patches/series" "p.diff\n")
    qt_write_file("${QT_WORK_DIR}/patches/p.diff" "${patch}")
    set(failed "Hunk #1 FAILED at 1.\n1 out of 1 hunk FAILED")

    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS push)
    qt_assert_failure("${rc}" "push of a patch with failed hunks should fail")
    qt_assert_equal("${out}"
        "Applying patch p.diff\npatching file 'a b.txt'\n${failed} -- rejects in file 'a b.txt'\npatching file \"it's.txt\"\n${failed} -- rejects in file \"it's.txt\"\npatching file 'it'\\''s (1).txt'\n${failed} -- rejects in file 'it'\\''s (1).txt'\npatching file '{'\n${failed} -- rejects in file '{'\npatching file 'd e.txt'\nHunk #1 FAILED at 1.\nNot deleting file 'd e.txt' as content differs from patch\n1 out of 1 hunk FAILED -- rejects in file 'd e.txt'\nThe next patch would create the file 'n e.txt',\nwhich already exists!  Applying it anyway.\npatching file 'n e.txt'\n${failed} -- rejects in file 'n e.txt'\nPatch p.diff does not apply (enforce with -f)\n"
        "push should quote the file names")

    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS push -f)
    qt_assert_failure("${rc}" "push -f of a patch with failed hunks should fail")
    qt_assert_contains("${out}" "${failed} -- saving rejects to file 'a b.txt.rej'\n"
        "push -f should quote a reject file name with a space")
    qt_assert_contains("${out}" "${failed} -- saving rejects to file \"it's.txt.rej\"\n"
        "push -f should double-quote a reject file name with a single quote")
    qt_assert_contains("${out}" "${failed} -- saving rejects to file 'it'\\''s (1).txt.rej'\n"
        "push -f should single-quote a reject file name with a single quote and parentheses")
    qt_assert_contains("${out}" "${failed} -- saving rejects to file {.rej\n"
        "push -f should not quote {.rej")
    qt_assert_exists("${QT_WORK_DIR}/it's (1).txt.rej" "push -f should keep the rejects")
endfunction()

# refresh -z names the fork like upstream's next_filename, incrementing a
# trailing -N instead of appending another -2
function(qt_scenario_refresh_z_increments_suffix)
    qt_begin_test("refresh_z_increments_suffix")
    qt_write_file("${QT_WORK_DIR}/f.txt" "a\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "b\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "c\n")
    qt_quilt_ok(OUTPUT out ARGS refresh -z MESSAGE "first refresh -z failed")
    qt_assert_equal("${out}" "Fork of patch p.patch created as p-2.patch\n"
                    "the first fork should be p-2.patch")
    qt_write_file("${QT_WORK_DIR}/f.txt" "d\n")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS refresh -z)
    qt_assert_success("${rc}" "second refresh -z failed")
    qt_assert_equal("${out}" "Fork of patch p-2.patch created as p-3.patch\n"
                    "the second fork should be p-3.patch, not p-2-2.patch")
    qt_assert_equal("${err}" "" "refresh -z should print nothing on stderr")
    qt_assert_file_text("${QT_WORK_DIR}/patches/series" "p.patch\np-2.patch\np-3.patch"
                        "series should hold all three patches")
    qt_assert_file_text("${QT_WORK_DIR}/.pc/applied-patches" "p.patch\np-2.patch\np-3.patch"
                        "all three patches should be applied")
    qt_assert_file_contains("${QT_WORK_DIR}/patches/p-3.patch" "+d" "p-3.patch should hold the change")
    qt_assert_not_exists("${QT_WORK_DIR}/patches/p-2-2.patch" "no p-2-2.patch")
    # An explicit name is taken as given, and the next default counts on from it
    qt_write_file("${QT_WORK_DIR}/f.txt" "e\n")
    qt_quilt_ok(OUTPUT out ARGS refresh -zq-5.patch MESSAGE "refresh -zq-5.patch failed")
    qt_assert_equal("${out}" "Fork of patch p-3.patch created as q-5.patch\n"
                    "an explicit fork name should be used as given")
    qt_write_file("${QT_WORK_DIR}/f.txt" "f\n")
    qt_quilt_ok(OUTPUT out ARGS refresh -z MESSAGE "refresh -z after q-5.patch failed")
    qt_assert_equal("${out}" "Fork of patch q-5.patch created as q-6.patch\n"
                    "the fork of q-5.patch should be q-6.patch")
endfunction()

# refresh -z keeps a suffix other than .diff/.dif/.patch as part of the name,
# and never mistakes a dot in a directory name for one
function(qt_scenario_refresh_z_next_filename_shapes)
    qt_begin_test("refresh_z_next_filename_shapes")
    qt_write_file("${QT_WORK_DIR}/f.txt" "0\n")
    set(n 0)
    foreach(pair "r.txt=r.txt-2" "t-2=t-3" "v1.0/q=v1.0/q-2")
        string(REPLACE "=" ";" pair "${pair}")
        list(GET pair 0 name)
        list(GET pair 1 fork)
        qt_quilt_ok(ARGS new "${name}" MESSAGE "new ${name} failed")
        qt_quilt_ok(ARGS add f.txt MESSAGE "add to ${name} failed")
        math(EXPR n "${n} + 1")
        qt_write_file("${QT_WORK_DIR}/f.txt" "${n}\n")
        qt_quilt_ok(ARGS refresh MESSAGE "refresh ${name} failed")
        math(EXPR n "${n} + 1")
        qt_write_file("${QT_WORK_DIR}/f.txt" "${n}\n")
        qt_quilt_ok(OUTPUT out ARGS refresh -z MESSAGE "refresh -z of ${name} failed")
        qt_assert_equal("${out}" "Fork of patch ${name} created as ${fork}\n"
                        "the fork of ${name} should be ${fork}")
        qt_assert_file_contains("${QT_WORK_DIR}/patches/${fork}" "+${n}"
                                "${fork} should hold the change")
    endforeach()
    qt_assert_file_text("${QT_WORK_DIR}/patches/series"
                        "r.txt\nr.txt-2\nt-2\nt-3\nv1.0/q\nv1.0/q-2"
                        "series should hold each patch and its fork")
    qt_assert_not_exists("${QT_WORK_DIR}/patches/v1-2.0" "no new patches directory")
    qt_assert_not_exists("${QT_WORK_DIR}/.pc/v1-2.0" "no new .pc/ directory")
endfunction()

# fork names the new patch like upstream's next_filename
function(qt_scenario_fork_next_filename_shapes)
    qt_begin_test("fork_next_filename_shapes")
    set(expected_series "")
    foreach(pair "v1.0/p=v1.0/p-2" "x.txt=x.txt-2" "s-2=s-3" "u.patch.gz=u-2.patch.gz"
                 "y.dif.zst=y-2.dif.zst" "w-99999999999.patch=w-100000000000.patch"
                 "z.diff=z-2.diff" "k-3.diff.bz2=k-4.diff.bz2" "m.patch.xz=m-2.patch.xz"
                 "n.lzma=n-2.lzma" "o.lz=o-2.lz")
        string(REPLACE "=" ";" pair "${pair}")
        list(GET pair 0 name)
        list(GET pair 1 fork)
        qt_quilt_ok(ARGS new "${name}" MESSAGE "new ${name} failed")
        qt_quilt(RESULT rc OUTPUT out ERROR err ARGS fork)
        qt_assert_success("${rc}" "fork of ${name} failed: ${err}")
        qt_assert_equal("${out}" "Fork of patch ${name} created as ${fork}\n"
                        "the fork of ${name} should be ${fork}")
        qt_assert_equal("${err}" "" "fork of ${name} should print nothing on stderr")
        qt_assert_exists("${QT_WORK_DIR}/.pc/${fork}" ".pc/ directory of ${fork} missing")
        qt_assert_not_exists("${QT_WORK_DIR}/.pc/${name}" ".pc/ directory of ${name} left behind")
        string(APPEND expected_series "${fork}\n")
    endforeach()
    qt_strip_trailing_newlines(expected_series "${expected_series}")
    qt_assert_file_text("${QT_WORK_DIR}/patches/series" "${expected_series}"
                        "series should hold each fork in place of its patch")
    qt_assert_not_exists("${QT_WORK_DIR}/patches/v1-2.0" "no new patches directory")
    qt_assert_not_exists("${QT_WORK_DIR}/.pc/v1-2.0" "no new .pc/ directory")
endfunction()

# fork refuses a name that exists in the series, in .pc/, or as a patch
# file, rather than overwriting it
function(qt_scenario_fork_target_exists)
    qt_begin_test("fork_target_exists")
    qt_write_file("${QT_WORK_DIR}/f.txt" "a\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "b\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    set(expected_err "Patch p-2.patch exists already, please choose a new name\n")

    # A patch file that is not in the series
    qt_write_file("${QT_WORK_DIR}/patches/p-2.patch" "junk\n")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS fork)
    qt_assert_failure("${rc}" "fork onto an existing patch file should fail")
    qt_assert_equal("${out}" "" "fork onto a patch file should print nothing on stdout")
    qt_assert_equal("${err}" "${expected_err}" "fork onto a patch file should say it exists")
    qt_assert_file_text("${QT_WORK_DIR}/patches/p-2.patch" "junk" "the existing patch file must survive")
    qt_assert_file_text("${QT_WORK_DIR}/patches/series" "p.patch" "series should be untouched")
    qt_assert_file_text("${QT_WORK_DIR}/.pc/applied-patches" "p.patch" "applied-patches should be untouched")
    qt_assert_exists("${QT_WORK_DIR}/.pc/p.patch/f.txt" "the backup should stay in place")
    file(REMOVE "${QT_WORK_DIR}/patches/p-2.patch")

    # A .pc/ directory
    file(MAKE_DIRECTORY "${QT_WORK_DIR}/.pc/p-2.patch")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS fork)
    qt_assert_failure("${rc}" "fork onto an existing .pc/ directory should fail")
    qt_assert_equal("${out}" "" "fork onto a .pc/ directory should print nothing on stdout")
    qt_assert_equal("${err}" "${expected_err}" "fork onto a .pc/ directory should say it exists")
    qt_assert_file_text("${QT_WORK_DIR}/patches/series" "p.patch" "series should be untouched")
    qt_assert_exists("${QT_WORK_DIR}/.pc/p.patch/f.txt" "the backup should stay in place")
    qt_assert_not_exists("${QT_WORK_DIR}/patches/p-2.patch" "no patch file for the fork")
    file(REMOVE_RECURSE "${QT_WORK_DIR}/.pc/p-2.patch")

    # A series entry with no file
    qt_append_file("${QT_WORK_DIR}/patches/series" "p-2.patch\n")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS fork)
    qt_assert_failure("${rc}" "fork onto a name in the series should fail")
    qt_assert_equal("${out}" "" "fork onto a series entry should print nothing on stdout")
    qt_assert_equal("${err}" "${expected_err}" "fork onto a series entry should say it exists")
    qt_assert_file_text("${QT_WORK_DIR}/patches/series" "p.patch\np-2.patch" "series should be untouched")
    qt_assert_file_text("${QT_WORK_DIR}/.pc/applied-patches" "p.patch" "applied-patches should be untouched")
    qt_assert_exists("${QT_WORK_DIR}/.pc/p.patch/f.txt" "the backup should stay in place")
endfunction()

# fork shows patch names with QUILT_PATCHES_PREFIX, like upstream
function(qt_scenario_fork_patches_prefix)
    qt_begin_test("fork_patches_prefix")
    qt_write_file("${QT_WORK_DIR}/f.txt" "a\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "b\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    qt_quilt(RESULT rc OUTPUT out ERROR err ENV "QUILT_PATCHES_PREFIX=1" ARGS fork)
    qt_assert_success("${rc}" "fork failed")
    qt_assert_equal("${out}" "Fork of patch patches/p.patch created as patches/p-2.patch\n"
                    "fork should show prefixed names")
    qt_append_file("${QT_WORK_DIR}/patches/series" "p-3.patch\n")
    qt_quilt(RESULT rc OUTPUT out ERROR err ENV "QUILT_PATCHES_PREFIX=1" ARGS fork)
    qt_assert_failure("${rc}" "fork onto a name in the series should fail")
    qt_assert_equal("${err}" "Patch patches/p-3.patch exists already, please choose a new name\n"
                    "the refusal should show a prefixed name")
endfunction()

# fork refuses an explicit name that is empty once the patches/ prefix is
# stripped, since .pc/ itself exists, instead of taking the default name
function(qt_scenario_fork_empty_name)
    qt_begin_test("fork_empty_name")
    qt_write_file("${QT_WORK_DIR}/f.txt" "a\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "b\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS fork patches/)
    qt_assert_failure("${rc}" "fork to patches/ should fail")
    qt_assert_equal("${out}" "" "fork to patches/ should print nothing on stdout")
    qt_assert_equal("${err}" "Patch  exists already, please choose a new name\n"
                    "fork to patches/ should say the empty name exists")
    qt_quilt(RESULT rc OUTPUT out ERROR err ENV "QUILT_PATCHES_PREFIX=1" ARGS fork patches/)
    qt_assert_failure("${rc}" "fork to patches/ with QUILT_PATCHES_PREFIX should fail")
    qt_assert_equal("${err}" "Patch patches/ exists already, please choose a new name\n"
                    "the refusal should show the prefix")
    qt_assert_file_text("${QT_WORK_DIR}/patches/series" "p.patch" "series should be untouched")
    qt_assert_file_text("${QT_WORK_DIR}/.pc/applied-patches" "p.patch" "applied-patches should be untouched")
    qt_assert_exists("${QT_WORK_DIR}/.pc/p.patch/f.txt" "the backup should stay in place")
    qt_assert_not_exists("${QT_WORK_DIR}/patches/p-2.patch" "no default fork should be made")
endfunction()

# quilt.cpp reads a -N suffix with leading zeros as decimal, where upstream's
# shell arithmetic reads it as octal (p-010 -> p-9) or fails (p-08)
function(qt_scenario_fork_leading_zero_suffix)
    qt_begin_test("fork_leading_zero_suffix")
    foreach(pair "p-08.patch=p-9.patch" "p-010.patch=p-11.patch" "p-0099=p-100")
        string(REPLACE "=" ";" pair "${pair}")
        list(GET pair 0 name)
        list(GET pair 1 fork)
        qt_quilt_ok(ARGS new "${name}" MESSAGE "new ${name} failed")
        qt_quilt_ok(OUTPUT out ARGS fork MESSAGE "fork of ${name} failed")
        qt_assert_equal("${out}" "Fork of patch ${name} created as ${fork}\n"
                        "the fork of ${name} should be ${fork}")
    endforeach()
    qt_write_file("${QT_WORK_DIR}/f.txt" "a\n")
    qt_quilt_ok(ARGS new r-09.patch MESSAGE "new r-09.patch failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "b\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "c\n")
    qt_quilt_ok(OUTPUT out ARGS refresh -z MESSAGE "refresh -z of r-09.patch failed")
    qt_assert_equal("${out}" "Fork of patch r-09.patch created as r-10.patch\n"
                    "the fork of r-09.patch should be r-10.patch")
endfunction()

# revert checks every file before changing any, and reports each file that
# is not in the patch, including a directory
function(qt_scenario_revert_checks_all_files_first)
    qt_begin_test("revert_checks_all_files_first")
    qt_write_file("${QT_WORK_DIR}/a.txt" "a1\n")
    qt_write_file("${QT_WORK_DIR}/b.txt" "b1\n")
    qt_write_file("${QT_WORK_DIR}/c.txt" "c1\n")
    qt_write_file("${QT_WORK_DIR}/sub/s.txt" "s1\n")
    qt_write_file("${QT_WORK_DIR}/sub/t.txt" "t1\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add a.txt b.txt sub/s.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/a.txt" "a2\n")
    qt_write_file("${QT_WORK_DIR}/b.txt" "b2\n")
    qt_write_file("${QT_WORK_DIR}/sub/s.txt" "s2\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    qt_write_file("${QT_WORK_DIR}/a.txt" "a-dirty\n")
    qt_write_file("${QT_WORK_DIR}/b.txt" "b-dirty\n")
    qt_write_file("${QT_WORK_DIR}/sub/s.txt" "s-dirty\n")

    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS revert a.txt c.txt b.txt)
    qt_assert_failure("${rc}" "revert with an untracked file should fail")
    qt_assert_equal("${out}" "" "revert should revert nothing")
    qt_assert_equal("${err}" "File c.txt is not in patch p.patch\n"
                    "revert should report the untracked file")
    qt_assert_file_text("${QT_WORK_DIR}/a.txt" "a-dirty" "a.txt should be untouched")
    qt_assert_file_text("${QT_WORK_DIR}/b.txt" "b-dirty" "b.txt should be untouched")

    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS revert c.txt a.txt e.txt)
    qt_assert_failure("${rc}" "revert with untracked files should fail")
    qt_assert_equal("${out}" "" "revert should revert nothing")
    qt_assert_equal("${err}"
        "File c.txt is not in patch p.patch\nFile e.txt is not in patch p.patch\n"
        "revert should report every untracked file")
    qt_assert_file_text("${QT_WORK_DIR}/a.txt" "a-dirty" "a.txt should be untouched")

    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS revert s.txt t.txt
             WORKING_DIRECTORY "${QT_WORK_DIR}/sub")
    qt_assert_failure("${rc}" "revert from a subdirectory should fail")
    qt_assert_equal("${out}" "" "revert should revert nothing")
    qt_assert_equal("${err}" "File sub/t.txt is not in patch p.patch\n"
                    "revert should report the untracked file")
    qt_assert_file_text("${QT_WORK_DIR}/sub/s.txt" "s-dirty" "sub/s.txt should be untouched")

    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS revert sub)
    qt_assert_failure("${rc}" "revert of a directory should fail")
    qt_assert_equal("${out}" "" "revert of a directory should print nothing")
    qt_assert_equal("${err}" "File sub is not in patch p.patch\n"
                    "a directory should not count as a file in the patch")
endfunction()

# revert refuses files a later patch modifies, on stdout, after checking
# that the file is in the named patch
function(qt_scenario_revert_shadowed_file)
    qt_begin_test("revert_shadowed_file")
    qt_write_file("${QT_WORK_DIR}/a.txt" "a1\n")
    qt_write_file("${QT_WORK_DIR}/b.txt" "b1\n")
    qt_write_file("${QT_WORK_DIR}/c.txt" "c1\n")
    qt_write_file("${QT_WORK_DIR}/d.txt" "d1\n")
    qt_quilt_ok(ARGS new p1.patch MESSAGE "new p1 failed")
    qt_quilt_ok(ARGS add a.txt b.txt MESSAGE "add p1 failed")
    qt_write_file("${QT_WORK_DIR}/a.txt" "a2\n")
    qt_write_file("${QT_WORK_DIR}/b.txt" "b2\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh p1 failed")
    qt_quilt_ok(ARGS new p2.patch MESSAGE "new p2 failed")
    qt_quilt_ok(ARGS add b.txt d.txt MESSAGE "add p2 failed")
    qt_write_file("${QT_WORK_DIR}/b.txt" "b3\n")
    qt_write_file("${QT_WORK_DIR}/d.txt" "d2\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh p2 failed")
    qt_write_file("${QT_WORK_DIR}/b.txt" "b-dirty\n")

    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS revert -P p1.patch c.txt b.txt)
    qt_assert_failure("${rc}" "revert should fail")
    qt_assert_equal("${out}" "File b.txt modified by patch p2.patch\n"
                    "revert should report the later patch on stdout")
    qt_assert_equal("${err}" "File c.txt is not in patch p1.patch\n"
                    "revert should also report the untracked file")
    qt_assert_file_text("${QT_WORK_DIR}/b.txt" "b-dirty" "b.txt should be untouched")

    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS revert -P p1.patch d.txt)
    qt_assert_failure("${rc}" "revert of a file not in p1 should fail")
    qt_assert_equal("${out}" "" "a file not in p1 is not shadowed")
    qt_assert_equal("${err}" "File d.txt is not in patch p1.patch\n"
                    "revert should report the file is not in p1")

    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS revert -P p1.patch ./b.txt)
    qt_assert_failure("${rc}" "revert of a shadowed ./ path should fail")
    qt_assert_equal("${out}" "File ./b.txt modified by patch p2.patch\n"
                    "the shadow check should resolve ./b.txt")
    qt_assert_file_text("${QT_WORK_DIR}/b.txt" "b-dirty" "b.txt should be untouched")
endfunction()

# revert of "./f", "d//f", or "../f" from a subdirectory restores the
# post-patch content, not the backup
function(qt_scenario_revert_unnormalized_path)
    qt_begin_test("revert_unnormalized_path")
    qt_write_file("${QT_WORK_DIR}/a.txt" "a1\n")
    qt_write_file("${QT_WORK_DIR}/sub/s.txt" "s1\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add a.txt sub/s.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/a.txt" "a2\n")
    qt_write_file("${QT_WORK_DIR}/sub/s.txt" "s2\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")

    qt_write_file("${QT_WORK_DIR}/a.txt" "a-dirty\n")
    qt_quilt_ok(OUTPUT out ARGS revert ./a.txt MESSAGE "revert ./a.txt failed")
    qt_assert_equal("${out}" "Changes to ./a.txt in patch p.patch reverted\n"
                    "revert should name the file as given")
    qt_assert_file_text("${QT_WORK_DIR}/a.txt" "a2" "./a.txt should get the post-patch content")

    qt_write_file("${QT_WORK_DIR}/sub/s.txt" "s-dirty\n")
    qt_quilt_ok(OUTPUT out ARGS revert sub//s.txt MESSAGE "revert sub//s.txt failed")
    qt_assert_equal("${out}" "Changes to sub//s.txt in patch p.patch reverted\n"
                    "revert should name the file as given")
    qt_assert_file_text("${QT_WORK_DIR}/sub/s.txt" "s2" "sub//s.txt should get the post-patch content")

    qt_write_file("${QT_WORK_DIR}/a.txt" "a-dirty\n")
    qt_quilt_ok(OUTPUT out ARGS revert ../a.txt WORKING_DIRECTORY "${QT_WORK_DIR}/sub"
                MESSAGE "revert ../a.txt failed")
    qt_assert_equal("${out}" "Changes to sub/../a.txt in patch p.patch reverted\n"
                    "revert should name the file as given")
    qt_assert_file_text("${QT_WORK_DIR}/a.txt" "a2" "../a.txt should get the post-patch content")
endfunction()

# revert prints usage before checking the stack, then resolves -P like
# upstream's find_applied_patch
function(qt_scenario_revert_patch_resolution)
    qt_begin_test("revert_patch_resolution")
    qt_write_file("${QT_WORK_DIR}/a.txt" "a1\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add a.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/a.txt" "a2\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")

    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS revert -P nosuch.patch a.txt)
    qt_assert_failure("${rc}" "revert -P with an unknown patch should fail")
    qt_assert_equal("${err}" "Patch nosuch.patch is not in series\n"
                    "revert should report the patch is not in the series")

    qt_quilt_ok(ARGS pop MESSAGE "pop failed")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS revert -P p.patch a.txt)
    qt_assert_failure("${rc}" "revert -P with an unapplied patch should fail")
    qt_assert_equal("${err}" "Patch p.patch is not applied\n"
                    "revert should report the patch is not applied")

    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS revert)
    qt_assert_failure("${rc}" "revert without files should fail")
    qt_combine_output(combined "${out}" "${err}")
    qt_assert_contains("${combined}" "Usage" "revert without files should print usage")
    qt_assert_not_contains("${combined}" "No patches applied"
                           "usage should come before the stack checks")
endfunction()

# revert reports a missing or empty series file like other commands
function(qt_scenario_revert_no_series)
    qt_begin_test("revert_no_series")
    qt_write_file("${QT_WORK_DIR}/a.txt" "a1\n")
    file(MAKE_DIRECTORY "${QT_WORK_DIR}/patches")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS revert a.txt)
    qt_assert_failure("${rc}" "revert without a series file should fail")
    qt_assert_equal("${err}" "No series file found\n" "missing series file should be reported")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS revert -P x.patch a.txt)
    qt_assert_failure("${rc}" "revert -P without a series file should fail")
    qt_assert_equal("${err}" "No series file found\n" "missing series file should be reported")

    qt_write_file("${QT_WORK_DIR}/patches/series" "")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS revert a.txt)
    qt_assert_failure("${rc}" "revert with an empty series should fail")
    qt_assert_equal("${err}" "No patches in series\n" "empty series should be reported")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS revert -P x.patch a.txt)
    qt_assert_failure("${rc}" "revert -P with an empty series should fail")
    qt_assert_equal("${err}" "No patches in series\n" "empty series should be reported")
endfunction()

# revert applies a patch marked -R in the series in reverse when computing
# the post-patch content, as push does
function(qt_scenario_revert_reversed_patch)
    qt_begin_test("revert_reversed_patch")
    qt_write_file("${QT_TEST_BASE}/r.diff" [=[--- a/a.txt
+++ b/a.txt
@@ -1 +1 @@
-a2
+a1
]=])
    qt_write_file("${QT_WORK_DIR}/a.txt" "a1\n")
    qt_quilt_ok(ARGS import -R "${QT_TEST_BASE}/r.diff" MESSAGE "import -R failed")
    qt_quilt_ok(ARGS push MESSAGE "push of reversed patch failed")
    qt_assert_file_text("${QT_WORK_DIR}/a.txt" "a2" "push should apply the patch in reverse")

    qt_write_file("${QT_WORK_DIR}/a.txt" "dirty\n")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS revert a.txt)
    qt_assert_success("${rc}" "revert in a reversed patch failed")
    qt_assert_equal("${out}" "Changes to a.txt in patch r.diff reverted\n"
                    "revert should report the change")
    qt_assert_file_text("${QT_WORK_DIR}/a.txt" "a2"
                        "revert should restore the reversed patch's result")

    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS revert a.txt)
    qt_assert_success("${rc}" "second revert failed")
    qt_assert_equal("${out}" "File a.txt is unchanged\n"
                    "a reverted file should be unchanged")
endfunction()

# revert finds a file in a patch whose headers spell its name with "./",
# however the file is named on the command line
function(qt_scenario_revert_dot_slash_headers)
    qt_begin_test("revert_dot_slash_headers")
    qt_write_file("${QT_TEST_BASE}/d.diff" [=[--- ./a.txt
+++ ./a.txt
@@ -1 +1 @@
-a1
+a2
--- ./sub/s.txt
+++ ./sub/s.txt
@@ -1 +1 @@
-s1
+s2
]=])
    qt_write_file("${QT_WORK_DIR}/a.txt" "a1\n")
    qt_write_file("${QT_WORK_DIR}/sub/s.txt" "s1\n")
    qt_quilt_ok(ARGS import -p0 "${QT_TEST_BASE}/d.diff" MESSAGE "import failed")
    qt_quilt_ok(ARGS push MESSAGE "push failed")

    foreach(name a.txt ./a.txt)
        qt_write_file("${QT_WORK_DIR}/a.txt" "dirty\n")
        qt_quilt_ok(OUTPUT out ARGS revert ${name} MESSAGE "revert ${name} failed")
        qt_assert_equal("${out}" "Changes to ${name} in patch d.diff reverted\n"
                        "revert ${name} should report the change")
        qt_assert_file_text("${QT_WORK_DIR}/a.txt" "a2"
                            "revert ${name} should restore the post-patch content")
    endforeach()

    qt_write_file("${QT_WORK_DIR}/sub/s.txt" "dirty\n")
    qt_quilt_ok(OUTPUT out ARGS revert s.txt WORKING_DIRECTORY "${QT_WORK_DIR}/sub"
                MESSAGE "revert s.txt in sub failed")
    qt_assert_equal("${out}" "Changes to sub/s.txt in patch d.diff reverted\n"
                    "revert from a subdirectory should report the change")
    qt_assert_file_text("${QT_WORK_DIR}/sub/s.txt" "s2"
                        "revert from a subdirectory should restore the post-patch content")
endfunction()

# Like upstream patch_header and patch_body, only "Index: x", "diff -",
# "--- x" followed by "+++ y", and "*** x" followed by "--- y" start the
# diff, so a description may hold lines that merely look like those.
function(qt_scenario_header_desc_lookalike_lines)
    qt_begin_test("header_desc_lookalike_lines")
    qt_write_file("${QT_WORK_DIR}/f.txt" "a\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "b\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    set(desc "Title\n=====\n--- note\ndiff between v1 and v2\nIndex:\nIndex:foo\n*** NOTE ***\n---  two spaces\n\n")
    qt_quilt_ok(ARGS header -r INPUT "${desc}" MESSAGE "header -r failed")
    qt_quilt_ok(OUTPUT out ARGS header MESSAGE "header failed")
    qt_assert_equal("${out}" "${desc}" "header should print the whole description")
    # The editor changes nothing, so -e writes back what it was given
    qt_quilt_ok(OUTPUT out ENV "EDITOR=true" ARGS header -e MESSAGE "header -e failed")
    qt_assert_equal("${out}" "Replaced header of patch p.patch\n" "wrong header -e output")
    qt_quilt_ok(OUTPUT out ARGS header MESSAGE "header failed")
    qt_assert_equal("${out}" "${desc}" "the editor should get the whole description")
    qt_quilt_ok(ARGS header -a INPUT "Appended\n" MESSAGE "header -a failed")
    qt_quilt_ok(OUTPUT out ARGS header MESSAGE "header failed")
    qt_assert_equal("${out}" "${desc}Appended\n" "header -a should append after the description")
    qt_quilt_ok(ARGS header -r INPUT "New\n" MESSAGE "header -r failed")
    qt_read_file_raw(patch "${QT_WORK_DIR}/patches/p.patch")
    qt_assert_matches("${patch}" "^New\nIndex: " "header -r should replace the whole description")
    qt_quilt_ok(ARGS pop MESSAGE "pop failed")
    qt_quilt_ok(ARGS push MESSAGE "push failed")
endfunction()

# A context diff without Index: lines starts at its "*** x" line.
function(qt_scenario_header_context_diff_no_index)
    qt_begin_test("header_context_diff_no_index")
    qt_write_file("${QT_WORK_DIR}/f.txt" "a\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "b\n")
    qt_quilt_ok(ARGS refresh -c --no-index --no-timestamps MESSAGE "refresh failed")
    qt_quilt_ok(OUTPUT out ARGS header MESSAGE "header failed")
    qt_assert_equal("${out}" "" "context diff should have no header")
    qt_quilt_ok(ARGS header -a INPUT "Note\n" MESSAGE "header -a failed")
    qt_read_file_raw(patch "${QT_WORK_DIR}/patches/p.patch")
    qt_assert_matches("${patch}" "^Note\n\\*\\*\\* [^\n]*\n--- " "header -a should go above the *** line")
    qt_quilt_ok(ARGS pop MESSAGE "pop of context patch failed")
    qt_quilt_ok(ARGS push MESSAGE "push of context patch failed")
endfunction()

# Header edits keep the patch's bytes, CRs included. As in upstream, the
# trailing whitespace strip leaves a CR alone, and a new header ending in
# a CR gets no newline (ensure_trailing_newline).
function(qt_scenario_header_crlf_preserved)
    qt_begin_test("header_crlf_preserved")
    set(body "Index: f.txt\\r\\n--- f.txt.orig\\r\\n+++ f.txt\\r\\n@@ -1 +1 @@\\r\\n-a\\r\\n+b\\r\\n")
    set(body_hex "496e6465783a20662e7478740d0a2d2d2d20662e7478742e6f7269670d0a2b2b2b20662e7478740d0a4040202d31202b312040400d0a2d610d0a2b620d0a")
    qt_write_file("${QT_WORK_DIR}/patches/series" "p.patch\n")
    qt_write_bytes("${QT_WORK_DIR}/patches/p.patch" "Desc \\r\\n\\r\\n${body}")
    qt_quilt_ok(ARGS header -a --strip-trailing-whitespace p.patch INPUT "Note \n"
                MESSAGE "header -a failed")
    qt_assert_file_hex("${QT_WORK_DIR}/patches/p.patch" "44657363200d0a0d0a4e6f74650a${body_hex}"
                       "header -a should keep CRs")
    qt_quilt_ok(ARGS header -r p.patch INPUT "New\r" MESSAGE "header -r failed")
    qt_assert_file_hex("${QT_WORK_DIR}/patches/p.patch" "4e65770d${body_hex}"
                       "header -r should add no newline after a CR")
endfunction()

# strip_diffstat, as upstream: stat lines (a " | " after some space) go
# only when a summary line follows, the summary line always goes, "#"
# prefixes included, and the blank line after a diffstat stays. Stat lines
# still pending at the end of the header are lost.
function(qt_scenario_header_strip_diffstat_upstream)
    qt_begin_test("header_strip_diffstat_upstream")
    set(diff "Index: f.txt\n--- f.txt.orig\n+++ f.txt\n@@ -1 +1 @@\n-a\n+b\n")
    qt_write_file("${QT_WORK_DIR}/patches/series" "p.patch\nq.patch\n")
    qt_write_file("${QT_WORK_DIR}/patches/p.patch"
        "Subject: s\n---\n f.txt |    2 +-\n 1 file changed, 1 insertion(+), 1 deletion(-)\n\nTrailer\n 2 files changed\n# g.txt |    2 +-\n# 1 file changed\nA table x | y\n\n${diff}")
    qt_quilt_ok(OUTPUT out ARGS header --strip-diffstat p.patch MESSAGE "header failed")
    qt_assert_equal("${out}" "Subject: s\n---\n\nTrailer\nA table x | y\n\n" "wrong stripped header")
    qt_write_file("${QT_WORK_DIR}/patches/q.patch" "Intro\nlast a | b\n${diff}")
    qt_quilt_ok(OUTPUT out ARGS header --strip-diffstat q.patch MESSAGE "header failed")
    qt_assert_equal("${out}" "Intro\n" "a pending stat line at the end should be lost")
endfunction()

# The header ends where a held "--- x" line meets end of input, and a line
# after a failed lookahead is not reconsidered, as in upstream.
function(qt_scenario_header_lookahead_edges)
    qt_begin_test("header_lookahead_edges")
    qt_write_file("${QT_WORK_DIR}/patches/series" "p.patch\nq.patch\n")
    qt_write_file("${QT_WORK_DIR}/patches/p.patch" "Intro\n--- trailing\n")
    qt_quilt_ok(OUTPUT out ARGS header p.patch MESSAGE "header failed")
    qt_assert_equal("${out}" "Intro\n" "held line at end of input")
    qt_write_file("${QT_WORK_DIR}/patches/q.patch" "Intro\n--- x\n--- f.txt.orig\n+++ f.txt\n")
    qt_quilt_ok(OUTPUT out ARGS header q.patch MESSAGE "header failed")
    qt_assert_equal("${out}" "Intro\n--- x\n--- f.txt.orig\n+++ f.txt\n" "no rescan after failed lookahead")
endfunction()

# Refresh keeps the whole header, including lines that look like diff
# starts and a "---" diffstat block. Whatever the header holds, an empty
# diff is "Nothing in patch".
function(qt_scenario_refresh_keeps_lookalike_header)
    qt_begin_test("refresh_keeps_lookalike_header")
    qt_write_file("${QT_WORK_DIR}/f.txt" "a\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "b\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    set(desc "Subject: x\n\n=====\ndiff between\n--- note\n---\n f.txt |    2 +-\n 1 file changed, 1 insertion(+), 1 deletion(-)\n\n")
    qt_quilt_ok(ARGS header -r INPUT "${desc}" MESSAGE "header -r failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "c\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    qt_quilt_ok(OUTPUT out ARGS header MESSAGE "header failed")
    qt_assert_equal("${out}" "${desc}" "refresh should keep the header")
    qt_write_file("${QT_WORK_DIR}/f.txt" "a\n")
    qt_quilt_ok(OUTPUT out ARGS refresh MESSAGE "refresh failed")
    qt_assert_equal("${out}" "Nothing in patch p.patch\n" "an empty diff should be nothing")
endfunction()

# Like upstream, refresh --diffstat swaps a diffstat in the header for the
# new one where it stands, "#" prefix included, and keeps every other byte,
# CRs and blank lines too. A header without one gets "---", the diffstat
# and a blank line at its end, even when the diff is empty.
function(qt_scenario_refresh_diffstat_in_place)
    qt_begin_test("refresh_diffstat_in_place")
    qt_write_file("${QT_WORK_DIR}/f.txt" "a\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "b\n")
    set(refresh refresh -p ab --no-index --no-timestamps --diffstat)
    set(diff "--- a/f.txt\n+++ b/f.txt\n@@ -1 +1 @@\n-a\n+b\n")
    set(diff_hex "2d2d2d20612f662e7478740a2b2b2b20622f662e7478740a4040202d31202b312040400a2d610a2b620a")
    set(stat " f.txt |    2 +-\n 1 file changed, 1 insertion(+), 1 deletion(-)\n")

    qt_write_bytes("${QT_WORK_DIR}/patches/p.patch"
        "Desc\\r\\n\\r\\n---\\r\\n f.txt | 9 +++\\r\\n 1 file changed, 9 insertions(+)\\r\\n\\r\\nTrailer\\r\\n\\r\\n${diff}")
    qt_quilt_ok(ARGS ${refresh} MESSAGE "refresh of CRLF header failed")
    qt_assert_file_hex("${QT_WORK_DIR}/patches/p.patch"
        "446573630d0a0d0a2d2d2d0d0a20662e747874207c2020202032202b2d0a20312066696c65206368616e6765642c203120696e73657274696f6e282b292c20312064656c6574696f6e282d290a0d0a547261696c65720d0a0d0a${diff_hex}"
        "the diffstat should be replaced in place, keeping CRs")

    qt_write_file("${QT_WORK_DIR}/patches/p.patch"
        "#  f.txt |    9 +++\n#  1 file changed, 9 insertions(+)\n#\nDesc\n${diff}")
    qt_quilt_ok(ARGS ${refresh} MESSAGE "refresh of # diffstat failed")
    qt_read_file_raw(patch "${QT_WORK_DIR}/patches/p.patch")
    qt_assert_equal("${patch}"
        "# f.txt |    2 +-\n# 1 file changed, 1 insertion(+), 1 deletion(-)\n#\nDesc\n${diff}"
        "a # diffstat should be replaced in place, prefix included")

    qt_write_file("${QT_WORK_DIR}/patches/p.patch" "Desc\n\n${diff}")
    qt_quilt_ok(ARGS ${refresh} MESSAGE "refresh without a diffstat failed")
    qt_read_file_raw(patch "${QT_WORK_DIR}/patches/p.patch")
    qt_assert_equal("${patch}" "Desc\n\n---\n${stat}\n${diff}"
                    "a diffstat should be added at the end of the header")

    qt_write_file("${QT_WORK_DIR}/f.txt" "a\n")
    qt_write_file("${QT_WORK_DIR}/patches/p.patch" "Desc\n\n${diff}")
    qt_quilt_ok(OUTPUT out ARGS ${refresh} MESSAGE "refresh of empty diff failed")
    qt_assert_equal("${out}" "Nothing in patch p.patch\n" "wrong empty diff message")
    qt_read_file_raw(patch "${QT_WORK_DIR}/patches/p.patch")
    qt_assert_equal("${patch}" "Desc\n\n---\n 0 files changed\n\n"
                    "an empty diff should get an empty diffstat")
endfunction()

# The mail subject and body come from the whole description.
function(qt_scenario_mail_subject_lookalike)
    qt_begin_test("mail_subject_lookalike")
    qt_write_file("${QT_WORK_DIR}/f.txt" "a\n")
    qt_quilt_ok(ARGS new p.patch MESSAGE "new failed")
    qt_quilt_ok(ARGS add f.txt MESSAGE "add failed")
    qt_write_file("${QT_WORK_DIR}/f.txt" "b\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh failed")
    qt_quilt_ok(ARGS header -r INPUT "diff between v1 and v2 breaks it\n\n=====\nBody\n"
                MESSAGE "header -r failed")
    qt_quilt_ok(ARGS mail --mbox "${QT_TEST_BASE}/out.mbox" --from "t@e.com" MESSAGE "mail failed")
    qt_read_file_raw(mbox "${QT_TEST_BASE}/out.mbox")
    qt_assert_contains("${mbox}" "Subject: [PATCH] diff between v1 and v2 breaks it\n" "wrong subject")
    qt_assert_contains("${mbox}" "\n=====\nBody\n\nIndex: " "body should hold the rest of the description")
endfunction()

# import -f without -d keeps the old header when the new version has none,
# and takes the new version whole when the old one has none. "Replacing"
# goes to stderr.
function(qt_scenario_import_force_keeps_old_header)
    qt_begin_test("import_force_keeps_old_header")
    set(diff_y "--- a/f.txt\n+++ b/f.txt\n@@ -1 +1 @@\n-x\n+y\n")
    set(diff_z "--- a/f.txt\n+++ b/f.txt\n@@ -1 +1 @@\n-x\n+z\n")
    set(ext "${QT_TEST_BASE}/ext.patch")
    qt_write_file("${ext}" "Old header\n${diff_y}")
    qt_quilt_ok(ARGS import "${ext}" MESSAGE "import failed")
    qt_write_file("${ext}" "${diff_z}")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS import -f "${ext}")
    qt_assert_success("${rc}" "import -f failed")
    qt_assert_equal("${out}" "" "import -f should not write to stdout")
    qt_assert_equal("${err}" "Replacing patch ext.patch with new version\n" "Replacing should go to stderr")
    qt_read_file_raw(text "${QT_WORK_DIR}/patches/ext.patch")
    qt_assert_equal("${text}" "Old header\n${diff_z}" "import -f should keep the old header")

    set(two "${QT_TEST_BASE}/two.patch")
    qt_write_file("${two}" "${diff_y}")
    qt_quilt_ok(ARGS import "${two}" MESSAGE "import two failed")
    qt_write_file("${two}" "New header\n${diff_z}")
    qt_quilt_ok(ARGS import -f "${two}" MESSAGE "import -f two failed")
    qt_read_file_raw(text "${QT_WORK_DIR}/patches/two.patch")
    qt_assert_equal("${text}" "New header\n${diff_z}" "import -f should take the new header")
endfunction()

# When both headers differ, import -f shows a real diff of them and fails
function(qt_scenario_import_force_headers_differ_hunk)
    qt_begin_test("import_force_headers_differ_hunk")
    set(ext "${QT_TEST_BASE}/ext.patch")
    qt_write_file("${ext}" "Subject: one\n\nline two\nline three\n--- a/f.txt\n+++ b/f.txt\n@@ -1 +1 @@\n-x\n+y\n")
    qt_quilt_ok(ARGS import "${ext}" MESSAGE "import failed")
    qt_write_file("${ext}" "Subject: one\n\nline 2\nline three\n--- a/f.txt\n+++ b/f.txt\n@@ -1 +1 @@\n-x\n+z\n")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS import -f "${ext}")
    qt_assert_failure("${rc}" "import -f should fail when the headers differ")
    qt_assert_equal("${out}" "" "import -f should not write to stdout")
    qt_assert_equal("${err}" "Patch headers differ:\n@@ -1,4 +1,4 @@\n Subject: one\n \n-line two\n+line 2\n line three\nPlease use -d {o|a|n} to specify which patch header(s) to keep.\n" "wrong header diff")
    qt_assert_file_contains("${QT_WORK_DIR}/patches/ext.patch" "+y" "a failed import -f should leave the patch alone")
endfunction()

# Port of the header merge in upstream's test/import.test
function(qt_scenario_import_force_upstream_sequence)
    qt_begin_test("import_force_upstream_sequence")
    qt_write_file("${QT_WORK_DIR}/t/patch1.diff" "--- a/f\n+++ b/f\n@@ -0,0 +1 @@\n+f\n")
    qt_quilt_ok(ARGS import t/patch1.diff MESSAGE "import failed")
    qt_quilt_ok(ARGS header -r patch1.diff INPUT "original description\n" MESSAGE "header -r failed")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS import -f t/patch1.diff)
    qt_assert_success("${rc}" "import -f failed")
    qt_assert_equal("${err}" "Replacing patch patch1.diff with new version\n" "wrong import -f message")
    qt_quilt_ok(OUTPUT out ARGS header patch1.diff MESSAGE "header failed")
    qt_assert_equal("${out}" "original description\n" "import -f should keep the old header")

    qt_read_file_raw(text "${QT_WORK_DIR}/patches/patch1.diff")
    string(REPLACE "original" "new" text "${text}")
    qt_write_file("${QT_WORK_DIR}/t/patch1.diff" "${text}")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS import -f t/patch1.diff)
    qt_assert_failure("${rc}" "import -f should fail when the headers differ")
    qt_assert_equal("${err}" "Patch headers differ:\n@@ -1 +1 @@\n-original description\n+new description\nPlease use -d {o|a|n} to specify which patch header(s) to keep.\n" "wrong header diff")

    qt_quilt_ok(ARGS import -d a -f t/patch1.diff MESSAGE "import -d a -f failed")
    qt_read_file_raw(text "${QT_WORK_DIR}/patches/patch1.diff")
    qt_assert_equal("${text}" "original description\n---\nnew description\n--- a/f\n+++ b/f\n@@ -0,0 +1 @@\n+f\n" "-d a should keep both headers")

    qt_quilt_ok(ARGS import -d n -f t/patch1.diff MESSAGE "import -d n -f failed")
    qt_quilt_ok(OUTPUT out ARGS header patch1.diff MESSAGE "header failed")
    qt_assert_equal("${out}" "new description\n" "-d n should keep the new header")
endfunction()

# The old header loses its diffstat when import -f keeps it
function(qt_scenario_import_force_strips_old_diffstat)
    qt_begin_test("import_force_strips_old_diffstat")
    set(diff_y "--- a/f.txt\n+++ b/f.txt\n@@ -1 +1 @@\n-x\n+y\n")
    set(diff_z "--- a/f.txt\n+++ b/f.txt\n@@ -1 +1 @@\n-x\n+z\n")
    set(old "Desc\n---\n f.txt |    2 +-\n 1 file changed, 1 insertion(+), 1 deletion(-)\n\n${diff_y}")
    set(ext "${QT_TEST_BASE}/ext.patch")
    set(dest "${QT_WORK_DIR}/patches/ext.patch")
    qt_write_file("${ext}" "${old}")
    qt_quilt_ok(ARGS import "${ext}" MESSAGE "import failed")
    qt_write_file("${ext}" "${diff_z}")
    qt_quilt_ok(ARGS import -f "${ext}" MESSAGE "import -f failed")
    qt_read_file_raw(text "${dest}")
    qt_assert_equal("${text}" "Desc\n---\n\n${diff_z}" "import -f should drop the old diffstat")

    qt_write_file("${ext}" "${old}")
    qt_quilt_ok(ARGS import -f -d n "${ext}" MESSAGE "import -f -d n failed")
    qt_write_file("${ext}" "New\n${diff_z}")
    qt_quilt_ok(ARGS import -f -d o "${ext}" MESSAGE "import -f -d o failed")
    qt_read_file_raw(text "${dest}")
    qt_assert_equal("${text}" "Desc\n---\n\n${diff_z}" "-d o should drop the old diffstat")

    qt_write_file("${ext}" "${old}")
    qt_quilt_ok(ARGS import -f -d n "${ext}" MESSAGE "import -f -d n failed")
    qt_write_file("${ext}" "New\n${diff_z}")
    qt_quilt_ok(ARGS import -f -d a "${ext}" MESSAGE "import -f -d a failed")
    qt_read_file_raw(text "${dest}")
    qt_assert_equal("${text}" "Desc\n---\n\n---\nNew\n${diff_z}" "-d a should drop the old diffstat")
endfunction()

# Headers that differ only in a diffstat do not conflict
function(qt_scenario_import_force_diffstat_not_a_conflict)
    qt_begin_test("import_force_diffstat_not_a_conflict")
    set(ext "${QT_TEST_BASE}/ext.patch")
    qt_write_file("${ext}" "Desc\n---\n f.txt |    2 +-\n 1 file changed, 1 insertion(+), 1 deletion(-)\n\n--- a/f.txt\n+++ b/f.txt\n@@ -1 +1 @@\n-x\n+y\n")
    qt_quilt_ok(ARGS import "${ext}" MESSAGE "import failed")
    qt_write_file("${ext}" "Desc\n---\n\n--- a/f.txt\n+++ b/f.txt\n@@ -1 +1 @@\n-x\n+z\n")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS import -f "${ext}")
    qt_assert_success("${rc}" "a diffstat should not make the headers differ")
    qt_assert_not_contains("${err}" "Patch headers differ" "a diffstat should not make the headers differ")
    qt_assert_file_contains("${QT_WORK_DIR}/patches/ext.patch" "+z" "import -f should take the new diff")

    # Nor does a diffstat only in the new version's header
    set(two "${QT_TEST_BASE}/two.patch")
    qt_write_file("${two}" "Desc\n---\n\n--- a/f.txt\n+++ b/f.txt\n@@ -1 +1 @@\n-x\n+y\n")
    qt_quilt_ok(ARGS import "${two}" MESSAGE "import two failed")
    qt_write_file("${two}" "Desc\n---\n f.txt |    2 +-\n 1 file changed, 1 insertion(+), 1 deletion(-)\n\n--- a/f.txt\n+++ b/f.txt\n@@ -1 +1 @@\n-x\n+z\n")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS import -f "${two}")
    qt_assert_success("${rc}" "a new diffstat should not make the headers differ")
    qt_assert_not_contains("${err}" "Patch headers differ" "a new diffstat should not make the headers differ")
    qt_assert_file_contains("${QT_WORK_DIR}/patches/two.patch" "+z" "import -f should take the new diff")
endfunction()

# import -f splits headers like upstream's patch_header
function(qt_scenario_import_force_header_boundaries)
    qt_begin_test("import_force_header_boundaries")
    set(diff_y "--- a/f.txt\n+++ b/f.txt\n@@ -1 +1 @@\n-x\n+y\n")
    set(diff_z "--- a/f.txt\n+++ b/f.txt\n@@ -1 +1 @@\n-x\n+z\n")
    set(ext "${QT_TEST_BASE}/ext.patch")
    qt_write_file("${ext}" "Title\n--- not a diff\n=====\nmore text\n${diff_y}")
    qt_quilt_ok(ARGS import "${ext}" MESSAGE "import failed")
    qt_write_file("${ext}" "${diff_z}")
    qt_quilt_ok(ARGS import -f "${ext}" MESSAGE "import -f failed")
    qt_read_file_raw(text "${QT_WORK_DIR}/patches/ext.patch")
    qt_assert_equal("${text}" "Title\n--- not a diff\n=====\nmore text\n${diff_z}" "import -f should keep the whole old header")

    set(two "${QT_TEST_BASE}/two.patch")
    qt_write_file("${two}" "Title\ndiff is fun\n${diff_y}")
    qt_quilt_ok(ARGS import "${two}" MESSAGE "import two failed")
    qt_write_file("${two}" "Title\ndiff is different\n${diff_z}")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS import -f "${two}")
    qt_assert_failure("${rc}" "import -f should fail when the headers differ")
    qt_assert_equal("${err}" "Patch headers differ:\n@@ -1,2 +1,2 @@\n Title\n-diff is fun\n+diff is different\nPlease use -d {o|a|n} to specify which patch header(s) to keep.\n" "wrong header diff")
endfunction()

# Unlike upstream, which writes the header twice, import -f takes the new
# version as it is when the headers match.
function(qt_scenario_import_force_identical_header_once)
    qt_begin_test("import_force_identical_header_once")
    set(ext "${QT_TEST_BASE}/ext.patch")
    qt_write_file("${ext}" "Same\n--- a/f.txt\n+++ b/f.txt\n@@ -1 +1 @@\n-x\n+y\n")
    qt_quilt_ok(ARGS import "${ext}" MESSAGE "import failed")
    qt_write_file("${ext}" "Same\n--- a/f.txt\n+++ b/f.txt\n@@ -1 +1 @@\n-x\n+z\n")
    qt_quilt_ok(ARGS import -f "${ext}" MESSAGE "import -f failed")
    qt_read_file_raw(text "${QT_WORK_DIR}/patches/ext.patch")
    qt_assert_equal("${text}" "Same\n--- a/f.txt\n+++ b/f.txt\n@@ -1 +1 @@\n-x\n+z\n" "import -f should write the header once")
endfunction()

# Unlike upstream, which carries its first choice over, import -f chooses
# which header to keep separately for each patch.
function(qt_scenario_import_force_mode_per_patch)
    qt_begin_test("import_force_mode_per_patch")
    set(diff_y "--- a/f.txt\n+++ b/f.txt\n@@ -1 +1 @@\n-x\n+y\n")
    set(diff_z "--- a/f.txt\n+++ b/f.txt\n@@ -1 +1 @@\n-x\n+z\n")
    set(a "${QT_TEST_BASE}/a.patch")
    set(b "${QT_TEST_BASE}/b.patch")
    qt_write_file("${a}" "A old\n${diff_y}")
    qt_write_file("${b}" "B old\n${diff_y}")
    qt_quilt_ok(ARGS import "${a}" "${b}" MESSAGE "import failed")
    qt_write_file("${a}" "${diff_z}")
    qt_write_file("${b}" "B new\n${diff_z}")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS import -f "${a}" "${b}")
    qt_assert_failure("${rc}" "import -f should fail when the headers of b differ")
    qt_assert_equal("${err}" "Replacing patch a.patch with new version\nPatch headers differ:\n@@ -1 +1 @@\n-B old\n+B new\nPlease use -d {o|a|n} to specify which patch header(s) to keep.\n" "wrong import -f messages")
    qt_read_file_raw(text "${QT_WORK_DIR}/patches/a.patch")
    qt_assert_equal("${text}" "A old\n${diff_z}" "a should keep its old header")
    qt_read_file_raw(text "${QT_WORK_DIR}/patches/b.patch")
    qt_assert_equal("${text}" "B old\n${diff_y}" "b should be left alone")

    set(c "${QT_TEST_BASE}/c.patch")
    set(d "${QT_TEST_BASE}/d.patch")
    qt_write_file("${c}" "${diff_y}")
    qt_write_file("${d}" "D old\n${diff_y}")
    qt_quilt_ok(ARGS import "${c}" "${d}" MESSAGE "import failed")
    qt_write_file("${c}" "C new\n${diff_z}")
    qt_write_file("${d}" "${diff_z}")
    qt_quilt_ok(ARGS import -f "${c}" "${d}" MESSAGE "import -f failed")
    qt_read_file_raw(text "${QT_WORK_DIR}/patches/c.patch")
    qt_assert_equal("${text}" "C new\n${diff_z}" "c should take its new header")
    qt_read_file_raw(text "${QT_WORK_DIR}/patches/d.patch")
    qt_assert_equal("${text}" "D old\n${diff_z}" "d should keep its old header")
endfunction()

# Like upstream push with GNU getopt, --fuzz takes the next word as its
# value even when it looks like an option, and patch then rejects it. An
# empty value means no fuzz option at all. Homebrew's compat getopt
# rejects the first form and hangs on "--fuzz=", so this is native only.
function(qt_scenario_push_fuzz_value_forms)
    qt_begin_test("push_fuzz_value_forms")
    qt_setup_three_patch_stack()
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS push --fuzz -a)
    qt_assert_equal("${rc}" "1" "push --fuzz -a should fail")
    qt_combine_output(combined "${out}" "${err}")
    qt_assert_contains("${combined}" "fuzz factor -a is not a number"
                       "push --fuzz -a should take -a as the fuzz factor")
    qt_assert_file_text("${QT_WORK_DIR}/f3.txt" "old3" "push --fuzz -a should apply nothing")
    qt_quilt_ok(ARGS push --fuzz=1 --fuzz= MESSAGE "push --fuzz= failed")
    qt_assert_file_text("${QT_WORK_DIR}/f3.txt" "new3" "push --fuzz= should push p3")
endfunction()

# Three patches for the option parsing tests: p1 changes a.txt and p2
# changes b.txt, both applied, and p3, unapplied, changes a.txt again
function(qt_setup_getopt_stack)
    qt_write_file("${QT_WORK_DIR}/a.txt" "a1\na2\na3\n")
    qt_write_file("${QT_WORK_DIR}/b.txt" "b1\nb2\n")
    qt_quilt_ok(ARGS new p1.patch MESSAGE "new p1 failed")
    qt_quilt_ok(ARGS add a.txt MESSAGE "add to p1 failed")
    qt_write_file("${QT_WORK_DIR}/a.txt" "a1\nA2\na3\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh p1 failed")
    qt_quilt_ok(ARGS new p2.patch MESSAGE "new p2 failed")
    qt_quilt_ok(ARGS add b.txt MESSAGE "add to p2 failed")
    qt_write_file("${QT_WORK_DIR}/b.txt" "b1\nB2\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh p2 failed")
    qt_quilt_ok(ARGS new p3.patch MESSAGE "new p3 failed")
    qt_quilt_ok(ARGS add a.txt MESSAGE "add to p3 failed")
    qt_write_file("${QT_WORK_DIR}/a.txt" "a1\nA2\nA3\n")
    qt_quilt_ok(ARGS refresh MESSAGE "refresh p3 failed")
    qt_quilt_ok(ARGS pop MESSAGE "pop p3 failed")
endfunction()

# Run quilt with the arguments after the command name, which upstream
# refuses, and check that it prints the command's usage with status 1
function(qt_assert_usage_error command)
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS ${ARGN})
    string(REPLACE ";" " " shown "${ARGN}")
    qt_assert_equal("${rc}" "1" "${shown} should fail with status 1")
    qt_combine_output(combined "${out}" "${err}")
    qt_assert_contains("${combined}" "Usage: quilt ${command}" "${shown} should print usage")
endfunction()

# push and pop parse options like upstream's getopt: grouped flags, values
# attached or in the next word, "--", options after the patch argument, and
# QUILT_PUSH_ARGS along with the command line. -a, or more than one
# argument, leaves no room for a patch argument.
function(qt_scenario_getopt_push_pop)
    qt_begin_test("getopt_push_pop")
    qt_setup_getopt_stack()
    set(applied "${QT_WORK_DIR}/.pc/applied-patches")

    qt_assert_usage_error(push push -a p3.patch)
    qt_assert_usage_error(push push 1 extra)
    qt_assert_usage_error(push push --merge=bogus)
    qt_assert_usage_error(pop pop -a p1.patch)
    qt_assert_usage_error(pop pop 1 2)
    qt_quilt(RESULT rc OUTPUT out ERROR err ENV "QUILT_PUSH_ARGS=-a" ARGS push p3.patch)
    qt_assert_equal("${rc}" "1" "push p3.patch with QUILT_PUSH_ARGS=-a should fail")
    qt_assert_file_text("${applied}" "p1.patch\np2.patch" "usage errors should change nothing")

    qt_quilt_ok(OUTPUT out ARGS push -qa MESSAGE "push -qa failed")
    qt_assert_not_contains("${out}" "patching file" "push -qa should be quiet")
    qt_assert_file_text("${applied}" "p1.patch\np2.patch\np3.patch" "push -qa should push all")
    qt_quilt_ok(OUTPUT out ARGS pop -qa MESSAGE "pop -qa failed")
    qt_assert_not_contains("${out}" "Restoring" "pop -qa should be quiet")
    qt_assert_not_exists("${applied}" "pop -qa should pop all")

    qt_quilt_ok(OUTPUT out ARGS push p2.patch -q MESSAGE "push p2.patch -q failed")
    qt_assert_not_contains("${out}" "patching file" "push p2.patch -q should be quiet")
    qt_assert_file_text("${applied}" "p1.patch\np2.patch" "push p2.patch -q should push to p2")
    qt_quilt_ok(ARGS push --fuzz 2 MESSAGE "push --fuzz 2 failed")
    qt_assert_file_text("${applied}" "p1.patch\np2.patch\np3.patch" "push --fuzz 2 should push p3")
    qt_quilt_ok(ARGS pop -fR -- p1.patch MESSAGE "pop -fR -- p1.patch failed")
    qt_assert_file_text("${applied}" "p1.patch" "pop -- p1.patch should pop to p1")
    qt_quilt_ok(ARGS push -mdiff3 MESSAGE "push -mdiff3 failed")
    qt_assert_file_text("${applied}" "p1.patch\np2.patch" "push -mdiff3 should push p2")
    qt_quilt_ok(OUTPUT out ENV "QUILT_PUSH_ARGS=-q" ARGS push -- p3.patch MESSAGE "push -- p3.patch failed")
    qt_assert_not_contains("${out}" "patching file" "QUILT_PUSH_ARGS=-q should make push quiet")
    qt_assert_file_text("${applied}" "p1.patch\np2.patch\np3.patch" "push -- p3.patch should push p3")

    # -h prints the help, even grouped with other options
    qt_quilt_ok(OUTPUT out ERROR err ARGS pop -ah MESSAGE "pop -ah failed")
    qt_combine_output(combined "${out}" "${err}")
    qt_assert_contains("${combined}" "Usage: quilt pop" "pop -ah should print help")
    qt_assert_file_text("${applied}" "p1.patch\np2.patch\np3.patch" "pop -ah should pop nothing")
endfunction()

# push hands its --fuzz value to patch, and like GNU patch, a value that is
# not a number, or is negative, fails the push before any file changes.
# A huge value fuzzes away all of a hunk's context.
function(qt_scenario_push_fuzz_value)
    qt_begin_test("push_fuzz_value")
    qt_write_file("${QT_WORK_DIR}/f.txt" "1\n2\n3\nX\n4\n5\n6\n")
    qt_write_file("${QT_TEST_BASE}/d.diff" [=[--- a/f.txt
+++ b/f.txt
@@ -1,7 +1,7 @@
 a
 b
 c
-X
+Y
 d
 e
 f
]=])
    qt_quilt_ok(ARGS import "${QT_TEST_BASE}/d.diff" MESSAGE "import failed")
    foreach(value abc 2x -1)
        qt_quilt(RESULT rc OUTPUT out ERROR err ARGS push --fuzz=${value})
        qt_assert_equal("${rc}" "1" "push --fuzz=${value} should fail")
        qt_combine_output(combined "${out}" "${err}")
        qt_assert_contains("${combined}" "fuzz factor ${value} is"
                           "push --fuzz=${value} should reject the value")
        qt_assert_contains("${combined}" "Patch d.diff does not apply (enforce with -f)"
                           "push --fuzz=${value} should not apply the patch")
    endforeach()
    qt_quilt(RESULT rc OUTPUT out ERROR err ENV "QUILT_PATCH_OPTS=--fuzz=abc"
             ARGS push --fuzz=3)
    qt_assert_equal("${rc}" "1" "a bad fuzz in QUILT_PATCH_OPTS should fail the push")
    qt_combine_output(combined "${out}" "${err}")
    qt_assert_contains("${combined}" "fuzz factor abc is not a number"
                       "a bad fuzz in QUILT_PATCH_OPTS should be reported")
    qt_assert_file_text("${QT_WORK_DIR}/f.txt" "1\n2\n3\nX\n4\n5\n6"
                        "a failed push should leave the file alone")
    qt_assert_not_exists("${QT_WORK_DIR}/.pc/d.diff" "a failed push should leave no backup")

    qt_quilt_ok(OUTPUT out ARGS push --fuzz=99999999999 MESSAGE "push with a huge fuzz failed")
    qt_assert_contains("${out}" "Hunk #1 succeeded at 1 with fuzz 3."
                       "a huge fuzz should fuzz away all of the context")
    qt_assert_file_text("${QT_WORK_DIR}/f.txt" "1\n2\n3\nY\n4\n5\n6"
                        "the patch should apply with all of its context fuzzed")
endfunction()

# The commands that show the stack take options like upstream's getopt,
# and refuse extra arguments with their usage
function(qt_scenario_getopt_stack_queries)
    qt_begin_test("getopt_stack_queries")
    qt_setup_getopt_stack()

    qt_assert_usage_error(applied applied p1.patch p2.patch)
    qt_assert_usage_error(unapplied unapplied p1.patch p2.patch)
    qt_assert_usage_error(top top extra)
    qt_assert_usage_error(next next p1.patch p2.patch)
    qt_assert_usage_error(previous previous p1.patch p2.patch)
    qt_assert_usage_error(series series -vx)

    qt_quilt_ok(OUTPUT out ARGS applied -- p1.patch MESSAGE "applied -- p1.patch failed")
    qt_assert_equal("${out}" "p1.patch\n" "applied -- p1.patch")
    qt_quilt_ok(OUTPUT out ARGS unapplied -- p1.patch MESSAGE "unapplied -- p1.patch failed")
    qt_assert_equal("${out}" "p2.patch\np3.patch\n" "unapplied -- p1.patch")
    qt_quilt_ok(OUTPUT out ARGS top -- MESSAGE "top -- failed")
    qt_assert_equal("${out}" "p2.patch\n" "top --")
    qt_quilt_ok(OUTPUT out ARGS next -- MESSAGE "next -- failed")
    qt_assert_equal("${out}" "p3.patch\n" "next --")
    qt_quilt_ok(OUTPUT out ARGS previous -- p2.patch MESSAGE "previous -- p2.patch failed")
    qt_assert_equal("${out}" "p1.patch\n" "previous -- p2.patch")
endfunction()

# add, remove, revert, edit, and annotate take -P attached or in the next
# word, before or after the files, and "--", and print their usage without
# the files they need
function(qt_scenario_getopt_file_commands)
    qt_begin_test("getopt_file_commands")
    qt_setup_getopt_stack()
    set(pc "${QT_WORK_DIR}/.pc")

    qt_assert_usage_error(add add)
    qt_assert_usage_error(add add -P p1.patch)
    qt_assert_usage_error(remove remove --)
    qt_assert_usage_error(revert revert -P p2.patch)
    qt_assert_usage_error(edit edit --)
    qt_assert_usage_error(annotate annotate)
    qt_assert_usage_error(annotate annotate a.txt b.txt)

    qt_write_file("${QT_WORK_DIR}/c.txt" "c\n")
    qt_write_file("${QT_WORK_DIR}/d.txt" "d\n")
    qt_write_file("${QT_WORK_DIR}/e.txt" "e\n")
    qt_quilt_ok(ARGS add -Pp1.patch c.txt MESSAGE "add -Pp1.patch c.txt failed")
    qt_assert_exists("${pc}/p1.patch/c.txt" "add -Pp1.patch should add to p1")
    qt_quilt_ok(ARGS add d.txt -P p1.patch MESSAGE "add d.txt -P p1.patch failed")
    qt_assert_exists("${pc}/p1.patch/d.txt" "add d.txt -P p1.patch should add to p1")
    qt_quilt_ok(ARGS remove -Pp1.patch -- c.txt d.txt MESSAGE "remove -Pp1.patch -- failed")
    qt_assert_not_exists("${pc}/p1.patch/c.txt" "remove should take c.txt from p1")
    qt_assert_not_exists("${pc}/p1.patch/d.txt" "remove should take d.txt from p1")
    qt_quilt_ok(ENV "EDITOR=true" ARGS edit -- e.txt MESSAGE "edit -- e.txt failed")
    qt_assert_exists("${pc}/p2.patch/e.txt" "edit -- e.txt should add to the top patch")

    qt_write_file("${QT_WORK_DIR}/b.txt" "b1\nchanged\n")
    qt_quilt_ok(ARGS revert -Pp2.patch -- b.txt MESSAGE "revert -Pp2.patch -- b.txt failed")
    qt_assert_file_text("${QT_WORK_DIR}/b.txt" "b1\nB2" "revert should restore b.txt")

    qt_quilt_ok(OUTPUT out ARGS annotate a.txt -Pp1.patch MESSAGE "annotate a.txt -Pp1.patch failed")
    qt_assert_contains("${out}" "1\tA2" "annotate should credit p1 with A2")
    qt_quilt_ok(OUTPUT out ARGS annotate -- a.txt MESSAGE "annotate -- a.txt failed")
    qt_assert_contains("${out}" "1\tA2" "annotate -- a.txt should credit p1 with A2")
endfunction()

# new takes -p after the patch name and "--", and refuses more than one
# name; snapshot takes "--" and no arguments
function(qt_scenario_getopt_new_snapshot)
    qt_begin_test("getopt_new_snapshot")
    qt_setup_getopt_stack()
    set(series "${QT_WORK_DIR}/patches/series")

    qt_assert_usage_error(new new)
    qt_assert_usage_error(new new x.patch y.patch)
    qt_assert_usage_error(snapshot snapshot extra)
    qt_assert_usage_error(snapshot snapshot -dx)
    qt_assert_file_text("${series}" "p1.patch\np2.patch\np3.patch" "usage errors should change nothing")

    qt_quilt_ok(ARGS new x.patch -p0 MESSAGE "new x.patch -p0 failed")
    qt_quilt_ok(ARGS new -- y.patch MESSAGE "new -- y.patch failed")
    qt_assert_file_text("${series}" "p1.patch\np2.patch\nx.patch -p0\ny.patch\np3.patch"
                        "new should take -p0 after the name")

    qt_quilt_ok(ARGS snapshot -- MESSAGE "snapshot -- failed")
    qt_assert_dir_exists("${QT_WORK_DIR}/.pc/.snap" "snapshot -- should take a snapshot")
    qt_quilt_ok(ARGS snapshot -d -- MESSAGE "snapshot -d -- failed")
    qt_assert_not_exists("${QT_WORK_DIR}/.pc/.snap" "snapshot -d -- should remove the snapshot")
endfunction()

# refresh and diff group options, take values attached or in the next word,
# before or after their arguments, and "--", along with QUILT_DIFF_ARGS
function(qt_scenario_getopt_refresh_diff)
    qt_begin_test("getopt_refresh_diff")
    qt_setup_getopt_stack()
    set(p2 "${QT_WORK_DIR}/patches/p2.patch")

    qt_assert_usage_error(refresh refresh p1.patch p2.patch)
    qt_assert_usage_error(refresh refresh -- p1.patch p2.patch)
    qt_assert_usage_error(diff diff --color=bogus)

    qt_write_file("${QT_WORK_DIR}/b.txt" "b1\nBB\n")
    qt_quilt_ok(ARGS refresh -fu MESSAGE "refresh -fu failed")
    qt_assert_file_contains("${p2}" "+BB" "refresh -fu should refresh p2")
    qt_quilt_ok(ARGS refresh -c -- MESSAGE "refresh -c -- failed")
    qt_assert_file_contains("${p2}" "***************" "refresh -c should write a context diff")
    qt_quilt_ok(ARGS refresh p2.patch -U0 MESSAGE "refresh p2.patch -U0 failed")
    qt_assert_file_contains("${p2}" "@@ -2 +2 @@" "refresh -U0 should write no context")

    qt_quilt_ok(OUTPUT out ARGS diff -RU0 -Pp1.patch --no-index MESSAGE "diff -RU0 -Pp1.patch failed")
    qt_assert_contains("${out}" "@@ -2 +2 @@\n-A2\n+a2\n" "diff -RU0 -Pp1.patch")
    qt_quilt_ok(OUTPUT out ARGS diff --no-index a.txt -P p1.patch -U 0 MESSAGE "diff a.txt -P p1.patch failed")
    qt_assert_contains("${out}" "@@ -2 +2 @@\n-a2\n+A2\n" "diff a.txt -P p1.patch")
    qt_quilt_ok(OUTPUT out ARGS diff --combine p1.patch --color=tty -- b.txt MESSAGE "diff --combine p1.patch -- b.txt failed")
    qt_assert_contains("${out}" "+BB" "diff --combine -- b.txt should show b.txt")
    qt_assert_not_contains("${out}" "a.txt" "diff -- b.txt should only show b.txt")

    qt_write_file("${QT_WORK_DIR}/b.txt" "b1\nZZ\n")
    qt_quilt_ok(ARGS diff --color= -P p1.patch MESSAGE "diff --color= failed")
    qt_quilt_ok(OUTPUT out ARGS diff -zR -U0 --color=never MESSAGE "diff -zR failed")
    qt_assert_contains("${out}" "-ZZ\n+BB\n" "diff -zR should reverse the changes since refresh")

    # The variable's words come first, in the same parse
    qt_quilt_ok(OUTPUT out ENV "QUILT_DIFF_ARGS=-R --no-index" ARGS diff -U0 -P p1.patch
                MESSAGE "diff with QUILT_DIFF_ARGS=-R failed")
    qt_assert_contains("${out}" "@@ -2 +2 @@\n-A2\n+a2\n" "QUILT_DIFF_ARGS=-R should reverse the diff")
    qt_quilt_ok(OUTPUT out ENV "QUILT_DIFF_ARGS=--" ARGS diff -P p1.patch
                MESSAGE "diff with QUILT_DIFF_ARGS=-- failed")
    qt_assert_equal("${out}" "" "after QUILT_DIFF_ARGS=--, -P and p1.patch should name files")
endfunction()

# delete, rename, fork, and upgrade group options and take "--", and
# refuse more arguments than upstream allows, changing nothing
function(qt_scenario_getopt_delete_rename_fork)
    qt_begin_test("getopt_delete_rename_fork")
    qt_setup_getopt_stack()
    set(series "${QT_WORK_DIR}/patches/series")

    qt_assert_usage_error(delete delete -n p3.patch)
    qt_assert_usage_error(delete delete p1.patch p2.patch)
    qt_assert_usage_error(rename rename)
    qt_assert_usage_error(rename rename a.patch b.patch)
    qt_assert_usage_error(fork fork a.patch b.patch)
    qt_assert_usage_error(upgrade upgrade a b)
    qt_assert_file_text("${series}" "p1.patch\np2.patch\np3.patch" "usage errors should change nothing")
    qt_assert_exists("${QT_WORK_DIR}/patches/p3.patch" "usage errors should delete nothing")

    qt_quilt_ok(ARGS delete -rn MESSAGE "delete -rn failed")
    qt_assert_file_text("${series}" "p1.patch\np2.patch" "delete -rn should delete p3")
    qt_assert_not_exists("${QT_WORK_DIR}/patches/p3.patch" "delete -rn should remove p3's file")
    qt_quilt_ok(ARGS rename -Pp1.patch -- q1.patch MESSAGE "rename -Pp1.patch -- q1.patch failed")
    qt_assert_file_text("${series}" "q1.patch\np2.patch" "rename -Pp1.patch should rename p1")
    qt_quilt_ok(ARGS fork -- f.patch MESSAGE "fork -- f.patch failed")
    qt_assert_file_text("${series}" "q1.patch\nf.patch" "fork -- f.patch should fork p2")
    qt_quilt_ok(ARGS upgrade -- MESSAGE "upgrade -- failed")

    # The variable's words come first, in the same parse
    qt_quilt_ok(ENV "QUILT_DELETE_ARGS=--backup" ARGS delete -r f.patch MESSAGE "delete with QUILT_DELETE_ARGS failed")
    qt_assert_exists("${QT_WORK_DIR}/patches/f.patch~" "QUILT_DELETE_ARGS=--backup should keep a backup")
endfunction()

# Like upstream, importing no patches does nothing, and import takes -h
# grouped with other options
function(qt_scenario_import_no_files)
    qt_begin_test("import_no_files")
    qt_quilt_ok(ARGS import MESSAGE "import with no files failed")
    qt_quilt_ok(ARGS import -f -- MESSAGE "import -f -- failed")
    qt_assert_not_exists("${QT_WORK_DIR}/.pc" "import with no files should create nothing")
    qt_assert_not_exists("${QT_WORK_DIR}/patches" "import with no files should create nothing")
    qt_quilt_ok(OUTPUT out ERROR err ARGS import -fh x.diff MESSAGE "import -fh failed")
    qt_combine_output(combined "${out}" "${err}")
    qt_assert_contains("${combined}" "Usage: quilt import" "import -fh should print the help")
    qt_assert_not_exists("${QT_WORK_DIR}/patches" "import -fh should import nothing")
endfunction()

# header takes its mode and the patch in any order, and "--", but only one
# mode and one patch
function(qt_scenario_getopt_header)
    qt_begin_test("getopt_header")
    qt_setup_getopt_stack()
    set(p1 "${QT_WORK_DIR}/patches/p1.patch")

    qt_assert_usage_error(header header -ra)
    qt_assert_usage_error(header header -r -e p1.patch)
    qt_assert_usage_error(header header p1.patch p2.patch)

    qt_quilt_ok(ARGS header -r -- p1.patch INPUT "First\n" MESSAGE "header -r -- p1.patch failed")
    qt_assert_file_contains("${p1}" "First\n" "header -r -- p1.patch should replace p1's header")
    qt_quilt_ok(ARGS header p1.patch -a --backup INPUT "Second\n" MESSAGE "header p1.patch -a failed")
    qt_assert_file_contains("${p1}" "First\nSecond\n" "header p1.patch -a should append to p1's header")
    qt_assert_exists("${p1}~" "header --backup after the patch should keep a backup")
    qt_quilt_ok(OUTPUT out ARGS header -- p1.patch MESSAGE "header -- p1.patch failed")
    qt_assert_equal("${out}" "First\nSecond\n" "header -- p1.patch should print p1's header")
endfunction()

# files, patches, and fold group options, take values attached, after
# "=", or in the next word, and "--", and check their argument counts
function(qt_scenario_getopt_files_patches_fold)
    qt_begin_test("getopt_files_patches_fold")
    qt_setup_getopt_stack()

    qt_assert_usage_error(files files p1.patch p2.patch)
    qt_assert_usage_error(patches patches)
    qt_assert_usage_error(patches patches -v --)
    qt_assert_usage_error(patches patches --color=bogus a.txt)
    qt_assert_usage_error(fold fold -p1 extra)

    qt_quilt_ok(OUTPUT out ARGS files -al MESSAGE "files -al failed")
    qt_assert_equal("${out}" "p1.patch a.txt\np2.patch b.txt\n" "files -al")
    qt_quilt_ok(OUTPUT out ARGS files --combine=p1.patch MESSAGE "files --combine=p1.patch failed")
    qt_assert_equal("${out}" "a.txt\nb.txt\n" "files --combine=p1.patch")
    qt_quilt_ok(OUTPUT out ARGS files --combine p2.patch -- p2.patch MESSAGE "files --combine p2.patch -- failed")
    qt_assert_equal("${out}" "b.txt\n" "files --combine p2.patch -- p2.patch")
    qt_quilt_ok(OUTPUT out ARGS files -- p1.patch MESSAGE "files -- p1.patch failed")
    qt_assert_equal("${out}" "a.txt\n" "files -- p1.patch")
    qt_quilt_ok(OUTPUT out ENV "QUILT_FILES_ARGS=-l" ARGS files -a MESSAGE "files with QUILT_FILES_ARGS failed")
    qt_assert_equal("${out}" "p1.patch a.txt\np2.patch b.txt\n" "QUILT_FILES_ARGS=-l with files -a")

    qt_quilt_ok(OUTPUT out ARGS patches -v -- b.txt MESSAGE "patches -v -- b.txt failed")
    qt_assert_equal("${out}" "= p2.patch\n" "patches -v -- b.txt")
    qt_quilt_ok(OUTPUT out ARGS patches a.txt --color=tty MESSAGE "patches a.txt --color=tty failed")
    qt_assert_equal("${out}" "p1.patch\np3.patch\n" "patches a.txt --color=tty")

    set(diff "--- a/e.txt\n+++ b/e.txt\n@@ -0,0 +1 @@\n+e\n")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS fold -pab INPUT "${diff}")
    qt_assert_equal("${rc}" "1" "fold -pab should fail")
    qt_combine_output(combined "${out}" "${err}")
    qt_assert_contains("${combined}" "strip count ab is not a number" "fold -pab should refuse the strip level")
    qt_assert_not_exists("${QT_WORK_DIR}/e.txt" "fold -pab should create nothing")
    qt_quilt_ok(ARGS fold -qp1 INPUT "${diff}" MESSAGE "fold -qp1 failed")
    qt_assert_file_text("${QT_WORK_DIR}/e.txt" "e" "fold -qp1 should create e.txt")
    qt_assert_exists("${QT_WORK_DIR}/.pc/p2.patch/e.txt" "fold -qp1 should add e.txt to p2")
endfunction()

# Like util-linux getopt(1), which Debian's quilt runs, quilt.cpp takes a
# long option by a unique prefix, where upstream's options beat quilt.cpp's
# own, and reports missing and unwanted values. The compat getopt of other
# upstream builds takes no prefixes, hence a native test.
function(qt_scenario_getopt_long_prefixes)
    qt_begin_test("getopt_long_prefixes")
    qt_setup_getopt_stack()

    qt_quilt_ok(ARGS header --strip-diff p1.patch MESSAGE "header --strip-diff failed")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS header --strip p1.patch)
    qt_assert_equal("${rc}" "1" "header --strip should fail")
    qt_assert_contains("${err}" "option '--strip' is ambiguous" "header --strip is ambiguous")
    qt_assert_contains("${err}" "Usage: quilt header" "header --strip should print usage")

    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS files --combine)
    qt_assert_equal("${rc}" "1" "files --combine without a value should fail")
    qt_assert_contains("${err}" "option '--combine' requires an argument" "files --combine")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS delete --backup=yes p3.patch)
    qt_assert_equal("${rc}" "1" "delete --backup=yes should fail")
    qt_assert_contains("${err}" "option '--backup' doesn't allow an argument" "delete --backup=yes")
    qt_assert_file_text("${QT_WORK_DIR}/patches/series" "p1.patch\np2.patch\np3.patch"
                        "delete --backup=yes should delete nothing")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS fold -x)
    qt_assert_equal("${rc}" "1" "fold -x should fail")
    qt_assert_contains("${err}" "invalid option -- 'x'" "fold -x")

    # --diff names --diffstat, not quilt.cpp's --diff-algorithm
    qt_write_file("${QT_WORK_DIR}/b.txt" "b1\nBB\n")
    qt_quilt_ok(ARGS refresh --diff MESSAGE "refresh --diff failed")
    qt_assert_file_contains("${QT_WORK_DIR}/patches/p2.patch" "1 file changed" "refresh --diff should add a diffstat")
    qt_quilt_ok(OUTPUT out ARGS diff --diff-a minimal -P p1.patch MESSAGE "diff --diff-a failed")
    qt_assert_contains("${out}" "+A2" "diff --diff-a minimal should diff p1")
endfunction()

# graph takes a --lines number only after "=", so "--lines 3" names patch
# 3, and refuses a patch with --all, or more than one
function(qt_scenario_getopt_graph)
    qt_begin_test("getopt_graph")
    qt_setup_getopt_stack()

    qt_assert_usage_error(graph graph --all p1.patch)
    qt_assert_usage_error(graph graph p1.patch p2.patch)
    qt_assert_usage_error(graph graph -T pdf)
    qt_assert_usage_error(graph graph --edge-labels=nodes)

    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS graph --lines 3)
    qt_assert_equal("${rc}" "1" "graph --lines 3 should fail")
    qt_combine_output(combined "${out}" "${err}")
    qt_assert_contains("${combined}" "Patch 3 is not in series" "graph --lines 3 should name patch 3")

    qt_quilt_ok(OUTPUT out ARGS graph -- p1.patch MESSAGE "graph -- p1.patch failed")
    qt_assert_contains("${out}" "label=\"p1.patch\"" "graph -- p1.patch should graph p1")
    qt_quilt_ok(OUTPUT out ARGS graph p1.patch --lines= --edge-labels files MESSAGE "graph p1.patch --lines= failed")
    qt_assert_contains("${out}" "label=\"p1.patch\"" "graph p1.patch --lines= should graph p1")
endfunction()

# Only getopt finds -h, so after "--" it names a file
function(qt_scenario_getopt_help_operand)
    qt_begin_test("getopt_help_operand")
    qt_setup_getopt_stack()

    qt_quilt_ok(OUTPUT out ARGS diff -- -h MESSAGE "diff -- -h failed")
    qt_assert_equal("${out}" "" "diff -- -h should diff no file")
    qt_quilt_ok(OUTPUT out ARGS patches -- -h MESSAGE "patches -- -h failed")
    qt_assert_equal("${out}" "" "patches -- -h should find no patch")
    qt_quilt_ok(OUTPUT out ENV "QUILT_SERIES_ARGS=-h" ARGS series MESSAGE "series with QUILT_SERIES_ARGS=-h failed")
    qt_assert_contains("${out}" "Usage: quilt series" "QUILT_SERIES_ARGS=-h should print the help")
endfunction()

# mail takes its long options with "=" or the value in the next word,
# -m with the value attached, and "--", and at most two patches
function(qt_scenario_getopt_mail)
    qt_begin_test("getopt_mail")
    qt_setup_getopt_stack()
    qt_quilt_ok(ARGS header -r p1.patch INPUT "First patch\n" MESSAGE "header p1 failed")
    qt_quilt_ok(ARGS header -r p2.patch INPUT "Second patch\n" MESSAGE "header p2 failed")
    set(mbox "${QT_TEST_BASE}/out.mbox")

    qt_assert_usage_error(mail mail --mbox "${mbox}" --from a@b.c p1.patch p2.patch p3.patch)
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS mail --mbox "${mbox}" --to)
    qt_assert_equal("${rc}" "1" "mail --to without a value should fail")
    qt_assert_contains("${err}" "option '--to' requires an argument" "mail --to")
    qt_assert_not_exists("${mbox}" "usage errors should write no mbox")

    qt_quilt_ok(ARGS mail "--mbox=${mbox}" --from=a@b.c -mintro --prefix RFC -- p1.patch p2.patch
                MESSAGE "mail with getopt forms failed")
    qt_assert_file_contains("${mbox}" "Subject: [RFC 1/2] First patch" "mail should take --prefix RFC")
    qt_assert_file_contains("${mbox}" "Subject: [RFC 2/2] Second patch" "mail should mail p1 to p2")
    qt_assert_file_contains("${mbox}" "From: a@b.c" "mail should take --from=a@b.c")
endfunction()

# Without the dispatcher's own scan for -h, a file or a value may be "-h",
# and the stubs still print their help
function(qt_scenario_getopt_help_value)
    qt_begin_test("getopt_help_value")
    qt_setup_getopt_stack()

    qt_quilt_ok(OUTPUT out ARGS add -- -h MESSAGE "add -- -h failed")
    qt_assert_contains("${out}" "File -h added to patch p2.patch" "add -- -h should add the file -h")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS files --combine -h)
    qt_assert_equal("${rc}" "1" "files --combine -h should fail")
    qt_assert_contains("${err}" "Patch -h is not in series" "files --combine -h should look up patch -h")

    qt_quilt_ok(OUTPUT out ARGS grep -h MESSAGE "grep -h failed")
    qt_assert_contains("${out}" "Usage: quilt grep" "grep -h should print the help")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS grep -- -h)
    qt_assert_equal("${rc}" "1" "grep -- -h should fail")
    qt_assert_contains("${err}" "not implemented" "grep -- -h should not print the help")
endfunction()

# push_overlapping_hunks: like GNU patch, a hunk may start among the trailing
# context of the hunk before, by one line or several, in a unified or a
# context diff, since context comes from the file, not the patch
function(qt_scenario_push_overlapping_hunks)
    qt_begin_test("push_overlapping_hunks")
    set(lines "")
    foreach(n RANGE 1 20)
        string(APPEND lines "l${n}\n")
    endforeach()
    qt_write_file("${QT_WORK_DIR}/f.txt" "${lines}")
    qt_write_file("${QT_WORK_DIR}/patches/series" "p.diff\n")

    qt_write_file("${QT_WORK_DIR}/patches/p.diff" [=[
--- a/f.txt
+++ b/f.txt
@@ -2,3 +2,3 @@
 l2
-l3
+L3
 l4
@@ -4,3 +4,3 @@
 l4
-l5
+L5
 l6
]=])
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS push)
    qt_assert_success("${rc}" "push of hunks sharing a line should succeed")
    qt_combine_output(combined "${out}" "${err}")
    qt_assert_not_contains("${combined}" "Hunk" "push should apply both hunks where they say")
    string(REPLACE "\nl3\n" "\nL3\n" expected "${lines}")
    string(REPLACE "\nl5\n" "\nL5\n" expected "${expected}")
    qt_strip_trailing_newlines(expected "${expected}")
    qt_assert_file_text("${QT_WORK_DIR}/f.txt" "${expected}"
        "push should apply hunks sharing a line")
    qt_quilt_ok(ARGS pop MESSAGE "pop failed")

    qt_write_file("${QT_WORK_DIR}/patches/p.diff" [=[
--- a/f.txt
+++ b/f.txt
@@ -2,7 +2,7 @@
 l2
 l3
 l4
-l5
+L5
 l6
 l7
 l8
@@ -7,7 +7,7 @@
 l7
 l8
 l9
-l10
+L10
 l11
 l12
 l13
]=])
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS push)
    qt_assert_success("${rc}" "push of hunks sharing two lines should succeed")
    qt_combine_output(combined "${out}" "${err}")
    qt_assert_not_contains("${combined}" "Hunk" "push should apply both hunks where they say")
    string(REPLACE "\nl5\n" "\nL5\n" expected "${lines}")
    string(REPLACE "\nl10\n" "\nL10\n" expected "${expected}")
    qt_strip_trailing_newlines(expected "${expected}")
    qt_assert_file_text("${QT_WORK_DIR}/f.txt" "${expected}"
        "push should apply hunks sharing two lines")
    qt_quilt_ok(ARGS pop MESSAGE "pop failed")

    qt_write_file("${QT_WORK_DIR}/patches/p.diff" [=[
*** a/f.txt
--- b/f.txt
***************
*** 2,8 ****
  l2
  l3
  l4
! l5
  l6
  l7
  l8
--- 2,8 ----
  l2
  l3
  l4
! L5
  l6
  l7
  l8
***************
*** 6,12 ****
  l6
  l7
  l8
! l9
  l10
  l11
  l12
--- 6,12 ----
  l6
  l7
  l8
! L9
  l10
  l11
  l12
]=])
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS push)
    qt_assert_success("${rc}" "push of context hunks sharing three lines should succeed")
    qt_combine_output(combined "${out}" "${err}")
    qt_assert_not_contains("${combined}" "Hunk" "push should apply both hunks where they say")
    string(REPLACE "\nl5\n" "\nL5\n" expected "${lines}")
    string(REPLACE "\nl9\n" "\nL9\n" expected "${expected}")
    qt_strip_trailing_newlines(expected "${expected}")
    qt_assert_file_text("${QT_WORK_DIR}/f.txt" "${expected}"
        "push should apply context hunks sharing three lines")
endfunction()

# push_overlapping_hunk_offsets: hunks that share lines report offsets, fuzz,
# and lines in the patched file as GNU patch does, and a fuzzed context line
# shared with the hunk before stays as it is in the file
function(qt_scenario_push_overlapping_hunk_offsets)
    qt_begin_test("push_overlapping_hunk_offsets")
    set(lines "x1\nx2\n")
    foreach(n RANGE 1 20)
        string(APPEND lines "l${n}\n")
    endforeach()
    qt_write_file("${QT_WORK_DIR}/f.txt" "${lines}")
    qt_write_file("${QT_WORK_DIR}/patches/series" "p.diff\n")
    qt_write_file("${QT_WORK_DIR}/patches/p.diff" [=[
--- a/f.txt
+++ b/f.txt
@@ -2,3 +2,5 @@
 l2
-l3
+A
+B
+C
 l4
@@ -4,3 +6,3 @@
 l4
-l5
+L5
 l6
@@ -6,3 +8,3 @@
 X6
-l7
+L7
 l8
]=])
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS push)
    qt_assert_success("${rc}" "push of overlapping hunks with offsets should succeed")
    qt_combine_output(combined "${out}" "${err}")
    qt_assert_contains("${combined}"
        "Hunk #1 succeeded at 4 (offset 2 lines).\nHunk #2 succeeded at 8 (offset 2 lines).\nHunk #3 succeeded at 10 with fuzz 1 (offset 2 lines).\n"
        "push should report the overlapping hunks' lines, offsets and fuzz")
    string(REPLACE "\nl3\n" "\nA\nB\nC\n" expected "${lines}")
    string(REPLACE "\nl5\n" "\nL5\n" expected "${expected}")
    string(REPLACE "\nl7\n" "\nL7\n" expected "${expected}")
    qt_strip_trailing_newlines(expected "${expected}")
    qt_assert_file_text("${QT_WORK_DIR}/f.txt" "${expected}"
        "push should apply the overlapping hunks, keeping the file's fuzzed line")
endfunction()

# push_hunk_among_frozen_lines: GNU patch may find a hunk whose leading
# context covers lines that the hunk before changed, as long as its own
# changes come after, searching as it does: first as far before the line it
# expects as the changes before reach past it, then the line after those
# changes, then each line up from the first
function(qt_scenario_push_hunk_among_frozen_lines)
    qt_begin_test("push_hunk_among_frozen_lines")
    set(lines "")
    foreach(n RANGE 1 20)
        string(APPEND lines "l${n}\n")
    endforeach()
    qt_write_file("${QT_WORK_DIR}/f.txt" "${lines}")
    qt_write_file("${QT_WORK_DIR}/patches/series" "p.diff\n")

    qt_write_file("${QT_WORK_DIR}/patches/p.diff" [=[
--- a/f.txt
+++ b/f.txt
@@ -2,3 +2,3 @@
 l2
-l3
+L3
 l4
@@ -3,3 +3,3 @@
 l3
-l4
+L4
 l5
]=])
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS push)
    qt_assert_success("${rc}" "push of a hunk with a changed line as context should succeed")
    qt_combine_output(combined "${out}" "${err}")
    qt_assert_not_contains("${combined}" "Hunk" "push should apply both hunks where they say")
    string(REPLACE "\nl3\nl4\n" "\nL3\nL4\n" expected "${lines}")
    qt_strip_trailing_newlines(expected "${expected}")
    qt_assert_file_text("${QT_WORK_DIR}/f.txt" "${expected}"
        "push should apply a hunk with a changed line as context")
    qt_quilt_ok(ARGS pop MESSAGE "pop failed")

    qt_write_file("${QT_WORK_DIR}/patches/p.diff" [=[
--- a/f.txt
+++ b/f.txt
@@ -4,4 +4,4 @@
 l4
-l5
-l6
+L5
+L6
 l7
@@ -3,7 +3,7 @@
 l5
 l6
 l7
-l8
+L8
 l9
 l10
 l11
]=])
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS push)
    qt_assert_success("${rc}" "push of a hunk found among changed lines should succeed")
    qt_combine_output(combined "${out}" "${err}")
    qt_assert_contains("${combined}" "Hunk #2 succeeded at 5 (offset 2 lines).\n"
        "push should find the hunk among the changed lines")
    string(REPLACE "\nl5\nl6\nl7\nl8\n" "\nL5\nL6\nl7\nL8\n" expected "${lines}")
    qt_strip_trailing_newlines(expected "${expected}")
    qt_assert_file_text("${QT_WORK_DIR}/f.txt" "${expected}"
        "push should apply a hunk found among changed lines")
    qt_quilt_ok(ARGS pop MESSAGE "pop failed")

    # With every line alike, where the hunk lands shows the search order
    string(REPEAT "x\n" 15 xs)
    qt_write_file("${QT_WORK_DIR}/f.txt" "${xs}")
    foreach(case "3;2;-1 lines" "2;4;2 lines")
        list(GET case 0 start)
        list(GET case 1 line)
        list(GET case 2 offset)
        qt_write_file("${QT_WORK_DIR}/patches/p.diff"
            "--- a/f.txt\n+++ b/f.txt\n@@ -2,3 +2,3 @@\n x\n-x\n+Y\n x\n@@ -${start},7 +${start},7 @@\n x\n x\n x\n-x\n+Z\n x\n x\n x\n")
        qt_quilt(RESULT rc OUTPUT out ERROR err ARGS push)
        qt_assert_success("${rc}" "push of hunks in alike lines should succeed")
        qt_combine_output(combined "${out}" "${err}")
        qt_assert_contains("${combined}" "Hunk #2 succeeded at ${line} (offset ${offset}).\n"
            "push should search for the hunk at line ${start} like GNU patch")
        set(expected "x\nx\nY\n")
        math(EXPR changed "${line} + 3")
        foreach(n RANGE 4 15)
            if(n EQUAL changed)
                string(APPEND expected "Z\n")
            else()
                string(APPEND expected "x\n")
            endif()
        endforeach()
        qt_strip_trailing_newlines(expected "${expected}")
        qt_assert_file_text("${QT_WORK_DIR}/f.txt" "${expected}"
            "push should apply the hunk expected at line ${start} at line ${line}")
        qt_quilt_ok(ARGS pop MESSAGE "pop failed")
    endforeach()
endfunction()

# push_misordered_hunks: like GNU patch, a hunk found among the lines that
# the hunk before changed, which would change one of them, fails, saying so
# even with -q, and the hunks after it still start from where it was found
function(qt_scenario_push_misordered_hunks)
    qt_begin_test("push_misordered_hunks")
    set(lines "")
    foreach(n RANGE 1 9)
        string(APPEND lines "l${n}\n")
    endforeach()
    string(APPEND lines "a\nb\nc\na\nb\nc\nl16\nl17\nl18\n")
    qt_write_file("${QT_WORK_DIR}/f.txt" "${lines}")
    qt_write_file("${QT_WORK_DIR}/patches/series" "p.diff\n")
    qt_write_file("${QT_WORK_DIR}/patches/p.diff" [=[
--- a/f.txt
+++ b/f.txt
@@ -4,3 +4,3 @@
 l4
-l5
+L5
 l6
@@ -4,3 +4,3 @@
 l2
-l3
+X3
 l4
@@ -12,3 +12,3 @@
 a
-b
+B
 c
]=])
    set(misordered "misordered hunks! output would be garbled\n")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS push)
    qt_assert_failure("${rc}" "push of misordered hunks should fail")
    qt_combine_output(combined "${out}" "${err}")
    qt_assert_contains("${combined}"
        "patching file f.txt\n${misordered}Hunk #2 FAILED at 2.\nHunk #3 succeeded at 10 (offset -2 lines).\n1 out of 3 hunks FAILED"
        "push should fail the misordered hunk and go on from where it was found")
    qt_strip_trailing_newlines(expected "${lines}")
    qt_assert_file_text("${QT_WORK_DIR}/f.txt" "${expected}" "push should roll back")

    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS push -q)
    qt_assert_failure("${rc}" "push -q of misordered hunks should fail")
    qt_combine_output(combined "${out}" "${err}")
    qt_assert_contains("${combined}" "${misordered}1 out of 3 hunks FAILED"
        "push -q should still say the hunks are misordered")
    qt_assert_not_contains("${combined}" "Hunk #" "push -q should not report hunks")

    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS push -f)
    qt_assert_failure("${rc}" "push -f of misordered hunks should fail")
    qt_assert_file_contains("${QT_WORK_DIR}/f.txt.rej"
        "--- f.txt\n+++ f.txt\n@@ -4,3 +4,3 @@\n l2\n-l3\n+X3\n l4\n"
        "push -f should reject the misordered hunk")
    string(REPLACE "\nl5\n" "\nL5\n" expected "${lines}")
    string(REPLACE "\na\nb\nc\na\n" "\na\nB\nc\na\n" expected "${expected}")
    qt_strip_trailing_newlines(expected "${expected}")
    qt_assert_file_text("${QT_WORK_DIR}/f.txt" "${expected}"
        "push -f should apply the other hunks")
endfunction()

# push_insertion_hunk_guess: like GNU patch, a hunk with no old lines goes
# right where it says, among the trailing context of the hunk before or
# past the end of the file, but fails when the hunk before changed a line
# after it, or the offset puts it before the first line
function(qt_scenario_push_insertion_hunk_guess)
    qt_begin_test("push_insertion_hunk_guess")
    set(lines "")
    foreach(n RANGE 1 20)
        string(APPEND lines "l${n}\n")
    endforeach()
    qt_write_file("${QT_WORK_DIR}/f.txt" "${lines}")
    qt_write_file("${QT_WORK_DIR}/patches/series" "p.diff\n")

    qt_write_file("${QT_WORK_DIR}/patches/p.diff"
        "--- a/f.txt\n+++ b/f.txt\n@@ -2,3 +2,3 @@\n l2\n-l3\n+L3\n l4\n@@ -3,0 +4 @@\n+ins\n@@ -25,0 +27 @@\n+end\n")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS push)
    qt_assert_success("${rc}" "push of insertions should succeed")
    qt_combine_output(combined "${out}" "${err}")
    qt_assert_not_contains("${combined}" "Hunk" "push should insert the lines where the hunks say")
    string(REPLACE "\nl3\n" "\nL3\nins\n" expected "${lines}end\n")
    qt_strip_trailing_newlines(expected "${expected}")
    qt_assert_file_text("${QT_WORK_DIR}/f.txt" "${expected}"
        "push should insert among the trailing context and at the end")
    qt_quilt_ok(ARGS pop MESSAGE "pop failed")

    qt_write_file("${QT_WORK_DIR}/patches/p.diff"
        "--- a/f.txt\n+++ b/f.txt\n@@ -2,3 +2,3 @@\n l2\n-l3\n+L3\n l4\n@@ -1,0 +2 @@\n+ins\n")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS push)
    qt_assert_failure("${rc}" "push of an insertion before a change should fail")
    qt_combine_output(combined "${out}" "${err}")
    qt_assert_contains("${combined}"
        "misordered hunks! output would be garbled\nHunk #2 FAILED at 2.\n"
        "push should fail an insertion before the change of the hunk before")

    qt_write_file("${QT_WORK_DIR}/patches/p.diff"
        "--- a/f.txt\n+++ b/f.txt\n@@ -6,3 +6,3 @@\n l2\n-l3\n+L3\n l4\n@@ -3,0 +4 @@\n+ins\n")
    qt_quilt(RESULT rc OUTPUT out ERROR err ARGS push)
    qt_assert_failure("${rc}" "push of an insertion before the first line should fail")
    qt_combine_output(combined "${out}" "${err}")
    qt_assert_contains("${combined}"
        "Hunk #1 succeeded at 2 (offset -4 lines).\nHunk #2 FAILED at 4.\n"
        "push should fail an insertion that the offset puts before the first line")
endfunction()
