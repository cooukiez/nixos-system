#!/usr/bin/env bash

CACHE_FILE="/tmp/hyprlock_weather"
# Update weather every 30 minutes (1800 seconds)
RELOAD_TIME=1800

if [[ ! -f "$CACHE_FILE" || $(($(date +%s) - $(stat -c %Y "$CACHE_FILE"))) -gt $RELOAD_TIME ]]; then
    # Fetch in background so we don't block hyprlock
    (
        weather_data=$(curl -s "wttr.in?format=%C+%t")
        if [[ -n "$weather_data" ]]; then
            condition=$(echo "$weather_data" | awk '{print $1}')
            temp=$(echo "$weather_data" | awk '{print $2}')

            case "$condition" in
                "Clear"|"Sunny") icon="󰖙 " ;;
                "Partly"|"Cloudy"|"Overcast") icon="󰖕 " ;;
                "Mist"|"Fog"|"Haze") icon="󰖑 " ;;
                "Drizzle"|"Rain"|"Light") icon="󰖗 " ;;
                "Thunderstorm") icon="󰖓 " ;;
                "Snow"|"Sleet") icon="󰖘 " ;;
                *) icon="󰖐 " ;;
            esac
            echo "$icon $temp" > "$CACHE_FILE"
        fi
    ) &
fi

# Always return the cached file content immediately
cat "$CACHE_FILE" 2>/dev/null || echo "N/A"