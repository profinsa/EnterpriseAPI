CREATE PROCEDURE PaymentIssueCreditMemo_CreateGLTransaction (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_PaymentID NATIONAL VARCHAR(36),INOUT SWP_Ret_Value INT) SWL_return:
BEGIN















   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);

   DECLARE v_Posted BOOLEAN;
   DECLARE v_PostDate DATETIME;
   DECLARE v_GLTransNumber NATIONAL VARCHAR(36);
   DECLARE v_VendorID NATIONAL VARCHAR(50);
   DECLARE v_Amount DECIMAL(19,4);
   DECLARE v_ConvertedAmount DECIMAL(19,4);
   DECLARE v_CurrencyID NATIONAL VARCHAR(3);
   DECLARE v_CompanyCurrencyID NATIONAL VARCHAR(3);
   DECLARE v_CurrencyExchangeRate FLOAT;
   DECLARE v_PostCOA BOOLEAN;
   DECLARE v_ProjectID NATIONAL VARCHAR(36);
   DECLARE v_GLBankAccount NATIONAL VARCHAR(36);
   DECLARE v_GLAPAccount NATIONAL VARCHAR(36);
   DECLARE v_PaymentDate DATETIME;
   DECLARE v_ErrorID INT;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
   END;
   select   IFNULL(Posted,0), IFNULL(Amount,0), VendorID, CurrencyID, GLBankAccount, IFNULL(PaymentDate,CURRENT_TIMESTAMP), CurrencyExchangeRate INTO v_Posted,v_Amount,v_VendorID,v_CurrencyID,v_GLBankAccount,v_PaymentDate,
   v_CurrencyExchangeRate FROM
   PaymentsHeader WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   PaymentID = v_PaymentID;


   SET v_GLBankAccount = IFNULL(v_GLBankAccount,(SELECT BankAccount
   FROM Companies
   WHERE CompanyID = v_CompanyID AND DivisionID  = v_DivisionID AND  DepartmentID = v_DepartmentID));



   IF v_Posted = 1 then

      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;
   end if;

   IF v_Amount = 0 then

      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;
   end if;

   SET @SWV_Error = 0;
   CALL VerifyCurrency(v_CompanyID,v_DivisionID,v_DepartmentID,v_PaymentDate,2,v_CompanyCurrencyID,
   v_CurrencyID,v_CurrencyExchangeRate);
   IF @SWV_Error <> 0 then

	
      SET v_ErrorMessage = 'Currency retrieving failed';
      ROLLBACK;


      DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;
      IF v_ErrorMessage <> '' then

	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payment_Post',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PaymentID',v_PaymentID);
      end if;
      SET SWP_Ret_Value = -1;
   end if;

   select   ProjectID INTO v_ProjectID FROM PaymentsDetail WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   PaymentID = v_PaymentID AND
   NOT ProjectID IS NULL   LIMIT 1;



   select   PeriodPosting INTO v_PostDate FROM
   Companies WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID;


   START TRANSACTION;

   SET v_ConvertedAmount = fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,v_Amount*v_CurrencyExchangeRate, 
   v_CompanyCurrencyID);

   SET @SWV_Error = 0;
   SET v_ReturnStatus = GetNextEntityID(v_CompanyID,v_DivisionID,v_DepartmentID,'NextGLTransNumber',v_GLTransNumber);
   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then

      SET v_ErrorMessage = 'GetNextEntityID call failed';
      ROLLBACK;


      DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;
      IF v_ErrorMessage <> '' then

	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payment_Post',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PaymentID',v_PaymentID);
      end if;
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
	GLTransactionPostedYN,
	GLTransactionSystemGenerated,
	GLTransactionBalance,
	GLTransactionAmountUndistributed)
   SELECT
   v_CompanyID,
		v_DivisionID,
		v_DepartmentID,
		v_GLTransNumber,
		CASE PaymentTypeID WHEN 'Check' THEN 'Voucher' ELSE 'Voucher' END,
		CASE v_PostDate
   WHEN 1 THEN CURRENT_TIMESTAMP
   ELSE PaymentsHeader.PaymentDate
   END,
		VendorID,
		v_PaymentID,
		v_CompanyCurrencyID,
		1,
		v_ConvertedAmount,
		1,
		1,
		0,
		0
   FROM
   PaymentsHeader
   WHERE
   PaymentsHeader.CompanyID = v_CompanyID AND
   PaymentsHeader.DivisionID = v_DivisionID AND
   PaymentsHeader.DepartmentID = v_DepartmentID AND
   PaymentsHeader.PaymentID = v_PaymentID;

   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Insert into LedgerTransactions failed';
      ROLLBACK;


      DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;
      IF v_ErrorMessage <> '' then

	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payment_Post',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PaymentID',v_PaymentID);
      end if;
      SET SWP_Ret_Value = -1;
   end if;


   select   GLAPAccount INTO v_GLAPAccount FROM
   Companies WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID;

   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Updating GLExpenseAccount  in PaymentsDetail failed';
      ROLLBACK;


      DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;
      IF v_ErrorMessage <> '' then

	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payment_Post',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PaymentID',v_PaymentID);
      end if;
      SET SWP_Ret_Value = -1;
   end if;


   DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;



   CREATE TEMPORARY TABLE tt_LedgerDetailTmp  
   (
      GLTransactionNumberDetail BIGINT NOT NULL  PRIMARY KEY  AUTO_INCREMENT,
      GLTransactionAccount NATIONAL VARCHAR(36),
      GLDebitAmount DECIMAL(19,4),
      GLCreditAmount DECIMAL(19,4),
      ProjectID NATIONAL VARCHAR(36)
   )  AUTO_INCREMENT = 1;



   SET @SWV_Error = 0;
   INSERT INTO tt_LedgerDetailTmp(GLTransactionAccount ,
	GLDebitAmount,
	GLCreditAmount,
	ProjectID)(SELECT
      v_GLAPAccount,
	0,
	SUM(AppliedAmount*v_CurrencyExchangeRate),
	ProjectID
      FROM
      PaymentsDetail
      WHERE
      CompanyID = v_CompanyID AND
      DivisionID = v_DivisionID AND
      DepartmentID = v_DepartmentID AND
      PaymentID = v_PaymentID AND
      IFNULL(AppliedAmount,0) > 0
      GROUP BY
      ProjectID);

   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Error Processing AP Data';
      ROLLBACK;


      DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;
      IF v_ErrorMessage <> '' then

	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payment_Post',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PaymentID',v_PaymentID);
      end if;
      SET SWP_Ret_Value = -1;
   end if;



   SET @SWV_Error = 0;
   INSERT INTO tt_LedgerDetailTmp(GLTransactionAccount ,
	GLDebitAmount,
	GLCreditAmount,
	ProjectID)
   SELECT
   IFNULL(GLExpenseAccount,(SELECT GLAPMiscAccount
      FROM Companies
      WHERE CompanyID = v_CompanyID AND DivisionID  = v_DivisionID AND  DepartmentID = v_DepartmentID)),
	SUM(AppliedAmount*v_CurrencyExchangeRate),
	0,
	ProjectID
   FROM
   PaymentsDetail
   WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   PaymentID = v_PaymentID AND
   IFNULL(AppliedAmount,0) > 0
   GROUP BY GLExpenseAccount,ProjectID;

   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Error Processing Expense Data';
      ROLLBACK;


      DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;
      IF v_ErrorMessage <> '' then

	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payment_Post',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PaymentID',v_PaymentID);
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
   SELECT
   v_CompanyID,
		v_DivisionID,
		v_DepartmentID,
		v_GLTransNumber,
		GLTransactionAccount,
		SUM(IFNULL(GLDebitAmount,0)),
		SUM(IFNULL(GLCreditAmount,0)),
		ProjectID
   FROM
   tt_LedgerDetailTmp
   GROUP BY
   GLTransactionAccount,ProjectID;

   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Insert into LedgerTransactionsDetail failed';
      ROLLBACK;


      DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;
      IF v_ErrorMessage <> '' then

	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payment_Post',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PaymentID',v_PaymentID);
      end if;
      SET SWP_Ret_Value = -1;
   end if;


   DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;


   SET @SWV_Error = 0;
   SET v_ReturnStatus = LedgerTransactions_PostCOA_AllRecords(v_CompanyID,v_DivisionID,v_DepartmentID,v_GLTransNumber);
   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then

      SET v_ErrorMessage = 'LedgerTransactions_PostCOA_AllRecords call failed';
      ROLLBACK;


      DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;
      IF v_ErrorMessage <> '' then

	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payment_Post',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PaymentID',v_PaymentID);
      end if;
      SET SWP_Ret_Value = -1;
   end if;


   COMMIT;
   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;









   ROLLBACK;


   DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;
   IF v_ErrorMessage <> '' then

	
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payment_Post',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PaymentID',v_PaymentID);
   end if;
   SET SWP_Ret_Value = -1;
END