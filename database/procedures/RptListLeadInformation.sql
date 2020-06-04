CREATE PROCEDURE RptListLeadInformation (v_CompanyID NATIONAL VARCHAR(36), 
 v_DivisionID NATIONAL VARCHAR(36), 
 v_DepartmentID NATIONAL VARCHAR(36)) BEGIN











   SELECT
	
	
	
   LeadID,
	LeadLastName,
	LeadFirstName,
	LeadSalutation,
	LeadAddress1, 
	
	
	LeadCity,
	LeadState,
	LeadZip, 
	
	LeadEmail,
	
	
	
	
	
	
	
	
	
	
	Hot
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
   FROM LeadInformation
   WHERE CompanyID = v_CompanyID and DivisionID = v_DivisionID and DepartmentID = v_DepartmentID;
END