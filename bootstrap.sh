#!/usr/bin/env bash
# Set up a Mac: Homebrew, packages, symlinks, tmux plugin manager.
#
# Usage: ./bootstrap.sh [--work] [--casks]
#   (no flags)  core CLI tools + symlinks
#   --work      also install brew/Brewfile.work
#   --casks     also install brew/Brewfile.casks (may ask for your sudo password)
set -euo pipefail
cd "$(dirname "$0")"

work=false
casks=false
for arg in "$@"; do
	case "$arg" in
		--work) work=true ;;
		--casks) casks=true ;;
		*) echo "unknown option: $arg" >&2; exit 1 ;;
	esac
done

# Skip brew's auto-update (slow, runs before every install) and its hints.
export HOMEBREW_NO_AUTO_UPDATE=1 HOMEBREW_NO_ENV_HINTS=1

echo "==> Homebrew"
# Apple Silicon installs to /opt/homebrew, which is not on PATH in a fresh shell.
if ! command -v brew >/dev/null 2>&1 && [[ ! -x /opt/homebrew/bin/brew ]]; then
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
eval "$(/opt/homebrew/bin/brew shellenv)"

echo "==> Core packages"
# --no-upgrade: install what is missing, leave installed packages alone.
brew bundle --file=brew/Brewfile --no-upgrade

if $work; then
	echo "==> Work packages"
	brew bundle --file=brew/Brewfile.work --no-upgrade
fi

# Casks last: some prompt for sudo.
if $casks; then
	echo "==> Casks"
	brew bundle --file=brew/Brewfile.casks --no-upgrade
fi

echo "==> Symlinks"
./links.sh

echo "==> tmux plugin manager"
if [[ -d "$HOME/.tmux/plugins/tpm" ]]; then
	git -C "$HOME/.tmux/plugins/tpm" pull --quiet
else
	git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
fi

echo "Done."
