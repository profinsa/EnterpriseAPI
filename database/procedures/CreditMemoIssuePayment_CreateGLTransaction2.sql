CREATE PROCEDURE CreditMemoIssuePayment_CreateGLTransaction2 (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_CreditMemoNumber NATIONAL VARCHAR(36),INOUT SWP_Ret_Value INT) SWL_return:
BEGIN



















   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);

   DECLARE v_GLAPAccount NATIONAL VARCHAR(36);
   DECLARE v_GLARAccount NATIONAL VARCHAR(36);
   DECLARE v_Posted BOOLEAN;
   DECLARE v_PostDate BOOLEAN;
   DECLARE v_PeriodClosed INT;
   DECLARE v_PeriodToPost INT;
   DECLARE v_CurrencyID NATIONAL VARCHAR(3); 
   DECLARE v_CompanyCurrencyID NATIONAL VARCHAR(3); 
   DECLARE v_CurrencyExchangeRate FLOAT;
   DECLARE v_CreditMemoDate DATETIME;
   DECLARE v_Amount DECIMAL(19,4);
   DECLARE v_GLTransactionNumber NATIONAL VARCHAR(36);
   DECLARE v_ProjectID NATIONAL VARCHAR(36);

   DECLARE v_ConvertedAmount DECIMAL(19,4);
   DECLARE v_ErrorID INT;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
   END;
   select   IFNULL(Posted,0), IFNULL(Total,0) -IFNULL(AmountPaid,0), CurrencyID, IFNULL(InvoiceDate,CURRENT_TIMESTAMP), CurrencyExchangeRate INTO v_Posted,v_Amount,v_CurrencyID,v_CreditMemoDate,v_CurrencyExchangeRate FROM
   InvoiceHeader WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   InvoiceNumber = v_CreditMemoNumber;



   IF v_Posted = 0 then
      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;
   end if;

   IF v_Amount = 0 then
      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;
   end if;

   START TRANSACTION;

   SET @SWV_Error = 0;
   CALL VerifyCurrency2(v_CompanyID,v_DivisionID,v_DepartmentID,v_CreditMemoDate,1,v_CompanyCurrencyID,
   v_CurrencyID,v_CurrencyExchangeRate);
   IF @SWV_Error <> 0 then

	
      SET v_ErrorMessage = 'Currency retrieving failed';
      ROLLBACK;
      IF v_ErrorMessage <> '' then

	
	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'CreditMemoIssuePayment_CreateGLTransaction',
         v_ErrorMessage,v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_CreditMemoNumber);
      end if;
      SET SWP_Ret_Value = -1;
   end if;

   SET v_ConvertedAmount = fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,v_Amount*v_CurrencyExchangeRate, 
   v_CompanyCurrencyID);

   select   ProjectID INTO v_ProjectID FROM  InvoiceDetail WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND InvoiceNumber = v_CreditMemoNumber
   AND NOT ProjectID IS NULL   LIMIT 1;



   SET @SWV_Error = 0;
   CALL GetNextEntityID2(v_CompanyID,v_DivisionID,v_DepartmentID,'NextGLTransNumber',v_GLTransactionNumber, v_ReturnStatus);

   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then



      SET v_ErrorMessage = 'GetNextEntityID call failed';
      ROLLBACK;
      IF v_ErrorMessage <> '' then

	
	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'CreditMemoIssuePayment_CreateGLTransaction',
         v_ErrorMessage,v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_CreditMemoNumber);
      end if;
      SET SWP_Ret_Value = -1;
   end if;



   select   GLAPAccount, GLARAccount, PeriodPosting INTO v_GLAPAccount,v_GLARAccount,v_PostDate FROM
   Companies WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID;


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
		CASE v_PostDate WHEN 1 THEN CURRENT_TIMESTAMP ELSE InvoiceDate END,
		CURRENT_TIMESTAMP,
		CustomerID,
		v_CreditMemoNumber,
		v_CompanyCurrencyID,
		1,
		v_ConvertedAmount,
		0,
		1,
		0,
		CONCAT('CREDIT MEMO ',cast(v_CreditMemoNumber as char(10))),
		1,
		0
   FROM
   InvoiceHeader
   WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND InvoiceNumber = v_CreditMemoNumber;

   IF @SWV_Error <> 0 then
	
	
	
      SET v_ErrorMessage = 'Insert into LedgerTransactions failed';
      ROLLBACK;
      IF v_ErrorMessage <> '' then

	
	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'CreditMemoIssuePayment_CreateGLTransaction',
         v_ErrorMessage,v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_CreditMemoNumber);
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
Values(v_CompanyID,
	v_DivisionID,
	v_DepartmentID,
	v_GLTransactionNumber,
	v_GLAPAccount,
	v_ConvertedAmount,
	0,
	v_ProjectID);


   IF @SWV_Error <> 0 then


      SET v_ErrorMessage = 'Insert into LedgerTransactionsDetail failed';
      ROLLBACK;
      IF v_ErrorMessage <> '' then

	
	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'CreditMemoIssuePayment_CreateGLTransaction',
         v_ErrorMessage,v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_CreditMemoNumber);
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
	v_ConvertedAmount,
	v_ProjectID);


   IF @SWV_Error <> 0 then


      SET v_ErrorMessage = 'Insert into LedgerTransactionsDetail failed';
      ROLLBACK;
      IF v_ErrorMessage <> '' then

	
	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'CreditMemoIssuePayment_CreateGLTransaction',
         v_ErrorMessage,v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_CreditMemoNumber);
      end if;
      SET SWP_Ret_Value = -1;
   end if;



   SET @SWV_Error = 0;
   CALL LedgerTransactions_PostCOA_AllRecords2(v_CompanyID,v_DivisionID,v_DepartmentID,v_GLTransactionNumber, v_ReturnStatus);
   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then

      SET v_ErrorMessage = 'LedgerTransactions_PostCOA_AllRecords call failed';
      ROLLBACK;
      IF v_ErrorMessage <> '' then

	
	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'CreditMemoIssuePayment_CreateGLTransaction',
         v_ErrorMessage,v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_CreditMemoNumber);
      end if;
      SET SWP_Ret_Value = -1;
   end if;



   COMMIT;
   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;








   ROLLBACK;

   IF v_ErrorMessage <> '' then

	
	
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'CreditMemoIssuePayment_CreateGLTransaction',
      v_ErrorMessage,v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_CreditMemoNumber);
   end if;
   SET SWP_Ret_Value = -1;
END