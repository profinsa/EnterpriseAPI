CREATE PROCEDURE RptListPayrollSetup (v_CompanyID NATIONAL VARCHAR(36), 
 v_DivisionID NATIONAL VARCHAR(36), 
 v_DepartmentID NATIONAL VARCHAR(36)) BEGIN










   SELECT
	
	
	
   FederalTaxIDNumber,
	State,
	StateTaxIDNumber,
	County,
	CountyTaxIDNumber,
	CityName,
	CityTaxIDNumber, 
	
	
	
	
	
	
	
	
	
	
	CreatePayroll,
	PayCommissions
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
   FROM PayrollSetup
   WHERE CompanyID = v_CompanyID and DivisionID = v_DivisionID and DepartmentID = v_DepartmentID;
END