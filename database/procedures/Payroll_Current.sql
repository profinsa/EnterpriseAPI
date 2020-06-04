CREATE PROCEDURE Payroll_Current (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),INOUT SWP_Ret_Value INT) SWL_return:
BEGIN














   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);

   DECLARE v_Check NATIONAL VARCHAR(36);
   DECLARE v_SystemDate DATETIME;
   DECLARE v_SystemDateChar VARCHAR(12);
   DECLARE v_CheckTypeID NATIONAL VARCHAR(36);
   DECLARE v_PayrollCheckDate DATETIME;
   DECLARE v_CheckNumber NATIONAL VARCHAR(20);
   DECLARE v_YTDGross DECIMAL(19,4);
   DECLARE v_Amount DECIMAL(19,4);
   DECLARE v_Commission DECIMAL(19,4);
   DECLARE v_OvertimeHours FLOAT;
   DECLARE v_RegularHours FLOAT;
   DECLARE v_OvertimeRate DECIMAL(19,4);
   DECLARE v_HourlyRate DECIMAL(19,4);
   DECLARE v_EmployeeID NATIONAL VARCHAR(36);
   DECLARE v_PayrollID NATIONAL VARCHAR(36);
   DECLARE v_PayFrequency NATIONAL VARCHAR(50);
   DECLARE v_LastPayDate DATETIME;
   DECLARE v_PayrollDate DATETIME;
   DECLARE v_PayPeriodStartDate DATETIME;
   DECLARE v_PayPeriodEndDate DATETIME;
   DECLARE v_GROSSDED DECIMAL(19,4); 
   DECLARE v_AGIDED DECIMAL(19,4);
   DECLARE v_PRETAXDED DECIMAL(19,4);
   DECLARE v_FIT DECIMAL(19,4);
   DECLARE v_STATETAX DECIMAL(19,4); 
   DECLARE v_LocalTax DECIMAL(19,4); 
   DECLARE v_FicaEE DECIMAL(19,4); 
   DECLARE v_FICAER DECIMAL(19,4); 
   DECLARE v_FICAMed DECIMAL(19,4); 
   DECLARE v_FUTA DECIMAL(19,4); 
   DECLARE v_SUI DECIMAL(19,4); 
   DECLARE v_ADDITIONS DECIMAL(19,4); 
   DECLARE v_NETADDITIONS DECIMAL(19,4); 
   DECLARE v_DEDUCTIONS DECIMAL(19,4); 
   DECLARE v_AGI DECIMAL(19,4);
   DECLARE v_GROSS DECIMAL(19,4);
   DECLARE v_Net DECIMAL(19,4);
   DECLARE v_Regular FLOAT;
   DECLARE v_CheckType VARCHAR(36);
   DECLARE v_FIND_CHECK BOOLEAN;
   DECLARE v_Employee VARCHAR(36);

   DECLARE v_ErrorID INT;
   DECLARE NO_DATA INT DEFAULT 0;
   DECLARE PayrollEmployeeTem CURSOR FOR
   SELECT 
   EmployeeID,
	PayrollID,
	CheckTypeID,
	PayrollCheckDate,
	StartDate,
	EndDate
	
	
   FROM PayrollChecks
   WHERE     
   UPPER(CompanyID) = UPPER(v_CompanyID)
   AND UPPER(DivisionID) = UPPER(v_DivisionID)
   AND UPPER(DepartmentID) = UPPER(v_DepartmentID)
   AND IFNULL(Apply,0) = 0;
	
   DECLARE PayrollEmployeecur CURSOR FOR
   SELECT 
   EmployeeID,
	PayrollID,
	CheckTypeID,
	PayrollCheckDate,
	StartDate,
	EndDate
	
	
   FROM tt_PayrollChecksTmp
   WHERE     
   UPPER(CompanyID) = UPPER(v_CompanyID)
   AND UPPER(DivisionID) = UPPER(v_DivisionID)
   AND UPPER(DepartmentID) = UPPER(v_DepartmentID);
	
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
      SET NO_DATA = -2;
   END;
   DECLARE CONTINUE HANDLER FOR NOT FOUND SET NO_DATA = -1;
   SET @SWV_Error = 0;
   SET v_FIND_CHECK = 0;

   START TRANSACTION;





   CREATE TEMPORARY TABLE tt_PayrollChecksTmp  
   (
      CompanyID NATIONAL VARCHAR(36) NOT NULL,
      DivisionID NATIONAL VARCHAR(36) NOT NULL,
      DepartmentID NATIONAL VARCHAR(36) NOT NULL,
      PayrollID NATIONAL VARCHAR(36) NOT NULL,
      EmployeeID NATIONAL VARCHAR(36) NOT NULL,
      PayrollCheckDate DATETIME,
      StartDate DATETIME,
      EndDate DATETIME,
      CheckPrinted BOOLEAN,
      Amount DECIMAL(19,4),
      GLEmployeeCreditAccount NATIONAL VARCHAR(36),
      CheckNumber NATIONAL VARCHAR(20),
      CheckTypeID NATIONAL VARCHAR(36),
      CurrencyID NATIONAL VARCHAR(3)
   );


   OPEN PayrollEmployeeTem;

   SET NO_DATA = 0;
   FETCH PayrollEmployeeTem INTO v_EmployeeID,v_PayrollID,v_Check,v_PayrollDate,v_PayPeriodStartDate,v_PayPeriodEndDate;
   WHILE NO_DATA = 0 DO
      INSERT INTO tt_PayrollChecksTmp(CompanyID,
			DivisionID,
			DepartmentID,
			PayrollID,
			EmployeeID,
			CheckTypeID,
			PayrollCheckDate,
			StartDate,
			EndDate)
		VALUES(v_CompanyID,
			v_DivisionID,
			v_DepartmentID,
			v_PayrollID,
			v_EmployeeID,
			v_Check,
			v_PayrollDate,
			v_PayPeriodStartDate,
			v_PayPeriodEndDate);
	
      SET NO_DATA = 0;
      FETCH PayrollEmployeeTem INTO v_EmployeeID,v_PayrollID,v_Check,v_PayrollDate,v_PayPeriodStartDate,v_PayPeriodEndDate;
   END WHILE;
   CLOSE PayrollEmployeeTem;




   OPEN PayrollEmployeecur;

   SET NO_DATA = 0;
   FETCH PayrollEmployeecur INTO v_EmployeeID,v_PayrollID,v_Check,v_PayrollDate,v_PayPeriodStartDate,v_PayPeriodEndDate;
   WHILE NO_DATA = 0 DO
      select   IFNULL(Amount,0), IFNULL(HourlyRate,0), IFNULL(OvertimeRate,0), IFNULL(YearToDateGross,0) INTO v_Amount,v_HourlyRate,v_OvertimeRate,v_YTDGross FROM PayrollEmployeesDetail WHERE
      UPPER(CompanyID) = UPPER(v_CompanyID)
      AND UPPER(DivisionID) = UPPER(v_DivisionID)
      AND UPPER(DepartmentID) = UPPER(v_DepartmentID)
      AND UPPER(EmployeeID) = UPPER(v_EmployeeID);
      SET v_SystemDateChar = DATE_FORMAT(CURRENT_TIMESTAMP,'%m/%d/%y');
      SET v_SystemDate = CAST(v_SystemDateChar AS DATETIME);

	

      SET @SWV_Error = 0;
      SET v_ReturnStatus = Payroll_Commission2(v_CompanyID,v_DivisionID,v_DepartmentID,v_EmployeeID,v_Commission);
      IF v_ReturnStatus <> 0 OR @SWV_Error <> 0 then
	
         SET v_ErrorMessage = 'Call Payroll_Commission failed';
		
         CLOSE PayrollEmployeecur;

         ROLLBACK;




         DROP TEMPORARY TABLE IF EXISTS tt_PayrollChecksTmp;
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payroll_Current',v_ErrorMessage,
         v_ErrorID);
         SET SWP_Ret_Value = -1;
      end if;

	

      SET @SWV_Error = 0;
      SET v_ReturnStatus = Payroll_Regular(v_CompanyID,v_DivisionID,v_DepartmentID,v_EmployeeID,v_RegularHours,v_OvertimeHours);
      IF v_ReturnStatus <> 0 OR @SWV_Error <> 0 then
	
         SET v_ErrorMessage = 'Call Payroll_Regular failed';
		
         CLOSE PayrollEmployeecur;

         ROLLBACK;




         DROP TEMPORARY TABLE IF EXISTS tt_PayrollChecksTmp;
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payroll_Current',v_ErrorMessage,
         v_ErrorID);
         SET SWP_Ret_Value = -1;
      end if;
      IF (v_PayrollDate IS NULL) OR (v_PayPeriodStartDate IS NULL) OR (v_PayPeriodEndDate IS NULL) then
	
         select   IFNULL(LastPayDate,0) INTO v_LastPayDate FROM PayrollEmployeesDetail WHERE
         UPPER(CompanyID) = UPPER(v_CompanyID)
         AND UPPER(DivisionID) = UPPER(v_DivisionID)
         AND UPPER(DepartmentID) = UPPER(v_DepartmentID)
         AND UPPER(EmployeeID) = UPPER(v_EmployeeID);
         select   IFNULL(PayrollDate,0) INTO v_PayrollDate FROM PayrollRegister WHERE
         UPPER(CompanyID) = UPPER(v_CompanyID)
         AND UPPER(DivisionID) = UPPER(v_DivisionID)
         AND UPPER(DepartmentID) = UPPER(v_DepartmentID)
         AND UPPER(EmployeeID) = UPPER(v_EmployeeID); 	

	

         SET @SWV_Error = 0;
         SET v_ReturnStatus = Payroll_CalcPayDate(v_CompanyID,v_DivisionID,v_DepartmentID,v_EmployeeID,v_LastPayDate,v_PayrollDate,
         v_PayPeriodStartDate,v_PayPeriodEndDate);
         IF v_ReturnStatus <> 0 OR @SWV_Error <> 0 then
		
            SET v_ErrorMessage = 'Call Payroll_CalcPayDate failed';
			
            CLOSE PayrollEmployeecur;

            ROLLBACK;




            DROP TEMPORARY TABLE IF EXISTS tt_PayrollChecksTmp;
            CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payroll_Current',v_ErrorMessage,
            v_ErrorID);
            SET SWP_Ret_Value = -1;
         end if;
      end if;
      SET @SWV_Error = 0;
      INSERT INTO PayrollRegister(CompanyID,
		DivisionID,
		DepartmentID,
		PayrollID,
		EmployeeID,
		PayrollDate,
		PayPeriodStartDate,
		PayPeriodEndDate,
		CheckTypeID)
	VALUES(v_CompanyID,
		v_DivisionID,
		v_DepartmentID,
		v_PayrollID,
		v_EmployeeID,
		v_PayrollDate,
		v_PayPeriodStartDate,
		v_PayPeriodEndDate,
		v_Check);
	
      IF @SWV_Error <> 0 then
	
         SET v_ErrorMessage = 'Insert into PayrollRegister failed';
		
         CLOSE PayrollEmployeecur;

         ROLLBACK;




         DROP TEMPORARY TABLE IF EXISTS tt_PayrollChecksTmp;
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payroll_Current',v_ErrorMessage,
         v_ErrorID);
         SET SWP_Ret_Value = -1;
      end if;

	

      SET @SWV_Error = 0;
      SET v_ReturnStatus = Payroll_GROSS(v_CompanyID,v_DivisionID,v_DepartmentID,v_EmployeeID,v_Check,v_GROSS);
      IF v_ReturnStatus <> 0 OR @SWV_Error <> 0 then
	
         SET v_ErrorMessage = 'Call enterprise.Payroll_GROSS failed';
		
         CLOSE PayrollEmployeecur;

         ROLLBACK;




         DROP TEMPORARY TABLE IF EXISTS tt_PayrollChecksTmp;
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payroll_Current',v_ErrorMessage,
         v_ErrorID);
         SET SWP_Ret_Value = -1;
      end if;
      SET v_GROSSDED = 0;
      SET v_AGIDED = 0;
      SET v_PRETAXDED = 0;
      SET v_FIT = 0;
      SET v_STATETAX = 0;
      SET v_LocalTax = 0;
      SET v_FicaEE = 0;
      SET v_FICAER = 0;
      SET v_FUTA = 0;
      SET v_SUI = 0;
      SET v_ADDITIONS = 0;
      SET v_NETADDITIONS = 0;
      SET v_DEDUCTIONS = 0;
      SET v_AGI = v_GROSS;
      SET v_Net = 0;
      SET @SWV_Error = 0;
      UPDATE PayrollRegister
      SET
      PreTax = v_PRETAXDED,Gross = v_GROSS,AGI = v_AGI,StateTax = v_STATETAX,CityTax = v_LocalTax,
      Additions = v_ADDITIONS,Deductions = v_DEDUCTIONS,NetPay = v_Net,
      Amount =	v_Amount,HourlyRate = v_HourlyRate,OvertimeRate = v_OvertimeRate,
      YTDGross = v_YTDGross,SystemDate = v_SystemDate,Commission = v_Commission,RegularHours = v_RegularHours,
      OvertimeHours = v_OvertimeHours
      WHERE
      UPPER(CompanyID) = UPPER(v_CompanyID)
      AND UPPER(DivisionID) = UPPER(v_DivisionID)
      AND UPPER(DepartmentID) = UPPER(v_DepartmentID)
      AND UPPER(EmployeeID) = UPPER(v_EmployeeID)
      AND UPPER(PayrollID) = UPPER(v_PayrollID);
      IF @SWV_Error <> 0 then
	
         SET v_ErrorMessage = 'UPDATE PayrollRegister failed';
		
         CLOSE PayrollEmployeecur;

         ROLLBACK;




         DROP TEMPORARY TABLE IF EXISTS tt_PayrollChecksTmp;
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payroll_Current',v_ErrorMessage,
         v_ErrorID);
         SET SWP_Ret_Value = -1;
      end if;

	

      SET @SWV_Error = 0;
      SET v_ReturnStatus = Payroll_CALC2(v_CompanyID,v_DivisionID,v_DepartmentID,v_EmployeeID,v_PayrollID,v_Check);
      IF v_ReturnStatus <> 0 OR @SWV_Error <> 0 then
	
         SET v_ErrorMessage = 'Call enterprise.Payroll_CALC failed';
		
         CLOSE PayrollEmployeecur;

         ROLLBACK;




         DROP TEMPORARY TABLE IF EXISTS tt_PayrollChecksTmp;
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payroll_Current',v_ErrorMessage,
         v_ErrorID);
         SET SWP_Ret_Value = -1;
      end if;
      SET @SWV_Error = 0;
      SET v_ReturnStatus = Payroll_Basis_GROSS2(v_CompanyID,v_DivisionID,v_DepartmentID,v_EmployeeID,v_PayrollID,v_Check);
      IF v_ReturnStatus <> 0 OR @SWV_Error <> 0 then
	
         SET v_ErrorMessage = 'Call enterprise.Payroll_Basis_GROSS failed';
		
         CLOSE PayrollEmployeecur;

         ROLLBACK;




         DROP TEMPORARY TABLE IF EXISTS tt_PayrollChecksTmp;
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payroll_Current',v_ErrorMessage,
         v_ErrorID);
         SET SWP_Ret_Value = -1;
      end if;
      select   IFNULL(Gross,0), IFNULL(NetPay,0), IFNULL(AGI,0), IFNULL(FICA,0), IFNULL(FIT,0), IFNULL(FICAMed,0), IFNULL(FUTA,0), IFNULL(SUTA,0), IFNULL(Commission,0), IFNULL(RegularHours,0) INTO v_GROSS,v_Net,v_AGI,v_FicaEE,v_FIT,v_FICAMed,v_FUTA,v_SUI,v_Commission,
      v_Regular FROM PayrollRegister WHERE
      UPPER(CompanyID) = UPPER(v_CompanyID)
      AND UPPER(DivisionID) = UPPER(v_DivisionID)
      AND UPPER(DepartmentID) = UPPER(v_DepartmentID)
      AND UPPER(EmployeeID) = UPPER(v_EmployeeID);
      UPDATE PayrollEmployeesDetail
      SET
      LastGross = v_GROSS,LastAGI = v_AGI,LastFICA = v_FicaEE,LastFIT = v_FIT,LastFICAMed = v_FICAMed,
      LastFUTA = v_FUTA,LastSUTA = v_SUI,LastCommissionAmount = v_Commission,
      LastHours = v_Regular
      WHERE
      UPPER(CompanyID) = UPPER(v_CompanyID)
      AND UPPER(DivisionID) = UPPER(v_DivisionID)
      AND UPPER(DepartmentID) = UPPER(v_DepartmentID)
      AND UPPER(EmployeeID) = UPPER(v_EmployeeID); 	



      SET @SWV_Error = 0;
      UPDATE PayrollChecks
      SET
      Amount = v_Net,Apply = 1
			
			
      WHERE
      UPPER(CompanyID) = UPPER(v_CompanyID)
      AND UPPER(DivisionID) = UPPER(v_DivisionID)
      AND UPPER(DepartmentID) = UPPER(v_DepartmentID)
      AND UPPER(EmployeeID) = UPPER(v_EmployeeID)
      AND UPPER(PayrollID) = UPPER(v_PayrollID);
      IF @SWV_Error <> 0 then

         SET v_ErrorMessage = 'UPDATE PayrollEmployeesDetail failed';
		
         CLOSE PayrollEmployeecur;

         ROLLBACK;




         DROP TEMPORARY TABLE IF EXISTS tt_PayrollChecksTmp;
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payroll_Current',v_ErrorMessage,
         v_ErrorID);
         SET SWP_Ret_Value = -1;
      end if;
      SET NO_DATA = 0;
      FETCH PayrollEmployeecur INTO v_EmployeeID,v_PayrollID,v_Check,v_PayrollDate,v_PayPeriodStartDate,v_PayPeriodEndDate;
   END WHILE;

   CLOSE PayrollEmployeecur;



   COMMIT;
   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;









   CLOSE PayrollEmployeecur;


   ROLLBACK;




   DROP TEMPORARY TABLE IF EXISTS tt_PayrollChecksTmp;

   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payroll_Current',v_ErrorMessage,
   v_ErrorID);

   SET SWP_Ret_Value = -1;
END