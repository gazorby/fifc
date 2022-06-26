function _fzf_complete_file_preview
    set -l file_type (_fzf_complete_file_type "$argv")

    switch $file_type
        case "txt"
            if type -q bat
                bat --color=always $fzf_complete_bat_opts "$argv"
            else
                cat "$argv"
            end
        case "json"
            if type -q bat
                bat --color=always -l json $fzf_complete_bat_opts "$argv"
            else
                cat "$argv"
            end
        case "image"
            if type -q chafa
                chafa $fzf_complete_chafa_opts "$argv"
            else
                _fzf_complete_file_preview_default "$argv"
            end
        case "archive"
            if type -q 7z
                7z l ""$argv"" | tail -n +17 | awk '{ print $6 }'
            else
                _fzf_complete_file_preview_default "$argv"
            end
        case "binary"
            if type -q hexyl
                hexyl $fzf_complete_hexyl_opts "$argv"
            else
                _fzf_complete_file_preview_default "$argv"
            end

    end
end
