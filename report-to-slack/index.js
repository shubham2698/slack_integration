const fs = require("fs");
const core = require("@actions/core");
const axios = require("axios");

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

  const determineColor = (isSuccessful) => {
    return isSuccessful ? 'good' : 'danger';
  };

  const isSuccessful = process.env.IS_SUCCESSFUL === 'true';
  const color = determineColor(isSuccessful);

  // Modify payload to include color in each section block
  payload.blocks.forEach((block) => {
    if (block.type === 'section') {
      block.color = color;
    }
  });

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

async function run() {
  try {
    const payloadFilePath = core.getInput("payload_file_path");
    const payload = readPayloadFromFile(payloadFilePath);
    await sendToSlack(payload);
  } catch (error) {
    core.setFailed(`Action failed with error: ${error.message}`);
  }
}

run();
