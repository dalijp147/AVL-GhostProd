const express = require("express");
const router = express.Router();

const { addfeedback, updatefeedback, getfeedbacks, deletefeedback} = require("../controller/Feedback");

router.route("/add").post(addfeedback);
router.route("/update/:id").put(updatefeedback);
router.route("/gets").get(getfeedbacks);
router.route("/delete").delete(deletefeedback);


module.exports = router;
