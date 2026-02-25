#!/usr/bin/env bash

# default value
echo "N/A" > /tmp/formatted_weather

while true; do
    # get current location
    LOC=$(curl -s "http://ip-api.com/json")
    LAT=$(echo "$LOC" | jq -r '.lat')
    LON=$(echo "$LOC" | jq -r '.lon')

    echo "Current location: Lat: $LAT, Lon: $LON"

    # fetch weather
    DATA=$(curl -s "https://api.open-meteo.com/v1/forecast?latitude=$LAT&longitude=$LON&current=temperature_2m,weather_code&timezone=auto")

    # extract
    TEMP=$(echo "$DATA" | jq '.current.temperature_2m | round')
    CODE=$(echo "$DATA" | jq '.current.weather_code')

    echo "Raw weather: Temp: $TEMP, Code: $CODE"

    if [[ "$TEMP" == "null" || -z "$TEMP" || "$CODE" == "null" || -z "$CODE" ]]; then
        continue
    fi

    case $CODE in
        0) ICON="󰖙" ;; # clear
        1|2|3) ICON="󰖕" ;; # partly cloudy
        45|48) ICON="󰖑" ;; # fog
        51|53|55|56|57) ICON="󰖗" ;; # drizzle
        61|63|65|66|67) ICON="󰖖" ;; # rain
        71|73|75|77) ICON="󰼶" ;; # snow
        80|81|82) ICON="󰖖" ;; # showers
        85|86) ICON="󰼶" ;; # snow showers
        95|96|99) ICON="󰙾" ;; # thunderstorm
        *) ICON="󰖐" ;; # unknown
    esac

    echo "Current weather: $ICON ${TEMP}°C"

    echo "$ICON   ${TEMP}°C" > /tmp/formatted_weather

    # wait 5 min
    sleep 300
done