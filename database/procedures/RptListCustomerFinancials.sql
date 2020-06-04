CREATE PROCEDURE RptListCustomerFinancials (v_CompanyID NATIONAL VARCHAR(36), 
 v_DivisionID NATIONAL VARCHAR(36), 
 v_DepartmentID NATIONAL VARCHAR(36)) BEGIN











   CALL CustomerFinancials_ReCalc2(v_CompanyID,v_DivisionID,v_DepartmentID);
 
   SELECT
	
	
	
   CustomerID, 
	
	
	
	
	
	
	
	
	
	
	TotalAR,
	CurrentARBalance,
	Under30,
	Over30,
	Over60,
	Over90,
	Over120,
	Over150,
	Over180
	
	
	
	
	
	
	
	
	
	
	
	
	
   FROM CustomerFinancials
   WHERE CompanyID = v_CompanyID and DivisionID = v_DivisionID and DepartmentID = v_DepartmentID;
END