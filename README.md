<div align="center">

# fifc 🐠

*fish fzf completions*

[![CI](https://github.com/gazorby/fifc/actions/workflows/ci.yml/badge.svg)](https://github.com/gazorby/fifc/actions/workflows/ci.yml)

</div>


fifc brings fzf powers on top of fish completion engine and allows customizable completion rules.

![gif usage](../assets/fifc.gif)

## Builtin features

### Preview/open

- Preview/open any file (text, image, gif, pdf, archive)
- Preview/open command's man page
- Preview/open full option description for commands (parse man pages)
- Preview/open directory content
- Preview/open process tree using
- Preview/open function definition

### Sources

- Use fd for path completion (recursively search for files and folders)

## 🚀 Install

```fish
fisher install gazorby/fifc
```

## 🔧 Usage

You only need to set one setting after install:

```fish
set -Ux fifc_editor <your-favorite-editor>
```

And enjoy built-in completions!

fifc can use modern tools if available:


| Prefer                                           | Fallback to | Used for                                  | Custom options  |
| ------------------------------------------------ | ----------- | ----------------------------------------- | --------------- |
| [bat](https://github.com/sharkdp/bat)            | cat         | Preview files                             | `$fifc_bat_opts`   |
| [chafa](https://github.com/hpjansson/chafa)      | file        | Preview images, gif, pdf etc              | `$fifc_chafa_opts` |
| [hexyl](https://github.com/sharkdp/hexyl)        | file        | Preview binaries                          | `$fifc_hexyl_opts` |
| [fd](https://github.com/sharkdp/fd)              | find        | Complete paths                            | `$fifc_fd_opts`    |
| [exa](https://github.com/ogham/exa)              | ls          | Preview directories                       | `$fifc_exa_opts`   |
| [ripgrep](https://github.com/BurntSushi/ripgrep) | pcregrep    | Search options in man pages               | -               |
| [procs](https://github.com/dalance/procs)        | ps          | Complete processes and preview their tree | `$fifc_procs_opts` |
| [broot](https://github.com/Canop/broot)          | -           | Explore directory trees                   | `$fifc_broot_opts` |


Custom options can be added for any of the commands used by fifc using the variable mentioned in the above table.

Example:

Show line number when previewing files:
- `set -U fifc_bat_opts --style=numbers`

Show hidden file by default:
- `set -U fifc_fd_opts --hidden`

## 🛠️ Write your own rules

Custom rules can easily be added using the `fifc` command. Actually, all builtin rules are added this way: see [conf.d/fifc.fish](https://github.com/gazorby/fifc/blob/52ff966511ea97ed7be79db469fe178784e22fd8/conf.d/fifc.fish)

Basically, a rule allows you to trigger some commands based on specific conditions.

Available command types:
- **preview:** Command used for fzf preview
- **source:** Command that feeds fzf input
- **open:** Command binded to `fifc_open_keybinding` (defaults to ctrl-o)

A condition can be either:
- A regex that must match commandline before cursor
- An arbitrary command that must exit with a non-zero status

All commands have access to the following variable describing the completion context:


| Variable           | Description                                                                           |
| ------------------ | ------------------------------------------------------------------------------------- |
| `fifc_candidate`   | Currently selected item in fzf                                                        |
| `fifc_commandline` | Commandline part before the cursor position                                           |
| `fifc_token`       | Last token from the commandline                                                       |
| `fifc_group`       | Group to which fish suggestions belong (can be either files, options or processes)    |
| `fifc_extracted`   | Extracted string from the currently selected item using the `extracted` regex, if any |


For example here's how built-in rule for file preview/open is implemened:

```fish
fifc \
    # If selected item is a file
    -n 'test -f "$fifc_candidate"' \
    # bind `_fifc_preview_file` to preview command
    -p _fifc_preview_file \
    # and `_fifc_preview_file` when pressing ctrl-o
    -o _fifc_open_file
```
