#!/bin/bash
GR=${ github.events.inputs.github_repository }
GB=${ github.events.inputs.github_branch }
GRI=${ github.events.inputs.github_run_id }
TRL=${ github.events.inputs.test_report_link }
echo $GR,$GB,$GRI,$TRL

sed -i "s|github_repo|$GR|g; s|github_branch|$GB|g; s|test_report_link|$TRL|g; s|run_id|$GRI|g" ./report-to-slack/reusable-payload.json
