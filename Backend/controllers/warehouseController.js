const Warehouse = require('../models/Warehouse');
// const { create } = require('../models/StockMaster'); // para MONGO DB, DESCOMENTAR

const createWarehouse = async (req, res) => {
    try{
        const { name, location } = req.body;

        if(!name | !location ){
            return res.status(400).json({message: 'Please fill all fields'})
        }
        const warehouse = await Warehouse.create({ name, location});
        return res.status(201).json({message: 'Warehouse created successfully', warehouse});    
    }catch(err){
        console.error('Error al crear el Almacen: ', err);
        return res.status(500).json({error: 'Error creating warehouse'})

    }
}

const getWarehouse = async (req, res) => {
    try{
        const warehouses = await Warehouse.findAll();
        return res.status(200).json(warehouses);
    
    }catch(error){
        console.error('error al obtener: ', error);
        return res.status(500).json({message: 'Error al obtener los datos'});
    
    }
}
const deleteWarehouse = async (req, res) => {
    console.log('entrando a destruir');

    try{
        const {warehouse_id} = req.params;
        const warehouse = await Warehouse.destroy({where: {warehouse_id}});
        if (warehouse === 0) {
            console.error('Almacen no encontrado...')
            return res.status(404).json({ message: 'Almacen no encontrado' });
        }
        return res.status(200).json({message: 'Warehouse deleted successfully'});
    }catch(error){
        console.error('error al eliminar: ', error);
        return res.status(500).json({message: 'Error al eliminar el Almacen'});
    }
        

}

module.exports = { createWarehouse, getWarehouse, deleteWarehouse};  