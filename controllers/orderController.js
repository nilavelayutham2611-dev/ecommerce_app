const Order =
  require("../models/Order");

const Cart =
  require("../models/Cart");

// PLACE ORDER
const placeOrder =
  async (req, res) => {
    try {

      // Get user cart
      const cartItems =
        await Cart.find({
          user: req.user.id,
        }).populate("product");

      // Check cart empty
      if (
        cartItems.length === 0
      ) {
        return res
          .status(400)
          .json({
            message:
              "Cart is empty",
          });
      }

      // Prepare order items
      const items =
        cartItems.map(item => ({
          product:
            item.product._id,
          quantity:
            item.quantity,
        }));

      // Calculate total
      const totalAmount =
        cartItems.reduce(
          (total, item) =>
            total +
            item.product.price *
              item.quantity,
          0
        );

      // Create order
      const order =
        await Order.create({
          user:
            req.user.id,
          items,
          totalAmount,
        });

      // Clear cart
      await Cart.deleteMany({
        user:
          req.user.id,
      });

      res.status(201).json({
        message:
          "Order placed successfully",
        order,
      });

    } catch (error) {

      console.error(error);

      res.status(500).json({
        message:
          "Server error",
      });
    }
  };

  // GET MY ORDERS
const getOrders =
  async (req, res) => {
    try {

      const orders =
        await Order.find({
          user: req.user.id,
        })
          .populate(
            "items.product"
          )
          .sort({
            createdAt: -1,
          });

      res.status(200).json(
        orders
      );

    } catch (error) {

      console.error(error);

      res.status(500).json({
        message:
          "Server error",
      });
    }
  };

module.exports = {
  placeOrder,getOrders,
};