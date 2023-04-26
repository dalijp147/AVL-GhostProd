const jwt = require("jsonwebtoken");
const jwtSecret = "4715aed3c946f7b0a38e6b534a9583628d84e96d10fbc04700770d572af3dce43625dd";


exports.userAuth=(req, res, next) => {
  try {
    const token = req.headers.authorization.split(' ')[1];
    const decodedToken = jwt.verify(token, jwtSecret);
    const userId = decodedToken.userId;
    if (req.body.userId && req.body.userId !== userId) {
      throw 'Invalid user ID';
    } else {
      next();
    }
  } catch {
    res.status(401).json({
      error: 'Not authorized!'
    });
  }
};
verifyToken=(req,res,next)=>{
    let token=req.headers.authorization

    if(!token){
            res.status(400).json({msg:'access rejected !'})
        }
        try{
            jwt.verify(token,privateKey)
            next()
        }catch(e){
            res.send(400).json({msg:e})
        }
}


