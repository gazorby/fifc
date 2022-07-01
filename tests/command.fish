set curr_fifc_unordered_comp $_fifc_unordered_comp
set curr_fifc_ordered_comp $_fifc_ordered_comp

# Add unordered completion
set comp_1 'test -f $candidate' '^cat $' 'echo comp_1' ''
set comp_2 'test -d $candidate' '^ls $' 'echo comp_2' ''
set _fifc_unordered_comp comp_1 comp_2

set _fifc_commandline "cat "
set actual (_fifc_action "preview" 'tests/_resources/dir with spaces/file 1.txt')
@test "preview match condition and regex first completion" "$actual" = comp_1

set _fifc_commandline "ls "
set actual (_fifc_action "preview" 'tests/_resources/dir with spaces')
@test "preview match condition and regex second completion" "$actual" = comp_2

set _fifc_complist "fallback    description"
set _fifc_commandline "fallback "
set actual (_fifc_action "preview" 'fallback')
@test "preview fallback fish description" "$actual" = description

# Add ordered completion
set o_comp_1 'test -f $candidate' '^cat $' 'echo o_comp_1' ''
set _fifc_ordered_comp o_comp_1
set _fifc_commandline "cat "
set actual (_fifc_action "preview" 'tests/_resources/dir with spaces/file 1.txt')
@test "preview match condition and regex ordered completion" "$actual" = o_comp_1

set -e _fifc_commandline
set -gx _fifc_unordered_comp $curr_fifc_unordered_comp
set -gx _fifc_ordered_comp $curr_fifc_ordered_comp
