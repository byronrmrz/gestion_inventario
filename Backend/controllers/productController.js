const Product = require("../models/Product");
const { create } = require("../models/StockMaster");

const createProduct = async (req, res) => {
  try {
    const { sku, name, description, price } = req.body;

    if (!sku | !name | !description | !price) {
      return res.status(400).json({ message: "Please fill all fields" });
    }
    const product = await Product.create({ sku, name, description, price });
    return res
      .status(201)
      .json({ message: "Product created successfully", product });
  } catch (err) {
    console.error("Error al crear el producto: ", err);
    return res.status(500).json({ error: "Error creating product" });
  }
};

const getProducts = async (req, res) => {
  try {
    const products = await Product.findAll();
    return res.status(200).json(products);
  } catch (error) {
    console.error("error al obtener: ", error);
    return res.status(500).json({ message: "Error al obtener los datos" });
  }
};
const deleteProducts = async (req, res) => {
  console.log("entrando a destruir");

  try {
    const { product_id } = req.params;
    const product = await Product.destroy({ where: { product_id } });
    if (product === 0) {
      console.error("producto no encontrado...");
      return res.status(404).json({ message: "Producto no encontrado" });
    }
    return res.status(200).json({ message: "Product deleted successfully" });
  } catch (error) {
    console.error("error al eliminar: ", error);
    return res.status(500).json({ message: "Error al eliminar el producto" });
  }
};

module.exports = { createProduct, getProducts, deleteProducts };
