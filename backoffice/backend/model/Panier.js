const mongoose = require('mongoose')
const Schema = mongoose.Schema

let Panierschema = new Schema({
    client_id : {type : Schema.Types.ObjectId,ref:"user"},
    produits : [
        {
          _id: { type : Schema.Types.ObjectId, required: true },
          quantity: { type: Number, required: true }
        }
      ],
    total : {
        type : Number,
        default : 0,
       required: true
    },
    createdAt: { type: Date }, 
    state : { type : Number , default : 0},//delivered or not
    livreur : { type: String, default: null},
    localisation:[{
      longitude:{ type : String },
      latitude:{ type : String }
    }],
    NumberTel:{ type : Number , required: true},
    DatePeriod:[{ 
      title:{ type : String },
      startdate:{ type : Date },
      enddate:{ type : Date }
    }]
})

module.exports = mongoose.model('Panier', Panierschema)