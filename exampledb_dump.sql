-- MySQL dump 10.13  Distrib 8.4.3, for Linux (x86_64)
--
-- Host: localhost    Database: exampleDB
-- ------------------------------------------------------
-- Server version	8.4.3

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
-- Table structure for table `Aerodrome`
--

DROP TABLE IF EXISTS `Aerodrome`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Aerodrome` (
  `idAerodrome` varchar(10) NOT NULL,
  `nameAerodrome` varchar(30) DEFAULT NULL,
  `idLocation` int DEFAULT NULL,
  PRIMARY KEY (`idAerodrome`),
  KEY `idLocation` (`idLocation`),
  CONSTRAINT `Aerodrome_ibfk_1` FOREIGN KEY (`idLocation`) REFERENCES `Location` (`idLocation`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Aerodrome`
--

LOCK TABLES `Aerodrome` WRITE;
/*!40000 ALTER TABLE `Aerodrome` DISABLE KEYS */;
INSERT INTO `Aerodrome` VALUES ('LFBO','Airport of Toulouse Blagnac',31),('LFBR','Aerodrome of Muret-Lherm',31),('LFML','Airport of Marseille Provence',13),('LFPL','Airport of Lognes-Émerainville',77);
/*!40000 ALTER TABLE `Aerodrome` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Aircraft`
--

DROP TABLE IF EXISTS `Aircraft`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Aircraft` (
  `idAircraft` varchar(10) NOT NULL,
  `typeAircraft` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`idAircraft`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Aircraft`
--

LOCK TABLES `Aircraft` WRITE;
/*!40000 ALTER TABLE `Aircraft` DISABLE KEYS */;
INSERT INTO `Aircraft` VALUES ('F-ENAC','TB20'),('F-GGYV','CAP10'),('F-GTYH','TB20'),('F-HCMC','DA42'),('F-HCTA','DA42');
/*!40000 ALTER TABLE `Aircraft` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Flight`
--

DROP TABLE IF EXISTS `Flight`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Flight` (
  `idFlight` varchar(10) NOT NULL,
  `dateFlight` date DEFAULT NULL,
  `typeFlight` varchar(10) DEFAULT NULL,
  `idAircraft` varchar(10) DEFAULT NULL,
  `idPilot` varchar(10) DEFAULT NULL,
  `idAlternateAerodrome` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`idFlight`),
  KEY `idAircraft` (`idAircraft`),
  KEY `idPilot` (`idPilot`),
  KEY `idAlternateAerodrome` (`idAlternateAerodrome`),
  CONSTRAINT `Flight_ibfk_1` FOREIGN KEY (`idAircraft`) REFERENCES `Aircraft` (`idAircraft`),
  CONSTRAINT `Flight_ibfk_2` FOREIGN KEY (`idPilot`) REFERENCES `Pilot` (`idPilot`),
  CONSTRAINT `Flight_ibfk_3` FOREIGN KEY (`idAlternateAerodrome`) REFERENCES `Aerodrome` (`idAerodrome`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Flight`
--

LOCK TABLES `Flight` WRITE;
/*!40000 ALTER TABLE `Flight` DISABLE KEYS */;
INSERT INTO `Flight` VALUES ('F1','2017-02-22','IFR','F-GTYH','P1','LFBR'),('F2','2017-11-22','VFR','F-HCTA','P2','LFBO'),('F3','2017-08-31','IFR','F-HCTA','P3','LFBR'),('F4','2018-01-22','IFR','F-GTYH','P1','LFBR'),('F5','2018-10-22','VFR','F-HCMC','P2','LFBR'),('F6','2018-07-31','IFR','F-GTYH','P1','LFBO');
/*!40000 ALTER TABLE `Flight` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Location`
--

DROP TABLE IF EXISTS `Location`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Location` (
  `idLocation` int NOT NULL,
  `nameLocation` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`idLocation`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Location`
--

LOCK TABLES `Location` WRITE;
/*!40000 ALTER TABLE `Location` DISABLE KEYS */;
INSERT INTO `Location` VALUES (13,'Bouches-du-Rhone'),(31,'Haute-Garonne'),(77,'Seine-et-Marne'),(91,'Essonne'),(93,'Seine-Saint-Denis');
/*!40000 ALTER TABLE `Location` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Pilot`
--

DROP TABLE IF EXISTS `Pilot`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Pilot` (
  `idPilot` varchar(10) NOT NULL,
  `name` varchar(30) DEFAULT NULL,
  `firstname` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`idPilot`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Pilot`
--

LOCK TABLES `Pilot` WRITE;
/*!40000 ALTER TABLE `Pilot` DISABLE KEYS */;
INSERT INTO `Pilot` VALUES ('P1','Planchon','Frederic'),('P2','Vengut','Jean-Marc'),('P3','Gotteland','Jean-Baptiste');
/*!40000 ALTER TABLE `Pilot` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Route`
--

DROP TABLE IF EXISTS `Route`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Route` (
  `idFlight` varchar(10) NOT NULL,
  `idAerodrome` varchar(10) NOT NULL,
  `orderRoute` int NOT NULL,
  PRIMARY KEY (`idFlight`,`idAerodrome`,`orderRoute`),
  KEY `idAerodrome` (`idAerodrome`),
  CONSTRAINT `Route_ibfk_1` FOREIGN KEY (`idFlight`) REFERENCES `Flight` (`idFlight`),
  CONSTRAINT `Route_ibfk_2` FOREIGN KEY (`idAerodrome`) REFERENCES `Aerodrome` (`idAerodrome`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Route`
--

LOCK TABLES `Route` WRITE;
/*!40000 ALTER TABLE `Route` DISABLE KEYS */;
INSERT INTO `Route` VALUES ('F3','LFBO',1),('F5','LFBO',1),('F1','LFBR',1),('F2','LFBR',1),('F4','LFBR',1),('F6','LFBR',3),('F1','LFML',2),('F2','LFML',3),('F3','LFML',2),('F4','LFML',2),('F5','LFML',2),('F6','LFML',1),('F2','LFPL',2),('F6','LFPL',2);
/*!40000 ALTER TABLE `Route` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Runway`
--

DROP TABLE IF EXISTS `Runway`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Runway` (
  `idRunway` varchar(10) NOT NULL,
  `direction` varchar(10) DEFAULT NULL,
  `lengthRunway` double DEFAULT NULL,
  `surface` varchar(30) DEFAULT NULL,
  `idAerodrome` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`idRunway`),
  KEY `idAerodrome` (`idAerodrome`),
  CONSTRAINT `Runway_ibfk_1` FOREIGN KEY (`idAerodrome`) REFERENCES `Aerodrome` (`idAerodrome`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Runway`
--

LOCK TABLES `Runway` WRITE;
/*!40000 ALTER TABLE `Runway` DISABLE KEYS */;
INSERT INTO `Runway` VALUES ('R1','14/32',11483,'Bituminous concrete','LFBO'),('R2','14/32',9843,'Bituminous concrete','LFBO'),('R3','13/31',11483,'Bituminous concrete','LFML'),('R4','13/31',7776,'Bituminous concrete','LFML'),('R5','12/30',3609,'Asphalt','LFBR'),('R6','12/30',2706,'Grass','LFBR'),('R7','26/08',2296,'Asphalt','LFPL'),('R8','26/08',3609,'Grass','LFPL');
/*!40000 ALTER TABLE `Runway` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-12-25 17:04:48
