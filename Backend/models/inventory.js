const { DataTypes } = require('sequelize');
const sequelize = require ('./db');

const Inventory = sequelize.define('Inventory', {
    inventory_id:{
        type: DataTypes.INTEGER,
        primaryKey: true,
        allowNull:false,
        autoIncrement: true
    },
    warehouse_id: {
        type: DataTypes.INTEGER,
        allowNull: false,
        references: {
            model: 'Warehouse',  
            key: 'warehouse_id'   
        }
    },
    product_id:{
        type: DataTypes.INTEGER,
        allowNull:false,
        references: {
            model: 'product',  
            key: 'product_id'   
        }
    },
    quantity:{
        type: DataTypes.INTEGER,
        allowNull: false,
        },
    created_at:{
        type: DataTypes.DATE,
        allowNull:false,
        defaultValue: DataTypes.NOW
        }
    },
    {
        tableName: 'inventory', 
        timestamps:false,
    }
);

module.exports = Inventory;  //export the model