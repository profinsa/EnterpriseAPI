CREATE PROCEDURE ServiceReceipt_CreateGLTransaction (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_ReceiptID NATIONAL VARCHAR(36),INOUT SWP_Ret_Value INT) SWL_return:
BEGIN















   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);

   DECLARE v_PostDate NATIONAL VARCHAR(1);
   DECLARE v_PeriodToPost INT;
   DECLARE v_PeriodClosed INT;
   DECLARE v_TranDate DATETIME;
   DECLARE v_GLTransNumber NATIONAL VARCHAR(36);
   DECLARE v_GLARCashAccount NATIONAL VARCHAR(36);
   DECLARE v_CurrencyID NATIONAL VARCHAR(3);
   DECLARE v_CompanyCurrencyID NATIONAL VARCHAR(3);
   DECLARE v_CurrencyExchangeRate FLOAT;
   DECLARE v_ReceiptDate DATETIME;
   DECLARE v_CustomerID NATIONAL VARCHAR(50);
   DECLARE v_PostCOA BOOLEAN;
   DECLARE v_Posted BOOLEAN;
   DECLARE v_Amount DECIMAL(19,4);
   DECLARE v_TotalAppliedAmount DECIMAL(19,4);
   DECLARE v_ProjectID NATIONAL VARCHAR(36);
   DECLARE v_GLBankAccount NATIONAL VARCHAR(36);
   DECLARE v_GLARAccount NATIONAL VARCHAR(36);




   DECLARE v_ConvertedAmount DECIMAL(19,4);
   DECLARE v_DiscountAccount NATIONAL VARCHAR(36);
   DECLARE v_WriteOffAccount NATIONAL VARCHAR(36);
   DECLARE v_ErrorID INT;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
   END;
   BEGIN
      TransactionFinish:
      BEGIN
         SET @SWV_Error = 0;
         SET v_ErrorMessage = '';
         select   Posted, IFNULL(Amount,0), CustomerID, GLBankAccount, CurrencyID, CurrencyExchangeRate, OrderDate INTO v_Posted,v_Amount,v_CustomerID,v_GLBankAccount,v_CurrencyID,v_CurrencyExchangeRate,
         v_ReceiptDate FROM
         ReceiptsHeader WHERE
         CompanyID = v_CompanyID AND
         DivisionID = v_DivisionID AND
         DepartmentID = v_DepartmentID AND
         ReceiptID = v_ReceiptID;
         IF v_Posted = 1 then

            SET SWP_Ret_Value = 0;
            LEAVE SWL_return;
         end if;
         IF v_Amount = 0 then 

            SET SWP_Ret_Value = 0;
            LEAVE SWL_return;
         end if;
         select   ProjectID INTO v_ProjectID FROM  ReceiptsDetail WHERE
         CompanyID = v_CompanyID
         AND DivisionID = v_DivisionID
         AND DepartmentID = v_DepartmentID
         AND ReceiptID = ReceiptID
         AND NOT ProjectID IS NULL   LIMIT 1;



         select   IFNULL(DefaultGLPostingDate,'1') INTO v_PostDate FROM
         Companies WHERE
         CompanyID = v_CompanyID AND
         DivisionID = v_DivisionID AND
         DepartmentID = v_DepartmentID;


         IF v_PostDate = '1' then
            SET v_TranDate = CURRENT_TIMESTAMP;
         ELSE
            select   TransactionDate INTO v_TranDate FROM
            ReceiptsHeader WHERE
            CompanyID = v_CompanyID AND
            DivisionID = v_DivisionID AND
            DepartmentID = v_DepartmentID AND
            ReceiptID = v_ReceiptID;
         end if;


         SET v_ReturnStatus = LedgerMain_VerifyPeriod(v_CompanyID,v_DivisionID,v_DepartmentID,v_TranDate,v_PeriodToPost,v_PeriodClosed);
         IF v_PeriodClosed <> 0 OR v_ReturnStatus = -1 then
            SET SWP_Ret_Value = 1;
            LEAVE SWL_return;
         end if;
         SET @SWV_Error = 0;
         CALL VerifyCurrency(v_CompanyID,v_DivisionID,v_DepartmentID,v_ReceiptDate,1,v_CompanyCurrencyID,
         v_CurrencyID,v_CurrencyExchangeRate);
         IF @SWV_Error <> 0 then

	
            SET v_ErrorMessage = 'Currency retrieving failed';
            ROLLBACK;
            DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;
            IF v_ErrorMessage <> '' then

	
               CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'ServiceReceipt_CreateGLTransaction',
               v_ErrorMessage,v_ErrorID);
               CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'ReceiptID',v_ReceiptID);
            end if;
            SET SWP_Ret_Value = -1;
         end if;
         START TRANSACTION;

         SET @SWV_Error = 0;
         CALL GetNextEntityID(v_CompanyID,v_DivisionID,v_DepartmentID,'NextGLTransNumber',v_GLTransNumber);
         IF @SWV_Error <> 0 then

            SET v_ErrorMessage = 'GetNextEntityID call failed';
            ROLLBACK;
            DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;
            IF v_ErrorMessage <> '' then

	
               CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'ServiceReceipt_CreateGLTransaction',
               v_ErrorMessage,v_ErrorID);
               CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'ReceiptID',v_ReceiptID);
            end if;
            SET SWP_Ret_Value = -1;
         end if;
         SET v_ConvertedAmount = fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,v_Amount*v_CurrencyExchangeRate, 
         v_CompanyCurrencyID);




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
		CASE ReceiptTypeID WHEN 'Cash' THEN 'Cash'
         ELSE 'Check'
         END,
		CASE v_PostDate WHEN '1' THEN CURRENT_TIMESTAMP ELSE TransactionDate END,
		v_CustomerID,
		v_ReceiptID,
		v_CompanyCurrencyID,
		1,
		v_ConvertedAmount,
		1,
		1,
		0,
		0
         FROM
         ReceiptsHeader
         WHERE
         CompanyID = v_CompanyID AND
         DivisionID = v_DivisionID AND
         DepartmentID = v_DepartmentID AND
         ReceiptID = v_ReceiptID;
         IF @SWV_Error <> 0 then

            SET v_ErrorMessage = 'Insert into LedgerTransactions failed';
            ROLLBACK;
            DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;
            IF v_ErrorMessage <> '' then

	
               CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'ServiceReceipt_CreateGLTransaction',
               v_ErrorMessage,v_ErrorID);
               CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'ReceiptID',v_ReceiptID);
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



         select   GLARDiscountAccount, GLARWriteOffAccount, GLARAccount INTO v_DiscountAccount,v_WriteOffAccount,v_GLARAccount FROM Companies WHERE
         CompanyID = v_CompanyID AND
         DivisionID = v_DivisionID AND
         DepartmentID = v_DepartmentID;



         select   SUM(AppliedAmount) INTO v_TotalAppliedAmount FROM
         ReceiptsDetail WHERE
         CompanyID = v_CompanyID AND
         DivisionID = v_DivisionID AND
         DepartmentID = v_DepartmentID AND
         ReceiptID = v_ReceiptID AND
         IFNULL(AppliedAmount,0) > 0;
         SET v_TotalAppliedAmount = IFNULL(v_TotalAppliedAmount,0);
         IF ABS(v_TotalAppliedAmount -v_Amount) > 0.05 then

	
            IF v_TotalAppliedAmount > v_Amount then
	
		
		
               SET @SWV_Error = 0;
               INSERT INTO tt_LedgerDetailTmp(GLTransactionAccount ,
			GLDebitAmount,
			GLCreditAmount,
			ProjectID)
		VALUES(v_GLBankAccount,
			v_ConvertedAmount,
			0,
			v_ProjectID);
		
               IF @SWV_Error <> 0 then
		
                  SET v_ErrorMessage = 'Error Processing Data';
                  ROLLBACK;
                  DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;
                  IF v_ErrorMessage <> '' then

	
                     CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'ServiceReceipt_CreateGLTransaction',
                     v_ErrorMessage,v_ErrorID);
                     CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'ReceiptID',v_ReceiptID);
                  end if;
                  SET SWP_Ret_Value = -1;
               end if;
		
		
		
               SET @SWV_Error = 0;
               INSERT INTO tt_LedgerDetailTmp(GLTransactionAccount ,
			GLDebitAmount,
			GLCreditAmount,
			ProjectID)
		VALUES(v_GLARAccount,
			0,
			v_ConvertedAmount,
			v_ProjectID);
		
               IF @SWV_Error <> 0 then
		
                  SET v_ErrorMessage = 'Error Processing Data';
                  ROLLBACK;
                  DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;
                  IF v_ErrorMessage <> '' then

	
                     CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'ServiceReceipt_CreateGLTransaction',
                     v_ErrorMessage,v_ErrorID);
                     CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'ReceiptID',v_ReceiptID);
                  end if;
                  SET SWP_Ret_Value = -1;
               end if;
               LEAVE TransactionFinish;
            end if;
         end if;


         SET @SWV_Error = 0;
         INSERT INTO tt_LedgerDetailTmp(GLTransactionAccount ,
	GLDebitAmount,
	GLCreditAmount,
	ProjectID)
         SELECT
         v_GLBankAccount,
		SUM(fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,AppliedAmount*v_CurrencyExchangeRate, 
         v_CompanyCurrencyID)),
		0,
		ProjectID
         FROM
         ReceiptsDetail
         WHERE
         CompanyID = v_CompanyID AND
         DivisionID = v_DivisionID AND
         DepartmentID = v_DepartmentID AND
         ReceiptID = v_ReceiptID AND
         IFNULL(AppliedAmount,0) > 0
         GROUP BY ProjectID;
         IF @SWV_Error <> 0 then

            SET v_ErrorMessage = 'Error Processing Data';
            ROLLBACK;
            DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;
            IF v_ErrorMessage <> '' then

	
               CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'ServiceReceipt_CreateGLTransaction',
               v_ErrorMessage,v_ErrorID);
               CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'ReceiptID',v_ReceiptID);
            end if;
            SET SWP_Ret_Value = -1;
         end if;



         SET @SWV_Error = 0;
         INSERT INTO tt_LedgerDetailTmp(GLTransactionAccount ,
	GLDebitAmount,
	GLCreditAmount,
	ProjectID)
         SELECT
         Companies.GLARAccount,
	0,
	SUM(AppliedAmount*v_CurrencyExchangeRate),
	ProjectID
         FROM
         ReceiptsDetail INNER JOIN Companies ON
         ReceiptsDetail.CompanyID = Companies.CompanyID AND
         ReceiptsDetail.DivisionID = Companies.DivisionID AND
         ReceiptsDetail.DepartmentID = Companies.DepartmentID
         WHERE
         ReceiptsDetail.CompanyID = v_CompanyID AND
         ReceiptsDetail.DivisionID = v_DivisionID AND
         ReceiptsDetail.DepartmentID = v_DepartmentID AND
         ReceiptsDetail.ReceiptID = v_ReceiptID AND
         IFNULL(AppliedAmount,0) > 0
         GROUP BY Companies.GLARAccount,ProjectID;
         IF @SWV_Error <> 0 then

            SET v_ErrorMessage = 'Error Processing Data';
            ROLLBACK;
            DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;
            IF v_ErrorMessage <> '' then

	
               CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'ServiceReceipt_CreateGLTransaction',
               v_ErrorMessage,v_ErrorID);
               CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'ReceiptID',v_ReceiptID);
            end if;
            SET SWP_Ret_Value = -1;
         end if;
         IF EXISTS(SELECT DiscountTaken
         FROM
         ReceiptsDetail
         WHERE
         CompanyID = v_CompanyID AND
         DivisionID = v_DivisionID AND
         DepartmentID = v_DepartmentID AND
         ReceiptID = v_ReceiptID AND
         IFNULL(DiscountTaken,0) > 0) then

	
            SET @SWV_Error = 0;
            INSERT INTO tt_LedgerDetailTmp(GLTransactionAccount ,
		GLDebitAmount,
		GLCreditAmount,
		ProjectID)
            SELECT
            v_DiscountAccount,
		SUM(fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,DiscountTaken*v_CurrencyExchangeRate, 
            v_CompanyCurrencyID)),
		0,
		ProjectID
            FROM
            ReceiptsDetail
            WHERE
            ReceiptsDetail.CompanyID = v_CompanyID AND
            ReceiptsDetail.DivisionID = v_DivisionID AND
            ReceiptsDetail.DepartmentID = v_DepartmentID AND
            ReceiptsDetail.ReceiptID = v_ReceiptID AND
            IFNULL(DiscountTaken,0) > 0
            GROUP BY
            ProjectID;
            IF @SWV_Error <> 0 then
	
               SET v_ErrorMessage = 'Error Processing Data';
               ROLLBACK;
               DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;
               IF v_ErrorMessage <> '' then

	
                  CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'ServiceReceipt_CreateGLTransaction',
                  v_ErrorMessage,v_ErrorID);
                  CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'ReceiptID',v_ReceiptID);
               end if;
               SET SWP_Ret_Value = -1;
            end if;
	
	
            SET @SWV_Error = 0;
            INSERT INTO tt_LedgerDetailTmp(GLTransactionAccount ,
		GLDebitAmount,
		GLCreditAmount,
		ProjectID)
            SELECT
            v_GLARAccount,
		0,
		SUM(fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,DiscountTaken*v_CurrencyExchangeRate, 
            v_CompanyCurrencyID)),
		ProjectID
            FROM
            ReceiptsDetail
            WHERE
            ReceiptsDetail.CompanyID = v_CompanyID AND
            ReceiptsDetail.DivisionID = v_DivisionID AND
            ReceiptsDetail.DepartmentID = v_DepartmentID AND
            ReceiptsDetail.ReceiptID = v_ReceiptID AND
            IFNULL(DiscountTaken,0) > 0
            GROUP BY
            ProjectID;
            IF @SWV_Error <> 0 then
	
               SET v_ErrorMessage = 'Error Processing Data';
               ROLLBACK;
               DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;
               IF v_ErrorMessage <> '' then

	
                  CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'ServiceReceipt_CreateGLTransaction',
                  v_ErrorMessage,v_ErrorID);
                  CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'ReceiptID',v_ReceiptID);
               end if;
               SET SWP_Ret_Value = -1;
            end if;
         end if;
         IF EXISTS(SELECT WriteOffAmount
         FROM
         ReceiptsDetail
         WHERE
         CompanyID = v_CompanyID AND
         DivisionID = v_DivisionID AND
         DepartmentID = v_DepartmentID AND
         ReceiptID = v_ReceiptID AND
         IFNULL(WriteOffAmount,0) > 0) then

	
            SET @SWV_Error = 0;
            INSERT INTO tt_LedgerDetailTmp(GLTransactionAccount ,
		GLDebitAmount,
		GLCreditAmount,
		ProjectID)
            SELECT
            v_WriteOffAccount,
		SUM(fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,WriteOffAmount*v_CurrencyExchangeRate, 
            v_CompanyCurrencyID)),
		0,
		ProjectID
            FROM
            ReceiptsDetail
            WHERE
            ReceiptsDetail.CompanyID = v_CompanyID AND
            ReceiptsDetail.DivisionID = v_DivisionID AND
            ReceiptsDetail.DepartmentID = v_DepartmentID AND
            ReceiptsDetail.ReceiptID = v_ReceiptID AND
            IFNULL(WriteOffAmount,0) > 0
            GROUP BY
            ProjectID;
            IF @SWV_Error <> 0 then
	
               SET v_ErrorMessage = 'Error Processing Data';
               ROLLBACK;
               DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;
               IF v_ErrorMessage <> '' then

	
                  CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'ServiceReceipt_CreateGLTransaction',
                  v_ErrorMessage,v_ErrorID);
                  CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'ReceiptID',v_ReceiptID);
               end if;
               SET SWP_Ret_Value = -1;
            end if;
	
	
            SET @SWV_Error = 0;
            INSERT INTO tt_LedgerDetailTmp(GLTransactionAccount ,
		GLDebitAmount,
		GLCreditAmount,
		ProjectID)
            SELECT
            v_GLARAccount,
		0,
		SUM(fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,WriteOffAmount*v_CurrencyExchangeRate, 
            v_CompanyCurrencyID)),
		ProjectID
            FROM
            ReceiptsDetail
            WHERE
            ReceiptsDetail.CompanyID = v_CompanyID AND
            ReceiptsDetail.DivisionID = v_DivisionID AND
            ReceiptsDetail.DepartmentID = v_DepartmentID AND
            ReceiptsDetail.ReceiptID = v_ReceiptID AND
            IFNULL(WriteOffAmount,0) > 0
            GROUP BY
            ProjectID;
            IF @SWV_Error <> 0 then
	
               SET v_ErrorMessage = 'Error Processing Data';
               ROLLBACK;
               DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;
               IF v_ErrorMessage <> '' then

	
                  CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'ServiceReceipt_CreateGLTransaction',
                  v_ErrorMessage,v_ErrorID);
                  CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'ReceiptID',v_ReceiptID);
               end if;
               SET SWP_Ret_Value = -1;
            end if;
         end if;


         SET @SWV_Error = 0;
      END;
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

	
            CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'ServiceReceipt_CreateGLTransaction',
            v_ErrorMessage,v_ErrorID);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'ReceiptID',v_ReceiptID);
         end if;
         SET SWP_Ret_Value = -1;
      end if;


      SET @SWV_Error = 0;
      SET v_ReturnStatus = LedgerTransactions_PostCOA_AllRecords(v_CompanyID,v_DivisionID,v_DepartmentID,v_GLTransNumber);
      IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then

         SET v_ErrorMessage = 'LedgerTransactions_PostCOA_AllRecords call failed';
         ROLLBACK;
         DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;
         IF v_ErrorMessage <> '' then

	
            CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'ServiceReceipt_CreateGLTransaction',
            v_ErrorMessage,v_ErrorID);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'ReceiptID',v_ReceiptID);
         end if;
         SET SWP_Ret_Value = -1;
      end if;


      DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;
      COMMIT;
      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;








   END;
   ROLLBACK;


   DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;

   IF v_ErrorMessage <> '' then

	
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'ServiceReceipt_CreateGLTransaction',
      v_ErrorMessage,v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'ReceiptID',v_ReceiptID);
   end if;

   SET SWP_Ret_Value = -1;
END