#!/usr/bin/env bash

check_pkg() {
    dpkg -s "$1" &> /dev/null && echo true || echo false
}

if [ "$(check_pkg fzf)" = "false" ]; then
    sudo apt install -y fzf
fi

if [ "$(check_pkg xclip)" = "false" ]; then
    sudo apt install -y xclip
fi

file=$(fzf --preview="cat {}" --layout=reverse --border)

printf "%s" "$file" | xclip -selection clipboard

echo "File path copied to clipboard: $file"