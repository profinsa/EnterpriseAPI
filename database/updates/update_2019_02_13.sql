DELIMITER //
DROP PROCEDURE IF EXISTS Invoice_Control;
//
CREATE          PROCEDURE Invoice_Control(v_CompanyID NATIONAL VARCHAR(36), 
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_InvoiceNumber NATIONAL VARCHAR(36),
	INOUT v_PostingResult NATIONAL VARCHAR(200) ,INOUT SWP_Ret_Value INT)
   SWL_return:
BEGIN














/*
Name of stored procedure: Invoice_Control
Method: 
	Passes Invoice Document to Proper posting routine

Date Created: EDE - 07/28/2015

Input Parameters:

	@CompanyID NVARCHAR(36)		 - the ID of the company
	@DivisionID NVARCHAR(36)	 - the ID of the division
	@DepartmentID NVARCHAR(36)	 - the ID of the department
	@InvoiceNumber NVARCHAR(36)	 - the ID of the document

Output Parameters:

	@PostingResult NVARCHAR(200)	 - error message that should be displayed for end user

Called From:

	Invoice_Control.vb

Calls:

	CreditMemo_Post, Invoice_Post, ReturnInvoice_Post, ServiceInvoice_Post, Error_InsertError, Error_InsertErrorDetail

Last Modified: 

Last Modified By: 

Revision History: 

*/

   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);

   DECLARE v_DocumentTypeID NATIONAL VARCHAR(36);

-- get the invoice type to know what procedure to call for posting
   DECLARE v_ErrorID INT;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
   END;
   select   TransactionTypeID INTO v_DocumentTypeID FROM
   InvoiceHeader WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   InvoiceNumber = v_InvoiceNumber;

-- the calls to the apropriate posting routines
   IF LOWER(v_DocumentTypeID) = LOWER('Credit Memo') then

      SET @SWV_Error = 0;
      SET v_ReturnStatus = CreditMemo_Post2(v_CompanyID,v_DivisionID,v_DepartmentID,v_InvoiceNumber,v_PostingResult);
      IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then
	-- An error occured, go to the error handler
	
         IF IFNULL(v_PostingResult,N'') <> N'' then
            SET v_ErrorMessage = v_PostingResult;
         ELSE
            SET v_ErrorMessage = 'CreditMemo_Post call failed';
         end if;
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Invoice_Control',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'DocumentNumber',v_InvoiceNumber);
         SET SWP_Ret_Value = -1;
      end if;
   end if;

   IF LOWER(v_DocumentTypeID) = LOWER('Invoice') then

      SET @SWV_Error = 0;
      CALL Invoice_Post2(v_CompanyID,v_DivisionID,v_DepartmentID,v_InvoiceNumber,0,v_PostingResult, v_ReturnStatus);
      IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then
	-- An error occured, go to the error handler
	
         IF IFNULL(v_PostingResult,N'') <> N'' then
            SET v_ErrorMessage = v_PostingResult;
         ELSE
            SET v_ErrorMessage = 'Invoice_Post call failed';
         end if;
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Invoice_Control',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'DocumentNumber',v_InvoiceNumber);
         SET SWP_Ret_Value = -1;
      end if;
   end if;

   IF LOWER(v_DocumentTypeID) = LOWER('Return') then

      SET @SWV_Error = 0;
      SET v_ReturnStatus = ReturnInvoice_Post(v_CompanyID,v_DivisionID,v_DepartmentID,v_InvoiceNumber,v_PostingResult);
      IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then
	-- An error occured, go to the error handler
	
         IF IFNULL(v_PostingResult,N'') <> N'' then
            SET v_ErrorMessage = v_PostingResult;
         ELSE
            SET v_ErrorMessage = 'ReturnInvoice_Post call failed';
         end if;
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Invoice_Control',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'DocumentNumber',v_InvoiceNumber);
         SET SWP_Ret_Value = -1;
      end if;
   end if;

   IF LOWER(v_DocumentTypeID) = LOWER('Service Invoice') then

      SET @SWV_Error = 0;
      SET v_ReturnStatus = ServiceInvoice_Post(v_CompanyID,v_DivisionID,v_DepartmentID,v_InvoiceNumber,v_PostingResult);
      IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then
	-- An error occured, go to the error handler
	
         IF IFNULL(v_PostingResult,N'') <> N'' then
            SET v_ErrorMessage = v_PostingResult;
         ELSE
            SET v_ErrorMessage = 'ServiceInvoice_Post call failed';
         end if;
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Invoice_Control',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'DocumentNumber',v_InvoiceNumber);
         SET SWP_Ret_Value = -1;
      end if;
   end if;

-- Everything is OK
   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;


-- if an error occured in the procedure this code will be executed
-- The information about the error are entered in the ErrrorLog and ErrorLogDetail tables.
-- The company, division, department informations are inserted in the ErrorLog table
-- along with information about the name of the procedure and the error message and an errorID is obtained.
-- The aditional information about other procedure parameters are inserted along with the errorID in the ErrorLogDetail table
-- (about the other parameters the name and the value are inserted).

-- the error handler
   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Invoice_Control',v_ErrorMessage,
   v_ErrorID);

   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'DocumentNumber',v_InvoiceNumber);

   SET SWP_Ret_Value = -1;
END;




//

DELIMITER ;

-- Stored procedure definition script Invoice_Post2 for MySQL
-- Generated by (c) Ispirer SQLWays 4.0 Build 219 Licensed to STFB
-- Timestamp: Tue Jul 28 16:20:00 2015

DELIMITER //
DROP PROCEDURE IF EXISTS Invoice_Post2;
//
CREATE      PROCEDURE Invoice_Post2(v_CompanyID NATIONAL VARCHAR(36), 
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_InvoiceNumber NATIONAL VARCHAR(36),
	v_CalledFrom INT,
	INOUT v_PostingResult NATIONAL VARCHAR(200) ,INOUT SWP_Ret_Value INT)
   SWL_return:
BEGIN



/*
Name of stored procedure: Invoice_Post
Method: 
	performs all the necessary actions to post an invoice
	and post it t General Ledger

Date Created: EDE - 07/28/2015

Input Parameters:

	@CompanyID NVARCHAR(36)		 - the ID of the company
	@DivisionID NVARCHAR(36)	 - the ID of the division
	@DepartmentID NVARCHAR(36)	 - the ID of the department
	@InvoiceNumber NVARCHAR(36)	 - the ID of the invoice
	@CalledFrom INT							- called from: 
																0 - Invoice_Control
																1 - Invoice_CreateFromOrder
																2 - Invoice_CreateFromReturn

Output Parameters:

	@PostingResult NVARCHAR(200)	 - returns error message that should be displayed for user

Called From:

	Invoice_Control, Invoice_CreateFromOrder, Invoice_CreateFromReturn, Invoice_Post.vb

Calls:

	Invoice_CreateGLTransaction, Error_InsertError, CustomerFinancials_Recalc, Receipt_CreateFromInvoice, Invoice_Recalc, Receipt_Post, LedgerMain_VerifyPeriod, Error_InsertErrorDetail, CreditMemo_CreateFromInvoice, Invoice_AdjustInventory, Inventory_CreateILTransaction, VerifyCurrency, CreditMemo_Post, Invoice_CustomerFinancialsUpdateAging, Invoice_AdjustCustomerFinancials

Last Modified: 

Last Modified By: 

Revision History: 

*/

   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);

   DECLARE v_Rest DECIMAL(19,4);
   DECLARE v_PostDate NATIONAL VARCHAR(1);
   DECLARE v_TranDate DATETIME;
   DECLARE v_PeriodToPost INT;
   DECLARE v_PeriodClosed INT;
   DECLARE v_InvoiceType NATIONAL VARCHAR(36);
   DECLARE v_BankKey NATIONAL VARCHAR(36);
   DECLARE v_Amount DECIMAL(19,4);
   DECLARE v_TotalAmount DECIMAL(19,4);
   DECLARE v_ConvertedAmount DECIMAL(19,4);
   DECLARE v_ConvertedTotalAmount DECIMAL(19,4);
   DECLARE v_CurrencyID NATIONAL VARCHAR(3);
   DECLARE v_CurrencyExchangeRate FLOAT;
   DECLARE v_CustomerSalesAcct NATIONAL VARCHAR(36);
   DECLARE v_CustomerID NATIONAL VARCHAR(36);
   DECLARE v_DefaultInventoryCostingMethod CHAR(1);
   DECLARE v_InventoryCost DECIMAL(19,4);

   DECLARE v_InvoiceLineNumber NUMERIC(18,0);
   DECLARE v_ItemID NATIONAL VARCHAR(36);
   DECLARE v_OrderQty NATIONAL VARCHAR(36);
   DECLARE v_ItemUnitPrice DECIMAL(19,4);
   DECLARE v_ItemCost DECIMAL(19,4);
   DECLARE v_ItemCurrencyID NATIONAL VARCHAR(3); 
   DECLARE v_CompanyCurrencyID NATIONAL VARCHAR(3);
   DECLARE v_ItemCurrencyExchangeRate FLOAT;
   DECLARE v_InvoiceDate DATETIME;
   DECLARE v_Posted BOOLEAN;
   DECLARE v_ProjectID NATIONAL VARCHAR(36);
   DECLARE v_PaymentMethodID NATIONAL VARCHAR(36);
   DECLARE v_ReceiptID NATIONAL VARCHAR(36);
   DECLARE v_Cleared BOOLEAN;
   DECLARE v_Success BOOLEAN;

   DECLARE v_WarehouseID NATIONAL VARCHAR(36);
   DECLARE v_WarehouseBinID NATIONAL VARCHAR(36);
   DECLARE v_SerialNumber NATIONAL VARCHAR(50);

   DECLARE v_TransactionTypeID NATIONAL VARCHAR(36);
   DECLARE v_ConvertedItemCost DECIMAL(19,4);
-- We select OrderQty as negative value
-- to post it to InventoryLedger table as outgoing inventory
   DECLARE v_ErrorID INT;
   DECLARE NO_DATA INT DEFAULT 0;
   DECLARE v_CreditMemoNumber NATIONAL VARCHAR(36);
   DECLARE cInvoiceDetail CURSOR FOR
   SELECT
   InvoiceLineNumber,
		ItemID,
		IFNULL(ItemUnitPrice,0),
		IFNULL(ItemCost,0),
		-IFNULL(OrderQty,0),
		WarehouseID,
		WarehouseBinID,
		SerialNumber
   FROM
   InvoiceDetail
   WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   InvoiceNumber = v_InvoiceNumber;

   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
      SET NO_DATA = -2;
   END;
   DECLARE CONTINUE HANDLER FOR NOT FOUND SET NO_DATA = -1;
   SET @SWV_Error = 0;
   IF NOT EXISTS(SELECT * FROM
   InvoiceDetail
   WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   InvoiceNumber = v_InvoiceNumber) then

      SET v_PostingResult = 'Invoice was not posted: there are no detail items';
      SET SWP_Ret_Value = -1;
      LEAVE SWL_return;
   end if;

   IF EXISTS(SELECT * FROM
   InvoiceDetail
   WHERE
   IFNULL(OrderQty,0) = 0 AND
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   InvoiceNumber = v_InvoiceNumber) then

      SET v_PostingResult = 'Invoice was not posted: there is the detail item with undefined Order Qty value';
      SET SWP_Ret_Value = -1;
      LEAVE SWL_return;
   end if;

   select   Posted INTO v_Posted FROM
   InvoiceHeader WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   InvoiceNumber = v_InvoiceNumber;
	
-- if the invoice is allready posted return	
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

   START TRANSACTION;
-- Recalculate the invoice before posting
-- EXEC @ReturnStatus = Invoice_RecalcCLR @CompanyID,@DivisionID,@DepartmentID, @InvoiceNumber
   SET @SWV_Error = 0;
   CALL Invoice_Recalc2(v_CompanyID,v_DivisionID,v_DepartmentID,v_InvoiceNumber, v_ReturnStatus);
   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then
-- An error occured, go to the error handler

      SET v_ErrorMessage = 'Invoice_Recalc call failed';
      ROLLBACK;
-- the error handler
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Invoice_Post',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
      SET SWP_Ret_Value = -1;
   end if;



-- get informations from invoice
   select   IFNULL(TransactionTypeID,N''), IFNULL(AmountPaid,0), IFNULL(Total,0), CurrencyID, CurrencyExchangeRate, InvoiceDate, IFNULL(GLSalesAccount,N''), IFNULL(GLSalesAccount,N''), CustomerID, IFNULL(PaymentMethodID,N''), CASE CreditCardApprovalNumber
   WHEN NULL THEN 0
   ELSE 1
   END, IFNULL(TransactionTypeID,N'') INTO v_InvoiceType,v_Amount,v_TotalAmount,v_CurrencyID,v_CurrencyExchangeRate,
   v_InvoiceDate,v_CustomerSalesAcct,v_BankKey,v_CustomerID,v_PaymentMethodID,
   v_Cleared,v_TransactionTypeID FROM
   InvoiceHeader WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND InvoiceNumber = v_InvoiceNumber;

   select   ProjectID INTO v_ProjectID FROM InvoiceDetail WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   InvoiceNumber = v_InvoiceNumber AND
   NOT ProjectID IS NULL   LIMIT 1;



-- called from Manually Entering Invoice
   IF v_CalledFrom = 0 then

      SET @SWV_Error = 0;
      CALL Invoice_DebitInventory(v_CompanyID,v_DivisionID,v_DepartmentID,v_InvoiceNumber, v_ReturnStatus);
      IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then
	-- An error occured, go to the error handler
	
         SET v_ErrorMessage = 'Invoice_DebitInventory call failed';
         ROLLBACK;
-- the error handler
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Invoice_Post',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
         SET SWP_Ret_Value = -1;
      end if;
   end if;



   SET @SWV_Error = 0;
   CALL VerifyCurrency2(v_CompanyID,v_DivisionID,v_DepartmentID,v_InvoiceDate,1,v_CompanyCurrencyID,
   v_CurrencyID,v_CurrencyExchangeRate);
   IF @SWV_Error <> 0 then

	-- the procedure will return an error code
      SET v_ErrorMessage = 'Currency retrieving failed';
      ROLLBACK;
-- the error handler
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Invoice_Post',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
      SET SWP_Ret_Value = -1;
   end if;

-- begin the posting process

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

-- verify the Period of time
   SET @SWV_Error = 0;
   CALL LedgerMain_VerifyPeriod2(v_CompanyID,v_DivisionID,v_DepartmentID,v_TranDate,v_PeriodToPost,v_PeriodClosed, v_ReturnStatus);
   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then
-- An error occured, go to the error handler

      SET v_ErrorMessage = 'LedgerMain_VerifyPeriod call failed';
      ROLLBACK;
-- the error handler
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Invoice_Post',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
      SET SWP_Ret_Value = -1;
   end if;

   IF v_PeriodClosed <> 0 then
-- the Period is closed, go to the error handler
-- and set the apropriate error message

      SET v_ErrorMessage = 'Period is closed';
      ROLLBACK;
-- the error handler
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Invoice_Post',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
      SET SWP_Ret_Value = -1;
   end if;

-- debit the inventory from the Committed field
   SET @SWV_Error = 0;
   CALL Invoice_AdjustInventory(v_CompanyID,v_DivisionID,v_DepartmentID,v_InvoiceNumber, v_ReturnStatus);
   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then
-- An error occured, go to the error handler

      SET v_ErrorMessage = 'Invoice_AdjustInventory call failed';
      ROLLBACK;
-- the error handler
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Invoice_Post',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
      SET SWP_Ret_Value = -1;
   end if;


-- get the amount unpaid
   select   IFNULL(Total,0) -IFNULL(AmountPaid,0) INTO v_Rest FROM
   InvoiceHeader WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND InvoiceNumber = v_InvoiceNumber;
   SET v_Rest = fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,v_Rest,v_CompanyCurrencyID);

   IF ABS(v_Rest) > 0.005 then

      IF v_Rest < 0 then
	
		
	
		-- Create credit memo for extra money
         SET v_Rest = -v_Rest; -- we should post extra money as positive value
         SET @SWV_Error = 0;
         SET v_ReturnStatus = CreditMemo_CreateFromInvoice2(v_CompanyID,v_DivisionID,v_DepartmentID,v_InvoiceNumber,v_Rest,v_CreditMemoNumber);
         IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then
		-- An error occured, go to the error handler
		
            SET v_ErrorMessage = 'CreditMemo_CreateFromInvoice call failed';
            ROLLBACK;
-- the error handler
            CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Invoice_Post',v_ErrorMessage,
            v_ErrorID);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
            SET SWP_Ret_Value = -1;
         end if;
         SET @SWV_Error = 0;
         SET v_ReturnStatus = CreditMemo_Post2(v_CompanyID,v_DivisionID,v_DepartmentID,v_CreditMemoNumber,v_PostingResult);
         IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then
		-- An error occured, go to the error handler
		
            SET v_ErrorMessage = 'CreditMemo_Post call failed';
            ROLLBACK;
-- the error handler
            CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Invoice_Post',v_ErrorMessage,
            v_ErrorID);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
            SET SWP_Ret_Value = -1;
         end if;
      end if;
   end if;


	
-- update cost for items in invetory

-- get @DefaultInventoryCostingMethod 
   select   IFNULL(DefaultInventoryCostingMethod,'F') INTO v_DefaultInventoryCostingMethod FROM
   Companies WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID;

   OPEN cInvoiceDetail;
   SET NO_DATA = 0;
   FETCH cInvoiceDetail INTO v_InvoiceLineNumber,v_ItemID,v_ItemUnitPrice,v_ItemCost,v_OrderQty,v_WarehouseID, 
   v_WarehouseBinID,v_SerialNumber;


   WHILE NO_DATA = 0 DO
	-- Post inventory changes to InventoryLedger table and recalc item cost
      SET v_ConvertedItemCost = fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,v_ItemCost*v_CurrencyExchangeRate, 
      v_CompanyCurrencyID);
      SET @SWV_Error = 0;
      CALL Inventory_CreateILTransaction2(v_CompanyID,v_DivisionID,v_DepartmentID,v_TranDate,v_ItemID,'Invoice',
      v_InvoiceNumber,v_InvoiceLineNumber,v_OrderQty,v_ConvertedItemCost, v_ReturnStatus);
      IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then
	-- An error occured, go to the error handler
	
         CLOSE cInvoiceDetail;
		
         SET v_ErrorMessage = 'Inventory_CreateILTransaction call failed';
         ROLLBACK;
-- the error handler
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Invoice_Post',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
         SET SWP_Ret_Value = -1;
      end if;
      select(CASE(v_DefaultInventoryCostingMethod)
      WHEN 'F' THEN FIFOCost
      WHEN 'L' THEN LIFOCost
      WHEN 'A' THEN AverageCost
      END) INTO v_InventoryCost FROM
      InventoryItems WHERE
      CompanyID = v_CompanyID AND
      DivisionID = v_DivisionID AND
      DepartmentID = v_DepartmentID AND
      ItemID = v_ItemID;
      IF v_CurrencyID <> v_CompanyCurrencyID then
	
         SET v_InventoryCost = fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,(1/v_CurrencyExchangeRate)*v_InventoryCost, 
         v_CompanyCurrencyID);
      end if;
      SET @SWV_Error = 0;
      UPDATE
      InvoiceDetail
      SET
      ItemCost = CAST(v_InventoryCost AS DECIMAL(19,4))
      WHERE
      CompanyID = v_CompanyID AND
      DivisionID = v_DivisionID AND
      DepartmentID = v_DepartmentID AND
      InvoiceNumber = v_InvoiceNumber AND
      InvoiceLineNumber = v_InvoiceLineNumber;
      IF @SWV_Error <> 0 then
	-- An error occured, go to the error handler
	
         CLOSE cInvoiceDetail;
		
         SET v_ErrorMessage = 'Update InvoiceDetail failed';
         ROLLBACK;
-- the error handler
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Invoice_Post',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
         SET SWP_Ret_Value = -1;
      end if;
      SET @SWV_Error = 0;
      CALL SerialNumber_Invoice_Get2(v_CompanyID,v_DivisionID,v_DepartmentID,v_WarehouseID,v_WarehouseBinID,
      v_SerialNumber,v_ItemID,v_InvoiceNumber,v_InvoiceLineNumber, v_ReturnStatus);
      IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then
	
         CLOSE cInvoiceDetail;
		
         SET v_ErrorMessage = 'SerialNumber_Invoice_Get failed';
         ROLLBACK;
-- the error handler
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Invoice_Post',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
         SET SWP_Ret_Value = -1;
      end if;
      SET NO_DATA = 0;
      FETCH cInvoiceDetail INTO v_InvoiceLineNumber,v_ItemID,v_ItemUnitPrice,v_ItemCost,v_OrderQty,v_WarehouseID, 
      v_WarehouseBinID,v_SerialNumber;
   END WHILE;

   CLOSE cInvoiceDetail;



-- CREATE THE TRANSACTION FROM THE INVOICE
/*
parameters	@CompanyID NVARCHAR(36),
		@DivisionID NVARCHAR(36),
		@DepartmentID NVARCHAR(36),
		@InvoiceNumber NVARCHAR (36)
		used to identify the invoice
		@PostDate NVARCHAR(1) - used in the process of creation of the transaction
*/
   SET @SWV_Error = 0;
   CALL Invoice_CreateGLTransaction(v_CompanyID,v_DivisionID,v_DepartmentID,v_InvoiceNumber,v_PostDate, v_ReturnStatus);
   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then
-- An error occured, go to the error handler

      SET v_ErrorMessage = 'Invoice_CreateGLTransaction call failed';
      ROLLBACK;
-- the error handler
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Invoice_Post',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
      SET SWP_Ret_Value = -1;
   end if;


   SET @SWV_Error = 0;
   UPDATE
   InvoiceHeader
   SET
   Posted = 1,PostedDate = CURRENT_TIMESTAMP
   WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   InvoiceNumber = v_InvoiceNumber;

   IF @SWV_Error <> 0 then
-- An error occured, go to the error handler

      SET v_ErrorMessage = 'InvoiceHeader update failed';
      ROLLBACK;
-- the error handler
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Invoice_Post',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
      SET SWP_Ret_Value = -1;
   end if;	

-- CREATE THE RECEIPT
/*
parameters	@CompanyID NVARCHAR(36),
		@DivisionID NVARCHAR(36),
		@DepartmentID NVARCHAR(36),
		@InvoiceNumber NVARCHAR (36)
		used to identify the order
		@ReceiptID output parameter; stores the new created invoice number; if @ReceiptID is N'' then exit the procedure
*/
   SET @SWV_Error = 0;
   CALL Receipt_CreateFromInvoice2(v_CompanyID,v_DivisionID,v_DepartmentID,v_InvoiceNumber,v_ReceiptID, v_ReturnStatus);
   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then

      SET v_ErrorMessage = 'Creating receipt from invoice failed';
      ROLLBACK;
-- the error handler
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Invoice_Post',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
      SET SWP_Ret_Value = -1;
   end if;

   IF IFNULL(v_ReceiptID,N'') <> N'' then

	-- POST THE RECEIPT
	/*
	call the procedure thet posts the new created invoice
	parameters	@CompanyID NVARCHAR(36),
			@DivisionID NVARCHAR(36),
			@DepartmentID NVARCHAR(36),
			@ReceiptID NVARCHAR (36)
			used to identify the reciept
			@Succes output parameter; stores the new created invoice number; if @Succes is 0 then exit the procedure
	*/
      SET @SWV_Error = 0;
      SET v_ReturnStatus = Receipt_Post(v_CompanyID,v_DivisionID,v_DepartmentID,v_ReceiptID,v_Success,v_PostingResult);
      IF @SWV_Error <> 0 OR v_ReturnStatus = -1 OR  v_Success = 0 then
	
         SET v_ErrorMessage = 'Posting the receipt failed';
         ROLLBACK;
-- the error handler
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Invoice_Post',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
         SET SWP_Ret_Value = -1;
      end if;
	-- update the receipt header and substract from the credit amount the money used to pay the invoice
      SET @SWV_Error = 0;
      UPDATE
      ReceiptsHeader
      SET
      CreditAmount = 0
      WHERE
      CompanyID = v_CompanyID AND
      DivisionID = v_DivisionID AND
      DepartmentID = v_DepartmentID AND
      ReceiptID = v_ReceiptID;
      IF @SWV_Error <> 0 then
	
         SET v_ErrorMessage = 'Update ReceiptsHeader failed';
         ROLLBACK;
-- the error handler
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Invoice_Post',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
         SET SWP_Ret_Value = -1;
      end if;	

	-- We created the receipt for invoice amount paid, so we should cash receipt immediatly
      SET v_ConvertedAmount = fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,v_Amount*v_CurrencyExchangeRate, 
      v_CompanyCurrencyID);
      SET @SWV_Error = 0;
      CALL ReceiptCash_CreateGLTransaction2(v_CompanyID,v_DivisionID,v_DepartmentID,v_InvoiceNumber,v_ConvertedAmount, v_ReturnStatus);
      IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then
	-- An error occured, go to the error handler
	
         SET v_ErrorMessage = 'ReceiptCash_CreateGLTransaction call failed';
         ROLLBACK;
-- the error handler
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Invoice_Post',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
         SET SWP_Ret_Value = -1;
      end if;
   end if;

-- Adjust Customer Finacials information
   SET @SWV_Error = 0;
   CALL Invoice_AdjustCustomerFinancials(v_CompanyID,v_DivisionID,v_DepartmentID,v_InvoiceNumber, v_ReturnStatus);
   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then
-- An error occured, go to the error handler

      SET v_ErrorMessage = 'Invoice_AdjustCustomerFinancials call failed';
      ROLLBACK;
-- the error handler
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Invoice_Post',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
      SET SWP_Ret_Value = -1;
   end if;

   IF UPPER(v_TransactionTypeID) <> 'RETURN' then

      SET @SWV_Error = 0;
      CALL CustomerFinancials_ReCalc(v_CompanyID,v_DivisionID,v_DepartmentID,v_CustomerID, v_ReturnStatus);
      IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then
	-- An error occured, go to the error handler
	
         SET v_ErrorMessage = 'CustomerFinancials_Recalc call failed';
         ROLLBACK;
-- the error handler
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Invoice_Post',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
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
   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Invoice_Post',v_ErrorMessage,
   v_ErrorID);

   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);

   SET SWP_Ret_Value = -1;
END;




//

DELIMITER ;

-- Stored procedure definition script Invoice_Recalc2 for MySQL
-- Generated by (c) Ispirer SQLWays 4.0 Build 219 Licensed to STFB
-- Timestamp: Tue Jul 28 16:20:00 2015

DELIMITER //
DROP PROCEDURE IF EXISTS Invoice_Recalc2;
//
CREATE                 PROCEDURE Invoice_Recalc2(v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_InvoiceNumber  NATIONAL VARCHAR(36),INOUT SWP_Ret_Value INT)
   SWL_return:
BEGIN

/*
Name of stored procedure: Invoice_Recalc
Method: 
	Calculates the amounts of money for a specified invoice

Date Created: EDE - 07/28/2015

Input Parameters:

	@CompanyID NVARCHAR(36)		 - the ID of the company
	@DivisionID NVARCHAR(36)	 - the ID of the division
	@DepartmentID NVARCHAR(36)	 - the ID of the department
	@InvoiceNumber NVARCHAR (36)	 - identify the invoice

Output Parameters:

	NONE

Called From:

	Invoice_Post, Invoice_Recalc.vb

Calls:

	TaxGroup_GetTotalPercent, VerifyCurrency, Error_InsertError, Error_InsertErrorDetail

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
   DECLARE v_AmountPaid DECIMAL(19,4);
   DECLARE v_TotalTaxable DECIMAL(19,4);
   DECLARE v_DiscountPers FLOAT;
   DECLARE v_DiscountAmount DECIMAL(19,4);
   DECLARE v_TaxAmount DECIMAL(19,4);
   DECLARE v_ItemTaxAmount DECIMAL(19,4);
   DECLARE v_Freight DECIMAL(19,4);
   DECLARE v_Handling DECIMAL(19,4);
   DECLARE v_TaxFreight BOOLEAN;
   DECLARE v_Posted BOOLEAN;
   DECLARE v_Picked BOOLEAN;

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
   DECLARE v_AllowanceDiscountAmount DECIMAL(19,4);
   DECLARE v_AllowanceDiscountPercent FLOAT;

   DECLARE v_CompanyCurrencyID NATIONAL VARCHAR(36);

   DECLARE SWV_cInvoiceDetailCrs_CompanyID NATIONAL VARCHAR(36);
   DECLARE SWV_cInvoiceDetailCrs_DivisionID NATIONAL VARCHAR(36);
   DECLARE SWV_cInvoiceDetailCrs_DepartmentID NATIONAL VARCHAR(36);
   DECLARE SWV_cInvoiceDetailCrs_InvoiceNumber NATIONAL VARCHAR(36);
   DECLARE SWV_cInvoiceDetailCrs_InvoiceLineNumber NUMERIC(18,0);
   DECLARE v_BalanceDue DECIMAL(19,4);
   DECLARE v_ErrorID INT;
   DECLARE NO_DATA INT DEFAULT 0;
   DECLARE cInvoiceDetailCrs CURSOR 
   FOR SELECT 
   IFNULL(OrderQty,0),
		IFNULL(ItemUnitPrice,0),
		IFNULL(DiscountPerc,0),
		IFNULL(Taxable,0),
		IFNULL(TaxGroupID,N''), CompanyID,DivisionID,DepartmentID,InvoiceNumber,InvoiceLineNumber
   FROM 
   InvoiceDetail
   WHERE	
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND InvoiceNumber = v_InvoiceNumber
   AND IFNULL(Total,0) >= 0;

   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
      SET NO_DATA = -2;
   END;
   DECLARE CONTINUE HANDLER FOR NOT FOUND SET NO_DATA = -1;
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
   select   CurrencyID, CurrencyExchangeRate, InvoiceDate, IFNULL(DiscountPers,0), IFNULL(TaxFreight,0), IFNULL(Freight,0), IFNULL(Handling,0), TaxGroupID, IFNULL(AllowanceDiscountPerc,0), IFNULL(AmountPaid,0) INTO v_CurrencyID,v_CurrencyExchangeRate,v_InvoiceDate,v_DiscountPers,v_TaxFreight,
   v_Freight,v_Handling,v_HeaderTaxGroupID,v_AllowanceDiscountPercent,
   v_AmountPaid FROM
   InvoiceHeader WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   InvoiceNumber = v_InvoiceNumber;

   START TRANSACTION;

   SET @SWV_Error = 0;
   CALL TaxGroup_GetTotalPercent2(v_CompanyID,v_DivisionID,v_DepartmentID,v_HeaderTaxGroupID,v_HeaderTaxPercent);
   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Procedure call TaxGroup_GetTotalPercent failed';
      ROLLBACK;
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Invoice_Recalc',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
      SET SWP_Ret_Value = -1;
   end if;

   SET v_HeaderTaxPercent = IFNULL(v_HeaderTaxPercent,0);

   SET @SWV_Error = 0;
   CALL VerifyCurrency2(v_CompanyID,v_DivisionID,v_DepartmentID,v_InvoiceDate,1,v_CompanyCurrencyID,
   v_CurrencyID,v_CurrencyExchangeRate);
   IF @SWV_Error <> 0 then

	-- the procedure will return an error code
      SET v_ErrorMessage = 'Currency retrieving failed';
      ROLLBACK;
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Invoice_Recalc',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
      SET SWP_Ret_Value = -1;
   end if;

-- get the details Totals
   SET v_Subtotal = 0;
   SET v_ItemSubtotal = 0;
   SET v_SubtotalMinusDetailDiscount = 0;
   SET v_TotalTaxable = 0;
   SET v_DiscountAmount = 0;
   SET v_TaxAmount = 0;
   SET v_Total = 0;

-- open the cursor and get the first row
   OPEN cInvoiceDetailCrs;
   SET NO_DATA = 0;
   FETCH cInvoiceDetailCrs INTO v_ItemOrderQty,v_ItemUnitPrice,v_ItemDiscountPerc,v_ItemTaxable,v_TaxGroupID,
   SWV_cInvoiceDetailCrs_CompanyID,SWV_cInvoiceDetailCrs_DivisionID,
   SWV_cInvoiceDetailCrs_DepartmentID,SWV_cInvoiceDetailCrs_InvoiceNumber,
   SWV_cInvoiceDetailCrs_InvoiceLineNumber;
   WHILE NO_DATA = 0 DO
      SET v_TaxPercent = 0;
      SET v_ItemTaxAmount = 0;
	-- update totals
      SET v_ItemSubtotal = fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,v_ItemOrderQty*v_ItemUnitPrice, 
      v_CompanyCurrencyID);
      SET v_Subtotal = v_Subtotal+v_ItemSubtotal;
      SET v_DiscountAmount = fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,v_DiscountAmount+v_ItemOrderQty*v_ItemUnitPrice*(v_ItemDiscountPerc+v_AllowanceDiscountPercent)/100, 
      v_CompanyCurrencyID);
    	-- recalculate the Total for every line of the Order; the total for a line is = OrderQty * ItemUnitPrice * ( 100 - DiscountPerc )/100
      SET v_ItemTotal = fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,v_ItemOrderQty*v_ItemUnitPrice*(100 -v_ItemDiscountPerc -v_AllowanceDiscountPercent)/100,v_CompanyCurrencyID);
      IF v_TaxGroupID <> N'' then
		
         SET @SWV_Error = 0;
         CALL TaxGroup_GetTotalPercent2(v_CompanyID,v_DivisionID,v_DepartmentID,v_TaxGroupID,v_TaxPercent);
         IF @SWV_Error <> 0 then
			
            SET v_ErrorMessage = 'Procedure call TaxGroup_GetTotalPercent failed';
            ROLLBACK;
            CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Invoice_Recalc',v_ErrorMessage,
            v_ErrorID);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
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
      UPDATE InvoiceDetail
      SET
      Total = v_ItemTotal,SubTotal = v_ItemSubtotal,TaxPercent = v_TaxPercent,
      TaxGroupID = v_TaxGroupID,TaxAmount = v_ItemTaxAmount
      WHERE InvoiceDetail.CompanyID = SWV_cInvoiceDetailCrs_CompanyID AND InvoiceDetail.DivisionID = SWV_cInvoiceDetailCrs_DivisionID AND InvoiceDetail.DepartmentID = SWV_cInvoiceDetailCrs_DepartmentID AND InvoiceDetail.InvoiceNumber = SWV_cInvoiceDetailCrs_InvoiceNumber AND InvoiceDetail.InvoiceLineNumber = SWV_cInvoiceDetailCrs_InvoiceLineNumber;
      IF @SWV_Error <> 0 then
	
         CLOSE cInvoiceDetailCrs;
		
         SET v_ErrorMessage = 'Updating order detail failed';
         ROLLBACK;
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Invoice_Recalc',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
         SET SWP_Ret_Value = -1;
      end if;
      SET NO_DATA = 0;
      FETCH cInvoiceDetailCrs INTO v_ItemOrderQty,v_ItemUnitPrice,v_ItemDiscountPerc,v_ItemTaxable,v_TaxGroupID,
      SWV_cInvoiceDetailCrs_CompanyID,SWV_cInvoiceDetailCrs_DivisionID,
      SWV_cInvoiceDetailCrs_DepartmentID,SWV_cInvoiceDetailCrs_InvoiceNumber,
      SWV_cInvoiceDetailCrs_InvoiceLineNumber;
   END WHILE;
   CLOSE cInvoiceDetailCrs;




   IF v_Handling > 0 then
      SET v_TaxAmount = fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,v_TaxAmount+v_Handling*v_HeaderTaxPercent/100, 
      v_CompanyCurrencyID);
   end if;
   IF v_Freight > 0 AND v_TaxFreight = 1 then
      SET v_TaxAmount = fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,v_TaxAmount+v_Freight*v_HeaderTaxPercent/100, 
      v_CompanyCurrencyID);
   end if;
   SET v_Total = v_Total+v_Handling+v_Freight+v_TaxAmount;

   SET v_BalanceDue = fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,v_Total -v_AmountPaid,v_CompanyCurrencyID);

   SET @SWV_Error = 0;
   UPDATE
   InvoiceHeader
   SET
   Subtotal = v_Subtotal,DiscountAmount = v_DiscountAmount,TaxableSubTotal = v_TotalTaxable,
   TaxPercent = v_HeaderTaxPercent,TaxAmount = v_TaxAmount,
   Total = v_Total,BalanceDue = v_BalanceDue
   WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND InvoiceNumber = v_InvoiceNumber;

   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Recalculating order header totals failed';
      ROLLBACK;
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Invoice_Recalc',v_ErrorMessage,
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

   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Invoice_Recalc',v_ErrorMessage,
   v_ErrorID);

   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);

   SET SWP_Ret_Value = -1;
END;


//

DELIMITER ;

-- Stored procedure definition script TaxGroup_GetTotalPercent2 for MySQL
-- Generated by (c) Ispirer SQLWays 4.0 Build 219 Licensed to STFB
-- Timestamp: Tue Jul 28 16:20:00 2015

DELIMITER //
DROP PROCEDURE IF EXISTS TaxGroup_GetTotalPercent2;
//
CREATE PROCEDURE TaxGroup_GetTotalPercent2(v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_TaxGroupID  NATIONAL VARCHAR(36), 
	INOUT v_TotalPercent  FLOAT)
BEGIN


/*
Name of stored procedure: TaxGroup_GetTotalPercent
Method: 
	Returns total tax percent related with specific tax group

Date Created: EDE - 07/28/2015

Input Parameters:

	@CompanyID NVARCHAR(36)		 - the ID of the company
	@DivisionID NVARCHAR(36)	 - the ID of the division
	@DepartmentID NVARCHAR(36)	 - the ID of the department
	@TaxGroupID NVARCHAR (36)	 - the ID of tax group

Output Parameters:

	@TotalPercent FLOAT 		 - the total tax percent related with specified tax group

Called From:

	Invoice_CreateGLTransaction, RMA_Recalc, Purchase_Recalc, ServiceOrder_Recalc, Invoice_Recalc, Order_Recalc, Contract_Recalc, Return_Recalc, ReturnInvoice_Recalc, Invoice_CreditMemoCreateGLTransaction, ReturnInvoice_CreateGLTransaction, ServiceInvoice_Recalc, ServiceInvoice_CreateGLTransaction, RMAReceiving_CreateGLTransaction, Receiving_CreateGLTransaction

Calls:

	NONE

Last Modified: 

Last Modified By: 

Revision History: 

*/

   set v_TotalPercent = fnTaxGroup_GetTotalPercent2(v_CompanyID,v_DivisionID,v_DepartmentID,v_TaxGroupID);
END;




//

DELIMITER ;


DELIMITER //
DROP FUNCTION IF EXISTS fnTaxGroup_GetTotalPercent2;
//
CREATE FUNCTION fnTaxGroup_GetTotalPercent2(v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_TaxGroupID  NATIONAL VARCHAR(36))
RETURNS FLOAT
BEGIN
-- =============================================
-- Author:		Andrew S. Bukin
-- Create date: <Create Date, ,>
-- Description:	Tax On Tax Calculation
-- =============================================

	-- Declare the return variable here
   DECLARE v_TotalPercent FLOAT;
   DECLARE v_TaxOnTax FLOAT;
   DECLARE v_curTax FLOAT;
   DECLARE v_prevTax FLOAT;
   DECLARE v_curTaxGroupDetail NATIONAL VARCHAR(36);
   DECLARE NO_DATA INT DEFAULT 0;
   DECLARE vend_cursor CURSOR
   FOR select TaxGroupDetail.TaxGroupDetailID
   FROM
   TaxGroups
   INNER JOIN TaxGroupDetail ON
   TaxGroupDetail.CompanyID = TaxGroups.CompanyID AND
   TaxGroupDetail.DivisionID = TaxGroups.DivisionID AND
   TaxGroupDetail.DepartmentID = TaxGroups.DepartmentID AND
   TaxGroupDetail.TaxGroupDetailID = TaxGroups.TaxGroupDetailID
   WHERE
   TaxGroupDetail.CompanyID = v_CompanyID AND
   TaxGroupDetail.DivisionID = v_DivisionID AND
   TaxGroupDetail.DepartmentID = v_DepartmentID AND
   TaxGroups.TaxGroupID = v_TaxGroupID
   group by TaxGroupDetail.TaxGroupDetailID;

   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET NO_DATA = -2;
   END;
   DECLARE CONTINUE HANDLER FOR NOT FOUND SET NO_DATA = -1;
   SET v_TotalPercent = 0;

-- first of all find out if we need to calc TaxOnTax
   set v_TaxOnTax = 0;

   select   sum(case when TaxGroups.TaxOnTax = 1 then 1 else 0 end) INTO v_TaxOnTax FROM
   TaxGroups WHERE
   TaxGroups.CompanyID = v_CompanyID AND
   TaxGroups.DivisionID = v_DivisionID AND
   TaxGroups.DepartmentID = v_DepartmentID AND
   TaxGroups.TaxGroupID = v_TaxGroupID;

-- make cursor for all taxes in group
   set v_curTax = 0;
   set v_prevTax = 0;

-- for each record in cursor @prevTax is totalTax(n), @curTax is tax(n) 
--    and @TotalPercent is sum of all totalTax(i), i=1..n
   OPEN vend_cursor;
   SET NO_DATA = 0;
   FETCH vend_cursor into v_curTaxGroupDetail;
   WHILE NO_DATA = 0 DO
      set v_curTax = fnTaxGroupDetail_GetTotalPercent2(v_CompanyID,v_DivisionID,v_DepartmentID,v_curTaxGroupDetail);
      if (v_TaxOnTax > 0) then
         set v_prevTax =(1+v_prevTax/100)*v_curTax;
      else
         set v_prevTax = v_curTax;
      end if;
      set v_TotalPercent = v_TotalPercent+v_prevTax;
      SET NO_DATA = 0;
      FETCH vend_cursor into v_curTaxGroupDetail;
   END WHILE;

   CLOSE vend_cursor;
	

	-- Return the result of the function
   RETURN ROUND(v_TotalPercent,4);

END;


//

DELIMITER ;

-- Function definition script fnTaxGroupDetail_GetTotalPercent2 for MySQL
-- Generated by (c) Ispirer SQLWays 4.0 Build 219 Licensed to STFB
-- Timestamp: Tue Jul 28 16:20:00 2015

DELIMITER //
DROP FUNCTION IF EXISTS fnTaxGroupDetail_GetTotalPercent2;
//
CREATE FUNCTION fnTaxGroupDetail_GetTotalPercent2(v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_TaxGroupDetailID  NATIONAL VARCHAR(36))
RETURNS FLOAT
BEGIN
-- =============================================
-- Author:		Andrew S. Bukin
-- Create date: <Create Date, ,>
-- Description:	Tax On Tax Calculation
-- =============================================

	-- Declare the return variable here
   DECLARE v_TotalPercent FLOAT;
   DECLARE v_TaxOnTax FLOAT;
   DECLARE NO_DATA INT DEFAULT 0;
   DECLARE v_curTax FLOAT;
   DECLARE v_prevTax FLOAT;
   DECLARE vend_cursor CURSOR
   FOR select Taxes.TaxPercent
   FROM
   TaxGroupDetail
   INNER JOIN Taxes ON
   TaxGroupDetail.CompanyID = Taxes.CompanyID AND
   TaxGroupDetail.DivisionID = Taxes.DivisionID AND
   TaxGroupDetail.DepartmentID = Taxes.DepartmentID AND
   TaxGroupDetail.TaxID = Taxes.TaxID
   WHERE
   TaxGroupDetail.CompanyID = v_CompanyID AND
   TaxGroupDetail.DivisionID = v_DivisionID AND
   TaxGroupDetail.DepartmentID = v_DepartmentID AND
   TaxGroupDetail.TaxGroupDetailID = v_TaxGroupDetailID;

   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET NO_DATA = -2;
   END;
   DECLARE CONTINUE HANDLER FOR NOT FOUND SET NO_DATA = -1;
   SET v_TotalPercent = 0;

-- first of all find out if we need to calc TaxOnTax
   set v_TaxOnTax = 0;

   select   nullif(sum(case when TaxGroupDetail.TaxOnTax = 1 then 1 else 0 end),0) INTO v_TaxOnTax FROM
   TaxGroupDetail WHERE
   TaxGroupDetail.CompanyID = v_CompanyID AND
   TaxGroupDetail.DivisionID = v_DivisionID AND
   TaxGroupDetail.DepartmentID = v_DepartmentID AND
   TaxGroupDetail.TaxGroupDetailID = v_TaxGroupDetailID;

   if (v_TaxOnTax > 0) then
	

-- make cursor for all taxes in group
		
      set v_curTax = 0;
      set v_prevTax = 0;

-- for each record in cursor @prevTax is totalTax(n), @curTax is tax(n) 
--    and @TotalPercent is sum of all totalTax(i), i=1..n
      OPEN vend_cursor;
      SET NO_DATA = 0;
      FETCH vend_cursor into v_curTax;
      WHILE NO_DATA = 0 DO
         set v_prevTax =(1+v_prevTax/100)*v_curTax;
         set v_TotalPercent = v_TotalPercent+v_prevTax;
         SET NO_DATA = 0;
         FETCH vend_cursor into v_curTax;
      END WHILE;
      CLOSE vend_cursor;
		
   else
-- usual tax calculation, i.e. just sum
      select   IFNULL(Sum(IFNULL(Taxes.TaxPercent,0)),0) INTO v_TotalPercent FROM
      TaxGroupDetail
      INNER JOIN Taxes ON
      TaxGroupDetail.CompanyID = Taxes.CompanyID AND
      TaxGroupDetail.DivisionID = Taxes.DivisionID AND
      TaxGroupDetail.DepartmentID = Taxes.DepartmentID AND
      TaxGroupDetail.TaxID = Taxes.TaxID WHERE
      TaxGroupDetail.CompanyID = v_CompanyID AND
      TaxGroupDetail.DivisionID = v_DivisionID AND
      TaxGroupDetail.DepartmentID = v_DepartmentID AND
      TaxGroupDetail.TaxGroupDetailID = v_TaxGroupDetailID;
   end if;

	-- Return the result of the function
   RETURN ROUND(v_TotalPercent,4);

END;


//

DELIMITER ;

-- Stored procedure definition script Invoice_DebitInventory for MySQL
-- Generated by (c) Ispirer SQLWays 4.0 Build 219 Licensed to STFB
-- Timestamp: Tue Jul 28 16:20:00 2015

DELIMITER //
DROP PROCEDURE IF EXISTS Invoice_DebitInventory;
//
CREATE  PROCEDURE Invoice_DebitInventory(v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_InvoiceNumber NATIONAL VARCHAR(36),INOUT SWP_Ret_Value INT)
   SWL_return:
BEGIN

/*
Name of stored procedure: Invoice_DebitInventory
Method:
Date Created: EDE - 07/28/2015
Input Parameters:
	@CompanyID NVARCHAR(36)		 - the ID of the company
	@DivisionID NVARCHAR(36)	 - the ID of the division
	@DepartmentID NVARCHAR(36)	 - the ID of the department
	@InvoiceNumber NVARCHAR(36)	 - the ID of the Invoice
Output Parameters:
	NONE
Called From:
	Invoice_Post
Calls:
Last Modified:
Last Modified By:
Revision History:
*/
   DECLARE v_ReturnStatus INT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(250);
   DECLARE v_FlipBackInvoiceFlag BOOLEAN;
   DECLARE v_InvoiceLineNumber NUMERIC(18,0);
   DECLARE v_ItemID NATIONAL VARCHAR(36);
   DECLARE v_QtyOnHand INT;
   DECLARE v_InvoiceQty FLOAT;
   DECLARE v_AvailableQty INT;
   DECLARE v_DifferenceQty INT;
   DECLARE v_WarehouseID NATIONAL VARCHAR(36);
   DECLARE v_WarehouseBinID NATIONAL VARCHAR(36);
   DECLARE v_SerialNumber NATIONAL VARCHAR(50);
   DECLARE v_Result INT;
   DECLARE v_ErrorID INT;
   DECLARE NO_DATA INT DEFAULT 0;
   DECLARE cInvoiceDetail CURSOR 
   FOR SELECT
   InvoiceLineNumber,
		ItemID,
		IFNULL(OrderQty,0),
		WarehouseID,
		WarehouseBinID,
		SerialNumber
   FROM
   InvoiceDetail
   WHERE	
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND InvoiceNumber = v_InvoiceNumber;
-- open the cursor and get the first row
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
      SET NO_DATA = -2;
   END;
   DECLARE CONTINUE HANDLER FOR NOT FOUND SET NO_DATA = -1;
   SET @SWV_Error = 0;
   START TRANSACTION;
-- debit the inventory
-- set the flag for back Invoices to 0
   SET v_FlipBackInvoiceFlag = 0;
-- declare a cursor to iterate through the Invoice's items
   OPEN cInvoiceDetail;
   SET NO_DATA = 0;
   FETCH cInvoiceDetail INTO v_InvoiceLineNumber,v_ItemID,v_InvoiceQty,v_WarehouseID,v_WarehouseBinID, 
   v_SerialNumber;
   WHILE NO_DATA = 0 DO
      SET v_FlipBackInvoiceFlag = 0;
      SET v_DifferenceQty = 0;
      SET v_QtyOnHand = 0;
      SET v_AvailableQty = 0;
-- get the @WarehouseID for the Invoice
      SET @SWV_Error = 0;
      CALL Inventory_GetWarehouseForInvoiceItem(v_CompanyID,v_DivisionID,v_DepartmentID,v_InvoiceNumber,v_InvoiceLineNumber,
      v_WarehouseID,v_WarehouseBinID, v_ReturnStatus);
      IF @SWV_Error <> 0 OR  v_ReturnStatus = -1 then
	
         CLOSE cInvoiceDetail;
		
         SET v_ErrorMessage = 'Getting the WarehouseID failed';
         ROLLBACK;
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Invoice_DebitInventory',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoceNumber',v_InvoiceNumber);
         SET SWP_Ret_Value = -1;
      end if;
      select   IFNULL(SUM(IFNULL(QtyOnHand,0)),0) INTO v_QtyOnHand FROM
      InventoryByWarehouse WHERE
      CompanyID = v_CompanyID
      AND DivisionID = v_DivisionID
      AND DepartmentID = v_DepartmentID
      AND WarehouseID = v_WarehouseID
      AND ItemID = v_ItemID;
      IF v_InvoiceQty > v_QtyOnHand then -- there is enough quantity in the warehouse
		
         SET v_AvailableQty = v_QtyOnHand;
         SET v_DifferenceQty = v_InvoiceQty -v_QtyOnHand;
		
			-- verify if the item is an assembly and if the assembly can be created
			-- from items existing in the warehouses
         SET @SWV_Error = 0;
         SET v_ReturnStatus = Invoice_CreateAssembly2(v_CompanyID,v_DivisionID,v_DepartmentID,v_ItemID,v_WarehouseID,v_DifferenceQty,
         v_Result);
			-- check for errors
         IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then
			
            CLOSE cInvoiceDetail;
				
            -- NOT SUPPORTED Print CONCAT('ItemID: ',convert(CHAR(20),@ItemID),' InvoiceQty: ', convert(CHAR(20),@InvoiceQty))
SET v_ErrorMessage = 'Invoice_CreateAssembly call failed';
            ROLLBACK;
            CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Invoice_DebitInventory',v_ErrorMessage,
            v_ErrorID);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoceNumber',v_InvoiceNumber);
            SET SWP_Ret_Value = -1;
         end if;
      end if;
      SET NO_DATA = 0;
      FETCH cInvoiceDetail INTO v_InvoiceLineNumber,v_ItemID,v_InvoiceQty,v_WarehouseID,v_WarehouseBinID, 
      v_SerialNumber;
   END WHILE;
   CLOSE cInvoiceDetail;
   SET @SWV_Error = 0;
   CALL  InvoiceDetail_SplitToWarehouseBin2(v_CompanyID,v_DivisionID,v_DepartmentID,v_InvoiceNumber,0,v_FlipBackInvoiceFlag, v_ReturnStatus);
   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then

      SET v_ErrorMessage = 'InvoiceDetail_SplitToWarehouseBin failed';
      ROLLBACK;
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Invoice_DebitInventory',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoceNumber',v_InvoiceNumber);
      SET SWP_Ret_Value = -1;
   end if;
   IF v_FlipBackInvoiceFlag = 1 then

	
      SET v_ErrorMessage = 'The Invoice did not post: there is not enough staff in Inventory to cover the invoice';
      ROLLBACK;
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Invoice_DebitInventory',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoceNumber',v_InvoiceNumber);
      SET SWP_Ret_Value = -1;
   end if;
-- open the cursor and get the first row
   OPEN cInvoiceDetail;
   SET NO_DATA = 0;
   FETCH cInvoiceDetail INTO v_InvoiceLineNumber,v_ItemID,v_InvoiceQty,v_WarehouseID,v_WarehouseBinID, 
   v_SerialNumber;
   WHILE NO_DATA = 0 DO
      SET @SWV_Error = 0;
      CALL SerialNumber_Get2(v_CompanyID,v_DivisionID,v_DepartmentID,v_WarehouseID,v_WarehouseBinID,
      v_SerialNumber,v_ItemID,NULL,NULL,v_InvoiceNumber,v_InvoiceLineNumber,
      v_InvoiceQty, v_ReturnStatus);
      IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then
	
         CLOSE cInvoiceDetail;
		
         SET v_ErrorMessage = 'SerialNumber_Get failed';
         ROLLBACK;
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Invoice_DebitInventory',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoceNumber',v_InvoiceNumber);
         SET SWP_Ret_Value = -1;
      end if;
      SET NO_DATA = 0;
      FETCH cInvoiceDetail INTO v_InvoiceLineNumber,v_ItemID,v_InvoiceQty,v_WarehouseID,v_WarehouseBinID, 
      v_SerialNumber;
   END WHILE;
   CLOSE cInvoiceDetail;

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
   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Invoice_DebitInventory',v_ErrorMessage,
   v_ErrorID);
   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoceNumber',v_InvoiceNumber);
   SET SWP_Ret_Value = -1;
END;




//

DELIMITER ;

-- Stored procedure definition script Invoice_AdjustInventory for MySQL
-- Generated by (c) Ispirer SQLWays 4.0 Build 219 Licensed to STFB
-- Timestamp: Tue Jul 28 16:20:00 2015

DELIMITER //
DROP PROCEDURE IF EXISTS Invoice_AdjustInventory;
//
CREATE    PROCEDURE Invoice_AdjustInventory(v_CompanyID NATIONAL VARCHAR(36), 
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_InvoiceNumber NATIONAL VARCHAR(36),INOUT SWP_Ret_Value INT)
   SWL_return:
BEGIN













/*
Name of stored procedure: Invoice_AdjustInventory
Method: 
	this procedure adjusts the inventory to show that the goods are gone and paid for.
	We already moved the inventory from the On Hand Column to the Committed Column 
	when the order was processed, now we are going to debit the inventory from 
	the Committed field.

Date Created: EDE - 07/28/2015

Input Parameters:

	@CompanyID NVARCHAR(36)		 - the ID of the company
	@DivisionID NVARCHAR(36)	 - the ID of the division
	@DepartmentID NVARCHAR(36)	 - the ID of the department
	@InvoiceNumber NVARCHAR(36)	 - the ID of the Invoice

Output Parameters:

	NONE

Called From:

	Invoice_Post

Calls:

	Inventory_GetWarehouseForOrder, WarehouseBinShipGoods, Error_InsertError, Error_InsertErrorDetail

Last Modified: 

Last Modified By: 

Revision History: 

*/

   DECLARE v_OrderNumber NATIONAL VARCHAR(36);
   DECLARE v_WarehouseID NATIONAL VARCHAR(36);
   DECLARE v_WarehouseBinID NATIONAL VARCHAR(36);
   DECLARE v_ReturnStatus INT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(250);
   DECLARE v_InvoiceLineNumber INT; 
   DECLARE v_ItemID NATIONAL VARCHAR(36);
   DECLARE v_OrderQty INT;
   DECLARE v_BackOrderQty INT;

   DECLARE v_ErrorID INT;
   DECLARE NO_DATA INT DEFAULT 0;
   DECLARE cInvoiceDetail CURSOR 
   FOR SELECT 
   WarehouseID, WarehouseBinID,
		InvoiceLineNumber, ItemID, IFNULL(OrderQty,0), IFNULL(BackOrderQty,0)
   FROM 
   InvoiceDetail
   WHERE	
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND InvoiceNumber = v_InvoiceNumber;

-- open the cursor and get the first row
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
      SET NO_DATA = -2;
   END;
   DECLARE CONTINUE HANDLER FOR NOT FOUND SET NO_DATA = -1;
   SET @SWV_Error = 0;
   START TRANSACTION;

   select   OrderNumber INTO v_OrderNumber FROM InvoiceHeader WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND InvoiceNumber = v_InvoiceNumber;


-- get the @WarehouseID for the invoice order
   SET v_ReturnStatus = Inventory_GetWarehouseForOrder2(v_CompanyID,v_DivisionID,v_DepartmentID,v_OrderNumber,v_WarehouseID); 
   IF v_ReturnStatus = -1 then

      SET v_ErrorMessage = 'Getting the WarehouseID failed';
      ROLLBACK;
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'InvoiceAdjustInventory',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoceNumber',v_InvoiceNumber);
      SET SWP_Ret_Value = -1;
   end if;

   OPEN cInvoiceDetail;
   SET NO_DATA = 0;
   FETCH cInvoiceDetail INTO v_WarehouseID,v_WarehouseBinID,v_InvoiceLineNumber,v_ItemID,v_OrderQty, 
   v_BackOrderQty;
   WHILE NO_DATA = 0 DO
      SET @SWV_Error = 0;
      CALL WarehouseBinShipGoods2(v_CompanyID,v_DivisionID,v_DepartmentID,v_WarehouseID,v_WarehouseBinID,
      v_ItemID,v_OrderQty,v_BackOrderQty,1, v_ReturnStatus);
      IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then
	
         CLOSE cInvoiceDetail;
		
         SET v_ErrorMessage = 'WarehouseBinShipGoods failed';
         ROLLBACK;
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'InvoiceAdjustInventory',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoceNumber',v_InvoiceNumber);
         SET SWP_Ret_Value = -1;
      end if;
      SET NO_DATA = 0;
      FETCH cInvoiceDetail INTO v_WarehouseID,v_WarehouseBinID,v_InvoiceLineNumber,v_ItemID,v_OrderQty, 
      v_BackOrderQty;
   END WHILE;
   CLOSE cInvoiceDetail;


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
   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'InvoiceAdjustInventory',v_ErrorMessage,
   v_ErrorID);

   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoceNumber',v_InvoiceNumber);

   SET SWP_Ret_Value = -1;
END;











//

DELIMITER ;

-- Stored procedure definition script Inventory_CreateILTransaction2 for MySQL
-- Generated by (c) Ispirer SQLWays 4.0 Build 219 Licensed to STFB
-- Timestamp: Tue Jul 28 16:20:00 2015

DELIMITER //
DROP PROCEDURE IF EXISTS Inventory_CreateILTransaction2;
//
CREATE        PROCEDURE Inventory_CreateILTransaction2(v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_TransDate DATETIME,
	v_ItemID NATIONAL VARCHAR(36),
	v_TransactionType NATIONAL VARCHAR(36),
	v_TransactionNumber NATIONAL VARCHAR(36),
	v_TransactionLineNumber DECIMAL,
	v_Quantity BIGINT,
	v_CostPerUnit DECIMAL(19,4),INOUT SWP_Ret_Value INT)
   SWL_return:
BEGIN




/*
Name of stored procedure: Inventory_CreateILTransaction
Method: 
	Fixes any physical inventory adjustment in the InventoryLedgerTable,
	recalculates inventory costing and updates all item cost for all opened orders

Date Created: EDE - 07/28/2015

Input Parameters:

	@CompanyID NVARCHAR(36)		 - the ID of the company
	@DivisionID NVARCHAR(36)	 - the ID of the division
	@DepartmentID NVARCHAR(36)	 - the ID of the department
	@TransDate DATETIME		 - the date of the transaction
	@ItemID NVARCHAR(36)		 - the Id of inventory item
	@TransactionType NVARCHAR(36)	 - the transaction type (i.e. Receiving, Invoice and so on)
	@TransactionNumber NVARCHAR(36)	 - the ID of transaction that cause inventory adjustment
	@TransactionLineNumber DECIMAL	 - the ID of detail transaction item related with specifed ItemID
	@Quantity BIGINT		 - the quantity of adjusted inventory items (can be negative or positive)
	@CostPerUnit MONEY		 - the cost of inventory item unit

Output Parameters:

	NONE

Called From:

	InventoryAdjustments_Post, Invoice_Post, Receiving_UpdateInventoryCosting, ReturnInvoice_Post

Calls:

	Inventory_RecalcItemCost, Error_InsertError, Error_InsertErrorDetail

Last Modified: 

Last Modified By: 

Revision History: 

*/

   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);

   DECLARE v_DefaultInventoryCostingMethod CHAR(1);
   DECLARE v_NewCostPerUnit DECIMAL(19,4);

   DECLARE v_CompanyCurrencyID NATIONAL VARCHAR(3);
   DECLARE NO_DATA INT DEFAULT 0;
   DECLARE v_ErrorID INT;
   DECLARE v_PrevQuantity BIGINT;
   DECLARE v_CurQuantity BIGINT;
   DECLARE v_CalcQuantity BIGINT;
   DECLARE v_InsQuantity BIGINT;
   DECLARE v_CurCostPerUnit DECIMAL(19,4);
   DECLARE SWV_CurNum INT DEFAULT 0;
   DECLARE cInventoryLedger CURSOR FOR
   SELECT Quantity, CostPerUnit FROM InventoryLedger
   WHERE 
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   ItemID = v_ItemID AND
   Quantity > 0
   ORDER BY  
   TransDate ASC;
   DECLARE cInventoryLedger2 CURSOR  FOR SELECT Quantity, CostPerUnit FROM InventoryLedger
   WHERE 
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   ItemID = v_ItemID AND
   Quantity > 0
   ORDER BY  
   TransDate DESC;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
      SET NO_DATA = -2;
   END;
   DECLARE CONTINUE HANDLER FOR NOT FOUND SET NO_DATA = -1;
   SET @SWV_Error = 0;
   IF IFNULL(v_Quantity,0) = 0 OR IFNULL(v_CostPerUnit,0) = 0 then

      SET SWP_Ret_Value = 1;
      LEAVE SWL_return;
   end if;
   IF(IFNULL(v_ItemID,N'') = N'' OR IFNULL(v_TransactionType,N'') = N'' OR IFNULL(v_TransactionNumber,N'') = N'') then

      SET v_ErrorMessage = 'Invalid input parameters for Inventory_CreateILTransaction';
      ROLLBACK;
-- the error handler

      IF v_ErrorMessage <> '' then

	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Inventory_CreateILTransaction',
         v_ErrorMessage,v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'ItemID',v_ItemID);
      end if;
      SET SWP_Ret_Value = -1;
   end if;


   select   IFNULL(CurrencyID,N'') INTO v_CompanyCurrencyID FROM Companies WHERE CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID   LIMIT 1;


-- get @DefaultInventoryCostingMethod 
   select   IFNULL(DefaultInventoryCostingMethod,'F') INTO v_DefaultInventoryCostingMethod FROM
   Companies WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID;


   START TRANSACTION;

   SET v_TransDate = IFNULL(v_TransDate,CURRENT_TIMESTAMP);

   IF v_Quantity > 0 then

      SET @SWV_Error = 0;
      INSERT INTO InventoryLedger(CompanyID,
		DivisionID,
		DepartmentID,
		TransDate,
		ItemID,
		TransactionType,
		TransNumber,
		ILLineNumber,
		Quantity,
		CostPerUnit,
		TotalCost)
	VALUES(v_CompanyID,
		v_DivisionID,
		v_DepartmentID,
		v_TransDate,
		v_ItemID,
		v_TransactionType,
		v_TransactionNumber,
		v_TransactionLineNumber,
		v_Quantity,
		v_CostPerUnit,
		fnRound(v_CompanyID, v_DivisionID, v_DepartmentID, Abs(v_Quantity)*v_CostPerUnit, v_CompanyCurrencyID));
	
      IF @SWV_Error <> 0 then
	-- An error occured, go to the error handler
	
         SET v_ErrorMessage = 'Insert in InventoryTransaction failed';
         ROLLBACK;
-- the error handler

         IF v_ErrorMessage <> '' then

	
            CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Inventory_CreateILTransaction',
            v_ErrorMessage,v_ErrorID);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'ItemID',v_ItemID);
         end if;
         SET SWP_Ret_Value = -1;
      end if;

	-- Recalculate inventory costing
      SET @SWV_Error = 0;
      CALL Inventory_RecalcItemCost2(v_CompanyID,v_DivisionID,v_DepartmentID,v_ItemID,v_Quantity,v_CostPerUnit,
      v_NewCostPerUnit, v_ReturnStatus);
      IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then
	-- An error occured, go to the error handler
	
         SET v_ErrorMessage = 'Inventory_RecalcItemCost call failed';
         ROLLBACK;
-- the error handler

         IF v_ErrorMessage <> '' then

	
            CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Inventory_CreateILTransaction',
            v_ErrorMessage,v_ErrorID);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'ItemID',v_ItemID);
         end if;
         SET SWP_Ret_Value = -1;
      end if;
   end if;


   IF v_Quantity < 0 then

	
      select   SUM(-Quantity) INTO v_PrevQuantity FROM
      InventoryLedger WHERE
      CompanyID = v_CompanyID AND
      DivisionID = v_DivisionID AND
      DepartmentID = v_DepartmentID AND
      ItemID = v_ItemID AND
      Quantity < 0;
      SET v_PrevQuantity = IFNULL(v_PrevQuantity,0);
      SET v_CalcQuantity = -v_Quantity;
      IF v_DefaultInventoryCostingMethod = 'F' OR v_DefaultInventoryCostingMethod = 'L' then
		
         IF v_DefaultInventoryCostingMethod = 'F' then
				
					
            SET SWV_CurNum = 0;
         ELSE 
            IF v_DefaultInventoryCostingMethod = 'L' then
				
					
               SET SWV_CurNum = 1;
            end if;
         end if;
         IF SWV_CurNum = 0 THEN
            OPEN cInventoryLedger;
         ELSE
            OPEN cInventoryLedger2;
         END IF;
         SET NO_DATA = 0;
         IF SWV_CurNum = 0 THEN
            FETCH cInventoryLedger INTO v_CurQuantity,v_CurCostPerUnit;
         ELSE
            FETCH cInventoryLedger2 INTO v_CurQuantity,v_CurCostPerUnit;
         END IF;
         WHILE NO_DATA = 0 DO
            IF v_CalcQuantity > 0 then
				
               SET v_PrevQuantity = v_PrevQuantity -v_CurQuantity;
               IF v_PrevQuantity < 0 then
					
                  SET v_PrevQuantity = -v_PrevQuantity;
                  IF v_PrevQuantity >= v_CalcQuantity then
						
                     SET v_InsQuantity = v_CalcQuantity;
                     SET v_CalcQuantity = 0;
                  ELSE
                     SET v_InsQuantity = v_PrevQuantity;
                     SET v_CalcQuantity = v_CalcQuantity -v_PrevQuantity;
                  end if;
                  SET v_PrevQuantity = 0;
                  SET v_TransDate = TIMESTAMPADD(SECOND,1,v_TransDate);
                  SET @SWV_Error = 0;
                  INSERT INTO InventoryLedger(CompanyID,
							DivisionID,
							DepartmentID,
							TransDate,
							ItemID,
							TransactionType,
							TransNumber,
							ILLineNumber,
							Quantity,
							CostPerUnit,
							TotalCost)
						VALUES(v_CompanyID,
							v_DivisionID,
							v_DepartmentID,
							v_TransDate,
							v_ItemID,
							v_TransactionType,
							v_TransactionNumber,
							v_TransactionLineNumber,
							-v_InsQuantity,
							v_CurCostPerUnit,
							fnRound(v_CompanyID, v_DivisionID, v_DepartmentID, Abs(v_InsQuantity)*v_CurCostPerUnit, v_CompanyCurrencyID));
						
                  IF @SWV_Error <> 0 then
						-- An error occured, go to the error handler
						
                     IF SWV_CurNum = 0 THEN
                        CLOSE cInventoryLedger;
                     ELSE
                        CLOSE cInventoryLedger2;
                     END IF;
							
                     SET v_ErrorMessage = 'Insert in InventoryTransaction failed';
                     ROLLBACK;
-- the error handler

                     IF v_ErrorMessage <> '' then

	
                        CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Inventory_CreateILTransaction',
                        v_ErrorMessage,v_ErrorID);
                        CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'ItemID',v_ItemID);
                     end if;
                     SET SWP_Ret_Value = -1;
                  end if;
               end if;
            end if;
            SET NO_DATA = 0;
            IF SWV_CurNum = 0 THEN
               FETCH cInventoryLedger INTO v_CurQuantity,v_CurCostPerUnit;
            ELSE
               FETCH cInventoryLedger2 INTO v_CurQuantity,v_CurCostPerUnit;
            END IF;
         END WHILE;
         IF SWV_CurNum = 0 THEN
            CLOSE cInventoryLedger;
         ELSE
            CLOSE cInventoryLedger2;
         END IF;
			

			-- Recalculate inventory costing
         SET @SWV_Error = 0;
         CALL Inventory_RecalcItemCost2(v_CompanyID,v_DivisionID,v_DepartmentID,v_ItemID,v_Quantity,v_CostPerUnit,
         v_NewCostPerUnit, v_ReturnStatus);
         IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then
			-- An error occured, go to the error handler
			
            SET v_ErrorMessage = 'Inventory_RecalcItemCost call failed';
            ROLLBACK;
-- the error handler

            IF v_ErrorMessage <> '' then

	
               CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Inventory_CreateILTransaction',
               v_ErrorMessage,v_ErrorID);
               CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'ItemID',v_ItemID);
            end if;
            SET SWP_Ret_Value = -1;
         end if;
		-- @DefaultInventoryCostingMethod = 'A'
      ELSE
         SET @SWV_Error = 0;
         INSERT INTO InventoryLedger(CompanyID,
					DivisionID,
					DepartmentID,
					TransDate,
					ItemID,
					TransactionType,
					TransNumber,
					ILLineNumber,
					Quantity,
					CostPerUnit,
					TotalCost)
				VALUES(v_CompanyID,
					v_DivisionID,
					v_DepartmentID,
					v_TransDate,
					v_ItemID,
					v_TransactionType,
					v_TransactionNumber,
					v_TransactionLineNumber,
					v_Quantity,
					v_CostPerUnit,
					fnRound(v_CompanyID, v_DivisionID, v_DepartmentID, Abs(v_Quantity)*v_CostPerUnit, v_CompanyCurrencyID));
				
         IF @SWV_Error <> 0 then
				-- An error occured, go to the error handler
				
            SET v_ErrorMessage = 'Insert in InventoryTransaction failed';
            ROLLBACK;
-- the error handler

            IF v_ErrorMessage <> '' then

	
               CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Inventory_CreateILTransaction',
               v_ErrorMessage,v_ErrorID);
               CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'ItemID',v_ItemID);
            end if;
            SET SWP_Ret_Value = -1;
         end if;
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

   IF v_ErrorMessage <> '' then

	
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Inventory_CreateILTransaction',
      v_ErrorMessage,v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'ItemID',v_ItemID);
   end if;
   SET SWP_Ret_Value = -1;
END;









//

DELIMITER ;

-- Stored procedure definition script Inventory_RecalcItemCost2 for MySQL
-- Generated by (c) Ispirer SQLWays 4.0 Build 219 Licensed to STFB
-- Timestamp: Tue Jul 28 16:20:00 2015

DELIMITER //
DROP PROCEDURE IF EXISTS Inventory_RecalcItemCost2;
//
CREATE      PROCEDURE Inventory_RecalcItemCost2(v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_ItemID NATIONAL VARCHAR(36),
	v_IncomeQuantity BIGINT,
	v_IncomeCostPerUnit DECIMAL(19,4),
	INOUT v_ItemCost DECIMAL(19,4) ,INOUT SWP_Ret_Value INT)
   SWL_return:
BEGIN







/*
Name of stored procedure: Inventory_RecalcItemCost
Method: 
	Recalculates different types of cost and updates cost of all opened orders

Date Created: EDE - 07/28/2015

Input Parameters:

	@CompanyID NVARCHAR(36)		 - the ID of the company
	@DivisionID NVARCHAR(36)	 - the ID of the division
	@DepartmentID NVARCHAR(36)	 - the ID of the department
	@ItemID NVARCHAR(36)		 - the ID of inventory item

Output Parameters:

	@ItemCost MONEY 		 - returns the item cost that corresponds default company costing method

Called From:

	Inventory_CreateILTransaction

Calls:

	Inventory_RecalcFIFOCost, Inventory_RecalcLIFOCost, Inventory_RecalcAverageCost, Error_InsertError, Error_InsertErrorDetail

Last Modified: 

Last Modified By: 

Revision History: 

*/

   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);
   DECLARE v_RunningQuantitySold FLOAT;


   DECLARE v_DefaultInventoryCostingMethod NATIONAL VARCHAR(1);
   DECLARE v_ErrorID INT;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
   END;
   SET @SWV_Error = 0;
   START TRANSACTION;
-- Get total Qty of all sold items
   select   IFNULL(-SUM(IFNULL(Quantity,0)),0) INTO v_RunningQuantitySold FROM InventoryLedger WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   ItemID = v_ItemID AND
   Quantity < 0;


-- Recalculate FIFO costing
   SET @SWV_Error = 0;
   CALL Inventory_RecalcFIFOCost(v_CompanyID,v_DivisionID,v_DepartmentID,v_ItemID,v_RunningQuantitySold, v_ReturnStatus);
   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then
-- An error occured, go to the error handler

      SET v_ErrorMessage = 'Inventory_RecalcFIFOCost call failed';
      ROLLBACK;
-- the error handler

      IF v_ErrorMessage <> '' then

	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Inventory_RecalcItemCost',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'ItemID',v_ItemID);
      end if;
      SET SWP_Ret_Value = -1;
   end if;

-- Recalculate LIFO costing
   SET @SWV_Error = 0;
   CALL Inventory_RecalcLIFOCost2(v_CompanyID,v_DivisionID,v_DepartmentID,v_ItemID,v_RunningQuantitySold, v_ReturnStatus);
   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then
-- An error occured, go to the error handler

      SET v_ErrorMessage = 'Inventory_RecalcLIFOCost call failed';
      ROLLBACK;
-- the error handler

      IF v_ErrorMessage <> '' then

	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Inventory_RecalcItemCost',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'ItemID',v_ItemID);
      end if;
      SET SWP_Ret_Value = -1;
   end if;


-- Recalculate Average costing
   SET @SWV_Error = 0;
   CALL Inventory_RecalcAverageCost(v_CompanyID,v_DivisionID,v_DepartmentID,v_ItemID,v_IncomeQuantity,v_IncomeCostPerUnit, v_ReturnStatus);

   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then
-- An error occured, go to the error handler

      SET v_ErrorMessage = 'Inventory_RecalcAverageCost call failed';
      ROLLBACK;
-- the error handler

      IF v_ErrorMessage <> '' then

	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Inventory_RecalcItemCost',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'ItemID',v_ItemID);
      end if;
      SET SWP_Ret_Value = -1;
   end if;

-- return default itme cost  that possibly was changed during recalculation
   select   IFNULL(DefaultInventoryCostingMethod,'F') INTO v_DefaultInventoryCostingMethod FROM
   Companies WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID;

   select(CASE(v_DefaultInventoryCostingMethod)
   WHEN 'F' THEN FIFOCost
   WHEN 'L' THEN LIFOCost
   WHEN 'A' THEN AverageCost
   END) INTO v_ItemCost FROM
   InventoryItems WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   ItemID = v_ItemID;



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

   IF v_ErrorMessage <> '' then

	
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Inventory_RecalcItemCost',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'ItemID',v_ItemID);
   end if;
   SET SWP_Ret_Value = -1;
END;






//

DELIMITER ;

-- Stored procedure definition script Inventory_RecalcFIFOCost for MySQL
-- Generated by (c) Ispirer SQLWays 4.0 Build 219 Licensed to STFB
-- Timestamp: Tue Jul 28 16:20:00 2015

DELIMITER //
DROP FUNCTION IF EXISTS Inventory_RecalcFIFOCost2;
//
CREATE       FUNCTION Inventory_RecalcFIFOCost2(v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_ItemID NATIONAL VARCHAR(36),
	v_RunningQuantitySold BIGINT)
RETURNS FLOAT
BEGIN
	DECLARE SWP_Ret_Value INT;
	CALL Inventory_RecalcFIFOCost(v_CompanyID, v_DivisionID, v_DepartmentID, v_ItemID, v_RunningQuantitySold, SWP_Ret_Value);
	RETURN SWP_Ret_Value;

END;










//

DELIMITER ;

-- Stored procedure definition script Inventory_RecalcFIFOCost for MySQL
-- Generated by (c) Ispirer SQLWays 4.0 Build 219 Licensed to STFB
-- Timestamp: Tue Jul 28 16:20:00 2015

DELIMITER //
DROP PROCEDURE IF EXISTS Inventory_RecalcFIFOCost;
//
CREATE       PROCEDURE Inventory_RecalcFIFOCost(v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_ItemID NATIONAL VARCHAR(36),
	v_RunningQuantitySold BIGINT,INOUT SWP_Ret_Value INT)
   SWL_return:
BEGIN







/*
Name of stored procedure: Inventory_RecalcFIFOCost
Method: 
	Recalculates FIFO cost and updates cost of all opened orders

Date Created: EDE - 07/28/2015

Input Parameters:

	@CompanyID NVARCHAR(36)		 - the ID of the company
	@DivisionID NVARCHAR(36)	 - the ID of the division
	@DepartmentID NVARCHAR(36)	 - the ID of the department
	@ItemID NVARCHAR(36)		 - the inventory item ID
	@RunningQuantitySold BIGINT	 - total Qty of all sold items

Output Parameters:

	NONE

Called From:

	Inventory_RecalcItemCost

Calls:

	Order_UpdateCosting, Error_InsertError, Error_InsertErrorDetail

Last Modified: 

Last Modified By: 

Revision History: 

*/

   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);

   DECLARE v_Quantity BIGINT;
   DECLARE v_CostPerUnit DECIMAL(19,4);
   DECLARE v_OldFIFOCost DECIMAL(19,4);

-- Store the old FIFO cost 
   DECLARE NO_DATA INT DEFAULT 0;
   DECLARE v_DefaultInventoryCostingMethod NATIONAL VARCHAR(1);
   DECLARE v_ErrorID INT;
   DECLARE cQty CURSOR FOR
   SELECT 
   IFNULL(Quantity,0), IFNULL(CostPerUnit,0)
   FROM 
   InventoryLedger
   WHERE 
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   ItemID = v_ItemID AND
   IFNULL(Quantity,0) > 0
   ORDER BY TransDate;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
      SET NO_DATA = -2;
   END;
   DECLARE CONTINUE HANDLER FOR NOT FOUND SET NO_DATA = -1;
   select   IFNULL(FIFOCost,0) INTO v_OldFIFOCost FROM
   InventoryItems WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   ItemID = v_ItemID;
-- if there is no such Item in the Inventory table, do nothing
   IF ROW_COUNT() = 0 then

      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;
   end if;


   START TRANSACTION;

   OPEN cQty;

   SET NO_DATA = 0;
   FETCH cQty INTO v_Quantity,v_CostPerUnit;
-- Scan all InventoryLedger items with positive Quantities 
-- from the start of the table
-- to find income item transaction from which the last sold was made
   WHILE NO_DATA = 0 AND v_RunningQuantitySold >= 0 DO
      SET v_RunningQuantitySold = v_RunningQuantitySold -v_Quantity;
      IF v_RunningQuantitySold >= 0 then
	
         SET NO_DATA = 0;
         FETCH cQty INTO v_Quantity,v_CostPerUnit;
      end if;
   END WHILE;


   CLOSE cQty;

-- Now we have the new item cost stored in @CostPerUnit variable
-- If it was changed, we will update FIFO cost in InventoryItems table 
-- and the item cost in all opened orders
   IF v_OldFIFOCost <> v_CostPerUnit AND v_CostPerUnit <> 0 then

      UPDATE
      InventoryItems
      SET
      FIFOCost = v_CostPerUnit
      WHERE
      CompanyID = v_CompanyID AND
      DivisionID = v_DivisionID AND
      DepartmentID = v_DepartmentID AND
      ItemID = v_ItemID;
      select   IFNULL(DefaultInventoryCostingMethod,'F') INTO v_DefaultInventoryCostingMethod FROM
      Companies WHERE
      CompanyID = v_CompanyID AND
      DivisionID = v_DivisionID AND
      DepartmentID = v_DepartmentID;
	-- If Company DefaultInventoryCostingMethod is FIFO
	-- update item cost in all opened orders
      IF v_DefaultInventoryCostingMethod = 'F' then
	
		-- Recalculate FIFO costing
         SET @SWV_Error = 0;
         SET v_ReturnStatus = Order_UpdateCosting(v_CompanyID,v_DivisionID,v_DepartmentID,v_ItemID,v_CostPerUnit);
         IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then
		-- An error occured, go to the error handler
		
            SET v_ErrorMessage = 'Order_UpdateCosting call failed';
            ROLLBACK;
-- the error handler

            IF v_ErrorMessage <> '' then

	
               CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Inventory_RecalcFIFOCost',v_ErrorMessage,
               v_ErrorID);
               CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'ItemID',v_ItemID);
            end if;
            SET SWP_Ret_Value = -1;
         end if;
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

   IF v_ErrorMessage <> '' then

	
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Inventory_RecalcFIFOCost',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'ItemID',v_ItemID);
   end if;
   SET SWP_Ret_Value = -1;
END;










//

DELIMITER ;
