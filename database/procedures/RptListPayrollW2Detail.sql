CREATE PROCEDURE RptListPayrollW2Detail (v_CompanyID NATIONAL VARCHAR(36), 
 v_DivisionID NATIONAL VARCHAR(36), 
 v_DepartmentID NATIONAL VARCHAR(36)) BEGIN











   SELECT
	
	
	
   EmployeeID,
	W2Year,
	W2ControlNumber,
	EmployeeName,
	EmployeeSSNumber,
	EmployeeAddress1, 
	
	EmployeeCity,
	EmployeeState,
	EmployeeZip
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
   FROM PayrollW2Detail
   WHERE CompanyID = v_CompanyID and DivisionID = v_DivisionID and DepartmentID = v_DepartmentID;
END