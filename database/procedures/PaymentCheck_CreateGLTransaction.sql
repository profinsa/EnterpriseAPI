CREATE PROCEDURE PaymentCheck_CreateGLTransaction (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_PaymentID NATIONAL VARCHAR(20),
	v_PostDate NATIONAL VARCHAR(1),INOUT SWP_Ret_Value INT) SWL_return:
BEGIN
















   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);
   DECLARE v_ReturnStatus SMALLINT;

   DECLARE v_CurrencyID NATIONAL VARCHAR(3);
   DECLARE v_CurrencyExchangeRate FLOAT;
   DECLARE v_CurrencyExchangeRateNew FLOAT;
   DECLARE v_PaymentDate DATETIME;
   DECLARE v_ValueDate DATETIME;
   DECLARE v_AppliedAmount DECIMAL(19,4);
   DECLARE v_OldAmount DECIMAL(19,4);
   DECLARE v_NewAmount DECIMAL(19,4);
   DECLARE v_GainLossAmount DECIMAL(19,4);
   DECLARE v_GLTransNumber NATIONAL VARCHAR(36);
   DECLARE v_GLBankAccount NATIONAL VARCHAR(36);
   DECLARE v_GLAPAccount NATIONAL VARCHAR(36);
   DECLARE v_GLAPCashAccount NATIONAL VARCHAR(36);
   DECLARE v_GLGainLossAccount NATIONAL VARCHAR(36);
   DECLARE v_BankTransNumber NATIONAL VARCHAR(36);
   DECLARE v_CheckNumber NATIONAL VARCHAR(20);
   DECLARE v_VendorID NATIONAL VARCHAR(60);
   DECLARE v_ProjectID NATIONAL VARCHAR(36);
   DECLARE v_CompanyCurrencyID NATIONAL VARCHAR(3);
   DECLARE v_DocumentNumber NATIONAL VARCHAR(36);
   DECLARE v_CheckDate DATETIME;


   DECLARE v_DiscountAccount NATIONAL VARCHAR(36);
   DECLARE v_WriteOffAccount NATIONAL VARCHAR(36);


   DECLARE v_ErrorID INT;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN

  

       SET @SWV_Error = 1;
   END;
   SET @SWV_Error = 0;
   START TRANSACTION;


   select   CurrencyID, CurrencyExchangeRate, PaymentDate, CheckNumber, VendorID, GLBankAccount, IFNULL(CreditAmount,Amount) INTO v_CurrencyID,v_CurrencyExchangeRate,v_PaymentDate,v_CheckNumber,v_VendorID,
   v_GLBankAccount,v_AppliedAmount FROM
   PaymentsHeader WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   PaymentID = v_PaymentID AND
   IFNULL(CheckPrinted,0) = 0 AND
   IFNULL(Paid,0) = 0; 


   SET v_GLBankAccount = IFNULL(v_GLBankAccount,(SELECT BankAccount
   FROM Companies
   WHERE CompanyID = v_CompanyID AND DivisionID  = v_DivisionID AND  DepartmentID = v_DepartmentID));



   IF ROW_COUNT() = 0 then
      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;
   end if;

   select   ProjectID INTO v_ProjectID FROM  PaymentsDetail WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND PaymentID = v_PaymentID
   AND NOT ProjectID IS NULL   LIMIT 1;



   SET @SWV_Error = 0;
   CALL GetNextEntityID2(v_CompanyID,v_DivisionID,v_DepartmentID,'NextGLTransNumber',v_GLTransNumber, v_ReturnStatus);
   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then

      SET v_ErrorMessage = 'GetNextEntityID call failed';
      ROLLBACK;


      DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;


      DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp1;


      CALL Error_InsertError(v_CompanyID,'','','PaymentCheck_CreateGLTransaction',v_ErrorMessage,v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PaymentID',v_PaymentID);
      SET SWP_Ret_Value = -1;
   end if; 

   SET v_ValueDate = CURRENT_TIMESTAMP;
   SET @SWV_Error = 0;
   CALL VerifyCurrency2(v_CompanyID,v_DivisionID,v_DepartmentID,v_ValueDate,2,v_CompanyCurrencyID,
   v_CurrencyID,v_CurrencyExchangeRateNew);
   IF @SWV_Error <> 0 then

	
      SET v_ErrorMessage = 'Currency retrieving failed';
      ROLLBACK;


      DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;


      DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp1;


      CALL Error_InsertError(v_CompanyID,'','','PaymentCheck_CreateGLTransaction',v_ErrorMessage,v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PaymentID',v_PaymentID);
      SET SWP_Ret_Value = -1;
   end if;


   SET v_OldAmount = fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,v_AppliedAmount*v_CurrencyExchangeRate, 
   v_CompanyCurrencyID);
   SET v_NewAmount = fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,v_AppliedAmount*v_CurrencyExchangeRateNew, 
   v_CompanyCurrencyID);
   SET v_GainLossAmount = v_OldAmount -v_NewAmount;


   SET @SWV_Error = 0;
   INSERT INTO LedgerTransactions(CompanyID,
	DivisionID,
	DepartmentID,
	GLTransactionNumber,
	GLTransactionTypeID,
	GLTransactionDate,
	GLTransactionDescription,
	GLTransactionReference,
	GLTransactionSource,
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
		'Check',
		CASE v_PostDate WHEN '1' THEN CURRENT_TIMESTAMP ELSE PaymentDate END,
		VendorID,
		v_PaymentID,
		v_CheckNumber,
		v_CompanyCurrencyID,
		1,
		v_OldAmount,
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

      SET v_ErrorMessage = 'Insert Header into LedgerTransactions failed';
      ROLLBACK;


      DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;


      DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp1;


      CALL Error_InsertError(v_CompanyID,'','','PaymentCheck_CreateGLTransaction',v_ErrorMessage,v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PaymentID',v_PaymentID);
      SET SWP_Ret_Value = -1;
   end if;


   CREATE TEMPORARY TABLE tt_LedgerDetailTmp  
   (
      GLTransactionNumberDetail BIGINT NOT NULL  PRIMARY KEY  AUTO_INCREMENT,
      GLTransactionAccount NATIONAL VARCHAR(36),
      GLDebitAmount DECIMAL(19,4),
      GLCreditAmount DECIMAL(19,4),
      ProjectID NATIONAL VARCHAR(36) 
   )  AUTO_INCREMENT = 1;

   select   GLAPDiscountAccount, GLAPWriteOffAccount, GLAPAccount, GLAPCashAccount, GLCurrencyGainLossAccount INTO v_DiscountAccount,v_WriteOffAccount,v_GLAPAccount,v_GLAPCashAccount,v_GLGainLossAccount FROM Companies WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID;




   IF v_OldAmount > 0.005 then

      SET @SWV_Error = 0;
      INSERT INTO tt_LedgerDetailTmp(GLTransactionAccount ,
		GLDebitAmount,
		GLCreditAmount,
		ProjectID)
		VALUES(v_GLBankAccount,
			0,
			v_OldAmount,
			v_ProjectID);
	
      IF @SWV_Error <> 0 then
	
         SET v_ErrorMessage = 'Insert Cash into LedgerTransactionsDetail failed';
         ROLLBACK;


         DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;


         DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp1;


         CALL Error_InsertError(v_CompanyID,'','','PaymentCheck_CreateGLTransaction',v_ErrorMessage,v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PaymentID',v_PaymentID);
         SET SWP_Ret_Value = -1;
      end if;
   end if;


   IF v_OldAmount > 0.005 then

      SET @SWV_Error = 0;
      INSERT INTO tt_LedgerDetailTmp(GLTransactionAccount,
		GLDebitAmount,
		GLCreditAmount,
		ProjectID)
		VALUES(v_GLAPAccount,
			v_OldAmount,
			0,
			v_ProjectID);
	
      IF @SWV_Error <> 0 then
	
         SET v_ErrorMessage = 'Insert AP into LedgerTransactionsDetail failed';
         ROLLBACK;


         DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;


         DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp1;


         CALL Error_InsertError(v_CompanyID,'','','PaymentCheck_CreateGLTransaction',v_ErrorMessage,v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PaymentID',v_PaymentID);
         SET SWP_Ret_Value = -1;
      end if;
   end if;
	
   IF EXISTS(SELECT DiscountTaken
   FROM
   PaymentsDetail
   WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   PaymentID = v_PaymentID AND
   IFNULL(DiscountTaken,0) > 0) then

	
      SET @SWV_Error = 0;
      INSERT INTO tt_LedgerDetailTmp(GLTransactionAccount ,
		GLDebitAmount,
		GLCreditAmount,
		ProjectID)
      SELECT
      v_DiscountAccount,
		0,
		SUM(fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,DiscountTaken*v_CurrencyExchangeRate, 
      v_CompanyCurrencyID)),
		v_ProjectID
      FROM
      PaymentsDetail
      WHERE
      CompanyID = v_CompanyID AND
      DivisionID = v_DivisionID AND
      DepartmentID = v_DepartmentID AND
      PaymentID = v_PaymentID AND
      IFNULL(DiscountTaken,0) > 0;
      IF @SWV_Error <> 0 then
	
         SET v_ErrorMessage = 'Insert into LedgerTransactionsDetail failed';
         ROLLBACK;


         DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;


         DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp1;


         CALL Error_InsertError(v_CompanyID,'','','PaymentCheck_CreateGLTransaction',v_ErrorMessage,v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PaymentID',v_PaymentID);
         SET SWP_Ret_Value = -1;
      end if;
		
	
      SET @SWV_Error = 0;
      INSERT INTO tt_LedgerDetailTmp(GLTransactionAccount ,
		GLDebitAmount,
		GLCreditAmount,
		ProjectID)
      SELECT
      v_GLAPAccount,
		SUM(fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,DiscountTaken*v_CurrencyExchangeRate, 
      v_CompanyCurrencyID)),
		0,
		v_ProjectID
      FROM
      PaymentsDetail
      WHERE
      CompanyID = v_CompanyID AND
      DivisionID = v_DivisionID AND
      DepartmentID = v_DepartmentID AND
      PaymentID = v_PaymentID AND
      IFNULL(DiscountTaken,0) > 0;
      IF @SWV_Error <> 0 then
	
         SET v_ErrorMessage = 'Error Processing AP Discount Data';
         ROLLBACK;


         DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;


         DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp1;


         CALL Error_InsertError(v_CompanyID,'','','PaymentCheck_CreateGLTransaction',v_ErrorMessage,v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PaymentID',v_PaymentID);
         SET SWP_Ret_Value = -1;
      end if;
   end if;
	
   IF EXISTS(SELECT WriteOffAmount
   FROM
   PaymentsDetail
   WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   PaymentID = v_PaymentID AND
   IFNULL(WriteOffAmount,0) > 0) then

	
      SET @SWV_Error = 0;
      INSERT INTO tt_LedgerDetailTmp(GLTransactionAccount ,
		GLDebitAmount,
		GLCreditAmount,
		ProjectID)
      SELECT
      v_GLAPAccount,
		SUM(fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,WriteOffAmount*v_CurrencyExchangeRate, 
      v_CompanyCurrencyID)),
		0,
		v_ProjectID
      FROM
      PaymentsDetail
      WHERE
      PaymentsDetail.CompanyID = v_CompanyID AND
      PaymentsDetail.DivisionID = v_DivisionID AND
      PaymentsDetail.DepartmentID = v_DepartmentID AND
      PaymentsDetail.PaymentID = v_PaymentID AND
      IFNULL(WriteOffAmount,0) > 0;
      IF @SWV_Error <> 0 then
	
         SET v_ErrorMessage = 'Error Processing Write off AP Data';
         ROLLBACK;


         DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;


         DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp1;


         CALL Error_InsertError(v_CompanyID,'','','PaymentCheck_CreateGLTransaction',v_ErrorMessage,v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PaymentID',v_PaymentID);
         SET SWP_Ret_Value = -1;
      end if;
	
	
      SET @SWV_Error = 0;
      INSERT INTO tt_LedgerDetailTmp(GLTransactionAccount ,
		GLDebitAmount,
		GLCreditAmount,
		ProjectID)
      SELECT
      v_WriteOffAccount,
		0,
		SUM(fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,WriteOffAmount*v_CurrencyExchangeRate, 
      v_CompanyCurrencyID)),
		v_ProjectID
      FROM
      PaymentsDetail
      WHERE
      CompanyID = v_CompanyID AND
      DivisionID = v_DivisionID AND
      DepartmentID = v_DepartmentID AND
      PaymentID = v_PaymentID AND
      IFNULL(WriteOffAmount,0) > 0;
      IF @SWV_Error <> 0 then
	
         SET v_ErrorMessage = 'Error Processing Write Off GL Data';
         ROLLBACK;


         DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;


         DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp1;


         CALL Error_InsertError(v_CompanyID,'','','PaymentCheck_CreateGLTransaction',v_ErrorMessage,v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PaymentID',v_PaymentID);
         SET SWP_Ret_Value = -1;
      end if;
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
		SUM(GLDebitAmount),
		SUM(GLCreditAmount),
		ProjectID
   FROM
   tt_LedgerDetailTmp
   GROUP BY
   GLTransactionAccount,ProjectID;

   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Insert into LedgerTransactionsDetail failed';
      ROLLBACK;


      DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;


      DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp1;


      CALL Error_InsertError(v_CompanyID,'','','PaymentCheck_CreateGLTransaction',v_ErrorMessage,v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PaymentID',v_PaymentID);
      SET SWP_Ret_Value = -1;
   end if;
	

   SET @SWV_Error = 0;
   CALL LedgerTransactions_PostCOA_AllRecords2(v_CompanyID,v_DivisionID,v_DepartmentID,v_GLTransNumber, v_ReturnStatus);
   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then

      SET v_ErrorMessage = 'LedgerTransactions_PostCOA_AllRecords call failed';
      ROLLBACK;


      DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;


      DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp1;


      CALL Error_InsertError(v_CompanyID,'','','PaymentCheck_CreateGLTransaction',v_ErrorMessage,v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PaymentID',v_PaymentID);
      SET SWP_Ret_Value = -1;
   end if;



   DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;





   IF ABS(v_GainLossAmount) >= 0.005 then

		
      SET @SWV_Error = 0;
      SET v_ReturnStatus = GetNextEntityID(v_CompanyID,v_DivisionID,v_DepartmentID,'NextGLTransNumber',v_GLTransNumber);
      IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then
		
         SET v_ErrorMessage = 'GetNextEntityID call failed';
         ROLLBACK;


         DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;


         DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp1;


         CALL Error_InsertError(v_CompanyID,'','','PaymentCheck_CreateGLTransaction',v_ErrorMessage,v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PaymentID',v_PaymentID);
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
			GLTransactionSource,
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
				'XRate Adj',
				CASE v_PostDate WHEN '1' THEN CURRENT_TIMESTAMP ELSE PaymentDate END,
				VendorID,
				v_PaymentID,
				v_CheckNumber,
				v_CompanyCurrencyID,
				1,
				ABS(v_GainLossAmount),
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
		
         SET v_ErrorMessage = 'Insert Header into LedgerTransactions failed';
         ROLLBACK;


         DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;


         DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp1;


         CALL Error_InsertError(v_CompanyID,'','','PaymentCheck_CreateGLTransaction',v_ErrorMessage,v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PaymentID',v_PaymentID);
         SET SWP_Ret_Value = -1;
      end if;
		
		
      CREATE TEMPORARY TABLE tt_LedgerDetailTmp1  
      (
         GLTransactionNumberDetail BIGINT NOT NULL  PRIMARY KEY  AUTO_INCREMENT,
         GLTransactionAccount NATIONAL VARCHAR(36),
         GLDebitAmount DECIMAL(19,4),
         GLCreditAmount DECIMAL(19,4),
         ProjectID NATIONAL VARCHAR(36) 
      )  AUTO_INCREMENT = 1;
      SET @SWV_Error = 0;
      INSERT INTO tt_LedgerDetailTmp1(GLTransactionAccount,
			GLDebitAmount,
			GLCreditAmount,
			ProjectID)
			VALUES(CASE WHEN v_GainLossAmount > 0 THEN v_GLAPAccount ELSE v_GLAPCashAccount END,
				CASE WHEN v_GainLossAmount > 0 THEN v_GainLossAmount ELSE 0 END,
				CASE WHEN v_GainLossAmount < 0 THEN(-1)*v_GainLossAmount ELSE 0 END,
				v_ProjectID);
		
      IF @SWV_Error <> 0 then
		
         SET v_ErrorMessage = 'Insert Gain Loss into LedgerTransactionsDetail failed';
         ROLLBACK;


         DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;


         DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp1;


         CALL Error_InsertError(v_CompanyID,'','','PaymentCheck_CreateGLTransaction',v_ErrorMessage,v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PaymentID',v_PaymentID);
         SET SWP_Ret_Value = -1;
      end if;
      SET @SWV_Error = 0;
      INSERT INTO tt_LedgerDetailTmp1(GLTransactionAccount,
			GLDebitAmount,
			GLCreditAmount,
			ProjectID)
			VALUES(v_GLGainLossAccount,
				CASE WHEN v_GainLossAmount < 0 THEN(-1)*v_GainLossAmount ELSE 0 END,
				CASE WHEN v_GainLossAmount > 0 THEN v_GainLossAmount ELSE 0 END,
				v_ProjectID);
		
      IF @SWV_Error <> 0 then
		
         SET v_ErrorMessage = 'Insert Gain Loss into LedgerTransactionsDetail failed';
         ROLLBACK;


         DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;


         DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp1;


         CALL Error_InsertError(v_CompanyID,'','','PaymentCheck_CreateGLTransaction',v_ErrorMessage,v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PaymentID',v_PaymentID);
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
				SUM(GLDebitAmount),
				SUM(GLCreditAmount),
				ProjectID
      FROM
      tt_LedgerDetailTmp1
      GROUP BY
      GLTransactionAccount,ProjectID;
      IF @SWV_Error <> 0 then
		
         SET v_ErrorMessage = 'Insert into LedgerTransactionsDetail failed';
         ROLLBACK;


         DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;


         DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp1;


         CALL Error_InsertError(v_CompanyID,'','','PaymentCheck_CreateGLTransaction',v_ErrorMessage,v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PaymentID',v_PaymentID);
         SET SWP_Ret_Value = -1;
      end if;

		
      SET @SWV_Error = 0;
      SET v_ReturnStatus = LedgerTransactions_PostCOA_AllRecords(v_CompanyID,v_DivisionID,v_DepartmentID,v_GLTransNumber);
      IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then
		
         SET v_ErrorMessage = 'LedgerTransactions_PostCOA_AllRecords call failed';
         ROLLBACK;


         DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;


         DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp1;


         CALL Error_InsertError(v_CompanyID,'','','PaymentCheck_CreateGLTransaction',v_ErrorMessage,v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PaymentID',v_PaymentID);
         SET SWP_Ret_Value = -1;
      end if;

		
      DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp1;
   end if;		







   COMMIT;
   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;








   ROLLBACK;


   DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;


   DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp1;


   CALL Error_InsertError(v_CompanyID,'','','PaymentCheck_CreateGLTransaction',v_ErrorMessage,v_ErrorID);

   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PaymentID',v_PaymentID);

   SET SWP_Ret_Value = -1;
END