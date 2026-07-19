set curr_fifc_token $fifc_token
set curr_home $HOME
set _fifc_complist_path (mktemp)

# Case a: bare completion of the cwd is generic
complete -C --escape -- "cat " >$_fifc_complist_path
if _fifc_is_generic_path "$PWD/"
    set actual true
else
    set actual false
end
@test "is_generic: bare cwd completion is generic" "$actual" = true

# Case b: a single specific directory path (not a cwd entry) is not generic
set specific_dir (mktemp -d)
echo "$specific_dir" >$_fifc_complist_path
if _fifc_is_generic_path "$PWD/"
    set actual true
else
    set actual false
end
@test "is_generic: specific path is not generic" "$actual" = false
command rm -rf "$specific_dir"

# Case c: tilde-form listing of a sub-directory is generic
set test_home (mktemp -d)
set -gx HOME "$test_home"
mkdir -p "$HOME/sub"
touch "$HOME/sub/a.txt" "$HOME/sub/b.txt"
printf '%s\n' '~/sub/a.txt' '~/sub/b.txt' >$_fifc_complist_path
if _fifc_is_generic_path "$HOME/sub/"
    set actual true
else
    set actual false
end
@test "is_generic: tilde subdir listing is generic" "$actual" = true

# Case d: a directory-only completer (cd) is generic against a dir with files + subdirs
set gen_dir (mktemp -d)
mkdir -p "$gen_dir/sub1" "$gen_dir/sub2"
touch "$gen_dir/file.txt"
printf '%s\n' sub1/ sub2/ >$_fifc_complist_path
if _fifc_is_generic_path "$gen_dir/"
    set actual true
else
    set actual false
end
@test "is_generic: directory-only listing is generic" "$actual" = true
command rm -rf "$gen_dir"

command rm -rf "$test_home"
set -gx HOME "$curr_home"
command rm -f $_fifc_complist_path
set -e _fifc_complist_path
set fifc_token $curr_fifc_token
