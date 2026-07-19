set curr_fifc_token $fifc_token
set _fifc_complist_path (mktemp)

set _commandline "kill "
complete -C --escape -- "$_commandline" >$_fifc_complist_path
set fifc_commandline "$_commandline"
set fifc_token ""
set actual (_fifc_completion_group)
@test "group test pid" "$actual" = processes

set _commandline "ls tests/_resources/dir\ with\ spaces/"
complete -C --escape -- "$_commandline" >$_fifc_complist_path
set fifc_commandline "$_commandline"
set fifc_token "tests/_resources/dir with spaces/"
set actual (_fifc_completion_group)
@test "group test files" "$actual" = files

set _commandline "ls -"
complete -C --escape -- "$_commandline" >$_fifc_complist_path
set fifc_commandline "$_commandline"
set fifc_token -
set actual (_fifc_completion_group)
@test "group test options" "$actual" = options

# Specific path completion (fish offers the worktree path, not the cwd listing):
# must NOT be treated as generic directory completion.
set _commandline "git worktree remove "
complete -C --escape -- "$_commandline" >$_fifc_complist_path
set fifc_commandline "$_commandline"
set fifc_token ""
set actual (_fifc_completion_group)
@test "group test specific path is not directories" "$actual" != directories

# Directory-only completer (cd) must remain classified as directories (recursive fd).
set _commandline "cd "
complete -C --escape -- "$_commandline" >$_fifc_complist_path
set fifc_commandline "$_commandline"
set fifc_token ""
set actual (_fifc_completion_group)
@test "group test directory completer stays directories" "$actual" = directories

set -e fifc_commandline
set fifc_token $curr_fifc_token
command $fifc_rm_cmd $_fifc_complist_path
set -e _fifc_complist_path
