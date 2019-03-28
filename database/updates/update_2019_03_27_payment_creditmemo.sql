DELIMITER //
DROP PROCEDURE IF EXISTS Payment_CreateCreditMemo;
//
CREATE       PROCEDURE Payment_CreateCreditMemo(v_CompanyID 		NATIONAL VARCHAR(36),
	v_DivisionID 		NATIONAL VARCHAR(36),
	v_DepartmentID 		NATIONAL VARCHAR(36),
	v_PaymentID NATIONAL VARCHAR(36),INOUT SWP_Ret_Value INT)
   SWL_return:
BEGIN


/*
Name of stored procedure: Payment_CreateCreditMemo
Method: 
	Creates a Credit memo from a Payment

Date Created: EDE - 07/28/2015

Input Parameters:

	@CompanyID NVARCHAR(36)		 - the ID of the company
	@DivisionID NVARCHAR(36)	 - the ID of the division
	@DepartmentID NVARCHAR(36)	 - the ID of the department
	@PaymentID NVARCHAR(36)		 - ID of the payment

Output Parameters:

	NONE

Called From:

	Payment_CreateCreditMemo.vb

Calls:

	GetNextEntityID, Customer_CreateFromVendor, Error_InsertError, Error_InsertErrorDetail

Last Modified: 

Last Modified By: 

Revision History: 

*/

   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);
   DECLARE v_CreditMemoNumber NATIONAL VARCHAR(36);
   DECLARE v_VendorID NATIONAL VARCHAR(36);
   DECLARE v_ProjectID NATIONAL VARCHAR(36);
   DECLARE v_CreditAmount DECIMAL(19,4);
   DECLARE v_Posted BOOLEAN;
   DECLARE v_Void BOOLEAN;
   DECLARE v_GLDefaultSalesAccount NATIONAL VARCHAR(36);
   DECLARE v_GLAPAccount NATIONAL VARCHAR(36);

-- get vendor id
   DECLARE v_ErrorID INT;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
       SET @SWV_Error = 1;
   END;
   WriteError:
   BEGIN
      select   VendorID, IFNULL(CreditAmount,0), IFNULL(Posted,0), IFNULL(Void,0) INTO v_VendorID,v_CreditAmount,v_Posted,v_Void FROM
      PaymentsHeader WHERE
      CompanyID = v_CompanyID
      AND DivisionID = v_DivisionID
      AND DepartmentID = v_DepartmentID
      AND PaymentID = v_PaymentID;

-- IF @Void = 1 OR @Posted = 0 OR @CreditAmount<=0
-- 	Return 0

      If v_Void = 1 then

         SET v_ReturnStatus = -4;
         SET v_ErrorMessage = CONCAT('The payment is void for PaymentID:',v_PaymentID);
         LEAVE WriteError;
      end if;
      If v_CreditAmount <= 0 then

         SET v_ReturnStatus = -5;
         SET v_ErrorMessage = CONCAT('The credit amount is 0 or less than 0 for PaymentID:',v_PaymentID);
         LEAVE WriteError;
      end if;
      if v_Posted = 0 then

         SET v_ReturnStatus = -6;
         SET v_ErrorMessage = CONCAT('The payment is not yet posted for PaymentID:',v_PaymentID);
         LEAVE WriteError;
      end if;
      START TRANSACTION;
      select   ProjectID INTO v_ProjectID FROM
      PaymentsDetail WHERE
      CompanyID = v_CompanyID
      AND DivisionID = v_DivisionID
      AND DepartmentID = v_DepartmentID
      AND PaymentID = v_PaymentID
      AND NOT ProjectID IS NULL   LIMIT 1;

-- Get default values from Companies table for
-- Sales Account, Account Payable and PeriodPosting flag
      select   GLARSalesAccount, GLAPAccount INTO v_GLDefaultSalesAccount,v_GLAPAccount FROM
      Companies WHERE
      CompanyID = v_CompanyID
      AND DivisionID = v_DivisionID
      AND DepartmentID = v_DepartmentID;

-- get the credit memo number
      SET @SWV_Error = 0;
      CALL GetNextEntityID2(v_CompanyID,v_DivisionID,v_DepartmentID,'NextInvoiceNumber',v_CreditMemoNumber, v_ReturnStatus);
-- An error occured, go to the error handler
      IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then

         SET v_ErrorMessage = 'GetNextEntityID call failed';
         LEAVE WriteError;
      end if;


-- convert vendor to customer
      SET @SWV_Error = 0;
      CALL Customer_CreateFromVendor(v_CompanyID,v_DivisionID,v_DepartmentID,v_VendorID, v_ReturnStatus);
-- An error occured, go to the error handler
      IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then

         SET v_ErrorMessage = 'Customer_CreateFromVendor call failed';
         LEAVE WriteError;
      end if;


-- create the Credit memo header getting all the data from the payment
      SET @SWV_Error = 0;
      INSERT INTO InvoiceHeader(CompanyID,
	DivisionID,
	DepartmentID,
	InvoiceNumber,
	OrderNumber ,
	TransactionTypeID,
	InvoiceDate,
	InvoiceDueDate,
	InvoiceShipDate,
	InvoiceCancelDate,
	SystemDate,
	PurchaseOrderNumber,
	TaxExemptID,
	TaxGroupID,
	CustomerID,
	TermsID,
	CurrencyID,
	CurrencyExchangeRate,
	Subtotal,
	DiscountPers,
	DiscountAmount,
	TaxPercent,
	TaxAmount,
	TaxableSubTotal,
	Freight,
	TaxFreight,
	Handling,
	Advertising,
	Total,
	EmployeeID,
	Commission,
	CommissionableSales,
	ComissionalbleCost,
	CustomerDropShipment,
	ShipMethodID,
	WarehouseID,
	ShipToID,
	ShipForID,
	ShippingName,
	ShippingAddress1,
	ShippingAddress2,
	ShippingAddress3,
	ShippingCity,
	ShippingState,
	ShippingZip,
	ShippingCountry,
	GLSalesAccount,
	PaymentMethodID,
	AmountPaid,
	BalanceDue,
	UndistributedAmount,
	CheckNumber,
	CheckDate,
	CreditCardTypeID,
	CreditCardName,
	CreditCardNumber,
	CreditCardExpDate,
	CreditCardCSVNumber,
	CreditCardBillToZip,
	CreditCardValidationCode,
	CreditCardApprovalNumber,
	Picked,
	PickedDate,
	Printed,
	PrintedDate,
	Shipped,
	ShipDate,
	TrackingNumber,
	BilledDate,
	Billed,
	Backordered,
	Posted,
	PostedDate,
	HeaderMemo1,
	HeaderMemo2,
	HeaderMemo3,
	HeaderMemo4,
	HeaderMemo5,
	HeaderMemo6,
	HeaderMemo7,
	HeaderMemo8,
	HeaderMemo9)
      SELECT
      v_CompanyID,
	v_DivisionID,
	v_DepartmentID,
	v_CreditMemoNumber,
	NULL,
	'Credit Memo',
	PaymentDate, -- InvoiceDate,
	DueToDate, -- InvoiceDueDate,
	'1980-01-01 00:00:00', -- InvoiceShipDate,
	'1980-01-01 00:00:00', -- InvoiceCancelDate,
	CURRENT_TIMESTAMP, -- SystemDate,
	NULL, -- PurchaseOrderNumber,
	NULL, -- TaxExemptID,
	NULL, -- TaxGroupID,
	VendorID, -- CustomerID,
	NULL, -- TermsID,
	CurrencyID, -- CurrencyID,
	CurrencyExchangeRate, -- CurrencyExchangeRate,
	v_CreditAmount, -- Subtotal,
	0, -- DiscountPers,
	0, -- DiscountAmount,
	0, -- TaxPercent,
	0, -- TaxAmount,
	0, -- TaxableSubTotal,
	0, -- Freight,
	0, -- TaxFreight,
	0, -- Handling,
	0, -- Advertising,
	v_CreditAmount, -- Total,
	NULL, -- EmployeeID,
	NULL, -- Commission,

	NULL, -- CommissionableSales,
	NULL, -- ComissionalbleCost,
	NULL, -- CustomerDropShipment,
	NULL, -- ShipMethodID,
	NULL, -- WarehouseID,
	NULL, -- ShipToID,
	NULL, -- ShipForID,
	NULL, -- ShippingName,
	NULL, -- ShippingAddress1,
	NULL, -- ShippingAddress2,

	NULL, -- ShippingAddress3,
	NULL, -- ShippingCity,
	NULL, -- ShippingState,
	NULL, -- ShippingZip,
	NULL, -- ShippingCountry,
	NULL, -- GLSalesAccount,
	NULL, -- PaymentMethodID,
	0, -- AmountPaid,
	v_CreditAmount, -- BalanceDue,
	0, -- UndistributedAmount,
	NULL, -- CheckNumber,
	NULL, -- CheckDate,
	NULL, -- CreditCardTypeID,
	NULL, -- CreditCardName,
	NULL, -- CreditCardNumber,
	NULL, -- CreditCardExpDate,
	NULL, -- CreditCardCSVNumber,
	NULL, -- CreditCardBillToZip,
	NULL, -- CreditCardValidationCode,
	NULL, -- CreditCardApprovalNumber,
	0, -- Picked,
	'1980-01-01 00:00:00', -- PickedDate,
	0, -- Printed,
	'1980-01-01 00:00:00', -- PrintedDate,
	0, -- Shipped,
	'1980-01-01 00:00:00', -- ShipDate,
	NULL, -- TrackingNumber,
	'1980-01-01 00:00:00', -- BilledDate,
	0, -- Billed,
	0, -- Backordered,
	0, -- Posted,
	'1980-01-01 00:00:00', -- PostedDate,
	NULL, -- HeaderMemo1,
	NULL, -- HeaderMemo2,
	NULL, -- HeaderMemo3,
	NULL, -- HeaderMemo4,
	NULL, -- HeaderMemo5,
	NULL, -- HeaderMemo6,
	NULL, -- HeaderMemo7,
	NULL, -- HeaderMemo8,
	NULL -- HeaderMemo9
      FROM
      PaymentsHeader
      WHERE
      CompanyID = v_CompanyID
      AND DivisionID = v_DivisionID
      AND DepartmentID = v_DepartmentID
      AND PaymentID = v_PaymentID;


-- An error occured, go to the error handler
      IF @SWV_Error <> 0 then

         SET v_ErrorMessage = 'Cannot create the credit memo header';
         LEAVE WriteError;
      end if;



-- create the credit memo details getting all the data from the payment
      SET @SWV_Error = 0;
      INSERT INTO InvoiceDetail(CompanyID,
	DivisionID,
	DepartmentID,
	InvoiceNumber,
	ItemID,
	WarehouseID,
	SerialNumber,
	OrderQty,
	BackOrdered,
	BackOrderQty,
	ItemUOM,
	ItemWeight,
	Description,
	DiscountPerc,
	Taxable,
	ItemCost,
	ItemUnitPrice,
	Total,
	TotalWeight,
	GLSalesAccount,
	ProjectID,
	TrackingNumber,
	DetailMemo1,
	DetailMemo2,
	DetailMemo3,
	DetailMemo4,
	DetailMemo5)
VALUES(v_CompanyID,
	v_DivisionID,
	v_DepartmentID,
	v_CreditMemoNumber,
	'Credit Memo', -- ItemID,
	NULL, -- WarehouseID,
	NULL, -- SerialNumber,
	1, -- OrderQty,
	NULL, -- BackOrdered,
	NULL, -- BackOrderQty,
	NULL, -- ItemUOM,
	NULL, -- ItemWeight,
	NULL, -- Description,
	NULL, -- DiscountPerc,
	NULL, -- Taxable,
	NULL, -- ItemCost,
	NULL, -- ItemUnitPrice,
	v_CreditAmount, -- Total,
	NULL, -- TotalWeight,
	v_GLAPAccount, -- GLSalesAccount,
	v_ProjectID, -- ProjectID,
	NULL, -- TrackingNumber,
	NULL, -- DetailMemo1,
	NULL, -- DetailMemo2,
	NULL, -- DetailMemo3,
	NULL, -- DetailMemo4,
	NULL -- DetailMemo5
);

-- An error occured, go to the error handler

      IF @SWV_Error <> 0 then

         SET v_CreditMemoNumber = N'';
         SET v_ErrorMessage = 'Cannot create Credit Memo Details';
         LEAVE WriteError;
      end if;
      SET @SWV_Error = 0;
      CALL CreditMemo_Post(v_CompanyID,v_DivisionID,v_DepartmentID,v_CreditMemoNumber, @postingResult, v_ReturnStatus);
      IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then

         SET v_ErrorMessage = 'CreditMemo_Post call failed';
         LEAVE WriteError;
      end if;


-- void the payment
      UPDATE
      PaymentsHeader
      SET
      Paid = 1
      WHERE
      CompanyID = v_CompanyID
      AND DivisionID = v_DivisionID
      AND DepartmentID = v_DepartmentID
      AND PaymentID = v_PaymentID;


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
   END;
   IF (NOT (v_Void = 1 OR v_Posted = 0 OR v_CreditAmount <= 0)) AND 1  /*NOT SUPPORTED @@TRANCOUNT*/< 2 then
      ROLLBACK;
   ELSE
      COMMIT;
   end if;
-- the error handler
   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payment_CreateCreditMemo',v_ErrorMessage,
   v_ErrorID);
   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PaymentID',v_PaymentID);

   IF (NOT (v_Void = 1 OR v_Posted = 0 OR v_CreditAmount <= 0)) then
      SET SWP_Ret_Value = -1;
      LEAVE SWL_return;
   ELSE
      SET SWP_Ret_Value = v_ReturnStatus;
      LEAVE SWL_return;
   end if;
END;



//

DELIMITER ;

DELIMITER //
DROP PROCEDURE IF EXISTS CreditMemo_Post;
//
CREATE         PROCEDURE CreditMemo_Post -- 'DINOS', 'DEFAULT', 'DEFAULT', '2150', ''
	(v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_InvoiceNumber NATIONAL VARCHAR(36),
	INOUT v_PostingResult NATIONAL VARCHAR(200) ,INOUT SWP_Ret_Value INT)
   SWL_return:
BEGIN




/*
Name of stored procedure: CreditMemo_Post
Method: 
	Stored procedure used to post a credit memo
	It performs all nessesary checks, posts credit memo to LedgerTransactions Table
	and set credit memo Posted flag to 1

Date Created: EDE - 07/28/2015

Input Parameters:

	@CompanyID NVARCHAR(36)		 - the ID of the company
	@DivisionID NVARCHAR(36)	 - the ID of the division
	@DepartmentID NVARCHAR(36)	 - the ID of the department
	@InvoiceNumber NVARCHAR(36)	 - the Invoice Number

Output Parameters:

	@PostingResult NVARCHAR(200)	 - returns error message that should be displayed for user

Called From:

	ServiceInvoice_Post, Invoice_Control, Receipt_Cash, Invoice_Post, ReturnInvoice_Post, ReturnReceipt_Cash

Calls:

	LedgerMain_VerifyPeriod, CreditMemo_CreateGLTransaction, Error_InsertError, Error_InsertErrorDetail

Last Modified: 

Last Modified By: 

Revision History: 

*/
   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);

   DECLARE v_GLSalesAccount NATIONAL VARCHAR(36);
   DECLARE v_Posted BOOLEAN;
   DECLARE v_PostDate NATIONAL VARCHAR(1);
   DECLARE v_PeriodClosed INT;
   DECLARE v_PeriodToPost INT;
   DECLARE v_AmountPaid DECIMAL(19,4);
   DECLARE v_Total DECIMAL(19,4);
   DECLARE v_TranDate DATETIME;
   DECLARE v_ErrorID INT;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
   END;
   SET @SWV_Error = 0;
   IF NOT EXISTS(SELECT * FROM
   InvoiceDetail
   WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   InvoiceNumber = v_InvoiceNumber) then

      SET v_PostingResult = 'Credit Memo was not posted: there are no detail items';
      -- NOT SUPPORTED Print @PostingResult
SET SWP_Ret_Value = -1;
      LEAVE SWL_return;
   end if;

   IF EXISTS(SELECT * FROM
   InvoiceDetail
   WHERE
   IFNULL(Total,0) = 0 AND
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   InvoiceNumber = v_InvoiceNumber) then

      SET v_PostingResult = 'Credit Memo was not posted: there is the detail item with undefined Total value';
      -- NOT SUPPORTED Print @PostingResult
SET SWP_Ret_Value = -1;
      LEAVE SWL_return;
   end if;

   select   IFNULL(Posted,0) INTO v_Posted FROM
   InvoiceHeader WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND InvoiceNumber = v_InvoiceNumber;

-- Do not post posted Credit Memo
   IF v_Posted = 1 then

      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;
   end if;

-- get current posting Period from companies
   select   IFNULL(DefaultGLPostingDate,'1') INTO v_PostDate FROM
   Companies WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID;


-- get the post date
   IF v_PostDate = '1' then
      SET v_TranDate = CURRENT_TIMESTAMP;
   ELSE
      select   IFNULL(InvoiceDate,CURRENT_TIMESTAMP) INTO v_TranDate FROM
      InvoiceHeader WHERE
      CompanyID = v_CompanyID
      AND DivisionID = v_DivisionID
      AND DepartmentID = v_DepartmentID
      AND InvoiceNumber = v_InvoiceNumber;
   end if;

   START TRANSACTION;
   SET @SWV_Error = 0;
   CALL CreditMemo_Recalc(v_CompanyID,v_DivisionID,v_DepartmentID,v_InvoiceNumber, v_ReturnStatus);
   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then

      SET v_ErrorMessage = 'Recalculating the credit memo failed';
      ROLLBACK;
      IF v_ErrorMessage <> '' then

	-- the error handler
	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'CreditMemo_Post',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
      end if;
      SET SWP_Ret_Value = -1;
   end if;

-- get the current Period
   SET @SWV_Error = 0;
   CALL LedgerMain_VerifyPeriod2(v_CompanyID,v_DivisionID,v_DepartmentID,v_TranDate,v_PeriodToPost,v_PeriodClosed, v_ReturnStatus);

   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then
-- An error occured, go to the error handler

      SET v_ErrorMessage = 'LedgerMain_VerifyPeriod call failed';
      ROLLBACK;
      IF v_ErrorMessage <> '' then

	-- the error handler
	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'CreditMemo_Post',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
      end if;
      SET SWP_Ret_Value = -1;
   end if;

   IF v_PeriodClosed <> 0 then
-- the Period is closed, go to the error handler
-- and set the apropriate error message

      SET v_ErrorMessage = 'Period is closed';
      ROLLBACK;
      IF v_ErrorMessage <> '' then

	-- the error handler
	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'CreditMemo_Post',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
      end if;
      SET SWP_Ret_Value = -1;
   end if;



   SET @SWV_Error = 0;
   CALL CreditMemo_CreateGLTransaction(v_CompanyID,v_DivisionID,v_DepartmentID,v_InvoiceNumber, v_ReturnStatus);
   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then

      SET v_ErrorMessage = 'CreditMemo_CreateGLTransaction call failed';
      ROLLBACK;
      IF v_ErrorMessage <> '' then

	-- the error handler
	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'CreditMemo_Post',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
      end if;
      SET SWP_Ret_Value = -1;
   end if;

-- Post Credit Memo
   UPDATE
   InvoiceHeader
   SET
   Posted = 1,PostedDate = CURRENT_TIMESTAMP
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

   IF v_ErrorMessage <> '' then

	-- the error handler
	
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'CreditMemo_Post',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
   end if;
   SET SWP_Ret_Value = -1;
END;
















//

DELIMITER ;

DELIMITER //
DROP PROCEDURE IF EXISTS CreditMemo_CreateGLTransaction;
//
CREATE      PROCEDURE CreditMemo_CreateGLTransaction(v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_InvoiceNumber NATIONAL VARCHAR(36),INOUT SWP_Ret_Value INT)
   SWL_return:
BEGIN













/*
Name of stored procedure: CreditMemo_CreateGLTransaction
Method: 
	Stored procedure used to post a credit memo to LedgerTransactions table

Date Created: EDE - 07/28/2015

Input Parameters:

	@CompanyID NVARCHAR(36)		 - the ID of the company
	@DivisionID NVARCHAR(36)	 - the ID of the division
	@DepartmentID NVARCHAR(36)	 - the ID of the department
	@InvoiceNumber NVARCHAR(36)	 - the Invoice Number

Output Parameters:

	NONE

Called From:

	CreditMemo_Post

Calls:

	VerifyCurrency, GetNextEntityID, LedgerTransactions_PostCOA_AllRecords, Error_InsertError, Error_InsertErrorDetail

Last Modified: 

Last Modified By: 

Revision History: 

*/

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

-- get the amount of money from the Invoice
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

-- Do nothing if Credit Memo is posted already
   IF v_Posted = 1 then
      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;
   end if;
-- Do nothing if there is no money in Credit Memo
   IF v_Total = 0 then
      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;
   end if;

   START TRANSACTION;

   SET @SWV_Error = 0;
   CALL VerifyCurrency2(v_CompanyID,v_DivisionID,v_DepartmentID,v_InvoiceDate,1,v_CompanyCurrencyID,
   v_CurrencyID,v_CurrencyExchangeRate);
   IF @SWV_Error <> 0 then

	-- the procedure will return an error code
      SET v_ErrorMessage = 'Currency retrieving failed';
      ROLLBACK;
      IF v_ErrorMessage <> '' then

	-- the error handler
	
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
	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'CreditMemo_CreateGLTransaction',
         v_ErrorMessage,v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
      end if;
      SET SWP_Ret_Value = -1;
   end if;

-- Get default values from Companies table for
-- Sales Account, Account Payable and DefaultGLPostingDate flag
   select   GLARSalesAccount, GLARAccount, IFNULL(DefaultGLPostingDate,'1') INTO v_GLDefaultSalesAccount,v_GLARAccount,v_PostDate FROM
   Companies WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID;

   SET v_GLDefaultSalesAccount = IFNULL(v_GLSalesAccount,v_GLDefaultSalesAccount);
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
	-- An error occured , drop the temporary table and 
	-- go to the error handler
	
      SET v_ErrorMessage = 'Insert into LedgerTransactions failed';
      ROLLBACK;
      IF v_ErrorMessage <> '' then

	-- the error handler
	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'CreditMemo_CreateGLTransaction',
         v_ErrorMessage,v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
      end if;
      SET SWP_Ret_Value = -1;
   end if;




-- Debit @Total from Sales Account
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
-- go to the error handler

      SET v_ErrorMessage = 'Insert into LedgerTransactionsDetail failed';
      ROLLBACK;
      IF v_ErrorMessage <> '' then

	-- the error handler
	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'CreditMemo_CreateGLTransaction',
         v_ErrorMessage,v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
      end if;
      SET SWP_Ret_Value = -1;
   end if;
		
	
-- Credit @Total to Account Receiviable
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
-- go to the error handler

      SET v_ErrorMessage = 'Insert into LedgerTransactionsDetail failed';
      ROLLBACK;
      IF v_ErrorMessage <> '' then

	-- the error handler
	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'CreditMemo_CreateGLTransaction',
         v_ErrorMessage,v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
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
	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'CreditMemo_CreateGLTransaction',
         v_ErrorMessage,v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
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
	
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'CreditMemo_CreateGLTransaction',
      v_ErrorMessage,v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
   end if;
   SET SWP_Ret_Value = -1;
END;













//

DELIMITER ;

DELIMITER //
DROP PROCEDURE IF EXISTS CreditMemo_Recalc;
//
CREATE     PROCEDURE CreditMemo_Recalc(v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_InvoiceNumber  NATIONAL VARCHAR(36),INOUT SWP_Ret_Value INT)
   SWL_return:
BEGIN














/*
Name of stored procedure: CreditMemo_Recalc
Method: 
	Calculates the amounts of money for a specified invoice

Date Created: EDE - 07/28/2015

Input Parameters:

	@CompanyID NVARCHAR(36)		 - the ID of the company
	@DivisionID NVARCHAR(36)	 - the ID of the division
	@DepartmentID NVARCHAR(36)	 - the ID of the department
	@InvoiceNumber NVARCHAR (36)	 - the ID of invoice that should be recalculated

Output Parameters:

	NONE

Called From:

	CreditMemo_Recalc.vb

Calls:

	VerifyCurrency, Error_InsertError, Error_InsertErrorDetail

Last Modified: 

Last Modified By: 

Revision History: 

*/

   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);
   DECLARE v_CurrencyID NATIONAL VARCHAR(3);
   DECLARE v_CurrencyExchangeRate FLOAT;
   DECLARE v_InvoiceDate DATETIME;
   DECLARE v_Subtotal DECIMAL(19,4);
   DECLARE v_SubtotalMinusDetailDiscount DECIMAL(19,4);
   DECLARE v_Total DECIMAL(19,4);
   DECLARE v_TotalTaxable DECIMAL(19,4);
   DECLARE v_DiscountPers FLOAT;
   DECLARE v_DiscountAmount DECIMAL(19,4);
   DECLARE v_TaxAmount DECIMAL(19,4);
   DECLARE v_Freight DECIMAL(19,4);
   DECLARE v_Handling DECIMAL(19,4);
   DECLARE v_TaxFreight BOOLEAN;
   DECLARE v_Posted BOOLEAN;
   DECLARE v_Picked BOOLEAN;

   DECLARE v_TaxPercent FLOAT;
   DECLARE v_TaxGroupID NATIONAL VARCHAR(36);

   DECLARE v_ItemOrderQty FLOAT;
   DECLARE v_ItemUnitPrice FLOAT;
   DECLARE v_ItemTotal DECIMAL(19,4);
   DECLARE v_ItemDiscountPerc FLOAT;
   DECLARE v_ItemTaxable BOOLEAN;
   DECLARE v_AllowanceDiscountAmount DECIMAL(19,4);

   DECLARE v_CompanyCurrencyID NATIONAL VARCHAR(36);

   DECLARE v_ErrorID INT;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
   END;
   SET @SWV_Error = 0;
   SET v_TaxPercent = 0;

-- get the information about the order status
   select   IFNULL(Posted,0), IFNULL(Picked,0) INTO v_Posted,v_Picked FROM
   InvoiceHeader WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   InvoiceNumber = v_InvoiceNumber;	

   IF v_Posted = 1 then

      IF v_Picked = 1 then 
	-- if the order is posted and picked return
	
         SET SWP_Ret_Value = 0;
         LEAVE SWL_return;
      end if;
   end if;

-- get the currency id for the order header
   select   CurrencyID, CurrencyExchangeRate, InvoiceDate, IFNULL(DiscountPers,0), IFNULL(TaxFreight,0), IFNULL(Freight,0), IFNULL(Handling,0), TaxGroupID INTO v_CurrencyID,v_CurrencyExchangeRate,v_InvoiceDate,v_DiscountPers,v_TaxFreight,
   v_Freight,v_Handling,v_TaxGroupID FROM
   InvoiceHeader WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   InvoiceNumber = v_InvoiceNumber;

   START TRANSACTION;

   SET @SWV_Error = 0;
   CALL VerifyCurrency2(v_CompanyID,v_DivisionID,v_DepartmentID,v_InvoiceDate,1,v_CompanyCurrencyID,
   v_CurrencyID,v_CurrencyExchangeRate);
   IF @SWV_Error <> 0 then

	-- the procedure will return an error code
      SET v_ErrorMessage = 'Currency retrieving failed';
      ROLLBACK;
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'CreditMemo_Recalc',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
      SET SWP_Ret_Value = -1;
   end if;


-- get the details Totals
   select   IFNULL(SUM(Total),0) INTO v_Subtotal FROM
   InvoiceDetail WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND InvoiceNumber = v_InvoiceNumber;



   SET v_Total = v_Subtotal; 

   SET @SWV_Error = 0;
   UPDATE
   InvoiceHeader
   SET
   Subtotal = v_Subtotal,DiscountAmount = 0,TaxableSubTotal = v_Total,TaxPercent = 0,
   TaxAmount = 0,Total = v_Total,BalanceDue = v_Total -IFNULL(AmountPaid,0)
   WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND InvoiceNumber = v_InvoiceNumber;

   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Recalculating order header totals failed';
      ROLLBACK;
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'CreditMemo_Recalc',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
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

   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'CreditMemo_Recalc',v_ErrorMessage,
   v_ErrorID);

   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);

   SET SWP_Ret_Value = -1;
END;











//

DELIMITER ;
