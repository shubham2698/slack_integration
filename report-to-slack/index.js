const axios = require('axios');
const fs = require('fs');

const payloadFilePath = process.env.PAYLOAD_FILE_PATH || './report-to-slack/reusable-payload.json';
const slackWebhookURL = process.env.SLACK_WEBHOOK_URL;

const sendSlackNotification = async () => {
    try {
        // Read the payload from the specified file
        const payload = JSON.parse(fs.readFileSync(payloadFilePath, 'utf-8'));

        // Send the payload to Slack
        const response = await axios.post(slackWebhookURL, payload);

        console.log('Message sent to Slack:', response.data);
    } catch (error) {
        console.error('Error sending message to Slack:', error);
    }
};

// Send Slack notification
sendSlackNotification();
