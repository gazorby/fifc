set curr_fifc_unordered_comp $_fifc_unordered_comp
set curr_fifc_ordered_comp $_fifc_ordered_comp
set test_fzf_argv_path (mktemp)
set test_fifc_token

function commandline
    switch "$argv"
        case --current-token
            echo $test_fifc_token
        case --cut-at-cursor
            echo "ls $test_fifc_token"
        case -b
            echo "ls $test_fifc_token"
        case --replace --function
            return 0
    end
end

function complete
end

function fzf
    printf '%s\n' $argv >$test_fzf_argv_path
end

function _test_fzf_query
    set test_fifc_token $argv[1]
    printf '' >$test_fzf_argv_path

    _fifc 2>/dev/null

    set -l args (cat $test_fzf_argv_path)
    set -l query_index (contains --index -- --query $args)
    test -n "$query_index"; and echo $args[(math $query_index + 1)]
end

set fifc_rm_cmd rm
set _fifc_ordered_comp
set comp_1 true '' '' '' 'printf "%s\n" candidate'
set _fifc_unordered_comp comp_1

# fzf receives the unescaped query for paths with spaces.
set actual (_test_fzf_query 'tests/_resources/dir\ with\ spaces/')
@test "fifc fzf query unescapes non-reg path with spaces" "$actual" = 'tests/_resources/dir with spaces/'

# apostrophes are safely passed to fzf without breaking eval quoting.
set actual (_test_fzf_query "tests/_resources/dir\\'apostrophe/")
@test "fifc fzf query preserves apostrophe" "$actual" = "tests/_resources/dir'apostrophe/"

command rm $test_fzf_argv_path
set -gx _fifc_unordered_comp $curr_fifc_unordered_comp
set -gx _fifc_ordered_comp $curr_fifc_ordered_comp

set curr_home $HOME
set curr_fifc_unordered_comp $_fifc_unordered_comp
set curr_fifc_ordered_comp $_fifc_ordered_comp

set test_home (mktemp -d)
set -gx HOME "$test_home"
mkdir -p "$HOME/downloads"

set test_fzf_argv_path (mktemp)
set test_fifc_token '~/downloads/'

function commandline
    switch $argv[1]
        case --current-token
            echo $test_fifc_token
        case --cut-at-cursor
            echo "ls $test_fifc_token"
        case -b
            echo "ls $test_fifc_token"
        case --replace --function
            return 0
    end
end

function complete
end

function fd
    if test "$argv[1]" = --version
        echo "fd 8.3.0"
    else
        echo "$HOME/downloads/file.txt"
    end
end

function fzf
    printf '%s\n' $argv >$test_fzf_argv_path
end

set fifc_rm_cmd rm
set _fifc_ordered_comp
set comp_1 true '' '' '' _fifc_source_files
set _fifc_unordered_comp comp_1

_fifc

set args (cat $test_fzf_argv_path)
set query_index (contains --index -- --query $args)
set actual $args[(math $query_index + 1)]

@test "fifc keeps tilde fzf query" "$actual" = '~/downloads/'

command rm -rf "$test_home"
command rm $test_fzf_argv_path
set -gx HOME "$curr_home"
set -gx _fifc_unordered_comp $curr_fifc_unordered_comp
set -gx _fifc_ordered_comp $curr_fifc_ordered_comp
functions --erase fd
