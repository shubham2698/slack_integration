#!/bin/bash

json_data='{}'
output_file="payload.json"
for var in $(compgen -e); do
    if [[ "$var" == SLACK_* ]]; then
        key="${var#SLACK_}"
        json_data=$(echo "$json_data" | jq --arg key "$key" --arg value "${!var}" '. + {($key): $value}')
    fi
done
echo "$json_data"

payload='{
    "fallback": "${{ env.FALLBACK }}",
    "attachments": [
        {
            "color": "${{ env.COLOR_CODE }}",
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
                }'



for key in $(echo "$json_data" | jq -r 'keys[]'); do
    value=$(echo "$json_data" | jq -r ".$key")
    payload+=',{
                "type": "section",
                "fields": [
                    {
                        "type": "mrkdwn",
                        "text": "*'$key'*\n'$value'"
                    }
                ]
            }'
done <<< "$sections"
payload+=']}]}'
echo $payload
echo "$payload" > "$output_file"


# json_file="slack-payload-input.json"
# sections=$(jq -r 'to_entries | map("\(.key)=\(.value)") | .[]' "$json_file")

# json_data='{}'
# output_file="payload.json"
# echo "$json_data" > "$output_file"

# # Define the while loop string
# # shellcheck disable=SC2034
# while_loop='while IFS= read -r key value; do'

# # Initialize the payload with the initial text
# # shellcheck disable=SC2016
# payload='{
#     "fallback": "${{ env.FALLBACK }}",
#     "attachments": [
#         {
#             "color": "${{ env.COLOR_CODE }}",
#             "blocks": [
#                 {
#                     "type": "header",
#                     "text": {
#                         "type": "plain_text",
#                         "text": "${{ env.HEADER_TEXT }}"
#                     }
#                 },
#                 {
#                     "type": "divider"
#                 }'

# # Construct Slack message sections dynamically
# while IFS='=' read -r key value; do
#   payload+=',{
#                 "type": "section",
#                 "fields": [
#                     {
#                         "type": "mrkdwn",
#                         "text": "*'$key'*\n'$value'"
#                     }
#                 ]
#             }'
# done <<< "$sections"
# payload+=']}]}'
# echo "$payload" > "$output_file"
