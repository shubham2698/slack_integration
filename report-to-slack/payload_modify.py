import json
import sys
import os

env_variables = os.environ
json_data = {}
exclude_variables = [
    "pythonLocation",
    "PKG_CONFIG_PATH",
    "Python_ROOT_DIR",
    "Python2_ROOT_DIR",
    "Python3_ROOT_DIR",
    "LD_LIBRARY_PATH"
]


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
    if key.startswith("INPUT_") and value not in exclude_variables:
        key = key[len("INPUT_"):]
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