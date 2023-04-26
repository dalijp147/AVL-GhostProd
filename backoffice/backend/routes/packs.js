const express = require("express");
const router = express.Router();

const pack_controller = require("../controller/Pack");

router.get("/", pack_controller.all_packs);
router.post("/createPack", pack_controller.pack_create);
router.get("/:id", pack_controller.pack_details);
router.put("/update/:id", pack_controller.pack_update);
router.delete("/deletePack/:id", pack_controller.pack_delete);

module.exports = router;
