function _fzf_complete_open_dir
    if type -q broot
        broot --color=yes $candidate
    end
end
