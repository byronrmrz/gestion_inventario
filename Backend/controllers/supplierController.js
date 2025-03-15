const Supplier = require("../models/Supplier")
const { sequelize } = require("../models/db");

const createSupplier = async (req, res) => {
  try {
    const { name, contact, phone, email } = req.body;
    if (!name || !contact || !phone || !email) {
      return res.status(400).json({ message: "Please fill all fields" });
    }
    const supplier = await Supplier.create({ name, contact, phone, email });
    res
      .status(201)
      .json({ message: "Supplier created successfully", supplier });
  } catch (error) {
    console.error( error);
    res.status(500).json({ message: "Error creating supplier" });
  }
};

module.exports = {createSupplier};
