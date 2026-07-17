set curr_home $HOME
set curr_fifc_unordered_comp $_fifc_unordered_comp
set curr_fifc_ordered_comp $_fifc_ordered_comp

set test_home (mktemp -d)
set -gx HOME "$test_home"
mkdir -p "$HOME/downloads"

set test_fifc_token '~/downl'
set test_fzf_selection '~/downloads/'
set test_replaced_token

function commandline
    switch $argv[1]
        case --current-token
            echo $test_fifc_token
        case --cut-at-cursor
            echo "ls $test_fifc_token"
        case -b
            echo "ls $test_fifc_token"
        case --replace
            set -g test_replaced_token $argv[-1]
        case --function
            return 0
    end
end

function complete
end

function fzf
    echo $test_fzf_selection
end

set fifc_rm_cmd rm
set _fifc_ordered_comp
set comp_1 true '' '' '' 'printf "%s\n" candidate'
set _fifc_unordered_comp comp_1

_fifc

@test "fifc does not add trailing space after tilde directory" "$test_replaced_token" = '~/downloads/'

command rm -rf "$test_home"
set -gx HOME "$curr_home"
set -gx _fifc_unordered_comp $curr_fifc_unordered_comp
set -gx _fifc_ordered_comp $curr_fifc_ordered_comp

set curr_home $HOME
set curr_fifc_unordered_comp $_fifc_unordered_comp
set curr_fifc_ordered_comp $_fifc_ordered_comp

set test_home (mktemp -d)
set -gx HOME "$test_home"
mkdir -p "$HOME/downloads"
touch "$HOME/downloads/test test.txt"

set test_fifc_token '~/downloads/test'
set test_fzf_selection '~/downloads/test test.txt'
set test_replaced_token

function commandline
    switch $argv[1]
        case --current-token
            echo $test_fifc_token
        case --cut-at-cursor
            echo "ls $test_fifc_token"
        case -b
            echo "ls $test_fifc_token"
        case --replace
            set -g test_replaced_token $argv[-1]
        case --function
            return 0
    end
end

function complete
end

function fzf
    echo $test_fzf_selection
end

set fifc_rm_cmd rm
set _fifc_ordered_comp
set comp_1 true '' '' '' 'printf "%s\n" candidate'
set _fifc_unordered_comp comp_1

_fifc

@test "fifc escapes spaces in tilde file without quotes" "$test_replaced_token" = '~/downloads/test\ test.txt '

command rm -rf "$test_home"
set -gx HOME "$curr_home"
set -gx _fifc_unordered_comp $curr_fifc_unordered_comp
set -gx _fifc_ordered_comp $curr_fifc_ordered_comp
