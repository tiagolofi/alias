#!/usr/bin/env bash

# Matar porta ?
kill_port() {
    local porta="$1"

    if [[ -z "$porta" ]]; then
        echo "Nenhuma porta informada."
        return 1
    fi

    fuser -k "${porta}/tcp"

    echo "Encerrando a porta $porta"
}

kill_port $1