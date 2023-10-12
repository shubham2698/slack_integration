const fs = require("fs");
const core = require("@actions/core");
const axios = require("axios");

async function run() {
  try {
    const payloadFilePath = core.getInput("payload_file_path");

    // Read the JSON data from the payload file
    const message = readPayloadFromFile(payloadFilePath);

    // Send the message to Slack
    await sendToSlack(message);
  } catch (error) {
    core.setFailed(`Action failed with error: ${error.message}`);
  }
}

function readPayloadFromFile(filePath) {
  try {
    const data = fs.readFileSync(filePath, "utf8");
    return JSON.parse(data);
  } catch (error) {
    throw new Error(`Error reading payload file: ${error.message}`);
  }
}

async function sendToSlack(message) {
  const botToken = core.getInput("slack_bot_token");
  const channelId = core.getInput("slack_channel_id");

  try {
    await axios.post("https://slack.com/api/chat.postMessage", {
      channel: channelId,
      text: JSON.stringify(message, null, 2), // Convert JSON to a formatted string
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
