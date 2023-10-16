#!/bin/bash

# Load the JSON data from the file into a variable
data=$(cat ./reusable-payload.json)

# Start building the Slack Block Kit JSON
blocks='{
    "text": "Pipeline Failure Details",
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
while IFS="=" read -r key value; do
  key=$key
  value=$value

  section_block='{
    "type": "section_'"$key"'",
      "fields":{
        "type": "mrkdwn",
        "text": "*'"$key"'*\n'"$value"'"
      }
  }'

  # Add the section block to the blocks array
  blocks=$(jq --argjson section_block "$section_block" '.blocks += [$section_block]' <<< "$blocks")
done <<< "$(echo "$data" | jq -r 'to_entries | .[] | "\(.key) \(.value)"')"

# Print the generated Slack Block Kit JSON
echo "$blocks"
