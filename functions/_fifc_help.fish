function __fifc_help_print
    argparse -s "i/indentation=?" "l/level=?" e/escape no-color -- $argv
    set -l spaces "$_flag_i"
    set -l level "$_flag_l"
    if test -z "$spaces"
        set spaces 4
    end
    if test -z "$level"
        set level 1
    end
    if test -n "$_flag_e"
        set echo_opt -e
    end
    set indent (string repeat --count (math $spaces x $level) " ")
    set out (string join -- "\n$indent" $argv)
    if test -n "$_flag_no_color"
        echo $echo_opt "$indent$out"
    else
        set_color -o white
        echo $echo_opt "$indent$out"
        set_color normal
    end
end

function __fifc_help_section
    set_color yellow
    __fifc_help_print -e -l0 --no-color (string join -- "" (string upper -- "$argv") "\n")
    set_color normal
end

function __fifc_help_opt
    set -l opt (string split -- '=' $argv[1])
    set_color green
    echo -en (__fifc_help_print --no-color -l1 -- "$opt[1]")
    set_color yellow
    if test (count $opt) -eq 2
        echo "=$opt[2]"
    else
        echo ""
    end
    set_color -o white
    set -l desc (string split -- '\n' $argv[2..-1] | string trim)
    echo -e (__fifc_help_print --no-color -l2 -- $desc)
    echo ""
    set_color normal
end

function _fifc_help -d "Print fifc help message"
    __fifc_help_section NAME
    __fifc_help_print -e "fifc - Set custom completion rules for use with fifc fish plugin\n"

    __fifc_help_section SYNOPSIS
    __fifc_help_print -e "fifc [OPTIONS]\n"

    __fifc_help_section DESCRIPTION

    __fifc_help_opt \
        "-r, --regex=REGEX" \
        "Regex that must match commandline preceding the cursor for the rule to be valid"

    __fifc_help_opt \
        "-e, --extract=COMMAND" \
        "Regex used to extract string from selected results before appending them to the commandline"

    __fifc_help_opt \
        "-n, --condition=COMMAND" \
        "Command or function that must exit with a non-zero status for the rule to be valid"

    __fifc_help_opt \
        "-p, --preview=COMMAND" \
        "Preview command passed to fzf if the rule is valid"

    __fifc_help_opt \
        "-s, --source=COMMAND" \
        "Command that will feed fzf input if the rule is valid"

    __fifc_help_opt \
        "-o, --open=COMMAND" \
        "Command binded to fifc_open_keybinding (defaults to ctrl-o) when using fzf"

    __fifc_help_opt \
        "-O, --order=INT" \
        "The order in which the rule is evaluated." \
        "If missing, the rule will be evaluated after all ordered ones, and all unordered rules defined before."


    __fifc_help_opt \
        "-f, --fzf-options" \
        "Custom fzf options (can override previous ones)"

    __fifc_help_opt \
        "-h, --help" \
        "Show this help"

    __fifc_help_print -e "Examples:\n"
    __fifc_help_print -e -l2 -- "- Preview files using bat (already builtin):\n"
    set_color white
    __fifc_help_print --no-color -e -l2 -- \
        '  fifc -n \'test -f "$fifc_candidate"\' -p "bat --color=always $fifc_candidate"'

    __fifc_help_print -e "\n\n"

    __fifc_help_print -e -l2 -- "- Use fd to search files recursively (already builtin):\n"
    set_color white
    __fifc_help_print --no-color -e -l2 -- \
        '  fifc -n \'test "$fifc_group" = files\' -s \'fd . --color=always --strip-cwd-prefix\''

    __fifc_help_print -e "\n\n"

    __fifc_help_print -e -l2 -- "- Interactively search packages on archlinux:\n"
    set_color white
    __fifc_help_print --no-color -e -l2 -- \
        "  fifc \\ \n" \
        "  -r '^pacman(\h*\-S)?\h+\w+' \\ \n" \
        "  -s 'pacman --color=always -Ss "\$fifc_token" | string match -r \"^[^\h+].*\"' \\ \n" \
        "  -e '.*/(.*?)\h.*' \\ \n" \
        "  -f '--query \"\"' \\ \n" \
        "  -p 'pacman -Si "\$fifc_extracted"' \\"
end
