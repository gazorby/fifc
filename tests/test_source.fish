set curr_fifc_unordered_comp $_fifc_unordered_comp
set curr_fifc_ordered_comp $_fifc_ordered_comp
set _fifc_complist_path (mktemp)

# Add unordered sources
set comp_1 'test "$any" = "1"' '^kill $' '' '' 'echo comp_1'
set comp_2 'test "$any" = "2"' '^ps -p $' '' '' 'echo comp_2'
set _fifc_unordered_comp comp_1 comp_2

set fifc_commandline "kill "
set any 1
set actual (_fifc_action "source")
@test "source match first" "$actual" = "echo comp_1"

set fifc_commandline "ps -p "
set any 2
set actual (_fifc_action "source")
@test "source match second" "$actual" = "echo comp_2"

set fifc_commandline "foo "
set actual (_fifc_action "source")
@test "source fallback fish suggestions" "$actual" = _fifc_parse_complist

set -e fifc_commandline
set -gx _fifc_unordered_comp $curr_fifc_unordered_comp
set -gx _fifc_unordered_comp $curr_fifc_ordered_comp
command $fifc_rm_cmd $_fifc_complist_path
