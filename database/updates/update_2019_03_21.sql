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
         CALL LedgerMain_VerifyPeriod2(v_CompanyID,v_DivisionID,v_DepartmentID,v_TranDate,v_PeriodToPost,v_PeriodClosed, v_ReturnStatus);
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
DROP PROCEDURE IF EXISTS Purchase_Post2;
//
CREATE                          PROCEDURE Purchase_Post2(v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_PurchaseNumber NATIONAL VARCHAR(36),
	INOUT v_PostingResult NATIONAL VARCHAR(200) ,INOUT SWP_Ret_Value INT)
   SWL_return:
BEGIN
/*
Name of stored procedure: Purchase_Post
Method: 
	Posts a purchase order to the system and updates Vendor Financials

Date Created: EDE - 07/28/2015

Input Parameters:

	@CompanyID NVARCHAR(36)		 - the ID of the company
	@DivisionID NVARCHAR(36)	 - the ID of the division
	@DepartmentID NVARCHAR(36)	 - the ID of the department
	@PurchaseNumber NVARCHAR(36)	 - the number of purchase

Output Parameters:

	@PostingResult NVARCHAR(200)	 - the error message that should be displayed for end user

Called From:

	EDI_PurchaseProcessingOutbound, Purchase_Control, EDI_ShipmentNoticesProcessingInbound, Purchase_Post.vb

Calls:

	Inventory_GetWarehouseForPurchase, WarehouseBinPutGoods, VerifyCurrency, Terms_GetNetDays, Error_InsertError, Error_InsertErrorDetail

Last Modified: 

Last Modified By: 

Revision History: 

*/

   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);

   DECLARE v_GLTransNumber NATIONAL VARCHAR(36);
   DECLARE v_OrderWarehouseID NATIONAL VARCHAR(36);
   DECLARE v_DetailWarehouseID NATIONAL VARCHAR(36);
   DECLARE v_WarehouseBinID NATIONAL VARCHAR(36);
   DECLARE v_PurchaseDetailID CHAR(144);
   DECLARE v_ItemID NATIONAL VARCHAR(36);
   DECLARE v_OrderQty FLOAT;
   DECLARE v_SerialNumber NATIONAL VARCHAR(50);
   DECLARE v_PurchaseLineNumber NUMERIC(18,0);

   DECLARE v_CompanyCurrencyID NATIONAL VARCHAR(3);

   DECLARE v_Total DECIMAL(19,4);


   DECLARE v_VendorID NATIONAL VARCHAR(50);
   DECLARE v_VendorCurrencyID NATIONAL VARCHAR(3);
   DECLARE v_PurchaseCurrencyID NATIONAL VARCHAR(3);
   DECLARE v_PurchaseCurrencyExchangeRate FLOAT;
   DECLARE v_PurchaseDate DATETIME;
   DECLARE v_PurchaseAmount DECIMAL(19,4);
   DECLARE v_HighestCredit DECIMAL(19,4);
   DECLARE v_AvailableCredit DECIMAL(19,4);

   DECLARE v_PurchasePosted BOOLEAN;
   DECLARE v_PurchasePaid BOOLEAN;
   DECLARE v_PurchaseShipped BOOLEAN;
   DECLARE v_PurchaseReceived BOOLEAN;
   DECLARE v_PurchaseCancelDate DATETIME;
   DECLARE v_AmountPaid DECIMAL(19,4);
   DECLARE v_IncomeTaxRate FLOAT;

   DECLARE v_IsOverflow BOOLEAN;

   DECLARE v_TermsID NATIONAL VARCHAR(36);
   DECLARE v_NetDays INT;

   DECLARE v_ErrorID INT;
   DECLARE NO_DATA INT DEFAULT 0;
   DECLARE v_Success INT;
   DECLARE v_Amount FLOAT;
   DECLARE cPurchaseDetail CURSOR FOR
   SELECT
   PurchaseNumber,
		PurchaseLineNumber,
		ItemID, 

		WarehouseID, 
		WarehouseBinID,
		IFNULL(OrderQty,0),
		IFNULL(Total,0),
		SerialNumber
   FROM
   PurchaseDetail
   WHERE
   PurchaseNumber = v_PurchaseNumber AND
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID;

   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
      SET NO_DATA = -2;
   END;
   DECLARE CONTINUE HANDLER FOR NOT FOUND SET NO_DATA = -1;
   SET @SWV_Error = 0;
   IF NOT EXISTS(SELECT * FROM
   PurchaseDetail
   WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   PurchaseNumber = v_PurchaseNumber) then

      SET v_PostingResult = 'Purchase was not posted: there are no detail items';
      SET SWP_Ret_Value = -1;
      LEAVE SWL_return;
   end if;

   IF EXISTS(SELECT * FROM
   PurchaseDetail
   WHERE
		(IFNULL(OrderQty,0) = 0) AND -- OR ISNULL(ItemCost,0)=0) 
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   PurchaseNumber = v_PurchaseNumber) then

      SET v_PostingResult = 'Purchase was not posted: there is the detail item with zero Qty';
      SET SWP_Ret_Value = -1;
      LEAVE SWL_return;
   end if;
-- if purchase is posted return
   select   IFNULL(Posted,0), IFNULL(Received,0), PurchaseCancelDate, IFNULL(Paid,0), IFNULL(AmountPaid,0) INTO v_PurchasePosted,v_PurchaseReceived,v_PurchaseCancelDate,v_PurchasePaid,
   v_AmountPaid FROM
   PurchaseHeader WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   PurchaseNumber = v_PurchaseNumber;

   IF v_PurchasePosted <> 0 then

      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;
   end if;
-- if order is canceled
-- or order is not posted exit the procedure
   IF ((NOT v_PurchaseCancelDate IS NULL) AND v_PurchaseCancelDate < CURRENT_TIMESTAMP) then

      SET v_PostingResult = 'Purchase was not posted: Cancel date is older then current date.';
      SET SWP_Ret_Value = -1;
      LEAVE SWL_return;
   end if;

   IF EXISTS(SELECT * FROM
   PurchaseDetail
   WHERE
   IFNULL(ItemUnitPrice,0) = 0 AND
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   PurchaseNumber = v_PurchaseNumber) then

      SET v_PostingResult = 'Warning: there is the detail item with zero item unit price, but purchase was posted nevertheless.';
   end if;


   START TRANSACTION;
-- EXEC @ReturnStatus = Purchase_RecalcCLR @CompanyID, @DivisionID, @DepartmentID, @PurchaseNumber
   SET @SWV_Error = 0;
   CALL Purchase_Recalc2(v_CompanyID,v_DivisionID,v_DepartmentID,v_PurchaseNumber, v_ReturnStatus);
   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then

      SET v_ErrorMessage = 'Recalculating the purchase failed';
      ROLLBACK;
-- the error handler
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Purchase_Post',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseNumber',v_PurchaseNumber);
      SET SWP_Ret_Value = -1;
   end if;

-- credit the invenory
-- get the warehouse for the order
   SET @SWV_Error = 0;
   CALL Inventory_GetWarehouseForPurchase2(v_CompanyID,v_DivisionID,v_DepartmentID,v_PurchaseNumber,v_OrderWarehouseID, v_ReturnStatus);


   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then

      SET v_ErrorMessage = 'Inventory_GetWarehouseForPurchase call failed';
      ROLLBACK;
-- the error handler
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Purchase_Post',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseNumber',v_PurchaseNumber);
      SET SWP_Ret_Value = -1;
   end if;	

-- create cursor for iteration of purchase details	
   OPEN cPurchaseDetail;
   SET NO_DATA = 0;
   FETCH cPurchaseDetail INTO v_PurchaseDetailID,v_PurchaseLineNumber,v_ItemID,v_DetailWarehouseID,v_WarehouseBinID, 
   v_OrderQty,v_Total,v_SerialNumber;

   WHILE NO_DATA = 0 DO
      SET @SWV_Error = 0;
      CALL WarehouseBinPutGoods2(v_CompanyID,v_DivisionID,v_DepartmentID,v_DetailWarehouseID,v_WarehouseBinID,
      v_ItemID,v_PurchaseNumber,v_PurchaseLineNumber,v_SerialNumber,NULL,
      v_OrderQty,1,v_IsOverflow, v_ReturnStatus);
      IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then
	
         CLOSE cPurchaseDetail;
		
         SET v_ErrorMessage = 'WarehouseBinPutGoods failed';
         ROLLBACK;
-- the error handler
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Purchase_Post',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseNumber',v_PurchaseNumber);
         SET SWP_Ret_Value = -1;
      end if;
      SET NO_DATA = 0;
      FETCH cPurchaseDetail INTO v_PurchaseDetailID,v_PurchaseLineNumber,v_ItemID,v_DetailWarehouseID,v_WarehouseBinID, 
      v_OrderQty,v_Total,v_SerialNumber;
   END WHILE;

   CLOSE cPurchaseDetail;


-- get the purchase amount


-- get values from PurchaseHeader
   select   VendorID, IFNULL(Total,0), CurrencyID, CurrencyExchangeRate, PurchaseDate, IFNULL(IncomeTaxRate,0) INTO v_VendorID,v_PurchaseAmount,v_PurchaseCurrencyID,v_PurchaseCurrencyExchangeRate,
   v_PurchaseDate,v_IncomeTaxRate FROM
   PurchaseHeader WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   PurchaseNumber = v_PurchaseNumber;

   SET @SWV_Error = 0;
   CALL VerifyCurrency2(v_CompanyID,v_DivisionID,v_DepartmentID,v_PurchaseDate,2,v_CompanyCurrencyID,
   v_PurchaseCurrencyID,v_PurchaseCurrencyExchangeRate);
   IF @SWV_Error <> 0 then

	-- the procedure will return an error code
      SET v_ErrorMessage = 'Currency retrieving failed';
      ROLLBACK;
-- the error handler
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Purchase_Post',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseNumber',v_PurchaseNumber);
      SET SWP_Ret_Value = -1;
   end if;


-- transform if necessary (different currencies)
   IF v_PurchaseCurrencyID <> v_CompanyCurrencyID then

      SET v_PurchaseAmount = v_PurchaseAmount*v_PurchaseCurrencyExchangeRate;
   end if;
-- update vendor financials
   select   IFNULL(HighestCredit,0), IFNULL(AvailableCredit,0) INTO v_HighestCredit,v_AvailableCredit FROM
   VendorFinancials WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   VendorID = v_VendorID;

   SET v_AvailableCredit = v_AvailableCredit -v_PurchaseAmount;
   IF v_HighestCredit < v_AvailableCredit then
      SET v_HighestCredit = v_AvailableCredit;
   end if;

   SET @SWV_Error = 0;
   UPDATE
   VendorFinancials
   SET
   AvailableCredit = v_AvailableCredit,HighestCredit = v_HighestCredit,BookedPurchaseOrders = IFNULL(BookedPurchaseOrders,0)+v_PurchaseAmount
   WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   VendorID = v_VendorID;
   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Update VendorFinancials failed';
      ROLLBACK;
-- the error handler
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Purchase_Post',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseNumber',v_PurchaseNumber);
      SET SWP_Ret_Value = -1;
   end if;	

-- check special terms
   select   TermsID INTO v_TermsID FROM
   VendorInformation WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND VendorID = v_VendorID;

   SET @SWV_Error = 0;
   CALL Terms_GetNetDays2(v_CompanyID,v_DivisionID,v_DepartmentID,v_TermsID,v_NetDays);
   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Terms_GetNetDays the order failed';
      ROLLBACK;
-- the error handler
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Purchase_Post',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseNumber',v_PurchaseNumber);
      SET SWP_Ret_Value = -1;
   end if;



   SET @SWV_Error = 0;
   UPDATE PurchaseHeader
   SET
   PurchaseHeader.TermsID = v_TermsID,PurchaseHeader.PurchaseDueDate = TIMESTAMPADD(Day,v_NetDays,PurchaseDate)
   WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND PurchaseNumber = v_PurchaseNumber;
   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Checking special terms failed';
      ROLLBACK;
-- the error handler
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Purchase_Post',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseNumber',v_PurchaseNumber);
      SET SWP_Ret_Value = -1;
   end if;


   UPDATE
   PurchaseHeader
   SET
   Posted = 1,PostedDate = CURRENT_TIMESTAMP
   WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   PurchaseNumber = v_PurchaseNumber;


   IF (v_PurchaseReceived = 1) then

	
      SET @SWV_Error = 0;
      CALL Receiving_Post(v_CompanyID,v_DivisionID,v_DepartmentID,v_PurchaseNumber,v_Success);
      IF @SWV_Error <> 0 OR v_Success <> 1 then
	
         SET v_ErrorMessage = 'Receiving Post failed';
         ROLLBACK;
-- the error handler
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Purchase_Post',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseNumber',v_PurchaseNumber);
         SET SWP_Ret_Value = -1;
      end if;
   end if;


-- create IncomeTaxSection CreditMemo
   if v_IncomeTaxRate is not null and v_PurchaseAmount > 0 and v_IncomeTaxRate > 0 then

	
      set v_Amount = fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,v_PurchaseAmount*v_IncomeTaxRate/100, 
      v_CompanyCurrencyID);
      SET @SWV_Error = 0;
      SET v_ReturnStatus = CreditMemo_CreateIncomeTax(v_CompanyID,v_DivisionID,v_DepartmentID,v_PurchaseNumber,v_Amount);
      IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then
	
         SET v_ErrorMessage = 'Income Tax credit memo creation is failed';
         ROLLBACK;
-- the error handler
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Purchase_Post',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseNumber',v_PurchaseNumber);
         SET SWP_Ret_Value = -1;
      end if;
      SET @SWV_Error = 0;
      SET v_ReturnStatus = DebitMemo_CreateIncomeTax(v_CompanyID,v_DivisionID,v_DepartmentID,v_PurchaseNumber,v_Amount);
      IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then
	
         SET v_ErrorMessage = 'Income Tax credit memo creation is failed';
         ROLLBACK;
-- the error handler
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Purchase_Post',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseNumber',v_PurchaseNumber);
         SET SWP_Ret_Value = -1;
      end if;
   end if;

-- Everything is OK
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
-- the error handler
   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Purchase_Post',v_ErrorMessage,
   v_ErrorID);

   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseNumber',v_PurchaseNumber);
   SET SWP_Ret_Value = -1;
END;




//

DELIMITER ;

DELIMITER //
DROP PROCEDURE IF EXISTS Purchase_Recalc2;
//
CREATE          PROCEDURE Purchase_Recalc2(v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_PurchaseNumber  NATIONAL VARCHAR(36),INOUT SWP_Ret_Value INT)
   SWL_return:
BEGIN

















/*
Name of stored procedure: Purchase_Recalc
Method: 
	Calculates the amounts of money for a specified Purchase

Date Created: EDE - 07/28/2015

Input Parameters:

	@CompanyID NVARCHAR(36)		 - the ID of the company
	@DivisionID NVARCHAR(36)	 - the ID of the division
	@DepartmentID NVARCHAR(36)	 - the ID of the department
	@PurchaseNumber NVARCHAR (36)	 - used to identify the Purchase

Output Parameters:

	NONE

Called From:

	RMA_Split, Receiving_Post, Purchase_Split, Purchase_Recalc.vb

Calls:

	TaxGroup_GetTotalPercent, VerifyCurrency, Error_InsertError, Error_InsertErrorDetail

Last Modified: 

Last Modified By: 

Revision History: 

*/

   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);
   DECLARE v_CurrencyID NATIONAL VARCHAR(3);
   DECLARE v_CompanyCurrencyID NATIONAL VARCHAR(3);
   DECLARE v_CurrencyExchangeRate FLOAT;
   DECLARE v_PurchaseDate DATETIME;
   DECLARE v_Subtotal DECIMAL(19,4);
   DECLARE v_Total DECIMAL(19,4);
   DECLARE v_TotalTaxable DECIMAL(19,4);
   DECLARE v_DiscountPers FLOAT;
   DECLARE v_DiscountAmount DECIMAL(19,4);
   DECLARE v_TaxAmount DECIMAL(19,4);
   DECLARE v_ItemTaxAmount DECIMAL(19,4);
   DECLARE v_Freight DECIMAL(19,4);
   DECLARE v_Handling DECIMAL(19,4);
   DECLARE v_TaxFreight BOOLEAN;
   DECLARE v_Posted BOOLEAN;
   DECLARE v_Paid BOOLEAN;

   DECLARE v_TaxPercent FLOAT;
   DECLARE v_HeaderTaxPercent FLOAT;

   DECLARE v_ItemOrderQty FLOAT;
   DECLARE v_ItemUnitPrice FLOAT;
   DECLARE v_ItemTotal DECIMAL(19,4);
   DECLARE v_ItemSubtotal DECIMAL(19,4);
   DECLARE v_ItemDiscountPerc FLOAT;
   DECLARE v_ItemTaxable BOOLEAN;
   DECLARE v_TaxGroupID NATIONAL VARCHAR(36);
   DECLARE v_HeaderTaxGroupID NATIONAL VARCHAR(36);


   DECLARE v_tmp NATIONAL VARCHAR(100);
-- get the information about the order status
   DECLARE SWV_cPurchaseDetail_CompanyID NATIONAL VARCHAR(36);
   DECLARE SWV_cPurchaseDetail_DivisionID NATIONAL VARCHAR(36);
   DECLARE SWV_cPurchaseDetail_DepartmentID NATIONAL VARCHAR(36);
   DECLARE SWV_cPurchaseDetail_PurchaseNumber NATIONAL VARCHAR(36);
   DECLARE SWV_cPurchaseDetail_PurchaseLineNumber NUMERIC(18,0);
   DECLARE v_ErrorID INT;
   DECLARE NO_DATA INT DEFAULT 0;
   DECLARE cPurchaseDetail CURSOR 
   FOR SELECT 
   IFNULL(OrderQty,0),
		IFNULL(ItemUnitPrice,0),
		IFNULL(DiscountPerc,0),
		IFNULL(Taxable,0),
		IFNULL(TaxGroupID,N''), CompanyID,DivisionID,DepartmentID,PurchaseNumber,PurchaseLineNumber
   FROM 
   PurchaseDetail
   WHERE	
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND PurchaseNumber = v_PurchaseNumber;


   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
      SET NO_DATA = -2;
   END;
   DECLARE CONTINUE HANDLER FOR NOT FOUND SET NO_DATA = -1;
   SET @SWV_Error = 0;
   SET v_TaxPercent = 0;
   select   IFNULL(Posted,0), IFNULL(Paid,0) INTO v_Posted,v_Paid FROM
   PurchaseHeader WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   PurchaseNumber = v_PurchaseNumber;	

   IF v_Posted = 1 then

      IF v_Paid = 1 then 
	-- if the order is posted and Paid return
	
         SET SWP_Ret_Value = 0;
         LEAVE SWL_return;
      end if;
   end if;

-- get the currency id for the order header

   select   CurrencyID, CurrencyExchangeRate, PurchaseDate, IFNULL(DiscountPers,0), IFNULL(TaxFreight,0), IFNULL(Freight,0), IFNULL(Handling,0), TaxGroupID INTO v_CurrencyID,v_CurrencyExchangeRate,v_PurchaseDate,v_DiscountPers,v_TaxFreight,
   v_Freight,v_Handling,v_HeaderTaxGroupID FROM
   PurchaseHeader WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   PurchaseNumber = v_PurchaseNumber;

   START TRANSACTION;

   SET @SWV_Error = 0;
   CALL TaxGroup_GetTotalPercent2(v_CompanyID,v_DivisionID,v_DepartmentID,v_HeaderTaxGroupID,v_HeaderTaxPercent);
   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Procedure call TaxGroup_GetTotalPercent failed';
      ROLLBACK;
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Purchase_Recalc',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseNumber',v_PurchaseNumber);
      SET SWP_Ret_Value = -1;
   end if;

   SET v_HeaderTaxPercent = IFNULL(v_HeaderTaxPercent,0);

   SET @SWV_Error = 0;
   CALL VerifyCurrency2(v_CompanyID,v_DivisionID,v_DepartmentID,v_PurchaseDate,2,v_CompanyCurrencyID,
   v_CurrencyID,v_CurrencyExchangeRate);
   IF @SWV_Error <> 0 then

	-- the procedure will return an error code
      SET v_ErrorMessage = 'Currency retrieving failed';
      ROLLBACK;
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Purchase_Recalc',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseNumber',v_PurchaseNumber);
      SET SWP_Ret_Value = -1;
   end if;


-- get the details Totals
   SET v_Subtotal = 0;
   SET v_ItemSubtotal = 0;
   SET v_TotalTaxable = 0;
   SET v_DiscountAmount = 0;
   SET v_TaxAmount = 0;
   SET v_Total = 0;

-- open the cursor and get the first row
   OPEN cPurchaseDetail;
   SET NO_DATA = 0;
   FETCH cPurchaseDetail INTO  v_ItemOrderQty,v_ItemUnitPrice,v_ItemDiscountPerc,v_ItemTaxable,v_TaxGroupID,
   SWV_cPurchaseDetail_CompanyID,SWV_cPurchaseDetail_DivisionID,SWV_cPurchaseDetail_DepartmentID,
   SWV_cPurchaseDetail_PurchaseNumber,SWV_cPurchaseDetail_PurchaseLineNumber;
   WHILE NO_DATA = 0 DO
      SET v_TaxPercent = 0;
      SET v_ItemTaxAmount = 0;
	-- update totals
      SET v_ItemSubtotal = fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,v_ItemOrderQty*v_ItemUnitPrice, 
      v_CompanyCurrencyID);
      SET v_Subtotal = v_Subtotal+v_ItemSubtotal;
      SET v_DiscountAmount = fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,v_DiscountAmount+v_ItemOrderQty*v_ItemUnitPrice*v_ItemDiscountPerc/100,v_CompanyCurrencyID);
    	-- recalculate the Total for every line of the Order; the total for a line is = OrderQty * ItemUnitPrice * ( 100 - DiscountPerc )/100
      SET v_ItemTotal = fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,v_ItemOrderQty*v_ItemUnitPrice*(100 -v_ItemDiscountPerc)/100, 
      v_CompanyCurrencyID);
      IF v_TaxGroupID <> N'' then
	
         SET @SWV_Error = 0;
         CALL TaxGroup_GetTotalPercent(v_CompanyID,v_DivisionID,v_DepartmentID,v_TaxGroupID,v_TaxPercent);
         IF @SWV_Error <> 0 then
		
            SET v_ErrorMessage = 'Procedure call TaxGroup_GetTotalPercent failed';
            ROLLBACK;
            CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Purchase_Recalc',v_ErrorMessage,
            v_ErrorID);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseNumber',v_PurchaseNumber);
            SET SWP_Ret_Value = -1;
         end if;
      end if;
      SET v_Total = v_Total+v_ItemTotal;
      IF v_ItemTaxable = 1 then
	
         IF v_TaxGroupID = N'' then
		
            SET v_TaxGroupID = v_HeaderTaxGroupID;
            SET v_TaxPercent = v_HeaderTaxPercent;
         end if;
         SET v_ItemTaxAmount = fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,(v_ItemTotal*v_TaxPercent)/100, 
         v_CompanyCurrencyID);
         SET v_TaxAmount = v_TaxAmount+v_ItemTaxAmount;
         SET v_TotalTaxable = v_TotalTaxable+v_ItemTotal;
         SET v_ItemTotal = v_ItemTotal+v_ItemTaxAmount;
      end if;

	-- update item total
      SET @SWV_Error = 0;
      UPDATE PurchaseDetail
      SET
      Total = v_ItemTotal,SubTotal = v_ItemSubtotal,TaxPercent = v_TaxPercent,
      TaxGroupID = v_TaxGroupID,TaxAmount = v_ItemTaxAmount
      WHERE PurchaseDetail.CompanyID = SWV_cPurchaseDetail_CompanyID AND PurchaseDetail.DivisionID = SWV_cPurchaseDetail_DivisionID AND PurchaseDetail.DepartmentID = SWV_cPurchaseDetail_DepartmentID AND PurchaseDetail.PurchaseNumber = SWV_cPurchaseDetail_PurchaseNumber AND PurchaseDetail.PurchaseLineNumber = SWV_cPurchaseDetail_PurchaseLineNumber;
      IF @SWV_Error <> 0 then
	
         CLOSE cPurchaseDetail;
		
         SET v_ErrorMessage = 'Updating order detail failed';
         ROLLBACK;
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Purchase_Recalc',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseNumber',v_PurchaseNumber);
         SET SWP_Ret_Value = -1;
      end if;
      SET NO_DATA = 0;
      FETCH cPurchaseDetail INTO v_ItemOrderQty,v_ItemUnitPrice,v_ItemDiscountPerc,v_ItemTaxable,v_TaxGroupID,
      SWV_cPurchaseDetail_CompanyID,SWV_cPurchaseDetail_DivisionID,SWV_cPurchaseDetail_DepartmentID,
      SWV_cPurchaseDetail_PurchaseNumber,SWV_cPurchaseDetail_PurchaseLineNumber;
   END WHILE;
   CLOSE cPurchaseDetail;



   IF v_Handling > 0 then
      SET v_TaxAmount = fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,v_TaxAmount+v_Handling*v_HeaderTaxPercent/100, 
      v_CompanyCurrencyID);
   end if;
   IF v_Freight > 0 AND v_TaxFreight = 1 then
      SET v_TaxAmount = fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,v_TaxAmount+v_Freight*v_HeaderTaxPercent/100, 
      v_CompanyCurrencyID);
   end if;
   SET v_Total = v_Total+v_Handling+v_Freight+v_TaxAmount;

   SET @SWV_Error = 0;
   UPDATE
   PurchaseHeader
   SET
   Subtotal = v_Subtotal,DiscountAmount = v_DiscountAmount,TaxableSubTotal = v_TotalTaxable,
   TaxPercent = v_HeaderTaxPercent,TaxAmount = v_TaxAmount,
   Total = v_Total,BalanceDue = fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,v_Total -IFNULL(AmountPaid,0), 
   v_CompanyCurrencyID)
   WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND PurchaseNumber = v_PurchaseNumber;

   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Recalculating order header totals failed';
      ROLLBACK;
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Purchase_Recalc',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseNumber',v_PurchaseNumber);
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

   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Purchase_Recalc',v_ErrorMessage,
   v_ErrorID);

   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseNumber',v_PurchaseNumber);

   SET SWP_Ret_Value = -1;
END;



















//

DELIMITER ;

DELIMITER //
DROP PROCEDURE IF EXISTS WarehouseBinPutGoods2;
//
CREATE  PROCEDURE WarehouseBinPutGoods2(v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_WarehouseID NATIONAL VARCHAR(36),
	v_WarehouseBinID NATIONAL VARCHAR(36),
	v_InventoryItemID NATIONAL VARCHAR(36),
	v_PurchaseNumber NATIONAL VARCHAR(36),
	v_PurchaseLineNumber NUMERIC(18,0),
	v_SerialNumber NATIONAL VARCHAR(50),
	v_ReceivedDate DATETIME,
	v_Qty INT,
	v_Action INT,
	INOUT v_IsOverflow BOOLEAN ,INOUT SWP_Ret_Value INT)
   SWL_return:
BEGIN

/*
Name of stored procedure: WarehouseBinPutGoods
Method:
	this procedure put goods into warehouse bin
Date Created: EDE - 07/28/2015
Input Parameters:
	@CompanyID NVARCHAR(36)		 - the ID of the company
	@DivisionID NVARCHAR(36)	 - the ID of the division
	@DepartmentID NVARCHAR(36)	 - the ID of the department
	@WarehouseID NVARCHAR(36)	 - the ID of warehouse
	@WarehouseBinID NVARCHAR(36)	 - the ID of warehouse bin
	@InventoryItemID NVARCHAR(36)	 - the ID of inventory item
	@PurchaseNumber NVARCHAR(36)	 - the purchase number
	@PurchaseLineNumber NUMERIC(18	 - the detail purchase item ID
	@SerialNumber NVARCHAR(50)	 - serial number
	@ReceivedDate DATETIME		 - purchase receiving date
	@Qty INT			 - the inventory items count
	@Action INT			 - defines the operation that is performed with inventory items
							
1 - increase InventoryByWarehouse.QtyOnOrder in @Qty value used from Purchase_CreateFromBackOrders,Purchase_CreateFromOrder,Purchase_CreateFromReorder,Purchase_Post,RMA_Post procedures
2 - decrease InventoryByWarehouse.QtyOnOrder in @Qty value increase InventoryByWarehouse.QtyOnHand in @Qty value used from Receiving_AdjustInventory procedures
3 - decrease InventoryByWarehouse.QtyOnOrder in @Qty value used from DebitMemo_Cancel,Purchase_Cancel,RMA_Cancel procedures
4 - decrease InventoryByWarehouse.QtyOnHand in @Qty value used from DebitMemo_Cancel,Purchase_Cancel,RMA_Cancel procedures
5 - decrease InventoryByWarehouse.QtyOnHand in @Qty value not used from procedures
6 - increase InventoryByWarehouse.QtyOnHand in @Qty value used from Inventory_Assemblies,Inventory_Transfer procedures

   else - nothing

Output Parameters:
	@IsOverflow BIT 		 - retuns overflow status of the warehouse bit that accepts inventory
Called From:
	Purchase_CreateFromOrder, Inventory_Assemblies, Purchase_CreateFromBackOrders, RMA_Post, Purchase_Post, Purchase_Cancel, Purchase_CreateFromReorder, Inventory_Transfer, Receiving_AdjustInventory, RMA_Cancel, DebitMemo_Cancel
Calls:
	WarehouseBinGet, SerialNumber_Put, Error_InsertError, Error_InsertErrorDetail
Last Modified:
Last Modified By:
Revision History:
*/

   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);
   DECLARE v_QtyBin BIGINT;
   DECLARE v_AvailableEmpty BIGINT;
   DECLARE v_OverFlowBin NATIONAL VARCHAR(36);
   DECLARE v_ErrorID INT;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
   END;
      PutToBin: LOOP
         SET @SWV_Error = 0;
         IF v_Qty = 0 then
		
            SET SWP_Ret_Value = 0;
            LEAVE SWL_return;
         end if;
	-- check input parameters
         IF v_Qty < 0 then
		
            SET v_ErrorMessage = 'Wrong inventory quantity';
            ROLLBACK;
            CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'WarehouseBinPutGoods',v_ErrorMessage,
            v_ErrorID);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'WarehouseID',v_WarehouseID);
            SET SWP_Ret_Value = -1;
         end if;
	-- get default Warehouse
         SET @SWV_Error = 0;
         CALL WarehouseBinGet(v_CompanyID,v_DivisionID,v_DepartmentID,v_InventoryItemID,v_WarehouseID,
         v_WarehouseBinID, v_ReturnStatus);
         IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then
	
            SET v_ErrorMessage = 'Get default root warehouse bin failed';
            ROLLBACK;
            CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'WarehouseBinPutGoods',v_ErrorMessage,
            v_ErrorID);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'WarehouseID',v_WarehouseID);
            SET SWP_Ret_Value = -1;
         end if;
         START TRANSACTION;
      IF v_WarehouseBinID = 'Overflow' then
		
         IF(SELECT COUNT(*) FROM InventoryByWarehouse
         WHERE
         CompanyID = v_CompanyID AND
         DivisionID = v_DivisionID AND
         DepartmentID = v_DepartmentID AND
         ItemID = v_InventoryItemID AND
         WarehouseID = v_WarehouseID AND
         WarehouseBinID = v_WarehouseBinID) = 0 then
            SET @SWV_Error = 0;
            INSERT INTO InventoryByWarehouse(CompanyID,
							DivisionID,
							DepartmentID,
							ItemID,
							WarehouseID,
							WarehouseBinID,
							QtyOnHand,
							QtyCommitted,
							QtyOnOrder,
							QtyOnBackorder)
					VALUES(v_CompanyID,
							v_DivisionID,
							v_DepartmentID,
							v_InventoryItemID,
							v_WarehouseID,
							v_WarehouseBinID,
							0,
							0,
							0,
							0);
					
            IF @SWV_Error <> 0 then
					
               SET v_ErrorMessage = 'Insert InventoryByWarehouse bin failed';
               ROLLBACK;
               CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'WarehouseBinPutGoods',v_ErrorMessage,
               v_ErrorID);
               CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'WarehouseID',v_WarehouseID);
               SET SWP_Ret_Value = -1;
            end if;
         end if;
			-- put to bin
         SET @SWV_Error = 0;
         UPDATE InventoryByWarehouse
         SET
         QtyOnHand =
         CASE v_Action
         WHEN 1 THEN IFNULL(QtyOnHand,0)
         WHEN 2 THEN IFNULL(QtyOnHand,0)+v_Qty
         WHEN 3 THEN IFNULL(QtyOnHand,0)
         WHEN 4 THEN IFNULL(QtyOnHand,0) -v_Qty
         WHEN 5 THEN IFNULL(QtyOnHand,0) -v_Qty
         WHEN 6 THEN IFNULL(QtyOnHand,0)+v_Qty
         ELSE IFNULL(QtyOnHand,0)
         END,QtyOnOrder =
         CASE v_Action
         WHEN 1 THEN IFNULL(QtyOnOrder,0)+v_Qty
         WHEN 2 THEN IFNULL(QtyOnOrder,0) -v_Qty
         WHEN 3 THEN IFNULL(QtyOnOrder,0) -v_Qty
         WHEN 4 THEN IFNULL(QtyOnOrder,0)
         WHEN 5 THEN IFNULL(QtyOnOrder,0)
         WHEN 6 THEN IFNULL(QtyOnOrder,0)
         ELSE IFNULL(QtyOnOrder,0)
         END
         WHERE
         CompanyID = v_CompanyID AND
         DivisionID = v_DivisionID AND
         DepartmentID = v_DepartmentID AND
         ItemID = v_InventoryItemID AND
         WarehouseID = v_WarehouseID AND
         WarehouseBinID = v_WarehouseBinID;
         IF ROW_COUNT() <> 1 OR @SWV_Error <> 0 then
				
            SET v_ErrorMessage = 'Update InventoryByWarehouse bin failed';
            ROLLBACK;
            CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'WarehouseBinPutGoods',v_ErrorMessage,
            v_ErrorID);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'WarehouseID',v_WarehouseID);
            SET SWP_Ret_Value = -1;
         end if;
         IF v_Action = 2 then
				
            SET @SWV_Error = 0;
            SET v_ReturnStatus = SerialNumber_Put2(v_CompanyID,v_DivisionID,v_DepartmentID,v_WarehouseID,v_WarehouseBinID,
            v_PurchaseNumber,v_PurchaseLineNumber,v_SerialNumber,v_InventoryItemID,
            v_ReceivedDate,v_Qty);
            IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then
					-- An error occured, go to the error handler
					
               SET v_ErrorMessage = 'SerialNumber_Put call failed';
               ROLLBACK;
               CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'WarehouseBinPutGoods',v_ErrorMessage,
               v_ErrorID);
               CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'WarehouseID',v_WarehouseID);
               SET SWP_Ret_Value = -1;
            end if;
         end if;
         SET v_IsOverflow = 1;
      ELSE
			-- get quantity in bin
         select   IFNULL(SUM(cast(QtyOnHand as SIGNED INTEGER)),0)+IFNULL(SUM(cast(QtyCommitted as SIGNED INTEGER)),0) INTO v_QtyBin FROM InventoryByWarehouse WHERE
         CompanyID = v_CompanyID AND
         DivisionID = v_DivisionID AND
         DepartmentID = v_DepartmentID AND
         WarehouseID = v_WarehouseID AND
         WarehouseBinID = v_WarehouseBinID;
			-- check for overflow bin
         select   cast(IFNULL(MaximumQuantity,0) as SIGNED INTEGER) -v_QtyBin, IFNULL(NULLIF(RTRIM(OverFlowBin),''),'Overflow') INTO v_AvailableEmpty,v_OverFlowBin FROM WarehouseBins WHERE
         CompanyID = v_CompanyID AND
         DivisionID = v_DivisionID AND
         DepartmentID = v_DepartmentID AND
         WarehouseID = v_WarehouseID AND
         WarehouseBinID = v_WarehouseBinID;
         IF ROW_COUNT() = 0 OR @SWV_Error <> 0 then
				
            SET v_ErrorMessage = 'Get selected bin failed';
            ROLLBACK;
            CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'WarehouseBinPutGoods',v_ErrorMessage,
            v_ErrorID);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'WarehouseID',v_WarehouseID);
            SET SWP_Ret_Value = -1;
         end if;
         IF ABS(v_AvailableEmpty) > 2147483647 then
				
            SET v_ErrorMessage = 'Logical error - attempt to put goods more then maximum quantity';
            ROLLBACK;
            CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'WarehouseBinPutGoods',v_ErrorMessage,
            v_ErrorID);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'WarehouseID',v_WarehouseID);
            SET SWP_Ret_Value = -1;
         end if;
         IF(SELECT COUNT(*) FROM InventoryByWarehouse
         WHERE
         CompanyID = v_CompanyID AND
         DivisionID = v_DivisionID AND
         DepartmentID = v_DepartmentID AND
         ItemID = v_InventoryItemID AND
         WarehouseID = v_WarehouseID AND
         WarehouseBinID = v_WarehouseBinID) = 0 then
				
            SET @SWV_Error = 0;
            INSERT INTO InventoryByWarehouse(CompanyID,
							DivisionID,
							DepartmentID,
							ItemID,
							WarehouseID,
							WarehouseBinID,
							QtyOnHand,
							QtyCommitted,
							QtyOnOrder,
							QtyOnBackorder)
					VALUES(v_CompanyID,
							v_DivisionID,
							v_DepartmentID,
							v_InventoryItemID,
							v_WarehouseID,
							v_WarehouseBinID,
							0,
							0,
							0,
							0);
					
            IF @SWV_Error <> 0 then
					
               SET v_ErrorMessage = 'Insert InventoryByWarehouse bin failed';
               ROLLBACK;
               CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'WarehouseBinPutGoods',v_ErrorMessage,
               v_ErrorID);
               CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'WarehouseID',v_WarehouseID);
               SET SWP_Ret_Value = -1;
            end if;
         end if;
         IF v_AvailableEmpty >= v_Qty then
				
					-- put to this bin
            SET @SWV_Error = 0;
            UPDATE InventoryByWarehouse
            SET
            QtyOnHand =
            CASE v_Action
            WHEN 1 THEN IFNULL(QtyOnHand,0)
            WHEN 2 THEN IFNULL(QtyOnHand,0)+v_Qty
            WHEN 3 THEN IFNULL(QtyOnHand,0)
            WHEN 4 THEN IFNULL(QtyOnHand,0) -v_Qty
            WHEN 5 THEN IFNULL(QtyOnHand,0) -v_Qty
            WHEN 6 THEN IFNULL(QtyOnHand,0)+v_Qty
            ELSE IFNULL(QtyOnHand,0)
            END,QtyOnOrder =
            CASE v_Action
            WHEN 1 THEN IFNULL(QtyOnOrder,0)+v_Qty
            WHEN 2 THEN IFNULL(QtyOnOrder,0) -v_Qty
            WHEN 3 THEN IFNULL(QtyOnOrder,0) -v_Qty
            WHEN 4 THEN IFNULL(QtyOnOrder,0)
            WHEN 5 THEN IFNULL(QtyOnOrder,0)
            WHEN 6 THEN IFNULL(QtyOnOrder,0)
            ELSE IFNULL(QtyOnOrder,0)
            END
            WHERE
            CompanyID = v_CompanyID AND
            DivisionID = v_DivisionID AND
            DepartmentID = v_DepartmentID AND
            ItemID = v_InventoryItemID AND
            WarehouseID = v_WarehouseID AND
            WarehouseBinID = v_WarehouseBinID;
            IF ROW_COUNT() <> 1 OR @SWV_Error <> 0 then
						
               SET v_ErrorMessage = 'Update InventoryByWarehouse bin failed';
               ROLLBACK;
               CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'WarehouseBinPutGoods',v_ErrorMessage,
               v_ErrorID);
               CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'WarehouseID',v_WarehouseID);
               SET SWP_Ret_Value = -1;
            end if;
            IF v_Action = 2 then
						
               SET @SWV_Error = 0;
               SET v_ReturnStatus = SerialNumber_Put2(v_CompanyID,v_DivisionID,v_DepartmentID,v_WarehouseID,v_WarehouseBinID,
               v_PurchaseNumber,v_PurchaseLineNumber,v_SerialNumber,v_InventoryItemID,
               v_ReceivedDate,v_Qty);
               IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then
							-- An error occured, go to the error handler
							
                  SET v_ErrorMessage = 'SerialNumber_Put call failed';
                  ROLLBACK;
                  CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'WarehouseBinPutGoods',v_ErrorMessage,
                  v_ErrorID);
                  CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'WarehouseID',v_WarehouseID);
                  SET SWP_Ret_Value = -1;
               end if;
            end if;
         ELSE
					-- put to this bin
            SET @SWV_Error = 0;
            UPDATE InventoryByWarehouse
            SET
            QtyOnHand =
            CASE v_Action
            WHEN 1 THEN IFNULL(QtyOnHand,0)
            WHEN 2 THEN IFNULL(QtyOnHand,0)+v_AvailableEmpty
            WHEN 3 THEN IFNULL(QtyOnHand,0)
            WHEN 4 THEN IFNULL(QtyOnHand,0) -v_AvailableEmpty
            WHEN 5 THEN IFNULL(QtyOnHand,0) -v_AvailableEmpty
            WHEN 6 THEN IFNULL(QtyOnHand,0)+v_AvailableEmpty
            ELSE IFNULL(QtyOnHand,0)
            END,QtyOnOrder =
            CASE v_Action
            WHEN 1 THEN IFNULL(QtyOnOrder,0)+v_AvailableEmpty
            WHEN 2 THEN IFNULL(QtyOnOrder,0) -v_AvailableEmpty
            WHEN 3 THEN IFNULL(QtyOnOrder,0) -v_AvailableEmpty
            WHEN 4 THEN IFNULL(QtyOnOrder,0)
            WHEN 5 THEN IFNULL(QtyOnOrder,0)
            WHEN 6 THEN IFNULL(QtyOnOrder,0)
            ELSE IFNULL(QtyOnOrder,0)
            END
            WHERE
            CompanyID = v_CompanyID AND
            DivisionID = v_DivisionID AND
            DepartmentID = v_DepartmentID AND
            ItemID = v_InventoryItemID AND
            WarehouseID = v_WarehouseID AND
            WarehouseBinID = v_WarehouseBinID;
            IF ROW_COUNT() <> 1 OR @SWV_Error <> 0 then
						
               SET v_ErrorMessage = 'Update InventoryByWarehouse bin failed';
               ROLLBACK;
               CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'WarehouseBinPutGoods',v_ErrorMessage,
               v_ErrorID);
               CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'WarehouseID',v_WarehouseID);
               SET SWP_Ret_Value = -1;
            end if;
            IF v_Action = 2 then
						
               SET @SWV_Error = 0;
               SET v_ReturnStatus = SerialNumber_Put2(v_CompanyID,v_DivisionID,v_DepartmentID,v_WarehouseID,v_WarehouseBinID,
               v_PurchaseNumber,v_PurchaseLineNumber,v_SerialNumber,v_InventoryItemID,
               v_ReceivedDate,v_AvailableEmpty);
               IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then
							-- An error occured, go to the error handler
							
                  SET v_ErrorMessage = 'SerialNumber_Put call failed';
                  ROLLBACK;
                  CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'WarehouseBinPutGoods',v_ErrorMessage,
                  v_ErrorID);
                  CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'WarehouseID',v_WarehouseID);
                  SET SWP_Ret_Value = -1;
               end if;
            end if;
					-- put to next bin
            SET v_Qty = v_Qty -v_AvailableEmpty;
            SET v_WarehouseBinID = v_OverFlowBin;
            leave PutToBin;
         end if;
      end if;
      COMMIT;
      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;
   END LOOP PutToBin;
   ROLLBACK;
   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'WarehouseBinPutGoods',v_ErrorMessage,
   v_ErrorID);
   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'WarehouseID',v_WarehouseID);
	
   SET SWP_Ret_Value = -1;
END;




//

DELIMITER ;

DELIMITER //
DROP PROCEDURE IF EXISTS WarehouseBinGet;
//
CREATE   PROCEDURE WarehouseBinGet(v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_InventoryItemID NATIONAL VARCHAR(36),
	INOUT v_WarehouseID NATIONAL VARCHAR(36) ,
	INOUT v_WarehouseBinID NATIONAL VARCHAR(36) ,INOUT SWP_Ret_Value INT)
BEGIN







/*
Name of stored procedure: WarehouseBinGet
Method: 
	this procedure get default root bin for inventory item

Date Created: EDE - 07/28/2015

Input Parameters:

	@CompanyID NVARCHAR(36)		 - the ID of the company
	@DivisionID NVARCHAR(36)	 - the ID of the division
	@DepartmentID NVARCHAR(36)	 - the ID of the department
	@InventoryItemID NVARCHAR(36)	 - the ID of inventory item

Output Parameters:

	@WarehouseID NVARCHAR(36)	 - the ID of warehouse
	@WarehouseBinID NVARCHAR(36)	 - the ID of warehouse bin

Called From:

	WarehouseBinPutGoods

Calls:

	NONE

Last Modified: 

Last Modified By: 

Revision History: 

*/



   SET v_WarehouseID = WarehouseRoot2(v_CompanyID,v_DivisionID,v_DepartmentID,v_WarehouseID,v_InventoryItemID);

   SET v_WarehouseBinID = WarehouseBinRoot2(v_CompanyID,v_DivisionID,v_DepartmentID,v_WarehouseID,v_WarehouseBinID,
   v_InventoryItemID);



   SET SWP_Ret_Value = 0;

END;










//

DELIMITER ;

update databaseinfo set value='2019_03_21',lastupdate=now() where id='Version';
