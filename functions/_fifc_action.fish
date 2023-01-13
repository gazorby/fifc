function _fifc_action
    # Can be either "preview", "open" or "source"
    set -l action $argv[1]
    set -l comp $_fifc_ordered_comp $_fifc_unordered_comp
    set -l regex_val (string escape --style=regex -- "$argv[2]")
    # Escape '/' for sed processing
    set regex_val (string replace '/' '\/' --all "$regex_val")

    # Variables exposed to evaluated commands
    set -x fifc_desc (sed -nr (printf 's/^%s[[:blank:]]+(.*)/\\\1/p' "$regex_val") $_fifc_complist_path | string trim)
    set -x fifc_candidate "$argv[2]"
    set -x fifc_extracted (string match --regex --groups-only -- "$_fifc_extract_regex" "$argv[2]")

    if test "$action" = preview
        set default_preview 1
        set fifc_query "$argv[3]"

    else if test "$action" = open
        set fifc_query "$argv[3]"

    else if test "$action" = source
        set default_source 1
    end

    for i in (seq (count $comp))
        set -l condition_cmd
        set -l regex_cmd
        set -l valid 1
        if test -n "$$comp[$i][1]"
            set condition_cmd "$$comp[$i][1]"
        else
            set condition_cmd true
        end
        if test -n "$$comp[$i][2]"
            set -l val (string escape -- "$fifc_commandline")
            set regex_cmd "string match --regex --quiet -- '$$comp[$i][2]' $val"
        else
            set regex_cmd true
        end

        if not eval "$condition_cmd; and $regex_cmd"
            set valid 0
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
