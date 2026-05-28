#!/usr/bin/env bash
set -euo pipefail

echo "setting up symlinks\n\n"

mkdir -p $HOME/.config
ln -sf "$PWD/.zshrc" "$HOME/.zshrc"
ln -sf "$PWD/.aliases" "$HOME/.aliases"
ln -sf "$PWD/starship.toml" "$HOME/.config/starship.toml"
ln -sf "$PWD/tmux/.tmux.conf" "$HOME/.tmux.conf"
mkdir -p "$HOME/.config/ghostty"
ln -sf "$PWD/ghostty/config" "$HOME/.config/ghostty/config"

rm -rf "$HOME/.config/nvim"
ln -sf "$PWD/nvim" "$HOME/.config/"

echo "cloning repos\n\n"
mkdir -p ~/.tmux/plugins

if [ -d "$HOME/.tmux/plugins/tpm" ]; then
	git -C "$HOME/.tmux/plugins/tpm" pull
else
	git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

