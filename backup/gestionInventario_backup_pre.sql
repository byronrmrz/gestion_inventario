-- MySQL dump 10.13  Distrib 9.2.0, for macos15.2 (arm64)
--
-- Host: localhost    Database: gestionInventario
-- ------------------------------------------------------
-- Server version	9.2.0

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `inventory`
--

DROP TABLE IF EXISTS `inventory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `inventory` (
  `inventory_id` int NOT NULL AUTO_INCREMENT,
  `product_id` int DEFAULT NULL,
  `warehouse_id` int DEFAULT NULL,
  `quantity` int NOT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`inventory_id`),
  KEY `idx_inventory_product_id` (`product_id`),
  KEY `idx_inventory_warehouse_id` (`warehouse_id`),
  CONSTRAINT `inventory_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`),
  CONSTRAINT `inventory_ibfk_2` FOREIGN KEY (`warehouse_id`) REFERENCES `warehouse` (`warehouse_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inventory`
--

LOCK TABLES `inventory` WRITE;
/*!40000 ALTER TABLE `inventory` DISABLE KEYS */;
INSERT INTO `inventory` VALUES (1,1,1,138,'2025-04-05 22:36:23'),(2,4,1,110,'2025-04-08 00:21:10');
/*!40000 ALTER TABLE `inventory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `permissions`
--

DROP TABLE IF EXISTS `permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `permissions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `rol_id` int DEFAULT NULL,
  `accion` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `rol_id` (`rol_id`),
  CONSTRAINT `permissions_ibfk_1` FOREIGN KEY (`rol_id`) REFERENCES `rol` (`rol_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `permissions`
--

LOCK TABLES `permissions` WRITE;
/*!40000 ALTER TABLE `permissions` DISABLE KEYS */;
INSERT INTO `permissions` VALUES (1,1,'GESTIONAR_USUARIOS'),(2,1,'GESTIONAR_PRODUCTOS'),(3,1,'GESTIONAR_VENTAS'),(4,1,'GESTIONAR_ALMACENES'),(5,1,'GESTIONAR_INVENTARIO'),(6,1,'VER_REPORTES'),(7,2,'GESTIONAR_PRODUCTOS'),(8,2,'GESTIONAR_ALMACENES'),(9,2,'GESTIONAR_INVENTARIO'),(10,3,'GESTIONAR_VENTAS'),(11,4,'VER_REPORTES');
/*!40000 ALTER TABLE `permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product`
--

DROP TABLE IF EXISTS `product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product` (
  `product_id` int NOT NULL AUTO_INCREMENT,
  `sku` varchar(50) NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` text,
  `price` decimal(10,2) NOT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`product_id`),
  UNIQUE KEY `sku` (`sku`),
  KEY `idx_product_id` (`product_id`),
  KEY `idx_product_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product`
--

LOCK TABLES `product` WRITE;
/*!40000 ALTER TABLE `product` DISABLE KEYS */;
INSERT INTO `product` VALUES (1,'p0019','Lavadora','Lg',9500.00,'2025-04-05 22:33:41'),(2,'5908764','Estufa Mabe','Estufa de 6 hornillas',4300.00,'2025-04-07 23:56:23'),(4,'p0998777','mesa','mesa con sillas',789.00,'2025-04-08 00:11:43');
/*!40000 ALTER TABLE `product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_details`
--

DROP TABLE IF EXISTS `product_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_details` (
  `product_id` int NOT NULL,
  `description` text,
  PRIMARY KEY (`product_id`),
  CONSTRAINT `product_details_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_details`
--

LOCK TABLES `product_details` WRITE;
/*!40000 ALTER TABLE `product_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `product_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `purchase_order`
--

DROP TABLE IF EXISTS `purchase_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `purchase_order` (
  `purchase_order_id` int NOT NULL AUTO_INCREMENT,
  `supplier_id` int DEFAULT NULL,
  `warehouse_id` int DEFAULT NULL,
  `order_date` datetime NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `total` decimal(10,2) NOT NULL,
  PRIMARY KEY (`purchase_order_id`),
  KEY `supplier_id` (`supplier_id`),
  KEY `warehouse_id` (`warehouse_id`),
  CONSTRAINT `purchase_order_ibfk_1` FOREIGN KEY (`supplier_id`) REFERENCES `supplier` (`supplier_id`),
  CONSTRAINT `purchase_order_ibfk_2` FOREIGN KEY (`warehouse_id`) REFERENCES `warehouse` (`warehouse_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `purchase_order`
--

LOCK TABLES `purchase_order` WRITE;
/*!40000 ALTER TABLE `purchase_order` DISABLE KEYS */;
INSERT INTO `purchase_order` VALUES (1,1,1,'2024-03-12 10:30:00','2025-04-05 22:37:48',0.00),(2,1,1,'2024-03-12 10:30:00','2025-04-05 22:43:51',0.00),(3,1,1,'2024-03-12 10:30:00','2025-04-05 22:46:56',950000.00),(4,1,1,'2024-03-12 10:30:00','2025-04-08 00:15:51',950000.00),(5,1,1,'2024-03-12 10:30:00','2025-04-08 00:17:00',950000.00),(6,1,1,'2025-04-07 18:20:00','2025-04-08 00:21:10',7890.00),(7,1,1,'2025-04-07 18:22:00','2025-04-08 00:23:06',78900.00);
/*!40000 ALTER TABLE `purchase_order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `purchase_order_item`
--

DROP TABLE IF EXISTS `purchase_order_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `purchase_order_item` (
  `purchase_order_item_id` int NOT NULL AUTO_INCREMENT,
  `purchase_order_id` int DEFAULT NULL,
  `product_id` int DEFAULT NULL,
  `quantity` int NOT NULL,
  `unitary_price` int NOT NULL,
  PRIMARY KEY (`purchase_order_item_id`),
  KEY `purchase_order_id` (`purchase_order_id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `purchase_order_item_ibfk_1` FOREIGN KEY (`purchase_order_id`) REFERENCES `purchase_order` (`purchase_order_id`),
  CONSTRAINT `purchase_order_item_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `purchase_order_item`
--

LOCK TABLES `purchase_order_item` WRITE;
/*!40000 ALTER TABLE `purchase_order_item` DISABLE KEYS */;
INSERT INTO `purchase_order_item` VALUES (1,3,1,100,9500),(2,4,1,100,9500),(3,5,1,100,9500),(4,6,4,10,789),(5,7,4,100,789);
/*!40000 ALTER TABLE `purchase_order_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rol`
--

DROP TABLE IF EXISTS `rol`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rol` (
  `rol_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`rol_id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rol`
--

LOCK TABLES `rol` WRITE;
/*!40000 ALTER TABLE `rol` DISABLE KEYS */;
INSERT INTO `rol` VALUES (1,'UA'),(4,'UAD'),(2,'UO'),(3,'UV');
/*!40000 ALTER TABLE `rol` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sales`
--

DROP TABLE IF EXISTS `sales`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sales` (
  `sale_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `date` datetime NOT NULL,
  `total` decimal(10,2) NOT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`sale_id`),
  KEY `user_id` (`user_id`),
  KEY `idx_sales_id` (`sale_id`),
  KEY `idx_sales_date` (`date`),
  CONSTRAINT `sales_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sales`
--

LOCK TABLES `sales` WRITE;
/*!40000 ALTER TABLE `sales` DISABLE KEYS */;
INSERT INTO `sales` VALUES (1,3,'2023-04-05 22:47:33',950000.00,'2025-04-05 22:47:33'),(2,3,'2023-04-05 22:49:39',95000.00,'2025-04-05 22:49:39'),(3,3,'2023-04-05 22:49:42',95000.00,'2025-04-05 22:49:42'),(4,3,'2024-04-05 22:49:43',95000.00,'2025-04-05 22:49:43'),(5,3,'2024-04-05 22:49:45',95000.00,'2025-04-05 22:49:45'),(6,3,'2024-04-05 22:49:46',95000.00,'2025-04-05 22:49:46'),(7,3,'2025-04-05 22:49:46',95000.00,'2025-04-05 22:49:46'),(8,3,'2025-04-05 22:49:47',95000.00,'2025-04-05 22:49:47'),(9,3,'2025-04-05 22:50:57',95000.00,'2025-04-05 22:50:57'),(10,4,'2025-04-08 00:32:56',95000.00,'2025-04-08 00:32:56'),(11,4,'2025-04-08 00:33:46',950000.00,'2025-04-08 00:33:46'),(12,10,'2025-04-08 23:31:16',95000.00,'2025-04-08 23:31:16'),(13,10,'2025-04-08 23:31:35',9000.00,'2025-04-08 23:31:35'),(14,10,'2025-04-08 23:33:41',9000.00,'2025-04-08 23:33:41'),(15,10,'2025-04-08 23:34:21',80000.00,'2025-04-08 23:34:21');
/*!40000 ALTER TABLE `sales` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sales_2023`
--

DROP TABLE IF EXISTS `sales_2023`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sales_2023` (
  `sale_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `date` datetime NOT NULL,
  `total` decimal(10,2) NOT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`sale_id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sales_2023`
--

LOCK TABLES `sales_2023` WRITE;
/*!40000 ALTER TABLE `sales_2023` DISABLE KEYS */;
INSERT INTO `sales_2023` VALUES (1,3,'2023-04-05 22:47:33',950000.00,'2025-04-05 22:47:33'),(2,3,'2023-04-05 22:49:39',95000.00,'2025-04-05 22:49:39'),(3,3,'2023-04-05 22:49:42',95000.00,'2025-04-05 22:49:42');
/*!40000 ALTER TABLE `sales_2023` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sales_2024`
--

DROP TABLE IF EXISTS `sales_2024`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sales_2024` (
  `sale_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `date` datetime NOT NULL,
  `total` decimal(10,2) NOT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`sale_id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sales_2024`
--

LOCK TABLES `sales_2024` WRITE;
/*!40000 ALTER TABLE `sales_2024` DISABLE KEYS */;
INSERT INTO `sales_2024` VALUES (4,3,'2024-04-05 22:49:43',95000.00,'2025-04-05 22:49:43'),(5,3,'2024-04-05 22:49:45',95000.00,'2025-04-05 22:49:45'),(6,3,'2024-04-05 22:49:46',95000.00,'2025-04-05 22:49:46');
/*!40000 ALTER TABLE `sales_2024` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sales_2025`
--

DROP TABLE IF EXISTS `sales_2025`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sales_2025` (
  `sale_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `date` datetime NOT NULL,
  `total` decimal(10,2) NOT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`sale_id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sales_2025`
--

LOCK TABLES `sales_2025` WRITE;
/*!40000 ALTER TABLE `sales_2025` DISABLE KEYS */;
INSERT INTO `sales_2025` VALUES (7,3,'2025-04-05 22:49:46',95000.00,'2025-04-05 22:49:46'),(8,3,'2025-04-05 22:49:47',95000.00,'2025-04-05 22:49:47'),(9,3,'2025-04-05 22:50:57',95000.00,'2025-04-05 22:50:57');
/*!40000 ALTER TABLE `sales_2025` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sales_detail`
--

DROP TABLE IF EXISTS `sales_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sales_detail` (
  `sales_detail_id` int NOT NULL AUTO_INCREMENT,
  `sale_id` int DEFAULT NULL,
  `product_id` int DEFAULT NULL,
  `quantity` int NOT NULL,
  `warehouse_id` int DEFAULT NULL,
  `unitary_price` decimal(10,2) NOT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`sales_detail_id`),
  KEY `warehouse_id` (`warehouse_id`),
  KEY `idx_sales_detail_sale_id` (`sale_id`),
  KEY `idx_sales_detail_product_id` (`product_id`),
  CONSTRAINT `sales_detail_ibfk_1` FOREIGN KEY (`sale_id`) REFERENCES `sales` (`sale_id`),
  CONSTRAINT `sales_detail_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`),
  CONSTRAINT `sales_detail_ibfk_3` FOREIGN KEY (`warehouse_id`) REFERENCES `warehouse` (`warehouse_id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sales_detail`
--

LOCK TABLES `sales_detail` WRITE;
/*!40000 ALTER TABLE `sales_detail` DISABLE KEYS */;
INSERT INTO `sales_detail` VALUES (1,1,1,100,1,9500.00,'2025-04-05 22:47:33'),(2,2,1,10,1,9500.00,'2025-04-05 22:49:39'),(3,3,1,10,1,9500.00,'2025-04-05 22:49:42'),(4,4,1,10,1,9500.00,'2025-04-05 22:49:43'),(5,5,1,10,1,9500.00,'2025-04-05 22:49:45'),(6,6,1,10,1,9500.00,'2025-04-05 22:49:46'),(7,7,1,10,1,9500.00,'2025-04-05 22:49:46'),(8,8,1,10,1,9500.00,'2025-04-05 22:49:47'),(9,9,1,10,1,9500.00,'2025-04-05 22:50:57'),(10,10,1,10,1,9500.00,'2025-04-08 00:32:56'),(11,11,1,100,1,9500.00,'2025-04-08 00:33:46'),(12,12,1,10,1,9500.00,'2025-04-08 23:31:16'),(13,13,1,1,1,9000.00,'2025-04-08 23:31:35'),(14,14,1,1,1,9000.00,'2025-04-08 23:33:41'),(15,15,1,10,1,8000.00,'2025-04-08 23:34:21');
/*!40000 ALTER TABLE `sales_detail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sales_extra_info`
--

DROP TABLE IF EXISTS `sales_extra_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sales_extra_info` (
  `sale_id` int NOT NULL,
  `payment_method` varchar(50) NOT NULL,
  `discount` decimal(10,2) DEFAULT '0.00',
  `notes` text,
  PRIMARY KEY (`sale_id`),
  CONSTRAINT `sales_extra_info_ibfk_1` FOREIGN KEY (`sale_id`) REFERENCES `sales` (`sale_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sales_extra_info`
--

LOCK TABLES `sales_extra_info` WRITE;
/*!40000 ALTER TABLE `sales_extra_info` DISABLE KEYS */;
/*!40000 ALTER TABLE `sales_extra_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `supplier`
--

DROP TABLE IF EXISTS `supplier`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `supplier` (
  `supplier_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `contact_person` varchar(100) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`supplier_id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `supplier`
--

LOCK TABLES `supplier` WRITE;
/*!40000 ALTER TABLE `supplier` DISABLE KEYS */;
INSERT INTO `supplier` VALUES (1,'Proveedor Tech',NULL,'555-1234','proveedor@example.com',NULL,'2025-04-05 22:37:26'),(2,'La curacao',NULL,'55555555','mynor@curacao.com',NULL,'2025-04-08 00:46:39'),(3,'Mayoristas de proveedores',NULL,'5555558','ali@mayo.com',NULL,'2025-04-08 00:49:10'),(4,'juan',NULL,'44','juan@gmail.com',NULL,'2025-04-08 00:51:22'),(5,'juanr',NULL,'444','juan4@gmail.com',NULL,'2025-04-08 00:51:48'),(6,'La mañosa','lidia gomez','55430198','lamaniosa@minit.com',NULL,'2025-04-08 00:54:34'),(8,'La mañosas','lidia gomezs','554301984','lamanisosa@minit.com',NULL,'2025-04-08 00:55:40');
/*!40000 ALTER TABLE `supplier` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `rol_id` int DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `password` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `email` (`email`),
  KEY `rol_id` (`rol_id`),
  CONSTRAINT `user_ibfk_1` FOREIGN KEY (`rol_id`) REFERENCES `rol` (`rol_id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (3,'Niddian Gómez','niddian@galileo.com',4,'2025-04-05 22:14:06','12345'),(4,'Byron Ramírez','byron@galileo.com',1,'2025-04-07 01:32:46','$2b$10$vnboyFQUleprs8PgWtTAruL77s3hsbGUKCEhKvRo8kbwKR3o91Eza'),(10,'Juan Gómez','Juan@ejemplo.com',3,'2025-04-07 23:21:59','$2b$10$kURHrzcsmuAJD9qjGfTmbuqvH9pV0szW6AE0QIscnfWnrVdlT1qZi'),(16,'Erick Ruiz','erick@galileo.com',4,'2025-04-08 21:46:47','$2b$10$GdWQMIns8C56.UjgMTqkj.gnOvBbtrk7H.p/GiVU1xTb19xU3CR/6'),(17,'Judith Gonzalez','judith@galileo.com',2,'2025-04-08 23:36:22','$2b$10$MCl0HSgteifwLfyCiluRH.v2ubHif1Qb.kTGTZ9VFS5sWXAn5Fi4C');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `vista_inventario_general`
--

DROP TABLE IF EXISTS `vista_inventario_general`;
/*!50001 DROP VIEW IF EXISTS `vista_inventario_general`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vista_inventario_general` AS SELECT 
 1 AS `Codigo`,
 1 AS `Nombre`,
 1 AS `Stock_Actual`,
 1 AS `Precio_Unitario`,
 1 AS `Valor_Total`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vista_productos_por_ubicacion`
--

DROP TABLE IF EXISTS `vista_productos_por_ubicacion`;
/*!50001 DROP VIEW IF EXISTS `vista_productos_por_ubicacion`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vista_productos_por_ubicacion` AS SELECT 
 1 AS `ID_Almacen`,
 1 AS `Nombre_Almacen`,
 1 AS `Ubicacion`,
 1 AS `Codigo_Producto`,
 1 AS `Nombre_Producto`,
 1 AS `Cantidad`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vista_ventas_simuladas`
--

DROP TABLE IF EXISTS `vista_ventas_simuladas`;
/*!50001 DROP VIEW IF EXISTS `vista_ventas_simuladas`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vista_ventas_simuladas` AS SELECT 
 1 AS `ID_Venta`,
 1 AS `Codigo_Producto`,
 1 AS `Nombre_Producto`,
 1 AS `Cantidad`,
 1 AS `Fecha_Venta`,
 1 AS `Valor_Total`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `warehouse`
--

DROP TABLE IF EXISTS `warehouse`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `warehouse` (
  `warehouse_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `location` varchar(255) NOT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`warehouse_id`),
  KEY `idx_warehouse_id` (`warehouse_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `warehouse`
--

LOCK TABLES `warehouse` WRITE;
/*!40000 ALTER TABLE `warehouse` DISABLE KEYS */;
INSERT INTO `warehouse` VALUES (1,'Bodega Norte','Flores, Peten','2025-04-05 22:35:22'),(2,'Bodega Central','Ciudad de Guatemala','2025-04-08 01:15:08'),(3,'Bodega Sur','Escuintla','2025-04-08 01:16:37');
/*!40000 ALTER TABLE `warehouse` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Final view structure for view `vista_inventario_general`
--

/*!50001 DROP VIEW IF EXISTS `vista_inventario_general`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vista_inventario_general` AS select `p`.`product_id` AS `Codigo`,`p`.`name` AS `Nombre`,sum(`i`.`quantity`) AS `Stock_Actual`,`p`.`price` AS `Precio_Unitario`,(sum(`i`.`quantity`) * `p`.`price`) AS `Valor_Total` from (`product` `p` left join `inventory` `i` on((`p`.`product_id` = `i`.`product_id`))) group by `p`.`product_id`,`p`.`name`,`p`.`price` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vista_productos_por_ubicacion`
--

/*!50001 DROP VIEW IF EXISTS `vista_productos_por_ubicacion`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vista_productos_por_ubicacion` AS select `w`.`warehouse_id` AS `ID_Almacen`,`w`.`name` AS `Nombre_Almacen`,`w`.`location` AS `Ubicacion`,`p`.`product_id` AS `Codigo_Producto`,`p`.`name` AS `Nombre_Producto`,`i`.`quantity` AS `Cantidad` from ((`inventory` `i` join `warehouse` `w` on((`i`.`warehouse_id` = `w`.`warehouse_id`))) join `product` `p` on((`i`.`product_id` = `p`.`product_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vista_ventas_simuladas`
--

/*!50001 DROP VIEW IF EXISTS `vista_ventas_simuladas`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vista_ventas_simuladas` AS select `s`.`sale_id` AS `ID_Venta`,`sd`.`product_id` AS `Codigo_Producto`,`p`.`name` AS `Nombre_Producto`,`sd`.`quantity` AS `Cantidad`,`s`.`date` AS `Fecha_Venta`,(`sd`.`quantity` * `sd`.`unitary_price`) AS `Valor_Total` from ((`sales` `s` join `sales_detail` `sd` on((`s`.`sale_id` = `sd`.`sale_id`))) join `product` `p` on((`sd`.`product_id` = `p`.`product_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-04-08 19:16:07
