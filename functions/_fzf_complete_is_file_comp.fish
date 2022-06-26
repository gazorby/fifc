function _fzf_complete_is_file_comp -d "Determine wether fish suggest file completion or not"
    set -l path (_fzf_complete_commandline_to_path)
    # Null means that either $path is empty or is not a directory
    set -l is_null (ls --almost-all $path 2> /dev/null | string collect)

    if test $_fzf_complete_is_opt = "1"; or test -z "$is_null"
        return 1
    end

    for item in (_fzf_complete_complist_split | string unescape)
        if not test -f $item; and not test -d $item; and not test -L $item
            return 1
        end
    end

    # return 0

    # We compare fish suggestion with file list in $PWD or path from current token,
    # if both list match fish completion is considered to be file completion
    # if string match '*.' "$path"
    #     set pattern "(.*)"
    # else
    #     set pattern "^([^\.].*)"
    #     # set prefix $path
    # end

    # set -l fish_comp (_fzf_complete_complist_split | sort | string unescape | string collect)
    # set -l pwd_files ( \
    #     # ls -1 -p --dereference-command-line-symlink-to-dir "$path" \
    #     find -L $path -mindepth 1 -maxdepth 1 -type d -printf '%p/\n' -o -print \
    #     # | string match -r --groups-only "^$PWD/([^\.].*)"
    #     | sort \
    #     | string unescape \
    #     | string replace --regex "^$PWD/(.*)" '$1' \
    #     | string replace --regex "^\./(.*)" '$1' \
    #     | string match --regex --groups-only "$pattern" \
    #     # | string match --regex '^(?!\n).*$' \
    #     | string collect \
    #     # | string trim \
    # )
    # echo "$pwd_files"
    # echo ""
    # echo "$fish_comp"
    # if test "$fish_comp" = "$pwd_files"
    #     return 0
    # else
    #     return 1
    # end
end
