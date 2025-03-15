const { DataTypes } = require('sequelize');
const sequelize = require ('./db');

const Rol = sequelize.define('Rol', {
    rol_id:{
        type: DataTypes.INTEGER,
        primaryKey: true,
        autoIncrement: true,
        allowNull:false
        },
        name:{
            type: DataTypes.STRING(50),
            allowNull:false,
            unique:true
        }
    },
    {
        tableName: 'rol', 
        timestamps:false,
    }
);

module.exports = Rol; 