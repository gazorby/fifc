function _fifc_open_dir
    if type -q broot
        broot --color=yes $fifc_broot_opts $fifc_candidate
    end
end
