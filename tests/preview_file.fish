set dir "tests/_resources/dir with spaces"
set candidate "$dir/file 1.txt"
set fifc_bat_opts '--color=never'

set actual (_fifc_preview_file)
@test "builtin file preview" "$actual" = 'foo 1'
