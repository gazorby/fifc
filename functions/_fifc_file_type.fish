function _fifc_file_type -d "Figure out file type (txt, json, image, pdf, archive, binary)"
    set -l mime (file --mime-type -b "$argv")
    set -l binary 0
    if string match --quiet '*binary*' -- (file --mime -b -L "$argv")
        set binary 1
    end

    switch $mime
        case application/{gzip,java-archive,x-{7z-compressed,bzip2,chrome-extension,rar,tar,xar},zip}
            echo archive
            return
        case "image/*"
            echo image
            return
    end

    if test $binary = 1
        echo binary
    else
        switch $mime
            case application/pdf
                echo pdf
            case application/json
                echo json
            case "*"
                echo txt
        end
    end
end
