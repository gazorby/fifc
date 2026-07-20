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

# An explicitly-typed subdirectory bypasses gitignore so its ignored entries appear.
set fifc_fd_opts
set fifc_query
set fifc_token docs/
set typed (_fifc_source_files)
if string match --quiet -- "*--no-ignore-vcs*" "$typed"
    set has_no_ignore yes
else
    set has_no_ignore no
end
@test "source files typed path bypasses gitignore" "$has_no_ignore" = yes

# Bare completion keeps respecting gitignore (no unignore flag).
set fifc_token ""
set bare (_fifc_source_files)
if string match --quiet -- "*--no-ignore*" "$bare"
    set bare_no_ignore yes
else
    set bare_no_ignore no
end
@test "source files bare completion respects gitignore" "$bare_no_ignore" = no

set fifc_fd_opts $curr_fifc_fd_opts
set fifc_query $curr_fifc_query
set fifc_token $curr_fifc_token
