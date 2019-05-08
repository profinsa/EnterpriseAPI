DELIMITER //
DROP PROCEDURE IF EXISTS CreditMemo_CreatePayment;
//
CREATE    PROCEDURE CreditMemo_CreatePayment(v_CompanyID NATIONAL VARCHAR(36), 
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_InvoiceNumber NATIONAL VARCHAR(36),INOUT SWP_Ret_Value INT)
   SWL_return:
BEGIN












/*
Name of stored procedure: CreditMemo_CreatePayment
Method: 
	Creates payment for specified credit memo

Date Created: EDE - 07/28/2015

Input Parameters:

	@CompanyID NVARCHAR(36)		 - the ID of the company
	@DivisionID NVARCHAR(36)	 - the ID of the division
	@DepartmentID NVARCHAR(36)	 - the ID of the department
	@InvoiceNumber NVARCHAR(36)	 - the ID of credit memo

Output Parameters:

	NONE

Called From:

	CreditMemo_CreatePayment.vb

Calls:

	GetNextEntityID, Vendor_CreateFromCustomer, Error_InsertError, Error_InsertErrorDetail

Last Modified: 

Last Modified By: 

Revision History: 

*/

   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);
   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_PaymentID NATIONAL VARCHAR(36);
   DECLARE v_CustomerID NATIONAL VARCHAR(36);
   DECLARE v_GLBankAccount NATIONAL VARCHAR(36);
   DECLARE v_GLSalesAccount NATIONAL VARCHAR(36);
   DECLARE v_PaymentDate DATETIME;
   DECLARE v_BalanceDue DECIMAL(19,4);
   DECLARE v_Posted BOOLEAN;

-- get customer id
   DECLARE v_ErrorID INT;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
   END;
   select   CustomerID, InvoiceDate, IFNULL(Total,0) -IFNULL(AmountPaid,0), IFNULL(Posted,0) INTO v_CustomerID,v_PaymentDate,v_BalanceDue,v_Posted FROM
   InvoiceHeader WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND InvoiceNumber = v_InvoiceNumber;

   IF v_BalanceDue <= 0 then
      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;
   end if;

   IF v_Posted = 0 then
      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;
   end if;
-- get customer id
   select   GLSalesAccount INTO v_GLSalesAccount FROM
   InvoiceDetail WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND InvoiceNumber = v_InvoiceNumber   LIMIT 1;
   START TRANSACTION;

-- get the payment number
   SET @SWV_Error = 0;
   CALL GetNextEntityID2(v_CompanyID,v_DivisionID,v_DepartmentID,'NextVoucherNumber',v_PaymentID, v_ReturnStatus);
   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then

      SET v_ErrorMessage = 'GetNextEntityID call failed';
      ROLLBACK;
-- the error handler
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'CreditMemo_CreatePayment',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
      SET SWP_Ret_Value = -1;
   end if;


-- convert customer to vendor
   SET @SWV_Error = 0;
   CALL Vendor_CreateFromCustomer2(v_CompanyID,v_DivisionID,v_DepartmentID,v_CustomerID, v_ReturnStatus);
-- An error occured, go to the error handler
   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then

      SET v_ErrorMessage = 'Vendor_CreateFromCustomer call failed';
      ROLLBACK;
-- the error handler
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'CreditMemo_CreatePayment',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
      SET SWP_Ret_Value = -1;
   end if;



   select   BankAccounts.GLBankAccount INTO v_GLBankAccount FROM
   Companies
   INNER JOIN
   BankAccounts
   ON
   Companies.CompanyID = BankAccounts.CompanyID AND
   Companies.DivisionID = BankAccounts.DivisionID AND
   Companies.DepartmentID = BankAccounts.DepartmentID WHERE
   Companies.CompanyID = v_CompanyID AND
   Companies.DivisionID = v_DivisionID AND
   Companies.DepartmentID = v_DepartmentID;

-- Insert into Payment Header getting the information from the credit memo
   SET @SWV_Error = 0;
   INSERT INTO PaymentsHeader(CompanyID,
	DivisionID,
	DepartmentID,
	PaymentID,
	PaymentTypeID,
	CheckNumber,
	VendorID,
	PaymentDate,
	Amount,
	CreditAmount,
	UnAppliedAmount,
	PaymentStatus,
	CurrencyID,
	CurrencyExchangeRate,
	Posted,
	Cleared,
	GLBankAccount,
	InvoiceNumber,
	DueToDate,
	PurchaseDate)
   SELECT
   v_CompanyID,
	v_DivisionID,
	v_DepartmentID,
	v_PaymentID,
	'Check',
	NULL,
	CustomerID,
	InvoiceDate,
	v_BalanceDue,
        v_BalanceDue,
	0,
	NULL,
	CurrencyID,
	CurrencyExchangeRate,
	0,
	0,
	v_GLBankAccount,
	NULL,
	InvoiceDueDate,
	'1 / 1 / 1980'
   FROM
   InvoiceHeader
   WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND InvoiceNumber = v_InvoiceNumber;

   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Insert into PaymentsHeader failed';
      ROLLBACK;
-- the error handler
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'CreditMemo_CreatePayment',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
      SET SWP_Ret_Value = -1;
   end if;


-- insert into receipts detail getting data from the crdit memo details
   SET @SWV_Error = 0;
   INSERT INTO PaymentsDetail(CompanyID,
	DivisionID,
	DepartmentID,
	PaymentID,
	PayedID,
	DocumentNumber,
	DocumentDate,
	DiscountTaken,
	WriteOffAmount,
	AppliedAmount,
	Cleared,
	GLExpenseAccount)
VALUES(v_CompanyID,
	v_DivisionID,
	v_DepartmentID,
	v_PaymentID,
	v_CustomerID,
	v_InvoiceNumber,
	v_PaymentDate,
	0,
	0,
	v_BalanceDue,
	0,
	v_GLSalesAccount);


   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Insert into PaymentsDetail failed';
      ROLLBACK;
-- the error handler
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'CreditMemo_CreatePayment',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
      SET SWP_Ret_Value = -1;
   end if;

   SET @SWV_Error = 0;
   CALL CreditMemoIssuePayment_CreateGLTransaction2(v_CompanyID,v_DivisionID,v_DepartmentID,v_InvoiceNumber, v_ReturnStatus);
-- An error occured, go to the error handler
   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then

      SET v_ErrorMessage = 'CreditMemoIssuePayment_CreateGLTransaction';
      ROLLBACK;
-- the error handler
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'CreditMemo_CreatePayment',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
      SET SWP_Ret_Value = -1;
   end if;


-- close the credit memo
   UPDATE
   InvoiceHeader
   SET
   AmountPaid = Total,BalanceDue = 0
   WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND InvoiceNumber = v_InvoiceNumber;


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
   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'CreditMemo_CreatePayment',v_ErrorMessage,
   v_ErrorID);

   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);

   SET SWP_Ret_Value = -1;
END;


























//

DELIMITER ;

DELIMITER //
DROP PROCEDURE IF EXISTS CreditMemo_CreatePayment;
//
CREATE    PROCEDURE CreditMemo_CreatePayment(v_CompanyID NATIONAL VARCHAR(36), 
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_InvoiceNumber NATIONAL VARCHAR(36),INOUT SWP_Ret_Value INT)
   SWL_return:
BEGIN












/*
Name of stored procedure: CreditMemo_CreatePayment
Method: 
	Creates payment for specified credit memo

Date Created: EDE - 07/28/2015

Input Parameters:

	@CompanyID NVARCHAR(36)		 - the ID of the company
	@DivisionID NVARCHAR(36)	 - the ID of the division
	@DepartmentID NVARCHAR(36)	 - the ID of the department
	@InvoiceNumber NVARCHAR(36)	 - the ID of credit memo

Output Parameters:

	NONE

Called From:

	CreditMemo_CreatePayment.vb

Calls:

	GetNextEntityID, Vendor_CreateFromCustomer, Error_InsertError, Error_InsertErrorDetail

Last Modified: 

Last Modified By: 

Revision History: 

*/

   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);
   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_PaymentID NATIONAL VARCHAR(36);
   DECLARE v_CustomerID NATIONAL VARCHAR(36);
   DECLARE v_GLBankAccount NATIONAL VARCHAR(36);
   DECLARE v_GLSalesAccount NATIONAL VARCHAR(36);
   DECLARE v_PaymentDate DATETIME;
   DECLARE v_BalanceDue DECIMAL(19,4);
   DECLARE v_Posted BOOLEAN;

-- get customer id
   DECLARE v_ErrorID INT;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
   END;
   select   CustomerID, InvoiceDate, IFNULL(Total,0) -IFNULL(AmountPaid,0), IFNULL(Posted,0) INTO v_CustomerID,v_PaymentDate,v_BalanceDue,v_Posted FROM
   InvoiceHeader WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND InvoiceNumber = v_InvoiceNumber;

   IF v_BalanceDue <= 0 then
      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;
   end if;

   IF v_Posted = 0 then
      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;
   end if;
-- get customer id
   select   GLSalesAccount INTO v_GLSalesAccount FROM
   InvoiceDetail WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND InvoiceNumber = v_InvoiceNumber   LIMIT 1;
   START TRANSACTION;

-- get the payment number
   SET @SWV_Error = 0;
   CALL GetNextEntityID2(v_CompanyID,v_DivisionID,v_DepartmentID,'NextVoucherNumber',v_PaymentID, v_ReturnStatus);
   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then

      SET v_ErrorMessage = 'GetNextEntityID call failed';
      ROLLBACK;
-- the error handler
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'CreditMemo_CreatePayment',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
      SET SWP_Ret_Value = -1;
   end if;


-- convert customer to vendor
   SET @SWV_Error = 0;
   CALL Vendor_CreateFromCustomer2(v_CompanyID,v_DivisionID,v_DepartmentID,v_CustomerID, v_ReturnStatus);
-- An error occured, go to the error handler
   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then

      SET v_ErrorMessage = 'Vendor_CreateFromCustomer call failed';
      ROLLBACK;
-- the error handler
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'CreditMemo_CreatePayment',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
      SET SWP_Ret_Value = -1;
   end if;



   select   BankAccounts.GLBankAccount INTO v_GLBankAccount FROM
   Companies
   INNER JOIN
   BankAccounts
   ON
   Companies.CompanyID = BankAccounts.CompanyID AND
   Companies.DivisionID = BankAccounts.DivisionID AND
   Companies.DepartmentID = BankAccounts.DepartmentID WHERE
   Companies.CompanyID = v_CompanyID AND
   Companies.DivisionID = v_DivisionID AND
   Companies.DepartmentID = v_DepartmentID;

-- Insert into Payment Header getting the information from the credit memo
   SET @SWV_Error = 0;
   INSERT INTO PaymentsHeader(CompanyID,
	DivisionID,
	DepartmentID,
	PaymentID,
	PaymentTypeID,
	CheckNumber,
	VendorID,
	PaymentDate,
	Amount,
	CreditAmount,
	UnAppliedAmount,
	PaymentStatus,
	CurrencyID,
	CurrencyExchangeRate,
	Posted,
	Cleared,
	GLBankAccount,
	InvoiceNumber,
	DueToDate,
	PurchaseDate)
   SELECT
   v_CompanyID,
	v_DivisionID,
	v_DepartmentID,
	v_PaymentID,
	'Check',
	NULL,
	CustomerID,
	InvoiceDate,
	v_BalanceDue,
        v_BalanceDue,
	0,
	NULL,
	CurrencyID,
	CurrencyExchangeRate,
	0,
	0,
	v_GLBankAccount,
	NULL,
	InvoiceDueDate,
	now()
   FROM
   InvoiceHeader
   WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND InvoiceNumber = v_InvoiceNumber;

   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Insert into PaymentsHeader failed';
      ROLLBACK;
-- the error handler
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'CreditMemo_CreatePayment',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
      SET SWP_Ret_Value = -1;
   end if;


-- insert into receipts detail getting data from the crdit memo details
   SET @SWV_Error = 0;
   INSERT INTO PaymentsDetail(CompanyID,
	DivisionID,
	DepartmentID,
	PaymentID,
	PayedID,
	DocumentNumber,
	DocumentDate,
	DiscountTaken,
	WriteOffAmount,
	AppliedAmount,
	Cleared,
	GLExpenseAccount)
VALUES(v_CompanyID,
	v_DivisionID,
	v_DepartmentID,
	v_PaymentID,
	v_CustomerID,
	v_InvoiceNumber,
	v_PaymentDate,
	0,
	0,
	v_BalanceDue,
	0,
	v_GLSalesAccount);


   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Insert into PaymentsDetail failed';
      ROLLBACK;
-- the error handler
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'CreditMemo_CreatePayment',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
      SET SWP_Ret_Value = -1;
   end if;

   SET @SWV_Error = 0;
   CALL CreditMemoIssuePayment_CreateGLTransaction2(v_CompanyID,v_DivisionID,v_DepartmentID,v_InvoiceNumber, v_ReturnStatus);
-- An error occured, go to the error handler
   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then

      SET v_ErrorMessage = 'CreditMemoIssuePayment_CreateGLTransaction';
      ROLLBACK;
-- the error handler
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'CreditMemo_CreatePayment',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
      SET SWP_Ret_Value = -1;
   end if;


-- close the credit memo
   UPDATE
   InvoiceHeader
   SET
   AmountPaid = Total,BalanceDue = 0
   WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND InvoiceNumber = v_InvoiceNumber;


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
   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'CreditMemo_CreatePayment',v_ErrorMessage,
   v_ErrorID);

   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);

   SET SWP_Ret_Value = -1;
END;


























//

DELIMITER ;

DELIMITER //
DROP PROCEDURE IF EXISTS CreditMemoIssuePayment_CreateGLTransaction2;
//
CREATE         PROCEDURE CreditMemoIssuePayment_CreateGLTransaction2(v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_CreditMemoNumber NATIONAL VARCHAR(36),INOUT SWP_Ret_Value INT)
   SWL_return:
BEGIN

















/*
Name of stored procedure: CreditMemoIssuePayment_CreateGLTransaction
Method: 
	Stored procedure used to post a credit memo to LedgerTransactions table

Date Created: EDE - 07/28/2015

Input Parameters:

	@CompanyID NVARCHAR(36)		 - the ID of the company
	@DivisionID NVARCHAR(36)	 - the ID of the division
	@DepartmentID NVARCHAR(36)	 - the ID of the department
	@CreditMemoNumber NVARCHAR(36)	 - the ID of Credit Memo

Output Parameters:

	NONE

Called From:

	CreditMemo_CreatePayment

Calls:

	VerifyCurrency, GetNextEntityID, LedgerTransactions_PostCOA_AllRecords, Error_InsertError, Error_InsertErrorDetail

Last Modified: 

Last Modified By: 

Revision History: 

*/

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


-- Do nothing if Credit Memo was not posted before
   IF v_Posted = 0 then
      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;
   end if;
-- Do nothing if there is no money in Credit Memo
   IF v_Amount = 0 then
      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;
   end if;

   START TRANSACTION;

   SET @SWV_Error = 0;
   CALL VerifyCurrency2(v_CompanyID,v_DivisionID,v_DepartmentID,v_CreditMemoDate,1,v_CompanyCurrencyID,
   v_CurrencyID,v_CurrencyExchangeRate);
   IF @SWV_Error <> 0 then

	-- the procedure will return an error code
      SET v_ErrorMessage = 'Currency retrieving failed';
      ROLLBACK;
      IF v_ErrorMessage <> '' then

	-- the error handler
	
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


-- get the transaction number
   SET @SWV_Error = 0;
   CALL GetNextEntityID2(v_CompanyID,v_DivisionID,v_DepartmentID,'NextGLTransNumber',v_GLTransactionNumber, v_ReturnStatus);

   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then
-- An error occured , drop the temporary table and 
-- go to the error handler

      SET v_ErrorMessage = 'GetNextEntityID call failed';
      ROLLBACK;
      IF v_ErrorMessage <> '' then

	-- the error handler
	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'CreditMemoIssuePayment_CreateGLTransaction',
         v_ErrorMessage,v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_CreditMemoNumber);
      end if;
      SET SWP_Ret_Value = -1;
   end if;

-- Get default values from Companies table for
-- Sales Account, Account Payable and PeriodPosting flag
   select   GLAPAccount, GLARAccount, PeriodPosting INTO v_GLAPAccount,v_GLARAccount,v_PostDate FROM
   Companies WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID;

-- insert the transaction corresponding to credit memo post
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
	-- An error occured , drop the temporary table and 
	-- go to the error handler
	
      SET v_ErrorMessage = 'Insert into LedgerTransactions failed';
      ROLLBACK;
      IF v_ErrorMessage <> '' then

	-- the error handler
	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'CreditMemoIssuePayment_CreateGLTransaction',
         v_ErrorMessage,v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_CreditMemoNumber);
      end if;
      SET SWP_Ret_Value = -1;
   end if;




-- Debit @Amount from AP 
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
-- go to the error handler

      SET v_ErrorMessage = 'Insert into LedgerTransactionsDetail failed';
      ROLLBACK;
      IF v_ErrorMessage <> '' then

	-- the error handler
	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'CreditMemoIssuePayment_CreateGLTransaction',
         v_ErrorMessage,v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_CreditMemoNumber);
      end if;
      SET SWP_Ret_Value = -1;
   end if;
		
	
-- Credit @Amount to Account Receiviable
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
-- go to the error handler

      SET v_ErrorMessage = 'Insert into LedgerTransactionsDetail failed';
      ROLLBACK;
      IF v_ErrorMessage <> '' then

	-- the error handler
	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'CreditMemoIssuePayment_CreateGLTransaction',
         v_ErrorMessage,v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_CreditMemoNumber);
      end if;
      SET SWP_Ret_Value = -1;
   end if;


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
   CALL LedgerTransactions_PostCOA_AllRecords2(v_CompanyID,v_DivisionID,v_DepartmentID,v_GLTransactionNumber, v_ReturnStatus);
   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then

      SET v_ErrorMessage = 'LedgerTransactions_PostCOA_AllRecords call failed';
      ROLLBACK;
      IF v_ErrorMessage <> '' then

	-- the error handler
	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'CreditMemoIssuePayment_CreateGLTransaction',
         v_ErrorMessage,v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_CreditMemoNumber);
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

   IF v_ErrorMessage <> '' then

	-- the error handler
	
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'CreditMemoIssuePayment_CreateGLTransaction',
      v_ErrorMessage,v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_CreditMemoNumber);
   end if;
   SET SWP_Ret_Value = -1;
END;

















//

DELIMITER ;
