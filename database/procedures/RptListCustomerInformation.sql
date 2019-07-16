CREATE PROCEDURE RptListCustomerInformation (v_CompanyID NATIONAL VARCHAR(36), 
 v_DivisionID NATIONAL VARCHAR(36), 
 v_DepartmentID NATIONAL VARCHAR(36)) BEGIN











   SELECT
	
	
	
   CustomerID,
	AccountStatus,
	CustomerName,
	CustomerAddress1, 
	
	
	CustomerCity,
	CustomerState,
	CustomerZip, 
	
	
	
	
	
	
	
	
	CustomerTypeID, 
	
	
	
	TermsID, 
	
	EmployeeID
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
   FROM CustomerInformation
   WHERE CompanyID = v_CompanyID and DivisionID = v_DivisionID and DepartmentID = v_DepartmentID;
END