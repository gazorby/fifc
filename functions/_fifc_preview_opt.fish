function _fifc_preview_opt -d "Open man page of a command starting at the selected option"
    set -l opt (string trim --chars '\n ' -- "$candidate")
    set -l regex "^\h*(-+[^\n]*)*$opt([^\-\w\.]([^\.\n]|\.{2,})*|)\n{1,2}.*?(?=^(\n|\h*(-+[^\n]*))+)"
    # Enable dotall matching for pcregrep
    set -l regex_pcre (string join -- '' '(?s)' $regex)
    set -l cmd (string match --regex --groups-only -- '(\w+) ?-*' $commandline)

    # PCRE is needed as regex has lookaround
    if type -q rg
         set out ( \
            man $cmd 2>/dev/null \
            | string trim \
            | rg --multiline --multiline-dotall --pcre2 $regex \
        )
    else if type -q pcre2grep
        set out (man $cmd 2>/dev/null | string trim | pcre2grep --multiline $regex_pcre)
    else
        set out (man $cmd 2>/dev/null | string trim | pcregrep --multiline $regex_pcre)
    end

    # Fallback to fish description if there is no man page
    if test -z "$out"
        echo "$desc"
    end

    # Pretty printing
    set_color brgreen; echo -e "$out[1]"
    set_color --bold white; echo -e (string join -- "\n" "" $out[2..-1])
    set_color normal
end
