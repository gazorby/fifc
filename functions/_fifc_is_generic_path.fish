function _fifc_is_generic_path -d "True when fish's completions equal the plain listing (all entries, or directories only) of the completed dir"
    set -l dir $argv[1]
    set -l listing
    # Include dotfiles only when the target path itself refers to hidden entries
    if string match --quiet -- "*." "$dir"
        set listing (command ls -1A -- $dir 2>/dev/null)
    else
        set listing (command ls -1 -- $dir 2>/dev/null)
    end
    # Directory-only subset, for directory completers (cd, pushd, rmdir, ...)
    set -l base (string replace --regex -- '/$' '' "$dir")
    set -l dirs
    for entry in $listing
        if test -d "$base/$entry"
            set -a dirs $entry
        end
    end
    # Reduce each fish completion to a bare name: strip trailing slash, then dir prefix
    set -l names
    for entry in (_fifc_expand_tilde (_fifc_parse_complist))
        set -a names (string replace --regex -- '^.*/' '' (string replace --regex -- '/$' '' $entry))
    end
    set -l sorted_names (printf '%s\n' $names | sort -u)
    set -l sorted_listing (printf '%s\n' $listing | sort -u)
    set -l sorted_dirs (printf '%s\n' $dirs | sort -u)
    test "$sorted_names" = "$sorted_listing"; or test "$sorted_names" = "$sorted_dirs"
end
