import 'dotenv/config';
import { TogetherAiClient } from '../clients/togethrAiClient.js';

export class DescriptionRepository {
    constructor(togetherAiClient) {
        if (!(togetherAiClient instanceof TogetherAiClient)) {
            throw new Error('Invalid togatherAiClient instance');
        }
        this.togatherAiClient = togetherAiClient;
    }

    async getDescriptions(img_url) {
        try {
            return await this.togatherAiClient.getCompletion(img_url);
        } catch (error) {
            console.error('Error in DescriptionRepository:', error);
            throw error;
        }
    }
}
// Create and export a default instance
const defaulTogetherAiClient = new TogetherAiClient(
    process.env.TOGETHER_API_KEY || ''
);
export default new DescriptionRepository(defaulTogetherAiClient);
