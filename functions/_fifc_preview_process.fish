function _fifc_preview_process -d "Preview process informations"
    set -l pid (_fifc_parse_pid "$fifc_candidate")
    set -l err_msg "\nThe process exited"

    if type -q procs
        procs --color=always --tree $fifc_procs_opts "$pid"
    else
        set -l ps_preview_fmt (string join ',' 'pid' 'ppid=PARENT' 'user' '%cpu' 'rss=RSS_IN_KB' 'start=START_TIME' 'command')
        ps -o "$ps_preview_fmt" -p "$pid" 2>/dev/null
    end
    if not ps -p "$pid" &>/dev/null
        set_color yellow
        echo -e "$err_msg"
    end
end
