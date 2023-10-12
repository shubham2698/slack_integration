const axios = require('axios');
const fs = require('fs');

const payloadFilePath = process.env.PAYLOAD_FILE_PATH || './report-to-slack/reusable-payload.json';
const slackBotToken = process.env.SLACK_BOT_TOKEN;
const slackChannelID = process.env.CHANNEL_ID;

const sendSlackNotification = async () => {
    try {
        // Read the payload from the specified file
        const payload = JSON.parse(fs.readFileSync(payloadFilePath, 'utf-8'));
        payload.channel = slackChannelID;
        // Send the payload to Slack
        const response = await axios.post(slackBotToken, payload);

        console.log('Message sent to Slack:', response.data);
    } catch (error) {
        console.error('Error sending message to Slack:', error);
    }
};

// Send Slack notification
sendSlackNotification();
