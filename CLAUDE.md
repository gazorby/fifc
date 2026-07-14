# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

`fifc` is a [fish shell](https://github.com/fish-shell/fish-shell) plugin (fish 3.4.0+) that layers [fzf](https://github.com/junegunn/fzf) on top of fish's native completion engine. It ships built-in completion rules (files, dirs, commands, functions, options, processes) and exposes a `fifc` command so users can register their own rules. Pure fish; no build step.

## Commands

Tooling is driven by [mise](https://mise.jdx.dev/) (see `mise.toml`). Requires `fd`, `fzf`, `actionlint` (mise installs them).

```fish
mise run test            # run all tests: fishtape tests/**.fish   (alias: t)
mise run lint            # format:check + syntax + ci:lint          (alias: l)
mise run format          # fish_indent --write on all .fish files   (alias: f)
mise run format:check    # fish_indent --check                      (alias: fc)
mise run syntax          # fish --no-execute on all .fish files     (alias: s)
mise run install         # install pre-commit hooks                 (alias: i)
```

Run a single test file directly:

```fish
fishtape tests/test_fifc.fish
```

Tests use [fishtape](https://github.com/jorgebucaran/fishtape) with `@test` assertions. CI runs on macOS + Ubuntu; fzf-launching tests have a 3-min timeout to guard against hangs.

Commits follow Conventional Commits (commitizen, `cz.yaml`); tags are `v$version`. Do not commit unless the user asks.

## Architecture

Fish auto-loads `functions/*.fish` by filename and sources `conf.d/*.fish` at startup. Flow:

1. **`conf.d/fifc.fish`** — entrypoint. On interactive start it binds `$fifc_keybinding` (default `tab`) to the `_fifc` widget and registers built-in **source** rules. When fish is itself launched inside fzf (`_fifc_launched_by_fzf` set), it registers the **preview/open** rules instead — this split keeps the fzf-child process from re-binding keys.

2. **`functions/fifc.fish`** — the rule-registration command. Parses flags with `argparse` (`-n` condition, `-r` regex, `-p` preview, `-o` open, `-s` source, `-e` extract, `-f` fzf-options, `-O` order) and stores each rule as a fish list variable `_fifc_comp_$count` with a fixed slot layout: `[1]=condition [2]=regex [3]=preview [4]=open [5]=source [6]=fzf-opts [7]=extract`. Rule names are pushed onto `_fifc_ordered_comp` (indexed by `-O`) or `_fifc_unordered_comp` (append order). **This slot layout is a contract**: `_fifc_action` indexes it positionally and the tests assert exact indices.

3. **`functions/_fifc.fish`** — the widget fired by the keybinding. Runs `complete -C` against the commandline, writes the completion list to a temp file (`$_fifc_complist_path`), computes `fifc_group` via `_fifc_completion_group`, resolves the source command, then `eval`s `<source> | fzf ...`. fzf's `--preview` and open keybinding call back into `_fifc_action`. Finally it escapes the picked token(s) and `commandline --replace`s the current token. The `eval` is deliberate (wrapping the source in a function adds visible fzf startup lag — see the comment).

4. **`functions/_fifc_action.fish`** — dispatcher invoked by fzf for `preview`/`open`/`source`. Iterates rules (ordered first, then unordered), evaluating each rule's `condition && regex`; the first match wins and its command is `eval`ed. No match falls back to the raw fish description (`fifc_desc`, extracted from the complist via `sed`) or `_fifc_parse_complist`.

### Rule resolution order

`_fifc_action` resolves `source`, `preview`, and `open` **separately**, each time walking rules top-to-bottom and stopping at the first whose condition+regex both pass. Because the three actions resolve independently, two rules with identical conditions don't clobber each other if they bind different actions. `-O`/`--order` forces a rule to a specific position (built-ins are all unordered, so a user `-O 1` rule runs first).

### Context variables exposed to rule commands

Set by the widget/dispatcher and available inside `-n`/`-p`/`-o`/`-s`/`-e` commands: `fifc_candidate` (selected item), `fifc_commandline` (buffer before cursor), `fifc_token` (last token), `fifc_group` (`directories`|`files`|`options`|`processes`), `fifc_extracted` (regex capture via `-e`), `fifc_query`, `fifc_desc`. `source` commands don't get `fifc_candidate`/`fifc_extracted`.

### Naming conventions

Helper functions follow `_fifc_<action>_<kind>`: `_fifc_source_files`, `_fifc_preview_file`, `_fifc_open_dir`, `_fifc_preview_process`, etc. Built-in rules in `conf.d/fifc.fish` reference these by name. When adding a completion kind, add the matching `_fifc_source_*` / `_fifc_preview_*` / `_fifc_open_*` functions and wire a `fifc ...` rule in `conf.d/fifc.fish`.

## Conventions & gotchas

- **External tool fallbacks**: fifc prefers modern tools and degrades gracefully — `bat`→`cat`, `chafa`→`file`, `fd`→`find`, `exa`→`ls`, `ripgrep`→`pcregrep`, `procs`→`ps`, `hexyl`→`file`. Per-tool extra flags come from `$fifc_<tool>_opts` list vars (e.g. `$fifc_fd_opts`). New preview/source logic touching these tools must honor the fallback + opts pattern.
- **Path escaping**: paths with spaces are handled explicitly (needs fish 3.4+). `_fifc.fish` special-cases `~`-prefixed and `$`-prefixed tokens when escaping results — don't naively `string escape` everything.
- **Version guarding**: use `_fifc_test_version` for fish-version-dependent behavior (e.g. `complete --escape` only on 3.4+).
- **Temp file cleanup**: the completion list temp file is force-removed (`rm -f`) to survive users who alias `rm` to `rm -i`.
- All `.fish` must pass `fish_indent --check` and `fish --no-execute`; run `mise run lint` before finishing.
