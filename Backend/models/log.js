const mongoose = require('../config/database.js');

// Definir el esquema del log
const logSchema = new mongoose.Schema({
  user_id: { type: String, required: true },
  action: { type: String, required: true },
  timestamp: { type: Date, default: Date.now },
});

// Crear el modelo del log
const Log = mongoose.model('Log', logSchema);

module.exports = Log;
