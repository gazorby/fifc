set curr_fifc_unordered_comp $_fifc_unordered_comp
set curr_fifc_ordered_comp $_fifc_ordered_comp
set dir "tests/_resources/dir with spaces"
set _fifc_complist_path (mktemp)

# Add unordered completions
set comp_1 \
    'test -f $fifc_candidate' \
    '^cat $' \
    'echo comp_1' \
    open_cmd \
    source_cmd \
    --fzf_option \
    extract_regex

set comp_2 \
    'test -d $fifc_candidate' \
    '^ls $' \
    'echo comp_2' \
    open_cmd \
    source_cmd \
    --fzf_option \
    extract_regex

set _fifc_unordered_comp comp_1 comp_2

set fifc_commandline "cat "
set actual (_fifc_action "preview" "$dir/file 1.txt")
@test "preview match condition and regex first completion" "$actual" = comp_1

set fifc_commandline "ls "
set actual (_fifc_action "preview" "$dir")
@test "preview match condition and regex second completion" "$actual" = comp_2

echo "fallback    description" >$_fifc_complist_path
set fifc_commandline "fallback "
set actual (_fifc_action "preview" 'fallback')
@test "preview fallback fish description" "$actual" = description

# Add ordered completion, should be evaluated before unordered ones
set o_comp_1 \
    'test -f $fifc_candidate' \
    '^cat $' \
    'echo o_comp_1' \
    open_cmd \
    source_cmd_1 \
    --fzf_option_1 \
    extract_regex_1

set _fifc_ordered_comp o_comp_1
set fifc_commandline "cat "
set actual (_fifc_action "preview" "$dir/file 1.txt")
@test "preview match condition and regex ordered completion" "$actual" = o_comp_1

set -e fifc_commandline
set -gx _fifc_unordered_comp $curr_fifc_unordered_comp
set -gx _fifc_ordered_comp $curr_fifc_ordered_comp
command $fifc_rm_cmd $_fifc_complist_path
