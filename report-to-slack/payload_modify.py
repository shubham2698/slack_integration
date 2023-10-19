import json
import sys
import os

json_data = {}

for var_name, var_value in os.environ.items():
    if var_name.startswith("INPUT_"):
        input_name = var_name[len("INPUT_"):]
        var_value = var_value.replace('"', '\\"')
        json_data[input_name] = var_value

color_code = os.getenv("COLOR_CODE")

    

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

for key, value in json_data.items():
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