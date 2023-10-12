const core = require("@actions/core");
const exec = require("child_process").exec;
const axios = require("axios");

async function run() {
  try {
    const payloadFilePath = core.getInput("payload_file_path");
    // const shellCommand = core.getInput("shell_command");

    // Run the shell command
    const { stdout, stderr } = await execShellCommand(shellCommand);

    // Send the output to Slack
    await sendToSlack(stdout, stderr);
  } catch (error) {
    core.setFailed(`Action failed with error: ${error.message}`);
  }
}

async function execShellCommand(command) {
  return new Promise((resolve, reject) => {
    exec(command, (error, stdout, stderr) => {
      if (error) {
        reject(error);
      } else {
        resolve({ stdout, stderr });
      }    // const shellCommand = core.getInput("shell_command");
    });
  });
}

async function sendToSlack(stdout, stderr) {
  const botToken = core.getInput("slack_bot_token");
  const channelId = core.getInput("slack_channel_id");
  const message = `Shell Command Output:\n\`\`\`${stdout}\`\`\`\nErrors:\n\`\`\`${stderr}\`\`\``;

  try {
    await axios.post("https://slack.com/api/chat.postMessage", {
      channel: channelId,
      text: message,
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
