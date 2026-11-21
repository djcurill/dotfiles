# Dotfiles

My macOS development setup: Neovim, zsh, tmux, Ghostty, and Homebrew packages.

## Quick start

```sh
./bootstrap.sh            # core tools + symlinks
./bootstrap.sh --work     # also work tools
./bootstrap.sh --casks    # also GUI apps (may ask for your password)
```

## What's inside

| Path | What it is |
| --- | --- |
| `bootstrap.sh` | Installs Homebrew, packages, and symlinks |
| `links.sh` | Links the configs below into `$HOME` |
| `brew/` | Package lists: core, work, and GUI apps |
| `nvim/` | Neovim config |
| `.zshrc`, `.aliases`, `starship.toml` | Shell and prompt |
| `tmux/`, `ghostty/`, `pgcli/` | Terminal tools |

## Themes

Pick a colorscheme in Neovim with `<leader>cs`. Ghostty and tmux follow it
automatically (see `nvim/lua/theme-sync.lua`).

## Keeping packages tidy

```sh
brew bundle cleanup --file=brew/Brewfile   # lists packages not in the file
```

This setup assumes macOS, Homebrew, zsh, and a Nerd Font.
