function _fzf_complete_parse_commandline -d "Sanitize commandline by removing trailing '-' or '--'"
    string match --regex --groups-only -- '(\w+) ?-*' "$_fzf_complete_commandline"
end
