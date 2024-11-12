import express from 'express';
import cors from 'cors';
import dotenv from 'dotenv';
import { TogetherAiClient } from './clients/togethrAiClient.js';
import { MuseumApiClient } from './clients/museumApiClient.js';
import { DescriptionRepository } from './repositories/descriptionRepository.js';
import { MuseumRepository } from './repositories/museumRepository.js';
import createRoutes from './routes/routes.js';

dotenv.config();

const app = express();

// Enable CORS for all routes
app.use(cors());

// Middleware to parse JSON bodies
app.use(express.json());

// Initialize dependencies
const togetherAiClient = new TogetherAiClient(process.env.TOGETHER_API_KEY);
const museumApiClient = new MuseumApiClient();
const descriptionRepository = new DescriptionRepository(togetherAiClient);
const museumRepository = new MuseumRepository(museumApiClient);

// Use the routes with injected dependencies
app.use('/api', createRoutes({ museumRepository, descriptionRepository }));

// Start the server
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
    console.log(`Server is running on port ${PORT}`);
});
