const User = require("../model/User");

const UserVerification = require("../model/UserVerification");
//email handler
const nodemailer = require("nodemailer");

//unique string

const { v4: uuidv4 } = require("uuid");

const jwtSecret =
  "4715aed3c946f7b0a38e6b534a9583628d84e96d10fbc04700770d572af3dce43625dd";

require("dotenv").config();

const bcrypt = require("bcryptjs");
const jwt = require("jsonwebtoken");
const UserOTPVerification = require("../model/UserOTPVerification");
//email handler

//unique string

// const {v4 : uuidv4} =require('uuid');

require("dotenv").config();

let transporter = nodemailer.createTransport({
  service: "gmail",
  auth: {
    user: process.env.AUTH_EMAIL,
    pass: process.env.EMAIL_APP_PSWD,
  },
});

// test success
transporter.verify((error, success) => {
  if (error) {
    console.log(error);
  } else {
    console.log("ready for messages");
    console.log(success);
  }
});

exports.registerlivreuradmin = async (req, res, next) => {
  if (
    req.body.role === "livreur" ||
    req.body.role === "admin" ||
    req.body.role === "super"
  ) {
    const { username, password, email, role } = req.body;
    if (password.length < 6) {
      return res
        .status(400)
        .json({ message: "Password less than 6 characters" });
    }
    bcrypt.hash(password, 10).then(async (hash) => {
      await User.create({
        username,
        password: hash,
        email,
        role,
        verified: false,
      })
        .then((user) => {
          res.status(200).json({
            message: "User  successful created",
            user: user,
          });
        })
        .catch((error) =>
          res.status(400).json({
            message: "User not successful created",
            error: error.message,
          })
        );
    });
  } else {
    res.json({
      status: "failed",
      message: "not allowed",
    });
  }
};

exports.register = async (req, res, next) => {
  if (req.body.role !== "client") {
    res.json({
      status: "failed",
      message: "not allowed",
    });
  } else {
    const { username, password, email, role } = req.body;
    if (password.length < 6) {
      return res
        .status(400)
        .json({ message: "Password less than 6 characters" });
    }
    bcrypt.hash(password, 10).then(async (hash) => {
      await User.create({
        username,
        password: hash,
        email,
        role,
        verified: false,
      })
        .then((user) => {
          // handle account verification
          sendOTPVerificationEmail(user, res);
        })
        .catch((error) =>
          res.status(400).json({
            message: "User not successful created",
            error: error.message,
          })
        );
    });
  }
};

const sendOTPVerificationEmail = async ({ _id, email }, res) => {
  try {
    const otp = `${Math.floor(1000 + Math.random() * 9000)}`;
    const mailOptions = {
      from: process.env.AUTH_EMAIL,
      to: email,
      subject: "Verify Your Email",
      html: `<p>Enter <b>${otp}</b> in the app to verify your address and complete the registration</p>
    <p>This Code expires in <b>1</b> hour</p>`,
    };

    //hash the otp
    const saltRounds = 10;
    const hashedOTP = await bcrypt.hash(otp, saltRounds);
    const newOTOVerification = await new UserOTPVerification({
      userId: _id,
      otp: hashedOTP,
      createdAt: Date.now(),
      expiresAt: Date.now() + 3600000,
    });
    await newOTOVerification.save();

    transporter.sendMail(mailOptions);
    res.json({
      status: "PENDING",
      message: "verification email sent",
      data: {
        userId: _id,
        email: email,
      },
    });
  } catch (error) {
    res.json({
      status: "FAILED",
      message: error.message,
    });
  }
};
exports.verifyOTP = async (req, res, next) => {
  try {
    let { userId, otp } = req.body;
    if (!userId || !otp) {
      throw Error("Empty otp details are not allowed");
    } else {
      const userOTPVerificationRecords = await UserOTPVerification.find({
        userId,
      });
      if (userOTPVerificationRecords.length <= 0) {
        //no record found
        throw new Error(
          "Account record doesn't exist or has been verified already.Please sign up or log in "
        );
      } else {
        //user otp record exists
        const { expiresAt } = userOTPVerificationRecords[0];
        const hashedOTP = userOTPVerificationRecords[0].otp;
        if (expiresAt < Date.now()) {
          //user otp has expired
          await UserOTPVerification.deleteMany({ userId });
          throw new Error("Code has expired .Please request again");
        } else {
          validOTP = await bcrypt.compare(otp, hashedOTP);
          if (!validOTP) {
            throw new Error("Invalid Code passed , check your Email again");
          } else {
            //success
            await User.updateOne({ _id: userId }, { verified: true });
            UserOTPVerification.deleteMany({ userId });
            res.json({
              status: "VERIFIED",
              message: "User Email Verified Successfully.",
            });
          }
        }
      }
    }
  } catch (error) {
    res.json({
      status: "Failed",
      message: error.message,
    });
  }
};

exports.ResendVerifyOTP = async (req, res, next) => {
  try {
    let { userId, email } = req.body;
    if (!userId || !email) {
      throw Error("Empty user details are not allowed");
    } else {
      await UserOTPVerification.deleteMany({ userId });
      sendOTPVerificationEmail({ _id: userId, email }, res);
    }
  } catch (error) {
    res.json({
      status: "Failed",
      message: error.message,
    });
  }
};

exports.login = async (req, res, next) => {
  const { username, password } = req.body;

  if (!username || !password) {
    return res.status(400).json({
      message: "Username or Password not present",
    });
  }

  try {
    const user = await User.findOne({ username });

    if (!user) {
      res.status(400).json({
        message: "Login not successful",
        error: "User not found",
      });
    } else {
      if (!user.verified) {
        res.status(400).json({
          email: user.email,
          user: user._id,
          status: "FAILED",
          message:
            "you need to verify your account , please check you e-mail. If the verification code resend it",
        });
      } else {
        // comparing given password with hashed password
        await bcrypt.compare(password, user.password).then(function (result) {
          if (result) {
            const maxAge = 12 * 60 * 60;
            const token = jwt.sign(
              { id: user._id, username, email: user.email, role: user.role },
              jwtSecret,
              {
                expiresIn: maxAge, // 3hrs in sec
              }
            );
            res.cookie("jwt", token, {
              httpOnly: true,
              maxAge: maxAge * 1000, // 3hrs in ms
            });
            if (user.role == "client") {
              res.status(200).json({
                message: "client successfully Logged in",
                user: user._id,
                username: user.username,
                email: user.email,
                role: user.role,
                token: token,
              });
            } else if (user.role == "super") {
              res.status(200).json({
                message: "super admin successfully Logged in",
                user: user._id,
                username: user.username,
                email: user.email,
                role: user.role,
                token: token,
              });
            } else if (user.role == "admin") {
              res.status(200).json({
                message: "admin successfully Logged in",
                user: user._id,
                username: user.username,
                email: user.email,
                role: user.role,
                token: token,
              });
            } else if (user.role == "livreur") {
              res.status(200).json({
                message: "livreur successfully Logged in",
                user: user._id,
                username: user.username,
                email: user.email,
                role: user.role,
              });
            }
          } else {
            res.status(400).json({ message: "Login not succesful" });
          }
        });
      }
    }
  } catch (error) {
    res.status(400).json({
      message: "An error occurred",
      error: error.message,
    });
  }
};

exports.changeVerified = async (req, res) => {
  await User.findById(req.body.id)
    .then((data) => {
      if (data.verified === true) {
        User.findByIdAndUpdate(req.body.id, {
          verified: false,
        })
          .then((result) => {
            res.status(201).send(result);
          })
          .catch((err) => {
            res.status(400).send(err);
          });
      } else if (data.verified === false) {
        User.findByIdAndUpdate(req.body.id, {
          verified: true,
        })
          .then((result) => {
            res.status(201).send(result);
          })
          .catch((err) => {
            res.status(400).send(err);
          });
      }
    })
    .catch((error) => {
      res.status(400).send(error);
    });
};

exports.getUsers = async (req, res, next) => {
  await User.find({ role: ["client", "livreur"] })
    .then((users) => {
      res.status(200).send(users);
    })
    .catch((err) => res.status(401).send(err));
};

exports.getLivreurs = (req, res) => {
  User.find({ role: "livreur", commande: null })
    .then((data) => {
      const userFunction = data.map((user) => {
        const container = {};
        container.label = user.username;
        container.value = user.username;
        return container;
      });
      res.status(200).json(userFunction);
    })
    .catch((error) =>
      res.status(400).send({
        error: error,
      })
    );
};

exports.getUsersadmin = async (req, res, next) => {
  await User.find({})
    .then((users) => {
      const userFunction = users
        .filter((user) => user.role == "admin")
        .map((user) => {
          const container = {};
          container.username = user.username;
          container.email = user.email;
          container.id = user._id;
          container.role = user.role;

          return container;
        });
      res.status(200).json({ user: userFunction });
    })
    .catch((err) =>
      res.status(401).json({ message: "Not successful", error: err.message })
    );
};

exports.deleteuser = async (req, res, next) => {
  const { id } = req.body;
  await User.findById(id)
    .then((user) => user.remove())
    .then((user) =>
      res.status(200).json({ message: "user successfully deleted", user })
    )
    .catch((error) =>
      res
        .status(400)
        .json({ message: "An error occurred", error: error.message })
    );
};

exports.blockuser = async (req, res, next) => {
  const { id } = req.body;
  const etatnouv = 1;
  await User.findByIdAndUpdate(id, { etat: etatnouv })
    .then((user) =>
      res.status(200).json({ message: "user successfully blocked", user })
    )
    .catch((error) =>
      res
        .status(400)
        .json({ message: "An error occurred", error: error.message })
    );
};

exports.unblockuser = async (req, res, next) => {
  const { id } = req.body;
  const etatnouv = 0;
  await User.findByIdAndUpdate(id, { etat: etatnouv })
    .then((user) =>
      res.status(200).json({ message: "user successfully blocked", user })
    )
    .catch((error) =>
      res
        .status(400)
        .json({ message: "An error occurred", error: error.message })
    );
};
