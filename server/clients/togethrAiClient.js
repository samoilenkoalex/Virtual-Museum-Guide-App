import Together from 'together-ai';

export class TogatherAiClient {
    constructor(apiKey) {
        if (!apiKey) {
            throw new Error(
                'TogatherAi API key is missing. Please set TOGETHER_API_KEY in environment variables.'
            );
        }
        this.togetherClient = new Together({ apiKey });
    }

    getClient() {
        return this.togetherClient;
    }

    async getCompletion(content) {
        try {
            const response = await this.togetherClient.chat.completions.create({
                messages: [
                    {
                        role: 'user',
                        content: content,
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

export function initTogatherAiClient(apiKey) {
    return new TogatherAiClient(apiKey);
}
