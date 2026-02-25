#!/usr/bin/env bash

while true; do
    # fetch weather
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
        
        echo "$icon $temp" > /tmp/formatted_weather
    fi
    # wait 30 min
    sleep 1800
done