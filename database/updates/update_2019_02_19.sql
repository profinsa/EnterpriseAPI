











-- ----------------------------
--  Table structure for `ediaddresses`
-- ----------------------------
DROP TABLE IF EXISTS `ediaddresses`;
CREATE TABLE `ediaddresses` (
  `CompanyID` varchar(36) NOT NULL,
  `DivisionID` varchar(36) NOT NULL,
  `DepartmentID` varchar(36) NOT NULL,
  `ReferenceID` varchar(36) NOT NULL,
  `ReferenceAddressShipTo` varchar(36) NOT NULL,
  `ReferenceAddressShipFor` varchar(36) DEFAULT NULL,
  `EDIDirectionTypeID` varchar(1) DEFAULT NULL,
  `EDIDocumentTypeID` varchar(3) DEFAULT NULL,
  `EDIOpen` tinyint(1) DEFAULT NULL,
  `ShipName` varchar(50) DEFAULT NULL,
  `ShipAddress1` varchar(50) DEFAULT NULL,
  `ShipAddress2` varchar(50) DEFAULT NULL,
  `ShipAddress3` varchar(50) DEFAULT NULL,
  `ShipCity` varchar(50) DEFAULT NULL,
  `ShipState` varchar(50) DEFAULT NULL,
  `ShipZip` varchar(10) DEFAULT NULL,
  `ShipCountry` varchar(50) DEFAULT NULL,
  `ShipAttention` varchar(50) DEFAULT NULL,
  `ShipPhone` varchar(36) DEFAULT NULL,
  `ShipFax` varchar(36) DEFAULT NULL,
  `ShipEmail` varchar(60) DEFAULT NULL,
  `ShipWebPage` varchar(80) DEFAULT NULL,
  `ShipNotes` varchar(255) DEFAULT NULL,
  `LockedBy` varchar(36) DEFAULT NULL,
  `LockTS` datetime DEFAULT NULL,
  PRIMARY KEY (`CompanyID`,`DivisionID`,`DepartmentID`,`ReferenceID`,`ReferenceAddressShipTo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
delimiter ;;
CREATE TRIGGER `EDIAddresses_Audit_Insert` AFTER INSERT ON `ediaddresses` FOR EACH ROW SWL_return:
BEGIN
   DECLARE NO_DATA INT DEFAULT 0;
   DECLARE v_Context VARBINARY(128);
   DECLARE v_TransactionNumber NATIONAL VARCHAR(50);
   DECLARE v_TransactionLineNumber NATIONAL VARCHAR(50);

   DECLARE v_CompanyID NATIONAL VARCHAR(36);
   DECLARE v_DivisionID NATIONAL VARCHAR(36);
   DECLARE v_DepartmentID NATIONAL VARCHAR(36);
   DECLARE v_ReferenceID NATIONAL VARCHAR(36);
   DECLARE v_ReferenceAddressShipTo NATIONAL VARCHAR(36);

-- inserting records cursor declaration
   DECLARE cInsert CURSOR
   FOR SELECT
   i.ReferenceID
		,i.ReferenceAddressShipTo

		,i.CompanyID
		,i.DivisionID
		,i.DepartmentID
		,i.ReferenceID
		,i.ReferenceAddressShipTo

   FROM
   InsEDIAddresses i;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET NO_DATA = -2;
   END;
   DECLARE CONTINUE HANDLER FOR NOT FOUND SET NO_DATA = -1;
   CREATE  TEMPORARY TABLE IF NOT EXISTS InsEDIAddresses
   (
      CompanyID NATIONAL VARCHAR(36),
      DivisionID NATIONAL VARCHAR(36),
      DepartmentID NATIONAL VARCHAR(36),
      ReferenceID NATIONAL VARCHAR(36),
      ReferenceAddressShipTo NATIONAL VARCHAR(36),
      ReferenceAddressShipFor NATIONAL VARCHAR(36),
      EDIDirectionTypeID NATIONAL VARCHAR(1),
      EDIDocumentTypeID NATIONAL VARCHAR(3),
      EDIOpen BOOLEAN,
      ShipName NATIONAL VARCHAR(50),
      ShipAddress1 NATIONAL VARCHAR(50),
      ShipAddress2 NATIONAL VARCHAR(50),
      ShipAddress3 NATIONAL VARCHAR(50),
      ShipCity NATIONAL VARCHAR(50),
      ShipState NATIONAL VARCHAR(50),
      ShipZip NATIONAL VARCHAR(10),
      ShipCountry NATIONAL VARCHAR(50),
      ShipAttention NATIONAL VARCHAR(50),
      ShipPhone NATIONAL VARCHAR(36),
      ShipFax NATIONAL VARCHAR(36),
      ShipEmail NATIONAL VARCHAR(60),
      ShipWebPage NATIONAL VARCHAR(80),
      ShipNotes NATIONAL VARCHAR(255),
      LockedBy NATIONAL VARCHAR(36),
      LockTS DATETIME
   );
   DELETE FROM InsEDIAddresses;
   INSERT INTO InsEDIAddresses VALUES(NEW.CompanyID, NEW.DivisionID, NEW.DepartmentID, NEW.ReferenceID, NEW.ReferenceAddressShipTo, NEW.ReferenceAddressShipFor, NEW.EDIDirectionTypeID, NEW.EDIDocumentTypeID, NEW.EDIOpen, NEW.ShipName, NEW.ShipAddress1, NEW.ShipAddress2, NEW.ShipAddress3, NEW.ShipCity, NEW.ShipState, NEW.ShipZip, NEW.ShipCountry, NEW.ShipAttention, NEW.ShipPhone, NEW.ShipFax, NEW.ShipEmail, NEW.ShipWebPage, NEW.ShipNotes, NEW.LockedBy, NEW.LockTS);

   BEGIN
-- check for audit triggers switch off

      select   context_info INTO v_Context FROM sysprocesses WHERE spid = CONNECTION_ID();
      IF CAST(v_Context AS CHAR(36)) = N'$$AuditSwitchOff$$' then 
         LEAVE SWL_return;
      end if;

-- declarations
      OPEN cInsert;
-- fetch from each inserting record
      SET NO_DATA = 0;
      FETCH cInsert INTO
      v_TransactionNumber,v_TransactionLineNumber,v_CompanyID,v_DivisionID,v_DepartmentID,
      v_ReferenceID,v_ReferenceAddressShipTo;
      WHILE NO_DATA = 0 DO
-- insert audit record for each inserting record
         IF IsGuid(v_TransactionNumber) = 0 then
		
            CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber,v_TransactionLineNumber,
            'EDIAddresses','New Record','','New Record');
         end if;
         SET NO_DATA = 0;
         FETCH cInsert INTO
         v_TransactionNumber,v_TransactionLineNumber,v_CompanyID,v_DivisionID,v_DepartmentID,
         v_ReferenceID,v_ReferenceAddressShipTo;
      END WHILE;
      CLOSE cInsert;

   END;
END;
 ;;
delimiter ;
delimiter ;;
CREATE TRIGGER `EDIAddresses_Audit_Update` AFTER UPDATE ON `ediaddresses` FOR EACH ROW SWL_return:
BEGIN
   DECLARE NO_DATA INT DEFAULT 0;
   DECLARE v_Context VARBINARY(128);
   DECLARE v_TransactionNumber_O NATIONAL VARCHAR(50);
   DECLARE v_TransactionNumber_N NATIONAL VARCHAR(50);
   DECLARE v_TransactionLineNumber NATIONAL VARCHAR(50);

   DECLARE v_CompanyID NATIONAL VARCHAR(36);
   DECLARE v_DivisionID NATIONAL VARCHAR(36);
   DECLARE v_DepartmentID NATIONAL VARCHAR(36);
   DECLARE v_ReferenceID NATIONAL VARCHAR(36);
   DECLARE v_ReferenceAddressShipTo NATIONAL VARCHAR(36);

   DECLARE v_ReferenceAddressShipFor_O NATIONAL VARCHAR(80);
   DECLARE v_ReferenceAddressShipFor_N NATIONAL VARCHAR(80);
   DECLARE v_EDIDirectionTypeID_O NATIONAL VARCHAR(80);
   DECLARE v_EDIDirectionTypeID_N NATIONAL VARCHAR(80);
   DECLARE v_EDIDocumentTypeID_O NATIONAL VARCHAR(80);
   DECLARE v_EDIDocumentTypeID_N NATIONAL VARCHAR(80);
   DECLARE v_EDIOpen_O NATIONAL VARCHAR(80);
   DECLARE v_EDIOpen_N NATIONAL VARCHAR(80);
   DECLARE v_ShipName_O NATIONAL VARCHAR(80);
   DECLARE v_ShipName_N NATIONAL VARCHAR(80);
   DECLARE v_ShipAddress1_O NATIONAL VARCHAR(80);
   DECLARE v_ShipAddress1_N NATIONAL VARCHAR(80);
   DECLARE v_ShipAddress2_O NATIONAL VARCHAR(80);
   DECLARE v_ShipAddress2_N NATIONAL VARCHAR(80);
   DECLARE v_ShipAddress3_O NATIONAL VARCHAR(80);
   DECLARE v_ShipAddress3_N NATIONAL VARCHAR(80);
   DECLARE v_ShipCity_O NATIONAL VARCHAR(80);
   DECLARE v_ShipCity_N NATIONAL VARCHAR(80);
   DECLARE v_ShipState_O NATIONAL VARCHAR(80);
   DECLARE v_ShipState_N NATIONAL VARCHAR(80);
   DECLARE v_ShipZip_O NATIONAL VARCHAR(80);
   DECLARE v_ShipZip_N NATIONAL VARCHAR(80);
   DECLARE v_ShipCountry_O NATIONAL VARCHAR(80);
   DECLARE v_ShipCountry_N NATIONAL VARCHAR(80);
   DECLARE v_ShipAttention_O NATIONAL VARCHAR(80);
   DECLARE v_ShipAttention_N NATIONAL VARCHAR(80);
   DECLARE v_ShipPhone_O NATIONAL VARCHAR(80);
   DECLARE v_ShipPhone_N NATIONAL VARCHAR(80);
   DECLARE v_ShipFax_O NATIONAL VARCHAR(80);
   DECLARE v_ShipFax_N NATIONAL VARCHAR(80);
   DECLARE v_ShipEmail_O NATIONAL VARCHAR(80);
   DECLARE v_ShipEmail_N NATIONAL VARCHAR(80);
   DECLARE v_ShipWebPage_O NATIONAL VARCHAR(80);
   DECLARE v_ShipWebPage_N NATIONAL VARCHAR(80);
   DECLARE v_ShipNotes_O NATIONAL VARCHAR(80);
   DECLARE v_ShipNotes_N NATIONAL VARCHAR(80);
 

-- updating records cursor declaration
   DECLARE cUpdate CURSOR
   FOR SELECT
   d.ReferenceID
		,i.ReferenceID
		,i.ReferenceAddressShipTo

		,i.CompanyID
		,i.DivisionID
		,i.DepartmentID
		,i.ReferenceID
		,i.ReferenceAddressShipTo

,CAST(d.ReferenceAddressShipFor AS CHAR(80))
,CAST(i.ReferenceAddressShipFor AS CHAR(80))
,CAST(d.EDIDirectionTypeID AS CHAR(80))
,CAST(i.EDIDirectionTypeID AS CHAR(80))
,CAST(d.EDIDocumentTypeID AS CHAR(80))
,CAST(i.EDIDocumentTypeID AS CHAR(80))
,CAST(d.EDIOpen AS CHAR(80))
,CAST(i.EDIOpen AS CHAR(80))
,CAST(d.ShipName AS CHAR(80))
,CAST(i.ShipName AS CHAR(80))
,CAST(d.ShipAddress1 AS CHAR(80))
,CAST(i.ShipAddress1 AS CHAR(80))
,CAST(d.ShipAddress2 AS CHAR(80))
,CAST(i.ShipAddress2 AS CHAR(80))
,CAST(d.ShipAddress3 AS CHAR(80))
,CAST(i.ShipAddress3 AS CHAR(80))
,CAST(d.ShipCity AS CHAR(80))
,CAST(i.ShipCity AS CHAR(80))
,CAST(d.ShipState AS CHAR(80))
,CAST(i.ShipState AS CHAR(80))
,CAST(d.ShipZip AS CHAR(80))
,CAST(i.ShipZip AS CHAR(80))
,CAST(d.ShipCountry AS CHAR(80))
,CAST(i.ShipCountry AS CHAR(80))
,CAST(d.ShipAttention AS CHAR(80))
,CAST(i.ShipAttention AS CHAR(80))
,CAST(d.ShipPhone AS CHAR(80))
,CAST(i.ShipPhone AS CHAR(80))
,CAST(d.ShipFax AS CHAR(80))
,CAST(i.ShipFax AS CHAR(80))
,CAST(d.ShipEmail AS CHAR(80))
,CAST(i.ShipEmail AS CHAR(80))
,CAST(d.ShipWebPage AS CHAR(80))
,CAST(i.ShipWebPage AS CHAR(80))
,CAST(d.ShipNotes AS CHAR(80))
,CAST(i.ShipNotes AS CHAR(80))
 

   FROM
   InsEDIAddresses i
   LEFT OUTER JOIN DelEDIAddresses d ON
   d.CompanyID = i.CompanyID
   AND d.DivisionID = i.DivisionID
   AND d.DepartmentID = i.DepartmentID
   AND d.ReferenceID = i.ReferenceID
   AND d.ReferenceAddressShipTo = i.ReferenceAddressShipTo;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET NO_DATA = -2;
   END;
   DECLARE CONTINUE HANDLER FOR NOT FOUND SET NO_DATA = -1;
   CREATE  TEMPORARY TABLE IF NOT EXISTS InsEDIAddresses
   (
      CompanyID NATIONAL VARCHAR(36),
      DivisionID NATIONAL VARCHAR(36),
      DepartmentID NATIONAL VARCHAR(36),
      ReferenceID NATIONAL VARCHAR(36),
      ReferenceAddressShipTo NATIONAL VARCHAR(36),
      ReferenceAddressShipFor NATIONAL VARCHAR(36),
      EDIDirectionTypeID NATIONAL VARCHAR(1),
      EDIDocumentTypeID NATIONAL VARCHAR(3),
      EDIOpen BOOLEAN,
      ShipName NATIONAL VARCHAR(50),
      ShipAddress1 NATIONAL VARCHAR(50),
      ShipAddress2 NATIONAL VARCHAR(50),
      ShipAddress3 NATIONAL VARCHAR(50),
      ShipCity NATIONAL VARCHAR(50),
      ShipState NATIONAL VARCHAR(50),
      ShipZip NATIONAL VARCHAR(10),
      ShipCountry NATIONAL VARCHAR(50),
      ShipAttention NATIONAL VARCHAR(50),
      ShipPhone NATIONAL VARCHAR(36),
      ShipFax NATIONAL VARCHAR(36),
      ShipEmail NATIONAL VARCHAR(60),
      ShipWebPage NATIONAL VARCHAR(80),
      ShipNotes NATIONAL VARCHAR(255),
      LockedBy NATIONAL VARCHAR(36),
      LockTS DATETIME
   );
   DELETE FROM InsEDIAddresses;
   INSERT INTO InsEDIAddresses VALUES(NEW.CompanyID, NEW.DivisionID, NEW.DepartmentID, NEW.ReferenceID, NEW.ReferenceAddressShipTo, NEW.ReferenceAddressShipFor, NEW.EDIDirectionTypeID, NEW.EDIDocumentTypeID, NEW.EDIOpen, NEW.ShipName, NEW.ShipAddress1, NEW.ShipAddress2, NEW.ShipAddress3, NEW.ShipCity, NEW.ShipState, NEW.ShipZip, NEW.ShipCountry, NEW.ShipAttention, NEW.ShipPhone, NEW.ShipFax, NEW.ShipEmail, NEW.ShipWebPage, NEW.ShipNotes, NEW.LockedBy, NEW.LockTS);

   CREATE  TEMPORARY TABLE IF NOT EXISTS DelEDIAddresses
   (
      CompanyID NATIONAL VARCHAR(36),
      DivisionID NATIONAL VARCHAR(36),
      DepartmentID NATIONAL VARCHAR(36),
      ReferenceID NATIONAL VARCHAR(36),
      ReferenceAddressShipTo NATIONAL VARCHAR(36),
      ReferenceAddressShipFor NATIONAL VARCHAR(36),
      EDIDirectionTypeID NATIONAL VARCHAR(1),
      EDIDocumentTypeID NATIONAL VARCHAR(3),
      EDIOpen BOOLEAN,
      ShipName NATIONAL VARCHAR(50),
      ShipAddress1 NATIONAL VARCHAR(50),
      ShipAddress2 NATIONAL VARCHAR(50),
      ShipAddress3 NATIONAL VARCHAR(50),
      ShipCity NATIONAL VARCHAR(50),
      ShipState NATIONAL VARCHAR(50),
      ShipZip NATIONAL VARCHAR(10),
      ShipCountry NATIONAL VARCHAR(50),
      ShipAttention NATIONAL VARCHAR(50),
      ShipPhone NATIONAL VARCHAR(36),
      ShipFax NATIONAL VARCHAR(36),
      ShipEmail NATIONAL VARCHAR(60),
      ShipWebPage NATIONAL VARCHAR(80),
      ShipNotes NATIONAL VARCHAR(255),
      LockedBy NATIONAL VARCHAR(36),
      LockTS DATETIME
   );
   DELETE FROM DelEDIAddresses;
   INSERT INTO DelEDIAddresses VALUES(OLD.CompanyID, OLD.DivisionID, OLD.DepartmentID, OLD.ReferenceID, OLD.ReferenceAddressShipTo, OLD.ReferenceAddressShipFor, OLD.EDIDirectionTypeID, OLD.EDIDocumentTypeID, OLD.EDIOpen, OLD.ShipName, OLD.ShipAddress1, OLD.ShipAddress2, OLD.ShipAddress3, OLD.ShipCity, OLD.ShipState, OLD.ShipZip, OLD.ShipCountry, OLD.ShipAttention, OLD.ShipPhone, OLD.ShipFax, OLD.ShipEmail, OLD.ShipWebPage, OLD.ShipNotes, OLD.LockedBy, OLD.LockTS);

   BEGIN
-- check for audit triggers switch off

      select   context_info INTO v_Context FROM sysprocesses WHERE spid = CONNECTION_ID();
      IF CAST(v_Context AS CHAR(36)) = N'$$AuditSwitchOff$$' then 
         LEAVE SWL_return;
      end if;

-- declarations
      OPEN cUpdate;
-- fetch from each updating record
      SET NO_DATA = 0;
      FETCH cUpdate INTO
      v_TransactionNumber_O,v_TransactionNumber_N,v_TransactionLineNumber,v_CompanyID,
      v_DivisionID,v_DepartmentID,v_ReferenceID,v_ReferenceAddressShipTo,
      v_ReferenceAddressShipFor_O,v_ReferenceAddressShipFor_N,v_EDIDirectionTypeID_O,
      v_EDIDirectionTypeID_N,v_EDIDocumentTypeID_O,v_EDIDocumentTypeID_N,
      v_EDIOpen_O,v_EDIOpen_N,v_ShipName_O,v_ShipName_N,v_ShipAddress1_O,
      v_ShipAddress1_N,v_ShipAddress2_O,v_ShipAddress2_N,v_ShipAddress3_O,
      v_ShipAddress3_N,v_ShipCity_O,v_ShipCity_N,v_ShipState_O,v_ShipState_N,
      v_ShipZip_O,v_ShipZip_N,v_ShipCountry_O,v_ShipCountry_N,v_ShipAttention_O,
      v_ShipAttention_N,v_ShipPhone_O,v_ShipPhone_N,v_ShipFax_O,
      v_ShipFax_N,v_ShipEmail_O,v_ShipEmail_N,v_ShipWebPage_O,v_ShipWebPage_N,
      v_ShipNotes_O,v_ShipNotes_N;
      WHILE NO_DATA = 0 DO
-- insert audit records for each changed field

         CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
         'EDIAddresses','ReferenceAddressShipFor',v_ReferenceAddressShipFor_O,
         v_ReferenceAddressShipFor_N);
         CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
         'EDIAddresses','EDIDirectionTypeID',v_EDIDirectionTypeID_O,
         v_EDIDirectionTypeID_N);
         CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
         'EDIAddresses','EDIDocumentTypeID',v_EDIDocumentTypeID_O,
         v_EDIDocumentTypeID_N);
         CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
         'EDIAddresses','EDIOpen',v_EDIOpen_O,v_EDIOpen_N);
         CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
         'EDIAddresses','ShipName',v_ShipName_O,v_ShipName_N);
         CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
         'EDIAddresses','ShipAddress1',v_ShipAddress1_O,v_ShipAddress1_N);
         CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
         'EDIAddresses','ShipAddress2',v_ShipAddress2_O,v_ShipAddress2_N);
         CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
         'EDIAddresses','ShipAddress3',v_ShipAddress3_O,v_ShipAddress3_N);
         CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
         'EDIAddresses','ShipCity',v_ShipCity_O,v_ShipCity_N);
         CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
         'EDIAddresses','ShipState',v_ShipState_O,v_ShipState_N);
         CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
         'EDIAddresses','ShipZip',v_ShipZip_O,v_ShipZip_N);
         CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
         'EDIAddresses','ShipCountry',v_ShipCountry_O,v_ShipCountry_N);
         CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
         'EDIAddresses','ShipAttention',v_ShipAttention_O,
         v_ShipAttention_N);
         CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
         'EDIAddresses','ShipPhone',v_ShipPhone_O,v_ShipPhone_N);
         CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
         'EDIAddresses','ShipFax',v_ShipFax_O,v_ShipFax_N);
         CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
         'EDIAddresses','ShipEmail',v_ShipEmail_O,v_ShipEmail_N);
         CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
         'EDIAddresses','ShipWebPage',v_ShipWebPage_O,v_ShipWebPage_N);
         CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
         'EDIAddresses','ShipNotes',v_ShipNotes_O,v_ShipNotes_N);
         SET NO_DATA = 0;
         FETCH cUpdate INTO
         v_TransactionNumber_O,v_TransactionNumber_N,v_TransactionLineNumber,v_CompanyID,
         v_DivisionID,v_DepartmentID,v_ReferenceID,v_ReferenceAddressShipTo,
         v_ReferenceAddressShipFor_O,v_ReferenceAddressShipFor_N,v_EDIDirectionTypeID_O,
         v_EDIDirectionTypeID_N,v_EDIDocumentTypeID_O,v_EDIDocumentTypeID_N,
         v_EDIOpen_O,v_EDIOpen_N,v_ShipName_O,v_ShipName_N,v_ShipAddress1_O,
         v_ShipAddress1_N,v_ShipAddress2_O,v_ShipAddress2_N,v_ShipAddress3_O,
         v_ShipAddress3_N,v_ShipCity_O,v_ShipCity_N,v_ShipState_O,v_ShipState_N,
         v_ShipZip_O,v_ShipZip_N,v_ShipCountry_O,v_ShipCountry_N,v_ShipAttention_O,
         v_ShipAttention_N,v_ShipPhone_O,v_ShipPhone_N,v_ShipFax_O,
         v_ShipFax_N,v_ShipEmail_O,v_ShipEmail_N,v_ShipWebPage_O,v_ShipWebPage_N,
         v_ShipNotes_O,v_ShipNotes_N;
      END WHILE;
      CLOSE cUpdate;

   END;
END;
 ;;
delimiter ;
delimiter ;;
CREATE TRIGGER `EDIAddresses_Audit_Delete` AFTER DELETE ON `ediaddresses` FOR EACH ROW SWL_return:
BEGIN
   DECLARE NO_DATA INT DEFAULT 0;
   DECLARE v_Context VARBINARY(128);
   DECLARE v_TransactionNumber NATIONAL VARCHAR(50);
   DECLARE v_TransactionLineNumber NATIONAL VARCHAR(50);

   DECLARE v_CompanyID NATIONAL VARCHAR(36);
   DECLARE v_DivisionID NATIONAL VARCHAR(36);
   DECLARE v_DepartmentID NATIONAL VARCHAR(36);
   DECLARE v_ReferenceID NATIONAL VARCHAR(36);
   DECLARE v_ReferenceAddressShipTo NATIONAL VARCHAR(36);

-- deleting records cursor declaration
   DECLARE cDelete CURSOR
   FOR SELECT
   d.ReferenceID
		,d.ReferenceAddressShipTo

		,d.CompanyID
		,d.DivisionID
		,d.DepartmentID
		,d.ReferenceID
		,d.ReferenceAddressShipTo

   FROM
   DelEDIAddresses d;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET NO_DATA = -2;
   END;
   DECLARE CONTINUE HANDLER FOR NOT FOUND SET NO_DATA = -1;
   CREATE  TEMPORARY TABLE IF NOT EXISTS DelEDIAddresses
   (
      CompanyID NATIONAL VARCHAR(36),
      DivisionID NATIONAL VARCHAR(36),
      DepartmentID NATIONAL VARCHAR(36),
      ReferenceID NATIONAL VARCHAR(36),
      ReferenceAddressShipTo NATIONAL VARCHAR(36),
      ReferenceAddressShipFor NATIONAL VARCHAR(36),
      EDIDirectionTypeID NATIONAL VARCHAR(1),
      EDIDocumentTypeID NATIONAL VARCHAR(3),
      EDIOpen BOOLEAN,
      ShipName NATIONAL VARCHAR(50),
      ShipAddress1 NATIONAL VARCHAR(50),
      ShipAddress2 NATIONAL VARCHAR(50),
      ShipAddress3 NATIONAL VARCHAR(50),
      ShipCity NATIONAL VARCHAR(50),
      ShipState NATIONAL VARCHAR(50),
      ShipZip NATIONAL VARCHAR(10),
      ShipCountry NATIONAL VARCHAR(50),
      ShipAttention NATIONAL VARCHAR(50),
      ShipPhone NATIONAL VARCHAR(36),
      ShipFax NATIONAL VARCHAR(36),
      ShipEmail NATIONAL VARCHAR(60),
      ShipWebPage NATIONAL VARCHAR(80),
      ShipNotes NATIONAL VARCHAR(255),
      LockedBy NATIONAL VARCHAR(36),
      LockTS DATETIME
   );
   DELETE FROM DelEDIAddresses;
   INSERT INTO DelEDIAddresses VALUES(OLD.CompanyID, OLD.DivisionID, OLD.DepartmentID, OLD.ReferenceID, OLD.ReferenceAddressShipTo, OLD.ReferenceAddressShipFor, OLD.EDIDirectionTypeID, OLD.EDIDocumentTypeID, OLD.EDIOpen, OLD.ShipName, OLD.ShipAddress1, OLD.ShipAddress2, OLD.ShipAddress3, OLD.ShipCity, OLD.ShipState, OLD.ShipZip, OLD.ShipCountry, OLD.ShipAttention, OLD.ShipPhone, OLD.ShipFax, OLD.ShipEmail, OLD.ShipWebPage, OLD.ShipNotes, OLD.LockedBy, OLD.LockTS);

   BEGIN
-- check for audit triggers switch off

      select   context_info INTO v_Context FROM sysprocesses WHERE spid = CONNECTION_ID();
      IF CAST(v_Context AS CHAR(36)) = N'$$AuditSwitchOff$$' then 
         LEAVE SWL_return;
      end if;

-- declarations
      OPEN cDelete;
-- fetch from each deleting record
      SET NO_DATA = 0;
      FETCH cDelete INTO
      v_TransactionNumber,v_TransactionLineNumber,v_CompanyID,v_DivisionID,v_DepartmentID,
      v_ReferenceID,v_ReferenceAddressShipTo;
      WHILE NO_DATA = 0 DO
-- insert audit record for each deleting record
         CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber,v_TransactionLineNumber,
         'EDIAddresses','Deleted','','Deleted');
         SET NO_DATA = 0;
         FETCH cDelete INTO
         v_TransactionNumber,v_TransactionLineNumber,v_CompanyID,v_DivisionID,v_DepartmentID,
         v_ReferenceID,v_ReferenceAddressShipTo;
      END WHILE;
      CLOSE cDelete;

   END;
END;
 ;;
delimiter ;

-- ----------------------------
--  Table structure for `edidirection`
-- ----------------------------
DROP TABLE IF EXISTS `edidirection`;
CREATE TABLE `edidirection` (
  `CompanyID` varchar(36) NOT NULL,
  `DivisionID` varchar(36) NOT NULL,
  `DepartmentID` varchar(36) NOT NULL,
  `DirectionTypeID` varchar(36) NOT NULL,
  `DirectionTypeDescription` varchar(15) DEFAULT NULL,
  `LockedBy` varchar(36) DEFAULT NULL,
  `LockTS` datetime DEFAULT NULL,
  PRIMARY KEY (`CompanyID`,`DivisionID`,`DepartmentID`,`DirectionTypeID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
delimiter ;;
CREATE TRIGGER `EDIDirection_Audit_Insert` AFTER INSERT ON `edidirection` FOR EACH ROW SWL_return:
BEGIN
   DECLARE NO_DATA INT DEFAULT 0;
   DECLARE v_Context VARBINARY(128);
   DECLARE v_TransactionNumber NATIONAL VARCHAR(50);
   DECLARE v_TransactionLineNumber NATIONAL VARCHAR(50);

   DECLARE v_CompanyID NATIONAL VARCHAR(36);
   DECLARE v_DivisionID NATIONAL VARCHAR(36);
   DECLARE v_DepartmentID NATIONAL VARCHAR(36);
   DECLARE v_DirectionTypeID NATIONAL VARCHAR(36);

-- inserting records cursor declaration
   DECLARE cInsert CURSOR
   FOR SELECT
   i.DirectionTypeID
		,''

		,i.CompanyID
		,i.DivisionID
		,i.DepartmentID
		,i.DirectionTypeID

   FROM
   InsEDIDirection i;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET NO_DATA = -2;
   END;
   DECLARE CONTINUE HANDLER FOR NOT FOUND SET NO_DATA = -1;
   CREATE  TEMPORARY TABLE IF NOT EXISTS InsEDIDirection
   (
      CompanyID NATIONAL VARCHAR(36),
      DivisionID NATIONAL VARCHAR(36),
      DepartmentID NATIONAL VARCHAR(36),
      DirectionTypeID NATIONAL VARCHAR(36),
      DirectionTypeDescription NATIONAL VARCHAR(15),
      LockedBy NATIONAL VARCHAR(36),
      LockTS DATETIME
   );
   DELETE FROM InsEDIDirection;
   INSERT INTO InsEDIDirection VALUES(NEW.CompanyID, NEW.DivisionID, NEW.DepartmentID, NEW.DirectionTypeID, NEW.DirectionTypeDescription, NEW.LockedBy, NEW.LockTS);

   BEGIN
-- check for audit triggers switch off

      select   context_info INTO v_Context FROM sysprocesses WHERE spid = CONNECTION_ID();
      IF CAST(v_Context AS CHAR(36)) = N'$$AuditSwitchOff$$' then 
         LEAVE SWL_return;
      end if;

-- declarations
      OPEN cInsert;
-- fetch from each inserting record
      SET NO_DATA = 0;
      FETCH cInsert INTO
      v_TransactionNumber,v_TransactionLineNumber,v_CompanyID,v_DivisionID,v_DepartmentID,
      v_DirectionTypeID;
      WHILE NO_DATA = 0 DO
-- insert audit record for each inserting record
         IF IsGuid(v_TransactionNumber) = 0 then
		
            CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber,v_TransactionLineNumber,
            'EDIDirection','New Record','','New Record');
         end if;
         SET NO_DATA = 0;
         FETCH cInsert INTO
         v_TransactionNumber,v_TransactionLineNumber,v_CompanyID,v_DivisionID,v_DepartmentID,
         v_DirectionTypeID;
      END WHILE;
      CLOSE cInsert;

   END;
END;
 ;;
delimiter ;
delimiter ;;
CREATE TRIGGER `EDIDirection_Audit_Update` AFTER UPDATE ON `edidirection` FOR EACH ROW SWL_return:
BEGIN
   DECLARE NO_DATA INT DEFAULT 0;
   DECLARE v_Context VARBINARY(128);
   DECLARE v_TransactionNumber_O NATIONAL VARCHAR(50);
   DECLARE v_TransactionNumber_N NATIONAL VARCHAR(50);
   DECLARE v_TransactionLineNumber NATIONAL VARCHAR(50);

   DECLARE v_CompanyID NATIONAL VARCHAR(36);
   DECLARE v_DivisionID NATIONAL VARCHAR(36);
   DECLARE v_DepartmentID NATIONAL VARCHAR(36);
   DECLARE v_DirectionTypeID NATIONAL VARCHAR(36);

   DECLARE v_DirectionTypeDescription_O NATIONAL VARCHAR(80);
   DECLARE v_DirectionTypeDescription_N NATIONAL VARCHAR(80);
 

-- updating records cursor declaration
   DECLARE cUpdate CURSOR
   FOR SELECT
   d.DirectionTypeID
		,i.DirectionTypeID
		,''

		,i.CompanyID
		,i.DivisionID
		,i.DepartmentID
		,i.DirectionTypeID

,CAST(d.DirectionTypeDescription AS CHAR(80))
,CAST(i.DirectionTypeDescription AS CHAR(80))
 

   FROM
   InsEDIDirection i
   LEFT OUTER JOIN DelEDIDirection d ON
   d.CompanyID = i.CompanyID
   AND d.DivisionID = i.DivisionID
   AND d.DepartmentID = i.DepartmentID
   AND d.DirectionTypeID = i.DirectionTypeID;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET NO_DATA = -2;
   END;
   DECLARE CONTINUE HANDLER FOR NOT FOUND SET NO_DATA = -1;
   CREATE  TEMPORARY TABLE IF NOT EXISTS InsEDIDirection
   (
      CompanyID NATIONAL VARCHAR(36),
      DivisionID NATIONAL VARCHAR(36),
      DepartmentID NATIONAL VARCHAR(36),
      DirectionTypeID NATIONAL VARCHAR(36),
      DirectionTypeDescription NATIONAL VARCHAR(15),
      LockedBy NATIONAL VARCHAR(36),
      LockTS DATETIME
   );
   DELETE FROM InsEDIDirection;
   INSERT INTO InsEDIDirection VALUES(NEW.CompanyID, NEW.DivisionID, NEW.DepartmentID, NEW.DirectionTypeID, NEW.DirectionTypeDescription, NEW.LockedBy, NEW.LockTS);

   CREATE  TEMPORARY TABLE IF NOT EXISTS DelEDIDirection
   (
      CompanyID NATIONAL VARCHAR(36),
      DivisionID NATIONAL VARCHAR(36),
      DepartmentID NATIONAL VARCHAR(36),
      DirectionTypeID NATIONAL VARCHAR(36),
      DirectionTypeDescription NATIONAL VARCHAR(15),
      LockedBy NATIONAL VARCHAR(36),
      LockTS DATETIME
   );
   DELETE FROM DelEDIDirection;
   INSERT INTO DelEDIDirection VALUES(OLD.CompanyID, OLD.DivisionID, OLD.DepartmentID, OLD.DirectionTypeID, OLD.DirectionTypeDescription, OLD.LockedBy, OLD.LockTS);

   BEGIN
-- check for audit triggers switch off

      select   context_info INTO v_Context FROM sysprocesses WHERE spid = CONNECTION_ID();
      IF CAST(v_Context AS CHAR(36)) = N'$$AuditSwitchOff$$' then 
         LEAVE SWL_return;
      end if;

-- declarations
      OPEN cUpdate;
-- fetch from each updating record
      SET NO_DATA = 0;
      FETCH cUpdate INTO
      v_TransactionNumber_O,v_TransactionNumber_N,v_TransactionLineNumber,v_CompanyID,
      v_DivisionID,v_DepartmentID,v_DirectionTypeID,v_DirectionTypeDescription_O,
      v_DirectionTypeDescription_N;
      WHILE NO_DATA = 0 DO
-- insert audit records for each changed field

         CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
         'EDIDirection','DirectionTypeDescription',v_DirectionTypeDescription_O,
         v_DirectionTypeDescription_N);
         SET NO_DATA = 0;
         FETCH cUpdate INTO
         v_TransactionNumber_O,v_TransactionNumber_N,v_TransactionLineNumber,v_CompanyID,
         v_DivisionID,v_DepartmentID,v_DirectionTypeID,v_DirectionTypeDescription_O,
         v_DirectionTypeDescription_N;
      END WHILE;
      CLOSE cUpdate;

   END;
END;
 ;;
delimiter ;
delimiter ;;
CREATE TRIGGER `EDIDirection_Audit_Delete` AFTER DELETE ON `edidirection` FOR EACH ROW SWL_return:
BEGIN
   DECLARE NO_DATA INT DEFAULT 0;
   DECLARE v_Context VARBINARY(128);
   DECLARE v_TransactionNumber NATIONAL VARCHAR(50);
   DECLARE v_TransactionLineNumber NATIONAL VARCHAR(50);

   DECLARE v_CompanyID NATIONAL VARCHAR(36);
   DECLARE v_DivisionID NATIONAL VARCHAR(36);
   DECLARE v_DepartmentID NATIONAL VARCHAR(36);
   DECLARE v_DirectionTypeID NATIONAL VARCHAR(36);

-- deleting records cursor declaration
   DECLARE cDelete CURSOR
   FOR SELECT
   d.DirectionTypeID
		,''

		,d.CompanyID
		,d.DivisionID
		,d.DepartmentID
		,d.DirectionTypeID

   FROM
   DelEDIDirection d;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET NO_DATA = -2;
   END;
   DECLARE CONTINUE HANDLER FOR NOT FOUND SET NO_DATA = -1;
   CREATE  TEMPORARY TABLE IF NOT EXISTS DelEDIDirection
   (
      CompanyID NATIONAL VARCHAR(36),
      DivisionID NATIONAL VARCHAR(36),
      DepartmentID NATIONAL VARCHAR(36),
      DirectionTypeID NATIONAL VARCHAR(36),
      DirectionTypeDescription NATIONAL VARCHAR(15),
      LockedBy NATIONAL VARCHAR(36),
      LockTS DATETIME
   );
   DELETE FROM DelEDIDirection;
   INSERT INTO DelEDIDirection VALUES(OLD.CompanyID, OLD.DivisionID, OLD.DepartmentID, OLD.DirectionTypeID, OLD.DirectionTypeDescription, OLD.LockedBy, OLD.LockTS);

   BEGIN
-- check for audit triggers switch off

      select   context_info INTO v_Context FROM sysprocesses WHERE spid = CONNECTION_ID();
      IF CAST(v_Context AS CHAR(36)) = N'$$AuditSwitchOff$$' then 
         LEAVE SWL_return;
      end if;

-- declarations
      OPEN cDelete;
-- fetch from each deleting record
      SET NO_DATA = 0;
      FETCH cDelete INTO
      v_TransactionNumber,v_TransactionLineNumber,v_CompanyID,v_DivisionID,v_DepartmentID,
      v_DirectionTypeID;
      WHILE NO_DATA = 0 DO
-- insert audit record for each deleting record
         CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber,v_TransactionLineNumber,
         'EDIDirection','Deleted','','Deleted');
         SET NO_DATA = 0;
         FETCH cDelete INTO
         v_TransactionNumber,v_TransactionLineNumber,v_CompanyID,v_DivisionID,v_DepartmentID,
         v_DirectionTypeID;
      END WHILE;
      CLOSE cDelete;

   END;
END;
 ;;
delimiter ;

-- ----------------------------
--  Records of `edidirection`
-- ----------------------------
BEGIN;
INSERT INTO `edidirection` VALUES ('DEFAULT', 'DEFAULT', 'DEFAULT', 'I', 'Inbound Trans', null, null), ('DEFAULT', 'DEFAULT', 'DEFAULT', 'O', 'Outbound Trans', null, null), ('DINOS', 'DEFAULT', 'DEFAULT', 'I', 'Inbound Trans', null, null), ('DINOS', 'DEFAULT', 'DEFAULT', 'O', 'Outbound Trans', null, null), ('DINOS', 'DEFAULT', 'PAYROLL', 'I', 'Inbound Trans', null, null), ('DINOS', 'DEFAULT', 'PAYROLL', 'O', 'Outbound Trans', null, null), ('DINOSFUND', 'DEFAULT', 'DEFAULT', 'I', 'Inbound Trans', null, null), ('DINOSFUND', 'DEFAULT', 'DEFAULT', 'O', 'Outbound Trans', null, null), ('DINOSFUND', 'DEFAULT', 'PAYROLL', 'I', 'Inbound Trans', null, null), ('DINOSFUND', 'DEFAULT', 'PAYROLL', 'O', 'Outbound Trans', null, null);
COMMIT;

-- ----------------------------
--  Table structure for `edidocumenttypes`
-- ----------------------------
DROP TABLE IF EXISTS `edidocumenttypes`;
CREATE TABLE `edidocumenttypes` (
  `CompanyID` varchar(36) NOT NULL,
  `DivisionID` varchar(36) NOT NULL,
  `DepartmentID` varchar(36) NOT NULL,
  `EDIDocumentTypeID` varchar(36) NOT NULL,
  `EDIDocumentDescription` varchar(50) DEFAULT NULL,
  `LockedBy` varchar(36) DEFAULT NULL,
  `LockTS` datetime DEFAULT NULL,
  PRIMARY KEY (`CompanyID`,`DivisionID`,`DepartmentID`,`EDIDocumentTypeID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
delimiter ;;
CREATE TRIGGER `EDIDocumentTypes_Audit_Insert` AFTER INSERT ON `edidocumenttypes` FOR EACH ROW SWL_return:
BEGIN
   DECLARE NO_DATA INT DEFAULT 0;
   DECLARE v_Context VARBINARY(128);
   DECLARE v_TransactionNumber NATIONAL VARCHAR(50);
   DECLARE v_TransactionLineNumber NATIONAL VARCHAR(50);

   DECLARE v_CompanyID NATIONAL VARCHAR(36);
   DECLARE v_DivisionID NATIONAL VARCHAR(36);
   DECLARE v_DepartmentID NATIONAL VARCHAR(36);
   DECLARE v_EDIDocumentTypeID NATIONAL VARCHAR(36);

-- inserting records cursor declaration
   DECLARE cInsert CURSOR
   FOR SELECT
   i.EDIDocumentTypeID
		,''

		,i.CompanyID
		,i.DivisionID
		,i.DepartmentID
		,i.EDIDocumentTypeID

   FROM
   InsEDIDocumentTypes i;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET NO_DATA = -2;
   END;
   DECLARE CONTINUE HANDLER FOR NOT FOUND SET NO_DATA = -1;
   CREATE  TEMPORARY TABLE IF NOT EXISTS InsEDIDocumentTypes
   (
      CompanyID NATIONAL VARCHAR(36),
      DivisionID NATIONAL VARCHAR(36),
      DepartmentID NATIONAL VARCHAR(36),
      EDIDocumentTypeID NATIONAL VARCHAR(36),
      EDIDocumentDescription NATIONAL VARCHAR(50),
      LockedBy NATIONAL VARCHAR(36),
      LockTS DATETIME
   );
   DELETE FROM InsEDIDocumentTypes;
   INSERT INTO InsEDIDocumentTypes VALUES(NEW.CompanyID, NEW.DivisionID, NEW.DepartmentID, NEW.EDIDocumentTypeID, NEW.EDIDocumentDescription, NEW.LockedBy, NEW.LockTS);

   BEGIN
-- check for audit triggers switch off

      select   context_info INTO v_Context FROM sysprocesses WHERE spid = CONNECTION_ID();
      IF CAST(v_Context AS CHAR(36)) = N'$$AuditSwitchOff$$' then 
         LEAVE SWL_return;
      end if;

-- declarations
      OPEN cInsert;
-- fetch from each inserting record
      SET NO_DATA = 0;
      FETCH cInsert INTO
      v_TransactionNumber,v_TransactionLineNumber,v_CompanyID,v_DivisionID,v_DepartmentID,
      v_EDIDocumentTypeID;
      WHILE NO_DATA = 0 DO
-- insert audit record for each inserting record
         IF IsGuid(v_TransactionNumber) = 0 then
		
            CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber,v_TransactionLineNumber,
            'EDIDocumentTypes','New Record','','New Record');
         end if;
         SET NO_DATA = 0;
         FETCH cInsert INTO
         v_TransactionNumber,v_TransactionLineNumber,v_CompanyID,v_DivisionID,v_DepartmentID,
         v_EDIDocumentTypeID;
      END WHILE;
      CLOSE cInsert;

   END;
END;
 ;;
delimiter ;
delimiter ;;
CREATE TRIGGER `EDIDocumentTypes_Audit_Update` AFTER UPDATE ON `edidocumenttypes` FOR EACH ROW SWL_return:
BEGIN
   DECLARE NO_DATA INT DEFAULT 0;
   DECLARE v_Context VARBINARY(128);
   DECLARE v_TransactionNumber_O NATIONAL VARCHAR(50);
   DECLARE v_TransactionNumber_N NATIONAL VARCHAR(50);
   DECLARE v_TransactionLineNumber NATIONAL VARCHAR(50);

   DECLARE v_CompanyID NATIONAL VARCHAR(36);
   DECLARE v_DivisionID NATIONAL VARCHAR(36);
   DECLARE v_DepartmentID NATIONAL VARCHAR(36);
   DECLARE v_EDIDocumentTypeID NATIONAL VARCHAR(36);

   DECLARE v_EDIDocumentDescription_O NATIONAL VARCHAR(80);
   DECLARE v_EDIDocumentDescription_N NATIONAL VARCHAR(80);
 

-- updating records cursor declaration
   DECLARE cUpdate CURSOR
   FOR SELECT
   d.EDIDocumentTypeID
		,i.EDIDocumentTypeID
		,''

		,i.CompanyID
		,i.DivisionID
		,i.DepartmentID
		,i.EDIDocumentTypeID

,CAST(d.EDIDocumentDescription AS CHAR(80))
,CAST(i.EDIDocumentDescription AS CHAR(80))
 

   FROM
   InsEDIDocumentTypes i
   LEFT OUTER JOIN DelEDIDocumentTypes d ON
   d.CompanyID = i.CompanyID
   AND d.DivisionID = i.DivisionID
   AND d.DepartmentID = i.DepartmentID
   AND d.EDIDocumentTypeID = i.EDIDocumentTypeID;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET NO_DATA = -2;
   END;
   DECLARE CONTINUE HANDLER FOR NOT FOUND SET NO_DATA = -1;
   CREATE  TEMPORARY TABLE IF NOT EXISTS InsEDIDocumentTypes
   (
      CompanyID NATIONAL VARCHAR(36),
      DivisionID NATIONAL VARCHAR(36),
      DepartmentID NATIONAL VARCHAR(36),
      EDIDocumentTypeID NATIONAL VARCHAR(36),
      EDIDocumentDescription NATIONAL VARCHAR(50),
      LockedBy NATIONAL VARCHAR(36),
      LockTS DATETIME
   );
   DELETE FROM InsEDIDocumentTypes;
   INSERT INTO InsEDIDocumentTypes VALUES(NEW.CompanyID, NEW.DivisionID, NEW.DepartmentID, NEW.EDIDocumentTypeID, NEW.EDIDocumentDescription, NEW.LockedBy, NEW.LockTS);

   CREATE  TEMPORARY TABLE IF NOT EXISTS DelEDIDocumentTypes
   (
      CompanyID NATIONAL VARCHAR(36),
      DivisionID NATIONAL VARCHAR(36),
      DepartmentID NATIONAL VARCHAR(36),
      EDIDocumentTypeID NATIONAL VARCHAR(36),
      EDIDocumentDescription NATIONAL VARCHAR(50),
      LockedBy NATIONAL VARCHAR(36),
      LockTS DATETIME
   );
   DELETE FROM DelEDIDocumentTypes;
   INSERT INTO DelEDIDocumentTypes VALUES(OLD.CompanyID, OLD.DivisionID, OLD.DepartmentID, OLD.EDIDocumentTypeID, OLD.EDIDocumentDescription, OLD.LockedBy, OLD.LockTS);

   BEGIN
-- check for audit triggers switch off

      select   context_info INTO v_Context FROM sysprocesses WHERE spid = CONNECTION_ID();
      IF CAST(v_Context AS CHAR(36)) = N'$$AuditSwitchOff$$' then 
         LEAVE SWL_return;
      end if;

-- declarations
      OPEN cUpdate;
-- fetch from each updating record
      SET NO_DATA = 0;
      FETCH cUpdate INTO
      v_TransactionNumber_O,v_TransactionNumber_N,v_TransactionLineNumber,v_CompanyID,
      v_DivisionID,v_DepartmentID,v_EDIDocumentTypeID,v_EDIDocumentDescription_O,
      v_EDIDocumentDescription_N;
      WHILE NO_DATA = 0 DO
-- insert audit records for each changed field

         CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
         'EDIDocumentTypes','EDIDocumentDescription',v_EDIDocumentDescription_O,
         v_EDIDocumentDescription_N);
         SET NO_DATA = 0;
         FETCH cUpdate INTO
         v_TransactionNumber_O,v_TransactionNumber_N,v_TransactionLineNumber,v_CompanyID,
         v_DivisionID,v_DepartmentID,v_EDIDocumentTypeID,v_EDIDocumentDescription_O,
         v_EDIDocumentDescription_N;
      END WHILE;
      CLOSE cUpdate;

   END;
END;
 ;;
delimiter ;
delimiter ;;
CREATE TRIGGER `EDIDocumentTypes_Audit_Delete` AFTER DELETE ON `edidocumenttypes` FOR EACH ROW SWL_return:
BEGIN
   DECLARE NO_DATA INT DEFAULT 0;
   DECLARE v_Context VARBINARY(128);
   DECLARE v_TransactionNumber NATIONAL VARCHAR(50);
   DECLARE v_TransactionLineNumber NATIONAL VARCHAR(50);

   DECLARE v_CompanyID NATIONAL VARCHAR(36);
   DECLARE v_DivisionID NATIONAL VARCHAR(36);
   DECLARE v_DepartmentID NATIONAL VARCHAR(36);
   DECLARE v_EDIDocumentTypeID NATIONAL VARCHAR(36);

-- deleting records cursor declaration
   DECLARE cDelete CURSOR
   FOR SELECT
   d.EDIDocumentTypeID
		,''

		,d.CompanyID
		,d.DivisionID
		,d.DepartmentID
		,d.EDIDocumentTypeID

   FROM
   DelEDIDocumentTypes d;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET NO_DATA = -2;
   END;
   DECLARE CONTINUE HANDLER FOR NOT FOUND SET NO_DATA = -1;
   CREATE  TEMPORARY TABLE IF NOT EXISTS DelEDIDocumentTypes
   (
      CompanyID NATIONAL VARCHAR(36),
      DivisionID NATIONAL VARCHAR(36),
      DepartmentID NATIONAL VARCHAR(36),
      EDIDocumentTypeID NATIONAL VARCHAR(36),
      EDIDocumentDescription NATIONAL VARCHAR(50),
      LockedBy NATIONAL VARCHAR(36),
      LockTS DATETIME
   );
   DELETE FROM DelEDIDocumentTypes;
   INSERT INTO DelEDIDocumentTypes VALUES(OLD.CompanyID, OLD.DivisionID, OLD.DepartmentID, OLD.EDIDocumentTypeID, OLD.EDIDocumentDescription, OLD.LockedBy, OLD.LockTS);

   BEGIN
-- check for audit triggers switch off

      select   context_info INTO v_Context FROM sysprocesses WHERE spid = CONNECTION_ID();
      IF CAST(v_Context AS CHAR(36)) = N'$$AuditSwitchOff$$' then 
         LEAVE SWL_return;
      end if;

-- declarations
      OPEN cDelete;
-- fetch from each deleting record
      SET NO_DATA = 0;
      FETCH cDelete INTO
      v_TransactionNumber,v_TransactionLineNumber,v_CompanyID,v_DivisionID,v_DepartmentID,
      v_EDIDocumentTypeID;
      WHILE NO_DATA = 0 DO
-- insert audit record for each deleting record
         CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber,v_TransactionLineNumber,
         'EDIDocumentTypes','Deleted','','Deleted');
         SET NO_DATA = 0;
         FETCH cDelete INTO
         v_TransactionNumber,v_TransactionLineNumber,v_CompanyID,v_DivisionID,v_DepartmentID,
         v_EDIDocumentTypeID;
      END WHILE;
      CLOSE cDelete;

   END;
END;
 ;;
delimiter ;

-- ----------------------------
--  Records of `edidocumenttypes`
-- ----------------------------
BEGIN;
INSERT INTO `edidocumenttypes` VALUES ('DEFAULT', 'DEFAULT', 'DEFAULT', '810', 'Invoice', null, null), ('DEFAULT', 'DEFAULT', 'DEFAULT', '832', 'Item Informaiton', null, null), ('DEFAULT', 'DEFAULT', 'DEFAULT', '850', 'Order', null, null), ('DEFAULT', 'DEFAULT', 'DEFAULT', '856', 'Advanced Ship Notice', null, null), ('DEFAULT', 'DEFAULT', 'DEFAULT', '864', 'Address Information', null, null), ('DEFAULT', 'DEFAULT', 'DEFAULT', 'OFX', 'Open Financial Exchange', null, null), ('DINOS', 'DEFAULT', 'DEFAULT', '810', 'Invoice', null, null), ('DINOS', 'DEFAULT', 'DEFAULT', '832', 'Item Informaiton', null, null), ('DINOS', 'DEFAULT', 'DEFAULT', '850', 'Order', null, null), ('DINOS', 'DEFAULT', 'DEFAULT', '856', 'Advanced Ship Notice', null, null), ('DINOS', 'DEFAULT', 'DEFAULT', '864', 'Address Information', null, null), ('DINOS', 'DEFAULT', 'DEFAULT', 'OFX', 'Open Financial Exchange', null, null), ('DINOS', 'DEFAULT', 'PAYROLL', '810', 'Invoice', null, null), ('DINOS', 'DEFAULT', 'PAYROLL', '832', 'Item Informaiton', null, null), ('DINOS', 'DEFAULT', 'PAYROLL', '850', 'Order', null, null), ('DINOS', 'DEFAULT', 'PAYROLL', '856', 'Advanced Ship Notice', null, null), ('DINOS', 'DEFAULT', 'PAYROLL', '864', 'Address Information', null, null), ('DINOS', 'DEFAULT', 'PAYROLL', 'OFX', 'Open Financial Exchange', null, null), ('DINOSFUND', 'DEFAULT', 'DEFAULT', '810', 'Invoice', null, null), ('DINOSFUND', 'DEFAULT', 'DEFAULT', '832', 'Item Informaiton', null, null), ('DINOSFUND', 'DEFAULT', 'DEFAULT', '850', 'Order', null, null), ('DINOSFUND', 'DEFAULT', 'DEFAULT', '856', 'Advanced Ship Notice', null, null), ('DINOSFUND', 'DEFAULT', 'DEFAULT', '864', 'Address Information', null, null), ('DINOSFUND', 'DEFAULT', 'DEFAULT', 'OFX', 'Open Financial Exchange', null, null), ('DINOSFUND', 'DEFAULT', 'PAYROLL', '810', 'Invoice', null, null), ('DINOSFUND', 'DEFAULT', 'PAYROLL', '832', 'Item Informaiton', null, null), ('DINOSFUND', 'DEFAULT', 'PAYROLL', '850', 'Order', null, null), ('DINOSFUND', 'DEFAULT', 'PAYROLL', '856', 'Advanced Ship Notice', null, null), ('DINOSFUND', 'DEFAULT', 'PAYROLL', '864', 'Address Information', null, null), ('DINOSFUND', 'DEFAULT', 'PAYROLL', 'OFX', 'Open Financial Exchange', null, null);
COMMIT;

-- ----------------------------
--  Table structure for `ediexceptions`
-- ----------------------------
DROP TABLE IF EXISTS `ediexceptions`;
CREATE TABLE `ediexceptions` (
  `CompanyID` varchar(36) NOT NULL,
  `DivisionID` varchar(36) NOT NULL,
  `DepartmentID` varchar(36) NOT NULL,
  `ExceptionID` varchar(36) NOT NULL,
  `ExceptionTypeID` varchar(36) DEFAULT NULL,
  `DirectionID` varchar(1) DEFAULT NULL,
  `DocumentID` varchar(36) DEFAULT NULL,
  `ExactErrorMessage` varchar(50) DEFAULT NULL,
  `LockedBy` varchar(36) DEFAULT NULL,
  `LockTS` datetime DEFAULT NULL,
  PRIMARY KEY (`CompanyID`,`DivisionID`,`DepartmentID`,`ExceptionID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
delimiter ;;
CREATE TRIGGER `EDIExceptions_Audit_Insert` AFTER INSERT ON `ediexceptions` FOR EACH ROW SWL_return:
BEGIN
   DECLARE NO_DATA INT DEFAULT 0;
   DECLARE v_Context VARBINARY(128);
   DECLARE v_TransactionNumber NATIONAL VARCHAR(50);
   DECLARE v_TransactionLineNumber NATIONAL VARCHAR(50);

   DECLARE v_CompanyID NATIONAL VARCHAR(36);
   DECLARE v_DivisionID NATIONAL VARCHAR(36);
   DECLARE v_DepartmentID NATIONAL VARCHAR(36);
   DECLARE v_ExceptionID NATIONAL VARCHAR(36);

-- inserting records cursor declaration
   DECLARE cInsert CURSOR
   FOR SELECT
   i.ExceptionID
		,''

		,i.CompanyID
		,i.DivisionID
		,i.DepartmentID
		,i.ExceptionID

   FROM
   InsEDIExceptions i;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET NO_DATA = -2;
   END;
   DECLARE CONTINUE HANDLER FOR NOT FOUND SET NO_DATA = -1;
   CREATE  TEMPORARY TABLE IF NOT EXISTS InsEDIExceptions
   (
      CompanyID NATIONAL VARCHAR(36),
      DivisionID NATIONAL VARCHAR(36),
      DepartmentID NATIONAL VARCHAR(36),
      ExceptionID NATIONAL VARCHAR(36),
      ExceptionTypeID NATIONAL VARCHAR(36),
      DirectionID NATIONAL VARCHAR(1),
      DocumentID NATIONAL VARCHAR(36),
      ExactErrorMessage NATIONAL VARCHAR(50),
      LockedBy NATIONAL VARCHAR(36),
      LockTS DATETIME
   );
   DELETE FROM InsEDIExceptions;
   INSERT INTO InsEDIExceptions VALUES(NEW.CompanyID, NEW.DivisionID, NEW.DepartmentID, NEW.ExceptionID, NEW.ExceptionTypeID, NEW.DirectionID, NEW.DocumentID, NEW.ExactErrorMessage, NEW.LockedBy, NEW.LockTS);

   BEGIN
-- check for audit triggers switch off

      select   context_info INTO v_Context FROM sysprocesses WHERE spid = CONNECTION_ID();
      IF CAST(v_Context AS CHAR(36)) = N'$$AuditSwitchOff$$' then 
         LEAVE SWL_return;
      end if;

-- declarations
      OPEN cInsert;
-- fetch from each inserting record
      SET NO_DATA = 0;
      FETCH cInsert INTO
      v_TransactionNumber,v_TransactionLineNumber,v_CompanyID,v_DivisionID,v_DepartmentID,
      v_ExceptionID;
      WHILE NO_DATA = 0 DO
-- insert audit record for each inserting record
         IF IsGuid(v_TransactionNumber) = 0 then
		
            CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber,v_TransactionLineNumber,
            'EDIExceptions','New Record','','New Record');
         end if;
         SET NO_DATA = 0;
         FETCH cInsert INTO
         v_TransactionNumber,v_TransactionLineNumber,v_CompanyID,v_DivisionID,v_DepartmentID,
         v_ExceptionID;
      END WHILE;
      CLOSE cInsert;

   END;
END;
 ;;
delimiter ;
delimiter ;;
CREATE TRIGGER `EDIExceptions_Audit_Update` AFTER UPDATE ON `ediexceptions` FOR EACH ROW SWL_return:
BEGIN
   DECLARE NO_DATA INT DEFAULT 0;
   DECLARE v_Context VARBINARY(128);
   DECLARE v_TransactionNumber_O NATIONAL VARCHAR(50);
   DECLARE v_TransactionNumber_N NATIONAL VARCHAR(50);
   DECLARE v_TransactionLineNumber NATIONAL VARCHAR(50);

   DECLARE v_CompanyID NATIONAL VARCHAR(36);
   DECLARE v_DivisionID NATIONAL VARCHAR(36);
   DECLARE v_DepartmentID NATIONAL VARCHAR(36);
   DECLARE v_ExceptionID NATIONAL VARCHAR(36);

   DECLARE v_ExceptionTypeID_O NATIONAL VARCHAR(80);
   DECLARE v_ExceptionTypeID_N NATIONAL VARCHAR(80);
   DECLARE v_DirectionID_O NATIONAL VARCHAR(80);
   DECLARE v_DirectionID_N NATIONAL VARCHAR(80);
   DECLARE v_DocumentID_O NATIONAL VARCHAR(80);
   DECLARE v_DocumentID_N NATIONAL VARCHAR(80);
   DECLARE v_ExactErrorMessage_O NATIONAL VARCHAR(80);
   DECLARE v_ExactErrorMessage_N NATIONAL VARCHAR(80);
 

-- updating records cursor declaration
   DECLARE cUpdate CURSOR
   FOR SELECT
   d.ExceptionID
		,i.ExceptionID
		,''

		,i.CompanyID
		,i.DivisionID
		,i.DepartmentID
		,i.ExceptionID

,CAST(d.ExceptionTypeID AS CHAR(80))
,CAST(i.ExceptionTypeID AS CHAR(80))
,CAST(d.DirectionID AS CHAR(80))
,CAST(i.DirectionID AS CHAR(80))
,CAST(d.DocumentID AS CHAR(80))
,CAST(i.DocumentID AS CHAR(80))
,CAST(d.ExactErrorMessage AS CHAR(80))
,CAST(i.ExactErrorMessage AS CHAR(80))
 

   FROM
   InsEDIExceptions i
   LEFT OUTER JOIN DelEDIExceptions d ON
   d.CompanyID = i.CompanyID
   AND d.DivisionID = i.DivisionID
   AND d.DepartmentID = i.DepartmentID
   AND d.ExceptionID = i.ExceptionID;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET NO_DATA = -2;
   END;
   DECLARE CONTINUE HANDLER FOR NOT FOUND SET NO_DATA = -1;
   CREATE  TEMPORARY TABLE IF NOT EXISTS InsEDIExceptions
   (
      CompanyID NATIONAL VARCHAR(36),
      DivisionID NATIONAL VARCHAR(36),
      DepartmentID NATIONAL VARCHAR(36),
      ExceptionID NATIONAL VARCHAR(36),
      ExceptionTypeID NATIONAL VARCHAR(36),
      DirectionID NATIONAL VARCHAR(1),
      DocumentID NATIONAL VARCHAR(36),
      ExactErrorMessage NATIONAL VARCHAR(50),
      LockedBy NATIONAL VARCHAR(36),
      LockTS DATETIME
   );
   DELETE FROM InsEDIExceptions;
   INSERT INTO InsEDIExceptions VALUES(NEW.CompanyID, NEW.DivisionID, NEW.DepartmentID, NEW.ExceptionID, NEW.ExceptionTypeID, NEW.DirectionID, NEW.DocumentID, NEW.ExactErrorMessage, NEW.LockedBy, NEW.LockTS);

   CREATE  TEMPORARY TABLE IF NOT EXISTS DelEDIExceptions
   (
      CompanyID NATIONAL VARCHAR(36),
      DivisionID NATIONAL VARCHAR(36),
      DepartmentID NATIONAL VARCHAR(36),
      ExceptionID NATIONAL VARCHAR(36),
      ExceptionTypeID NATIONAL VARCHAR(36),
      DirectionID NATIONAL VARCHAR(1),
      DocumentID NATIONAL VARCHAR(36),
      ExactErrorMessage NATIONAL VARCHAR(50),
      LockedBy NATIONAL VARCHAR(36),
      LockTS DATETIME
   );
   DELETE FROM DelEDIExceptions;
   INSERT INTO DelEDIExceptions VALUES(OLD.CompanyID, OLD.DivisionID, OLD.DepartmentID, OLD.ExceptionID, OLD.ExceptionTypeID, OLD.DirectionID, OLD.DocumentID, OLD.ExactErrorMessage, OLD.LockedBy, OLD.LockTS);

   BEGIN
-- check for audit triggers switch off

      select   context_info INTO v_Context FROM sysprocesses WHERE spid = CONNECTION_ID();
      IF CAST(v_Context AS CHAR(36)) = N'$$AuditSwitchOff$$' then 
         LEAVE SWL_return;
      end if;

-- declarations
      OPEN cUpdate;
-- fetch from each updating record
      SET NO_DATA = 0;
      FETCH cUpdate INTO
      v_TransactionNumber_O,v_TransactionNumber_N,v_TransactionLineNumber,v_CompanyID,
      v_DivisionID,v_DepartmentID,v_ExceptionID,v_ExceptionTypeID_O,
      v_ExceptionTypeID_N,v_DirectionID_O,v_DirectionID_N,v_DocumentID_O,v_DocumentID_N,
      v_ExactErrorMessage_O,v_ExactErrorMessage_N;
      WHILE NO_DATA = 0 DO
-- insert audit records for each changed field

         CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
         'EDIExceptions','ExceptionTypeID',v_ExceptionTypeID_O,
         v_ExceptionTypeID_N);
         CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
         'EDIExceptions','DirectionID',v_DirectionID_O,v_DirectionID_N);
         CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
         'EDIExceptions','DocumentID',v_DocumentID_O,v_DocumentID_N);
         CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
         'EDIExceptions','ExactErrorMessage',v_ExactErrorMessage_O,
         v_ExactErrorMessage_N);
         SET NO_DATA = 0;
         FETCH cUpdate INTO
         v_TransactionNumber_O,v_TransactionNumber_N,v_TransactionLineNumber,v_CompanyID,
         v_DivisionID,v_DepartmentID,v_ExceptionID,v_ExceptionTypeID_O,
         v_ExceptionTypeID_N,v_DirectionID_O,v_DirectionID_N,v_DocumentID_O,v_DocumentID_N,
         v_ExactErrorMessage_O,v_ExactErrorMessage_N;
      END WHILE;
      CLOSE cUpdate;

   END;
END;
 ;;
delimiter ;
delimiter ;;
CREATE TRIGGER `EDIExceptions_Audit_Delete` AFTER DELETE ON `ediexceptions` FOR EACH ROW SWL_return:
BEGIN
   DECLARE NO_DATA INT DEFAULT 0;
   DECLARE v_Context VARBINARY(128);
   DECLARE v_TransactionNumber NATIONAL VARCHAR(50);
   DECLARE v_TransactionLineNumber NATIONAL VARCHAR(50);

   DECLARE v_CompanyID NATIONAL VARCHAR(36);
   DECLARE v_DivisionID NATIONAL VARCHAR(36);
   DECLARE v_DepartmentID NATIONAL VARCHAR(36);
   DECLARE v_ExceptionID NATIONAL VARCHAR(36);

-- deleting records cursor declaration
   DECLARE cDelete CURSOR
   FOR SELECT
   d.ExceptionID
		,''

		,d.CompanyID
		,d.DivisionID
		,d.DepartmentID
		,d.ExceptionID

   FROM
   DelEDIExceptions d;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET NO_DATA = -2;
   END;
   DECLARE CONTINUE HANDLER FOR NOT FOUND SET NO_DATA = -1;
   CREATE  TEMPORARY TABLE IF NOT EXISTS DelEDIExceptions
   (
      CompanyID NATIONAL VARCHAR(36),
      DivisionID NATIONAL VARCHAR(36),
      DepartmentID NATIONAL VARCHAR(36),
      ExceptionID NATIONAL VARCHAR(36),
      ExceptionTypeID NATIONAL VARCHAR(36),
      DirectionID NATIONAL VARCHAR(1),
      DocumentID NATIONAL VARCHAR(36),
      ExactErrorMessage NATIONAL VARCHAR(50),
      LockedBy NATIONAL VARCHAR(36),
      LockTS DATETIME
   );
   DELETE FROM DelEDIExceptions;
   INSERT INTO DelEDIExceptions VALUES(OLD.CompanyID, OLD.DivisionID, OLD.DepartmentID, OLD.ExceptionID, OLD.ExceptionTypeID, OLD.DirectionID, OLD.DocumentID, OLD.ExactErrorMessage, OLD.LockedBy, OLD.LockTS);

   BEGIN
-- check for audit triggers switch off

      select   context_info INTO v_Context FROM sysprocesses WHERE spid = CONNECTION_ID();
      IF CAST(v_Context AS CHAR(36)) = N'$$AuditSwitchOff$$' then 
         LEAVE SWL_return;
      end if;

-- declarations
      OPEN cDelete;
-- fetch from each deleting record
      SET NO_DATA = 0;
      FETCH cDelete INTO
      v_TransactionNumber,v_TransactionLineNumber,v_CompanyID,v_DivisionID,v_DepartmentID,
      v_ExceptionID;
      WHILE NO_DATA = 0 DO
-- insert audit record for each deleting record
         CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber,v_TransactionLineNumber,
         'EDIExceptions','Deleted','','Deleted');
         SET NO_DATA = 0;
         FETCH cDelete INTO
         v_TransactionNumber,v_TransactionLineNumber,v_CompanyID,v_DivisionID,v_DepartmentID,
         v_ExceptionID;
      END WHILE;
      CLOSE cDelete;

   END;
END;
 ;;
delimiter ;

-- ----------------------------
--  Records of `ediexceptions`
-- ----------------------------
BEGIN;
INSERT INTO `ediexceptions` VALUES ('DEFAULT', 'DEFAULT', 'DEFAULT', '00001', 'Part', 'I', '850', 'Invalid Part Number', null, null), ('DEFAULT', 'DEFAULT', 'DEFAULT', '00002', 'Price', 'I', '850', 'Invalid Price', null, null), ('DEFAULT', 'DEFAULT', 'DEFAULT', '00003', 'ShipTo', 'I', '850', 'Invalid Ship To', null, null), ('DEFAULT', 'DEFAULT', 'DEFAULT', '00004', 'ShipFor', 'I', '850', 'Invalid Ship For', null, null), ('DEFAULT', 'DEFAULT', 'DEFAULT', '00005', 'NoMatch', 'I', '810', 'No Matching Document Found', null, null), ('DINOS', 'DEFAULT', 'DEFAULT', '00001', 'Part', 'I', '850', 'Invalid Part Number', null, null), ('DINOS', 'DEFAULT', 'DEFAULT', '00002', 'Price', 'I', '850', 'Invalid Price', null, null), ('DINOS', 'DEFAULT', 'DEFAULT', '00003', 'ShipTo', 'I', '850', 'Invalid Ship To', null, null), ('DINOS', 'DEFAULT', 'DEFAULT', '00004', 'ShipFor', 'I', '850', 'Invalid Ship For', null, null), ('DINOS', 'DEFAULT', 'DEFAULT', '00005', 'NoMatch', 'I', '810', 'No Matching Document Found', null, null), ('DINOS', 'DEFAULT', 'PAYROLL', '00001', 'Part', 'I', '850', 'Invalid Part Number', null, null), ('DINOS', 'DEFAULT', 'PAYROLL', '00002', 'Price', 'I', '850', 'Invalid Price', null, null), ('DINOS', 'DEFAULT', 'PAYROLL', '00003', 'ShipTo', 'I', '850', 'Invalid Ship To', null, null), ('DINOS', 'DEFAULT', 'PAYROLL', '00004', 'ShipFor', 'I', '850', 'Invalid Ship For', null, null), ('DINOS', 'DEFAULT', 'PAYROLL', '00005', 'NoMatch', 'I', '810', 'No Matching Document Found', null, null), ('DINOSFUND', 'DEFAULT', 'DEFAULT', '00001', 'Part', 'I', '850', 'Invalid Part Number', null, null), ('DINOSFUND', 'DEFAULT', 'DEFAULT', '00002', 'Price', 'I', '850', 'Invalid Price', null, null), ('DINOSFUND', 'DEFAULT', 'DEFAULT', '00003', 'ShipTo', 'I', '850', 'Invalid Ship To', null, null), ('DINOSFUND', 'DEFAULT', 'DEFAULT', '00004', 'ShipFor', 'I', '850', 'Invalid Ship For', null, null), ('DINOSFUND', 'DEFAULT', 'DEFAULT', '00005', 'NoMatch', 'I', '810', 'No Matching Document Found', null, null), ('DINOSFUND', 'DEFAULT', 'PAYROLL', '00001', 'Part', 'I', '850', 'Invalid Part Number', null, null), ('DINOSFUND', 'DEFAULT', 'PAYROLL', '00002', 'Price', 'I', '850', 'Invalid Price', null, null), ('DINOSFUND', 'DEFAULT', 'PAYROLL', '00003', 'ShipTo', 'I', '850', 'Invalid Ship To', null, null), ('DINOSFUND', 'DEFAULT', 'PAYROLL', '00004', 'ShipFor', 'I', '850', 'Invalid Ship For', null, null), ('DINOSFUND', 'DEFAULT', 'PAYROLL', '00005', 'NoMatch', 'I', '810', 'No Matching Document Found', null, null);
COMMIT;

-- ----------------------------
--  Table structure for `ediexceptiontypes`
-- ----------------------------
DROP TABLE IF EXISTS `ediexceptiontypes`;
CREATE TABLE `ediexceptiontypes` (
  `CompanyID` varchar(36) NOT NULL,
  `DivisionID` varchar(36) NOT NULL,
  `DepartmentID` varchar(36) NOT NULL,
  `ExceptionTypeID` varchar(36) NOT NULL,
  `ExceptionTypeDescription` varchar(50) DEFAULT NULL,
  `LockedBy` varchar(36) DEFAULT NULL,
  `LockTS` datetime DEFAULT NULL,
  PRIMARY KEY (`CompanyID`,`DivisionID`,`DepartmentID`,`ExceptionTypeID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
delimiter ;;
CREATE TRIGGER `EDIExceptionTypes_Audit_Insert` AFTER INSERT ON `ediexceptiontypes` FOR EACH ROW SWL_return:
BEGIN
   DECLARE NO_DATA INT DEFAULT 0;
   DECLARE v_Context VARBINARY(128);
   DECLARE v_TransactionNumber NATIONAL VARCHAR(50);
   DECLARE v_TransactionLineNumber NATIONAL VARCHAR(50);

   DECLARE v_CompanyID NATIONAL VARCHAR(36);
   DECLARE v_DivisionID NATIONAL VARCHAR(36);
   DECLARE v_DepartmentID NATIONAL VARCHAR(36);
   DECLARE v_ExceptionTypeID NATIONAL VARCHAR(36);

-- inserting records cursor declaration
   DECLARE cInsert CURSOR
   FOR SELECT
   i.ExceptionTypeID
		,''

		,i.CompanyID
		,i.DivisionID
		,i.DepartmentID
		,i.ExceptionTypeID

   FROM
   InsEDIExceptionTypes i;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET NO_DATA = -2;
   END;
   DECLARE CONTINUE HANDLER FOR NOT FOUND SET NO_DATA = -1;
   CREATE  TEMPORARY TABLE IF NOT EXISTS InsEDIExceptionTypes
   (
      CompanyID NATIONAL VARCHAR(36),
      DivisionID NATIONAL VARCHAR(36),
      DepartmentID NATIONAL VARCHAR(36),
      ExceptionTypeID NATIONAL VARCHAR(36),
      ExceptionTypeDescription NATIONAL VARCHAR(50),
      LockedBy NATIONAL VARCHAR(36),
      LockTS DATETIME
   );
   DELETE FROM InsEDIExceptionTypes;
   INSERT INTO InsEDIExceptionTypes VALUES(NEW.CompanyID, NEW.DivisionID, NEW.DepartmentID, NEW.ExceptionTypeID, NEW.ExceptionTypeDescription, NEW.LockedBy, NEW.LockTS);

   BEGIN
-- check for audit triggers switch off

      select   context_info INTO v_Context FROM sysprocesses WHERE spid = CONNECTION_ID();
      IF CAST(v_Context AS CHAR(36)) = N'$$AuditSwitchOff$$' then 
         LEAVE SWL_return;
      end if;

-- declarations
      OPEN cInsert;
-- fetch from each inserting record
      SET NO_DATA = 0;
      FETCH cInsert INTO
      v_TransactionNumber,v_TransactionLineNumber,v_CompanyID,v_DivisionID,v_DepartmentID,
      v_ExceptionTypeID;
      WHILE NO_DATA = 0 DO
-- insert audit record for each inserting record
         IF IsGuid(v_TransactionNumber) = 0 then
		
            CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber,v_TransactionLineNumber,
            'EDIExceptionTypes','New Record','','New Record');
         end if;
         SET NO_DATA = 0;
         FETCH cInsert INTO
         v_TransactionNumber,v_TransactionLineNumber,v_CompanyID,v_DivisionID,v_DepartmentID,
         v_ExceptionTypeID;
      END WHILE;
      CLOSE cInsert;

   END;
END;
 ;;
delimiter ;
delimiter ;;
CREATE TRIGGER `EDIExceptionTypes_Audit_Update` AFTER UPDATE ON `ediexceptiontypes` FOR EACH ROW SWL_return:
BEGIN
   DECLARE NO_DATA INT DEFAULT 0;
   DECLARE v_Context VARBINARY(128);
   DECLARE v_TransactionNumber_O NATIONAL VARCHAR(50);
   DECLARE v_TransactionNumber_N NATIONAL VARCHAR(50);
   DECLARE v_TransactionLineNumber NATIONAL VARCHAR(50);

   DECLARE v_CompanyID NATIONAL VARCHAR(36);
   DECLARE v_DivisionID NATIONAL VARCHAR(36);
   DECLARE v_DepartmentID NATIONAL VARCHAR(36);
   DECLARE v_ExceptionTypeID NATIONAL VARCHAR(36);

   DECLARE v_ExceptionTypeDescription_O NATIONAL VARCHAR(80);
   DECLARE v_ExceptionTypeDescription_N NATIONAL VARCHAR(80);
 

-- updating records cursor declaration
   DECLARE cUpdate CURSOR
   FOR SELECT
   d.ExceptionTypeID
		,i.ExceptionTypeID
		,''

		,i.CompanyID
		,i.DivisionID
		,i.DepartmentID
		,i.ExceptionTypeID

,CAST(d.ExceptionTypeDescription AS CHAR(80))
,CAST(i.ExceptionTypeDescription AS CHAR(80))
 

   FROM
   InsEDIExceptionTypes i
   LEFT OUTER JOIN DelEDIExceptionTypes d ON
   d.CompanyID = i.CompanyID
   AND d.DivisionID = i.DivisionID
   AND d.DepartmentID = i.DepartmentID
   AND d.ExceptionTypeID = i.ExceptionTypeID;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET NO_DATA = -2;
   END;
   DECLARE CONTINUE HANDLER FOR NOT FOUND SET NO_DATA = -1;
   CREATE  TEMPORARY TABLE IF NOT EXISTS InsEDIExceptionTypes
   (
      CompanyID NATIONAL VARCHAR(36),
      DivisionID NATIONAL VARCHAR(36),
      DepartmentID NATIONAL VARCHAR(36),
      ExceptionTypeID NATIONAL VARCHAR(36),
      ExceptionTypeDescription NATIONAL VARCHAR(50),
      LockedBy NATIONAL VARCHAR(36),
      LockTS DATETIME
   );
   DELETE FROM InsEDIExceptionTypes;
   INSERT INTO InsEDIExceptionTypes VALUES(NEW.CompanyID, NEW.DivisionID, NEW.DepartmentID, NEW.ExceptionTypeID, NEW.ExceptionTypeDescription, NEW.LockedBy, NEW.LockTS);

   CREATE  TEMPORARY TABLE IF NOT EXISTS DelEDIExceptionTypes
   (
      CompanyID NATIONAL VARCHAR(36),
      DivisionID NATIONAL VARCHAR(36),
      DepartmentID NATIONAL VARCHAR(36),
      ExceptionTypeID NATIONAL VARCHAR(36),
      ExceptionTypeDescription NATIONAL VARCHAR(50),
      LockedBy NATIONAL VARCHAR(36),
      LockTS DATETIME
   );
   DELETE FROM DelEDIExceptionTypes;
   INSERT INTO DelEDIExceptionTypes VALUES(OLD.CompanyID, OLD.DivisionID, OLD.DepartmentID, OLD.ExceptionTypeID, OLD.ExceptionTypeDescription, OLD.LockedBy, OLD.LockTS);

   BEGIN
-- check for audit triggers switch off

      select   context_info INTO v_Context FROM sysprocesses WHERE spid = CONNECTION_ID();
      IF CAST(v_Context AS CHAR(36)) = N'$$AuditSwitchOff$$' then 
         LEAVE SWL_return;
      end if;

-- declarations
      OPEN cUpdate;
-- fetch from each updating record
      SET NO_DATA = 0;
      FETCH cUpdate INTO
      v_TransactionNumber_O,v_TransactionNumber_N,v_TransactionLineNumber,v_CompanyID,
      v_DivisionID,v_DepartmentID,v_ExceptionTypeID,v_ExceptionTypeDescription_O,
      v_ExceptionTypeDescription_N;
      WHILE NO_DATA = 0 DO
-- insert audit records for each changed field

         CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
         'EDIExceptionTypes','ExceptionTypeDescription',v_ExceptionTypeDescription_O,
         v_ExceptionTypeDescription_N);
         SET NO_DATA = 0;
         FETCH cUpdate INTO
         v_TransactionNumber_O,v_TransactionNumber_N,v_TransactionLineNumber,v_CompanyID,
         v_DivisionID,v_DepartmentID,v_ExceptionTypeID,v_ExceptionTypeDescription_O,
         v_ExceptionTypeDescription_N;
      END WHILE;
      CLOSE cUpdate;

   END;
END;
 ;;
delimiter ;
delimiter ;;
CREATE TRIGGER `EDIExceptionTypes_Audit_Delete` AFTER DELETE ON `ediexceptiontypes` FOR EACH ROW SWL_return:
BEGIN
   DECLARE NO_DATA INT DEFAULT 0;
   DECLARE v_Context VARBINARY(128);
   DECLARE v_TransactionNumber NATIONAL VARCHAR(50);
   DECLARE v_TransactionLineNumber NATIONAL VARCHAR(50);

   DECLARE v_CompanyID NATIONAL VARCHAR(36);
   DECLARE v_DivisionID NATIONAL VARCHAR(36);
   DECLARE v_DepartmentID NATIONAL VARCHAR(36);
   DECLARE v_ExceptionTypeID NATIONAL VARCHAR(36);

-- deleting records cursor declaration
   DECLARE cDelete CURSOR
   FOR SELECT
   d.ExceptionTypeID
		,''

		,d.CompanyID
		,d.DivisionID
		,d.DepartmentID
		,d.ExceptionTypeID

   FROM
   DelEDIExceptionTypes d;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET NO_DATA = -2;
   END;
   DECLARE CONTINUE HANDLER FOR NOT FOUND SET NO_DATA = -1;
   CREATE  TEMPORARY TABLE IF NOT EXISTS DelEDIExceptionTypes
   (
      CompanyID NATIONAL VARCHAR(36),
      DivisionID NATIONAL VARCHAR(36),
      DepartmentID NATIONAL VARCHAR(36),
      ExceptionTypeID NATIONAL VARCHAR(36),
      ExceptionTypeDescription NATIONAL VARCHAR(50),
      LockedBy NATIONAL VARCHAR(36),
      LockTS DATETIME
   );
   DELETE FROM DelEDIExceptionTypes;
   INSERT INTO DelEDIExceptionTypes VALUES(OLD.CompanyID, OLD.DivisionID, OLD.DepartmentID, OLD.ExceptionTypeID, OLD.ExceptionTypeDescription, OLD.LockedBy, OLD.LockTS);

   BEGIN
-- check for audit triggers switch off

      select   context_info INTO v_Context FROM sysprocesses WHERE spid = CONNECTION_ID();
      IF CAST(v_Context AS CHAR(36)) = N'$$AuditSwitchOff$$' then 
         LEAVE SWL_return;
      end if;

-- declarations
      OPEN cDelete;
-- fetch from each deleting record
      SET NO_DATA = 0;
      FETCH cDelete INTO
      v_TransactionNumber,v_TransactionLineNumber,v_CompanyID,v_DivisionID,v_DepartmentID,
      v_ExceptionTypeID;
      WHILE NO_DATA = 0 DO
-- insert audit record for each deleting record
         CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber,v_TransactionLineNumber,
         'EDIExceptionTypes','Deleted','','Deleted');
         SET NO_DATA = 0;
         FETCH cDelete INTO
         v_TransactionNumber,v_TransactionLineNumber,v_CompanyID,v_DivisionID,v_DepartmentID,
         v_ExceptionTypeID;
      END WHILE;
      CLOSE cDelete;

   END;
END;
 ;;
delimiter ;

-- ----------------------------
--  Records of `ediexceptiontypes`
-- ----------------------------
BEGIN;
INSERT INTO `ediexceptiontypes` VALUES ('DEFAULT', 'DEFAULT', 'DEFAULT', 'Duplicate', 'Duplicate Transaction Number', null, null), ('DEFAULT', 'DEFAULT', 'DEFAULT', 'Part', 'Invalid Part Number', null, null), ('DEFAULT', 'DEFAULT', 'DEFAULT', 'Price', 'Invalid Price', null, null), ('DEFAULT', 'DEFAULT', 'DEFAULT', 'ShipFor', 'Invalid Ship For Information', null, null), ('DEFAULT', 'DEFAULT', 'DEFAULT', 'ShipTo', 'Invalid Ship To Information', null, null), ('DINOS', 'DEFAULT', 'DEFAULT', 'Duplicate', 'Duplicate Transaction Number', null, null), ('DINOS', 'DEFAULT', 'DEFAULT', 'Part', 'Invalid Part Number', null, null), ('DINOS', 'DEFAULT', 'DEFAULT', 'Price', 'Invalid Price', null, null), ('DINOS', 'DEFAULT', 'DEFAULT', 'ShipFor', 'Invalid Ship For Information', null, null), ('DINOS', 'DEFAULT', 'DEFAULT', 'ShipTo', 'Invalid Ship To Information', null, null), ('DINOS', 'DEFAULT', 'PAYROLL', 'Duplicate', 'Duplicate Transaction Number', null, null), ('DINOS', 'DEFAULT', 'PAYROLL', 'Part', 'Invalid Part Number', null, null), ('DINOS', 'DEFAULT', 'PAYROLL', 'Price', 'Invalid Price', null, null), ('DINOS', 'DEFAULT', 'PAYROLL', 'ShipFor', 'Invalid Ship For Information', null, null), ('DINOS', 'DEFAULT', 'PAYROLL', 'ShipTo', 'Invalid Ship To Information', null, null), ('DINOSFUND', 'DEFAULT', 'DEFAULT', 'Duplicate', 'Duplicate Transaction Number', null, null), ('DINOSFUND', 'DEFAULT', 'DEFAULT', 'Part', 'Invalid Part Number', null, null), ('DINOSFUND', 'DEFAULT', 'DEFAULT', 'Price', 'Invalid Price', null, null), ('DINOSFUND', 'DEFAULT', 'DEFAULT', 'ShipFor', 'Invalid Ship For Information', null, null), ('DINOSFUND', 'DEFAULT', 'DEFAULT', 'ShipTo', 'Invalid Ship To Information', null, null), ('DINOSFUND', 'DEFAULT', 'PAYROLL', 'Duplicate', 'Duplicate Transaction Number', null, null), ('DINOSFUND', 'DEFAULT', 'PAYROLL', 'Part', 'Invalid Part Number', null, null), ('DINOSFUND', 'DEFAULT', 'PAYROLL', 'Price', 'Invalid Price', null, null), ('DINOSFUND', 'DEFAULT', 'PAYROLL', 'ShipFor', 'Invalid Ship For Information', null, null), ('DINOSFUND', 'DEFAULT', 'PAYROLL', 'ShipTo', 'Invalid Ship To Information', null, null);
COMMIT;

-- ----------------------------
--  Table structure for `ediinvoicedetail`
-- ----------------------------
DROP TABLE IF EXISTS `ediinvoicedetail`;
CREATE TABLE `ediinvoicedetail` (
  `CompanyID` varchar(36) NOT NULL,
  `DivisionID` varchar(36) NOT NULL,
  `DepartmentID` varchar(36) NOT NULL,
  `InvoiceNumber` varchar(36) NOT NULL,
  `InvoiceLineNumber` bigint(20) NOT NULL AUTO_INCREMENT,
  `ItemID` varchar(36) DEFAULT NULL,
  `WarehouseID` varchar(36) DEFAULT NULL,
  `SerialNumber` varchar(50) DEFAULT NULL,
  `OrderQty` float DEFAULT NULL,
  `BackOrdered` tinyint(1) DEFAULT NULL,
  `BackOrderQty` float DEFAULT NULL,
  `ItemUOM` varchar(15) DEFAULT NULL,
  `ItemWeight` float DEFAULT NULL,
  `Description` varchar(80) DEFAULT NULL,
  `DiscountPerc` float DEFAULT NULL,
  `Taxable` tinyint(1) DEFAULT NULL,
  `CurrencyID` varchar(3) DEFAULT NULL,
  `CurrencyExchangeRate` float DEFAULT NULL,
  `ItemCost` decimal(19,4) DEFAULT NULL,
  `ItemUnitPrice` decimal(19,4) DEFAULT NULL,
  `Total` decimal(19,4) DEFAULT NULL,
  `TotalWeight` float DEFAULT NULL,
  `GLSalesAccount` varchar(36) DEFAULT NULL,
  `ProjectID` varchar(36) DEFAULT NULL,
  `TrackingNumber` varchar(50) DEFAULT NULL,
  `DetailMemo1` varchar(50) DEFAULT NULL,
  `DetailMemo2` varchar(50) DEFAULT NULL,
  `DetailMemo3` varchar(50) DEFAULT NULL,
  `DetailMemo4` varchar(50) DEFAULT NULL,
  `DetailMemo5` varchar(50) DEFAULT NULL,
  `LockedBy` varchar(36) DEFAULT NULL,
  `LockTS` datetime DEFAULT NULL,
  `TaxGroupID` varchar(36) DEFAULT NULL,
  `TaxAmount` decimal(19,4) DEFAULT NULL,
  `TaxPercent` float DEFAULT NULL,
  `SubTotal` decimal(19,4) DEFAULT NULL,
  PRIMARY KEY (`InvoiceLineNumber`,`CompanyID`,`DivisionID`,`DepartmentID`,`InvoiceNumber`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
delimiter ;;
CREATE TRIGGER `EDIInvoiceDetail_Audit_Insert` AFTER INSERT ON `ediinvoicedetail` FOR EACH ROW SWL_return:
BEGIN
   DECLARE NO_DATA INT DEFAULT 0;
   DECLARE v_Context VARBINARY(128);
   DECLARE v_TransactionNumber NATIONAL VARCHAR(50);
   DECLARE v_TransactionLineNumber NATIONAL VARCHAR(50);

   DECLARE v_CompanyID NATIONAL VARCHAR(36);
   DECLARE v_DivisionID NATIONAL VARCHAR(36);
   DECLARE v_DepartmentID NATIONAL VARCHAR(36);
   DECLARE v_InvoiceNumber NATIONAL VARCHAR(36);
   DECLARE v_InvoiceLineNumber NUMERIC(18,0);

-- inserting records cursor declaration
   DECLARE cInsert CURSOR
   FOR SELECT
   i.InvoiceNumber
		,i.InvoiceLineNumber

		,i.CompanyID
		,i.DivisionID
		,i.DepartmentID
		,i.InvoiceNumber
		,i.InvoiceLineNumber

   FROM
   InsEDIInvoiceDetail i;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET NO_DATA = -2;
   END;
   DECLARE CONTINUE HANDLER FOR NOT FOUND SET NO_DATA = -1;
   CREATE  TEMPORARY TABLE IF NOT EXISTS InsEDIInvoiceDetail
   (
      CompanyID NATIONAL VARCHAR(36),
      DivisionID NATIONAL VARCHAR(36),
      DepartmentID NATIONAL VARCHAR(36),
      InvoiceNumber NATIONAL VARCHAR(36),
      InvoiceLineNumber NUMERIC(18,0),
      ItemID NATIONAL VARCHAR(36),
      WarehouseID NATIONAL VARCHAR(36),
      SerialNumber NATIONAL VARCHAR(50),
      OrderQty FLOAT,
      BackOrdered BOOLEAN,
      BackOrderQty FLOAT,
      ItemUOM NATIONAL VARCHAR(15),
      ItemWeight FLOAT,
      Description NATIONAL VARCHAR(80),
      DiscountPerc FLOAT,
      Taxable BOOLEAN,
      CurrencyID NATIONAL VARCHAR(3),
      CurrencyExchangeRate FLOAT,
      ItemCost DECIMAL(19,4),
      ItemUnitPrice DECIMAL(19,4),
      Total DECIMAL(19,4),
      TotalWeight FLOAT,
      GLSalesAccount NATIONAL VARCHAR(36),
      ProjectID NATIONAL VARCHAR(36),
      TrackingNumber NATIONAL VARCHAR(50),
      DetailMemo1 NATIONAL VARCHAR(50),
      DetailMemo2 NATIONAL VARCHAR(50),
      DetailMemo3 NATIONAL VARCHAR(50),
      DetailMemo4 NATIONAL VARCHAR(50),
      DetailMemo5 NATIONAL VARCHAR(50),
      LockedBy NATIONAL VARCHAR(36),
      LockTS DATETIME,
      TaxGroupID NATIONAL VARCHAR(36),
      TaxAmount DECIMAL(19,4),
      TaxPercent FLOAT,
      SubTotal DECIMAL(19,4)
   );
   DELETE FROM InsEDIInvoiceDetail;
   INSERT INTO InsEDIInvoiceDetail VALUES(NEW.CompanyID, NEW.DivisionID, NEW.DepartmentID, NEW.InvoiceNumber, NEW.InvoiceLineNumber, NEW.ItemID, NEW.WarehouseID, NEW.SerialNumber, NEW.OrderQty, NEW.BackOrdered, NEW.BackOrderQty, NEW.ItemUOM, NEW.ItemWeight, NEW.Description, NEW.DiscountPerc, NEW.Taxable, NEW.CurrencyID, NEW.CurrencyExchangeRate, NEW.ItemCost, NEW.ItemUnitPrice, NEW.Total, NEW.TotalWeight, NEW.GLSalesAccount, NEW.ProjectID, NEW.TrackingNumber, NEW.DetailMemo1, NEW.DetailMemo2, NEW.DetailMemo3, NEW.DetailMemo4, NEW.DetailMemo5, NEW.LockedBy, NEW.LockTS, NEW.TaxGroupID, NEW.TaxAmount, NEW.TaxPercent, NEW.SubTotal);

   BEGIN
-- check for audit triggers switch off

      select   context_info INTO v_Context FROM sysprocesses WHERE spid = CONNECTION_ID();
      IF CAST(v_Context AS CHAR(36)) = N'$$AuditSwitchOff$$' then 
         LEAVE SWL_return;
      end if;

-- declarations
      OPEN cInsert;
-- fetch from each inserting record
      SET NO_DATA = 0;
      FETCH cInsert INTO
      v_TransactionNumber,v_TransactionLineNumber,v_CompanyID,v_DivisionID,v_DepartmentID,
      v_InvoiceNumber,v_InvoiceLineNumber;
      WHILE NO_DATA = 0 DO
-- insert audit record for each inserting record
         IF IsGuid(v_TransactionNumber) = 0 then
		
            CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber,v_TransactionLineNumber,
            'EDIInvoiceDetail','New Record','','New Record');
         end if;
         SET NO_DATA = 0;
         FETCH cInsert INTO
         v_TransactionNumber,v_TransactionLineNumber,v_CompanyID,v_DivisionID,v_DepartmentID,
         v_InvoiceNumber,v_InvoiceLineNumber;
      END WHILE;
      CLOSE cInsert;

   END;
END;
 ;;
delimiter ;
delimiter ;;
CREATE TRIGGER `EDIInvoiceDetail_Audit_Update` AFTER UPDATE ON `ediinvoicedetail` FOR EACH ROW SWL_return:
BEGIN
   DECLARE NO_DATA INT DEFAULT 0;
   DECLARE v_Context VARBINARY(128);
   DECLARE v_TransactionNumber_O NATIONAL VARCHAR(50);
   DECLARE v_TransactionNumber_N NATIONAL VARCHAR(50);
   DECLARE v_TransactionLineNumber NATIONAL VARCHAR(50);

   DECLARE v_CompanyID NATIONAL VARCHAR(36);
   DECLARE v_DivisionID NATIONAL VARCHAR(36);
   DECLARE v_DepartmentID NATIONAL VARCHAR(36);
   DECLARE v_InvoiceNumber NATIONAL VARCHAR(36);
   DECLARE v_InvoiceLineNumber NUMERIC(18,0);

   DECLARE v_ItemID_O NATIONAL VARCHAR(80);
   DECLARE v_ItemID_N NATIONAL VARCHAR(80);
   DECLARE v_WarehouseID_O NATIONAL VARCHAR(80);
   DECLARE v_WarehouseID_N NATIONAL VARCHAR(80);
   DECLARE v_SerialNumber_O NATIONAL VARCHAR(80);
   DECLARE v_SerialNumber_N NATIONAL VARCHAR(80);
   DECLARE v_OrderQty_O NATIONAL VARCHAR(80);
   DECLARE v_OrderQty_N NATIONAL VARCHAR(80);
   DECLARE v_BackOrdered_O NATIONAL VARCHAR(80);
   DECLARE v_BackOrdered_N NATIONAL VARCHAR(80);
   DECLARE v_BackOrderQty_O NATIONAL VARCHAR(80);
   DECLARE v_BackOrderQty_N NATIONAL VARCHAR(80);
   DECLARE v_ItemUOM_O NATIONAL VARCHAR(80);
   DECLARE v_ItemUOM_N NATIONAL VARCHAR(80);
   DECLARE v_ItemWeight_O NATIONAL VARCHAR(80);
   DECLARE v_ItemWeight_N NATIONAL VARCHAR(80);
   DECLARE v_Description_O NATIONAL VARCHAR(80);
   DECLARE v_Description_N NATIONAL VARCHAR(80);
   DECLARE v_DiscountPerc_O NATIONAL VARCHAR(80);
   DECLARE v_DiscountPerc_N NATIONAL VARCHAR(80);
   DECLARE v_Taxable_O NATIONAL VARCHAR(80);
   DECLARE v_Taxable_N NATIONAL VARCHAR(80);
   DECLARE v_CurrencyID_O NATIONAL VARCHAR(80);
   DECLARE v_CurrencyID_N NATIONAL VARCHAR(80);
   DECLARE v_CurrencyExchangeRate_O NATIONAL VARCHAR(80);
   DECLARE v_CurrencyExchangeRate_N NATIONAL VARCHAR(80);
   DECLARE v_ItemCost_O NATIONAL VARCHAR(80);
   DECLARE v_ItemCost_N NATIONAL VARCHAR(80);
   DECLARE v_ItemUnitPrice_O NATIONAL VARCHAR(80);
   DECLARE v_ItemUnitPrice_N NATIONAL VARCHAR(80);
   DECLARE v_Total_O NATIONAL VARCHAR(80);
   DECLARE v_Total_N NATIONAL VARCHAR(80);
   DECLARE v_TotalWeight_O NATIONAL VARCHAR(80);
   DECLARE v_TotalWeight_N NATIONAL VARCHAR(80);
   DECLARE v_GLSalesAccount_O NATIONAL VARCHAR(80);
   DECLARE v_GLSalesAccount_N NATIONAL VARCHAR(80);
   DECLARE v_ProjectID_O NATIONAL VARCHAR(80);
   DECLARE v_ProjectID_N NATIONAL VARCHAR(80);
   DECLARE v_TrackingNumber_O NATIONAL VARCHAR(80);
   DECLARE v_TrackingNumber_N NATIONAL VARCHAR(80);
   DECLARE v_DetailMemo1_O NATIONAL VARCHAR(80);
   DECLARE v_DetailMemo1_N NATIONAL VARCHAR(80);
   DECLARE v_DetailMemo2_O NATIONAL VARCHAR(80);
   DECLARE v_DetailMemo2_N NATIONAL VARCHAR(80);
   DECLARE v_DetailMemo3_O NATIONAL VARCHAR(80);
   DECLARE v_DetailMemo3_N NATIONAL VARCHAR(80);
   DECLARE v_DetailMemo4_O NATIONAL VARCHAR(80);
   DECLARE v_DetailMemo4_N NATIONAL VARCHAR(80);
   DECLARE v_DetailMemo5_O NATIONAL VARCHAR(80);
   DECLARE v_DetailMemo5_N NATIONAL VARCHAR(80);
   DECLARE v_TaxGroupID_O NATIONAL VARCHAR(80);
   DECLARE v_TaxGroupID_N NATIONAL VARCHAR(80);
   DECLARE v_TaxAmount_O NATIONAL VARCHAR(80);
   DECLARE v_TaxAmount_N NATIONAL VARCHAR(80);
   DECLARE v_TaxPercent_O NATIONAL VARCHAR(80);
   DECLARE v_TaxPercent_N NATIONAL VARCHAR(80);
   DECLARE v_SubTotal_O NATIONAL VARCHAR(80);
   DECLARE v_SubTotal_N NATIONAL VARCHAR(80);
 

-- updating records cursor declaration
   DECLARE cUpdate CURSOR
   FOR SELECT
   d.InvoiceNumber
		,i.InvoiceNumber
		,i.InvoiceLineNumber

		,i.CompanyID
		,i.DivisionID
		,i.DepartmentID
		,i.InvoiceNumber
		,i.InvoiceLineNumber

,CAST(d.ItemID AS CHAR(80))
,CAST(i.ItemID AS CHAR(80))
,CAST(d.WarehouseID AS CHAR(80))
,CAST(i.WarehouseID AS CHAR(80))
,CAST(d.SerialNumber AS CHAR(80))
,CAST(i.SerialNumber AS CHAR(80))
,CAST(d.OrderQty AS CHAR(80))
,CAST(i.OrderQty AS CHAR(80))
,CAST(d.BackOrdered AS CHAR(80))
,CAST(i.BackOrdered AS CHAR(80))
,CAST(d.BackOrderQty AS CHAR(80))
,CAST(i.BackOrderQty AS CHAR(80))
,CAST(d.ItemUOM AS CHAR(80))
,CAST(i.ItemUOM AS CHAR(80))
,CAST(d.ItemWeight AS CHAR(80))
,CAST(i.ItemWeight AS CHAR(80))
,CAST(d.Description AS CHAR(80))
,CAST(i.Description AS CHAR(80))
,CAST(d.DiscountPerc AS CHAR(80))
,CAST(i.DiscountPerc AS CHAR(80))
,CAST(d.Taxable AS CHAR(80))
,CAST(i.Taxable AS CHAR(80))
,CAST(d.CurrencyID AS CHAR(80))
,CAST(i.CurrencyID AS CHAR(80))
,CAST(d.CurrencyExchangeRate AS CHAR(80))
,CAST(i.CurrencyExchangeRate AS CHAR(80))
,CAST(d.ItemCost AS CHAR(80))
,CAST(i.ItemCost AS CHAR(80))
,CAST(d.ItemUnitPrice AS CHAR(80))
,CAST(i.ItemUnitPrice AS CHAR(80))
,CAST(d.Total AS CHAR(80))
,CAST(i.Total AS CHAR(80))
,CAST(d.TotalWeight AS CHAR(80))
,CAST(i.TotalWeight AS CHAR(80))
,CAST(d.GLSalesAccount AS CHAR(80))
,CAST(i.GLSalesAccount AS CHAR(80))
,CAST(d.ProjectID AS CHAR(80))
,CAST(i.ProjectID AS CHAR(80))
,CAST(d.TrackingNumber AS CHAR(80))
,CAST(i.TrackingNumber AS CHAR(80))
,CAST(d.DetailMemo1 AS CHAR(80))
,CAST(i.DetailMemo1 AS CHAR(80))
,CAST(d.DetailMemo2 AS CHAR(80))
,CAST(i.DetailMemo2 AS CHAR(80))
,CAST(d.DetailMemo3 AS CHAR(80))
,CAST(i.DetailMemo3 AS CHAR(80))
,CAST(d.DetailMemo4 AS CHAR(80))
,CAST(i.DetailMemo4 AS CHAR(80))
,CAST(d.DetailMemo5 AS CHAR(80))
,CAST(i.DetailMemo5 AS CHAR(80))
,CAST(d.TaxGroupID AS CHAR(80))
,CAST(i.TaxGroupID AS CHAR(80))
,CAST(d.TaxAmount AS CHAR(80))
,CAST(i.TaxAmount AS CHAR(80))
,CAST(d.TaxPercent AS CHAR(80))
,CAST(i.TaxPercent AS CHAR(80))
,CAST(d.SubTotal AS CHAR(80))
,CAST(i.SubTotal AS CHAR(80))
 

   FROM
   InsEDIInvoiceDetail i
   LEFT OUTER JOIN DelEDIInvoiceDetail d ON
   d.CompanyID = i.CompanyID
   AND d.DivisionID = i.DivisionID
   AND d.DepartmentID = i.DepartmentID
   AND d.InvoiceNumber = i.InvoiceNumber
   AND d.InvoiceLineNumber = i.InvoiceLineNumber;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET NO_DATA = -2;
   END;
   DECLARE CONTINUE HANDLER FOR NOT FOUND SET NO_DATA = -1;
   CREATE  TEMPORARY TABLE IF NOT EXISTS InsEDIInvoiceDetail
   (
      CompanyID NATIONAL VARCHAR(36),
      DivisionID NATIONAL VARCHAR(36),
      DepartmentID NATIONAL VARCHAR(36),
      InvoiceNumber NATIONAL VARCHAR(36),
      InvoiceLineNumber NUMERIC(18,0),
      ItemID NATIONAL VARCHAR(36),
      WarehouseID NATIONAL VARCHAR(36),
      SerialNumber NATIONAL VARCHAR(50),
      OrderQty FLOAT,
      BackOrdered BOOLEAN,
      BackOrderQty FLOAT,
      ItemUOM NATIONAL VARCHAR(15),
      ItemWeight FLOAT,
      Description NATIONAL VARCHAR(80),
      DiscountPerc FLOAT,
      Taxable BOOLEAN,
      CurrencyID NATIONAL VARCHAR(3),
      CurrencyExchangeRate FLOAT,
      ItemCost DECIMAL(19,4),
      ItemUnitPrice DECIMAL(19,4),
      Total DECIMAL(19,4),
      TotalWeight FLOAT,
      GLSalesAccount NATIONAL VARCHAR(36),
      ProjectID NATIONAL VARCHAR(36),
      TrackingNumber NATIONAL VARCHAR(50),
      DetailMemo1 NATIONAL VARCHAR(50),
      DetailMemo2 NATIONAL VARCHAR(50),
      DetailMemo3 NATIONAL VARCHAR(50),
      DetailMemo4 NATIONAL VARCHAR(50),
      DetailMemo5 NATIONAL VARCHAR(50),
      LockedBy NATIONAL VARCHAR(36),
      LockTS DATETIME,
      TaxGroupID NATIONAL VARCHAR(36),
      TaxAmount DECIMAL(19,4),
      TaxPercent FLOAT,
      SubTotal DECIMAL(19,4)
   );
   DELETE FROM InsEDIInvoiceDetail;
   INSERT INTO InsEDIInvoiceDetail VALUES(NEW.CompanyID, NEW.DivisionID, NEW.DepartmentID, NEW.InvoiceNumber, NEW.InvoiceLineNumber, NEW.ItemID, NEW.WarehouseID, NEW.SerialNumber, NEW.OrderQty, NEW.BackOrdered, NEW.BackOrderQty, NEW.ItemUOM, NEW.ItemWeight, NEW.Description, NEW.DiscountPerc, NEW.Taxable, NEW.CurrencyID, NEW.CurrencyExchangeRate, NEW.ItemCost, NEW.ItemUnitPrice, NEW.Total, NEW.TotalWeight, NEW.GLSalesAccount, NEW.ProjectID, NEW.TrackingNumber, NEW.DetailMemo1, NEW.DetailMemo2, NEW.DetailMemo3, NEW.DetailMemo4, NEW.DetailMemo5, NEW.LockedBy, NEW.LockTS, NEW.TaxGroupID, NEW.TaxAmount, NEW.TaxPercent, NEW.SubTotal);

   CREATE  TEMPORARY TABLE IF NOT EXISTS DelEDIInvoiceDetail
   (
      CompanyID NATIONAL VARCHAR(36),
      DivisionID NATIONAL VARCHAR(36),
      DepartmentID NATIONAL VARCHAR(36),
      InvoiceNumber NATIONAL VARCHAR(36),
      InvoiceLineNumber NUMERIC(18,0),
      ItemID NATIONAL VARCHAR(36),
      WarehouseID NATIONAL VARCHAR(36),
      SerialNumber NATIONAL VARCHAR(50),
      OrderQty FLOAT,
      BackOrdered BOOLEAN,
      BackOrderQty FLOAT,
      ItemUOM NATIONAL VARCHAR(15),
      ItemWeight FLOAT,
      Description NATIONAL VARCHAR(80),
      DiscountPerc FLOAT,
      Taxable BOOLEAN,
      CurrencyID NATIONAL VARCHAR(3),
      CurrencyExchangeRate FLOAT,
      ItemCost DECIMAL(19,4),
      ItemUnitPrice DECIMAL(19,4),
      Total DECIMAL(19,4),
      TotalWeight FLOAT,
      GLSalesAccount NATIONAL VARCHAR(36),
      ProjectID NATIONAL VARCHAR(36),
      TrackingNumber NATIONAL VARCHAR(50),
      DetailMemo1 NATIONAL VARCHAR(50),
      DetailMemo2 NATIONAL VARCHAR(50),
      DetailMemo3 NATIONAL VARCHAR(50),
      DetailMemo4 NATIONAL VARCHAR(50),
      DetailMemo5 NATIONAL VARCHAR(50),
      LockedBy NATIONAL VARCHAR(36),
      LockTS DATETIME,
      TaxGroupID NATIONAL VARCHAR(36),
      TaxAmount DECIMAL(19,4),
      TaxPercent FLOAT,
      SubTotal DECIMAL(19,4)
   );
   DELETE FROM DelEDIInvoiceDetail;
   INSERT INTO DelEDIInvoiceDetail VALUES(OLD.CompanyID, OLD.DivisionID, OLD.DepartmentID, OLD.InvoiceNumber, OLD.InvoiceLineNumber, OLD.ItemID, OLD.WarehouseID, OLD.SerialNumber, OLD.OrderQty, OLD.BackOrdered, OLD.BackOrderQty, OLD.ItemUOM, OLD.ItemWeight, OLD.Description, OLD.DiscountPerc, OLD.Taxable, OLD.CurrencyID, OLD.CurrencyExchangeRate, OLD.ItemCost, OLD.ItemUnitPrice, OLD.Total, OLD.TotalWeight, OLD.GLSalesAccount, OLD.ProjectID, OLD.TrackingNumber, OLD.DetailMemo1, OLD.DetailMemo2, OLD.DetailMemo3, OLD.DetailMemo4, OLD.DetailMemo5, OLD.LockedBy, OLD.LockTS, OLD.TaxGroupID, OLD.TaxAmount, OLD.TaxPercent, OLD.SubTotal);

   BEGIN
-- check for audit triggers switch off

      select   context_info INTO v_Context FROM sysprocesses WHERE spid = CONNECTION_ID();
      IF CAST(v_Context AS CHAR(36)) = N'$$AuditSwitchOff$$' then 
         LEAVE SWL_return;
      end if;

-- declarations
      OPEN cUpdate;
-- fetch from each updating record
      SET NO_DATA = 0;
      FETCH cUpdate INTO
      v_TransactionNumber_O,v_TransactionNumber_N,v_TransactionLineNumber,v_CompanyID,
      v_DivisionID,v_DepartmentID,v_InvoiceNumber,v_InvoiceLineNumber,
      v_ItemID_O,v_ItemID_N,v_WarehouseID_O,v_WarehouseID_N,v_SerialNumber_O,
      v_SerialNumber_N,v_OrderQty_O,v_OrderQty_N,v_BackOrdered_O,v_BackOrdered_N,
      v_BackOrderQty_O,v_BackOrderQty_N,v_ItemUOM_O,v_ItemUOM_N,v_ItemWeight_O,
      v_ItemWeight_N,v_Description_O,v_Description_N,v_DiscountPerc_O,
      v_DiscountPerc_N,v_Taxable_O,v_Taxable_N,v_CurrencyID_O,v_CurrencyID_N,
      v_CurrencyExchangeRate_O,v_CurrencyExchangeRate_N,v_ItemCost_O,
      v_ItemCost_N,v_ItemUnitPrice_O,v_ItemUnitPrice_N,v_Total_O,v_Total_N,
      v_TotalWeight_O,v_TotalWeight_N,v_GLSalesAccount_O,v_GLSalesAccount_N,
      v_ProjectID_O,v_ProjectID_N,v_TrackingNumber_O,v_TrackingNumber_N,v_DetailMemo1_O,
      v_DetailMemo1_N,v_DetailMemo2_O,v_DetailMemo2_N,v_DetailMemo3_O,
      v_DetailMemo3_N,v_DetailMemo4_O,v_DetailMemo4_N,v_DetailMemo5_O,
      v_DetailMemo5_N,v_TaxGroupID_O,v_TaxGroupID_N,v_TaxAmount_O,v_TaxAmount_N,
      v_TaxPercent_O,v_TaxPercent_N,v_SubTotal_O,v_SubTotal_N;
      WHILE NO_DATA = 0 DO
-- insert audit records for each changed field
         IF IsGuid(v_TransactionNumber_N) = 0 then
		
            IF v_TransactionNumber_O IS NULL then
				
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIInvoiceDetail','New Record','','New Record');
            ELSE
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIInvoiceDetail','ItemID',v_ItemID_O,v_ItemID_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIInvoiceDetail','WarehouseID',v_WarehouseID_O,
               v_WarehouseID_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIInvoiceDetail','SerialNumber',v_SerialNumber_O,
               v_SerialNumber_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIInvoiceDetail','OrderQty',v_OrderQty_O,v_OrderQty_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIInvoiceDetail','BackOrdered',v_BackOrdered_O,
               v_BackOrdered_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIInvoiceDetail','BackOrderQty',v_BackOrderQty_O,
               v_BackOrderQty_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIInvoiceDetail','ItemUOM',v_ItemUOM_O,v_ItemUOM_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIInvoiceDetail','ItemWeight',v_ItemWeight_O,v_ItemWeight_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIInvoiceDetail','Description',v_Description_O,
               v_Description_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIInvoiceDetail','DiscountPerc',v_DiscountPerc_O,
               v_DiscountPerc_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIInvoiceDetail','Taxable',v_Taxable_O,v_Taxable_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIInvoiceDetail','CurrencyID',v_CurrencyID_O,v_CurrencyID_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIInvoiceDetail','CurrencyExchangeRate',v_CurrencyExchangeRate_O,
               v_CurrencyExchangeRate_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIInvoiceDetail','ItemCost',v_ItemCost_O,v_ItemCost_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIInvoiceDetail','ItemUnitPrice',v_ItemUnitPrice_O,
               v_ItemUnitPrice_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIInvoiceDetail','Total',v_Total_O,v_Total_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIInvoiceDetail','TotalWeight',v_TotalWeight_O,
               v_TotalWeight_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIInvoiceDetail','GLSalesAccount',v_GLSalesAccount_O,
               v_GLSalesAccount_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIInvoiceDetail','ProjectID',v_ProjectID_O,v_ProjectID_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIInvoiceDetail','TrackingNumber',v_TrackingNumber_O,
               v_TrackingNumber_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIInvoiceDetail','DetailMemo1',v_DetailMemo1_O,
               v_DetailMemo1_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIInvoiceDetail','DetailMemo2',v_DetailMemo2_O,
               v_DetailMemo2_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIInvoiceDetail','DetailMemo3',v_DetailMemo3_O,
               v_DetailMemo3_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIInvoiceDetail','DetailMemo4',v_DetailMemo4_O,
               v_DetailMemo4_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIInvoiceDetail','DetailMemo5',v_DetailMemo5_O,
               v_DetailMemo5_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIInvoiceDetail','TaxGroupID',v_TaxGroupID_O,v_TaxGroupID_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIInvoiceDetail','TaxAmount',v_TaxAmount_O,v_TaxAmount_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIInvoiceDetail','TaxPercent',v_TaxPercent_O,v_TaxPercent_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIInvoiceDetail','SubTotal',v_SubTotal_O,v_SubTotal_N);
            end if;
         end if;
         SET NO_DATA = 0;
         FETCH cUpdate INTO
         v_TransactionNumber_O,v_TransactionNumber_N,v_TransactionLineNumber,v_CompanyID,
         v_DivisionID,v_DepartmentID,v_InvoiceNumber,v_InvoiceLineNumber,
         v_ItemID_O,v_ItemID_N,v_WarehouseID_O,v_WarehouseID_N,v_SerialNumber_O,
         v_SerialNumber_N,v_OrderQty_O,v_OrderQty_N,v_BackOrdered_O,v_BackOrdered_N,
         v_BackOrderQty_O,v_BackOrderQty_N,v_ItemUOM_O,v_ItemUOM_N,v_ItemWeight_O,
         v_ItemWeight_N,v_Description_O,v_Description_N,v_DiscountPerc_O,
         v_DiscountPerc_N,v_Taxable_O,v_Taxable_N,v_CurrencyID_O,v_CurrencyID_N,
         v_CurrencyExchangeRate_O,v_CurrencyExchangeRate_N,v_ItemCost_O,
         v_ItemCost_N,v_ItemUnitPrice_O,v_ItemUnitPrice_N,v_Total_O,v_Total_N,
         v_TotalWeight_O,v_TotalWeight_N,v_GLSalesAccount_O,v_GLSalesAccount_N,
         v_ProjectID_O,v_ProjectID_N,v_TrackingNumber_O,v_TrackingNumber_N,v_DetailMemo1_O,
         v_DetailMemo1_N,v_DetailMemo2_O,v_DetailMemo2_N,v_DetailMemo3_O,
         v_DetailMemo3_N,v_DetailMemo4_O,v_DetailMemo4_N,v_DetailMemo5_O,
         v_DetailMemo5_N,v_TaxGroupID_O,v_TaxGroupID_N,v_TaxAmount_O,v_TaxAmount_N,
         v_TaxPercent_O,v_TaxPercent_N,v_SubTotal_O,v_SubTotal_N;
      END WHILE;
      CLOSE cUpdate;

   END;
END;
 ;;
delimiter ;
delimiter ;;
CREATE TRIGGER `EDIInvoiceDetail_Audit_Delete` AFTER DELETE ON `ediinvoicedetail` FOR EACH ROW SWL_return:
BEGIN
   DECLARE NO_DATA INT DEFAULT 0;
   DECLARE v_Context VARBINARY(128);
   DECLARE v_TransactionNumber NATIONAL VARCHAR(50);
   DECLARE v_TransactionLineNumber NATIONAL VARCHAR(50);

   DECLARE v_CompanyID NATIONAL VARCHAR(36);
   DECLARE v_DivisionID NATIONAL VARCHAR(36);
   DECLARE v_DepartmentID NATIONAL VARCHAR(36);
   DECLARE v_InvoiceNumber NATIONAL VARCHAR(36);
   DECLARE v_InvoiceLineNumber NUMERIC(18,0);

-- deleting records cursor declaration
   DECLARE cDelete CURSOR
   FOR SELECT
   d.InvoiceNumber
		,d.InvoiceLineNumber

		,d.CompanyID
		,d.DivisionID
		,d.DepartmentID
		,d.InvoiceNumber
		,d.InvoiceLineNumber

   FROM
   DelEDIInvoiceDetail d;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET NO_DATA = -2;
   END;
   DECLARE CONTINUE HANDLER FOR NOT FOUND SET NO_DATA = -1;
   CREATE  TEMPORARY TABLE IF NOT EXISTS DelEDIInvoiceDetail
   (
      CompanyID NATIONAL VARCHAR(36),
      DivisionID NATIONAL VARCHAR(36),
      DepartmentID NATIONAL VARCHAR(36),
      InvoiceNumber NATIONAL VARCHAR(36),
      InvoiceLineNumber NUMERIC(18,0),
      ItemID NATIONAL VARCHAR(36),
      WarehouseID NATIONAL VARCHAR(36),
      SerialNumber NATIONAL VARCHAR(50),
      OrderQty FLOAT,
      BackOrdered BOOLEAN,
      BackOrderQty FLOAT,
      ItemUOM NATIONAL VARCHAR(15),
      ItemWeight FLOAT,
      Description NATIONAL VARCHAR(80),
      DiscountPerc FLOAT,
      Taxable BOOLEAN,
      CurrencyID NATIONAL VARCHAR(3),
      CurrencyExchangeRate FLOAT,
      ItemCost DECIMAL(19,4),
      ItemUnitPrice DECIMAL(19,4),
      Total DECIMAL(19,4),
      TotalWeight FLOAT,
      GLSalesAccount NATIONAL VARCHAR(36),
      ProjectID NATIONAL VARCHAR(36),
      TrackingNumber NATIONAL VARCHAR(50),
      DetailMemo1 NATIONAL VARCHAR(50),
      DetailMemo2 NATIONAL VARCHAR(50),
      DetailMemo3 NATIONAL VARCHAR(50),
      DetailMemo4 NATIONAL VARCHAR(50),
      DetailMemo5 NATIONAL VARCHAR(50),
      LockedBy NATIONAL VARCHAR(36),
      LockTS DATETIME,
      TaxGroupID NATIONAL VARCHAR(36),
      TaxAmount DECIMAL(19,4),
      TaxPercent FLOAT,
      SubTotal DECIMAL(19,4)
   );
   DELETE FROM DelEDIInvoiceDetail;
   INSERT INTO DelEDIInvoiceDetail VALUES(OLD.CompanyID, OLD.DivisionID, OLD.DepartmentID, OLD.InvoiceNumber, OLD.InvoiceLineNumber, OLD.ItemID, OLD.WarehouseID, OLD.SerialNumber, OLD.OrderQty, OLD.BackOrdered, OLD.BackOrderQty, OLD.ItemUOM, OLD.ItemWeight, OLD.Description, OLD.DiscountPerc, OLD.Taxable, OLD.CurrencyID, OLD.CurrencyExchangeRate, OLD.ItemCost, OLD.ItemUnitPrice, OLD.Total, OLD.TotalWeight, OLD.GLSalesAccount, OLD.ProjectID, OLD.TrackingNumber, OLD.DetailMemo1, OLD.DetailMemo2, OLD.DetailMemo3, OLD.DetailMemo4, OLD.DetailMemo5, OLD.LockedBy, OLD.LockTS, OLD.TaxGroupID, OLD.TaxAmount, OLD.TaxPercent, OLD.SubTotal);

   BEGIN
-- check for audit triggers switch off

      select   context_info INTO v_Context FROM sysprocesses WHERE spid = CONNECTION_ID();
      IF CAST(v_Context AS CHAR(36)) = N'$$AuditSwitchOff$$' then 
         LEAVE SWL_return;
      end if;

-- declarations
      OPEN cDelete;
-- fetch from each deleting record
      SET NO_DATA = 0;
      FETCH cDelete INTO
      v_TransactionNumber,v_TransactionLineNumber,v_CompanyID,v_DivisionID,v_DepartmentID,
      v_InvoiceNumber,v_InvoiceLineNumber;
      WHILE NO_DATA = 0 DO
-- insert audit record for each deleting record
         CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber,v_TransactionLineNumber,
         'EDIInvoiceDetail','Deleted','','Deleted');
         SET NO_DATA = 0;
         FETCH cDelete INTO
         v_TransactionNumber,v_TransactionLineNumber,v_CompanyID,v_DivisionID,v_DepartmentID,
         v_InvoiceNumber,v_InvoiceLineNumber;
      END WHILE;
      CLOSE cDelete;

   END;
END;
 ;;
delimiter ;

-- ----------------------------
--  Table structure for `ediinvoiceheader`
-- ----------------------------
DROP TABLE IF EXISTS `ediinvoiceheader`;
CREATE TABLE `ediinvoiceheader` (
  `CompanyID` varchar(36) NOT NULL,
  `DivisionID` varchar(36) NOT NULL,
  `DepartmentID` varchar(36) NOT NULL,
  `InvoiceNumber` varchar(36) NOT NULL,
  `OrderNumber` varchar(36) DEFAULT NULL,
  `TransactionTypeID` varchar(36) DEFAULT NULL,
  `EDIDirectionTypeID` varchar(1) DEFAULT NULL,
  `EDIDocumentTypeID` varchar(3) DEFAULT NULL,
  `EDIOpen` tinyint(1) DEFAULT NULL,
  `TransOpen` tinyint(1) DEFAULT NULL,
  `InvoiceTypeID` varchar(36) DEFAULT NULL,
  `InvoiceDate` datetime DEFAULT NULL,
  `InvoiceDueDate` datetime DEFAULT NULL,
  `InvoiceShipDate` datetime DEFAULT NULL,
  `InvoiceCancelDate` datetime DEFAULT NULL,
  `PurchaseOrderNumber` varchar(36) DEFAULT NULL,
  `TaxExemptID` varchar(36) DEFAULT NULL,
  `TaxGroupID` varchar(36) DEFAULT NULL,
  `CustomerID` varchar(50) DEFAULT NULL,
  `CustomerShipToID` varchar(36) DEFAULT NULL,
  `CustomerShipForID` varchar(36) DEFAULT NULL,
  `WarehouseID` varchar(36) DEFAULT NULL,
  `CustomerDropShipment` tinyint(1) DEFAULT NULL,
  `ShippingName` varchar(50) DEFAULT NULL,
  `ShippingAddress1` varchar(50) DEFAULT NULL,
  `ShippingAddress2` varchar(50) DEFAULT NULL,
  `ShippingCity` varchar(50) DEFAULT NULL,
  `ShippingState` varchar(50) DEFAULT NULL,
  `ShippingZip` varchar(10) DEFAULT NULL,
  `ShippingCountry` varchar(50) DEFAULT NULL,
  `ShipMethodID` varchar(15) DEFAULT NULL,
  `EmployeeID` varchar(15) DEFAULT NULL,
  `TermsID` varchar(36) DEFAULT NULL,
  `PaymentMethodID` varchar(36) DEFAULT NULL,
  `CurrencyID` varchar(3) DEFAULT NULL,
  `CurrencyExchangeRate` float DEFAULT NULL,
  `Subtotal` decimal(19,4) DEFAULT NULL,
  `DiscountPers` float DEFAULT NULL,
  `DiscountAmount` decimal(19,4) DEFAULT NULL,
  `TaxPercent` float DEFAULT NULL,
  `TaxAmount` decimal(19,4) DEFAULT NULL,
  `TaxableSubTotal` decimal(19,4) DEFAULT NULL,
  `Freight` decimal(19,4) DEFAULT NULL,
  `TaxFreight` tinyint(1) DEFAULT NULL,
  `Handling` decimal(19,4) DEFAULT NULL,
  `Advertising` decimal(19,4) DEFAULT NULL,
  `Total` decimal(19,4) DEFAULT NULL,
  `AmountPaid` decimal(19,4) DEFAULT NULL,
  `BalanceDue` decimal(19,4) DEFAULT NULL,
  `UndistributedAmount` decimal(19,4) DEFAULT NULL,
  `Commission` decimal(19,4) DEFAULT NULL,
  `CommissionableSales` decimal(19,4) DEFAULT NULL,
  `ComissionalbleCost` decimal(19,4) DEFAULT NULL,
  `GLSalesAccount` varchar(36) DEFAULT NULL,
  `CheckNumber` varchar(20) DEFAULT NULL,
  `CheckDate` datetime DEFAULT NULL,
  `CreditCardTypeID` varchar(15) DEFAULT NULL,
  `CreditCardName` varchar(50) DEFAULT NULL,
  `CreditCardNumber` varchar(50) DEFAULT NULL,
  `CreditCardExpDate` datetime DEFAULT NULL,
  `CreditCardCSVNumber` varchar(5) DEFAULT NULL,
  `CreditCardBillToZip` varchar(10) DEFAULT NULL,
  `CreditCardValidationCode` varchar(20) DEFAULT NULL,
  `CreditCardApprovalNumber` varchar(20) DEFAULT NULL,
  `Picked` tinyint(1) DEFAULT NULL,
  `PickedDate` datetime DEFAULT NULL,
  `Billed` tinyint(1) DEFAULT NULL,
  `BilledDate` datetime DEFAULT NULL,
  `Printed` tinyint(1) DEFAULT NULL,
  `PrintedDate` datetime DEFAULT NULL,
  `Shipped` tinyint(1) DEFAULT NULL,
  `ShipDate` datetime DEFAULT NULL,
  `TrackingNumber` varchar(50) DEFAULT NULL,
  `Backordered` tinyint(1) DEFAULT NULL,
  `Posted` tinyint(1) DEFAULT NULL,
  `PostedDate` datetime DEFAULT NULL,
  `HeaderMemo1` varchar(50) DEFAULT NULL,
  `HeaderMemo2` varchar(50) DEFAULT NULL,
  `HeaderMemo3` varchar(50) DEFAULT NULL,
  `HeaderMemo4` varchar(50) DEFAULT NULL,
  `HeaderMemo5` varchar(50) DEFAULT NULL,
  `HeaderMemo6` varchar(50) DEFAULT NULL,
  `HeaderMemo7` varchar(50) DEFAULT NULL,
  `HeaderMemo8` varchar(50) DEFAULT NULL,
  `HeaderMemo9` varchar(50) DEFAULT NULL,
  `LockedBy` varchar(36) DEFAULT NULL,
  `LockTS` datetime DEFAULT NULL,
  `AllowanceDiscountPerc` float DEFAULT NULL,
  PRIMARY KEY (`CompanyID`,`DivisionID`,`DepartmentID`,`InvoiceNumber`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
delimiter ;;
CREATE TRIGGER `EDIInvoiceHeader_Audit_Insert` AFTER INSERT ON `ediinvoiceheader` FOR EACH ROW SWL_return:
BEGIN
   DECLARE NO_DATA INT DEFAULT 0;
   DECLARE v_Context VARBINARY(128);
   DECLARE v_TransactionNumber NATIONAL VARCHAR(50);
   DECLARE v_TransactionLineNumber NATIONAL VARCHAR(50);

   DECLARE v_CompanyID NATIONAL VARCHAR(36);
   DECLARE v_DivisionID NATIONAL VARCHAR(36);
   DECLARE v_DepartmentID NATIONAL VARCHAR(36);
   DECLARE v_InvoiceNumber NATIONAL VARCHAR(36);

-- inserting records cursor declaration
   DECLARE cInsert CURSOR
   FOR SELECT
   i.InvoiceNumber
		,''

		,i.CompanyID
		,i.DivisionID
		,i.DepartmentID
		,i.InvoiceNumber

   FROM
   InsEDIInvoiceHeader i;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET NO_DATA = -2;
   END;
   DECLARE CONTINUE HANDLER FOR NOT FOUND SET NO_DATA = -1;
   CREATE  TEMPORARY TABLE IF NOT EXISTS InsEDIInvoiceHeader
   (
      CompanyID NATIONAL VARCHAR(36),
      DivisionID NATIONAL VARCHAR(36),
      DepartmentID NATIONAL VARCHAR(36),
      InvoiceNumber NATIONAL VARCHAR(36),
      OrderNumber NATIONAL VARCHAR(36),
      TransactionTypeID NATIONAL VARCHAR(36),
      EDIDirectionTypeID NATIONAL VARCHAR(1),
      EDIDocumentTypeID NATIONAL VARCHAR(3),
      EDIOpen BOOLEAN,
      TransOpen BOOLEAN,
      InvoiceTypeID NATIONAL VARCHAR(36),
      InvoiceDate DATETIME,
      InvoiceDueDate DATETIME,
      InvoiceShipDate DATETIME,
      InvoiceCancelDate DATETIME,
      PurchaseOrderNumber NATIONAL VARCHAR(36),
      TaxExemptID NATIONAL VARCHAR(36),
      TaxGroupID NATIONAL VARCHAR(36),
      CustomerID NATIONAL VARCHAR(50),
      CustomerShipToID NATIONAL VARCHAR(36),
      CustomerShipForID NATIONAL VARCHAR(36),
      WarehouseID NATIONAL VARCHAR(36),
      CustomerDropShipment BOOLEAN,
      ShippingName NATIONAL VARCHAR(50),
      ShippingAddress1 NATIONAL VARCHAR(50),
      ShippingAddress2 NATIONAL VARCHAR(50),
      ShippingCity NATIONAL VARCHAR(50),
      ShippingState NATIONAL VARCHAR(50),
      ShippingZip NATIONAL VARCHAR(10),
      ShippingCountry NATIONAL VARCHAR(50),
      ShipMethodID NATIONAL VARCHAR(15),
      EmployeeID NATIONAL VARCHAR(15),
      TermsID NATIONAL VARCHAR(36),
      PaymentMethodID NATIONAL VARCHAR(36),
      CurrencyID NATIONAL VARCHAR(3),
      CurrencyExchangeRate FLOAT,
      Subtotal DECIMAL(19,4),
      DiscountPers FLOAT,
      DiscountAmount DECIMAL(19,4),
      TaxPercent FLOAT,
      TaxAmount DECIMAL(19,4),
      TaxableSubTotal DECIMAL(19,4),
      Freight DECIMAL(19,4),
      TaxFreight BOOLEAN,
      Handling DECIMAL(19,4),
      Advertising DECIMAL(19,4),
      Total DECIMAL(19,4),
      AmountPaid DECIMAL(19,4),
      BalanceDue DECIMAL(19,4),
      UndistributedAmount DECIMAL(19,4),
      Commission DECIMAL(19,4),
      CommissionableSales DECIMAL(19,4),
      ComissionalbleCost DECIMAL(19,4),
      GLSalesAccount NATIONAL VARCHAR(36),
      CheckNumber NATIONAL VARCHAR(20),
      CheckDate DATETIME,
      CreditCardTypeID NATIONAL VARCHAR(15),
      CreditCardName NATIONAL VARCHAR(50),
      CreditCardNumber NATIONAL VARCHAR(50),
      CreditCardExpDate DATETIME,
      CreditCardCSVNumber NATIONAL VARCHAR(5),
      CreditCardBillToZip NATIONAL VARCHAR(10),
      CreditCardValidationCode NATIONAL VARCHAR(20),
      CreditCardApprovalNumber NATIONAL VARCHAR(20),
      Picked BOOLEAN,
      PickedDate DATETIME,
      Billed BOOLEAN,
      BilledDate DATETIME,
      Printed BOOLEAN,
      PrintedDate DATETIME,
      Shipped BOOLEAN,
      ShipDate DATETIME,
      TrackingNumber NATIONAL VARCHAR(50),
      Backordered BOOLEAN,
      Posted BOOLEAN,
      PostedDate DATETIME,
      HeaderMemo1 NATIONAL VARCHAR(50),
      HeaderMemo2 NATIONAL VARCHAR(50),
      HeaderMemo3 NATIONAL VARCHAR(50),
      HeaderMemo4 NATIONAL VARCHAR(50),
      HeaderMemo5 NATIONAL VARCHAR(50),
      HeaderMemo6 NATIONAL VARCHAR(50),
      HeaderMemo7 NATIONAL VARCHAR(50),
      HeaderMemo8 NATIONAL VARCHAR(50),
      HeaderMemo9 NATIONAL VARCHAR(50),
      LockedBy NATIONAL VARCHAR(36),
      LockTS DATETIME,
      AllowanceDiscountPerc FLOAT
   );
   DELETE FROM InsEDIInvoiceHeader;
   INSERT INTO InsEDIInvoiceHeader VALUES(NEW.CompanyID, NEW.DivisionID, NEW.DepartmentID, NEW.InvoiceNumber, NEW.OrderNumber, NEW.TransactionTypeID, NEW.EDIDirectionTypeID, NEW.EDIDocumentTypeID, NEW.EDIOpen, NEW.TransOpen, NEW.InvoiceTypeID, NEW.InvoiceDate, NEW.InvoiceDueDate, NEW.InvoiceShipDate, NEW.InvoiceCancelDate, NEW.PurchaseOrderNumber, NEW.TaxExemptID, NEW.TaxGroupID, NEW.CustomerID, NEW.CustomerShipToID, NEW.CustomerShipForID, NEW.WarehouseID, NEW.CustomerDropShipment, NEW.ShippingName, NEW.ShippingAddress1, NEW.ShippingAddress2, NEW.ShippingCity, NEW.ShippingState, NEW.ShippingZip, NEW.ShippingCountry, NEW.ShipMethodID, NEW.EmployeeID, NEW.TermsID, NEW.PaymentMethodID, NEW.CurrencyID, NEW.CurrencyExchangeRate, NEW.Subtotal, NEW.DiscountPers, NEW.DiscountAmount, NEW.TaxPercent, NEW.TaxAmount, NEW.TaxableSubTotal, NEW.Freight, NEW.TaxFreight, NEW.Handling, NEW.Advertising, NEW.Total, NEW.AmountPaid, NEW.BalanceDue, NEW.UndistributedAmount, NEW.Commission, NEW.CommissionableSales, NEW.ComissionalbleCost, NEW.GLSalesAccount, NEW.CheckNumber, NEW.CheckDate, NEW.CreditCardTypeID, NEW.CreditCardName, NEW.CreditCardNumber, NEW.CreditCardExpDate, NEW.CreditCardCSVNumber, NEW.CreditCardBillToZip, NEW.CreditCardValidationCode, NEW.CreditCardApprovalNumber, NEW.Picked, NEW.PickedDate, NEW.Billed, NEW.BilledDate, NEW.Printed, NEW.PrintedDate, NEW.Shipped, NEW.ShipDate, NEW.TrackingNumber, NEW.Backordered, NEW.Posted, NEW.PostedDate, NEW.HeaderMemo1, NEW.HeaderMemo2, NEW.HeaderMemo3, NEW.HeaderMemo4, NEW.HeaderMemo5, NEW.HeaderMemo6, NEW.HeaderMemo7, NEW.HeaderMemo8, NEW.HeaderMemo9, NEW.LockedBy, NEW.LockTS, NEW.AllowanceDiscountPerc);

   BEGIN
-- check for audit triggers switch off

      select   context_info INTO v_Context FROM sysprocesses WHERE spid = CONNECTION_ID();
      IF CAST(v_Context AS CHAR(36)) = N'$$AuditSwitchOff$$' then 
         LEAVE SWL_return;
      end if;

-- declarations
      OPEN cInsert;
-- fetch from each inserting record
      SET NO_DATA = 0;
      FETCH cInsert INTO
      v_TransactionNumber,v_TransactionLineNumber,v_CompanyID,v_DivisionID,v_DepartmentID,
      v_InvoiceNumber;
      WHILE NO_DATA = 0 DO
-- insert audit record for each inserting record
         IF IsGuid(v_TransactionNumber) = 0 then
		
            CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber,v_TransactionLineNumber,
            'EDIInvoiceHeader','New Record','','New Record');
         end if;
         SET NO_DATA = 0;
         FETCH cInsert INTO
         v_TransactionNumber,v_TransactionLineNumber,v_CompanyID,v_DivisionID,v_DepartmentID,
         v_InvoiceNumber;
      END WHILE;
      CLOSE cInsert;

   END;
END;
 ;;
delimiter ;
delimiter ;;
CREATE TRIGGER `EDIInvoiceHeader_Audit_Update` AFTER UPDATE ON `ediinvoiceheader` FOR EACH ROW SWL_return:
BEGIN
   DECLARE NO_DATA INT DEFAULT 0;
   DECLARE v_Context VARBINARY(128);
   DECLARE v_TransactionNumber_O NATIONAL VARCHAR(50);
   DECLARE v_TransactionNumber_N NATIONAL VARCHAR(50);
   DECLARE v_TransactionLineNumber NATIONAL VARCHAR(50);

   DECLARE v_CompanyID NATIONAL VARCHAR(36);
   DECLARE v_DivisionID NATIONAL VARCHAR(36);
   DECLARE v_DepartmentID NATIONAL VARCHAR(36);
   DECLARE v_InvoiceNumber NATIONAL VARCHAR(36);

   DECLARE v_OrderNumber_O NATIONAL VARCHAR(80);
   DECLARE v_OrderNumber_N NATIONAL VARCHAR(80);
   DECLARE v_TransactionTypeID_O NATIONAL VARCHAR(80);
   DECLARE v_TransactionTypeID_N NATIONAL VARCHAR(80);
   DECLARE v_EDIDirectionTypeID_O NATIONAL VARCHAR(80);
   DECLARE v_EDIDirectionTypeID_N NATIONAL VARCHAR(80);
   DECLARE v_EDIDocumentTypeID_O NATIONAL VARCHAR(80);
   DECLARE v_EDIDocumentTypeID_N NATIONAL VARCHAR(80);
   DECLARE v_EDIOpen_O NATIONAL VARCHAR(80);
   DECLARE v_EDIOpen_N NATIONAL VARCHAR(80);
   DECLARE v_TransOpen_O NATIONAL VARCHAR(80);
   DECLARE v_TransOpen_N NATIONAL VARCHAR(80);
   DECLARE v_InvoiceTypeID_O NATIONAL VARCHAR(80);
   DECLARE v_InvoiceTypeID_N NATIONAL VARCHAR(80);
   DECLARE v_InvoiceDate_O NATIONAL VARCHAR(80);
   DECLARE v_InvoiceDate_N NATIONAL VARCHAR(80);
   DECLARE v_InvoiceDueDate_O NATIONAL VARCHAR(80);
   DECLARE v_InvoiceDueDate_N NATIONAL VARCHAR(80);
   DECLARE v_InvoiceShipDate_O NATIONAL VARCHAR(80);
   DECLARE v_InvoiceShipDate_N NATIONAL VARCHAR(80);
   DECLARE v_InvoiceCancelDate_O NATIONAL VARCHAR(80);
   DECLARE v_InvoiceCancelDate_N NATIONAL VARCHAR(80);
   DECLARE v_PurchaseOrderNumber_O NATIONAL VARCHAR(80);
   DECLARE v_PurchaseOrderNumber_N NATIONAL VARCHAR(80);
   DECLARE v_TaxExemptID_O NATIONAL VARCHAR(80);
   DECLARE v_TaxExemptID_N NATIONAL VARCHAR(80);
   DECLARE v_TaxGroupID_O NATIONAL VARCHAR(80);
   DECLARE v_TaxGroupID_N NATIONAL VARCHAR(80);
   DECLARE v_CustomerID_O NATIONAL VARCHAR(80);
   DECLARE v_CustomerID_N NATIONAL VARCHAR(80);
   DECLARE v_CustomerShipToID_O NATIONAL VARCHAR(80);
   DECLARE v_CustomerShipToID_N NATIONAL VARCHAR(80);
   DECLARE v_CustomerShipForID_O NATIONAL VARCHAR(80);
   DECLARE v_CustomerShipForID_N NATIONAL VARCHAR(80);
   DECLARE v_WarehouseID_O NATIONAL VARCHAR(80);
   DECLARE v_WarehouseID_N NATIONAL VARCHAR(80);
   DECLARE v_CustomerDropShipment_O NATIONAL VARCHAR(80);
   DECLARE v_CustomerDropShipment_N NATIONAL VARCHAR(80);
   DECLARE v_ShippingName_O NATIONAL VARCHAR(80);
   DECLARE v_ShippingName_N NATIONAL VARCHAR(80);
   DECLARE v_ShippingAddress1_O NATIONAL VARCHAR(80);
   DECLARE v_ShippingAddress1_N NATIONAL VARCHAR(80);
   DECLARE v_ShippingAddress2_O NATIONAL VARCHAR(80);
   DECLARE v_ShippingAddress2_N NATIONAL VARCHAR(80);
   DECLARE v_ShippingCity_O NATIONAL VARCHAR(80);
   DECLARE v_ShippingCity_N NATIONAL VARCHAR(80);
   DECLARE v_ShippingState_O NATIONAL VARCHAR(80);
   DECLARE v_ShippingState_N NATIONAL VARCHAR(80);
   DECLARE v_ShippingZip_O NATIONAL VARCHAR(80);
   DECLARE v_ShippingZip_N NATIONAL VARCHAR(80);
   DECLARE v_ShippingCountry_O NATIONAL VARCHAR(80);
   DECLARE v_ShippingCountry_N NATIONAL VARCHAR(80);
   DECLARE v_ShipMethodID_O NATIONAL VARCHAR(80);
   DECLARE v_ShipMethodID_N NATIONAL VARCHAR(80);
   DECLARE v_EmployeeID_O NATIONAL VARCHAR(80);
   DECLARE v_EmployeeID_N NATIONAL VARCHAR(80);
   DECLARE v_TermsID_O NATIONAL VARCHAR(80);
   DECLARE v_TermsID_N NATIONAL VARCHAR(80);
   DECLARE v_PaymentMethodID_O NATIONAL VARCHAR(80);
   DECLARE v_PaymentMethodID_N NATIONAL VARCHAR(80);
   DECLARE v_CurrencyID_O NATIONAL VARCHAR(80);
   DECLARE v_CurrencyID_N NATIONAL VARCHAR(80);
   DECLARE v_CurrencyExchangeRate_O NATIONAL VARCHAR(80);
   DECLARE v_CurrencyExchangeRate_N NATIONAL VARCHAR(80);
   DECLARE v_Subtotal_O NATIONAL VARCHAR(80);
   DECLARE v_Subtotal_N NATIONAL VARCHAR(80);
   DECLARE v_DiscountPers_O NATIONAL VARCHAR(80);
   DECLARE v_DiscountPers_N NATIONAL VARCHAR(80);
   DECLARE v_DiscountAmount_O NATIONAL VARCHAR(80);
   DECLARE v_DiscountAmount_N NATIONAL VARCHAR(80);
   DECLARE v_TaxPercent_O NATIONAL VARCHAR(80);
   DECLARE v_TaxPercent_N NATIONAL VARCHAR(80);
   DECLARE v_TaxAmount_O NATIONAL VARCHAR(80);
   DECLARE v_TaxAmount_N NATIONAL VARCHAR(80);
   DECLARE v_TaxableSubTotal_O NATIONAL VARCHAR(80);
   DECLARE v_TaxableSubTotal_N NATIONAL VARCHAR(80);
   DECLARE v_Freight_O NATIONAL VARCHAR(80);
   DECLARE v_Freight_N NATIONAL VARCHAR(80);
   DECLARE v_TaxFreight_O NATIONAL VARCHAR(80);
   DECLARE v_TaxFreight_N NATIONAL VARCHAR(80);
   DECLARE v_Handling_O NATIONAL VARCHAR(80);
   DECLARE v_Handling_N NATIONAL VARCHAR(80);
   DECLARE v_Advertising_O NATIONAL VARCHAR(80);
   DECLARE v_Advertising_N NATIONAL VARCHAR(80);
   DECLARE v_Total_O NATIONAL VARCHAR(80);
   DECLARE v_Total_N NATIONAL VARCHAR(80);
   DECLARE v_AmountPaid_O NATIONAL VARCHAR(80);
   DECLARE v_AmountPaid_N NATIONAL VARCHAR(80);
   DECLARE v_BalanceDue_O NATIONAL VARCHAR(80);
   DECLARE v_BalanceDue_N NATIONAL VARCHAR(80);
   DECLARE v_UndistributedAmount_O NATIONAL VARCHAR(80);
   DECLARE v_UndistributedAmount_N NATIONAL VARCHAR(80);
   DECLARE v_Commission_O NATIONAL VARCHAR(80);
   DECLARE v_Commission_N NATIONAL VARCHAR(80);
   DECLARE v_CommissionableSales_O NATIONAL VARCHAR(80);
   DECLARE v_CommissionableSales_N NATIONAL VARCHAR(80);
   DECLARE v_ComissionalbleCost_O NATIONAL VARCHAR(80);
   DECLARE v_ComissionalbleCost_N NATIONAL VARCHAR(80);
   DECLARE v_GLSalesAccount_O NATIONAL VARCHAR(80);
   DECLARE v_GLSalesAccount_N NATIONAL VARCHAR(80);
   DECLARE v_CheckNumber_O NATIONAL VARCHAR(80);
   DECLARE v_CheckNumber_N NATIONAL VARCHAR(80);
   DECLARE v_CheckDate_O NATIONAL VARCHAR(80);
   DECLARE v_CheckDate_N NATIONAL VARCHAR(80);
   DECLARE v_CreditCardTypeID_O NATIONAL VARCHAR(80);
   DECLARE v_CreditCardTypeID_N NATIONAL VARCHAR(80);
   DECLARE v_CreditCardName_O NATIONAL VARCHAR(80);
   DECLARE v_CreditCardName_N NATIONAL VARCHAR(80);
   DECLARE v_CreditCardNumber_O NATIONAL VARCHAR(80);
   DECLARE v_CreditCardNumber_N NATIONAL VARCHAR(80);
   DECLARE v_CreditCardExpDate_O NATIONAL VARCHAR(80);
   DECLARE v_CreditCardExpDate_N NATIONAL VARCHAR(80);
   DECLARE v_CreditCardCSVNumber_O NATIONAL VARCHAR(80);
   DECLARE v_CreditCardCSVNumber_N NATIONAL VARCHAR(80);
   DECLARE v_CreditCardBillToZip_O NATIONAL VARCHAR(80);
   DECLARE v_CreditCardBillToZip_N NATIONAL VARCHAR(80);
   DECLARE v_CreditCardValidationCode_O NATIONAL VARCHAR(80);
   DECLARE v_CreditCardValidationCode_N NATIONAL VARCHAR(80);
   DECLARE v_CreditCardApprovalNumber_O NATIONAL VARCHAR(80);
   DECLARE v_CreditCardApprovalNumber_N NATIONAL VARCHAR(80);
   DECLARE v_Picked_O NATIONAL VARCHAR(80);
   DECLARE v_Picked_N NATIONAL VARCHAR(80);
   DECLARE v_PickedDate_O NATIONAL VARCHAR(80);
   DECLARE v_PickedDate_N NATIONAL VARCHAR(80);
   DECLARE v_Billed_O NATIONAL VARCHAR(80);
   DECLARE v_Billed_N NATIONAL VARCHAR(80);
   DECLARE v_BilledDate_O NATIONAL VARCHAR(80);
   DECLARE v_BilledDate_N NATIONAL VARCHAR(80);
   DECLARE v_Printed_O NATIONAL VARCHAR(80);
   DECLARE v_Printed_N NATIONAL VARCHAR(80);
   DECLARE v_PrintedDate_O NATIONAL VARCHAR(80);
   DECLARE v_PrintedDate_N NATIONAL VARCHAR(80);
   DECLARE v_Shipped_O NATIONAL VARCHAR(80);
   DECLARE v_Shipped_N NATIONAL VARCHAR(80);
   DECLARE v_ShipDate_O NATIONAL VARCHAR(80);
   DECLARE v_ShipDate_N NATIONAL VARCHAR(80);
   DECLARE v_TrackingNumber_O NATIONAL VARCHAR(80);
   DECLARE v_TrackingNumber_N NATIONAL VARCHAR(80);
   DECLARE v_Backordered_O NATIONAL VARCHAR(80);
   DECLARE v_Backordered_N NATIONAL VARCHAR(80);
   DECLARE v_Posted_O NATIONAL VARCHAR(80);
   DECLARE v_Posted_N NATIONAL VARCHAR(80);
   DECLARE v_PostedDate_O NATIONAL VARCHAR(80);
   DECLARE v_PostedDate_N NATIONAL VARCHAR(80);
   DECLARE v_HeaderMemo1_O NATIONAL VARCHAR(80);
   DECLARE v_HeaderMemo1_N NATIONAL VARCHAR(80);
   DECLARE v_HeaderMemo2_O NATIONAL VARCHAR(80);
   DECLARE v_HeaderMemo2_N NATIONAL VARCHAR(80);
   DECLARE v_HeaderMemo3_O NATIONAL VARCHAR(80);
   DECLARE v_HeaderMemo3_N NATIONAL VARCHAR(80);
   DECLARE v_HeaderMemo4_O NATIONAL VARCHAR(80);
   DECLARE v_HeaderMemo4_N NATIONAL VARCHAR(80);
   DECLARE v_HeaderMemo5_O NATIONAL VARCHAR(80);
   DECLARE v_HeaderMemo5_N NATIONAL VARCHAR(80);
   DECLARE v_HeaderMemo6_O NATIONAL VARCHAR(80);
   DECLARE v_HeaderMemo6_N NATIONAL VARCHAR(80);
   DECLARE v_HeaderMemo7_O NATIONAL VARCHAR(80);
   DECLARE v_HeaderMemo7_N NATIONAL VARCHAR(80);
   DECLARE v_HeaderMemo8_O NATIONAL VARCHAR(80);
   DECLARE v_HeaderMemo8_N NATIONAL VARCHAR(80);
   DECLARE v_HeaderMemo9_O NATIONAL VARCHAR(80);
   DECLARE v_HeaderMemo9_N NATIONAL VARCHAR(80);
   DECLARE v_AllowanceDiscountPerc_O NATIONAL VARCHAR(80);
   DECLARE v_AllowanceDiscountPerc_N NATIONAL VARCHAR(80);
 

-- updating records cursor declaration
   DECLARE cUpdate CURSOR
   FOR SELECT
   d.InvoiceNumber
		,i.InvoiceNumber
		,''

		,i.CompanyID
		,i.DivisionID
		,i.DepartmentID
		,i.InvoiceNumber

,CAST(d.OrderNumber AS CHAR(80))
,CAST(i.OrderNumber AS CHAR(80))
,CAST(d.TransactionTypeID AS CHAR(80))
,CAST(i.TransactionTypeID AS CHAR(80))
,CAST(d.EDIDirectionTypeID AS CHAR(80))
,CAST(i.EDIDirectionTypeID AS CHAR(80))
,CAST(d.EDIDocumentTypeID AS CHAR(80))
,CAST(i.EDIDocumentTypeID AS CHAR(80))
,CAST(d.EDIOpen AS CHAR(80))
,CAST(i.EDIOpen AS CHAR(80))
,CAST(d.TransOpen AS CHAR(80))
,CAST(i.TransOpen AS CHAR(80))
,CAST(d.InvoiceTypeID AS CHAR(80))
,CAST(i.InvoiceTypeID AS CHAR(80))
,CAST(d.InvoiceDate AS CHAR(80))
,CAST(i.InvoiceDate AS CHAR(80))
,CAST(d.InvoiceDueDate AS CHAR(80))
,CAST(i.InvoiceDueDate AS CHAR(80))
,CAST(d.InvoiceShipDate AS CHAR(80))
,CAST(i.InvoiceShipDate AS CHAR(80))
,CAST(d.InvoiceCancelDate AS CHAR(80))
,CAST(i.InvoiceCancelDate AS CHAR(80))
,CAST(d.PurchaseOrderNumber AS CHAR(80))
,CAST(i.PurchaseOrderNumber AS CHAR(80))
,CAST(d.TaxExemptID AS CHAR(80))
,CAST(i.TaxExemptID AS CHAR(80))
,CAST(d.TaxGroupID AS CHAR(80))
,CAST(i.TaxGroupID AS CHAR(80))
,CAST(d.CustomerID AS CHAR(80))
,CAST(i.CustomerID AS CHAR(80))
,CAST(d.CustomerShipToID AS CHAR(80))
,CAST(i.CustomerShipToID AS CHAR(80))
,CAST(d.CustomerShipForID AS CHAR(80))
,CAST(i.CustomerShipForID AS CHAR(80))
,CAST(d.WarehouseID AS CHAR(80))
,CAST(i.WarehouseID AS CHAR(80))
,CAST(d.CustomerDropShipment AS CHAR(80))
,CAST(i.CustomerDropShipment AS CHAR(80))
,CAST(d.ShippingName AS CHAR(80))
,CAST(i.ShippingName AS CHAR(80))
,CAST(d.ShippingAddress1 AS CHAR(80))
,CAST(i.ShippingAddress1 AS CHAR(80))
,CAST(d.ShippingAddress2 AS CHAR(80))
,CAST(i.ShippingAddress2 AS CHAR(80))
,CAST(d.ShippingCity AS CHAR(80))
,CAST(i.ShippingCity AS CHAR(80))
,CAST(d.ShippingState AS CHAR(80))
,CAST(i.ShippingState AS CHAR(80))
,CAST(d.ShippingZip AS CHAR(80))
,CAST(i.ShippingZip AS CHAR(80))
,CAST(d.ShippingCountry AS CHAR(80))
,CAST(i.ShippingCountry AS CHAR(80))
,CAST(d.ShipMethodID AS CHAR(80))
,CAST(i.ShipMethodID AS CHAR(80))
,CAST(d.EmployeeID AS CHAR(80))
,CAST(i.EmployeeID AS CHAR(80))
,CAST(d.TermsID AS CHAR(80))
,CAST(i.TermsID AS CHAR(80))
,CAST(d.PaymentMethodID AS CHAR(80))
,CAST(i.PaymentMethodID AS CHAR(80))
,CAST(d.CurrencyID AS CHAR(80))
,CAST(i.CurrencyID AS CHAR(80))
,CAST(d.CurrencyExchangeRate AS CHAR(80))
,CAST(i.CurrencyExchangeRate AS CHAR(80))
,CAST(d.Subtotal AS CHAR(80))
,CAST(i.Subtotal AS CHAR(80))
,CAST(d.DiscountPers AS CHAR(80))
,CAST(i.DiscountPers AS CHAR(80))
,CAST(d.DiscountAmount AS CHAR(80))
,CAST(i.DiscountAmount AS CHAR(80))
,CAST(d.TaxPercent AS CHAR(80))
,CAST(i.TaxPercent AS CHAR(80))
,CAST(d.TaxAmount AS CHAR(80))
,CAST(i.TaxAmount AS CHAR(80))
,CAST(d.TaxableSubTotal AS CHAR(80))
,CAST(i.TaxableSubTotal AS CHAR(80))
,CAST(d.Freight AS CHAR(80))
,CAST(i.Freight AS CHAR(80))
,CAST(d.TaxFreight AS CHAR(80))
,CAST(i.TaxFreight AS CHAR(80))
,CAST(d.Handling AS CHAR(80))
,CAST(i.Handling AS CHAR(80))
,CAST(d.Advertising AS CHAR(80))
,CAST(i.Advertising AS CHAR(80))
,CAST(d.Total AS CHAR(80))
,CAST(i.Total AS CHAR(80))
,CAST(d.AmountPaid AS CHAR(80))
,CAST(i.AmountPaid AS CHAR(80))
,CAST(d.BalanceDue AS CHAR(80))
,CAST(i.BalanceDue AS CHAR(80))
,CAST(d.UndistributedAmount AS CHAR(80))
,CAST(i.UndistributedAmount AS CHAR(80))
,CAST(d.Commission AS CHAR(80))
,CAST(i.Commission AS CHAR(80))
,CAST(d.CommissionableSales AS CHAR(80))
,CAST(i.CommissionableSales AS CHAR(80))
,CAST(d.ComissionalbleCost AS CHAR(80))
,CAST(i.ComissionalbleCost AS CHAR(80))
,CAST(d.GLSalesAccount AS CHAR(80))
,CAST(i.GLSalesAccount AS CHAR(80))
,CAST(d.CheckNumber AS CHAR(80))
,CAST(i.CheckNumber AS CHAR(80))
,CAST(d.CheckDate AS CHAR(80))
,CAST(i.CheckDate AS CHAR(80))
,CAST(d.CreditCardTypeID AS CHAR(80))
,CAST(i.CreditCardTypeID AS CHAR(80))
,CAST(d.CreditCardName AS CHAR(80))
,CAST(i.CreditCardName AS CHAR(80))
,CAST(d.CreditCardNumber AS CHAR(80))
,CAST(i.CreditCardNumber AS CHAR(80))
,CAST(d.CreditCardExpDate AS CHAR(80))
,CAST(i.CreditCardExpDate AS CHAR(80))
,CAST(d.CreditCardCSVNumber AS CHAR(80))
,CAST(i.CreditCardCSVNumber AS CHAR(80))
,CAST(d.CreditCardBillToZip AS CHAR(80))
,CAST(i.CreditCardBillToZip AS CHAR(80))
,CAST(d.CreditCardValidationCode AS CHAR(80))
,CAST(i.CreditCardValidationCode AS CHAR(80))
,CAST(d.CreditCardApprovalNumber AS CHAR(80))
,CAST(i.CreditCardApprovalNumber AS CHAR(80))
,CAST(d.Picked AS CHAR(80))
,CAST(i.Picked AS CHAR(80))
,CAST(d.PickedDate AS CHAR(80))
,CAST(i.PickedDate AS CHAR(80))
,CAST(d.Billed AS CHAR(80))
,CAST(i.Billed AS CHAR(80))
,CAST(d.BilledDate AS CHAR(80))
,CAST(i.BilledDate AS CHAR(80))
,CAST(d.Printed AS CHAR(80))
,CAST(i.Printed AS CHAR(80))
,CAST(d.PrintedDate AS CHAR(80))
,CAST(i.PrintedDate AS CHAR(80))
,CAST(d.Shipped AS CHAR(80))
,CAST(i.Shipped AS CHAR(80))
,CAST(d.ShipDate AS CHAR(80))
,CAST(i.ShipDate AS CHAR(80))
,CAST(d.TrackingNumber AS CHAR(80))
,CAST(i.TrackingNumber AS CHAR(80))
,CAST(d.Backordered AS CHAR(80))
,CAST(i.Backordered AS CHAR(80))
,CAST(d.Posted AS CHAR(80))
,CAST(i.Posted AS CHAR(80))
,CAST(d.PostedDate AS CHAR(80))
,CAST(i.PostedDate AS CHAR(80))
,CAST(d.HeaderMemo1 AS CHAR(80))
,CAST(i.HeaderMemo1 AS CHAR(80))
,CAST(d.HeaderMemo2 AS CHAR(80))
,CAST(i.HeaderMemo2 AS CHAR(80))
,CAST(d.HeaderMemo3 AS CHAR(80))
,CAST(i.HeaderMemo3 AS CHAR(80))
,CAST(d.HeaderMemo4 AS CHAR(80))
,CAST(i.HeaderMemo4 AS CHAR(80))
,CAST(d.HeaderMemo5 AS CHAR(80))
,CAST(i.HeaderMemo5 AS CHAR(80))
,CAST(d.HeaderMemo6 AS CHAR(80))
,CAST(i.HeaderMemo6 AS CHAR(80))
,CAST(d.HeaderMemo7 AS CHAR(80))
,CAST(i.HeaderMemo7 AS CHAR(80))
,CAST(d.HeaderMemo8 AS CHAR(80))
,CAST(i.HeaderMemo8 AS CHAR(80))
,CAST(d.HeaderMemo9 AS CHAR(80))
,CAST(i.HeaderMemo9 AS CHAR(80))
,CAST(d.AllowanceDiscountPerc AS CHAR(80))
,CAST(i.AllowanceDiscountPerc AS CHAR(80))
 

   FROM
   InsEDIInvoiceHeader i
   LEFT OUTER JOIN DelEDIInvoiceHeader d ON
   d.CompanyID = i.CompanyID
   AND d.DivisionID = i.DivisionID
   AND d.DepartmentID = i.DepartmentID
   AND d.InvoiceNumber = i.InvoiceNumber;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET NO_DATA = -2;
   END;
   DECLARE CONTINUE HANDLER FOR NOT FOUND SET NO_DATA = -1;
   CREATE  TEMPORARY TABLE IF NOT EXISTS InsEDIInvoiceHeader
   (
      CompanyID NATIONAL VARCHAR(36),
      DivisionID NATIONAL VARCHAR(36),
      DepartmentID NATIONAL VARCHAR(36),
      InvoiceNumber NATIONAL VARCHAR(36),
      OrderNumber NATIONAL VARCHAR(36),
      TransactionTypeID NATIONAL VARCHAR(36),
      EDIDirectionTypeID NATIONAL VARCHAR(1),
      EDIDocumentTypeID NATIONAL VARCHAR(3),
      EDIOpen BOOLEAN,
      TransOpen BOOLEAN,
      InvoiceTypeID NATIONAL VARCHAR(36),
      InvoiceDate DATETIME,
      InvoiceDueDate DATETIME,
      InvoiceShipDate DATETIME,
      InvoiceCancelDate DATETIME,
      PurchaseOrderNumber NATIONAL VARCHAR(36),
      TaxExemptID NATIONAL VARCHAR(36),
      TaxGroupID NATIONAL VARCHAR(36),
      CustomerID NATIONAL VARCHAR(50),
      CustomerShipToID NATIONAL VARCHAR(36),
      CustomerShipForID NATIONAL VARCHAR(36),
      WarehouseID NATIONAL VARCHAR(36),
      CustomerDropShipment BOOLEAN,
      ShippingName NATIONAL VARCHAR(50),
      ShippingAddress1 NATIONAL VARCHAR(50),
      ShippingAddress2 NATIONAL VARCHAR(50),
      ShippingCity NATIONAL VARCHAR(50),
      ShippingState NATIONAL VARCHAR(50),
      ShippingZip NATIONAL VARCHAR(10),
      ShippingCountry NATIONAL VARCHAR(50),
      ShipMethodID NATIONAL VARCHAR(15),
      EmployeeID NATIONAL VARCHAR(15),
      TermsID NATIONAL VARCHAR(36),
      PaymentMethodID NATIONAL VARCHAR(36),
      CurrencyID NATIONAL VARCHAR(3),
      CurrencyExchangeRate FLOAT,
      Subtotal DECIMAL(19,4),
      DiscountPers FLOAT,
      DiscountAmount DECIMAL(19,4),
      TaxPercent FLOAT,
      TaxAmount DECIMAL(19,4),
      TaxableSubTotal DECIMAL(19,4),
      Freight DECIMAL(19,4),
      TaxFreight BOOLEAN,
      Handling DECIMAL(19,4),
      Advertising DECIMAL(19,4),
      Total DECIMAL(19,4),
      AmountPaid DECIMAL(19,4),
      BalanceDue DECIMAL(19,4),
      UndistributedAmount DECIMAL(19,4),
      Commission DECIMAL(19,4),
      CommissionableSales DECIMAL(19,4),
      ComissionalbleCost DECIMAL(19,4),
      GLSalesAccount NATIONAL VARCHAR(36),
      CheckNumber NATIONAL VARCHAR(20),
      CheckDate DATETIME,
      CreditCardTypeID NATIONAL VARCHAR(15),
      CreditCardName NATIONAL VARCHAR(50),
      CreditCardNumber NATIONAL VARCHAR(50),
      CreditCardExpDate DATETIME,
      CreditCardCSVNumber NATIONAL VARCHAR(5),
      CreditCardBillToZip NATIONAL VARCHAR(10),
      CreditCardValidationCode NATIONAL VARCHAR(20),
      CreditCardApprovalNumber NATIONAL VARCHAR(20),
      Picked BOOLEAN,
      PickedDate DATETIME,
      Billed BOOLEAN,
      BilledDate DATETIME,
      Printed BOOLEAN,
      PrintedDate DATETIME,
      Shipped BOOLEAN,
      ShipDate DATETIME,
      TrackingNumber NATIONAL VARCHAR(50),
      Backordered BOOLEAN,
      Posted BOOLEAN,
      PostedDate DATETIME,
      HeaderMemo1 NATIONAL VARCHAR(50),
      HeaderMemo2 NATIONAL VARCHAR(50),
      HeaderMemo3 NATIONAL VARCHAR(50),
      HeaderMemo4 NATIONAL VARCHAR(50),
      HeaderMemo5 NATIONAL VARCHAR(50),
      HeaderMemo6 NATIONAL VARCHAR(50),
      HeaderMemo7 NATIONAL VARCHAR(50),
      HeaderMemo8 NATIONAL VARCHAR(50),
      HeaderMemo9 NATIONAL VARCHAR(50),
      LockedBy NATIONAL VARCHAR(36),
      LockTS DATETIME,
      AllowanceDiscountPerc FLOAT
   );
   DELETE FROM InsEDIInvoiceHeader;
   INSERT INTO InsEDIInvoiceHeader VALUES(NEW.CompanyID, NEW.DivisionID, NEW.DepartmentID, NEW.InvoiceNumber, NEW.OrderNumber, NEW.TransactionTypeID, NEW.EDIDirectionTypeID, NEW.EDIDocumentTypeID, NEW.EDIOpen, NEW.TransOpen, NEW.InvoiceTypeID, NEW.InvoiceDate, NEW.InvoiceDueDate, NEW.InvoiceShipDate, NEW.InvoiceCancelDate, NEW.PurchaseOrderNumber, NEW.TaxExemptID, NEW.TaxGroupID, NEW.CustomerID, NEW.CustomerShipToID, NEW.CustomerShipForID, NEW.WarehouseID, NEW.CustomerDropShipment, NEW.ShippingName, NEW.ShippingAddress1, NEW.ShippingAddress2, NEW.ShippingCity, NEW.ShippingState, NEW.ShippingZip, NEW.ShippingCountry, NEW.ShipMethodID, NEW.EmployeeID, NEW.TermsID, NEW.PaymentMethodID, NEW.CurrencyID, NEW.CurrencyExchangeRate, NEW.Subtotal, NEW.DiscountPers, NEW.DiscountAmount, NEW.TaxPercent, NEW.TaxAmount, NEW.TaxableSubTotal, NEW.Freight, NEW.TaxFreight, NEW.Handling, NEW.Advertising, NEW.Total, NEW.AmountPaid, NEW.BalanceDue, NEW.UndistributedAmount, NEW.Commission, NEW.CommissionableSales, NEW.ComissionalbleCost, NEW.GLSalesAccount, NEW.CheckNumber, NEW.CheckDate, NEW.CreditCardTypeID, NEW.CreditCardName, NEW.CreditCardNumber, NEW.CreditCardExpDate, NEW.CreditCardCSVNumber, NEW.CreditCardBillToZip, NEW.CreditCardValidationCode, NEW.CreditCardApprovalNumber, NEW.Picked, NEW.PickedDate, NEW.Billed, NEW.BilledDate, NEW.Printed, NEW.PrintedDate, NEW.Shipped, NEW.ShipDate, NEW.TrackingNumber, NEW.Backordered, NEW.Posted, NEW.PostedDate, NEW.HeaderMemo1, NEW.HeaderMemo2, NEW.HeaderMemo3, NEW.HeaderMemo4, NEW.HeaderMemo5, NEW.HeaderMemo6, NEW.HeaderMemo7, NEW.HeaderMemo8, NEW.HeaderMemo9, NEW.LockedBy, NEW.LockTS, NEW.AllowanceDiscountPerc);

   CREATE  TEMPORARY TABLE IF NOT EXISTS DelEDIInvoiceHeader
   (
      CompanyID NATIONAL VARCHAR(36),
      DivisionID NATIONAL VARCHAR(36),
      DepartmentID NATIONAL VARCHAR(36),
      InvoiceNumber NATIONAL VARCHAR(36),
      OrderNumber NATIONAL VARCHAR(36),
      TransactionTypeID NATIONAL VARCHAR(36),
      EDIDirectionTypeID NATIONAL VARCHAR(1),
      EDIDocumentTypeID NATIONAL VARCHAR(3),
      EDIOpen BOOLEAN,
      TransOpen BOOLEAN,
      InvoiceTypeID NATIONAL VARCHAR(36),
      InvoiceDate DATETIME,
      InvoiceDueDate DATETIME,
      InvoiceShipDate DATETIME,
      InvoiceCancelDate DATETIME,
      PurchaseOrderNumber NATIONAL VARCHAR(36),
      TaxExemptID NATIONAL VARCHAR(36),
      TaxGroupID NATIONAL VARCHAR(36),
      CustomerID NATIONAL VARCHAR(50),
      CustomerShipToID NATIONAL VARCHAR(36),
      CustomerShipForID NATIONAL VARCHAR(36),
      WarehouseID NATIONAL VARCHAR(36),
      CustomerDropShipment BOOLEAN,
      ShippingName NATIONAL VARCHAR(50),
      ShippingAddress1 NATIONAL VARCHAR(50),
      ShippingAddress2 NATIONAL VARCHAR(50),
      ShippingCity NATIONAL VARCHAR(50),
      ShippingState NATIONAL VARCHAR(50),
      ShippingZip NATIONAL VARCHAR(10),
      ShippingCountry NATIONAL VARCHAR(50),
      ShipMethodID NATIONAL VARCHAR(15),
      EmployeeID NATIONAL VARCHAR(15),
      TermsID NATIONAL VARCHAR(36),
      PaymentMethodID NATIONAL VARCHAR(36),
      CurrencyID NATIONAL VARCHAR(3),
      CurrencyExchangeRate FLOAT,
      Subtotal DECIMAL(19,4),
      DiscountPers FLOAT,
      DiscountAmount DECIMAL(19,4),
      TaxPercent FLOAT,
      TaxAmount DECIMAL(19,4),
      TaxableSubTotal DECIMAL(19,4),
      Freight DECIMAL(19,4),
      TaxFreight BOOLEAN,
      Handling DECIMAL(19,4),
      Advertising DECIMAL(19,4),
      Total DECIMAL(19,4),
      AmountPaid DECIMAL(19,4),
      BalanceDue DECIMAL(19,4),
      UndistributedAmount DECIMAL(19,4),
      Commission DECIMAL(19,4),
      CommissionableSales DECIMAL(19,4),
      ComissionalbleCost DECIMAL(19,4),
      GLSalesAccount NATIONAL VARCHAR(36),
      CheckNumber NATIONAL VARCHAR(20),
      CheckDate DATETIME,
      CreditCardTypeID NATIONAL VARCHAR(15),
      CreditCardName NATIONAL VARCHAR(50),
      CreditCardNumber NATIONAL VARCHAR(50),
      CreditCardExpDate DATETIME,
      CreditCardCSVNumber NATIONAL VARCHAR(5),
      CreditCardBillToZip NATIONAL VARCHAR(10),
      CreditCardValidationCode NATIONAL VARCHAR(20),
      CreditCardApprovalNumber NATIONAL VARCHAR(20),
      Picked BOOLEAN,
      PickedDate DATETIME,
      Billed BOOLEAN,
      BilledDate DATETIME,
      Printed BOOLEAN,
      PrintedDate DATETIME,
      Shipped BOOLEAN,
      ShipDate DATETIME,
      TrackingNumber NATIONAL VARCHAR(50),
      Backordered BOOLEAN,
      Posted BOOLEAN,
      PostedDate DATETIME,
      HeaderMemo1 NATIONAL VARCHAR(50),
      HeaderMemo2 NATIONAL VARCHAR(50),
      HeaderMemo3 NATIONAL VARCHAR(50),
      HeaderMemo4 NATIONAL VARCHAR(50),
      HeaderMemo5 NATIONAL VARCHAR(50),
      HeaderMemo6 NATIONAL VARCHAR(50),
      HeaderMemo7 NATIONAL VARCHAR(50),
      HeaderMemo8 NATIONAL VARCHAR(50),
      HeaderMemo9 NATIONAL VARCHAR(50),
      LockedBy NATIONAL VARCHAR(36),
      LockTS DATETIME,
      AllowanceDiscountPerc FLOAT
   );
   DELETE FROM DelEDIInvoiceHeader;
   INSERT INTO DelEDIInvoiceHeader VALUES(OLD.CompanyID, OLD.DivisionID, OLD.DepartmentID, OLD.InvoiceNumber, OLD.OrderNumber, OLD.TransactionTypeID, OLD.EDIDirectionTypeID, OLD.EDIDocumentTypeID, OLD.EDIOpen, OLD.TransOpen, OLD.InvoiceTypeID, OLD.InvoiceDate, OLD.InvoiceDueDate, OLD.InvoiceShipDate, OLD.InvoiceCancelDate, OLD.PurchaseOrderNumber, OLD.TaxExemptID, OLD.TaxGroupID, OLD.CustomerID, OLD.CustomerShipToID, OLD.CustomerShipForID, OLD.WarehouseID, OLD.CustomerDropShipment, OLD.ShippingName, OLD.ShippingAddress1, OLD.ShippingAddress2, OLD.ShippingCity, OLD.ShippingState, OLD.ShippingZip, OLD.ShippingCountry, OLD.ShipMethodID, OLD.EmployeeID, OLD.TermsID, OLD.PaymentMethodID, OLD.CurrencyID, OLD.CurrencyExchangeRate, OLD.Subtotal, OLD.DiscountPers, OLD.DiscountAmount, OLD.TaxPercent, OLD.TaxAmount, OLD.TaxableSubTotal, OLD.Freight, OLD.TaxFreight, OLD.Handling, OLD.Advertising, OLD.Total, OLD.AmountPaid, OLD.BalanceDue, OLD.UndistributedAmount, OLD.Commission, OLD.CommissionableSales, OLD.ComissionalbleCost, OLD.GLSalesAccount, OLD.CheckNumber, OLD.CheckDate, OLD.CreditCardTypeID, OLD.CreditCardName, OLD.CreditCardNumber, OLD.CreditCardExpDate, OLD.CreditCardCSVNumber, OLD.CreditCardBillToZip, OLD.CreditCardValidationCode, OLD.CreditCardApprovalNumber, OLD.Picked, OLD.PickedDate, OLD.Billed, OLD.BilledDate, OLD.Printed, OLD.PrintedDate, OLD.Shipped, OLD.ShipDate, OLD.TrackingNumber, OLD.Backordered, OLD.Posted, OLD.PostedDate, OLD.HeaderMemo1, OLD.HeaderMemo2, OLD.HeaderMemo3, OLD.HeaderMemo4, OLD.HeaderMemo5, OLD.HeaderMemo6, OLD.HeaderMemo7, OLD.HeaderMemo8, OLD.HeaderMemo9, OLD.LockedBy, OLD.LockTS, OLD.AllowanceDiscountPerc);

   BEGIN
-- check for audit triggers switch off

      select   context_info INTO v_Context FROM sysprocesses WHERE spid = CONNECTION_ID();
      IF CAST(v_Context AS CHAR(36)) = N'$$AuditSwitchOff$$' then 
         LEAVE SWL_return;
      end if;

-- declarations
      OPEN cUpdate;
-- fetch from each updating record
      SET NO_DATA = 0;
      FETCH cUpdate INTO
      v_TransactionNumber_O,v_TransactionNumber_N,v_TransactionLineNumber,v_CompanyID,
      v_DivisionID,v_DepartmentID,v_InvoiceNumber,v_OrderNumber_O,
      v_OrderNumber_N,v_TransactionTypeID_O,v_TransactionTypeID_N,v_EDIDirectionTypeID_O,
      v_EDIDirectionTypeID_N,v_EDIDocumentTypeID_O,v_EDIDocumentTypeID_N,
      v_EDIOpen_O,v_EDIOpen_N,v_TransOpen_O,v_TransOpen_N,v_InvoiceTypeID_O,
      v_InvoiceTypeID_N,v_InvoiceDate_O,v_InvoiceDate_N,v_InvoiceDueDate_O,
      v_InvoiceDueDate_N,v_InvoiceShipDate_O,v_InvoiceShipDate_N,v_InvoiceCancelDate_O,
      v_InvoiceCancelDate_N,v_PurchaseOrderNumber_O,v_PurchaseOrderNumber_N,
      v_TaxExemptID_O,v_TaxExemptID_N,v_TaxGroupID_O,v_TaxGroupID_N,
      v_CustomerID_O,v_CustomerID_N,v_CustomerShipToID_O,v_CustomerShipToID_N,
      v_CustomerShipForID_O,v_CustomerShipForID_N,v_WarehouseID_O,
      v_WarehouseID_N,v_CustomerDropShipment_O,v_CustomerDropShipment_N,
      v_ShippingName_O,v_ShippingName_N,v_ShippingAddress1_O,v_ShippingAddress1_N,
      v_ShippingAddress2_O,v_ShippingAddress2_N,v_ShippingCity_O,v_ShippingCity_N,
      v_ShippingState_O,v_ShippingState_N,v_ShippingZip_O,v_ShippingZip_N,
      v_ShippingCountry_O,v_ShippingCountry_N,v_ShipMethodID_O,v_ShipMethodID_N,
      v_EmployeeID_O,v_EmployeeID_N,v_TermsID_O,v_TermsID_N,v_PaymentMethodID_O,
      v_PaymentMethodID_N,v_CurrencyID_O,v_CurrencyID_N,v_CurrencyExchangeRate_O,
      v_CurrencyExchangeRate_N,v_Subtotal_O,v_Subtotal_N,
      v_DiscountPers_O,v_DiscountPers_N,v_DiscountAmount_O,v_DiscountAmount_N,
      v_TaxPercent_O,v_TaxPercent_N,v_TaxAmount_O,v_TaxAmount_N,v_TaxableSubTotal_O,
      v_TaxableSubTotal_N,v_Freight_O,v_Freight_N,v_TaxFreight_O,
      v_TaxFreight_N,v_Handling_O,v_Handling_N,v_Advertising_O,v_Advertising_N,
      v_Total_O,v_Total_N,v_AmountPaid_O,v_AmountPaid_N,v_BalanceDue_O,
      v_BalanceDue_N,v_UndistributedAmount_O,v_UndistributedAmount_N,v_Commission_O,
      v_Commission_N,v_CommissionableSales_O,v_CommissionableSales_N,
      v_ComissionalbleCost_O,v_ComissionalbleCost_N,v_GLSalesAccount_O,v_GLSalesAccount_N,
      v_CheckNumber_O,v_CheckNumber_N,v_CheckDate_O,v_CheckDate_N,
      v_CreditCardTypeID_O,v_CreditCardTypeID_N,v_CreditCardName_O,v_CreditCardName_N,
      v_CreditCardNumber_O,v_CreditCardNumber_N,v_CreditCardExpDate_O,
      v_CreditCardExpDate_N,v_CreditCardCSVNumber_O,v_CreditCardCSVNumber_N,
      v_CreditCardBillToZip_O,v_CreditCardBillToZip_N,v_CreditCardValidationCode_O,
      v_CreditCardValidationCode_N,v_CreditCardApprovalNumber_O,
      v_CreditCardApprovalNumber_N,v_Picked_O,v_Picked_N,v_PickedDate_O,
      v_PickedDate_N,v_Billed_O,v_Billed_N,v_BilledDate_O,v_BilledDate_N,v_Printed_O,
      v_Printed_N,v_PrintedDate_O,v_PrintedDate_N,v_Shipped_O,v_Shipped_N,
      v_ShipDate_O,v_ShipDate_N,v_TrackingNumber_O,v_TrackingNumber_N,
      v_Backordered_O,v_Backordered_N,v_Posted_O,v_Posted_N,v_PostedDate_O,
      v_PostedDate_N,v_HeaderMemo1_O,v_HeaderMemo1_N,v_HeaderMemo2_O,v_HeaderMemo2_N,
      v_HeaderMemo3_O,v_HeaderMemo3_N,v_HeaderMemo4_O,v_HeaderMemo4_N,
      v_HeaderMemo5_O,v_HeaderMemo5_N,v_HeaderMemo6_O,v_HeaderMemo6_N,v_HeaderMemo7_O,
      v_HeaderMemo7_N,v_HeaderMemo8_O,v_HeaderMemo8_N,v_HeaderMemo9_O,
      v_HeaderMemo9_N,v_AllowanceDiscountPerc_O,v_AllowanceDiscountPerc_N;
      WHILE NO_DATA = 0 DO
-- insert audit records for each changed field
         IF IsGuid(v_TransactionNumber_N) = 0 then
		
            IF v_TransactionNumber_O IS NULL then
				
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIInvoiceHeader','New Record','','New Record');
            ELSE
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIInvoiceHeader','OrderNumber',v_OrderNumber_O,
               v_OrderNumber_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIInvoiceHeader','TransactionTypeID',v_TransactionTypeID_O,
               v_TransactionTypeID_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIInvoiceHeader','EDIDirectionTypeID',v_EDIDirectionTypeID_O,
               v_EDIDirectionTypeID_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIInvoiceHeader','EDIDocumentTypeID',v_EDIDocumentTypeID_O,
               v_EDIDocumentTypeID_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIInvoiceHeader','EDIOpen',v_EDIOpen_O,v_EDIOpen_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIInvoiceHeader','TransOpen',v_TransOpen_O,v_TransOpen_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIInvoiceHeader','InvoiceTypeID',v_InvoiceTypeID_O,
               v_InvoiceTypeID_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIInvoiceHeader','InvoiceDate',v_InvoiceDate_O,
               v_InvoiceDate_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIInvoiceHeader','InvoiceDueDate',v_InvoiceDueDate_O,
               v_InvoiceDueDate_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIInvoiceHeader','InvoiceShipDate',v_InvoiceShipDate_O,
               v_InvoiceShipDate_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIInvoiceHeader','InvoiceCancelDate',v_InvoiceCancelDate_O,
               v_InvoiceCancelDate_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIInvoiceHeader','PurchaseOrderNumber',v_PurchaseOrderNumber_O,
               v_PurchaseOrderNumber_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIInvoiceHeader','TaxExemptID',v_TaxExemptID_O,
               v_TaxExemptID_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIInvoiceHeader','TaxGroupID',v_TaxGroupID_O,v_TaxGroupID_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIInvoiceHeader','CustomerID',v_CustomerID_O,v_CustomerID_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIInvoiceHeader','CustomerShipToID',v_CustomerShipToID_O,
               v_CustomerShipToID_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIInvoiceHeader','CustomerShipForID',v_CustomerShipForID_O,
               v_CustomerShipForID_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIInvoiceHeader','WarehouseID',v_WarehouseID_O,
               v_WarehouseID_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIInvoiceHeader','CustomerDropShipment',v_CustomerDropShipment_O,
               v_CustomerDropShipment_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIInvoiceHeader','ShippingName',v_ShippingName_O,
               v_ShippingName_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIInvoiceHeader','ShippingAddress1',v_ShippingAddress1_O,
               v_ShippingAddress1_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIInvoiceHeader','ShippingAddress2',v_ShippingAddress2_O,
               v_ShippingAddress2_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIInvoiceHeader','ShippingCity',v_ShippingCity_O,
               v_ShippingCity_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIInvoiceHeader','ShippingState',v_ShippingState_O,
               v_ShippingState_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIInvoiceHeader','ShippingZip',v_ShippingZip_O,
               v_ShippingZip_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIInvoiceHeader','ShippingCountry',v_ShippingCountry_O,
               v_ShippingCountry_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIInvoiceHeader','ShipMethodID',v_ShipMethodID_O,
               v_ShipMethodID_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIInvoiceHeader','EmployeeID',v_EmployeeID_O,v_EmployeeID_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIInvoiceHeader','TermsID',v_TermsID_O,v_TermsID_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIInvoiceHeader','PaymentMethodID',v_PaymentMethodID_O,
               v_PaymentMethodID_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIInvoiceHeader','CurrencyID',v_CurrencyID_O,v_CurrencyID_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIInvoiceHeader','CurrencyExchangeRate',v_CurrencyExchangeRate_O,
               v_CurrencyExchangeRate_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIInvoiceHeader','Subtotal',v_Subtotal_O,v_Subtotal_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIInvoiceHeader','DiscountPers',v_DiscountPers_O,
               v_DiscountPers_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIInvoiceHeader','DiscountAmount',v_DiscountAmount_O,
               v_DiscountAmount_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIInvoiceHeader','TaxPercent',v_TaxPercent_O,v_TaxPercent_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIInvoiceHeader','TaxAmount',v_TaxAmount_O,v_TaxAmount_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIInvoiceHeader','TaxableSubTotal',v_TaxableSubTotal_O,
               v_TaxableSubTotal_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIInvoiceHeader','Freight',v_Freight_O,v_Freight_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIInvoiceHeader','TaxFreight',v_TaxFreight_O,v_TaxFreight_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIInvoiceHeader','Handling',v_Handling_O,v_Handling_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIInvoiceHeader','Advertising',v_Advertising_O,
               v_Advertising_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIInvoiceHeader','Total',v_Total_O,v_Total_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIInvoiceHeader','AmountPaid',v_AmountPaid_O,v_AmountPaid_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIInvoiceHeader','BalanceDue',v_BalanceDue_O,v_BalanceDue_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIInvoiceHeader','UndistributedAmount',v_UndistributedAmount_O,
               v_UndistributedAmount_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIInvoiceHeader','Commission',v_Commission_O,v_Commission_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIInvoiceHeader','CommissionableSales',v_CommissionableSales_O,
               v_CommissionableSales_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIInvoiceHeader','ComissionalbleCost',v_ComissionalbleCost_O,
               v_ComissionalbleCost_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIInvoiceHeader','GLSalesAccount',v_GLSalesAccount_O,
               v_GLSalesAccount_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIInvoiceHeader','CheckNumber',v_CheckNumber_O,
               v_CheckNumber_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIInvoiceHeader','CheckDate',v_CheckDate_O,v_CheckDate_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIInvoiceHeader','CreditCardTypeID',v_CreditCardTypeID_O,
               v_CreditCardTypeID_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIInvoiceHeader','CreditCardName',v_CreditCardName_O,
               v_CreditCardName_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIInvoiceHeader','CreditCardNumber',v_CreditCardNumber_O,
               v_CreditCardNumber_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIInvoiceHeader','CreditCardExpDate',v_CreditCardExpDate_O,
               v_CreditCardExpDate_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIInvoiceHeader','CreditCardCSVNumber',v_CreditCardCSVNumber_O,
               v_CreditCardCSVNumber_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIInvoiceHeader','CreditCardBillToZip',v_CreditCardBillToZip_O,
               v_CreditCardBillToZip_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIInvoiceHeader','CreditCardValidationCode',v_CreditCardValidationCode_O,
               v_CreditCardValidationCode_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIInvoiceHeader','CreditCardApprovalNumber',v_CreditCardApprovalNumber_O,
               v_CreditCardApprovalNumber_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIInvoiceHeader','Picked',v_Picked_O,v_Picked_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIInvoiceHeader','PickedDate',v_PickedDate_O,v_PickedDate_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIInvoiceHeader','Billed',v_Billed_O,v_Billed_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIInvoiceHeader','BilledDate',v_BilledDate_O,v_BilledDate_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIInvoiceHeader','Printed',v_Printed_O,v_Printed_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIInvoiceHeader','PrintedDate',v_PrintedDate_O,
               v_PrintedDate_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIInvoiceHeader','Shipped',v_Shipped_O,v_Shipped_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIInvoiceHeader','ShipDate',v_ShipDate_O,v_ShipDate_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIInvoiceHeader','TrackingNumber',v_TrackingNumber_O,
               v_TrackingNumber_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIInvoiceHeader','Backordered',v_Backordered_O,
               v_Backordered_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIInvoiceHeader','Posted',v_Posted_O,v_Posted_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIInvoiceHeader','PostedDate',v_PostedDate_O,v_PostedDate_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIInvoiceHeader','HeaderMemo1',v_HeaderMemo1_O,
               v_HeaderMemo1_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIInvoiceHeader','HeaderMemo2',v_HeaderMemo2_O,
               v_HeaderMemo2_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIInvoiceHeader','HeaderMemo3',v_HeaderMemo3_O,
               v_HeaderMemo3_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIInvoiceHeader','HeaderMemo4',v_HeaderMemo4_O,
               v_HeaderMemo4_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIInvoiceHeader','HeaderMemo5',v_HeaderMemo5_O,
               v_HeaderMemo5_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIInvoiceHeader','HeaderMemo6',v_HeaderMemo6_O,
               v_HeaderMemo6_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIInvoiceHeader','HeaderMemo7',v_HeaderMemo7_O,
               v_HeaderMemo7_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIInvoiceHeader','HeaderMemo8',v_HeaderMemo8_O,
               v_HeaderMemo8_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIInvoiceHeader','HeaderMemo9',v_HeaderMemo9_O,
               v_HeaderMemo9_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIInvoiceHeader','AllowanceDiscountPerc',v_AllowanceDiscountPerc_O,
               v_AllowanceDiscountPerc_N);
            end if;
         end if;
         SET NO_DATA = 0;
         FETCH cUpdate INTO
         v_TransactionNumber_O,v_TransactionNumber_N,v_TransactionLineNumber,v_CompanyID,
         v_DivisionID,v_DepartmentID,v_InvoiceNumber,v_OrderNumber_O,
         v_OrderNumber_N,v_TransactionTypeID_O,v_TransactionTypeID_N,v_EDIDirectionTypeID_O,
         v_EDIDirectionTypeID_N,v_EDIDocumentTypeID_O,v_EDIDocumentTypeID_N,
         v_EDIOpen_O,v_EDIOpen_N,v_TransOpen_O,v_TransOpen_N,v_InvoiceTypeID_O,
         v_InvoiceTypeID_N,v_InvoiceDate_O,v_InvoiceDate_N,v_InvoiceDueDate_O,
         v_InvoiceDueDate_N,v_InvoiceShipDate_O,v_InvoiceShipDate_N,v_InvoiceCancelDate_O,
         v_InvoiceCancelDate_N,v_PurchaseOrderNumber_O,v_PurchaseOrderNumber_N,
         v_TaxExemptID_O,v_TaxExemptID_N,v_TaxGroupID_O,v_TaxGroupID_N,
         v_CustomerID_O,v_CustomerID_N,v_CustomerShipToID_O,v_CustomerShipToID_N,
         v_CustomerShipForID_O,v_CustomerShipForID_N,v_WarehouseID_O,
         v_WarehouseID_N,v_CustomerDropShipment_O,v_CustomerDropShipment_N,
         v_ShippingName_O,v_ShippingName_N,v_ShippingAddress1_O,v_ShippingAddress1_N,
         v_ShippingAddress2_O,v_ShippingAddress2_N,v_ShippingCity_O,v_ShippingCity_N,
         v_ShippingState_O,v_ShippingState_N,v_ShippingZip_O,v_ShippingZip_N,
         v_ShippingCountry_O,v_ShippingCountry_N,v_ShipMethodID_O,v_ShipMethodID_N,
         v_EmployeeID_O,v_EmployeeID_N,v_TermsID_O,v_TermsID_N,v_PaymentMethodID_O,
         v_PaymentMethodID_N,v_CurrencyID_O,v_CurrencyID_N,v_CurrencyExchangeRate_O,
         v_CurrencyExchangeRate_N,v_Subtotal_O,v_Subtotal_N,
         v_DiscountPers_O,v_DiscountPers_N,v_DiscountAmount_O,v_DiscountAmount_N,
         v_TaxPercent_O,v_TaxPercent_N,v_TaxAmount_O,v_TaxAmount_N,v_TaxableSubTotal_O,
         v_TaxableSubTotal_N,v_Freight_O,v_Freight_N,v_TaxFreight_O,
         v_TaxFreight_N,v_Handling_O,v_Handling_N,v_Advertising_O,v_Advertising_N,
         v_Total_O,v_Total_N,v_AmountPaid_O,v_AmountPaid_N,v_BalanceDue_O,
         v_BalanceDue_N,v_UndistributedAmount_O,v_UndistributedAmount_N,v_Commission_O,
         v_Commission_N,v_CommissionableSales_O,v_CommissionableSales_N,
         v_ComissionalbleCost_O,v_ComissionalbleCost_N,v_GLSalesAccount_O,v_GLSalesAccount_N,
         v_CheckNumber_O,v_CheckNumber_N,v_CheckDate_O,v_CheckDate_N,
         v_CreditCardTypeID_O,v_CreditCardTypeID_N,v_CreditCardName_O,v_CreditCardName_N,
         v_CreditCardNumber_O,v_CreditCardNumber_N,v_CreditCardExpDate_O,
         v_CreditCardExpDate_N,v_CreditCardCSVNumber_O,v_CreditCardCSVNumber_N,
         v_CreditCardBillToZip_O,v_CreditCardBillToZip_N,v_CreditCardValidationCode_O,
         v_CreditCardValidationCode_N,v_CreditCardApprovalNumber_O,
         v_CreditCardApprovalNumber_N,v_Picked_O,v_Picked_N,v_PickedDate_O,
         v_PickedDate_N,v_Billed_O,v_Billed_N,v_BilledDate_O,v_BilledDate_N,v_Printed_O,
         v_Printed_N,v_PrintedDate_O,v_PrintedDate_N,v_Shipped_O,v_Shipped_N,
         v_ShipDate_O,v_ShipDate_N,v_TrackingNumber_O,v_TrackingNumber_N,
         v_Backordered_O,v_Backordered_N,v_Posted_O,v_Posted_N,v_PostedDate_O,
         v_PostedDate_N,v_HeaderMemo1_O,v_HeaderMemo1_N,v_HeaderMemo2_O,v_HeaderMemo2_N,
         v_HeaderMemo3_O,v_HeaderMemo3_N,v_HeaderMemo4_O,v_HeaderMemo4_N,
         v_HeaderMemo5_O,v_HeaderMemo5_N,v_HeaderMemo6_O,v_HeaderMemo6_N,v_HeaderMemo7_O,
         v_HeaderMemo7_N,v_HeaderMemo8_O,v_HeaderMemo8_N,v_HeaderMemo9_O,
         v_HeaderMemo9_N,v_AllowanceDiscountPerc_O,v_AllowanceDiscountPerc_N;
      END WHILE;
      CLOSE cUpdate;

   END;
END;
 ;;
delimiter ;
delimiter ;;
CREATE TRIGGER `EDIInvoiceHeader_Audit_Delete` AFTER DELETE ON `ediinvoiceheader` FOR EACH ROW SWL_return:
BEGIN
   DECLARE NO_DATA INT DEFAULT 0;
   DECLARE v_Context VARBINARY(128);
   DECLARE v_TransactionNumber NATIONAL VARCHAR(50);
   DECLARE v_TransactionLineNumber NATIONAL VARCHAR(50);

   DECLARE v_CompanyID NATIONAL VARCHAR(36);
   DECLARE v_DivisionID NATIONAL VARCHAR(36);
   DECLARE v_DepartmentID NATIONAL VARCHAR(36);
   DECLARE v_InvoiceNumber NATIONAL VARCHAR(36);

-- deleting records cursor declaration
   DECLARE cDelete CURSOR
   FOR SELECT
   d.InvoiceNumber
		,''

		,d.CompanyID
		,d.DivisionID
		,d.DepartmentID
		,d.InvoiceNumber

   FROM
   DelEDIInvoiceHeader d;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET NO_DATA = -2;
   END;
   DECLARE CONTINUE HANDLER FOR NOT FOUND SET NO_DATA = -1;
   CREATE  TEMPORARY TABLE IF NOT EXISTS DelEDIInvoiceHeader
   (
      CompanyID NATIONAL VARCHAR(36),
      DivisionID NATIONAL VARCHAR(36),
      DepartmentID NATIONAL VARCHAR(36),
      InvoiceNumber NATIONAL VARCHAR(36),
      OrderNumber NATIONAL VARCHAR(36),
      TransactionTypeID NATIONAL VARCHAR(36),
      EDIDirectionTypeID NATIONAL VARCHAR(1),
      EDIDocumentTypeID NATIONAL VARCHAR(3),
      EDIOpen BOOLEAN,
      TransOpen BOOLEAN,
      InvoiceTypeID NATIONAL VARCHAR(36),
      InvoiceDate DATETIME,
      InvoiceDueDate DATETIME,
      InvoiceShipDate DATETIME,
      InvoiceCancelDate DATETIME,
      PurchaseOrderNumber NATIONAL VARCHAR(36),
      TaxExemptID NATIONAL VARCHAR(36),
      TaxGroupID NATIONAL VARCHAR(36),
      CustomerID NATIONAL VARCHAR(50),
      CustomerShipToID NATIONAL VARCHAR(36),
      CustomerShipForID NATIONAL VARCHAR(36),
      WarehouseID NATIONAL VARCHAR(36),
      CustomerDropShipment BOOLEAN,
      ShippingName NATIONAL VARCHAR(50),
      ShippingAddress1 NATIONAL VARCHAR(50),
      ShippingAddress2 NATIONAL VARCHAR(50),
      ShippingCity NATIONAL VARCHAR(50),
      ShippingState NATIONAL VARCHAR(50),
      ShippingZip NATIONAL VARCHAR(10),
      ShippingCountry NATIONAL VARCHAR(50),
      ShipMethodID NATIONAL VARCHAR(15),
      EmployeeID NATIONAL VARCHAR(15),
      TermsID NATIONAL VARCHAR(36),
      PaymentMethodID NATIONAL VARCHAR(36),
      CurrencyID NATIONAL VARCHAR(3),
      CurrencyExchangeRate FLOAT,
      Subtotal DECIMAL(19,4),
      DiscountPers FLOAT,
      DiscountAmount DECIMAL(19,4),
      TaxPercent FLOAT,
      TaxAmount DECIMAL(19,4),
      TaxableSubTotal DECIMAL(19,4),
      Freight DECIMAL(19,4),
      TaxFreight BOOLEAN,
      Handling DECIMAL(19,4),
      Advertising DECIMAL(19,4),
      Total DECIMAL(19,4),
      AmountPaid DECIMAL(19,4),
      BalanceDue DECIMAL(19,4),
      UndistributedAmount DECIMAL(19,4),
      Commission DECIMAL(19,4),
      CommissionableSales DECIMAL(19,4),
      ComissionalbleCost DECIMAL(19,4),
      GLSalesAccount NATIONAL VARCHAR(36),
      CheckNumber NATIONAL VARCHAR(20),
      CheckDate DATETIME,
      CreditCardTypeID NATIONAL VARCHAR(15),
      CreditCardName NATIONAL VARCHAR(50),
      CreditCardNumber NATIONAL VARCHAR(50),
      CreditCardExpDate DATETIME,
      CreditCardCSVNumber NATIONAL VARCHAR(5),
      CreditCardBillToZip NATIONAL VARCHAR(10),
      CreditCardValidationCode NATIONAL VARCHAR(20),
      CreditCardApprovalNumber NATIONAL VARCHAR(20),
      Picked BOOLEAN,
      PickedDate DATETIME,
      Billed BOOLEAN,
      BilledDate DATETIME,
      Printed BOOLEAN,
      PrintedDate DATETIME,
      Shipped BOOLEAN,
      ShipDate DATETIME,
      TrackingNumber NATIONAL VARCHAR(50),
      Backordered BOOLEAN,
      Posted BOOLEAN,
      PostedDate DATETIME,
      HeaderMemo1 NATIONAL VARCHAR(50),
      HeaderMemo2 NATIONAL VARCHAR(50),
      HeaderMemo3 NATIONAL VARCHAR(50),
      HeaderMemo4 NATIONAL VARCHAR(50),
      HeaderMemo5 NATIONAL VARCHAR(50),
      HeaderMemo6 NATIONAL VARCHAR(50),
      HeaderMemo7 NATIONAL VARCHAR(50),
      HeaderMemo8 NATIONAL VARCHAR(50),
      HeaderMemo9 NATIONAL VARCHAR(50),
      LockedBy NATIONAL VARCHAR(36),
      LockTS DATETIME,
      AllowanceDiscountPerc FLOAT
   );
   DELETE FROM DelEDIInvoiceHeader;
   INSERT INTO DelEDIInvoiceHeader VALUES(OLD.CompanyID, OLD.DivisionID, OLD.DepartmentID, OLD.InvoiceNumber, OLD.OrderNumber, OLD.TransactionTypeID, OLD.EDIDirectionTypeID, OLD.EDIDocumentTypeID, OLD.EDIOpen, OLD.TransOpen, OLD.InvoiceTypeID, OLD.InvoiceDate, OLD.InvoiceDueDate, OLD.InvoiceShipDate, OLD.InvoiceCancelDate, OLD.PurchaseOrderNumber, OLD.TaxExemptID, OLD.TaxGroupID, OLD.CustomerID, OLD.CustomerShipToID, OLD.CustomerShipForID, OLD.WarehouseID, OLD.CustomerDropShipment, OLD.ShippingName, OLD.ShippingAddress1, OLD.ShippingAddress2, OLD.ShippingCity, OLD.ShippingState, OLD.ShippingZip, OLD.ShippingCountry, OLD.ShipMethodID, OLD.EmployeeID, OLD.TermsID, OLD.PaymentMethodID, OLD.CurrencyID, OLD.CurrencyExchangeRate, OLD.Subtotal, OLD.DiscountPers, OLD.DiscountAmount, OLD.TaxPercent, OLD.TaxAmount, OLD.TaxableSubTotal, OLD.Freight, OLD.TaxFreight, OLD.Handling, OLD.Advertising, OLD.Total, OLD.AmountPaid, OLD.BalanceDue, OLD.UndistributedAmount, OLD.Commission, OLD.CommissionableSales, OLD.ComissionalbleCost, OLD.GLSalesAccount, OLD.CheckNumber, OLD.CheckDate, OLD.CreditCardTypeID, OLD.CreditCardName, OLD.CreditCardNumber, OLD.CreditCardExpDate, OLD.CreditCardCSVNumber, OLD.CreditCardBillToZip, OLD.CreditCardValidationCode, OLD.CreditCardApprovalNumber, OLD.Picked, OLD.PickedDate, OLD.Billed, OLD.BilledDate, OLD.Printed, OLD.PrintedDate, OLD.Shipped, OLD.ShipDate, OLD.TrackingNumber, OLD.Backordered, OLD.Posted, OLD.PostedDate, OLD.HeaderMemo1, OLD.HeaderMemo2, OLD.HeaderMemo3, OLD.HeaderMemo4, OLD.HeaderMemo5, OLD.HeaderMemo6, OLD.HeaderMemo7, OLD.HeaderMemo8, OLD.HeaderMemo9, OLD.LockedBy, OLD.LockTS, OLD.AllowanceDiscountPerc);

   BEGIN
-- check for audit triggers switch off

      select   context_info INTO v_Context FROM sysprocesses WHERE spid = CONNECTION_ID();
      IF CAST(v_Context AS CHAR(36)) = N'$$AuditSwitchOff$$' then 
         LEAVE SWL_return;
      end if;

-- declarations
      OPEN cDelete;
-- fetch from each deleting record
      SET NO_DATA = 0;
      FETCH cDelete INTO
      v_TransactionNumber,v_TransactionLineNumber,v_CompanyID,v_DivisionID,v_DepartmentID,
      v_InvoiceNumber;
      WHILE NO_DATA = 0 DO
-- insert audit record for each deleting record
         CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber,v_TransactionLineNumber,
         'EDIInvoiceHeader','Deleted','','Deleted');
         SET NO_DATA = 0;
         FETCH cDelete INTO
         v_TransactionNumber,v_TransactionLineNumber,v_CompanyID,v_DivisionID,v_DepartmentID,
         v_InvoiceNumber;
      END WHILE;
      CLOSE cDelete;

   END;
END;
 ;;
delimiter ;

-- ----------------------------
--  Table structure for `ediitems`
-- ----------------------------
DROP TABLE IF EXISTS `ediitems`;
CREATE TABLE `ediitems` (
  `CompanyID` varchar(36) NOT NULL,
  `DivisionID` varchar(36) NOT NULL,
  `DepartmentID` varchar(36) NOT NULL,
  `ItemID` varchar(36) NOT NULL,
  `ReferenceID` varchar(36) NOT NULL,
  `ItemDescription` varchar(80) DEFAULT NULL,
  `ReferenceDescription` varchar(80) DEFAULT NULL,
  `EDIDirectionTypeID` varchar(1) DEFAULT NULL,
  `EDIDocumentTypeID` varchar(3) DEFAULT NULL,
  `EDIOpen` tinyint(1) DEFAULT NULL,
  `UPCCode` varchar(12) DEFAULT NULL,
  `EPCCode` varchar(12) DEFAULT NULL,
  `RFIDCode` varchar(80) DEFAULT NULL,
  `ItemCategory` varchar(36) DEFAULT NULL,
  `ItemFamily` varchar(36) DEFAULT NULL,
  `ItemWeight` float DEFAULT NULL,
  `ItemUOM` varchar(36) DEFAULT NULL,
  `UOMBasis` varchar(36) DEFAULT NULL,
  `Length` varchar(10) DEFAULT NULL,
  `Width` varchar(10) DEFAULT NULL,
  `Height` varchar(10) DEFAULT NULL,
  `Quantity` bigint(20) DEFAULT NULL,
  `NRFColor` varchar(10) DEFAULT NULL,
  `NRFStyle` varchar(10) DEFAULT NULL,
  `LockedBy` varchar(36) DEFAULT NULL,
  `LockTS` datetime DEFAULT NULL,
  PRIMARY KEY (`CompanyID`,`DivisionID`,`DepartmentID`,`ItemID`,`ReferenceID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
delimiter ;;
CREATE TRIGGER `EDIItems_Audit_Insert` AFTER INSERT ON `ediitems` FOR EACH ROW SWL_return:
BEGIN
   DECLARE NO_DATA INT DEFAULT 0;
   DECLARE v_Context VARBINARY(128);
   DECLARE v_TransactionNumber NATIONAL VARCHAR(50);
   DECLARE v_TransactionLineNumber NATIONAL VARCHAR(50);

   DECLARE v_CompanyID NATIONAL VARCHAR(36);
   DECLARE v_DivisionID NATIONAL VARCHAR(36);
   DECLARE v_DepartmentID NATIONAL VARCHAR(36);
   DECLARE v_ItemID NATIONAL VARCHAR(36);
   DECLARE v_ReferenceID NATIONAL VARCHAR(36);

-- inserting records cursor declaration
   DECLARE cInsert CURSOR
   FOR SELECT
   i.ItemID
		,i.ReferenceID

		,i.CompanyID
		,i.DivisionID
		,i.DepartmentID
		,i.ItemID
		,i.ReferenceID

   FROM
   InsEDIItems i;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET NO_DATA = -2;
   END;
   DECLARE CONTINUE HANDLER FOR NOT FOUND SET NO_DATA = -1;
   CREATE  TEMPORARY TABLE IF NOT EXISTS InsEDIItems
   (
      CompanyID NATIONAL VARCHAR(36),
      DivisionID NATIONAL VARCHAR(36),
      DepartmentID NATIONAL VARCHAR(36),
      ItemID NATIONAL VARCHAR(36),
      ReferenceID NATIONAL VARCHAR(36),
      ItemDescription NATIONAL VARCHAR(80),
      ReferenceDescription NATIONAL VARCHAR(80),
      EDIDirectionTypeID NATIONAL VARCHAR(1),
      EDIDocumentTypeID NATIONAL VARCHAR(3),
      EDIOpen BOOLEAN,
      UPCCode NATIONAL VARCHAR(12),
      EPCCode NATIONAL VARCHAR(12),
      RFIDCode NATIONAL VARCHAR(80),
      ItemCategory NATIONAL VARCHAR(36),
      ItemFamily NATIONAL VARCHAR(36),
      ItemWeight FLOAT,
      ItemUOM NATIONAL VARCHAR(36),
      UOMBasis NATIONAL VARCHAR(36),
      Length NATIONAL VARCHAR(10),
      Width NATIONAL VARCHAR(10),
      Height NATIONAL VARCHAR(10),
      Quantity BIGINT,
      NRFColor NATIONAL VARCHAR(10),
      NRFStyle NATIONAL VARCHAR(10),
      LockedBy NATIONAL VARCHAR(36),
      LockTS DATETIME
   );
   DELETE FROM InsEDIItems;
   INSERT INTO InsEDIItems VALUES(NEW.CompanyID, NEW.DivisionID, NEW.DepartmentID, NEW.ItemID, NEW.ReferenceID, NEW.ItemDescription, NEW.ReferenceDescription, NEW.EDIDirectionTypeID, NEW.EDIDocumentTypeID, NEW.EDIOpen, NEW.UPCCode, NEW.EPCCode, NEW.RFIDCode, NEW.ItemCategory, NEW.ItemFamily, NEW.ItemWeight, NEW.ItemUOM, NEW.UOMBasis, NEW.Length, NEW.Width, NEW.Height, NEW.Quantity, NEW.NRFColor, NEW.NRFStyle, NEW.LockedBy, NEW.LockTS);

   BEGIN
-- check for audit triggers switch off

      select   context_info INTO v_Context FROM sysprocesses WHERE spid = CONNECTION_ID();
      IF CAST(v_Context AS CHAR(36)) = N'$$AuditSwitchOff$$' then 
         LEAVE SWL_return;
      end if;

-- declarations
      OPEN cInsert;
-- fetch from each inserting record
      SET NO_DATA = 0;
      FETCH cInsert INTO
      v_TransactionNumber,v_TransactionLineNumber,v_CompanyID,v_DivisionID,v_DepartmentID,
      v_ItemID,v_ReferenceID;
      WHILE NO_DATA = 0 DO
-- insert audit record for each inserting record
         IF IsGuid(v_TransactionNumber) = 0 then
		
            CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber,v_TransactionLineNumber,
            'EDIItems','New Record','','New Record');
         end if;
         SET NO_DATA = 0;
         FETCH cInsert INTO
         v_TransactionNumber,v_TransactionLineNumber,v_CompanyID,v_DivisionID,v_DepartmentID,
         v_ItemID,v_ReferenceID;
      END WHILE;
      CLOSE cInsert;

   END;
END;
 ;;
delimiter ;
delimiter ;;
CREATE TRIGGER `EDIItems_Audit_Update` AFTER UPDATE ON `ediitems` FOR EACH ROW SWL_return:
BEGIN
   DECLARE NO_DATA INT DEFAULT 0;
   DECLARE v_Context VARBINARY(128);
   DECLARE v_TransactionNumber_O NATIONAL VARCHAR(50);
   DECLARE v_TransactionNumber_N NATIONAL VARCHAR(50);
   DECLARE v_TransactionLineNumber NATIONAL VARCHAR(50);

   DECLARE v_CompanyID NATIONAL VARCHAR(36);
   DECLARE v_DivisionID NATIONAL VARCHAR(36);
   DECLARE v_DepartmentID NATIONAL VARCHAR(36);
   DECLARE v_ItemID NATIONAL VARCHAR(36);
   DECLARE v_ReferenceID NATIONAL VARCHAR(36);

   DECLARE v_ItemDescription_O NATIONAL VARCHAR(80);
   DECLARE v_ItemDescription_N NATIONAL VARCHAR(80);
   DECLARE v_ReferenceDescription_O NATIONAL VARCHAR(80);
   DECLARE v_ReferenceDescription_N NATIONAL VARCHAR(80);
   DECLARE v_EDIDirectionTypeID_O NATIONAL VARCHAR(80);
   DECLARE v_EDIDirectionTypeID_N NATIONAL VARCHAR(80);
   DECLARE v_EDIDocumentTypeID_O NATIONAL VARCHAR(80);
   DECLARE v_EDIDocumentTypeID_N NATIONAL VARCHAR(80);
   DECLARE v_EDIOpen_O NATIONAL VARCHAR(80);
   DECLARE v_EDIOpen_N NATIONAL VARCHAR(80);
   DECLARE v_UPCCode_O NATIONAL VARCHAR(80);
   DECLARE v_UPCCode_N NATIONAL VARCHAR(80);
   DECLARE v_EPCCode_O NATIONAL VARCHAR(80);
   DECLARE v_EPCCode_N NATIONAL VARCHAR(80);
   DECLARE v_RFIDCode_O NATIONAL VARCHAR(80);
   DECLARE v_RFIDCode_N NATIONAL VARCHAR(80);
   DECLARE v_ItemCategory_O NATIONAL VARCHAR(80);
   DECLARE v_ItemCategory_N NATIONAL VARCHAR(80);
   DECLARE v_ItemFamily_O NATIONAL VARCHAR(80);
   DECLARE v_ItemFamily_N NATIONAL VARCHAR(80);
   DECLARE v_ItemWeight_O NATIONAL VARCHAR(80);
   DECLARE v_ItemWeight_N NATIONAL VARCHAR(80);
   DECLARE v_ItemUOM_O NATIONAL VARCHAR(80);
   DECLARE v_ItemUOM_N NATIONAL VARCHAR(80);
   DECLARE v_UOMBasis_O NATIONAL VARCHAR(80);
   DECLARE v_UOMBasis_N NATIONAL VARCHAR(80);
   DECLARE v_Length_O NATIONAL VARCHAR(80);
   DECLARE v_Length_N NATIONAL VARCHAR(80);
   DECLARE v_Width_O NATIONAL VARCHAR(80);
   DECLARE v_Width_N NATIONAL VARCHAR(80);
   DECLARE v_Height_O NATIONAL VARCHAR(80);
   DECLARE v_Height_N NATIONAL VARCHAR(80);
   DECLARE v_Quantity_O NATIONAL VARCHAR(80);
   DECLARE v_Quantity_N NATIONAL VARCHAR(80);
   DECLARE v_NRFColor_O NATIONAL VARCHAR(80);
   DECLARE v_NRFColor_N NATIONAL VARCHAR(80);
   DECLARE v_NRFStyle_O NATIONAL VARCHAR(80);
   DECLARE v_NRFStyle_N NATIONAL VARCHAR(80);
 

-- updating records cursor declaration
   DECLARE cUpdate CURSOR
   FOR SELECT
   d.ItemID
		,i.ItemID
		,i.ReferenceID

		,i.CompanyID
		,i.DivisionID
		,i.DepartmentID
		,i.ItemID
		,i.ReferenceID

,CAST(d.ItemDescription AS CHAR(80))
,CAST(i.ItemDescription AS CHAR(80))
,CAST(d.ReferenceDescription AS CHAR(80))
,CAST(i.ReferenceDescription AS CHAR(80))
,CAST(d.EDIDirectionTypeID AS CHAR(80))
,CAST(i.EDIDirectionTypeID AS CHAR(80))
,CAST(d.EDIDocumentTypeID AS CHAR(80))
,CAST(i.EDIDocumentTypeID AS CHAR(80))
,CAST(d.EDIOpen AS CHAR(80))
,CAST(i.EDIOpen AS CHAR(80))
,CAST(d.UPCCode AS CHAR(80))
,CAST(i.UPCCode AS CHAR(80))
,CAST(d.EPCCode AS CHAR(80))
,CAST(i.EPCCode AS CHAR(80))
,CAST(d.RFIDCode AS CHAR(80))
,CAST(i.RFIDCode AS CHAR(80))
,CAST(d.ItemCategory AS CHAR(80))
,CAST(i.ItemCategory AS CHAR(80))
,CAST(d.ItemFamily AS CHAR(80))
,CAST(i.ItemFamily AS CHAR(80))
,CAST(d.ItemWeight AS CHAR(80))
,CAST(i.ItemWeight AS CHAR(80))
,CAST(d.ItemUOM AS CHAR(80))
,CAST(i.ItemUOM AS CHAR(80))
,CAST(d.UOMBasis AS CHAR(80))
,CAST(i.UOMBasis AS CHAR(80))
,CAST(d.Length AS CHAR(80))
,CAST(i.Length AS CHAR(80))
,CAST(d.Width AS CHAR(80))
,CAST(i.Width AS CHAR(80))
,CAST(d.Height AS CHAR(80))
,CAST(i.Height AS CHAR(80))
,CAST(d.Quantity AS CHAR(80))
,CAST(i.Quantity AS CHAR(80))
,CAST(d.NRFColor AS CHAR(80))
,CAST(i.NRFColor AS CHAR(80))
,CAST(d.NRFStyle AS CHAR(80))
,CAST(i.NRFStyle AS CHAR(80))
 

   FROM
   InsEDIItems i
   LEFT OUTER JOIN DelEDIItems d ON
   d.CompanyID = i.CompanyID
   AND d.DivisionID = i.DivisionID
   AND d.DepartmentID = i.DepartmentID
   AND d.ItemID = i.ItemID
   AND d.ReferenceID = i.ReferenceID;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET NO_DATA = -2;
   END;
   DECLARE CONTINUE HANDLER FOR NOT FOUND SET NO_DATA = -1;
   CREATE  TEMPORARY TABLE IF NOT EXISTS InsEDIItems
   (
      CompanyID NATIONAL VARCHAR(36),
      DivisionID NATIONAL VARCHAR(36),
      DepartmentID NATIONAL VARCHAR(36),
      ItemID NATIONAL VARCHAR(36),
      ReferenceID NATIONAL VARCHAR(36),
      ItemDescription NATIONAL VARCHAR(80),
      ReferenceDescription NATIONAL VARCHAR(80),
      EDIDirectionTypeID NATIONAL VARCHAR(1),
      EDIDocumentTypeID NATIONAL VARCHAR(3),
      EDIOpen BOOLEAN,
      UPCCode NATIONAL VARCHAR(12),
      EPCCode NATIONAL VARCHAR(12),
      RFIDCode NATIONAL VARCHAR(80),
      ItemCategory NATIONAL VARCHAR(36),
      ItemFamily NATIONAL VARCHAR(36),
      ItemWeight FLOAT,
      ItemUOM NATIONAL VARCHAR(36),
      UOMBasis NATIONAL VARCHAR(36),
      Length NATIONAL VARCHAR(10),
      Width NATIONAL VARCHAR(10),
      Height NATIONAL VARCHAR(10),
      Quantity BIGINT,
      NRFColor NATIONAL VARCHAR(10),
      NRFStyle NATIONAL VARCHAR(10),
      LockedBy NATIONAL VARCHAR(36),
      LockTS DATETIME
   );
   DELETE FROM InsEDIItems;
   INSERT INTO InsEDIItems VALUES(NEW.CompanyID, NEW.DivisionID, NEW.DepartmentID, NEW.ItemID, NEW.ReferenceID, NEW.ItemDescription, NEW.ReferenceDescription, NEW.EDIDirectionTypeID, NEW.EDIDocumentTypeID, NEW.EDIOpen, NEW.UPCCode, NEW.EPCCode, NEW.RFIDCode, NEW.ItemCategory, NEW.ItemFamily, NEW.ItemWeight, NEW.ItemUOM, NEW.UOMBasis, NEW.Length, NEW.Width, NEW.Height, NEW.Quantity, NEW.NRFColor, NEW.NRFStyle, NEW.LockedBy, NEW.LockTS);

   CREATE  TEMPORARY TABLE IF NOT EXISTS DelEDIItems
   (
      CompanyID NATIONAL VARCHAR(36),
      DivisionID NATIONAL VARCHAR(36),
      DepartmentID NATIONAL VARCHAR(36),
      ItemID NATIONAL VARCHAR(36),
      ReferenceID NATIONAL VARCHAR(36),
      ItemDescription NATIONAL VARCHAR(80),
      ReferenceDescription NATIONAL VARCHAR(80),
      EDIDirectionTypeID NATIONAL VARCHAR(1),
      EDIDocumentTypeID NATIONAL VARCHAR(3),
      EDIOpen BOOLEAN,
      UPCCode NATIONAL VARCHAR(12),
      EPCCode NATIONAL VARCHAR(12),
      RFIDCode NATIONAL VARCHAR(80),
      ItemCategory NATIONAL VARCHAR(36),
      ItemFamily NATIONAL VARCHAR(36),
      ItemWeight FLOAT,
      ItemUOM NATIONAL VARCHAR(36),
      UOMBasis NATIONAL VARCHAR(36),
      Length NATIONAL VARCHAR(10),
      Width NATIONAL VARCHAR(10),
      Height NATIONAL VARCHAR(10),
      Quantity BIGINT,
      NRFColor NATIONAL VARCHAR(10),
      NRFStyle NATIONAL VARCHAR(10),
      LockedBy NATIONAL VARCHAR(36),
      LockTS DATETIME
   );
   DELETE FROM DelEDIItems;
   INSERT INTO DelEDIItems VALUES(OLD.CompanyID, OLD.DivisionID, OLD.DepartmentID, OLD.ItemID, OLD.ReferenceID, OLD.ItemDescription, OLD.ReferenceDescription, OLD.EDIDirectionTypeID, OLD.EDIDocumentTypeID, OLD.EDIOpen, OLD.UPCCode, OLD.EPCCode, OLD.RFIDCode, OLD.ItemCategory, OLD.ItemFamily, OLD.ItemWeight, OLD.ItemUOM, OLD.UOMBasis, OLD.Length, OLD.Width, OLD.Height, OLD.Quantity, OLD.NRFColor, OLD.NRFStyle, OLD.LockedBy, OLD.LockTS);

   BEGIN
-- check for audit triggers switch off

      select   context_info INTO v_Context FROM sysprocesses WHERE spid = CONNECTION_ID();
      IF CAST(v_Context AS CHAR(36)) = N'$$AuditSwitchOff$$' then 
         LEAVE SWL_return;
      end if;

-- declarations
      OPEN cUpdate;
-- fetch from each updating record
      SET NO_DATA = 0;
      FETCH cUpdate INTO
      v_TransactionNumber_O,v_TransactionNumber_N,v_TransactionLineNumber,v_CompanyID,
      v_DivisionID,v_DepartmentID,v_ItemID,v_ReferenceID,v_ItemDescription_O,
      v_ItemDescription_N,v_ReferenceDescription_O,v_ReferenceDescription_N,
      v_EDIDirectionTypeID_O,v_EDIDirectionTypeID_N,v_EDIDocumentTypeID_O,
      v_EDIDocumentTypeID_N,v_EDIOpen_O,v_EDIOpen_N,v_UPCCode_O,v_UPCCode_N,
      v_EPCCode_O,v_EPCCode_N,v_RFIDCode_O,v_RFIDCode_N,v_ItemCategory_O,
      v_ItemCategory_N,v_ItemFamily_O,v_ItemFamily_N,v_ItemWeight_O,v_ItemWeight_N,
      v_ItemUOM_O,v_ItemUOM_N,v_UOMBasis_O,v_UOMBasis_N,v_Length_O,
      v_Length_N,v_Width_O,v_Width_N,v_Height_O,v_Height_N,v_Quantity_O,
      v_Quantity_N,v_NRFColor_O,v_NRFColor_N,v_NRFStyle_O,v_NRFStyle_N;
      WHILE NO_DATA = 0 DO
-- insert audit records for each changed field

         CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
         'EDIItems','ItemDescription',v_ItemDescription_O,
         v_ItemDescription_N);
         CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
         'EDIItems','ReferenceDescription',v_ReferenceDescription_O,
         v_ReferenceDescription_N);
         CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
         'EDIItems','EDIDirectionTypeID',v_EDIDirectionTypeID_O,
         v_EDIDirectionTypeID_N);
         CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
         'EDIItems','EDIDocumentTypeID',v_EDIDocumentTypeID_O,
         v_EDIDocumentTypeID_N);
         CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
         'EDIItems','EDIOpen',v_EDIOpen_O,v_EDIOpen_N);
         CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
         'EDIItems','UPCCode',v_UPCCode_O,v_UPCCode_N);
         CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
         'EDIItems','EPCCode',v_EPCCode_O,v_EPCCode_N);
         CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
         'EDIItems','RFIDCode',v_RFIDCode_O,v_RFIDCode_N);
         CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
         'EDIItems','ItemCategory',v_ItemCategory_O,v_ItemCategory_N);
         CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
         'EDIItems','ItemFamily',v_ItemFamily_O,v_ItemFamily_N);
         CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
         'EDIItems','ItemWeight',v_ItemWeight_O,v_ItemWeight_N);
         CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
         'EDIItems','ItemUOM',v_ItemUOM_O,v_ItemUOM_N);
         CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
         'EDIItems','UOMBasis',v_UOMBasis_O,v_UOMBasis_N);
         CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
         'EDIItems','Length',v_Length_O,v_Length_N);
         CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
         'EDIItems','Width',v_Width_O,v_Width_N);
         CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
         'EDIItems','Height',v_Height_O,v_Height_N);
         CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
         'EDIItems','Quantity',v_Quantity_O,v_Quantity_N);
         CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
         'EDIItems','NRFColor',v_NRFColor_O,v_NRFColor_N);
         CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
         'EDIItems','NRFStyle',v_NRFStyle_O,v_NRFStyle_N);
         SET NO_DATA = 0;
         FETCH cUpdate INTO
         v_TransactionNumber_O,v_TransactionNumber_N,v_TransactionLineNumber,v_CompanyID,
         v_DivisionID,v_DepartmentID,v_ItemID,v_ReferenceID,v_ItemDescription_O,
         v_ItemDescription_N,v_ReferenceDescription_O,v_ReferenceDescription_N,
         v_EDIDirectionTypeID_O,v_EDIDirectionTypeID_N,v_EDIDocumentTypeID_O,
         v_EDIDocumentTypeID_N,v_EDIOpen_O,v_EDIOpen_N,v_UPCCode_O,v_UPCCode_N,
         v_EPCCode_O,v_EPCCode_N,v_RFIDCode_O,v_RFIDCode_N,v_ItemCategory_O,
         v_ItemCategory_N,v_ItemFamily_O,v_ItemFamily_N,v_ItemWeight_O,v_ItemWeight_N,
         v_ItemUOM_O,v_ItemUOM_N,v_UOMBasis_O,v_UOMBasis_N,v_Length_O,
         v_Length_N,v_Width_O,v_Width_N,v_Height_O,v_Height_N,v_Quantity_O,
         v_Quantity_N,v_NRFColor_O,v_NRFColor_N,v_NRFStyle_O,v_NRFStyle_N;
      END WHILE;
      CLOSE cUpdate;

   END;
END;
 ;;
delimiter ;
delimiter ;;
CREATE TRIGGER `EDIItems_Audit_Delete` AFTER DELETE ON `ediitems` FOR EACH ROW SWL_return:
BEGIN
   DECLARE NO_DATA INT DEFAULT 0;
   DECLARE v_Context VARBINARY(128);
   DECLARE v_TransactionNumber NATIONAL VARCHAR(50);
   DECLARE v_TransactionLineNumber NATIONAL VARCHAR(50);

   DECLARE v_CompanyID NATIONAL VARCHAR(36);
   DECLARE v_DivisionID NATIONAL VARCHAR(36);
   DECLARE v_DepartmentID NATIONAL VARCHAR(36);
   DECLARE v_ItemID NATIONAL VARCHAR(36);
   DECLARE v_ReferenceID NATIONAL VARCHAR(36);

-- deleting records cursor declaration
   DECLARE cDelete CURSOR
   FOR SELECT
   d.ItemID
		,d.ReferenceID

		,d.CompanyID
		,d.DivisionID
		,d.DepartmentID
		,d.ItemID
		,d.ReferenceID

   FROM
   DelEDIItems d;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET NO_DATA = -2;
   END;
   DECLARE CONTINUE HANDLER FOR NOT FOUND SET NO_DATA = -1;
   CREATE  TEMPORARY TABLE IF NOT EXISTS DelEDIItems
   (
      CompanyID NATIONAL VARCHAR(36),
      DivisionID NATIONAL VARCHAR(36),
      DepartmentID NATIONAL VARCHAR(36),
      ItemID NATIONAL VARCHAR(36),
      ReferenceID NATIONAL VARCHAR(36),
      ItemDescription NATIONAL VARCHAR(80),
      ReferenceDescription NATIONAL VARCHAR(80),
      EDIDirectionTypeID NATIONAL VARCHAR(1),
      EDIDocumentTypeID NATIONAL VARCHAR(3),
      EDIOpen BOOLEAN,
      UPCCode NATIONAL VARCHAR(12),
      EPCCode NATIONAL VARCHAR(12),
      RFIDCode NATIONAL VARCHAR(80),
      ItemCategory NATIONAL VARCHAR(36),
      ItemFamily NATIONAL VARCHAR(36),
      ItemWeight FLOAT,
      ItemUOM NATIONAL VARCHAR(36),
      UOMBasis NATIONAL VARCHAR(36),
      Length NATIONAL VARCHAR(10),
      Width NATIONAL VARCHAR(10),
      Height NATIONAL VARCHAR(10),
      Quantity BIGINT,
      NRFColor NATIONAL VARCHAR(10),
      NRFStyle NATIONAL VARCHAR(10),
      LockedBy NATIONAL VARCHAR(36),
      LockTS DATETIME
   );
   DELETE FROM DelEDIItems;
   INSERT INTO DelEDIItems VALUES(OLD.CompanyID, OLD.DivisionID, OLD.DepartmentID, OLD.ItemID, OLD.ReferenceID, OLD.ItemDescription, OLD.ReferenceDescription, OLD.EDIDirectionTypeID, OLD.EDIDocumentTypeID, OLD.EDIOpen, OLD.UPCCode, OLD.EPCCode, OLD.RFIDCode, OLD.ItemCategory, OLD.ItemFamily, OLD.ItemWeight, OLD.ItemUOM, OLD.UOMBasis, OLD.Length, OLD.Width, OLD.Height, OLD.Quantity, OLD.NRFColor, OLD.NRFStyle, OLD.LockedBy, OLD.LockTS);

   BEGIN
-- check for audit triggers switch off

      select   context_info INTO v_Context FROM sysprocesses WHERE spid = CONNECTION_ID();
      IF CAST(v_Context AS CHAR(36)) = N'$$AuditSwitchOff$$' then 
         LEAVE SWL_return;
      end if;

-- declarations
      OPEN cDelete;
-- fetch from each deleting record
      SET NO_DATA = 0;
      FETCH cDelete INTO
      v_TransactionNumber,v_TransactionLineNumber,v_CompanyID,v_DivisionID,v_DepartmentID,
      v_ItemID,v_ReferenceID;
      WHILE NO_DATA = 0 DO
-- insert audit record for each deleting record
         CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber,v_TransactionLineNumber,
         'EDIItems','Deleted','','Deleted');
         SET NO_DATA = 0;
         FETCH cDelete INTO
         v_TransactionNumber,v_TransactionLineNumber,v_CompanyID,v_DivisionID,v_DepartmentID,
         v_ItemID,v_ReferenceID;
      END WHILE;
      CLOSE cDelete;

   END;
END;
 ;;
delimiter ;

-- ----------------------------
--  Table structure for `ediorderdetail`
-- ----------------------------
DROP TABLE IF EXISTS `ediorderdetail`;
CREATE TABLE `ediorderdetail` (
  `CompanyID` varchar(36) NOT NULL,
  `DivisionID` varchar(36) NOT NULL,
  `DepartmentID` varchar(36) NOT NULL,
  `OrderNumber` varchar(36) NOT NULL,
  `OrderLineNumber` bigint(20) NOT NULL AUTO_INCREMENT,
  `ItemID` varchar(36) DEFAULT NULL,
  `WarehouseID` varchar(36) DEFAULT NULL,
  `WarehouseBinID` varchar(36) DEFAULT NULL,
  `SerialNumber` varchar(50) DEFAULT NULL,
  `Description` varchar(80) DEFAULT NULL,
  `OrderQty` float DEFAULT NULL,
  `BackOrdered` tinyint(1) DEFAULT NULL,
  `BackOrderQyyty` float DEFAULT NULL,
  `ItemUOM` varchar(15) DEFAULT NULL,
  `ItemWeight` float DEFAULT NULL,
  `DiscountPerc` float DEFAULT NULL,
  `Taxable` tinyint(1) DEFAULT NULL,
  `CurrencyID` varchar(3) DEFAULT NULL,
  `CurrencyExchangeRate` float DEFAULT NULL,
  `ItemCost` decimal(19,4) DEFAULT NULL,
  `ItemUnitPrice` decimal(19,4) DEFAULT NULL,
  `Total` decimal(19,4) DEFAULT NULL,
  `TotalWeight` float DEFAULT NULL,
  `GLSalesAccount` varchar(36) DEFAULT NULL,
  `ProjectID` varchar(36) DEFAULT NULL,
  `WarehouseBinZone` varchar(36) DEFAULT NULL,
  `PalletLevel` varchar(36) DEFAULT NULL,
  `CartonLevel` varchar(36) DEFAULT NULL,
  `PackLevelA` varchar(36) DEFAULT NULL,
  `PackLevelB` varchar(36) DEFAULT NULL,
  `PackLevelC` varchar(36) DEFAULT NULL,
  `TrackingNumber` varchar(50) DEFAULT NULL,
  `DetailMemo1` varchar(50) DEFAULT NULL,
  `DetailMemo2` varchar(50) DEFAULT NULL,
  `DetailMemo3` varchar(50) DEFAULT NULL,
  `DetailMemo4` varchar(50) DEFAULT NULL,
  `DetailMemo5` varchar(50) DEFAULT NULL,
  `LockedBy` varchar(36) DEFAULT NULL,
  `LockTS` datetime DEFAULT NULL,
  `TaxGroupID` varchar(36) DEFAULT NULL,
  `TaxAmount` decimal(19,4) DEFAULT NULL,
  `TaxPercent` float DEFAULT NULL,
  `SubTotal` decimal(19,4) DEFAULT NULL,
  PRIMARY KEY (`OrderLineNumber`,`CompanyID`,`DivisionID`,`DepartmentID`,`OrderNumber`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
delimiter ;;
CREATE TRIGGER `EDIOrderDetail_Audit_Insert` AFTER INSERT ON `ediorderdetail` FOR EACH ROW SWL_return:
BEGIN
   DECLARE NO_DATA INT DEFAULT 0;
   DECLARE v_Context VARBINARY(128);
   DECLARE v_TransactionNumber NATIONAL VARCHAR(50);
   DECLARE v_TransactionLineNumber NATIONAL VARCHAR(50);

   DECLARE v_CompanyID NATIONAL VARCHAR(36);
   DECLARE v_DivisionID NATIONAL VARCHAR(36);
   DECLARE v_DepartmentID NATIONAL VARCHAR(36);
   DECLARE v_OrderNumber NATIONAL VARCHAR(36);
   DECLARE v_OrderLineNumber NUMERIC(18,0);

-- inserting records cursor declaration
   DECLARE cInsert CURSOR
   FOR SELECT
   i.OrderNumber
		,i.OrderLineNumber

		,i.CompanyID
		,i.DivisionID
		,i.DepartmentID
		,i.OrderNumber
		,i.OrderLineNumber

   FROM
   InsEDIOrderDetail i;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET NO_DATA = -2;
   END;
   DECLARE CONTINUE HANDLER FOR NOT FOUND SET NO_DATA = -1;
   CREATE  TEMPORARY TABLE IF NOT EXISTS InsEDIOrderDetail
   (
      CompanyID NATIONAL VARCHAR(36),
      DivisionID NATIONAL VARCHAR(36),
      DepartmentID NATIONAL VARCHAR(36),
      OrderNumber NATIONAL VARCHAR(36),
      OrderLineNumber NUMERIC(18,0),
      ItemID NATIONAL VARCHAR(36),
      WarehouseID NATIONAL VARCHAR(36),
      WarehouseBinID NATIONAL VARCHAR(36),
      SerialNumber NATIONAL VARCHAR(50),
      Description NATIONAL VARCHAR(80),
      OrderQty FLOAT,
      BackOrdered BOOLEAN,
      BackOrderQyyty FLOAT,
      ItemUOM NATIONAL VARCHAR(15),
      ItemWeight FLOAT,
      DiscountPerc FLOAT,
      Taxable BOOLEAN,
      CurrencyID NATIONAL VARCHAR(3),
      CurrencyExchangeRate FLOAT,
      ItemCost DECIMAL(19,4),
      ItemUnitPrice DECIMAL(19,4),
      Total DECIMAL(19,4),
      TotalWeight FLOAT,
      GLSalesAccount NATIONAL VARCHAR(36),
      ProjectID NATIONAL VARCHAR(36),
      WarehouseBinZone NATIONAL VARCHAR(36),
      PalletLevel NATIONAL VARCHAR(36),
      CartonLevel NATIONAL VARCHAR(36),
      PackLevelA NATIONAL VARCHAR(36),
      PackLevelB NATIONAL VARCHAR(36),
      PackLevelC NATIONAL VARCHAR(36),
      TrackingNumber NATIONAL VARCHAR(50),
      DetailMemo1 NATIONAL VARCHAR(50),
      DetailMemo2 NATIONAL VARCHAR(50),
      DetailMemo3 NATIONAL VARCHAR(50),
      DetailMemo4 NATIONAL VARCHAR(50),
      DetailMemo5 NATIONAL VARCHAR(50),
      LockedBy NATIONAL VARCHAR(36),
      LockTS DATETIME,
      TaxGroupID NATIONAL VARCHAR(36),
      TaxAmount DECIMAL(19,4),
      TaxPercent FLOAT,
      SubTotal DECIMAL(19,4)
   );
   DELETE FROM InsEDIOrderDetail;
   INSERT INTO InsEDIOrderDetail VALUES(NEW.CompanyID, NEW.DivisionID, NEW.DepartmentID, NEW.OrderNumber, NEW.OrderLineNumber, NEW.ItemID, NEW.WarehouseID, NEW.WarehouseBinID, NEW.SerialNumber, NEW.Description, NEW.OrderQty, NEW.BackOrdered, NEW.BackOrderQyyty, NEW.ItemUOM, NEW.ItemWeight, NEW.DiscountPerc, NEW.Taxable, NEW.CurrencyID, NEW.CurrencyExchangeRate, NEW.ItemCost, NEW.ItemUnitPrice, NEW.Total, NEW.TotalWeight, NEW.GLSalesAccount, NEW.ProjectID, NEW.WarehouseBinZone, NEW.PalletLevel, NEW.CartonLevel, NEW.PackLevelA, NEW.PackLevelB, NEW.PackLevelC, NEW.TrackingNumber, NEW.DetailMemo1, NEW.DetailMemo2, NEW.DetailMemo3, NEW.DetailMemo4, NEW.DetailMemo5, NEW.LockedBy, NEW.LockTS, NEW.TaxGroupID, NEW.TaxAmount, NEW.TaxPercent, NEW.SubTotal);

   BEGIN
-- check for audit triggers switch off

      select   context_info INTO v_Context FROM sysprocesses WHERE spid = CONNECTION_ID();
      IF CAST(v_Context AS CHAR(36)) = N'$$AuditSwitchOff$$' then 
         LEAVE SWL_return;
      end if;

-- declarations
      OPEN cInsert;
-- fetch from each inserting record
      SET NO_DATA = 0;
      FETCH cInsert INTO
      v_TransactionNumber,v_TransactionLineNumber,v_CompanyID,v_DivisionID,v_DepartmentID,
      v_OrderNumber,v_OrderLineNumber;
      WHILE NO_DATA = 0 DO
-- insert audit record for each inserting record
         IF IsGuid(v_TransactionNumber) = 0 then
		
            CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber,v_TransactionLineNumber,
            'EDIOrderDetail','New Record','','New Record');
         end if;
         SET NO_DATA = 0;
         FETCH cInsert INTO
         v_TransactionNumber,v_TransactionLineNumber,v_CompanyID,v_DivisionID,v_DepartmentID,
         v_OrderNumber,v_OrderLineNumber;
      END WHILE;
      CLOSE cInsert;

   END;
END;
 ;;
delimiter ;
delimiter ;;
CREATE TRIGGER `EDIOrderDetail_Audit_Update` AFTER UPDATE ON `ediorderdetail` FOR EACH ROW SWL_return:
BEGIN
   DECLARE NO_DATA INT DEFAULT 0;
   DECLARE v_Context VARBINARY(128);
   DECLARE v_TransactionNumber_O NATIONAL VARCHAR(50);
   DECLARE v_TransactionNumber_N NATIONAL VARCHAR(50);
   DECLARE v_TransactionLineNumber NATIONAL VARCHAR(50);

   DECLARE v_CompanyID NATIONAL VARCHAR(36);
   DECLARE v_DivisionID NATIONAL VARCHAR(36);
   DECLARE v_DepartmentID NATIONAL VARCHAR(36);
   DECLARE v_OrderNumber NATIONAL VARCHAR(36);
   DECLARE v_OrderLineNumber NUMERIC(18,0);

   DECLARE v_ItemID_O NATIONAL VARCHAR(80);
   DECLARE v_ItemID_N NATIONAL VARCHAR(80);
   DECLARE v_WarehouseID_O NATIONAL VARCHAR(80);
   DECLARE v_WarehouseID_N NATIONAL VARCHAR(80);
   DECLARE v_WarehouseBinID_O NATIONAL VARCHAR(80);
   DECLARE v_WarehouseBinID_N NATIONAL VARCHAR(80);
   DECLARE v_SerialNumber_O NATIONAL VARCHAR(80);
   DECLARE v_SerialNumber_N NATIONAL VARCHAR(80);
   DECLARE v_Description_O NATIONAL VARCHAR(80);
   DECLARE v_Description_N NATIONAL VARCHAR(80);
   DECLARE v_OrderQty_O NATIONAL VARCHAR(80);
   DECLARE v_OrderQty_N NATIONAL VARCHAR(80);
   DECLARE v_BackOrdered_O NATIONAL VARCHAR(80);
   DECLARE v_BackOrdered_N NATIONAL VARCHAR(80);
   DECLARE v_BackOrderQyyty_O NATIONAL VARCHAR(80);
   DECLARE v_BackOrderQyyty_N NATIONAL VARCHAR(80);
   DECLARE v_ItemUOM_O NATIONAL VARCHAR(80);
   DECLARE v_ItemUOM_N NATIONAL VARCHAR(80);
   DECLARE v_ItemWeight_O NATIONAL VARCHAR(80);
   DECLARE v_ItemWeight_N NATIONAL VARCHAR(80);
   DECLARE v_DiscountPerc_O NATIONAL VARCHAR(80);
   DECLARE v_DiscountPerc_N NATIONAL VARCHAR(80);
   DECLARE v_Taxable_O NATIONAL VARCHAR(80);
   DECLARE v_Taxable_N NATIONAL VARCHAR(80);
   DECLARE v_CurrencyID_O NATIONAL VARCHAR(80);
   DECLARE v_CurrencyID_N NATIONAL VARCHAR(80);
   DECLARE v_CurrencyExchangeRate_O NATIONAL VARCHAR(80);
   DECLARE v_CurrencyExchangeRate_N NATIONAL VARCHAR(80);
   DECLARE v_ItemCost_O NATIONAL VARCHAR(80);
   DECLARE v_ItemCost_N NATIONAL VARCHAR(80);
   DECLARE v_ItemUnitPrice_O NATIONAL VARCHAR(80);
   DECLARE v_ItemUnitPrice_N NATIONAL VARCHAR(80);
   DECLARE v_Total_O NATIONAL VARCHAR(80);
   DECLARE v_Total_N NATIONAL VARCHAR(80);
   DECLARE v_TotalWeight_O NATIONAL VARCHAR(80);
   DECLARE v_TotalWeight_N NATIONAL VARCHAR(80);
   DECLARE v_GLSalesAccount_O NATIONAL VARCHAR(80);
   DECLARE v_GLSalesAccount_N NATIONAL VARCHAR(80);
   DECLARE v_ProjectID_O NATIONAL VARCHAR(80);
   DECLARE v_ProjectID_N NATIONAL VARCHAR(80);
   DECLARE v_WarehouseBinZone_O NATIONAL VARCHAR(80);
   DECLARE v_WarehouseBinZone_N NATIONAL VARCHAR(80);
   DECLARE v_PalletLevel_O NATIONAL VARCHAR(80);
   DECLARE v_PalletLevel_N NATIONAL VARCHAR(80);
   DECLARE v_CartonLevel_O NATIONAL VARCHAR(80);
   DECLARE v_CartonLevel_N NATIONAL VARCHAR(80);
   DECLARE v_PackLevelA_O NATIONAL VARCHAR(80);
   DECLARE v_PackLevelA_N NATIONAL VARCHAR(80);
   DECLARE v_PackLevelB_O NATIONAL VARCHAR(80);
   DECLARE v_PackLevelB_N NATIONAL VARCHAR(80);
   DECLARE v_PackLevelC_O NATIONAL VARCHAR(80);
   DECLARE v_PackLevelC_N NATIONAL VARCHAR(80);
   DECLARE v_TrackingNumber_O NATIONAL VARCHAR(80);
   DECLARE v_TrackingNumber_N NATIONAL VARCHAR(80);
   DECLARE v_DetailMemo1_O NATIONAL VARCHAR(80);
   DECLARE v_DetailMemo1_N NATIONAL VARCHAR(80);
   DECLARE v_DetailMemo2_O NATIONAL VARCHAR(80);
   DECLARE v_DetailMemo2_N NATIONAL VARCHAR(80);
   DECLARE v_DetailMemo3_O NATIONAL VARCHAR(80);
   DECLARE v_DetailMemo3_N NATIONAL VARCHAR(80);
   DECLARE v_DetailMemo4_O NATIONAL VARCHAR(80);
   DECLARE v_DetailMemo4_N NATIONAL VARCHAR(80);
   DECLARE v_DetailMemo5_O NATIONAL VARCHAR(80);
   DECLARE v_DetailMemo5_N NATIONAL VARCHAR(80);
   DECLARE v_TaxGroupID_O NATIONAL VARCHAR(80);
   DECLARE v_TaxGroupID_N NATIONAL VARCHAR(80);
   DECLARE v_TaxAmount_O NATIONAL VARCHAR(80);
   DECLARE v_TaxAmount_N NATIONAL VARCHAR(80);
   DECLARE v_TaxPercent_O NATIONAL VARCHAR(80);
   DECLARE v_TaxPercent_N NATIONAL VARCHAR(80);
   DECLARE v_SubTotal_O NATIONAL VARCHAR(80);
   DECLARE v_SubTotal_N NATIONAL VARCHAR(80);
 

-- updating records cursor declaration
   DECLARE cUpdate CURSOR
   FOR SELECT
   d.OrderNumber
		,i.OrderNumber
		,i.OrderLineNumber

		,i.CompanyID
		,i.DivisionID
		,i.DepartmentID
		,i.OrderNumber
		,i.OrderLineNumber

,CAST(d.ItemID AS CHAR(80))
,CAST(i.ItemID AS CHAR(80))
,CAST(d.WarehouseID AS CHAR(80))
,CAST(i.WarehouseID AS CHAR(80))
,CAST(d.WarehouseBinID AS CHAR(80))
,CAST(i.WarehouseBinID AS CHAR(80))
,CAST(d.SerialNumber AS CHAR(80))
,CAST(i.SerialNumber AS CHAR(80))
,CAST(d.Description AS CHAR(80))
,CAST(i.Description AS CHAR(80))
,CAST(d.OrderQty AS CHAR(80))
,CAST(i.OrderQty AS CHAR(80))
,CAST(d.BackOrdered AS CHAR(80))
,CAST(i.BackOrdered AS CHAR(80))
,CAST(d.BackOrderQyyty AS CHAR(80))
,CAST(i.BackOrderQyyty AS CHAR(80))
,CAST(d.ItemUOM AS CHAR(80))
,CAST(i.ItemUOM AS CHAR(80))
,CAST(d.ItemWeight AS CHAR(80))
,CAST(i.ItemWeight AS CHAR(80))
,CAST(d.DiscountPerc AS CHAR(80))
,CAST(i.DiscountPerc AS CHAR(80))
,CAST(d.Taxable AS CHAR(80))
,CAST(i.Taxable AS CHAR(80))
,CAST(d.CurrencyID AS CHAR(80))
,CAST(i.CurrencyID AS CHAR(80))
,CAST(d.CurrencyExchangeRate AS CHAR(80))
,CAST(i.CurrencyExchangeRate AS CHAR(80))
,CAST(d.ItemCost AS CHAR(80))
,CAST(i.ItemCost AS CHAR(80))
,CAST(d.ItemUnitPrice AS CHAR(80))
,CAST(i.ItemUnitPrice AS CHAR(80))
,CAST(d.Total AS CHAR(80))
,CAST(i.Total AS CHAR(80))
,CAST(d.TotalWeight AS CHAR(80))
,CAST(i.TotalWeight AS CHAR(80))
,CAST(d.GLSalesAccount AS CHAR(80))
,CAST(i.GLSalesAccount AS CHAR(80))
,CAST(d.ProjectID AS CHAR(80))
,CAST(i.ProjectID AS CHAR(80))
,CAST(d.WarehouseBinZone AS CHAR(80))
,CAST(i.WarehouseBinZone AS CHAR(80))
,CAST(d.PalletLevel AS CHAR(80))
,CAST(i.PalletLevel AS CHAR(80))
,CAST(d.CartonLevel AS CHAR(80))
,CAST(i.CartonLevel AS CHAR(80))
,CAST(d.PackLevelA AS CHAR(80))
,CAST(i.PackLevelA AS CHAR(80))
,CAST(d.PackLevelB AS CHAR(80))
,CAST(i.PackLevelB AS CHAR(80))
,CAST(d.PackLevelC AS CHAR(80))
,CAST(i.PackLevelC AS CHAR(80))
,CAST(d.TrackingNumber AS CHAR(80))
,CAST(i.TrackingNumber AS CHAR(80))
,CAST(d.DetailMemo1 AS CHAR(80))
,CAST(i.DetailMemo1 AS CHAR(80))
,CAST(d.DetailMemo2 AS CHAR(80))
,CAST(i.DetailMemo2 AS CHAR(80))
,CAST(d.DetailMemo3 AS CHAR(80))
,CAST(i.DetailMemo3 AS CHAR(80))
,CAST(d.DetailMemo4 AS CHAR(80))
,CAST(i.DetailMemo4 AS CHAR(80))
,CAST(d.DetailMemo5 AS CHAR(80))
,CAST(i.DetailMemo5 AS CHAR(80))
,CAST(d.TaxGroupID AS CHAR(80))
,CAST(i.TaxGroupID AS CHAR(80))
,CAST(d.TaxAmount AS CHAR(80))
,CAST(i.TaxAmount AS CHAR(80))
,CAST(d.TaxPercent AS CHAR(80))
,CAST(i.TaxPercent AS CHAR(80))
,CAST(d.SubTotal AS CHAR(80))
,CAST(i.SubTotal AS CHAR(80))
 

   FROM
   InsEDIOrderDetail i
   LEFT OUTER JOIN DelEDIOrderDetail d ON
   d.CompanyID = i.CompanyID
   AND d.DivisionID = i.DivisionID
   AND d.DepartmentID = i.DepartmentID
   AND d.OrderNumber = i.OrderNumber
   AND d.OrderLineNumber = i.OrderLineNumber;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET NO_DATA = -2;
   END;
   DECLARE CONTINUE HANDLER FOR NOT FOUND SET NO_DATA = -1;
   CREATE  TEMPORARY TABLE IF NOT EXISTS InsEDIOrderDetail
   (
      CompanyID NATIONAL VARCHAR(36),
      DivisionID NATIONAL VARCHAR(36),
      DepartmentID NATIONAL VARCHAR(36),
      OrderNumber NATIONAL VARCHAR(36),
      OrderLineNumber NUMERIC(18,0),
      ItemID NATIONAL VARCHAR(36),
      WarehouseID NATIONAL VARCHAR(36),
      WarehouseBinID NATIONAL VARCHAR(36),
      SerialNumber NATIONAL VARCHAR(50),
      Description NATIONAL VARCHAR(80),
      OrderQty FLOAT,
      BackOrdered BOOLEAN,
      BackOrderQyyty FLOAT,
      ItemUOM NATIONAL VARCHAR(15),
      ItemWeight FLOAT,
      DiscountPerc FLOAT,
      Taxable BOOLEAN,
      CurrencyID NATIONAL VARCHAR(3),
      CurrencyExchangeRate FLOAT,
      ItemCost DECIMAL(19,4),
      ItemUnitPrice DECIMAL(19,4),
      Total DECIMAL(19,4),
      TotalWeight FLOAT,
      GLSalesAccount NATIONAL VARCHAR(36),
      ProjectID NATIONAL VARCHAR(36),
      WarehouseBinZone NATIONAL VARCHAR(36),
      PalletLevel NATIONAL VARCHAR(36),
      CartonLevel NATIONAL VARCHAR(36),
      PackLevelA NATIONAL VARCHAR(36),
      PackLevelB NATIONAL VARCHAR(36),
      PackLevelC NATIONAL VARCHAR(36),
      TrackingNumber NATIONAL VARCHAR(50),
      DetailMemo1 NATIONAL VARCHAR(50),
      DetailMemo2 NATIONAL VARCHAR(50),
      DetailMemo3 NATIONAL VARCHAR(50),
      DetailMemo4 NATIONAL VARCHAR(50),
      DetailMemo5 NATIONAL VARCHAR(50),
      LockedBy NATIONAL VARCHAR(36),
      LockTS DATETIME,
      TaxGroupID NATIONAL VARCHAR(36),
      TaxAmount DECIMAL(19,4),
      TaxPercent FLOAT,
      SubTotal DECIMAL(19,4)
   );
   DELETE FROM InsEDIOrderDetail;
   INSERT INTO InsEDIOrderDetail VALUES(NEW.CompanyID, NEW.DivisionID, NEW.DepartmentID, NEW.OrderNumber, NEW.OrderLineNumber, NEW.ItemID, NEW.WarehouseID, NEW.WarehouseBinID, NEW.SerialNumber, NEW.Description, NEW.OrderQty, NEW.BackOrdered, NEW.BackOrderQyyty, NEW.ItemUOM, NEW.ItemWeight, NEW.DiscountPerc, NEW.Taxable, NEW.CurrencyID, NEW.CurrencyExchangeRate, NEW.ItemCost, NEW.ItemUnitPrice, NEW.Total, NEW.TotalWeight, NEW.GLSalesAccount, NEW.ProjectID, NEW.WarehouseBinZone, NEW.PalletLevel, NEW.CartonLevel, NEW.PackLevelA, NEW.PackLevelB, NEW.PackLevelC, NEW.TrackingNumber, NEW.DetailMemo1, NEW.DetailMemo2, NEW.DetailMemo3, NEW.DetailMemo4, NEW.DetailMemo5, NEW.LockedBy, NEW.LockTS, NEW.TaxGroupID, NEW.TaxAmount, NEW.TaxPercent, NEW.SubTotal);

   CREATE  TEMPORARY TABLE IF NOT EXISTS DelEDIOrderDetail
   (
      CompanyID NATIONAL VARCHAR(36),
      DivisionID NATIONAL VARCHAR(36),
      DepartmentID NATIONAL VARCHAR(36),
      OrderNumber NATIONAL VARCHAR(36),
      OrderLineNumber NUMERIC(18,0),
      ItemID NATIONAL VARCHAR(36),
      WarehouseID NATIONAL VARCHAR(36),
      WarehouseBinID NATIONAL VARCHAR(36),
      SerialNumber NATIONAL VARCHAR(50),
      Description NATIONAL VARCHAR(80),
      OrderQty FLOAT,
      BackOrdered BOOLEAN,
      BackOrderQyyty FLOAT,
      ItemUOM NATIONAL VARCHAR(15),
      ItemWeight FLOAT,
      DiscountPerc FLOAT,
      Taxable BOOLEAN,
      CurrencyID NATIONAL VARCHAR(3),
      CurrencyExchangeRate FLOAT,
      ItemCost DECIMAL(19,4),
      ItemUnitPrice DECIMAL(19,4),
      Total DECIMAL(19,4),
      TotalWeight FLOAT,
      GLSalesAccount NATIONAL VARCHAR(36),
      ProjectID NATIONAL VARCHAR(36),
      WarehouseBinZone NATIONAL VARCHAR(36),
      PalletLevel NATIONAL VARCHAR(36),
      CartonLevel NATIONAL VARCHAR(36),
      PackLevelA NATIONAL VARCHAR(36),
      PackLevelB NATIONAL VARCHAR(36),
      PackLevelC NATIONAL VARCHAR(36),
      TrackingNumber NATIONAL VARCHAR(50),
      DetailMemo1 NATIONAL VARCHAR(50),
      DetailMemo2 NATIONAL VARCHAR(50),
      DetailMemo3 NATIONAL VARCHAR(50),
      DetailMemo4 NATIONAL VARCHAR(50),
      DetailMemo5 NATIONAL VARCHAR(50),
      LockedBy NATIONAL VARCHAR(36),
      LockTS DATETIME,
      TaxGroupID NATIONAL VARCHAR(36),
      TaxAmount DECIMAL(19,4),
      TaxPercent FLOAT,
      SubTotal DECIMAL(19,4)
   );
   DELETE FROM DelEDIOrderDetail;
   INSERT INTO DelEDIOrderDetail VALUES(OLD.CompanyID, OLD.DivisionID, OLD.DepartmentID, OLD.OrderNumber, OLD.OrderLineNumber, OLD.ItemID, OLD.WarehouseID, OLD.WarehouseBinID, OLD.SerialNumber, OLD.Description, OLD.OrderQty, OLD.BackOrdered, OLD.BackOrderQyyty, OLD.ItemUOM, OLD.ItemWeight, OLD.DiscountPerc, OLD.Taxable, OLD.CurrencyID, OLD.CurrencyExchangeRate, OLD.ItemCost, OLD.ItemUnitPrice, OLD.Total, OLD.TotalWeight, OLD.GLSalesAccount, OLD.ProjectID, OLD.WarehouseBinZone, OLD.PalletLevel, OLD.CartonLevel, OLD.PackLevelA, OLD.PackLevelB, OLD.PackLevelC, OLD.TrackingNumber, OLD.DetailMemo1, OLD.DetailMemo2, OLD.DetailMemo3, OLD.DetailMemo4, OLD.DetailMemo5, OLD.LockedBy, OLD.LockTS, OLD.TaxGroupID, OLD.TaxAmount, OLD.TaxPercent, OLD.SubTotal);

   BEGIN
-- check for audit triggers switch off

      select   context_info INTO v_Context FROM sysprocesses WHERE spid = CONNECTION_ID();
      IF CAST(v_Context AS CHAR(36)) = N'$$AuditSwitchOff$$' then 
         LEAVE SWL_return;
      end if;

-- declarations
      OPEN cUpdate;
-- fetch from each updating record
      SET NO_DATA = 0;
      FETCH cUpdate INTO
      v_TransactionNumber_O,v_TransactionNumber_N,v_TransactionLineNumber,v_CompanyID,
      v_DivisionID,v_DepartmentID,v_OrderNumber,v_OrderLineNumber,
      v_ItemID_O,v_ItemID_N,v_WarehouseID_O,v_WarehouseID_N,v_WarehouseBinID_O,
      v_WarehouseBinID_N,v_SerialNumber_O,v_SerialNumber_N,v_Description_O,
      v_Description_N,v_OrderQty_O,v_OrderQty_N,v_BackOrdered_O,v_BackOrdered_N,
      v_BackOrderQyyty_O,v_BackOrderQyyty_N,v_ItemUOM_O,v_ItemUOM_N,v_ItemWeight_O,
      v_ItemWeight_N,v_DiscountPerc_O,v_DiscountPerc_N,v_Taxable_O,
      v_Taxable_N,v_CurrencyID_O,v_CurrencyID_N,v_CurrencyExchangeRate_O,
      v_CurrencyExchangeRate_N,v_ItemCost_O,v_ItemCost_N,v_ItemUnitPrice_O,
      v_ItemUnitPrice_N,v_Total_O,v_Total_N,v_TotalWeight_O,v_TotalWeight_N,
      v_GLSalesAccount_O,v_GLSalesAccount_N,v_ProjectID_O,v_ProjectID_N,v_WarehouseBinZone_O,
      v_WarehouseBinZone_N,v_PalletLevel_O,v_PalletLevel_N,
      v_CartonLevel_O,v_CartonLevel_N,v_PackLevelA_O,v_PackLevelA_N,v_PackLevelB_O,
      v_PackLevelB_N,v_PackLevelC_O,v_PackLevelC_N,v_TrackingNumber_O,
      v_TrackingNumber_N,v_DetailMemo1_O,v_DetailMemo1_N,v_DetailMemo2_O,v_DetailMemo2_N,
      v_DetailMemo3_O,v_DetailMemo3_N,v_DetailMemo4_O,v_DetailMemo4_N,
      v_DetailMemo5_O,v_DetailMemo5_N,v_TaxGroupID_O,v_TaxGroupID_N,
      v_TaxAmount_O,v_TaxAmount_N,v_TaxPercent_O,v_TaxPercent_N,v_SubTotal_O,
      v_SubTotal_N;
      WHILE NO_DATA = 0 DO
-- insert audit records for each changed field
         IF IsGuid(v_TransactionNumber_N) = 0 then
		
            IF v_TransactionNumber_O IS NULL then
				
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIOrderDetail','New Record','','New Record');
            ELSE
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIOrderDetail','ItemID',v_ItemID_O,v_ItemID_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIOrderDetail','WarehouseID',v_WarehouseID_O,v_WarehouseID_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIOrderDetail','WarehouseBinID',v_WarehouseBinID_O,
               v_WarehouseBinID_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIOrderDetail','SerialNumber',v_SerialNumber_O,
               v_SerialNumber_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIOrderDetail','Description',v_Description_O,v_Description_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIOrderDetail','OrderQty',v_OrderQty_O,v_OrderQty_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIOrderDetail','BackOrdered',v_BackOrdered_O,v_BackOrdered_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIOrderDetail','BackOrderQyyty',v_BackOrderQyyty_O,
               v_BackOrderQyyty_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIOrderDetail','ItemUOM',v_ItemUOM_O,v_ItemUOM_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIOrderDetail','ItemWeight',v_ItemWeight_O,v_ItemWeight_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIOrderDetail','DiscountPerc',v_DiscountPerc_O,
               v_DiscountPerc_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIOrderDetail','Taxable',v_Taxable_O,v_Taxable_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIOrderDetail','CurrencyID',v_CurrencyID_O,v_CurrencyID_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIOrderDetail','CurrencyExchangeRate',v_CurrencyExchangeRate_O,
               v_CurrencyExchangeRate_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIOrderDetail','ItemCost',v_ItemCost_O,v_ItemCost_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIOrderDetail','ItemUnitPrice',v_ItemUnitPrice_O,
               v_ItemUnitPrice_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIOrderDetail','Total',v_Total_O,v_Total_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIOrderDetail','TotalWeight',v_TotalWeight_O,v_TotalWeight_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIOrderDetail','GLSalesAccount',v_GLSalesAccount_O,
               v_GLSalesAccount_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIOrderDetail','ProjectID',v_ProjectID_O,v_ProjectID_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIOrderDetail','WarehouseBinZone',v_WarehouseBinZone_O,
               v_WarehouseBinZone_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIOrderDetail','PalletLevel',v_PalletLevel_O,v_PalletLevel_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIOrderDetail','CartonLevel',v_CartonLevel_O,v_CartonLevel_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIOrderDetail','PackLevelA',v_PackLevelA_O,v_PackLevelA_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIOrderDetail','PackLevelB',v_PackLevelB_O,v_PackLevelB_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIOrderDetail','PackLevelC',v_PackLevelC_O,v_PackLevelC_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIOrderDetail','TrackingNumber',v_TrackingNumber_O,
               v_TrackingNumber_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIOrderDetail','DetailMemo1',v_DetailMemo1_O,v_DetailMemo1_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIOrderDetail','DetailMemo2',v_DetailMemo2_O,v_DetailMemo2_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIOrderDetail','DetailMemo3',v_DetailMemo3_O,v_DetailMemo3_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIOrderDetail','DetailMemo4',v_DetailMemo4_O,v_DetailMemo4_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIOrderDetail','DetailMemo5',v_DetailMemo5_O,v_DetailMemo5_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIOrderDetail','TaxGroupID',v_TaxGroupID_O,v_TaxGroupID_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIOrderDetail','TaxAmount',v_TaxAmount_O,v_TaxAmount_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIOrderDetail','TaxPercent',v_TaxPercent_O,v_TaxPercent_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIOrderDetail','SubTotal',v_SubTotal_O,v_SubTotal_N);
            end if;
         end if;
         SET NO_DATA = 0;
         FETCH cUpdate INTO
         v_TransactionNumber_O,v_TransactionNumber_N,v_TransactionLineNumber,v_CompanyID,
         v_DivisionID,v_DepartmentID,v_OrderNumber,v_OrderLineNumber,
         v_ItemID_O,v_ItemID_N,v_WarehouseID_O,v_WarehouseID_N,v_WarehouseBinID_O,
         v_WarehouseBinID_N,v_SerialNumber_O,v_SerialNumber_N,v_Description_O,
         v_Description_N,v_OrderQty_O,v_OrderQty_N,v_BackOrdered_O,v_BackOrdered_N,
         v_BackOrderQyyty_O,v_BackOrderQyyty_N,v_ItemUOM_O,v_ItemUOM_N,v_ItemWeight_O,
         v_ItemWeight_N,v_DiscountPerc_O,v_DiscountPerc_N,v_Taxable_O,
         v_Taxable_N,v_CurrencyID_O,v_CurrencyID_N,v_CurrencyExchangeRate_O,
         v_CurrencyExchangeRate_N,v_ItemCost_O,v_ItemCost_N,v_ItemUnitPrice_O,
         v_ItemUnitPrice_N,v_Total_O,v_Total_N,v_TotalWeight_O,v_TotalWeight_N,
         v_GLSalesAccount_O,v_GLSalesAccount_N,v_ProjectID_O,v_ProjectID_N,v_WarehouseBinZone_O,
         v_WarehouseBinZone_N,v_PalletLevel_O,v_PalletLevel_N,
         v_CartonLevel_O,v_CartonLevel_N,v_PackLevelA_O,v_PackLevelA_N,v_PackLevelB_O,
         v_PackLevelB_N,v_PackLevelC_O,v_PackLevelC_N,v_TrackingNumber_O,
         v_TrackingNumber_N,v_DetailMemo1_O,v_DetailMemo1_N,v_DetailMemo2_O,v_DetailMemo2_N,
         v_DetailMemo3_O,v_DetailMemo3_N,v_DetailMemo4_O,v_DetailMemo4_N,
         v_DetailMemo5_O,v_DetailMemo5_N,v_TaxGroupID_O,v_TaxGroupID_N,
         v_TaxAmount_O,v_TaxAmount_N,v_TaxPercent_O,v_TaxPercent_N,v_SubTotal_O,
         v_SubTotal_N;
      END WHILE;
      CLOSE cUpdate;

   END;
END;
 ;;
delimiter ;
delimiter ;;
CREATE TRIGGER `EDIOrderDetail_Audit_Delete` AFTER DELETE ON `ediorderdetail` FOR EACH ROW SWL_return:
BEGIN
   DECLARE NO_DATA INT DEFAULT 0;
   DECLARE v_Context VARBINARY(128);
   DECLARE v_TransactionNumber NATIONAL VARCHAR(50);
   DECLARE v_TransactionLineNumber NATIONAL VARCHAR(50);

   DECLARE v_CompanyID NATIONAL VARCHAR(36);
   DECLARE v_DivisionID NATIONAL VARCHAR(36);
   DECLARE v_DepartmentID NATIONAL VARCHAR(36);
   DECLARE v_OrderNumber NATIONAL VARCHAR(36);
   DECLARE v_OrderLineNumber NUMERIC(18,0);

-- deleting records cursor declaration
   DECLARE cDelete CURSOR
   FOR SELECT
   d.OrderNumber
		,d.OrderLineNumber

		,d.CompanyID
		,d.DivisionID
		,d.DepartmentID
		,d.OrderNumber
		,d.OrderLineNumber

   FROM
   DelEDIOrderDetail d;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET NO_DATA = -2;
   END;
   DECLARE CONTINUE HANDLER FOR NOT FOUND SET NO_DATA = -1;
   CREATE  TEMPORARY TABLE IF NOT EXISTS DelEDIOrderDetail
   (
      CompanyID NATIONAL VARCHAR(36),
      DivisionID NATIONAL VARCHAR(36),
      DepartmentID NATIONAL VARCHAR(36),
      OrderNumber NATIONAL VARCHAR(36),
      OrderLineNumber NUMERIC(18,0),
      ItemID NATIONAL VARCHAR(36),
      WarehouseID NATIONAL VARCHAR(36),
      WarehouseBinID NATIONAL VARCHAR(36),
      SerialNumber NATIONAL VARCHAR(50),
      Description NATIONAL VARCHAR(80),
      OrderQty FLOAT,
      BackOrdered BOOLEAN,
      BackOrderQyyty FLOAT,
      ItemUOM NATIONAL VARCHAR(15),
      ItemWeight FLOAT,
      DiscountPerc FLOAT,
      Taxable BOOLEAN,
      CurrencyID NATIONAL VARCHAR(3),
      CurrencyExchangeRate FLOAT,
      ItemCost DECIMAL(19,4),
      ItemUnitPrice DECIMAL(19,4),
      Total DECIMAL(19,4),
      TotalWeight FLOAT,
      GLSalesAccount NATIONAL VARCHAR(36),
      ProjectID NATIONAL VARCHAR(36),
      WarehouseBinZone NATIONAL VARCHAR(36),
      PalletLevel NATIONAL VARCHAR(36),
      CartonLevel NATIONAL VARCHAR(36),
      PackLevelA NATIONAL VARCHAR(36),
      PackLevelB NATIONAL VARCHAR(36),
      PackLevelC NATIONAL VARCHAR(36),
      TrackingNumber NATIONAL VARCHAR(50),
      DetailMemo1 NATIONAL VARCHAR(50),
      DetailMemo2 NATIONAL VARCHAR(50),
      DetailMemo3 NATIONAL VARCHAR(50),
      DetailMemo4 NATIONAL VARCHAR(50),
      DetailMemo5 NATIONAL VARCHAR(50),
      LockedBy NATIONAL VARCHAR(36),
      LockTS DATETIME,
      TaxGroupID NATIONAL VARCHAR(36),
      TaxAmount DECIMAL(19,4),
      TaxPercent FLOAT,
      SubTotal DECIMAL(19,4)
   );
   DELETE FROM DelEDIOrderDetail;
   INSERT INTO DelEDIOrderDetail VALUES(OLD.CompanyID, OLD.DivisionID, OLD.DepartmentID, OLD.OrderNumber, OLD.OrderLineNumber, OLD.ItemID, OLD.WarehouseID, OLD.WarehouseBinID, OLD.SerialNumber, OLD.Description, OLD.OrderQty, OLD.BackOrdered, OLD.BackOrderQyyty, OLD.ItemUOM, OLD.ItemWeight, OLD.DiscountPerc, OLD.Taxable, OLD.CurrencyID, OLD.CurrencyExchangeRate, OLD.ItemCost, OLD.ItemUnitPrice, OLD.Total, OLD.TotalWeight, OLD.GLSalesAccount, OLD.ProjectID, OLD.WarehouseBinZone, OLD.PalletLevel, OLD.CartonLevel, OLD.PackLevelA, OLD.PackLevelB, OLD.PackLevelC, OLD.TrackingNumber, OLD.DetailMemo1, OLD.DetailMemo2, OLD.DetailMemo3, OLD.DetailMemo4, OLD.DetailMemo5, OLD.LockedBy, OLD.LockTS, OLD.TaxGroupID, OLD.TaxAmount, OLD.TaxPercent, OLD.SubTotal);

   BEGIN
-- check for audit triggers switch off

      select   context_info INTO v_Context FROM sysprocesses WHERE spid = CONNECTION_ID();
      IF CAST(v_Context AS CHAR(36)) = N'$$AuditSwitchOff$$' then 
         LEAVE SWL_return;
      end if;

-- declarations
      OPEN cDelete;
-- fetch from each deleting record
      SET NO_DATA = 0;
      FETCH cDelete INTO
      v_TransactionNumber,v_TransactionLineNumber,v_CompanyID,v_DivisionID,v_DepartmentID,
      v_OrderNumber,v_OrderLineNumber;
      WHILE NO_DATA = 0 DO
-- insert audit record for each deleting record
         CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber,v_TransactionLineNumber,
         'EDIOrderDetail','Deleted','','Deleted');
         SET NO_DATA = 0;
         FETCH cDelete INTO
         v_TransactionNumber,v_TransactionLineNumber,v_CompanyID,v_DivisionID,v_DepartmentID,
         v_OrderNumber,v_OrderLineNumber;
      END WHILE;
      CLOSE cDelete;

   END;
END;
 ;;
delimiter ;

-- ----------------------------
--  Table structure for `ediorderheader`
-- ----------------------------
DROP TABLE IF EXISTS `ediorderheader`;
CREATE TABLE `ediorderheader` (
  `CompanyID` varchar(36) NOT NULL,
  `DivisionID` varchar(36) NOT NULL,
  `DepartmentID` varchar(36) NOT NULL,
  `OrderNumber` varchar(36) NOT NULL,
  `TransactionTypeID` varchar(36) DEFAULT NULL,
  `EDIDirectionTypeID` varchar(1) DEFAULT NULL,
  `EDIDocumentTypeID` varchar(3) DEFAULT NULL,
  `EDIOpen` tinyint(1) DEFAULT NULL,
  `OrderTypeID` varchar(36) DEFAULT NULL,
  `OrderDate` datetime DEFAULT NULL,
  `OrderDueDate` datetime DEFAULT NULL,
  `OrderShipDate` datetime DEFAULT NULL,
  `OrderCancelDate` datetime DEFAULT NULL,
  `PurchaseOrderNumber` varchar(36) DEFAULT NULL,
  `TaxExemptID` varchar(36) DEFAULT NULL,
  `TaxGroupID` varchar(36) DEFAULT NULL,
  `CustomerID` varchar(50) DEFAULT NULL,
  `CustomerShipToID` varchar(36) DEFAULT NULL,
  `CustomerShipForID` varchar(36) DEFAULT NULL,
  `WarehouseID` varchar(36) DEFAULT NULL,
  `CustomerDropShipment` tinyint(1) DEFAULT NULL,
  `ShippingName` varchar(50) DEFAULT NULL,
  `ShippingAddress1` varchar(50) DEFAULT NULL,
  `ShippingAddress2` varchar(50) DEFAULT NULL,
  `ShippingCity` varchar(50) DEFAULT NULL,
  `ShippingState` varchar(50) DEFAULT NULL,
  `ShippingZip` varchar(10) DEFAULT NULL,
  `ShippingCountry` varchar(50) DEFAULT NULL,
  `ShipMethodID` varchar(36) DEFAULT NULL,
  `EmployeeID` varchar(36) DEFAULT NULL,
  `TermsID` varchar(36) DEFAULT NULL,
  `PaymentMethodID` varchar(36) DEFAULT NULL,
  `CurrencyID` varchar(3) DEFAULT NULL,
  `CurrencyExchangeRate` float DEFAULT NULL,
  `Subtotal` decimal(19,4) DEFAULT NULL,
  `DiscountPers` float DEFAULT NULL,
  `DiscountAmount` decimal(19,4) DEFAULT NULL,
  `TaxPercent` float DEFAULT NULL,
  `TaxAmount` decimal(19,4) DEFAULT NULL,
  `TaxableSubTotal` decimal(19,4) DEFAULT NULL,
  `Freight` decimal(19,4) DEFAULT NULL,
  `TaxFreight` tinyint(1) DEFAULT NULL,
  `Handling` decimal(19,4) DEFAULT NULL,
  `Advertising` decimal(19,4) DEFAULT NULL,
  `Total` decimal(19,4) DEFAULT NULL,
  `AmountPaid` decimal(19,4) DEFAULT NULL,
  `BalanceDue` decimal(19,4) DEFAULT NULL,
  `UndistributedAmount` decimal(19,4) DEFAULT NULL,
  `Commission` decimal(19,4) DEFAULT NULL,
  `CommissionableSales` decimal(19,4) DEFAULT NULL,
  `ComissionalbleCost` decimal(19,4) DEFAULT NULL,
  `GLSalesAccount` varchar(36) DEFAULT NULL,
  `CheckNumber` varchar(20) DEFAULT NULL,
  `CheckDate` datetime DEFAULT NULL,
  `CreditCardTypeID` varchar(15) DEFAULT NULL,
  `CreditCardName` varchar(50) DEFAULT NULL,
  `CreditCardNumber` varchar(50) DEFAULT NULL,
  `CreditCardExpDate` datetime DEFAULT NULL,
  `CreditCardCSVNumber` varchar(5) DEFAULT NULL,
  `CreditCardBillToZip` varchar(10) DEFAULT NULL,
  `CreditCardValidationCode` varchar(20) DEFAULT NULL,
  `CreditCardApprovalNumber` varchar(20) DEFAULT NULL,
  `Picked` tinyint(1) DEFAULT NULL,
  `PickedDate` datetime DEFAULT NULL,
  `Billed` tinyint(1) DEFAULT NULL,
  `BilledDate` datetime DEFAULT NULL,
  `Printed` tinyint(1) DEFAULT NULL,
  `PrintedDate` datetime DEFAULT NULL,
  `Shipped` tinyint(1) DEFAULT NULL,
  `ShipDate` datetime DEFAULT NULL,
  `TrackingNumber` varchar(50) DEFAULT NULL,
  `Backordered` tinyint(1) DEFAULT NULL,
  `Invoiced` tinyint(1) DEFAULT NULL,
  `InvoiceNumber` varchar(20) DEFAULT NULL,
  `InvoiceDate` datetime DEFAULT NULL,
  `Posted` tinyint(1) DEFAULT NULL,
  `PostedDate` datetime DEFAULT NULL,
  `MasterBillOfLading` varchar(36) DEFAULT NULL,
  `MasterBillOfLadingDate` datetime DEFAULT NULL,
  `TrailerNumber` varchar(36) DEFAULT NULL,
  `TrailerPrefix` varchar(36) DEFAULT NULL,
  `HeaderMemo1` varchar(50) DEFAULT NULL,
  `HeaderMemo2` varchar(50) DEFAULT NULL,
  `HeaderMemo3` varchar(50) DEFAULT NULL,
  `HeaderMemo4` varchar(50) DEFAULT NULL,
  `HeaderMemo5` varchar(50) DEFAULT NULL,
  `HeaderMemo6` varchar(50) DEFAULT NULL,
  `HeaderMemo7` varchar(50) DEFAULT NULL,
  `HeaderMemo8` varchar(50) DEFAULT NULL,
  `HeaderMemo9` varchar(50) DEFAULT NULL,
  `LockedBy` varchar(36) DEFAULT NULL,
  `LockTS` datetime DEFAULT NULL,
  `AllowanceDiscountPerc` float DEFAULT NULL,
  PRIMARY KEY (`CompanyID`,`DivisionID`,`DepartmentID`,`OrderNumber`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
delimiter ;;
CREATE TRIGGER `EDIOrderHeader_Audit_Insert` AFTER INSERT ON `ediorderheader` FOR EACH ROW SWL_return:
BEGIN
   DECLARE NO_DATA INT DEFAULT 0;
   DECLARE v_Context VARBINARY(128);
   DECLARE v_TransactionNumber NATIONAL VARCHAR(50);
   DECLARE v_TransactionLineNumber NATIONAL VARCHAR(50);

   DECLARE v_CompanyID NATIONAL VARCHAR(36);
   DECLARE v_DivisionID NATIONAL VARCHAR(36);
   DECLARE v_DepartmentID NATIONAL VARCHAR(36);
   DECLARE v_OrderNumber NATIONAL VARCHAR(36);

-- inserting records cursor declaration
   DECLARE cInsert CURSOR
   FOR SELECT
   i.OrderNumber
		,''

		,i.CompanyID
		,i.DivisionID
		,i.DepartmentID
		,i.OrderNumber

   FROM
   InsEDIOrderHeader i;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET NO_DATA = -2;
   END;
   DECLARE CONTINUE HANDLER FOR NOT FOUND SET NO_DATA = -1;
   CREATE  TEMPORARY TABLE IF NOT EXISTS InsEDIOrderHeader
   (
      CompanyID NATIONAL VARCHAR(36),
      DivisionID NATIONAL VARCHAR(36),
      DepartmentID NATIONAL VARCHAR(36),
      OrderNumber NATIONAL VARCHAR(36),
      TransactionTypeID NATIONAL VARCHAR(36),
      EDIDirectionTypeID NATIONAL VARCHAR(1),
      EDIDocumentTypeID NATIONAL VARCHAR(3),
      EDIOpen BOOLEAN,
      OrderTypeID NATIONAL VARCHAR(36),
      OrderDate DATETIME,
      OrderDueDate DATETIME,
      OrderShipDate DATETIME,
      OrderCancelDate DATETIME,
      PurchaseOrderNumber NATIONAL VARCHAR(36),
      TaxExemptID NATIONAL VARCHAR(36),
      TaxGroupID NATIONAL VARCHAR(36),
      CustomerID NATIONAL VARCHAR(50),
      CustomerShipToID NATIONAL VARCHAR(36),
      CustomerShipForID NATIONAL VARCHAR(36),
      WarehouseID NATIONAL VARCHAR(36),
      CustomerDropShipment BOOLEAN,
      ShippingName NATIONAL VARCHAR(50),
      ShippingAddress1 NATIONAL VARCHAR(50),
      ShippingAddress2 NATIONAL VARCHAR(50),
      ShippingCity NATIONAL VARCHAR(50),
      ShippingState NATIONAL VARCHAR(50),
      ShippingZip NATIONAL VARCHAR(10),
      ShippingCountry NATIONAL VARCHAR(50),
      ShipMethodID NATIONAL VARCHAR(36),
      EmployeeID NATIONAL VARCHAR(36),
      TermsID NATIONAL VARCHAR(36),
      PaymentMethodID NATIONAL VARCHAR(36),
      CurrencyID NATIONAL VARCHAR(3),
      CurrencyExchangeRate FLOAT,
      Subtotal DECIMAL(19,4),
      DiscountPers FLOAT,
      DiscountAmount DECIMAL(19,4),
      TaxPercent FLOAT,
      TaxAmount DECIMAL(19,4),
      TaxableSubTotal DECIMAL(19,4),
      Freight DECIMAL(19,4),
      TaxFreight BOOLEAN,
      Handling DECIMAL(19,4),
      Advertising DECIMAL(19,4),
      Total DECIMAL(19,4),
      AmountPaid DECIMAL(19,4),
      BalanceDue DECIMAL(19,4),
      UndistributedAmount DECIMAL(19,4),
      Commission DECIMAL(19,4),
      CommissionableSales DECIMAL(19,4),
      ComissionalbleCost DECIMAL(19,4),
      GLSalesAccount NATIONAL VARCHAR(36),
      CheckNumber NATIONAL VARCHAR(20),
      CheckDate DATETIME,
      CreditCardTypeID NATIONAL VARCHAR(15),
      CreditCardName NATIONAL VARCHAR(50),
      CreditCardNumber NATIONAL VARCHAR(50),
      CreditCardExpDate DATETIME,
      CreditCardCSVNumber NATIONAL VARCHAR(5),
      CreditCardBillToZip NATIONAL VARCHAR(10),
      CreditCardValidationCode NATIONAL VARCHAR(20),
      CreditCardApprovalNumber NATIONAL VARCHAR(20),
      Picked BOOLEAN,
      PickedDate DATETIME,
      Billed BOOLEAN,
      BilledDate DATETIME,
      Printed BOOLEAN,
      PrintedDate DATETIME,
      Shipped BOOLEAN,
      ShipDate DATETIME,
      TrackingNumber NATIONAL VARCHAR(50),
      Backordered BOOLEAN,
      Invoiced BOOLEAN,
      InvoiceNumber NATIONAL VARCHAR(20),
      InvoiceDate DATETIME,
      Posted BOOLEAN,
      PostedDate DATETIME,
      MasterBillOfLading NATIONAL VARCHAR(36),
      MasterBillOfLadingDate DATETIME,
      TrailerNumber NATIONAL VARCHAR(36),
      TrailerPrefix NATIONAL VARCHAR(36),
      HeaderMemo1 NATIONAL VARCHAR(50),
      HeaderMemo2 NATIONAL VARCHAR(50),
      HeaderMemo3 NATIONAL VARCHAR(50),
      HeaderMemo4 NATIONAL VARCHAR(50),
      HeaderMemo5 NATIONAL VARCHAR(50),
      HeaderMemo6 NATIONAL VARCHAR(50),
      HeaderMemo7 NATIONAL VARCHAR(50),
      HeaderMemo8 NATIONAL VARCHAR(50),
      HeaderMemo9 NATIONAL VARCHAR(50),
      LockedBy NATIONAL VARCHAR(36),
      LockTS DATETIME,
      AllowanceDiscountPerc FLOAT
   );
   DELETE FROM InsEDIOrderHeader;
   INSERT INTO InsEDIOrderHeader VALUES(NEW.CompanyID, NEW.DivisionID, NEW.DepartmentID, NEW.OrderNumber, NEW.TransactionTypeID, NEW.EDIDirectionTypeID, NEW.EDIDocumentTypeID, NEW.EDIOpen, NEW.OrderTypeID, NEW.OrderDate, NEW.OrderDueDate, NEW.OrderShipDate, NEW.OrderCancelDate, NEW.PurchaseOrderNumber, NEW.TaxExemptID, NEW.TaxGroupID, NEW.CustomerID, NEW.CustomerShipToID, NEW.CustomerShipForID, NEW.WarehouseID, NEW.CustomerDropShipment, NEW.ShippingName, NEW.ShippingAddress1, NEW.ShippingAddress2, NEW.ShippingCity, NEW.ShippingState, NEW.ShippingZip, NEW.ShippingCountry, NEW.ShipMethodID, NEW.EmployeeID, NEW.TermsID, NEW.PaymentMethodID, NEW.CurrencyID, NEW.CurrencyExchangeRate, NEW.Subtotal, NEW.DiscountPers, NEW.DiscountAmount, NEW.TaxPercent, NEW.TaxAmount, NEW.TaxableSubTotal, NEW.Freight, NEW.TaxFreight, NEW.Handling, NEW.Advertising, NEW.Total, NEW.AmountPaid, NEW.BalanceDue, NEW.UndistributedAmount, NEW.Commission, NEW.CommissionableSales, NEW.ComissionalbleCost, NEW.GLSalesAccount, NEW.CheckNumber, NEW.CheckDate, NEW.CreditCardTypeID, NEW.CreditCardName, NEW.CreditCardNumber, NEW.CreditCardExpDate, NEW.CreditCardCSVNumber, NEW.CreditCardBillToZip, NEW.CreditCardValidationCode, NEW.CreditCardApprovalNumber, NEW.Picked, NEW.PickedDate, NEW.Billed, NEW.BilledDate, NEW.Printed, NEW.PrintedDate, NEW.Shipped, NEW.ShipDate, NEW.TrackingNumber, NEW.Backordered, NEW.Invoiced, NEW.InvoiceNumber, NEW.InvoiceDate, NEW.Posted, NEW.PostedDate, NEW.MasterBillOfLading, NEW.MasterBillOfLadingDate, NEW.TrailerNumber, NEW.TrailerPrefix, NEW.HeaderMemo1, NEW.HeaderMemo2, NEW.HeaderMemo3, NEW.HeaderMemo4, NEW.HeaderMemo5, NEW.HeaderMemo6, NEW.HeaderMemo7, NEW.HeaderMemo8, NEW.HeaderMemo9, NEW.LockedBy, NEW.LockTS, NEW.AllowanceDiscountPerc);

   BEGIN
-- check for audit triggers switch off

      select   context_info INTO v_Context FROM sysprocesses WHERE spid = CONNECTION_ID();
      IF CAST(v_Context AS CHAR(36)) = N'$$AuditSwitchOff$$' then 
         LEAVE SWL_return;
      end if;

-- declarations
      OPEN cInsert;
-- fetch from each inserting record
      SET NO_DATA = 0;
      FETCH cInsert INTO
      v_TransactionNumber,v_TransactionLineNumber,v_CompanyID,v_DivisionID,v_DepartmentID,
      v_OrderNumber;
      WHILE NO_DATA = 0 DO
-- insert audit record for each inserting record
         IF IsGuid(v_TransactionNumber) = 0 then
		
            CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber,v_TransactionLineNumber,
            'EDIOrderHeader','New Record','','New Record');
         end if;
         SET NO_DATA = 0;
         FETCH cInsert INTO
         v_TransactionNumber,v_TransactionLineNumber,v_CompanyID,v_DivisionID,v_DepartmentID,
         v_OrderNumber;
      END WHILE;
      CLOSE cInsert;

   END;
END;
 ;;
delimiter ;
delimiter ;;
CREATE TRIGGER `EDIOrderHeader_Audit_Update` AFTER UPDATE ON `ediorderheader` FOR EACH ROW SWL_return:
BEGIN
   DECLARE NO_DATA INT DEFAULT 0;
   DECLARE v_Context VARBINARY(128);
   DECLARE v_TransactionNumber_O NATIONAL VARCHAR(50);
   DECLARE v_TransactionNumber_N NATIONAL VARCHAR(50);
   DECLARE v_TransactionLineNumber NATIONAL VARCHAR(50);

   DECLARE v_CompanyID NATIONAL VARCHAR(36);
   DECLARE v_DivisionID NATIONAL VARCHAR(36);
   DECLARE v_DepartmentID NATIONAL VARCHAR(36);
   DECLARE v_OrderNumber NATIONAL VARCHAR(36);

   DECLARE v_TransactionTypeID_O NATIONAL VARCHAR(80);
   DECLARE v_TransactionTypeID_N NATIONAL VARCHAR(80);
   DECLARE v_EDIDirectionTypeID_O NATIONAL VARCHAR(80);
   DECLARE v_EDIDirectionTypeID_N NATIONAL VARCHAR(80);
   DECLARE v_EDIDocumentTypeID_O NATIONAL VARCHAR(80);
   DECLARE v_EDIDocumentTypeID_N NATIONAL VARCHAR(80);
   DECLARE v_EDIOpen_O NATIONAL VARCHAR(80);
   DECLARE v_EDIOpen_N NATIONAL VARCHAR(80);
   DECLARE v_OrderTypeID_O NATIONAL VARCHAR(80);
   DECLARE v_OrderTypeID_N NATIONAL VARCHAR(80);
   DECLARE v_OrderDate_O NATIONAL VARCHAR(80);
   DECLARE v_OrderDate_N NATIONAL VARCHAR(80);
   DECLARE v_OrderDueDate_O NATIONAL VARCHAR(80);
   DECLARE v_OrderDueDate_N NATIONAL VARCHAR(80);
   DECLARE v_OrderShipDate_O NATIONAL VARCHAR(80);
   DECLARE v_OrderShipDate_N NATIONAL VARCHAR(80);
   DECLARE v_OrderCancelDate_O NATIONAL VARCHAR(80);
   DECLARE v_OrderCancelDate_N NATIONAL VARCHAR(80);
   DECLARE v_PurchaseOrderNumber_O NATIONAL VARCHAR(80);
   DECLARE v_PurchaseOrderNumber_N NATIONAL VARCHAR(80);
   DECLARE v_TaxExemptID_O NATIONAL VARCHAR(80);
   DECLARE v_TaxExemptID_N NATIONAL VARCHAR(80);
   DECLARE v_TaxGroupID_O NATIONAL VARCHAR(80);
   DECLARE v_TaxGroupID_N NATIONAL VARCHAR(80);
   DECLARE v_CustomerID_O NATIONAL VARCHAR(80);
   DECLARE v_CustomerID_N NATIONAL VARCHAR(80);
   DECLARE v_CustomerShipToID_O NATIONAL VARCHAR(80);
   DECLARE v_CustomerShipToID_N NATIONAL VARCHAR(80);
   DECLARE v_CustomerShipForID_O NATIONAL VARCHAR(80);
   DECLARE v_CustomerShipForID_N NATIONAL VARCHAR(80);
   DECLARE v_WarehouseID_O NATIONAL VARCHAR(80);
   DECLARE v_WarehouseID_N NATIONAL VARCHAR(80);
   DECLARE v_CustomerDropShipment_O NATIONAL VARCHAR(80);
   DECLARE v_CustomerDropShipment_N NATIONAL VARCHAR(80);
   DECLARE v_ShippingName_O NATIONAL VARCHAR(80);
   DECLARE v_ShippingName_N NATIONAL VARCHAR(80);
   DECLARE v_ShippingAddress1_O NATIONAL VARCHAR(80);
   DECLARE v_ShippingAddress1_N NATIONAL VARCHAR(80);
   DECLARE v_ShippingAddress2_O NATIONAL VARCHAR(80);
   DECLARE v_ShippingAddress2_N NATIONAL VARCHAR(80);
   DECLARE v_ShippingCity_O NATIONAL VARCHAR(80);
   DECLARE v_ShippingCity_N NATIONAL VARCHAR(80);
   DECLARE v_ShippingState_O NATIONAL VARCHAR(80);
   DECLARE v_ShippingState_N NATIONAL VARCHAR(80);
   DECLARE v_ShippingZip_O NATIONAL VARCHAR(80);
   DECLARE v_ShippingZip_N NATIONAL VARCHAR(80);
   DECLARE v_ShippingCountry_O NATIONAL VARCHAR(80);
   DECLARE v_ShippingCountry_N NATIONAL VARCHAR(80);
   DECLARE v_ShipMethodID_O NATIONAL VARCHAR(80);
   DECLARE v_ShipMethodID_N NATIONAL VARCHAR(80);
   DECLARE v_EmployeeID_O NATIONAL VARCHAR(80);
   DECLARE v_EmployeeID_N NATIONAL VARCHAR(80);
   DECLARE v_TermsID_O NATIONAL VARCHAR(80);
   DECLARE v_TermsID_N NATIONAL VARCHAR(80);
   DECLARE v_PaymentMethodID_O NATIONAL VARCHAR(80);
   DECLARE v_PaymentMethodID_N NATIONAL VARCHAR(80);
   DECLARE v_CurrencyID_O NATIONAL VARCHAR(80);
   DECLARE v_CurrencyID_N NATIONAL VARCHAR(80);
   DECLARE v_CurrencyExchangeRate_O NATIONAL VARCHAR(80);
   DECLARE v_CurrencyExchangeRate_N NATIONAL VARCHAR(80);
   DECLARE v_Subtotal_O NATIONAL VARCHAR(80);
   DECLARE v_Subtotal_N NATIONAL VARCHAR(80);
   DECLARE v_DiscountPers_O NATIONAL VARCHAR(80);
   DECLARE v_DiscountPers_N NATIONAL VARCHAR(80);
   DECLARE v_DiscountAmount_O NATIONAL VARCHAR(80);
   DECLARE v_DiscountAmount_N NATIONAL VARCHAR(80);
   DECLARE v_TaxPercent_O NATIONAL VARCHAR(80);
   DECLARE v_TaxPercent_N NATIONAL VARCHAR(80);
   DECLARE v_TaxAmount_O NATIONAL VARCHAR(80);
   DECLARE v_TaxAmount_N NATIONAL VARCHAR(80);
   DECLARE v_TaxableSubTotal_O NATIONAL VARCHAR(80);
   DECLARE v_TaxableSubTotal_N NATIONAL VARCHAR(80);
   DECLARE v_Freight_O NATIONAL VARCHAR(80);
   DECLARE v_Freight_N NATIONAL VARCHAR(80);
   DECLARE v_TaxFreight_O NATIONAL VARCHAR(80);
   DECLARE v_TaxFreight_N NATIONAL VARCHAR(80);
   DECLARE v_Handling_O NATIONAL VARCHAR(80);
   DECLARE v_Handling_N NATIONAL VARCHAR(80);
   DECLARE v_Advertising_O NATIONAL VARCHAR(80);
   DECLARE v_Advertising_N NATIONAL VARCHAR(80);
   DECLARE v_Total_O NATIONAL VARCHAR(80);
   DECLARE v_Total_N NATIONAL VARCHAR(80);
   DECLARE v_AmountPaid_O NATIONAL VARCHAR(80);
   DECLARE v_AmountPaid_N NATIONAL VARCHAR(80);
   DECLARE v_BalanceDue_O NATIONAL VARCHAR(80);
   DECLARE v_BalanceDue_N NATIONAL VARCHAR(80);
   DECLARE v_UndistributedAmount_O NATIONAL VARCHAR(80);
   DECLARE v_UndistributedAmount_N NATIONAL VARCHAR(80);
   DECLARE v_Commission_O NATIONAL VARCHAR(80);
   DECLARE v_Commission_N NATIONAL VARCHAR(80);
   DECLARE v_CommissionableSales_O NATIONAL VARCHAR(80);
   DECLARE v_CommissionableSales_N NATIONAL VARCHAR(80);
   DECLARE v_ComissionalbleCost_O NATIONAL VARCHAR(80);
   DECLARE v_ComissionalbleCost_N NATIONAL VARCHAR(80);
   DECLARE v_GLSalesAccount_O NATIONAL VARCHAR(80);
   DECLARE v_GLSalesAccount_N NATIONAL VARCHAR(80);
   DECLARE v_CheckNumber_O NATIONAL VARCHAR(80);
   DECLARE v_CheckNumber_N NATIONAL VARCHAR(80);
   DECLARE v_CheckDate_O NATIONAL VARCHAR(80);
   DECLARE v_CheckDate_N NATIONAL VARCHAR(80);
   DECLARE v_CreditCardTypeID_O NATIONAL VARCHAR(80);
   DECLARE v_CreditCardTypeID_N NATIONAL VARCHAR(80);
   DECLARE v_CreditCardName_O NATIONAL VARCHAR(80);
   DECLARE v_CreditCardName_N NATIONAL VARCHAR(80);
   DECLARE v_CreditCardNumber_O NATIONAL VARCHAR(80);
   DECLARE v_CreditCardNumber_N NATIONAL VARCHAR(80);
   DECLARE v_CreditCardExpDate_O NATIONAL VARCHAR(80);
   DECLARE v_CreditCardExpDate_N NATIONAL VARCHAR(80);
   DECLARE v_CreditCardCSVNumber_O NATIONAL VARCHAR(80);
   DECLARE v_CreditCardCSVNumber_N NATIONAL VARCHAR(80);
   DECLARE v_CreditCardBillToZip_O NATIONAL VARCHAR(80);
   DECLARE v_CreditCardBillToZip_N NATIONAL VARCHAR(80);
   DECLARE v_CreditCardValidationCode_O NATIONAL VARCHAR(80);
   DECLARE v_CreditCardValidationCode_N NATIONAL VARCHAR(80);
   DECLARE v_CreditCardApprovalNumber_O NATIONAL VARCHAR(80);
   DECLARE v_CreditCardApprovalNumber_N NATIONAL VARCHAR(80);
   DECLARE v_Picked_O NATIONAL VARCHAR(80);
   DECLARE v_Picked_N NATIONAL VARCHAR(80);
   DECLARE v_PickedDate_O NATIONAL VARCHAR(80);
   DECLARE v_PickedDate_N NATIONAL VARCHAR(80);
   DECLARE v_Billed_O NATIONAL VARCHAR(80);
   DECLARE v_Billed_N NATIONAL VARCHAR(80);
   DECLARE v_BilledDate_O NATIONAL VARCHAR(80);
   DECLARE v_BilledDate_N NATIONAL VARCHAR(80);
   DECLARE v_Printed_O NATIONAL VARCHAR(80);
   DECLARE v_Printed_N NATIONAL VARCHAR(80);
   DECLARE v_PrintedDate_O NATIONAL VARCHAR(80);
   DECLARE v_PrintedDate_N NATIONAL VARCHAR(80);
   DECLARE v_Shipped_O NATIONAL VARCHAR(80);
   DECLARE v_Shipped_N NATIONAL VARCHAR(80);
   DECLARE v_ShipDate_O NATIONAL VARCHAR(80);
   DECLARE v_ShipDate_N NATIONAL VARCHAR(80);
   DECLARE v_TrackingNumber_O NATIONAL VARCHAR(80);
   DECLARE v_TrackingNumber_N NATIONAL VARCHAR(80);
   DECLARE v_Backordered_O NATIONAL VARCHAR(80);
   DECLARE v_Backordered_N NATIONAL VARCHAR(80);
   DECLARE v_Invoiced_O NATIONAL VARCHAR(80);
   DECLARE v_Invoiced_N NATIONAL VARCHAR(80);
   DECLARE v_InvoiceNumber_O NATIONAL VARCHAR(80);
   DECLARE v_InvoiceNumber_N NATIONAL VARCHAR(80);
   DECLARE v_InvoiceDate_O NATIONAL VARCHAR(80);
   DECLARE v_InvoiceDate_N NATIONAL VARCHAR(80);
   DECLARE v_Posted_O NATIONAL VARCHAR(80);
   DECLARE v_Posted_N NATIONAL VARCHAR(80);
   DECLARE v_PostedDate_O NATIONAL VARCHAR(80);
   DECLARE v_PostedDate_N NATIONAL VARCHAR(80);
   DECLARE v_MasterBillOfLading_O NATIONAL VARCHAR(80);
   DECLARE v_MasterBillOfLading_N NATIONAL VARCHAR(80);
   DECLARE v_MasterBillOfLadingDate_O NATIONAL VARCHAR(80);
   DECLARE v_MasterBillOfLadingDate_N NATIONAL VARCHAR(80);
   DECLARE v_TrailerNumber_O NATIONAL VARCHAR(80);
   DECLARE v_TrailerNumber_N NATIONAL VARCHAR(80);
   DECLARE v_TrailerPrefix_O NATIONAL VARCHAR(80);
   DECLARE v_TrailerPrefix_N NATIONAL VARCHAR(80);
   DECLARE v_HeaderMemo1_O NATIONAL VARCHAR(80);
   DECLARE v_HeaderMemo1_N NATIONAL VARCHAR(80);
   DECLARE v_HeaderMemo2_O NATIONAL VARCHAR(80);
   DECLARE v_HeaderMemo2_N NATIONAL VARCHAR(80);
   DECLARE v_HeaderMemo3_O NATIONAL VARCHAR(80);
   DECLARE v_HeaderMemo3_N NATIONAL VARCHAR(80);
   DECLARE v_HeaderMemo4_O NATIONAL VARCHAR(80);
   DECLARE v_HeaderMemo4_N NATIONAL VARCHAR(80);
   DECLARE v_HeaderMemo5_O NATIONAL VARCHAR(80);
   DECLARE v_HeaderMemo5_N NATIONAL VARCHAR(80);
   DECLARE v_HeaderMemo6_O NATIONAL VARCHAR(80);
   DECLARE v_HeaderMemo6_N NATIONAL VARCHAR(80);
   DECLARE v_HeaderMemo7_O NATIONAL VARCHAR(80);
   DECLARE v_HeaderMemo7_N NATIONAL VARCHAR(80);
   DECLARE v_HeaderMemo8_O NATIONAL VARCHAR(80);
   DECLARE v_HeaderMemo8_N NATIONAL VARCHAR(80);
   DECLARE v_HeaderMemo9_O NATIONAL VARCHAR(80);
   DECLARE v_HeaderMemo9_N NATIONAL VARCHAR(80);
   DECLARE v_AllowanceDiscountPerc_O NATIONAL VARCHAR(80);
   DECLARE v_AllowanceDiscountPerc_N NATIONAL VARCHAR(80);
 

-- updating records cursor declaration
   DECLARE cUpdate CURSOR
   FOR SELECT
   d.OrderNumber
		,i.OrderNumber
		,''

		,i.CompanyID
		,i.DivisionID
		,i.DepartmentID
		,i.OrderNumber

,CAST(d.TransactionTypeID AS CHAR(80))
,CAST(i.TransactionTypeID AS CHAR(80))
,CAST(d.EDIDirectionTypeID AS CHAR(80))
,CAST(i.EDIDirectionTypeID AS CHAR(80))
,CAST(d.EDIDocumentTypeID AS CHAR(80))
,CAST(i.EDIDocumentTypeID AS CHAR(80))
,CAST(d.EDIOpen AS CHAR(80))
,CAST(i.EDIOpen AS CHAR(80))
,CAST(d.OrderTypeID AS CHAR(80))
,CAST(i.OrderTypeID AS CHAR(80))
,CAST(d.OrderDate AS CHAR(80))
,CAST(i.OrderDate AS CHAR(80))
,CAST(d.OrderDueDate AS CHAR(80))
,CAST(i.OrderDueDate AS CHAR(80))
,CAST(d.OrderShipDate AS CHAR(80))
,CAST(i.OrderShipDate AS CHAR(80))
,CAST(d.OrderCancelDate AS CHAR(80))
,CAST(i.OrderCancelDate AS CHAR(80))
,CAST(d.PurchaseOrderNumber AS CHAR(80))
,CAST(i.PurchaseOrderNumber AS CHAR(80))
,CAST(d.TaxExemptID AS CHAR(80))
,CAST(i.TaxExemptID AS CHAR(80))
,CAST(d.TaxGroupID AS CHAR(80))
,CAST(i.TaxGroupID AS CHAR(80))
,CAST(d.CustomerID AS CHAR(80))
,CAST(i.CustomerID AS CHAR(80))
,CAST(d.CustomerShipToID AS CHAR(80))
,CAST(i.CustomerShipToID AS CHAR(80))
,CAST(d.CustomerShipForID AS CHAR(80))
,CAST(i.CustomerShipForID AS CHAR(80))
,CAST(d.WarehouseID AS CHAR(80))
,CAST(i.WarehouseID AS CHAR(80))
,CAST(d.CustomerDropShipment AS CHAR(80))
,CAST(i.CustomerDropShipment AS CHAR(80))
,CAST(d.ShippingName AS CHAR(80))
,CAST(i.ShippingName AS CHAR(80))
,CAST(d.ShippingAddress1 AS CHAR(80))
,CAST(i.ShippingAddress1 AS CHAR(80))
,CAST(d.ShippingAddress2 AS CHAR(80))
,CAST(i.ShippingAddress2 AS CHAR(80))
,CAST(d.ShippingCity AS CHAR(80))
,CAST(i.ShippingCity AS CHAR(80))
,CAST(d.ShippingState AS CHAR(80))
,CAST(i.ShippingState AS CHAR(80))
,CAST(d.ShippingZip AS CHAR(80))
,CAST(i.ShippingZip AS CHAR(80))
,CAST(d.ShippingCountry AS CHAR(80))
,CAST(i.ShippingCountry AS CHAR(80))
,CAST(d.ShipMethodID AS CHAR(80))
,CAST(i.ShipMethodID AS CHAR(80))
,CAST(d.EmployeeID AS CHAR(80))
,CAST(i.EmployeeID AS CHAR(80))
,CAST(d.TermsID AS CHAR(80))
,CAST(i.TermsID AS CHAR(80))
,CAST(d.PaymentMethodID AS CHAR(80))
,CAST(i.PaymentMethodID AS CHAR(80))
,CAST(d.CurrencyID AS CHAR(80))
,CAST(i.CurrencyID AS CHAR(80))
,CAST(d.CurrencyExchangeRate AS CHAR(80))
,CAST(i.CurrencyExchangeRate AS CHAR(80))
,CAST(d.Subtotal AS CHAR(80))
,CAST(i.Subtotal AS CHAR(80))
,CAST(d.DiscountPers AS CHAR(80))
,CAST(i.DiscountPers AS CHAR(80))
,CAST(d.DiscountAmount AS CHAR(80))
,CAST(i.DiscountAmount AS CHAR(80))
,CAST(d.TaxPercent AS CHAR(80))
,CAST(i.TaxPercent AS CHAR(80))
,CAST(d.TaxAmount AS CHAR(80))
,CAST(i.TaxAmount AS CHAR(80))
,CAST(d.TaxableSubTotal AS CHAR(80))
,CAST(i.TaxableSubTotal AS CHAR(80))
,CAST(d.Freight AS CHAR(80))
,CAST(i.Freight AS CHAR(80))
,CAST(d.TaxFreight AS CHAR(80))
,CAST(i.TaxFreight AS CHAR(80))
,CAST(d.Handling AS CHAR(80))
,CAST(i.Handling AS CHAR(80))
,CAST(d.Advertising AS CHAR(80))
,CAST(i.Advertising AS CHAR(80))
,CAST(d.Total AS CHAR(80))
,CAST(i.Total AS CHAR(80))
,CAST(d.AmountPaid AS CHAR(80))
,CAST(i.AmountPaid AS CHAR(80))
,CAST(d.BalanceDue AS CHAR(80))
,CAST(i.BalanceDue AS CHAR(80))
,CAST(d.UndistributedAmount AS CHAR(80))
,CAST(i.UndistributedAmount AS CHAR(80))
,CAST(d.Commission AS CHAR(80))
,CAST(i.Commission AS CHAR(80))
,CAST(d.CommissionableSales AS CHAR(80))
,CAST(i.CommissionableSales AS CHAR(80))
,CAST(d.ComissionalbleCost AS CHAR(80))
,CAST(i.ComissionalbleCost AS CHAR(80))
,CAST(d.GLSalesAccount AS CHAR(80))
,CAST(i.GLSalesAccount AS CHAR(80))
,CAST(d.CheckNumber AS CHAR(80))
,CAST(i.CheckNumber AS CHAR(80))
,CAST(d.CheckDate AS CHAR(80))
,CAST(i.CheckDate AS CHAR(80))
,CAST(d.CreditCardTypeID AS CHAR(80))
,CAST(i.CreditCardTypeID AS CHAR(80))
,CAST(d.CreditCardName AS CHAR(80))
,CAST(i.CreditCardName AS CHAR(80))
,CAST(d.CreditCardNumber AS CHAR(80))
,CAST(i.CreditCardNumber AS CHAR(80))
,CAST(d.CreditCardExpDate AS CHAR(80))
,CAST(i.CreditCardExpDate AS CHAR(80))
,CAST(d.CreditCardCSVNumber AS CHAR(80))
,CAST(i.CreditCardCSVNumber AS CHAR(80))
,CAST(d.CreditCardBillToZip AS CHAR(80))
,CAST(i.CreditCardBillToZip AS CHAR(80))
,CAST(d.CreditCardValidationCode AS CHAR(80))
,CAST(i.CreditCardValidationCode AS CHAR(80))
,CAST(d.CreditCardApprovalNumber AS CHAR(80))
,CAST(i.CreditCardApprovalNumber AS CHAR(80))
,CAST(d.Picked AS CHAR(80))
,CAST(i.Picked AS CHAR(80))
,CAST(d.PickedDate AS CHAR(80))
,CAST(i.PickedDate AS CHAR(80))
,CAST(d.Billed AS CHAR(80))
,CAST(i.Billed AS CHAR(80))
,CAST(d.BilledDate AS CHAR(80))
,CAST(i.BilledDate AS CHAR(80))
,CAST(d.Printed AS CHAR(80))
,CAST(i.Printed AS CHAR(80))
,CAST(d.PrintedDate AS CHAR(80))
,CAST(i.PrintedDate AS CHAR(80))
,CAST(d.Shipped AS CHAR(80))
,CAST(i.Shipped AS CHAR(80))
,CAST(d.ShipDate AS CHAR(80))
,CAST(i.ShipDate AS CHAR(80))
,CAST(d.TrackingNumber AS CHAR(80))
,CAST(i.TrackingNumber AS CHAR(80))
,CAST(d.Backordered AS CHAR(80))
,CAST(i.Backordered AS CHAR(80))
,CAST(d.Invoiced AS CHAR(80))
,CAST(i.Invoiced AS CHAR(80))
,CAST(d.InvoiceNumber AS CHAR(80))
,CAST(i.InvoiceNumber AS CHAR(80))
,CAST(d.InvoiceDate AS CHAR(80))
,CAST(i.InvoiceDate AS CHAR(80))
,CAST(d.Posted AS CHAR(80))
,CAST(i.Posted AS CHAR(80))
,CAST(d.PostedDate AS CHAR(80))
,CAST(i.PostedDate AS CHAR(80))
,CAST(d.MasterBillOfLading AS CHAR(80))
,CAST(i.MasterBillOfLading AS CHAR(80))
,CAST(d.MasterBillOfLadingDate AS CHAR(80))
,CAST(i.MasterBillOfLadingDate AS CHAR(80))
,CAST(d.TrailerNumber AS CHAR(80))
,CAST(i.TrailerNumber AS CHAR(80))
,CAST(d.TrailerPrefix AS CHAR(80))
,CAST(i.TrailerPrefix AS CHAR(80))
,CAST(d.HeaderMemo1 AS CHAR(80))
,CAST(i.HeaderMemo1 AS CHAR(80))
,CAST(d.HeaderMemo2 AS CHAR(80))
,CAST(i.HeaderMemo2 AS CHAR(80))
,CAST(d.HeaderMemo3 AS CHAR(80))
,CAST(i.HeaderMemo3 AS CHAR(80))
,CAST(d.HeaderMemo4 AS CHAR(80))
,CAST(i.HeaderMemo4 AS CHAR(80))
,CAST(d.HeaderMemo5 AS CHAR(80))
,CAST(i.HeaderMemo5 AS CHAR(80))
,CAST(d.HeaderMemo6 AS CHAR(80))
,CAST(i.HeaderMemo6 AS CHAR(80))
,CAST(d.HeaderMemo7 AS CHAR(80))
,CAST(i.HeaderMemo7 AS CHAR(80))
,CAST(d.HeaderMemo8 AS CHAR(80))
,CAST(i.HeaderMemo8 AS CHAR(80))
,CAST(d.HeaderMemo9 AS CHAR(80))
,CAST(i.HeaderMemo9 AS CHAR(80))
,CAST(d.AllowanceDiscountPerc AS CHAR(80))
,CAST(i.AllowanceDiscountPerc AS CHAR(80))
 

   FROM
   InsEDIOrderHeader i
   LEFT OUTER JOIN DelEDIOrderHeader d ON
   d.CompanyID = i.CompanyID
   AND d.DivisionID = i.DivisionID
   AND d.DepartmentID = i.DepartmentID
   AND d.OrderNumber = i.OrderNumber;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET NO_DATA = -2;
   END;
   DECLARE CONTINUE HANDLER FOR NOT FOUND SET NO_DATA = -1;
   CREATE  TEMPORARY TABLE IF NOT EXISTS InsEDIOrderHeader
   (
      CompanyID NATIONAL VARCHAR(36),
      DivisionID NATIONAL VARCHAR(36),
      DepartmentID NATIONAL VARCHAR(36),
      OrderNumber NATIONAL VARCHAR(36),
      TransactionTypeID NATIONAL VARCHAR(36),
      EDIDirectionTypeID NATIONAL VARCHAR(1),
      EDIDocumentTypeID NATIONAL VARCHAR(3),
      EDIOpen BOOLEAN,
      OrderTypeID NATIONAL VARCHAR(36),
      OrderDate DATETIME,
      OrderDueDate DATETIME,
      OrderShipDate DATETIME,
      OrderCancelDate DATETIME,
      PurchaseOrderNumber NATIONAL VARCHAR(36),
      TaxExemptID NATIONAL VARCHAR(36),
      TaxGroupID NATIONAL VARCHAR(36),
      CustomerID NATIONAL VARCHAR(50),
      CustomerShipToID NATIONAL VARCHAR(36),
      CustomerShipForID NATIONAL VARCHAR(36),
      WarehouseID NATIONAL VARCHAR(36),
      CustomerDropShipment BOOLEAN,
      ShippingName NATIONAL VARCHAR(50),
      ShippingAddress1 NATIONAL VARCHAR(50),
      ShippingAddress2 NATIONAL VARCHAR(50),
      ShippingCity NATIONAL VARCHAR(50),
      ShippingState NATIONAL VARCHAR(50),
      ShippingZip NATIONAL VARCHAR(10),
      ShippingCountry NATIONAL VARCHAR(50),
      ShipMethodID NATIONAL VARCHAR(36),
      EmployeeID NATIONAL VARCHAR(36),
      TermsID NATIONAL VARCHAR(36),
      PaymentMethodID NATIONAL VARCHAR(36),
      CurrencyID NATIONAL VARCHAR(3),
      CurrencyExchangeRate FLOAT,
      Subtotal DECIMAL(19,4),
      DiscountPers FLOAT,
      DiscountAmount DECIMAL(19,4),
      TaxPercent FLOAT,
      TaxAmount DECIMAL(19,4),
      TaxableSubTotal DECIMAL(19,4),
      Freight DECIMAL(19,4),
      TaxFreight BOOLEAN,
      Handling DECIMAL(19,4),
      Advertising DECIMAL(19,4),
      Total DECIMAL(19,4),
      AmountPaid DECIMAL(19,4),
      BalanceDue DECIMAL(19,4),
      UndistributedAmount DECIMAL(19,4),
      Commission DECIMAL(19,4),
      CommissionableSales DECIMAL(19,4),
      ComissionalbleCost DECIMAL(19,4),
      GLSalesAccount NATIONAL VARCHAR(36),
      CheckNumber NATIONAL VARCHAR(20),
      CheckDate DATETIME,
      CreditCardTypeID NATIONAL VARCHAR(15),
      CreditCardName NATIONAL VARCHAR(50),
      CreditCardNumber NATIONAL VARCHAR(50),
      CreditCardExpDate DATETIME,
      CreditCardCSVNumber NATIONAL VARCHAR(5),
      CreditCardBillToZip NATIONAL VARCHAR(10),
      CreditCardValidationCode NATIONAL VARCHAR(20),
      CreditCardApprovalNumber NATIONAL VARCHAR(20),
      Picked BOOLEAN,
      PickedDate DATETIME,
      Billed BOOLEAN,
      BilledDate DATETIME,
      Printed BOOLEAN,
      PrintedDate DATETIME,
      Shipped BOOLEAN,
      ShipDate DATETIME,
      TrackingNumber NATIONAL VARCHAR(50),
      Backordered BOOLEAN,
      Invoiced BOOLEAN,
      InvoiceNumber NATIONAL VARCHAR(20),
      InvoiceDate DATETIME,
      Posted BOOLEAN,
      PostedDate DATETIME,
      MasterBillOfLading NATIONAL VARCHAR(36),
      MasterBillOfLadingDate DATETIME,
      TrailerNumber NATIONAL VARCHAR(36),
      TrailerPrefix NATIONAL VARCHAR(36),
      HeaderMemo1 NATIONAL VARCHAR(50),
      HeaderMemo2 NATIONAL VARCHAR(50),
      HeaderMemo3 NATIONAL VARCHAR(50),
      HeaderMemo4 NATIONAL VARCHAR(50),
      HeaderMemo5 NATIONAL VARCHAR(50),
      HeaderMemo6 NATIONAL VARCHAR(50),
      HeaderMemo7 NATIONAL VARCHAR(50),
      HeaderMemo8 NATIONAL VARCHAR(50),
      HeaderMemo9 NATIONAL VARCHAR(50),
      LockedBy NATIONAL VARCHAR(36),
      LockTS DATETIME,
      AllowanceDiscountPerc FLOAT
   );
   DELETE FROM InsEDIOrderHeader;
   INSERT INTO InsEDIOrderHeader VALUES(NEW.CompanyID, NEW.DivisionID, NEW.DepartmentID, NEW.OrderNumber, NEW.TransactionTypeID, NEW.EDIDirectionTypeID, NEW.EDIDocumentTypeID, NEW.EDIOpen, NEW.OrderTypeID, NEW.OrderDate, NEW.OrderDueDate, NEW.OrderShipDate, NEW.OrderCancelDate, NEW.PurchaseOrderNumber, NEW.TaxExemptID, NEW.TaxGroupID, NEW.CustomerID, NEW.CustomerShipToID, NEW.CustomerShipForID, NEW.WarehouseID, NEW.CustomerDropShipment, NEW.ShippingName, NEW.ShippingAddress1, NEW.ShippingAddress2, NEW.ShippingCity, NEW.ShippingState, NEW.ShippingZip, NEW.ShippingCountry, NEW.ShipMethodID, NEW.EmployeeID, NEW.TermsID, NEW.PaymentMethodID, NEW.CurrencyID, NEW.CurrencyExchangeRate, NEW.Subtotal, NEW.DiscountPers, NEW.DiscountAmount, NEW.TaxPercent, NEW.TaxAmount, NEW.TaxableSubTotal, NEW.Freight, NEW.TaxFreight, NEW.Handling, NEW.Advertising, NEW.Total, NEW.AmountPaid, NEW.BalanceDue, NEW.UndistributedAmount, NEW.Commission, NEW.CommissionableSales, NEW.ComissionalbleCost, NEW.GLSalesAccount, NEW.CheckNumber, NEW.CheckDate, NEW.CreditCardTypeID, NEW.CreditCardName, NEW.CreditCardNumber, NEW.CreditCardExpDate, NEW.CreditCardCSVNumber, NEW.CreditCardBillToZip, NEW.CreditCardValidationCode, NEW.CreditCardApprovalNumber, NEW.Picked, NEW.PickedDate, NEW.Billed, NEW.BilledDate, NEW.Printed, NEW.PrintedDate, NEW.Shipped, NEW.ShipDate, NEW.TrackingNumber, NEW.Backordered, NEW.Invoiced, NEW.InvoiceNumber, NEW.InvoiceDate, NEW.Posted, NEW.PostedDate, NEW.MasterBillOfLading, NEW.MasterBillOfLadingDate, NEW.TrailerNumber, NEW.TrailerPrefix, NEW.HeaderMemo1, NEW.HeaderMemo2, NEW.HeaderMemo3, NEW.HeaderMemo4, NEW.HeaderMemo5, NEW.HeaderMemo6, NEW.HeaderMemo7, NEW.HeaderMemo8, NEW.HeaderMemo9, NEW.LockedBy, NEW.LockTS, NEW.AllowanceDiscountPerc);

   CREATE  TEMPORARY TABLE IF NOT EXISTS DelEDIOrderHeader
   (
      CompanyID NATIONAL VARCHAR(36),
      DivisionID NATIONAL VARCHAR(36),
      DepartmentID NATIONAL VARCHAR(36),
      OrderNumber NATIONAL VARCHAR(36),
      TransactionTypeID NATIONAL VARCHAR(36),
      EDIDirectionTypeID NATIONAL VARCHAR(1),
      EDIDocumentTypeID NATIONAL VARCHAR(3),
      EDIOpen BOOLEAN,
      OrderTypeID NATIONAL VARCHAR(36),
      OrderDate DATETIME,
      OrderDueDate DATETIME,
      OrderShipDate DATETIME,
      OrderCancelDate DATETIME,
      PurchaseOrderNumber NATIONAL VARCHAR(36),
      TaxExemptID NATIONAL VARCHAR(36),
      TaxGroupID NATIONAL VARCHAR(36),
      CustomerID NATIONAL VARCHAR(50),
      CustomerShipToID NATIONAL VARCHAR(36),
      CustomerShipForID NATIONAL VARCHAR(36),
      WarehouseID NATIONAL VARCHAR(36),
      CustomerDropShipment BOOLEAN,
      ShippingName NATIONAL VARCHAR(50),
      ShippingAddress1 NATIONAL VARCHAR(50),
      ShippingAddress2 NATIONAL VARCHAR(50),
      ShippingCity NATIONAL VARCHAR(50),
      ShippingState NATIONAL VARCHAR(50),
      ShippingZip NATIONAL VARCHAR(10),
      ShippingCountry NATIONAL VARCHAR(50),
      ShipMethodID NATIONAL VARCHAR(36),
      EmployeeID NATIONAL VARCHAR(36),
      TermsID NATIONAL VARCHAR(36),
      PaymentMethodID NATIONAL VARCHAR(36),
      CurrencyID NATIONAL VARCHAR(3),
      CurrencyExchangeRate FLOAT,
      Subtotal DECIMAL(19,4),
      DiscountPers FLOAT,
      DiscountAmount DECIMAL(19,4),
      TaxPercent FLOAT,
      TaxAmount DECIMAL(19,4),
      TaxableSubTotal DECIMAL(19,4),
      Freight DECIMAL(19,4),
      TaxFreight BOOLEAN,
      Handling DECIMAL(19,4),
      Advertising DECIMAL(19,4),
      Total DECIMAL(19,4),
      AmountPaid DECIMAL(19,4),
      BalanceDue DECIMAL(19,4),
      UndistributedAmount DECIMAL(19,4),
      Commission DECIMAL(19,4),
      CommissionableSales DECIMAL(19,4),
      ComissionalbleCost DECIMAL(19,4),
      GLSalesAccount NATIONAL VARCHAR(36),
      CheckNumber NATIONAL VARCHAR(20),
      CheckDate DATETIME,
      CreditCardTypeID NATIONAL VARCHAR(15),
      CreditCardName NATIONAL VARCHAR(50),
      CreditCardNumber NATIONAL VARCHAR(50),
      CreditCardExpDate DATETIME,
      CreditCardCSVNumber NATIONAL VARCHAR(5),
      CreditCardBillToZip NATIONAL VARCHAR(10),
      CreditCardValidationCode NATIONAL VARCHAR(20),
      CreditCardApprovalNumber NATIONAL VARCHAR(20),
      Picked BOOLEAN,
      PickedDate DATETIME,
      Billed BOOLEAN,
      BilledDate DATETIME,
      Printed BOOLEAN,
      PrintedDate DATETIME,
      Shipped BOOLEAN,
      ShipDate DATETIME,
      TrackingNumber NATIONAL VARCHAR(50),
      Backordered BOOLEAN,
      Invoiced BOOLEAN,
      InvoiceNumber NATIONAL VARCHAR(20),
      InvoiceDate DATETIME,
      Posted BOOLEAN,
      PostedDate DATETIME,
      MasterBillOfLading NATIONAL VARCHAR(36),
      MasterBillOfLadingDate DATETIME,
      TrailerNumber NATIONAL VARCHAR(36),
      TrailerPrefix NATIONAL VARCHAR(36),
      HeaderMemo1 NATIONAL VARCHAR(50),
      HeaderMemo2 NATIONAL VARCHAR(50),
      HeaderMemo3 NATIONAL VARCHAR(50),
      HeaderMemo4 NATIONAL VARCHAR(50),
      HeaderMemo5 NATIONAL VARCHAR(50),
      HeaderMemo6 NATIONAL VARCHAR(50),
      HeaderMemo7 NATIONAL VARCHAR(50),
      HeaderMemo8 NATIONAL VARCHAR(50),
      HeaderMemo9 NATIONAL VARCHAR(50),
      LockedBy NATIONAL VARCHAR(36),
      LockTS DATETIME,
      AllowanceDiscountPerc FLOAT
   );
   DELETE FROM DelEDIOrderHeader;
   INSERT INTO DelEDIOrderHeader VALUES(OLD.CompanyID, OLD.DivisionID, OLD.DepartmentID, OLD.OrderNumber, OLD.TransactionTypeID, OLD.EDIDirectionTypeID, OLD.EDIDocumentTypeID, OLD.EDIOpen, OLD.OrderTypeID, OLD.OrderDate, OLD.OrderDueDate, OLD.OrderShipDate, OLD.OrderCancelDate, OLD.PurchaseOrderNumber, OLD.TaxExemptID, OLD.TaxGroupID, OLD.CustomerID, OLD.CustomerShipToID, OLD.CustomerShipForID, OLD.WarehouseID, OLD.CustomerDropShipment, OLD.ShippingName, OLD.ShippingAddress1, OLD.ShippingAddress2, OLD.ShippingCity, OLD.ShippingState, OLD.ShippingZip, OLD.ShippingCountry, OLD.ShipMethodID, OLD.EmployeeID, OLD.TermsID, OLD.PaymentMethodID, OLD.CurrencyID, OLD.CurrencyExchangeRate, OLD.Subtotal, OLD.DiscountPers, OLD.DiscountAmount, OLD.TaxPercent, OLD.TaxAmount, OLD.TaxableSubTotal, OLD.Freight, OLD.TaxFreight, OLD.Handling, OLD.Advertising, OLD.Total, OLD.AmountPaid, OLD.BalanceDue, OLD.UndistributedAmount, OLD.Commission, OLD.CommissionableSales, OLD.ComissionalbleCost, OLD.GLSalesAccount, OLD.CheckNumber, OLD.CheckDate, OLD.CreditCardTypeID, OLD.CreditCardName, OLD.CreditCardNumber, OLD.CreditCardExpDate, OLD.CreditCardCSVNumber, OLD.CreditCardBillToZip, OLD.CreditCardValidationCode, OLD.CreditCardApprovalNumber, OLD.Picked, OLD.PickedDate, OLD.Billed, OLD.BilledDate, OLD.Printed, OLD.PrintedDate, OLD.Shipped, OLD.ShipDate, OLD.TrackingNumber, OLD.Backordered, OLD.Invoiced, OLD.InvoiceNumber, OLD.InvoiceDate, OLD.Posted, OLD.PostedDate, OLD.MasterBillOfLading, OLD.MasterBillOfLadingDate, OLD.TrailerNumber, OLD.TrailerPrefix, OLD.HeaderMemo1, OLD.HeaderMemo2, OLD.HeaderMemo3, OLD.HeaderMemo4, OLD.HeaderMemo5, OLD.HeaderMemo6, OLD.HeaderMemo7, OLD.HeaderMemo8, OLD.HeaderMemo9, OLD.LockedBy, OLD.LockTS, OLD.AllowanceDiscountPerc);

   BEGIN
-- check for audit triggers switch off

      select   context_info INTO v_Context FROM sysprocesses WHERE spid = CONNECTION_ID();
      IF CAST(v_Context AS CHAR(36)) = N'$$AuditSwitchOff$$' then 
         LEAVE SWL_return;
      end if;

-- declarations
      OPEN cUpdate;
-- fetch from each updating record
      SET NO_DATA = 0;
      FETCH cUpdate INTO
      v_TransactionNumber_O,v_TransactionNumber_N,v_TransactionLineNumber,v_CompanyID,
      v_DivisionID,v_DepartmentID,v_OrderNumber,v_TransactionTypeID_O,
      v_TransactionTypeID_N,v_EDIDirectionTypeID_O,v_EDIDirectionTypeID_N,
      v_EDIDocumentTypeID_O,v_EDIDocumentTypeID_N,v_EDIOpen_O,v_EDIOpen_N,
      v_OrderTypeID_O,v_OrderTypeID_N,v_OrderDate_O,v_OrderDate_N,v_OrderDueDate_O,
      v_OrderDueDate_N,v_OrderShipDate_O,v_OrderShipDate_N,v_OrderCancelDate_O,
      v_OrderCancelDate_N,v_PurchaseOrderNumber_O,v_PurchaseOrderNumber_N,
      v_TaxExemptID_O,v_TaxExemptID_N,v_TaxGroupID_O,v_TaxGroupID_N,
      v_CustomerID_O,v_CustomerID_N,v_CustomerShipToID_O,v_CustomerShipToID_N,
      v_CustomerShipForID_O,v_CustomerShipForID_N,v_WarehouseID_O,v_WarehouseID_N,
      v_CustomerDropShipment_O,v_CustomerDropShipment_N,v_ShippingName_O,
      v_ShippingName_N,v_ShippingAddress1_O,v_ShippingAddress1_N,v_ShippingAddress2_O,
      v_ShippingAddress2_N,v_ShippingCity_O,v_ShippingCity_N,
      v_ShippingState_O,v_ShippingState_N,v_ShippingZip_O,v_ShippingZip_N,v_ShippingCountry_O,
      v_ShippingCountry_N,v_ShipMethodID_O,v_ShipMethodID_N,
      v_EmployeeID_O,v_EmployeeID_N,v_TermsID_O,v_TermsID_N,v_PaymentMethodID_O,
      v_PaymentMethodID_N,v_CurrencyID_O,v_CurrencyID_N,v_CurrencyExchangeRate_O,
      v_CurrencyExchangeRate_N,v_Subtotal_O,v_Subtotal_N,v_DiscountPers_O,
      v_DiscountPers_N,v_DiscountAmount_O,v_DiscountAmount_N,v_TaxPercent_O,
      v_TaxPercent_N,v_TaxAmount_O,v_TaxAmount_N,v_TaxableSubTotal_O,
      v_TaxableSubTotal_N,v_Freight_O,v_Freight_N,v_TaxFreight_O,v_TaxFreight_N,
      v_Handling_O,v_Handling_N,v_Advertising_O,v_Advertising_N,v_Total_O,
      v_Total_N,v_AmountPaid_O,v_AmountPaid_N,v_BalanceDue_O,v_BalanceDue_N,
      v_UndistributedAmount_O,v_UndistributedAmount_N,v_Commission_O,v_Commission_N,
      v_CommissionableSales_O,v_CommissionableSales_N,v_ComissionalbleCost_O,
      v_ComissionalbleCost_N,v_GLSalesAccount_O,v_GLSalesAccount_N,
      v_CheckNumber_O,v_CheckNumber_N,v_CheckDate_O,v_CheckDate_N,v_CreditCardTypeID_O,
      v_CreditCardTypeID_N,v_CreditCardName_O,v_CreditCardName_N,
      v_CreditCardNumber_O,v_CreditCardNumber_N,v_CreditCardExpDate_O,v_CreditCardExpDate_N,
      v_CreditCardCSVNumber_O,v_CreditCardCSVNumber_N,v_CreditCardBillToZip_O,
      v_CreditCardBillToZip_N,v_CreditCardValidationCode_O,
      v_CreditCardValidationCode_N,v_CreditCardApprovalNumber_O,v_CreditCardApprovalNumber_N,
      v_Picked_O,v_Picked_N,v_PickedDate_O,v_PickedDate_N,
      v_Billed_O,v_Billed_N,v_BilledDate_O,v_BilledDate_N,v_Printed_O,v_Printed_N,
      v_PrintedDate_O,v_PrintedDate_N,v_Shipped_O,v_Shipped_N,v_ShipDate_O,
      v_ShipDate_N,v_TrackingNumber_O,v_TrackingNumber_N,v_Backordered_O,
      v_Backordered_N,v_Invoiced_O,v_Invoiced_N,v_InvoiceNumber_O,v_InvoiceNumber_N,
      v_InvoiceDate_O,v_InvoiceDate_N,v_Posted_O,v_Posted_N,v_PostedDate_O,
      v_PostedDate_N,v_MasterBillOfLading_O,v_MasterBillOfLading_N,
      v_MasterBillOfLadingDate_O,v_MasterBillOfLadingDate_N,v_TrailerNumber_O,
      v_TrailerNumber_N,v_TrailerPrefix_O,v_TrailerPrefix_N,v_HeaderMemo1_O,
      v_HeaderMemo1_N,v_HeaderMemo2_O,v_HeaderMemo2_N,v_HeaderMemo3_O,
      v_HeaderMemo3_N,v_HeaderMemo4_O,v_HeaderMemo4_N,v_HeaderMemo5_O,v_HeaderMemo5_N,
      v_HeaderMemo6_O,v_HeaderMemo6_N,v_HeaderMemo7_O,v_HeaderMemo7_N,
      v_HeaderMemo8_O,v_HeaderMemo8_N,v_HeaderMemo9_O,v_HeaderMemo9_N,v_AllowanceDiscountPerc_O,
      v_AllowanceDiscountPerc_N;
      WHILE NO_DATA = 0 DO
-- insert audit records for each changed field
         IF IsGuid(v_TransactionNumber_N) = 0 then
		
            IF v_TransactionNumber_O IS NULL then
				
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIOrderHeader','New Record','','New Record');
            ELSE
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIOrderHeader','TransactionTypeID',v_TransactionTypeID_O,
               v_TransactionTypeID_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIOrderHeader','EDIDirectionTypeID',v_EDIDirectionTypeID_O,
               v_EDIDirectionTypeID_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIOrderHeader','EDIDocumentTypeID',v_EDIDocumentTypeID_O,
               v_EDIDocumentTypeID_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIOrderHeader','EDIOpen',v_EDIOpen_O,v_EDIOpen_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIOrderHeader','OrderTypeID',v_OrderTypeID_O,v_OrderTypeID_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIOrderHeader','OrderDate',v_OrderDate_O,v_OrderDate_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIOrderHeader','OrderDueDate',v_OrderDueDate_O,
               v_OrderDueDate_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIOrderHeader','OrderShipDate',v_OrderShipDate_O,
               v_OrderShipDate_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIOrderHeader','OrderCancelDate',v_OrderCancelDate_O,
               v_OrderCancelDate_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIOrderHeader','PurchaseOrderNumber',v_PurchaseOrderNumber_O,
               v_PurchaseOrderNumber_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIOrderHeader','TaxExemptID',v_TaxExemptID_O,v_TaxExemptID_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIOrderHeader','TaxGroupID',v_TaxGroupID_O,v_TaxGroupID_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIOrderHeader','CustomerID',v_CustomerID_O,v_CustomerID_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIOrderHeader','CustomerShipToID',v_CustomerShipToID_O,
               v_CustomerShipToID_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIOrderHeader','CustomerShipForID',v_CustomerShipForID_O,
               v_CustomerShipForID_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIOrderHeader','WarehouseID',v_WarehouseID_O,v_WarehouseID_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIOrderHeader','CustomerDropShipment',v_CustomerDropShipment_O,
               v_CustomerDropShipment_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIOrderHeader','ShippingName',v_ShippingName_O,
               v_ShippingName_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIOrderHeader','ShippingAddress1',v_ShippingAddress1_O,
               v_ShippingAddress1_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIOrderHeader','ShippingAddress2',v_ShippingAddress2_O,
               v_ShippingAddress2_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIOrderHeader','ShippingCity',v_ShippingCity_O,
               v_ShippingCity_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIOrderHeader','ShippingState',v_ShippingState_O,
               v_ShippingState_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIOrderHeader','ShippingZip',v_ShippingZip_O,v_ShippingZip_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIOrderHeader','ShippingCountry',v_ShippingCountry_O,
               v_ShippingCountry_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIOrderHeader','ShipMethodID',v_ShipMethodID_O,
               v_ShipMethodID_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIOrderHeader','EmployeeID',v_EmployeeID_O,v_EmployeeID_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIOrderHeader','TermsID',v_TermsID_O,v_TermsID_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIOrderHeader','PaymentMethodID',v_PaymentMethodID_O,
               v_PaymentMethodID_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIOrderHeader','CurrencyID',v_CurrencyID_O,v_CurrencyID_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIOrderHeader','CurrencyExchangeRate',v_CurrencyExchangeRate_O,
               v_CurrencyExchangeRate_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIOrderHeader','Subtotal',v_Subtotal_O,v_Subtotal_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIOrderHeader','DiscountPers',v_DiscountPers_O,
               v_DiscountPers_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIOrderHeader','DiscountAmount',v_DiscountAmount_O,
               v_DiscountAmount_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIOrderHeader','TaxPercent',v_TaxPercent_O,v_TaxPercent_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIOrderHeader','TaxAmount',v_TaxAmount_O,v_TaxAmount_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIOrderHeader','TaxableSubTotal',v_TaxableSubTotal_O,
               v_TaxableSubTotal_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIOrderHeader','Freight',v_Freight_O,v_Freight_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIOrderHeader','TaxFreight',v_TaxFreight_O,v_TaxFreight_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIOrderHeader','Handling',v_Handling_O,v_Handling_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIOrderHeader','Advertising',v_Advertising_O,v_Advertising_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIOrderHeader','Total',v_Total_O,v_Total_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIOrderHeader','AmountPaid',v_AmountPaid_O,v_AmountPaid_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIOrderHeader','BalanceDue',v_BalanceDue_O,v_BalanceDue_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIOrderHeader','UndistributedAmount',v_UndistributedAmount_O,
               v_UndistributedAmount_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIOrderHeader','Commission',v_Commission_O,v_Commission_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIOrderHeader','CommissionableSales',v_CommissionableSales_O,
               v_CommissionableSales_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIOrderHeader','ComissionalbleCost',v_ComissionalbleCost_O,
               v_ComissionalbleCost_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIOrderHeader','GLSalesAccount',v_GLSalesAccount_O,
               v_GLSalesAccount_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIOrderHeader','CheckNumber',v_CheckNumber_O,v_CheckNumber_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIOrderHeader','CheckDate',v_CheckDate_O,v_CheckDate_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIOrderHeader','CreditCardTypeID',v_CreditCardTypeID_O,
               v_CreditCardTypeID_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIOrderHeader','CreditCardName',v_CreditCardName_O,
               v_CreditCardName_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIOrderHeader','CreditCardNumber',v_CreditCardNumber_O,
               v_CreditCardNumber_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIOrderHeader','CreditCardExpDate',v_CreditCardExpDate_O,
               v_CreditCardExpDate_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIOrderHeader','CreditCardCSVNumber',v_CreditCardCSVNumber_O,
               v_CreditCardCSVNumber_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIOrderHeader','CreditCardBillToZip',v_CreditCardBillToZip_O,
               v_CreditCardBillToZip_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIOrderHeader','CreditCardValidationCode',v_CreditCardValidationCode_O,
               v_CreditCardValidationCode_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIOrderHeader','CreditCardApprovalNumber',v_CreditCardApprovalNumber_O,
               v_CreditCardApprovalNumber_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIOrderHeader','Picked',v_Picked_O,v_Picked_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIOrderHeader','PickedDate',v_PickedDate_O,v_PickedDate_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIOrderHeader','Billed',v_Billed_O,v_Billed_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIOrderHeader','BilledDate',v_BilledDate_O,v_BilledDate_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIOrderHeader','Printed',v_Printed_O,v_Printed_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIOrderHeader','PrintedDate',v_PrintedDate_O,v_PrintedDate_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIOrderHeader','Shipped',v_Shipped_O,v_Shipped_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIOrderHeader','ShipDate',v_ShipDate_O,v_ShipDate_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIOrderHeader','TrackingNumber',v_TrackingNumber_O,
               v_TrackingNumber_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIOrderHeader','Backordered',v_Backordered_O,v_Backordered_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIOrderHeader','Invoiced',v_Invoiced_O,v_Invoiced_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIOrderHeader','InvoiceNumber',v_InvoiceNumber_O,
               v_InvoiceNumber_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIOrderHeader','InvoiceDate',v_InvoiceDate_O,v_InvoiceDate_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIOrderHeader','Posted',v_Posted_O,v_Posted_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIOrderHeader','PostedDate',v_PostedDate_O,v_PostedDate_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIOrderHeader','MasterBillOfLading',v_MasterBillOfLading_O,
               v_MasterBillOfLading_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIOrderHeader','MasterBillOfLadingDate',v_MasterBillOfLadingDate_O,
               v_MasterBillOfLadingDate_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIOrderHeader','TrailerNumber',v_TrailerNumber_O,
               v_TrailerNumber_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIOrderHeader','TrailerPrefix',v_TrailerPrefix_O,
               v_TrailerPrefix_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIOrderHeader','HeaderMemo1',v_HeaderMemo1_O,v_HeaderMemo1_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIOrderHeader','HeaderMemo2',v_HeaderMemo2_O,v_HeaderMemo2_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIOrderHeader','HeaderMemo3',v_HeaderMemo3_O,v_HeaderMemo3_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIOrderHeader','HeaderMemo4',v_HeaderMemo4_O,v_HeaderMemo4_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIOrderHeader','HeaderMemo5',v_HeaderMemo5_O,v_HeaderMemo5_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIOrderHeader','HeaderMemo6',v_HeaderMemo6_O,v_HeaderMemo6_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIOrderHeader','HeaderMemo7',v_HeaderMemo7_O,v_HeaderMemo7_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIOrderHeader','HeaderMemo8',v_HeaderMemo8_O,v_HeaderMemo8_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIOrderHeader','HeaderMemo9',v_HeaderMemo9_O,v_HeaderMemo9_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIOrderHeader','AllowanceDiscountPerc',v_AllowanceDiscountPerc_O,
               v_AllowanceDiscountPerc_N);
            end if;
         end if;
         SET NO_DATA = 0;
         FETCH cUpdate INTO
         v_TransactionNumber_O,v_TransactionNumber_N,v_TransactionLineNumber,v_CompanyID,
         v_DivisionID,v_DepartmentID,v_OrderNumber,v_TransactionTypeID_O,
         v_TransactionTypeID_N,v_EDIDirectionTypeID_O,v_EDIDirectionTypeID_N,
         v_EDIDocumentTypeID_O,v_EDIDocumentTypeID_N,v_EDIOpen_O,v_EDIOpen_N,
         v_OrderTypeID_O,v_OrderTypeID_N,v_OrderDate_O,v_OrderDate_N,v_OrderDueDate_O,
         v_OrderDueDate_N,v_OrderShipDate_O,v_OrderShipDate_N,v_OrderCancelDate_O,
         v_OrderCancelDate_N,v_PurchaseOrderNumber_O,v_PurchaseOrderNumber_N,
         v_TaxExemptID_O,v_TaxExemptID_N,v_TaxGroupID_O,v_TaxGroupID_N,
         v_CustomerID_O,v_CustomerID_N,v_CustomerShipToID_O,v_CustomerShipToID_N,
         v_CustomerShipForID_O,v_CustomerShipForID_N,v_WarehouseID_O,v_WarehouseID_N,
         v_CustomerDropShipment_O,v_CustomerDropShipment_N,v_ShippingName_O,
         v_ShippingName_N,v_ShippingAddress1_O,v_ShippingAddress1_N,v_ShippingAddress2_O,
         v_ShippingAddress2_N,v_ShippingCity_O,v_ShippingCity_N,
         v_ShippingState_O,v_ShippingState_N,v_ShippingZip_O,v_ShippingZip_N,v_ShippingCountry_O,
         v_ShippingCountry_N,v_ShipMethodID_O,v_ShipMethodID_N,
         v_EmployeeID_O,v_EmployeeID_N,v_TermsID_O,v_TermsID_N,v_PaymentMethodID_O,
         v_PaymentMethodID_N,v_CurrencyID_O,v_CurrencyID_N,v_CurrencyExchangeRate_O,
         v_CurrencyExchangeRate_N,v_Subtotal_O,v_Subtotal_N,v_DiscountPers_O,
         v_DiscountPers_N,v_DiscountAmount_O,v_DiscountAmount_N,v_TaxPercent_O,
         v_TaxPercent_N,v_TaxAmount_O,v_TaxAmount_N,v_TaxableSubTotal_O,
         v_TaxableSubTotal_N,v_Freight_O,v_Freight_N,v_TaxFreight_O,v_TaxFreight_N,
         v_Handling_O,v_Handling_N,v_Advertising_O,v_Advertising_N,v_Total_O,
         v_Total_N,v_AmountPaid_O,v_AmountPaid_N,v_BalanceDue_O,v_BalanceDue_N,
         v_UndistributedAmount_O,v_UndistributedAmount_N,v_Commission_O,v_Commission_N,
         v_CommissionableSales_O,v_CommissionableSales_N,v_ComissionalbleCost_O,
         v_ComissionalbleCost_N,v_GLSalesAccount_O,v_GLSalesAccount_N,
         v_CheckNumber_O,v_CheckNumber_N,v_CheckDate_O,v_CheckDate_N,v_CreditCardTypeID_O,
         v_CreditCardTypeID_N,v_CreditCardName_O,v_CreditCardName_N,
         v_CreditCardNumber_O,v_CreditCardNumber_N,v_CreditCardExpDate_O,v_CreditCardExpDate_N,
         v_CreditCardCSVNumber_O,v_CreditCardCSVNumber_N,v_CreditCardBillToZip_O,
         v_CreditCardBillToZip_N,v_CreditCardValidationCode_O,
         v_CreditCardValidationCode_N,v_CreditCardApprovalNumber_O,v_CreditCardApprovalNumber_N,
         v_Picked_O,v_Picked_N,v_PickedDate_O,v_PickedDate_N,
         v_Billed_O,v_Billed_N,v_BilledDate_O,v_BilledDate_N,v_Printed_O,v_Printed_N,
         v_PrintedDate_O,v_PrintedDate_N,v_Shipped_O,v_Shipped_N,v_ShipDate_O,
         v_ShipDate_N,v_TrackingNumber_O,v_TrackingNumber_N,v_Backordered_O,
         v_Backordered_N,v_Invoiced_O,v_Invoiced_N,v_InvoiceNumber_O,v_InvoiceNumber_N,
         v_InvoiceDate_O,v_InvoiceDate_N,v_Posted_O,v_Posted_N,v_PostedDate_O,
         v_PostedDate_N,v_MasterBillOfLading_O,v_MasterBillOfLading_N,
         v_MasterBillOfLadingDate_O,v_MasterBillOfLadingDate_N,v_TrailerNumber_O,
         v_TrailerNumber_N,v_TrailerPrefix_O,v_TrailerPrefix_N,v_HeaderMemo1_O,
         v_HeaderMemo1_N,v_HeaderMemo2_O,v_HeaderMemo2_N,v_HeaderMemo3_O,
         v_HeaderMemo3_N,v_HeaderMemo4_O,v_HeaderMemo4_N,v_HeaderMemo5_O,v_HeaderMemo5_N,
         v_HeaderMemo6_O,v_HeaderMemo6_N,v_HeaderMemo7_O,v_HeaderMemo7_N,
         v_HeaderMemo8_O,v_HeaderMemo8_N,v_HeaderMemo9_O,v_HeaderMemo9_N,v_AllowanceDiscountPerc_O,
         v_AllowanceDiscountPerc_N;
      END WHILE;
      CLOSE cUpdate;

   END;
END;
 ;;
delimiter ;
delimiter ;;
CREATE TRIGGER `EDIOrderHeader_Audit_Delete` AFTER DELETE ON `ediorderheader` FOR EACH ROW SWL_return:
BEGIN
   DECLARE NO_DATA INT DEFAULT 0;
   DECLARE v_Context VARBINARY(128);
   DECLARE v_TransactionNumber NATIONAL VARCHAR(50);
   DECLARE v_TransactionLineNumber NATIONAL VARCHAR(50);

   DECLARE v_CompanyID NATIONAL VARCHAR(36);
   DECLARE v_DivisionID NATIONAL VARCHAR(36);
   DECLARE v_DepartmentID NATIONAL VARCHAR(36);
   DECLARE v_OrderNumber NATIONAL VARCHAR(36);

-- deleting records cursor declaration
   DECLARE cDelete CURSOR
   FOR SELECT
   d.OrderNumber
		,''

		,d.CompanyID
		,d.DivisionID
		,d.DepartmentID
		,d.OrderNumber

   FROM
   DelEDIOrderHeader d;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET NO_DATA = -2;
   END;
   DECLARE CONTINUE HANDLER FOR NOT FOUND SET NO_DATA = -1;
   CREATE  TEMPORARY TABLE IF NOT EXISTS DelEDIOrderHeader
   (
      CompanyID NATIONAL VARCHAR(36),
      DivisionID NATIONAL VARCHAR(36),
      DepartmentID NATIONAL VARCHAR(36),
      OrderNumber NATIONAL VARCHAR(36),
      TransactionTypeID NATIONAL VARCHAR(36),
      EDIDirectionTypeID NATIONAL VARCHAR(1),
      EDIDocumentTypeID NATIONAL VARCHAR(3),
      EDIOpen BOOLEAN,
      OrderTypeID NATIONAL VARCHAR(36),
      OrderDate DATETIME,
      OrderDueDate DATETIME,
      OrderShipDate DATETIME,
      OrderCancelDate DATETIME,
      PurchaseOrderNumber NATIONAL VARCHAR(36),
      TaxExemptID NATIONAL VARCHAR(36),
      TaxGroupID NATIONAL VARCHAR(36),
      CustomerID NATIONAL VARCHAR(50),
      CustomerShipToID NATIONAL VARCHAR(36),
      CustomerShipForID NATIONAL VARCHAR(36),
      WarehouseID NATIONAL VARCHAR(36),
      CustomerDropShipment BOOLEAN,
      ShippingName NATIONAL VARCHAR(50),
      ShippingAddress1 NATIONAL VARCHAR(50),
      ShippingAddress2 NATIONAL VARCHAR(50),
      ShippingCity NATIONAL VARCHAR(50),
      ShippingState NATIONAL VARCHAR(50),
      ShippingZip NATIONAL VARCHAR(10),
      ShippingCountry NATIONAL VARCHAR(50),
      ShipMethodID NATIONAL VARCHAR(36),
      EmployeeID NATIONAL VARCHAR(36),
      TermsID NATIONAL VARCHAR(36),
      PaymentMethodID NATIONAL VARCHAR(36),
      CurrencyID NATIONAL VARCHAR(3),
      CurrencyExchangeRate FLOAT,
      Subtotal DECIMAL(19,4),
      DiscountPers FLOAT,
      DiscountAmount DECIMAL(19,4),
      TaxPercent FLOAT,
      TaxAmount DECIMAL(19,4),
      TaxableSubTotal DECIMAL(19,4),
      Freight DECIMAL(19,4),
      TaxFreight BOOLEAN,
      Handling DECIMAL(19,4),
      Advertising DECIMAL(19,4),
      Total DECIMAL(19,4),
      AmountPaid DECIMAL(19,4),
      BalanceDue DECIMAL(19,4),
      UndistributedAmount DECIMAL(19,4),
      Commission DECIMAL(19,4),
      CommissionableSales DECIMAL(19,4),
      ComissionalbleCost DECIMAL(19,4),
      GLSalesAccount NATIONAL VARCHAR(36),
      CheckNumber NATIONAL VARCHAR(20),
      CheckDate DATETIME,
      CreditCardTypeID NATIONAL VARCHAR(15),
      CreditCardName NATIONAL VARCHAR(50),
      CreditCardNumber NATIONAL VARCHAR(50),
      CreditCardExpDate DATETIME,
      CreditCardCSVNumber NATIONAL VARCHAR(5),
      CreditCardBillToZip NATIONAL VARCHAR(10),
      CreditCardValidationCode NATIONAL VARCHAR(20),
      CreditCardApprovalNumber NATIONAL VARCHAR(20),
      Picked BOOLEAN,
      PickedDate DATETIME,
      Billed BOOLEAN,
      BilledDate DATETIME,
      Printed BOOLEAN,
      PrintedDate DATETIME,
      Shipped BOOLEAN,
      ShipDate DATETIME,
      TrackingNumber NATIONAL VARCHAR(50),
      Backordered BOOLEAN,
      Invoiced BOOLEAN,
      InvoiceNumber NATIONAL VARCHAR(20),
      InvoiceDate DATETIME,
      Posted BOOLEAN,
      PostedDate DATETIME,
      MasterBillOfLading NATIONAL VARCHAR(36),
      MasterBillOfLadingDate DATETIME,
      TrailerNumber NATIONAL VARCHAR(36),
      TrailerPrefix NATIONAL VARCHAR(36),
      HeaderMemo1 NATIONAL VARCHAR(50),
      HeaderMemo2 NATIONAL VARCHAR(50),
      HeaderMemo3 NATIONAL VARCHAR(50),
      HeaderMemo4 NATIONAL VARCHAR(50),
      HeaderMemo5 NATIONAL VARCHAR(50),
      HeaderMemo6 NATIONAL VARCHAR(50),
      HeaderMemo7 NATIONAL VARCHAR(50),
      HeaderMemo8 NATIONAL VARCHAR(50),
      HeaderMemo9 NATIONAL VARCHAR(50),
      LockedBy NATIONAL VARCHAR(36),
      LockTS DATETIME,
      AllowanceDiscountPerc FLOAT
   );
   DELETE FROM DelEDIOrderHeader;
   INSERT INTO DelEDIOrderHeader VALUES(OLD.CompanyID, OLD.DivisionID, OLD.DepartmentID, OLD.OrderNumber, OLD.TransactionTypeID, OLD.EDIDirectionTypeID, OLD.EDIDocumentTypeID, OLD.EDIOpen, OLD.OrderTypeID, OLD.OrderDate, OLD.OrderDueDate, OLD.OrderShipDate, OLD.OrderCancelDate, OLD.PurchaseOrderNumber, OLD.TaxExemptID, OLD.TaxGroupID, OLD.CustomerID, OLD.CustomerShipToID, OLD.CustomerShipForID, OLD.WarehouseID, OLD.CustomerDropShipment, OLD.ShippingName, OLD.ShippingAddress1, OLD.ShippingAddress2, OLD.ShippingCity, OLD.ShippingState, OLD.ShippingZip, OLD.ShippingCountry, OLD.ShipMethodID, OLD.EmployeeID, OLD.TermsID, OLD.PaymentMethodID, OLD.CurrencyID, OLD.CurrencyExchangeRate, OLD.Subtotal, OLD.DiscountPers, OLD.DiscountAmount, OLD.TaxPercent, OLD.TaxAmount, OLD.TaxableSubTotal, OLD.Freight, OLD.TaxFreight, OLD.Handling, OLD.Advertising, OLD.Total, OLD.AmountPaid, OLD.BalanceDue, OLD.UndistributedAmount, OLD.Commission, OLD.CommissionableSales, OLD.ComissionalbleCost, OLD.GLSalesAccount, OLD.CheckNumber, OLD.CheckDate, OLD.CreditCardTypeID, OLD.CreditCardName, OLD.CreditCardNumber, OLD.CreditCardExpDate, OLD.CreditCardCSVNumber, OLD.CreditCardBillToZip, OLD.CreditCardValidationCode, OLD.CreditCardApprovalNumber, OLD.Picked, OLD.PickedDate, OLD.Billed, OLD.BilledDate, OLD.Printed, OLD.PrintedDate, OLD.Shipped, OLD.ShipDate, OLD.TrackingNumber, OLD.Backordered, OLD.Invoiced, OLD.InvoiceNumber, OLD.InvoiceDate, OLD.Posted, OLD.PostedDate, OLD.MasterBillOfLading, OLD.MasterBillOfLadingDate, OLD.TrailerNumber, OLD.TrailerPrefix, OLD.HeaderMemo1, OLD.HeaderMemo2, OLD.HeaderMemo3, OLD.HeaderMemo4, OLD.HeaderMemo5, OLD.HeaderMemo6, OLD.HeaderMemo7, OLD.HeaderMemo8, OLD.HeaderMemo9, OLD.LockedBy, OLD.LockTS, OLD.AllowanceDiscountPerc);

   BEGIN
-- check for audit triggers switch off

      select   context_info INTO v_Context FROM sysprocesses WHERE spid = CONNECTION_ID();
      IF CAST(v_Context AS CHAR(36)) = N'$$AuditSwitchOff$$' then 
         LEAVE SWL_return;
      end if;

-- declarations
      OPEN cDelete;
-- fetch from each deleting record
      SET NO_DATA = 0;
      FETCH cDelete INTO
      v_TransactionNumber,v_TransactionLineNumber,v_CompanyID,v_DivisionID,v_DepartmentID,
      v_OrderNumber;
      WHILE NO_DATA = 0 DO
-- insert audit record for each deleting record
         CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber,v_TransactionLineNumber,
         'EDIOrderHeader','Deleted','','Deleted');
         SET NO_DATA = 0;
         FETCH cDelete INTO
         v_TransactionNumber,v_TransactionLineNumber,v_CompanyID,v_DivisionID,v_DepartmentID,
         v_OrderNumber;
      END WHILE;
      CLOSE cDelete;

   END;
END;
 ;;
delimiter ;

-- ----------------------------
--  Table structure for `edipaymentsdetail`
-- ----------------------------
DROP TABLE IF EXISTS `edipaymentsdetail`;
CREATE TABLE `edipaymentsdetail` (
  `CompanyID` varchar(36) NOT NULL,
  `DivisionID` varchar(36) NOT NULL,
  `DepartmentID` varchar(36) NOT NULL,
  `PaymentID` varchar(36) NOT NULL,
  `PaymentDetailID` bigint(20) NOT NULL AUTO_INCREMENT,
  `PayedID` varchar(36) DEFAULT NULL,
  `DocumentNumber` varchar(36) DEFAULT NULL,
  `DocumentDate` datetime DEFAULT NULL,
  `CurrencyID` varchar(3) DEFAULT NULL,
  `CurrencyExchangeRate` float DEFAULT NULL,
  `DiscountTaken` decimal(19,4) DEFAULT NULL,
  `WriteOffAmount` decimal(19,4) DEFAULT NULL,
  `AppliedAmount` decimal(19,4) DEFAULT NULL,
  `Cleared` tinyint(1) DEFAULT NULL,
  `GLExpenseAccount` varchar(36) DEFAULT NULL,
  `ProjectID` varchar(36) DEFAULT NULL,
  `LockedBy` varchar(36) DEFAULT NULL,
  `LockTS` datetime DEFAULT NULL,
  PRIMARY KEY (`PaymentDetailID`,`CompanyID`,`DivisionID`,`DepartmentID`,`PaymentID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
delimiter ;;
CREATE TRIGGER `EDIPaymentsDetail_Audit_Insert` AFTER INSERT ON `edipaymentsdetail` FOR EACH ROW SWL_return:
BEGIN
   DECLARE NO_DATA INT DEFAULT 0;
   DECLARE v_Context VARBINARY(128);
   DECLARE v_TransactionNumber NATIONAL VARCHAR(50);
   DECLARE v_TransactionLineNumber NATIONAL VARCHAR(50);

   DECLARE v_CompanyID NATIONAL VARCHAR(36);
   DECLARE v_DivisionID NATIONAL VARCHAR(36);
   DECLARE v_DepartmentID NATIONAL VARCHAR(36);
   DECLARE v_PaymentID NATIONAL VARCHAR(36);
   DECLARE v_PaymentDetailID NUMERIC(18,0);

-- inserting records cursor declaration
   DECLARE cInsert CURSOR
   FOR SELECT
   i.PaymentID
		,i.PaymentDetailID

		,i.CompanyID
		,i.DivisionID
		,i.DepartmentID
		,i.PaymentID
		,i.PaymentDetailID

   FROM
   InsEDIPaymentsDetail i;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET NO_DATA = -2;
   END;
   DECLARE CONTINUE HANDLER FOR NOT FOUND SET NO_DATA = -1;
   CREATE  TEMPORARY TABLE IF NOT EXISTS InsEDIPaymentsDetail
   (
      CompanyID NATIONAL VARCHAR(36),
      DivisionID NATIONAL VARCHAR(36),
      DepartmentID NATIONAL VARCHAR(36),
      PaymentID NATIONAL VARCHAR(36),
      PaymentDetailID NUMERIC(18,0),
      PayedID NATIONAL VARCHAR(36),
      DocumentNumber NATIONAL VARCHAR(36),
      DocumentDate DATETIME,
      CurrencyID NATIONAL VARCHAR(3),
      CurrencyExchangeRate FLOAT,
      DiscountTaken DECIMAL(19,4),
      WriteOffAmount DECIMAL(19,4),
      AppliedAmount DECIMAL(19,4),
      Cleared BOOLEAN,
      GLExpenseAccount NATIONAL VARCHAR(36),
      ProjectID NATIONAL VARCHAR(36),
      LockedBy NATIONAL VARCHAR(36),
      LockTS DATETIME
   );
   DELETE FROM InsEDIPaymentsDetail;
   INSERT INTO InsEDIPaymentsDetail VALUES(NEW.CompanyID, NEW.DivisionID, NEW.DepartmentID, NEW.PaymentID, NEW.PaymentDetailID, NEW.PayedID, NEW.DocumentNumber, NEW.DocumentDate, NEW.CurrencyID, NEW.CurrencyExchangeRate, NEW.DiscountTaken, NEW.WriteOffAmount, NEW.AppliedAmount, NEW.Cleared, NEW.GLExpenseAccount, NEW.ProjectID, NEW.LockedBy, NEW.LockTS);

   BEGIN
-- check for audit triggers switch off

      select   context_info INTO v_Context FROM sysprocesses WHERE spid = CONNECTION_ID();
      IF CAST(v_Context AS CHAR(36)) = N'$$AuditSwitchOff$$' then 
         LEAVE SWL_return;
      end if;

-- declarations
      OPEN cInsert;
-- fetch from each inserting record
      SET NO_DATA = 0;
      FETCH cInsert INTO
      v_TransactionNumber,v_TransactionLineNumber,v_CompanyID,v_DivisionID,v_DepartmentID,
      v_PaymentID,v_PaymentDetailID;
      WHILE NO_DATA = 0 DO
-- insert audit record for each inserting record
         IF IsGuid(v_TransactionNumber) = 0 then
		
            CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber,v_TransactionLineNumber,
            'EDIPaymentsDetail','New Record','','New Record');
         end if;
         SET NO_DATA = 0;
         FETCH cInsert INTO
         v_TransactionNumber,v_TransactionLineNumber,v_CompanyID,v_DivisionID,v_DepartmentID,
         v_PaymentID,v_PaymentDetailID;
      END WHILE;
      CLOSE cInsert;

   END;
END;
 ;;
delimiter ;
delimiter ;;
CREATE TRIGGER `EDIPaymentsDetail_Audit_Update` AFTER UPDATE ON `edipaymentsdetail` FOR EACH ROW SWL_return:
BEGIN
   DECLARE NO_DATA INT DEFAULT 0;
   DECLARE v_Context VARBINARY(128);
   DECLARE v_TransactionNumber_O NATIONAL VARCHAR(50);
   DECLARE v_TransactionNumber_N NATIONAL VARCHAR(50);
   DECLARE v_TransactionLineNumber NATIONAL VARCHAR(50);

   DECLARE v_CompanyID NATIONAL VARCHAR(36);
   DECLARE v_DivisionID NATIONAL VARCHAR(36);
   DECLARE v_DepartmentID NATIONAL VARCHAR(36);
   DECLARE v_PaymentID NATIONAL VARCHAR(36);
   DECLARE v_PaymentDetailID NUMERIC(18,0);

   DECLARE v_PayedID_O NATIONAL VARCHAR(80);
   DECLARE v_PayedID_N NATIONAL VARCHAR(80);
   DECLARE v_DocumentNumber_O NATIONAL VARCHAR(80);
   DECLARE v_DocumentNumber_N NATIONAL VARCHAR(80);
   DECLARE v_DocumentDate_O NATIONAL VARCHAR(80);
   DECLARE v_DocumentDate_N NATIONAL VARCHAR(80);
   DECLARE v_CurrencyID_O NATIONAL VARCHAR(80);
   DECLARE v_CurrencyID_N NATIONAL VARCHAR(80);
   DECLARE v_CurrencyExchangeRate_O NATIONAL VARCHAR(80);
   DECLARE v_CurrencyExchangeRate_N NATIONAL VARCHAR(80);
   DECLARE v_DiscountTaken_O NATIONAL VARCHAR(80);
   DECLARE v_DiscountTaken_N NATIONAL VARCHAR(80);
   DECLARE v_WriteOffAmount_O NATIONAL VARCHAR(80);
   DECLARE v_WriteOffAmount_N NATIONAL VARCHAR(80);
   DECLARE v_AppliedAmount_O NATIONAL VARCHAR(80);
   DECLARE v_AppliedAmount_N NATIONAL VARCHAR(80);
   DECLARE v_Cleared_O NATIONAL VARCHAR(80);
   DECLARE v_Cleared_N NATIONAL VARCHAR(80);
   DECLARE v_GLExpenseAccount_O NATIONAL VARCHAR(80);
   DECLARE v_GLExpenseAccount_N NATIONAL VARCHAR(80);
   DECLARE v_ProjectID_O NATIONAL VARCHAR(80);
   DECLARE v_ProjectID_N NATIONAL VARCHAR(80);
 

-- updating records cursor declaration
   DECLARE cUpdate CURSOR
   FOR SELECT
   d.PaymentID
		,i.PaymentID
		,i.PaymentDetailID

		,i.CompanyID
		,i.DivisionID
		,i.DepartmentID
		,i.PaymentID
		,i.PaymentDetailID

,CAST(d.PayedID AS CHAR(80))
,CAST(i.PayedID AS CHAR(80))
,CAST(d.DocumentNumber AS CHAR(80))
,CAST(i.DocumentNumber AS CHAR(80))
,CAST(d.DocumentDate AS CHAR(80))
,CAST(i.DocumentDate AS CHAR(80))
,CAST(d.CurrencyID AS CHAR(80))
,CAST(i.CurrencyID AS CHAR(80))
,CAST(d.CurrencyExchangeRate AS CHAR(80))
,CAST(i.CurrencyExchangeRate AS CHAR(80))
,CAST(d.DiscountTaken AS CHAR(80))
,CAST(i.DiscountTaken AS CHAR(80))
,CAST(d.WriteOffAmount AS CHAR(80))
,CAST(i.WriteOffAmount AS CHAR(80))
,CAST(d.AppliedAmount AS CHAR(80))
,CAST(i.AppliedAmount AS CHAR(80))
,CAST(d.Cleared AS CHAR(80))
,CAST(i.Cleared AS CHAR(80))
,CAST(d.GLExpenseAccount AS CHAR(80))
,CAST(i.GLExpenseAccount AS CHAR(80))
,CAST(d.ProjectID AS CHAR(80))
,CAST(i.ProjectID AS CHAR(80))
 

   FROM
   InsEDIPaymentsDetail i
   LEFT OUTER JOIN DelEDIPaymentsDetail d ON
   d.CompanyID = i.CompanyID
   AND d.DivisionID = i.DivisionID
   AND d.DepartmentID = i.DepartmentID
   AND d.PaymentID = i.PaymentID
   AND d.PaymentDetailID = i.PaymentDetailID;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET NO_DATA = -2;
   END;
   DECLARE CONTINUE HANDLER FOR NOT FOUND SET NO_DATA = -1;
   CREATE  TEMPORARY TABLE IF NOT EXISTS InsEDIPaymentsDetail
   (
      CompanyID NATIONAL VARCHAR(36),
      DivisionID NATIONAL VARCHAR(36),
      DepartmentID NATIONAL VARCHAR(36),
      PaymentID NATIONAL VARCHAR(36),
      PaymentDetailID NUMERIC(18,0),
      PayedID NATIONAL VARCHAR(36),
      DocumentNumber NATIONAL VARCHAR(36),
      DocumentDate DATETIME,
      CurrencyID NATIONAL VARCHAR(3),
      CurrencyExchangeRate FLOAT,
      DiscountTaken DECIMAL(19,4),
      WriteOffAmount DECIMAL(19,4),
      AppliedAmount DECIMAL(19,4),
      Cleared BOOLEAN,
      GLExpenseAccount NATIONAL VARCHAR(36),
      ProjectID NATIONAL VARCHAR(36),
      LockedBy NATIONAL VARCHAR(36),
      LockTS DATETIME
   );
   DELETE FROM InsEDIPaymentsDetail;
   INSERT INTO InsEDIPaymentsDetail VALUES(NEW.CompanyID, NEW.DivisionID, NEW.DepartmentID, NEW.PaymentID, NEW.PaymentDetailID, NEW.PayedID, NEW.DocumentNumber, NEW.DocumentDate, NEW.CurrencyID, NEW.CurrencyExchangeRate, NEW.DiscountTaken, NEW.WriteOffAmount, NEW.AppliedAmount, NEW.Cleared, NEW.GLExpenseAccount, NEW.ProjectID, NEW.LockedBy, NEW.LockTS);

   CREATE  TEMPORARY TABLE IF NOT EXISTS DelEDIPaymentsDetail
   (
      CompanyID NATIONAL VARCHAR(36),
      DivisionID NATIONAL VARCHAR(36),
      DepartmentID NATIONAL VARCHAR(36),
      PaymentID NATIONAL VARCHAR(36),
      PaymentDetailID NUMERIC(18,0),
      PayedID NATIONAL VARCHAR(36),
      DocumentNumber NATIONAL VARCHAR(36),
      DocumentDate DATETIME,
      CurrencyID NATIONAL VARCHAR(3),
      CurrencyExchangeRate FLOAT,
      DiscountTaken DECIMAL(19,4),
      WriteOffAmount DECIMAL(19,4),
      AppliedAmount DECIMAL(19,4),
      Cleared BOOLEAN,
      GLExpenseAccount NATIONAL VARCHAR(36),
      ProjectID NATIONAL VARCHAR(36),
      LockedBy NATIONAL VARCHAR(36),
      LockTS DATETIME
   );
   DELETE FROM DelEDIPaymentsDetail;
   INSERT INTO DelEDIPaymentsDetail VALUES(OLD.CompanyID, OLD.DivisionID, OLD.DepartmentID, OLD.PaymentID, OLD.PaymentDetailID, OLD.PayedID, OLD.DocumentNumber, OLD.DocumentDate, OLD.CurrencyID, OLD.CurrencyExchangeRate, OLD.DiscountTaken, OLD.WriteOffAmount, OLD.AppliedAmount, OLD.Cleared, OLD.GLExpenseAccount, OLD.ProjectID, OLD.LockedBy, OLD.LockTS);

   BEGIN
-- check for audit triggers switch off

      select   context_info INTO v_Context FROM sysprocesses WHERE spid = CONNECTION_ID();
      IF CAST(v_Context AS CHAR(36)) = N'$$AuditSwitchOff$$' then 
         LEAVE SWL_return;
      end if;

-- declarations
      OPEN cUpdate;
-- fetch from each updating record
      SET NO_DATA = 0;
      FETCH cUpdate INTO
      v_TransactionNumber_O,v_TransactionNumber_N,v_TransactionLineNumber,v_CompanyID,
      v_DivisionID,v_DepartmentID,v_PaymentID,v_PaymentDetailID,v_PayedID_O,
      v_PayedID_N,v_DocumentNumber_O,v_DocumentNumber_N,v_DocumentDate_O,
      v_DocumentDate_N,v_CurrencyID_O,v_CurrencyID_N,v_CurrencyExchangeRate_O,
      v_CurrencyExchangeRate_N,v_DiscountTaken_O,v_DiscountTaken_N,
      v_WriteOffAmount_O,v_WriteOffAmount_N,v_AppliedAmount_O,v_AppliedAmount_N,
      v_Cleared_O,v_Cleared_N,v_GLExpenseAccount_O,v_GLExpenseAccount_N,
      v_ProjectID_O,v_ProjectID_N;
      WHILE NO_DATA = 0 DO
-- insert audit records for each changed field
         IF IsGuid(v_TransactionNumber_N) = 0 then
		
            IF v_TransactionNumber_O IS NULL then
				
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIPaymentsDetail','New Record','','New Record');
            ELSE
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIPaymentsDetail','PayedID',v_PayedID_O,v_PayedID_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIPaymentsDetail','DocumentNumber',v_DocumentNumber_O,
               v_DocumentNumber_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIPaymentsDetail','DocumentDate',v_DocumentDate_O,
               v_DocumentDate_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIPaymentsDetail','CurrencyID',v_CurrencyID_O,
               v_CurrencyID_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIPaymentsDetail','CurrencyExchangeRate',v_CurrencyExchangeRate_O,
               v_CurrencyExchangeRate_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIPaymentsDetail','DiscountTaken',v_DiscountTaken_O,
               v_DiscountTaken_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIPaymentsDetail','WriteOffAmount',v_WriteOffAmount_O,
               v_WriteOffAmount_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIPaymentsDetail','AppliedAmount',v_AppliedAmount_O,
               v_AppliedAmount_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIPaymentsDetail','Cleared',v_Cleared_O,v_Cleared_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIPaymentsDetail','GLExpenseAccount',v_GLExpenseAccount_O,
               v_GLExpenseAccount_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIPaymentsDetail','ProjectID',v_ProjectID_O,v_ProjectID_N);
            end if;
         end if;
         SET NO_DATA = 0;
         FETCH cUpdate INTO
         v_TransactionNumber_O,v_TransactionNumber_N,v_TransactionLineNumber,v_CompanyID,
         v_DivisionID,v_DepartmentID,v_PaymentID,v_PaymentDetailID,v_PayedID_O,
         v_PayedID_N,v_DocumentNumber_O,v_DocumentNumber_N,v_DocumentDate_O,
         v_DocumentDate_N,v_CurrencyID_O,v_CurrencyID_N,v_CurrencyExchangeRate_O,
         v_CurrencyExchangeRate_N,v_DiscountTaken_O,v_DiscountTaken_N,
         v_WriteOffAmount_O,v_WriteOffAmount_N,v_AppliedAmount_O,v_AppliedAmount_N,
         v_Cleared_O,v_Cleared_N,v_GLExpenseAccount_O,v_GLExpenseAccount_N,
         v_ProjectID_O,v_ProjectID_N;
      END WHILE;
      CLOSE cUpdate;

   END;
END;
 ;;
delimiter ;
delimiter ;;
CREATE TRIGGER `EDIPaymentsDetail_Audit_Delete` AFTER DELETE ON `edipaymentsdetail` FOR EACH ROW SWL_return:
BEGIN
   DECLARE NO_DATA INT DEFAULT 0;
   DECLARE v_Context VARBINARY(128);
   DECLARE v_TransactionNumber NATIONAL VARCHAR(50);
   DECLARE v_TransactionLineNumber NATIONAL VARCHAR(50);

   DECLARE v_CompanyID NATIONAL VARCHAR(36);
   DECLARE v_DivisionID NATIONAL VARCHAR(36);
   DECLARE v_DepartmentID NATIONAL VARCHAR(36);
   DECLARE v_PaymentID NATIONAL VARCHAR(36);
   DECLARE v_PaymentDetailID NUMERIC(18,0);

-- deleting records cursor declaration
   DECLARE cDelete CURSOR
   FOR SELECT
   d.PaymentID
		,d.PaymentDetailID

		,d.CompanyID
		,d.DivisionID
		,d.DepartmentID
		,d.PaymentID
		,d.PaymentDetailID

   FROM
   DelEDIPaymentsDetail d;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET NO_DATA = -2;
   END;
   DECLARE CONTINUE HANDLER FOR NOT FOUND SET NO_DATA = -1;
   CREATE  TEMPORARY TABLE IF NOT EXISTS DelEDIPaymentsDetail
   (
      CompanyID NATIONAL VARCHAR(36),
      DivisionID NATIONAL VARCHAR(36),
      DepartmentID NATIONAL VARCHAR(36),
      PaymentID NATIONAL VARCHAR(36),
      PaymentDetailID NUMERIC(18,0),
      PayedID NATIONAL VARCHAR(36),
      DocumentNumber NATIONAL VARCHAR(36),
      DocumentDate DATETIME,
      CurrencyID NATIONAL VARCHAR(3),
      CurrencyExchangeRate FLOAT,
      DiscountTaken DECIMAL(19,4),
      WriteOffAmount DECIMAL(19,4),
      AppliedAmount DECIMAL(19,4),
      Cleared BOOLEAN,
      GLExpenseAccount NATIONAL VARCHAR(36),
      ProjectID NATIONAL VARCHAR(36),
      LockedBy NATIONAL VARCHAR(36),
      LockTS DATETIME
   );
   DELETE FROM DelEDIPaymentsDetail;
   INSERT INTO DelEDIPaymentsDetail VALUES(OLD.CompanyID, OLD.DivisionID, OLD.DepartmentID, OLD.PaymentID, OLD.PaymentDetailID, OLD.PayedID, OLD.DocumentNumber, OLD.DocumentDate, OLD.CurrencyID, OLD.CurrencyExchangeRate, OLD.DiscountTaken, OLD.WriteOffAmount, OLD.AppliedAmount, OLD.Cleared, OLD.GLExpenseAccount, OLD.ProjectID, OLD.LockedBy, OLD.LockTS);

   BEGIN
-- check for audit triggers switch off

      select   context_info INTO v_Context FROM sysprocesses WHERE spid = CONNECTION_ID();
      IF CAST(v_Context AS CHAR(36)) = N'$$AuditSwitchOff$$' then 
         LEAVE SWL_return;
      end if;

-- declarations
      OPEN cDelete;
-- fetch from each deleting record
      SET NO_DATA = 0;
      FETCH cDelete INTO
      v_TransactionNumber,v_TransactionLineNumber,v_CompanyID,v_DivisionID,v_DepartmentID,
      v_PaymentID,v_PaymentDetailID;
      WHILE NO_DATA = 0 DO
-- insert audit record for each deleting record
         CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber,v_TransactionLineNumber,
         'EDIPaymentsDetail','Deleted','','Deleted');
         SET NO_DATA = 0;
         FETCH cDelete INTO
         v_TransactionNumber,v_TransactionLineNumber,v_CompanyID,v_DivisionID,v_DepartmentID,
         v_PaymentID,v_PaymentDetailID;
      END WHILE;
      CLOSE cDelete;

   END;
END;
 ;;
delimiter ;

-- ----------------------------
--  Table structure for `edipaymentsheader`
-- ----------------------------
DROP TABLE IF EXISTS `edipaymentsheader`;
CREATE TABLE `edipaymentsheader` (
  `CompanyID` varchar(36) NOT NULL,
  `DivisionID` varchar(36) NOT NULL,
  `DepartmentID` varchar(36) NOT NULL,
  `PaymentID` varchar(36) NOT NULL,
  `PaymentTypeID` varchar(36) DEFAULT NULL,
  `EDIDirectionTypeID` varchar(1) DEFAULT NULL,
  `EDIDocumentTypeID` varchar(3) DEFAULT NULL,
  `EDIOpen` tinyint(1) DEFAULT NULL,
  `CheckNumber` varchar(20) DEFAULT NULL,
  `CheckPrinted` tinyint(1) DEFAULT NULL,
  `CheckDate` datetime DEFAULT NULL,
  `Paid` tinyint(1) DEFAULT NULL,
  `PaymentDate` datetime DEFAULT NULL,
  `PaymentClassID` varchar(36) DEFAULT NULL,
  `VendorID` varchar(50) DEFAULT NULL,
  `SystemDate` datetime DEFAULT NULL,
  `Amount` decimal(19,4) DEFAULT NULL,
  `UnAppliedAmount` decimal(19,4) DEFAULT NULL,
  `GLBankAccount` varchar(36) DEFAULT NULL,
  `PaymentStatus` varchar(10) DEFAULT NULL,
  `Void` tinyint(1) DEFAULT NULL,
  `Notes` varchar(255) DEFAULT NULL,
  `CurrencyID` varchar(3) DEFAULT NULL,
  `CurrencyExchangeRate` float DEFAULT NULL,
  `CreditAmount` decimal(19,4) DEFAULT NULL,
  `SelectedForPayment` tinyint(1) DEFAULT NULL,
  `SelectedForPaymentDate` datetime DEFAULT NULL,
  `ApprovedForPayment` tinyint(1) DEFAULT NULL,
  `ApprovedForPaymentDate` datetime DEFAULT NULL,
  `Cleared` tinyint(1) DEFAULT NULL,
  `InvoiceNumber` varchar(36) DEFAULT NULL,
  `Posted` tinyint(1) DEFAULT NULL,
  `Reconciled` tinyint(1) DEFAULT NULL,
  `Credit` tinyint(1) DEFAULT NULL,
  `LockedBy` varchar(36) DEFAULT NULL,
  `LockTS` datetime DEFAULT NULL,
  PRIMARY KEY (`CompanyID`,`DivisionID`,`DepartmentID`,`PaymentID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
delimiter ;;
CREATE TRIGGER `EDIPaymentsHeader_Audit_Insert` AFTER INSERT ON `edipaymentsheader` FOR EACH ROW SWL_return:
BEGIN
   DECLARE NO_DATA INT DEFAULT 0;
   DECLARE v_Context VARBINARY(128);
   DECLARE v_TransactionNumber NATIONAL VARCHAR(50);
   DECLARE v_TransactionLineNumber NATIONAL VARCHAR(50);

   DECLARE v_CompanyID NATIONAL VARCHAR(36);
   DECLARE v_DivisionID NATIONAL VARCHAR(36);
   DECLARE v_DepartmentID NATIONAL VARCHAR(36);
   DECLARE v_PaymentID NATIONAL VARCHAR(36);

-- inserting records cursor declaration
   DECLARE cInsert CURSOR
   FOR SELECT
   i.PaymentID
		,''

		,i.CompanyID
		,i.DivisionID
		,i.DepartmentID
		,i.PaymentID

   FROM
   InsEDIPaymentsHeader i;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET NO_DATA = -2;
   END;
   DECLARE CONTINUE HANDLER FOR NOT FOUND SET NO_DATA = -1;
   CREATE  TEMPORARY TABLE IF NOT EXISTS InsEDIPaymentsHeader
   (
      CompanyID NATIONAL VARCHAR(36),
      DivisionID NATIONAL VARCHAR(36),
      DepartmentID NATIONAL VARCHAR(36),
      PaymentID NATIONAL VARCHAR(36),
      PaymentTypeID NATIONAL VARCHAR(36),
      EDIDirectionTypeID NATIONAL VARCHAR(1),
      EDIDocumentTypeID NATIONAL VARCHAR(3),
      EDIOpen BOOLEAN,
      CheckNumber NATIONAL VARCHAR(20),
      CheckPrinted BOOLEAN,
      CheckDate DATETIME,
      Paid BOOLEAN,
      PaymentDate DATETIME,
      PaymentClassID NATIONAL VARCHAR(36),
      VendorID NATIONAL VARCHAR(50),
      SystemDate DATETIME,
      Amount DECIMAL(19,4),
      UnAppliedAmount DECIMAL(19,4),
      GLBankAccount NATIONAL VARCHAR(36),
      PaymentStatus NATIONAL VARCHAR(10),
      Void BOOLEAN,
      Notes NATIONAL VARCHAR(255),
      CurrencyID NATIONAL VARCHAR(3),
      CurrencyExchangeRate FLOAT,
      CreditAmount DECIMAL(19,4),
      SelectedForPayment BOOLEAN,
      SelectedForPaymentDate DATETIME,
      ApprovedForPayment BOOLEAN,
      ApprovedForPaymentDate DATETIME,
      Cleared BOOLEAN,
      InvoiceNumber NATIONAL VARCHAR(36),
      Posted BOOLEAN,
      Reconciled BOOLEAN,
      Credit BOOLEAN,
      LockedBy NATIONAL VARCHAR(36),
      LockTS DATETIME
   );
   DELETE FROM InsEDIPaymentsHeader;
   INSERT INTO InsEDIPaymentsHeader VALUES(NEW.CompanyID, NEW.DivisionID, NEW.DepartmentID, NEW.PaymentID, NEW.PaymentTypeID, NEW.EDIDirectionTypeID, NEW.EDIDocumentTypeID, NEW.EDIOpen, NEW.CheckNumber, NEW.CheckPrinted, NEW.CheckDate, NEW.Paid, NEW.PaymentDate, NEW.PaymentClassID, NEW.VendorID, NEW.SystemDate, NEW.Amount, NEW.UnAppliedAmount, NEW.GLBankAccount, NEW.PaymentStatus, NEW.Void, NEW.Notes, NEW.CurrencyID, NEW.CurrencyExchangeRate, NEW.CreditAmount, NEW.SelectedForPayment, NEW.SelectedForPaymentDate, NEW.ApprovedForPayment, NEW.ApprovedForPaymentDate, NEW.Cleared, NEW.InvoiceNumber, NEW.Posted, NEW.Reconciled, NEW.Credit, NEW.LockedBy, NEW.LockTS);

   BEGIN
-- check for audit triggers switch off

      select   context_info INTO v_Context FROM sysprocesses WHERE spid = CONNECTION_ID();
      IF CAST(v_Context AS CHAR(36)) = N'$$AuditSwitchOff$$' then 
         LEAVE SWL_return;
      end if;

-- declarations
      OPEN cInsert;
-- fetch from each inserting record
      SET NO_DATA = 0;
      FETCH cInsert INTO
      v_TransactionNumber,v_TransactionLineNumber,v_CompanyID,v_DivisionID,v_DepartmentID,
      v_PaymentID;
      WHILE NO_DATA = 0 DO
-- insert audit record for each inserting record
         IF IsGuid(v_TransactionNumber) = 0 then
		
            CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber,v_TransactionLineNumber,
            'EDIPaymentsHeader','New Record','','New Record');
         end if;
         SET NO_DATA = 0;
         FETCH cInsert INTO
         v_TransactionNumber,v_TransactionLineNumber,v_CompanyID,v_DivisionID,v_DepartmentID,
         v_PaymentID;
      END WHILE;
      CLOSE cInsert;

   END;
END;
 ;;
delimiter ;
delimiter ;;
CREATE TRIGGER `EDIPaymentsHeader_Audit_Update` AFTER UPDATE ON `edipaymentsheader` FOR EACH ROW SWL_return:
BEGIN
   DECLARE NO_DATA INT DEFAULT 0;
   DECLARE v_Context VARBINARY(128);
   DECLARE v_TransactionNumber_O NATIONAL VARCHAR(50);
   DECLARE v_TransactionNumber_N NATIONAL VARCHAR(50);
   DECLARE v_TransactionLineNumber NATIONAL VARCHAR(50);

   DECLARE v_CompanyID NATIONAL VARCHAR(36);
   DECLARE v_DivisionID NATIONAL VARCHAR(36);
   DECLARE v_DepartmentID NATIONAL VARCHAR(36);
   DECLARE v_PaymentID NATIONAL VARCHAR(36);

   DECLARE v_PaymentTypeID_O NATIONAL VARCHAR(80);
   DECLARE v_PaymentTypeID_N NATIONAL VARCHAR(80);
   DECLARE v_EDIDirectionTypeID_O NATIONAL VARCHAR(80);
   DECLARE v_EDIDirectionTypeID_N NATIONAL VARCHAR(80);
   DECLARE v_EDIDocumentTypeID_O NATIONAL VARCHAR(80);
   DECLARE v_EDIDocumentTypeID_N NATIONAL VARCHAR(80);
   DECLARE v_EDIOpen_O NATIONAL VARCHAR(80);
   DECLARE v_EDIOpen_N NATIONAL VARCHAR(80);
   DECLARE v_CheckNumber_O NATIONAL VARCHAR(80);
   DECLARE v_CheckNumber_N NATIONAL VARCHAR(80);
   DECLARE v_CheckPrinted_O NATIONAL VARCHAR(80);
   DECLARE v_CheckPrinted_N NATIONAL VARCHAR(80);
   DECLARE v_CheckDate_O NATIONAL VARCHAR(80);
   DECLARE v_CheckDate_N NATIONAL VARCHAR(80);
   DECLARE v_Paid_O NATIONAL VARCHAR(80);
   DECLARE v_Paid_N NATIONAL VARCHAR(80);
   DECLARE v_PaymentDate_O NATIONAL VARCHAR(80);
   DECLARE v_PaymentDate_N NATIONAL VARCHAR(80);
   DECLARE v_PaymentClassID_O NATIONAL VARCHAR(80);
   DECLARE v_PaymentClassID_N NATIONAL VARCHAR(80);
   DECLARE v_VendorID_O NATIONAL VARCHAR(80);
   DECLARE v_VendorID_N NATIONAL VARCHAR(80);
   DECLARE v_SystemDate_O NATIONAL VARCHAR(80);
   DECLARE v_SystemDate_N NATIONAL VARCHAR(80);
   DECLARE v_Amount_O NATIONAL VARCHAR(80);
   DECLARE v_Amount_N NATIONAL VARCHAR(80);
   DECLARE v_UnAppliedAmount_O NATIONAL VARCHAR(80);
   DECLARE v_UnAppliedAmount_N NATIONAL VARCHAR(80);
   DECLARE v_GLBankAccount_O NATIONAL VARCHAR(80);
   DECLARE v_GLBankAccount_N NATIONAL VARCHAR(80);
   DECLARE v_PaymentStatus_O NATIONAL VARCHAR(80);
   DECLARE v_PaymentStatus_N NATIONAL VARCHAR(80);
   DECLARE v_Void_O NATIONAL VARCHAR(80);
   DECLARE v_Void_N NATIONAL VARCHAR(80);
   DECLARE v_Notes_O NATIONAL VARCHAR(80);
   DECLARE v_Notes_N NATIONAL VARCHAR(80);
   DECLARE v_CurrencyID_O NATIONAL VARCHAR(80);
   DECLARE v_CurrencyID_N NATIONAL VARCHAR(80);
   DECLARE v_CurrencyExchangeRate_O NATIONAL VARCHAR(80);
   DECLARE v_CurrencyExchangeRate_N NATIONAL VARCHAR(80);
   DECLARE v_CreditAmount_O NATIONAL VARCHAR(80);
   DECLARE v_CreditAmount_N NATIONAL VARCHAR(80);
   DECLARE v_SelectedForPayment_O NATIONAL VARCHAR(80);
   DECLARE v_SelectedForPayment_N NATIONAL VARCHAR(80);
   DECLARE v_SelectedForPaymentDate_O NATIONAL VARCHAR(80);
   DECLARE v_SelectedForPaymentDate_N NATIONAL VARCHAR(80);
   DECLARE v_ApprovedForPayment_O NATIONAL VARCHAR(80);
   DECLARE v_ApprovedForPayment_N NATIONAL VARCHAR(80);
   DECLARE v_ApprovedForPaymentDate_O NATIONAL VARCHAR(80);
   DECLARE v_ApprovedForPaymentDate_N NATIONAL VARCHAR(80);
   DECLARE v_Cleared_O NATIONAL VARCHAR(80);
   DECLARE v_Cleared_N NATIONAL VARCHAR(80);
   DECLARE v_InvoiceNumber_O NATIONAL VARCHAR(80);
   DECLARE v_InvoiceNumber_N NATIONAL VARCHAR(80);
   DECLARE v_Posted_O NATIONAL VARCHAR(80);
   DECLARE v_Posted_N NATIONAL VARCHAR(80);
   DECLARE v_Reconciled_O NATIONAL VARCHAR(80);
   DECLARE v_Reconciled_N NATIONAL VARCHAR(80);
   DECLARE v_Credit_O NATIONAL VARCHAR(80);
   DECLARE v_Credit_N NATIONAL VARCHAR(80);
 

-- updating records cursor declaration
   DECLARE cUpdate CURSOR
   FOR SELECT
   d.PaymentID
		,i.PaymentID
		,''

		,i.CompanyID
		,i.DivisionID
		,i.DepartmentID
		,i.PaymentID

,CAST(d.PaymentTypeID AS CHAR(80))
,CAST(i.PaymentTypeID AS CHAR(80))
,CAST(d.EDIDirectionTypeID AS CHAR(80))
,CAST(i.EDIDirectionTypeID AS CHAR(80))
,CAST(d.EDIDocumentTypeID AS CHAR(80))
,CAST(i.EDIDocumentTypeID AS CHAR(80))
,CAST(d.EDIOpen AS CHAR(80))
,CAST(i.EDIOpen AS CHAR(80))
,CAST(d.CheckNumber AS CHAR(80))
,CAST(i.CheckNumber AS CHAR(80))
,CAST(d.CheckPrinted AS CHAR(80))
,CAST(i.CheckPrinted AS CHAR(80))
,CAST(d.CheckDate AS CHAR(80))
,CAST(i.CheckDate AS CHAR(80))
,CAST(d.Paid AS CHAR(80))
,CAST(i.Paid AS CHAR(80))
,CAST(d.PaymentDate AS CHAR(80))
,CAST(i.PaymentDate AS CHAR(80))
,CAST(d.PaymentClassID AS CHAR(80))
,CAST(i.PaymentClassID AS CHAR(80))
,CAST(d.VendorID AS CHAR(80))
,CAST(i.VendorID AS CHAR(80))
,CAST(d.SystemDate AS CHAR(80))
,CAST(i.SystemDate AS CHAR(80))
,CAST(d.Amount AS CHAR(80))
,CAST(i.Amount AS CHAR(80))
,CAST(d.UnAppliedAmount AS CHAR(80))
,CAST(i.UnAppliedAmount AS CHAR(80))
,CAST(d.GLBankAccount AS CHAR(80))
,CAST(i.GLBankAccount AS CHAR(80))
,CAST(d.PaymentStatus AS CHAR(80))
,CAST(i.PaymentStatus AS CHAR(80))
,CAST(d.Void AS CHAR(80))
,CAST(i.Void AS CHAR(80))
,CAST(d.Notes AS CHAR(80))
,CAST(i.Notes AS CHAR(80))
,CAST(d.CurrencyID AS CHAR(80))
,CAST(i.CurrencyID AS CHAR(80))
,CAST(d.CurrencyExchangeRate AS CHAR(80))
,CAST(i.CurrencyExchangeRate AS CHAR(80))
,CAST(d.CreditAmount AS CHAR(80))
,CAST(i.CreditAmount AS CHAR(80))
,CAST(d.SelectedForPayment AS CHAR(80))
,CAST(i.SelectedForPayment AS CHAR(80))
,CAST(d.SelectedForPaymentDate AS CHAR(80))
,CAST(i.SelectedForPaymentDate AS CHAR(80))
,CAST(d.ApprovedForPayment AS CHAR(80))
,CAST(i.ApprovedForPayment AS CHAR(80))
,CAST(d.ApprovedForPaymentDate AS CHAR(80))
,CAST(i.ApprovedForPaymentDate AS CHAR(80))
,CAST(d.Cleared AS CHAR(80))
,CAST(i.Cleared AS CHAR(80))
,CAST(d.InvoiceNumber AS CHAR(80))
,CAST(i.InvoiceNumber AS CHAR(80))
,CAST(d.Posted AS CHAR(80))
,CAST(i.Posted AS CHAR(80))
,CAST(d.Reconciled AS CHAR(80))
,CAST(i.Reconciled AS CHAR(80))
,CAST(d.Credit AS CHAR(80))
,CAST(i.Credit AS CHAR(80))
 

   FROM
   InsEDIPaymentsHeader i
   LEFT OUTER JOIN DelEDIPaymentsHeader d ON
   d.CompanyID = i.CompanyID
   AND d.DivisionID = i.DivisionID
   AND d.DepartmentID = i.DepartmentID
   AND d.PaymentID = i.PaymentID;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET NO_DATA = -2;
   END;
   DECLARE CONTINUE HANDLER FOR NOT FOUND SET NO_DATA = -1;
   CREATE  TEMPORARY TABLE IF NOT EXISTS InsEDIPaymentsHeader
   (
      CompanyID NATIONAL VARCHAR(36),
      DivisionID NATIONAL VARCHAR(36),
      DepartmentID NATIONAL VARCHAR(36),
      PaymentID NATIONAL VARCHAR(36),
      PaymentTypeID NATIONAL VARCHAR(36),
      EDIDirectionTypeID NATIONAL VARCHAR(1),
      EDIDocumentTypeID NATIONAL VARCHAR(3),
      EDIOpen BOOLEAN,
      CheckNumber NATIONAL VARCHAR(20),
      CheckPrinted BOOLEAN,
      CheckDate DATETIME,
      Paid BOOLEAN,
      PaymentDate DATETIME,
      PaymentClassID NATIONAL VARCHAR(36),
      VendorID NATIONAL VARCHAR(50),
      SystemDate DATETIME,
      Amount DECIMAL(19,4),
      UnAppliedAmount DECIMAL(19,4),
      GLBankAccount NATIONAL VARCHAR(36),
      PaymentStatus NATIONAL VARCHAR(10),
      Void BOOLEAN,
      Notes NATIONAL VARCHAR(255),
      CurrencyID NATIONAL VARCHAR(3),
      CurrencyExchangeRate FLOAT,
      CreditAmount DECIMAL(19,4),
      SelectedForPayment BOOLEAN,
      SelectedForPaymentDate DATETIME,
      ApprovedForPayment BOOLEAN,
      ApprovedForPaymentDate DATETIME,
      Cleared BOOLEAN,
      InvoiceNumber NATIONAL VARCHAR(36),
      Posted BOOLEAN,
      Reconciled BOOLEAN,
      Credit BOOLEAN,
      LockedBy NATIONAL VARCHAR(36),
      LockTS DATETIME
   );
   DELETE FROM InsEDIPaymentsHeader;
   INSERT INTO InsEDIPaymentsHeader VALUES(NEW.CompanyID, NEW.DivisionID, NEW.DepartmentID, NEW.PaymentID, NEW.PaymentTypeID, NEW.EDIDirectionTypeID, NEW.EDIDocumentTypeID, NEW.EDIOpen, NEW.CheckNumber, NEW.CheckPrinted, NEW.CheckDate, NEW.Paid, NEW.PaymentDate, NEW.PaymentClassID, NEW.VendorID, NEW.SystemDate, NEW.Amount, NEW.UnAppliedAmount, NEW.GLBankAccount, NEW.PaymentStatus, NEW.Void, NEW.Notes, NEW.CurrencyID, NEW.CurrencyExchangeRate, NEW.CreditAmount, NEW.SelectedForPayment, NEW.SelectedForPaymentDate, NEW.ApprovedForPayment, NEW.ApprovedForPaymentDate, NEW.Cleared, NEW.InvoiceNumber, NEW.Posted, NEW.Reconciled, NEW.Credit, NEW.LockedBy, NEW.LockTS);

   CREATE  TEMPORARY TABLE IF NOT EXISTS DelEDIPaymentsHeader
   (
      CompanyID NATIONAL VARCHAR(36),
      DivisionID NATIONAL VARCHAR(36),
      DepartmentID NATIONAL VARCHAR(36),
      PaymentID NATIONAL VARCHAR(36),
      PaymentTypeID NATIONAL VARCHAR(36),
      EDIDirectionTypeID NATIONAL VARCHAR(1),
      EDIDocumentTypeID NATIONAL VARCHAR(3),
      EDIOpen BOOLEAN,
      CheckNumber NATIONAL VARCHAR(20),
      CheckPrinted BOOLEAN,
      CheckDate DATETIME,
      Paid BOOLEAN,
      PaymentDate DATETIME,
      PaymentClassID NATIONAL VARCHAR(36),
      VendorID NATIONAL VARCHAR(50),
      SystemDate DATETIME,
      Amount DECIMAL(19,4),
      UnAppliedAmount DECIMAL(19,4),
      GLBankAccount NATIONAL VARCHAR(36),
      PaymentStatus NATIONAL VARCHAR(10),
      Void BOOLEAN,
      Notes NATIONAL VARCHAR(255),
      CurrencyID NATIONAL VARCHAR(3),
      CurrencyExchangeRate FLOAT,
      CreditAmount DECIMAL(19,4),
      SelectedForPayment BOOLEAN,
      SelectedForPaymentDate DATETIME,
      ApprovedForPayment BOOLEAN,
      ApprovedForPaymentDate DATETIME,
      Cleared BOOLEAN,
      InvoiceNumber NATIONAL VARCHAR(36),
      Posted BOOLEAN,
      Reconciled BOOLEAN,
      Credit BOOLEAN,
      LockedBy NATIONAL VARCHAR(36),
      LockTS DATETIME
   );
   DELETE FROM DelEDIPaymentsHeader;
   INSERT INTO DelEDIPaymentsHeader VALUES(OLD.CompanyID, OLD.DivisionID, OLD.DepartmentID, OLD.PaymentID, OLD.PaymentTypeID, OLD.EDIDirectionTypeID, OLD.EDIDocumentTypeID, OLD.EDIOpen, OLD.CheckNumber, OLD.CheckPrinted, OLD.CheckDate, OLD.Paid, OLD.PaymentDate, OLD.PaymentClassID, OLD.VendorID, OLD.SystemDate, OLD.Amount, OLD.UnAppliedAmount, OLD.GLBankAccount, OLD.PaymentStatus, OLD.Void, OLD.Notes, OLD.CurrencyID, OLD.CurrencyExchangeRate, OLD.CreditAmount, OLD.SelectedForPayment, OLD.SelectedForPaymentDate, OLD.ApprovedForPayment, OLD.ApprovedForPaymentDate, OLD.Cleared, OLD.InvoiceNumber, OLD.Posted, OLD.Reconciled, OLD.Credit, OLD.LockedBy, OLD.LockTS);

   BEGIN
-- check for audit triggers switch off

      select   context_info INTO v_Context FROM sysprocesses WHERE spid = CONNECTION_ID();
      IF CAST(v_Context AS CHAR(36)) = N'$$AuditSwitchOff$$' then 
         LEAVE SWL_return;
      end if;

-- declarations
      OPEN cUpdate;
-- fetch from each updating record
      SET NO_DATA = 0;
      FETCH cUpdate INTO
      v_TransactionNumber_O,v_TransactionNumber_N,v_TransactionLineNumber,v_CompanyID,
      v_DivisionID,v_DepartmentID,v_PaymentID,v_PaymentTypeID_O,v_PaymentTypeID_N,
      v_EDIDirectionTypeID_O,v_EDIDirectionTypeID_N,v_EDIDocumentTypeID_O,
      v_EDIDocumentTypeID_N,v_EDIOpen_O,v_EDIOpen_N,v_CheckNumber_O,
      v_CheckNumber_N,v_CheckPrinted_O,v_CheckPrinted_N,v_CheckDate_O,
      v_CheckDate_N,v_Paid_O,v_Paid_N,v_PaymentDate_O,v_PaymentDate_N,v_PaymentClassID_O,
      v_PaymentClassID_N,v_VendorID_O,v_VendorID_N,v_SystemDate_O,
      v_SystemDate_N,v_Amount_O,v_Amount_N,v_UnAppliedAmount_O,v_UnAppliedAmount_N,
      v_GLBankAccount_O,v_GLBankAccount_N,v_PaymentStatus_O,v_PaymentStatus_N,
      v_Void_O,v_Void_N,v_Notes_O,v_Notes_N,v_CurrencyID_O,v_CurrencyID_N,
      v_CurrencyExchangeRate_O,v_CurrencyExchangeRate_N,v_CreditAmount_O,
      v_CreditAmount_N,v_SelectedForPayment_O,v_SelectedForPayment_N,
      v_SelectedForPaymentDate_O,v_SelectedForPaymentDate_N,v_ApprovedForPayment_O,
      v_ApprovedForPayment_N,v_ApprovedForPaymentDate_O,v_ApprovedForPaymentDate_N,
      v_Cleared_O,v_Cleared_N,v_InvoiceNumber_O,v_InvoiceNumber_N,
      v_Posted_O,v_Posted_N,v_Reconciled_O,v_Reconciled_N,v_Credit_O,v_Credit_N;
      WHILE NO_DATA = 0 DO
-- insert audit records for each changed field
         IF IsGuid(v_TransactionNumber_N) = 0 then
		
            IF v_TransactionNumber_O IS NULL then
				
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIPaymentsHeader','New Record','','New Record');
            ELSE
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIPaymentsHeader','PaymentTypeID',v_PaymentTypeID_O,
               v_PaymentTypeID_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIPaymentsHeader','EDIDirectionTypeID',v_EDIDirectionTypeID_O,
               v_EDIDirectionTypeID_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIPaymentsHeader','EDIDocumentTypeID',v_EDIDocumentTypeID_O,
               v_EDIDocumentTypeID_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIPaymentsHeader','EDIOpen',v_EDIOpen_O,v_EDIOpen_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIPaymentsHeader','CheckNumber',v_CheckNumber_O,
               v_CheckNumber_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIPaymentsHeader','CheckPrinted',v_CheckPrinted_O,
               v_CheckPrinted_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIPaymentsHeader','CheckDate',v_CheckDate_O,v_CheckDate_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIPaymentsHeader','Paid',v_Paid_O,v_Paid_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIPaymentsHeader','PaymentDate',v_PaymentDate_O,
               v_PaymentDate_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIPaymentsHeader','PaymentClassID',v_PaymentClassID_O,
               v_PaymentClassID_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIPaymentsHeader','VendorID',v_VendorID_O,v_VendorID_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIPaymentsHeader','SystemDate',v_SystemDate_O,
               v_SystemDate_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIPaymentsHeader','Amount',v_Amount_O,v_Amount_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIPaymentsHeader','UnAppliedAmount',v_UnAppliedAmount_O,
               v_UnAppliedAmount_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIPaymentsHeader','GLBankAccount',v_GLBankAccount_O,
               v_GLBankAccount_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIPaymentsHeader','PaymentStatus',v_PaymentStatus_O,
               v_PaymentStatus_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIPaymentsHeader','Void',v_Void_O,v_Void_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIPaymentsHeader','Notes',v_Notes_O,v_Notes_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIPaymentsHeader','CurrencyID',v_CurrencyID_O,
               v_CurrencyID_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIPaymentsHeader','CurrencyExchangeRate',v_CurrencyExchangeRate_O,
               v_CurrencyExchangeRate_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIPaymentsHeader','CreditAmount',v_CreditAmount_O,
               v_CreditAmount_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIPaymentsHeader','SelectedForPayment',v_SelectedForPayment_O,
               v_SelectedForPayment_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIPaymentsHeader','SelectedForPaymentDate',v_SelectedForPaymentDate_O,
               v_SelectedForPaymentDate_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIPaymentsHeader','ApprovedForPayment',v_ApprovedForPayment_O,
               v_ApprovedForPayment_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIPaymentsHeader','ApprovedForPaymentDate',v_ApprovedForPaymentDate_O,
               v_ApprovedForPaymentDate_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIPaymentsHeader','Cleared',v_Cleared_O,v_Cleared_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIPaymentsHeader','InvoiceNumber',v_InvoiceNumber_O,
               v_InvoiceNumber_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIPaymentsHeader','Posted',v_Posted_O,v_Posted_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIPaymentsHeader','Reconciled',v_Reconciled_O,
               v_Reconciled_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIPaymentsHeader','Credit',v_Credit_O,v_Credit_N);
            end if;
         end if;
         SET NO_DATA = 0;
         FETCH cUpdate INTO
         v_TransactionNumber_O,v_TransactionNumber_N,v_TransactionLineNumber,v_CompanyID,
         v_DivisionID,v_DepartmentID,v_PaymentID,v_PaymentTypeID_O,v_PaymentTypeID_N,
         v_EDIDirectionTypeID_O,v_EDIDirectionTypeID_N,v_EDIDocumentTypeID_O,
         v_EDIDocumentTypeID_N,v_EDIOpen_O,v_EDIOpen_N,v_CheckNumber_O,
         v_CheckNumber_N,v_CheckPrinted_O,v_CheckPrinted_N,v_CheckDate_O,
         v_CheckDate_N,v_Paid_O,v_Paid_N,v_PaymentDate_O,v_PaymentDate_N,v_PaymentClassID_O,
         v_PaymentClassID_N,v_VendorID_O,v_VendorID_N,v_SystemDate_O,
         v_SystemDate_N,v_Amount_O,v_Amount_N,v_UnAppliedAmount_O,v_UnAppliedAmount_N,
         v_GLBankAccount_O,v_GLBankAccount_N,v_PaymentStatus_O,v_PaymentStatus_N,
         v_Void_O,v_Void_N,v_Notes_O,v_Notes_N,v_CurrencyID_O,v_CurrencyID_N,
         v_CurrencyExchangeRate_O,v_CurrencyExchangeRate_N,v_CreditAmount_O,
         v_CreditAmount_N,v_SelectedForPayment_O,v_SelectedForPayment_N,
         v_SelectedForPaymentDate_O,v_SelectedForPaymentDate_N,v_ApprovedForPayment_O,
         v_ApprovedForPayment_N,v_ApprovedForPaymentDate_O,v_ApprovedForPaymentDate_N,
         v_Cleared_O,v_Cleared_N,v_InvoiceNumber_O,v_InvoiceNumber_N,
         v_Posted_O,v_Posted_N,v_Reconciled_O,v_Reconciled_N,v_Credit_O,v_Credit_N;
      END WHILE;
      CLOSE cUpdate;

   END;
END;
 ;;
delimiter ;
delimiter ;;
CREATE TRIGGER `EDIPaymentsHeader_Audit_Delete` AFTER DELETE ON `edipaymentsheader` FOR EACH ROW SWL_return:
BEGIN
   DECLARE NO_DATA INT DEFAULT 0;
   DECLARE v_Context VARBINARY(128);
   DECLARE v_TransactionNumber NATIONAL VARCHAR(50);
   DECLARE v_TransactionLineNumber NATIONAL VARCHAR(50);

   DECLARE v_CompanyID NATIONAL VARCHAR(36);
   DECLARE v_DivisionID NATIONAL VARCHAR(36);
   DECLARE v_DepartmentID NATIONAL VARCHAR(36);
   DECLARE v_PaymentID NATIONAL VARCHAR(36);

-- deleting records cursor declaration
   DECLARE cDelete CURSOR
   FOR SELECT
   d.PaymentID
		,''

		,d.CompanyID
		,d.DivisionID
		,d.DepartmentID
		,d.PaymentID

   FROM
   DelEDIPaymentsHeader d;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET NO_DATA = -2;
   END;
   DECLARE CONTINUE HANDLER FOR NOT FOUND SET NO_DATA = -1;
   CREATE  TEMPORARY TABLE IF NOT EXISTS DelEDIPaymentsHeader
   (
      CompanyID NATIONAL VARCHAR(36),
      DivisionID NATIONAL VARCHAR(36),
      DepartmentID NATIONAL VARCHAR(36),
      PaymentID NATIONAL VARCHAR(36),
      PaymentTypeID NATIONAL VARCHAR(36),
      EDIDirectionTypeID NATIONAL VARCHAR(1),
      EDIDocumentTypeID NATIONAL VARCHAR(3),
      EDIOpen BOOLEAN,
      CheckNumber NATIONAL VARCHAR(20),
      CheckPrinted BOOLEAN,
      CheckDate DATETIME,
      Paid BOOLEAN,
      PaymentDate DATETIME,
      PaymentClassID NATIONAL VARCHAR(36),
      VendorID NATIONAL VARCHAR(50),
      SystemDate DATETIME,
      Amount DECIMAL(19,4),
      UnAppliedAmount DECIMAL(19,4),
      GLBankAccount NATIONAL VARCHAR(36),
      PaymentStatus NATIONAL VARCHAR(10),
      Void BOOLEAN,
      Notes NATIONAL VARCHAR(255),
      CurrencyID NATIONAL VARCHAR(3),
      CurrencyExchangeRate FLOAT,
      CreditAmount DECIMAL(19,4),
      SelectedForPayment BOOLEAN,
      SelectedForPaymentDate DATETIME,
      ApprovedForPayment BOOLEAN,
      ApprovedForPaymentDate DATETIME,
      Cleared BOOLEAN,
      InvoiceNumber NATIONAL VARCHAR(36),
      Posted BOOLEAN,
      Reconciled BOOLEAN,
      Credit BOOLEAN,
      LockedBy NATIONAL VARCHAR(36),
      LockTS DATETIME
   );
   DELETE FROM DelEDIPaymentsHeader;
   INSERT INTO DelEDIPaymentsHeader VALUES(OLD.CompanyID, OLD.DivisionID, OLD.DepartmentID, OLD.PaymentID, OLD.PaymentTypeID, OLD.EDIDirectionTypeID, OLD.EDIDocumentTypeID, OLD.EDIOpen, OLD.CheckNumber, OLD.CheckPrinted, OLD.CheckDate, OLD.Paid, OLD.PaymentDate, OLD.PaymentClassID, OLD.VendorID, OLD.SystemDate, OLD.Amount, OLD.UnAppliedAmount, OLD.GLBankAccount, OLD.PaymentStatus, OLD.Void, OLD.Notes, OLD.CurrencyID, OLD.CurrencyExchangeRate, OLD.CreditAmount, OLD.SelectedForPayment, OLD.SelectedForPaymentDate, OLD.ApprovedForPayment, OLD.ApprovedForPaymentDate, OLD.Cleared, OLD.InvoiceNumber, OLD.Posted, OLD.Reconciled, OLD.Credit, OLD.LockedBy, OLD.LockTS);

   BEGIN
-- check for audit triggers switch off

      select   context_info INTO v_Context FROM sysprocesses WHERE spid = CONNECTION_ID();
      IF CAST(v_Context AS CHAR(36)) = N'$$AuditSwitchOff$$' then 
         LEAVE SWL_return;
      end if;

-- declarations
      OPEN cDelete;
-- fetch from each deleting record
      SET NO_DATA = 0;
      FETCH cDelete INTO
      v_TransactionNumber,v_TransactionLineNumber,v_CompanyID,v_DivisionID,v_DepartmentID,
      v_PaymentID;
      WHILE NO_DATA = 0 DO
-- insert audit record for each deleting record
         CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber,v_TransactionLineNumber,
         'EDIPaymentsHeader','Deleted','','Deleted');
         SET NO_DATA = 0;
         FETCH cDelete INTO
         v_TransactionNumber,v_TransactionLineNumber,v_CompanyID,v_DivisionID,v_DepartmentID,
         v_PaymentID;
      END WHILE;
      CLOSE cDelete;

   END;
END;
 ;;
delimiter ;

-- ----------------------------
--  Table structure for `edipurchasedetail`
-- ----------------------------
DROP TABLE IF EXISTS `edipurchasedetail`;
CREATE TABLE `edipurchasedetail` (
  `CompanyID` varchar(36) NOT NULL,
  `DivisionID` varchar(36) NOT NULL,
  `DepartmentID` varchar(36) NOT NULL,
  `PurchaseNumber` varchar(36) NOT NULL,
  `PurchaseLineNumber` bigint(20) NOT NULL AUTO_INCREMENT,
  `ItemID` varchar(36) DEFAULT NULL,
  `VendorItemID` varchar(36) DEFAULT NULL,
  `Description` varchar(80) DEFAULT NULL,
  `WarehouseID` varchar(36) DEFAULT NULL,
  `SerialNumber` varchar(50) DEFAULT NULL,
  `OrderQty` float DEFAULT NULL,
  `ItemUOM` varchar(15) DEFAULT NULL,
  `ItemWeight` float DEFAULT NULL,
  `DiscountPerc` float DEFAULT NULL,
  `Taxable` tinyint(1) DEFAULT NULL,
  `CurrencyID` varchar(3) DEFAULT NULL,
  `CurrencyExchangeRate` float DEFAULT NULL,
  `ItemCost` decimal(19,4) DEFAULT NULL,
  `ItemUnitPrice` decimal(19,4) DEFAULT NULL,
  `Total` decimal(19,4) DEFAULT NULL,
  `TotalWeight` float DEFAULT NULL,
  `GLPurchaseAccount` varchar(36) DEFAULT NULL,
  `TrackingNumber` varchar(50) DEFAULT NULL,
  `ProjectID` varchar(36) DEFAULT NULL,
  `Received` tinyint(1) DEFAULT NULL,
  `ReceivedDate` datetime DEFAULT NULL,
  `RecivingNumber` varchar(20) DEFAULT NULL,
  `DetailMemo1` varchar(50) DEFAULT NULL,
  `DetailMemo2` varchar(50) DEFAULT NULL,
  `DetailMemo3` varchar(50) DEFAULT NULL,
  `DetailMemo4` varchar(50) DEFAULT NULL,
  `DetailMemo5` varchar(50) DEFAULT NULL,
  `LockedBy` varchar(36) DEFAULT NULL,
  `LockTS` datetime DEFAULT NULL,
  `TaxGroupID` varchar(36) DEFAULT NULL,
  `TaxAmount` decimal(19,4) DEFAULT NULL,
  `TaxPercent` float DEFAULT NULL,
  `SubTotal` decimal(19,4) DEFAULT NULL,
  PRIMARY KEY (`PurchaseLineNumber`,`CompanyID`,`DivisionID`,`DepartmentID`,`PurchaseNumber`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
delimiter ;;
CREATE TRIGGER `EDIPurchaseDetail_Audit_Insert` AFTER INSERT ON `edipurchasedetail` FOR EACH ROW SWL_return:
BEGIN
   DECLARE NO_DATA INT DEFAULT 0;
   DECLARE v_Context VARBINARY(128);
   DECLARE v_TransactionNumber NATIONAL VARCHAR(50);
   DECLARE v_TransactionLineNumber NATIONAL VARCHAR(50);

   DECLARE v_CompanyID NATIONAL VARCHAR(36);
   DECLARE v_DivisionID NATIONAL VARCHAR(36);
   DECLARE v_DepartmentID NATIONAL VARCHAR(36);
   DECLARE v_PurchaseNumber NATIONAL VARCHAR(36);
   DECLARE v_PurchaseLineNumber NUMERIC(18,0);

-- inserting records cursor declaration
   DECLARE cInsert CURSOR
   FOR SELECT
   i.PurchaseNumber
		,i.PurchaseLineNumber

		,i.CompanyID
		,i.DivisionID
		,i.DepartmentID
		,i.PurchaseNumber
		,i.PurchaseLineNumber

   FROM
   InsEDIPurchaseDetail i;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET NO_DATA = -2;
   END;
   DECLARE CONTINUE HANDLER FOR NOT FOUND SET NO_DATA = -1;
   CREATE  TEMPORARY TABLE IF NOT EXISTS InsEDIPurchaseDetail
   (
      CompanyID NATIONAL VARCHAR(36),
      DivisionID NATIONAL VARCHAR(36),
      DepartmentID NATIONAL VARCHAR(36),
      PurchaseNumber NATIONAL VARCHAR(36),
      PurchaseLineNumber NUMERIC(18,0),
      ItemID NATIONAL VARCHAR(36),
      VendorItemID NATIONAL VARCHAR(36),
      Description NATIONAL VARCHAR(80),
      WarehouseID NATIONAL VARCHAR(36),
      SerialNumber NATIONAL VARCHAR(50),
      OrderQty FLOAT,
      ItemUOM NATIONAL VARCHAR(15),
      ItemWeight FLOAT,
      DiscountPerc FLOAT,
      Taxable BOOLEAN,
      CurrencyID NATIONAL VARCHAR(3),
      CurrencyExchangeRate FLOAT,
      ItemCost DECIMAL(19,4),
      ItemUnitPrice DECIMAL(19,4),
      Total DECIMAL(19,4),
      TotalWeight FLOAT,
      GLPurchaseAccount NATIONAL VARCHAR(36),
      TrackingNumber NATIONAL VARCHAR(50),
      ProjectID NATIONAL VARCHAR(36),
      Received BOOLEAN,
      ReceivedDate DATETIME,
      RecivingNumber NATIONAL VARCHAR(20),
      DetailMemo1 NATIONAL VARCHAR(50),
      DetailMemo2 NATIONAL VARCHAR(50),
      DetailMemo3 NATIONAL VARCHAR(50),
      DetailMemo4 NATIONAL VARCHAR(50),
      DetailMemo5 NATIONAL VARCHAR(50),
      LockedBy NATIONAL VARCHAR(36),
      LockTS DATETIME,
      TaxGroupID NATIONAL VARCHAR(36),
      TaxAmount DECIMAL(19,4),
      TaxPercent FLOAT,
      SubTotal DECIMAL(19,4)
   );
   DELETE FROM InsEDIPurchaseDetail;
   INSERT INTO InsEDIPurchaseDetail VALUES(NEW.CompanyID, NEW.DivisionID, NEW.DepartmentID, NEW.PurchaseNumber, NEW.PurchaseLineNumber, NEW.ItemID, NEW.VendorItemID, NEW.Description, NEW.WarehouseID, NEW.SerialNumber, NEW.OrderQty, NEW.ItemUOM, NEW.ItemWeight, NEW.DiscountPerc, NEW.Taxable, NEW.CurrencyID, NEW.CurrencyExchangeRate, NEW.ItemCost, NEW.ItemUnitPrice, NEW.Total, NEW.TotalWeight, NEW.GLPurchaseAccount, NEW.TrackingNumber, NEW.ProjectID, NEW.Received, NEW.ReceivedDate, NEW.RecivingNumber, NEW.DetailMemo1, NEW.DetailMemo2, NEW.DetailMemo3, NEW.DetailMemo4, NEW.DetailMemo5, NEW.LockedBy, NEW.LockTS, NEW.TaxGroupID, NEW.TaxAmount, NEW.TaxPercent, NEW.SubTotal);

   BEGIN
-- check for audit triggers switch off

      select   context_info INTO v_Context FROM sysprocesses WHERE spid = CONNECTION_ID();
      IF CAST(v_Context AS CHAR(36)) = N'$$AuditSwitchOff$$' then 
         LEAVE SWL_return;
      end if;

-- declarations
      OPEN cInsert;
-- fetch from each inserting record
      SET NO_DATA = 0;
      FETCH cInsert INTO
      v_TransactionNumber,v_TransactionLineNumber,v_CompanyID,v_DivisionID,v_DepartmentID,
      v_PurchaseNumber,v_PurchaseLineNumber;
      WHILE NO_DATA = 0 DO
-- insert audit record for each inserting record
         IF IsGuid(v_TransactionNumber) = 0 then
		
            CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber,v_TransactionLineNumber,
            'EDIPurchaseDetail','New Record','','New Record');
         end if;
         SET NO_DATA = 0;
         FETCH cInsert INTO
         v_TransactionNumber,v_TransactionLineNumber,v_CompanyID,v_DivisionID,v_DepartmentID,
         v_PurchaseNumber,v_PurchaseLineNumber;
      END WHILE;
      CLOSE cInsert;

   END;
END;
 ;;
delimiter ;
delimiter ;;
CREATE TRIGGER `EDIPurchaseDetail_Audit_Update` AFTER UPDATE ON `edipurchasedetail` FOR EACH ROW SWL_return:
BEGIN
   DECLARE NO_DATA INT DEFAULT 0;
   DECLARE v_Context VARBINARY(128);
   DECLARE v_TransactionNumber_O NATIONAL VARCHAR(50);
   DECLARE v_TransactionNumber_N NATIONAL VARCHAR(50);
   DECLARE v_TransactionLineNumber NATIONAL VARCHAR(50);

   DECLARE v_CompanyID NATIONAL VARCHAR(36);
   DECLARE v_DivisionID NATIONAL VARCHAR(36);
   DECLARE v_DepartmentID NATIONAL VARCHAR(36);
   DECLARE v_PurchaseNumber NATIONAL VARCHAR(36);
   DECLARE v_PurchaseLineNumber NUMERIC(18,0);

   DECLARE v_ItemID_O NATIONAL VARCHAR(80);
   DECLARE v_ItemID_N NATIONAL VARCHAR(80);
   DECLARE v_VendorItemID_O NATIONAL VARCHAR(80);
   DECLARE v_VendorItemID_N NATIONAL VARCHAR(80);
   DECLARE v_Description_O NATIONAL VARCHAR(80);
   DECLARE v_Description_N NATIONAL VARCHAR(80);
   DECLARE v_WarehouseID_O NATIONAL VARCHAR(80);
   DECLARE v_WarehouseID_N NATIONAL VARCHAR(80);
   DECLARE v_SerialNumber_O NATIONAL VARCHAR(80);
   DECLARE v_SerialNumber_N NATIONAL VARCHAR(80);
   DECLARE v_OrderQty_O NATIONAL VARCHAR(80);
   DECLARE v_OrderQty_N NATIONAL VARCHAR(80);
   DECLARE v_ItemUOM_O NATIONAL VARCHAR(80);
   DECLARE v_ItemUOM_N NATIONAL VARCHAR(80);
   DECLARE v_ItemWeight_O NATIONAL VARCHAR(80);
   DECLARE v_ItemWeight_N NATIONAL VARCHAR(80);
   DECLARE v_DiscountPerc_O NATIONAL VARCHAR(80);
   DECLARE v_DiscountPerc_N NATIONAL VARCHAR(80);
   DECLARE v_Taxable_O NATIONAL VARCHAR(80);
   DECLARE v_Taxable_N NATIONAL VARCHAR(80);
   DECLARE v_CurrencyID_O NATIONAL VARCHAR(80);
   DECLARE v_CurrencyID_N NATIONAL VARCHAR(80);
   DECLARE v_CurrencyExchangeRate_O NATIONAL VARCHAR(80);
   DECLARE v_CurrencyExchangeRate_N NATIONAL VARCHAR(80);
   DECLARE v_ItemCost_O NATIONAL VARCHAR(80);
   DECLARE v_ItemCost_N NATIONAL VARCHAR(80);
   DECLARE v_ItemUnitPrice_O NATIONAL VARCHAR(80);
   DECLARE v_ItemUnitPrice_N NATIONAL VARCHAR(80);
   DECLARE v_Total_O NATIONAL VARCHAR(80);
   DECLARE v_Total_N NATIONAL VARCHAR(80);
   DECLARE v_TotalWeight_O NATIONAL VARCHAR(80);
   DECLARE v_TotalWeight_N NATIONAL VARCHAR(80);
   DECLARE v_GLPurchaseAccount_O NATIONAL VARCHAR(80);
   DECLARE v_GLPurchaseAccount_N NATIONAL VARCHAR(80);
   DECLARE v_TrackingNumber_O NATIONAL VARCHAR(80);
   DECLARE v_TrackingNumber_N NATIONAL VARCHAR(80);
   DECLARE v_ProjectID_O NATIONAL VARCHAR(80);
   DECLARE v_ProjectID_N NATIONAL VARCHAR(80);
   DECLARE v_Received_O NATIONAL VARCHAR(80);
   DECLARE v_Received_N NATIONAL VARCHAR(80);
   DECLARE v_ReceivedDate_O NATIONAL VARCHAR(80);
   DECLARE v_ReceivedDate_N NATIONAL VARCHAR(80);
   DECLARE v_RecivingNumber_O NATIONAL VARCHAR(80);
   DECLARE v_RecivingNumber_N NATIONAL VARCHAR(80);
   DECLARE v_DetailMemo1_O NATIONAL VARCHAR(80);
   DECLARE v_DetailMemo1_N NATIONAL VARCHAR(80);
   DECLARE v_DetailMemo2_O NATIONAL VARCHAR(80);
   DECLARE v_DetailMemo2_N NATIONAL VARCHAR(80);
   DECLARE v_DetailMemo3_O NATIONAL VARCHAR(80);
   DECLARE v_DetailMemo3_N NATIONAL VARCHAR(80);
   DECLARE v_DetailMemo4_O NATIONAL VARCHAR(80);
   DECLARE v_DetailMemo4_N NATIONAL VARCHAR(80);
   DECLARE v_DetailMemo5_O NATIONAL VARCHAR(80);
   DECLARE v_DetailMemo5_N NATIONAL VARCHAR(80);
   DECLARE v_TaxGroupID_O NATIONAL VARCHAR(80);
   DECLARE v_TaxGroupID_N NATIONAL VARCHAR(80);
   DECLARE v_TaxAmount_O NATIONAL VARCHAR(80);
   DECLARE v_TaxAmount_N NATIONAL VARCHAR(80);
   DECLARE v_TaxPercent_O NATIONAL VARCHAR(80);
   DECLARE v_TaxPercent_N NATIONAL VARCHAR(80);
   DECLARE v_SubTotal_O NATIONAL VARCHAR(80);
   DECLARE v_SubTotal_N NATIONAL VARCHAR(80);
 

-- updating records cursor declaration
   DECLARE cUpdate CURSOR
   FOR SELECT
   d.PurchaseNumber
		,i.PurchaseNumber
		,i.PurchaseLineNumber

		,i.CompanyID
		,i.DivisionID
		,i.DepartmentID
		,i.PurchaseNumber
		,i.PurchaseLineNumber

,CAST(d.ItemID AS CHAR(80))
,CAST(i.ItemID AS CHAR(80))
,CAST(d.VendorItemID AS CHAR(80))
,CAST(i.VendorItemID AS CHAR(80))
,CAST(d.Description AS CHAR(80))
,CAST(i.Description AS CHAR(80))
,CAST(d.WarehouseID AS CHAR(80))
,CAST(i.WarehouseID AS CHAR(80))
,CAST(d.SerialNumber AS CHAR(80))
,CAST(i.SerialNumber AS CHAR(80))
,CAST(d.OrderQty AS CHAR(80))
,CAST(i.OrderQty AS CHAR(80))
,CAST(d.ItemUOM AS CHAR(80))
,CAST(i.ItemUOM AS CHAR(80))
,CAST(d.ItemWeight AS CHAR(80))
,CAST(i.ItemWeight AS CHAR(80))
,CAST(d.DiscountPerc AS CHAR(80))
,CAST(i.DiscountPerc AS CHAR(80))
,CAST(d.Taxable AS CHAR(80))
,CAST(i.Taxable AS CHAR(80))
,CAST(d.CurrencyID AS CHAR(80))
,CAST(i.CurrencyID AS CHAR(80))
,CAST(d.CurrencyExchangeRate AS CHAR(80))
,CAST(i.CurrencyExchangeRate AS CHAR(80))
,CAST(d.ItemCost AS CHAR(80))
,CAST(i.ItemCost AS CHAR(80))
,CAST(d.ItemUnitPrice AS CHAR(80))
,CAST(i.ItemUnitPrice AS CHAR(80))
,CAST(d.Total AS CHAR(80))
,CAST(i.Total AS CHAR(80))
,CAST(d.TotalWeight AS CHAR(80))
,CAST(i.TotalWeight AS CHAR(80))
,CAST(d.GLPurchaseAccount AS CHAR(80))
,CAST(i.GLPurchaseAccount AS CHAR(80))
,CAST(d.TrackingNumber AS CHAR(80))
,CAST(i.TrackingNumber AS CHAR(80))
,CAST(d.ProjectID AS CHAR(80))
,CAST(i.ProjectID AS CHAR(80))
,CAST(d.Received AS CHAR(80))
,CAST(i.Received AS CHAR(80))
,CAST(d.ReceivedDate AS CHAR(80))
,CAST(i.ReceivedDate AS CHAR(80))
,CAST(d.RecivingNumber AS CHAR(80))
,CAST(i.RecivingNumber AS CHAR(80))
,CAST(d.DetailMemo1 AS CHAR(80))
,CAST(i.DetailMemo1 AS CHAR(80))
,CAST(d.DetailMemo2 AS CHAR(80))
,CAST(i.DetailMemo2 AS CHAR(80))
,CAST(d.DetailMemo3 AS CHAR(80))
,CAST(i.DetailMemo3 AS CHAR(80))
,CAST(d.DetailMemo4 AS CHAR(80))
,CAST(i.DetailMemo4 AS CHAR(80))
,CAST(d.DetailMemo5 AS CHAR(80))
,CAST(i.DetailMemo5 AS CHAR(80))
,CAST(d.TaxGroupID AS CHAR(80))
,CAST(i.TaxGroupID AS CHAR(80))
,CAST(d.TaxAmount AS CHAR(80))
,CAST(i.TaxAmount AS CHAR(80))
,CAST(d.TaxPercent AS CHAR(80))
,CAST(i.TaxPercent AS CHAR(80))
,CAST(d.SubTotal AS CHAR(80))
,CAST(i.SubTotal AS CHAR(80))
 

   FROM
   InsEDIPurchaseDetail i
   LEFT OUTER JOIN DelEDIPurchaseDetail d ON
   d.CompanyID = i.CompanyID
   AND d.DivisionID = i.DivisionID
   AND d.DepartmentID = i.DepartmentID
   AND d.PurchaseNumber = i.PurchaseNumber
   AND d.PurchaseLineNumber = i.PurchaseLineNumber;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET NO_DATA = -2;
   END;
   DECLARE CONTINUE HANDLER FOR NOT FOUND SET NO_DATA = -1;
   CREATE  TEMPORARY TABLE IF NOT EXISTS InsEDIPurchaseDetail
   (
      CompanyID NATIONAL VARCHAR(36),
      DivisionID NATIONAL VARCHAR(36),
      DepartmentID NATIONAL VARCHAR(36),
      PurchaseNumber NATIONAL VARCHAR(36),
      PurchaseLineNumber NUMERIC(18,0),
      ItemID NATIONAL VARCHAR(36),
      VendorItemID NATIONAL VARCHAR(36),
      Description NATIONAL VARCHAR(80),
      WarehouseID NATIONAL VARCHAR(36),
      SerialNumber NATIONAL VARCHAR(50),
      OrderQty FLOAT,
      ItemUOM NATIONAL VARCHAR(15),
      ItemWeight FLOAT,
      DiscountPerc FLOAT,
      Taxable BOOLEAN,
      CurrencyID NATIONAL VARCHAR(3),
      CurrencyExchangeRate FLOAT,
      ItemCost DECIMAL(19,4),
      ItemUnitPrice DECIMAL(19,4),
      Total DECIMAL(19,4),
      TotalWeight FLOAT,
      GLPurchaseAccount NATIONAL VARCHAR(36),
      TrackingNumber NATIONAL VARCHAR(50),
      ProjectID NATIONAL VARCHAR(36),
      Received BOOLEAN,
      ReceivedDate DATETIME,
      RecivingNumber NATIONAL VARCHAR(20),
      DetailMemo1 NATIONAL VARCHAR(50),
      DetailMemo2 NATIONAL VARCHAR(50),
      DetailMemo3 NATIONAL VARCHAR(50),
      DetailMemo4 NATIONAL VARCHAR(50),
      DetailMemo5 NATIONAL VARCHAR(50),
      LockedBy NATIONAL VARCHAR(36),
      LockTS DATETIME,
      TaxGroupID NATIONAL VARCHAR(36),
      TaxAmount DECIMAL(19,4),
      TaxPercent FLOAT,
      SubTotal DECIMAL(19,4)
   );
   DELETE FROM InsEDIPurchaseDetail;
   INSERT INTO InsEDIPurchaseDetail VALUES(NEW.CompanyID, NEW.DivisionID, NEW.DepartmentID, NEW.PurchaseNumber, NEW.PurchaseLineNumber, NEW.ItemID, NEW.VendorItemID, NEW.Description, NEW.WarehouseID, NEW.SerialNumber, NEW.OrderQty, NEW.ItemUOM, NEW.ItemWeight, NEW.DiscountPerc, NEW.Taxable, NEW.CurrencyID, NEW.CurrencyExchangeRate, NEW.ItemCost, NEW.ItemUnitPrice, NEW.Total, NEW.TotalWeight, NEW.GLPurchaseAccount, NEW.TrackingNumber, NEW.ProjectID, NEW.Received, NEW.ReceivedDate, NEW.RecivingNumber, NEW.DetailMemo1, NEW.DetailMemo2, NEW.DetailMemo3, NEW.DetailMemo4, NEW.DetailMemo5, NEW.LockedBy, NEW.LockTS, NEW.TaxGroupID, NEW.TaxAmount, NEW.TaxPercent, NEW.SubTotal);

   CREATE  TEMPORARY TABLE IF NOT EXISTS DelEDIPurchaseDetail
   (
      CompanyID NATIONAL VARCHAR(36),
      DivisionID NATIONAL VARCHAR(36),
      DepartmentID NATIONAL VARCHAR(36),
      PurchaseNumber NATIONAL VARCHAR(36),
      PurchaseLineNumber NUMERIC(18,0),
      ItemID NATIONAL VARCHAR(36),
      VendorItemID NATIONAL VARCHAR(36),
      Description NATIONAL VARCHAR(80),
      WarehouseID NATIONAL VARCHAR(36),
      SerialNumber NATIONAL VARCHAR(50),
      OrderQty FLOAT,
      ItemUOM NATIONAL VARCHAR(15),
      ItemWeight FLOAT,
      DiscountPerc FLOAT,
      Taxable BOOLEAN,
      CurrencyID NATIONAL VARCHAR(3),
      CurrencyExchangeRate FLOAT,
      ItemCost DECIMAL(19,4),
      ItemUnitPrice DECIMAL(19,4),
      Total DECIMAL(19,4),
      TotalWeight FLOAT,
      GLPurchaseAccount NATIONAL VARCHAR(36),
      TrackingNumber NATIONAL VARCHAR(50),
      ProjectID NATIONAL VARCHAR(36),
      Received BOOLEAN,
      ReceivedDate DATETIME,
      RecivingNumber NATIONAL VARCHAR(20),
      DetailMemo1 NATIONAL VARCHAR(50),
      DetailMemo2 NATIONAL VARCHAR(50),
      DetailMemo3 NATIONAL VARCHAR(50),
      DetailMemo4 NATIONAL VARCHAR(50),
      DetailMemo5 NATIONAL VARCHAR(50),
      LockedBy NATIONAL VARCHAR(36),
      LockTS DATETIME,
      TaxGroupID NATIONAL VARCHAR(36),
      TaxAmount DECIMAL(19,4),
      TaxPercent FLOAT,
      SubTotal DECIMAL(19,4)
   );
   DELETE FROM DelEDIPurchaseDetail;
   INSERT INTO DelEDIPurchaseDetail VALUES(OLD.CompanyID, OLD.DivisionID, OLD.DepartmentID, OLD.PurchaseNumber, OLD.PurchaseLineNumber, OLD.ItemID, OLD.VendorItemID, OLD.Description, OLD.WarehouseID, OLD.SerialNumber, OLD.OrderQty, OLD.ItemUOM, OLD.ItemWeight, OLD.DiscountPerc, OLD.Taxable, OLD.CurrencyID, OLD.CurrencyExchangeRate, OLD.ItemCost, OLD.ItemUnitPrice, OLD.Total, OLD.TotalWeight, OLD.GLPurchaseAccount, OLD.TrackingNumber, OLD.ProjectID, OLD.Received, OLD.ReceivedDate, OLD.RecivingNumber, OLD.DetailMemo1, OLD.DetailMemo2, OLD.DetailMemo3, OLD.DetailMemo4, OLD.DetailMemo5, OLD.LockedBy, OLD.LockTS, OLD.TaxGroupID, OLD.TaxAmount, OLD.TaxPercent, OLD.SubTotal);

   BEGIN
-- check for audit triggers switch off

      select   context_info INTO v_Context FROM sysprocesses WHERE spid = CONNECTION_ID();
      IF CAST(v_Context AS CHAR(36)) = N'$$AuditSwitchOff$$' then 
         LEAVE SWL_return;
      end if;

-- declarations
      OPEN cUpdate;
-- fetch from each updating record
      SET NO_DATA = 0;
      FETCH cUpdate INTO
      v_TransactionNumber_O,v_TransactionNumber_N,v_TransactionLineNumber,v_CompanyID,
      v_DivisionID,v_DepartmentID,v_PurchaseNumber,v_PurchaseLineNumber,
      v_ItemID_O,v_ItemID_N,v_VendorItemID_O,v_VendorItemID_N,v_Description_O,
      v_Description_N,v_WarehouseID_O,v_WarehouseID_N,v_SerialNumber_O,
      v_SerialNumber_N,v_OrderQty_O,v_OrderQty_N,v_ItemUOM_O,v_ItemUOM_N,
      v_ItemWeight_O,v_ItemWeight_N,v_DiscountPerc_O,v_DiscountPerc_N,v_Taxable_O,
      v_Taxable_N,v_CurrencyID_O,v_CurrencyID_N,v_CurrencyExchangeRate_O,
      v_CurrencyExchangeRate_N,v_ItemCost_O,v_ItemCost_N,v_ItemUnitPrice_O,
      v_ItemUnitPrice_N,v_Total_O,v_Total_N,v_TotalWeight_O,v_TotalWeight_N,
      v_GLPurchaseAccount_O,v_GLPurchaseAccount_N,v_TrackingNumber_O,v_TrackingNumber_N,
      v_ProjectID_O,v_ProjectID_N,v_Received_O,v_Received_N,v_ReceivedDate_O,
      v_ReceivedDate_N,v_RecivingNumber_O,v_RecivingNumber_N,
      v_DetailMemo1_O,v_DetailMemo1_N,v_DetailMemo2_O,v_DetailMemo2_N,v_DetailMemo3_O,
      v_DetailMemo3_N,v_DetailMemo4_O,v_DetailMemo4_N,v_DetailMemo5_O,
      v_DetailMemo5_N,v_TaxGroupID_O,v_TaxGroupID_N,v_TaxAmount_O,v_TaxAmount_N,
      v_TaxPercent_O,v_TaxPercent_N,v_SubTotal_O,v_SubTotal_N;
      WHILE NO_DATA = 0 DO
-- insert audit records for each changed field
         IF IsGuid(v_TransactionNumber_N) = 0 then
		
            IF v_TransactionNumber_O IS NULL then
				
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIPurchaseDetail','New Record','','New Record');
            ELSE
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIPurchaseDetail','ItemID',v_ItemID_O,v_ItemID_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIPurchaseDetail','VendorItemID',v_VendorItemID_O,
               v_VendorItemID_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIPurchaseDetail','Description',v_Description_O,
               v_Description_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIPurchaseDetail','WarehouseID',v_WarehouseID_O,
               v_WarehouseID_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIPurchaseDetail','SerialNumber',v_SerialNumber_O,
               v_SerialNumber_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIPurchaseDetail','OrderQty',v_OrderQty_O,v_OrderQty_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIPurchaseDetail','ItemUOM',v_ItemUOM_O,v_ItemUOM_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIPurchaseDetail','ItemWeight',v_ItemWeight_O,
               v_ItemWeight_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIPurchaseDetail','DiscountPerc',v_DiscountPerc_O,
               v_DiscountPerc_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIPurchaseDetail','Taxable',v_Taxable_O,v_Taxable_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIPurchaseDetail','CurrencyID',v_CurrencyID_O,
               v_CurrencyID_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIPurchaseDetail','CurrencyExchangeRate',v_CurrencyExchangeRate_O,
               v_CurrencyExchangeRate_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIPurchaseDetail','ItemCost',v_ItemCost_O,v_ItemCost_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIPurchaseDetail','ItemUnitPrice',v_ItemUnitPrice_O,
               v_ItemUnitPrice_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIPurchaseDetail','Total',v_Total_O,v_Total_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIPurchaseDetail','TotalWeight',v_TotalWeight_O,
               v_TotalWeight_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIPurchaseDetail','GLPurchaseAccount',v_GLPurchaseAccount_O,
               v_GLPurchaseAccount_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIPurchaseDetail','TrackingNumber',v_TrackingNumber_O,
               v_TrackingNumber_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIPurchaseDetail','ProjectID',v_ProjectID_O,v_ProjectID_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIPurchaseDetail','Received',v_Received_O,v_Received_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIPurchaseDetail','ReceivedDate',v_ReceivedDate_O,
               v_ReceivedDate_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIPurchaseDetail','RecivingNumber',v_RecivingNumber_O,
               v_RecivingNumber_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIPurchaseDetail','DetailMemo1',v_DetailMemo1_O,
               v_DetailMemo1_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIPurchaseDetail','DetailMemo2',v_DetailMemo2_O,
               v_DetailMemo2_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIPurchaseDetail','DetailMemo3',v_DetailMemo3_O,
               v_DetailMemo3_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIPurchaseDetail','DetailMemo4',v_DetailMemo4_O,
               v_DetailMemo4_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIPurchaseDetail','DetailMemo5',v_DetailMemo5_O,
               v_DetailMemo5_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIPurchaseDetail','TaxGroupID',v_TaxGroupID_O,
               v_TaxGroupID_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIPurchaseDetail','TaxAmount',v_TaxAmount_O,v_TaxAmount_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIPurchaseDetail','TaxPercent',v_TaxPercent_O,
               v_TaxPercent_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIPurchaseDetail','SubTotal',v_SubTotal_O,v_SubTotal_N);
            end if;
         end if;
         SET NO_DATA = 0;
         FETCH cUpdate INTO
         v_TransactionNumber_O,v_TransactionNumber_N,v_TransactionLineNumber,v_CompanyID,
         v_DivisionID,v_DepartmentID,v_PurchaseNumber,v_PurchaseLineNumber,
         v_ItemID_O,v_ItemID_N,v_VendorItemID_O,v_VendorItemID_N,v_Description_O,
         v_Description_N,v_WarehouseID_O,v_WarehouseID_N,v_SerialNumber_O,
         v_SerialNumber_N,v_OrderQty_O,v_OrderQty_N,v_ItemUOM_O,v_ItemUOM_N,
         v_ItemWeight_O,v_ItemWeight_N,v_DiscountPerc_O,v_DiscountPerc_N,v_Taxable_O,
         v_Taxable_N,v_CurrencyID_O,v_CurrencyID_N,v_CurrencyExchangeRate_O,
         v_CurrencyExchangeRate_N,v_ItemCost_O,v_ItemCost_N,v_ItemUnitPrice_O,
         v_ItemUnitPrice_N,v_Total_O,v_Total_N,v_TotalWeight_O,v_TotalWeight_N,
         v_GLPurchaseAccount_O,v_GLPurchaseAccount_N,v_TrackingNumber_O,v_TrackingNumber_N,
         v_ProjectID_O,v_ProjectID_N,v_Received_O,v_Received_N,v_ReceivedDate_O,
         v_ReceivedDate_N,v_RecivingNumber_O,v_RecivingNumber_N,
         v_DetailMemo1_O,v_DetailMemo1_N,v_DetailMemo2_O,v_DetailMemo2_N,v_DetailMemo3_O,
         v_DetailMemo3_N,v_DetailMemo4_O,v_DetailMemo4_N,v_DetailMemo5_O,
         v_DetailMemo5_N,v_TaxGroupID_O,v_TaxGroupID_N,v_TaxAmount_O,v_TaxAmount_N,
         v_TaxPercent_O,v_TaxPercent_N,v_SubTotal_O,v_SubTotal_N;
      END WHILE;
      CLOSE cUpdate;

   END;
END;
 ;;
delimiter ;
delimiter ;;
CREATE TRIGGER `EDIPurchaseDetail_Audit_Delete` AFTER DELETE ON `edipurchasedetail` FOR EACH ROW SWL_return:
BEGIN
   DECLARE NO_DATA INT DEFAULT 0;
   DECLARE v_Context VARBINARY(128);
   DECLARE v_TransactionNumber NATIONAL VARCHAR(50);
   DECLARE v_TransactionLineNumber NATIONAL VARCHAR(50);

   DECLARE v_CompanyID NATIONAL VARCHAR(36);
   DECLARE v_DivisionID NATIONAL VARCHAR(36);
   DECLARE v_DepartmentID NATIONAL VARCHAR(36);
   DECLARE v_PurchaseNumber NATIONAL VARCHAR(36);
   DECLARE v_PurchaseLineNumber NUMERIC(18,0);

-- deleting records cursor declaration
   DECLARE cDelete CURSOR
   FOR SELECT
   d.PurchaseNumber
		,d.PurchaseLineNumber

		,d.CompanyID
		,d.DivisionID
		,d.DepartmentID
		,d.PurchaseNumber
		,d.PurchaseLineNumber

   FROM
   DelEDIPurchaseDetail d;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET NO_DATA = -2;
   END;
   DECLARE CONTINUE HANDLER FOR NOT FOUND SET NO_DATA = -1;
   CREATE  TEMPORARY TABLE IF NOT EXISTS DelEDIPurchaseDetail
   (
      CompanyID NATIONAL VARCHAR(36),
      DivisionID NATIONAL VARCHAR(36),
      DepartmentID NATIONAL VARCHAR(36),
      PurchaseNumber NATIONAL VARCHAR(36),
      PurchaseLineNumber NUMERIC(18,0),
      ItemID NATIONAL VARCHAR(36),
      VendorItemID NATIONAL VARCHAR(36),
      Description NATIONAL VARCHAR(80),
      WarehouseID NATIONAL VARCHAR(36),
      SerialNumber NATIONAL VARCHAR(50),
      OrderQty FLOAT,
      ItemUOM NATIONAL VARCHAR(15),
      ItemWeight FLOAT,
      DiscountPerc FLOAT,
      Taxable BOOLEAN,
      CurrencyID NATIONAL VARCHAR(3),
      CurrencyExchangeRate FLOAT,
      ItemCost DECIMAL(19,4),
      ItemUnitPrice DECIMAL(19,4),
      Total DECIMAL(19,4),
      TotalWeight FLOAT,
      GLPurchaseAccount NATIONAL VARCHAR(36),
      TrackingNumber NATIONAL VARCHAR(50),
      ProjectID NATIONAL VARCHAR(36),
      Received BOOLEAN,
      ReceivedDate DATETIME,
      RecivingNumber NATIONAL VARCHAR(20),
      DetailMemo1 NATIONAL VARCHAR(50),
      DetailMemo2 NATIONAL VARCHAR(50),
      DetailMemo3 NATIONAL VARCHAR(50),
      DetailMemo4 NATIONAL VARCHAR(50),
      DetailMemo5 NATIONAL VARCHAR(50),
      LockedBy NATIONAL VARCHAR(36),
      LockTS DATETIME,
      TaxGroupID NATIONAL VARCHAR(36),
      TaxAmount DECIMAL(19,4),
      TaxPercent FLOAT,
      SubTotal DECIMAL(19,4)
   );
   DELETE FROM DelEDIPurchaseDetail;
   INSERT INTO DelEDIPurchaseDetail VALUES(OLD.CompanyID, OLD.DivisionID, OLD.DepartmentID, OLD.PurchaseNumber, OLD.PurchaseLineNumber, OLD.ItemID, OLD.VendorItemID, OLD.Description, OLD.WarehouseID, OLD.SerialNumber, OLD.OrderQty, OLD.ItemUOM, OLD.ItemWeight, OLD.DiscountPerc, OLD.Taxable, OLD.CurrencyID, OLD.CurrencyExchangeRate, OLD.ItemCost, OLD.ItemUnitPrice, OLD.Total, OLD.TotalWeight, OLD.GLPurchaseAccount, OLD.TrackingNumber, OLD.ProjectID, OLD.Received, OLD.ReceivedDate, OLD.RecivingNumber, OLD.DetailMemo1, OLD.DetailMemo2, OLD.DetailMemo3, OLD.DetailMemo4, OLD.DetailMemo5, OLD.LockedBy, OLD.LockTS, OLD.TaxGroupID, OLD.TaxAmount, OLD.TaxPercent, OLD.SubTotal);

   BEGIN
-- check for audit triggers switch off

      select   context_info INTO v_Context FROM sysprocesses WHERE spid = CONNECTION_ID();
      IF CAST(v_Context AS CHAR(36)) = N'$$AuditSwitchOff$$' then 
         LEAVE SWL_return;
      end if;

-- declarations
      OPEN cDelete;
-- fetch from each deleting record
      SET NO_DATA = 0;
      FETCH cDelete INTO
      v_TransactionNumber,v_TransactionLineNumber,v_CompanyID,v_DivisionID,v_DepartmentID,
      v_PurchaseNumber,v_PurchaseLineNumber;
      WHILE NO_DATA = 0 DO
-- insert audit record for each deleting record
         CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber,v_TransactionLineNumber,
         'EDIPurchaseDetail','Deleted','','Deleted');
         SET NO_DATA = 0;
         FETCH cDelete INTO
         v_TransactionNumber,v_TransactionLineNumber,v_CompanyID,v_DivisionID,v_DepartmentID,
         v_PurchaseNumber,v_PurchaseLineNumber;
      END WHILE;
      CLOSE cDelete;

   END;
END;
 ;;
delimiter ;

-- ----------------------------
--  Table structure for `edipurchaseheader`
-- ----------------------------
DROP TABLE IF EXISTS `edipurchaseheader`;
CREATE TABLE `edipurchaseheader` (
  `CompanyID` varchar(36) NOT NULL,
  `DivisionID` varchar(36) NOT NULL,
  `DepartmentID` varchar(36) NOT NULL,
  `PurchaseNumber` varchar(36) NOT NULL,
  `PurchaseTypeID` varchar(36) DEFAULT NULL,
  `EDIDirectionTypeID` varchar(1) DEFAULT NULL,
  `EDIDocumentTypeID` varchar(3) DEFAULT NULL,
  `EDIOpen` tinyint(1) DEFAULT NULL,
  `PurchaseDate` datetime DEFAULT NULL,
  `PurchaseDueDate` datetime DEFAULT NULL,
  `PurchaseShipDate` datetime DEFAULT NULL,
  `PurchaseCancelDate` datetime DEFAULT NULL,
  `PurchaseDateRequested` datetime DEFAULT NULL,
  `OrderNumber` varchar(36) DEFAULT NULL,
  `VendorInvoiceNumber` varchar(36) DEFAULT NULL,
  `OrderedBy` varchar(15) DEFAULT NULL,
  `TaxExemptID` varchar(20) DEFAULT NULL,
  `TaxGroupID` varchar(36) DEFAULT NULL,
  `VendorID` varchar(50) DEFAULT NULL,
  `WarehouseID` varchar(36) DEFAULT NULL,
  `ShipToWarehouse` tinyint(1) DEFAULT NULL,
  `ShippingName` varchar(50) DEFAULT NULL,
  `ShippingAddress1` varchar(50) DEFAULT NULL,
  `ShippingAddress2` varchar(50) DEFAULT NULL,
  `ShippingCity` varchar(50) DEFAULT NULL,
  `ShippingState` varchar(50) DEFAULT NULL,
  `ShippingZip` varchar(10) DEFAULT NULL,
  `ShippingCountry` varchar(50) DEFAULT NULL,
  `ShipMethodID` varchar(36) DEFAULT NULL,
  `TermsID` varchar(36) DEFAULT NULL,
  `PaymentMethodID` varchar(36) DEFAULT NULL,
  `CurrencyID` varchar(3) DEFAULT NULL,
  `CurrencyExchangeRate` float DEFAULT NULL,
  `Subtotal` decimal(19,4) DEFAULT NULL,
  `DiscountPers` float DEFAULT NULL,
  `DiscountAmount` decimal(19,4) DEFAULT NULL,
  `TaxPercent` float DEFAULT NULL,
  `TaxAmount` decimal(19,4) DEFAULT NULL,
  `TaxableSubTotal` decimal(19,4) DEFAULT NULL,
  `Freight` decimal(19,4) DEFAULT NULL,
  `TaxFreight` tinyint(1) DEFAULT NULL,
  `Handling` decimal(19,4) DEFAULT NULL,
  `Advertising` decimal(19,4) DEFAULT NULL,
  `Total` decimal(19,4) DEFAULT NULL,
  `AmountPaid` decimal(19,4) DEFAULT NULL,
  `BalanceDue` decimal(19,4) DEFAULT NULL,
  `UndistributedAmount` decimal(19,4) DEFAULT NULL,
  `GLPurchaseAccount` varchar(36) DEFAULT NULL,
  `Printed` tinyint(1) DEFAULT NULL,
  `PrintedDate` datetime DEFAULT NULL,
  `Shipped` tinyint(1) DEFAULT NULL,
  `ShipDate` datetime DEFAULT NULL,
  `TrackingNumber` varchar(50) DEFAULT NULL,
  `Received` tinyint(1) DEFAULT NULL,
  `ReceivedDate` datetime DEFAULT NULL,
  `RecivingNumber` varchar(20) DEFAULT NULL,
  `Paid` tinyint(1) DEFAULT NULL,
  `CheckNumber` varchar(20) DEFAULT NULL,
  `CheckDate` datetime DEFAULT NULL,
  `PaidDate` datetime DEFAULT NULL,
  `CreditCardTypeID` varchar(15) DEFAULT NULL,
  `CreditCardName` varchar(50) DEFAULT NULL,
  `CreditCardNumber` varchar(50) DEFAULT NULL,
  `CreditCardExpDate` datetime DEFAULT NULL,
  `CreditCardCSVNumber` varchar(5) DEFAULT NULL,
  `CreditCardBillToZip` varchar(10) DEFAULT NULL,
  `CreditCardValidationCode` varchar(20) DEFAULT NULL,
  `CreditCardApprovalNumber` varchar(20) DEFAULT NULL,
  `Posted` tinyint(1) DEFAULT NULL,
  `PostedDate` datetime DEFAULT NULL,
  `HeaderMemo1` varchar(50) DEFAULT NULL,
  `HeaderMemo2` varchar(50) DEFAULT NULL,
  `HeaderMemo3` varchar(50) DEFAULT NULL,
  `HeaderMemo4` varchar(50) DEFAULT NULL,
  `HeaderMemo5` varchar(50) DEFAULT NULL,
  `HeaderMemo6` varchar(50) DEFAULT NULL,
  `HeaderMemo7` varchar(50) DEFAULT NULL,
  `HeaderMemo8` varchar(50) DEFAULT NULL,
  `HeaderMemo9` varchar(50) DEFAULT NULL,
  `LockedBy` varchar(36) DEFAULT NULL,
  `LockTS` datetime DEFAULT NULL,
  PRIMARY KEY (`CompanyID`,`DivisionID`,`DepartmentID`,`PurchaseNumber`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
delimiter ;;
CREATE TRIGGER `EDIPurchaseHeader_Audit_Insert` AFTER INSERT ON `edipurchaseheader` FOR EACH ROW SWL_return:
BEGIN
   DECLARE NO_DATA INT DEFAULT 0;
   DECLARE v_Context VARBINARY(128);
   DECLARE v_TransactionNumber NATIONAL VARCHAR(50);
   DECLARE v_TransactionLineNumber NATIONAL VARCHAR(50);

   DECLARE v_CompanyID NATIONAL VARCHAR(36);
   DECLARE v_DivisionID NATIONAL VARCHAR(36);
   DECLARE v_DepartmentID NATIONAL VARCHAR(36);
   DECLARE v_PurchaseNumber NATIONAL VARCHAR(36);

-- inserting records cursor declaration
   DECLARE cInsert CURSOR
   FOR SELECT
   i.PurchaseNumber
		,''

		,i.CompanyID
		,i.DivisionID
		,i.DepartmentID
		,i.PurchaseNumber

   FROM
   InsEDIPurchaseHeader i;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET NO_DATA = -2;
   END;
   DECLARE CONTINUE HANDLER FOR NOT FOUND SET NO_DATA = -1;
   CREATE  TEMPORARY TABLE IF NOT EXISTS InsEDIPurchaseHeader
   (
      CompanyID NATIONAL VARCHAR(36),
      DivisionID NATIONAL VARCHAR(36),
      DepartmentID NATIONAL VARCHAR(36),
      PurchaseNumber NATIONAL VARCHAR(36),
      PurchaseTypeID NATIONAL VARCHAR(36),
      EDIDirectionTypeID NATIONAL VARCHAR(1),
      EDIDocumentTypeID NATIONAL VARCHAR(3),
      EDIOpen BOOLEAN,
      PurchaseDate DATETIME,
      PurchaseDueDate DATETIME,
      PurchaseShipDate DATETIME,
      PurchaseCancelDate DATETIME,
      PurchaseDateRequested DATETIME,
      OrderNumber NATIONAL VARCHAR(36),
      VendorInvoiceNumber NATIONAL VARCHAR(36),
      OrderedBy NATIONAL VARCHAR(15),
      TaxExemptID NATIONAL VARCHAR(20),
      TaxGroupID NATIONAL VARCHAR(36),
      VendorID NATIONAL VARCHAR(50),
      WarehouseID NATIONAL VARCHAR(36),
      ShipToWarehouse BOOLEAN,
      ShippingName NATIONAL VARCHAR(50),
      ShippingAddress1 NATIONAL VARCHAR(50),
      ShippingAddress2 NATIONAL VARCHAR(50),
      ShippingCity NATIONAL VARCHAR(50),
      ShippingState NATIONAL VARCHAR(50),
      ShippingZip NATIONAL VARCHAR(10),
      ShippingCountry NATIONAL VARCHAR(50),
      ShipMethodID NATIONAL VARCHAR(36),
      TermsID NATIONAL VARCHAR(36),
      PaymentMethodID NATIONAL VARCHAR(36),
      CurrencyID NATIONAL VARCHAR(3),
      CurrencyExchangeRate FLOAT,
      Subtotal DECIMAL(19,4),
      DiscountPers FLOAT,
      DiscountAmount DECIMAL(19,4),
      TaxPercent FLOAT,
      TaxAmount DECIMAL(19,4),
      TaxableSubTotal DECIMAL(19,4),
      Freight DECIMAL(19,4),
      TaxFreight BOOLEAN,
      Handling DECIMAL(19,4),
      Advertising DECIMAL(19,4),
      Total DECIMAL(19,4),
      AmountPaid DECIMAL(19,4),
      BalanceDue DECIMAL(19,4),
      UndistributedAmount DECIMAL(19,4),
      GLPurchaseAccount NATIONAL VARCHAR(36),
      Printed BOOLEAN,
      PrintedDate DATETIME,
      Shipped BOOLEAN,
      ShipDate DATETIME,
      TrackingNumber NATIONAL VARCHAR(50),
      Received BOOLEAN,
      ReceivedDate DATETIME,
      RecivingNumber NATIONAL VARCHAR(20),
      Paid BOOLEAN,
      CheckNumber NATIONAL VARCHAR(20),
      CheckDate DATETIME,
      PaidDate DATETIME,
      CreditCardTypeID NATIONAL VARCHAR(15),
      CreditCardName NATIONAL VARCHAR(50),
      CreditCardNumber NATIONAL VARCHAR(50),
      CreditCardExpDate DATETIME,
      CreditCardCSVNumber NATIONAL VARCHAR(5),
      CreditCardBillToZip NATIONAL VARCHAR(10),
      CreditCardValidationCode NATIONAL VARCHAR(20),
      CreditCardApprovalNumber NATIONAL VARCHAR(20),
      Posted BOOLEAN,
      PostedDate DATETIME,
      HeaderMemo1 NATIONAL VARCHAR(50),
      HeaderMemo2 NATIONAL VARCHAR(50),
      HeaderMemo3 NATIONAL VARCHAR(50),
      HeaderMemo4 NATIONAL VARCHAR(50),
      HeaderMemo5 NATIONAL VARCHAR(50),
      HeaderMemo6 NATIONAL VARCHAR(50),
      HeaderMemo7 NATIONAL VARCHAR(50),
      HeaderMemo8 NATIONAL VARCHAR(50),
      HeaderMemo9 NATIONAL VARCHAR(50),
      LockedBy NATIONAL VARCHAR(36),
      LockTS DATETIME
   );
   DELETE FROM InsEDIPurchaseHeader;
   INSERT INTO InsEDIPurchaseHeader VALUES(NEW.CompanyID, NEW.DivisionID, NEW.DepartmentID, NEW.PurchaseNumber, NEW.PurchaseTypeID, NEW.EDIDirectionTypeID, NEW.EDIDocumentTypeID, NEW.EDIOpen, NEW.PurchaseDate, NEW.PurchaseDueDate, NEW.PurchaseShipDate, NEW.PurchaseCancelDate, NEW.PurchaseDateRequested, NEW.OrderNumber, NEW.VendorInvoiceNumber, NEW.OrderedBy, NEW.TaxExemptID, NEW.TaxGroupID, NEW.VendorID, NEW.WarehouseID, NEW.ShipToWarehouse, NEW.ShippingName, NEW.ShippingAddress1, NEW.ShippingAddress2, NEW.ShippingCity, NEW.ShippingState, NEW.ShippingZip, NEW.ShippingCountry, NEW.ShipMethodID, NEW.TermsID, NEW.PaymentMethodID, NEW.CurrencyID, NEW.CurrencyExchangeRate, NEW.Subtotal, NEW.DiscountPers, NEW.DiscountAmount, NEW.TaxPercent, NEW.TaxAmount, NEW.TaxableSubTotal, NEW.Freight, NEW.TaxFreight, NEW.Handling, NEW.Advertising, NEW.Total, NEW.AmountPaid, NEW.BalanceDue, NEW.UndistributedAmount, NEW.GLPurchaseAccount, NEW.Printed, NEW.PrintedDate, NEW.Shipped, NEW.ShipDate, NEW.TrackingNumber, NEW.Received, NEW.ReceivedDate, NEW.RecivingNumber, NEW.Paid, NEW.CheckNumber, NEW.CheckDate, NEW.PaidDate, NEW.CreditCardTypeID, NEW.CreditCardName, NEW.CreditCardNumber, NEW.CreditCardExpDate, NEW.CreditCardCSVNumber, NEW.CreditCardBillToZip, NEW.CreditCardValidationCode, NEW.CreditCardApprovalNumber, NEW.Posted, NEW.PostedDate, NEW.HeaderMemo1, NEW.HeaderMemo2, NEW.HeaderMemo3, NEW.HeaderMemo4, NEW.HeaderMemo5, NEW.HeaderMemo6, NEW.HeaderMemo7, NEW.HeaderMemo8, NEW.HeaderMemo9, NEW.LockedBy, NEW.LockTS);

   BEGIN
-- check for audit triggers switch off

      select   context_info INTO v_Context FROM sysprocesses WHERE spid = CONNECTION_ID();
      IF CAST(v_Context AS CHAR(36)) = N'$$AuditSwitchOff$$' then 
         LEAVE SWL_return;
      end if;

-- declarations
      OPEN cInsert;
-- fetch from each inserting record
      SET NO_DATA = 0;
      FETCH cInsert INTO
      v_TransactionNumber,v_TransactionLineNumber,v_CompanyID,v_DivisionID,v_DepartmentID,
      v_PurchaseNumber;
      WHILE NO_DATA = 0 DO
-- insert audit record for each inserting record
         IF IsGuid(v_TransactionNumber) = 0 then
		
            CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber,v_TransactionLineNumber,
            'EDIPurchaseHeader','New Record','','New Record');
         end if;
         SET NO_DATA = 0;
         FETCH cInsert INTO
         v_TransactionNumber,v_TransactionLineNumber,v_CompanyID,v_DivisionID,v_DepartmentID,
         v_PurchaseNumber;
      END WHILE;
      CLOSE cInsert;

   END;
END;
 ;;
delimiter ;
delimiter ;;
CREATE TRIGGER `EDIPurchaseHeader_Audit_Update` AFTER UPDATE ON `edipurchaseheader` FOR EACH ROW SWL_return:
BEGIN
   DECLARE NO_DATA INT DEFAULT 0;
   DECLARE v_Context VARBINARY(128);
   DECLARE v_TransactionNumber_O NATIONAL VARCHAR(50);
   DECLARE v_TransactionNumber_N NATIONAL VARCHAR(50);
   DECLARE v_TransactionLineNumber NATIONAL VARCHAR(50);

   DECLARE v_CompanyID NATIONAL VARCHAR(36);
   DECLARE v_DivisionID NATIONAL VARCHAR(36);
   DECLARE v_DepartmentID NATIONAL VARCHAR(36);
   DECLARE v_PurchaseNumber NATIONAL VARCHAR(36);

   DECLARE v_PurchaseTypeID_O NATIONAL VARCHAR(80);
   DECLARE v_PurchaseTypeID_N NATIONAL VARCHAR(80);
   DECLARE v_EDIDirectionTypeID_O NATIONAL VARCHAR(80);
   DECLARE v_EDIDirectionTypeID_N NATIONAL VARCHAR(80);
   DECLARE v_EDIDocumentTypeID_O NATIONAL VARCHAR(80);
   DECLARE v_EDIDocumentTypeID_N NATIONAL VARCHAR(80);
   DECLARE v_EDIOpen_O NATIONAL VARCHAR(80);
   DECLARE v_EDIOpen_N NATIONAL VARCHAR(80);
   DECLARE v_PurchaseDate_O NATIONAL VARCHAR(80);
   DECLARE v_PurchaseDate_N NATIONAL VARCHAR(80);
   DECLARE v_PurchaseDueDate_O NATIONAL VARCHAR(80);
   DECLARE v_PurchaseDueDate_N NATIONAL VARCHAR(80);
   DECLARE v_PurchaseShipDate_O NATIONAL VARCHAR(80);
   DECLARE v_PurchaseShipDate_N NATIONAL VARCHAR(80);
   DECLARE v_PurchaseCancelDate_O NATIONAL VARCHAR(80);
   DECLARE v_PurchaseCancelDate_N NATIONAL VARCHAR(80);
   DECLARE v_PurchaseDateRequested_O NATIONAL VARCHAR(80);
   DECLARE v_PurchaseDateRequested_N NATIONAL VARCHAR(80);
   DECLARE v_OrderNumber_O NATIONAL VARCHAR(80);
   DECLARE v_OrderNumber_N NATIONAL VARCHAR(80);
   DECLARE v_VendorInvoiceNumber_O NATIONAL VARCHAR(80);
   DECLARE v_VendorInvoiceNumber_N NATIONAL VARCHAR(80);
   DECLARE v_OrderedBy_O NATIONAL VARCHAR(80);
   DECLARE v_OrderedBy_N NATIONAL VARCHAR(80);
   DECLARE v_TaxExemptID_O NATIONAL VARCHAR(80);
   DECLARE v_TaxExemptID_N NATIONAL VARCHAR(80);
   DECLARE v_TaxGroupID_O NATIONAL VARCHAR(80);
   DECLARE v_TaxGroupID_N NATIONAL VARCHAR(80);
   DECLARE v_VendorID_O NATIONAL VARCHAR(80);
   DECLARE v_VendorID_N NATIONAL VARCHAR(80);
   DECLARE v_WarehouseID_O NATIONAL VARCHAR(80);
   DECLARE v_WarehouseID_N NATIONAL VARCHAR(80);
   DECLARE v_ShipToWarehouse_O NATIONAL VARCHAR(80);
   DECLARE v_ShipToWarehouse_N NATIONAL VARCHAR(80);
   DECLARE v_ShippingName_O NATIONAL VARCHAR(80);
   DECLARE v_ShippingName_N NATIONAL VARCHAR(80);
   DECLARE v_ShippingAddress1_O NATIONAL VARCHAR(80);
   DECLARE v_ShippingAddress1_N NATIONAL VARCHAR(80);
   DECLARE v_ShippingAddress2_O NATIONAL VARCHAR(80);
   DECLARE v_ShippingAddress2_N NATIONAL VARCHAR(80);
   DECLARE v_ShippingCity_O NATIONAL VARCHAR(80);
   DECLARE v_ShippingCity_N NATIONAL VARCHAR(80);
   DECLARE v_ShippingState_O NATIONAL VARCHAR(80);
   DECLARE v_ShippingState_N NATIONAL VARCHAR(80);
   DECLARE v_ShippingZip_O NATIONAL VARCHAR(80);
   DECLARE v_ShippingZip_N NATIONAL VARCHAR(80);
   DECLARE v_ShippingCountry_O NATIONAL VARCHAR(80);
   DECLARE v_ShippingCountry_N NATIONAL VARCHAR(80);
   DECLARE v_ShipMethodID_O NATIONAL VARCHAR(80);
   DECLARE v_ShipMethodID_N NATIONAL VARCHAR(80);
   DECLARE v_TermsID_O NATIONAL VARCHAR(80);
   DECLARE v_TermsID_N NATIONAL VARCHAR(80);
   DECLARE v_PaymentMethodID_O NATIONAL VARCHAR(80);
   DECLARE v_PaymentMethodID_N NATIONAL VARCHAR(80);
   DECLARE v_CurrencyID_O NATIONAL VARCHAR(80);
   DECLARE v_CurrencyID_N NATIONAL VARCHAR(80);
   DECLARE v_CurrencyExchangeRate_O NATIONAL VARCHAR(80);
   DECLARE v_CurrencyExchangeRate_N NATIONAL VARCHAR(80);
   DECLARE v_Subtotal_O NATIONAL VARCHAR(80);
   DECLARE v_Subtotal_N NATIONAL VARCHAR(80);
   DECLARE v_DiscountPers_O NATIONAL VARCHAR(80);
   DECLARE v_DiscountPers_N NATIONAL VARCHAR(80);
   DECLARE v_DiscountAmount_O NATIONAL VARCHAR(80);
   DECLARE v_DiscountAmount_N NATIONAL VARCHAR(80);
   DECLARE v_TaxPercent_O NATIONAL VARCHAR(80);
   DECLARE v_TaxPercent_N NATIONAL VARCHAR(80);
   DECLARE v_TaxAmount_O NATIONAL VARCHAR(80);
   DECLARE v_TaxAmount_N NATIONAL VARCHAR(80);
   DECLARE v_TaxableSubTotal_O NATIONAL VARCHAR(80);
   DECLARE v_TaxableSubTotal_N NATIONAL VARCHAR(80);
   DECLARE v_Freight_O NATIONAL VARCHAR(80);
   DECLARE v_Freight_N NATIONAL VARCHAR(80);
   DECLARE v_TaxFreight_O NATIONAL VARCHAR(80);
   DECLARE v_TaxFreight_N NATIONAL VARCHAR(80);
   DECLARE v_Handling_O NATIONAL VARCHAR(80);
   DECLARE v_Handling_N NATIONAL VARCHAR(80);
   DECLARE v_Advertising_O NATIONAL VARCHAR(80);
   DECLARE v_Advertising_N NATIONAL VARCHAR(80);
   DECLARE v_Total_O NATIONAL VARCHAR(80);
   DECLARE v_Total_N NATIONAL VARCHAR(80);
   DECLARE v_AmountPaid_O NATIONAL VARCHAR(80);
   DECLARE v_AmountPaid_N NATIONAL VARCHAR(80);
   DECLARE v_BalanceDue_O NATIONAL VARCHAR(80);
   DECLARE v_BalanceDue_N NATIONAL VARCHAR(80);
   DECLARE v_UndistributedAmount_O NATIONAL VARCHAR(80);
   DECLARE v_UndistributedAmount_N NATIONAL VARCHAR(80);
   DECLARE v_GLPurchaseAccount_O NATIONAL VARCHAR(80);
   DECLARE v_GLPurchaseAccount_N NATIONAL VARCHAR(80);
   DECLARE v_Printed_O NATIONAL VARCHAR(80);
   DECLARE v_Printed_N NATIONAL VARCHAR(80);
   DECLARE v_PrintedDate_O NATIONAL VARCHAR(80);
   DECLARE v_PrintedDate_N NATIONAL VARCHAR(80);
   DECLARE v_Shipped_O NATIONAL VARCHAR(80);
   DECLARE v_Shipped_N NATIONAL VARCHAR(80);
   DECLARE v_ShipDate_O NATIONAL VARCHAR(80);
   DECLARE v_ShipDate_N NATIONAL VARCHAR(80);
   DECLARE v_TrackingNumber_O NATIONAL VARCHAR(80);
   DECLARE v_TrackingNumber_N NATIONAL VARCHAR(80);
   DECLARE v_Received_O NATIONAL VARCHAR(80);
   DECLARE v_Received_N NATIONAL VARCHAR(80);
   DECLARE v_ReceivedDate_O NATIONAL VARCHAR(80);
   DECLARE v_ReceivedDate_N NATIONAL VARCHAR(80);
   DECLARE v_RecivingNumber_O NATIONAL VARCHAR(80);
   DECLARE v_RecivingNumber_N NATIONAL VARCHAR(80);
   DECLARE v_Paid_O NATIONAL VARCHAR(80);
   DECLARE v_Paid_N NATIONAL VARCHAR(80);
   DECLARE v_CheckNumber_O NATIONAL VARCHAR(80);
   DECLARE v_CheckNumber_N NATIONAL VARCHAR(80);
   DECLARE v_CheckDate_O NATIONAL VARCHAR(80);
   DECLARE v_CheckDate_N NATIONAL VARCHAR(80);
   DECLARE v_PaidDate_O NATIONAL VARCHAR(80);
   DECLARE v_PaidDate_N NATIONAL VARCHAR(80);
   DECLARE v_CreditCardTypeID_O NATIONAL VARCHAR(80);
   DECLARE v_CreditCardTypeID_N NATIONAL VARCHAR(80);
   DECLARE v_CreditCardName_O NATIONAL VARCHAR(80);
   DECLARE v_CreditCardName_N NATIONAL VARCHAR(80);
   DECLARE v_CreditCardNumber_O NATIONAL VARCHAR(80);
   DECLARE v_CreditCardNumber_N NATIONAL VARCHAR(80);
   DECLARE v_CreditCardExpDate_O NATIONAL VARCHAR(80);
   DECLARE v_CreditCardExpDate_N NATIONAL VARCHAR(80);
   DECLARE v_CreditCardCSVNumber_O NATIONAL VARCHAR(80);
   DECLARE v_CreditCardCSVNumber_N NATIONAL VARCHAR(80);
   DECLARE v_CreditCardBillToZip_O NATIONAL VARCHAR(80);
   DECLARE v_CreditCardBillToZip_N NATIONAL VARCHAR(80);
   DECLARE v_CreditCardValidationCode_O NATIONAL VARCHAR(80);
   DECLARE v_CreditCardValidationCode_N NATIONAL VARCHAR(80);
   DECLARE v_CreditCardApprovalNumber_O NATIONAL VARCHAR(80);
   DECLARE v_CreditCardApprovalNumber_N NATIONAL VARCHAR(80);
   DECLARE v_Posted_O NATIONAL VARCHAR(80);
   DECLARE v_Posted_N NATIONAL VARCHAR(80);
   DECLARE v_PostedDate_O NATIONAL VARCHAR(80);
   DECLARE v_PostedDate_N NATIONAL VARCHAR(80);
   DECLARE v_HeaderMemo1_O NATIONAL VARCHAR(80);
   DECLARE v_HeaderMemo1_N NATIONAL VARCHAR(80);
   DECLARE v_HeaderMemo2_O NATIONAL VARCHAR(80);
   DECLARE v_HeaderMemo2_N NATIONAL VARCHAR(80);
   DECLARE v_HeaderMemo3_O NATIONAL VARCHAR(80);
   DECLARE v_HeaderMemo3_N NATIONAL VARCHAR(80);
   DECLARE v_HeaderMemo4_O NATIONAL VARCHAR(80);
   DECLARE v_HeaderMemo4_N NATIONAL VARCHAR(80);
   DECLARE v_HeaderMemo5_O NATIONAL VARCHAR(80);
   DECLARE v_HeaderMemo5_N NATIONAL VARCHAR(80);
   DECLARE v_HeaderMemo6_O NATIONAL VARCHAR(80);
   DECLARE v_HeaderMemo6_N NATIONAL VARCHAR(80);
   DECLARE v_HeaderMemo7_O NATIONAL VARCHAR(80);
   DECLARE v_HeaderMemo7_N NATIONAL VARCHAR(80);
   DECLARE v_HeaderMemo8_O NATIONAL VARCHAR(80);
   DECLARE v_HeaderMemo8_N NATIONAL VARCHAR(80);
   DECLARE v_HeaderMemo9_O NATIONAL VARCHAR(80);
   DECLARE v_HeaderMemo9_N NATIONAL VARCHAR(80);
 

-- updating records cursor declaration
   DECLARE cUpdate CURSOR
   FOR SELECT
   d.PurchaseNumber
		,i.PurchaseNumber
		,''

		,i.CompanyID
		,i.DivisionID
		,i.DepartmentID
		,i.PurchaseNumber

,CAST(d.PurchaseTypeID AS CHAR(80))
,CAST(i.PurchaseTypeID AS CHAR(80))
,CAST(d.EDIDirectionTypeID AS CHAR(80))
,CAST(i.EDIDirectionTypeID AS CHAR(80))
,CAST(d.EDIDocumentTypeID AS CHAR(80))
,CAST(i.EDIDocumentTypeID AS CHAR(80))
,CAST(d.EDIOpen AS CHAR(80))
,CAST(i.EDIOpen AS CHAR(80))
,CAST(d.PurchaseDate AS CHAR(80))
,CAST(i.PurchaseDate AS CHAR(80))
,CAST(d.PurchaseDueDate AS CHAR(80))
,CAST(i.PurchaseDueDate AS CHAR(80))
,CAST(d.PurchaseShipDate AS CHAR(80))
,CAST(i.PurchaseShipDate AS CHAR(80))
,CAST(d.PurchaseCancelDate AS CHAR(80))
,CAST(i.PurchaseCancelDate AS CHAR(80))
,CAST(d.PurchaseDateRequested AS CHAR(80))
,CAST(i.PurchaseDateRequested AS CHAR(80))
,CAST(d.OrderNumber AS CHAR(80))
,CAST(i.OrderNumber AS CHAR(80))
,CAST(d.VendorInvoiceNumber AS CHAR(80))
,CAST(i.VendorInvoiceNumber AS CHAR(80))
,CAST(d.OrderedBy AS CHAR(80))
,CAST(i.OrderedBy AS CHAR(80))
,CAST(d.TaxExemptID AS CHAR(80))
,CAST(i.TaxExemptID AS CHAR(80))
,CAST(d.TaxGroupID AS CHAR(80))
,CAST(i.TaxGroupID AS CHAR(80))
,CAST(d.VendorID AS CHAR(80))
,CAST(i.VendorID AS CHAR(80))
,CAST(d.WarehouseID AS CHAR(80))
,CAST(i.WarehouseID AS CHAR(80))
,CAST(d.ShipToWarehouse AS CHAR(80))
,CAST(i.ShipToWarehouse AS CHAR(80))
,CAST(d.ShippingName AS CHAR(80))
,CAST(i.ShippingName AS CHAR(80))
,CAST(d.ShippingAddress1 AS CHAR(80))
,CAST(i.ShippingAddress1 AS CHAR(80))
,CAST(d.ShippingAddress2 AS CHAR(80))
,CAST(i.ShippingAddress2 AS CHAR(80))
,CAST(d.ShippingCity AS CHAR(80))
,CAST(i.ShippingCity AS CHAR(80))
,CAST(d.ShippingState AS CHAR(80))
,CAST(i.ShippingState AS CHAR(80))
,CAST(d.ShippingZip AS CHAR(80))
,CAST(i.ShippingZip AS CHAR(80))
,CAST(d.ShippingCountry AS CHAR(80))
,CAST(i.ShippingCountry AS CHAR(80))
,CAST(d.ShipMethodID AS CHAR(80))
,CAST(i.ShipMethodID AS CHAR(80))
,CAST(d.TermsID AS CHAR(80))
,CAST(i.TermsID AS CHAR(80))
,CAST(d.PaymentMethodID AS CHAR(80))
,CAST(i.PaymentMethodID AS CHAR(80))
,CAST(d.CurrencyID AS CHAR(80))
,CAST(i.CurrencyID AS CHAR(80))
,CAST(d.CurrencyExchangeRate AS CHAR(80))
,CAST(i.CurrencyExchangeRate AS CHAR(80))
,CAST(d.Subtotal AS CHAR(80))
,CAST(i.Subtotal AS CHAR(80))
,CAST(d.DiscountPers AS CHAR(80))
,CAST(i.DiscountPers AS CHAR(80))
,CAST(d.DiscountAmount AS CHAR(80))
,CAST(i.DiscountAmount AS CHAR(80))
,CAST(d.TaxPercent AS CHAR(80))
,CAST(i.TaxPercent AS CHAR(80))
,CAST(d.TaxAmount AS CHAR(80))
,CAST(i.TaxAmount AS CHAR(80))
,CAST(d.TaxableSubTotal AS CHAR(80))
,CAST(i.TaxableSubTotal AS CHAR(80))
,CAST(d.Freight AS CHAR(80))
,CAST(i.Freight AS CHAR(80))
,CAST(d.TaxFreight AS CHAR(80))
,CAST(i.TaxFreight AS CHAR(80))
,CAST(d.Handling AS CHAR(80))
,CAST(i.Handling AS CHAR(80))
,CAST(d.Advertising AS CHAR(80))
,CAST(i.Advertising AS CHAR(80))
,CAST(d.Total AS CHAR(80))
,CAST(i.Total AS CHAR(80))
,CAST(d.AmountPaid AS CHAR(80))
,CAST(i.AmountPaid AS CHAR(80))
,CAST(d.BalanceDue AS CHAR(80))
,CAST(i.BalanceDue AS CHAR(80))
,CAST(d.UndistributedAmount AS CHAR(80))
,CAST(i.UndistributedAmount AS CHAR(80))
,CAST(d.GLPurchaseAccount AS CHAR(80))
,CAST(i.GLPurchaseAccount AS CHAR(80))
,CAST(d.Printed AS CHAR(80))
,CAST(i.Printed AS CHAR(80))
,CAST(d.PrintedDate AS CHAR(80))
,CAST(i.PrintedDate AS CHAR(80))
,CAST(d.Shipped AS CHAR(80))
,CAST(i.Shipped AS CHAR(80))
,CAST(d.ShipDate AS CHAR(80))
,CAST(i.ShipDate AS CHAR(80))
,CAST(d.TrackingNumber AS CHAR(80))
,CAST(i.TrackingNumber AS CHAR(80))
,CAST(d.Received AS CHAR(80))
,CAST(i.Received AS CHAR(80))
,CAST(d.ReceivedDate AS CHAR(80))
,CAST(i.ReceivedDate AS CHAR(80))
,CAST(d.RecivingNumber AS CHAR(80))
,CAST(i.RecivingNumber AS CHAR(80))
,CAST(d.Paid AS CHAR(80))
,CAST(i.Paid AS CHAR(80))
,CAST(d.CheckNumber AS CHAR(80))
,CAST(i.CheckNumber AS CHAR(80))
,CAST(d.CheckDate AS CHAR(80))
,CAST(i.CheckDate AS CHAR(80))
,CAST(d.PaidDate AS CHAR(80))
,CAST(i.PaidDate AS CHAR(80))
,CAST(d.CreditCardTypeID AS CHAR(80))
,CAST(i.CreditCardTypeID AS CHAR(80))
,CAST(d.CreditCardName AS CHAR(80))
,CAST(i.CreditCardName AS CHAR(80))
,CAST(d.CreditCardNumber AS CHAR(80))
,CAST(i.CreditCardNumber AS CHAR(80))
,CAST(d.CreditCardExpDate AS CHAR(80))
,CAST(i.CreditCardExpDate AS CHAR(80))
,CAST(d.CreditCardCSVNumber AS CHAR(80))
,CAST(i.CreditCardCSVNumber AS CHAR(80))
,CAST(d.CreditCardBillToZip AS CHAR(80))
,CAST(i.CreditCardBillToZip AS CHAR(80))
,CAST(d.CreditCardValidationCode AS CHAR(80))
,CAST(i.CreditCardValidationCode AS CHAR(80))
,CAST(d.CreditCardApprovalNumber AS CHAR(80))
,CAST(i.CreditCardApprovalNumber AS CHAR(80))
,CAST(d.Posted AS CHAR(80))
,CAST(i.Posted AS CHAR(80))
,CAST(d.PostedDate AS CHAR(80))
,CAST(i.PostedDate AS CHAR(80))
,CAST(d.HeaderMemo1 AS CHAR(80))
,CAST(i.HeaderMemo1 AS CHAR(80))
,CAST(d.HeaderMemo2 AS CHAR(80))
,CAST(i.HeaderMemo2 AS CHAR(80))
,CAST(d.HeaderMemo3 AS CHAR(80))
,CAST(i.HeaderMemo3 AS CHAR(80))
,CAST(d.HeaderMemo4 AS CHAR(80))
,CAST(i.HeaderMemo4 AS CHAR(80))
,CAST(d.HeaderMemo5 AS CHAR(80))
,CAST(i.HeaderMemo5 AS CHAR(80))
,CAST(d.HeaderMemo6 AS CHAR(80))
,CAST(i.HeaderMemo6 AS CHAR(80))
,CAST(d.HeaderMemo7 AS CHAR(80))
,CAST(i.HeaderMemo7 AS CHAR(80))
,CAST(d.HeaderMemo8 AS CHAR(80))
,CAST(i.HeaderMemo8 AS CHAR(80))
,CAST(d.HeaderMemo9 AS CHAR(80))
,CAST(i.HeaderMemo9 AS CHAR(80))
 

   FROM
   InsEDIPurchaseHeader i
   LEFT OUTER JOIN DelEDIPurchaseHeader d ON
   d.CompanyID = i.CompanyID
   AND d.DivisionID = i.DivisionID
   AND d.DepartmentID = i.DepartmentID
   AND d.PurchaseNumber = i.PurchaseNumber;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET NO_DATA = -2;
   END;
   DECLARE CONTINUE HANDLER FOR NOT FOUND SET NO_DATA = -1;
   CREATE  TEMPORARY TABLE IF NOT EXISTS InsEDIPurchaseHeader
   (
      CompanyID NATIONAL VARCHAR(36),
      DivisionID NATIONAL VARCHAR(36),
      DepartmentID NATIONAL VARCHAR(36),
      PurchaseNumber NATIONAL VARCHAR(36),
      PurchaseTypeID NATIONAL VARCHAR(36),
      EDIDirectionTypeID NATIONAL VARCHAR(1),
      EDIDocumentTypeID NATIONAL VARCHAR(3),
      EDIOpen BOOLEAN,
      PurchaseDate DATETIME,
      PurchaseDueDate DATETIME,
      PurchaseShipDate DATETIME,
      PurchaseCancelDate DATETIME,
      PurchaseDateRequested DATETIME,
      OrderNumber NATIONAL VARCHAR(36),
      VendorInvoiceNumber NATIONAL VARCHAR(36),
      OrderedBy NATIONAL VARCHAR(15),
      TaxExemptID NATIONAL VARCHAR(20),
      TaxGroupID NATIONAL VARCHAR(36),
      VendorID NATIONAL VARCHAR(50),
      WarehouseID NATIONAL VARCHAR(36),
      ShipToWarehouse BOOLEAN,
      ShippingName NATIONAL VARCHAR(50),
      ShippingAddress1 NATIONAL VARCHAR(50),
      ShippingAddress2 NATIONAL VARCHAR(50),
      ShippingCity NATIONAL VARCHAR(50),
      ShippingState NATIONAL VARCHAR(50),
      ShippingZip NATIONAL VARCHAR(10),
      ShippingCountry NATIONAL VARCHAR(50),
      ShipMethodID NATIONAL VARCHAR(36),
      TermsID NATIONAL VARCHAR(36),
      PaymentMethodID NATIONAL VARCHAR(36),
      CurrencyID NATIONAL VARCHAR(3),
      CurrencyExchangeRate FLOAT,
      Subtotal DECIMAL(19,4),
      DiscountPers FLOAT,
      DiscountAmount DECIMAL(19,4),
      TaxPercent FLOAT,
      TaxAmount DECIMAL(19,4),
      TaxableSubTotal DECIMAL(19,4),
      Freight DECIMAL(19,4),
      TaxFreight BOOLEAN,
      Handling DECIMAL(19,4),
      Advertising DECIMAL(19,4),
      Total DECIMAL(19,4),
      AmountPaid DECIMAL(19,4),
      BalanceDue DECIMAL(19,4),
      UndistributedAmount DECIMAL(19,4),
      GLPurchaseAccount NATIONAL VARCHAR(36),
      Printed BOOLEAN,
      PrintedDate DATETIME,
      Shipped BOOLEAN,
      ShipDate DATETIME,
      TrackingNumber NATIONAL VARCHAR(50),
      Received BOOLEAN,
      ReceivedDate DATETIME,
      RecivingNumber NATIONAL VARCHAR(20),
      Paid BOOLEAN,
      CheckNumber NATIONAL VARCHAR(20),
      CheckDate DATETIME,
      PaidDate DATETIME,
      CreditCardTypeID NATIONAL VARCHAR(15),
      CreditCardName NATIONAL VARCHAR(50),
      CreditCardNumber NATIONAL VARCHAR(50),
      CreditCardExpDate DATETIME,
      CreditCardCSVNumber NATIONAL VARCHAR(5),
      CreditCardBillToZip NATIONAL VARCHAR(10),
      CreditCardValidationCode NATIONAL VARCHAR(20),
      CreditCardApprovalNumber NATIONAL VARCHAR(20),
      Posted BOOLEAN,
      PostedDate DATETIME,
      HeaderMemo1 NATIONAL VARCHAR(50),
      HeaderMemo2 NATIONAL VARCHAR(50),
      HeaderMemo3 NATIONAL VARCHAR(50),
      HeaderMemo4 NATIONAL VARCHAR(50),
      HeaderMemo5 NATIONAL VARCHAR(50),
      HeaderMemo6 NATIONAL VARCHAR(50),
      HeaderMemo7 NATIONAL VARCHAR(50),
      HeaderMemo8 NATIONAL VARCHAR(50),
      HeaderMemo9 NATIONAL VARCHAR(50),
      LockedBy NATIONAL VARCHAR(36),
      LockTS DATETIME
   );
   DELETE FROM InsEDIPurchaseHeader;
   INSERT INTO InsEDIPurchaseHeader VALUES(NEW.CompanyID, NEW.DivisionID, NEW.DepartmentID, NEW.PurchaseNumber, NEW.PurchaseTypeID, NEW.EDIDirectionTypeID, NEW.EDIDocumentTypeID, NEW.EDIOpen, NEW.PurchaseDate, NEW.PurchaseDueDate, NEW.PurchaseShipDate, NEW.PurchaseCancelDate, NEW.PurchaseDateRequested, NEW.OrderNumber, NEW.VendorInvoiceNumber, NEW.OrderedBy, NEW.TaxExemptID, NEW.TaxGroupID, NEW.VendorID, NEW.WarehouseID, NEW.ShipToWarehouse, NEW.ShippingName, NEW.ShippingAddress1, NEW.ShippingAddress2, NEW.ShippingCity, NEW.ShippingState, NEW.ShippingZip, NEW.ShippingCountry, NEW.ShipMethodID, NEW.TermsID, NEW.PaymentMethodID, NEW.CurrencyID, NEW.CurrencyExchangeRate, NEW.Subtotal, NEW.DiscountPers, NEW.DiscountAmount, NEW.TaxPercent, NEW.TaxAmount, NEW.TaxableSubTotal, NEW.Freight, NEW.TaxFreight, NEW.Handling, NEW.Advertising, NEW.Total, NEW.AmountPaid, NEW.BalanceDue, NEW.UndistributedAmount, NEW.GLPurchaseAccount, NEW.Printed, NEW.PrintedDate, NEW.Shipped, NEW.ShipDate, NEW.TrackingNumber, NEW.Received, NEW.ReceivedDate, NEW.RecivingNumber, NEW.Paid, NEW.CheckNumber, NEW.CheckDate, NEW.PaidDate, NEW.CreditCardTypeID, NEW.CreditCardName, NEW.CreditCardNumber, NEW.CreditCardExpDate, NEW.CreditCardCSVNumber, NEW.CreditCardBillToZip, NEW.CreditCardValidationCode, NEW.CreditCardApprovalNumber, NEW.Posted, NEW.PostedDate, NEW.HeaderMemo1, NEW.HeaderMemo2, NEW.HeaderMemo3, NEW.HeaderMemo4, NEW.HeaderMemo5, NEW.HeaderMemo6, NEW.HeaderMemo7, NEW.HeaderMemo8, NEW.HeaderMemo9, NEW.LockedBy, NEW.LockTS);

   CREATE  TEMPORARY TABLE IF NOT EXISTS DelEDIPurchaseHeader
   (
      CompanyID NATIONAL VARCHAR(36),
      DivisionID NATIONAL VARCHAR(36),
      DepartmentID NATIONAL VARCHAR(36),
      PurchaseNumber NATIONAL VARCHAR(36),
      PurchaseTypeID NATIONAL VARCHAR(36),
      EDIDirectionTypeID NATIONAL VARCHAR(1),
      EDIDocumentTypeID NATIONAL VARCHAR(3),
      EDIOpen BOOLEAN,
      PurchaseDate DATETIME,
      PurchaseDueDate DATETIME,
      PurchaseShipDate DATETIME,
      PurchaseCancelDate DATETIME,
      PurchaseDateRequested DATETIME,
      OrderNumber NATIONAL VARCHAR(36),
      VendorInvoiceNumber NATIONAL VARCHAR(36),
      OrderedBy NATIONAL VARCHAR(15),
      TaxExemptID NATIONAL VARCHAR(20),
      TaxGroupID NATIONAL VARCHAR(36),
      VendorID NATIONAL VARCHAR(50),
      WarehouseID NATIONAL VARCHAR(36),
      ShipToWarehouse BOOLEAN,
      ShippingName NATIONAL VARCHAR(50),
      ShippingAddress1 NATIONAL VARCHAR(50),
      ShippingAddress2 NATIONAL VARCHAR(50),
      ShippingCity NATIONAL VARCHAR(50),
      ShippingState NATIONAL VARCHAR(50),
      ShippingZip NATIONAL VARCHAR(10),
      ShippingCountry NATIONAL VARCHAR(50),
      ShipMethodID NATIONAL VARCHAR(36),
      TermsID NATIONAL VARCHAR(36),
      PaymentMethodID NATIONAL VARCHAR(36),
      CurrencyID NATIONAL VARCHAR(3),
      CurrencyExchangeRate FLOAT,
      Subtotal DECIMAL(19,4),
      DiscountPers FLOAT,
      DiscountAmount DECIMAL(19,4),
      TaxPercent FLOAT,
      TaxAmount DECIMAL(19,4),
      TaxableSubTotal DECIMAL(19,4),
      Freight DECIMAL(19,4),
      TaxFreight BOOLEAN,
      Handling DECIMAL(19,4),
      Advertising DECIMAL(19,4),
      Total DECIMAL(19,4),
      AmountPaid DECIMAL(19,4),
      BalanceDue DECIMAL(19,4),
      UndistributedAmount DECIMAL(19,4),
      GLPurchaseAccount NATIONAL VARCHAR(36),
      Printed BOOLEAN,
      PrintedDate DATETIME,
      Shipped BOOLEAN,
      ShipDate DATETIME,
      TrackingNumber NATIONAL VARCHAR(50),
      Received BOOLEAN,
      ReceivedDate DATETIME,
      RecivingNumber NATIONAL VARCHAR(20),
      Paid BOOLEAN,
      CheckNumber NATIONAL VARCHAR(20),
      CheckDate DATETIME,
      PaidDate DATETIME,
      CreditCardTypeID NATIONAL VARCHAR(15),
      CreditCardName NATIONAL VARCHAR(50),
      CreditCardNumber NATIONAL VARCHAR(50),
      CreditCardExpDate DATETIME,
      CreditCardCSVNumber NATIONAL VARCHAR(5),
      CreditCardBillToZip NATIONAL VARCHAR(10),
      CreditCardValidationCode NATIONAL VARCHAR(20),
      CreditCardApprovalNumber NATIONAL VARCHAR(20),
      Posted BOOLEAN,
      PostedDate DATETIME,
      HeaderMemo1 NATIONAL VARCHAR(50),
      HeaderMemo2 NATIONAL VARCHAR(50),
      HeaderMemo3 NATIONAL VARCHAR(50),
      HeaderMemo4 NATIONAL VARCHAR(50),
      HeaderMemo5 NATIONAL VARCHAR(50),
      HeaderMemo6 NATIONAL VARCHAR(50),
      HeaderMemo7 NATIONAL VARCHAR(50),
      HeaderMemo8 NATIONAL VARCHAR(50),
      HeaderMemo9 NATIONAL VARCHAR(50),
      LockedBy NATIONAL VARCHAR(36),
      LockTS DATETIME
   );
   DELETE FROM DelEDIPurchaseHeader;
   INSERT INTO DelEDIPurchaseHeader VALUES(OLD.CompanyID, OLD.DivisionID, OLD.DepartmentID, OLD.PurchaseNumber, OLD.PurchaseTypeID, OLD.EDIDirectionTypeID, OLD.EDIDocumentTypeID, OLD.EDIOpen, OLD.PurchaseDate, OLD.PurchaseDueDate, OLD.PurchaseShipDate, OLD.PurchaseCancelDate, OLD.PurchaseDateRequested, OLD.OrderNumber, OLD.VendorInvoiceNumber, OLD.OrderedBy, OLD.TaxExemptID, OLD.TaxGroupID, OLD.VendorID, OLD.WarehouseID, OLD.ShipToWarehouse, OLD.ShippingName, OLD.ShippingAddress1, OLD.ShippingAddress2, OLD.ShippingCity, OLD.ShippingState, OLD.ShippingZip, OLD.ShippingCountry, OLD.ShipMethodID, OLD.TermsID, OLD.PaymentMethodID, OLD.CurrencyID, OLD.CurrencyExchangeRate, OLD.Subtotal, OLD.DiscountPers, OLD.DiscountAmount, OLD.TaxPercent, OLD.TaxAmount, OLD.TaxableSubTotal, OLD.Freight, OLD.TaxFreight, OLD.Handling, OLD.Advertising, OLD.Total, OLD.AmountPaid, OLD.BalanceDue, OLD.UndistributedAmount, OLD.GLPurchaseAccount, OLD.Printed, OLD.PrintedDate, OLD.Shipped, OLD.ShipDate, OLD.TrackingNumber, OLD.Received, OLD.ReceivedDate, OLD.RecivingNumber, OLD.Paid, OLD.CheckNumber, OLD.CheckDate, OLD.PaidDate, OLD.CreditCardTypeID, OLD.CreditCardName, OLD.CreditCardNumber, OLD.CreditCardExpDate, OLD.CreditCardCSVNumber, OLD.CreditCardBillToZip, OLD.CreditCardValidationCode, OLD.CreditCardApprovalNumber, OLD.Posted, OLD.PostedDate, OLD.HeaderMemo1, OLD.HeaderMemo2, OLD.HeaderMemo3, OLD.HeaderMemo4, OLD.HeaderMemo5, OLD.HeaderMemo6, OLD.HeaderMemo7, OLD.HeaderMemo8, OLD.HeaderMemo9, OLD.LockedBy, OLD.LockTS);

   BEGIN
-- check for audit triggers switch off

      select   context_info INTO v_Context FROM sysprocesses WHERE spid = CONNECTION_ID();
      IF CAST(v_Context AS CHAR(36)) = N'$$AuditSwitchOff$$' then 
         LEAVE SWL_return;
      end if;

-- declarations
      OPEN cUpdate;
-- fetch from each updating record
      SET NO_DATA = 0;
      FETCH cUpdate INTO
      v_TransactionNumber_O,v_TransactionNumber_N,v_TransactionLineNumber,v_CompanyID,
      v_DivisionID,v_DepartmentID,v_PurchaseNumber,v_PurchaseTypeID_O,
      v_PurchaseTypeID_N,v_EDIDirectionTypeID_O,v_EDIDirectionTypeID_N,v_EDIDocumentTypeID_O,
      v_EDIDocumentTypeID_N,v_EDIOpen_O,v_EDIOpen_N,v_PurchaseDate_O,
      v_PurchaseDate_N,v_PurchaseDueDate_O,v_PurchaseDueDate_N,
      v_PurchaseShipDate_O,v_PurchaseShipDate_N,v_PurchaseCancelDate_O,v_PurchaseCancelDate_N,
      v_PurchaseDateRequested_O,v_PurchaseDateRequested_N,
      v_OrderNumber_O,v_OrderNumber_N,v_VendorInvoiceNumber_O,v_VendorInvoiceNumber_N,
      v_OrderedBy_O,v_OrderedBy_N,v_TaxExemptID_O,v_TaxExemptID_N,
      v_TaxGroupID_O,v_TaxGroupID_N,v_VendorID_O,v_VendorID_N,v_WarehouseID_O,
      v_WarehouseID_N,v_ShipToWarehouse_O,v_ShipToWarehouse_N,v_ShippingName_O,
      v_ShippingName_N,v_ShippingAddress1_O,v_ShippingAddress1_N,v_ShippingAddress2_O,
      v_ShippingAddress2_N,v_ShippingCity_O,v_ShippingCity_N,
      v_ShippingState_O,v_ShippingState_N,v_ShippingZip_O,v_ShippingZip_N,v_ShippingCountry_O,
      v_ShippingCountry_N,v_ShipMethodID_O,v_ShipMethodID_N,
      v_TermsID_O,v_TermsID_N,v_PaymentMethodID_O,v_PaymentMethodID_N,v_CurrencyID_O,
      v_CurrencyID_N,v_CurrencyExchangeRate_O,v_CurrencyExchangeRate_N,
      v_Subtotal_O,v_Subtotal_N,v_DiscountPers_O,v_DiscountPers_N,v_DiscountAmount_O,
      v_DiscountAmount_N,v_TaxPercent_O,v_TaxPercent_N,v_TaxAmount_O,
      v_TaxAmount_N,v_TaxableSubTotal_O,v_TaxableSubTotal_N,v_Freight_O,
      v_Freight_N,v_TaxFreight_O,v_TaxFreight_N,v_Handling_O,v_Handling_N,
      v_Advertising_O,v_Advertising_N,v_Total_O,v_Total_N,v_AmountPaid_O,
      v_AmountPaid_N,v_BalanceDue_O,v_BalanceDue_N,v_UndistributedAmount_O,v_UndistributedAmount_N,
      v_GLPurchaseAccount_O,v_GLPurchaseAccount_N,v_Printed_O,
      v_Printed_N,v_PrintedDate_O,v_PrintedDate_N,v_Shipped_O,v_Shipped_N,
      v_ShipDate_O,v_ShipDate_N,v_TrackingNumber_O,v_TrackingNumber_N,
      v_Received_O,v_Received_N,v_ReceivedDate_O,v_ReceivedDate_N,v_RecivingNumber_O,
      v_RecivingNumber_N,v_Paid_O,v_Paid_N,v_CheckNumber_O,v_CheckNumber_N,
      v_CheckDate_O,v_CheckDate_N,v_PaidDate_O,v_PaidDate_N,v_CreditCardTypeID_O,
      v_CreditCardTypeID_N,v_CreditCardName_O,v_CreditCardName_N,
      v_CreditCardNumber_O,v_CreditCardNumber_N,v_CreditCardExpDate_O,v_CreditCardExpDate_N,
      v_CreditCardCSVNumber_O,v_CreditCardCSVNumber_N,v_CreditCardBillToZip_O,
      v_CreditCardBillToZip_N,v_CreditCardValidationCode_O,
      v_CreditCardValidationCode_N,v_CreditCardApprovalNumber_O,v_CreditCardApprovalNumber_N,
      v_Posted_O,v_Posted_N,v_PostedDate_O,v_PostedDate_N,
      v_HeaderMemo1_O,v_HeaderMemo1_N,v_HeaderMemo2_O,v_HeaderMemo2_N,v_HeaderMemo3_O,
      v_HeaderMemo3_N,v_HeaderMemo4_O,v_HeaderMemo4_N,v_HeaderMemo5_O,
      v_HeaderMemo5_N,v_HeaderMemo6_O,v_HeaderMemo6_N,v_HeaderMemo7_O,
      v_HeaderMemo7_N,v_HeaderMemo8_O,v_HeaderMemo8_N,v_HeaderMemo9_O,v_HeaderMemo9_N;
      WHILE NO_DATA = 0 DO
-- insert audit records for each changed field
         IF IsGuid(v_TransactionNumber_N) = 0 then
		
            IF v_TransactionNumber_O IS NULL then
				
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIPurchaseHeader','New Record','','New Record');
            ELSE
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIPurchaseHeader','PurchaseTypeID',v_PurchaseTypeID_O,
               v_PurchaseTypeID_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIPurchaseHeader','EDIDirectionTypeID',v_EDIDirectionTypeID_O,
               v_EDIDirectionTypeID_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIPurchaseHeader','EDIDocumentTypeID',v_EDIDocumentTypeID_O,
               v_EDIDocumentTypeID_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIPurchaseHeader','EDIOpen',v_EDIOpen_O,v_EDIOpen_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIPurchaseHeader','PurchaseDate',v_PurchaseDate_O,
               v_PurchaseDate_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIPurchaseHeader','PurchaseDueDate',v_PurchaseDueDate_O,
               v_PurchaseDueDate_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIPurchaseHeader','PurchaseShipDate',v_PurchaseShipDate_O,
               v_PurchaseShipDate_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIPurchaseHeader','PurchaseCancelDate',v_PurchaseCancelDate_O,
               v_PurchaseCancelDate_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIPurchaseHeader','PurchaseDateRequested',v_PurchaseDateRequested_O,
               v_PurchaseDateRequested_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIPurchaseHeader','OrderNumber',v_OrderNumber_O,
               v_OrderNumber_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIPurchaseHeader','VendorInvoiceNumber',v_VendorInvoiceNumber_O,
               v_VendorInvoiceNumber_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIPurchaseHeader','OrderedBy',v_OrderedBy_O,v_OrderedBy_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIPurchaseHeader','TaxExemptID',v_TaxExemptID_O,
               v_TaxExemptID_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIPurchaseHeader','TaxGroupID',v_TaxGroupID_O,
               v_TaxGroupID_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIPurchaseHeader','VendorID',v_VendorID_O,v_VendorID_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIPurchaseHeader','WarehouseID',v_WarehouseID_O,
               v_WarehouseID_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIPurchaseHeader','ShipToWarehouse',v_ShipToWarehouse_O,
               v_ShipToWarehouse_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIPurchaseHeader','ShippingName',v_ShippingName_O,
               v_ShippingName_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIPurchaseHeader','ShippingAddress1',v_ShippingAddress1_O,
               v_ShippingAddress1_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIPurchaseHeader','ShippingAddress2',v_ShippingAddress2_O,
               v_ShippingAddress2_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIPurchaseHeader','ShippingCity',v_ShippingCity_O,
               v_ShippingCity_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIPurchaseHeader','ShippingState',v_ShippingState_O,
               v_ShippingState_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIPurchaseHeader','ShippingZip',v_ShippingZip_O,
               v_ShippingZip_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIPurchaseHeader','ShippingCountry',v_ShippingCountry_O,
               v_ShippingCountry_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIPurchaseHeader','ShipMethodID',v_ShipMethodID_O,
               v_ShipMethodID_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIPurchaseHeader','TermsID',v_TermsID_O,v_TermsID_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIPurchaseHeader','PaymentMethodID',v_PaymentMethodID_O,
               v_PaymentMethodID_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIPurchaseHeader','CurrencyID',v_CurrencyID_O,
               v_CurrencyID_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIPurchaseHeader','CurrencyExchangeRate',v_CurrencyExchangeRate_O,
               v_CurrencyExchangeRate_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIPurchaseHeader','Subtotal',v_Subtotal_O,v_Subtotal_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIPurchaseHeader','DiscountPers',v_DiscountPers_O,
               v_DiscountPers_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIPurchaseHeader','DiscountAmount',v_DiscountAmount_O,
               v_DiscountAmount_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIPurchaseHeader','TaxPercent',v_TaxPercent_O,
               v_TaxPercent_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIPurchaseHeader','TaxAmount',v_TaxAmount_O,v_TaxAmount_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIPurchaseHeader','TaxableSubTotal',v_TaxableSubTotal_O,
               v_TaxableSubTotal_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIPurchaseHeader','Freight',v_Freight_O,v_Freight_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIPurchaseHeader','TaxFreight',v_TaxFreight_O,
               v_TaxFreight_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIPurchaseHeader','Handling',v_Handling_O,v_Handling_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIPurchaseHeader','Advertising',v_Advertising_O,
               v_Advertising_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIPurchaseHeader','Total',v_Total_O,v_Total_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIPurchaseHeader','AmountPaid',v_AmountPaid_O,
               v_AmountPaid_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIPurchaseHeader','BalanceDue',v_BalanceDue_O,
               v_BalanceDue_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIPurchaseHeader','UndistributedAmount',v_UndistributedAmount_O,
               v_UndistributedAmount_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIPurchaseHeader','GLPurchaseAccount',v_GLPurchaseAccount_O,
               v_GLPurchaseAccount_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIPurchaseHeader','Printed',v_Printed_O,v_Printed_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIPurchaseHeader','PrintedDate',v_PrintedDate_O,
               v_PrintedDate_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIPurchaseHeader','Shipped',v_Shipped_O,v_Shipped_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIPurchaseHeader','ShipDate',v_ShipDate_O,v_ShipDate_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIPurchaseHeader','TrackingNumber',v_TrackingNumber_O,
               v_TrackingNumber_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIPurchaseHeader','Received',v_Received_O,v_Received_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIPurchaseHeader','ReceivedDate',v_ReceivedDate_O,
               v_ReceivedDate_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIPurchaseHeader','RecivingNumber',v_RecivingNumber_O,
               v_RecivingNumber_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIPurchaseHeader','Paid',v_Paid_O,v_Paid_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIPurchaseHeader','CheckNumber',v_CheckNumber_O,
               v_CheckNumber_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIPurchaseHeader','CheckDate',v_CheckDate_O,v_CheckDate_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIPurchaseHeader','PaidDate',v_PaidDate_O,v_PaidDate_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIPurchaseHeader','CreditCardTypeID',v_CreditCardTypeID_O,
               v_CreditCardTypeID_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIPurchaseHeader','CreditCardName',v_CreditCardName_O,
               v_CreditCardName_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIPurchaseHeader','CreditCardNumber',v_CreditCardNumber_O,
               v_CreditCardNumber_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIPurchaseHeader','CreditCardExpDate',v_CreditCardExpDate_O,
               v_CreditCardExpDate_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIPurchaseHeader','CreditCardCSVNumber',v_CreditCardCSVNumber_O,
               v_CreditCardCSVNumber_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIPurchaseHeader','CreditCardBillToZip',v_CreditCardBillToZip_O,
               v_CreditCardBillToZip_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIPurchaseHeader','CreditCardValidationCode',v_CreditCardValidationCode_O,
               v_CreditCardValidationCode_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIPurchaseHeader','CreditCardApprovalNumber',v_CreditCardApprovalNumber_O,
               v_CreditCardApprovalNumber_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIPurchaseHeader','Posted',v_Posted_O,v_Posted_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIPurchaseHeader','PostedDate',v_PostedDate_O,
               v_PostedDate_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIPurchaseHeader','HeaderMemo1',v_HeaderMemo1_O,
               v_HeaderMemo1_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIPurchaseHeader','HeaderMemo2',v_HeaderMemo2_O,
               v_HeaderMemo2_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIPurchaseHeader','HeaderMemo3',v_HeaderMemo3_O,
               v_HeaderMemo3_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIPurchaseHeader','HeaderMemo4',v_HeaderMemo4_O,
               v_HeaderMemo4_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIPurchaseHeader','HeaderMemo5',v_HeaderMemo5_O,
               v_HeaderMemo5_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIPurchaseHeader','HeaderMemo6',v_HeaderMemo6_O,
               v_HeaderMemo6_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIPurchaseHeader','HeaderMemo7',v_HeaderMemo7_O,
               v_HeaderMemo7_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIPurchaseHeader','HeaderMemo8',v_HeaderMemo8_O,
               v_HeaderMemo8_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIPurchaseHeader','HeaderMemo9',v_HeaderMemo9_O,
               v_HeaderMemo9_N);
            end if;
         end if;
         SET NO_DATA = 0;
         FETCH cUpdate INTO
         v_TransactionNumber_O,v_TransactionNumber_N,v_TransactionLineNumber,v_CompanyID,
         v_DivisionID,v_DepartmentID,v_PurchaseNumber,v_PurchaseTypeID_O,
         v_PurchaseTypeID_N,v_EDIDirectionTypeID_O,v_EDIDirectionTypeID_N,v_EDIDocumentTypeID_O,
         v_EDIDocumentTypeID_N,v_EDIOpen_O,v_EDIOpen_N,v_PurchaseDate_O,
         v_PurchaseDate_N,v_PurchaseDueDate_O,v_PurchaseDueDate_N,
         v_PurchaseShipDate_O,v_PurchaseShipDate_N,v_PurchaseCancelDate_O,v_PurchaseCancelDate_N,
         v_PurchaseDateRequested_O,v_PurchaseDateRequested_N,
         v_OrderNumber_O,v_OrderNumber_N,v_VendorInvoiceNumber_O,v_VendorInvoiceNumber_N,
         v_OrderedBy_O,v_OrderedBy_N,v_TaxExemptID_O,v_TaxExemptID_N,
         v_TaxGroupID_O,v_TaxGroupID_N,v_VendorID_O,v_VendorID_N,v_WarehouseID_O,
         v_WarehouseID_N,v_ShipToWarehouse_O,v_ShipToWarehouse_N,v_ShippingName_O,
         v_ShippingName_N,v_ShippingAddress1_O,v_ShippingAddress1_N,v_ShippingAddress2_O,
         v_ShippingAddress2_N,v_ShippingCity_O,v_ShippingCity_N,
         v_ShippingState_O,v_ShippingState_N,v_ShippingZip_O,v_ShippingZip_N,v_ShippingCountry_O,
         v_ShippingCountry_N,v_ShipMethodID_O,v_ShipMethodID_N,
         v_TermsID_O,v_TermsID_N,v_PaymentMethodID_O,v_PaymentMethodID_N,v_CurrencyID_O,
         v_CurrencyID_N,v_CurrencyExchangeRate_O,v_CurrencyExchangeRate_N,
         v_Subtotal_O,v_Subtotal_N,v_DiscountPers_O,v_DiscountPers_N,v_DiscountAmount_O,
         v_DiscountAmount_N,v_TaxPercent_O,v_TaxPercent_N,v_TaxAmount_O,
         v_TaxAmount_N,v_TaxableSubTotal_O,v_TaxableSubTotal_N,v_Freight_O,
         v_Freight_N,v_TaxFreight_O,v_TaxFreight_N,v_Handling_O,v_Handling_N,
         v_Advertising_O,v_Advertising_N,v_Total_O,v_Total_N,v_AmountPaid_O,
         v_AmountPaid_N,v_BalanceDue_O,v_BalanceDue_N,v_UndistributedAmount_O,v_UndistributedAmount_N,
         v_GLPurchaseAccount_O,v_GLPurchaseAccount_N,v_Printed_O,
         v_Printed_N,v_PrintedDate_O,v_PrintedDate_N,v_Shipped_O,v_Shipped_N,
         v_ShipDate_O,v_ShipDate_N,v_TrackingNumber_O,v_TrackingNumber_N,
         v_Received_O,v_Received_N,v_ReceivedDate_O,v_ReceivedDate_N,v_RecivingNumber_O,
         v_RecivingNumber_N,v_Paid_O,v_Paid_N,v_CheckNumber_O,v_CheckNumber_N,
         v_CheckDate_O,v_CheckDate_N,v_PaidDate_O,v_PaidDate_N,v_CreditCardTypeID_O,
         v_CreditCardTypeID_N,v_CreditCardName_O,v_CreditCardName_N,
         v_CreditCardNumber_O,v_CreditCardNumber_N,v_CreditCardExpDate_O,v_CreditCardExpDate_N,
         v_CreditCardCSVNumber_O,v_CreditCardCSVNumber_N,v_CreditCardBillToZip_O,
         v_CreditCardBillToZip_N,v_CreditCardValidationCode_O,
         v_CreditCardValidationCode_N,v_CreditCardApprovalNumber_O,v_CreditCardApprovalNumber_N,
         v_Posted_O,v_Posted_N,v_PostedDate_O,v_PostedDate_N,
         v_HeaderMemo1_O,v_HeaderMemo1_N,v_HeaderMemo2_O,v_HeaderMemo2_N,v_HeaderMemo3_O,
         v_HeaderMemo3_N,v_HeaderMemo4_O,v_HeaderMemo4_N,v_HeaderMemo5_O,
         v_HeaderMemo5_N,v_HeaderMemo6_O,v_HeaderMemo6_N,v_HeaderMemo7_O,
         v_HeaderMemo7_N,v_HeaderMemo8_O,v_HeaderMemo8_N,v_HeaderMemo9_O,v_HeaderMemo9_N;
      END WHILE;
      CLOSE cUpdate;

   END;
END;
 ;;
delimiter ;
delimiter ;;
CREATE TRIGGER `EDIPurchaseHeader_Audit_Delete` AFTER DELETE ON `edipurchaseheader` FOR EACH ROW SWL_return:
BEGIN
   DECLARE NO_DATA INT DEFAULT 0;
   DECLARE v_Context VARBINARY(128);
   DECLARE v_TransactionNumber NATIONAL VARCHAR(50);
   DECLARE v_TransactionLineNumber NATIONAL VARCHAR(50);

   DECLARE v_CompanyID NATIONAL VARCHAR(36);
   DECLARE v_DivisionID NATIONAL VARCHAR(36);
   DECLARE v_DepartmentID NATIONAL VARCHAR(36);
   DECLARE v_PurchaseNumber NATIONAL VARCHAR(36);

-- deleting records cursor declaration
   DECLARE cDelete CURSOR
   FOR SELECT
   d.PurchaseNumber
		,''

		,d.CompanyID
		,d.DivisionID
		,d.DepartmentID
		,d.PurchaseNumber

   FROM
   DelEDIPurchaseHeader d;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET NO_DATA = -2;
   END;
   DECLARE CONTINUE HANDLER FOR NOT FOUND SET NO_DATA = -1;
   CREATE  TEMPORARY TABLE IF NOT EXISTS DelEDIPurchaseHeader
   (
      CompanyID NATIONAL VARCHAR(36),
      DivisionID NATIONAL VARCHAR(36),
      DepartmentID NATIONAL VARCHAR(36),
      PurchaseNumber NATIONAL VARCHAR(36),
      PurchaseTypeID NATIONAL VARCHAR(36),
      EDIDirectionTypeID NATIONAL VARCHAR(1),
      EDIDocumentTypeID NATIONAL VARCHAR(3),
      EDIOpen BOOLEAN,
      PurchaseDate DATETIME,
      PurchaseDueDate DATETIME,
      PurchaseShipDate DATETIME,
      PurchaseCancelDate DATETIME,
      PurchaseDateRequested DATETIME,
      OrderNumber NATIONAL VARCHAR(36),
      VendorInvoiceNumber NATIONAL VARCHAR(36),
      OrderedBy NATIONAL VARCHAR(15),
      TaxExemptID NATIONAL VARCHAR(20),
      TaxGroupID NATIONAL VARCHAR(36),
      VendorID NATIONAL VARCHAR(50),
      WarehouseID NATIONAL VARCHAR(36),
      ShipToWarehouse BOOLEAN,
      ShippingName NATIONAL VARCHAR(50),
      ShippingAddress1 NATIONAL VARCHAR(50),
      ShippingAddress2 NATIONAL VARCHAR(50),
      ShippingCity NATIONAL VARCHAR(50),
      ShippingState NATIONAL VARCHAR(50),
      ShippingZip NATIONAL VARCHAR(10),
      ShippingCountry NATIONAL VARCHAR(50),
      ShipMethodID NATIONAL VARCHAR(36),
      TermsID NATIONAL VARCHAR(36),
      PaymentMethodID NATIONAL VARCHAR(36),
      CurrencyID NATIONAL VARCHAR(3),
      CurrencyExchangeRate FLOAT,
      Subtotal DECIMAL(19,4),
      DiscountPers FLOAT,
      DiscountAmount DECIMAL(19,4),
      TaxPercent FLOAT,
      TaxAmount DECIMAL(19,4),
      TaxableSubTotal DECIMAL(19,4),
      Freight DECIMAL(19,4),
      TaxFreight BOOLEAN,
      Handling DECIMAL(19,4),
      Advertising DECIMAL(19,4),
      Total DECIMAL(19,4),
      AmountPaid DECIMAL(19,4),
      BalanceDue DECIMAL(19,4),
      UndistributedAmount DECIMAL(19,4),
      GLPurchaseAccount NATIONAL VARCHAR(36),
      Printed BOOLEAN,
      PrintedDate DATETIME,
      Shipped BOOLEAN,
      ShipDate DATETIME,
      TrackingNumber NATIONAL VARCHAR(50),
      Received BOOLEAN,
      ReceivedDate DATETIME,
      RecivingNumber NATIONAL VARCHAR(20),
      Paid BOOLEAN,
      CheckNumber NATIONAL VARCHAR(20),
      CheckDate DATETIME,
      PaidDate DATETIME,
      CreditCardTypeID NATIONAL VARCHAR(15),
      CreditCardName NATIONAL VARCHAR(50),
      CreditCardNumber NATIONAL VARCHAR(50),
      CreditCardExpDate DATETIME,
      CreditCardCSVNumber NATIONAL VARCHAR(5),
      CreditCardBillToZip NATIONAL VARCHAR(10),
      CreditCardValidationCode NATIONAL VARCHAR(20),
      CreditCardApprovalNumber NATIONAL VARCHAR(20),
      Posted BOOLEAN,
      PostedDate DATETIME,
      HeaderMemo1 NATIONAL VARCHAR(50),
      HeaderMemo2 NATIONAL VARCHAR(50),
      HeaderMemo3 NATIONAL VARCHAR(50),
      HeaderMemo4 NATIONAL VARCHAR(50),
      HeaderMemo5 NATIONAL VARCHAR(50),
      HeaderMemo6 NATIONAL VARCHAR(50),
      HeaderMemo7 NATIONAL VARCHAR(50),
      HeaderMemo8 NATIONAL VARCHAR(50),
      HeaderMemo9 NATIONAL VARCHAR(50),
      LockedBy NATIONAL VARCHAR(36),
      LockTS DATETIME
   );
   DELETE FROM DelEDIPurchaseHeader;
   INSERT INTO DelEDIPurchaseHeader VALUES(OLD.CompanyID, OLD.DivisionID, OLD.DepartmentID, OLD.PurchaseNumber, OLD.PurchaseTypeID, OLD.EDIDirectionTypeID, OLD.EDIDocumentTypeID, OLD.EDIOpen, OLD.PurchaseDate, OLD.PurchaseDueDate, OLD.PurchaseShipDate, OLD.PurchaseCancelDate, OLD.PurchaseDateRequested, OLD.OrderNumber, OLD.VendorInvoiceNumber, OLD.OrderedBy, OLD.TaxExemptID, OLD.TaxGroupID, OLD.VendorID, OLD.WarehouseID, OLD.ShipToWarehouse, OLD.ShippingName, OLD.ShippingAddress1, OLD.ShippingAddress2, OLD.ShippingCity, OLD.ShippingState, OLD.ShippingZip, OLD.ShippingCountry, OLD.ShipMethodID, OLD.TermsID, OLD.PaymentMethodID, OLD.CurrencyID, OLD.CurrencyExchangeRate, OLD.Subtotal, OLD.DiscountPers, OLD.DiscountAmount, OLD.TaxPercent, OLD.TaxAmount, OLD.TaxableSubTotal, OLD.Freight, OLD.TaxFreight, OLD.Handling, OLD.Advertising, OLD.Total, OLD.AmountPaid, OLD.BalanceDue, OLD.UndistributedAmount, OLD.GLPurchaseAccount, OLD.Printed, OLD.PrintedDate, OLD.Shipped, OLD.ShipDate, OLD.TrackingNumber, OLD.Received, OLD.ReceivedDate, OLD.RecivingNumber, OLD.Paid, OLD.CheckNumber, OLD.CheckDate, OLD.PaidDate, OLD.CreditCardTypeID, OLD.CreditCardName, OLD.CreditCardNumber, OLD.CreditCardExpDate, OLD.CreditCardCSVNumber, OLD.CreditCardBillToZip, OLD.CreditCardValidationCode, OLD.CreditCardApprovalNumber, OLD.Posted, OLD.PostedDate, OLD.HeaderMemo1, OLD.HeaderMemo2, OLD.HeaderMemo3, OLD.HeaderMemo4, OLD.HeaderMemo5, OLD.HeaderMemo6, OLD.HeaderMemo7, OLD.HeaderMemo8, OLD.HeaderMemo9, OLD.LockedBy, OLD.LockTS);

   BEGIN
-- check for audit triggers switch off

      select   context_info INTO v_Context FROM sysprocesses WHERE spid = CONNECTION_ID();
      IF CAST(v_Context AS CHAR(36)) = N'$$AuditSwitchOff$$' then 
         LEAVE SWL_return;
      end if;

-- declarations
      OPEN cDelete;
-- fetch from each deleting record
      SET NO_DATA = 0;
      FETCH cDelete INTO
      v_TransactionNumber,v_TransactionLineNumber,v_CompanyID,v_DivisionID,v_DepartmentID,
      v_PurchaseNumber;
      WHILE NO_DATA = 0 DO
-- insert audit record for each deleting record
         CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber,v_TransactionLineNumber,
         'EDIPurchaseHeader','Deleted','','Deleted');
         SET NO_DATA = 0;
         FETCH cDelete INTO
         v_TransactionNumber,v_TransactionLineNumber,v_CompanyID,v_DivisionID,v_DepartmentID,
         v_PurchaseNumber;
      END WHILE;
      CLOSE cDelete;

   END;
END;
 ;;
delimiter ;

-- ----------------------------
--  Table structure for `edireceiptsdetail`
-- ----------------------------
DROP TABLE IF EXISTS `edireceiptsdetail`;
CREATE TABLE `edireceiptsdetail` (
  `CompanyID` varchar(36) NOT NULL,
  `DivisionID` varchar(36) NOT NULL,
  `DepartmentID` varchar(36) NOT NULL,
  `ReceiptID` varchar(36) NOT NULL,
  `ReceiptDetailID` bigint(20) NOT NULL AUTO_INCREMENT,
  `DocumentNumber` varchar(36) DEFAULT NULL,
  `PaymentID` varchar(36) DEFAULT NULL,
  `PayedID` varchar(36) DEFAULT NULL,
  `CurrencyID` varchar(3) DEFAULT NULL,
  `CurrencyExchangeRate` float DEFAULT NULL,
  `DiscountTaken` decimal(19,4) DEFAULT NULL,
  `WriteOffAmount` decimal(19,4) DEFAULT NULL,
  `AppliedAmount` decimal(19,4) DEFAULT NULL,
  `Cleared` tinyint(1) DEFAULT NULL,
  `DetailMemo1` varchar(50) DEFAULT NULL,
  `DetailMemo2` varchar(50) DEFAULT NULL,
  `DetailMemo3` varchar(50) DEFAULT NULL,
  `DetailMemo4` varchar(50) DEFAULT NULL,
  `DetailMemo5` varchar(50) DEFAULT NULL,
  `LockedBy` varchar(36) DEFAULT NULL,
  `LockTS` datetime DEFAULT NULL,
  PRIMARY KEY (`ReceiptDetailID`,`CompanyID`,`DivisionID`,`DepartmentID`,`ReceiptID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
delimiter ;;
CREATE TRIGGER `EDIReceiptsDetail_Audit_Insert` AFTER INSERT ON `edireceiptsdetail` FOR EACH ROW SWL_return:
BEGIN
   DECLARE NO_DATA INT DEFAULT 0;
   DECLARE v_Context VARBINARY(128);
   DECLARE v_TransactionNumber NATIONAL VARCHAR(50);
   DECLARE v_TransactionLineNumber NATIONAL VARCHAR(50);

   DECLARE v_CompanyID NATIONAL VARCHAR(36);
   DECLARE v_DivisionID NATIONAL VARCHAR(36);
   DECLARE v_DepartmentID NATIONAL VARCHAR(36);
   DECLARE v_ReceiptID NATIONAL VARCHAR(36);
   DECLARE v_ReceiptDetailID NUMERIC(18,0);

-- inserting records cursor declaration
   DECLARE cInsert CURSOR
   FOR SELECT
   i.ReceiptID
		,i.ReceiptDetailID

		,i.CompanyID
		,i.DivisionID
		,i.DepartmentID
		,i.ReceiptID
		,i.ReceiptDetailID

   FROM
   InsEDIReceiptsDetail i;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET NO_DATA = -2;
   END;
   DECLARE CONTINUE HANDLER FOR NOT FOUND SET NO_DATA = -1;
   CREATE  TEMPORARY TABLE IF NOT EXISTS InsEDIReceiptsDetail
   (
      CompanyID NATIONAL VARCHAR(36),
      DivisionID NATIONAL VARCHAR(36),
      DepartmentID NATIONAL VARCHAR(36),
      ReceiptID NATIONAL VARCHAR(36),
      ReceiptDetailID NUMERIC(18,0),
      DocumentNumber NATIONAL VARCHAR(36),
      PaymentID NATIONAL VARCHAR(36),
      PayedID NATIONAL VARCHAR(36),
      CurrencyID NATIONAL VARCHAR(3),
      CurrencyExchangeRate FLOAT,
      DiscountTaken DECIMAL(19,4),
      WriteOffAmount DECIMAL(19,4),
      AppliedAmount DECIMAL(19,4),
      Cleared BOOLEAN,
      DetailMemo1 NATIONAL VARCHAR(50),
      DetailMemo2 NATIONAL VARCHAR(50),
      DetailMemo3 NATIONAL VARCHAR(50),
      DetailMemo4 NATIONAL VARCHAR(50),
      DetailMemo5 NATIONAL VARCHAR(50),
      LockedBy NATIONAL VARCHAR(36),
      LockTS DATETIME
   );
   DELETE FROM InsEDIReceiptsDetail;
   INSERT INTO InsEDIReceiptsDetail VALUES(NEW.CompanyID, NEW.DivisionID, NEW.DepartmentID, NEW.ReceiptID, NEW.ReceiptDetailID, NEW.DocumentNumber, NEW.PaymentID, NEW.PayedID, NEW.CurrencyID, NEW.CurrencyExchangeRate, NEW.DiscountTaken, NEW.WriteOffAmount, NEW.AppliedAmount, NEW.Cleared, NEW.DetailMemo1, NEW.DetailMemo2, NEW.DetailMemo3, NEW.DetailMemo4, NEW.DetailMemo5, NEW.LockedBy, NEW.LockTS);

   BEGIN
-- check for audit triggers switch off

      select   context_info INTO v_Context FROM sysprocesses WHERE spid = CONNECTION_ID();
      IF CAST(v_Context AS CHAR(36)) = N'$$AuditSwitchOff$$' then 
         LEAVE SWL_return;
      end if;

-- declarations
      OPEN cInsert;
-- fetch from each inserting record
      SET NO_DATA = 0;
      FETCH cInsert INTO
      v_TransactionNumber,v_TransactionLineNumber,v_CompanyID,v_DivisionID,v_DepartmentID,
      v_ReceiptID,v_ReceiptDetailID;
      WHILE NO_DATA = 0 DO
-- insert audit record for each inserting record
         IF IsGuid(v_TransactionNumber) = 0 then
		
            CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber,v_TransactionLineNumber,
            'EDIReceiptsDetail','New Record','','New Record');
         end if;
         SET NO_DATA = 0;
         FETCH cInsert INTO
         v_TransactionNumber,v_TransactionLineNumber,v_CompanyID,v_DivisionID,v_DepartmentID,
         v_ReceiptID,v_ReceiptDetailID;
      END WHILE;
      CLOSE cInsert;

   END;
END;
 ;;
delimiter ;
delimiter ;;
CREATE TRIGGER `EDIReceiptsDetail_Audit_Update` AFTER UPDATE ON `edireceiptsdetail` FOR EACH ROW SWL_return:
BEGIN
   DECLARE NO_DATA INT DEFAULT 0;
   DECLARE v_Context VARBINARY(128);
   DECLARE v_TransactionNumber_O NATIONAL VARCHAR(50);
   DECLARE v_TransactionNumber_N NATIONAL VARCHAR(50);
   DECLARE v_TransactionLineNumber NATIONAL VARCHAR(50);

   DECLARE v_CompanyID NATIONAL VARCHAR(36);
   DECLARE v_DivisionID NATIONAL VARCHAR(36);
   DECLARE v_DepartmentID NATIONAL VARCHAR(36);
   DECLARE v_ReceiptID NATIONAL VARCHAR(36);
   DECLARE v_ReceiptDetailID NUMERIC(18,0);

   DECLARE v_DocumentNumber_O NATIONAL VARCHAR(80);
   DECLARE v_DocumentNumber_N NATIONAL VARCHAR(80);
   DECLARE v_PaymentID_O NATIONAL VARCHAR(80);
   DECLARE v_PaymentID_N NATIONAL VARCHAR(80);
   DECLARE v_PayedID_O NATIONAL VARCHAR(80);
   DECLARE v_PayedID_N NATIONAL VARCHAR(80);
   DECLARE v_CurrencyID_O NATIONAL VARCHAR(80);
   DECLARE v_CurrencyID_N NATIONAL VARCHAR(80);
   DECLARE v_CurrencyExchangeRate_O NATIONAL VARCHAR(80);
   DECLARE v_CurrencyExchangeRate_N NATIONAL VARCHAR(80);
   DECLARE v_DiscountTaken_O NATIONAL VARCHAR(80);
   DECLARE v_DiscountTaken_N NATIONAL VARCHAR(80);
   DECLARE v_WriteOffAmount_O NATIONAL VARCHAR(80);
   DECLARE v_WriteOffAmount_N NATIONAL VARCHAR(80);
   DECLARE v_AppliedAmount_O NATIONAL VARCHAR(80);
   DECLARE v_AppliedAmount_N NATIONAL VARCHAR(80);
   DECLARE v_Cleared_O NATIONAL VARCHAR(80);
   DECLARE v_Cleared_N NATIONAL VARCHAR(80);
   DECLARE v_DetailMemo1_O NATIONAL VARCHAR(80);
   DECLARE v_DetailMemo1_N NATIONAL VARCHAR(80);
   DECLARE v_DetailMemo2_O NATIONAL VARCHAR(80);
   DECLARE v_DetailMemo2_N NATIONAL VARCHAR(80);
   DECLARE v_DetailMemo3_O NATIONAL VARCHAR(80);
   DECLARE v_DetailMemo3_N NATIONAL VARCHAR(80);
   DECLARE v_DetailMemo4_O NATIONAL VARCHAR(80);
   DECLARE v_DetailMemo4_N NATIONAL VARCHAR(80);
   DECLARE v_DetailMemo5_O NATIONAL VARCHAR(80);
   DECLARE v_DetailMemo5_N NATIONAL VARCHAR(80);
 

-- updating records cursor declaration
   DECLARE cUpdate CURSOR
   FOR SELECT
   d.ReceiptID
		,i.ReceiptID
		,i.ReceiptDetailID

		,i.CompanyID
		,i.DivisionID
		,i.DepartmentID
		,i.ReceiptID
		,i.ReceiptDetailID

,CAST(d.DocumentNumber AS CHAR(80))
,CAST(i.DocumentNumber AS CHAR(80))
,CAST(d.PaymentID AS CHAR(80))
,CAST(i.PaymentID AS CHAR(80))
,CAST(d.PayedID AS CHAR(80))
,CAST(i.PayedID AS CHAR(80))
,CAST(d.CurrencyID AS CHAR(80))
,CAST(i.CurrencyID AS CHAR(80))
,CAST(d.CurrencyExchangeRate AS CHAR(80))
,CAST(i.CurrencyExchangeRate AS CHAR(80))
,CAST(d.DiscountTaken AS CHAR(80))
,CAST(i.DiscountTaken AS CHAR(80))
,CAST(d.WriteOffAmount AS CHAR(80))
,CAST(i.WriteOffAmount AS CHAR(80))
,CAST(d.AppliedAmount AS CHAR(80))
,CAST(i.AppliedAmount AS CHAR(80))
,CAST(d.Cleared AS CHAR(80))
,CAST(i.Cleared AS CHAR(80))
,CAST(d.DetailMemo1 AS CHAR(80))
,CAST(i.DetailMemo1 AS CHAR(80))
,CAST(d.DetailMemo2 AS CHAR(80))
,CAST(i.DetailMemo2 AS CHAR(80))
,CAST(d.DetailMemo3 AS CHAR(80))
,CAST(i.DetailMemo3 AS CHAR(80))
,CAST(d.DetailMemo4 AS CHAR(80))
,CAST(i.DetailMemo4 AS CHAR(80))
,CAST(d.DetailMemo5 AS CHAR(80))
,CAST(i.DetailMemo5 AS CHAR(80))
 

   FROM
   InsEDIReceiptsDetail i
   LEFT OUTER JOIN DelEDIReceiptsDetail d ON
   d.CompanyID = i.CompanyID
   AND d.DivisionID = i.DivisionID
   AND d.DepartmentID = i.DepartmentID
   AND d.ReceiptID = i.ReceiptID
   AND d.ReceiptDetailID = i.ReceiptDetailID;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET NO_DATA = -2;
   END;
   DECLARE CONTINUE HANDLER FOR NOT FOUND SET NO_DATA = -1;
   CREATE  TEMPORARY TABLE IF NOT EXISTS InsEDIReceiptsDetail
   (
      CompanyID NATIONAL VARCHAR(36),
      DivisionID NATIONAL VARCHAR(36),
      DepartmentID NATIONAL VARCHAR(36),
      ReceiptID NATIONAL VARCHAR(36),
      ReceiptDetailID NUMERIC(18,0),
      DocumentNumber NATIONAL VARCHAR(36),
      PaymentID NATIONAL VARCHAR(36),
      PayedID NATIONAL VARCHAR(36),
      CurrencyID NATIONAL VARCHAR(3),
      CurrencyExchangeRate FLOAT,
      DiscountTaken DECIMAL(19,4),
      WriteOffAmount DECIMAL(19,4),
      AppliedAmount DECIMAL(19,4),
      Cleared BOOLEAN,
      DetailMemo1 NATIONAL VARCHAR(50),
      DetailMemo2 NATIONAL VARCHAR(50),
      DetailMemo3 NATIONAL VARCHAR(50),
      DetailMemo4 NATIONAL VARCHAR(50),
      DetailMemo5 NATIONAL VARCHAR(50),
      LockedBy NATIONAL VARCHAR(36),
      LockTS DATETIME
   );
   DELETE FROM InsEDIReceiptsDetail;
   INSERT INTO InsEDIReceiptsDetail VALUES(NEW.CompanyID, NEW.DivisionID, NEW.DepartmentID, NEW.ReceiptID, NEW.ReceiptDetailID, NEW.DocumentNumber, NEW.PaymentID, NEW.PayedID, NEW.CurrencyID, NEW.CurrencyExchangeRate, NEW.DiscountTaken, NEW.WriteOffAmount, NEW.AppliedAmount, NEW.Cleared, NEW.DetailMemo1, NEW.DetailMemo2, NEW.DetailMemo3, NEW.DetailMemo4, NEW.DetailMemo5, NEW.LockedBy, NEW.LockTS);

   CREATE  TEMPORARY TABLE IF NOT EXISTS DelEDIReceiptsDetail
   (
      CompanyID NATIONAL VARCHAR(36),
      DivisionID NATIONAL VARCHAR(36),
      DepartmentID NATIONAL VARCHAR(36),
      ReceiptID NATIONAL VARCHAR(36),
      ReceiptDetailID NUMERIC(18,0),
      DocumentNumber NATIONAL VARCHAR(36),
      PaymentID NATIONAL VARCHAR(36),
      PayedID NATIONAL VARCHAR(36),
      CurrencyID NATIONAL VARCHAR(3),
      CurrencyExchangeRate FLOAT,
      DiscountTaken DECIMAL(19,4),
      WriteOffAmount DECIMAL(19,4),
      AppliedAmount DECIMAL(19,4),
      Cleared BOOLEAN,
      DetailMemo1 NATIONAL VARCHAR(50),
      DetailMemo2 NATIONAL VARCHAR(50),
      DetailMemo3 NATIONAL VARCHAR(50),
      DetailMemo4 NATIONAL VARCHAR(50),
      DetailMemo5 NATIONAL VARCHAR(50),
      LockedBy NATIONAL VARCHAR(36),
      LockTS DATETIME
   );
   DELETE FROM DelEDIReceiptsDetail;
   INSERT INTO DelEDIReceiptsDetail VALUES(OLD.CompanyID, OLD.DivisionID, OLD.DepartmentID, OLD.ReceiptID, OLD.ReceiptDetailID, OLD.DocumentNumber, OLD.PaymentID, OLD.PayedID, OLD.CurrencyID, OLD.CurrencyExchangeRate, OLD.DiscountTaken, OLD.WriteOffAmount, OLD.AppliedAmount, OLD.Cleared, OLD.DetailMemo1, OLD.DetailMemo2, OLD.DetailMemo3, OLD.DetailMemo4, OLD.DetailMemo5, OLD.LockedBy, OLD.LockTS);

   BEGIN
-- check for audit triggers switch off

      select   context_info INTO v_Context FROM sysprocesses WHERE spid = CONNECTION_ID();
      IF CAST(v_Context AS CHAR(36)) = N'$$AuditSwitchOff$$' then 
         LEAVE SWL_return;
      end if;

-- declarations
      OPEN cUpdate;
-- fetch from each updating record
      SET NO_DATA = 0;
      FETCH cUpdate INTO
      v_TransactionNumber_O,v_TransactionNumber_N,v_TransactionLineNumber,v_CompanyID,
      v_DivisionID,v_DepartmentID,v_ReceiptID,v_ReceiptDetailID,v_DocumentNumber_O,
      v_DocumentNumber_N,v_PaymentID_O,v_PaymentID_N,v_PayedID_O,
      v_PayedID_N,v_CurrencyID_O,v_CurrencyID_N,v_CurrencyExchangeRate_O,
      v_CurrencyExchangeRate_N,v_DiscountTaken_O,v_DiscountTaken_N,v_WriteOffAmount_O,
      v_WriteOffAmount_N,v_AppliedAmount_O,v_AppliedAmount_N,v_Cleared_O,
      v_Cleared_N,v_DetailMemo1_O,v_DetailMemo1_N,v_DetailMemo2_O,
      v_DetailMemo2_N,v_DetailMemo3_O,v_DetailMemo3_N,v_DetailMemo4_O,v_DetailMemo4_N,
      v_DetailMemo5_O,v_DetailMemo5_N;
      WHILE NO_DATA = 0 DO
-- insert audit records for each changed field
         IF IsGuid(v_TransactionNumber_N) = 0 then
		
            IF v_TransactionNumber_O IS NULL then
				
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIReceiptsDetail','New Record','','New Record');
            ELSE
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIReceiptsDetail','DocumentNumber',v_DocumentNumber_O,
               v_DocumentNumber_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIReceiptsDetail','PaymentID',v_PaymentID_O,v_PaymentID_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIReceiptsDetail','PayedID',v_PayedID_O,v_PayedID_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIReceiptsDetail','CurrencyID',v_CurrencyID_O,
               v_CurrencyID_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIReceiptsDetail','CurrencyExchangeRate',v_CurrencyExchangeRate_O,
               v_CurrencyExchangeRate_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIReceiptsDetail','DiscountTaken',v_DiscountTaken_O,
               v_DiscountTaken_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIReceiptsDetail','WriteOffAmount',v_WriteOffAmount_O,
               v_WriteOffAmount_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIReceiptsDetail','AppliedAmount',v_AppliedAmount_O,
               v_AppliedAmount_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIReceiptsDetail','Cleared',v_Cleared_O,v_Cleared_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIReceiptsDetail','DetailMemo1',v_DetailMemo1_O,
               v_DetailMemo1_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIReceiptsDetail','DetailMemo2',v_DetailMemo2_O,
               v_DetailMemo2_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIReceiptsDetail','DetailMemo3',v_DetailMemo3_O,
               v_DetailMemo3_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIReceiptsDetail','DetailMemo4',v_DetailMemo4_O,
               v_DetailMemo4_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIReceiptsDetail','DetailMemo5',v_DetailMemo5_O,
               v_DetailMemo5_N);
            end if;
         end if;
         SET NO_DATA = 0;
         FETCH cUpdate INTO
         v_TransactionNumber_O,v_TransactionNumber_N,v_TransactionLineNumber,v_CompanyID,
         v_DivisionID,v_DepartmentID,v_ReceiptID,v_ReceiptDetailID,v_DocumentNumber_O,
         v_DocumentNumber_N,v_PaymentID_O,v_PaymentID_N,v_PayedID_O,
         v_PayedID_N,v_CurrencyID_O,v_CurrencyID_N,v_CurrencyExchangeRate_O,
         v_CurrencyExchangeRate_N,v_DiscountTaken_O,v_DiscountTaken_N,v_WriteOffAmount_O,
         v_WriteOffAmount_N,v_AppliedAmount_O,v_AppliedAmount_N,v_Cleared_O,
         v_Cleared_N,v_DetailMemo1_O,v_DetailMemo1_N,v_DetailMemo2_O,
         v_DetailMemo2_N,v_DetailMemo3_O,v_DetailMemo3_N,v_DetailMemo4_O,v_DetailMemo4_N,
         v_DetailMemo5_O,v_DetailMemo5_N;
      END WHILE;
      CLOSE cUpdate;

   END;
END;
 ;;
delimiter ;
delimiter ;;
CREATE TRIGGER `EDIReceiptsDetail_Audit_Delete` AFTER DELETE ON `edireceiptsdetail` FOR EACH ROW SWL_return:
BEGIN
   DECLARE NO_DATA INT DEFAULT 0;
   DECLARE v_Context VARBINARY(128);
   DECLARE v_TransactionNumber NATIONAL VARCHAR(50);
   DECLARE v_TransactionLineNumber NATIONAL VARCHAR(50);

   DECLARE v_CompanyID NATIONAL VARCHAR(36);
   DECLARE v_DivisionID NATIONAL VARCHAR(36);
   DECLARE v_DepartmentID NATIONAL VARCHAR(36);
   DECLARE v_ReceiptID NATIONAL VARCHAR(36);
   DECLARE v_ReceiptDetailID NUMERIC(18,0);

-- deleting records cursor declaration
   DECLARE cDelete CURSOR
   FOR SELECT
   d.ReceiptID
		,d.ReceiptDetailID

		,d.CompanyID
		,d.DivisionID
		,d.DepartmentID
		,d.ReceiptID
		,d.ReceiptDetailID

   FROM
   DelEDIReceiptsDetail d;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET NO_DATA = -2;
   END;
   DECLARE CONTINUE HANDLER FOR NOT FOUND SET NO_DATA = -1;
   CREATE  TEMPORARY TABLE IF NOT EXISTS DelEDIReceiptsDetail
   (
      CompanyID NATIONAL VARCHAR(36),
      DivisionID NATIONAL VARCHAR(36),
      DepartmentID NATIONAL VARCHAR(36),
      ReceiptID NATIONAL VARCHAR(36),
      ReceiptDetailID NUMERIC(18,0),
      DocumentNumber NATIONAL VARCHAR(36),
      PaymentID NATIONAL VARCHAR(36),
      PayedID NATIONAL VARCHAR(36),
      CurrencyID NATIONAL VARCHAR(3),
      CurrencyExchangeRate FLOAT,
      DiscountTaken DECIMAL(19,4),
      WriteOffAmount DECIMAL(19,4),
      AppliedAmount DECIMAL(19,4),
      Cleared BOOLEAN,
      DetailMemo1 NATIONAL VARCHAR(50),
      DetailMemo2 NATIONAL VARCHAR(50),
      DetailMemo3 NATIONAL VARCHAR(50),
      DetailMemo4 NATIONAL VARCHAR(50),
      DetailMemo5 NATIONAL VARCHAR(50),
      LockedBy NATIONAL VARCHAR(36),
      LockTS DATETIME
   );
   DELETE FROM DelEDIReceiptsDetail;
   INSERT INTO DelEDIReceiptsDetail VALUES(OLD.CompanyID, OLD.DivisionID, OLD.DepartmentID, OLD.ReceiptID, OLD.ReceiptDetailID, OLD.DocumentNumber, OLD.PaymentID, OLD.PayedID, OLD.CurrencyID, OLD.CurrencyExchangeRate, OLD.DiscountTaken, OLD.WriteOffAmount, OLD.AppliedAmount, OLD.Cleared, OLD.DetailMemo1, OLD.DetailMemo2, OLD.DetailMemo3, OLD.DetailMemo4, OLD.DetailMemo5, OLD.LockedBy, OLD.LockTS);

   BEGIN
-- check for audit triggers switch off

      select   context_info INTO v_Context FROM sysprocesses WHERE spid = CONNECTION_ID();
      IF CAST(v_Context AS CHAR(36)) = N'$$AuditSwitchOff$$' then 
         LEAVE SWL_return;
      end if;

-- declarations
      OPEN cDelete;
-- fetch from each deleting record
      SET NO_DATA = 0;
      FETCH cDelete INTO
      v_TransactionNumber,v_TransactionLineNumber,v_CompanyID,v_DivisionID,v_DepartmentID,
      v_ReceiptID,v_ReceiptDetailID;
      WHILE NO_DATA = 0 DO
-- insert audit record for each deleting record
         CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber,v_TransactionLineNumber,
         'EDIReceiptsDetail','Deleted','','Deleted');
         SET NO_DATA = 0;
         FETCH cDelete INTO
         v_TransactionNumber,v_TransactionLineNumber,v_CompanyID,v_DivisionID,v_DepartmentID,
         v_ReceiptID,v_ReceiptDetailID;
      END WHILE;
      CLOSE cDelete;

   END;
END;
 ;;
delimiter ;

-- ----------------------------
--  Table structure for `edireceiptsheader`
-- ----------------------------
DROP TABLE IF EXISTS `edireceiptsheader`;
CREATE TABLE `edireceiptsheader` (
  `CompanyID` varchar(36) NOT NULL,
  `DivisionID` varchar(36) NOT NULL,
  `DepartmentID` varchar(36) NOT NULL,
  `ReceiptID` varchar(36) NOT NULL,
  `ReceiptTypeID` varchar(36) DEFAULT NULL,
  `ReceiptClassID` varchar(36) DEFAULT NULL,
  `EDIDirectionTypeID` varchar(1) DEFAULT NULL,
  `EDIDocumentTypeID` varchar(3) DEFAULT NULL,
  `EDIOpen` tinyint(1) DEFAULT NULL,
  `CheckNumber` varchar(20) DEFAULT NULL,
  `CustomerID` varchar(50) DEFAULT NULL,
  `TransactionDate` datetime DEFAULT NULL,
  `CurrencyID` varchar(3) DEFAULT NULL,
  `CurrencyExchangeRate` float DEFAULT NULL,
  `Amount` decimal(19,4) DEFAULT NULL,
  `UnAppliedAmount` decimal(19,4) DEFAULT NULL,
  `GLBankAccount` varchar(36) DEFAULT NULL,
  `Status` varchar(10) DEFAULT NULL,
  `NSF` tinyint(1) DEFAULT NULL,
  `Notes` varchar(255) DEFAULT NULL,
  `CreditAmount` decimal(19,4) DEFAULT NULL,
  `Cleared` tinyint(1) DEFAULT NULL,
  `Posted` tinyint(1) DEFAULT NULL,
  `Reconciled` tinyint(1) DEFAULT NULL,
  `Deposited` tinyint(1) DEFAULT NULL,
  `HeaderMemo1` varchar(50) DEFAULT NULL,
  `HeaderMemo2` varchar(50) DEFAULT NULL,
  `HeaderMemo3` varchar(50) DEFAULT NULL,
  `HeaderMemo4` varchar(50) DEFAULT NULL,
  `HeaderMemo5` varchar(50) DEFAULT NULL,
  `HeaderMemo6` varchar(50) DEFAULT NULL,
  `HeaderMemo7` varchar(50) DEFAULT NULL,
  `HeaderMemo8` varchar(50) DEFAULT NULL,
  `HeaderMemo9` varchar(50) DEFAULT NULL,
  `LockedBy` varchar(36) DEFAULT NULL,
  `LockTS` datetime DEFAULT NULL,
  PRIMARY KEY (`CompanyID`,`DivisionID`,`DepartmentID`,`ReceiptID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
delimiter ;;
CREATE TRIGGER `EDIReceiptsHeader_Audit_Insert` AFTER INSERT ON `edireceiptsheader` FOR EACH ROW SWL_return:
BEGIN
   DECLARE NO_DATA INT DEFAULT 0;
   DECLARE v_Context VARBINARY(128);
   DECLARE v_TransactionNumber NATIONAL VARCHAR(50);
   DECLARE v_TransactionLineNumber NATIONAL VARCHAR(50);

   DECLARE v_CompanyID NATIONAL VARCHAR(36);
   DECLARE v_DivisionID NATIONAL VARCHAR(36);
   DECLARE v_DepartmentID NATIONAL VARCHAR(36);
   DECLARE v_ReceiptID NATIONAL VARCHAR(36);

-- inserting records cursor declaration
   DECLARE cInsert CURSOR
   FOR SELECT
   i.ReceiptID
		,''

		,i.CompanyID
		,i.DivisionID
		,i.DepartmentID
		,i.ReceiptID

   FROM
   InsEDIReceiptsHeader i;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET NO_DATA = -2;
   END;
   DECLARE CONTINUE HANDLER FOR NOT FOUND SET NO_DATA = -1;
   CREATE  TEMPORARY TABLE IF NOT EXISTS InsEDIReceiptsHeader
   (
      CompanyID NATIONAL VARCHAR(36),
      DivisionID NATIONAL VARCHAR(36),
      DepartmentID NATIONAL VARCHAR(36),
      ReceiptID NATIONAL VARCHAR(36),
      ReceiptTypeID NATIONAL VARCHAR(36),
      ReceiptClassID NATIONAL VARCHAR(36),
      EDIDirectionTypeID NATIONAL VARCHAR(1),
      EDIDocumentTypeID NATIONAL VARCHAR(3),
      EDIOpen BOOLEAN,
      CheckNumber NATIONAL VARCHAR(20),
      CustomerID NATIONAL VARCHAR(50),
      TransactionDate DATETIME,
      CurrencyID NATIONAL VARCHAR(3),
      CurrencyExchangeRate FLOAT,
      Amount DECIMAL(19,4),
      UnAppliedAmount DECIMAL(19,4),
      GLBankAccount NATIONAL VARCHAR(36),
      Status NATIONAL VARCHAR(10),
      NSF BOOLEAN,
      Notes NATIONAL VARCHAR(255),
      CreditAmount DECIMAL(19,4),
      Cleared BOOLEAN,
      Posted BOOLEAN,
      Reconciled BOOLEAN,
      Deposited BOOLEAN,
      HeaderMemo1 NATIONAL VARCHAR(50),
      HeaderMemo2 NATIONAL VARCHAR(50),
      HeaderMemo3 NATIONAL VARCHAR(50),
      HeaderMemo4 NATIONAL VARCHAR(50),
      HeaderMemo5 NATIONAL VARCHAR(50),
      HeaderMemo6 NATIONAL VARCHAR(50),
      HeaderMemo7 NATIONAL VARCHAR(50),
      HeaderMemo8 NATIONAL VARCHAR(50),
      HeaderMemo9 NATIONAL VARCHAR(50),
      LockedBy NATIONAL VARCHAR(36),
      LockTS DATETIME
   );
   DELETE FROM InsEDIReceiptsHeader;
   INSERT INTO InsEDIReceiptsHeader VALUES(NEW.CompanyID, NEW.DivisionID, NEW.DepartmentID, NEW.ReceiptID, NEW.ReceiptTypeID, NEW.ReceiptClassID, NEW.EDIDirectionTypeID, NEW.EDIDocumentTypeID, NEW.EDIOpen, NEW.CheckNumber, NEW.CustomerID, NEW.TransactionDate, NEW.CurrencyID, NEW.CurrencyExchangeRate, NEW.Amount, NEW.UnAppliedAmount, NEW.GLBankAccount, NEW.Status, NEW.NSF, NEW.Notes, NEW.CreditAmount, NEW.Cleared, NEW.Posted, NEW.Reconciled, NEW.Deposited, NEW.HeaderMemo1, NEW.HeaderMemo2, NEW.HeaderMemo3, NEW.HeaderMemo4, NEW.HeaderMemo5, NEW.HeaderMemo6, NEW.HeaderMemo7, NEW.HeaderMemo8, NEW.HeaderMemo9, NEW.LockedBy, NEW.LockTS);

   BEGIN
-- check for audit triggers switch off

      select   context_info INTO v_Context FROM sysprocesses WHERE spid = CONNECTION_ID();
      IF CAST(v_Context AS CHAR(36)) = N'$$AuditSwitchOff$$' then 
         LEAVE SWL_return;
      end if;

-- declarations
      OPEN cInsert;
-- fetch from each inserting record
      SET NO_DATA = 0;
      FETCH cInsert INTO
      v_TransactionNumber,v_TransactionLineNumber,v_CompanyID,v_DivisionID,v_DepartmentID,
      v_ReceiptID;
      WHILE NO_DATA = 0 DO
-- insert audit record for each inserting record
         IF IsGuid(v_TransactionNumber) = 0 then
		
            CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber,v_TransactionLineNumber,
            'EDIReceiptsHeader','New Record','','New Record');
         end if;
         SET NO_DATA = 0;
         FETCH cInsert INTO
         v_TransactionNumber,v_TransactionLineNumber,v_CompanyID,v_DivisionID,v_DepartmentID,
         v_ReceiptID;
      END WHILE;
      CLOSE cInsert;

   END;
END;
 ;;
delimiter ;
delimiter ;;
CREATE TRIGGER `EDIReceiptsHeader_Audit_Update` AFTER UPDATE ON `edireceiptsheader` FOR EACH ROW SWL_return:
BEGIN
   DECLARE NO_DATA INT DEFAULT 0;
   DECLARE v_Context VARBINARY(128);
   DECLARE v_TransactionNumber_O NATIONAL VARCHAR(50);
   DECLARE v_TransactionNumber_N NATIONAL VARCHAR(50);
   DECLARE v_TransactionLineNumber NATIONAL VARCHAR(50);

   DECLARE v_CompanyID NATIONAL VARCHAR(36);
   DECLARE v_DivisionID NATIONAL VARCHAR(36);
   DECLARE v_DepartmentID NATIONAL VARCHAR(36);
   DECLARE v_ReceiptID NATIONAL VARCHAR(36);

   DECLARE v_ReceiptTypeID_O NATIONAL VARCHAR(80);
   DECLARE v_ReceiptTypeID_N NATIONAL VARCHAR(80);
   DECLARE v_ReceiptClassID_O NATIONAL VARCHAR(80);
   DECLARE v_ReceiptClassID_N NATIONAL VARCHAR(80);
   DECLARE v_EDIDirectionTypeID_O NATIONAL VARCHAR(80);
   DECLARE v_EDIDirectionTypeID_N NATIONAL VARCHAR(80);
   DECLARE v_EDIDocumentTypeID_O NATIONAL VARCHAR(80);
   DECLARE v_EDIDocumentTypeID_N NATIONAL VARCHAR(80);
   DECLARE v_EDIOpen_O NATIONAL VARCHAR(80);
   DECLARE v_EDIOpen_N NATIONAL VARCHAR(80);
   DECLARE v_CheckNumber_O NATIONAL VARCHAR(80);
   DECLARE v_CheckNumber_N NATIONAL VARCHAR(80);
   DECLARE v_CustomerID_O NATIONAL VARCHAR(80);
   DECLARE v_CustomerID_N NATIONAL VARCHAR(80);
   DECLARE v_TransactionDate_O NATIONAL VARCHAR(80);
   DECLARE v_TransactionDate_N NATIONAL VARCHAR(80);
   DECLARE v_CurrencyID_O NATIONAL VARCHAR(80);
   DECLARE v_CurrencyID_N NATIONAL VARCHAR(80);
   DECLARE v_CurrencyExchangeRate_O NATIONAL VARCHAR(80);
   DECLARE v_CurrencyExchangeRate_N NATIONAL VARCHAR(80);
   DECLARE v_Amount_O NATIONAL VARCHAR(80);
   DECLARE v_Amount_N NATIONAL VARCHAR(80);
   DECLARE v_UnAppliedAmount_O NATIONAL VARCHAR(80);
   DECLARE v_UnAppliedAmount_N NATIONAL VARCHAR(80);
   DECLARE v_GLBankAccount_O NATIONAL VARCHAR(80);
   DECLARE v_GLBankAccount_N NATIONAL VARCHAR(80);
   DECLARE v_Status_O NATIONAL VARCHAR(80);
   DECLARE v_Status_N NATIONAL VARCHAR(80);
   DECLARE v_NSF_O NATIONAL VARCHAR(80);
   DECLARE v_NSF_N NATIONAL VARCHAR(80);
   DECLARE v_Notes_O NATIONAL VARCHAR(80);
   DECLARE v_Notes_N NATIONAL VARCHAR(80);
   DECLARE v_CreditAmount_O NATIONAL VARCHAR(80);
   DECLARE v_CreditAmount_N NATIONAL VARCHAR(80);
   DECLARE v_Cleared_O NATIONAL VARCHAR(80);
   DECLARE v_Cleared_N NATIONAL VARCHAR(80);
   DECLARE v_Posted_O NATIONAL VARCHAR(80);
   DECLARE v_Posted_N NATIONAL VARCHAR(80);
   DECLARE v_Reconciled_O NATIONAL VARCHAR(80);
   DECLARE v_Reconciled_N NATIONAL VARCHAR(80);
   DECLARE v_Deposited_O NATIONAL VARCHAR(80);
   DECLARE v_Deposited_N NATIONAL VARCHAR(80);
   DECLARE v_HeaderMemo1_O NATIONAL VARCHAR(80);
   DECLARE v_HeaderMemo1_N NATIONAL VARCHAR(80);
   DECLARE v_HeaderMemo2_O NATIONAL VARCHAR(80);
   DECLARE v_HeaderMemo2_N NATIONAL VARCHAR(80);
   DECLARE v_HeaderMemo3_O NATIONAL VARCHAR(80);
   DECLARE v_HeaderMemo3_N NATIONAL VARCHAR(80);
   DECLARE v_HeaderMemo4_O NATIONAL VARCHAR(80);
   DECLARE v_HeaderMemo4_N NATIONAL VARCHAR(80);
   DECLARE v_HeaderMemo5_O NATIONAL VARCHAR(80);
   DECLARE v_HeaderMemo5_N NATIONAL VARCHAR(80);
   DECLARE v_HeaderMemo6_O NATIONAL VARCHAR(80);
   DECLARE v_HeaderMemo6_N NATIONAL VARCHAR(80);
   DECLARE v_HeaderMemo7_O NATIONAL VARCHAR(80);
   DECLARE v_HeaderMemo7_N NATIONAL VARCHAR(80);
   DECLARE v_HeaderMemo8_O NATIONAL VARCHAR(80);
   DECLARE v_HeaderMemo8_N NATIONAL VARCHAR(80);
   DECLARE v_HeaderMemo9_O NATIONAL VARCHAR(80);
   DECLARE v_HeaderMemo9_N NATIONAL VARCHAR(80);
 

-- updating records cursor declaration
   DECLARE cUpdate CURSOR
   FOR SELECT
   d.ReceiptID
		,i.ReceiptID
		,''

		,i.CompanyID
		,i.DivisionID
		,i.DepartmentID
		,i.ReceiptID

,CAST(d.ReceiptTypeID AS CHAR(80))
,CAST(i.ReceiptTypeID AS CHAR(80))
,CAST(d.ReceiptClassID AS CHAR(80))
,CAST(i.ReceiptClassID AS CHAR(80))
,CAST(d.EDIDirectionTypeID AS CHAR(80))
,CAST(i.EDIDirectionTypeID AS CHAR(80))
,CAST(d.EDIDocumentTypeID AS CHAR(80))
,CAST(i.EDIDocumentTypeID AS CHAR(80))
,CAST(d.EDIOpen AS CHAR(80))
,CAST(i.EDIOpen AS CHAR(80))
,CAST(d.CheckNumber AS CHAR(80))
,CAST(i.CheckNumber AS CHAR(80))
,CAST(d.CustomerID AS CHAR(80))
,CAST(i.CustomerID AS CHAR(80))
,CAST(d.TransactionDate AS CHAR(80))
,CAST(i.TransactionDate AS CHAR(80))
,CAST(d.CurrencyID AS CHAR(80))
,CAST(i.CurrencyID AS CHAR(80))
,CAST(d.CurrencyExchangeRate AS CHAR(80))
,CAST(i.CurrencyExchangeRate AS CHAR(80))
,CAST(d.Amount AS CHAR(80))
,CAST(i.Amount AS CHAR(80))
,CAST(d.UnAppliedAmount AS CHAR(80))
,CAST(i.UnAppliedAmount AS CHAR(80))
,CAST(d.GLBankAccount AS CHAR(80))
,CAST(i.GLBankAccount AS CHAR(80))
,CAST(d.Status AS CHAR(80))
,CAST(i.Status AS CHAR(80))
,CAST(d.NSF AS CHAR(80))
,CAST(i.NSF AS CHAR(80))
,CAST(d.Notes AS CHAR(80))
,CAST(i.Notes AS CHAR(80))
,CAST(d.CreditAmount AS CHAR(80))
,CAST(i.CreditAmount AS CHAR(80))
,CAST(d.Cleared AS CHAR(80))
,CAST(i.Cleared AS CHAR(80))
,CAST(d.Posted AS CHAR(80))
,CAST(i.Posted AS CHAR(80))
,CAST(d.Reconciled AS CHAR(80))
,CAST(i.Reconciled AS CHAR(80))
,CAST(d.Deposited AS CHAR(80))
,CAST(i.Deposited AS CHAR(80))
,CAST(d.HeaderMemo1 AS CHAR(80))
,CAST(i.HeaderMemo1 AS CHAR(80))
,CAST(d.HeaderMemo2 AS CHAR(80))
,CAST(i.HeaderMemo2 AS CHAR(80))
,CAST(d.HeaderMemo3 AS CHAR(80))
,CAST(i.HeaderMemo3 AS CHAR(80))
,CAST(d.HeaderMemo4 AS CHAR(80))
,CAST(i.HeaderMemo4 AS CHAR(80))
,CAST(d.HeaderMemo5 AS CHAR(80))
,CAST(i.HeaderMemo5 AS CHAR(80))
,CAST(d.HeaderMemo6 AS CHAR(80))
,CAST(i.HeaderMemo6 AS CHAR(80))
,CAST(d.HeaderMemo7 AS CHAR(80))
,CAST(i.HeaderMemo7 AS CHAR(80))
,CAST(d.HeaderMemo8 AS CHAR(80))
,CAST(i.HeaderMemo8 AS CHAR(80))
,CAST(d.HeaderMemo9 AS CHAR(80))
,CAST(i.HeaderMemo9 AS CHAR(80))
 

   FROM
   InsEDIReceiptsHeader i
   LEFT OUTER JOIN DelEDIReceiptsHeader d ON
   d.CompanyID = i.CompanyID
   AND d.DivisionID = i.DivisionID
   AND d.DepartmentID = i.DepartmentID
   AND d.ReceiptID = i.ReceiptID;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET NO_DATA = -2;
   END;
   DECLARE CONTINUE HANDLER FOR NOT FOUND SET NO_DATA = -1;
   CREATE  TEMPORARY TABLE IF NOT EXISTS InsEDIReceiptsHeader
   (
      CompanyID NATIONAL VARCHAR(36),
      DivisionID NATIONAL VARCHAR(36),
      DepartmentID NATIONAL VARCHAR(36),
      ReceiptID NATIONAL VARCHAR(36),
      ReceiptTypeID NATIONAL VARCHAR(36),
      ReceiptClassID NATIONAL VARCHAR(36),
      EDIDirectionTypeID NATIONAL VARCHAR(1),
      EDIDocumentTypeID NATIONAL VARCHAR(3),
      EDIOpen BOOLEAN,
      CheckNumber NATIONAL VARCHAR(20),
      CustomerID NATIONAL VARCHAR(50),
      TransactionDate DATETIME,
      CurrencyID NATIONAL VARCHAR(3),
      CurrencyExchangeRate FLOAT,
      Amount DECIMAL(19,4),
      UnAppliedAmount DECIMAL(19,4),
      GLBankAccount NATIONAL VARCHAR(36),
      Status NATIONAL VARCHAR(10),
      NSF BOOLEAN,
      Notes NATIONAL VARCHAR(255),
      CreditAmount DECIMAL(19,4),
      Cleared BOOLEAN,
      Posted BOOLEAN,
      Reconciled BOOLEAN,
      Deposited BOOLEAN,
      HeaderMemo1 NATIONAL VARCHAR(50),
      HeaderMemo2 NATIONAL VARCHAR(50),
      HeaderMemo3 NATIONAL VARCHAR(50),
      HeaderMemo4 NATIONAL VARCHAR(50),
      HeaderMemo5 NATIONAL VARCHAR(50),
      HeaderMemo6 NATIONAL VARCHAR(50),
      HeaderMemo7 NATIONAL VARCHAR(50),
      HeaderMemo8 NATIONAL VARCHAR(50),
      HeaderMemo9 NATIONAL VARCHAR(50),
      LockedBy NATIONAL VARCHAR(36),
      LockTS DATETIME
   );
   DELETE FROM InsEDIReceiptsHeader;
   INSERT INTO InsEDIReceiptsHeader VALUES(NEW.CompanyID, NEW.DivisionID, NEW.DepartmentID, NEW.ReceiptID, NEW.ReceiptTypeID, NEW.ReceiptClassID, NEW.EDIDirectionTypeID, NEW.EDIDocumentTypeID, NEW.EDIOpen, NEW.CheckNumber, NEW.CustomerID, NEW.TransactionDate, NEW.CurrencyID, NEW.CurrencyExchangeRate, NEW.Amount, NEW.UnAppliedAmount, NEW.GLBankAccount, NEW.Status, NEW.NSF, NEW.Notes, NEW.CreditAmount, NEW.Cleared, NEW.Posted, NEW.Reconciled, NEW.Deposited, NEW.HeaderMemo1, NEW.HeaderMemo2, NEW.HeaderMemo3, NEW.HeaderMemo4, NEW.HeaderMemo5, NEW.HeaderMemo6, NEW.HeaderMemo7, NEW.HeaderMemo8, NEW.HeaderMemo9, NEW.LockedBy, NEW.LockTS);

   CREATE  TEMPORARY TABLE IF NOT EXISTS DelEDIReceiptsHeader
   (
      CompanyID NATIONAL VARCHAR(36),
      DivisionID NATIONAL VARCHAR(36),
      DepartmentID NATIONAL VARCHAR(36),
      ReceiptID NATIONAL VARCHAR(36),
      ReceiptTypeID NATIONAL VARCHAR(36),
      ReceiptClassID NATIONAL VARCHAR(36),
      EDIDirectionTypeID NATIONAL VARCHAR(1),
      EDIDocumentTypeID NATIONAL VARCHAR(3),
      EDIOpen BOOLEAN,
      CheckNumber NATIONAL VARCHAR(20),
      CustomerID NATIONAL VARCHAR(50),
      TransactionDate DATETIME,
      CurrencyID NATIONAL VARCHAR(3),
      CurrencyExchangeRate FLOAT,
      Amount DECIMAL(19,4),
      UnAppliedAmount DECIMAL(19,4),
      GLBankAccount NATIONAL VARCHAR(36),
      Status NATIONAL VARCHAR(10),
      NSF BOOLEAN,
      Notes NATIONAL VARCHAR(255),
      CreditAmount DECIMAL(19,4),
      Cleared BOOLEAN,
      Posted BOOLEAN,
      Reconciled BOOLEAN,
      Deposited BOOLEAN,
      HeaderMemo1 NATIONAL VARCHAR(50),
      HeaderMemo2 NATIONAL VARCHAR(50),
      HeaderMemo3 NATIONAL VARCHAR(50),
      HeaderMemo4 NATIONAL VARCHAR(50),
      HeaderMemo5 NATIONAL VARCHAR(50),
      HeaderMemo6 NATIONAL VARCHAR(50),
      HeaderMemo7 NATIONAL VARCHAR(50),
      HeaderMemo8 NATIONAL VARCHAR(50),
      HeaderMemo9 NATIONAL VARCHAR(50),
      LockedBy NATIONAL VARCHAR(36),
      LockTS DATETIME
   );
   DELETE FROM DelEDIReceiptsHeader;
   INSERT INTO DelEDIReceiptsHeader VALUES(OLD.CompanyID, OLD.DivisionID, OLD.DepartmentID, OLD.ReceiptID, OLD.ReceiptTypeID, OLD.ReceiptClassID, OLD.EDIDirectionTypeID, OLD.EDIDocumentTypeID, OLD.EDIOpen, OLD.CheckNumber, OLD.CustomerID, OLD.TransactionDate, OLD.CurrencyID, OLD.CurrencyExchangeRate, OLD.Amount, OLD.UnAppliedAmount, OLD.GLBankAccount, OLD.Status, OLD.NSF, OLD.Notes, OLD.CreditAmount, OLD.Cleared, OLD.Posted, OLD.Reconciled, OLD.Deposited, OLD.HeaderMemo1, OLD.HeaderMemo2, OLD.HeaderMemo3, OLD.HeaderMemo4, OLD.HeaderMemo5, OLD.HeaderMemo6, OLD.HeaderMemo7, OLD.HeaderMemo8, OLD.HeaderMemo9, OLD.LockedBy, OLD.LockTS);

   BEGIN
-- check for audit triggers switch off

      select   context_info INTO v_Context FROM sysprocesses WHERE spid = CONNECTION_ID();
      IF CAST(v_Context AS CHAR(36)) = N'$$AuditSwitchOff$$' then 
         LEAVE SWL_return;
      end if;

-- declarations
      OPEN cUpdate;
-- fetch from each updating record
      SET NO_DATA = 0;
      FETCH cUpdate INTO
      v_TransactionNumber_O,v_TransactionNumber_N,v_TransactionLineNumber,v_CompanyID,
      v_DivisionID,v_DepartmentID,v_ReceiptID,v_ReceiptTypeID_O,v_ReceiptTypeID_N,
      v_ReceiptClassID_O,v_ReceiptClassID_N,v_EDIDirectionTypeID_O,
      v_EDIDirectionTypeID_N,v_EDIDocumentTypeID_O,v_EDIDocumentTypeID_N,
      v_EDIOpen_O,v_EDIOpen_N,v_CheckNumber_O,v_CheckNumber_N,v_CustomerID_O,
      v_CustomerID_N,v_TransactionDate_O,v_TransactionDate_N,v_CurrencyID_O,
      v_CurrencyID_N,v_CurrencyExchangeRate_O,v_CurrencyExchangeRate_N,
      v_Amount_O,v_Amount_N,v_UnAppliedAmount_O,v_UnAppliedAmount_N,v_GLBankAccount_O,
      v_GLBankAccount_N,v_Status_O,v_Status_N,v_NSF_O,v_NSF_N,v_Notes_O,
      v_Notes_N,v_CreditAmount_O,v_CreditAmount_N,v_Cleared_O,v_Cleared_N,
      v_Posted_O,v_Posted_N,v_Reconciled_O,v_Reconciled_N,v_Deposited_O,
      v_Deposited_N,v_HeaderMemo1_O,v_HeaderMemo1_N,v_HeaderMemo2_O,v_HeaderMemo2_N,
      v_HeaderMemo3_O,v_HeaderMemo3_N,v_HeaderMemo4_O,v_HeaderMemo4_N,
      v_HeaderMemo5_O,v_HeaderMemo5_N,v_HeaderMemo6_O,v_HeaderMemo6_N,v_HeaderMemo7_O,
      v_HeaderMemo7_N,v_HeaderMemo8_O,v_HeaderMemo8_N,v_HeaderMemo9_O,
      v_HeaderMemo9_N;
      WHILE NO_DATA = 0 DO
-- insert audit records for each changed field
         IF IsGuid(v_TransactionNumber_N) = 0 then
		
            IF v_TransactionNumber_O IS NULL then
				
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIReceiptsHeader','New Record','','New Record');
            ELSE
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIReceiptsHeader','ReceiptTypeID',v_ReceiptTypeID_O,
               v_ReceiptTypeID_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIReceiptsHeader','ReceiptClassID',v_ReceiptClassID_O,
               v_ReceiptClassID_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIReceiptsHeader','EDIDirectionTypeID',v_EDIDirectionTypeID_O,
               v_EDIDirectionTypeID_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIReceiptsHeader','EDIDocumentTypeID',v_EDIDocumentTypeID_O,
               v_EDIDocumentTypeID_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIReceiptsHeader','EDIOpen',v_EDIOpen_O,v_EDIOpen_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIReceiptsHeader','CheckNumber',v_CheckNumber_O,
               v_CheckNumber_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIReceiptsHeader','CustomerID',v_CustomerID_O,
               v_CustomerID_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIReceiptsHeader','TransactionDate',v_TransactionDate_O,
               v_TransactionDate_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIReceiptsHeader','CurrencyID',v_CurrencyID_O,
               v_CurrencyID_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIReceiptsHeader','CurrencyExchangeRate',v_CurrencyExchangeRate_O,
               v_CurrencyExchangeRate_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIReceiptsHeader','Amount',v_Amount_O,v_Amount_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIReceiptsHeader','UnAppliedAmount',v_UnAppliedAmount_O,
               v_UnAppliedAmount_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIReceiptsHeader','GLBankAccount',v_GLBankAccount_O,
               v_GLBankAccount_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIReceiptsHeader','Status',v_Status_O,v_Status_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIReceiptsHeader','NSF',v_NSF_O,v_NSF_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIReceiptsHeader','Notes',v_Notes_O,v_Notes_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIReceiptsHeader','CreditAmount',v_CreditAmount_O,
               v_CreditAmount_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIReceiptsHeader','Cleared',v_Cleared_O,v_Cleared_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIReceiptsHeader','Posted',v_Posted_O,v_Posted_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIReceiptsHeader','Reconciled',v_Reconciled_O,
               v_Reconciled_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIReceiptsHeader','Deposited',v_Deposited_O,v_Deposited_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIReceiptsHeader','HeaderMemo1',v_HeaderMemo1_O,
               v_HeaderMemo1_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIReceiptsHeader','HeaderMemo2',v_HeaderMemo2_O,
               v_HeaderMemo2_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIReceiptsHeader','HeaderMemo3',v_HeaderMemo3_O,
               v_HeaderMemo3_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIReceiptsHeader','HeaderMemo4',v_HeaderMemo4_O,
               v_HeaderMemo4_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIReceiptsHeader','HeaderMemo5',v_HeaderMemo5_O,
               v_HeaderMemo5_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIReceiptsHeader','HeaderMemo6',v_HeaderMemo6_O,
               v_HeaderMemo6_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIReceiptsHeader','HeaderMemo7',v_HeaderMemo7_O,
               v_HeaderMemo7_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIReceiptsHeader','HeaderMemo8',v_HeaderMemo8_O,
               v_HeaderMemo8_N);
               CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
               'EDIReceiptsHeader','HeaderMemo9',v_HeaderMemo9_O,
               v_HeaderMemo9_N);
            end if;
         end if;
         SET NO_DATA = 0;
         FETCH cUpdate INTO
         v_TransactionNumber_O,v_TransactionNumber_N,v_TransactionLineNumber,v_CompanyID,
         v_DivisionID,v_DepartmentID,v_ReceiptID,v_ReceiptTypeID_O,v_ReceiptTypeID_N,
         v_ReceiptClassID_O,v_ReceiptClassID_N,v_EDIDirectionTypeID_O,
         v_EDIDirectionTypeID_N,v_EDIDocumentTypeID_O,v_EDIDocumentTypeID_N,
         v_EDIOpen_O,v_EDIOpen_N,v_CheckNumber_O,v_CheckNumber_N,v_CustomerID_O,
         v_CustomerID_N,v_TransactionDate_O,v_TransactionDate_N,v_CurrencyID_O,
         v_CurrencyID_N,v_CurrencyExchangeRate_O,v_CurrencyExchangeRate_N,
         v_Amount_O,v_Amount_N,v_UnAppliedAmount_O,v_UnAppliedAmount_N,v_GLBankAccount_O,
         v_GLBankAccount_N,v_Status_O,v_Status_N,v_NSF_O,v_NSF_N,v_Notes_O,
         v_Notes_N,v_CreditAmount_O,v_CreditAmount_N,v_Cleared_O,v_Cleared_N,
         v_Posted_O,v_Posted_N,v_Reconciled_O,v_Reconciled_N,v_Deposited_O,
         v_Deposited_N,v_HeaderMemo1_O,v_HeaderMemo1_N,v_HeaderMemo2_O,v_HeaderMemo2_N,
         v_HeaderMemo3_O,v_HeaderMemo3_N,v_HeaderMemo4_O,v_HeaderMemo4_N,
         v_HeaderMemo5_O,v_HeaderMemo5_N,v_HeaderMemo6_O,v_HeaderMemo6_N,v_HeaderMemo7_O,
         v_HeaderMemo7_N,v_HeaderMemo8_O,v_HeaderMemo8_N,v_HeaderMemo9_O,
         v_HeaderMemo9_N;
      END WHILE;
      CLOSE cUpdate;

   END;
END;
 ;;
delimiter ;
delimiter ;;
CREATE TRIGGER `EDIReceiptsHeader_Audit_Delete` AFTER DELETE ON `edireceiptsheader` FOR EACH ROW SWL_return:
BEGIN
   DECLARE NO_DATA INT DEFAULT 0;
   DECLARE v_Context VARBINARY(128);
   DECLARE v_TransactionNumber NATIONAL VARCHAR(50);
   DECLARE v_TransactionLineNumber NATIONAL VARCHAR(50);

   DECLARE v_CompanyID NATIONAL VARCHAR(36);
   DECLARE v_DivisionID NATIONAL VARCHAR(36);
   DECLARE v_DepartmentID NATIONAL VARCHAR(36);
   DECLARE v_ReceiptID NATIONAL VARCHAR(36);

-- deleting records cursor declaration
   DECLARE cDelete CURSOR
   FOR SELECT
   d.ReceiptID
		,''

		,d.CompanyID
		,d.DivisionID
		,d.DepartmentID
		,d.ReceiptID

   FROM
   DelEDIReceiptsHeader d;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET NO_DATA = -2;
   END;
   DECLARE CONTINUE HANDLER FOR NOT FOUND SET NO_DATA = -1;
   CREATE  TEMPORARY TABLE IF NOT EXISTS DelEDIReceiptsHeader
   (
      CompanyID NATIONAL VARCHAR(36),
      DivisionID NATIONAL VARCHAR(36),
      DepartmentID NATIONAL VARCHAR(36),
      ReceiptID NATIONAL VARCHAR(36),
      ReceiptTypeID NATIONAL VARCHAR(36),
      ReceiptClassID NATIONAL VARCHAR(36),
      EDIDirectionTypeID NATIONAL VARCHAR(1),
      EDIDocumentTypeID NATIONAL VARCHAR(3),
      EDIOpen BOOLEAN,
      CheckNumber NATIONAL VARCHAR(20),
      CustomerID NATIONAL VARCHAR(50),
      TransactionDate DATETIME,
      CurrencyID NATIONAL VARCHAR(3),
      CurrencyExchangeRate FLOAT,
      Amount DECIMAL(19,4),
      UnAppliedAmount DECIMAL(19,4),
      GLBankAccount NATIONAL VARCHAR(36),
      Status NATIONAL VARCHAR(10),
      NSF BOOLEAN,
      Notes NATIONAL VARCHAR(255),
      CreditAmount DECIMAL(19,4),
      Cleared BOOLEAN,
      Posted BOOLEAN,
      Reconciled BOOLEAN,
      Deposited BOOLEAN,
      HeaderMemo1 NATIONAL VARCHAR(50),
      HeaderMemo2 NATIONAL VARCHAR(50),
      HeaderMemo3 NATIONAL VARCHAR(50),
      HeaderMemo4 NATIONAL VARCHAR(50),
      HeaderMemo5 NATIONAL VARCHAR(50),
      HeaderMemo6 NATIONAL VARCHAR(50),
      HeaderMemo7 NATIONAL VARCHAR(50),
      HeaderMemo8 NATIONAL VARCHAR(50),
      HeaderMemo9 NATIONAL VARCHAR(50),
      LockedBy NATIONAL VARCHAR(36),
      LockTS DATETIME
   );
   DELETE FROM DelEDIReceiptsHeader;
   INSERT INTO DelEDIReceiptsHeader VALUES(OLD.CompanyID, OLD.DivisionID, OLD.DepartmentID, OLD.ReceiptID, OLD.ReceiptTypeID, OLD.ReceiptClassID, OLD.EDIDirectionTypeID, OLD.EDIDocumentTypeID, OLD.EDIOpen, OLD.CheckNumber, OLD.CustomerID, OLD.TransactionDate, OLD.CurrencyID, OLD.CurrencyExchangeRate, OLD.Amount, OLD.UnAppliedAmount, OLD.GLBankAccount, OLD.Status, OLD.NSF, OLD.Notes, OLD.CreditAmount, OLD.Cleared, OLD.Posted, OLD.Reconciled, OLD.Deposited, OLD.HeaderMemo1, OLD.HeaderMemo2, OLD.HeaderMemo3, OLD.HeaderMemo4, OLD.HeaderMemo5, OLD.HeaderMemo6, OLD.HeaderMemo7, OLD.HeaderMemo8, OLD.HeaderMemo9, OLD.LockedBy, OLD.LockTS);

   BEGIN
-- check for audit triggers switch off

      select   context_info INTO v_Context FROM sysprocesses WHERE spid = CONNECTION_ID();
      IF CAST(v_Context AS CHAR(36)) = N'$$AuditSwitchOff$$' then 
         LEAVE SWL_return;
      end if;

-- declarations
      OPEN cDelete;
-- fetch from each deleting record
      SET NO_DATA = 0;
      FETCH cDelete INTO
      v_TransactionNumber,v_TransactionLineNumber,v_CompanyID,v_DivisionID,v_DepartmentID,
      v_ReceiptID;
      WHILE NO_DATA = 0 DO
-- insert audit record for each deleting record
         CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber,v_TransactionLineNumber,
         'EDIReceiptsHeader','Deleted','','Deleted');
         SET NO_DATA = 0;
         FETCH cDelete INTO
         v_TransactionNumber,v_TransactionLineNumber,v_CompanyID,v_DivisionID,v_DepartmentID,
         v_ReceiptID;
      END WHILE;
      CLOSE cDelete;

   END;
END;
 ;;
delimiter ;

-- ----------------------------
--  Table structure for `edisetup`
-- ----------------------------
DROP TABLE IF EXISTS `edisetup`;
CREATE TABLE `edisetup` (
  `CompanyID` varchar(36) NOT NULL,
  `DivisionID` varchar(36) NOT NULL,
  `DepartmentID` varchar(36) NOT NULL,
  `EDIID` varchar(10) NOT NULL,
  `EDIActive` tinyint(1) DEFAULT NULL,
  `EDIQualifier` varchar(2) DEFAULT NULL,
  `EDITestQualifier` varchar(2) DEFAULT NULL,
  `EDITestID` varchar(10) DEFAULT NULL,
  `EDIInboundOrders` tinyint(1) DEFAULT NULL,
  `EDIOutboundOrders` tinyint(1) DEFAULT NULL,
  `EDIInboundInvoices` tinyint(1) DEFAULT NULL,
  `EDIOutboundInvoices` tinyint(1) DEFAULT NULL,
  `EDIInboundASN` tinyint(1) DEFAULT NULL,
  `EDIOutboundASN` tinyint(1) DEFAULT NULL,
  `EDIInboundUPC` tinyint(1) DEFAULT NULL,
  `EDIOutboundUPC` tinyint(1) DEFAULT NULL,
  `EDIInboundFinancial` tinyint(1) DEFAULT NULL,
  `EDIOutboundFinancial` tinyint(1) DEFAULT NULL,
  `EDIInboundOrderStatus` tinyint(1) DEFAULT NULL,
  `EDIOutboundOrderStatus` tinyint(1) DEFAULT NULL,
  `EDIInboundInventory` tinyint(1) DEFAULT NULL,
  `EDIOutboundInventory` tinyint(1) DEFAULT NULL,
  `LockedBy` varchar(36) DEFAULT NULL,
  `LockTS` datetime DEFAULT NULL,
  PRIMARY KEY (`CompanyID`,`DivisionID`,`DepartmentID`,`EDIID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
delimiter ;;
CREATE TRIGGER `EDISetup_Audit_Insert` AFTER INSERT ON `edisetup` FOR EACH ROW SWL_return:
BEGIN
   DECLARE NO_DATA INT DEFAULT 0;
   DECLARE v_Context VARBINARY(128);
   DECLARE v_TransactionNumber NATIONAL VARCHAR(50);
   DECLARE v_TransactionLineNumber NATIONAL VARCHAR(50);

   DECLARE v_CompanyID NATIONAL VARCHAR(36);
   DECLARE v_DivisionID NATIONAL VARCHAR(36);
   DECLARE v_DepartmentID NATIONAL VARCHAR(36);
   DECLARE v_EDIID NATIONAL VARCHAR(10);

-- inserting records cursor declaration
   DECLARE cInsert CURSOR
   FOR SELECT
   i.EDIID
		,''

		,i.CompanyID
		,i.DivisionID
		,i.DepartmentID
		,i.EDIID

   FROM
   InsEDISetup i;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET NO_DATA = -2;
   END;
   DECLARE CONTINUE HANDLER FOR NOT FOUND SET NO_DATA = -1;
   CREATE  TEMPORARY TABLE IF NOT EXISTS InsEDISetup
   (
      CompanyID NATIONAL VARCHAR(36),
      DivisionID NATIONAL VARCHAR(36),
      DepartmentID NATIONAL VARCHAR(36),
      EDIID NATIONAL VARCHAR(10),
      EDIActive BOOLEAN,
      EDIQualifier NATIONAL VARCHAR(2),
      EDITestQualifier NATIONAL VARCHAR(2),
      EDITestID NATIONAL VARCHAR(10),
      EDIInboundOrders BOOLEAN,
      EDIOutboundOrders BOOLEAN,
      EDIInboundInvoices BOOLEAN,
      EDIOutboundInvoices BOOLEAN,
      EDIInboundASN BOOLEAN,
      EDIOutboundASN BOOLEAN,
      EDIInboundUPC BOOLEAN,
      EDIOutboundUPC BOOLEAN,
      EDIInboundFinancial BOOLEAN,
      EDIOutboundFinancial BOOLEAN,
      EDIInboundOrderStatus BOOLEAN,
      EDIOutboundOrderStatus BOOLEAN,
      EDIInboundInventory BOOLEAN,
      EDIOutboundInventory BOOLEAN,
      LockedBy NATIONAL VARCHAR(36),
      LockTS DATETIME
   );
   DELETE FROM InsEDISetup;
   INSERT INTO InsEDISetup VALUES(NEW.CompanyID, NEW.DivisionID, NEW.DepartmentID, NEW.EDIID, NEW.EDIActive, NEW.EDIQualifier, NEW.EDITestQualifier, NEW.EDITestID, NEW.EDIInboundOrders, NEW.EDIOutboundOrders, NEW.EDIInboundInvoices, NEW.EDIOutboundInvoices, NEW.EDIInboundASN, NEW.EDIOutboundASN, NEW.EDIInboundUPC, NEW.EDIOutboundUPC, NEW.EDIInboundFinancial, NEW.EDIOutboundFinancial, NEW.EDIInboundOrderStatus, NEW.EDIOutboundOrderStatus, NEW.EDIInboundInventory, NEW.EDIOutboundInventory, NEW.LockedBy, NEW.LockTS);

   BEGIN
-- check for audit triggers switch off

      select   context_info INTO v_Context FROM sysprocesses WHERE spid = CONNECTION_ID();
      IF CAST(v_Context AS CHAR(36)) = N'$$AuditSwitchOff$$' then 
         LEAVE SWL_return;
      end if;

-- declarations
      OPEN cInsert;
-- fetch from each inserting record
      SET NO_DATA = 0;
      FETCH cInsert INTO
      v_TransactionNumber,v_TransactionLineNumber,v_CompanyID,v_DivisionID,v_DepartmentID,
      v_EDIID;
      WHILE NO_DATA = 0 DO
-- insert audit record for each inserting record
         IF IsGuid(v_TransactionNumber) = 0 then
		
            CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber,v_TransactionLineNumber,
            'EDISetup','New Record','','New Record');
         end if;
         SET NO_DATA = 0;
         FETCH cInsert INTO
         v_TransactionNumber,v_TransactionLineNumber,v_CompanyID,v_DivisionID,v_DepartmentID,
         v_EDIID;
      END WHILE;
      CLOSE cInsert;

   END;
END;
 ;;
delimiter ;
delimiter ;;
CREATE TRIGGER `EDISetup_Audit_Update` AFTER UPDATE ON `edisetup` FOR EACH ROW SWL_return:
BEGIN
   DECLARE NO_DATA INT DEFAULT 0;
   DECLARE v_Context VARBINARY(128);
   DECLARE v_TransactionNumber_O NATIONAL VARCHAR(50);
   DECLARE v_TransactionNumber_N NATIONAL VARCHAR(50);
   DECLARE v_TransactionLineNumber NATIONAL VARCHAR(50);

   DECLARE v_CompanyID NATIONAL VARCHAR(36);
   DECLARE v_DivisionID NATIONAL VARCHAR(36);
   DECLARE v_DepartmentID NATIONAL VARCHAR(36);
   DECLARE v_EDIID NATIONAL VARCHAR(10);

   DECLARE v_EDIActive_O NATIONAL VARCHAR(80);
   DECLARE v_EDIActive_N NATIONAL VARCHAR(80);
   DECLARE v_EDIQualifier_O NATIONAL VARCHAR(80);
   DECLARE v_EDIQualifier_N NATIONAL VARCHAR(80);
   DECLARE v_EDITestQualifier_O NATIONAL VARCHAR(80);
   DECLARE v_EDITestQualifier_N NATIONAL VARCHAR(80);
   DECLARE v_EDITestID_O NATIONAL VARCHAR(80);
   DECLARE v_EDITestID_N NATIONAL VARCHAR(80);
   DECLARE v_EDIInboundOrders_O NATIONAL VARCHAR(80);
   DECLARE v_EDIInboundOrders_N NATIONAL VARCHAR(80);
   DECLARE v_EDIOutboundOrders_O NATIONAL VARCHAR(80);
   DECLARE v_EDIOutboundOrders_N NATIONAL VARCHAR(80);
   DECLARE v_EDIInboundInvoices_O NATIONAL VARCHAR(80);
   DECLARE v_EDIInboundInvoices_N NATIONAL VARCHAR(80);
   DECLARE v_EDIOutboundInvoices_O NATIONAL VARCHAR(80);
   DECLARE v_EDIOutboundInvoices_N NATIONAL VARCHAR(80);
   DECLARE v_EDIInboundASN_O NATIONAL VARCHAR(80);
   DECLARE v_EDIInboundASN_N NATIONAL VARCHAR(80);
   DECLARE v_EDIOutboundASN_O NATIONAL VARCHAR(80);
   DECLARE v_EDIOutboundASN_N NATIONAL VARCHAR(80);
   DECLARE v_EDIInboundUPC_O NATIONAL VARCHAR(80);
   DECLARE v_EDIInboundUPC_N NATIONAL VARCHAR(80);
   DECLARE v_EDIOutboundUPC_O NATIONAL VARCHAR(80);
   DECLARE v_EDIOutboundUPC_N NATIONAL VARCHAR(80);
   DECLARE v_EDIInboundFinancial_O NATIONAL VARCHAR(80);
   DECLARE v_EDIInboundFinancial_N NATIONAL VARCHAR(80);
   DECLARE v_EDIOutboundFinancial_O NATIONAL VARCHAR(80);
   DECLARE v_EDIOutboundFinancial_N NATIONAL VARCHAR(80);
   DECLARE v_EDIInboundOrderStatus_O NATIONAL VARCHAR(80);
   DECLARE v_EDIInboundOrderStatus_N NATIONAL VARCHAR(80);
   DECLARE v_EDIOutboundOrderStatus_O NATIONAL VARCHAR(80);
   DECLARE v_EDIOutboundOrderStatus_N NATIONAL VARCHAR(80);
   DECLARE v_EDIInboundInventory_O NATIONAL VARCHAR(80);
   DECLARE v_EDIInboundInventory_N NATIONAL VARCHAR(80);
   DECLARE v_EDIOutboundInventory_O NATIONAL VARCHAR(80);
   DECLARE v_EDIOutboundInventory_N NATIONAL VARCHAR(80);
 

-- updating records cursor declaration
   DECLARE cUpdate CURSOR
   FOR SELECT
   d.EDIID
		,i.EDIID
		,''

		,i.CompanyID
		,i.DivisionID
		,i.DepartmentID
		,i.EDIID

,CAST(d.EDIActive AS CHAR(80))
,CAST(i.EDIActive AS CHAR(80))
,CAST(d.EDIQualifier AS CHAR(80))
,CAST(i.EDIQualifier AS CHAR(80))
,CAST(d.EDITestQualifier AS CHAR(80))
,CAST(i.EDITestQualifier AS CHAR(80))
,CAST(d.EDITestID AS CHAR(80))
,CAST(i.EDITestID AS CHAR(80))
,CAST(d.EDIInboundOrders AS CHAR(80))
,CAST(i.EDIInboundOrders AS CHAR(80))
,CAST(d.EDIOutboundOrders AS CHAR(80))
,CAST(i.EDIOutboundOrders AS CHAR(80))
,CAST(d.EDIInboundInvoices AS CHAR(80))
,CAST(i.EDIInboundInvoices AS CHAR(80))
,CAST(d.EDIOutboundInvoices AS CHAR(80))
,CAST(i.EDIOutboundInvoices AS CHAR(80))
,CAST(d.EDIInboundASN AS CHAR(80))
,CAST(i.EDIInboundASN AS CHAR(80))
,CAST(d.EDIOutboundASN AS CHAR(80))
,CAST(i.EDIOutboundASN AS CHAR(80))
,CAST(d.EDIInboundUPC AS CHAR(80))
,CAST(i.EDIInboundUPC AS CHAR(80))
,CAST(d.EDIOutboundUPC AS CHAR(80))
,CAST(i.EDIOutboundUPC AS CHAR(80))
,CAST(d.EDIInboundFinancial AS CHAR(80))
,CAST(i.EDIInboundFinancial AS CHAR(80))
,CAST(d.EDIOutboundFinancial AS CHAR(80))
,CAST(i.EDIOutboundFinancial AS CHAR(80))
,CAST(d.EDIInboundOrderStatus AS CHAR(80))
,CAST(i.EDIInboundOrderStatus AS CHAR(80))
,CAST(d.EDIOutboundOrderStatus AS CHAR(80))
,CAST(i.EDIOutboundOrderStatus AS CHAR(80))
,CAST(d.EDIInboundInventory AS CHAR(80))
,CAST(i.EDIInboundInventory AS CHAR(80))
,CAST(d.EDIOutboundInventory AS CHAR(80))
,CAST(i.EDIOutboundInventory AS CHAR(80))
 

   FROM
   InsEDISetup i
   LEFT OUTER JOIN DelEDISetup d ON
   d.CompanyID = i.CompanyID
   AND d.DivisionID = i.DivisionID
   AND d.DepartmentID = i.DepartmentID
   AND d.EDIID = i.EDIID;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET NO_DATA = -2;
   END;
   DECLARE CONTINUE HANDLER FOR NOT FOUND SET NO_DATA = -1;
   CREATE  TEMPORARY TABLE IF NOT EXISTS InsEDISetup
   (
      CompanyID NATIONAL VARCHAR(36),
      DivisionID NATIONAL VARCHAR(36),
      DepartmentID NATIONAL VARCHAR(36),
      EDIID NATIONAL VARCHAR(10),
      EDIActive BOOLEAN,
      EDIQualifier NATIONAL VARCHAR(2),
      EDITestQualifier NATIONAL VARCHAR(2),
      EDITestID NATIONAL VARCHAR(10),
      EDIInboundOrders BOOLEAN,
      EDIOutboundOrders BOOLEAN,
      EDIInboundInvoices BOOLEAN,
      EDIOutboundInvoices BOOLEAN,
      EDIInboundASN BOOLEAN,
      EDIOutboundASN BOOLEAN,
      EDIInboundUPC BOOLEAN,
      EDIOutboundUPC BOOLEAN,
      EDIInboundFinancial BOOLEAN,
      EDIOutboundFinancial BOOLEAN,
      EDIInboundOrderStatus BOOLEAN,
      EDIOutboundOrderStatus BOOLEAN,
      EDIInboundInventory BOOLEAN,
      EDIOutboundInventory BOOLEAN,
      LockedBy NATIONAL VARCHAR(36),
      LockTS DATETIME
   );
   DELETE FROM InsEDISetup;
   INSERT INTO InsEDISetup VALUES(NEW.CompanyID, NEW.DivisionID, NEW.DepartmentID, NEW.EDIID, NEW.EDIActive, NEW.EDIQualifier, NEW.EDITestQualifier, NEW.EDITestID, NEW.EDIInboundOrders, NEW.EDIOutboundOrders, NEW.EDIInboundInvoices, NEW.EDIOutboundInvoices, NEW.EDIInboundASN, NEW.EDIOutboundASN, NEW.EDIInboundUPC, NEW.EDIOutboundUPC, NEW.EDIInboundFinancial, NEW.EDIOutboundFinancial, NEW.EDIInboundOrderStatus, NEW.EDIOutboundOrderStatus, NEW.EDIInboundInventory, NEW.EDIOutboundInventory, NEW.LockedBy, NEW.LockTS);

   CREATE  TEMPORARY TABLE IF NOT EXISTS DelEDISetup
   (
      CompanyID NATIONAL VARCHAR(36),
      DivisionID NATIONAL VARCHAR(36),
      DepartmentID NATIONAL VARCHAR(36),
      EDIID NATIONAL VARCHAR(10),
      EDIActive BOOLEAN,
      EDIQualifier NATIONAL VARCHAR(2),
      EDITestQualifier NATIONAL VARCHAR(2),
      EDITestID NATIONAL VARCHAR(10),
      EDIInboundOrders BOOLEAN,
      EDIOutboundOrders BOOLEAN,
      EDIInboundInvoices BOOLEAN,
      EDIOutboundInvoices BOOLEAN,
      EDIInboundASN BOOLEAN,
      EDIOutboundASN BOOLEAN,
      EDIInboundUPC BOOLEAN,
      EDIOutboundUPC BOOLEAN,
      EDIInboundFinancial BOOLEAN,
      EDIOutboundFinancial BOOLEAN,
      EDIInboundOrderStatus BOOLEAN,
      EDIOutboundOrderStatus BOOLEAN,
      EDIInboundInventory BOOLEAN,
      EDIOutboundInventory BOOLEAN,
      LockedBy NATIONAL VARCHAR(36),
      LockTS DATETIME
   );
   DELETE FROM DelEDISetup;
   INSERT INTO DelEDISetup VALUES(OLD.CompanyID, OLD.DivisionID, OLD.DepartmentID, OLD.EDIID, OLD.EDIActive, OLD.EDIQualifier, OLD.EDITestQualifier, OLD.EDITestID, OLD.EDIInboundOrders, OLD.EDIOutboundOrders, OLD.EDIInboundInvoices, OLD.EDIOutboundInvoices, OLD.EDIInboundASN, OLD.EDIOutboundASN, OLD.EDIInboundUPC, OLD.EDIOutboundUPC, OLD.EDIInboundFinancial, OLD.EDIOutboundFinancial, OLD.EDIInboundOrderStatus, OLD.EDIOutboundOrderStatus, OLD.EDIInboundInventory, OLD.EDIOutboundInventory, OLD.LockedBy, OLD.LockTS);

   BEGIN
-- check for audit triggers switch off

      select   context_info INTO v_Context FROM sysprocesses WHERE spid = CONNECTION_ID();
      IF CAST(v_Context AS CHAR(36)) = N'$$AuditSwitchOff$$' then 
         LEAVE SWL_return;
      end if;

-- declarations
      OPEN cUpdate;
-- fetch from each updating record
      SET NO_DATA = 0;
      FETCH cUpdate INTO
      v_TransactionNumber_O,v_TransactionNumber_N,v_TransactionLineNumber,v_CompanyID,
      v_DivisionID,v_DepartmentID,v_EDIID,v_EDIActive_O,v_EDIActive_N,
      v_EDIQualifier_O,v_EDIQualifier_N,v_EDITestQualifier_O,v_EDITestQualifier_N,
      v_EDITestID_O,v_EDITestID_N,v_EDIInboundOrders_O,v_EDIInboundOrders_N,
      v_EDIOutboundOrders_O,v_EDIOutboundOrders_N,v_EDIInboundInvoices_O,
      v_EDIInboundInvoices_N,v_EDIOutboundInvoices_O,v_EDIOutboundInvoices_N,
      v_EDIInboundASN_O,v_EDIInboundASN_N,v_EDIOutboundASN_O,v_EDIOutboundASN_N,
      v_EDIInboundUPC_O,v_EDIInboundUPC_N,v_EDIOutboundUPC_O,v_EDIOutboundUPC_N,
      v_EDIInboundFinancial_O,v_EDIInboundFinancial_N,v_EDIOutboundFinancial_O,
      v_EDIOutboundFinancial_N,v_EDIInboundOrderStatus_O,
      v_EDIInboundOrderStatus_N,v_EDIOutboundOrderStatus_O,v_EDIOutboundOrderStatus_N,
      v_EDIInboundInventory_O,v_EDIInboundInventory_N,v_EDIOutboundInventory_O,
      v_EDIOutboundInventory_N;
      WHILE NO_DATA = 0 DO
-- insert audit records for each changed field

         CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
         'EDISetup','EDIActive',v_EDIActive_O,v_EDIActive_N);
         CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
         'EDISetup','EDIQualifier',v_EDIQualifier_O,v_EDIQualifier_N);
         CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
         'EDISetup','EDITestQualifier',v_EDITestQualifier_O,
         v_EDITestQualifier_N);
         CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
         'EDISetup','EDITestID',v_EDITestID_O,v_EDITestID_N);
         CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
         'EDISetup','EDIInboundOrders',v_EDIInboundOrders_O,
         v_EDIInboundOrders_N);
         CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
         'EDISetup','EDIOutboundOrders',v_EDIOutboundOrders_O,
         v_EDIOutboundOrders_N);
         CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
         'EDISetup','EDIInboundInvoices',v_EDIInboundInvoices_O,
         v_EDIInboundInvoices_N);
         CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
         'EDISetup','EDIOutboundInvoices',v_EDIOutboundInvoices_O,
         v_EDIOutboundInvoices_N);
         CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
         'EDISetup','EDIInboundASN',v_EDIInboundASN_O,v_EDIInboundASN_N);
         CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
         'EDISetup','EDIOutboundASN',v_EDIOutboundASN_O,v_EDIOutboundASN_N);
         CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
         'EDISetup','EDIInboundUPC',v_EDIInboundUPC_O,v_EDIInboundUPC_N);
         CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
         'EDISetup','EDIOutboundUPC',v_EDIOutboundUPC_O,v_EDIOutboundUPC_N);
         CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
         'EDISetup','EDIInboundFinancial',v_EDIInboundFinancial_O,
         v_EDIInboundFinancial_N);
         CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
         'EDISetup','EDIOutboundFinancial',v_EDIOutboundFinancial_O,
         v_EDIOutboundFinancial_N);
         CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
         'EDISetup','EDIInboundOrderStatus',v_EDIInboundOrderStatus_O,
         v_EDIInboundOrderStatus_N);
         CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
         'EDISetup','EDIOutboundOrderStatus',v_EDIOutboundOrderStatus_O,
         v_EDIOutboundOrderStatus_N);
         CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
         'EDISetup','EDIInboundInventory',v_EDIInboundInventory_O,
         v_EDIInboundInventory_N);
         CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
         'EDISetup','EDIOutboundInventory',v_EDIOutboundInventory_O,
         v_EDIOutboundInventory_N);
         SET NO_DATA = 0;
         FETCH cUpdate INTO
         v_TransactionNumber_O,v_TransactionNumber_N,v_TransactionLineNumber,v_CompanyID,
         v_DivisionID,v_DepartmentID,v_EDIID,v_EDIActive_O,v_EDIActive_N,
         v_EDIQualifier_O,v_EDIQualifier_N,v_EDITestQualifier_O,v_EDITestQualifier_N,
         v_EDITestID_O,v_EDITestID_N,v_EDIInboundOrders_O,v_EDIInboundOrders_N,
         v_EDIOutboundOrders_O,v_EDIOutboundOrders_N,v_EDIInboundInvoices_O,
         v_EDIInboundInvoices_N,v_EDIOutboundInvoices_O,v_EDIOutboundInvoices_N,
         v_EDIInboundASN_O,v_EDIInboundASN_N,v_EDIOutboundASN_O,v_EDIOutboundASN_N,
         v_EDIInboundUPC_O,v_EDIInboundUPC_N,v_EDIOutboundUPC_O,v_EDIOutboundUPC_N,
         v_EDIInboundFinancial_O,v_EDIInboundFinancial_N,v_EDIOutboundFinancial_O,
         v_EDIOutboundFinancial_N,v_EDIInboundOrderStatus_O,
         v_EDIInboundOrderStatus_N,v_EDIOutboundOrderStatus_O,v_EDIOutboundOrderStatus_N,
         v_EDIInboundInventory_O,v_EDIInboundInventory_N,v_EDIOutboundInventory_O,
         v_EDIOutboundInventory_N;
      END WHILE;
      CLOSE cUpdate;

   END;
END;
 ;;
delimiter ;
delimiter ;;
CREATE TRIGGER `EDISetup_Audit_Delete` AFTER DELETE ON `edisetup` FOR EACH ROW SWL_return:
BEGIN
   DECLARE NO_DATA INT DEFAULT 0;
   DECLARE v_Context VARBINARY(128);
   DECLARE v_TransactionNumber NATIONAL VARCHAR(50);
   DECLARE v_TransactionLineNumber NATIONAL VARCHAR(50);

   DECLARE v_CompanyID NATIONAL VARCHAR(36);
   DECLARE v_DivisionID NATIONAL VARCHAR(36);
   DECLARE v_DepartmentID NATIONAL VARCHAR(36);
   DECLARE v_EDIID NATIONAL VARCHAR(10);

-- deleting records cursor declaration
   DECLARE cDelete CURSOR
   FOR SELECT
   d.EDIID
		,''

		,d.CompanyID
		,d.DivisionID
		,d.DepartmentID
		,d.EDIID

   FROM
   DelEDISetup d;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET NO_DATA = -2;
   END;
   DECLARE CONTINUE HANDLER FOR NOT FOUND SET NO_DATA = -1;
   CREATE  TEMPORARY TABLE IF NOT EXISTS DelEDISetup
   (
      CompanyID NATIONAL VARCHAR(36),
      DivisionID NATIONAL VARCHAR(36),
      DepartmentID NATIONAL VARCHAR(36),
      EDIID NATIONAL VARCHAR(10),
      EDIActive BOOLEAN,
      EDIQualifier NATIONAL VARCHAR(2),
      EDITestQualifier NATIONAL VARCHAR(2),
      EDITestID NATIONAL VARCHAR(10),
      EDIInboundOrders BOOLEAN,
      EDIOutboundOrders BOOLEAN,
      EDIInboundInvoices BOOLEAN,
      EDIOutboundInvoices BOOLEAN,
      EDIInboundASN BOOLEAN,
      EDIOutboundASN BOOLEAN,
      EDIInboundUPC BOOLEAN,
      EDIOutboundUPC BOOLEAN,
      EDIInboundFinancial BOOLEAN,
      EDIOutboundFinancial BOOLEAN,
      EDIInboundOrderStatus BOOLEAN,
      EDIOutboundOrderStatus BOOLEAN,
      EDIInboundInventory BOOLEAN,
      EDIOutboundInventory BOOLEAN,
      LockedBy NATIONAL VARCHAR(36),
      LockTS DATETIME
   );
   DELETE FROM DelEDISetup;
   INSERT INTO DelEDISetup VALUES(OLD.CompanyID, OLD.DivisionID, OLD.DepartmentID, OLD.EDIID, OLD.EDIActive, OLD.EDIQualifier, OLD.EDITestQualifier, OLD.EDITestID, OLD.EDIInboundOrders, OLD.EDIOutboundOrders, OLD.EDIInboundInvoices, OLD.EDIOutboundInvoices, OLD.EDIInboundASN, OLD.EDIOutboundASN, OLD.EDIInboundUPC, OLD.EDIOutboundUPC, OLD.EDIInboundFinancial, OLD.EDIOutboundFinancial, OLD.EDIInboundOrderStatus, OLD.EDIOutboundOrderStatus, OLD.EDIInboundInventory, OLD.EDIOutboundInventory, OLD.LockedBy, OLD.LockTS);

   BEGIN
-- check for audit triggers switch off

      select   context_info INTO v_Context FROM sysprocesses WHERE spid = CONNECTION_ID();
      IF CAST(v_Context AS CHAR(36)) = N'$$AuditSwitchOff$$' then 
         LEAVE SWL_return;
      end if;

-- declarations
      OPEN cDelete;
-- fetch from each deleting record
      SET NO_DATA = 0;
      FETCH cDelete INTO
      v_TransactionNumber,v_TransactionLineNumber,v_CompanyID,v_DivisionID,v_DepartmentID,
      v_EDIID;
      WHILE NO_DATA = 0 DO
-- insert audit record for each deleting record
         CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber,v_TransactionLineNumber,
         'EDISetup','Deleted','','Deleted');
         SET NO_DATA = 0;
         FETCH cDelete INTO
         v_TransactionNumber,v_TransactionLineNumber,v_CompanyID,v_DivisionID,v_DepartmentID,
         v_EDIID;
      END WHILE;
      CLOSE cDelete;

   END;
END;
 ;;
delimiter ;

-- ----------------------------
--  Records of `edisetup`
-- ----------------------------
BEGIN;
INSERT INTO `edisetup` VALUES ('DEFAULT', 'DEFAULT', 'DEFAULT', '', '0', '', '', '', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', null, null), ('DINOS', 'DEFAULT', 'DEFAULT', '', '0', '', '', '', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', null, null), ('DINOS', 'DEFAULT', 'PAYROLL', '', '0', '', '', '', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', null, null), ('DINOSFUND', 'DEFAULT', 'DEFAULT', '', '0', '', '', '', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', null, null), ('DINOSFUND', 'DEFAULT', 'PAYROLL', '', '0', '', '', '', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', null, null);
COMMIT;

-- ----------------------------
--  Table structure for `edistatements`
-- ----------------------------
DROP TABLE IF EXISTS `edistatements`;
CREATE TABLE `edistatements` (
  `CompanyID` varchar(36) NOT NULL,
  `DivisionID` varchar(36) NOT NULL,
  `DepartmentID` varchar(36) NOT NULL,
  `BankID` varchar(36) NOT NULL,
  `BankTransactionID` varchar(36) NOT NULL,
  `SystemDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `TransactionDate` datetime DEFAULT NULL,
  `TransactionType` varchar(36) DEFAULT NULL,
  `TransactionAccount` varchar(36) DEFAULT NULL,
  `TransactionDescription` varchar(120) DEFAULT NULL,
  `TransactionReference` varchar(120) DEFAULT NULL,
  `TransactionAmount` decimal(19,4) DEFAULT NULL,
  `CurrencyID` varchar(3) DEFAULT NULL,
  `CurrencyExchangeRate` float DEFAULT NULL,
  `TransactionCodeA` varchar(1) DEFAULT NULL,
  `TransactionCodeB` varchar(1) DEFAULT NULL,
  `TransactionCodeC` varchar(1) DEFAULT NULL,
  `BeginningBalance` decimal(19,4) DEFAULT NULL,
  `EndingBalance` decimal(19,4) DEFAULT NULL,
  `DebitCredit` varchar(1) DEFAULT NULL,
  `Cleared` tinyint(1) DEFAULT NULL,
  `Reconciled` tinyint(1) DEFAULT NULL,
  `RelatedDocumentNumber` varchar(36) DEFAULT NULL,
  `Notes` varchar(255) DEFAULT NULL,
  `LockedBy` varchar(36) DEFAULT NULL,
  `LockTS` datetime DEFAULT NULL,
  PRIMARY KEY (`CompanyID`,`DivisionID`,`DepartmentID`,`BankID`,`BankTransactionID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
delimiter ;;
CREATE TRIGGER `EDIStatements_Audit_Insert` AFTER INSERT ON `edistatements` FOR EACH ROW SWL_return:
BEGIN
   DECLARE NO_DATA INT DEFAULT 0;
   DECLARE v_Context VARBINARY(128);
   DECLARE v_TransactionNumber NATIONAL VARCHAR(50);
   DECLARE v_TransactionLineNumber NATIONAL VARCHAR(50);

   DECLARE v_CompanyID NATIONAL VARCHAR(36);
   DECLARE v_DivisionID NATIONAL VARCHAR(36);
   DECLARE v_DepartmentID NATIONAL VARCHAR(36);
   DECLARE v_BankID NATIONAL VARCHAR(36);
   DECLARE v_BankTransactionID NATIONAL VARCHAR(36);

-- inserting records cursor declaration
   DECLARE cInsert CURSOR
   FOR SELECT
   i.BankID
		,i.BankTransactionID

		,i.CompanyID
		,i.DivisionID
		,i.DepartmentID
		,i.BankID
		,i.BankTransactionID

   FROM
   InsEDIStatements i;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET NO_DATA = -2;
   END;
   DECLARE CONTINUE HANDLER FOR NOT FOUND SET NO_DATA = -1;
   CREATE  TEMPORARY TABLE IF NOT EXISTS InsEDIStatements
   (
      CompanyID NATIONAL VARCHAR(36),
      DivisionID NATIONAL VARCHAR(36),
      DepartmentID NATIONAL VARCHAR(36),
      BankID NATIONAL VARCHAR(36),
      BankTransactionID NATIONAL VARCHAR(36),
      SystemDate DATETIME,
      TransactionDate DATETIME,
      TransactionType NATIONAL VARCHAR(36),
      TransactionAccount NATIONAL VARCHAR(36),
      TransactionDescription NATIONAL VARCHAR(120),
      TransactionReference NATIONAL VARCHAR(120),
      TransactionAmount DECIMAL(19,4),
      CurrencyID NATIONAL VARCHAR(3),
      CurrencyExchangeRate FLOAT,
      TransactionCodeA NATIONAL VARCHAR(1),
      TransactionCodeB NATIONAL VARCHAR(1),
      TransactionCodeC NATIONAL VARCHAR(1),
      BeginningBalance DECIMAL(19,4),
      EndingBalance DECIMAL(19,4),
      DebitCredit NATIONAL VARCHAR(1),
      Cleared BOOLEAN,
      Reconciled BOOLEAN,
      RelatedDocumentNumber NATIONAL VARCHAR(36),
      Notes NATIONAL VARCHAR(255),
      LockedBy NATIONAL VARCHAR(36),
      LockTS DATETIME
   );
   DELETE FROM InsEDIStatements;
   INSERT INTO InsEDIStatements VALUES(NEW.CompanyID, NEW.DivisionID, NEW.DepartmentID, NEW.BankID, NEW.BankTransactionID, NEW.SystemDate, NEW.TransactionDate, NEW.TransactionType, NEW.TransactionAccount, NEW.TransactionDescription, NEW.TransactionReference, NEW.TransactionAmount, NEW.CurrencyID, NEW.CurrencyExchangeRate, NEW.TransactionCodeA, NEW.TransactionCodeB, NEW.TransactionCodeC, NEW.BeginningBalance, NEW.EndingBalance, NEW.DebitCredit, NEW.Cleared, NEW.Reconciled, NEW.RelatedDocumentNumber, NEW.Notes, NEW.LockedBy, NEW.LockTS);

   BEGIN
-- check for audit triggers switch off

      select   context_info INTO v_Context FROM sysprocesses WHERE spid = CONNECTION_ID();
      IF CAST(v_Context AS CHAR(36)) = N'$$AuditSwitchOff$$' then 
         LEAVE SWL_return;
      end if;

-- declarations
      OPEN cInsert;
-- fetch from each inserting record
      SET NO_DATA = 0;
      FETCH cInsert INTO
      v_TransactionNumber,v_TransactionLineNumber,v_CompanyID,v_DivisionID,v_DepartmentID,
      v_BankID,v_BankTransactionID;
      WHILE NO_DATA = 0 DO
-- insert audit record for each inserting record
         IF IsGuid(v_TransactionNumber) = 0 then
		
            CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber,v_TransactionLineNumber,
            'EDIStatements','New Record','','New Record');
         end if;
         SET NO_DATA = 0;
         FETCH cInsert INTO
         v_TransactionNumber,v_TransactionLineNumber,v_CompanyID,v_DivisionID,v_DepartmentID,
         v_BankID,v_BankTransactionID;
      END WHILE;
      CLOSE cInsert;

   END;
END;
 ;;
delimiter ;
delimiter ;;
CREATE TRIGGER `EDIStatements_Audit_Update` AFTER UPDATE ON `edistatements` FOR EACH ROW SWL_return:
BEGIN
   DECLARE NO_DATA INT DEFAULT 0;
   DECLARE v_Context VARBINARY(128);
   DECLARE v_TransactionNumber_O NATIONAL VARCHAR(50);
   DECLARE v_TransactionNumber_N NATIONAL VARCHAR(50);
   DECLARE v_TransactionLineNumber NATIONAL VARCHAR(50);

   DECLARE v_CompanyID NATIONAL VARCHAR(36);
   DECLARE v_DivisionID NATIONAL VARCHAR(36);
   DECLARE v_DepartmentID NATIONAL VARCHAR(36);
   DECLARE v_BankID NATIONAL VARCHAR(36);
   DECLARE v_BankTransactionID NATIONAL VARCHAR(36);

   DECLARE v_SystemDate_O NATIONAL VARCHAR(80);
   DECLARE v_SystemDate_N NATIONAL VARCHAR(80);
   DECLARE v_TransactionDate_O NATIONAL VARCHAR(80);
   DECLARE v_TransactionDate_N NATIONAL VARCHAR(80);
   DECLARE v_TransactionType_O NATIONAL VARCHAR(80);
   DECLARE v_TransactionType_N NATIONAL VARCHAR(80);
   DECLARE v_TransactionAccount_O NATIONAL VARCHAR(80);
   DECLARE v_TransactionAccount_N NATIONAL VARCHAR(80);
   DECLARE v_TransactionDescription_O NATIONAL VARCHAR(80);
   DECLARE v_TransactionDescription_N NATIONAL VARCHAR(80);
   DECLARE v_TransactionReference_O NATIONAL VARCHAR(80);
   DECLARE v_TransactionReference_N NATIONAL VARCHAR(80);
   DECLARE v_TransactionAmount_O NATIONAL VARCHAR(80);
   DECLARE v_TransactionAmount_N NATIONAL VARCHAR(80);
   DECLARE v_CurrencyID_O NATIONAL VARCHAR(80);
   DECLARE v_CurrencyID_N NATIONAL VARCHAR(80);
   DECLARE v_CurrencyExchangeRate_O NATIONAL VARCHAR(80);
   DECLARE v_CurrencyExchangeRate_N NATIONAL VARCHAR(80);
   DECLARE v_TransactionCodeA_O NATIONAL VARCHAR(80);
   DECLARE v_TransactionCodeA_N NATIONAL VARCHAR(80);
   DECLARE v_TransactionCodeB_O NATIONAL VARCHAR(80);
   DECLARE v_TransactionCodeB_N NATIONAL VARCHAR(80);
   DECLARE v_TransactionCodeC_O NATIONAL VARCHAR(80);
   DECLARE v_TransactionCodeC_N NATIONAL VARCHAR(80);
   DECLARE v_BeginningBalance_O NATIONAL VARCHAR(80);
   DECLARE v_BeginningBalance_N NATIONAL VARCHAR(80);
   DECLARE v_EndingBalance_O NATIONAL VARCHAR(80);
   DECLARE v_EndingBalance_N NATIONAL VARCHAR(80);
   DECLARE v_DebitCredit_O NATIONAL VARCHAR(80);
   DECLARE v_DebitCredit_N NATIONAL VARCHAR(80);
   DECLARE v_Cleared_O NATIONAL VARCHAR(80);
   DECLARE v_Cleared_N NATIONAL VARCHAR(80);
   DECLARE v_Reconciled_O NATIONAL VARCHAR(80);
   DECLARE v_Reconciled_N NATIONAL VARCHAR(80);
   DECLARE v_RelatedDocumentNumber_O NATIONAL VARCHAR(80);
   DECLARE v_RelatedDocumentNumber_N NATIONAL VARCHAR(80);
   DECLARE v_Notes_O NATIONAL VARCHAR(80);
   DECLARE v_Notes_N NATIONAL VARCHAR(80);
 

-- updating records cursor declaration
   DECLARE cUpdate CURSOR
   FOR SELECT
   d.BankID
		,i.BankID
		,i.BankTransactionID

		,i.CompanyID
		,i.DivisionID
		,i.DepartmentID
		,i.BankID
		,i.BankTransactionID

,CAST(d.SystemDate AS CHAR(80))
,CAST(i.SystemDate AS CHAR(80))
,CAST(d.TransactionDate AS CHAR(80))
,CAST(i.TransactionDate AS CHAR(80))
,CAST(d.TransactionType AS CHAR(80))
,CAST(i.TransactionType AS CHAR(80))
,CAST(d.TransactionAccount AS CHAR(80))
,CAST(i.TransactionAccount AS CHAR(80))
,CAST(d.TransactionDescription AS CHAR(80))
,CAST(i.TransactionDescription AS CHAR(80))
,CAST(d.TransactionReference AS CHAR(80))
,CAST(i.TransactionReference AS CHAR(80))
,CAST(d.TransactionAmount AS CHAR(80))
,CAST(i.TransactionAmount AS CHAR(80))
,CAST(d.CurrencyID AS CHAR(80))
,CAST(i.CurrencyID AS CHAR(80))
,CAST(d.CurrencyExchangeRate AS CHAR(80))
,CAST(i.CurrencyExchangeRate AS CHAR(80))
,CAST(d.TransactionCodeA AS CHAR(80))
,CAST(i.TransactionCodeA AS CHAR(80))
,CAST(d.TransactionCodeB AS CHAR(80))
,CAST(i.TransactionCodeB AS CHAR(80))
,CAST(d.TransactionCodeC AS CHAR(80))
,CAST(i.TransactionCodeC AS CHAR(80))
,CAST(d.BeginningBalance AS CHAR(80))
,CAST(i.BeginningBalance AS CHAR(80))
,CAST(d.EndingBalance AS CHAR(80))
,CAST(i.EndingBalance AS CHAR(80))
,CAST(d.DebitCredit AS CHAR(80))
,CAST(i.DebitCredit AS CHAR(80))
,CAST(d.Cleared AS CHAR(80))
,CAST(i.Cleared AS CHAR(80))
,CAST(d.Reconciled AS CHAR(80))
,CAST(i.Reconciled AS CHAR(80))
,CAST(d.RelatedDocumentNumber AS CHAR(80))
,CAST(i.RelatedDocumentNumber AS CHAR(80))
,CAST(d.Notes AS CHAR(80))
,CAST(i.Notes AS CHAR(80))
 

   FROM
   InsEDIStatements i
   LEFT OUTER JOIN DelEDIStatements d ON
   d.CompanyID = i.CompanyID
   AND d.DivisionID = i.DivisionID
   AND d.DepartmentID = i.DepartmentID
   AND d.BankID = i.BankID
   AND d.BankTransactionID = i.BankTransactionID;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET NO_DATA = -2;
   END;
   DECLARE CONTINUE HANDLER FOR NOT FOUND SET NO_DATA = -1;
   CREATE  TEMPORARY TABLE IF NOT EXISTS InsEDIStatements
   (
      CompanyID NATIONAL VARCHAR(36),
      DivisionID NATIONAL VARCHAR(36),
      DepartmentID NATIONAL VARCHAR(36),
      BankID NATIONAL VARCHAR(36),
      BankTransactionID NATIONAL VARCHAR(36),
      SystemDate DATETIME,
      TransactionDate DATETIME,
      TransactionType NATIONAL VARCHAR(36),
      TransactionAccount NATIONAL VARCHAR(36),
      TransactionDescription NATIONAL VARCHAR(120),
      TransactionReference NATIONAL VARCHAR(120),
      TransactionAmount DECIMAL(19,4),
      CurrencyID NATIONAL VARCHAR(3),
      CurrencyExchangeRate FLOAT,
      TransactionCodeA NATIONAL VARCHAR(1),
      TransactionCodeB NATIONAL VARCHAR(1),
      TransactionCodeC NATIONAL VARCHAR(1),
      BeginningBalance DECIMAL(19,4),
      EndingBalance DECIMAL(19,4),
      DebitCredit NATIONAL VARCHAR(1),
      Cleared BOOLEAN,
      Reconciled BOOLEAN,
      RelatedDocumentNumber NATIONAL VARCHAR(36),
      Notes NATIONAL VARCHAR(255),
      LockedBy NATIONAL VARCHAR(36),
      LockTS DATETIME
   );
   DELETE FROM InsEDIStatements;
   INSERT INTO InsEDIStatements VALUES(NEW.CompanyID, NEW.DivisionID, NEW.DepartmentID, NEW.BankID, NEW.BankTransactionID, NEW.SystemDate, NEW.TransactionDate, NEW.TransactionType, NEW.TransactionAccount, NEW.TransactionDescription, NEW.TransactionReference, NEW.TransactionAmount, NEW.CurrencyID, NEW.CurrencyExchangeRate, NEW.TransactionCodeA, NEW.TransactionCodeB, NEW.TransactionCodeC, NEW.BeginningBalance, NEW.EndingBalance, NEW.DebitCredit, NEW.Cleared, NEW.Reconciled, NEW.RelatedDocumentNumber, NEW.Notes, NEW.LockedBy, NEW.LockTS);

   CREATE  TEMPORARY TABLE IF NOT EXISTS DelEDIStatements
   (
      CompanyID NATIONAL VARCHAR(36),
      DivisionID NATIONAL VARCHAR(36),
      DepartmentID NATIONAL VARCHAR(36),
      BankID NATIONAL VARCHAR(36),
      BankTransactionID NATIONAL VARCHAR(36),
      SystemDate DATETIME,
      TransactionDate DATETIME,
      TransactionType NATIONAL VARCHAR(36),
      TransactionAccount NATIONAL VARCHAR(36),
      TransactionDescription NATIONAL VARCHAR(120),
      TransactionReference NATIONAL VARCHAR(120),
      TransactionAmount DECIMAL(19,4),
      CurrencyID NATIONAL VARCHAR(3),
      CurrencyExchangeRate FLOAT,
      TransactionCodeA NATIONAL VARCHAR(1),
      TransactionCodeB NATIONAL VARCHAR(1),
      TransactionCodeC NATIONAL VARCHAR(1),
      BeginningBalance DECIMAL(19,4),
      EndingBalance DECIMAL(19,4),
      DebitCredit NATIONAL VARCHAR(1),
      Cleared BOOLEAN,
      Reconciled BOOLEAN,
      RelatedDocumentNumber NATIONAL VARCHAR(36),
      Notes NATIONAL VARCHAR(255),
      LockedBy NATIONAL VARCHAR(36),
      LockTS DATETIME
   );
   DELETE FROM DelEDIStatements;
   INSERT INTO DelEDIStatements VALUES(OLD.CompanyID, OLD.DivisionID, OLD.DepartmentID, OLD.BankID, OLD.BankTransactionID, OLD.SystemDate, OLD.TransactionDate, OLD.TransactionType, OLD.TransactionAccount, OLD.TransactionDescription, OLD.TransactionReference, OLD.TransactionAmount, OLD.CurrencyID, OLD.CurrencyExchangeRate, OLD.TransactionCodeA, OLD.TransactionCodeB, OLD.TransactionCodeC, OLD.BeginningBalance, OLD.EndingBalance, OLD.DebitCredit, OLD.Cleared, OLD.Reconciled, OLD.RelatedDocumentNumber, OLD.Notes, OLD.LockedBy, OLD.LockTS);

   BEGIN
-- check for audit triggers switch off

      select   context_info INTO v_Context FROM sysprocesses WHERE spid = CONNECTION_ID();
      IF CAST(v_Context AS CHAR(36)) = N'$$AuditSwitchOff$$' then 
         LEAVE SWL_return;
      end if;

-- declarations
      OPEN cUpdate;
-- fetch from each updating record
      SET NO_DATA = 0;
      FETCH cUpdate INTO
      v_TransactionNumber_O,v_TransactionNumber_N,v_TransactionLineNumber,v_CompanyID,
      v_DivisionID,v_DepartmentID,v_BankID,v_BankTransactionID,v_SystemDate_O,
      v_SystemDate_N,v_TransactionDate_O,v_TransactionDate_N,v_TransactionType_O,
      v_TransactionType_N,v_TransactionAccount_O,v_TransactionAccount_N,
      v_TransactionDescription_O,v_TransactionDescription_N,v_TransactionReference_O,
      v_TransactionReference_N,v_TransactionAmount_O,v_TransactionAmount_N,
      v_CurrencyID_O,v_CurrencyID_N,v_CurrencyExchangeRate_O,
      v_CurrencyExchangeRate_N,v_TransactionCodeA_O,v_TransactionCodeA_N,
      v_TransactionCodeB_O,v_TransactionCodeB_N,v_TransactionCodeC_O,v_TransactionCodeC_N,
      v_BeginningBalance_O,v_BeginningBalance_N,v_EndingBalance_O,
      v_EndingBalance_N,v_DebitCredit_O,v_DebitCredit_N,v_Cleared_O,v_Cleared_N,
      v_Reconciled_O,v_Reconciled_N,v_RelatedDocumentNumber_O,v_RelatedDocumentNumber_N,
      v_Notes_O,v_Notes_N;
      WHILE NO_DATA = 0 DO
-- insert audit records for each changed field

         CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
         'EDIStatements','SystemDate',v_SystemDate_O,v_SystemDate_N);
         CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
         'EDIStatements','TransactionDate',v_TransactionDate_O,
         v_TransactionDate_N);
         CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
         'EDIStatements','TransactionType',v_TransactionType_O,
         v_TransactionType_N);
         CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
         'EDIStatements','TransactionAccount',v_TransactionAccount_O,
         v_TransactionAccount_N);
         CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
         'EDIStatements','TransactionDescription',v_TransactionDescription_O,
         v_TransactionDescription_N);
         CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
         'EDIStatements','TransactionReference',v_TransactionReference_O,
         v_TransactionReference_N);
         CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
         'EDIStatements','TransactionAmount',v_TransactionAmount_O,
         v_TransactionAmount_N);
         CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
         'EDIStatements','CurrencyID',v_CurrencyID_O,v_CurrencyID_N);
         CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
         'EDIStatements','CurrencyExchangeRate',v_CurrencyExchangeRate_O,
         v_CurrencyExchangeRate_N);
         CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
         'EDIStatements','TransactionCodeA',v_TransactionCodeA_O,
         v_TransactionCodeA_N);
         CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
         'EDIStatements','TransactionCodeB',v_TransactionCodeB_O,
         v_TransactionCodeB_N);
         CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
         'EDIStatements','TransactionCodeC',v_TransactionCodeC_O,
         v_TransactionCodeC_N);
         CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
         'EDIStatements','BeginningBalance',v_BeginningBalance_O,
         v_BeginningBalance_N);
         CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
         'EDIStatements','EndingBalance',v_EndingBalance_O,
         v_EndingBalance_N);
         CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
         'EDIStatements','DebitCredit',v_DebitCredit_O,v_DebitCredit_N);
         CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
         'EDIStatements','Cleared',v_Cleared_O,v_Cleared_N);
         CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
         'EDIStatements','Reconciled',v_Reconciled_O,v_Reconciled_N);
         CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
         'EDIStatements','RelatedDocumentNumber',v_RelatedDocumentNumber_O,
         v_RelatedDocumentNumber_N);
         CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber_N,v_TransactionLineNumber,
         'EDIStatements','Notes',v_Notes_O,v_Notes_N);
         SET NO_DATA = 0;
         FETCH cUpdate INTO
         v_TransactionNumber_O,v_TransactionNumber_N,v_TransactionLineNumber,v_CompanyID,
         v_DivisionID,v_DepartmentID,v_BankID,v_BankTransactionID,v_SystemDate_O,
         v_SystemDate_N,v_TransactionDate_O,v_TransactionDate_N,v_TransactionType_O,
         v_TransactionType_N,v_TransactionAccount_O,v_TransactionAccount_N,
         v_TransactionDescription_O,v_TransactionDescription_N,v_TransactionReference_O,
         v_TransactionReference_N,v_TransactionAmount_O,v_TransactionAmount_N,
         v_CurrencyID_O,v_CurrencyID_N,v_CurrencyExchangeRate_O,
         v_CurrencyExchangeRate_N,v_TransactionCodeA_O,v_TransactionCodeA_N,
         v_TransactionCodeB_O,v_TransactionCodeB_N,v_TransactionCodeC_O,v_TransactionCodeC_N,
         v_BeginningBalance_O,v_BeginningBalance_N,v_EndingBalance_O,
         v_EndingBalance_N,v_DebitCredit_O,v_DebitCredit_N,v_Cleared_O,v_Cleared_N,
         v_Reconciled_O,v_Reconciled_N,v_RelatedDocumentNumber_O,v_RelatedDocumentNumber_N,
         v_Notes_O,v_Notes_N;
      END WHILE;
      CLOSE cUpdate;

   END;
END;
 ;;
delimiter ;
delimiter ;;
CREATE TRIGGER `EDIStatements_Audit_Delete` AFTER DELETE ON `edistatements` FOR EACH ROW SWL_return:
BEGIN
   DECLARE NO_DATA INT DEFAULT 0;
   DECLARE v_Context VARBINARY(128);
   DECLARE v_TransactionNumber NATIONAL VARCHAR(50);
   DECLARE v_TransactionLineNumber NATIONAL VARCHAR(50);

   DECLARE v_CompanyID NATIONAL VARCHAR(36);
   DECLARE v_DivisionID NATIONAL VARCHAR(36);
   DECLARE v_DepartmentID NATIONAL VARCHAR(36);
   DECLARE v_BankID NATIONAL VARCHAR(36);
   DECLARE v_BankTransactionID NATIONAL VARCHAR(36);

-- deleting records cursor declaration
   DECLARE cDelete CURSOR
   FOR SELECT
   d.BankID
		,d.BankTransactionID

		,d.CompanyID
		,d.DivisionID
		,d.DepartmentID
		,d.BankID
		,d.BankTransactionID

   FROM
   DelEDIStatements d;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET NO_DATA = -2;
   END;
   DECLARE CONTINUE HANDLER FOR NOT FOUND SET NO_DATA = -1;
   CREATE  TEMPORARY TABLE IF NOT EXISTS DelEDIStatements
   (
      CompanyID NATIONAL VARCHAR(36),
      DivisionID NATIONAL VARCHAR(36),
      DepartmentID NATIONAL VARCHAR(36),
      BankID NATIONAL VARCHAR(36),
      BankTransactionID NATIONAL VARCHAR(36),
      SystemDate DATETIME,
      TransactionDate DATETIME,
      TransactionType NATIONAL VARCHAR(36),
      TransactionAccount NATIONAL VARCHAR(36),
      TransactionDescription NATIONAL VARCHAR(120),
      TransactionReference NATIONAL VARCHAR(120),
      TransactionAmount DECIMAL(19,4),
      CurrencyID NATIONAL VARCHAR(3),
      CurrencyExchangeRate FLOAT,
      TransactionCodeA NATIONAL VARCHAR(1),
      TransactionCodeB NATIONAL VARCHAR(1),
      TransactionCodeC NATIONAL VARCHAR(1),
      BeginningBalance DECIMAL(19,4),
      EndingBalance DECIMAL(19,4),
      DebitCredit NATIONAL VARCHAR(1),
      Cleared BOOLEAN,
      Reconciled BOOLEAN,
      RelatedDocumentNumber NATIONAL VARCHAR(36),
      Notes NATIONAL VARCHAR(255),
      LockedBy NATIONAL VARCHAR(36),
      LockTS DATETIME
   );
   DELETE FROM DelEDIStatements;
   INSERT INTO DelEDIStatements VALUES(OLD.CompanyID, OLD.DivisionID, OLD.DepartmentID, OLD.BankID, OLD.BankTransactionID, OLD.SystemDate, OLD.TransactionDate, OLD.TransactionType, OLD.TransactionAccount, OLD.TransactionDescription, OLD.TransactionReference, OLD.TransactionAmount, OLD.CurrencyID, OLD.CurrencyExchangeRate, OLD.TransactionCodeA, OLD.TransactionCodeB, OLD.TransactionCodeC, OLD.BeginningBalance, OLD.EndingBalance, OLD.DebitCredit, OLD.Cleared, OLD.Reconciled, OLD.RelatedDocumentNumber, OLD.Notes, OLD.LockedBy, OLD.LockTS);

   BEGIN
-- check for audit triggers switch off

      select   context_info INTO v_Context FROM sysprocesses WHERE spid = CONNECTION_ID();
      IF CAST(v_Context AS CHAR(36)) = N'$$AuditSwitchOff$$' then 
         LEAVE SWL_return;
      end if;

-- declarations
      OPEN cDelete;
-- fetch from each deleting record
      SET NO_DATA = 0;
      FETCH cDelete INTO
      v_TransactionNumber,v_TransactionLineNumber,v_CompanyID,v_DivisionID,v_DepartmentID,
      v_BankID,v_BankTransactionID;
      WHILE NO_DATA = 0 DO
-- insert audit record for each deleting record
         CALL AuditInsert(v_CompanyID,v_DivisionID,v_DepartmentID,'EDI',v_TransactionNumber,v_TransactionLineNumber,
         'EDIStatements','Deleted','','Deleted');
         SET NO_DATA = 0;
         FETCH cDelete INTO
         v_TransactionNumber,v_TransactionLineNumber,v_CompanyID,v_DivisionID,v_DepartmentID,
         v_BankID,v_BankTransactionID;
      END WHILE;
      CLOSE cDelete;

   END;
END;
 ;;
delimiter ;

-- ----------------------------
--  Table structure for `edistatementshistory`
-- ----------------------------
DROP TABLE IF EXISTS `edistatementshistory`;
CREATE TABLE `edistatementshistory` (
  `CompanyID` varchar(36) NOT NULL,
  `DivisionID` varchar(36) NOT NULL,
  `DepartmentID` varchar(36) NOT NULL,
  `BankID` varchar(36) NOT NULL,
  `BankTransactionID` varchar(36) NOT NULL,
  `SystemDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `TransactionDate` datetime DEFAULT NULL,
  `TransactionType` varchar(36) DEFAULT NULL,
  `TransactionAccount` varchar(36) DEFAULT NULL,
  `TransactionDescription` varchar(120) DEFAULT NULL,
  `TransactionReference` varchar(120) DEFAULT NULL,
  `TransactionAmount` decimal(19,4) DEFAULT NULL,
  `CurrencyID` varchar(3) DEFAULT NULL,
  `CurrencyExchangeRate` float DEFAULT NULL,
  `TransactionCodeA` varchar(1) DEFAULT NULL,
  `TransactionCodeB` varchar(1) DEFAULT NULL,
  `TransactionCodeC` varchar(1) DEFAULT NULL,
  `BeginningBalance` decimal(19,4) DEFAULT NULL,
  `EndingBalance` decimal(19,4) DEFAULT NULL,
  `DebitCredit` varchar(1) DEFAULT NULL,
  `Cleared` tinyint(1) DEFAULT NULL,
  `Reconciled` tinyint(1) DEFAULT NULL,
  `RelatedDocumentNumber` varchar(36) DEFAULT NULL,
  `Notes` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`CompanyID`,`DivisionID`,`DepartmentID`,`BankID`,`BankTransactionID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


