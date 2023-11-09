#!/bin/bash

locationsArray=( "ukwest" )

locations="location=${locationsArray[0]}"

for value in "${locationsArray[@]:1}"
do
  locations+="&location=$value"
done

dataEndAt="dataEndAt=$(date -d "1 day" +"%Y-%m-%dT%TZ")"

windowSize="windowSize=10"

response=$(curl -G -s  "https://carbon-aware-api.azurewebsites.net/emissions/forecasts/current?$locations&$windowSize" --data-urlencode "$dataEndAt" )

optimalDataPoints=$(sed -E 's/.*("optimalDataPoints":\[\{[^}]*\}\]).*/\1/' <<< "$response")

timestampString=$(sed -E 's/.*"timestamp":"([^"]*)".*/\1/' <<< "$optimalDataPoints")

timestamp=$(date -d $timestampString)

minute=$(date -d "$timestamp" '+%M')

hour=$(date -d "$timestamp" '+%H')

day=$(date -d "$timestamp" '+%d')

month=$(date -d "$timestamp" '+%m')

echo "$minute $hour $day $month *"