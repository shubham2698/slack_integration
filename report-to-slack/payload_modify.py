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

for var_name, var_value in env_variables.items():
    if var_name.startswith("INPUT_") and var_name not in exclude_variables:
        input_name = var_name[len("INPUT_"):]
        var_value = var_value.replace('"', '\\"')
        json_data[input_name] = var_value

color_code = os.getenv("COLOR_CODE")

print(json_data)

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