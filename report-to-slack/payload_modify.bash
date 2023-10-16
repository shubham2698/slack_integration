# #!/bin/bash

# # Specify the path to your JSON file
# json_file="./report-to-slack/reusable-payload.json"

# # Check if the JSON file exists
# if [ ! -f "$json_file" ]; then
#   echo "JSON file not found: $json_file"
#   exit 1path/to/your/data
# fi

# # Initialize the blocks with the header and divider
# blocks='{
#   "blocks": [
#     {
#       "type": "header",
#       "text": {
#         "type": "plain_text",
#         "text": "Pipeline Failure"
#       }
#     },
#     {
#       "type": "divider"
#     }
#   ]
# }'

# # Iterate over each key-value pair in the JSON file
# jq -r '. | to_entries[] | "\(.key),\(.value)"' "$json_file" |
# while IFS=',' read -r key value; do
#   section_block=$(jq -n --arg key "$key" --arg value "$value" '{
#     "type": "section",
#     "fields": [
#       {
#         "type": "mrkdwn",
#         "text": "*\($key)*\n\($value)"
#       }
#     ]
#   }')

#   # Add the section block to the blocks array
#   blocks=$(jq --argjson section_block "$section_block" '.blocks += [$section_block]' <<< "$blocks")
# done

# # Print the generated Slack Block Kit JSON
# echo "$blocks"

#!/bin/bash

# Specify the path to your JSON file
json_file="./report-to-slack/reusable-payload.json"

# Check if the JSON file exists
if [ ! -f "$json_file" ]; then
  echo "JSON file not found: $json_file"
  exit 1
fi

# Initialize the blocks with the header and divider
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

# Iterate over each key-value pair in the JSON file
jq -r '. | to_entries[] | "\(.key),\(.value)"' "$json_file" |
while IFS=',' read -r key value; do
  echo "Key: $key"
  echo "Value: $value"

  section_block=$(jq -n --arg key "$key" --arg value "$value" '{
    "type": "section",
    "fields": [
      {
        "type": "mrkdwn",
        "text": "*\($key)*\n\($value)"
      }
    ]
  }')

  # Add the section block to the blocks array
  blocks=$(jq --argjson section_block "$section_block" '.blocks += [$section_block]' <<< "$blocks")
done

# Print the generated Slack Block Kit JSON
echo "$blocks"
