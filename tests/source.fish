set curr_fifc_unordered_sources $_fifc_unordered_sources
set curr_fifc_ordered_sources $_fifc_ordered_sources

# Add unordered sources
set source_1 'test "$any" = "1"' '^kill $' 'echo source_1'
set source_2 'test "$any" = "2"' '^ps -p $' 'echo source_2'
set _fifc_unordered_sources source_1 source_2

set _fifc_commandline "kill "
set any 1
set actual (_fifc_action "source")
@test "source match first" "$actual" = "echo source_1"

set _fifc_commandline "ps -p "
set any 2
set actual (_fifc_action "source")
@test "source match second" "$actual" = "echo source_2"

set _fifc_commandline "foo "
set actual (_fifc_action "source")
@test "source fallback fish suggestions" "$actual" = "_fifc_parse_complist"

set -e _fifc_commandline
set -gx _fifc_unordered_sources $curr_fifc_unordered_sources
set -gx _fifc_unordered_sources $curr_fifc_ordered_sources
