function _fifc_preview_opt -d "Open man page of a command starting at the selected option"
    set -l regex "(?s)^(\-+[^\n]+)*$fifc_candidate([^\-\w\.]([^\.\n]|\.{2,}|\w+\.)*|)\n{1,2}.*?(^(\-+[^\n]+|\w+))"
    set -l regex_replace '^\h+(\-+[^\n]+.*)'
    set -l cmd (string match --regex --groups-only -- '(^|\h+)(\w+) ?-*$' $fifc_commandline)
    echo $group
    set out (man $cmd 2>/dev/null | string replace -r $regex_replace '$1' \
        | begin
            if type -q rg
                rg --multiline $regex
            else if type -q pcre2grep
                pcre2grep --multiline $regex
            else
                pcregrep --multiline $regex
            end
        end \
        # Remove last line as it should describes the next option
        | awk 'n>=1 { print a[n%1] } { a[n%1]=$0; n=n+1 }' \
        | string trim \
    )

    # Fallback to fish description if there is no man page
    if test -z "$out"
        echo "$fifc_desc"
    end

    # Pretty printing
    set_color brgreen
    echo -e "$out[1]"
    set_color --bold white
    echo -e (string join -- "\n" "" $out[2..-1])
    set_color normal
end
