-- DDL script for table ErrorLog for MySQL
-- Generated by (c) Ispirer SQLWays 4.0 Build 219 Licensed to STFB
-- Timestamp: Tue Jul 28 16:09:01 2015

-- Create table statement


CREATE TABLE ErrorLog
(
   CompanyID NATIONAL VARCHAR(36) NOT NULL,
   DivisionID NATIONAL VARCHAR(36) NOT NULL,
   DepartmentID NATIONAL VARCHAR(36) NOT NULL,
   ErrorID INT NOT NULL  AUTO_INCREMENT,
   EmployeeID NATIONAL VARCHAR(36),
   ErrorDate DATETIME,
   ErrorTime DATETIME,
   ScreenName NATIONAL VARCHAR(50),
   ModuleName NATIONAL VARCHAR(50),
   ErrorCode INT,
   ErrorMessage NATIONAL VARCHAR(255),
   ProcedureName NATIONAL VARCHAR(50),
   CallTime DATETIME,
   Error NATIONAL VARCHAR(200),
   LockedBy NATIONAL VARCHAR(36),
   LockTS DATETIME,
   PRIMARY KEY(ErrorID,CompanyID,DivisionID,DepartmentID)
)  AUTO_INCREMENT = 1;

