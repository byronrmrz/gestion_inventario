var express = require('express');
var router = express.Router();
const jwt = require("jsonwebtoken");


const authenticateToken = ( req, res, next ) => {
  const token = req.header('Authorization');
  if (!token) return res.status(401).send('Acceso denegado, no se proporcionó token');
  try {
    const tokenWithoutBearer = token.replace("Bearer","").trim();;
    const verified= jwt.verify(tokenWithoutBearer, process.env.SECRET_KEY);
    req.user = verified;
    next();
  }catch(error){
    console.error('el error: ',error);
    return res.status(403).send('Acceso denegado, token invalido o expirado');
  }
}

// const Stock = require('../models/StockMaster');
const { createProduct, getProducts, deleteProducts,productByUbication } = require('../controllers/productController'); 
const { createWarehouse, getWarehouse, deleteWarehouse, } = require('../controllers/warehouseController'); 
const { addInventoryItem,getinventory, deleteInventoryItem } = require('../controllers/inventoryController');
const { createRol, getRoles, deleteRol} = require('../controllers/rolController');
const { createUser, getAllUsers, getUserById, updateUser, deleteUser} = require('../controllers/userController');
const { createPermission, checkPermission} = require('../controllers/permissionController');
const { processSale, salesReport} = require('../controllers/salesDetailController');
const { processPurchase} = require('../controllers/purchaseController');
const { createSupplier, getSupplier} = require('../controllers/supplierController');
const { getInventoryReport,getSalesReportByYear } = require("../controllers/getReportController");




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
router.post("/createProduct", authenticateToken,checkPermission("GESTIONAR_PRODUCTOS"), createProduct);
router.post("/getProducts", authenticateToken,checkPermission("GESTIONAR_PRODUCTOS"), getProducts);
router.delete("/deleteProduct/:product_id", checkPermission("GESTIONAR_PRODUCTOS"), deleteProducts);
router.post("/productByUbication", checkPermission("GESTIONAR_PRODUCTOS"), productByUbication);


//NOTE - Endpoints de almacen
router.post("/createWarehouse", checkPermission("GESTIONAR_ALMACENES"), createWarehouse);
router.post("/getWarehouse", checkPermission("GESTIONAR_ALMACENES"), getWarehouse);
router.delete("/deleteWarehouse/:warehouse_id", checkPermission("GESTIONAR_ALMACENES"), deleteWarehouse);

//NOTE - Endpoints de inventario
router.post("/addInventoryItem", checkPermission("GESTIONAR_INVENTARIO"), addInventoryItem);
router.post("/getInventory", checkPermission("VER_REPORTES"), getinventory);
router.delete("/deleteInventoryItem/:product_id/:warehouse_id", checkPermission("GESTIONAR_INVENTARIO"), deleteInventoryItem);
router.post("/getInventoryReport", checkPermission("VER_REPORTES"),getInventoryReport);
router.post("/getSalesReportByYear", checkPermission("VER_REPORTES"),getSalesReportByYear);
router.post("/getSalesReportByYear", checkPermission("VER_REPORTES"),getSalesReportByYear);
router.post('/salesReport',checkPermission("VER_REPORTES"), salesReport);

//NOTE - Endpoints de roles
router.post('/createRol',checkPermission("GESTIONAR_USUARIOS"), createRol);
router.get('/getRoles',checkPermission("GESTIONAR_USUARIOS"),getRoles);
router.delete('/deleteRol/:rol_id',checkPermission("GESTIONAR_USUARIOS"),deleteRol);

//NOTE - Endpoints de usuarios
router.post("/createUser", checkPermission("GESTIONAR_USUARIOS"), createUser);
router.post("/getAllUsers", checkPermission("GESTIONAR_USUARIOS"), getAllUsers);
router.get("/getUserById/:id", getUserById);
router.post("/updateUser/:id", checkPermission("GESTIONAR_USUARIOS"), updateUser);
router.delete("/deleteUser/:id", checkPermission("GESTIONAR_USUARIOS"), deleteUser);

//NOTE - Endpoints de permisos
router.post('/createPermission',checkPermission("GESTIONAR_USUARIOS"), createPermission);

//NOTE - Endpoints de Ventas
router.post('/process_Sale',  checkPermission("GESTIONAR_VENTAS"),processSale);


//NOTE - Endpoints de Proveedores
router.post('/createSupplier',checkPermission("GESTIONAR_INVENTARIO"), createSupplier);
router.post('/getSupplier',checkPermission("GESTIONAR_INVENTARIO"), getSupplier);
router.post('/processPurchase',checkPermission("GESTIONAR_INVENTARIO"), processPurchase);

module.exports = router;
