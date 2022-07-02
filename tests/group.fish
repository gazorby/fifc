
set _commandline "kill "
set _fifc_complist (complete -C --escape -- "$_commandline")
set fifc_commandline "$_commandline"
set actual (_fifc_completion_group)
@test "group test pid" "$actual" = processes

set _commandline "ls tests/_resources/dir with spaces/"
set _fifc_complist (complete -C --escape -- "$_commandline")
set fifc_commandline "$_commandline"
set actual (_fifc_completion_group)
@test "group test files" "$actual" = files

set _commandline "ls --"
set _fifc_complist (complete -C --escape -- "$_commandline")
set fifc_commandline "$_commandline"
set actual (_fifc_completion_group)
@test "group test options" "$actual" = options

set -e _fifc_complist
set -e fifc_commandline
