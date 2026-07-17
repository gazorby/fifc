set curr_home $HOME
set curr_fifc_unordered_comp $_fifc_unordered_comp
set curr_fifc_ordered_comp $_fifc_ordered_comp

set test_home (mktemp -d)
set -gx HOME "$test_home"
mkdir -p "$HOME/downloads"
echo "preview works" >"$HOME/downloads/file.txt"

set _fifc_complist_path (mktemp)
set fifc_commandline "cat ~/downloads/"
set _fifc_ordered_comp
set comp_1 'test -f "$fifc_candidate"' '.*' 'cat "$fifc_candidate"'
set _fifc_unordered_comp comp_1

set actual (_fifc_action preview '~/downloads/file.txt')

@test "preview works with tilde candidate" "$actual" = "preview works"

command rm -rf "$test_home"
command rm $_fifc_complist_path
set -gx HOME "$curr_home"
set -gx _fifc_unordered_comp $curr_fifc_unordered_comp
set -gx _fifc_ordered_comp $curr_fifc_ordered_comp
