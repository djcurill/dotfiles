#!/usr/bin/env bash
set -euo pipefail

echo "Installing applications from Brewfile"

failed=()
skipped=()

while read -r first rest <&3; do
	pkg=$(echo $rest | tr -d '"' | cut -d ',' -f1)
	case "$first" in
		tap)
			brew tap $pkg || failed+=("brew tap $pkg")
			;;
		cask)
			brew install --cask $pkg || failed+=("brew install --cask $pkg")
			;;
		brew)
			brew install $pkg || failed+=("brew install $pkg")
			;;
		"")
			;;
		*)
			echo "Skipping installation for $first $pkg"
			skipped+=("$first $rest")
			;;
	esac
done 3< Brewfile

if [ "${#failed[@]}" -gt 0 ]; then
	echo "the following packages failed during installation:"
	for f in "${failed[@]}"; do
		echo $f
	done
fi

if [ "${#skipped[@]}" -gt 0 ]; then
	echo "the following packages were skipped:"
	for f in "${skipped[@]}"; do
		echo $f
	done
fi

