const express = require('express');
const app = express();
const userRoutes = require('./routes/userRoutes')
const userInfoRoutes = require('./routes/healthRoutes');
const cors = require('cors');
const serverless = require('serverless-http');


require('dotenv').config();

const port = process.env.PORT;
app.use(cors());

app.use(express.json());

app.use((req, res, next) => {
    console.log(req.path, req.method)
    console.log(req.body)
    next()
})

app.use("/.netlify/functions/server/users", userRoutes);

app.use("/.netlify/functions/server/userinfo", userInfoRoutes);

module.exports = app;
module.exports.handler = serverless(app);

// app.listen(port, ()=>{
//     console.log('listening on port', process.env.PORT)
// })

