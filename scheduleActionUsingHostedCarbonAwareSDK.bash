#!/bin/bash
dateTime="$(date -d "1 day" +"%Y-%m-%dT%T+00:00")"

response=$(curl -s "https://carbon-aware-api.azurewebsites.net/emissions/forecasts/current?location=ukwest&windowSize=10&dateEndAt=${dateTime}")

optimalDataPoints=$(sed -E 's/.*("optimalDataPoints":\[\{[^}]*\}\]).*/\1/' <<< "$response")

timestampString=$(sed -E 's/.*"timestamp":"([^"]*)".*/\1/' <<< "$optimalDataPoints")

timestamp=$(date -d $timestampString)

minute=$(date -d "$timestamp" '+%M')

hour=$(date -d "$timestamp" '+%H')

day=$(date -d "$timestamp" '+%d')

month=$(date -d "$timestamp" '+%m')

# echo "$minute $hour $day $month *"
echo "56 13 08 11 *"