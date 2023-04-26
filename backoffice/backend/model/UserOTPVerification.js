const Mongoose = require("mongoose");

const UserOTPVerificationSchema = new Mongoose.Schema({
  userId : String,
  otp : String ,
  createdAt : Date,
  expiresAt : Date,
});

const UserOTPVerification = Mongoose.model("userOTPVerification", UserOTPVerificationSchema);

module.exports = UserOTPVerification;
