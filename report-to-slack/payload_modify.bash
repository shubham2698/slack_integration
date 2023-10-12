#!/bin/bash
git_repo=${GITHUB_REPOSITORY}
git_branch=${GITHUB_BRANCH}
test_rep_link=${TEST_REPORTS_LINK}
run_id=${GITHUB_RUN_ID}
sed -i "s|github_repo|$git_repo|g; s|github_branch|$git_branch|g; s|test_report_link|$test_rep_link|g; s|run_id|$run_id|g" ./report-to-slack/reusable-payload.json

# perl -pi -e 's|github_repo|$GITHUB_REPOSITORY|g; s|github_branch|$GITHUB_BRANCH|g; s|test_report_link|$TEST_REPORTS_LINK|g; s|run_id|$GITHUB_RUN_ID|g' ./report-to-slack/reusable-payload.json
