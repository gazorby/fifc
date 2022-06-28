function _fzf_complete_action
    # Can be either "preview" or "action"
    set -l action $argv[1]
    set -l regex_val (string escape --style=regex -- $argv[2])
    set -l desc ( \
        _fzf_complete_complist_split \
        | string match --regex --groups-only -- "$regex_val\h+(.*)" \
        | string trim \
    )
    set -l comp $_fzf_complete_ordered_comp $_fzf_complete_unordered_comp

    if test "$action" = "preview"
        set default_preview 1
    end

    for i in (seq (count $comp))
        set -l conditions
        set -l valid 1

        begin
            # Variables exposed to evaluated commands
            set -lx candidate $argv[2]
            set -lx commandline $_fzf_complete_commandline
            set -lx desc $desc

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

            if test "$action" = "preview"; and test -n $$comp[$i][3]
                eval $$comp[$i][3]
                set default_preview 0
                break
            else if test "$action" = "open"; and test -n $$comp[$i][4]
                eval $$comp[$i][4]
                break
            end
        end
    end

    # We are in preview mode, but nothing matched
    # fallback to fish description
    if test "$default_preview" = "1"
        echo "$desc"
    end
end
