function _fifc_path_to_complete
    set -l token (string unescape $fifc_token)
    if string match --regex --quiet -- '.*(\w|\.|/)+$' "$token"
        echo "$token"
    else
        echo {$PWD}/
    end
end
