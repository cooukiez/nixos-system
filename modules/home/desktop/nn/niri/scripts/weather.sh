#!/usr/bin/env bash

CACHE_FILE="/tmp/formatted_weather"

if [ -s "$CACHE_FILE" ]; then
    cat "$CACHE_FILE"
else
    echo "N/A"
fi