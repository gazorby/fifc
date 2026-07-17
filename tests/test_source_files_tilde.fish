set curr_home $HOME
set curr_fifc_token $fifc_token
set curr_fifc_query $fifc_query

set test_home (mktemp -d)
set -gx HOME "$test_home"
mkdir -p "$HOME/downloads"

function fd
    if test "$argv[1]" = --version
        echo "fd 8.3.0"
    else
        echo "$HOME/downloads/file.txt"
    end
end

set fifc_token '~/downloads/'
set fifc_query '~/downloads/'

set actual (eval (_fifc_source_files))

@test "source files fd preserves tilde prefix" "$actual" = '~/downloads/file.txt'

command rm -rf "$test_home"
set -gx HOME "$curr_home"
set fifc_token $curr_fifc_token
set fifc_query $curr_fifc_query
functions --erase fd

set curr_home $HOME
set curr_path $PATH
set curr_fifc_token $fifc_token
set curr_fifc_query $fifc_query

set test_home (mktemp -d)
set -gx HOME "$test_home"
mkdir -p "$HOME/downloads"

functions --erase fd
set PATH

function find
    echo "$HOME/downloads/file.txt"
end

function sed
    while read -l line
        echo $line
    end
end

set fifc_token '~/downloads/'
set fifc_query '~/downloads/'

set actual (eval (_fifc_source_files))

@test "source files find preserves tilde prefix" "$actual" = '~/downloads/file.txt'

set PATH $curr_path
command rm -rf "$test_home"
set -gx HOME "$curr_home"
set fifc_token $curr_fifc_token
set fifc_query $curr_fifc_query
functions --erase find
functions --erase sed
