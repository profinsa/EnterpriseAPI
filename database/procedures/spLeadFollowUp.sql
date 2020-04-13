CREATE PROCEDURE spLeadFollowUp (v_CompanyID NATIONAL VARCHAR(36), 
 v_DivisionID NATIONAL VARCHAR(36), 
 v_DepartmentID NATIONAL VARCHAR(36),
 v_EmployeeID NATIONAL VARCHAR(36)) BEGIN







   SELECT
   LeadID,
	LeadEmail
   FROM LeadInformation
   WHERE CompanyID = v_CompanyID and DivisionID = v_DivisionID and DepartmentID = v_DepartmentID and EmployeeID = v_EmployeeID
   and LastFollowUp < TIMESTAMPADD(day,-30,CURRENT_TIMESTAMP)
   and LOWER(LeadID) <> 'default'
   and	IFNULL(ConvertedToCustomer,0) = 0;
END