set curr_fifc_unordered_comp $_fifc_unordered_comp

# Add completion
set comp_1 'test -f $candidate' '^cat $' 'echo comp_1' ''
set comp_2 'test -d $candidate' '^ls $' 'echo comp_2' ''
set _fifc_unordered_comp comp_1 comp_2

set _fifc_commandline "cat "
set actual (_fifc_action "preview" 'tests/_resources/dir with spaces/file 1.txt')
@test "match condition and regex first comp" "$actual" = "comp_1"

set _fifc_commandline "ls "
set actual (_fifc_action "preview" 'tests/_resources/dir with spaces')
@test "match condition and regex second comp" "$actual" = "comp_2"

set _fifc_complist "fallback    description"
set _fifc_commandline "fallback "
set actual (_fifc_action "preview" 'doesnotexists')
@test "no match" "$actual" = "fallback"

set -e _fifc_commandline
set -gx _fifc_unordered_comp $curr_fifc_unordered_comp
