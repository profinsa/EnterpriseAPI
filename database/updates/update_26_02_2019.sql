DELIMITER //
DROP PROCEDURE IF EXISTS Receipt_Post2;
//
CREATE                 PROCEDURE Receipt_Post2(v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_ReceiptID NATIONAL VARCHAR(36),
	INOUT v_Success INT  ,
	INOUT v_PostingResult NATIONAL VARCHAR(200) ,INOUT SWP_Ret_Value INT)
   SWL_return:
BEGIN











/*
Name of stored procedure: Receipt_Post
Method: 
	Posts a receipt into the system

Date Created: EDE - 07/28/2015

Input Parameters:

	@CompanyID NVARCHAR(36)		 - the ID of the company
	@DivisionID NVARCHAR(36)	 - the ID of the division
	@DepartmentID NVARCHAR(36)	 - the ID of the department
	@ReceiptID NVARCHAR(36)		 - the ID of the receipt

Output Parameters:

	@Success INT  			 - RETURN VALUES for the @Succes output parameter:

							   1 succes

							   0 error while processin data

							   2 error on geting time Period
	@PostingResult NVARCHAR(200)	 - the error message that should be displayed for end user

Called From:

	Invoice_Post, Receipt_Post.vb

Calls:

	Receipt_Recalc, Receipt_CreateGLTransaction, Receipt_AdjustCustomerFinancials, Project_ReCalc, Error_InsertError, Error_InsertErrorDetail

Last Modified: 

Last Modified By: 

Revision History: 

*/

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
   DECLARE v_ConvertedAmount DECIMAL(19,4);
   DECLARE v_TotalAppliedAmount DECIMAL(19,4);
   DECLARE v_ProjectID NATIONAL VARCHAR(36);
   DECLARE v_GLBankAccount NATIONAL VARCHAR(36);
   DECLARE v_ErrorID INT;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
   END;

-- set the success flag to true
-- this flag will be changed if any error will occurr
-- in the procedure
   SET @SWV_Error = 0;
   SET v_Success = 1;
   SET v_ErrorMessage = '';



   IF NOT EXISTS(SELECT
   ReceiptID
   FROM
   ReceiptsDetail
   WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   ReceiptID = v_ReceiptID) then

      SET v_PostingResult = 'Receipt was not posted: there are no detail items';
      SET SWP_Ret_Value = -1;
      LEAVE SWL_return;
   end if;

   IF EXISTS(SELECT
   ReceiptID
   FROM
   ReceiptsDetail
   WHERE
   IFNULL(AppliedAmount,0) = 0 AND
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   ReceiptID = v_ReceiptID) then

      SET v_PostingResult = 'Receipt was not posted: there is the detail item with undefined AppliedAmount value';
      SET SWP_Ret_Value = -1;
      LEAVE SWL_return;
   end if;


   select   Posted INTO v_Posted FROM
   ReceiptsHeader WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   ReceiptID = v_ReceiptID;



   IF v_Posted = 1 then

      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;
   end if;


   START TRANSACTION;
   SET @SWV_Error = 0;
   CALL Receipt_Recalc2(v_CompanyID,v_DivisionID,v_DepartmentID,v_ReceiptID, v_ReturnStatus);
   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then

	-- the procedure will return an error code
      SET v_ErrorMessage = 'Receipt_Recalc call failed';
      ROLLBACK;
      IF v_Success <> 1 then

         SET v_Success = 0;
      end if;
      DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;
      IF v_ErrorMessage <> '' then

	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Receipt_Post',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'ReceiptID',v_ReceiptID);
      end if;
      SET SWP_Ret_Value = -1;
   end if;

   select   IFNULL(Amount,0) INTO v_Amount FROM
   ReceiptsHeader WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   ReceiptID = v_ReceiptID;

   IF v_Amount = 0 then -- Nothing to post

      SET v_PostingResult = 'Receipt was not posted: Receipt Amount = 0';
	
-- We do not begin transaction before jump to this point, so should not call ROLLBACK TRAN
      SET v_Success = 2;
      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;
-- if an error occured in the procedure this code will be executed
-- The information about the error are entered in the ErrrorLog and ErrorLogDetail tables.
-- The company, division, department informations are inserted in the ErrorLog table
-- along with information about the name of the procedure and the error message and an errorID is obtained.
-- The aditional information about other procedure parameters are inserted along with the errorID in the ErrorLogDetail table
-- (about the other parameters the name and the value are inserted).
   end if;

   SET @SWV_Error = 0;
   CALL Receipt_CreateGLTransaction(v_CompanyID,v_DivisionID,v_DepartmentID,v_ReceiptID, v_ReturnStatus);
   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then

	-- the procedure will return an error code
      SET v_ErrorMessage = 'Receipt_AdjustCustomerFinancials call failed';
      ROLLBACK;
      IF v_Success <> 1 then

         SET v_Success = 0;
      end if;
      DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;
      IF v_ErrorMessage <> '' then

	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Receipt_Post',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'ReceiptID',v_ReceiptID);
      end if;
      SET SWP_Ret_Value = -1;
   end if;

-- Period to post is closed already so we can't post the Receipt
   IF v_ReturnStatus = 1 then

      SET v_PostingResult = 'Receipt was not posted: Period to post is closed already';
	
-- We do not begin transaction before jump to this point, so should not call ROLLBACK TRAN
      SET v_Success = 2;
      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;
-- if an error occured in the procedure this code will be executed
-- The information about the error are entered in the ErrrorLog and ErrorLogDetail tables.
-- The company, division, department informations are inserted in the ErrorLog table
-- along with information about the name of the procedure and the error message and an errorID is obtained.
-- The aditional information about other procedure parameters are inserted along with the errorID in the ErrorLogDetail table
-- (about the other parameters the name and the value are inserted).
   end if;


-- Update fields in Customer Finasials table
   SET @SWV_Error = 0;
   CALL Receipt_AdjustCustomerFinancials(v_CompanyID,v_DivisionID,v_DepartmentID,v_ReceiptID, v_ReturnStatus);
   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then

	-- the procedure will return an error code
      SET v_ErrorMessage = 'Receipt_AdjustCustomerFinancials call failed';
      ROLLBACK;
      IF v_Success <> 1 then

         SET v_Success = 0;
      end if;
      DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;
      IF v_ErrorMessage <> '' then

	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Receipt_Post',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'ReceiptID',v_ReceiptID);
      end if;
      SET SWP_Ret_Value = -1;
   end if;

-- Update fields in Projects table
   SET @SWV_Error = 0;
   CALL Project_Recalc2(v_CompanyID,v_DivisionID,v_DepartmentID,v_ProjectID, v_ReturnStatus);
   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then

	-- the procedure will return an error code
      SET v_ErrorMessage = 'Project_ReCalc call failed';
      ROLLBACK;
      IF v_Success <> 1 then

         SET v_Success = 0;
      end if;
      DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;
      IF v_ErrorMessage <> '' then

	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Receipt_Post',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'ReceiptID',v_ReceiptID);
      end if;
      SET SWP_Ret_Value = -1;
   end if;


-- set posted flag for payment
   SET @SWV_Error = 0;
   UPDATE
   ReceiptsHeader
   SET
   Posted = 1,Status = 'Posted'
   WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   ReceiptID = v_ReceiptID;

   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Update ReceiptsHeader failed';
      ROLLBACK;
      IF v_Success <> 1 then

         SET v_Success = 0;
      end if;
      DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;
      IF v_ErrorMessage <> '' then

	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Receipt_Post',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'ReceiptID',v_ReceiptID);
      end if;
      SET SWP_Ret_Value = -1;
   end if;

   COMMIT;


   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;



-- We do not begin transaction before jump to this point, so should not call ROLLBACK TRAN
   SET v_Success = 2;
   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;
-- if an error occured in the procedure this code will be executed
-- The information about the error are entered in the ErrrorLog and ErrorLogDetail tables.
-- The company, division, department informations are inserted in the ErrorLog table
-- along with information about the name of the procedure and the error message and an errorID is obtained.
-- The aditional information about other procedure parameters are inserted along with the errorID in the ErrorLogDetail table
-- (about the other parameters the name and the value are inserted).
   ROLLBACK;


   IF v_Success <> 1 then

      SET v_Success = 0;
   end if;
   DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;

   IF v_ErrorMessage <> '' then

	
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Receipt_Post',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'ReceiptID',v_ReceiptID);
   end if;

   SET SWP_Ret_Value = -1;
END;



















//

DELIMITER ;

DELIMITER //
DROP PROCEDURE IF EXISTS Receipt_CreateGLTransaction;
//
CREATE                 PROCEDURE Receipt_CreateGLTransaction(v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_ReceiptID NATIONAL VARCHAR(36),INOUT SWP_Ret_Value INT)
   SWL_return:
BEGIN













/*
Name of stored procedure: Receipt_CreateGLTransaction
Method: 
	Posts a receipt LedgerTransactions table

Date Created: EDE - 07/28/2015

Input Parameters:

	@CompanyID NVARCHAR(36)		 - the ID of the company
	@DivisionID NVARCHAR(36)	 - the ID of the division
	@DepartmentID NVARCHAR(36)	 - the ID of the department
	@ReceiptID NVARCHAR(36)		 - the ID of the receipt

Output Parameters:

	NONE

Called From:

	Receipt_Post

Calls:

	LedgerMain_VerifyPeriod, VerifyCurrency, GetNextEntityID, LedgerTransactions_PostCOA_AllRecords, Error_InsertError, Error_InsertErrorDetail

Last Modified: 

Last Modified By: 

Revision History: 

*/

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

-- set the success flag to true
-- this flag will be changed if any error will occurr
-- in the procedure
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
         IF v_Amount = 0 then -- Nothing to post

            SET SWP_Ret_Value = 0;
            LEAVE SWL_return;
         end if;
         select   ProjectID INTO v_ProjectID FROM  ReceiptsDetail WHERE
         CompanyID = v_CompanyID
         AND DivisionID = v_DivisionID
         AND DepartmentID = v_DepartmentID
         AND ReceiptID = ReceiptID
         AND NOT ProjectID IS NULL   LIMIT 1;


-- get the post date for the company
         select   IFNULL(DefaultGLPostingDate,'1') INTO v_PostDate FROM
         Companies WHERE
         CompanyID = v_CompanyID AND
         DivisionID = v_DivisionID AND
         DepartmentID = v_DepartmentID;

-- begin the posting process
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

-- verify the Period of time
         SET v_ReturnStatus = LedgerMain_VerifyPeriod(v_CompanyID,v_DivisionID,v_DepartmentID,v_TranDate,v_PeriodToPost,v_PeriodClosed);
         IF v_PeriodClosed <> 0 OR v_ReturnStatus = -1 then
            SET SWP_Ret_Value = 1;
            LEAVE SWL_return;
         end if;
         SET @SWV_Error = 0;
         CALL VerifyCurrency2(v_CompanyID,v_DivisionID,v_DepartmentID,v_ReceiptDate,1,v_CompanyCurrencyID,
         v_CurrencyID,v_CurrencyExchangeRate);
         IF @SWV_Error <> 0 then

	-- the procedure will return an error code
            SET v_ErrorMessage = 'Currency retrieving failed';
            ROLLBACK;
            DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;
            IF v_ErrorMessage <> '' then

	
               CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Receipt_CreateGLTransaction',
               v_ErrorMessage,v_ErrorID);
               CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'ReceiptID',v_ReceiptID);
            end if;
            SET SWP_Ret_Value = -1;
         end if;
         START TRANSACTION;
-- get the transaction number
         SET @SWV_Error = 0;
         CALL GetNextEntityID2(v_CompanyID,v_DivisionID,v_DepartmentID,'NextGLTransNumber',v_GLTransNumber, SWP_Ret_Value);
         IF @SWV_Error <> 0 then

            SET v_ErrorMessage = 'GetNextEntityID call failed';
            ROLLBACK;
            DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;
            IF v_ErrorMessage <> '' then

	
               CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Receipt_CreateGLTransaction',
               v_ErrorMessage,v_ErrorID);
               CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'ReceiptID',v_ReceiptID);
            end if;
            SET SWP_Ret_Value = -1;
         end if;
         SET v_ConvertedAmount = fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,v_Amount*v_CurrencyExchangeRate, 
         v_CompanyCurrencyID);
-- Insert into LedgerTransactions the necessary entries
-- setting the transaction type to RECEIPT and
-- the post date as current date or transaction date depending
-- of the data from company table (@PostDate)
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
		CASE ReceiptTypeID WHEN 'Cash' THEN 'Cash Receipt'
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

	
               CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Receipt_CreateGLTransaction',
               v_ErrorMessage,v_ErrorID);
               CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'ReceiptID',v_ReceiptID);
            end if;
            SET SWP_Ret_Value = -1;
         end if;
         DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;


-- create temporary table for payment information
         CREATE TEMPORARY TABLE tt_LedgerDetailTmp  
         (
            GLTransactionNumberDetail BIGINT NOT NULL  PRIMARY KEY  AUTO_INCREMENT,
            GLTransactionAccount NATIONAL VARCHAR(36),
            GLDebitAmount DECIMAL(19,4),
            GLCreditAmount DECIMAL(19,4),
            ProjectID NATIONAL VARCHAR(36)
         )  AUTO_INCREMENT = 1;


-- Get additional company accounts
         select   GLARDiscountAccount, GLARWriteOffAccount, GLARAccount INTO v_DiscountAccount,v_WriteOffAccount,v_GLARAccount FROM Companies WHERE
         CompanyID = v_CompanyID AND
         DivisionID = v_DivisionID AND
         DepartmentID = v_DepartmentID;


-- Get total for Receipt
         select   SUM(fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,IFNULL(AppliedAmount,0),v_CompanyCurrencyID)) INTO v_TotalAppliedAmount FROM
         ReceiptsDetail WHERE
         CompanyID = v_CompanyID AND
         DivisionID = v_DivisionID AND
         DepartmentID = v_DepartmentID AND
         ReceiptID = v_ReceiptID AND
         IFNULL(AppliedAmount,0) > 0;
         SET v_TotalAppliedAmount = IFNULL(v_TotalAppliedAmount,0);
         IF ABS(v_TotalAppliedAmount -v_Amount) > 0.05 then

	-- Patial payment is posted using simplified scheme
            IF v_TotalAppliedAmount > v_Amount then
	
		-- insert into TransactionsDetail the records from ReceiptsDetail
		-- Debit Receipt Amount to Bank Account
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

	
                     CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Receipt_CreateGLTransaction',
                     v_ErrorMessage,v_ErrorID);
                     CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'ReceiptID',v_ReceiptID);
                  end if;
                  SET SWP_Ret_Value = -1;
               end if;
		
		
		-- Credit Receipt amount to Account Receivable
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

	
                     CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Receipt_CreateGLTransaction',
                     v_ErrorMessage,v_ErrorID);
                     CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'ReceiptID',v_ReceiptID);
                  end if;
                  SET SWP_Ret_Value = -1;
               end if;
               LEAVE TransactionFinish;
            end if;
         end if;
-- insert into TransactionsDetail the records from ReceiptsDetail
-- Debit Receipt Amount to Bank Account
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

	
               CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Receipt_CreateGLTransaction',
               v_ErrorMessage,v_ErrorID);
               CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'ReceiptID',v_ReceiptID);
            end if;
            SET SWP_Ret_Value = -1;
         end if;


-- Credit Receipt amount from Account Receivable
         SET @SWV_Error = 0;
         INSERT INTO tt_LedgerDetailTmp(GLTransactionAccount ,
	GLDebitAmount,
	GLCreditAmount,
	ProjectID)
         SELECT
         Companies.GLARAccount,
	0,
	SUM(fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,AppliedAmount*v_CurrencyExchangeRate, 
         v_CompanyCurrencyID)),
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

	
               CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Receipt_CreateGLTransaction',
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

	-- Debit DiscountTaken to GLARDiscountAccount
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

	
                  CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Receipt_CreateGLTransaction',
                  v_ErrorMessage,v_ErrorID);
                  CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'ReceiptID',v_ReceiptID);
               end if;
               SET SWP_Ret_Value = -1;
            end if;
	
	-- Credit DiscountTaken from AR Account
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

	
                  CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Receipt_CreateGLTransaction',
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

	-- Debit WriteOffAmount to GLARWriteOffAccount
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

	
                  CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Receipt_CreateGLTransaction',
                  v_ErrorMessage,v_ErrorID);
                  CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'ReceiptID',v_ReceiptID);
               end if;
               SET SWP_Ret_Value = -1;
            end if;
	
	-- Credit WriteOffAmount from Account Receivable
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

	
                  CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Receipt_CreateGLTransaction',
                  v_ErrorMessage,v_ErrorID);
                  CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'ReceiptID',v_ReceiptID);
               end if;
               SET SWP_Ret_Value = -1;
            end if;
         end if;

-- insert the information in the LedgerTransactionsDetail group by GLTransactionAccount, CurrencyID, CurrencyExchangeRate
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

	
            CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Receipt_CreateGLTransaction',
            v_ErrorMessage,v_ErrorID);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'ReceiptID',v_ReceiptID);
         end if;
         SET SWP_Ret_Value = -1;
      end if;

/*
update the information in the Ledger Chart of Accounts fro the accounts of the newly inserted transaction

parameters	@CompanyID NVARCHAR(36),
		@DivisionID NVARCHAR(36),
		@DepartmentID NVARCHAR(36),
		@GLTransNumber NVARCHAR (36)
		used to identify the TRANSACTION
		@PostCOA BIT - used in the process of creation of the transaction
*/
      SET @SWV_Error = 0;
      CALL LedgerTransactions_PostCOA_AllRecords2(v_CompanyID,v_DivisionID,v_DepartmentID,v_GLTransNumber, v_ReturnStatus);
      IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then

         SET v_ErrorMessage = 'LedgerTransactions_PostCOA_AllRecords call failed';
         ROLLBACK;
         DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;
         IF v_ErrorMessage <> '' then

	
            CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Receipt_CreateGLTransaction',
            v_ErrorMessage,v_ErrorID);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'ReceiptID',v_ReceiptID);
         end if;
         SET SWP_Ret_Value = -1;
      end if;

-- drop temporary table used for ledger details
      DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;
      COMMIT;
      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;


-- if an error occured in the procedure this code will be executed
-- The information about the error are entered in the ErrrorLog and ErrorLogDetail tables.
-- The company, division, department informations are inserted in the ErrorLog table
-- along with information about the name of the procedure and the error message and an errorID is obtained.
-- The aditional information about other procedure parameters are inserted along with the errorID in the ErrorLogDetail table
-- (about the other parameters the name and the value are inserted).
   END;
   ROLLBACK;


   DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;

   IF v_ErrorMessage <> '' then

	
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Receipt_CreateGLTransaction',
      v_ErrorMessage,v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'ReceiptID',v_ReceiptID);
   end if;

   SET SWP_Ret_Value = -1;
END;











//

DELIMITER ;

DELIMITER //
DROP PROCEDURE IF EXISTS Receipt_AdjustCustomerFinancials;
//
CREATE      PROCEDURE Receipt_AdjustCustomerFinancials(v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_ReceiptID  NATIONAL VARCHAR(36),INOUT SWP_Ret_Value INT)
   SWL_return:
BEGIN












/*
Name of stored procedure: Receipt_AdjustCustomerFinancials
Method: 
	Updates fields in the Customer Financials Table
	LateDays Difference between payment date and due date based on terms
	AverageDaytoPay - there will already be a number here, the default is zero, so use that to calculate new average days to pay, check first to see if its a zero or a one, and if the current days to pay is zero or one then don't do the update, just leave it zero or one, because this means that this is a cash and carry or an e-commerce business.
	LastPaymentDate - Date of payment
	LastPaymentAmount - Amount of this payment
	PromptPerc - How often they are on time
	PaymentsYTD - Payments YTD = Payments YTD + This payment.

Date Created: EDE - 07/28/2015

Input Parameters:

	@CompanyID NVARCHAR(36)		 - the ID of the company
	@DivisionID NVARCHAR(36)	 - the ID of the division
	@DepartmentID NVARCHAR(36)	 - the ID of the department
	@ReceiptID NVARCHAR (36)	 - the ID of the receipt

Output Parameters:

	NONE

Called From:

	Receipt_Post, ServiceReceipt_Post

Calls:

	VerifyCurrency, Error_InsertError, Error_InsertErrorDetail

Last Modified: 

Last Modified By: 

Revision History: 

*/

   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);

   DECLARE v_CustomerID NATIONAL VARCHAR(50);
   DECLARE v_CurrencyID NATIONAL VARCHAR(3);
   DECLARE v_CompanyCurrencyID NATIONAL VARCHAR(3);
   DECLARE v_CurrencyExchangeRate FLOAT;
   DECLARE v_ReceiptDate DATETIME;
   DECLARE v_Amount DECIMAL(19,4);
   DECLARE v_ConvertedAmount DECIMAL(19,4);
   DECLARE v_AverageDaytoPay INT;
   DECLARE v_LateDays INT;
   DECLARE v_PromptPerc FLOAT;
   DECLARE v_PaymentDate DATETIME;
   DECLARE v_DueDate DATETIME;
   DECLARE v_OnTimePaymentCount INT;
   DECLARE v_TotalPaymentCount INT;
   DECLARE v_TotalDayToPay INT;

-- select informations about the customer,
-- the total value of the order
-- the currency of the order and the exchange rate
   DECLARE v_LastPaymentDate DATETIME;
   DECLARE v_LastReceiptID NATIONAL VARCHAR(36);
   DECLARE v_LastPaymentAmount DECIMAL(19,4);
   DECLARE v_ErrorID INT;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
   END;
   select   CustomerID, Amount, CurrencyID, CurrencyExchangeRate, OrderDate, TransactionDate, IFNULL(DueToDate,TransactionDate) INTO v_CustomerID,v_Amount,v_CurrencyID,v_CurrencyExchangeRate,v_ReceiptDate,
   v_PaymentDate,v_DueDate FROM
   ReceiptsHeader WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND ReceiptID = v_ReceiptID;

   START TRANSACTION;

-- adjust the system to for the multicurrency 
   SET @SWV_Error = 0;
   CALL VerifyCurrency2(v_CompanyID,v_DivisionID,v_DepartmentID,v_ReceiptDate,1,v_CompanyCurrencyID,
   v_CurrencyID,v_CurrencyExchangeRate);
   IF @SWV_Error <> 0 then

	-- the procedure will return an error code
      SET v_ErrorMessage = 'Currency retrieving failed';
      ROLLBACK;
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Receipt_AdjustCustomerFinancials',
      v_ErrorMessage,v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'ReceiptID',v_ReceiptID);
      SET SWP_Ret_Value = -1;
   end if;

   SET v_ConvertedAmount = fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,v_Amount*v_CurrencyExchangeRate, 
   v_CompanyCurrencyID);


-- LateDays Difference between payment date and due date based on terms
   select   MAX(TIMESTAMPDIFF(Day,TransactionDate,IFNULL(DueToDate,TransactionDate))) INTO v_LateDays FROM
   ReceiptsHeader WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND CustomerID = v_CustomerID
   AND LOWER(IFNULL(ReceiptsHeader.ReceiptClassID,N'')) <> LOWER('Vendor') -- Do not take RMA into account here
   AND Posted = 1;

   IF IFNULL(v_LateDays,0) <= 0 then

      SET v_LateDays = 0;
   end if;
-- AverageDaytoPay - Difference between payment date and order date
   select   ROUND(AVG(TIMESTAMPDIFF(DAY,IFNULL(OrderDate,TransactionDate),TransactionDate)),0) INTO v_AverageDaytoPay FROM
   ReceiptsHeader WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND CustomerID = v_CustomerID
   AND LOWER(IFNULL(ReceiptsHeader.ReceiptClassID,N'')) <> LOWER('Vendor') -- Do not take RMA into account here
   AND Posted = 1;

   SET v_AverageDaytoPay = IFNULL(v_AverageDaytoPay,-1);


-- LastPaymentDate - Date of last closed payment
   select   TransactionDate, ReceiptID INTO v_LastPaymentDate,v_LastReceiptID FROM
   ReceiptsHeader WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND CustomerID = v_CustomerID
   AND LOWER(IFNULL(ReceiptsHeader.ReceiptClassID,N'')) <> LOWER('Vendor') -- Do not take RMA into account here
   AND Posted = 1   ORDER BY TransactionDate,ReceiptID DESC LIMIT 1;

-- LastPaymentAmount - Amount of last payment
   select   Amount, IFNULL(CurrencyExchangeRate,1) INTO v_Amount,v_CurrencyExchangeRate FROM
   ReceiptsHeader WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND ReceiptID = v_LastReceiptID;

   SET v_LastPaymentAmount = fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,IFNULL(v_Amount,0)*IFNULL(v_CurrencyExchangeRate,1), 
   v_CompanyCurrencyID);


-- PromptPerc - How often payments are on time
   select   IFNULL(Count(ReceiptID),0) INTO v_OnTimePaymentCount FROM
   ReceiptsHeader WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND CustomerID = v_CustomerID
   AND Posted = 1
   AND LOWER(IFNULL(ReceiptsHeader.ReceiptClassID,N'')) <> LOWER('Vendor') -- Do not take RMA into account here
   AND TIMESTAMPDIFF(Day,TransactionDate,IFNULL(DueToDate,TransactionDate)) >= 0;

   select   IFNULL(Count(ReceiptID),0) INTO v_TotalPaymentCount FROM
   ReceiptsHeader WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND CustomerID = v_CustomerID
   AND Posted = 1
   AND LOWER(IFNULL(ReceiptsHeader.ReceiptClassID,N'')) <> LOWER('Vendor'); -- Do not take RMA into account here

   IF IFNULL(v_TotalPaymentCount,0) > 0 then
      SET v_PromptPerc = cast(IFNULL(v_OnTimePaymentCount,0) as DECIMAL(15,15))/IFNULL(v_TotalPaymentCount,1);
   end if;
   SET @SWV_Error = 0;
   UPDATE
   CustomerFinancials
   SET
   LateDays = v_LateDays,AverageDaytoPay = v_AverageDaytoPay,LastPaymentDate = v_PaymentDate,
   LastPaymentAmount = v_ConvertedAmount,PromptPerc = v_PromptPerc,
   PaymentsYTD = IFNULL(PaymentsYTD,0)+v_ConvertedAmount
   WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND CustomerID = v_CustomerID;

   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'customer financials updating failed';
      ROLLBACK;
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Receipt_AdjustCustomerFinancials',
      v_ErrorMessage,v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'ReceiptID',v_ReceiptID);
      SET SWP_Ret_Value = -1;
   end if;


   COMMIT;
   SET SWP_Ret_Value = 0;
   LEAVE SWL_return; 
-- if an error occured in the procedure this code will be executed
-- The information about the error are entered in the ErrrorLog and ErrorLogDetail tables.
-- The company, division, department informations are inserted in the ErrorLog table
-- along with information about the name of the procedure and the error message and an errorID is obtained.
-- The aditional information about other procedure parameters are inserted along with the errorID in the ErrorLogDetail table
-- (about the other parameters the name and the value are inserted).
   ROLLBACK;

   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Receipt_AdjustCustomerFinancials',
   v_ErrorMessage,v_ErrorID);

   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'ReceiptID',v_ReceiptID);

   SET SWP_Ret_Value = -1;
END;














//

DELIMITER ;
