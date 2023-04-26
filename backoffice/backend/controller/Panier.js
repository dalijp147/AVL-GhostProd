const Panier = require("../model/Panier");
const Product = require("../model/Product");
const mongoose = require("mongoose");
const User = require("../model/User");


exports.addCommande = async (req, res, next) => {
  await Panier.create({
    client_id : req.body.client_id,
    produits : req.body.produits,
    total : req.body.total,
    createdAt: new Date(), 
    state : req.body.state,//delivered or not
    localisation:req.body.localisation,
    NumberTel:req.body.NumberTel,
    DatePeriod:req.body.DatePeriod,
  }).then(() => {
    res.status(200).json({
      message: "bien ajoute !",
    });
  }).catch((error) =>
  res
    .status(400)
    .json({ message: "An error occurred", error: error.message })
);;

};

exports.addproduitpanier = async (req, res, next) => {
  const { client_id, produit_id } = req.body;
  client = await User.findOne({ _id: client_id });
  if (!client){
    res.json({
      status: "failed!",
      message: "Le client n'existe pas"
    })
  }
  produit = await Product.findOne({ _id: produit_id });
  if (!produit){
    res.json({
      status: "failed!",
      message: "Ce produit n'existe pas"
    })
  }
  panier = await Panier.findOne({ client_id: client_id });
  if (panier) {
    const itemIndex = panier.produits.findIndex((p) => p._id == produit_id);
    if (itemIndex > -1) {
      panier.produits[itemIndex].quantity++;
      panier.total += produit.price;
      panier.save();
      res.status(200).json({
        message: "quantite updated",
      });
    } else {
      produitss = panier.produits;
      produitss.push({
        _id: produit_id,
        quantity: 1,
      });
      total = panier.total + produit.price;
      await Panier.updateOne({
        client_id: client_id,
        produits: produitss,
        total: total,
      }).then((Panier) => {
        res.status(201).json({
          message: "produit ajoute successfully",
        });
      });
    }
  } else {
    await Panier.create({
      client_id: client_id,
      produits: [
        {
          _id: produit_id,
          quantity: 1,
        },
      ],
      total: produit.price,
      createdAt: new Date(),
    }).then((Panier) => {
      res.status(201).json({
        message: "panier successfully created  and produit added",
        produit: produit,
      });
    });
  }
};

exports.deleteproduitpanier = async (req, res, next) => {
  const { id, idproduit } = req.body;
  produit = await Product.findById(idproduit);

  await Panier.findById(id)
    .then((panier) => {
      const itemIndex = panier.produits.findIndex((p) => p._id == idproduit);
      if (itemIndex > -1) {
        if (panier.produits[itemIndex].quantity > 1) {
          panier.produits[itemIndex].quantity--;
          panier.total -= produit.price;
          panier.save();
          res.status(201).json({ message: "quantite updated", panier });
        } else {
          //panier= removeObjectWithId(panier.produits, idproduit);
          panier.produits.splice(itemIndex, 1);
          panier.total -= produit.price;
          panier.save();
          res
            .status(201)
            .json({ message: "produit successfully deleted", panier });
        }
      } else {
        res.status(401).json({ message: "produit dont existe" });
      }
    })
    .catch((error) =>
      res
        .status(400)
        .json({ message: "An error occurred", error: error.message })
    );
};
exports.deletepanier = async (req, res, next) => {
  const { id } = req.body;
  await Panier.findById(id)
    .then((panier) => panier.remove())
    .then((panier) =>
      res.status(201).json({ message: "panier successfully deleted", panier })
    )
    .catch((error) =>
      res
        .status(400)
        .json({ message: "An error occurred", error: error.message })
    );
};
exports.panierbyuser = async (req, res, next) => {
  Panier.aggregate([
    { $match: { client_id: mongoose.Types.ObjectId(req.query.id) } },

    {
      $unwind: {
        path: "$produits",
      },
    },
    {
      $lookup: {
        from: "products",
        localField: "produits._id",
        foreignField: "_id",
        as: "produits.product",
      },
    },
    {
      $unwind: {
        path: "$produits.product",
      },
    },
    {
      $group: {
        _id: {
          _id: "$_id",
          total: "$total",
          createdAt: "$createdAt",
          client_id: "$client_id",
          state: "$state"
        },

        produits: {
          $push: "$produits",
        },
      },
    },
  ])
    .then((panier) => {
      res.status(200).json(panier);
    })
    .catch((err) =>
      res.status(401).json({ message: "Not successful", error: err.message })
    );
};
exports.listepanier = async (req, res, next) => {
  Panier.aggregate([
    {
      $unwind: {
        path: "$produits",
      },
    },
    {
      $lookup: {
        from: "products",
        localField: "produits._id",
        foreignField: "_id",
        as: "produits.product",
      },
    },
    {
      $unwind: {
        path: "$produits.product",
      },
    },
    {
      $group: {
        _id: {
          _id: "$_id",
          total: "$total",
          createdAt: "$createdAt",
          client_id: "$client_id",
          state: "$state",
          livreur: "$livreur",
        },

        produits: {
          $push: "$produits",
        },

      },
    },
    {
      $lookup: {
        from: "users",
        localField: "_id.client_id",
        foreignField: "_id",
        as: "_id.client",
      },
    },
  ])
    .then((paniers) => {
      res.status(200).json(paniers);
    })
    .catch((err) =>
      res.status(401).json({ message: "Not successful", error: err.message })
    );
};

exports.changeState = (req, res, next) => {
  if (req.body.livreur === '' ){
    return res.status(201).json({
      status: 'failed',
      message: "livreur should not be null"
    })
  }
  else{
  Panier.findById(req.body.id)
    .then((data) => {
      if (data.state === 0) {
        Panier.findByIdAndUpdate(req.body.id, {
          state: 1,
          livreur: req.body.livreur
        }).then((d) =>
          res.send({
            state: 1,
          })
        );
      } else {
        Panier.findByIdAndUpdate(req.body.id, {
          state: 0,
          livreur: null
        }).then((d) =>
          res.send({
            state: 0,
          })
        );
      }
    })
    .catch((err) => {
      if (err.kind === "ObjectId") {
        return res.status(404).send({
          success: false,
          message: "Product not found with id " + req.params.id,
        });
      }
      return res.status(500).send({
        success: false,
        message: "Error retrieving product with id " + req.params.id,
      });
    });
  }
};
