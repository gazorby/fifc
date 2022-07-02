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
set -Ux _fifc_comp_count 0
set -Ux _fifc_source_count 0
set -gx _fifc_unordered_comp
set -gx _fifc_ordered_comp
set -gx _fifc_unordered_sources
set -gx _fifc_ordered_sources

# Set sources
fifc \
    -n 'test "$group" = "files"' \
    -s _fifc_source_files
fifc \
    -n 'test "$group" = processes' \
    -s 'ps --no-headers -ax --format pid,command'

# Builtin preview/open commands
fifc \
    -n 'test "$group" = "options"' \
    -p _fifc_preview_opt \
    -o _fifc_open_opt
fifc \
    -n 'test -n "$desc"; and type -q -f -- "$candidate"' \
    -r '^(?!\w+\h+)' \
    -p _fifc_preview_cmd \
    -o _fifc_open_cmd
fifc \
    -n 'test -n "$desc"' \
    -r '^functions\h+|^\h+' \
    -p _fifc_preview_fn \
    -o _fifc_open_fn
fifc \
    -n 'test -f "$candidate"' \
    -p _fifc_preview_file \
    -o _fifc_open_file
fifc \
    -n 'test -d "$candidate"' \
    -p _fifc_preview_dir \
    -o _fifc_open_dir
fifc \
    -n 'test "$group" = processes -a (ps -p (_fifc_parse_pid "$candidate") &>/dev/null)' \
    -p _fifc_preview_process \
    -o _fifc_open_process \
    -e '^\h*([0-9]+)'


# Fisher
function _fifc_install --on-event fifc_install
    set -U _fifc_complist_sep ' / '
end

function _fifc_uninstall --on-event fifc_uninstall
    set -e _fifc_complist_sep

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
    set -e _fifc_unordered_sources
    set -e _fifc_ordered_sources
end
