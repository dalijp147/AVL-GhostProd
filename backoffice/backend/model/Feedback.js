const Mongoose = require("mongoose");

const FeedbackSchema = new Mongoose.Schema({
  
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

const Feedback = Mongoose.model("feedback", FeedbackSchema);

module.exports = Feedback;
