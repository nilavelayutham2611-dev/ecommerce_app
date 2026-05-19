const Product = require("../models/Product");

// CREATE PRODUCT
const createProduct = async (
  req,
  res
) => {
  try {
    const {
      name,
      description,
      price,
      category,
      image,
      stock,
    } = req.body;

    const product =
      await Product.create({
        name,
        description,
        price,
        category,
        image,
        stock,
      });

    res.status(201).json({
      message:
        "Product created successfully",
      product,
    });

  } catch (error) {
    console.error(error);

    res.status(500).json({
      message: "Server error",
    });
  }
};

// GET ALL PRODUCTS
const getProducts = async (
  req,
  res
) => {
  try {

    const products =
      await Product.find();

    res.status(200).json(
      products
    );

  } catch (error) {

    console.error(error);

    res.status(500).json({
      message: "Server error",
    });
  }
};

// GET SINGLE PRODUCT
const getSingleProduct = async (
  req,
  res
) => {
  try {

    const product =
      await Product.findById(
        req.params.id
      );

    if (!product) {
      return res.status(404).json({
        message: "Product not found",
      });
    }

    res.status(200).json(
      product
    );

  } catch (error) {

    console.error(error);

    res.status(500).json({
      message: "Server error",
    });
  }
};
module.exports = {
  createProduct,
  getProducts,getSingleProduct,
};