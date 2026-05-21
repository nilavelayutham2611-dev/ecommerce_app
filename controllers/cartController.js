const Cart = require("../models/Cart");

// ADD TO CART
const addToCart = async (
  req,
  res
) => {
  try {

    const {
      productId,
      quantity,
    } = req.body;

    // Check existing cart item
    const existingCart =
      await Cart.findOne({
        user: req.user.id,
        product: productId,
      });

    // If product already exists
    if (existingCart) {

      existingCart.quantity +=
        quantity || 1;

      await existingCart.save();

      return res.status(200).json({
        message:
          "Cart updated",
        cart: existingCart,
      });
    }

    // Create new cart item
    const cart =
      await Cart.create({
        user: req.user.id,
        product: productId,
        quantity:
          quantity || 1,
      });

    res.status(201).json({
      message:
        "Added to cart",
      cart,
    });

  } catch (error) {

    console.error(error);

    res.status(500).json({
      message:
        "Server error",
    });
  }
};

// GET USER CART
const getCart = async (
  req,
  res
) => {
  try {

    const cart =
      await Cart.find({
        user: req.user.id,
      }).populate("product");

    res.status(200).json(
      cart
    );

  } catch (error) {

    console.error(error);

    res.status(500).json({
      message:
        "Server error",
    });
  }
};

// REMOVE CART ITEM
const removeCartItem =
  async (req, res) => {
    try {

      const cart =
        await Cart.findById(
          req.params.id
        );

      if (!cart) {
        return res
          .status(404)
          .json({
            message:
              "Cart item not found",
          });
      }

      // Security check
      if (
        cart.user.toString() !==
        req.user.id
      ) {
        return res
          .status(401)
          .json({
            message:
              "Unauthorized",
          });
      }

      await cart.deleteOne();

      res.status(200).json({
        message:
          "Cart item removed",
      });

    } catch (error) {

      console.error(error);

      res.status(500).json({
        message:
          "Server error",
      });
    }
  };

module.exports = {
  addToCart,getCart,removeCartItem,
};