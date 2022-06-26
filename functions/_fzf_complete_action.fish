function _fzf_complete_action -d "Run preview/bind commands"
    # Can be either "preview" or "action"
    set -l action $argv[1]
    set -l candidate "$argv[2]"
    # Dynamically set specific function names depending on the action
    set -l opt_cmd fzf_complete_opt_$action
    set -l file_cmd fzf_complete_file_$action
    set -l dir_cmd fzf_complete_dir_$action
    set -l cmd_cmd fzf_complete_cmd_$action
    set -l fn_cmd fzf_complete_fn_$action
    # Retrieve completion descriptions
    set -l regex_val (string escape --style=regex -- $candidate)
    set -l description ( \
        _fzf_complete_complist_split \
        | string match --regex --groups-only -- "$regex_val\h+(.*)" \
        | string trim \
    )

    # let's try to see if we can provide more detailed description to feed fzf
    if test $_fzf_complete_is_opt = "1"
        $$opt_cmd "$candidate"
    else if test -n "$description"
        # Test commands only
        if type --query --no-functions -- "$candidate"
            # Avoid subcommands of the same named as other commands to be treated
            # as command itself, like 'systemctl status', 'docker login' etc
            and not string match --regex --quiet -- '^\w+\h+'  $_fzf_complete_commandline
            $$cmd_cmd "$candidate"
        else if functions --query -- "$candidate"
            # Same here but only match when commandline starts with spaces or 'functions '
            # to also prevent subcommands to be treated as function (eg: 'docker wait')
            and string match --regex --quiet -- '^functions\h+|^\h+'  $_fzf_complete_commandline
            $$fn_cmd "$candidate"
        # Fallback to fish description
        else
            echo "$description"
        end
    # Otherwise
    else if test -f "$candidate"
        $$file_cmd "$candidate"
    else if test -d "$candidate"
        $$dir_cmd "$candidate"
    end
end
