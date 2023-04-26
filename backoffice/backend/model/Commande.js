const mongoose = require('mongoose')
const Schema = mongoose.Schema

let Commandeschema = new Schema({
    details:{
        _id:mongoose.Types.ObjectId,
        client_id : mongoose.Types.ObjectId,
        total:Number,
        createdAt:Date,
        state:Boolean,
        coordination:[],
        DateSet:{},
        client:[{
            username: {
                type: String,
              },
              password: {
                type: String,
              },
              email:{
                type: String,
              },
              role:{
                type: String,
              },
              etat:{
                type: Number,
              }
            }
        ]
    },
    produits : [
        {
          
          quantity: Number,
          product:{
            name: String,
           price: Number,
           description: String ,
          imageUrl: String,
         createdAt: Date ,
          quantity: Number,
          }
        }
      ],
    total : {
        type : Number,
        
    },
    createdAt: { type: Date }, 
    delivered : { default:0 ,type : Number }
})

module.exports = mongoose.model('Commande', Commandeschema)