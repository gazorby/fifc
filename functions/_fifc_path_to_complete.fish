function _fifc_path_to_complete
    if string match --regex --quiet -- '.*(\w|\.|/)+$' "$fifc_token"
        echo "$fifc_token"
    else
        echo {$PWD}/
    end
end
