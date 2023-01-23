set dir "tests/_resources/dir with spaces"
set curr_fifc_editor $fifc_editor
set fifc_editor cat
set fifc_candidate "$dir/file 1.txt"

set actual (_fifc_open_file)
@test "builtin file open" "$actual" = 'foo 1'

set fifc_editor $curr_fifc_editor
