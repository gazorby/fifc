function _fifc_completion_group -d "Determine completion group"
    set -l path (_fifc_path_to_complete)
    # Null means that either $path is empty or is not a directory
    set -l is_null (ls --almost-all $path 2> /dev/null | string collect)
    set -l parsed_complist (_fifc_parse_complist)

    if test -n "$is_null"; and ls -d -- $parsed_complist &>/dev/null
        echo files
    else if string match --regex --quiet -- '\h+\-+\h*$' $_fifc_commandline
        echo options
    else if _fifc_parse_complist | string join '' | string match --regex --quiet '^[0-9]+$'
        echo pid
    end
end
