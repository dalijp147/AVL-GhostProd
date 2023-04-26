const express = require('express')
const upload = require('../middleware/multer');
const router = express.Router()

const product_controller = require('../controller/Product')

router.get('/', product_controller.all_products)
router.post('/create', upload.array('file'), product_controller.product_create)
router.get('/:id', product_controller.product_details)
router.put('/update/:id', upload.array('file'), product_controller.product_update)
router.delete('/delete/:id', product_controller.product_delete);

module.exports = router
