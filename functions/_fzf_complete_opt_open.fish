function _fzf_complete_opt_open
    set -l cmd (_fzf_complete_parse_commandline)
    set -l pattern (printf $fzf_complete_opt_open_regex "$argv")

    if type -q bat
        man $cmd \
            | bat --color=always --language man $fzf_complete_bat_opts \
            # --RAW-CONTROL-CHARS allow color output of bat to be displayed
            | less --RAW-CONTROL-CHARS --pattern "$pattern"
    else
        man $cmd | less --pattern "$pattern"
    end
end
