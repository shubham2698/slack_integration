import json
import sys
import os
import re

json_file_path = "payload.json"
data = {}
payload = {
    "fallback": f"{os.environ.get('FALLBACK')}",
    "attachments": [
        {
            "color": f"{os.environ.get('COLOR_CODE')}",
            "blocks": [
                {
                    "type": "header",
                    "text": {
                        "type": "plain_text",
                        "text": f"{os.environ.get('HEADER_TEXT')}"
                    }
                },
                {
                    "type": "divider"
                }
            ]
        }
    ]
}


for key, value in os.environ.items():
    if key.startswith('SLACK_'):
        key=key[len("SLACK_"):].replace("_"," ")
        data[key] = value

data = {key: value for key, value in reversed(data.items())}

for key, value in data.items():
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

with open(json_file_path, 'w') as json_file:
    json.dump(payload, json_file, indent=4)

