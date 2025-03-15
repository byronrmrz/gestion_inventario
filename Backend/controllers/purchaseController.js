const { DataTypes } = require("sequelize");
const sequelize = require("../models/db");

const processPurchase = async (req, res) => {
    try {
    const {
      supplier_id,
      warehouse_id,
      product_id,
      quantity,
      unitary_price,
      order_date,
    } = req.body;

    if (
      !supplier_id ||
      !warehouse_id ||
      !product_id ||
      !quantity ||
      !unitary_price ||
      !order_date
    ) {return res.status(400).json({ message: "Faltan datos obligatorios" });
  }

    // Ejecutar el procedimiento almacenado
    await sequelize.query(
      "CALL process_purchase(:supplier_id, :warehouse_id, :product_id, :quantity, :unitary_price, :order_date, @resultado)",
      {
        replacements: {
          supplier_id,
          warehouse_id,
          product_id,
          quantity,
          unitary_price,
          order_date,
        },
        type: sequelize.QueryTypes.RAW,
      }
    );

    // Obtener el resultado del procedimiento almacenado
    const [[{ resultado }]] = await sequelize.query(
      "SELECT @resultado AS resultado"
    );

    return res.status(201).json({ message: resultado });
  } catch (error) {
    console.error("Error al procesar la compra:", error);
    return res.status(500).json({ message: "Error en el servidor" });
  }
};

module.exports = { processPurchase };
