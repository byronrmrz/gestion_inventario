const { DataTypes } = require("sequelize");
const sequelize = require("./db");

const Permission = sequelize.define('Permission', {
    id: {
      type: DataTypes.INTEGER,
      primaryKey: true,
      allowNull: false,
      autoIncrement: true
    },
    rol_id: {
      type: DataTypes.INTEGER, 
      allowNull: false,
      references: {
        model: "rol",
        key: "rol_id",
      }
    },
    accion: {
      type: DataTypes.STRING(50),
      allowNull: false
    }
  }, {
    tableName: 'permissions', 
    timestamps: false
  });
  module.exports = Permission;
  