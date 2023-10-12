#!/bin/bash
TEST_REPORT_LINK=${ github.events.inputs.TEST_REPORT_LINK }
echo $TEST_REPORT_LINK
sed -i "s|github_repo|$GITHUB_REPOSITORY|g; s|github_branch|$GITHUB_REF_NAME|g; s|test_report_link|$INPUT_TEST_REPORT_LINK|g; s|run_id|$GITHUB_RUN_ID|g" ./report-to-slack/reusable-payload.json
# perl -pi -e 's|github_repo|$GITHUB_REPOSITORY|g; s|github_branch|$GITHUB_BRANCH|g; s|test_report_link|$TEST_REPORTS_LINK|g; s|run_id|$GITHUB_RUN_ID|g' ./report-to-slack/reusable-payload.json
