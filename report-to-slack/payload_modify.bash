#!/bin/bash

# Read the JSON file and extract key-value pairs
json_file="./report-to-slack/reusable-payload.json"
sections=$(jq -r 'to_entries | map("\(.key)=\(.value)") | .[]' "$json_file")

# Define the while loop string
while_loop='while IFS= read -r key value; do'

# Initialize the payload with the initial text
payload='{
  "text": "env.TITLE_TEXT",
    "attachments": [
        {
            "color": "${{ env.ATTACHMENT_COLOR }}",
            "blocks": [
                {
                    "type": "header",
                    "text": {
                        "type": "plain_text",
                        "text": "${{ env.HEADER_TEXT }}"
                    }
                },
                {
                    "type": "divider"
                },'

# Construct Slack message sections dynamically
while IFS='=' read -r key value; do
  payload+='{
                    "type": "section",
                    "fields": [
                        {
                            "type": "mrkdwn",
                            "text": "*'$key'*\n'$value'"
                        }
                    ]
                },'
done <<< "$sections"

# Remove the trailing comma and add the closing brackets for the payload
payload=${payload%,}
payload+=']}]}'

# Overwrite the JSON file with the updated payload
echo "$payload" > "$json_file"

echo "Payload updated and saved to $json_file"
