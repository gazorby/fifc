##################
# Keybindings
##################
for mode in default insert
    if not set --query --universal fzf_complete_keybinding
        bind --mode $mode \t 'fzf_complete'
    else
        bind --mode $mode $fzf_complete_keybinding 'fzf_complete'
    end
end

# fzf

if not set --query --universal fzf_complete_open_keybinding
    set --universal fzf_complete_open_keybinding 'ctrl-o'
end

if not set --query --universal fzf_complete_search_keybinding
    set --universal fzf_complete_search_keybinding 'ctrl-f'
end


##################
# File
##################
set -q -U fzf_complete_file_preview; or set -U fzf_complete_file_preview _fzf_complete_file_preview
if not set --query --universal fzf_complete_file_preview
    set --universal fzf_complete_file_preview _fzf_complete_file_preview
end

if not set --query --universal fzf_complete_file_open
    set --universal fzf_complete_file_open _fzf_complete_file_open
end

if not set --query --universal fzf_complete_file_editor
    set --universal fzf_complete_file_editor vim
end

##################
# Directory
##################
if not set --query --universal fzf_complete_dir_preview
    set --universal fzf_complete_dir_preview _fzf_complete_dir_preview
end

if not set --query --universal fzf_complete_dir_open
    set --universal fzf_complete_dir_open _fzf_complete_dir_open
end

if not set --query --universal fzf_complete_dir_search
    set --universal fzf_complete_dir_search _fzf_complete_dir_search
end

##################
# Command
##################
if not set --query --universal fzf_complete_cmd_preview
    set --universal fzf_complete_cmd_preview _fzf_complete_cmd_preview
end

if not set --query --universal fzf_complete_cmd_open
    set --universal fzf_complete_cmd_open _fzf_complete_cmd_open
end

##################
# Functions
##################
if not set --query --universal fzf_complete_fn_preview
    set --universal fzf_complete_fn_preview _fzf_complete_fn_preview
end

if not set --query --universal fzf_complete_fn_open
    set --universal fzf_complete_fn_open _fzf_complete_fn_open
end

##################
# Command options
##################
if not set --query --universal fzf_complete_opt_preview
    set --universal fzf_complete_opt_preview _fzf_complete_opt_preview
end

if not set --query --universal fzf_complete_opt_open
    set --universal fzf_complete_opt_open _fzf_complete_opt_open
end

# Regex used to extract option description from man pages
if not set --query --universal fzf_complete_opt_preview_regex
    set --universal fzf_complete_opt_preview_regex '^\h*(-+(\w|-|,|\h)*)*%s(\h+|,|\\\\n{1,2}|=).*?(?=(^\\\\n(^\h*(-+(\w|-|,|\h)*))*)+)'
end

# Regex used to open man page starting on the option description
if not set --query --universal fzf_complete_opt_open_regex
    set --universal fzf_complete_opt_open_regex '^\h*(-+(\w|-|,| )*)*%s'
end

##################
# Private
##################

set -U _fzf_complete_complist_sep ' / '

function uninstall --on-event fish_fzf_complete_uninstall
    set -e _fzf_complete_complist_sep
end
