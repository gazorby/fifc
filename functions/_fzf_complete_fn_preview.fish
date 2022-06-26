function _fzf_complete_fn_preview
    if type -q bat
        type $argv | bat --color=always --language fish $fzf_complete_bat_opts
    else
        type $argv
    end
end
