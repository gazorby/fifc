function _fifc_preview_cmd -d "Open man page of the selected command"
    if type -q bat
        man $fifc_candidate 2>/dev/null | bat --color=always --language man $fifc_bat_opts
    else
        man $fifc_candidate 2>/dev/null
    end
end
