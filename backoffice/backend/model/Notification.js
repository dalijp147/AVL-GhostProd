const Mongoose = require("mongoose");

const NotificationSchema =  Mongoose.Schema({
  
  titre: {
    min: [6, 'Must be at least 6, got {VALUE}'],
    max: 40,
    type: String,
    required: true,
  },
  description:{
    min: [10, 'Must be at least 10, got {VALUE}'],
    max: 255,
    type: String,
    required: true,
  },
});

const Notification = Mongoose.model("notification", NotificationSchema);

module.exports = Notification;
