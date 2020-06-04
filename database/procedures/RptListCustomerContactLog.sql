CREATE PROCEDURE RptListCustomerContactLog (v_CompanyID NATIONAL VARCHAR(36), 
 v_DivisionID NATIONAL VARCHAR(36), 
 v_DepartmentID NATIONAL VARCHAR(36)) BEGIN











   SELECT
	
	
	
   CustomerID,
	ContactID,
	ContactLogID,
	ContactDate,
	ContactCallStartTime,
	ContactCallEndTime,
	ContactDesctiption
   FROM CustomerContactLog
   WHERE CompanyID = v_CompanyID and DivisionID = v_DivisionID and DepartmentID = v_DepartmentID;
END