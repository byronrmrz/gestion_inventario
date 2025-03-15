// const { sequelize } = require("../models/db");
const Permission = require("../models/Permissions");
const { create } = require("../models/Permissions");
const { DataTypes } = require("sequelize");
const sequelize = require("../models/db");
const createPermission = async (req, res) => {
  try {
    const { rol_id, accion } = req.body;

    if (!rol_id || !Array.isArray(accion) || accion.length === 0) {
      return res.status(400).json({ message: "Datos inválidos" });
    }

    // Crear array de permisos para insertar en bulk
    const permisos = accion.map((accion) => ({
      rol_id,
      accion,
    }));

    // Usar bulkCreate para insertar múltiples registros
    await Permission.bulkCreate(permisos);

    return res.status(201).json({ message: "Permisos agregados exitosamente" });
  } catch (error) {
    console.error("Error al crear permisos:", error);
    return res.status(500).json({ message: "Error en el servidor" });
  }
};



const checkPermission = (requiredAction) => {
  return async (req, res, next) => {
    try {
      const { user_id } = req.body; 

      if (!user_id) {
        return res.status(400).json({ message: "User ID is required" });
      }

      const [user] = await sequelize.query(
        "SELECT rol_id FROM user WHERE user_id = ?",
        { replacements: [user_id], type: sequelize.QueryTypes.SELECT }
      );

      if (!user) {
        return res.status(404).json({ message: "User not found" });
      }

      const [permission] = await sequelize.query(
        "SELECT accion FROM permissions WHERE rol_id = ? AND accion = ?",
        { replacements: [user.rol_id, requiredAction], type: sequelize.QueryTypes.SELECT }
      );

      if (!permission) {
        return res.status(403).json({ message: "No tienes permisos para esta acción" });
      }

      next(); 
    } catch (error) {
      console.error("Error en la validación de permisos:", error);
      return res.status(500).json({ message: "Error en el servidor" });
    }
  };
};


module.exports = { createPermission, checkPermission};