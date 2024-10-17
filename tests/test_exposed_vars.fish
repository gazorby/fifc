set curr_fifc_unordered_comp $_fifc_unordered_comp
set dir "tests/_resources/dir with spaces"
set _fifc_complist_path (mktemp)

function _fifc_test_exposed_vars
    switch $var
        case candidate
            echo -n "$fifc_candidate"
        case extracted
            echo -n "$fifc_extracted"
        case query
            echo -n "$fifc_query"
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

set var extracted
set -x fifc_extracted
set _fifc_extract_regex '.*/(.*\.txt)$'
set actual (_fifc_action "preview" "$dir/file 1.txt")
@test "exposed vars fifc_extracted" "$actual" = "file 1.txt"

set var query
set -x fifc_query
set actual (_fifc_action "preview" "$dir/file 1.txt" "1")
@test "exposed vars fifc_query" "$actual" = 1

command $fifc_rm_cmd $_fifc_complist_path
