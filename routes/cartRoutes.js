const express =
  require("express");

const router =
  express.Router();

const {addToCart,getCart,removeCartItem,} = require("../controllers/cartController");

const authMiddleware =
  require(
    "../middleware/authMiddleware"
  );
router.post(
  "/",
  authMiddleware,
  addToCart
);
  router.get(
  "/",
  authMiddleware,
  getCart
);
router.delete(
  "/:id",
  authMiddleware,
  removeCartItem
);


module.exports = router;