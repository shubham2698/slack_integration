#!/bin/bash

# Read the JSON file and extract key-value pairs
json_file="./report-to-slack/reusable-payload.json"
sections=$(jq -r 'to_entries | map("\(.key): \(.value)") | .[]' "$json_file")

# Initialize the payload with the initial text
payload='{"blocks":['

# Construct Slack message sections dynamically
for section in $sections; do
  payload+='{"type":"section","text":{"type":"mrkdwn","text":"'$section'"}},'
done

# Remove the trailing comma and add the closing brackets for the payload
payload=${payload%,}
payload+=']}'
echo "$payload" > "$json_file"
echo "$payload"
