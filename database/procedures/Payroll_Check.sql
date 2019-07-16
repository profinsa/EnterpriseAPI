CREATE PROCEDURE Payroll_Check (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_EmployeeID NATIONAL VARCHAR(36),
	v_PayrollID NATIONAL VARCHAR(36),INOUT SWP_Ret_Value INT) SWL_return:
BEGIN







   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);

   DECLARE v_CheckNumber NATIONAL VARCHAR(36);
   DECLARE v_GLEmployeeCreditAccount NATIONAL VARCHAR(36);
   DECLARE v_CurrencyID NATIONAL VARCHAR(3);


   DECLARE v_ErrorID INT;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
   END;
   SET @SWV_Error = 0;
   START TRANSACTION;


   SET @SWV_Error = 0;
   SET v_ReturnStatus = GetNextEntityID(v_CompanyID,v_DivisionID,v_DepartmentID,'NextPayrollCheckNumber',v_CheckNumber);
   IF v_ReturnStatus <> 0 OR @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Call enterprise.GetNextEntityID failed';
      ROLLBACK;
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payroll_Check',v_ErrorMessage,
      v_ErrorID);
      SET SWP_Ret_Value = -1;
   end if;


   SET @SWV_Error = 0;
   SET v_ReturnStatus = Payroll_Post(v_CompanyID,v_DivisionID,v_DepartmentID,v_EmployeeID,v_PayrollID,v_CheckNumber);
   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then

      SET v_ErrorMessage = 'Payroll_Post call failed';
      ROLLBACK;
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payroll_Check',v_ErrorMessage,
      v_ErrorID);
      SET SWP_Ret_Value = -1;
   end if;

   select   IFNULL(GLWagesPayrollAccount,0) INTO v_GLEmployeeCreditAccount FROM
   PayrollSetup WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID;

   select   CurrencyID INTO v_CurrencyID FROM
   Companies WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID;



   INSERT INTO
   PayrollChecks(CompanyID,
		DivisionID,
		DepartmentID,
		PayrollID,
		EmployeeID,
		PayrollCheckDate,
		StartDate,
		EndDate,
		CheckPrinted,
		Amount,
		GLEmployeeCreditAccount,
		CheckNumber,
		CheckTypeID,
		CurrencyID,
		Apply)
   SELECT
   v_CompanyID,
	v_DivisionID,
	v_DepartmentID,
	v_PayrollID,
	v_EmployeeID,
	CURRENT_TIMESTAMP,
	PayPeriodStartDate,
	PayPeriodEndDate,
	1,
	NetPay,
	v_GLEmployeeCreditAccount,
	v_CheckNumber,
	CheckTypeID,
	v_CurrencyID,
	1
   FROM
   PayrollRegister
   WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   EmployeeID = v_EmployeeID AND
   PayrollID = v_PayrollID;
	

   COMMIT;

   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;








   ROLLBACK;

   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payroll_Check',v_ErrorMessage,
   v_ErrorID);

   SET SWP_Ret_Value = -1;
END