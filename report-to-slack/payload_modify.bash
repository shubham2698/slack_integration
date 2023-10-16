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
        "text": "Pipeline Failure"
      }
    },
    {
      "type": "divider"
    }
  ]
}'

# Iterate over the JSON data and add sections to the blocks
while IFS= read -r line; do
  key=$(echo "$line" | jq -r 'keys[0]')
  value=$(echo "$line" | jq -r '.['"$key"']')

  section_block='{
    "type": "section",
    "fields": [
      {
        "type": "mrkdwn",
        "text": "*'"$key"'*\n'"$value"'"
      }
    ]
  }'

  # Add the section block to the blocks array
  blocks=$(jq --argjson section_block "$section_block" '.blocks += [$section_block]' <<< "$blocks")
done <<< "$(echo "$data" | jq -r 'to_entries | .[] | "\(.key) \(.value)"')"

# Print the generated Slack Block Kit JSON
echo "$blocks"
