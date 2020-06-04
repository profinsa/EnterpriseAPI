CREATE PROCEDURE DebitMemoApplyToPayment_CreateGLTransaction2 (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_PaymentID NATIONAL VARCHAR(36),
	v_DebitMemoAmount DECIMAL(19,4),INOUT SWP_Ret_Value INT) SWL_return:
BEGIN



















   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);

   DECLARE v_TranDate DATETIME;
   DECLARE v_PeriodToPost INT;
   DECLARE v_ConvertedDebitMemoAmount DECIMAL(19,4);
   DECLARE v_CurrencyID NATIONAL VARCHAR(3);
   DECLARE v_CompanyCurrencyID NATIONAL VARCHAR(3);
   DECLARE v_CurrencyExchangeRate FLOAT;
   DECLARE v_PaymentDate DATETIME;
   DECLARE v_AmountPaid DECIMAL(19,4);
   DECLARE v_Amount DECIMAL(19,4);
   DECLARE v_ConvertedTotal DECIMAL(19,4);
   DECLARE v_GLTransNumber NATIONAL VARCHAR(36);
   DECLARE v_GLCashAccount NATIONAL VARCHAR(36);
   DECLARE v_GLAPAccount NATIONAL VARCHAR(36);
   DECLARE v_GLARAccount NATIONAL VARCHAR(36);
   DECLARE v_VendorID NATIONAL VARCHAR(36);
   DECLARE v_PostCOA BOOLEAN;
   DECLARE v_ProjectID NATIONAL VARCHAR(36);
   DECLARE v_PostDate NATIONAL VARCHAR(1);
   DECLARE v_Posted BOOLEAN;

   DECLARE v_ErrorID INT;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
   END;
   SET @SWV_Error = 0;
   START TRANSACTION;





   select   IFNULL(Posted,0), IFNULL(CreditAmount,0), VendorID, CurrencyID, IFNULL(PaymentDate,CURRENT_TIMESTAMP), CurrencyExchangeRate INTO v_Posted,v_Amount,v_VendorID,v_CurrencyID,v_PaymentDate,v_CurrencyExchangeRate FROM
   PaymentsHeader WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   PaymentID = v_PaymentID;


   IF v_Amount = 0 or v_DebitMemoAmount = 0 then

      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;
   end if;

   IF v_Amount < v_DebitMemoAmount then

      SET v_ErrorMessage = 'Debit memo amount can't be greater then payment amount';
      ROLLBACK;



      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'DebitMemoApplyToPayment_CreateGLTransaction',
      v_ErrorMessage,v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseNumber',v_PaymentID);
      SET SWP_Ret_Value = -1;
   end if;


   select   GLARAccount, GLAPAccount, IFNULL(DefaultGLPostingDate,'1') INTO v_GLARAccount,v_GLAPAccount,v_PostDate FROM
   Companies WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID;



   SET @SWV_Error = 0;
   CALL VerifyCurrency2(v_CompanyID,v_DivisionID,v_DepartmentID,v_PaymentDate,2,v_CompanyCurrencyID,
   v_CurrencyID,v_CurrencyExchangeRate);
   IF @SWV_Error <> 0 then

	
      SET v_ErrorMessage = 'Currency retrieving failed';
      ROLLBACK;



      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'DebitMemoApplyToPayment_CreateGLTransaction',
      v_ErrorMessage,v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseNumber',v_PaymentID);
      SET SWP_Ret_Value = -1;
   end if;


   SET v_ConvertedTotal = fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,v_Amount*v_CurrencyExchangeRate, 
   v_CompanyCurrencyID);
   SET v_ConvertedDebitMemoAmount = fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,v_DebitMemoAmount*v_CurrencyExchangeRate, 
   v_CompanyCurrencyID);


   select   ProjectID INTO v_ProjectID FROM
   PaymentsDetail WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   PaymentID = v_PaymentID AND
   Not ProjectID IS NULL;



   SET @SWV_Error = 0;
   CALL GetNextEntityID2(v_CompanyID,v_DivisionID,v_DepartmentID,'NextGLTransNumber',v_GLTransNumber, v_ReturnStatus);
   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'GetNextEntityID call failed';
      ROLLBACK;



      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'DebitMemoApplyToPayment_CreateGLTransaction',
      v_ErrorMessage,v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseNumber',v_PaymentID);
      SET SWP_Ret_Value = -1;
   end if;

   SET @SWV_Error = 0;
   INSERT INTO LedgerTransactions(CompanyID,
	DivisionID,
	DepartmentID,
	GLTransactionNumber,
	GLTransactionTypeID,
	GLTransactionDate,
	GLTransactionDescription,
	GLTransactionReference,
	CurrencyID,
	CurrencyExchangeRate,
	GLTransactionAmount,
	GLTransactionAmountUndistributed,
	GLTransactionPostedYN,
	GLTransactionBalance,
	GLTransactionSource,
	GLTransactionSystemGenerated,
	GLTransactionRecurringYN)
	Values(v_CompanyID,
		v_DivisionID,
		v_DepartmentID,
		v_GLTransNumber,
		'DM Check',
		CASE v_PostDate WHEN '1' THEN CURRENT_TIMESTAMP ELSE v_PaymentDate END,
		v_VendorID,
		v_PaymentID,
		v_CurrencyID,
		v_CurrencyExchangeRate,
		v_ConvertedDebitMemoAmount,
		0,
		1,
		0,
		CONCAT('DM Check ', cast(v_PaymentID as char(10))),
		1,
		1);


   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Insert into LedgerTransactions failed';
      ROLLBACK;



      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'DebitMemoApplyToPayment_CreateGLTransaction',
      v_ErrorMessage,v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseNumber',v_PaymentID);
      SET SWP_Ret_Value = -1;
   end if;




   INSERT INTO LedgerTransactionsDetail(CompanyID,
	DivisionID,
	DepartmentID,
	GLTransactionNumber,
	GLTransactionAccount,
	GLDebitAmount,
	GLCreditAmount,
	ProjectID)
VALUES(v_CompanyID,
		v_DivisionID,
		v_DepartmentID,
		v_GLTransNumber,
		v_GLARAccount,
		0,
		v_ConvertedDebitMemoAmount,
		v_ProjectID);



   SET @SWV_Error = 0;
   INSERT INTO LedgerTransactionsDetail(CompanyID,
	DivisionID,
	DepartmentID,
	GLTransactionNumber,
	GLTransactionAccount,
	GLDebitAmount,
	GLCreditAmount,
	ProjectID)
VALUES(v_CompanyID,
	v_DivisionID,
	v_DepartmentID,
	v_GLTransNumber,
	v_GLAPAccount,
	v_ConvertedDebitMemoAmount,
	0,
	v_ProjectID);




   IF @SWV_Error <> 0 then



      SET v_ErrorMessage = 'Error Processing Data';
      ROLLBACK;



      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'DebitMemoApplyToPayment_CreateGLTransaction',
      v_ErrorMessage,v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseNumber',v_PaymentID);
      SET SWP_Ret_Value = -1;
   end if;



   SET @SWV_Error = 0;
   CALL LedgerTransactions_PostCOA_AllRecords2(v_CompanyID,v_DivisionID,v_DepartmentID,v_GLTransNumber, v_ReturnStatus);
   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then

      SET v_ErrorMessage = 'LedgerTransactions_PostCOA_AllRecords call failed';
      ROLLBACK;



      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'DebitMemoApplyToPayment_CreateGLTransaction',
      v_ErrorMessage,v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseNumber',v_PaymentID);
      SET SWP_Ret_Value = -1;
   end if;


   COMMIT;

   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;








   ROLLBACK;



   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'DebitMemoApplyToPayment_CreateGLTransaction',
   v_ErrorMessage,v_ErrorID);

   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseNumber',v_PaymentID);

   SET SWP_Ret_Value = -1;
END