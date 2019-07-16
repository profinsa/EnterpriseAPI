CREATE PROCEDURE Payroll_CreateGLTransaction (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_EmployeeID NATIONAL VARCHAR(36),
	v_PayrollID NATIONAL VARCHAR(36),INOUT SWP_Ret_Value INT) SWL_return:
BEGIN














   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);

   DECLARE v_Posted BOOLEAN;

   DECLARE v_FICA DECIMAL(19,4);
   DECLARE v_FICAER DECIMAL(19,4); 
   DECLARE v_SUTA DECIMAL(19,4);
   DECLARE v_FIT DECIMAL(19,4);
   DECLARE v_SIT DECIMAL(19,4);
   DECLARE v_SDI DECIMAL(19,4);
   DECLARE v_StateTax DECIMAL(19,4); 
   DECLARE v_CountyTax DECIMAL(19,4);
   DECLARE v_LocalTax DECIMAL(19,4); 
   DECLARE v_FICAMed DECIMAL(19,4); 
   DECLARE v_FUTA DECIMAL(19,4); 
   DECLARE v_Additions DECIMAL(19,4); 
   DECLARE v_Deductions DECIMAL(19,4); 
   DECLARE v_Commission DECIMAL(19,4);
   DECLARE v_Gross DECIMAL(19,4);
   DECLARE v_NetPay DECIMAL(19,4);

   DECLARE v_EmployeeDepartmentID NATIONAL VARCHAR(36);

   DECLARE v_GLFITPayrollAccount NATIONAL VARCHAR(36);
   DECLARE v_GLFITExpenseAccount NATIONAL VARCHAR(36);
   DECLARE v_GLFICAPayrollAccount NATIONAL VARCHAR(36);
   DECLARE v_GLFICAExpenseAccount NATIONAL VARCHAR(36);
   DECLARE v_GLFUTAPayrollAccount NATIONAL VARCHAR(36);
   DECLARE v_GLFUTAExpenseAccount NATIONAL VARCHAR(36);
   DECLARE v_GLSUTAPayrollAccount NATIONAL VARCHAR(36);
   DECLARE v_GLSUTAExpenseAccount NATIONAL VARCHAR(36);
   DECLARE v_GLSITPayrollAccount NATIONAL VARCHAR(36);
   DECLARE v_GLSITExpenseAccount NATIONAL VARCHAR(36);
   DECLARE v_GLSDIPayrollAccount NATIONAL VARCHAR(36);
   DECLARE v_GLSDIExpenseAccount NATIONAL VARCHAR(36);
   DECLARE v_GLFICAMedPayrollAccount NATIONAL VARCHAR(36);
   DECLARE v_GLFICAMedExpenseAccount NATIONAL VARCHAR(36);
   DECLARE v_GLPayrollCashAccount NATIONAL VARCHAR(36);
   DECLARE v_GLOvertimePayrollExpenseAccount NATIONAL VARCHAR(36);
   DECLARE v_GLPayrollTaxExpenseAccount NATIONAL VARCHAR(36);
   DECLARE v_GLBonusPayrollAccount NATIONAL VARCHAR(36);
   DECLARE v_GLWagesPayrollAccount NATIONAL VARCHAR(36);
   DECLARE v_GLLocalPayrollAccount NATIONAL VARCHAR(36);
   DECLARE v_GLSalesPayrollExpenseAccount NATIONAL VARCHAR(36);
   DECLARE v_GLOfficePayrollExpenseAccount NATIONAL VARCHAR(36);
   DECLARE v_GLWarehousePayrollExpenseAccount NATIONAL VARCHAR(36);
   DECLARE v_GLProductionPayrollExpenseAccount NATIONAL VARCHAR(36);
   DECLARE v_PayrollDate DATETIME;
   DECLARE v_PostDate NATIONAL VARCHAR(1);


   DECLARE v_GLTransactionNumber NATIONAL VARCHAR(36);
   DECLARE v_CurrencyID NATIONAL VARCHAR(3);

   DECLARE v_AdditionsToGross DECIMAL(19,4);
   DECLARE v_Basis NATIONAL VARCHAR(20);
   DECLARE v_Type NATIONAL VARCHAR(50);
   DECLARE v_TotalAmount DECIMAL(19,4);
   DECLARE v_EmployerTotalAmount DECIMAL(19,4);
   DECLARE v_GLEmployeeCreditAccount NATIONAL VARCHAR(36);
   DECLARE v_GLEmployerDebitAccount NATIONAL VARCHAR(36);
   DECLARE v_GLEmployerCreditAccount NATIONAL VARCHAR(36);

   DECLARE v_Account NATIONAL VARCHAR(36);
   DECLARE v_ErrorID INT;
   DECLARE NO_DATA INT DEFAULT 0;
   DECLARE RegisterDetailcurs CURSOR FOR
   SELECT 
   Basis,
	Type,
	TotalAmount,
	EmployerTotalAmount,
	GLEmployeeCreditAccount,
	GLEmployerDebitAccount,
	GLEmployerCreditAccount
   FROM PayrollRegisterDetail
   WHERE     
   UPPER(CompanyID) = UPPER(v_CompanyID)
   AND UPPER(DivisionID) = UPPER(v_DivisionID)
   AND UPPER(DepartmentID) = UPPER(v_DepartmentID)
   AND UPPER(EmployeeID) = UPPER(v_EmployeeID) 	
   AND UPPER(PayrollID) = UPPER(v_PayrollID) 	
   AND ApplyItem = 1
   ORDER BY Type;


   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
      SET NO_DATA = -2;
   END;
   DECLARE CONTINUE HANDLER FOR NOT FOUND SET NO_DATA = -1;
   select   CurrencyID, IFNULL(DefaultGLPostingDate,'1') INTO v_CurrencyID,v_PostDate FROM
   Companies WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID;


   select   EmployeeDepartmentID INTO v_EmployeeDepartmentID FROM
   PayrollEmployees WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   EmployeeID = v_EmployeeID;


   select   GLFITPayrollAccount, GLFITExpenseAccount, GLFICAPayrollAccount, GLFICAExpenseAccount, GLFUTAPayrollAccount, GLFUTAExpenseAccount, GLSUTAPayrollAccount, GLSUTAExpenseAccount, GLSITPayrollAccount, GLSITExpenseAccount, GLSDIPayrollAccount, GLSDIExpenseAccount, GLFICAMedPayrollAccount, GLFICAMedExpenseAccount, GLPayrollCashAccount, GLOvertimePayrollExpenseAccount, GLPayrollTaxExpenseAccount, GLBonusPayrollAccount, GLWagesPayrollAccount, GLLocalPayrollAccount, GLSalesPayrollExpenseAccount, GLOfficePayrollExpenseAccount, GLWarehousePayrollExpenseAccount, GLProductionPayrollExpenseAccount INTO v_GLFITPayrollAccount,v_GLFITExpenseAccount,v_GLFICAPayrollAccount,v_GLFICAExpenseAccount,
   v_GLFUTAPayrollAccount,v_GLFUTAExpenseAccount,v_GLSUTAPayrollAccount,
   v_GLSUTAExpenseAccount,v_GLSITPayrollAccount,v_GLSITExpenseAccount,
   v_GLSDIPayrollAccount,v_GLSDIExpenseAccount,v_GLFICAMedPayrollAccount,
   v_GLFICAMedExpenseAccount,v_GLPayrollCashAccount,v_GLOvertimePayrollExpenseAccount,
   v_GLPayrollTaxExpenseAccount,v_GLBonusPayrollAccount,
   v_GLWagesPayrollAccount,v_GLLocalPayrollAccount,v_GLSalesPayrollExpenseAccount,
   v_GLOfficePayrollExpenseAccount,v_GLWarehousePayrollExpenseAccount,
   v_GLProductionPayrollExpenseAccount FROM
   PayrollSetup WHERE
   UPPER(CompanyID) = UPPER(v_CompanyID) AND
   UPPER(DivisionID) = UPPER(v_DivisionID) AND
   UPPER(DepartmentID) = UPPER(v_DepartmentID);


   select   IFNULL(Gross,0), IFNULL(FICA,0), IFNULL(FICAER,0), IFNULL(FIT,0), IFNULL(FUTA,0), IFNULL(StateTax,0), IFNULL(CountyTax,0), IFNULL(CityTax,0), IFNULL(FICAMed,0), IFNULL(SUTA,0), IFNULL(SIT,0), IFNULL(SDI,0), IFNULL(Additions,0), IFNULL(Deductions,0), IFNULL(Commission,0), IFNULL(NetPay,0), IFNULL(Posted,0), PayrollDate INTO v_Gross,v_FICA,v_FICAER,v_FIT,v_FUTA,v_StateTax,v_CountyTax,v_LocalTax,
   v_FICAMed,v_SUTA,v_SIT,v_SDI,v_Additions,v_Deductions,v_Commission,v_NetPay,
   v_Posted,v_PayrollDate FROM
   PayrollRegister WHERE
   UPPER(CompanyID) = UPPER(v_CompanyID) AND
   UPPER(DivisionID) = UPPER(v_DivisionID) AND
   UPPER(DepartmentID) = UPPER(v_DepartmentID) AND
   UPPER(EmployeeID) = UPPER(v_EmployeeID) AND
   UPPER(PayrollID) = UPPER(v_PayrollID);




   IF v_Posted = 1 then

      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;
   end if;


   START TRANSACTION;



   CREATE TEMPORARY TABLE tt_LedgerDetailTmp  
   (
      GLTransactionNumberDetail BIGINT NOT NULL  PRIMARY KEY  AUTO_INCREMENT,
      GLTransactionAccount NATIONAL VARCHAR(36),
      GLDebitAmount DECIMAL(19,4),
      GLCreditAmount DECIMAL(19,4)
   )  AUTO_INCREMENT = 1;


   SET @SWV_Error = 0;
   SET v_ReturnStatus = GetNextEntityID(v_CompanyID,v_DivisionID,v_DepartmentID,'NextGLTransNumber',v_GLTransactionNumber);
   IF v_ReturnStatus <> 0 OR @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Call enterprise.GetNextEntityID failed';
      ROLLBACK;
      DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payroll_CreateGLTransaction',
      v_ErrorMessage,v_ErrorID);
      SET SWP_Ret_Value = -1;
   end if;

   SET @SWV_Error = 0;
   INSERT INTO LedgerTransactions(CompanyID,
	DivisionID,
	DepartmentID,
	GLTransactionNumber,
	GLTransactionTypeID,
	SystemDate,
	GLTransactionReference,
	CurrencyID,
	GLTransactionAmount,
	GLTransactionBalance,
	GLTransactionPostedYN)
VALUES(v_CompanyID,
	v_DivisionID,
	v_DepartmentID,
	v_GLTransactionNumber,
	'Payroll',
	CASE v_PostDate WHEN '1' THEN CURRENT_TIMESTAMP ELSE v_PayrollDate END,
	v_PayrollID,
	v_CurrencyID,
	fnRound(v_CompanyID, v_DivisionID , v_DepartmentID, v_Gross+v_Additions -v_NetPay, v_CurrencyID),
	0,
	1);

   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Insert into LedgerTransactions failed';
      ROLLBACK;
      DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payroll_CreateGLTransaction',
      v_ErrorMessage,v_ErrorID);
      SET SWP_Ret_Value = -1;
   end if;


   SET @SWV_Error = 0;
   INSERT INTO tt_LedgerDetailTmp(GLTransactionAccount,
	GLDebitAmount,
	GLCreditAmount)
VALUES(v_GLFICAExpenseAccount,
	fnRound(v_CompanyID, v_DivisionID , v_DepartmentID, v_FICAER, v_CurrencyID),
	0);

   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Insert into LedgerTransactionsDetail failed';
      ROLLBACK;
      DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payroll_CreateGLTransaction',
      v_ErrorMessage,v_ErrorID);
      SET SWP_Ret_Value = -1;
   end if;



   SET @SWV_Error = 0;
   INSERT INTO tt_LedgerDetailTmp(GLTransactionAccount,
	GLDebitAmount,
	GLCreditAmount)
VALUES(v_GLFUTAExpenseAccount,
	fnRound(v_CompanyID, v_DivisionID , v_DepartmentID, v_FUTA, v_CurrencyID),
	0);

   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Insert into LedgerTransactionsDetail failed';
      ROLLBACK;
      DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payroll_CreateGLTransaction',
      v_ErrorMessage,v_ErrorID);
      SET SWP_Ret_Value = -1;
   end if;



   SET @SWV_Error = 0;
   INSERT INTO tt_LedgerDetailTmp(GLTransactionAccount,
	GLDebitAmount,
	GLCreditAmount)
VALUES(v_GLSUTAExpenseAccount,
	fnRound(v_CompanyID, v_DivisionID , v_DepartmentID, v_SUTA, v_CurrencyID),
	0);

   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Insert into LedgerTransactionsDetail failed';
      ROLLBACK;
      DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payroll_CreateGLTransaction',
      v_ErrorMessage,v_ErrorID);
      SET SWP_Ret_Value = -1;
   end if;



   SET @SWV_Error = 0;
   INSERT INTO tt_LedgerDetailTmp(GLTransactionAccount,
	GLDebitAmount,
	GLCreditAmount)
VALUES(v_GLFICAPayrollAccount,
	0,
	fnRound(v_CompanyID, v_DivisionID , v_DepartmentID, v_FICAER+v_FICA, v_CurrencyID));

   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Insert into LedgerTransactionsDetail failed';
      ROLLBACK;
      DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payroll_CreateGLTransaction',
      v_ErrorMessage,v_ErrorID);
      SET SWP_Ret_Value = -1;
   end if;



   SET @SWV_Error = 0;
   INSERT INTO tt_LedgerDetailTmp(GLTransactionAccount,
	GLDebitAmount,
	GLCreditAmount)
VALUES(v_GLFITPayrollAccount,
	0,
	fnRound(v_CompanyID, v_DivisionID , v_DepartmentID, v_FIT, v_CurrencyID));

   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Insert into LedgerTransactionsDetail failed';
      ROLLBACK;
      DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payroll_CreateGLTransaction',
      v_ErrorMessage,v_ErrorID);
      SET SWP_Ret_Value = -1;
   end if;



   SET @SWV_Error = 0;
   INSERT INTO tt_LedgerDetailTmp(GLTransactionAccount,
	GLDebitAmount,
	GLCreditAmount)
VALUES(v_GLFUTAPayrollAccount,
	0,
	fnRound(v_CompanyID, v_DivisionID , v_DepartmentID, v_FUTA, v_CurrencyID));

   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Insert into LedgerTransactionsDetail failed';
      ROLLBACK;
      DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payroll_CreateGLTransaction',
      v_ErrorMessage,v_ErrorID);
      SET SWP_Ret_Value = -1;
   end if;



   SET @SWV_Error = 0;
   INSERT INTO tt_LedgerDetailTmp(GLTransactionAccount,
	GLDebitAmount,
	GLCreditAmount)
VALUES(v_GLSUTAPayrollAccount,
	0,
	fnRound(v_CompanyID, v_DivisionID , v_DepartmentID, v_SUTA, v_CurrencyID));

   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Insert into LedgerTransactionsDetail failed';
      ROLLBACK;
      DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payroll_CreateGLTransaction',
      v_ErrorMessage,v_ErrorID);
      SET SWP_Ret_Value = -1;
   end if;



   SET @SWV_Error = 0;
   INSERT INTO tt_LedgerDetailTmp(GLTransactionAccount,
	GLDebitAmount,
	GLCreditAmount)
VALUES(v_GLPayrollCashAccount,
	0,
	fnRound(v_CompanyID, v_DivisionID , v_DepartmentID, v_NetPay, v_CurrencyID));

   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Insert into LedgerTransactionsDetail failed';
      ROLLBACK;
      DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payroll_CreateGLTransaction',
      v_ErrorMessage,v_ErrorID);
      SET SWP_Ret_Value = -1;
   end if;


   SET v_AdditionsToGross = 0;


   OPEN RegisterDetailcurs;

   SET NO_DATA = 0;
   FETCH RegisterDetailcurs INTO
   v_Basis,v_Type,v_TotalAmount,v_EmployerTotalAmount,v_GLEmployeeCreditAccount, 
   v_GLEmployerDebitAccount,v_GLEmployerCreditAccount;
   WHILE NO_DATA = 0 DO
      IF v_Type = 'Addition' then
		
         SET @SWV_Error = 0;
         INSERT INTO tt_LedgerDetailTmp(GLTransactionAccount,
				GLDebitAmount,
				GLCreditAmount)
			VALUES(v_GLEmployeeCreditAccount,
				fnRound(v_CompanyID, v_DivisionID , v_DepartmentID, v_TotalAmount, v_CurrencyID),
				0);
			
         IF @SWV_Error <> 0 then
			
            CLOSE RegisterDetailcurs;
				
            SET v_ErrorMessage = 'Insert into LedgerTransactionsDetail failed';
            ROLLBACK;
            DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;
            CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payroll_CreateGLTransaction',
            v_ErrorMessage,v_ErrorID);
            SET SWP_Ret_Value = -1;
         end if;
         SET @SWV_Error = 0;
         INSERT INTO tt_LedgerDetailTmp(GLTransactionAccount,
				GLDebitAmount,
				GLCreditAmount)
			VALUES(v_GLEmployerDebitAccount,
				fnRound(v_CompanyID, v_DivisionID , v_DepartmentID, v_EmployerTotalAmount, v_CurrencyID),
				0);
			
         IF @SWV_Error <> 0 then
			
            CLOSE RegisterDetailcurs;
				
            SET v_ErrorMessage = 'Insert into LedgerTransactionsDetail failed';
            ROLLBACK;
            DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;
            CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payroll_CreateGLTransaction',
            v_ErrorMessage,v_ErrorID);
            SET SWP_Ret_Value = -1;
         end if;
         SET @SWV_Error = 0;
         INSERT INTO tt_LedgerDetailTmp(GLTransactionAccount,
				GLDebitAmount,
				GLCreditAmount)
			VALUES(v_GLEmployerCreditAccount,
				0,
				fnRound(v_CompanyID, v_DivisionID , v_DepartmentID, v_EmployerTotalAmount, v_CurrencyID));
			
         IF @SWV_Error <> 0 then
			
            CLOSE RegisterDetailcurs;
				
            SET v_ErrorMessage = 'Insert into LedgerTransactionsDetail failed';
            ROLLBACK;
            DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;
            CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payroll_CreateGLTransaction',
            v_ErrorMessage,v_ErrorID);
            SET SWP_Ret_Value = -1;
         end if;
         IF v_Basis != 'Net' then
				
            SET v_AdditionsToGross = v_AdditionsToGross+v_TotalAmount;
         end if;
      end if;
      IF v_Type = 'Deduction' then
		
         SET @SWV_Error = 0;
         INSERT INTO tt_LedgerDetailTmp(GLTransactionAccount,
				GLDebitAmount,
				GLCreditAmount)
			VALUES(v_GLEmployeeCreditAccount,
				0,
				fnRound(v_CompanyID, v_DivisionID , v_DepartmentID, v_TotalAmount, v_CurrencyID));
			
         IF @SWV_Error <> 0 then
			
            CLOSE RegisterDetailcurs;
				
            SET v_ErrorMessage = 'Insert into LedgerTransactionsDetail failed';
            ROLLBACK;
            DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;
            CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payroll_CreateGLTransaction',
            v_ErrorMessage,v_ErrorID);
            SET SWP_Ret_Value = -1;
         end if;
         SET @SWV_Error = 0;
         INSERT INTO tt_LedgerDetailTmp(GLTransactionAccount,
				GLDebitAmount,
				GLCreditAmount)
			VALUES(v_GLEmployerDebitAccount,
				fnRound(v_CompanyID, v_DivisionID , v_DepartmentID, v_EmployerTotalAmount, v_CurrencyID),
				0);
			
         IF @SWV_Error <> 0 then
			
            CLOSE RegisterDetailcurs;
				
            SET v_ErrorMessage = 'Insert into LedgerTransactionsDetail failed';
            ROLLBACK;
            DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;
            CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payroll_CreateGLTransaction',
            v_ErrorMessage,v_ErrorID);
            SET SWP_Ret_Value = -1;
         end if;
         SET @SWV_Error = 0;
         INSERT INTO tt_LedgerDetailTmp(GLTransactionAccount,
				GLDebitAmount,
				GLCreditAmount)
			VALUES(v_GLEmployerCreditAccount,
				0,
				fnRound(v_CompanyID, v_DivisionID , v_DepartmentID, v_EmployerTotalAmount, v_CurrencyID));
			
         IF @SWV_Error <> 0 then
			
            CLOSE RegisterDetailcurs;
				
            SET v_ErrorMessage = 'Insert into LedgerTransactionsDetail failed';
            ROLLBACK;
            DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;
            CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payroll_CreateGLTransaction',
            v_ErrorMessage,v_ErrorID);
            SET SWP_Ret_Value = -1;
         end if;
      end if;
      IF v_Type = 'State Tax' then
		
         SET @SWV_Error = 0;
         INSERT INTO tt_LedgerDetailTmp(GLTransactionAccount,
				GLDebitAmount,
				GLCreditAmount)
			VALUES(v_GLEmployeeCreditAccount,
				0,
				fnRound(v_CompanyID, v_DivisionID , v_DepartmentID, v_TotalAmount, v_CurrencyID));
			
         IF @SWV_Error <> 0 then
			
            CLOSE RegisterDetailcurs;
				
            SET v_ErrorMessage = 'Insert into LedgerTransactionsDetail failed';
            ROLLBACK;
            DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;
            CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payroll_CreateGLTransaction',
            v_ErrorMessage,v_ErrorID);
            SET SWP_Ret_Value = -1;
         end if;
      end if;
      IF v_Type = 'Local Tax' then
		
         SET @SWV_Error = 0;
         INSERT INTO tt_LedgerDetailTmp(GLTransactionAccount,
				GLDebitAmount,
				GLCreditAmount)
			VALUES(v_GLEmployeeCreditAccount,
				0,
				fnRound(v_CompanyID, v_DivisionID , v_DepartmentID, v_TotalAmount, v_CurrencyID));
			
         IF @SWV_Error <> 0 then
			
            CLOSE RegisterDetailcurs;
				
            SET v_ErrorMessage = 'Insert into LedgerTransactionsDetail failed';
            ROLLBACK;
            DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;
            CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payroll_CreateGLTransaction',
            v_ErrorMessage,v_ErrorID);
            SET SWP_Ret_Value = -1;
         end if;
      end if;
      SET NO_DATA = 0;
      FETCH RegisterDetailcurs INTO
      v_Basis,v_Type,v_TotalAmount,v_EmployerTotalAmount,v_GLEmployeeCreditAccount, 
      v_GLEmployerDebitAccount,v_GLEmployerCreditAccount;
   END WHILE;

   CLOSE RegisterDetailcurs;


   SET v_Account = CASE v_EmployeeDepartmentID
   WHEN 'Office' THEN v_GLOfficePayrollExpenseAccount
   WHEN 'Sales' THEN v_GLSalesPayrollExpenseAccount
   WHEN 'Warehouse' THEN v_GLWarehousePayrollExpenseAccount
   WHEN 'Production' THEN v_GLProductionPayrollExpenseAccount
   ELSE ''
   END;

   SET @SWV_Error = 0;
   INSERT INTO tt_LedgerDetailTmp(GLTransactionAccount,
	GLDebitAmount,
	GLCreditAmount)
VALUES(v_Account,
	fnRound(v_CompanyID, v_DivisionID , v_DepartmentID, v_Gross -v_AdditionsToGross, v_CurrencyID),
	0);

   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Insert into LedgerTransactionsDetail failed';
      ROLLBACK;
      DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payroll_CreateGLTransaction',
      v_ErrorMessage,v_ErrorID);
      SET SWP_Ret_Value = -1;
   end if;






   SET @SWV_Error = 0;
   INSERT INTO LedgerTransactionsDetail(CompanyID,
	DivisionID,
	DepartmentID,
	GLTransactionNumber,
	GLTransactionAccount,
	GLDebitAmount,
	GLCreditAmount,
	ProjectID)
   SELECT
   v_CompanyID,
	v_DivisionID,
	v_DepartmentID,
	v_GLTransactionNumber,
	GLTransactionAccount,
	SUM(IFNULL(GLDebitAmount,0)),
	SUM(IFNULL(GLCreditAmount,0)) ,
	NULL
   FROM
   tt_LedgerDetailTmp
   GROUP BY
   GLTransactionAccount;
   IF @SWV_Error <> 0 then



      SET v_ErrorMessage = 'Insert into LedgerTransactionDetail failed';
      ROLLBACK;
      DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payroll_CreateGLTransaction',
      v_ErrorMessage,v_ErrorID);
      SET SWP_Ret_Value = -1;
   end if;

   DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;



   SET @SWV_Error = 0;
   SET v_ReturnStatus = LedgerTransactions_PostCOA_AllRecords(v_CompanyID,v_DivisionID,v_DepartmentID,v_GLTransactionNumber);
   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then



      SET v_ErrorMessage = 'LedgerTransactions_PostCOA_AllRecords call failed';
      ROLLBACK;
      DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payroll_CreateGLTransaction',
      v_ErrorMessage,v_ErrorID);
      SET SWP_Ret_Value = -1;
   end if;


   COMMIT;
   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;








   ROLLBACK;

   DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;

   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payroll_CreateGLTransaction',
   v_ErrorMessage,v_ErrorID);

   SET SWP_Ret_Value = -1;
END