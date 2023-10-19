import json
import sys
import os

print("Script Execution Started")
for key, value in os.environ.items():
    if key.islower():
        print(f"{key}={value}")

