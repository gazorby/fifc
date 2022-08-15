function _fifc_test_version -d "Compare version numbers"
    set -l arg_1 (string replace --regex --all '[^\d]' '' -- "$argv[1]")
    set -l arg_2 (string replace --regex --all '[^\d]' '' -- "$argv[3]")
    set -l op "$argv[2]"

    set -l v_diff (math (string length -- $arg_1) - (string length -- $arg_2))

    # Ensure both versions are the same length
    if test $v_diff -gt 0
        set arg_2 (string join '' -- "$arg_2" (string repeat -N -n $v_diff '0'))
    else if test $v_diff -lt 0
        set v_diff (math abs $v_diff)
        set arg_1 (string join '' -- "$arg_1" (string repeat -N -n $v_diff '0'))
    end

    set -l cmd (string collect -- "test " "$arg_1" " $op " "$arg_2")
    eval $cmd
end
