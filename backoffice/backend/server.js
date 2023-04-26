const express = require("express");
const cors = require('cors');
const cookieParser = require("cookie-parser");
const bodyParser = require('body-parser');
const path = require('path');
const connectDB = require("./database");
const app = express();
const {userAuth} = require("./middleware/auth"); // add the authentication middleware to the routes 
const productsRouter = require('./routes/products');
const loginRouter = require('./routes/login');
const userRouter = require('./routes/users');
const feedbackRouter = require('./routes/feedbacks');
const panierRouter = require('./routes/paniers');
const packRouter = require('./routes/packs');
const notificationRouter = require('./routes/notifications');
const commandeRouter = require("./controller/Commande");
const calendarRouter = require("./controller/Calendar");
const PaymentRouter = require('./routes/payment');

app.set("view engine", "ejs");

const port = process.env.PORT;

connectDB();

app.use(
  cors({
      origin: ["http://localhost:5000", "http://10.10.10.10:5000","http://avl.battat.lol:5000"],
      credentials: true,
  })
);
app.use(express.static('build')); // for the built version of react
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({extended: false}));
app.use(cookieParser());
app.use('/uploads', express.static('uploads'));

app.use("/api",loginRouter);
app.use("/api/auth",userRouter);
app.use("/api/feedback",feedbackRouter);
app.use("/api/panier",panierRouter);
app.use("/api/products", productsRouter);
app.use('/api/packs', packRouter);
app.use('/api/notification', notificationRouter);
app.use('/api/calendar',calendarRouter);
app.use('/api/commande',commandeRouter);
app.use('/WebHook',PaymentRouter);

app.get('*', (req,res) => {
  res.sendFile(path.join(__dirname, 'build', 'index.html')); // for the built version of react
});

const server = app.listen(port, () =>
  console.log(`Server listening on port: ${port}`)
);

process.on("unhandledRejection", (err) => {
  console.log(`An error occurred: ${err.message}`);
  server.close(() => process.exit(1));
});
