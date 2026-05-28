# Dotfiles

Personal macOS development environment configuration.

This repo is built around a small, explicit toolchain:

- Neovim config derived from Kickstart.nvim
- zsh with completion, history search, aliases, and Starship
- tmux with vim-style navigation and true color support
- Ghostty terminal settings
- Homebrew bundle for common CLI tools, language servers, and desktop apps

## Layout

| Path | Purpose |
| --- | --- |
| `Brewfile` | Homebrew taps, formulae, casks, and Go tools |
| `.zshrc` | Shell startup config |
| `.aliases` | Short aliases for Git, GitHub, Kubernetes, Go, and Terraform |
| `starship.toml` | Prompt customizations |
| `tmux/.tmux.conf` | tmux prefix, pane navigation, plugins, and terminal color |
| `ghostty/config` | Ghostty font, theme, macOS, and performance settings |
| `nvim/` | Neovim configuration |
| `.editorconfig` | Shared editor defaults |
| `.markdownlint.jsonc` | Markdown linting rules |

## Bootstrap

Run the install script `./install.sh`

## Notes

These are personal defaults, not a portable framework. The config assumes macOS,
Homebrew, zsh, and a terminal with Nerd Font support.
