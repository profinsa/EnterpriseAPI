CREATE PROCEDURE RptListTerms (v_CompanyID NATIONAL VARCHAR(36), 
 v_DivisionID NATIONAL VARCHAR(36), 
 v_DepartmentID NATIONAL VARCHAR(36)) BEGIN











   SELECT
	
	
	
   TermsID,
	TermsDescription,
	NetDays,
	DiscountPercent,
	DiscountDays
   FROM Terms
   WHERE CompanyID = v_CompanyID and DivisionID = v_DivisionID and DepartmentID = v_DepartmentID;
END