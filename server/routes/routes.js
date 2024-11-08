import express from 'express';
import dotenv from 'dotenv';
import { DescriptionRepository } from '../repositiries/descriptionRepository.js';

import { MuseumRepository } from '../repositiries/museumRepository.js';
import { TogatherAiClient } from '../clients/togethrAiClient.js';
import { MuseumApiClient } from '../clients/museumApiClient.js';

dotenv.config();
const router = express.Router();

router.post('/description', async (req, res) => {
    try {
        const togatherAiClient = new TogatherAiClient(
            process.env.TOGETHER_API_KEY
        );
        const descriptionRepository = new DescriptionRepository(
            togatherAiClient
        );
        const description = await descriptionRepository.getDescriptions();
        res.json({ message: description });
    } catch (error) {
        console.error('Error:', error);
        res.status(500).json({
            error: 'An error occurred while processing your request',
        });
    }
});

router.post('/search', async (req, res) => {
    try {
        const museumApiClient = new MuseumApiClient();
        const museumRepository = new MuseumRepository(museumApiClient);
        const result = await museumRepository.implementSearch(req.body.query);
        res.json({ result });
    } catch (error) {
        console.error('Detailed error:', error);
        res.status(500).json({
            error: 'An error occurred while processing your request',
            details: error.message,
        });
    }
});

export default router;
