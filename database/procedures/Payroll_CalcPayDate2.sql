CREATE PROCEDURE Payroll_CalcPayDate2 (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_EmployeeID NATIONAL VARCHAR(36),
	v_LastPayDate DATETIME,
	INOUT v_PayrollDate DATETIME ,
	INOUT v_PayPeriodStartDate DATETIME ,
	INOUT v_PayPeriodEndDate DATETIME ,INOUT SWP_Ret_Value INT) SWL_return:
BEGIN













   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);

   DECLARE v_Periods INT;
   DECLARE v_Days INT;

   DECLARE v_ErrorID INT;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
   END;
   SET @SWV_Error = 0;
   START TRANSACTION;

   SET @SWV_Error = 0;
   SET v_ReturnStatus = Payroll_Periods(v_CompanyID,v_DivisionID,v_DepartmentID,v_EmployeeID,v_Periods);
   IF v_ReturnStatus <> 0 OR @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Call enterprise.Payroll_Periods failed';
      ROLLBACK;

      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payroll_CalcPayDate',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'EmployeeID',v_EmployeeID);
      SET SWP_Ret_Value = -1;
   end if;

   select   IFNULL(PayPeriodStartDate,0), IFNULL(PayPeriodEndDate,0) INTO v_PayPeriodStartDate,v_PayPeriodEndDate FROM
   PayrollRegister WHERE
   UPPER(CompanyID) = UPPER(v_CompanyID)
   AND UPPER(DivisionID) = UPPER(v_DivisionID)
   AND UPPER(DepartmentID) = UPPER(v_DepartmentID)
   AND UPPER(EmployeeID) = UPPER(v_EmployeeID);


   IF(v_Periods = 52) then

      SET v_PayrollDate = TIMESTAMPADD(day,7,v_LastPayDate);
      SET v_PayPeriodStartDate = TIMESTAMPADD(day,7,v_PayPeriodStartDate);
      SET v_PayPeriodEndDate = TIMESTAMPADD(day,7,v_PayPeriodEndDate);
   ELSE
      IF(v_Periods = 26) then
	
         SET v_PayrollDate = TIMESTAMPADD(day,14,v_LastPayDate);
         SET v_PayPeriodStartDate = TIMESTAMPADD(day,14,v_PayPeriodStartDate);
         SET v_PayPeriodEndDate = TIMESTAMPADD(day,14,v_PayPeriodEndDate);
      ELSE
         IF(v_Periods = 12) then
		
            SET v_PayrollDate = TIMESTAMPADD(month,1,v_LastPayDate);
            SET v_PayPeriodStartDate = TIMESTAMPADD(month,1,v_PayPeriodStartDate);
            SET v_PayPeriodEndDate = TIMESTAMPADD(month,1,v_PayPeriodEndDate);
         ELSE
            IF(v_Periods = 1) then
				
               SET v_PayrollDate = TIMESTAMPADD(year,1,v_LastPayDate);
               SET v_PayPeriodStartDate = TIMESTAMPADD(year,1,v_PayPeriodStartDate);
               SET v_PayPeriodEndDate = TIMESTAMPADD(year,1,v_PayPeriodEndDate);
            end if;
         end if;
      end if;
   end if;
						



   COMMIT;
   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;








   ROLLBACK;

   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payroll_CalcPayDate',v_ErrorMessage,
   v_ErrorID);

   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'EmployeeID',v_EmployeeID);

   SET SWP_Ret_Value = -1;
END