const express = require("express");
const router = express.Router();

const {addUserInfo, editUserInfo, deleteUserInfo, fetchData} = require('./../controllers/healthController')


// get entries
router.get('/', fetchData)

//add entry
router.post('/add', addUserInfo)


//update entry
router.put('/update', editUserInfo)


//remove entry
router.delete('/delete', deleteUserInfo)

module.exports = router;


