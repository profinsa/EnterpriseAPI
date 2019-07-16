CREATE PROCEDURE RptListAccessPermissions (v_CompanyID NATIONAL VARCHAR(36), 
 v_DivisionID NATIONAL VARCHAR(36), 
 v_DepartmentID NATIONAL VARCHAR(36)) BEGIN











   SELECT
	
	
	
   EmployeeID,
	SecurityLevel,
	OEView, 
	
	
	
	
	ARView,
	
	
	
	POView,
	
	
	
	
	
	APView,
	
	
	
	
	
	GLView,
	
	
	
	
	
	
	
	EMView
	
	
	
	
	
	
	
	
	
	
	
	
	
   FROM AccessPermissions
   WHERE CompanyID = v_CompanyID and DivisionID = v_DivisionID and DepartmentID = v_DepartmentID;
END