function _fzf_complete_open_file
    set -l file_type (_fzf_complete_file_type "$candidate")

    switch $file_type
        case "txt" "json" "archive"
            $fzf_complete_file_editor "$candidate"
        case "image"
            if type -q chafa
                chafa --watch $fzf_complete_chafa_opts "$candidate"
            else
                $fzf_complete_file_editor "$candidate"
            end
        case "binary"
            if type -q hexyl
                hexyl $fzf_complete_hexyl_opts "$candidate" | less --RAW-CONTROL-CHARS
            else
                $fzf_complete_file_editor "$candidate"
            end
    end
end
