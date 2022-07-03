function _fifc_action
    # Can be either "preview", "action" or "source"
    set -l action $argv[1]
    set -l regex_val (string escape --style=regex -- "$argv[2]")
    set -l comp $_fifc_ordered_comp $_fifc_unordered_comp

    # Variables exposed to evaluated commands
    set -x fifc_desc ( \
        _fifc_split_complist \
        | string match --regex --groups-only -- "$regex_val\h+(.*)" \
        | string trim \
    )
    set -x fifc_group (_fifc_completion_group)
    set -x fifc_candidate "$argv[2]"
    set fifc_extracted (string match --regex --groups-only -- "$_fifc_extract_regex" "$argv[2]")

    if test "$action" = preview
        set default_preview 1
    else if test "$action" = source
        set default_source 1
    end

    for i in (seq (count $comp))
        set -l conditions
        set -l valid 1
        if test -n "$$comp[$i][1]"
            set -a conditions "$$comp[$i][1]"
        end
        if test -n "$$comp[$i][2]"
            set -a conditions "string match --regex --quiet -- '$$comp[$i][2]' '$fifc_commandline'"
        end

        for condition in $conditions
            if not eval "$condition"
                set valid 0
                break
            end
        end

        if test $valid -eq 0
            continue
        end

        set _fifc_extract_regex "$$comp[$i][7]"

        if test "$action" = preview; and test -n "$$comp[$i][3]"
            eval $$comp[$i][3]
            set default_preview 0
            break
        else if test "$action" = open; and test -n "$$comp[$i][4]"
            eval $$comp[$i][4]
            break
        else if test "$action" = source; and test -n "$$comp[$i][5]"
            set _fifc_custom_fzf_opts "$$comp[$i][6]"
            if functions "$$comp[$i][5]" 1>/dev/null
                eval $$comp[$i][5]
            else
                echo $$comp[$i][5]
            end
            set default_source 0
            break
        end
    end

    # We are in preview mode, but nothing matched
    # fallback to fish description
    if test "$default_preview" = 1
        echo "$fifc_desc"
    else if test "$default_source" = 1
        echo _fifc_parse_complist
    end
end
