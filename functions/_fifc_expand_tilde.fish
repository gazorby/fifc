function _fifc_expand_tilde
    string replace --regex -- '^~' "$HOME" $argv
end
