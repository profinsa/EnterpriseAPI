update databaseinfo set value='2019_03_27',lastupdate=now() WHERE id='Version';

DELIMITER //
DROP PROCEDURE IF EXISTS Payment_Post;
//
CREATE             PROCEDURE Payment_Post(v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_PaymentID NATIONAL VARCHAR(36),
	INOUT v_Succes INT  ,
	INOUT v_PostingResult NATIONAL VARCHAR(200) ,INOUT SWP_Ret_Value INT)
   SWL_return:
BEGIN
















/*
Name of stored procedure: Payment_Post
Method: 
	Prepares payment for posting and post payment to General Ledger

Date Created: EDE - 07/28/2015

Input Parameters:

	@CompanyID NVARCHAR(36)		 - the ID of the company
	@DivisionID NVARCHAR(36)	 - the ID of the division
	@DepartmentID NVARCHAR(36)	 - the ID of the department
	@PaymentID NVARCHAR(36)		 - the ID of the payment

Output Parameters:

	@Succes INT  			 - RETURN VALUES for the @Succes output parameter:

							   1 succes

							   0 error while processin data

							   2 error on geting time period
	@PostingResult NVARCHAR(200)	 - the error message that should be displayed for end user

Called From:

	EDI_InvoiceProcessingInbound, Payment_Post.vb

Calls:

	LedgerTransactions_Reverse, LedgerMain_VerifyPeriod, Payment_Recalc, Payment_CreateGLTransaction, VendorFinancials_Recalc, Project_Recalc, Error_InsertError, Error_InsertErrorDetail

Last Modified: 

Last Modified By: 

Revision History: 

*/

   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);

   DECLARE v_Posted BOOLEAN;
   DECLARE v_Void BOOLEAN;
   DECLARE v_Paid BOOLEAN;
   DECLARE v_PostDate NATIONAL VARCHAR(1);
   DECLARE v_TranDate DATETIME;
   DECLARE v_PaymentDate DATETIME;
   DECLARE v_PeriodToPost INT;
   DECLARE v_PeriodClosed INT;
   DECLARE v_ProjectID NATIONAL VARCHAR(36);
   DECLARE v_GLTransactionNumber NATIONAL VARCHAR(36);
   DECLARE v_VendorID NATIONAL VARCHAR(36);
   DECLARE v_PaymentTypeID NATIONAL VARCHAR(36);
   DECLARE v_CheckNumber NATIONAL VARCHAR(20);
   DECLARE v_ErrorID INT;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
       SET @SWV_Error = 1;
   END;
   SET @SWV_Error = 0;
   SET v_Succes =  1;

-- If there is no detail for the payment, then exit
   IF NOT EXISTS(SELECT
   PaymentID
   FROM
   PaymentsDetail
   WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   PaymentID = v_PaymentID) then

      SET v_PostingResult = 'Payment was not posted: there are no detail items';
      SET SWP_Ret_Value = -1;
      LEAVE SWL_return;
   end if;

-- If the detail line does not contain the amount to apply, then exit
   IF EXISTS(SELECT
   PaymentID
   FROM
   PaymentsDetail
   WHERE
   IFNULL(AppliedAmount,0) = 0 AND
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   PaymentID = v_PaymentID) then

      SET v_PostingResult = 'Payment was not posted: there is the detail item with undefined AppliedAmount value';
      SET SWP_Ret_Value = -1;
      LEAVE SWL_return;
   end if;

   select   IFNULL(Posted,0), IFNULL(Void,0), IFNULL(Paid,0), IFNULL(PaymentDate,CURRENT_TIMESTAMP), VendorID, IFNULL(PaymentTypeID,''), IFNULL(CheckNumber,'') INTO v_Posted,v_Void,v_Paid,v_PaymentDate,v_VendorID,v_PaymentTypeID,v_CheckNumber FROM
   PaymentsHeader WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   PaymentID = v_PaymentID;


-- payment type and check number check
   IF v_PaymentTypeID <> 'Check' AND RTrim(v_CheckNumber) = '' then
	
      START TRANSACTION;
      SET v_ErrorMessage = 'You must enter a Check Number for this payment type.';
      ROLLBACK;
-- the error handler
      IF v_Succes = 1 then

         SET v_Succes = 0;
      end if;
      IF v_ErrorMessage <> '' then

	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payment_Post',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PaymentID',v_PaymentID);
      end if;
      SET SWP_Ret_Value = -1;
   end if;


-- if the payment is void checked, void it
   IF v_Paid = 1 AND v_Void = 1 then

      START TRANSACTION;
	-- get GLTransactionNumber
      select   GLTransactionNumber INTO v_GLTransactionNumber FROM
      LedgerTransactions WHERE
      CompanyID = v_CompanyID AND
      DivisionID = v_DivisionID AND
      DepartmentID = v_DepartmentID AND
      GLTransactionTypeID = 'Check' AND
      GLTransactionReference = v_PaymentID AND
      IFNULL(Reversal,0) = 0;
      IF @SWV_Error <> 0 OR ROW_COUNT() <> 1 then
	
         SET v_ErrorMessage = 'Get GLTransactionNumber failed';
         ROLLBACK;
-- the error handler
         IF v_Succes = 1 then

            SET v_Succes = 0;
         end if;
         IF v_ErrorMessage <> '' then

	
            CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payment_Post',v_ErrorMessage,
            v_ErrorID);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PaymentID',v_PaymentID);
         end if;
         SET SWP_Ret_Value = -1;
      end if;

	-- reverse the transaction
      SET v_ReturnStatus = LedgerTransactions_Reverse(v_CompanyID,v_DivisionID,v_DepartmentID,v_GLTransactionNumber);
      IF v_ReturnStatus = -1 then
	
         SET v_ErrorMessage = 'LedgerTransactions_Reverse call failed';
         ROLLBACK;
-- the error handler
         IF v_Succes = 1 then

            SET v_Succes = 0;
         end if;
         IF v_ErrorMessage <> '' then

	
            CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payment_Post',v_ErrorMessage,
            v_ErrorID);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PaymentID',v_PaymentID);
         end if;
         SET SWP_Ret_Value = -1;
      end if;

	-- clear void flag
      SET @SWV_Error = 0;
      UPDATE
      PaymentsHeader
      SET
      Void = 0,CheckPrinted = 0,Paid = 0
      WHERE
      CompanyID = v_CompanyID AND
      DivisionID = v_DivisionID AND
      DepartmentID = v_DepartmentID AND
      PaymentID = v_PaymentID;
      IF @SWV_Error <> 0 then
	
         SET v_ErrorMessage = 'Update PaymentsHeader failed';
         ROLLBACK;
-- the error handler
         IF v_Succes = 1 then

            SET v_Succes = 0;
         end if;
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
   end if;


-- if the payment is allready posted do not post it again
   IF v_Posted = 1 then

      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;
   end if;

-- get the post date flag from
-- the companies table
   select   IFNULL(DefaultGLPostingDate,'1') INTO v_PostDate FROM
   Companies WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID;

-- begin the posting process
   IF v_PostDate = '1' then

	-- select the transaction date
	-- as the current date
      SET v_TranDate = CURRENT_TIMESTAMP;
   ELSE
	-- select the transaction date
	-- as payment date
      select   IFNULL(PaymentDate,CURRENT_TIMESTAMP) INTO v_TranDate FROM
      PaymentsHeader WHERE
      CompanyID = v_CompanyID AND
      DivisionID = v_DivisionID AND
      DepartmentID = v_DepartmentID AND
      PaymentID = v_PaymentID;
   end if;


   START TRANSACTION;

-- verify the period of time
   CALL LedgerMain_VerifyPeriod2(v_CompanyID,v_DivisionID,v_DepartmentID,v_TranDate,v_PeriodToPost,v_PeriodClosed, v_ReturnStatus);
   IF v_ReturnStatus = -1 then

      SET v_ErrorMessage = 'LedgerMain_VerifyPeriod call failed';
      ROLLBACK;
-- the error handler
      IF v_Succes = 1 then

         SET v_Succes = 0;
      end if;
      IF v_ErrorMessage <> '' then

	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payment_Post',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PaymentID',v_PaymentID);
      end if;
      SET SWP_Ret_Value = -1;
   end if;

   IF v_PeriodClosed <> 0 then

      SET v_Succes = 2;
      SET v_ErrorMessage = 'UNABLE_TO_POST_HERE';
      ROLLBACK;
-- the error handler
      IF v_Succes = 1 then

         SET v_Succes = 0;
      end if;
      IF v_ErrorMessage <> '' then

	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payment_Post',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PaymentID',v_PaymentID);
      end if;
      SET SWP_Ret_Value = -1;
   end if;

-- Recalculate payment before posting 
   SET @SWV_Error = 0;
   CALL Payment_Recalc2(v_CompanyID,v_DivisionID,v_DepartmentID,v_PaymentID, v_ReturnStatus);
   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then

	-- the procedure will return an error code
      SET v_ErrorMessage = 'Payment_Recalc call failed';
      ROLLBACK;
-- the error handler
      IF v_Succes = 1 then

         SET v_Succes = 0;
      end if;
      IF v_ErrorMessage <> '' then

	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payment_Post',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PaymentID',v_PaymentID);
      end if;
      SET SWP_Ret_Value = -1;
   end if;

   SET @SWV_Error = 0;
   CALL Payment_CreateGLTransaction(v_CompanyID,v_DivisionID,v_DepartmentID,v_PaymentID, v_ReturnStatus);
   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then

      SET v_ErrorMessage = 'Payment_CreateGLTransaction call failed';
      ROLLBACK;
-- the error handler
      IF v_Succes = 1 then

         SET v_Succes = 0;
      end if;
      IF v_ErrorMessage <> '' then

	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payment_Post',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PaymentID',v_PaymentID);
      end if;
      SET SWP_Ret_Value = -1;
   end if;


-- set posted flag for payment
   SET @SWV_Error = 0;
   UPDATE
   PaymentsHeader
   SET
   Posted = 1
   WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   PaymentID = v_PaymentID;

   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Update PaymentsHeader failed';
      ROLLBACK;
-- the error handler
      IF v_Succes = 1 then

         SET v_Succes = 0;
      end if;
      IF v_ErrorMessage <> '' then

	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payment_Post',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PaymentID',v_PaymentID);
      end if;
      SET SWP_Ret_Value = -1;
   end if;

   SET @SWV_Error = 0;
   SET v_ReturnStatus = VendorFinancials_ReCalc2(v_CompanyID,v_DivisionID,v_DepartmentID,v_VendorID);
   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then

	-- the procedure will return an error code
      SET v_ErrorMessage = 'VendorFinancials_Recalc call failed';
      ROLLBACK;
-- the error handler
      IF v_Succes = 1 then

         SET v_Succes = 0;
      end if;
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

-- Update fields in Projects table
   SET @SWV_Error = 0;
   CALL Project_Recalc2(v_CompanyID,v_DivisionID,v_DepartmentID,v_ProjectID, v_ReturnStatus);
   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then

	-- the procedure will return an error code
      SET v_ErrorMessage = 'Project_ReCalc call failed';
      ROLLBACK;
-- the error handler
      IF v_Succes = 1 then

         SET v_Succes = 0;
      end if;
      IF v_ErrorMessage <> '' then

	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payment_Post',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PaymentID',v_PaymentID);
      end if;
      SET SWP_Ret_Value = -1;
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
   IF v_Succes = 1 then

      SET v_Succes = 0;
   end if;

   IF v_ErrorMessage <> '' then

	
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payment_Post',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PaymentID',v_PaymentID);
   end if;
   SET SWP_Ret_Value = -1;
END;



























//

DELIMITER ;

DELIMITER //
DROP PROCEDURE IF EXISTS Payment_CreateGLTransaction;
//
CREATE             PROCEDURE Payment_CreateGLTransaction(v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_PaymentID NATIONAL VARCHAR(36),INOUT SWP_Ret_Value INT)
   SWL_return:
BEGIN










/*
Name of stored procedure: Payment_CreateGLTransaction
Method: 
	Posts payment amounts to the General Ledger

Date Created: EDE - 07/28/2015

Input Parameters:

	@CompanyID NVARCHAR(36)		 - the ID of the company
	@DivisionID NVARCHAR(36)	 - the ID of the division
	@DepartmentID NVARCHAR(36)	 - the ID of the department
	@PaymentID NVARCHAR(36)		 - the ID of the payment

Output Parameters:

	NONE

Called From:

	Payment_Post

Calls:

	VerifyCurrency, GetNextEntityID, LedgerTransactions_PostCOA_AllRecords, Error_InsertError, Error_InsertErrorDetail

Last Modified: 

Last Modified By: 

Revision History: 

*/

   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);

   DECLARE v_Posted BOOLEAN;
   DECLARE v_PostDate NATIONAL VARCHAR(1);
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


-- if the payment is allready posted do not post it again
   IF v_Posted = 1 then

      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;
   end if;

   IF v_Amount = 0 then

      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;
   end if;

   SET @SWV_Error = 0;
   CALL VerifyCurrency2(v_CompanyID,v_DivisionID,v_DepartmentID,v_PaymentDate,2,v_CompanyCurrencyID,
   v_CurrencyID,v_CurrencyExchangeRate);
   IF @SWV_Error <> 0 then

	-- the procedure will return an error code
      SET v_ErrorMessage = 'Currency retrieving failed';
      ROLLBACK;
-- the error handler

      DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;
      IF v_ErrorMessage <> '' then

	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payment_CreateGLTransaction',v_ErrorMessage,
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

-- get the post date flag from
-- the companies table
   select   IFNULL(DefaultGLPostingDate,'1') INTO v_PostDate FROM
   Companies WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID;


   START TRANSACTION;

   SET v_ConvertedAmount = fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,v_Amount*v_CurrencyExchangeRate, 
   v_CompanyCurrencyID);
-- get the transaction number
   SET @SWV_Error = 0;
   CALL GetNextEntityID2(v_CompanyID,v_DivisionID,v_DepartmentID,'NextGLTransNumber',v_GLTransNumber, v_ReturnStatus);
   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then

      SET v_ErrorMessage = 'GetNextEntityID call failed';
      ROLLBACK;
-- the error handler

      DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;
      IF v_ErrorMessage <> '' then

	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payment_CreateGLTransaction',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PaymentID',v_PaymentID);
      end if;
      SET SWP_Ret_Value = -1;
   end if;
-- insert into ledger transactions informations about the payment
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
   WHEN '1' THEN CURRENT_TIMESTAMP
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
-- the error handler

      DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;
      IF v_ErrorMessage <> '' then

	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payment_Post',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PaymentID',v_PaymentID);
      end if;
      SET SWP_Ret_Value = -1;
   end if;

-- Get Account Payable
   select   GLAPAccount INTO v_GLAPAccount FROM
   Companies WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID;

   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Updating GLExpenseAccount  in PaymentsDetail failed';
      ROLLBACK;
-- the error handler

      DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;
      IF v_ErrorMessage <> '' then

	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payment_Post',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PaymentID',v_PaymentID);
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

-- insert into TransactionsDetail the records from PaymentsDetail
-- Credit  AppliedAmount to Account Payable
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
-- the error handler

      DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;
      IF v_ErrorMessage <> '' then

	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payment_Post',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PaymentID',v_PaymentID);
      end if;
      SET SWP_Ret_Value = -1;
   end if;


-- Debit AppliedAmount to Expense Account
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
-- the error handler

      DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;
      IF v_ErrorMessage <> '' then

	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payment_Post',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PaymentID',v_PaymentID);
      end if;
      SET SWP_Ret_Value = -1;
   end if;

-- insert the information in the LedgerTransactionsDetail group by GLTransactionAccount, CurrencyID, CurrencyExchangeRate
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
-- the error handler

      DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;
      IF v_ErrorMessage <> '' then

	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payment_Post',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PaymentID',v_PaymentID);
      end if;
      SET SWP_Ret_Value = -1;
   end if;

-- drop temporary table used for ledger details
   DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;

/*
update the information in the Ledger Chart of Accounts for the accounts of the newly inserted transaction

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
-- the error handler

      DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;
      IF v_ErrorMessage <> '' then

	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payment_Post',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PaymentID',v_PaymentID);
      end if;
      SET SWP_Ret_Value = -1;
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

   DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;
   IF v_ErrorMessage <> '' then

	
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payment_Post',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PaymentID',v_PaymentID);
   end if;
   SET SWP_Ret_Value = -1;
END;













//

DELIMITER ;

