import json
import sys
import os
import re

def is_camel_case(text):
    pattern = r'^[a-z]+(?:[A-Z][a-z]*)*$'
    return bool(re.match(pattern, text))

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

for key, value in os.environ.items():
    if is_camel_case(key):
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

