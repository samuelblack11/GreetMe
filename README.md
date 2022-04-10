README:

GreetMe is a digital greeting card app, allowing users to create custom digital greeting cards with a photo collage and custom formatted note to the recipient. They may be sent for special occasions, as postcards, or just because! Users may then share their custom greeting card via text, email, or share to social media. Photos for the collage can be added from the user’s photo library or from the __ API service. 

Instructions for the App are as follows:
1. Login using Apple ID
2. Choose from menu wether to create new greeting card, or view previously sent cards 
    1. If viewing previously sent cards, those cards (stored to Core Data) are displayed in a Collection View. Each cell displays an image of the card along with the recipient’s name, the occasion, and date it was sent.
3. If creating a new card, user will be prompted to import photos from their library or from the __ API using the “Select Photo #” Button.
    1. If importing from the __ API, the user will search for photos by keyword, then add them to the collage
4. User will finalize photo selection and write a personalized note up to 140 characters long and choose a font for the note to be written in
5. The user will perform one final review of the full card (collage and note), then share with the recipient however they choose