const { DataTypes } = require("sequelize");
const sequelize = require("../models/db");
const getInventoryReport = async (req, res) => {
  try {
    const report = await sequelize.query("CALL get_inventory_report()", {
      type: sequelize.QueryTypes.SELECT,
    });

    return res.status(200).json(report);
  } catch (error) {
    console.error("Error al obtener reporte de inventario:", error);
    return res.status(500).json({ message: "Error en el servidor" });
  }
};

module.exports = { getInventoryReport };