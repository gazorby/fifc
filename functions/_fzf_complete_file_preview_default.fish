function _fzf_complete_file_preview_default
    set -l mime (file --mime-type -b "$argv")
    set_color brgreen; echo -e "$mime[1]\n"
    set_color --bold white; file -b "$argv"
    set_color normal
end
