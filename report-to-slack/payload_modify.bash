#!/bin/bash

sed -i "s|github_repo|$github.events.inputs.GITHUB_REPOSITORY|g; s|github_branch|$github.events.inputs.GITHUB_BRANCH|g; s|test_report_link|$github.events.inputs.TEST_REPORTS_LINK|g; s|run_id|$github.events.inputs.GITHUB_RUN_ID|g" ./report-to-slack/reusable-payload.json