const express = require('express');
const bodyParser = require('body-parser');
const cors = require('cors');
const axios = require('axios');

const app = express();
app.use(cors());
app.use(bodyParser.json());

const API_KEY = 'your_openai_api_key'; // Replace with your OpenAI API key.

app.post('/chat', async (req, res) => {
    const { message, history } = req.body;

    try {
        const response = await axios.post('https://api.openai.com/v1/chat/completions', {
            model: 'gpt-4',
            messages: [...history, { role: 'user', content: message }],
        }, {
            headers: {
                'Authorization': `Bearer ${API_KEY}`,
                'Content-Type': 'application/json'
            }
        });

        const aiMessage = response.data.choices[0].message.content;
        res.json({ reply: aiMessage });
    } catch (error) {
        console.error('Error:', error);
        res.status(500).send('Error communicating with AI');
    }
});

app.listen(5000, () => {
    console.log('Server is running on http://localhost:5000');
});