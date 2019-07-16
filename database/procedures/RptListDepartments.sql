CREATE PROCEDURE RptListDepartments (v_CompanyID NATIONAL VARCHAR(36), 
 v_DivisionID NATIONAL VARCHAR(36), 
 v_DepartmentID NATIONAL VARCHAR(36)) BEGIN











   SELECT
	
	
   DepartmentID,
	DepartmentName,
	DepartmentDescription,
	DepartmentAddress1, 
	
	DepartmentCity,
	DepartmentState,
	DepartmentZip, 
	
	
	
	
	
	DepartmentNotes
   FROM Departments
   WHERE CompanyID = v_CompanyID and DivisionID = v_DivisionID and DepartmentID = v_DepartmentID;
END