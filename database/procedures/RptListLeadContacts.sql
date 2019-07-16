CREATE PROCEDURE RptListLeadContacts (v_CompanyID NATIONAL VARCHAR(36), 
 v_DivisionID NATIONAL VARCHAR(36), 
 v_DepartmentID NATIONAL VARCHAR(36)) BEGIN











   SELECT
	
	
	
   LeadID,
	ContactID,
	LeadType,
	ContactDescription,
	ContactLastName,
	ContactFirstName, 
	
	
	
	ContactAddress1, 
	
	
	ContactCity,
	ContactState,
	ContactZip
	
	
	
	
	
	
	
	
	
	
	
	
	
	
   FROM LeadContacts
   WHERE CompanyID = v_CompanyID and DivisionID = v_DivisionID and DepartmentID = v_DepartmentID;
END