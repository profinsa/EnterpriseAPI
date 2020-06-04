-- MySQL dump 10.13  Distrib 5.7.23, for Linux (i686)
--
-- Host: localhost    Database: myenterprise
-- ------------------------------------------------------
-- Server version	5.7.23-0ubuntu0.16.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `helpdocument`
--

DROP TABLE IF EXISTS `helpdocument`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `helpdocument` (
  `CompanyID` varchar(36) NOT NULL,
  `DivisionID` varchar(36) NOT NULL,
  `DepartmentID` varchar(36) NOT NULL,
  `DocumentTitleID` varchar(36) NOT NULL,
  `DocumentTitle` varchar(128) DEFAULT NULL,
  `DocumentTopic` varchar(36) DEFAULT NULL,
  `DocumentModule` varchar(36) DEFAULT NULL,
  `DocumentURL` varchar(128) DEFAULT NULL,
  `DocumentContents` text,
  `LockedBy` varchar(36) DEFAULT NULL,
  `LockTS` datetime DEFAULT NULL,
  PRIMARY KEY (`CompanyID`,`DivisionID`,`DepartmentID`,`DocumentTitleID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `helpdocument`
--

LOCK TABLES `helpdocument` WRITE;
/*!40000 ALTER TABLE `helpdocument` DISABLE KEYS */;
INSERT INTO `helpdocument` VALUES ('DEFAULT','DEFAULT','DEFAULT','hop','roma','INSTALL','PR','LALAL','KDJFKDFJFLWE\r\ndfdfdf\r\ndfdfdfd',NULL,NULL);
/*!40000 ALTER TABLE `helpdocument` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `helpdocumenttopic`
--

DROP TABLE IF EXISTS `helpdocumenttopic`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `helpdocumenttopic` (
  `CompanyID` varchar(36) NOT NULL,
  `DivisionID` varchar(36) NOT NULL,
  `DepartmentID` varchar(36) NOT NULL,
  `TopicID` varchar(36) NOT NULL,
  `TopicName` varchar(50) DEFAULT NULL,
  `TopicDescription` varchar(50) DEFAULT NULL,
  `TopicLongDescription` varchar(80) DEFAULT NULL,
  `TopicPictureURL` varchar(80) DEFAULT NULL,
  `TopicPicture` varchar(80) DEFAULT NULL,
  `LockedBy` varchar(36) DEFAULT NULL,
  `LockTS` datetime DEFAULT NULL,
  PRIMARY KEY (`CompanyID`,`DivisionID`,`DepartmentID`,`TopicID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `helpdocumenttopic`
--

LOCK TABLES `helpdocumenttopic` WRITE;
/*!40000 ALTER TABLE `helpdocumenttopic` DISABLE KEYS */;
INSERT INTO `helpdocumenttopic` VALUES ('DEFAULT','DEFAULT','DEFAULT','INSTALL','Insatallation','Installation Instructions','Installation Instructions',NULL,NULL,NULL,NULL),('DEFAULT','DEFAULT','DEFAULT','PROBLEMS','Common Problems','Common Problems','Common Problems',NULL,NULL,NULL,NULL),('DEFAULT','DEFAULT','DEFAULT','START','Getting Started','Getting Started','Getting Started',NULL,NULL,NULL,NULL),('DEFAULT','DEFAULT','DEFAULT','TECH','Technical Reference','Technical Reference','Technical Reference',NULL,NULL,NULL,NULL),('DEFAULT','DEFAULT','DEFAULT','TROUBLE','Troubleshooting','TroubleShooting','Troubleshooting',NULL,NULL,NULL,NULL),('DEFAULT','DEFAULT','DEFAULT','USER','User Manual','User Manual','User Manual',NULL,NULL,NULL,NULL),('DEFAULT','DEFAULT','DEFAULT','WELCOME','Welcome','Welcome','Welcome',NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `helpdocumenttopic` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `helpdocumentmodule`
--

DROP TABLE IF EXISTS `helpdocumentmodule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `helpdocumentmodule` (
  `CompanyID` varchar(36) NOT NULL,
  `DivisionID` varchar(36) NOT NULL,
  `DepartmentID` varchar(36) NOT NULL,
  `ModuleID` varchar(36) NOT NULL,
  `ModuleName` varchar(50) DEFAULT NULL,
  `ModuleDescription` varchar(50) DEFAULT NULL,
  `ModuleLongDescription` varchar(80) DEFAULT NULL,
  `ModulePictureURL` varchar(80) DEFAULT NULL,
  `ModulePicture` varchar(80) DEFAULT NULL,
  `LockedBy` varchar(36) DEFAULT NULL,
  `LockTS` datetime DEFAULT NULL,
  PRIMARY KEY (`CompanyID`,`DivisionID`,`DepartmentID`,`ModuleID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `helpdocumentmodule`
--

LOCK TABLES `helpdocumentmodule` WRITE;
/*!40000 ALTER TABLE `helpdocumentmodule` DISABLE KEYS */;
INSERT INTO `helpdocumentmodule` VALUES ('DEFAULT','DEFAULT','DEFAULT','AP','Accounts Payable','Accounts Payable','Accounts Payable',NULL,NULL,NULL,NULL),('DEFAULT','DEFAULT','DEFAULT','AR','Accounts Receivable','Accounts Receivable','Accounts Receivable',NULL,NULL,NULL,NULL),('DEFAULT','DEFAULT','DEFAULT','CART','Shopping Cart','Shopping Cart','Shopping Cart',NULL,NULL,NULL,NULL),('DEFAULT','DEFAULT','DEFAULT','GL','General Ledger','General Ledger','General Ledger',NULL,NULL,NULL,NULL),('DEFAULT','DEFAULT','DEFAULT','HR','Human Resources','Human Resources','Human Resources',NULL,NULL,NULL,NULL),('DEFAULT','DEFAULT','DEFAULT','INV','Inventory','Inventory','Inventory',NULL,NULL,NULL,NULL),('DEFAULT','DEFAULT','DEFAULT','MRP','MRP','MRP','MRP',NULL,NULL,NULL,NULL),('DEFAULT','DEFAULT','DEFAULT','POS','Point of Sale','Point Of Sale','Point Of Sale',NULL,NULL,NULL,NULL),('DEFAULT','DEFAULT','DEFAULT','PR','Payroll','Payroll','Payroll',NULL,NULL,NULL,NULL),('DEFAULT','DEFAULT','DEFAULT','RPT','Reports','Reports','Reports',NULL,NULL,NULL,NULL),('DEFAULT','DEFAULT','DEFAULT','SET','Setup','Setup','Setup',NULL,NULL,NULL,NULL),('DEFAUT','DEFAULT','DEFAULT','FIXED','Fixed Assets','Fixed Assets','Fixed Assets',NULL,NULL,NULL,NULL),('DEFAUT','DEFAULT','DEFAULT','OTHER','Other Features','Other Features and Functions','Other Features and Functions',NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `helpdocumentmodule` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-06-24 16:52:47
