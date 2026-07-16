set curr_pwd $PWD
set curr_fifc_fd_opts $fifc_fd_opts
set curr_fifc_query $fifc_query
set curr_fifc_token $fifc_token

function fd
    echo "fd 8.3.0"
end

set fifc_fd_opts --type f
set fifc_query
set fifc_token

cd "tests/_resources/dir with spaces"
set actual (_fifc_source_files)
@test "source files cwd with spaces" "$actual" = "fd . --type f --color=always --strip-cwd-prefix"

cd "$curr_pwd"
set fifc_fd_opts $curr_fifc_fd_opts
set fifc_query $curr_fifc_query
set fifc_token $curr_fifc_token
