function __fifc_check_flag -d "Check flag value for fifc"
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

function fifc -d "Add your own fish fzf completions"
    set -l option_spec 'n/condition=' 'p/preview=' 'o/open=' 's/source=' 'e/extract='
    set -a option_spec 'r/regex=!__fifc_check_flag' 'O/order=!__fifc_check_flag'

    argparse --name 'fifc' $option_spec -- $argv

    if test "$status" != "0"
        return 1
    end

    if test \( -n "$_flag_n" -o -n "$_flag_r" \) \
        -a \( -z "$_flag_p" -a -z "$_flag_o" -a -z "$_flag_s" -a -z "$_flag_e" \)

        echo "fifc: You have not specified any binding (preview, open, source or extract)"
        return 1
    end

    set _fifc_comp_count (math $_fifc_comp_count + 1)

    # Add source if specified
    if test -n "$_flag_s"
        set _fifc_source_count (math $_fifc_source_count + 1)
        set -l count $_fifc_source_count
        set -Ux "_fifc_source_$count" "$_flag_n" "$_flag_r" "$_flag_s"

        if test -z "$_flag_O"
            set -a _fifc_unordered_sources "_fifc_source_$count"
        else
            set _fifc_ordered_sources[$_flag_O] "_fifc_source_$count"
        end
    end

    set -l count $_fifc_comp_count
    set -Ux "_fifc_comp_$count" "$_flag_n" "$_flag_r" "$_flag_p" "$_flag_o" "$_flag_e"

    if test -z "$_flag_O"
        set -a _fifc_unordered_comp "_fifc_comp_$count"
    else
        set _fifc_ordered_comp[$_flag_O] "_fifc_comp_$count"
    end
end
