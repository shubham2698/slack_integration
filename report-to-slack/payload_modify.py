import json
import sys
import os

print("Script Execution Started")


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
    if key.islower():
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

