set candidate mkdir
set fifc_bat_opts '--color=never'

set actual (_fifc_open_cmd)
set expected (man mkdir)
@test "builtin cmd open" "$actual" = "$expected"
