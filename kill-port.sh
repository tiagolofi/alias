#!/usr/bin/env bash

# Matar porta ?
kill_port() {
    local porta=$1

    kill -9 $(lsof -t -i:$porta)

    echo "Encerrando a porta $porta"
}

kill_port $1