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
/*       GET DIAGNOSTICS CONDITION 1 @p1 = RETURNED_SQLSTATE, @p2 = MESSAGE_TEXT;
       SELECT @p1, @p2;*/
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
      CALL GetNextEntityID2(v_CompanyID,v_DivisionID,v_DepartmentID,'NextInvoiceNumber',v_CreditMemoNumber, v_ReturnStatus);
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
      CALL CustomerFinancials_ReCalc(v_CompanyID,v_DivisionID,v_DepartmentID,v_CustomerID, v_ReturnStatus);
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
/*       GET DIAGNOSTICS CONDITION 1 @p1 = RETURNED_SQLSTATE, @p2 = MESSAGE_TEXT;
       SELECT @p1, @p2;*/
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
         CALL LedgerMain_VerifyPeriod(v_CompanyID,v_DivisionID,v_DepartmentID,v_TranDate,v_PeriodToPost,v_PeriodClosed, v_ReturnStatus);
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
