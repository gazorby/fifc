function _fzf_complete_file_open
    set -l file_type (_fzf_complete_file_type "$argv")

    switch $file_type
        case "txt" "json" "archive"
            $fzf_complete_file_editor "$argv"
        case "image"
            if type -q chafa
                chafa --watch $fzf_complete_chafa_opts "$argv"
            else
                $fzf_complete_file_editor "$argv"
            end
        case "binary"
            if type -q hexyl
                hexyl $fzf_complete_hexyl_opts "$argv" | less --RAW-CONTROL-CHARS
            else
                $fzf_complete_file_editor "$argv"
            end
    end
end
