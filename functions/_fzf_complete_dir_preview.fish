function _fzf_complete_dir_preview
    if type -q exa
        exa $fzf_complete_exa_opts $argv
    else
        ls --color=always --all
    end
end
