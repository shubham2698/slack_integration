import json
import sys
import os

env_variables = os.environ

json_data = {}
for key, value in env_variables.items():
    value = value.replace('"', '\\"')
    json_data[key] = value

json_file = json.dumps(json_data)
color_code = os.getenv("COLOR_CODE")


with open(json_file, 'r') as file:
    data = json.load(file)
    

payload = {
    "attachments": [
        {
            "color": f"{color_code}",
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

print(payload)