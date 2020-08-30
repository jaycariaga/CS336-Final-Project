CREATE DATABASE  IF NOT EXISTS `project` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `project`;
-- MySQL dump 10.13  Distrib 8.0.19, for Win64 (x86_64)
--
-- Host: db-project.cwtgu3tqnwx8.us-east-2.rds.amazonaws.com    Database: project
-- ------------------------------------------------------
-- Server version	8.0.15

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
-- Table structure for table `Customer`
--

DROP TABLE IF EXISTS `Customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Customer` (
  `username` char(20) NOT NULL,
  `state` char(20) DEFAULT NULL,
  `city` char(20) DEFAULT NULL,
  `telephone` char(20) DEFAULT NULL,
  `email` char(30) DEFAULT NULL,
  `zip` char(10) DEFAULT NULL,
  `address` char(30) DEFAULT NULL,
  PRIMARY KEY (`username`),
  CONSTRAINT `Customer_ibfk_1` FOREIGN KEY (`username`) REFERENCES `User` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Customer`
--

LOCK TABLES `Customer` WRITE;
/*!40000 ALTER TABLE `Customer` DISABLE KEYS */;
INSERT INTO `Customer` VALUES ('a','NY','Albany','609-124-4569','a@gmail.com','12345','2 Rutgers Way'),('banana','VA','Potamac','609-123-4555','banana@gmail.com','21458','3 Rutgers Way'),('dimmadomes','MI','Detroit','609-123-4666','dim@gmail.com','56821','4 Rutgers Way'),('jasonc','NJ','Princeton','609-123-4569','j@gmail.com','01234','1 Rutgers Way'),('leb','WA','Seattle','609-123-4577','leb@gmail.com','15476','5 Rutgers Way'),('parker','NJ','Hamilton','609-123-9999','parker@gmail.com','15697','6 Rutgers Way'),('valia','NJ','Linden','609-888-8414','valia@gmail.com','11121','7 Rutgers Way');
/*!40000 ALTER TABLE `Customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Customer_Rep`
--

DROP TABLE IF EXISTS `Customer_Rep`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Customer_Rep` (
  `username` char(20) NOT NULL,
  `SSN` char(10) DEFAULT NULL,
  PRIMARY KEY (`username`),
  KEY `SSN` (`SSN`),
  CONSTRAINT `Customer_Rep_ibfk_1` FOREIGN KEY (`username`) REFERENCES `Employee` (`username`),
  CONSTRAINT `Customer_Rep_ibfk_2` FOREIGN KEY (`SSN`) REFERENCES `Employee` (`SSN`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Customer_Rep`
--

LOCK TABLES `Customer_Rep` WRITE;
/*!40000 ALTER TABLE `Customer_Rep` DISABLE KEYS */;
INSERT INTO `Customer_Rep` VALUES ('custrep1','123456780'),('custrep2','123456781'),('custrep3','123456782'),('custrep4','123456783'),('custrep5','123456784');
/*!40000 ALTER TABLE `Customer_Rep` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Employee`
--

DROP TABLE IF EXISTS `Employee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Employee` (
  `username` char(20) NOT NULL,
  `SSN` char(10) DEFAULT NULL,
  `type` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`username`),
  UNIQUE KEY `SSN` (`SSN`),
  CONSTRAINT `Employee_ibfk_1` FOREIGN KEY (`username`) REFERENCES `User` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Employee`
--

LOCK TABLES `Employee` WRITE;
/*!40000 ALTER TABLE `Employee` DISABLE KEYS */;
INSERT INTO `Employee` VALUES ('custrep1','123456780','rep'),('custrep2','123456781','rep'),('custrep3','123456782','rep'),('custrep4','123456783','rep'),('custrep5','123456784','rep');
/*!40000 ALTER TABLE `Employee` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Forum`
--

DROP TABLE IF EXISTS `Forum`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Forum` (
  `question` varchar(200) DEFAULT NULL,
  `answer` varchar(200) DEFAULT NULL,
  `forum_id` int(11) NOT NULL,
  `cust_user` varchar(20) DEFAULT NULL,
  `timestamp` date DEFAULT NULL,
  PRIMARY KEY (`forum_id`),
  KEY `cust_user` (`cust_user`),
  CONSTRAINT `Forum_ibfk_1` FOREIGN KEY (`cust_user`) REFERENCES `Customer` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Forum`
--

LOCK TABLES `Forum` WRITE;
/*!40000 ALTER TABLE `Forum` DISABLE KEYS */;
INSERT INTO `Forum` VALUES ('what','yes',1,'jasonc','2020-01-01'),('fa',NULL,2,NULL,'2020-04-13'),('boooo',NULL,3,NULL,'2020-04-13'),('hello',NULL,4,NULL,'2020-04-13');
/*!40000 ALTER TABLE `Forum` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Manager`
--

DROP TABLE IF EXISTS `Manager`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Manager` (
  `username` char(20) NOT NULL,
  `SSN` char(10) DEFAULT NULL,
  PRIMARY KEY (`username`),
  KEY `SSN` (`SSN`),
  CONSTRAINT `Manager_ibfk_1` FOREIGN KEY (`username`) REFERENCES `Employee` (`username`),
  CONSTRAINT `Manager_ibfk_2` FOREIGN KEY (`SSN`) REFERENCES `Employee` (`SSN`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Manager`
--

LOCK TABLES `Manager` WRITE;
/*!40000 ALTER TABLE `Manager` DISABLE KEYS */;
/*!40000 ALTER TABLE `Manager` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Reservations`
--

DROP TABLE IF EXISTS `Reservations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Reservations` (
  `reservation_no` int(11) NOT NULL AUTO_INCREMENT,
  `customer` varchar(45) DEFAULT NULL,
  `customerRep` varchar(45) DEFAULT NULL,
  `adults` int(11) DEFAULT NULL,
  `children` int(11) DEFAULT NULL,
  `seniors` int(11) DEFAULT NULL,
  `disabled` int(11) DEFAULT NULL,
  `total_fare` double DEFAULT NULL,
  `transit_line` varchar(45) DEFAULT NULL,
  `trainID` int(11) DEFAULT NULL,
  `originStationID` int(11) DEFAULT NULL,
  `destinationStationID` int(11) DEFAULT NULL,
  `travelDate` date DEFAULT NULL,
  `departOriginTime` time DEFAULT NULL,
  `arriveDestinationTime` time DEFAULT NULL,
  `dateTimeReservationMade` datetime DEFAULT NULL,
  `seatNumber` int(11) DEFAULT NULL,
  `class` varchar(45) DEFAULT NULL,
  `status` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`reservation_no`),
  KEY `customer` (`customer`),
  KEY `Reservations_ibfk_1_idx` (`customerRep`),
  KEY `Reservations_ibfk_2_idx` (`originStationID`),
  KEY `Reservations_ibfk_3_idx` (`destinationStationID`),
  KEY `Reservations_ibfk_4_idx` (`customerRep`),
  CONSTRAINT `Reservations_ibfk_1` FOREIGN KEY (`customer`) REFERENCES `User` (`username`),
  CONSTRAINT `Reservations_ibfk_2` FOREIGN KEY (`originStationID`) REFERENCES `Station_new` (`stationID`),
  CONSTRAINT `Reservations_ibfk_3` FOREIGN KEY (`destinationStationID`) REFERENCES `Station_new` (`stationID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Reservations`
--

LOCK TABLES `Reservations` WRITE;
/*!40000 ALTER TABLE `Reservations` DISABLE KEYS */;
/*!40000 ALTER TABLE `Reservations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Schedules`
--

DROP TABLE IF EXISTS `Schedules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Schedules` (
  `train_id` char(20) NOT NULL,
  `arrival` date DEFAULT NULL,
  `departure` date DEFAULT NULL,
  `fare` int(11) DEFAULT NULL,
  `transit_name` char(20) DEFAULT NULL,
  `origin` char(20) DEFAULT NULL,
  `destination` char(20) DEFAULT NULL,
  `seats_avail` int(11) DEFAULT NULL,
  `stops_left` int(11) DEFAULT NULL,
  PRIMARY KEY (`train_id`),
  CONSTRAINT `Schedules_ibfk_1` FOREIGN KEY (`train_id`) REFERENCES `Train` (`train_id`) ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Schedules`
--

LOCK TABLES `Schedules` WRITE;
/*!40000 ALTER TABLE `Schedules` DISABLE KEYS */;
/*!40000 ALTER TABLE `Schedules` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Schedules_new_aka_reaches`
--

DROP TABLE IF EXISTS `Schedules_new_aka_reaches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Schedules_new_aka_reaches` (
  `trainID` int(11) NOT NULL,
  `stationID` int(11) NOT NULL,
  `time` time DEFAULT NULL,
  KEY `trainID_idx` (`trainID`),
  KEY `stationID_idx` (`stationID`),
  KEY `trainID_idx2` (`trainID`),
  KEY `stationID_idx2` (`stationID`),
  CONSTRAINT `Schedules_new_aka_reaches_ibfk_1` FOREIGN KEY (`trainID`) REFERENCES `Train_new` (`trainID`),
  CONSTRAINT `Schedules_new_aka_reaches_ibfk_2` FOREIGN KEY (`stationID`) REFERENCES `Station_new` (`stationID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Schedules_new_aka_reaches`
--

LOCK TABLES `Schedules_new_aka_reaches` WRITE;
/*!40000 ALTER TABLE `Schedules_new_aka_reaches` DISABLE KEYS */;
/*!40000 ALTER TABLE `Schedules_new_aka_reaches` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Station`
--

DROP TABLE IF EXISTS `Station`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Station` (
  `id` int(11) NOT NULL,
  `state` varchar(40) DEFAULT NULL,
  `name` varchar(40) DEFAULT NULL,
  `city` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Station`
--

LOCK TABLES `Station` WRITE;
/*!40000 ALTER TABLE `Station` DISABLE KEYS */;
INSERT INTO `Station` VALUES (1,'NJ','Trenton','Trenton'),(2,'NJ','Princeton Junction','Princeton Junction'),(3,'NY','New York Penn Statio','New York City');
/*!40000 ALTER TABLE `Station` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Station_new`
--

DROP TABLE IF EXISTS `Station_new`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Station_new` (
  `stationID` int(11) NOT NULL,
  `name` varchar(45) DEFAULT NULL,
  `transit_line` varchar(45) DEFAULT NULL,
  `state` varchar(45) DEFAULT NULL,
  `city` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`stationID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Station_new`
--

LOCK TABLES `Station_new` WRITE;
/*!40000 ALTER TABLE `Station_new` DISABLE KEYS */;
INSERT INTO `Station_new` VALUES (1,'Trenton','NJ Transit','NJ','Trenton'),(2,'Hamilton','NJ Transit','NJ','Hamilton'),(3,'Princeton','NJ Transit','NJ','Princeton'),(4,'New Brunswick','NJ Transit','NJ','New Brunswick'),(5,'Edison','NJ Transit','NJ','Edison'),(6,'Metuchen','NJ Transit','NJ','Metuchen'),(7,'Linden','NJ Transit','NJ','Linden'),(8,'Newark Penn Station','NJ Transit','NJ','Newark'),(9,'New York Penn Station','NJ Transit','NY','New York'),(10,'San Diego','Pacific Corridor','CA','San Diego'),(11,'Los Angeles','Pacific Corridor','CA','Los Angeles'),(12,'Santa Barbara','Pacific Corridor','CA','Santa Barbara'),(13,'San Francisco Union Station','Pacific Corridor','CA','San Francisco'),(14,'Eugene Stop','Pacific Corridor','OR','Eugene'),(15,'Portland Mission','Pacific Corridor','OR','Portland'),(16,'Olympia Station','Pacific Corridor','WA','Olympia'),(17,'Seattle Metro Station','Pacific Corridor','WA','Seattle'),(18,'Spokane','Pacific Corridor','WA','Spokane'),(19,'San Antonio Square','Southern Express','TX','San Antonio'),(20,'Austin','Southern Express','TX','Austin'),(21,'Houston','Southern Express','TX','Houston'),(22,'Baton Rouge Union Station','Southern Express','LA','Baton Rouge'),(23,'Montgomery','Southern Express','AL','Montgomery'),(24,'Tallahassee','Southern Express','FL','Tallahassee'),(25,'Jacksonville Penn Station','Southern Express','FL','Jacksonville'),(26,'Orlando Triangle','Southern Express','FL','Orlando'),(27,'Miami','Southern Express','FL','Miami');
/*!40000 ALTER TABLE `Station_new` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Train`
--

DROP TABLE IF EXISTS `Train`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Train` (
  `train_id` char(20) NOT NULL,
  `seats` int(11) DEFAULT NULL,
  `cars` int(11) DEFAULT NULL,
  PRIMARY KEY (`train_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Train`
--

LOCK TABLES `Train` WRITE;
/*!40000 ALTER TABLE `Train` DISABLE KEYS */;
/*!40000 ALTER TABLE `Train` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Train_new`
--

DROP TABLE IF EXISTS `Train_new`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Train_new` (
  `trainID` int(11) NOT NULL,
  `transit_line` varchar(45) DEFAULT NULL,
  `seats_remaining` int(11) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `cars` int(11) DEFAULT NULL,
  PRIMARY KEY (`trainID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Train_new`
--

LOCK TABLES `Train_new` WRITE;
/*!40000 ALTER TABLE `Train_new` DISABLE KEYS */;
INSERT INTO `Train_new` VALUES (1,'NJ Transit',200,'2020-04-10',10),(2,'NJ Transit',200,'2020-04-10',10),(3,'NJ Transit',220,'2020-04-10',11),(4,'NJ Transit',200,'2020-04-11',10),(5,'NJ Transit',200,'2020-04-11',10),(6,'NJ Transit',220,'2020-04-11',11),(7,'NJ Transit',200,'2020-04-12',10),(8,'NJ Transit',200,'2020-04-12',10),(9,'NJ Transit',220,'2020-04-12',11),(10,'Pacific Corridor',300,'2020-04-10',15),(11,'Pacific Corridor',300,'2020-04-10',15),(12,'Pacific Corridor',320,'2020-04-10',16),(13,'Pacific Corridor',300,'2020-04-11',15),(14,'Pacific Corridor',300,'2020-04-11',15),(15,'Pacific Corridor',320,'2020-04-11',16),(16,'Pacific Corridor',300,'2020-04-12',15),(17,'Pacific Corridor',300,'2020-04-12',15),(18,'Pacific Corridor',320,'2020-04-12',16),(19,'Southern Express',100,'2020-04-10',5),(20,'Southern Express',100,'2020-04-10',5),(21,'Southern Express',120,'2020-04-10',6),(22,'Southern Express',100,'2020-04-11',5),(23,'Southern Express',100,'2020-04-11',5),(24,'Southern Express',120,'2020-04-11',6),(25,'Southern Express',100,'2020-04-12',5),(26,'Southern Express',100,'2020-04-12',5),(27,'Southern Express',120,'2020-04-12',6);
/*!40000 ALTER TABLE `Train_new` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `User`
--

DROP TABLE IF EXISTS `User`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `User` (
  `username` char(20) NOT NULL,
  `password` char(20) DEFAULT NULL,
  `first_name` char(20) DEFAULT NULL,
  `last_name` char(20) DEFAULT NULL,
  PRIMARY KEY (`username`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `User`
--

LOCK TABLES `User` WRITE;
/*!40000 ALTER TABLE `User` DISABLE KEYS */;
INSERT INTO `User` VALUES ('a','a','Abraham','Arden'),('app','123','Apple','Banana'),('banana','banana','sid','dis'),('custrep1','custrep1','cust','rep'),('custrep2','custrep2','cust','rep'),('custrep3','custrep3','cust','rep'),('custrep4','custrep4','cust','rep'),('custrep5','custrep5','cust','rep'),('dimmadomes','turner','doug','dimmadome'),('jasonc','jason','jason','c'),('leb','pass','lebron','james'),('parker','fisher','Parker','Fisher'),('valia','valia','Valia','K');
/*!40000 ALTER TABLE `User` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `starts_at_new`
--

DROP TABLE IF EXISTS `starts_at_new`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `starts_at_new` (
  `trainID` int(11) NOT NULL,
  `stationID` int(11) NOT NULL,
  KEY `Schedules_ibfk_1_idx` (`trainID`),
  KEY `starts_at_new_ibfk_2_idx` (`stationID`),
  CONSTRAINT `starts_at_new_ibfk_1` FOREIGN KEY (`trainID`) REFERENCES `Train_new` (`trainID`),
  CONSTRAINT `starts_at_new_ibfk_2` FOREIGN KEY (`stationID`) REFERENCES `Station_new` (`stationID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `starts_at_new`
--

LOCK TABLES `starts_at_new` WRITE;
/*!40000 ALTER TABLE `starts_at_new` DISABLE KEYS */;
INSERT INTO `starts_at_new` VALUES (1,1),(2,1),(3,1);
/*!40000 ALTER TABLE `starts_at_new` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stops_at_new`
--

DROP TABLE IF EXISTS `stops_at_new`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stops_at_new` (
  `trainID` int(11) NOT NULL,
  `stationID` int(11) NOT NULL,
  `stopsLeftTillDestination` int(11) DEFAULT NULL,
  `arrival_time` time DEFAULT NULL,
  KEY `stopts_at_new_ibfk_1_idx` (`trainID`),
  KEY `stops_at_new_ibfk_2_idx` (`stationID`),
  CONSTRAINT `stops_at_new_ibfk_1` FOREIGN KEY (`trainID`) REFERENCES `Train_new` (`trainID`),
  CONSTRAINT `stops_at_new_ibfk_2` FOREIGN KEY (`stationID`) REFERENCES `Station_new` (`stationID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stops_at_new`
--

LOCK TABLES `stops_at_new` WRITE;
/*!40000 ALTER TABLE `stops_at_new` DISABLE KEYS */;
INSERT INTO `stops_at_new` VALUES (1,1,8,'08:00:00'),(1,2,7,'08:20:00'),(1,3,6,'08:40:00'),(1,4,5,'09:00:00'),(1,5,4,'09:20:00'),(1,6,3,'09:40:00'),(1,7,2,'10:00:00'),(1,8,1,'10:20:00'),(1,9,0,'10:40:00'),(2,1,8,'11:00:00'),(2,2,7,'11:20:00'),(2,3,6,'11:40:00'),(2,4,5,'12:00:00'),(2,5,4,'12:20:00'),(2,6,3,'12:40:00'),(2,7,2,'13:00:00'),(2,8,1,'13:20:00'),(2,9,0,'13:40:00'),(3,1,4,'14:00:00'),(3,3,3,'14:20:00'),(3,5,2,'14:40:00'),(3,7,1,'15:00:00'),(3,9,0,'15:20:00'),(4,1,8,'08:00:00'),(4,2,7,'08:20:00'),(4,3,6,'08:40:00'),(4,4,5,'09:00:00'),(4,5,4,'09:20:00'),(4,6,3,'09:40:00'),(4,7,2,'10:00:00'),(4,8,1,'10:20:00'),(4,9,0,'10:40:00'),(5,1,8,'11:00:00'),(5,2,7,'11:20:00'),(5,3,6,'11:40:00'),(5,4,5,'12:00:00'),(5,5,4,'12:20:00'),(5,6,3,'12:40:00'),(5,7,2,'13:00:00'),(5,8,1,'13:20:00'),(5,9,0,'13:40:00'),(6,1,4,'14:00:00'),(6,3,3,'14:20:00'),(6,5,2,'14:40:00'),(6,7,1,'15:00:00'),(6,9,0,'15:20:00'),(7,1,8,'08:00:00'),(7,2,7,'08:20:00'),(7,3,6,'08:40:00'),(7,4,5,'09:00:00'),(7,5,4,'09:20:00'),(7,6,3,'09:40:00'),(7,7,2,'10:00:00'),(7,8,1,'10:20:00'),(7,9,0,'10:40:00'),(8,1,8,'11:00:00'),(8,2,7,'11:20:00'),(8,3,6,'11:40:00'),(8,4,5,'12:00:00'),(8,5,4,'12:20:00'),(8,6,3,'12:40:00'),(8,7,2,'13:00:00'),(8,8,1,'13:20:00'),(8,9,0,'13:40:00'),(9,1,4,'14:00:00'),(9,3,3,'14:20:00'),(9,5,2,'14:40:00'),(9,7,1,'15:00:00'),(9,9,0,'15:20:00');
/*!40000 ALTER TABLE `stops_at_new` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-04-18 18:04:34
