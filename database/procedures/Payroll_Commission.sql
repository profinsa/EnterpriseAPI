CREATE PROCEDURE Payroll_Commission (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_EmployeeID NATIONAL VARCHAR(36),
	INOUT v_CommissionPerc FLOAT ,INOUT SWP_Ret_Value INT) BEGIN























   SET v_CommissionPerc = IFNULL((SELECT  CommissionPerc
   FROM         PayrollEmployees
   WHERE
   UPPER(CompanyID) = UPPER(v_CompanyID)
   AND UPPER(DivisionID) = UPPER(v_DivisionID)
   AND UPPER(DepartmentID) = UPPER(v_DepartmentID)
   AND UPPER(EmployeeID) = UPPER(v_EmployeeID) LIMIT 1),0);


   SET SWP_Ret_Value = 0;
END