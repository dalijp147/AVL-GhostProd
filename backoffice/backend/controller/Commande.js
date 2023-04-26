const router = require('express').Router();
const Commande = require('../model/Commande');


router.post('/addCommande',async(req,res)=>{
    const commande = Commande(req.body);
    await commande.save();
    res.sendStatus(200)

});

module.exports=router;