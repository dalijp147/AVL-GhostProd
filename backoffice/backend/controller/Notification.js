const Notification = require("../model/Notification");


exports.addNotification = async (req, res, next) => {
    const { titre, description } = req.body;
    if (!titre || !description) {
        return res.status(400).json({
          message: "titre or description not present",
        });
      }
    try
    {
        await Notification.create({
            titre,
            description,
          }).then((Notification)=>{
            res.status(201).json({
                message: "Notification successfully created",
                titre_id: Notification._id,
                titre: Notification.titre,
                description: Notification.description,
              });
          }

          )
    }
    catch (error) {
        res.status(400).json({
          message: "An error occurred",
          error: error.message,
        });
      }

}

exports.updateNotification = async (req, res, next) => {
    await Notification.findByIdAndUpdate(req.params.id, req.body, { new: true });

  res.status(200).json({
    description: "Successfully updated Notification data!",
  });
}
exports.getNotifications = (req, res) => {
  Notification.find()
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
exports.deleteNotification = async (req, res, next) => {
    const { id } = req.body;
    await Notification.findById(id)
      .then((Notification) => Notification.remove())
      .then((Notification) =>
        res.status(200).json({ message: "Notification successfully deleted", Notification })
      )
      .catch((error) =>
        res
          .status(400)
          .json({ message: "An error occurred", error: error.message })
      );
  };

