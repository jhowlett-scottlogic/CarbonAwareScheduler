#!/bin/bash
dateTime="$(date -d "1 day" +"%Y-%m-%dT%T+00:00")"

response=$(curl "https://carbon-aware-api.azurewebsites.net/emissions/forecasts/current?location=ukwest&windowSize=10&dateEndAt=${dateTime}")

optimalDataPoints=$(sed -E 's/.*("optimalDataPoints":\[\{[^}]*\}\]).*/\1/' <<< "$response")

timestamp=$(sed -E 's/.*"timestamp":"([^"]*)".*/\1/' <<< "$optimalDataPoints")

echo "the cleanest time to run the job in the next 24 hours for ukwest is: $timestamp"