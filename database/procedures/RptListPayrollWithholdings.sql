CREATE PROCEDURE RptListPayrollWithholdings (v_CompanyID NATIONAL VARCHAR(36), 
 v_DivisionID NATIONAL VARCHAR(36), 
 v_DepartmentID NATIONAL VARCHAR(36)) BEGIN














   SELECT
	
	
	
   Period,
	fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,OverAmnt,N'') AS OverAmnt,
	fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,NotOver,N'') AS NotOver,
	TaxBracket,
	fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,Cumulative,N'') AS Cumulative,
	WithholdingStatus,
	fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,Allowance,N'') AS Allowance,
	PayrollYear
   FROM PayrollWithholdings
   WHERE CompanyID = v_CompanyID and DivisionID = v_DivisionID and DepartmentID = v_DepartmentID;
END