function __fzf_complete_check_flag -d "Check flag value for fzf_complete"
    switch $_flag_name
        case O order
            if not test 0 -lt $_flag_value
                echo "$_argparse_cmd: Order must be a positive integer"
                return 1
            end
        # Ensure regex is valid
        case r regex
            set -l out (string match --regex --quiet $_flag_value 2>&1 | string join '\n')
            if test -n "$out"
                echo -e "$_argparse_cmd:\n$out"
            end
    end
end

function fzf_complete -d "Add your own fish fzf completions"
    set -l option_spec 'c/condition=' 'p/preview=' 'o/open=' 'clear'
    set -a option_spec 'r/regex=!__fzf_complete_check_flag' 'O/order=!__fzf_complete_check_flag'

    argparse --name 'fzf_complete' $option_spec -- $argv

    if test "$status" != "0"
        return 1
    end

    if test \( -n "$_flag_c" -o -n "$_flag_r" \) -a \( -z "$_flag_p" -a -z "$_flag_o" \)
        echo "fzf_complete: You have not specified the '--preview' or '--open' commands"
        return 1
    end

    set _fzf_complete_comp_count (math $_fzf_complete_comp_count + 1)
    set -l count $_fzf_complete_comp_count
    set -Ux "_fzf_complete_comp_$count" "$_flag_c" "$_flag_r" "$_flag_p" "$_flag_o"

    if test -z "$_flag_O"
        set -a _fzf_complete_unordered_comp "_fzf_complete_comp_$count"
    else
        set _fzf_complete_ordered_comp[$_flag_O] "_fzf_complete_comp_$count"
    end
end
