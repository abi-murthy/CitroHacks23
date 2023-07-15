const asyncHandler = require("express-async-handler");

const supabase = require('./../createClient');

// const bcrypt = require("bcrypt");
// const supabase = require("./../supabaseClient.js");


// @desc Register a user
// @route POST /api/users/register
// @access public

const registerUser = asyncHandler(async (req, res) => {
    const {email, password} = req.body
    const { data, error } = await supabase.auth.signUp({
        email,
        password
    })
    if (error){
        console.log(error);
        console.log(data);
        res.status(400).json({msg:"Could not register"});
        throw new Error("Can't register", error);
    }    
    return res.status(200).json(data);   
})


// const loginUser 

// @route POST /api/users/login
const loginUser = asyncHandler(async (req, res) => {
    const {email, password} = req.body
    const { data, error } = await supabase.auth.signInWithPassword({
        email,
        password
    })
    if (error){
        res.status(400).json({msg:"Could not login"});
        throw new Error("Can't log in", error);
    }    
    return res.status(200).json(data);
})

// logoutUser

// @route POST /api/users/logout
const logoutUser = asyncHandler(async(req, res) => {
    const { error } = await supabase.auth.signOut();
    if (error){
        res.status(400).json({msg:"Could not logout"});
        throw new Error("Can't log out", error);
    }
    else{
        res.status(200).json({msg:"Successful"});
    }
})


module.exports = {
    logoutUser, 
    loginUser,
    registerUser
};

