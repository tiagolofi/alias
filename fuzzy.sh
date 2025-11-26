#!/usr/bin/env bash

CHECK_INSTALL_FZF="dpkg -s fzf && echo true || echo false"

INSTALLED_FZF=$($CHECK_INSTALL_FZF)

if [ "$INSTALLED_FZF" = "false" ]; then
    sudo apt install -y fzf
fi

CHECK_INSTALL_XCLIP="dpkg -s xclip && echo true || echo false"

INSTALLED_XCLIP=$($CHECK_INSTALL_XCLIP)

if [ "$INSTALLED_XCLIP" = "false" ]; then
    sudo apt install -y xclip
fi

file = $(fzf)

printf "%s" "$file" | xclip -selection clipboard

echo "File path copied to clipboard: $file"