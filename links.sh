#!/usr/bin/env bash
# Link the configs in this repo into $HOME and ~/.config.
# Run from the repo root (bootstrap.sh does this). Safe to re-run.
set -euo pipefail

echo "setting up symlinks\n\n"

# ln -sf replaces an existing file or link at the target. Any local edits to a
# live config that is NOT already a link to this repo are overwritten, so copy
# them into the repo first.
mkdir -p $HOME/.config
ln -sf "$PWD/.zshrc" "$HOME/.zshrc"
ln -sf "$PWD/.aliases" "$HOME/.aliases"
ln -sf "$PWD/starship.toml" "$HOME/.config/starship.toml"
ln -sf "$PWD/tmux/.tmux.conf" "$HOME/.tmux.conf"
mkdir -p "$HOME/.config/ghostty"
ln -sf "$PWD/ghostty/config" "$HOME/.config/ghostty/config"

# Link only the config file: pgcli's history and log files stay local.
mkdir -p "$HOME/.config/pgcli"
ln -sf "$PWD/pgcli/config" "$HOME/.config/pgcli/config"

# nvim is linked as a whole directory. Remove the old one first, or ln would
# create the link *inside* it. CAUTION: rm -rf deletes a real nvim directory.
rm -rf "$HOME/.config/nvim"
ln -sf "$PWD/nvim" "$HOME/.config/"

# tpm (tmux plugin manager) is cloned, not vendored; update it if present.
echo "cloning repos\n\n"
mkdir -p ~/.tmux/plugins

if [ -d "$HOME/.tmux/plugins/tpm" ]; then
	git -C "$HOME/.tmux/plugins/tpm" pull
else
	git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi
