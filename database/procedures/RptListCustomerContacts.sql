CREATE PROCEDURE RptListCustomerContacts (v_CompanyID NATIONAL VARCHAR(36), 
 v_DivisionID NATIONAL VARCHAR(36), 
 v_DepartmentID NATIONAL VARCHAR(36)) BEGIN











   SELECT
	
	
	
   CustomerID,
	ContactID,
	ContactType,
	ContactDescription,
	ContactLastName,
	ContactFirstName,
	ContactTitle,
	
	
	
	ContactIndustry,
	
	
	
	ContactCity,
	ContactState,
	ContactZip,
	ContactPhone
	
	
	
	
	
	
	
	
	
	
   FROM CustomerContacts
   WHERE CompanyID = v_CompanyID and DivisionID = v_DivisionID and DepartmentID = v_DepartmentID;
END