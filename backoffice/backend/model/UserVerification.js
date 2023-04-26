const Mongoose = require("mongoose");

const UserVerificationSchema = new Mongoose.Schema({
  userId : String,
  uniqueString : String ,
  createdAt : Date,
  expiresAt : Date,
});

const UserVerification = Mongoose.model("userVerification", UserVerificationSchema);

module.exports = UserVerification;
