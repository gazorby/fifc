function _fzf_complete_cmd_preview
    if type -q bat
        man $argv 2>/dev/null | bat --color=always --language man $fzf_complete_bat_opts
    else
        man $argv 2>/dev/null
    end
end
