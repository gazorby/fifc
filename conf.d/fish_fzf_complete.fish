# Keybindings
for mode in default insert
    if not set --query --universal fzf_complete_keybinding
        bind --mode $mode \t '_fzf_complete'
    else
        bind --mode $mode $fzf_complete_keybinding '_fzf_complete'
    end
end

if not set --query --universal fzf_complete_open_keybinding
    set --universal fzf_complete_open_keybinding 'ctrl-o'
end

if not set --query --universal fzf_complete_search_keybinding
    set --universal fzf_complete_search_keybinding 'ctrl-f'
end


# Private
set -Ux _fzf_complete_comp_count 0
set -gx _fzf_complete_unordered_comp
set -gx _fzf_complete_ordered_comp


# Builtin completions
fzf_complete \
    -r '\w+\h+\-+\h*$' \
    -p '_fzf_complete_preview_opt' \
    -o '_fzf_complete_open_opt'
fzf_complete \
    -c 'test -n "$desc"; and type -q -f -- "$candidate"' \
    -r '^(?!\w+\h+)' \
    -p '_fzf_complete_preview_cmd' \
    -o '_fzf_complete_open_cmd'
fzf_complete \
    -c 'test -n "$desc"' \
    -r '^functions\h+|^\h+' \
    -p '_fzf_complete_preview_fn' \
    -o '_fzf_complete_open_fn'
fzf_complete \
    -c 'test -f "$candidate"' \
    -p '_fzf_complete_preview_file' \
    -o '_fzf_complete_open_file'
fzf_complete \
    -c 'test -d "$candidate"' \
    -p '_fzf_complete_preview_dir' \
    -o '_fzf_complete_open_dir'

fzf_complete -c 'test -n "$desc"' -p 'echo "$desc"'


# Fisher
function _fzf_complete_install --on-event fish_fzf_complete_install
    set -U _fzf_complete_complist_sep ' / '
end

function _fzf_complete_uninstall --on-event fish_fzf_complete_uninstall
    set -e _fzf_complete_complist_sep

    for i in (seq (count $_fzf_complete_unordered_comp))
        set -e $_fzf_complete_unordered_comp[$i]
    end

    for i in (seq (count $_fzf_complete_ordered_comp))
        set -e $_fzf_complete_ordered_comp[$i]
    end

    set -e _fzf_complete_unordered_comp
    set -e _fzf_complete_ordered_comp
end
