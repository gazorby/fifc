function _fzf_complete_open_fn
    set -l pathname (functions --details $candidate)
    if test -f $pathname
        _fzf_complete_open_file $pathname
    end
end
