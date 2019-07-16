CREATE PROCEDURE RptListPayrollRegisterDetail (v_CompanyID NATIONAL VARCHAR(36), 
 v_DivisionID NATIONAL VARCHAR(36), 
 v_DepartmentID NATIONAL VARCHAR(36)) BEGIN














   SELECT
	
	
	
   PayrollID,
	PayrollItemID,
	EmployeeID,
	Description,
	Basis, 
	
	
	
	
	
	ItemAmount,
	ItemPercent, 
	
	fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,TotalAmount,N'') AS TotalAmount
	
	
	
	
	
	
	
	
	
   FROM PayrollRegisterDetail
   WHERE CompanyID = v_CompanyID and DivisionID = v_DivisionID and DepartmentID = v_DepartmentID;
END