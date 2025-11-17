// Entry point for backend Express server
require('dotenv').config();
const express = require('express');
const cookieParser = require('cookie-parser');
const app = express();
const http = require('http').createServer(app);
const websocket = require('./websocket');

app.use(express.json());
app.use(cookieParser());


// Example route
app.get('/', (req, res) => {
  res.send('Finport backend running');
});

// User OTP routes
const userRoutes = require('./routes/userRoutes');
app.use('/api/user', userRoutes);

// Attach WebSocket
websocket(http);

const PORT = process.env.PORT || 4000;
http.listen(PORT, () => {
  console.log(`Backend server listening on port ${PORT}`);
});
