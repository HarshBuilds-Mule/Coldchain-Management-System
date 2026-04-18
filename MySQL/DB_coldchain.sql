CREATE DATABASE  IF NOT EXISTS `coldchain` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `coldchain`;
-- MySQL dump 10.13  Distrib 8.0.43, for Win64 (x86_64)
--
-- Host: localhost    Database: coldchain
-- ------------------------------------------------------
-- Server version	8.0.43

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `alerts`
--

DROP TABLE IF EXISTS `alerts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `alerts` (
  `id` int NOT NULL AUTO_INCREMENT,
  `shipment_id` int NOT NULL,
  `status` enum('temp_high','temp_low','sensor_offline') DEFAULT NULL,
  `message` text,
  `alerted_at` datetime DEFAULT NULL,
  `resolved` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `shipment_id` (`shipment_id`),
  CONSTRAINT `alerts_ibfk_1` FOREIGN KEY (`shipment_id`) REFERENCES `shipments` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alerts`
--

LOCK TABLES `alerts` WRITE;
/*!40000 ALTER TABLE `alerts` DISABLE KEYS */;
INSERT INTO `alerts` VALUES (1,1,'temp_high','Temperature reached 7.0°C which exceeds threshold.','2025-07-15 10:35:00',0),(4,1,'temp_high','Temperature crossed 8°C','2025-07-16 17:00:00',0),(5,1,'temp_low','Temperature is higher than threshold.9.25','2023-10-23 16:10:00',0),(6,1,'temp_low','Temperature is higher than threshold.9.25','2023-10-23 16:10:00',0),(7,1,'temp_low','Temperature reached is lower than threshold.','2023-10-23 15:50:00',0),(11,1001,'temp_low','Temperature reached 22.5 higher than threshold.','2025-08-08 04:01:00',1),(12,1001,'temp_low','Temperature reached 22.5 higher than threshold.','2025-08-08 04:01:00',1),(13,1001,'temp_low','Temperature reached 22.5 higher than threshold.','2025-08-08 04:01:00',1),(14,1003,'temp_low','Temperature reached 21.8 higher than threshold.','2025-08-07 22:37:00',0),(15,1004,'temp_low','Temperature reached 22.2 higher than threshold.','2025-08-07 22:41:00',0),(16,1007,'temp_low','Temperature reached 22 higher than threshold.','2025-08-07 22:50:00',0),(17,1008,'temp_low','Temperature reached 21.5 higher than threshold.','2025-08-07 22:53:00',0),(18,1010,'temp_low','Temperature reached 22.8 higher than threshold.','2025-08-07 23:00:00',1);
/*!40000 ALTER TABLE `alerts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `messages`
--

DROP TABLE IF EXISTS `messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `messages` (
  `id` int NOT NULL AUTO_INCREMENT,
  `fullName` varchar(30) DEFAULT NULL,
  `email` varchar(30) DEFAULT NULL,
  `subject` varchar(100) DEFAULT NULL,
  `matter` varchar(1000) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `messages`
--

LOCK TABLES `messages` WRITE;
/*!40000 ALTER TABLE `messages` DISABLE KEYS */;
INSERT INTO `messages` VALUES (1,'Donut lord','randomdonut@gmail.com','testing','testing'),(2,'Doom','DoomCop@gmail.com','DoomsDay','Lol'),(3,'Doom','DoomCop@gmail.com','DoomsDay','Lol'),(4,'Doom','DoomCop@gmail.com','DoomsDay','Lol'),(5,'Donald','donald@gmail.com','test','select * from messages;'),(6,'Donald','donald@gmail.com','test','donald is great'),(7,'amiya','amiya@gmail.com','Testing','Testing');
/*!40000 ALTER TABLE `messages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `resetpass`
--

DROP TABLE IF EXISTS `resetpass`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `resetpass` (
  `email` varchar(255) DEFAULT NULL,
  `status` varchar(10) DEFAULT NULL,
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `resetpass`
--

LOCK TABLES `resetpass` WRITE;
/*!40000 ALTER TABLE `resetpass` DISABLE KEYS */;
INSERT INTO `resetpass` VALUES ('resetexample@gmail.com','Unresolved'),('resetexample2@gmail.com','Unresolved'),('alice@example.com','Unresolved');
/*!40000 ALTER TABLE `resetpass` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shipments`
--

DROP TABLE IF EXISTS `shipments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `shipments` (
  `id` int NOT NULL AUTO_INCREMENT,
  `shipment_code` varchar(50) NOT NULL,
  `origin` varchar(100) DEFAULT NULL,
  `destination` varchar(100) DEFAULT NULL,
  `status` enum('in_transit','delivered','delayed','cancelled') DEFAULT 'in_transit',
  `start_time` datetime NOT NULL,
  `end_time` datetime DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `shipment_code` (`shipment_code`)
) ENGINE=InnoDB AUTO_INCREMENT=1011 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shipments`
--

LOCK TABLES `shipments` WRITE;
/*!40000 ALTER TABLE `shipments` DISABLE KEYS */;
INSERT INTO `shipments` VALUES (1,'SHIP001','Delhi','Mumbai','delayed','2025-07-15 08:00:00',NULL,'2025-07-23 16:26:23'),(2,'SHIP002','Hyderabad','Bangalore','delivered','2025-07-12 09:30:00','2025-07-13 14:00:00','2025-07-23 16:26:23'),(4,'SHIP12345','Madhya Pradesh','Jabalpur','in_transit','2025-07-24 10:30:00',NULL,'2025-07-24 16:40:19'),(1001,'SHIP1001','Delhi','Mumbai','in_transit','2025-08-07 08:00:00',NULL,'2025-08-08 10:12:45'),(1002,'SHIP1002','Hyderabad','Bangalore','delivered','2025-08-06 09:30:00','2025-08-07 14:00:00','2025-08-08 10:12:45'),(1003,'SHIP1003','Kolkata','Chennai','in_transit','2025-08-05 10:15:00',NULL,'2025-08-08 10:12:45'),(1004,'SHIP1004','Pune','Ahmedabad','delayed','2025-08-04 07:45:00',NULL,'2025-08-08 10:12:45'),(1005,'SHIP1005','Lucknow','Patna','in_transit','2025-08-03 08:20:00',NULL,'2025-08-08 10:12:45'),(1006,'SHIP1006','Bhopal','Nagpur','delivered','2025-08-02 06:50:00','2025-08-03 18:00:00','2025-08-08 10:12:45'),(1007,'SHIP1007','Jaipur','Surat','in_transit','2025-08-01 12:00:00',NULL,'2025-08-08 10:12:45'),(1008,'SHIP1008','Chandigarh','Ludhiana','delivered','2025-07-31 15:10:00','2025-08-01 17:30:00','2025-08-08 10:12:45'),(1009,'SHIP1009','Visakhapatnam','Raipur','in_transit','2025-07-30 10:00:00',NULL,'2025-08-08 10:12:45'),(1010,'SHIP1010','Ranchi','Guwahati','delayed','2025-07-29 09:40:00',NULL,'2025-08-08 10:12:45');
/*!40000 ALTER TABLE `shipments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `temperature_logs`
--

DROP TABLE IF EXISTS `temperature_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `temperature_logs` (
  `id` int NOT NULL AUTO_INCREMENT,
  `shipment_id` int NOT NULL,
  `temperature` decimal(5,2) DEFAULT NULL,
  `recorded_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `shipment_id` (`shipment_id`),
  CONSTRAINT `temperature_logs_ibfk_1` FOREIGN KEY (`shipment_id`) REFERENCES `shipments` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `temperature_logs`
--

LOCK TABLES `temperature_logs` WRITE;
/*!40000 ALTER TABLE `temperature_logs` DISABLE KEYS */;
INSERT INTO `temperature_logs` VALUES (1,1,4.50,'2025-07-15 08:30:00'),(2,1,5.20,'2025-07-15 09:30:00'),(3,1,7.00,'2025-07-15 10:30:00'),(4,2,3.00,'2025-07-12 10:00:00'),(5,2,2.80,'2025-07-12 12:00:00'),(7,1,3.25,'2023-10-23 15:30:00'),(8,1,3.25,'2023-10-23 15:30:00'),(9,1,3.25,'2023-10-23 15:30:00'),(10,1,7.25,'2023-10-23 16:10:00'),(11,1,7.25,'2023-10-23 16:10:00'),(12,1,7.25,'2023-10-23 16:10:00'),(13,1,9.25,'2023-10-23 16:10:00'),(14,1,9.25,'2023-10-23 16:10:00'),(15,1,9.25,'2023-10-23 16:10:00'),(16,1,9.25,'2023-10-23 16:10:00'),(17,1,9.25,'2023-10-23 16:10:00'),(18,1,1.25,'2023-10-23 15:50:00'),(19,4,6.28,'2023-10-23 15:55:00'),(30,1001,22.50,'2025-08-07 22:31:00'),(31,1002,6.00,'2025-08-07 22:35:00'),(32,1003,21.80,'2025-08-07 22:37:00'),(33,1004,22.20,'2025-08-07 22:41:00'),(34,1005,6.00,'2025-08-07 22:44:00'),(35,1006,6.00,'2025-08-07 22:47:00'),(36,1007,22.00,'2025-08-07 22:50:00'),(37,1008,21.50,'2025-08-07 22:53:00'),(38,1009,6.00,'2025-08-07 22:57:00'),(39,1010,22.80,'2025-08-07 23:00:00');
/*!40000 ALTER TABLE `temperature_logs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `fullname` char(20) DEFAULT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('admin','viewer') DEFAULT 'viewer',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'adam marakov','admin@coldchain.com','hashedpassword1','admin','2025-07-23 16:25:58'),(2,'venus trap','viewer@coldchain.com','hashedpassword2','viewer','2025-07-23 16:25:58'),(3,'raj','raj@gmail.com','roaster34','admin','2025-08-21 17:33:51'),(4,'Alex dhurve','alex@coldchain.com','123','admin','2025-08-21 17:50:09'),(7,'Bob the builder','Bob@coldchain.com','123','admin','2025-08-22 17:34:26'),(8,'Shake','shake@coldchain.com','12345','viewer','2025-08-22 17:36:05'),(9,'Rasta','Rasta@coldchain.com','12345','viewer','2025-08-22 17:38:00'),(10,'moko','moko@coldchain.com','moko','admin','2025-08-22 18:01:07'),(11,'amiya','am@gmail.com','am','admin','2025-09-12 15:15:58');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-04-09 23:05:01
