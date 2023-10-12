FROM node:latest

WORKDIR /usr/src/app

# COPY package.json ./
# COPY ./index.js index.js

# RUN sed -i "s|github_repo|${{inputs.GITHUB_REPOSITORY}}|g; s|github_branch|${{inputs.GITHUB_BRANCH}}|g; s|test_report_link|${{inputs.TEST_REPORTS_LINK}}|g; s|run_id|${{inputs.GITHUB_RUN_ID}}|g" util/slack-notification/reusable-payload.json

RUN npm install axios

COPY . .

ENTRYPOINT ["node", "/usr/src/app/index.js"]
# ENTRYPOINT [" index.js "]