#!/usr/bin/env bash
set -euo pipefail

echo "Installing applications from Brewfile"

if brew bundle; then
	"brew bundle installation successful"
else
	echo "brew bundle failed"
fi

echo "setting up symlinks\n\n"

mkdir -p $HOME/.config
ln -sf "$PWD/.zshrc" "$HOME/.zshrc"
ln -sf "$PWD/.aliases" "$HOME/.aliases"
ln -sf "$PWD/starship.toml" "$HOME/.config/starship.toml"
ln -sf "$PWD/tmux/.tmux.conf" "$HOME/.tmux.conf"
mkdir -p "$HOME/.config/ghostty"
ln -sf "$PWD/ghostty/config" "$HOME/.config/ghostty/config"

echo "cloning repos\n\n"
mkdir -p ~/.tmux/plugins
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

