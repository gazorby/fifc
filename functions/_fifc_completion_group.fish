function _fifc_completion_group -d "Determine completion group"
    set -l path_candidate (_fifc_path_to_complete)
    # Null means that either $path is empty or is not a directory
    set -l is_null (ls -A -- $path_candidate 2> /dev/null | string collect)
    set -l complist (_fifc_expand_tilde (_fifc_parse_complist))

    set -l dir_test "test -d '$complist[1]"
    set dir_test (string join "' -a -d '" $dir_test $complist[2..-1])
    set dir_test $complist"'"
    if test -n "$is_null"; and eval "$dir_test"
        echo directories
        # When complist is big, avoid calling ls with all arguments if first is neither a file nor a directory
    else if test -n "$is_null"; and test \( -f "$complist[1]" -o -d "$complist[1]" \); and echo (string escape -- $complist) | xargs ls -d -- &>/dev/null
        echo files
    else if string match --regex --quiet -- '\h+\-+\h*$' $fifc_commandline
        set -e fifc_query
        echo options
    else if string join -- '' (string escape -- $complist) | string match --regex --quiet '^[0-9]+$'
        echo processes
    end
end
