function _fzf_complete_preview_file_default
    set -l mime (file --mime-type -b "$argv")
    set_color brgreen; echo -e "$mime[1]\n"
    set_color --bold white; file -b "$argv"
    set_color normal
end
