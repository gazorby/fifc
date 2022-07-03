# fifc

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

And you can enjoy built-in fuzzy completions!
