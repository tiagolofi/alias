#!/usr/bin/env bash

# comando para verificar instalação
CHECK_INSTALL="dpkg -s fzf &> /dev/null && echo true || echo false"

# executa o comando e guarda o resultado
INSTALLED=$($CHECK_INSTALL)

if [ "$INSTALLED" = "false" ]; then
    sudo apt install -y fzf
fi

fzf --preview="cat {}" --layout=reverse --border
