set curr_fifc_unordered_comp $_fifc_unordered_comp
set dir "tests/_resources/dir with spaces"

function _fifc_test_exposed_vars
    switch $var
        case candidate
            echo -n "$fifc_candidate"
        case group
            echo -n "$fifc_group"
        case token
            echo -n "$fifc_token"
        case commandline
            echo -n "$fifc_commandline"
        case extracted
            echo -n "$fifc_extracted"
    end
end


set comp_1 \
    'test -f $fifc_candidate' \
    '.*' \
    _fifc_test_exposed_vars \
    open_cmd \
    source_cmd \
    --fzf_option \
    '.*/(.*\.txt)$'

set _fifc_unordered_comp comp_1

set var candidate
set actual (_fifc_action "preview" "$dir/file 1.txt")
@test "exposed vars fifc_candidate" "$actual" = "$dir/file 1.txt"

set var group
set _fifc_complist (string join $_fifc_complist_sep "$dir/file 1.txt" "$dir/file 2.txt")
set actual (_fifc_action "preview" "$dir/file 1.txt")
@test "exposed vars fifc_group" "$actual" = files

set var extracted
set -x fifc_extracted
set _fifc_extract_regex '.*/(.*\.txt)$'
set actual (_fifc_action "preview" "$dir/file 1.txt")
@test "exposed vars fifc_extracted" "$actual" = "file 1.txt"
