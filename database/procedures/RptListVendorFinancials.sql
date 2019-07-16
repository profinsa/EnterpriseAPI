CREATE PROCEDURE RptListVendorFinancials (v_CompanyID NATIONAL VARCHAR(36), 
 v_DivisionID NATIONAL VARCHAR(36), 
 v_DepartmentID NATIONAL VARCHAR(36)) BEGIN











   CALL VendorFinancials_ReCalc(v_CompanyID,v_DivisionID,v_DepartmentID);
 
   SELECT
	
	
	
   VendorID, 
	
	
	
	
	
	
	
	
	
	TotalAP,
	CurrentAPBalance,
	Under30,
	Over30,
	Over60,
	Over90,
	Over120,
	Over150,
	Over180
	
	
	
	
	
	
	
   FROM VendorFinancials
   WHERE CompanyID = v_CompanyID and DivisionID = v_DivisionID and DepartmentID = v_DepartmentID;
END