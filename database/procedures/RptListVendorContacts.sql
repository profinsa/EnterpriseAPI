CREATE PROCEDURE RptListVendorContacts (v_CompanyID NATIONAL VARCHAR(36), 
 v_DivisionID NATIONAL VARCHAR(36), 
 v_DepartmentID NATIONAL VARCHAR(36)) BEGIN











   SELECT
	
	
	
   VendorID,
	ContactID,
	ContactTypeID,
	ContactDescription,
	ContactLastName,
	ContactFirstName,
	ContactAddress1, 
	
	
	ContactCity,
	ContactState,
	ContactZip,
	ContactPhone
	
	
	
	
	
	
	
   FROM VendorContacts
   WHERE CompanyID = v_CompanyID and DivisionID = v_DivisionID and DepartmentID = v_DepartmentID;
END