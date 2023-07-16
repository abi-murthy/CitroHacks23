const asyncHandler = require("express-async-handler");

const supabase = require('./../createClient')

// const bcrypt = require("bcrypt");


// fetch data


const fetchData = asyncHandler(async (req, res) => {
    // const { weight, caloriesIn, caloriesOut } = req.body; // Assuming the form submission is available in req.body
    const { data, error } = await supabase
    .from('User Info')
    .select()
    
    if (error){
        return res.status(400).json({msg:"Bad body!"})
    }
    res.status(200).json({message: "fetch successful"});
})




// @desc Add user info 
// @route POST /api/userinfo/add
// @access public
const addUserInfo = asyncHandler(async (req, res) => {
        // const { weight, caloriesIn, caloriesOut } = req.body; // Assuming the form submission is available in req.body
        const { error } = await supabase
        .from('User Info')
        .insert({...req.body})
        if (error){
            console.log(error)
            return res.status(400).json({msg:"Bad body!"})
        }
        res.status(200).json({message: "add successful"});

})



// @desc Edit user info 
// @route PUT /api/userinfo/edit
// @access public
const editUserInfo = asyncHandler(async (req, res) => {
    const itemId = req.body.id;
    // const { weight, caloriesIn, caloriesOut } = req.body;
    const { error } = await supabase
    .from('User Info')
    .update(req.body)
    .eq('id', itemId)
    if (error){
        return res.status(400).json({message: "Cannot edit"});
    }
    res.status(200).json({message: "Edit successful"});
    
})


// @desc Delete user info 
// @route Delete /api/userinfo/delete
// @access public

const deleteUserInfo = asyncHandler(async (req, res) => {
    const itemId = req.body.id;
    const { error } = await supabase
    .from('User Info')
    .delete()
    .eq('id', itemId)
    
    if (error){
        return res.status(400).json({message: "Cannot delete"});
    }

    res.status(200).json({message: "Delete successful"});
})










module.exports = {
    editUserInfo,
    addUserInfo, 
    deleteUserInfo
};

