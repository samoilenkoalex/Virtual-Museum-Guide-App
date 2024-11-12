import Together from 'together-ai';

export class TogetherAiClient {
    constructor(apiKey) {
        if (!apiKey) {
            throw new Error(
                'TogetherAi API key is missing. Please set TOGETHER_API_KEY in environment variables.'
            );
        }
        this.togetherClient = new Together({ apiKey });
    }

    getClient() {
        return this.togetherClient;
    }

    async getCompletion(img_url) {
        try {
            const response = await this.togetherClient.chat.completions.create({
                messages: [
                    {
                        role: 'user',
                        content: [
                            {
                                type: 'text',
                                text: 'describe image: its author, historical period, color composition, style.',
                            },
                            {
                                type: 'image_url',
                                image_url: {
                                    url: img_url,
                                },
                            },
                        ],
                    },
                ],
                model: 'meta-llama/Llama-3.2-90B-Vision-Instruct-Turbo',
            });

            return response.choices[0].message.content;
        } catch (error) {
            console.error('Error in TogatherAiClient:', error);
            throw error;
        }
    }
}

export function initTogetherAiClient(apiKey) {
    return new TogetherAiClient(apiKey);
}
