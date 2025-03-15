const { DataTypes } = require('sequelize');
const sequelize = require ('./db');

const SalesDetail = sequelize.define('SalesDetail', {
    sales_detail_id:{
        type: DataTypes.INTEGER,
        primaryKey: true,
        allowNull:false,
        autoIncrement: true
    },
    sale_id: {
        type: DataTypes.INTEGER,
        allowNull: false,
        references: {
            model: 'sales',  
            key: 'sale_id'   
        }
    },
    product_id: {
        type: DataTypes.INTEGER,
        allowNull: false,
        references: {
            model: 'product',  
            key: 'product_id'   
        }
    },
    quantity: {
        type: DataTypes.INTEGER,
        allowNull: false
    },
    unitary_price: {
        type: DataTypes.DECIMAL(10,2),
        allowNull: false
    },
    warehouse_id: {
        type: DataTypes.INTEGER,
        allowNull: false,
        references: {
            model: 'warehouse',
            key: 'warehouse_id'
        }
    },
    createdAt:{
        type:Date,
        default:Date.now
    }
    },
    {
        tableName: 'sales_detail', 
        timestamps:false,
    }
);

module.exports = SalesDetail;  //export the model