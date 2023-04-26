const Product = require("../model/Product.js");

exports.product_create = function (req, res) {
  if (!req.body.name || !req.body.price) {
    return res.status(400).send({
      success: false,
      message: "You have to give an image, a name and a price",
    });
  } else {
    if (req.body.description) {
      var product = new Product({
        name: req.body.name,
        price: req.body.price,
        quantity: req.body.quantity,
        discount: req.body.discount,
        priceAfterDiscount :req.body.price - (req.body.price * (req.body.discount/100)),
        imageUrl: req.files.map(
          (file) =>
            req.protocol + "://" + req.get("host") + "/uploads/" + file.filename
        ),
        description: req.body.description,
        createdAt: new Date(),
      });
    } else {
      var product = new Product({
        name: req.body.name,
        price: req.body.price,
        quantity: req.body.quantity,
        imageUrl: req.files.map(
          (file) =>
            req.protocol + "://" + req.get("host") + "/uploads/" + file.filename
        ),
        createdAt: new Date(),
      });
    }
  }
  product
    .save()
    .then((data) => {
      res.send({
        success: true,
        message: "Product successfully created",
        data: data,
      });
    })
    .catch((err) => {
      res.status(500).send({
        success: false,
        message:
          err.message || "Some error occurred while creating the product.",
      });
    });
};

exports.all_products = (req, res) => {
  Product.find()
    .then((data) => {
      var message = "";
      if (data === undefined || data.length == 0) message = "No product found!";
      else message = "Products successfully retrieved";

      res.send({
        success: true,
        message: message,
        data: data,
      });
    })
    .catch((err) => {
      res.status(500).send({
        success: false,
        message:
          err.message || "Some error occurred while retrieving products.",
      });
    });
};

exports.product_details = (req, res) => {
  Product.findById(req.params.id)
    .then((data) => {
      if (!data) {
        return res.status(404).send({
          success: false,
          message: "Product not found with id " + req.params.id,
        });
      }
      res.send({
        success: true,
        message: "Product successfully retrieved",
        data: data,
      });
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
};

exports.product_update = (req, res) => {
  if (!req.body.name || !req.body.price) {
    return res.status(400).send({
      success: false,
      message: "Please enter product name and price",
    });
  }
  Product.findById(req.params.id).then(() => {
    if (req.body.description) {
      Product.findByIdAndUpdate(
        req.params.id,
        {
          name: req.body.name,
          price: req.body.price,
          quantity: req.body.quantity,
          imageUrl: req.files.map((file) => req.protocol +"://" +req.get("host") + "/uploads/" + file.filename),
          description: req.body.description,
          createdAt: new Date(),
        },
        { new: true }
      ).then(() => {
        if (req.body.imageUrl) {
          Product.findByIdAndUpdate(req.params.id, {$push: {imageUrl: {$each: req.body.imageUrl.split(',')}}},{upsert: true})
          .then((data) => {
            if (!data) {
              return res.status(404).send({
                success: false,
                message: "Product not found with id " + req.params.id,
              });
            }
            res.send({
              success: true,
              data: data,
            });
          }).catch((err) => {
            if (err.kind === 'ObjectId') {
              return res.status(404).send({
                success: false,
                message: 'Product not found with id ' + req.params.id,
              })
            }
            return res.status(500).send({
              success: false,
              message: 'Error updating product with id ' + req.params.id,
            })
          })
        }
        
      });
    } else {
      Product.findByIdAndUpdate(
        req.params.id,
        {
          name: req.body.name,
          price: req.body.price,
          quantity: req.body.quantity,
          imageUrl: req.files.map((file) => req.protocol +"://" +req.get("host") + "/uploads/" + file.filename),
          description: req.body.description,
          createdAt: new Date(),
        },
        { new: true }
      ).then(() => {
        if (req.body.imageUrl) {
          Product.findByIdAndUpdate(req.params.id, {$push: {imageUrl: {$each: req.body.imageUrl.split(',')}}},{upsert: true})
          .then((data) => {
            if (!data) {
              return res.status(404).send({
                success: false,
                message: "Product not found with id " + req.params.id,
              });
            }
            res.send({
              success: true,
              data: data,
            });
          }).catch((err) => {
            if (err.kind === 'ObjectId') {
              return res.status(404).send({
                success: false,
                message: 'Product not found with id ' + req.params.id,
              })
            }
            return res.status(500).send({
              success: false,
              message: 'Error updating product with id ' + req.params.id,
            })
          })
        } 
      });
    }
  });
};

exports.product_delete = (req, res) => {
  Product.findByIdAndRemove(req.params.id)
    .then((data) => {
      if (!data) {
        return res.status(404).send({
          success: false,
          message: "Product not found with id " + req.params.id,
        });
      }
      res.send({
        success: true,
        message: "Product successfully deleted!",
      });
    })
    .catch((err) => {
      if (err.kind === "ObjectId" || err.name === "NotFound") {
        return res.status(404).send({
          success: false,
          message: "Product not found with id " + req.params.id,
        });
      }
      return res.status(500).send({
        success: false,
        message: "Could not delete product with id " + req.params.id,
      });
    });
};
