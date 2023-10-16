const fs = require('fs');
const { IncomingWebhook } = require('@slack/webhook');

async function sendSlackMessage(blocks) {
  const webhook = new IncomingWebhook(process.env.SLACK_WEBHOOK_URL);
  await webhook.send({
    blocks: blocks
  });
}

async function main() {
  try {
    const jsonFilePath = process.env.JSON_FILE_PATH || 'data.json';
    const rawData = fs.readFileSync(jsonFilePath);
    const data = JSON.parse(rawData);

    let blocks = [
      {
        "type": "header",
        "text": {
          "type": "plain_text",
          "text": "Your Heading"
        }
      },
      {
        "type": "divider"
      }
    ];

    for (const [heading, link] of Object.entries(data)) {
      blocks.push(
        {
          "type": "section",
          "fields": [
            {
              "type": "mrkdwn",
              "text": `*${heading}*\n${link}`
            }
          ]
        }
      );
    }

    await sendSlackMessage(blocks);
  } catch (error) {
    console.error('Error:', error.message);
    process.exit(1);
  }
}

main();