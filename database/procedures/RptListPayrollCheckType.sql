CREATE PROCEDURE RptListPayrollCheckType (v_CompanyID NATIONAL VARCHAR(36), 
 v_DivisionID NATIONAL VARCHAR(36), 
 v_DepartmentID NATIONAL VARCHAR(36)) BEGIN












   SELECT
	
	
	
   CheckTypeID,
	CheckTypeDescription
   FROM PayrollCheckType
   WHERE CompanyID = v_CompanyID and DivisionID = v_DivisionID and DepartmentID = v_DepartmentID;
END