function _fifc_source_files -d "Return a command to recursively find files"
    set -l path (_fifc_path_to_complete | string escape)
    set -l hidden (string match "*." "$path")

    if string match --quiet -- '~*' "$fifc_query"
        set -e fifc_query
    end

    if type -q fd
        if test "$path" = {$PWD}/
            echo "fd . --color=always $fifc_fd_opts"
        else if test "$path" = "."
            echo "fd . --color=always --hidden $fifc_fd_opts"
        else if test -n "$hidden"
            echo "fd . --color=always --hidden $fifc_fd_opts -- $path"
        else
            echo "fd . --color=always $fifc_fd_opts -- $path"
        end
    else if test -n "$hidden"
        # Use sed to strip cwd prefix
        echo "find . $path ! -path . -print $fifc_find_opts 2>/dev/null | sed 's|^\./||'"
    else
        # Exclude hidden directories
        echo "find . $path ! -path . ! -path '*/.*' -print $fifc_find_opts 2>/dev/null | sed 's|^\./||'"
    end
end
