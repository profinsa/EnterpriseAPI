CREATE PROCEDURE Payroll_CalcForEmployee (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_EmployeeID NATIONAL VARCHAR(36),
	v_PayrollDate DATETIME,
	v_StartDate DATETIME,
	v_EndDate DATETIME,

	v_IsCreate BOOLEAN,

	INOUT v_PreTax DECIMAL(19,4) ,
	INOUT v_YTDGross DECIMAL(19,4) ,
	INOUT v_Gross DECIMAL(19,4) ,
	INOUT v_AGI DECIMAL(19,4) ,
	INOUT v_FICA DECIMAL(19,4) ,
	INOUT v_FICAER DECIMAL(19,4) ,
	INOUT v_FIT DECIMAL(19,4) ,
	INOUT v_FUTA DECIMAL(19,4) ,
	INOUT v_StateTax DECIMAL(19,4) ,
	INOUT v_CountyTax DECIMAL(19,4) ,
	INOUT v_CityTax DECIMAL(19,4) ,
	INOUT v_FICAMed DECIMAL(19,4) ,
	INOUT v_SUTA DECIMAL(19,4) ,
	INOUT v_SIT DECIMAL(19,4) ,
	INOUT v_SDI DECIMAL(19,4) ,
	INOUT v_LUI DECIMAL(19,4) ,
	INOUT v_Additions DECIMAL(19,4) ,
	INOUT v_Commission DECIMAL(19,4) ,
	INOUT v_Deductions DECIMAL(19,4) ,
	INOUT v_NetPay DECIMAL(19,4) ,
	INOUT v_RegularHours FLOAT ,
	INOUT v_OvertimeHours FLOAT ,
	INOUT v_OvertimeRate DECIMAL(19,4) ,
	INOUT v_HourlyRate DECIMAL(19,4) ,INOUT SWP_Ret_Value INT) SWL_return:
BEGIN






   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);

   DECLARE v_CheckTypeID NATIONAL VARCHAR(36);
   DECLARE v_PayrollID NATIONAL VARCHAR(36);
   DECLARE v_ErrorID INT;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
   END;
   SET @SWV_Error = 0;
   SET v_CheckTypeID = '';

   START TRANSACTION; 

   IF v_IsCreate = 1 then
		
      SET @SWV_Error = 0;
      SET v_ReturnStatus = GetNextEntityID(v_CompanyID,v_DivisionID,v_DepartmentID,'NextPayrollNumber',v_PayrollID);
      IF v_ReturnStatus <> 0 OR @SWV_Error <> 0 then
			
         SET v_ErrorMessage = 'Call enterprise.GetNextEntityID failed';
         ROLLBACK;

         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payroll_CalcForEmployee',v_ErrorMessage,
         v_ErrorID);
         SET SWP_Ret_Value = -1;
      end if;
   ELSE
      SET v_PayrollID = CAST(UUID() AS CHAR(36));
   end if;



   SET @SWV_Error = 0;
   SET v_ReturnStatus = Payroll_CalcCurrent2(v_CompanyID,v_DivisionID,v_DepartmentID,v_EmployeeID,v_PayrollID,v_CheckTypeID,
   v_PayrollDate,v_StartDate,v_EndDate);
	
   IF v_ReturnStatus <> 0 OR @SWV_Error <> 0 then
	
      SET v_ErrorMessage = 'Call enterprise.Payroll_CalcCurrent failed';
      ROLLBACK;

      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payroll_CalcForEmployee',v_ErrorMessage,
      v_ErrorID);
      SET SWP_Ret_Value = -1;
   end if;




   select   IFNULL(Gross,0), IFNULL(PreTax,0), IFNULL(YTDGross,0), IFNULL(AGI,0), IFNULL(FICA,0), IFNULL(FICAER,0), IFNULL(FIT,0), IFNULL(FUTA,0), IFNULL(StateTax,0), IFNULL(CountyTax,0), IFNULL(CityTax,0), IFNULL(FICAMed,0), IFNULL(SUTA,0), IFNULL(SIT,0), IFNULL(SDI,0), IFNULL(LUI,0), IFNULL(Additions,0), IFNULL(Commission,0), IFNULL(Deductions,0), IFNULL(NetPay,0), IFNULL(RegularHours,0), IFNULL(OvertimeHours,0), IFNULL(OvertimeRate,0), IFNULL(HourlyRate,0) INTO v_Gross,v_PreTax,v_YTDGross,v_AGI,v_FICA,v_FICAER,v_FIT,v_FUTA,v_StateTax,
   v_CountyTax,v_CityTax,v_FICAMed,v_SUTA,v_SIT,v_SDI,v_LUI,v_Additions,
   v_Commission,v_Deductions,v_NetPay,v_RegularHours,v_OvertimeHours,v_OvertimeRate,
   v_HourlyRate FROM
   PayrollRegister WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   EmployeeID = v_EmployeeID AND
   PayrollID = v_PayrollID;



   IF v_IsCreate = 0 then
	
      DELETE FROM
      PayrollRegister
      WHERE
      CompanyID = v_CompanyID AND
      DivisionID = v_DivisionID AND
      DepartmentID = v_DepartmentID AND
      EmployeeID = v_EmployeeID AND
      PayrollID = v_PayrollID;
   end if;

   BEGIN
      COMMIT;
   END;


   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;








   ROLLBACK;

   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payroll_CalcForEmployee',v_ErrorMessage,
   v_ErrorID);


   SET SWP_Ret_Value = -1;
END