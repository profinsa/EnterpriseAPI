CREATE PROCEDURE spHelpNewPosts (v_CompanyID NATIONAL VARCHAR(36), 
 v_DivisionID NATIONAL VARCHAR(36), 
 v_DepartmentID NATIONAL VARCHAR(36), 
 v_EmployeeID NATIONAL VARCHAR(36)) BEGIN






   SELECT
   MessageName,
	MessageText
   FROM HelpMessageBoard
   WHERE CompanyID = v_CompanyID and DivisionID = v_DivisionID and DepartmentID = v_DepartmentID
   and IFNULL(Valid,0) = 0;
END