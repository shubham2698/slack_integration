const fs = require("fs");
const core = require("@actions/core");
const axios = require("axios");
const { exec } = require('child_process');

async function run() {
  try {
    const payloadFilePath = core.getInput("payload_file_path");
    const payload = readPayloadFromFile(payloadFilePath);
    await sendToSlack(payload);
  } catch (error) {
    core.setFailed(`Action failed with error: ${error.message}`);
  }
}

exec('chmod +x ./report-to-slack/payload_modify.bash && ' +
             './report-to-slack/payload_modify.bash && ' +
             'cat ./report-to-slack/reusable-payload.json', (error) => {
            if (error) {
                console.error('Error executing shell commands:', error);
                return;
            }
            console.log('Shell commands executed successfully');
      });

function readPayloadFromFile(filePath) {
  try {
    const data = fs.readFileSync(filePath, "utf8");
    return JSON.parse(data);
  } catch (error) {
    throw new Error(`Error reading payload file: ${error.message}`);
  }
}

async function sendToSlack(payload) {
  const botToken = core.getInput("slack_bot_token");
  const channelId = core.getInput("slack_channel_id");

  try {
    await axios.post("https://slack.com/api/chat.postMessage", {
      channel: channelId,
      blocks: payload.blocks,
    }, {
      headers: {
        "Authorization": `Bearer ${botToken}`,
        "Content-Type": "application/json",
      },
    });
  } catch (error) {
    core.setFailed(`Failed to send message to Slack: ${error.message}`);
  }
}

run();
