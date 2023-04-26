const Pack = require("../model/Pack.js");

exports.pack_create = function (req, res) {
  if (!req.body.title || !req.body.price) {
    return res.status(400).send({
      success: false,
      message: "Please enter pack title price and description",
    });
  }

  let pack = new Pack({
    title: req.body.title,
    price: req.body.price,
    description: req.body.description,
    createdAt: new Date(),
    productList: req.body.productList,
  });

  pack
    .save()
    .then((data) => {
      res.send({
        success: true,
        message: "pack successfully created",
        data: data,
      });
    })
    .catch((err) => {
      res.status(500).send({
        success: false,
        message: err.message || "Some error occurred while creating the pack.",
      });
    });
};

exports.all_packs = (req, res) => {
  Pack.aggregate([
    {
      $unwind: {
        path: "$productList",
      },
    },
    {
      $lookup: {
        from: "products",
        localField: "productList._id",
        foreignField: "_id",
        as: "productList.product",
      },
    },
    {
      $unwind: {
        path: "$productList.product",
      },
    },
    {
      $group: {
        _id: {
          _id: "$_id",
          price: "$price",
          createdAt: "$createdAt",
          description: "$description",
          title: "$title",
        },

        produits: {
          $push: "$productList",
        },
      },
    },
  ])
    .then((data) => {
      var message = "";
      if (data === undefined || data.length == 0) message = "No pack found!";
      else message = "packs successfully retrieved";

      res.send({
        success: true,
        message: message,
        data: data,
      });
    })
    .catch((err) => {
      res.status(500).send({
        success: false,
        message: err.message || "Some error occurred while retrieving packs.",
      });
    });
};

exports.pack_details = (req, res) => {
  Pack.findById(req.params.id)
    .then((data) => {
      if (!data) {
        return res.status(404).send({
          success: false,
          message: "pack not found with id " + req.params.id,
        });
      }
      res.send({
        success: true,
        message: "pack successfully retrieved",
        data: data,
      });
    })
    .catch((err) => {
      if (err.kind === "ObjectId") {
        return res.status(404).send({
          success: false,
          message: "pack not found with id " + req.params.id,
        });
      }
      return res.status(500).send({
        success: false,
        message: "Error retrieving pack with id " + req.params.id,
      });
    });
};

exports.pack_update = (req, res) => {
  if (!req.body.title || !req.body.price) {
    return res.status(400).send({
      success: false,
      message: "Please enter pack title price and description",
    });
  }
  Pack.findByIdAndUpdate(
    req.params.id,
    {
      $set: req.body,
    },
    { new: true }
  )
    .then((data) => {
      if (!data) {
        return res.status(404).send({
          success: false,
          message: "pack not found with id " + req.params.id,
        });
      }
      res.send({
        success: true,
        data: data,
      });
    })
    .catch((err) => {
      if (err.kind === "ObjectId") {
        return res.status(404).send({
          success: false,
          message: "pack not found with id " + req.params.id,
        });
      }
      return res.status(500).send({
        success: false,
        message: "Error updating pack with id " + req.params.id,
      });
    });
};

exports.pack_delete = (req, res) => {
  Pack.findByIdAndRemove(req.params.id)
    .then((data) => {
      if (!data) {
        return res.status(404).send({
          success: false,
          message: "pack not found with id " + req.params.id,
        });
      }
      res.send({
        success: true,
        message: "pack successfully deleted!",
      });
    })
    .catch((err) => {
      if (err.kind === "ObjectId" || err.title === "NotFound") {
        return res.status(404).send({
          success: false,
          message: "pack not found with id " + req.params.id,
        });
      }
      return res.status(500).send({
        success: false,
        message: "Could not delete pack with id " + req.params.id,
      });
    });
};
