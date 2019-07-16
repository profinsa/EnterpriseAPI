CREATE PROCEDURE RptListPayrollEmployees (v_CompanyID NATIONAL VARCHAR(36), 
 v_DivisionID NATIONAL VARCHAR(36), 
 v_DepartmentID NATIONAL VARCHAR(36)) BEGIN











   SELECT
	
	
	
   EmployeeID,
	EmployeeTypeID,
	EmployeeName,
	ActiveYN, 
	
	
	
	
	
	
	
	
	
	
	EmployeeUserName,
	EmployeePassword,
	
	
	
	
	
	
	Notes
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
   FROM PayrollEmployees
   WHERE CompanyID = v_CompanyID and DivisionID = v_DivisionID and DepartmentID = v_DepartmentID;
END