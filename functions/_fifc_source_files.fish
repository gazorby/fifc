function _fifc_source_files -d "Return a command to recursively find files"
    set -l raw_path (_fifc_path_to_complete)
    set -l escaped_path (string escape -- $raw_path)
    set -l hidden (string match "*." "$raw_path")

    if string match --quiet -- '~*' "$fifc_query"
        set -e fifc_query
    end

    if type -q fd
        if _fifc_test_version (fd --version) -ge "8.3.0"
            set fd_custom_opts --strip-cwd-prefix
        end

        if test "$raw_path" = "$PWD/"
            echo "fd . $fifc_fd_opts --color=always $fd_custom_opts"
        else if test "$raw_path" = "."
            echo "fd . $fifc_fd_opts --color=always --hidden $fd_custom_opts"
        else if test -n "$hidden"
            echo "fd . $fifc_fd_opts --color=always --hidden -- $escaped_path"
        else
            echo "fd . $fifc_fd_opts --color=always -- $escaped_path"
        end
    else if test -n "$hidden"
        # Use sed to strip cwd prefix
        echo "find . $escaped_path $fifc_find_opts ! -path . -print 2>/dev/null | sed 's|^\./||'"
    else
        # Exclude hidden directories
        echo "find . $escaped_path $fifc_find_opts ! -path . ! -path '*/.*' -print 2>/dev/null | sed 's|^\./||'"
    end
end
