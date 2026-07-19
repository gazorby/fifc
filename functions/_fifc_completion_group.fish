function _fifc_completion_group -d "Determine completion group"
    set -l path_candidate (_fifc_path_to_complete)
    # Null means that either $path is empty or is not a directory
    set -l is_null (ls -A -- $path_candidate 2> /dev/null | string collect)
    set -l complist (string escape -- (_fifc_expand_tilde (_fifc_parse_complist)))
    # Directories
    set -l dir_test "test -d $complist[1]"
    set dir_test (string join -- " -a -d " $dir_test $complist[2..-1])

    # Only treat the completion as file/dir path completion when fish's list is
    # the plain listing of the completed dir. Otherwise fish is offering specific
    # paths (e.g. `git worktree remove`), which must be forwarded unchanged.
    set -l generic 0
    if test -n "$is_null"; and _fifc_is_generic_path "$path_candidate"
        set generic 1
    end

    if test "$generic" = 1; and eval "$dir_test"
        echo directories
        # Files
        # When complist is big, avoid calling ls with all arguments if first is neither a file nor a directory
    else if test "$generic" = 1; and echo $complist | xargs ls -d -- &>/dev/null
        echo files
        # Options
    else if string match --regex --quiet -- '\h+\-+\h*$' $fifc_commandline
        set -e fifc_query
        echo options
        # PIDs
    else if string join -- '' $complist | string match --regex --quiet '^[0-9]+$'
        echo processes
    end
end
