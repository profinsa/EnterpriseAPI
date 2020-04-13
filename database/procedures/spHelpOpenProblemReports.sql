CREATE PROCEDURE spHelpOpenProblemReports (v_CompanyID NATIONAL VARCHAR(36), 
 v_DivisionID NATIONAL VARCHAR(36), 
 v_DepartmentID NATIONAL VARCHAR(36), 
 v_EmployeeID NATIONAL VARCHAR(36)) BEGIN






   SELECT
   CustomerId,
	ProblemShortDescription
   FROM HelpProblemReport
   WHERE CompanyID = v_CompanyID and DivisionID = v_DivisionID and DepartmentID = v_DepartmentID
   and IFNULL(ProblemFixed,0) = 0;
END