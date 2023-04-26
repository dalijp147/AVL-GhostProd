const express = require("express");
const router = express.Router();
const axios = require('axios');

router.post('/WebHookVerification', async (req, res) => {
  try {
    const paymentToken = req.body.token; // assuming the payment token is included in the webhook payload
    const paymentStatus = await checkPaymentStatus(paymentToken);
    if (paymentStatus === true) {
      // handle the payment verification success here
      res.json({
        status: 'ok'
      });
      console.log('done')
    } else {
      // handle the payment verification failure here
      res.status(400).json({
        error: 'Payment verification failed'
      });
    }
  } catch (error) {
    console.error(error);
    // handle any errors that may occur during payment verification
    res.status(500).json({
      error: 'Internal server error'
    });
  }
});

async function checkPaymentStatus(token) {
  console.log(token)
  try {
    const response = await axios.get(`https://sandbox.paymee.tn/api/v1/payments/${token}/check`,{headers:{
      
      Authorization: "Token 5a98a6c3f64c89e684632c44ba3d0628d1410e1e"
    }});
    const paymentStatus = response.data.data.payment_status;
    console.log(paymentStatus)
    return paymentStatus;
  } catch (error) {
    console.error(error);
    throw new Error('Payment verification failed');
  }
}

module.exports = router;
