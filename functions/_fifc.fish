function _fifc
    set -l fish_version (string split -- '.' $FISH_VERSION)
    set -l complist
    set -l result
    set -Ux _fifc_group
    set -Ux _fifc_extract
    set -Ux _fifc_complist
    set -Ux _fifc_commandline
    set -Ux _fifc_current_token (commandline --current-token)
    set -Ux _fifc_custom_fzf_opts

    # Get commandline buffer
    if test "$argv" = ""
        set _fifc_commandline (commandline --cut-at-cursor)
    else
        set _fifc_commandline $argv
    end

    set -l query $_fifc_commandline

    # Get completion list
    # --escape is only available on fisher 3.4+
    if test $fish_version[2] -ge 4
        set complist (complete -C --escape $_fifc_commandline)
    else
        set complist (complete -C $_fifc_commandline)
    end

    # Split using '/' as it can't be used in filenames
    set -gx _fifc_complist (string join -- ' / ' $complist)

    if string match --quiet --regex -- '\w+ +-+ *$' "$_fifc_commandline"
        set -e query
    else
        # Set intial query to the last token from commandline buffer
        set query (string split -- ' ' $query)
        set query $query[-1]
    end

    # We use eval hack because wrapping source command
    # inside a function cause some delay before fzf to show up
    # set -l source_cmd (_fifc_source_cmd)
    set -l source_cmd (_fifc_action source)
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
            --preview '_fifc_action preview {}' \
            --bind='$fifc_open_keybinding:execute(_fifc_action open {} &> /dev/tty)' \
            --query '$query' \
            $_fifc_custom_fzf_opts"

    set -l cmd (string join -- " | " $source_cmd $fzf_cmd)

    # Perform extraction if needed
    eval $cmd | while read -l token
        set -a result (string escape -- $token)
        if test -n "$_fifc_extract"
            set result[-1] (string match --regex --groups-only "$_fifc_extract" "$token")
        end
    end

    # Add space trailing space only if:
    # - there is no trailing space already present
    # - Result is not a directory
    if test (count $result) -eq 1; and not test -d $result[1]
        set -l buffer (string split -- "$_fifc_commandline" (commandline -b))
        if not string match -- ' *' "$buffer[2]"
            set -a result ''
        end
    end

    if test -n "$result"
        commandline --replace --current-token -- (string join -- ' ' $result)
    end

    commandline --function repaint

    # Clean state
    set -e _fifc_group
    set -e _fifc_extract
    set -e _fifc_complist
    set -e _fifc_commandline
    set -e _fifc_current_token
    set -e _fifc_custom_fzf_opts
end
