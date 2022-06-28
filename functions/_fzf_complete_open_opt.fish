function _fzf_complete_open_opt
    set -l cmd (string match --regex --groups-only -- '(\w+) ?-*' "$commandline")
    set -l opt (string trim --chars '\n ' -- "$candidate")
    set -l regex "^\h*(-+[^\n]*)*$opt"

    if type -q bat
        man $cmd \
            | bat --color=always --language man $fzf_complete_bat_opts \
            # --RAW-CONTROL-CHARS allow color output of bat to be displayed
            | less --RAW-CONTROL-CHARS --pattern "$regex"
    else
        man $cmd | less --pattern "$regex"
    end
end
