function _fifc_open_file -d "Open a file with the right tool depending on its type"
    set -l file_type (_fifc_file_type "$candidate")

    switch $file_type
        case "txt" "json" "archive"
            $fifc_file_editor "$candidate"
        case "image"
            if type -q chafa
                chafa --watch $fifc_chafa_opts "$candidate"
            else
                $fifc_file_editor "$candidate"
            end
        case "binary"
            if type -q hexyl
                hexyl $fifc_hexyl_opts "$candidate" | less --RAW-CONTROL-CHARS
            else
                $fifc_file_editor "$candidate"
            end
    end
end
