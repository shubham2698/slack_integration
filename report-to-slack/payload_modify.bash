#!/bin/bash

# Load the JSON data from the file into a variable
data=$(cat ./report-to-slack/reusable-payload.json)
while_loop='while IFS= read -r key value; do'
# Start building the Slack Block Kit JSON
blocks='{
    "text": "title_text",
    "attachments": [
        {
            "color": "color_code",
            "blocks": [
                {
                    "type": "header",
                    "text": {
                        "type": "plain_text",
                        "text": "header_text"
                    }
                },
                {
                    "type": "divider"
                }
            ]
        }
    ]
}'

# Iterate over the JSON data and add sections to the blocks
while IFS="=" read -r key value; do
  key=$key
  value=$value

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