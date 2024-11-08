import axios from 'axios';

export class MuseumApiClient {
    async searchMetMuseum(query) {
        try {
            const searchResponse = await axios.get(
                'https://collectionapi.metmuseum.org/public/collection/v1/search',
                {
                    params: {
                        q: query,
                    },
                }
            );

            if (searchResponse.data && searchResponse.data.objectIDs) {
                const objectIDs = searchResponse.data.objectIDs;
                const detailedResults = [];
                let fetchedCount = 0;
                const limit =
                    searchResponse.data.total < 5
                        ? searchResponse.data.total
                        : 5;
                let index = 0;

                while (fetchedCount < limit && index < objectIDs.length) {
                    const objectID = objectIDs[index];
                    try {
                        const singleItemResponse = await axios.get(
                            `https://collectionapi.metmuseum.org/public/collection/v1/objects/${objectID}`
                        );

                        detailedResults.push({
                            objectID: singleItemResponse.data.objectID,
                            title: singleItemResponse.data.title,
                            artistName:
                                singleItemResponse.data.artistDisplayName,
                            primaryImage: singleItemResponse.data.primaryImage,
                            department: singleItemResponse.data.department,
                            objectURL: singleItemResponse.data.objectURL,
                        });
                        console.log(
                            `Successfully fetched details for object ID ${objectID}`
                        );
                        fetchedCount++;
                    } catch (error) {
                        console.error(
                            `Error fetching details for object ID ${objectID}:`,
                            error.message
                        );
                        // Add a placeholder for failed requests
                        detailedResults.push({
                            objectID: objectID,
                            error: 'Unable to fetch details for this object',
                        });
                    }
                    index++;
                }

                console.log(`Returning ${detailedResults.length} results`);
                return {
                    total: searchResponse.data.total,
                    results: detailedResults,
                };
            } else {
                console.log('No results found');
                return {
                    total: 0,
                    results: [],
                };
            }
        } catch (error) {
            console.error(
                'Error fetching data from Met Museum API:',
                error.message
            );
            throw error;
        }
    }
}

export function initMuseumApiClient() {
    return new MuseumApiClient();
}
