function _fifc_open_file -d "Open a file with the right tool depending on its type"
    set -l file_type (_fifc_file_type "$fifc_candidate")

    switch $file_type
        case txt json archive
            $fifc_editor "$fifc_candidate"
        case image
            if type -q chafa
                chafa --watch $fifc_chafa_opts "$fifc_candidate"
            else
                $fifc_editor "$fifc_candidate"
            end
        case binary
            if type -q hexyl
                hexyl $fifc_hexyl_opts "$fifc_candidate" | less --RAW-CONTROL-CHARS
            else
                $fifc_editor "$fifc_candidate"
            end
    end
end
