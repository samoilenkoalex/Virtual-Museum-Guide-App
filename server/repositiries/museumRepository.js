import 'dotenv/config';
import { MuseumApiClient } from '../clients/museumApiClient.js';

export class MuseumRepository {
    constructor(museumApiClient) {
        if (!(museumApiClient instanceof MuseumApiClient)) {
            throw new Error('Invalid togatherAiClient instance');
        }
        this.museumApiClient = museumApiClient;
    }

    async implementSearch(query) {
        try {
            return await this.museumApiClient.searchMetMuseum(query);
        } catch (error) {
            console.error('Error in DescriptionRepository:', error);
            throw error;
        }
    }
}
// Create and export a default instance
const defaulMuseumApiClient = new MuseumApiClient();
export default new MuseumRepository(defaulMuseumApiClient);
