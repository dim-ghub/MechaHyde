#!/bin/bash

# Get time in 12-hour format, no leading zero
time=$(date +"%-I:%M %p")

# Get raw weather data from wttr.in
raw_weather=$(curl -s "wttr.in/?format=%t+%C" | sed 's/+//g') # e.g., "68°F Sunny"
temperature=$(echo "$raw_weather" | awk '{print $1}')
condition=$(echo "$raw_weather" | cut -d' ' -f2-)

# Map condition keywords to emoji (you can expand this as needed)
case "$condition" in
    *Sunny*|*Clear*) icon=" " ;;
    *Cloudy*|*Overcast*) icon=" " ;;
    *Rain*|*Drizzle*) icon=" " ;;
    *Thunder*|*Storm*) icon=" " ;;
    *Snow*) icon=" " ;;
    *Fog*|*Mist*) icon="敖 " ;;
    *) icon=" " ;; # fallback
esac

# Tooltip: full date
tooltip=$(date +"%A, %B %d, %Y")

# Final JSON output
echo "{\"text\": \"$icon $temperature | $time\", \"tooltip\": \"$tooltip\"}"
