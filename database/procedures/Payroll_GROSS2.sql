CREATE PROCEDURE Payroll_GROSS2 (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_EmployeeID NATIONAL VARCHAR(36),
	v_Check NATIONAL VARCHAR(36),
	INOUT v_GROSS REAL ,INOUT SWP_Ret_Value INT) SWL_return:
BEGIN
















   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);

   DECLARE v_OT REAL;
   DECLARE v_Periods INT;
   DECLARE v_Regular REAL;
   DECLARE v_HourlyRate DECIMAL(19,4);
   DECLARE v_Salary DECIMAL(19,4);
   DECLARE v_OvertimeRate DECIMAL(19,4);
   DECLARE v_Amount DECIMAL(19,4);
   DECLARE v_Commission FLOAT;

   DECLARE v_CompanyCurrencyID NATIONAL VARCHAR(3);
   DECLARE v_ErrorID INT;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
   END;
   SET @SWV_Error = 0;
   SET v_Regular = 0;

   START TRANSACTION; 

   SET v_HourlyRate = IFNULL((SELECT  HourlyRate
   FROM
   PayrollEmployeesDetail
   WHERE
   UPPER(CompanyID) = UPPER(v_CompanyID)
   AND UPPER(DivisionID) = UPPER(v_DivisionID)
   AND UPPER(DepartmentID) = UPPER(v_DepartmentID)
   AND UPPER(EmployeeID) = UPPER(v_EmployeeID) LIMIT 1),0);

   SET v_Salary = IFNULL((SELECT  Salary
   FROM
   PayrollEmployeesDetail
   WHERE
   UPPER(CompanyID) = UPPER(v_CompanyID)
   AND UPPER(DivisionID) = UPPER(v_DivisionID)
   AND UPPER(DepartmentID) = UPPER(v_DepartmentID)
   AND UPPER(EmployeeID) = UPPER(v_EmployeeID) LIMIT 1),0);

   SET v_OvertimeRate = IFNULL((SELECT  OvertimeRate
   FROM
   PayrollEmployeesDetail
   WHERE
   UPPER(CompanyID) = UPPER(v_CompanyID)
   AND UPPER(DivisionID) = UPPER(v_DivisionID)
   AND UPPER(DepartmentID) = UPPER(v_DepartmentID)
   AND UPPER(EmployeeID) = UPPER(v_EmployeeID) LIMIT 1),0);

   SET v_Amount = IFNULL((SELECT  Amount
   FROM
   PayrollEmployeesDetail
   WHERE
   UPPER(CompanyID) = UPPER(v_CompanyID)
   AND UPPER(DivisionID) = UPPER(v_DivisionID)
   AND UPPER(DepartmentID) = UPPER(v_DepartmentID)
   AND UPPER(EmployeeID) = UPPER(v_EmployeeID) LIMIT 1),0);

   SET @SWV_Error = 0;
   SET v_ReturnStatus = Payroll_Periods(v_CompanyID,v_DivisionID,v_DepartmentID,v_EmployeeID,v_Periods);
   IF v_ReturnStatus <> 0 OR @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Call enterprise.Payroll_Periods failed';
      ROLLBACK;

      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payroll_GROSS',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'EmployeeID',v_EmployeeID);
      SET SWP_Ret_Value = -1;
   end if;

   SET @SWV_Error = 0;
   SET v_ReturnStatus = Payroll_Regular(v_CompanyID,v_DivisionID,v_DepartmentID,v_EmployeeID,v_Regular,v_OT);
   IF v_ReturnStatus <> 0 OR @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Call enterprise.Payroll_Regular failed';
      ROLLBACK;

      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payroll_GROSS',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'EmployeeID',v_EmployeeID);
      SET SWP_Ret_Value = -1;
   end if;

   SET v_Commission = 0;
   SET @SWV_Error = 0;
   SET v_ReturnStatus = Payroll_Commissions_Calc(v_CompanyID,v_DivisionID,v_DepartmentID,v_EmployeeID,v_Commission);
   IF v_ReturnStatus <> 0 OR @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Call enterprise.Payroll_Commissions_Calc failed';
      ROLLBACK;

      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payroll_GROSS',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'EmployeeID',v_EmployeeID);
      SET SWP_Ret_Value = -1;
   end if;

   select   IFNULL(CurrencyID,N'') INTO v_CompanyCurrencyID FROM Companies WHERE CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID   LIMIT 1;


   if (v_Check = 'Manual') then
      SET v_GROSS = fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,(v_Regular*v_HourlyRate)+(v_OT*v_OvertimeRate)+v_Amount+v_Commission, 
      v_CompanyCurrencyID);
   else
      SET v_GROSS = fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,(v_Salary/v_Periods)+(v_Regular*v_HourlyRate)+(v_OT*v_OvertimeRate)+v_Commission,v_CompanyCurrencyID);
   end if;



   COMMIT;
   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;








   ROLLBACK;

   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payroll_GROSS',v_ErrorMessage,
   v_ErrorID);

   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'EmployeeID',v_EmployeeID);

   SET SWP_Ret_Value = -1;
END