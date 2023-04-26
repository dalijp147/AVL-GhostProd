const express = require("express");
const router = express.Router();
const {userAuth} = require('../middleware/auth');
const { register, getUsers, getLivreurs, getUsersadmin, deleteuser, blockuser, verifyOTP, ResendVerifyOTP, registerlivreuradmin, unblockuser, changeVerified} = require("../controller/auth");

router.post("/register",register);
router.post("/registerlivreuradmin",registerlivreuradmin);
router.get("/getUsers", userAuth, getUsers);
router.get("/getadmins", userAuth, getUsersadmin);
router.delete("/delete", userAuth, deleteuser);
router.put("/block", userAuth, blockuser);
router.put("/unblock", userAuth, unblockuser);
router.get('/getlivreurs', getLivreurs);
router.post('/verifyOTP', verifyOTP);
router.post('/ResendVerifyOTP', ResendVerifyOTP);
router.put('/verified', changeVerified);

module.exports = router;
