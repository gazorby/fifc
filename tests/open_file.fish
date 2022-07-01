set dir "tests/_resources/dir with spaces"
set fifc_file_editor cat
set candidate "$dir/file 1.txt"

set actual (_fifc_open_file)
@test "builtin file open" "$actual" = 'foo 1'
