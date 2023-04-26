const mongoose = require('mongoose')
const Schema = mongoose.Schema

let ProductSchema = new Schema({
  name: { type: String, required: true, max: 100 },
  price: { type: Number, required: true },
  description: { type: String },
  imageUrl: [],
  createdAt: { type: Date },
  quantity: { type: Number, default: 1 },
  discount:{ type: Number, default: 0 },
  priceAfterDiscount : { type: Number },
})

module.exports = mongoose.model('Product', ProductSchema)
