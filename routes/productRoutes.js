const express = require("express");

const router = express.Router();

const {
  createProduct,getProducts,getSingleProduct,
} = require(
  "../controllers/productController"
);

router.post(
  "/",
  createProduct
);

router.get(
  "/",
  getProducts
);

router.get(
  "/:id",
  getSingleProduct
);

module.exports = router;