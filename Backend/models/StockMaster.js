const mongoose = require('mongoose');
const StockMasterSchema = new mongoose.Schema({
    title:{
        type:String,
        required:true
    },
    desciption:{
        type:String,
        required:true
    },
    createdAt:{
        type:Date,
        default:Date.now
    }
    });

    module.exports = mongoose.model('Stock', StockMasterSchema); 