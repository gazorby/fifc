function _fifc_path_to_complete
    set -l token $_fifc_current_token
    if string match --regex --quiet -- '.*(\w|\.|/)+$' "$token"
        echo "$token"
    else
        echo {$PWD}/
    end
end
