// dependencies.js
import { MuseumApiClient } from './path/to/MuseumApiClient.js';
import { MuseumRepository } from './path/to/MuseumRepository.js';
import { TogetherAiClient } from './path/to/TogetherAiClient.js';
import { DescriptionRepository } from './path/to/DescriptionRepository.js';

export function initializeDependencies() {
    const museumApiClient = new MuseumApiClient();
    const museumRepository = new MuseumRepository(museumApiClient);

    const togetherAiClient = new TogetherAiClient(process.env.TOGETHER_API_KEY);
    const descriptionRepository = new DescriptionRepository(togetherAiClient);

    return {
        museumRepository,
        descriptionRepository,
    };
}
