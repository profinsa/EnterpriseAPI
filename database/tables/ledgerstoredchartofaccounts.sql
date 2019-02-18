-- MySQL dump 10.13  Distrib 5.6.28, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: myenterprise
-- ------------------------------------------------------
-- Server version	5.6.28-0ubuntu0.15.10.1

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
-- Table structure for table `ledgerstoredchartofaccounts`
--

DROP TABLE IF EXISTS `ledgerstoredchartofaccounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ledgerstoredchartofaccounts` (
  `Industry` nvarchar(36) NOT NULL,
  `ChartType` nvarchar(36) NOT NULL,
  `ChartDescription` nvarchar(128) DEFAULT NULL,
  `CompanyID` varchar(36) NOT NULL,
  `DivisionID` varchar(36) NOT NULL,
  `DepartmentID` varchar(36) NOT NULL,
  `GLAccountNumber` varchar(36) NOT NULL,
  `GLAccountCode` varchar(36) NOT NULL,
  `GLSubAccountCode` varchar(36) DEFAULT NULL,
  `GLAccountName` varchar(30) DEFAULT NULL,
  `GLAccountDescription` varchar(50) DEFAULT NULL,
  `GLAccountUse` varchar(50) DEFAULT NULL,
  `GLAccountType` varchar(36) DEFAULT NULL,
  `GLBalanceType` varchar(36) DEFAULT NULL,
  `GLReportingAccount` tinyint(1) DEFAULT '0',
  `GLReportLevel` smallint(6) DEFAULT NULL,
  `CurrencyID` varchar(3) DEFAULT NULL,
  `CurrencyExchangeRate` float DEFAULT NULL,
  `GLAccountBalance` decimal(19,4) DEFAULT '0.0000',
  `GLAccountBeginningBalance` decimal(19,4) DEFAULT '0.0000',
  `GLOtherNotes` varchar(255) DEFAULT NULL,
  `GLBudgetID` varchar(36) DEFAULT NULL,
  `GLCurrentYearBeginningBalance` decimal(19,4) DEFAULT '0.0000',
  `GLCurrentYearPeriod1` decimal(19,4) DEFAULT '0.0000',
  `GLCurrentYearPeriod2` decimal(19,4) DEFAULT '0.0000',
  `GLCurrentYearPeriod3` decimal(19,4) DEFAULT '0.0000',
  `GLCurrentYearPeriod4` decimal(19,4) DEFAULT '0.0000',
  `GLCurrentYearPeriod5` decimal(19,4) DEFAULT '0.0000',
  `GLCurrentYearPeriod6` decimal(19,4) DEFAULT '0.0000',
  `GLCurrentYearPeriod7` decimal(19,4) DEFAULT '0.0000',
  `GLCurrentYearPeriod8` decimal(19,4) DEFAULT '0.0000',
  `GLCurrentYearPeriod9` decimal(19,4) DEFAULT '0.0000',
  `GLCurrentYearPeriod10` decimal(19,4) DEFAULT '0.0000',
  `GLCurrentYearPeriod11` decimal(19,4) DEFAULT '0.0000',
  `GLCurrentYearPeriod12` decimal(19,4) DEFAULT '0.0000',
  `GLCurrentYearPeriod13` decimal(19,4) DEFAULT '0.0000',
  `GLCurrentYearPeriod14` decimal(19,4) DEFAULT '0.0000',
  `GLBudgetBeginningBalance` decimal(19,4) DEFAULT '0.0000',
  `GLBudgetPeriod1` decimal(19,4) DEFAULT '0.0000',
  `GLBudgetPeriod2` decimal(19,4) DEFAULT '0.0000',
  `GLBudgetPeriod3` decimal(19,4) DEFAULT '0.0000',
  `GLBudgetPeriod4` decimal(19,4) DEFAULT '0.0000',
  `GLBudgetPeriod5` decimal(19,4) DEFAULT '0.0000',
  `GLBudgetPeriod6` decimal(19,4) DEFAULT '0.0000',
  `GLBudgetPeriod7` decimal(19,4) DEFAULT '0.0000',
  `GLBudgetPeriod8` decimal(19,4) DEFAULT '0.0000',
  `GLBudgetPeriod9` decimal(19,4) DEFAULT '0.0000',
  `GLBudgetPeriod10` decimal(19,4) DEFAULT '0.0000',
  `GLBudgetPeriod11` decimal(19,4) DEFAULT '0.0000',
  `GLBudgetPeriod12` decimal(19,4) DEFAULT '0.0000',
  `GLBudgetPeriod13` decimal(19,4) DEFAULT '0.0000',
  `GLBudgetPeriod14` decimal(19,4) DEFAULT '0.0000',
  `GLPriorFiscalYear` datetime DEFAULT NULL,
  `GLPriorYearBeginningBalance` decimal(19,4) DEFAULT '0.0000',
  `GLPriorYearPeriod1` decimal(19,4) DEFAULT '0.0000',
  `GLPriorYearPeriod2` decimal(19,4) DEFAULT '0.0000',
  `GLPriorYearPeriod3` decimal(19,4) DEFAULT NULL,
  `GLPriorYearPeriod4` decimal(19,4) DEFAULT '0.0000',
  `GLPriortYearPeriod5` decimal(19,4) DEFAULT '0.0000',
  `GLPriorYearPeriod6` decimal(19,4) DEFAULT '0.0000',
  `GLPriorYearPeriod7` decimal(19,4) DEFAULT '0.0000',
  `GLPriorYearPeriod8` decimal(19,4) DEFAULT '0.0000',
  `GLPriorYearPeriod9` decimal(19,4) DEFAULT '0.0000',
  `GLPriortYearPeriod10` decimal(19,4) DEFAULT '0.0000',
  `GLPriorYearPeriod11` decimal(19,4) DEFAULT '0.0000',
  `GLPriorYearPeriod12` decimal(19,4) DEFAULT '0.0000',
  `GLPriorYearPeriod13` decimal(19,4) DEFAULT '0.0000',
  `GLPriorYearPeriod14` decimal(19,4) DEFAULT '0.0000',
  `LockedBy` varchar(36) DEFAULT NULL,
  `LockTS` datetime DEFAULT NULL,
  PRIMARY KEY (`Industry`, `ChartType`, `CompanyID`,`DivisionID`,`DepartmentID`,`GLAccountNumber`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ledgerstoredchartofaccounts`
--

LOCK TABLES `ledgerstoredchartofaccounts` WRITE;
/*!40000 ALTER TABLE `ledgerstoredchartofaccounts` DISABLE KEYS */;
/*!40000 ALTER TABLE `ledgerstoredchartofaccounts` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-07-11 14:46:21
