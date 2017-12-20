#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

if [ -z "$1" ]; then
    echo 'You must specify the container id'
    exit 1
fi

# Inspect exposed ports.
ip_addresses="$(docker inspect --format='{{range .NetworkSettings.Networks}}{{.IPAddress}} {{end}}' "$1")"
ports="$(docker inspect --format='{{range $k, $v := .Config.ExposedPorts}}{{$k}} {{end}}' "$1")"

# Take the first host-port pair as the target.
ip_address="${ip_addresses%% *}"
port="${ports%%/*}"

# Wait for the exposed port to be available
echo -n "waiting for ${ip_address}:${port} "
seq 100 | while read i; do
    if nc -z "$ip_address" ${port}; then
        echo ' OK'
        break
    fi
    echo -n '.'
    sleep 0.5
done
