CREATE PROCEDURE CreditMemo_CreateGLTransaction (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_InvoiceNumber NATIONAL VARCHAR(36),INOUT SWP_Ret_Value INT) SWL_return:
BEGIN















   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);

   DECLARE v_GLSalesAccount NATIONAL VARCHAR(36);
   DECLARE v_GLDefaultSalesAccount NATIONAL VARCHAR(36);
   DECLARE v_GLARAccount NATIONAL VARCHAR(36);
   DECLARE v_Posted BOOLEAN;
   DECLARE v_PostDate NATIONAL VARCHAR(1);
   DECLARE v_PeriodClosed INT;
   DECLARE v_PeriodToPost INT;
   DECLARE v_CurrencyID NATIONAL VARCHAR(3); 
   DECLARE v_CompanyCurrencyID NATIONAL VARCHAR(3); 
   DECLARE v_CurrencyExchangeRate FLOAT;
   DECLARE v_InvoiceDate DATETIME;
   DECLARE v_Total DECIMAL(19,4);
   DECLARE v_GLTransactionNumber NATIONAL VARCHAR(36);
   DECLARE v_ProjectID NATIONAL VARCHAR(36);


   DECLARE v_ConvertedTotal DECIMAL(19,4);
   DECLARE v_ErrorID INT;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
   END;
   select   IFNULL(Total,0), CurrencyID, CurrencyExchangeRate, GLSalesAccount, InvoiceDate, Posted INTO v_Total,v_CurrencyID,v_CurrencyExchangeRate,v_GLSalesAccount,v_InvoiceDate,
   v_Posted FROM
   InvoiceHeader WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND InvoiceNumber = v_InvoiceNumber;


   IF v_Posted = 1 then
      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;
   end if;

   IF v_Total = 0 then
      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;
   end if;

   START TRANSACTION;

   SET @SWV_Error = 0;
   CALL VerifyCurrency2(v_CompanyID,v_DivisionID,v_DepartmentID,v_InvoiceDate,1,v_CompanyCurrencyID,
   v_CurrencyID,v_CurrencyExchangeRate);
   IF @SWV_Error <> 0 then

	
      SET v_ErrorMessage = 'Currency retrieving failed';
      ROLLBACK;
      IF v_ErrorMessage <> '' then

	
	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'CreditMemo_CreateGLTransaction',
         v_ErrorMessage,v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
      end if;
      SET SWP_Ret_Value = -1;
   end if;

   SET v_ConvertedTotal = fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,v_Total*v_CurrencyExchangeRate, 
   v_CompanyCurrencyID);

   select   ProjectID INTO v_ProjectID FROM  InvoiceDetail WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND InvoiceNumber = v_InvoiceNumber
   AND NOT ProjectID IS NULL   LIMIT 1;



   SET @SWV_Error = 0;
   CALL GetNextEntityID2(v_CompanyID,v_DivisionID,v_DepartmentID,'NextGLTransNumber',v_GLTransactionNumber, v_ReturnStatus);

   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then



      SET v_ErrorMessage = 'GetNextEntityID call failed';
      ROLLBACK;
      IF v_ErrorMessage <> '' then

	
	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'CreditMemo_CreateGLTransaction',
         v_ErrorMessage,v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
      end if;
      SET SWP_Ret_Value = -1;
   end if;



   select   GLARSalesAccount, GLARAccount, IFNULL(DefaultGLPostingDate,'1') INTO v_GLDefaultSalesAccount,v_GLARAccount,v_PostDate FROM
   Companies WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID;

   SET v_GLDefaultSalesAccount = IFNULL(v_GLSalesAccount,v_GLDefaultSalesAccount);

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
	GLTransactionPostedYN,
	GLTransactionBalance,
	GLTransactionSource,
	GLTransactionSystemGenerated,
	GLTransactionRecurringYN)
   SELECT
   v_CompanyID,
		v_DivisionID,
		v_DepartmentID,
		v_GLTransactionNumber,
		'Credit Memo',
		CASE v_PostDate WHEN '1' THEN CURRENT_TIMESTAMP ELSE InvoiceDate END,
		CURRENT_TIMESTAMP,
		CustomerID,
		v_InvoiceNumber,
		v_CompanyCurrencyID,
		1,
		v_ConvertedTotal,
		0,
		1,
		0,
		CONCAT('CREDIT MEMO ',cast(v_InvoiceNumber as char(10))),
		1,
		0
   FROM
   InvoiceHeader
   WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND InvoiceNumber = v_InvoiceNumber;

   IF @SWV_Error <> 0 then
	
	
	
      SET v_ErrorMessage = 'Insert into LedgerTransactions failed';
      ROLLBACK;
      IF v_ErrorMessage <> '' then

	
	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'CreditMemo_CreateGLTransaction',
         v_ErrorMessage,v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
      end if;
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
   Select
   v_CompanyID,
	v_DivisionID,
	v_DepartmentID,
	v_GLTransactionNumber,
	IFNULL(GLSalesAccount,v_GLDefaultSalesAccount),
	fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,Total*v_CurrencyExchangeRate,v_CompanyCurrencyID),
	0,
	ProjectID
   FROM
   InvoiceDetail
   WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND InvoiceNumber = v_InvoiceNumber
   AND IFNULL(Total,0) <> 0;

   IF @SWV_Error <> 0 then


      SET v_ErrorMessage = 'Insert into LedgerTransactionsDetail failed';
      ROLLBACK;
      IF v_ErrorMessage <> '' then

	
	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'CreditMemo_CreateGLTransaction',
         v_ErrorMessage,v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
      end if;
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
VALUES(v_CompanyID,
	v_DivisionID,
	v_DepartmentID,
	v_GLTransactionNumber,
	v_GLARAccount,
	0,
	v_ConvertedTotal,
	v_ProjectID);


   IF @SWV_Error <> 0 then


      SET v_ErrorMessage = 'Insert into LedgerTransactionsDetail failed';
      ROLLBACK;
      IF v_ErrorMessage <> '' then

	
	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'CreditMemo_CreateGLTransaction',
         v_ErrorMessage,v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
      end if;
      SET SWP_Ret_Value = -1;
   end if;



   SET @SWV_Error = 0;
   CALL LedgerTransactions_PostCOA_AllRecords2(v_CompanyID,v_DivisionID,v_DepartmentID,v_GLTransactionNumber, v_ReturnStatus);
   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then

      SET v_ErrorMessage = 'LedgerTransactions_PostCOA_AllRecords call failed';
      ROLLBACK;
      IF v_ErrorMessage <> '' then

	
	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'CreditMemo_CreateGLTransaction',
         v_ErrorMessage,v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
      end if;
      SET SWP_Ret_Value = -1;
   end if;



   COMMIT;
   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;








   ROLLBACK;

   IF v_ErrorMessage <> '' then

	
	
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'CreditMemo_CreateGLTransaction',
      v_ErrorMessage,v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
   end if;
   SET SWP_Ret_Value = -1;
END