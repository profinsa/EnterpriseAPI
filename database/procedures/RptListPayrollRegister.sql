CREATE PROCEDURE RptListPayrollRegister (v_CompanyID NATIONAL VARCHAR(36), 
 v_DivisionID NATIONAL VARCHAR(36), 
 v_DepartmentID NATIONAL VARCHAR(36)) BEGIN















   SELECT
	
	
	
   PayrollID,
	EmployeeID,
	PayrollDate,
	PayPeriodStartDate,
	PayPeriodEndDate,
	CheckTypeID,
	PayrollCheckDate, 
	
	CheckNumber,
	 fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,Gross,N'') AS Gross,
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	NetPay
	
	
	
	
	
	
	
	
   FROM PayrollRegister
   WHERE CompanyID = v_CompanyID and DivisionID = v_DivisionID and DepartmentID = v_DepartmentID;
END