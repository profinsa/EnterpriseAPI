CREATE PROCEDURE RptPayrollCheckItem (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_PayrollID NATIONAL VARCHAR(36),INOUT SWP_Ret_Value INT) BEGIN





   SELECT * FROM
   PayrollRegisterDetail
   WHERE
   PayrollRegisterDetail.CompanyID = v_CompanyID AND
   PayrollRegisterDetail.DivisionID = v_DivisionID AND
   PayrollRegisterDetail.DepartmentID = v_DepartmentID AND
   PayrollRegisterDetail.PayrollID = v_PayrollID;


   SET SWP_Ret_Value = 0;
END