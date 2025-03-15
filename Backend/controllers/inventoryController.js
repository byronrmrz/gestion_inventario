const sequelize = require("../models/db");
const Inventory = require("../models/inventory");

const { create } = require("../models/StockMaster");

const addInventoryItem = async (req, res) => {
  try {
    const { warehouse_id, product_id, quantity } = req.body;

    if (!warehouse_id | !product_id | !quantity) {
      return res.status(400).json({ message: "Please fill all fields" });
    }
    await sequelize.query(
      "CALL add_or_update_inventory(:warehouse_id, :product_id, :quantity, @resultado)",
      {
        replacements: { warehouse_id, product_id, quantity },
        type: sequelize.QueryTypes.RAW,
      }
    );

    const [[{ resultado }]] = await sequelize.query(
      "SELECT @resultado AS resultado"
    );

    return res.status(201).json({ message: resultado });
  } catch (err) {
    console.error("Error al agregar al inventario: ", err);
    return res.status(500).json({ error: "Error adding to inventory" });
  }
};
const getinventory = async (req, res) => {
  try {
    const inventories = await Inventory.findAll();
    return res.status(200).json(inventories);
  } catch (error) {
    console.error("error al obtener: ", error);
    return res.status(500).json({ message: "Error al obtener los datos" });
  }
};

const deleteInventoryItem = async (req, res) => {
  try {
    const { product_id, warehouse_id } = req.params;

    if (!warehouse_id | !product_id) {
      return res
        .status(400)
        .json({
          message: "Debes proveer un id de producto y un id de almacen",
        });
    }

    await sequelize.query(
      "CALL delete_product_from_inventory(:product_id,:warehouse_id)",
      {
        replacements: { product_id, warehouse_id },
        type: sequelize.QueryTypes.RAW,
      }
    );

    return res
      .status(200)
      .json({ message: "Product removed from inventory succesfully" });
  } catch (error) {
    console.error("error al eliminar: ", error);
    return res
      .status(500)
      .json({ message: "Error al eliminar del inventario" });
  }
};

module.exports = { addInventoryItem, getinventory, deleteInventoryItem };
