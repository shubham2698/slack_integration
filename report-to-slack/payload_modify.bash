#!/bin/bash

sed -i "s|github_repo|$GITHUB_REPOSITORY|g; s|github_branch|$GITHUB_REF_NAME|g; s|test_report_link|$INPUT_TEST_REPORTS_LINK|g; s|run_id|$GITHUB_RUN_ID|g" ./report-to-slack/reusable-payload.json
# perl -pi -e 's|github_repo|$GITHUB_REPOSITORY|g; s|github_branch|$GITHUB_BRANCH|g; s|test_report_link|$TEST_REPORTS_LINK|g; s|run_id|$GITHUB_RUN_ID|g' ./report-to-slack/reusable-payload.json
