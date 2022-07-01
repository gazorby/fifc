
set _commandline "kill "
set _fifc_complist (complete -C --escape -- "$_commandline")
set _fifc_commandline "$_commandline"
set actual (_fifc_completion_group)
@test "group test pid" "$actual" = pid

set _commandline "ls tests/_resources/dir with spaces/ "
set _fifc_complist (complete -C --escape -- "$_commandline")
set _fifc_commandline "$_commandline"
set actual (_fifc_completion_group)
@test "group test files" "$actual" = files

set -e _fifc_complist
set -e _fifc_commandline
