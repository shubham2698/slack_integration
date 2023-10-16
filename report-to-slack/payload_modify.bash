#!/bin/bash

# Load the JSON data from the file into a variable
data=$(cat ./report-to-slack/reusable-payload.json)

# Start building the Slack Block Kit JSON
blocks='{
  "blocks": [
    {
      "type": "header",
      "text": {
        "type": "plain_text",
        "text": "Your Heading"
      }
    },
    {
      "type": "divider"
    }
  ],
  "text": "Your optional message text here"
}'

# Iterate over the JSON data and add sections to the blocks
while IFS= read -r line; do
  heading=$(echo "$line" | jq -r '.heading')
  link=$(echo "$line" | jq -r '.link')

  block='{
    "type": "section",
    "fields": [
      {
        "type": "mrkdwn",
        "text": "*'$heading'*\n'$link'"
      }
    ]
  }'

  blocks=$(jq --argjson block "$block" '.blocks += [$block]' <<< "$blocks")
done <<< "$data"

# Combine the Slack Block Kit JSON and save it to the original file
echo "$blocks" > data.json

# Print the updated Slack Block Kit JSON
cat data.json
