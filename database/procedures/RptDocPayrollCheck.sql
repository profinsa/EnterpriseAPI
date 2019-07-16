CREATE PROCEDURE RptDocPayrollCheck (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_PayrollID NATIONAL VARCHAR(36)) BEGIN












   SELECT * FROM
   PayrollRegister
   WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   PayrollID = v_PayrollID;
END