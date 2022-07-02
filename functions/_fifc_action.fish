function _fifc_action
    # Can be either "preview", "action" or "source"
    set -l action $argv[1]
    set -l regex_val (string escape --style=regex -- $argv[2])
    set -l comp $_fifc_ordered_comp $_fifc_unordered_comp

    # Variables exposed to evaluated commands
    set -lx desc ( \
        _fifc_split_complist \
        | string match --regex --groups-only -- "$regex_val\h+(.*)" \
        | string trim \
    )
    set -lx group (_fifc_completion_group)
    set -lx candidate $argv[2]
    set -lx commandline $_fifc_commandline
    set -lx token $_fifc_current_token

    if test "$action" = preview
        set default_preview 1
    else if test "$action" = source
        set comp $_fifc_ordered_sources $_fifc_unordered_sources
        set default_source 1
    end

    for i in (seq (count $comp))
        set -l conditions
        set -l valid 1
        if test -n "$$comp[$i][1]"
            set -a conditions "$$comp[$i][1]"
        end
        if test -n "$$comp[$i][2]"
            set -a conditions "string match --regex --quiet -- '$$comp[$i][2]' '$commandline'"
        end

        for condition in $conditions
            if not eval $condition
                set valid 0
                break
            end
        end

        if test $valid -eq 0
            continue
        end

        set _fifc_extract "$$comp[$i][5]"

        if test "$action" = preview; and test -n "$$comp[$i][3]"
            eval $$comp[$i][3]
            set default_preview 0
            break
        else if test "$action" = open; and test -n "$$comp[$i][4]"
            eval $$comp[$i][4]
            break
        else if test "$action" = source; and test -n "$$comp[$i][3]"
            if functions "$$comp[$i][3]" 1>/dev/null
                eval $$comp[$i][3]
            else
                echo $$comp[$i][3]
            end
            set default_source 0
            break
        end
    end

    # We are in preview mode, but nothing matched
    # fallback to fish description
    if test "$default_preview" = 1
        echo "$desc"
    else if test "$default_source" = 1
        echo _fifc_parse_complist
    end
end
