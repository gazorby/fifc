function _fzf_complete_preview_cmd
    if type -q bat
        man $candidate 2>/dev/null | bat --color=always --language man $fzf_complete_bat_opts
    else
        man $candidate 2>/dev/null
    end
end
