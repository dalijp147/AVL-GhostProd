const Mongoose = require("mongoose");

// const localDB = `mongodb://localhost:27017/role_auth`; // Uncomment to connect to your local Database

const localDB = "mongodb+srv://AVL:AVL@cluster0.g0nousp.mongodb.net/?retryWrites=true&w=majority";

Mongoose.set("strictQuery", true)

const connectDB = async () => {
  await Mongoose.connect(localDB, {
    useNewUrlParser: true,
    useUnifiedTopology: true,
  })
  .then(() => {
    console.log("MongoDB Connected");
  })
  .catch((error) => {
    console.log(error);
  })
};

module.exports = connectDB;
