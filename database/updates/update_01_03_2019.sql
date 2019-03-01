DELIMITER //
DROP PROCEDURE IF EXISTS Receipt_Cash;
//
CREATE PROCEDURE Receipt_Cash(v_CompanyID NATIONAL VARCHAR(36), 
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_InvoiceNumber NATIONAL VARCHAR(36),
	v_ReceiptID NATIONAL VARCHAR(36),
	v_ReceiptType NATIONAL VARCHAR(36),
	v_Amount DECIMAL(19,4),
	v_ForceReceiptClosing BOOLEAN,
	INOUT v_Result SMALLINT ,INOUT SWP_Ret_Value INT)
   SWL_return:
BEGIN

/*
Name of stored procedure: Receipt_Cash
Method: 
	takes all the necessary actions to cash a receipt

Date Created: EDE - 07/28/2015

Input Parameters:

	@CompanyID NVARCHAR(36)		 - the ID of the company
	@DivisionID NVARCHAR(36)	 - the ID of the division
	@DepartmentID NVARCHAR(36)	 - the ID of the department
	@InvoiceNumber NVARCHAR(36)	 - the the number of the cashed invoice
	@ReceiptID NVARCHAR(36)		 - the ID of the cash
	@ReceiptType NVARCHAR(36)	 - the cash type ('Receipt' or 'Credit Memo')
	@Amount MONEY			 - the cash amount

Output Parameters:

	@Result SMALLINT 		 - return value

						   1 - the cash is applied to the invoice

						   0 - the cash was not applied to the invoice

Called From:

	Receipt_Cash_Auto, Receipt_Cash.vb

Calls:

	GetNextEntityID, CreditMemo_Post, ReceiptCash_CreateGLTransaction, CustomerFinancials_Recalc, Error_InsertError, Error_InsertErrorDetail

Last Modified: 7/25/2008

Last Modified By: 

Revision History: 

*/

   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);

   DECLARE v_InvoicePost BOOLEAN;
   DECLARE v_InvoiceTotal DECIMAL(19,4);
   DECLARE v_InvoiceAmountPaid DECIMAL(19,4);
   DECLARE v_InvoiceBalance DECIMAL(19,4);
   DECLARE v_InvoiceCurrencyID NATIONAL VARCHAR(3);

   DECLARE v_ReceiptPost BOOLEAN;
   DECLARE v_ReceiptCreditAmount DECIMAL(19,4);
   DECLARE v_ReceiptAmount DECIMAL(19,4);
   DECLARE v_ReceiptCurrencyID NATIONAL VARCHAR(3);
   DECLARE v_ReceiptCheckNumber NATIONAL VARCHAR(20);
   DECLARE v_ReceiptCheckDate DATETIME;
   DECLARE v_BankTransNumber NATIONAL VARCHAR(36);
   DECLARE v_CreditMemoNumber NATIONAL VARCHAR(36);
   DECLARE v_CurrencyExchangeRate FLOAT;

   DECLARE v_CurrencyExchangeRateInvoice FLOAT;
   DECLARE v_CompanyCurrencyID NATIONAL VARCHAR(3);

   DECLARE v_PayInvoice DECIMAL(19,4);
   DECLARE v_PayInvoiceCurrInvoice DECIMAL(19,4);
   DECLARE v_Rest DECIMAL(19,4);

-- customer info
   DECLARE v_CustomerID NATIONAL VARCHAR(50);
   DECLARE v_TermsID NATIONAL VARCHAR(36);
   DECLARE v_CustomerShipToID NATIONAL VARCHAR(36);
   DECLARE v_CustomerShipForID NATIONAL VARCHAR(36);
   DECLARE v_CurrencyID NATIONAL VARCHAR(3);
   DECLARE v_TaxGroupID NATIONAL VARCHAR(36);
   DECLARE v_WarehouseID NATIONAL VARCHAR(36);
   DECLARE v_ShipMethodID NATIONAL VARCHAR(36);
   DECLARE v_EmployeeID NATIONAL VARCHAR(36);
   DECLARE v_ShippingName NATIONAL VARCHAR(50);
   DECLARE v_ShippingAddress1 NATIONAL VARCHAR(50);
   DECLARE v_ShippingAddress2 NATIONAL VARCHAR(50);
   DECLARE v_ShippingAddress3 NATIONAL VARCHAR(50);
   DECLARE v_ShippingCity NATIONAL VARCHAR(50);
   DECLARE v_ShippingState NATIONAL VARCHAR(50);
   DECLARE v_ShippingZip NATIONAL VARCHAR(50);
   DECLARE v_ShippingCountry NATIONAL VARCHAR(50);
   DECLARE v_GLSalesAccount NATIONAL VARCHAR(36);

   DECLARE v_ErrorID INT;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
   END;
   SET @SWV_Error = 0;
   SET v_PayInvoice = 0;
   SET v_PayInvoiceCurrInvoice = 0;

-- get information about the invoice
   select   CustomerID, IFNULL(Posted,0), IFNULL(Total,0), IFNULL(AmountPaid,0), IFNULL(BalanceDue,0), CurrencyID INTO v_CustomerID,v_InvoicePost,v_InvoiceTotal,v_InvoiceAmountPaid,v_InvoiceBalance,
   v_InvoiceCurrencyID FROM
   InvoiceHeader WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   InvoiceNumber = v_InvoiceNumber;

-- verify if the invoice can be used
   IF v_InvoicePost <> 1 OR v_InvoiceBalance = 0 OR v_InvoiceTotal = 0 then

      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;
   end if;

   IF v_ReceiptType = 'Credit Memo' then
	-- get the information about the credit memo
      select   1, IFNULL(Total,0) -IFNULL(AmountPaid,0), IFNULL(Total,0) -IFNULL(AmountPaid,0), CurrencyID, CurrencyExchangeRate, CheckNumber, InvoiceDate INTO v_ReceiptPost,v_ReceiptCreditAmount,v_ReceiptAmount,v_ReceiptCurrencyID,
      v_CurrencyExchangeRate,v_ReceiptCheckNumber,v_ReceiptCheckDate FROM
      InvoiceHeader WHERE
      CompanyID = v_CompanyID AND
      DivisionID = v_DivisionID AND
      DepartmentID = v_DepartmentID AND
      InvoiceNumber = v_ReceiptID;
   ELSE
	-- get the information about the receipt
      select   IFNULL(Posted,0), IFNULL(CreditAmount,IFNULL(Amount,0)), IFNULL(Amount,0), CurrencyID, CurrencyExchangeRate, CheckNumber, TransactionDate INTO v_ReceiptPost,v_ReceiptCreditAmount,v_ReceiptAmount,v_ReceiptCurrencyID,
      v_CurrencyExchangeRate,v_ReceiptCheckNumber,v_ReceiptCheckDate FROM
      ReceiptsHeader WHERE
      CompanyID = v_CompanyID AND
      DivisionID = v_DivisionID AND
      DepartmentID = v_DepartmentID AND
      ReceiptID = v_ReceiptID;
   end if;

-- verify if the receipt can be used
   IF v_ReceiptPost <> 1 OR v_ReceiptCreditAmount = 0 OR v_ReceiptAmount = 0 then

      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;
   end if;

-- verify if the invoice and the receipt are in the same currency
   IF v_InvoiceCurrencyID <> v_ReceiptCurrencyID then
	
      SET @SWV_Error = 0;
      CALL VerifyCurrency2(v_CompanyID,v_DivisionID,v_DepartmentID,v_ReceiptCheckDate,1,v_CompanyCurrencyID,
      v_InvoiceCurrencyID,v_CurrencyExchangeRateInvoice);
      IF @SWV_Error <> 0 then
		
         SET SWP_Ret_Value = 0;
         LEAVE SWL_return;
      end if;
      SET @SWV_Error = 0;
      CALL VerifyCurrency2(v_CompanyID,v_DivisionID,v_DepartmentID,v_ReceiptCheckDate,1,v_CompanyCurrencyID,
      v_ReceiptCurrencyID,v_CurrencyExchangeRate);
      IF @SWV_Error <> 0 then
		
         SET SWP_Ret_Value = 0;
         LEAVE SWL_return;
      end if;
      SET v_CurrencyExchangeRateInvoice = v_CurrencyExchangeRateInvoice*v_CurrencyExchangeRate;
   ELSE
      SET v_CurrencyExchangeRateInvoice = 1.0;
   end if;

-- get the total amount of money the receipts has to transfer

   SET v_PayInvoiceCurrInvoice = fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,v_ReceiptCreditAmount*v_CurrencyExchangeRateInvoice, 
   v_CompanyCurrencyID);
-- if the amount is greater that the invoice needs to be totally paid get only
-- the amount needed to pay the invoice
   IF v_PayInvoiceCurrInvoice > v_InvoiceTotal -v_InvoiceAmountPaid then

      SET v_PayInvoiceCurrInvoice = v_InvoiceTotal -v_InvoiceAmountPaid;
      SET v_Result = 1;
   ELSE
      SET v_Result = 0;
   end if;

-- reduce the amount if specified
   IF v_Amount IS NOT NULL AND v_PayInvoiceCurrInvoice > v_Amount then

      SET v_PayInvoiceCurrInvoice = v_Amount;
   end if;

   START TRANSACTION;

-- cash the receipt

   SET @SWV_Error = 0;
   UPDATE
   InvoiceHeader
   SET
   AmountPaid = v_InvoiceAmountPaid+v_PayInvoiceCurrInvoice,BalanceDue = v_InvoiceTotal -v_InvoiceAmountPaid -v_PayInvoiceCurrInvoice,CheckNumber = v_ReceiptCheckNumber,
   CheckDate = v_ReceiptCheckDate
   WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   InvoiceNumber = v_InvoiceNumber;
   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Update InvoiceHeader failed';
      ROLLBACK;
-- the error handler
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Receipt_Cash',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'ReceiptID',v_ReceiptID);
      SET SWP_Ret_Value = -1;
   end if;	



   SET v_PayInvoice = fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,v_PayInvoiceCurrInvoice/v_CurrencyExchangeRateInvoice, 
   v_CompanyCurrencyID);
   SET v_Rest = v_ReceiptCreditAmount -v_PayInvoice;
   IF v_ReceiptType = 'Credit Memo' then

      SET @SWV_Error = 0;
      UPDATE
      InvoiceHeader
      SET
      AmountPaid = IFNULL(Total,0) -v_Rest,BalanceDue = v_Rest
      WHERE
      CompanyID = v_CompanyID AND
      DivisionID = v_DivisionID AND
      DepartmentID = v_DepartmentID AND
      InvoiceNumber = v_ReceiptID;
      IF @SWV_Error <> 0 then
	
         SET v_ErrorMessage = 'Update Credit Memo failed';
         ROLLBACK;
-- the error handler
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Receipt_Cash',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'ReceiptID',v_ReceiptID);
         SET SWP_Ret_Value = -1;
      end if;
   ELSE
	-- update the receipt header and substract from the credit amount the money used to pay the invoice
      SET @SWV_Error = 0;
      UPDATE
      ReceiptsHeader
      SET
      CreditAmount = CASE v_ForceReceiptClosing WHEN 1 THEN 0 ELSE v_Rest END
      WHERE
      CompanyID = v_CompanyID AND
      DivisionID = v_DivisionID AND
      DepartmentID = v_DepartmentID AND
      ReceiptID = v_ReceiptID;
      IF @SWV_Error <> 0 then
	
         SET v_ErrorMessage = 'Update ReceiptsHeader failed';
         ROLLBACK;
-- the error handler
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Receipt_Cash',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'ReceiptID',v_ReceiptID);
         SET SWP_Ret_Value = -1;
      end if;
   end if;

-- create a credit memo if we have some money left (if it's not already created)
   IF (v_PayInvoice < v_ReceiptCreditAmount) AND (IFNULL(v_ReceiptType,'') <> 'Credit Memo') AND (v_ForceReceiptClosing = 1) then

      SET @SWV_Error = 0;
      SET v_ReturnStatus = GetNextEntityID(v_CompanyID,v_DivisionID,v_DepartmentID,'NextInvoiceNumber',v_CreditMemoNumber);
      IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then
	
         SET v_ErrorMessage = 'GetNextEntityID call failed';
         ROLLBACK;
-- the error handler
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Receipt_Cash',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'ReceiptID',v_ReceiptID);
         SET SWP_Ret_Value = -1;
      end if;
      -- NOT SUPPORTED PRINT CONCAT('@CreditMemoNumber = ', @CreditMemoNumber)


	-- obtain customer info	
	select   TermsID, CustomerShipToId, CustomerShipForId, TaxGroupID, WarehouseID, ShipMethodID, EmployeeID, CustomerName, CustomerAddress1, CustomerAddress2, CustomerAddress3, CustomerCity, CustomerState, CustomerZip, CustomerCountry, GLSalesAccount INTO v_TermsID,v_CustomerShipToID,v_CustomerShipForID,v_TaxGroupID,v_WarehouseID,
      v_ShipMethodID,v_EmployeeID,v_ShippingName,v_ShippingAddress1,v_ShippingAddress2,
      v_ShippingAddress3,v_ShippingCity,v_ShippingState,v_ShippingZip,
      v_ShippingCountry,v_GLSalesAccount FROM CustomerInformation WHERE CompanyID = v_CompanyID
      AND DivisionID = v_DivisionID
      AND DepartmentID = v_DepartmentID
      AND CustomerID = v_CustomerID;
      IF EXISTS(SELECT * FROM InvoiceHeader WHERE CompanyID = v_CompanyID
      AND DivisionID = v_DivisionID AND DepartmentID = v_DepartmentID AND
      InvoiceNumber = 'DEFAULT') then
	
         SET @SWV_Error = 0;
         INSERT INTO InvoiceHeader(CompanyID,
			DivisionID,
			DepartmentID,
			InvoiceNumber,
			OrderNumber,
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
			CURRENT_TIMESTAMP,
			CURRENT_TIMESTAMP,
			CURRENT_TIMESTAMP,
			NULL,
			CURRENT_TIMESTAMP,
			PurchaseOrderNumber,
			TaxExemptID,
			v_TaxGroupID,
			v_CustomerID,
			v_TermsID,
			v_ReceiptCurrencyID,
			v_CurrencyExchangeRate,
			v_Rest,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			v_Rest,
			v_EmployeeID,
			0,
			0,
			0,
			CustomerDropShipment,
			v_ShipMethodID,
			v_WarehouseID,
			v_CustomerShipToID,
			v_CustomerShipForID,
			v_ShippingName,
			v_ShippingAddress1,
			v_ShippingAddress2,
			v_ShippingAddress3,
			v_ShippingCity,
			v_ShippingState,
			v_ShippingZip,
			v_ShippingCountry,
			v_GLSalesAccount,
			PaymentMethodID,
			0,
			0,
			0,
			v_ReceiptCheckNumber,
			v_ReceiptCheckDate,
			NULL,
			NULL,
			NULL,
			NULL,
			NULL,
			NULL,
			NULL,
			NULL,
			0,
			NULL,
			0,
			NULL,
			0,
			NULL,
			NULL,
			NULL,
			0,
			0,
			0,
			NULL,
			HeaderMemo1,
			HeaderMemo2,
			HeaderMemo3,
			HeaderMemo4,
			HeaderMemo5,
			HeaderMemo6,
			HeaderMemo7,
			HeaderMemo8,
			HeaderMemo9
         FROM
         InvoiceHeader
         WHERE
         CompanyID = v_CompanyID
         AND DivisionID = v_DivisionID
         AND DepartmentID = v_DepartmentID
         AND InvoiceNumber = 'DEFAULT';
         IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then
		
            SET v_ErrorMessage = 'Unable to create Credit Memo';
            ROLLBACK;
-- the error handler
            CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Receipt_Cash',v_ErrorMessage,
            v_ErrorID);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'ReceiptID',v_ReceiptID);
            SET SWP_Ret_Value = -1;
         end if;
      ELSE
         SET @SWV_Error = 0;
         INSERT INTO InvoiceHeader(CompanyID,
			DivisionID,
			DepartmentID,
			InvoiceNumber,
			OrderNumber,
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
			CheckDate)
		VALUES(v_CompanyID,
			v_DivisionID,
			v_DepartmentID,
			v_CreditMemoNumber,
			NULL,
			'Credit Memo',
			CURRENT_TIMESTAMP,
			CURRENT_TIMESTAMP,
			CURRENT_TIMESTAMP,
			NULL,
			CURRENT_TIMESTAMP,
			NULL,
			NULL,
			v_TaxGroupID,
			v_CustomerID,
			v_TermsID,
			v_ReceiptCurrencyID,
			v_CurrencyExchangeRate,
			v_Rest,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			v_Rest,
			v_EmployeeID,
			0,
			0,
			0,
			0,
			v_ShipMethodID,
			v_WarehouseID,
			v_CustomerShipToID,
			v_CustomerShipForID,
			v_ShippingName,
			v_ShippingAddress1,
			v_ShippingAddress2,
			v_ShippingAddress3,
			v_ShippingCity,
			v_ShippingState,
			v_ShippingZip,
			v_ShippingCountry,
			v_GLSalesAccount,
			NULL,
			0,
			0,
			0,
			v_ReceiptCheckNumber,
			v_ReceiptCheckDate);
		
         IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then
		
            SET v_ErrorMessage = 'Unable to create Credit Memo';
            ROLLBACK;
-- the error handler
            CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Receipt_Cash',v_ErrorMessage,
            v_ErrorID);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'ReceiptID',v_ReceiptID);
            SET SWP_Ret_Value = -1;
         end if;
      end if;
      SET @SWV_Error = 0;
      INSERT INTO InvoiceDetail(CompanyID,
		DivisionID,
		DepartmentID,
		InvoiceNumber,
		ItemID,
		OrderQty,
		ItemUnitPrice,
		Total,
		GLSalesAccount)
	VALUES(v_CompanyID,
		v_DivisionID,
		v_DepartmentID,
		v_CreditMemoNumber,
		'CreditMemo',
		1,
		v_Rest,
		v_Rest,
		v_GLSalesAccount);
	
      IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then
	
         SET v_ErrorMessage = 'Unable to create Credit Memo Detail';
         ROLLBACK;
-- the error handler
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Receipt_Cash',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'ReceiptID',v_ReceiptID);
         SET SWP_Ret_Value = -1;
      end if;

	-- Post created Credit Memo
      SET @SWV_Error = 0;
      SET v_ReturnStatus = CreditMemo_Post2(v_CompanyID,v_DivisionID,v_DepartmentID,v_CreditMemoNumber);
      IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then
	-- An error occured, go to the error handler
	
         SET v_ErrorMessage = 'CreditMemo_Post call failed';
         ROLLBACK;
-- the error handler
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Receipt_Cash',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'ReceiptID',v_ReceiptID);
         SET SWP_Ret_Value = -1;
      end if;
   ELSE 
      IF (v_Rest <= 0.005) AND (IFNULL(v_ReceiptType,'') <> 'Credit Memo') then
         SET v_ForceReceiptClosing = 1;
      end if;
   end if;


   SET @SWV_Error = 0;
   CALL ReceiptCash_CreateGLTransaction2(v_CompanyID,v_DivisionID,v_DepartmentID,v_InvoiceNumber,v_PayInvoiceCurrInvoice, v_ReturnStatus);
   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then
-- An error occured, go to the error handler

      SET v_ErrorMessage = 'ReceiptCash_CreateGLTransaction call failed';
      ROLLBACK;
-- the error handler
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Receipt_Cash',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'ReceiptID',v_ReceiptID);
      SET SWP_Ret_Value = -1;
   end if;

   IF v_ForceReceiptClosing = 1 then

      SET @SWV_Error = 0;
      SET v_ReturnStatus = CustomerFinancials_ReCalc2(v_CompanyID,v_DivisionID,v_DepartmentID,v_CustomerID);
      IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then
	-- An error occured, go to the error handler
	
         SET v_ErrorMessage = 'CustomerFinancials_Recalc call failed';
         ROLLBACK;
-- the error handler
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Receipt_Cash',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'ReceiptID',v_ReceiptID);
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
   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Receipt_Cash',v_ErrorMessage,
   v_ErrorID);

   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'ReceiptID',v_ReceiptID);

   SET SWP_Ret_Value = -1;
END;


//

DELIMITER ;

DELIMITER //
DROP PROCEDURE IF EXISTS ReceiptCash_CreateGLTransaction2;
//
CREATE      PROCEDURE ReceiptCash_CreateGLTransaction2(v_CompanyID NATIONAL VARCHAR(36), 
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_InvoiceNumber NATIONAL VARCHAR(36),
	v_PayInvoice DECIMAL(19,4),INOUT SWP_Ret_Value INT)
   SWL_return:
BEGIN

/*
Name of stored procedure: ReceiptCash_CreateGLTransaction
Method: 
	Creates a new GL transaction for the cashed invoice

Date Created: EDE - 07/28/2015

Input Parameters:

	@CompanyID NVARCHAR(36)		 - the ID of the company
	@DivisionID NVARCHAR(36)	 - the ID of the division
	@DepartmentID NVARCHAR(36)	 - the ID of the department
	@InvoiceNumber NVARCHAR(36)	 - the invoice number
	@PayInvoice MONEY		 - the cash amount

Output Parameters:

	NONE

Called From:

	Receipt_Cash

Calls:

	VerifyCurrency, GetNextEntityID, LedgerTransactions_PostCOA_AllRecords, Error_InsertError, Error_InsertErrorDetail

Last Modified: 

Last Modified By: 

Revision History: 

*/

   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);

   DECLARE v_GLTransNumber NATIONAL VARCHAR(36);
   DECLARE v_ValueDate DATETIME;
   DECLARE v_OldAmount DECIMAL(19,4);
   DECLARE v_NewAmount DECIMAL(19,4);
   DECLARE v_GainLossAmount DECIMAL(19,4);
   DECLARE v_GLInvoiceSalesAccount NATIONAL VARCHAR(36);
   DECLARE v_CurrencyID NATIONAL VARCHAR(3); 
   DECLARE v_CompanyCurrencyID NATIONAL VARCHAR(3); 
   DECLARE v_CurrencyExchangeRate FLOAT;
   DECLARE v_CurrencyExchangeRateNew FLOAT;
   DECLARE v_GLARAccount NATIONAL VARCHAR(36);
   DECLARE v_GLARCashAccount NATIONAL VARCHAR(36);
   DECLARE v_GLGainLossAccount NATIONAL VARCHAR(36);
   DECLARE v_ProjectID NATIONAL VARCHAR(36);


-- get the ammount of money from the Invoice
   DECLARE v_PostDate NATIONAL VARCHAR(1);
   DECLARE v_ErrorID INT;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
       GET DIAGNOSTICS CONDITION 1 @p1 = RETURNED_SQLSTATE, @p2 = MESSAGE_TEXT;
       SELECT @p1, @p2;
       SET @SWV_Error = 1;
   END;
   select   GLSalesAccount, CurrencyID, CurrencyExchangeRate INTO v_GLInvoiceSalesAccount,v_CurrencyID,v_CurrencyExchangeRate FROM
   InvoiceHeader WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND InvoiceNumber = v_InvoiceNumber;


   SET v_ValueDate = CURRENT_TIMESTAMP;
   SET @SWV_Error = 0;
   CALL VerifyCurrency2(v_CompanyID,v_DivisionID,v_DepartmentID,v_ValueDate,2,v_CompanyCurrencyID,
   v_CurrencyID,v_CurrencyExchangeRateNew);
   IF @SWV_Error <> 0 then

	-- the procedure will return an error code
      SET v_ErrorMessage = 'Currency retrieving failed';
      ROLLBACK;
      DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;
      IF v_ErrorMessage <> '' then

	-- the error handler
	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Invoice_CreateGLTransaction',
         v_ErrorMessage,v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
      end if;
      SET SWP_Ret_Value = -1;
   end if;

-- calculate exchange gain/loss
   SET v_OldAmount = fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,v_PayInvoice*v_CurrencyExchangeRate, 
   v_CompanyCurrencyID);
   SET v_NewAmount = fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,v_PayInvoice*v_CurrencyExchangeRateNew, 
   v_CompanyCurrencyID);
   SET v_GainLossAmount = v_NewAmount -v_OldAmount;

   IF ABS(v_GainLossAmount) < 0.005 then

      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;
   end if;


   START TRANSACTION;


/*
a temporary table used to collect information about the details of the Transaction;
at the end, the record from this table will be grouped by the GLTransactionAccount and inserted into the LedgerTransactionsDetail
*/
   CREATE TEMPORARY TABLE tt_LedgerDetailTmp  
   (
      GLTransactionNumberDetail BIGINT NOT NULL  PRIMARY KEY  AUTO_INCREMENT,
      GLTransactionAccount NATIONAL VARCHAR(36),
      GLDebitAmount DECIMAL(19,4),
      GLCreditAmount DECIMAL(19,4),
      ProjectID NATIONAL VARCHAR(36)
   )  AUTO_INCREMENT = 1;

   select   ProjectID INTO v_ProjectID FROM  InvoiceDetail WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND InvoiceNumber = v_InvoiceNumber
   AND NOT ProjectID IS NULL   LIMIT 1;


-- get the transaction number
   SET @SWV_Error = 0;
   CALL GetNextEntityID2(v_CompanyID,v_DivisionID,v_DepartmentID,'NextGLTransNumber',v_GLTransNumber, v_ReturnStatus);
   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then
-- An error occured, go to the error handler

      SET v_ErrorMessage = 'GetNextEntityID call failed';	
      ROLLBACK;
      DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;
      IF v_ErrorMessage <> '' then

	-- the error handler
	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Invoice_CreateGLTransaction',
         v_ErrorMessage,v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
      end if;
      SET SWP_Ret_Value = -1;
   end if;

   select   IFNULL(DefaultGLPostingDate,'1') INTO v_PostDate FROM
   Companies WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID;

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
	GLTransactionAmountUndistributed,
	GLTransactionBalance,
	GLTransactionPostedYN,
	GLTransactionSource,
	GLTransactionSystemGenerated)
   SELECT
   v_CompanyID,
		v_DivisionID,
		v_DepartmentID,
		v_GLTransNumber,
		'XRate Adj',
		CASE v_PostDate WHEN '1' THEN CURRENT_TIMESTAMP ELSE InvoiceDate END ,
		CustomerID,
		InvoiceNumber,
		v_CompanyCurrencyID,
		1,
		ABS(v_GainLossAmount),
		0,
		0,
		1,
		CONCAT('INV ',cast(v_InvoiceNumber as char(10))),
		1
   FROM
   InvoiceHeader
   WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND InvoiceNumber = v_InvoiceNumber;
   IF @SWV_Error <> 0 then
-- An error occured, go to the error handler
-- and drop the temporary table

      SET v_ErrorMessage = 'Insert into LedgerTransactions failed';
      ROLLBACK;
      DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;
      IF v_ErrorMessage <> '' then

	-- the error handler
	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Invoice_CreateGLTransaction',
         v_ErrorMessage,v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
      end if;
      SET SWP_Ret_Value = -1;
   end if;

-- Get Company Account Receivable
   select   GLARAccount, GLARCashAccount, GLCurrencyGainLossAccount INTO v_GLARAccount,v_GLARCashAccount,v_GLGainLossAccount FROM
   Companies WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID;


-- Debit/Credit @GainLossAmount to Account Receivable
   SET @SWV_Error = 0;
   INSERT INTO tt_LedgerDetailTmp(GLTransactionAccount,
		GLDebitAmount,
		GLCreditAmount,
		ProjectID)
		VALUES(CASE WHEN v_GainLossAmount > 0 THEN v_GLARCashAccount ELSE v_GLARAccount END,
			CASE WHEN v_GainLossAmount > 0 THEN v_GainLossAmount ELSE 0 END,
			CASE WHEN v_GainLossAmount < 0 THEN(-1)*v_GainLossAmount ELSE 0 END,
			v_ProjectID);
		
	
   IF @SWV_Error <> 0 then
	
      SET v_ErrorMessage = 'Insert AR into LedgerTransactionsDetail failed';
      ROLLBACK;
      DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;
      IF v_ErrorMessage <> '' then

	-- the error handler
	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Invoice_CreateGLTransaction',
         v_ErrorMessage,v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
      end if;
      SET SWP_Ret_Value = -1;
   end if;

-- Debit/Credit @GainLossAmount to Gain/Loss Account
   SET @SWV_Error = 0;
   INSERT INTO tt_LedgerDetailTmp(GLTransactionAccount,
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
      IF v_ErrorMessage <> '' then

	-- the error handler
	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Invoice_CreateGLTransaction',
         v_ErrorMessage,v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
      end if;
      SET SWP_Ret_Value = -1;
   end if;


-- insert the data into the LedgerTransactionsDetail table; 
-- the records are grouped by GLTransactionAccount and ProjectID 
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
	SUM(IFNULL(GLCreditAmount,0)) ,
	ProjectID
   FROM
   tt_LedgerDetailTmp
   GROUP BY
   ProjectID,GLTransactionAccount;
   IF @SWV_Error <> 0 then
-- An error occured, go to the error handler
-- and drop the temporary table

      SET v_ErrorMessage = 'Insert into LedgerTransactionDetail failed';
      ROLLBACK;
      DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;
      IF v_ErrorMessage <> '' then

	-- the error handler
	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Invoice_CreateGLTransaction',
         v_ErrorMessage,v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
      end if;
      SET SWP_Ret_Value = -1;
   end if;


   DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;


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
-- An error occured, go to the error handler
-- and drop the temporary table

      SET v_ErrorMessage = 'LedgerTransactions_PostCOA_AllRecords call failed';
      ROLLBACK;
      DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;
      IF v_ErrorMessage <> '' then

	-- the error handler
	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Invoice_CreateGLTransaction',
         v_ErrorMessage,v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
      end if;
      SET SWP_Ret_Value = -1;
   end if;


-- Everything is  OK
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

   DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;

   IF v_ErrorMessage <> '' then

	-- the error handler
	
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Invoice_CreateGLTransaction',
      v_ErrorMessage,v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
   end if;
   SET SWP_Ret_Value = -1;
END;


//

DELIMITER ;

DELIMITER //
DROP PROCEDURE IF EXISTS VerifyCurrency2;
//
CREATE      PROCEDURE VerifyCurrency2(v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_ExchangeRateDate DATETIME,
	v_ExchangeRateFlag INT,
	INOUT v_CompanyCurrencyID NATIONAL VARCHAR(3) ,
	INOUT v_CurrencyID NATIONAL VARCHAR(3) ,
 	INOUT v_CurrencyExchangeRate FLOAT)
BEGIN





/*
Name of stored procedure: VerifyCurrency
Method: 
	Checks passed currencies values and fill them with default one, if value is NULL

Date Created: EDE - 07/28/2015

Input Parameters:

	@CompanyID NVARCHAR(36)		 - the ID of company
	@DivisionID NVARCHAR(36)	 - the ID of division
	@DepartmentID NVARCHAR(36)	 - the ID of department
	@ExchangeRateDate DATETIME	 - date for exchange rate
	@ExchangeRateFlag INT		 - type of rate for getting most favouritable rate:

						   

						   0 - undefined (last rate for selected date)

						   

						   1 - highest rate (for receivable transaction)

						   

						   2 - lowest rate (for payable transaction)

Output Parameters:

	@CompanyCurrencyID NVARCHAR(3)	 - returns default company CurrencyID
	@CurrencyID NVARCHAR(3)		 - checks passed CurrencyID and if it is NULL, assign it the default value
	@CurrencyExchangeRate FLOAT 	 - checks @CurrencyExchangeRate to ensure that it >0 and returns corrected value

Called From:

	RMA_Post, FixedAssetDisposal_CreateGLTransaction, VerifyCurrency.vb, ReturnInvoice_Post, ServiceInvoice_Recalc, ServiceReceipt_CreateGLTransaction, Return_Cancel, Order_Cancel, ReceiptCash_CreateGLTransaction, DebitMemo_CreateGLTransaction, Purchase_Post, Bank_PostWithdrawal, Purchase_Cancel, Bank_PostTransfer, Receipt_CreateGLTransaction, Invoice_CustomerFinancialsUpdateAging, DebitMemo_Cancel, DebitMemo_Recalc, Inventory_Costing, PaymentCheck_CreateGLTransaction, FixedAssetDepreciation_CreateGLTransaction, Bank_PostDeposit, Contract_Recalc, ReturnInvoice_VendorFinancialsUpdateAging, ReturnInvoice_AdjustVendorFinancials, ReceiptCash_Return_CreateGLTransaction, Bank_PostReconciliation, ReturnInvoice_Cancel, Receiving_AdjustVendorFinancials, Receiving_CreateGLTransaction, Receipt_AdjustCustomerFinancials, ReturnReceipt_AdjustVendorFinancials, ReturnInvoice_CreateGLTransaction, Payment_AdjustVendorFinancials, ServiceInvoice_Cancel, ServiceInvoice_Post, Order_Recalc, ReturnReceipt_CreateGLTransaction, RMAReceiving_CreateGLTransaction, ServiceInvoice_CreateGLTransaction, Payment_CreateGLTransaction, ReturnInvoice_Recalc, Purchase_Recalc, ServiceOrder_Cancel, Invoice_Post, Invoice_Recalc, Order_CreditCustomerAccount, CustomerFinancials_UpdateAging, Invoice_Cancel, VendorFinancials_UpdateAging, Return_Recalc, CreditMemo_Recalc, Purchase_DebitMemoPost, Invoice_AdjustCustomerFinancials, Return_CreditVendorAccount, RMA_Cancel, Invoice_CreateGLTransaction, RMAReceiving_AdjustCustomerFinancials, RMA_Recalc, CreditMemo_CreateGLTransaction, Invoice_UndoAdjustCustomerFinancials, Invoice_CreditMemoCreateGLTransaction, ServiceOrder_Recalc, Inventory_Assemblies, Receiving_UpdateInventoryCosting, Invoice_UndoCustomerFinancialsUpdateAging

Calls:

	NONE

Last Modified: 

Last Modified By: 

Revision History: 

*/

   DECLARE v_Today DATETIME;
   SET v_ExchangeRateDate = STR_TO_DATE(DATE_FORMAT(v_ExchangeRateDate,'%Y-%m-%d'),'%Y-%m-%d');
   SET v_Today = STR_TO_DATE(DATE_FORMAT(CURRENT_TIMESTAMP,'%Y-%m-%d'),'%Y-%m-%d');

   select   IFNULL(CurrencyID,N'') INTO v_CompanyCurrencyID FROM Companies WHERE CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID   LIMIT 1;

   SET v_CurrencyID = IFNULL(v_CurrencyID,v_CompanyCurrencyID);

   IF v_ExchangeRateFlag = 1 then
	
      SET v_CurrencyExchangeRate =
      IFNULL(v_CurrencyExchangeRate,(SELECT MAX(CurrencyExchangeRate)
      FROM CurrencyTypesHistory
      WHERE
      CompanyID = v_CompanyID AND
      DivisionID = v_DivisionID AND
      DepartmentID = v_DepartmentID AND
      CurrencyID = v_CurrencyID	AND
      STR_TO_DATE(DATE_FORMAT(CurrencyIDDateTime,'%Y-%m-%d'),'%Y-%m-%d') = v_ExchangeRateDate));
   ELSE 
      IF v_ExchangeRateFlag = 2 then
	
         SET v_CurrencyExchangeRate =
         IFNULL(v_CurrencyExchangeRate,(SELECT MIN(CurrencyExchangeRate)
         FROM CurrencyTypesHistory
         WHERE
         CompanyID = v_CompanyID AND
         DivisionID = v_DivisionID AND
         DepartmentID = v_DepartmentID AND
         CurrencyID = v_CurrencyID	AND
         STR_TO_DATE(DATE_FORMAT(CurrencyIDDateTime,'%Y-%m-%d'),'%Y-%m-%d') = v_ExchangeRateDate));
      ELSE
         SET v_CurrencyExchangeRate =
         IFNULL(v_CurrencyExchangeRate,(SELECT  CurrencyExchangeRate
         FROM CurrencyTypesHistory
         WHERE
         CompanyID = v_CompanyID AND
         DivisionID = v_DivisionID AND
         DepartmentID = v_DepartmentID AND
         CurrencyID = v_CurrencyID	AND
         STR_TO_DATE(DATE_FORMAT(CurrencyIDDateTime,'%Y-%m-%d'),'%Y-%m-%d') = v_ExchangeRateDate
         ORDER BY
         CurrencyIDDateTime DESC LIMIT 1));
      end if;
   end if;

   SET v_CurrencyExchangeRate =
   IFNULL(v_CurrencyExchangeRate,(SELECT  CurrencyExchangeRate
   FROM CurrencyTypesHistory
   WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   CurrencyID = v_CurrencyID	AND
   CurrencyIDDateTime < v_ExchangeRateDate
   ORDER BY
   CurrencyIDDateTime DESC LIMIT 1));

   SET v_CurrencyExchangeRate =
   IFNULL(v_CurrencyExchangeRate,(SELECT  CurrencyExchangeRate
   FROM CurrencyTypes
   WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   CurrencyID = v_CurrencyID LIMIT 1));

   SET v_CurrencyExchangeRate = IFNULL(v_CurrencyExchangeRate,1);

   IF v_CurrencyExchangeRate <= 0 then
      SET v_CurrencyExchangeRate = 1;
   end if;
END;
















//

DELIMITER ;
