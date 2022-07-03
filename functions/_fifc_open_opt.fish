function _fifc_open_opt -d "Open a man page starting at the selected option"
    set -l cmd (string match --regex --groups-only -- '(^|\h+)(\w+) ?-*$' "$fifc_commandline")
    set -l opt (string trim --chars '\n ' -- "$fifc_candidate")
    set -l regex "^\h*(-+[^\n]*)*$opt"

    if type -q bat
        man $cmd \
            | bat --color=always --language man $fifc_bat_opts \
            # --RAW-CONTROL-CHARS allow color output of bat to be displayed
            | less --RAW-CONTROL-CHARS --pattern "$regex"
    else
        man $cmd | less --pattern "$regex"
    end
end
