#!/usr/bin/env bash

set -euo pipefail

is_installed() {
	command -v "$1" >/dev/null 2>&1
}

echo "installing applications use cURL"

if ! is_installed "starship"; then
	echo "installing starship"
	curl -sS https://starship.rs/install.sh | sh
fi

if [[ ! -d "$HOME/.tmux/plugins/tpm" ]]; then
	echo "installing tpm"
	git clone https://github.com/tmux-plugins/tpm.git ~/.tmux/plugins/tpm
fi
