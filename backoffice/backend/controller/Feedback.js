const Feedback = require("../model/Feedback");


exports.addfeedback = async (req, res, next) => {
    const { titre, description } = req.body;
    if (!titre || !description) {
        return res.status(400).json({
          message: "titre or description not present",
        });
      }
    try
    {
        await Feedback.create({
            titre,
            description,
          }).then((Feedback)=>{
            res.status(201).json({
                message: "feedback successfully created",
                titre_id: Feedback._id,
                titre: Feedback.titre,
                description: Feedback.description,
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

exports.updatefeedback = async (req, res, next) => {
    await Feedback.findByIdAndUpdate(req.params.id, req.body, { new: true });

  res.status(200).json({
    description: "Successfully updated feedback data!",
  });
}
exports.getfeedbacks = async (req, res, next) => {
    await Feedback.find({})
    .then((feedbacks) => {
      const feedbackFunction = feedbacks.map((feedback) => {
        const container = {};
        container.titre = feedback.titre;
        container.description = feedback.description;
        container.id = feedback._id;

        return container;
      });
      res.status(200).json({ feedback: feedbackFunction });
    })
    .catch((err) =>
      res.status(401).json({ message: "Not successful", error: err.message })
    );
}
exports.deletefeedback = async (req, res, next) => {
    const { id } = req.body;
    await Feedback.findById(id)
      .then((feedback) => feedback.remove())
      .then((feedback) =>
        res.status(200).json({ message: "feedback successfully deleted", feedback })
      )
      .catch((error) =>
        res
          .status(400)
          .json({ message: "An error occurred", error: error.message })
      );
  };

