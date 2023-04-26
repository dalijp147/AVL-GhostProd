const express = require("express");
const router = express.Router();

const { addNotification, updateNotification, getNotifications, deleteNotification} = require("../controller/Notification");

router.route("/add").post(addNotification);
router.route("/update/:id").put(updateNotification);
router.route("/gets").get(getNotifications);
router.route("/delete").delete(deleteNotification);


module.exports = router;
