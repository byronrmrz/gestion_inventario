var express = require('express');
var router = express.Router();
// const Stock = require('../models/StockMaster');
const { createProduct, getProducts, deleteProducts, } = require('../controllers/productController'); 
const { createWarehouse, getWarehouse, deleteWarehouse, } = require('../controllers/warehouseController'); 
const { addInventoryItem,getinventory, deleteInventoryItem } = require('../controllers/inventoryController');
const { createRol, getRoles, deleteRol} = require('../controllers/rolController');
const { createUser, getAllUsers, getUserById, updateUser, deleteUser} = require('../controllers/userController');
const { createPermission, checkPermission} = require('../controllers/permissionController');
const { processSale} = require('../controllers/salesDetailController');
const { processPurchase} = require('../controllers/purchaseController');
const { createSupplier} = require('../controllers/supplierController');
const { getInventoryReport } = require("../controllers/getReportController");




const Product = require('../models/Product');
const Warehouse = require('../models/Warehouse');
const Inventory = require('../models/inventory');

//NOTE - EXAMPLE GET
router.get('/', function(req, res, next) {
  res.render('index', { title: 'Express' });
});

//NOTE -  EXAMPLE GET

// router.get('/stock', function(req, res, next) {
//   res.json({ 'Prueba': 'Stock' });
// });

router.get('/stock',async(req, res) => {
  try{
    const StockMaster = await Stock.find();
    res.json(StockMaster);
  }catch{
    res.status(500).json({message: 'Error al obtener los datos'});
  }
});

//NOTE - Endpoints de productos
router.post("/createProduct", checkPermission("GESTIONAR_PRODUCTOS"), createProduct);
router.get("/getProducts", checkPermission("GESTIONAR_PRODUCTOS"), getProducts);
router.delete("/deleteProduct/:product_id", checkPermission("GESTIONAR_PRODUCTOS"), deleteProducts);

//NOTE - Endpoints de almacen
router.post("/createWarehouse", checkPermission("GESTIONAR_ALMACENES"), createWarehouse);
router.get("/getWarehouse", checkPermission("GESTIONAR_ALMACENES"), getWarehouse);
router.delete("/deleteWarehouse/:warehouse_id", checkPermission("GESTIONAR_ALMACENES"), deleteWarehouse);

//NOTE - Endpoints de inventario
router.post("/addInventoryItem", checkPermission("GESTIONAR_INVENTARIO"), addInventoryItem);
router.get("/getInventory", checkPermission("GESTIONAR_INVENTARIO"), getinventory);
router.delete("/deleteInventoryItem/:product_id/:warehouse_id", checkPermission("GESTIONAR_INVENTARIO"), deleteInventoryItem);


//NOTE - Endpoints de roles
router.post('/createRol',checkPermission("GESTIONAR_USUARIOS"), createRol);
router.get('/getRoles',checkPermission("GESTIONAR_USUARIOS"),getRoles);
router.delete('/deleteRol/:rol_id',checkPermission("GESTIONAR_USUARIOS"),deleteRol);

//NOTE - Endpoints de usuarios
router.post("/createUser", checkPermission("GESTIONAR_USUARIOS"), createUser);
router.get("/getAllUsers", checkPermission("GESTIONAR_USUARIOS"), getAllUsers);
router.get("/getUserById/:id", checkPermission("GESTIONAR_USUARIOS"), getUserById);
router.post("/updateUser/:id", checkPermission("GESTIONAR_USUARIOS"), updateUser);
router.delete("/deleteUser/:id", checkPermission("GESTIONAR_USUARIOS"), deleteUser);

//NOTE - Endpoints de permisos
router.post('/createPermission', createPermission);

router.post('/process_Sale', processSale);

router.post('/createSupplier', createSupplier);

router.post('/processPurchase', processPurchase);

router.get("/getInventoryReport", getInventoryReport);


module.exports = router;
