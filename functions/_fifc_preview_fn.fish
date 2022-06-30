function _fifc_preview_fn -d "Preview the function definition"
    if type -q bat
        type $candidate | bat --color=always --language fish $fifc_bat_opts
    else
        type $candidate
    end
end
