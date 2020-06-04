CREATE PROCEDURE Payroll_CalcGross (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_EmployeeID NATIONAL VARCHAR(36),
	v_PayrollID NATIONAL VARCHAR(36),INOUT SWP_Ret_Value INT) SWL_return:
BEGIN














   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);

   DECLARE v_HourlyRate DECIMAL(19,4);
   DECLARE v_OvertimeRate DECIMAL(19,4);
   DECLARE v_RegularHours FLOAT;
   DECLARE v_OvertimeHours FLOAT;
   DECLARE v_GROSS DECIMAL(19,4);
   DECLARE v_Salary DECIMAL(19,4);
   DECLARE v_Commission DECIMAL(19,4);
   DECLARE v_LastHours FLOAT;
   DECLARE v_OTConversion FLOAT;
   DECLARE v_Periods FLOAT;
   DECLARE v_OTAfter FLOAT;
   DECLARE v_PayFrequency NATIONAL VARCHAR(50);


   DECLARE v_CompanyCurrencyID NATIONAL VARCHAR(3);
   DECLARE v_ErrorID INT;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
   END;
   SET @SWV_Error = 0;
   START TRANSACTION;

   select   IFNULL(PayFrequency,'weekly'), IFNULL(Salary,0), IFNULL(HourlyRate,0), IFNULL(OvertimeRate,0), IFNULL(LastHours,0) INTO v_PayFrequency,v_Salary,v_HourlyRate,v_OvertimeRate,v_LastHours FROM
   PayrollEmployeesDetail WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND EmployeeID = v_EmployeeID;


   select   IFNULL(OTAfter,0) INTO v_OTAfter FROM
   PayrollSetup WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID;



   IF LOWER(v_PayFrequency) = 'biweekly' then
		
      SET v_OTConversion = v_OTAfter*2;
   ELSE
      SET v_OTConversion = v_OTAfter;
   end if;


	
   IF v_LastHours > v_OTConversion then
		
      SET v_OvertimeHours = v_LastHours -v_OTConversion;
      SET v_RegularHours = v_OTConversion;
   ELSE
      SET v_RegularHours = v_LastHours;
      SET v_OvertimeHours = 0;
   end if;


 	
   SET v_Commission = 0;
   SET @SWV_Error = 0;
   SET v_ReturnStatus = Payroll_Commissions_Calc(v_CompanyID,v_DivisionID,v_DepartmentID,v_EmployeeID,v_Commission);
   IF v_ReturnStatus <> 0 OR @SWV_Error <> 0 then
	
      SET v_ErrorMessage = 'Call enterprise.Payroll_Commissions_Calc failed';
      ROLLBACK;

      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payroll_CalcGross',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'EmployeeID',v_EmployeeID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PayrollID',v_PayrollID);
      SET SWP_Ret_Value = -1;
   end if;
	
	


   SET v_Periods = CASE LOWER(v_PayFrequency)
   WHEN 'weekly' THEN 52
   WHEN 'biweekly' THEN 26
   WHEN 'semimonthly' THEN 24
   WHEN 'monthly' THEN 12
   WHEN 'yearly' THEN 1
   ELSE 0
   END;

   select   IFNULL(CurrencyID,N'') INTO v_CompanyCurrencyID FROM Companies WHERE CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID   LIMIT 1;


   SET v_GROSS = fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,(v_Salary/v_Periods)+(v_RegularHours*v_HourlyRate)+(v_OvertimeHours*v_OvertimeRate)+v_Commission, 
   v_CompanyCurrencyID);


   UPDATE
   PayrollRegister
   SET
   Gross = v_GROSS,RegularHours = v_RegularHours,OvertimeHours = v_OvertimeHours,
   OvertimeRate = v_OvertimeRate,HourlyRate = v_HourlyRate
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

   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payroll_CalcGross',v_ErrorMessage,
   v_ErrorID);

   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'EmployeeID',v_EmployeeID);
   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PayrollID',v_PayrollID);

   SET SWP_Ret_Value = -1;
END