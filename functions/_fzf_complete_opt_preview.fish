function _fzf_complete_opt_preview -d "Open man page of a command starting at the selected option"
    set -l regex (printf $fzf_complete_opt_preview_regex (string trim -- "$argv"))
    set -l cmd (_fzf_complete_parse_commandline)
    set -l out ( \
        man $cmd 2>/dev/null \
        | string trim \
        # PCRE2 needed as regex has lookaround
        | rg -U --multiline-dotall --pcre2 $regex \
    )
    # Pretty printing
    set_color brgreen; echo -e "$out[1]"
    set_color --bold white; echo -e (string join -- "\n" "" $out[2..-1])
    set_color normal
end
