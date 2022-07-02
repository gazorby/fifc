function _fifc_open_fn -d "Open a function definition using open file wrapper"
    set -l pathname (functions --details $fifc_candidate)
    if test -f $pathname
        _fifc_open_file $pathname
    end
end
