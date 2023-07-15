const express = require("express");
const router = express.Router();

const {addUserInfo, editUserInfo, deleteUserInfo} = require('./../controllers/healthController')



//add entry
router.post('/add', addUserInfo)


//update entry
router.put('/update', editUserInfo)


//remove entry
router.delete('/delete', deleteUserInfo)

module.exports = router;


