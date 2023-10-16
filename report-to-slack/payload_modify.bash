#!/bin/bash

# Load the JSON data from the file into a variable
data=$(cat './report-to-slack/reusable-payload.json')

# Start building the Slack Block Kit JSON
blocks='[
  {
    "type": "header",
    "text": {
      "type": "plain_text",
      "text": "Pipeline Failure Message"
    }
  },
  {
    "type": "divider"
  }
]'

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

  blocks="$blocks,$block"
done <<< "$data"

# Add closing square bracket to complete the JSON array
blocks="$blocks]"

# Print the generated Slack Block Kit JSON
echo "$blocks"
