#!/bin/bash
echo $github_branch
echo $INPUT_TEST_REPORT_LINK
sed -i "s|github_repo|$github_repository|g; s|github_branch|$github_branch|g; s|test_report_link|$INPUT_TEST_REPORT_LINK|g; s|run_id|$github_run_id|g" ./report-to-slack/reusable-payload.json
# perl -pi -e 's|github_repo|$GITHUB_REPOSITORY|g; s|github_branch|$GITHUB_BRANCH|g; s|test_report_link|$TEST_REPORTS_LINK|g; s|run_id|$GITHUB_RUN_ID|g' ./report-to-slack/reusable-payload.json
