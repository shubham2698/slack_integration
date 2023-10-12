#!/bin/bash

sed -i "s|github_repo|${inputs.GITHUB_REPOSITORY}|g; s|github_branch|${inputs.GITHUB_BRANCH}|g; s|test_report_link|${inputs.TEST_REPORTS_LINK}|g; s|run_id|${inputs.GITHUB_RUN_ID}|g" util/slack-notification/reusable-payload.json
    