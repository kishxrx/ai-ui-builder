// Step 1: Import express
const express = require('express');

// Step 2: Creating app
const app = express();

// Step 3: When someone visits '/', sends a message
app.get('/', (req, res) => {
  res.send('Hello, OUR AI UI Builder IS CURRENTLY ON BUILD PLEASE COME BACK AGAIN IN A COUPLE OF DAYS!');
});

// Step 4: Tell app to listen on port 3000
app.listen(3000, () => {
  console.log('Server is running on http://localhost:3000');
});
