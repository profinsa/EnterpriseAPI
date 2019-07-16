CREATE PROCEDURE ReturnReceipt_Cash (v_CompanyID NATIONAL VARCHAR(36), 
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_InvoiceNumber NATIONAL VARCHAR(36),
	v_ReceiptID NATIONAL VARCHAR(36),
	v_ReceiptType NATIONAL VARCHAR(36),
	v_TransactionType NATIONAL VARCHAR(36),
	v_Amount DECIMAL(19,4),
	INOUT v_Result SMALLINT ,INOUT SWP_Ret_Value INT) SWL_return:
BEGIN











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

   DECLARE v_PayInvoice DECIMAL(19,4);
   DECLARE v_Rest DECIMAL(19,4);


   DECLARE v_VendorID NATIONAL VARCHAR(50);
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


   IF UPPER(v_TransactionType) = UPPER('Debit Memo') then

      select   VendorID, Posted, IFNULL(Total,0), IFNULL(AmountPaid,0), IFNULL(BalanceDue,0), CurrencyID INTO v_VendorID,v_InvoicePost,v_InvoiceTotal,v_InvoiceAmountPaid,v_InvoiceBalance,
      v_InvoiceCurrencyID FROM
      PurchaseHeader WHERE
      CompanyID = v_CompanyID AND
      DivisionID = v_DivisionID AND
      DepartmentID = v_DepartmentID AND
      PurchaseNumber = v_InvoiceNumber;
   ELSE
      select   CustomerID, Posted, IFNULL(Total,0), IFNULL(AmountPaid,0), IFNULL(BalanceDue,0), CurrencyID INTO v_VendorID,v_InvoicePost,v_InvoiceTotal,v_InvoiceAmountPaid,v_InvoiceBalance,
      v_InvoiceCurrencyID FROM
      InvoiceHeader WHERE
      CompanyID = v_CompanyID AND
      DivisionID = v_DivisionID AND
      DepartmentID = v_DepartmentID AND
      InvoiceNumber = v_InvoiceNumber;
   end if;

   IF v_InvoicePost <> 1 OR v_InvoiceBalance = 0 OR v_InvoiceTotal = 0 then

      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;
   end if;

   IF v_ReceiptType = 'Credit Memo' then
	
      select   1, IFNULL(Total,0) -IFNULL(AmountPaid,0), IFNULL(Total,0) -IFNULL(AmountPaid,0), CurrencyID, CurrencyExchangeRate, CheckNumber, InvoiceDate INTO v_ReceiptPost,v_ReceiptCreditAmount,v_ReceiptAmount,v_ReceiptCurrencyID,
      v_CurrencyExchangeRate,v_ReceiptCheckNumber,v_ReceiptCheckDate FROM
      InvoiceHeader WHERE
      CompanyID = v_CompanyID AND
      DivisionID = v_DivisionID AND
      DepartmentID = v_DepartmentID AND
      InvoiceNumber = v_ReceiptID;
   ELSE
	
      select   IFNULL(Posted,0), IFNULL(CreditAmount,IFNULL(Amount,0)), IFNULL(Amount,0), CurrencyID, CurrencyExchangeRate, CheckNumber, TransactionDate INTO v_ReceiptPost,v_ReceiptCreditAmount,v_ReceiptAmount,v_ReceiptCurrencyID,
      v_CurrencyExchangeRate,v_ReceiptCheckNumber,v_ReceiptCheckDate FROM
      ReceiptsHeader WHERE
      CompanyID = v_CompanyID AND
      DivisionID = v_DivisionID AND
      DepartmentID = v_DepartmentID AND
      ReceiptID = v_ReceiptID;
   end if;


   IF v_ReceiptPost <> 1 OR v_ReceiptCreditAmount = 0 OR v_ReceiptAmount = 0 then

      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;
   end if;


   IF v_InvoiceCurrencyID <> v_ReceiptCurrencyID then

      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;
   end if;



   SET v_PayInvoice = v_ReceiptCreditAmount;


   IF v_PayInvoice > v_InvoiceTotal -v_InvoiceAmountPaid then

      SET v_PayInvoice = v_InvoiceTotal -v_InvoiceAmountPaid;
      SET v_Result = 1;
   ELSE
      SET v_Result = 0;
   end if;


   IF v_Amount IS NOT NULL AND v_PayInvoice > v_Amount then

      SET v_PayInvoice = v_Amount;
   end if;

   START TRANSACTION;


   SET @SWV_Error = 0;
   IF UPPER(v_TransactionType) = UPPER('Debit Memo') then

      UPDATE
      PurchaseHeader
      SET
      AmountPaid = v_InvoiceAmountPaid+v_PayInvoice,BalanceDue = v_InvoiceTotal -v_InvoiceAmountPaid -v_PayInvoice,
      CheckNumber = v_ReceiptCheckNumber,
      CheckDate = v_ReceiptCheckDate
      WHERE
      CompanyID = v_CompanyID AND
      DivisionID = v_DivisionID AND
      DepartmentID = v_DepartmentID AND
      PurchaseNumber = v_InvoiceNumber;
   ELSE
      UPDATE
      InvoiceHeader
      SET
      AmountPaid = v_InvoiceAmountPaid+v_PayInvoice,BalanceDue = v_InvoiceTotal -v_InvoiceAmountPaid -v_PayInvoice,
      CheckNumber = v_ReceiptCheckNumber,
      CheckDate = v_ReceiptCheckDate
      WHERE
      CompanyID = v_CompanyID AND
      DivisionID = v_DivisionID AND
      DepartmentID = v_DepartmentID AND
      InvoiceNumber = v_InvoiceNumber;
   end if;
   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Update InvoiceHeader failed';
      ROLLBACK;

      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'ReturnReceipt_Cash',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'ReceiptID',v_ReceiptID);
      SET SWP_Ret_Value = -1;
   end if;	

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

         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'ReturnReceipt_Cash',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'ReceiptID',v_ReceiptID);
         SET SWP_Ret_Value = -1;
      end if;
   ELSE
	
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

         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'ReturnReceipt_Cash',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'ReceiptID',v_ReceiptID);
         SET SWP_Ret_Value = -1;
      end if;
   end if;



   IF (v_PayInvoice < v_ReceiptCreditAmount) AND (IFNULL(v_ReceiptType,'') <> 'Credit Memo') then

      SET @SWV_Error = 0;
      CALL GetNextEntityID2(v_CompanyID,v_DivisionID,v_DepartmentID,'NextInvoiceNumber',v_CreditMemoNumber, v_ReturnStatus);
      IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then
	
         SET v_ErrorMessage = 'GetNextEntityID call failed';
         ROLLBACK;

         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'ReturnReceipt_Cash',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'ReceiptID',v_ReceiptID);
         SET SWP_Ret_Value = -1;
      end if;
      


	
	select   TermsID, TaxGroupID, WarehouseID, ShipMethodID, VendorName, VendorAddress1, VendorAddress2, VendorAddress3, VendorCity, VendorState, VendorZip, VendorCountry, GLPurchaseAccount INTO v_TermsID,v_TaxGroupID,v_WarehouseID,v_ShipMethodID,v_ShippingName,v_ShippingAddress1,
      v_ShippingAddress2,v_ShippingAddress3,v_ShippingCity,v_ShippingState,
      v_ShippingZip,v_ShippingCountry,v_GLSalesAccount FROM VendorInformation WHERE CompanyID = v_CompanyID
      AND DivisionID = v_DivisionID
      AND DepartmentID = v_DepartmentID
      AND VendorID = v_VendorID;
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
			v_VendorID,
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

            CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'ReturnReceipt_Cash',v_ErrorMessage,
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
			v_VendorID,
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

            CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'ReturnReceipt_Cash',v_ErrorMessage,
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

         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'ReturnReceipt_Cash',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'ReceiptID',v_ReceiptID);
         SET SWP_Ret_Value = -1;
      end if;

	
      SET @SWV_Error = 0;
      CALL CreditMemo_Post(v_CompanyID,v_DivisionID,v_DepartmentID,v_CreditMemoNumber, v_PostingResult, v_ReturnStatus);
      IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then
	
	
         SET v_ErrorMessage = 'CreditMemo_Post call failed';
         ROLLBACK;

         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'ReturnReceipt_Cash',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'ReceiptID',v_ReceiptID);
         SET SWP_Ret_Value = -1;
      end if;
   end if;


   SET @SWV_Error = 0;
   CALL ReceiptCash_Return_CreateGLTransaction(v_CompanyID,v_DivisionID,v_DepartmentID,v_InvoiceNumber,v_PayInvoice, v_ReturnStatus);
   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then


      SET v_ErrorMessage = 'ReceiptCash_Return_CreateGLTransaction call failed';
      ROLLBACK;

      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'ReturnReceipt_Cash',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'ReceiptID',v_ReceiptID);
      SET SWP_Ret_Value = -1;
   end if;

   SET @SWV_Error = 0;
   SET v_ReturnStatus = VendorFinancials_ReCalc2(v_CompanyID,v_DivisionID,v_DepartmentID,v_VendorID);
   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then


      SET v_ErrorMessage = 'VendorFinancials_Recalc call failed';
      ROLLBACK;

      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'ReturnReceipt_Cash',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'ReceiptID',v_ReceiptID);
      SET SWP_Ret_Value = -1;
   end if;


   COMMIT;
   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;








   ROLLBACK;

   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'ReturnReceipt_Cash',v_ErrorMessage,
   v_ErrorID);

   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'ReceiptID',v_ReceiptID);

   SET SWP_Ret_Value = -1;
END