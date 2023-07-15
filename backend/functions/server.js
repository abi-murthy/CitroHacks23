const express = require('express');
const app = express();
const userRoutes = require('./routes/userRoutes')
const userInfoRoutes = require('./routes/healthRoutes');
const cors = require('cors');

const router = express.Router();

require('dotenv').config();

const port = process.env.PORT;
app.use(cors());

app.use(express.json());

app.use((req, res, next) => {
    console.log(req.path, req.method)
    console.log(req.body)
    next()
})

app.use("/api/users", userRoutes);

app.use("/api/userinfo", userInfoRoutes);



app.listen(port, ()=>{
    console.log('listening on port', process.env.PORT)
})