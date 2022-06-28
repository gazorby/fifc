function _fzf_complete_preview_fn
    if type -q bat
        type $candidate | bat --color=always --language fish $fzf_complete_bat_opts
    else
        type $candidate
    end
end
