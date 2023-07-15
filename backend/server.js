const express = require('express');
const app = express();
app.use(express.json());

const dotenv = require('dotenv').config();
const port = process.env.PORT;

app.listen("5000", () => {
    
    
})