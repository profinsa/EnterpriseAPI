CREATE PROCEDURE spHelpCompanyNews (v_CompanyID NATIONAL VARCHAR(36), 
 v_DivisionID NATIONAL VARCHAR(36), 
 v_DepartmentID NATIONAL VARCHAR(36), 
 v_EmployeeID NATIONAL VARCHAR(36)) BEGIN






   SELECT
   NewsDate,
	NewsMessage
   FROM HelpNewsBoard
   WHERE CompanyID = v_CompanyID and DivisionID = v_DivisionID and DepartmentID = v_DepartmentID
   ORDER BY NewsDate;
END