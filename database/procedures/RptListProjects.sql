CREATE PROCEDURE RptListProjects (v_CompanyID NATIONAL VARCHAR(36), 
 v_DivisionID NATIONAL VARCHAR(36), 
 v_DepartmentID NATIONAL VARCHAR(36)) BEGIN














   SELECT
	
	
	
   ProjectID,
	ProjectName, 
	
	
	
	ProjectStartDate,
	ProjectCompleteDate, 
	
	
	fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,ProjectEstRevenue,N'') AS ProjectEstRevenue,
	fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,ProjectEstCost,N'') AS ProjectEstCost,
	fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,ProjectActualRevenue,N'') AS ProjectActualRevenue,
	fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,ProjectActualCost,N'') AS ProjectActualCost, 
	
	
	
	ProjectOpen
   FROM Projects
   WHERE CompanyID = v_CompanyID and DivisionID = v_DivisionID and DepartmentID = v_DepartmentID;
END