CREATE PROCEDURE RptListARTransactionTypes (v_CompanyID NATIONAL VARCHAR(36), 
 v_DivisionID NATIONAL VARCHAR(36), 
 v_DepartmentID NATIONAL VARCHAR(36)) BEGIN











   SELECT
                
	
	
   TransactionTypeID,
	TransactionDescription
   FROM ARTransactionTypes
   WHERE CompanyID = v_CompanyID and DivisionID = v_DivisionID and DepartmentID = v_DepartmentID;
END