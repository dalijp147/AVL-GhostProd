const express = require("express");
const router = express.Router();

const {  addproduitpanier, deleteproduitpanier,deletepanier,panierbyuser,listepanier, changeState ,addCommande} = require("../controller/Panier");

router.route("/addproduit").post(addproduitpanier);
router.route("/gets").get(listepanier);
router.route("/getsbyuser").get(panierbyuser);
router.route("/delete").delete(deletepanier);
router.route("/deleteproduit").delete(deleteproduitpanier);
router.route('/state').put(changeState);
router.route('/addCommande').post(addCommande),

module.exports = router;
