function __fifc_help_print
    argparse -s "i/indentation=?" "l/level=?" "c/color=?" e/escape n -- $argv
    set -l spaces "$_flag_i"
    set -l level "$_flag_l"
    set -l color "$_flag_c"
    set -l echo_opt

    if test -z "$spaces"
        set spaces 4
    end
    if test -z "$level"
        set level 1
    end
    if test -n "$_flag_e"
        set -a echo_opt -e
    end
    if test -n "$_flag_n"
        set -a echo_opt -n
    end
    if test -z "$_flag_c"
        set color -o white
    end
    set indent (string repeat --count (math $spaces x $level) " ")

    set_color $color
    echo $echo_opt "$indent$argv[1]"
    for line in $argv[2..-1]
        set_color $color
        echo $echo_opt "\n$indent$line"
    end
    # end
    set_color normal
end

function __fifc_help_section
    __fifc_help_print -e -l0 --color=yellow (string join -- "" (string upper -- "$argv") "\n")
end

function __fifc_help_opt
    set -l opt (string split -- '=' $argv[1])
    __fifc_help_print -n -e --color=green -l1 -- "$opt[1]"
    if test (count $opt) -eq 2
        set_color yellow
        echo "=$opt[2]"
    else
        echo ""
    end
    set -l desc (string split -- '\n' $argv[2..-1] | string trim)
    __fifc_help_print -e -l2 -- $desc
    echo ""
end

function _fifc_help -d "Print fifc help message"
    __fifc_help_section NAME
    __fifc_help_print -e "fifc - Set custom completion rules for use with fifc fish plugin\n"

    __fifc_help_section SYNOPSIS
    __fifc_help_print -e "fifc [OPTIONS]\n"

    __fifc_help_section DESCRIPTION

    __fifc_help_print -e -n \
        "The fifc command allows you to add custom completion rules that can enhance fish completions or override them.\n" \
        "A rule is composed of condition(s) that, if valid, trigger commands that can:" \
        "  - Change fzf preview (-p)" \
        "  - Feed fzf input (-s)" \
        "  - Execute when fifc_open_keybinding is pressed (defaults to ctrl-o) (-o)"

    __fifc_help_print -e "\n\n"

    __fifc_help_print -e -n \
        "A condition can be either:" \
        " - A regex that must match commandline before cursor position (-r)" \
        " - An arbitrary command that must exit with a non-zero status (-n)"

    __fifc_help_print -e "\n"

    __fifc_help_print -e -n \
        "Rule are evaluated in the order in which they are defined," \
        "and fifc will stop at the first rule where all conditions are met"

    __fifc_help_print -e "\n\n"

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
    __fifc_help_print -e -l2 --color=white -- \
        '  fifc -n \'test -f "$fifc_candidate"\' -p "bat --color=always $fifc_candidate"'

    __fifc_help_print -e "\n"

    __fifc_help_print -e -l2 -- "- Use fd to search files recursively (already builtin):\n"
    __fifc_help_print -e -l2 --color=white -- \
        '  fifc -n \'test "$fifc_group" = files\' -s \'fd . --color=always --strip-cwd-prefix\''

    __fifc_help_print -e "\n"

    __fifc_help_print -e -l2 -- "- Interactively search packages on archlinux:\n"
    __fifc_help_print -e -n -l2 --color=white -- \
        " fifc \\" \
        " -r '^pacman(\h*\-S)?\h+\w+' \\" \
        " -s 'pacman --color=always -Ss "\$fifc_token" | string match -r \"^[^\h+].*\"' \\" \
        " -e '.*/(.*?)\h.*' \\" \
        " -f '--query \"\"' \\" \
        " -p 'pacman -Si "\$fifc_extracted"' \\ \n"
end
