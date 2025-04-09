const Log = require('../models/log');

const logAction = async (user_id, action) => {
  try {
    const log = new Log({ user_id, action });
    await log.save();
    console.log('Log guardado exitosamente');
  } catch (error) {
    console.error('Error al guardar el log:', error);
  }
};

module.exports = logAction;
