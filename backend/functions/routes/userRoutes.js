const express = require("express");
const router = express.Router();

const {registerUser, loginUser, logoutUser} = require("../controllers/userController");

// register route
router.post("/register", registerUser);
// login route
router.post("/login", loginUser);
//logout 
router.post("/logout", logoutUser);

module.exports = router;