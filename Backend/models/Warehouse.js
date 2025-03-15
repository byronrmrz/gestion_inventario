const { DataTypes } = require('sequelize');
const sequelize = require ('./db');

const Warehouse = sequelize.define('Warehouse', {
    warehouse_id:{
        type: DataTypes.INTEGER,
        primaryKey: true,
        allowNull:false,
        autoIncrement: true
        },
    name:{
        type: DataTypes.STRING(50),
        allowNull:false
        },
    location:{
        type: DataTypes.STRING(50),
        allowNull:false
    },
    created_at:{
        type: DataTypes.DATE,
        allowNull:true,
        defaultValue: DataTypes.NOW
    }
    },
        
    {
        tableName: 'warehouse', 
        timestamps:false,
    }   
);

module.exports = Warehouse;  