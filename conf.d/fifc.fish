# Keybindings
for mode in default insert
    if not set --query --universal fifc_keybinding
        bind --mode $mode \t _fifc
    else
        bind --mode $mode $fifc_keybinding _fifc
    end
end

if not set --query --universal fifc_open_keybinding
    set --universal fifc_open_keybinding ctrl-o
end


# Private
set -gx _fifc_comp_count 0
set -gx _fifc_unordered_comp
set -gx _fifc_ordered_comp

# Set sources
fifc \
    -n 'test "$fifc_group" = "directories"' \
    -s _fifc_source_directories
fifc \
    -n 'test "$fifc_group" = "files"' \
    -s _fifc_source_files
fifc \
    -n 'test "$fifc_group" = processes' \
    -s 'ps -ax -o pid=,command='

# Builtin preview/open commands
fifc \
    -n 'test "$fifc_group" = "options"' \
    -p _fifc_preview_opt \
    -o _fifc_open_opt
fifc \
    -n 'test \( -n "$fifc_desc" -o -z "$fifc_commandline" \); and type -q -f -- "$fifc_candidate"' \
    -r '^(?!\\w+\\h+)' \
    -p _fifc_preview_cmd \
    -o _fifc_open_cmd
fifc \
    -n 'test -n "$fifc_desc" -o -z "$fifc_commandline"' \
    -r '^(functions)?\\h+' \
    -p _fifc_preview_fn \
    -o _fifc_open_fn
fifc \
    -n 'test -f "$fifc_candidate"' \
    -p _fifc_preview_file \
    -o _fifc_open_file
fifc \
    -n 'test -d "$fifc_candidate"' \
    -p _fifc_preview_dir \
    -o _fifc_open_dir
fifc \
    -n 'test "$fifc_group" = processes -a (ps -p (_fifc_parse_pid "$fifc_candidate") &>/dev/null)' \
    -p _fifc_preview_process \
    -o _fifc_open_process \
    -e '^\\h*([0-9]+)'


# Fisher
function _fifc_uninstall --on-event fifc_uninstall
    for i in (seq (count $_fifc_unordered_comp))
        set -e $_fifc_unordered_comp[$i]
    end

    for i in (seq (count $_fifc_ordered_comp))
        set -e $_fifc_ordered_comp[$i]
    end

    set -e _fifc_comp_count
    set -e _fifc_source_count
    set -e _fifc_unordered_comp
    set -e _fifc_ordered_comp
end
