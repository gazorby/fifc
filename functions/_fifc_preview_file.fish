function _fifc_preview_file -d "Preview the selected file with the right tool depending on its type"
    set -l file_type (_fifc_file_type "$candidate")

    switch $file_type
        case txt
            if type -q bat
                bat --color=always $fifc_bat_opts "$candidate"
            else
                cat "$candidate"
            end
        case json
            if type -q bat
                bat --color=always -l json $fifc_bat_opts "$candidate"
            else
                cat "$candidate"
            end
        case image
            if type -q chafa
                chafa $fifc_chafa_opts "$candidate"
            else
                _fifc_preview_file_default "$candidate"
            end
        case archive
            if type -q 7z
                7z l ""$candidate"" | tail -n +17 | awk '{ print $6 }'
            else
                _fifc_preview_file_default "$candidate"
            end
        case binary
            if type -q hexyl
                hexyl $fifc_hexyl_opts "$candidate"
            else
                _fifc_preview_file_default "$candidate"
            end

    end
end
