#!/usr/bin/env bash

check_pkg() {
    dpkg -s "$1" &> /dev/null && echo true || echo false
}

install_missing_pkgs() {
    for pkg in "$@"; do
        if [ "$(check_pkg "$pkg")" = "false" ]; then
            sudo apt install -y "$pkg"
        fi
    done
}

install_missing_pkgs fzf xclip

file=$(fzf --preview="cat {}" --layout=reverse --border)

printf "%s" "$file" | xclip -selection clipboard

echo "File path copied to clipboard: $file. Use Ctrl+Shift+V to paste."