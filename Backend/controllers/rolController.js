const Rol = require('../models/rol');
const { create } = require('../models/StockMaster');

const createRol = async (req, res) => {
    try{
        const { name} = req.body;

        if(!name ){
            return res.status(400).json({message: 'Please fill all fields'})
        }
        const rol = await Rol.create({name});
        return res.status(201).json({message: 'Role created successfully', rol});    
    }catch(err){
        console.error('Error al crear el rol: ', err);
        return res.status(500).json({error: 'Error creating role'})

    }
}

const getRoles = async (req, res) => {
    try{
        const rol = await Rol.findAll();
        return res.status(200).json(rol);
    
    }catch(error){
        console.error('error al obtener: ', error);
        return res.status(500).json({message: 'Error al obtener los datos'});
    
    }
}
const deleteRol = async (req, res) => {
    console.log('entrando a destruir');

    try{
        const {rol_id} = req.params;
        const rol = await Rol.destroy({where: {rol_id}});
        if (rol === 0) {
            console.error('Rol no encontrado...')
            return res.status(404).json({ message: 'Rol no encontrado' });
        }
        return res.status(200).json({message: 'Rol deleted successfully'});
    }catch(error){
        console.error('error al eliminar: ', error);
        return res.status(500).json({message: 'Error al eliminar el rol'});
    }
        

}

module.exports = { createRol, getRoles, deleteRol};  