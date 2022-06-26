function fzf_complete
    set -l fish_version (string split -- '.' $FISH_VERSION)
    set -l complist
    set -l result
    set -U _fzf_complete_is_opt 0
    set -Ux _fzf_complete_current_token (commandline --current-token)

    # Get commandline buffer
    if test "$argv" = ""
        set -U _fzf_complete_commandline (commandline --cut-at-cursor)
    else
        set -U _fzf_complete_commandline $argv
    end

    set -l query $_fzf_complete_commandline

    # Get completion list
    # --escape is only available on fisher 3.4+
    if test $fish_version[2] -ge 4
        set complist (complete -C --escape $_fzf_complete_commandline)
    else
        set complist (complete -C $_fzf_complete_commandline)
    end

    # Split using '/' as it can't be used in filenames
    set -gx _fzf_complete_complist (string join -- ' / ' $complist)

    if string match --quiet --regex -- '\w+ +-+ *$' "$_fzf_complete_commandline"
        set -e query
        set _fzf_complete_is_opt 1
    else
        # Set intial query to the last token from commandline buffer
        set query (string split -- ' ' $query)
        set query $query[-1]
    end

    # We use eval hack because wrapping source command
    # inside a function cause some delay before fzf to show up
    set -l source_cmd (_fzf_complete_source_cmd)
    set -l fzf_cmd "
        fzf \
            -d \t \
            --exact \
            --tiebreak=length \
            --select-1 \
            --exit-0 \
            --ansi \
            --tabstop=4 \
            --multi \
            --reverse \
            --header '$header' \
            --preview '_fzf_complete_action preview {}' \
            --bind='$fzf_complete_open_keybinding:execute(_fzf_complete_action open {} &> /dev/tty)' \
            --query '$query'"

    set -l cmd (string join -- " | " $source_cmd $fzf_cmd)
    eval $cmd | while read --local token; set -a result $token; end

    # Add space trailing space only if:
    # - there is no trailing space already present
    # - Result is not a directory
    if test (count $result) -eq 1; and not test -d $result[1]
        set -l buffer (string split -- "$_fzf_complete_commandline" (commandline -b))
        if not string match -- ' *' "$buffer[2]"
            set -a result ''
        end
    end

    if test -n "$result"
        commandline --replace --current-token -- (string join -- ' ' $result)
    end

    commandline --function repaint

    # Clean state
    set -e result
    set -e _fzf_complete_is_opt
    set -e _fzf_complete_complist
    set -e _fzf_complete_file_group
    set -e _fzf_complete_commandline
    set -e _fzf_complete_current_token
    set -e _fzf_complete_reloaded_files
end

# --bind='change:reload(_fzf_complete_reload_files)+unbind(change)' \
# --bind=\"$fzf_complete_search_keybinding:clear-query+reload(_fzf_complete_action search {})\" \
