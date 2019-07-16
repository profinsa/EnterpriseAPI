CREATE PROCEDURE Payroll_SaveEmployeeDetails (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_EmployeeID NATIONAL VARCHAR(36),

	v_PayType NATIONAL VARCHAR(50),
	v_PayFrequency NATIONAL VARCHAR(50),
	v_Salary DECIMAL(19,4),
	v_HourlyRate DECIMAL(19,4),
	v_CommissionCalc INT,
	v_ComissionPerc FLOAT,
	v_OvertimeRate DECIMAL(19,4),
	v_LastHours REAL,INOUT SWP_Ret_Value INT) SWL_return:
BEGIN










   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);


   DECLARE v_ErrorID INT;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
   END;
   SET @SWV_Error = 0;
   START TRANSACTION;

   SET @SWV_Error = 0;
   UPDATE
   PayrollEmployeesDetail
   SET
   PayType = v_PayType,PayFrequency = v_PayFrequency,Salary = v_Salary,HourlyRate = v_HourlyRate,
   CommissionCalc = v_CommissionCalc,ComissionPerc = v_ComissionPerc,
   OvertimeRate = v_OvertimeRate,LastHours = v_LastHours
   WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   EmployeeID = v_EmployeeID;
	
   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'UPDATE PayrollEmployeesDetail failed';
      ROLLBACK;

      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payroll_SaveEmployeeDetails',
      v_ErrorMessage,v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'EmployeeID',v_EmployeeID);
      SET SWP_Ret_Value = -1;
      LEAVE SWL_return;
   end if;
		

   COMMIT;
   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;








   ROLLBACK;

   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payroll_SaveEmployeeDetails',
   v_ErrorMessage,v_ErrorID);

   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'EmployeeID',v_EmployeeID);

   SET SWP_Ret_Value = -1;
   LEAVE SWL_return;













END