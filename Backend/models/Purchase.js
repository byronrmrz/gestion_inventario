const { DataTypes } = require("sequelize");
const sequelize = require("./db");
// const { supplier_id, user_id, product_id, quantity }
const Purchase = sequelize.define("purchase", {
  purchase_order_id: {
    type: DataTypes.INTEGER,
    primaryKey: true,
    autoIncrement: true,
    allowNull: false,
  },
  warehouse_id:{
    type: DataTypes.INTEGER,
    allowNull: false,
    references:{
        model: "warehouse",
        key: 'warehouse_id'
        }
    },
  supplier_id: {
    type: DataTypes.INTEGER,
    allowNull: false,
    references: {
      model: "supplier",
      key: "supplier_id",
    },
  },
  user_id: {
    type: DataTypes.INTEGER,
    allowNull: false,
    references: {
      model: "user",
      key: "user_id",
    },
  },
  product_id: {
    type: DataTypes.INTEGER,
    allowNull: false,
    references: {
      model: "product",
      key: "product_id",
    },
  },
  quantity: {
    type: DataTypes.INTEGER,
    allowNull: false,
  },
});
module.exports = Purchase;
