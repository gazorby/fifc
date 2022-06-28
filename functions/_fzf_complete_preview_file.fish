function _fzf_complete_preview_file
    set -l file_type (_fzf_complete_file_type "$candidate")

    switch $file_type
        case "txt"
            if type -q bat
                bat --color=always $fzf_complete_bat_opts "$candidate"
            else
                cat "$candidate"
            end
        case "json"
            if type -q bat
                bat --color=always -l json $fzf_complete_bat_opts "$candidate"
            else
                cat "$candidate"
            end
        case "image"
            if type -q chafa
                chafa $fzf_complete_chafa_opts "$candidate"
            else
                _fzf_complete_preview_file_default "$candidate"
            end
        case "archive"
            if type -q 7z
                7z l ""$candidate"" | tail -n +17 | awk '{ print $6 }'
            else
                _fzf_complete_preview_file_default "$candidate"
            end
        case "binary"
            if type -q hexyl
                hexyl $fzf_complete_hexyl_opts "$candidate"
            else
                _fzf_complete_preview_file_default "$candidate"
            end

    end
end
