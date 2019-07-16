CREATE PROCEDURE Payroll_CreateOne (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_EmployeeID NATIONAL VARCHAR(36),
	v_PayrollID NATIONAL VARCHAR(36),
	v_CheckTypeID NATIONAL VARCHAR(36),
	v_PayrollDate DATETIME,
	v_StartDate DATETIME,
	v_EndDate DATETIME,INOUT SWP_Ret_Value INT) SWL_return:
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
   INSERT INTO PayrollRegister(CompanyID,
			DivisionID,
			DepartmentID,
			PayrollID,
			EmployeeID,
			PayrollDate,
			PayPeriodStartDate,
			PayPeriodEndDate,
			PaidThrough,
			CheckTypeID,
			PayrollCheckDate,
			SystemDate,
			CheckNumber,
			PreTax,
			YTDGross,
			Gross,
			AGI,
			FICA,
			FICAER,
			FIT,
			FUTA,
			StateTax,
			CountyTax,
			CityTax,
			FICAMed,
			SUTA,
			SIT,
			SDI,
			LUI,
			Additions,
			Commission,
			Deductions,
			NetPay,
			Voided,
			Reconciled,
			Printed,
			RegularHours,
			OvertimeHours,
			OvertimeRate,
			HourlyRate,
			Amount)
	VALUES(v_CompanyID,
			v_DivisionID,
			v_DepartmentID,
			v_PayrollID,
			v_EmployeeID,
			v_PayrollDate,
			v_StartDate,
			v_EndDate,
			NULL, 
			v_CheckTypeID,
			NULL, 
			CURRENT_TIMESTAMP,
			NULL, 
			0, 
			0, 
			0, 
			0, 
			0, 
			0, 
			0, 
			0, 
			0, 
			0, 
			0, 
			0, 
			0, 
			0, 
			0, 
			0, 
			0, 
			0, 
			0, 
			0, 
			0, 
			0, 
			0, 
			0, 
			0, 
			0, 
			0, 
			0 
		);
	
   IF @SWV_Error <> 0 then
	
      SET v_ErrorMessage = 'Insert into PayrollRegister failed';
      ROLLBACK;

      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payroll_CreateOne',v_ErrorMessage,
      v_ErrorID);
      SET SWP_Ret_Value = -1;
   end if;

	
   SET @SWV_Error = 0;
   INSERT INTO PayrollRegisterDetail(CompanyID,
			DivisionID,
			DepartmentID,
			PayrollID,
			PayrollItemID,
			EmployeeID,
			Description,
			Basis,
			Type,
			YTDMax,
			Minimum,
			WageHigh,
			WageLow,
			ItemAmount,
			ItemPercent,
			PercentAmount,
			TotalAmount,
			ApplyItem,
			EmployerItemAmount,
			EmployerItemPercent,
			EmployerPercentAmount,
			EmployerTotalAmount,
			Employer,
			GLEmployeeCreditAccount,
			GLEmployerDebitAccount,
			GLEmployerCreditAccount)
   SELECT
   v_CompanyID,
			v_DivisionID,
			v_DepartmentID,
			v_PayrollID,
			PayrollItemID,
			EmployeeID,
			PayrollItemDescription,
			Basis,
			PayrollItemTypeID,
			YTDMaximum,
			Minimum,
			WageHigh,
			WageLow,
			ItemAmount,
			ItemPercent,
			PercentAmount,
			TotalAmount,
			ApplyItem,
			EmployerItemAmount,
			EmployerItemPercent,
			EmployerPercentAmount,
			EmployerTotalAmount,
			Employer,
			GLEmployeeCreditAccount,
			GLEmployerDebitAccount,
			GLEmployerCreditAccount
   FROM
   PayrollItems
   WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   EmployeeID = v_EmployeeID AND
   ApplyItem = 1;
		
   IF @SWV_Error <> 0 then
	
      SET v_ErrorMessage = 'Insert into PayrollRegisterDetail failed';
      ROLLBACK;

      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payroll_CreateOne',v_ErrorMessage,
      v_ErrorID);
      SET SWP_Ret_Value = -1;
   end if;
		


   COMMIT;
   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;








   ROLLBACK;

   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payroll_CreateOne',v_ErrorMessage,
   v_ErrorID);


   SET SWP_Ret_Value = -1;
END