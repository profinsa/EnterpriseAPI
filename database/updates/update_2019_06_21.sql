update databaseinfo set value='2019_06_21',lastupdate=now() WHERE id='Version';
 
DROP TABLE IF EXISTS `helpdocumenttopic`;
CREATE TABLE `helpdocumenttopic` (
  `CompanyID` varchar(36) NOT NULL,
  `DivisionID` varchar(36) NOT NULL,
  `DepartmentID` varchar(36) NOT NULL,
  `DocumentTopicID` varchar(36) NOT NULL,
  `DocumentTopicDescription` varchar(60),
  `LockedBy` varchar(36) DEFAULT NULL,
  `LockTS` datetime DEFAULT NULL,
  PRIMARY KEY (`CompanyID`,`DivisionID`,`DepartmentID`,`DocumentTopicID`)
) ENGINE=InnoDB AUTO_INCREMENT=81 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `helpdocumentmodule`;
CREATE TABLE `helpdocumentmodule` (
  `CompanyID` varchar(36) NOT NULL,
  `DivisionID` varchar(36) NOT NULL,
  `DepartmentID` varchar(36) NOT NULL,
  `DocumentModuleID` varchar(36) NOT NULL,
  `DocumentModuleDescription` varchar(60),
  `LockedBy` varchar(36) DEFAULT NULL,
  `LockTS` datetime DEFAULT NULL,
  PRIMARY KEY (`CompanyID`,`DivisionID`,`DepartmentID`,`DocumentModuleID`)
) ENGINE=InnoDB AUTO_INCREMENT=81 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `helpdocument`;
CREATE TABLE `helpdocument` (
  `CompanyID` varchar(36) NOT NULL,
  `DivisionID` varchar(36) NOT NULL,
  `DepartmentID` varchar(36) NOT NULL,
  `DocumentTitleID` varchar(36) NOT NULL,
  `DocumentTitleTitle` varchar(60),
  `DocumentTopic` varchar(36),
  `DocumentModule` varchar(36),
  `DocumentURL` TEXT,
  `DocumentContents` LONGTEXT,
  `LockedBy` varchar(36) DEFAULT NULL,
  `LockTS` datetime DEFAULT NULL,
  PRIMARY KEY (`CompanyID`,`DivisionID`,`DepartmentID`,`DocumentTitleID`)
) ENGINE=InnoDB AUTO_INCREMENT=81 DEFAULT CHARSET=utf8;
