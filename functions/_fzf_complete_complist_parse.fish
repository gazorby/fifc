function _fzf_complete_complist_parse
    _fzf_complete_complist_split \
        | string unescape \
        | uniq \
        | awk -F '\t' '{ print $1 }'
end
