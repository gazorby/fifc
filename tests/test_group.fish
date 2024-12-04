set _fifc_complist_path (mktemp)

set _commandline "kill "
complete -C --escape -- "$_commandline" >$_fifc_complist_path
set fifc_commandline "$_commandline"
set actual (_fifc_completion_group)
@test "group test pid" "$actual" = processes

set _commandline "ls tests/_resources/dir\ with\ spaces/"
complete -C --escape -- "$_commandline" >$_fifc_complist_path
set fifc_commandline "$_commandline"
set actual (_fifc_completion_group)
@test "group test files" "$actual" = files

set _commandline "ls -"
complete -C --escape -- "$_commandline" >$_fifc_complist_path
set fifc_commandline "$_commandline"
set actual (_fifc_completion_group)
@test "group test options" "$actual" = options

set -e _fifc_complist
set -e fifc_commandline
command $fifc_rm_cmd $_fifc_complist_path
