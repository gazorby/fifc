function _fzf_complete_commandline_to_path
    set -l token $_fzf_complete_current_token
    if string match --regex --quiet -- '^.+$' "$token"
        echo "$token"
    else
        echo {$PWD}/
    end
end
