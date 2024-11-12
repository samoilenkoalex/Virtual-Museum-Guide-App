import express from 'express';
import dotenv from 'dotenv';

dotenv.config();

export default function createRoutes({
    museumRepository,
    descriptionRepository,
}) {
    const router = express.Router();

    router.post('/description', async (req, res) => {
        try {
            const description = await descriptionRepository.getDescriptions(
                req.body.img_url
            );

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
            const result = await museumRepository.implementSearch(
                req.body.query
            );
            res.json({ result });
        } catch (error) {
            console.error('Detailed error:', error);
            res.status(500).json({
                error: 'An error occurred while processing your request',
                details: error.message,
            });
        }
    });

    return router;
}
