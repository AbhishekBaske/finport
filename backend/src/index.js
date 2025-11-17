// Entry point for backend Express server
require('dotenv').config();
const express = require('express');
const cookieParser = require('cookie-parser');
const app = express();
const http = require('http').createServer(app);
const websocket = require('./websocket');

// CORS Configuration for Render deployment
const corsOrigin = process.env.CORS_ORIGIN || 'http://localhost:3000';
app.use((req, res, next) => {
  res.header('Access-Control-Allow-Origin', corsOrigin);
  res.header('Access-Control-Allow-Methods', 'GET, POST, PUT, DELETE, OPTIONS');
  res.header('Access-Control-Allow-Headers', 'Origin, X-Requested-With, Content-Type, Accept, Authorization');
  res.header('Access-Control-Allow-Credentials', 'true');
  if (req.method === 'OPTIONS') {
    res.sendStatus(200);
  } else {
    next();
  }
});

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
const HOST = process.env.NODE_ENV === 'production' ? '0.0.0.0' : 'localhost';

http.listen(PORT, HOST, () => {
  console.log(`Backend server listening on ${HOST}:${PORT}`);
  console.log(`Environment: ${process.env.NODE_ENV || 'development'}`);
});
