const fs = require('fs');
const { IncomingWebhook } = require('@slack/webhook');

async function sendSlackMessage(message) {
  const webhook = new IncomingWebhook(process.env.SLACK_WEBHOOK_URL);
  await webhook.send(message);
}

async function main() {
  try {
    const jsonFilePath = process.env.JSON_FILE_PATH || 'data.json';
    const rawData = fs.readFileSync(jsonFilePath);
    const data = JSON.parse(rawData);

    let message = '';

    for (const [heading, link] of Object.entries(data)) {
      message += `*${heading}*: ${link}\n`;
    }

    await sendSlackMessage(message);
  } catch (error) {
    console.error('Error:', error.message);
    process.exit(1);
  }
}

main();
