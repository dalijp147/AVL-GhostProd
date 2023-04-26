const { default: mongoose } = require("mongoose");
const Mongoose = require("mongoose");

const UserSchema = new Mongoose.Schema({
  username: {
    type: String,
    unique: true,
    required: true,
  },
  password: {
    type: String,
    minlength: 6,
    required: true,
  },
  email:{
    type: String,
    required: true,
  },
  role:{
    type: String,
    required : true,
    enum: {
      values: ['livreur', 'client','super','admin'],
      message: '{VALUE} is not supported'
    }
  },
  etat:{
    type: Number,
    default:0
  },
  verified : {type:Boolean,default:false},
  commande:{type:mongoose.Types.ObjectId,default:null}
});

const User = Mongoose.model("user", UserSchema);

module.exports = User;
