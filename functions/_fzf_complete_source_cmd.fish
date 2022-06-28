function _fzf_complete_source_cmd -d "Return the command that will produce completion list"
    if _fzf_complete_is_file_group
        set -l path (_fzf_complete_commandline_to_path)
        set -l hidden (string match "*." "$path")
        if type -q fd
            if test "$path" = {$PWD}/
                echo "fd . --color=always --strip-cwd-prefix $fzf_complete_fd_opts"
            else if test "$path" = "."
                echo "fd . --color=always --strip-cwd-prefix --hidden $fzf_complete_fd_opts"
            else if test -n "$hidden"
                echo "fd . --color=always --hidden $fzf_complete_fd_opts $path"
            else
                echo "fd . --color=always $fzf_complete_fd_opts $path"
            end
        else if test -n "$hidden"
            echo "find . $path -not -path '*/.*' -print $fzf_complete_find_opts | sed 's|^\./||'"
        else
            echo "find . $path -print $fzf_complete_find_opts | sed 's|^\./||'"
        end
    else
        echo "_fzf_complete_complist_parse"
    end
end
