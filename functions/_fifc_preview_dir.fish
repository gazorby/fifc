function _fifc_preview_dir -d "List content of the selected directory"
    if type -q exa
        exa $fifc_exa_opts $fifc_candidate
    else
        ls --color=always --all $fifc_candidate
    end
end
