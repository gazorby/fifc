function _fifc_preview_dir -d "List content of the selected directory"
    if type -q exa
        exa --color=always $fifc_exa_opts $fifc_candidate
    else
        ls --color=always $fifc_ls_opts $fifc_candidate
    end
end
