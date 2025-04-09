const Sales_Detail = require("../models/Sales_Detail");
const sequelize = require("../models/db");

const processSale = async (req, res) => {
  try {
    const { user_id, product_id, warehouse_id, quantity, unitary_price } =
      req.body;

    if (
      !user_id ||
      !product_id ||
      !warehouse_id ||
      !quantity ||
      !unitary_price
    ) {
      return res.status(400).json({ message: "Faltan datos obligatorios" });
    }

    // Ejecutar el procedimiento almacenado
    await sequelize.query(
      "CALL process_sale(:user_id, :product_id, :warehouse_id, :quantity, :unitary_price, @resultado)",
      {
        replacements: {
          user_id,
          product_id,
          warehouse_id,
          quantity,
          unitary_price,
        },
        type: sequelize.QueryTypes.RAW,
      }
    );

    // Obtener el resultado del procedimiento
    const [[{ resultado }]] = await sequelize.query(
      "SELECT @resultado AS resultado"
    );

    if (resultado !== "Venta procesada correctamente.") {
      return res.status(400).json({ message: resultado });
    }

    return res.status(201).json({ message: resultado });
  } catch (error) {
    console.error("Error al procesar la venta:", error);
    return res.status(500).json({ message: "Error en el servidor" });
  }
};

const salesReport = async (req, res) => {
  try {
    const userId = req.user_id;
    const productosPorUbicacion = await sequelize.query(
      "SELECT * FROM vista_ventas_simuladas",
      {
        type: sequelize.QueryTypes.RAW,
      }
    );

    res.json(productosPorUbicacion);
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: "Error al obtener productos por ubicación" });
  }
};



module.exports = { processSale, salesReport };
