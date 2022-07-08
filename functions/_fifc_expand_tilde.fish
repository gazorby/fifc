function _fifc_expand_tilde
    string replace --regex -- '^~(/?)' "$HOME\$1" $argv
end
