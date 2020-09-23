#!/bin/bash
set -e

if [ "$1" == "start" ]; then
    systemctl start docker
    cd "$(dirname "$(readlink ~/.local/bin/work)")"
    docker-compose start || (docker-compose build && docker-compose start)
elif [ "$1" == "stop" ]; then
    cd "$(dirname "$(readlink ~/.local/bin/work)")"
    systemctl is-active docker && (docker-compose stop; systemctl stop docker)
fi
