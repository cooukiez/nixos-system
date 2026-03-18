#!/usr/bin/env bash

CONTAINERS=$(machinectl list --no-legend | awk '{print $1}')

if [ -n "$CONTAINERS" ]; then
    for CONTAINER in $CONTAINERS; do
        echo "--- Cleaning INSIDE container: $CONTAINER ---"
        sudo machinectl shell "$CONTAINER" /run/current-system/sw/bin/journalctl --rotate
        sudo machinectl shell "$CONTAINER" /run/current-system/sw/bin/journalctl --vacuum-time=1s
        
        echo "--- Cleaning HOST logs for: $CONTAINER ---"
        sudo journalctl -u "container@$CONTAINER.service" --rotate
        sudo journalctl -u "container@$CONTAINER.service" --vacuum-time=1s
    done
else
    echo "No running containers found."
fi
echo "Cleaning all host system logs..."
sudo journalctl --rotate
sudo journalctl --vacuum-time=1s

if [ -f /var/log/lastlog ]; then
    echo "Clearing /var/log/lastlog..."
    sudo truncate -s 0 /var/log/lastlog
fi

echo "All journals vacuumed."