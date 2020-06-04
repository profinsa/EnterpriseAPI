CREATE FUNCTION PayrollCheck_Post (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36)) BEGIN











   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);


   DECLARE v_Additions DECIMAL(19,4); 
   DECLARE v_Commission DECIMAL(19,4);
   DECLARE v_NetPay DECIMAL(19,4);
   DECLARE v_EmployeeID NATIONAL VARCHAR(36);
   DECLARE v_PayrollID NATIONAL VARCHAR(36);
   DECLARE v_Amount DECIMAL(19,4);
   DECLARE v_GLPayrollCashAccount NATIONAL VARCHAR(36);
   DECLARE v_GLOvertimePayrollExpenseAccount NATIONAL VARCHAR(36);


   DECLARE v_GLTransactionNumber NATIONAL VARCHAR(36);
   DECLARE v_CurrencyID NATIONAL VARCHAR(3);

   DECLARE v_ErrorID INT;
   DECLARE NO_DATA INT DEFAULT 0;
   DECLARE c_PayrollChecks CURSOR FOR
   SELECT
   IFNULL(PayrollRegister.Additions,0),
		IFNULL(PayrollRegister.Commission,0),
		IFNULL(PayrollRegister.NetPay,0),
		IFNULL(PayrollSetup.GLPayrollCashAccount,N''),
		IFNULL(PayrollSetup.GLOvertimePayrollExpenseAccount,N'')
   FROM
   PayrollChecks INNER JOIN PayrollRegister ON
   PayrollChecks.CompanyID = PayrollRegister.CompanyID AND
   PayrollChecks.DivisionID = PayrollRegister.DivisionID AND
   PayrollChecks.DepartmentID = PayrollRegister.DepartmentID AND
   PayrollChecks.EmployeeID = PayrollRegister.EmployeeID AND
   PayrollChecks.PayrollID = PayrollRegister.PayrollID
   INNER JOIN PayrollSetup ON
   PayrollRegister.CompanyID = PayrollSetup.CompanyID AND
   PayrollRegister.DivisionID = PayrollSetup.DivisionID AND
   PayrollRegister.DepartmentID = PayrollSetup.DepartmentID
   WHERE
   PayrollChecks.CompanyID = v_CompanyID AND
   PayrollChecks.DivisionID = v_DivisionID AND
   PayrollChecks.DepartmentID = v_DepartmentID;

   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
      SET NO_DATA = -2;
   END;
   DECLARE CONTINUE HANDLER FOR NOT FOUND SET NO_DATA = -1;
   select   CurrencyID INTO v_CurrencyID FROM
   Companies WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID;


   OPEN c_PayrollChecks;

   SET NO_DATA = 0;
   FETCH c_PayrollChecks INTO v_Additions,v_Commission,v_NetPay,v_GLPayrollCashAccount,v_GLOvertimePayrollExpenseAccount;
   WHILE NO_DATA = 0 DO
      SET @SWV_Error = 0;
      SET v_ReturnStatus = GetNextEntityID(v_CompanyID,v_DivisionID,v_DepartmentID,'NextGLTransNumber',v_GLTransactionNumber);
      IF v_ReturnStatus <> 0 OR @SWV_Error <> 0 then
	
         SET v_ErrorMessage = 'Call enterprise.GetNextEntityID failed';
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'PayrollCheck_Post',v_ErrorMessage,
         v_ErrorID);
         RETURN -1;
      end if;
      SET @SWV_Error = 0;
      INSERT INTO LedgerTransactions(CompanyID,
		DivisionID,
		DepartmentID,
		GLTransactionNumber,
		GLTransactionTypeID,
		SystemDate,
		CurrencyID,
		GLTransactionAmount,
		GLTransactionBalance,
		GLTransactionPostedYN)
	VALUES(v_CompanyID,
		v_DivisionID,
		v_DepartmentID,
		v_GLTransactionNumber,
		'Payroll',
		CURRENT_TIMESTAMP,
		v_CurrencyID,
		v_NetPay+v_Additions+v_Commission,
		0,
		1);
	
      IF @SWV_Error <> 0 then
	
         SET v_ErrorMessage = 'Insert into LedgerTransactions failed';
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'PayrollCheck_Post',v_ErrorMessage,
         v_ErrorID);
         RETURN -1;
      end if;
      SET @SWV_Error = 0;
      INSERT INTO LedgerTransactionsDetail(CompanyID,
		DivisionID,
		DepartmentID,
		GLTransactionNumber,
		GLTransactionAccount,
		
		GLDebitAmount,
		GLCreditAmount)
	VALUES(v_CompanyID,
		v_DivisionID,
		v_DepartmentID,
		v_GLTransactionNumber,
		v_GLPayrollCashAccount,
		
		v_NetPay+v_Additions+v_Commission,
		0);
	
      IF @SWV_Error <> 0 then
	
         SET v_ErrorMessage = 'Insert into LedgerTransactionsDetail failed';
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'PayrollCheck_Post',v_ErrorMessage,
         v_ErrorID);
         RETURN -1;
      end if;
      SET @SWV_Error = 0;
      INSERT INTO LedgerTransactionsDetail(CompanyID,
		DivisionID,
		DepartmentID,
		GLTransactionNumber,
		GLTransactionAccount,
		
		GLDebitAmount,
		GLCreditAmount)
	VALUES(v_CompanyID,
		v_DivisionID,
		v_DepartmentID,
		v_GLTransactionNumber,
		v_GLOvertimePayrollExpenseAccount,
		
		0,
		v_Additions);
	
      IF @SWV_Error <> 0 then
	
         SET v_ErrorMessage = 'Insert into LedgerTransactionsDetail failed';
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'PayrollCheck_Post',v_ErrorMessage,
         v_ErrorID);
         RETURN -1;
      end if;
      SET NO_DATA = 0;
      FETCH c_PayrollChecks INTO v_Additions,v_Commission,v_NetPay,v_GLPayrollCashAccount,v_GLOvertimePayrollExpenseAccount;
   END WHILE;


   CLOSE c_PayrollChecks;



	
   RETURN 0;








   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'PayrollCheck_Post',v_ErrorMessage,
   v_ErrorID);

   RETURN -1;
END