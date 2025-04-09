const User = require("../models/User");
const { create } = require("../models/StockMaster");
const logAction = require('./logAction');


const createUser = async (req, res) => {
  let user_id= req.body.user_id;

  try {
    const { name, email, rol_id } = req.body;
    if (!name || !email || !rol_id) {
      return res.status(400).json({ message: "Please fill all the fields" });
    }
    const user = await User.create({ name, email, rol_id });
    await logAction(user_id, 'Usuario creado');

    res.status(201).json({ message: "User created successfully", user });
  } catch (error) {
    res.status(500).json({ message: "Error creating user", error });
  }
};

const getAllUsers = async (req, res) => {
  let user_id= req.body.user_id;
  try {
    const users = await User.findAll();
    await logAction(user_id, 'Get All Users');

    res.status(200).json(users);
  } catch (error) {
    res.status(500).json({ message: "Error fetching users", error });
  }
};
const getUserById = async (req, res) => {

  try {
    const id = req.params.id;
    const user = await User.findByPk(id);
    if (!user) {
      return res.status(404).json({ message: "User not found" });
    }

    res.status(200).json(user);
  } catch (error) {
    res.status(500).json({ message: "Error fetching user", error });
  }
};
const updateUser = async (req, res) => {
  let user_id= req.body.user_id;

  try {
    const id = req.params.id;
    const { name, email, rol_id } = req.body;
    const user = await User.findByPk(id);
    if (!user) {
      return res.status(404).json({ message: "User not found" });
    }
    user.name = name;
    user.email = email;
    user.rol_id = rol_id;
    await user.save();
    await logAction(user_id, 'Actualizar usuarios');

    res.status(200).json({ message: "User updated successfully", user });
  } catch (error) {
    res.status(500).json({ message: "Error updating user", error });
  }
};
const deleteUser = async (req, res) => {
  let user_id= req.body.user_id;
  try {
    const id = req.params.id;
    const user = await User.findByPk(id);
    if (!user) {
      return res.status(404).json({ message: "User not found" });
    }
    await user.destroy();
    await logAction(user_id, 'Usuario Eliminado');

    res.status(200).json({ message: "User deleted successfully" });
  } catch (error) {
    res.status(500).json({ message: "Error deleting user", error });
  }
};
module.exports = {createUser, getAllUsers, getUserById, updateUser, deleteUser};
