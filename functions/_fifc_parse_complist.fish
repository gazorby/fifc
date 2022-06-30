function _fifc_parse_complist -d "Extract the first column of fish completion list"
    _fifc_split_complist \
        | string unescape \
        | uniq \
        | awk -F '\t' '{ print $1 }'
end
