function _fifc_source_directories -d "Return a command to recursively find directories"
    if type -q fd
        set --local --export --append fifc_fd_opts -t d
        _fifc_source_files
    else
        set --local --export --append fifc_find_opts -type d
        _fifc_source_files
    end
end
