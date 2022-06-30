function _fifc_preview_dir -d "List content of the selected directory"
    if type -q exa
        exa $fifc_exa_opts $candidate
    else
        ls --color=always --all $candidate
    end
end
