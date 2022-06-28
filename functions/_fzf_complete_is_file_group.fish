function _fzf_complete_is_file_group -d "Determine wether fish suggest file completion or not"
    set -l path (_fzf_complete_commandline_to_path)
    # Null means that either $path is empty or is not a directory
    set -l is_null (ls --almost-all $path 2> /dev/null | string collect)

    if not ls -d -- (_fzf_complete_complist_parse) &> /dev/null
        or test -z "$is_null"
        return 1
    end
end
