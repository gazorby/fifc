function _fifc_open_process -d "Open the tree view of the selected process (procs only)"
    set -l pid (_fifc_parse_pid "$fifc_candidate")

    if type -q procs
        procs --color=always --tree --pager=always $fifc_procs_opts "$pid"
    end
end
