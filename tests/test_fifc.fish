set curr_fifc_unordered_comp $_fifc_unordered_comp
set _fifc_unordered_comp

fifc \
    -n 'test -n "$fifc_desc"' \
    -r '^functions\h+|^\h+' \
    -p _fifc_preview_fn \
    -o _fifc_open_fn

@test "fifc command completion added" (count $_fifc_unordered_comp) = 1
@test "fifc command completion condition" "$$_fifc_unordered_comp[1][1]" = 'test -n "$fifc_desc"'
@test "fifc command completion regex" "$$_fifc_unordered_comp[1][2]" = '^functions\h+|^\h+'
@test "fifc command completion preview" "$$_fifc_unordered_comp[1][3]" = _fifc_preview_fn
@test "fifc command completion open" "$$_fifc_unordered_comp[1][4]" = _fifc_open_fn

# set _fifc_unordered_comp
fifc \
    -n 'test -n "$fifc_desc"' \
    -r '^functions\h+|^\h+' \
    -s source_cmd

@test "fifc source added" (count $_fifc_unordered_comp) = 2
@test "fifc source condition" "$$_fifc_unordered_comp[2][1]" = 'test -n "$fifc_desc"'
@test "fifc source regex" "$$_fifc_unordered_comp[2][2]" = '^functions\h+|^\h+'
@test "fifc source command" "$$_fifc_unordered_comp[2][5]" = source_cmd

set -gx _fifc_unordered_comp $curr_fifc_unordered_comp
