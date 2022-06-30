function _fifc_parse_pid -d "Extract pid at the beginning of ps output lines"
    string match --regex --groups-only -- "^\h*([0-9]+)" "$argv"
end
