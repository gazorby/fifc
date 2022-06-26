function _fzf_complete_dir_open
    if type -q broot
        broot --color=yes $argv
    end
end
