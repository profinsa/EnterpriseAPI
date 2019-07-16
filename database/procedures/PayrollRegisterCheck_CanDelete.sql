CREATE PROCEDURE PayrollRegisterCheck_CanDelete (v_CompanyID NATIONAL VARCHAR(36), 
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_Key NATIONAL VARCHAR(36),
	INOUT v_CanDelete BOOLEAN ,INOUT SWP_Ret_Value INT) BEGIN














   select   ~ Posted INTO v_CanDelete FROM PayrollRegister WHERE
   CompanyID = v_CompanyID AND DivisionID = v_DivisionID AND DepartmentID = v_DepartmentID AND
   PayrollID = v_Key;

   
SET SWP_Ret_Value = 0;
END