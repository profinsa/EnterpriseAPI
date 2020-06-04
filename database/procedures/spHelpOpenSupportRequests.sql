CREATE PROCEDURE spHelpOpenSupportRequests (v_CompanyID NATIONAL VARCHAR(36), 
 v_DivisionID NATIONAL VARCHAR(36), 
 v_DepartmentID NATIONAL VARCHAR(36), 
 v_EmployeeID NATIONAL VARCHAR(36)) BEGIN






   SELECT
   CustomerId,
	SupportQuestion
   FROM HelpSupportRequest
   WHERE CompanyID = v_CompanyID and DivisionID = v_DivisionID and DepartmentID = v_DepartmentID
   and IFNULL(SupportApproved,0) = 0;
END