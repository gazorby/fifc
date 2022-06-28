function _fzf_complete_preview_dir
    if type -q exa
        exa $fzf_complete_exa_opts $candidate
    else
        ls --color=always --all $candidate
    end
end
