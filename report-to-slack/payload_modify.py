import json
import sys
import os
import re

print("Creating Payload...")

json_file_path = "payload.json"

payload = {
    "attachments": [
        {
            "color": f"#FF0000",
            "blocks": [
                {
                    "type": "header",
                    "text": {
                        "type": "plain_text",
                        "text": "Unit Test Result (hard-coded)"
                    }
                },
                {
                    "type": "divider"
                }
            ]
        }
    ]
}

data = {}

for key, value in os.environ.items():
    if key.startswith('SLACK_'):
        key=key[len("SLACK_"):].replace("_"," ")
        data[key] = value

print(data)

for key, value in os.environ.items():
    if key.startswith('SLACK_'):
        key=key[len("SLACK_"):].replace("_"," ")
        section = {
            "type": "section",
            "fields": [
                {
                    "type": "mrkdwn",
                    "text": f"*{key}*\n{value}"
                }
            ]
        }
        payload["attachments"][0]["blocks"].append(section)

print("Payload Creation Completed")

with open(json_file_path, 'w') as json_file:
    json.dump(payload, json_file, indent=4)

print("Exported ./payload.json")
