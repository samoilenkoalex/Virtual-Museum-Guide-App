import 'dotenv/config';
import { TogatherAiClient } from '../clients/togethrAiClient.js';

export class DescriptionRepository {
    constructor(togatherAiClient) {
        if (!(togatherAiClient instanceof TogatherAiClient)) {
            throw new Error('Invalid togatherAiClient instance');
        }
        this.togatherAiClient = togatherAiClient;
    }

    async getDescriptions() {
        try {
            const content = 'What are some fun things to do in New York?';
            return await this.togatherAiClient.getCompletion(content);
        } catch (error) {
            console.error('Error in DescriptionRepository:', error);
            throw error;
        }
    }
}
// Create and export a default instance
const defaulTogatherAiClient = new TogatherAiClient(
    process.env.TOGETHER_API_KEY || ''
);
export default new DescriptionRepository(defaulTogatherAiClient);
