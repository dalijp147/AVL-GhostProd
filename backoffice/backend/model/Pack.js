const mongoose = require("mongoose");
const Schema = mongoose.Schema;

const Product = require("./Product");

let PackSchema = new Schema({
  title: { type: String, required: true },
  price: { type: Number, required: true },
  description: { type: String },
  createdAt: { type: Date },
  productList: [
    { 
      _id: { type: Schema.Types.ObjectId, ref: Product },
      quantity: { type: Number }
    }],
});

module.exports = mongoose.model("Pack", PackSchema);
