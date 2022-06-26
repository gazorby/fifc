function _fzf_complete_fn_open
    set -l pathname (functions --details $argv)
    if test -f $pathname
        _fzf_complete_file_open $pathname
    end
end
