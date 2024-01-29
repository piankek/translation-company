-- MySQL dump 10.13  Distrib 8.0.33, for Win64 (x86_64)
--
-- Host: localhost    Database: translations
-- ------------------------------------------------------
-- Server version	8.0.33

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
-- Table structure for table `clients`
--

DROP TABLE IF EXISTS `clients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clients` (
  `client_id` int NOT NULL,
  `client_name` varchar(50) NOT NULL,
  `client_email` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`client_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clients`
--

LOCK TABLES `clients` WRITE;
/*!40000 ALTER TABLE `clients` DISABLE KEYS */;
INSERT INTO `clients` VALUES (1,'Super Serious Company','info@superserious.co'),(2,'Movies4U','subtitles@movies4u.eu'),(3,'BeFit','ecommerce@befit.cz'),(4,'Purple Games','orders@purplegames.pl'),(5,'Lisbon Fashion','ecommerce@lisbonfashion.pt'),(6,'Today','today@magazine.com');
/*!40000 ALTER TABLE `clients` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `commission_by_month`
--

DROP TABLE IF EXISTS `commission_by_month`;
/*!50001 DROP VIEW IF EXISTS `commission_by_month`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `commission_by_month` AS SELECT 
 1 AS `sub_month`,
 1 AS `sub_year`,
 1 AS `translator_name`,
 1 AS `monthly_commission`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `estimated_order_price`
--

DROP TABLE IF EXISTS `estimated_order_price`;
/*!50001 DROP VIEW IF EXISTS `estimated_order_price`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `estimated_order_price` AS SELECT 
 1 AS `order_id`,
 1 AS `client_name`,
 1 AS `estimated_price`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `order_id` int NOT NULL,
  `client_id` int DEFAULT NULL,
  `order_placed_date` datetime DEFAULT NULL,
  `order_deadline` datetime DEFAULT NULL,
  `source_page_amount` decimal(10,2) DEFAULT NULL,
  `source_language` char(2) DEFAULT NULL,
  `target_language` char(2) DEFAULT NULL,
  `task_id` int DEFAULT NULL,
  PRIMARY KEY (`order_id`),
  KEY `client_id` (`client_id`),
  KEY `task_id` (`task_id`),
  KEY `source_language` (`source_language`,`target_language`),
  CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`client_id`) REFERENCES `clients` (`client_id`),
  CONSTRAINT `orders_ibfk_2` FOREIGN KEY (`task_id`) REFERENCES `tasks` (`task_id`),
  CONSTRAINT `orders_ibfk_3` FOREIGN KEY (`source_language`, `target_language`) REFERENCES `prices` (`source_language`, `target_language`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (1,5,'2023-01-07 15:13:00','2023-01-15 15:00:00',53.60,'PT','EN',1),(2,3,'2023-01-21 11:37:00','2023-01-30 15:00:00',32.50,'CZ','EN',2),(3,6,'2023-01-22 15:00:00','2023-01-28 15:00:00',15.30,'EN','JP',3),(4,1,'2023-02-12 13:13:00','2023-02-15 13:00:00',10.30,'EN','JP',4),(5,1,'2023-02-12 13:13:00','2023-02-15 13:00:00',13.10,'JP','EN',5),(6,6,'2023-02-15 15:36:00','2023-02-28 17:30:00',50.10,'EN','PT',6),(7,2,'2023-03-01 21:33:00','2023-03-20 08:00:00',120.60,'CZ','EN',7),(8,2,'2023-03-01 21:37:00','2023-03-20 08:00:00',115.70,'EN','PT',8),(9,4,'2023-03-12 12:36:00','2023-03-18 08:30:00',32.70,'EN','PL',9),(10,1,'2023-03-25 15:00:00','2023-04-25 08:00:00',77.50,'CZ','EN',10),(11,5,'2023-04-01 13:45:00','2023-04-15 09:00:00',50.10,'EN','PL',11),(12,3,'2023-04-05 23:04:00','2023-04-20 09:00:00',100.10,'JP','EN',12),(13,6,'2023-04-15 07:13:00','2023-04-21 15:00:00',30.50,'JP','EN',13),(14,2,'2023-04-21 15:03:00','2023-04-29 18:00:00',27.50,'CZ','EN',14),(15,2,'2023-05-03 19:15:00','2023-05-28 08:00:00',203.70,'PT','EN',15),(16,4,'2023-05-05 15:43:00','2023-05-27 10:30:00',116.30,'CZ','EN',16),(17,3,'2023-05-15 09:13:00','2023-06-01 06:00:00',117.50,'EN','PL',17),(18,5,'2023-05-15 10:15:00','2023-05-27 09:30:00',47.90,'EN','PT',18),(19,6,'2023-06-01 15:37:00','2023-06-15 15:30:00',30.30,'JP','EN',19),(20,1,'2023-06-01 16:15:00','2023-06-28 08:00:00',158.30,'PL','EN',20),(21,4,'2023-06-12 12:54:00','2023-08-16 08:00:00',13.80,'EN','PT',21),(22,1,'2023-07-01 15:36:00','2023-07-13 09:15:00',12.50,'PT','EN',22),(23,5,'2023-07-22 09:23:00','2023-08-25 08:00:00',203.00,'EN','PT',23),(24,2,'2023-07-23 15:43:00','2023-08-08 21:15:00',84.20,'PL','EN',26),(25,3,'2023-07-27 13:40:00','2023-08-19 08:00:00',23.40,'EN','CZ',NULL),(26,6,'2023-08-05 17:23:00','2023-08-25 08:00:00',53.60,'PT','EN',24),(27,5,'2023-08-01 16:42:00','2023-08-23 08:45:00',111.60,'PT','EN',25),(28,6,'2023-08-03 16:43:00','2023-09-21 09:00:00',501.00,'JP','EN',NULL),(29,4,'2023-08-01 15:43:00','2023-08-20 08:00:00',115.60,'EN','PL',NULL),(30,1,'2023-08-09 12:35:00','2023-08-27 16:30:00',55.70,'EN','CZ',NULL);
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prices`
--

DROP TABLE IF EXISTS `prices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prices` (
  `source_language` char(2) NOT NULL,
  `target_language` char(2) NOT NULL,
  `price_per_page` decimal(6,2) DEFAULT NULL,
  PRIMARY KEY (`source_language`,`target_language`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prices`
--

LOCK TABLES `prices` WRITE;
/*!40000 ALTER TABLE `prices` DISABLE KEYS */;
INSERT INTO `prices` VALUES ('CZ','EN',27.00),('EN','CZ',32.00),('EN','JP',50.00),('EN','PL',30.00),('EN','PT',28.00),('JP','EN',30.00),('PL','EN',25.00),('PT','EN',23.00);
/*!40000 ALTER TABLE `prices` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tasks`
--

DROP TABLE IF EXISTS `tasks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tasks` (
  `task_id` int NOT NULL,
  `task_assigned_date` datetime DEFAULT NULL,
  `task_submitted_date` datetime DEFAULT NULL,
  `task_status` enum('Not assigned','Assigned','Completed') DEFAULT 'Not assigned',
  `translator_id` int DEFAULT NULL,
  `target_page_amount` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`task_id`),
  KEY `translator_id` (`translator_id`),
  CONSTRAINT `tasks_ibfk_1` FOREIGN KEY (`translator_id`) REFERENCES `translators` (`translator_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tasks`
--

LOCK TABLES `tasks` WRITE;
/*!40000 ALTER TABLE `tasks` DISABLE KEYS */;
INSERT INTO `tasks` VALUES (1,'2023-01-07 17:00:00','2023-01-15 09:00:00','Completed',1,49.50),(2,'2023-01-21 12:30:00','2023-01-29 19:37:00','Completed',8,31.10),(3,'2023-01-23 08:00:00','2023-01-28 08:37:00','Completed',2,8.10),(4,'2023-02-13 09:00:00','2023-02-15 12:15:00','Completed',2,5.20),(5,'2023-02-13 09:00:00','2023-02-15 15:55:00','Completed',4,20.30),(6,'2023-02-15 15:36:00','2023-02-28 17:30:00','Completed',7,60.10),(7,'2023-03-02 08:21:00','2023-03-19 17:36:00','Completed',8,118.30),(8,'2023-03-02 09:01:00','2023-03-20 15:48:00','Completed',1,113.20),(9,'2023-03-12 15:36:00','2023-03-18 06:34:00','Completed',9,35.80),(10,'2023-03-25 21:13:00','2023-04-24 21:00:00','Completed',3,79.30),(11,'2023-04-01 15:21:00','2023-04-16 09:00:00','Completed',5,55.00),(12,'2023-04-06 08:00:00','2023-04-19 15:54:00','Completed',10,190.50),(13,'2023-04-15 15:03:00','2023-04-21 13:01:00','Completed',6,55.30),(14,'2023-04-22 08:05:00','2023-04-30 08:00:00','Completed',10,26.70),(15,'2023-05-04 09:14:00','2023-05-27 23:59:00','Completed',7,202.50),(16,'2023-05-06 08:00:00','2023-05-27 12:57:00','Completed',3,114.10),(17,'2023-05-15 10:00:00','2023-05-30 13:46:00','Completed',5,151.30),(18,'2023-05-15 12:34:00','2023-05-28 06:13:00','Completed',1,52.40),(19,'2023-06-02 07:45:00','2023-06-15 18:49:00','Completed',4,64.80),(20,'2023-06-02 08:45:00','2023-06-28 07:43:00','Completed',9,141.50),(21,'2023-07-23 19:00:00',NULL,'Assigned',9,NULL),(22,'2023-07-22 11:23:00',NULL,'Assigned',7,NULL),(23,NULL,NULL,'Not assigned',NULL,NULL),(24,'2023-08-16 08:26:00','2023-08-16 17:02:00','Completed',7,110.20),(25,NULL,NULL,'Not assigned',NULL,NULL),(26,'2023-07-23 18:22:00',NULL,'Assigned',3,NULL);
/*!40000 ALTER TABLE `tasks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `trans_language_pairs`
--

DROP TABLE IF EXISTS `trans_language_pairs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `trans_language_pairs` (
  `translator_id` int DEFAULT NULL,
  `source_language` char(2) DEFAULT NULL,
  `target_language` char(2) DEFAULT NULL,
  KEY `translator_id` (`translator_id`),
  KEY `source_language` (`source_language`,`target_language`),
  CONSTRAINT `trans_language_pairs_ibfk_1` FOREIGN KEY (`translator_id`) REFERENCES `translators` (`translator_id`),
  CONSTRAINT `trans_language_pairs_ibfk_2` FOREIGN KEY (`source_language`, `target_language`) REFERENCES `prices` (`source_language`, `target_language`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `trans_language_pairs`
--

LOCK TABLES `trans_language_pairs` WRITE;
/*!40000 ALTER TABLE `trans_language_pairs` DISABLE KEYS */;
INSERT INTO `trans_language_pairs` VALUES (1,'EN','PT'),(1,'PT','EN'),(1,'PL','EN'),(2,'EN','JP'),(2,'JP','EN'),(3,'EN','CZ'),(3,'CZ','EN'),(3,'PL','EN'),(4,'JP','EN'),(5,'EN','CZ'),(5,'EN','PL'),(6,'JP','EN'),(7,'PT','EN'),(7,'EN','PT'),(7,'PL','EN'),(7,'EN','PL'),(8,'CZ','EN'),(8,'PT','EN'),(9,'PL','EN'),(9,'EN','PL'),(9,'PT','EN'),(10,'JP','EN'),(10,'CZ','EN');
/*!40000 ALTER TABLE `trans_language_pairs` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `insert_lang_pair` BEFORE INSERT ON `trans_language_pairs` FOR EACH ROW BEGIN
	IF (NEW.source_language, NEW.target_language) NOT IN(SELECT prices.source_language, prices.target_language FROM prices) THEN
		INSERT INTO prices
		(source_language, target_language, price_per_page)
		VALUES
		(NEW.source_language, NEW.target_language, Null);
        END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `trans_levels`
--

DROP TABLE IF EXISTS `trans_levels`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `trans_levels` (
  `translator_level` varchar(30) NOT NULL,
  `translator_commission` decimal(2,2) NOT NULL,
  PRIMARY KEY (`translator_level`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `trans_levels`
--

LOCK TABLES `trans_levels` WRITE;
/*!40000 ALTER TABLE `trans_levels` DISABLE KEYS */;
INSERT INTO `trans_levels` VALUES ('Junior',0.35),('New joiner',0.25),('Senior',0.45);
/*!40000 ALTER TABLE `trans_levels` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `translators`
--

DROP TABLE IF EXISTS `translators`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `translators` (
  `translator_id` int NOT NULL,
  `translator_name` varchar(50) NOT NULL,
  `translator_email` varchar(30) DEFAULT NULL,
  `translator_level` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`translator_id`),
  KEY `translator_level` (`translator_level`),
  CONSTRAINT `translators_ibfk_1` FOREIGN KEY (`translator_level`) REFERENCES `trans_levels` (`translator_level`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `translators`
--

LOCK TABLES `translators` WRITE;
/*!40000 ALTER TABLE `translators` DISABLE KEYS */;
INSERT INTO `translators` VALUES (1,'Karen','karen@company.com','Senior'),(2,'Hiroshi','hiroshi@company.com','Senior'),(3,'Katka','katka@company.com','Senior'),(4,'Geraldine','geraldine@company.com','New joiner'),(5,'Karolina','karolina@company.com','Junior'),(6,'Albert','albert@company.com','New joiner'),(7,'Patricia','patricia@company.com','Senior'),(8,'Philip','philip@company.com','Junior'),(9,'Maria','maria@company.com','Senior'),(10,'Sofia','sofia@company.com','Junior');
/*!40000 ALTER TABLE `translators` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Final view structure for view `commission_by_month`
--

/*!50001 DROP VIEW IF EXISTS `commission_by_month`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `commission_by_month` AS select month(`t`.`task_submitted_date`) AS `sub_month`,year(`t`.`task_submitted_date`) AS `sub_year`,`trans`.`translator_name` AS `translator_name`,sum(round(((ceiling(`t`.`target_page_amount`) * `p`.`price_per_page`) * `l`.`translator_commission`),2)) AS `monthly_commission` from ((((`translators` `trans` join `tasks` `t` on((`trans`.`translator_id` = `t`.`translator_id`))) join `trans_levels` `l` on((`trans`.`translator_level` = `l`.`translator_level`))) join `orders` `o` on((`t`.`task_id` = `o`.`task_id`))) join `prices` `p` on(((`o`.`source_language` = `p`.`source_language`) and (`o`.`target_language` = `p`.`target_language`)))) where (`t`.`task_status` = 'Completed') group by `sub_month`,`sub_year`,`trans`.`translator_name` order by `sub_month`,`sub_year`,`trans`.`translator_name` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `estimated_order_price`
--

/*!50001 DROP VIEW IF EXISTS `estimated_order_price`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `estimated_order_price` AS select `o`.`order_id` AS `order_id`,`c`.`client_name` AS `client_name`,round((ceiling(`o`.`source_page_amount`) * `p`.`price_per_page`),0) AS `estimated_price` from ((`orders` `o` join `clients` `c` on((`o`.`client_id` = `c`.`client_id`))) join `prices` `p` on(((`o`.`source_language` = `p`.`source_language`) and (`o`.`target_language` = `p`.`target_language`)))) order by `o`.`order_id` desc */;
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

-- Dump completed on 2023-08-16 16:16:51
