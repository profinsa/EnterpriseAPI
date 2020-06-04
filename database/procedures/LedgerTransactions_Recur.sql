CREATE PROCEDURE LedgerTransactions_Recur (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_GLTransactionNumber NATIONAL VARCHAR(36),INOUT SWP_Ret_Value INT) SWL_return:
BEGIN













   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);

   DECLARE v_GLTransactionNumberNew NATIONAL VARCHAR(36); 
   DECLARE v_GLTransactionNumberDetail NUMERIC(18,0);
   DECLARE v_GLTransactionAccount NATIONAL VARCHAR(36);
   DECLARE v_GLDebitAmount DECIMAL(19,4);
   DECLARE v_GLCreditAmount DECIMAL(19,4);
   DECLARE v_ProjectID NATIONAL VARCHAR(36);

   DECLARE v_ErrorID INT;
   DECLARE NO_DATA INT DEFAULT 0;
   DECLARE cLedgerTransaction CURSOR FOR
   SELECT
   GLTransactionNumberDetail,
		GLTransactionAccount,
		
		
		GLDebitAmount,
		GLCreditAmount,
		ProjectID
   FROM
   LedgerTransactionsDetail
   WHERE
   CompanyID = v_CompanyID 
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND GLTransactionNumber = v_GLTransactionNumber;
		

   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
      SET NO_DATA = -2;
   END;
   DECLARE CONTINUE HANDLER FOR NOT FOUND SET NO_DATA = -1;
   SET @SWV_Error = 0;
   START TRANSACTION;


   SET v_ReturnStatus = GetNextEntityID(v_CompanyID,v_DivisionID,v_DepartmentID,'NextGLTransNumber',v_GLTransactionNumberNew);
   IF v_ReturnStatus = -1 then

      SET v_ErrorMessage = 'GetNextEntityID call failed';
      ROLLBACK;

      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'LedgerTransactions_Recur',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'GLTransactionNumber',
      v_GLTransactionNumber);
      SET SWP_Ret_Value = -1;
   end if;


   IF v_GLTransactionNumberNew IS NULL then

      ROLLBACK;
      LEAVE SWL_return;
   end if;


   SET @SWV_Error = 0;
   INSERT INTO LedgerTransactions(CompanyID,
	DivisionID,
	DepartmentID,
	GLTransactionNumber,
	GLTransactionTypeID,
	GLTransactionDate,
	SystemDate,
	GLTransactionDescription,
	GLTransactionReference,
	CurrencyID,
	CurrencyExchangeRate,
	GLTransactionAmount,
	GLTransactionAmountUndistributed,
	GLTransactionBalance,
	GLTransactionPostedYN,
	GLTransactionSource,
	GLTransactionSystemGenerated,
	GLTransactionRecurringYN)
   SELECT
   v_CompanyID,
		v_DivisionID,
		v_DepartmentID,
		v_GLTransactionNumberNew,
		'GL Entry',
		GLTransactionDate,
		SystemDate,
		GLTransactionDescription,
		GLTransactionReference,
		CurrencyID,
		CurrencyExchangeRate,
		GLTransactionAmount,
		GLTransactionAmountUndistributed,
		GLTransactionBalance,
		0,
		GLTransactionSource,
		GLTransactionSystemGenerated,
		0
   FROM
   LedgerTransactions
   WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND GLTransactionNumber = v_GLTransactionNumber;

   IF @SWV_Error <> 0 then


      SET v_ErrorMessage = 'Insert into LedgerTransaction failed';
      ROLLBACK;

      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'LedgerTransactions_Recur',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'GLTransactionNumber',
      v_GLTransactionNumber);
      SET SWP_Ret_Value = -1;
   end if;

   IF v_GLTransactionNumberNew IS NULL then

      SET v_ErrorMessage = 'Invalid transaction number';
      ROLLBACK;

      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'LedgerTransactions_Recur',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'GLTransactionNumber',
      v_GLTransactionNumber);
      SET SWP_Ret_Value = -1;
   end if;

   OPEN cLedgerTransaction;

   SET NO_DATA = 0;
   FETCH cLedgerTransaction INTO v_GLTransactionNumberDetail,v_GLTransactionAccount, 
							v_GLDebitAmount,v_GLCreditAmount, 
   v_ProjectID;


   WHILE NO_DATA = 0 DO

      SET @SWV_Error = 0;
      INSERT INTO LedgerTransactionsDetail(CompanyID,
		DivisionID,
		DepartmentID,
		GLTransactionNumber,
		GLTransactionNumberDetail,
		GLTransactionAccount,
		GLDebitAmount,
		GLCreditAmount,
		ProjectID)
	VALUES(v_CompanyID,
		v_DivisionID,
		v_DepartmentID,
		v_GLTransactionNumberNew,
		v_GLTransactionNumberDetail,
		v_GLTransactionAccount,
		v_GLDebitAmount,
		v_GLCreditAmount,
		v_ProjectID);
	
      IF @SWV_Error <> 0 then
	
         CLOSE cLedgerTransaction;
		
         SET v_ErrorMessage = 'Insert into LedgerTransactionsDetail failed';
         ROLLBACK;

         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'LedgerTransactions_Recur',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'GLTransactionNumber',
         v_GLTransactionNumber);
         SET SWP_Ret_Value = -1;
      end if;
      SET NO_DATA = 0;
      FETCH cLedgerTransaction INTO v_GLTransactionNumberDetail,v_GLTransactionAccount, 
								v_GLDebitAmount,v_GLCreditAmount, 
      v_ProjectID;
   END WHILE;

   CLOSE cLedgerTransaction;


   COMMIT;
   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;







   ROLLBACK;

   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'LedgerTransactions_Recur',v_ErrorMessage,
   v_ErrorID);

   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'GLTransactionNumber',
   v_GLTransactionNumber);

   SET SWP_Ret_Value = -1;
END