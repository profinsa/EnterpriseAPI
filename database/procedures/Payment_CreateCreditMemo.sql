CREATE PROCEDURE Payment_CreateCreditMemo (v_CompanyID 		NATIONAL VARCHAR(36),
	v_DivisionID 		NATIONAL VARCHAR(36),
	v_DepartmentID 		NATIONAL VARCHAR(36),
	v_PaymentID NATIONAL VARCHAR(36),INOUT SWP_Ret_Value INT) SWL_return:
BEGIN




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



      select   GLARSalesAccount, GLAPAccount INTO v_GLDefaultSalesAccount,v_GLAPAccount FROM
      Companies WHERE
      CompanyID = v_CompanyID
      AND DivisionID = v_DivisionID
      AND DepartmentID = v_DepartmentID;


      SET @SWV_Error = 0;
      CALL GetNextEntityID2(v_CompanyID,v_DivisionID,v_DepartmentID,'NextInvoiceNumber',v_CreditMemoNumber, v_ReturnStatus);

      IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then

         SET v_ErrorMessage = 'GetNextEntityID call failed';
         LEAVE WriteError;
      end if;



      SET @SWV_Error = 0;
      CALL Customer_CreateFromVendor(v_CompanyID,v_DivisionID,v_DepartmentID,v_VendorID, v_ReturnStatus);

      IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then

         SET v_ErrorMessage = 'Customer_CreateFromVendor call failed';
         LEAVE WriteError;
      end if;



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
	PaymentDate, 
	DueToDate, 
	now(), 
	now(), 
	now(), 
	NULL, 
	NULL, 
	NULL, 
	VendorID, 
	NULL, 
	CurrencyID, 
	CurrencyExchangeRate, 
	v_CreditAmount, 
	0, 
	0, 
	0, 
	0, 
	0, 
	0, 
	0, 
	0, 
	0, 
	v_CreditAmount, 
	NULL, 
	NULL, 

	NULL, 
	NULL, 
	NULL, 
	NULL, 
	NULL, 
	NULL, 
	NULL, 
	NULL, 
	NULL, 
	NULL, 

	NULL, 
	NULL, 
	NULL, 
	NULL, 
	NULL, 
	NULL, 
	NULL, 
	0, 
	v_CreditAmount, 
	0, 
	NULL, 
	NULL, 
	NULL, 
	NULL, 
	NULL, 
	NULL, 
	NULL, 
	NULL, 
	NULL, 
	NULL, 
	0, 
	now(), 
	0, 
	now(), 
	0, 
	now(), 
	NULL, 
	now(), 
	0, 
	0, 
	0, 
	now(), 
	NULL, 
	NULL, 
	NULL, 
	NULL, 
	NULL, 
	NULL, 
	NULL, 
	NULL, 
	NULL 
      FROM
      PaymentsHeader
      WHERE
      CompanyID = v_CompanyID
      AND DivisionID = v_DivisionID
      AND DepartmentID = v_DepartmentID
      AND PaymentID = v_PaymentID;



      IF @SWV_Error <> 0 then

         SET v_ErrorMessage = 'Cannot create the credit memo header';
         LEAVE WriteError;
      end if;




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
	'Credit Memo', 
	NULL, 
	NULL, 
	1, 
	NULL, 
	NULL, 
	NULL, 
	NULL, 
	NULL, 
	NULL, 
	NULL, 
	NULL, 
	NULL, 
	v_CreditAmount, 
	NULL, 
	v_GLAPAccount, 
	v_ProjectID, 
	NULL, 
	NULL, 
	NULL, 
	NULL, 
	NULL, 
	NULL 
);



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



      UPDATE
      PaymentsHeader
      SET
      Paid = 1
      WHERE
      CompanyID = v_CompanyID
      AND DivisionID = v_DivisionID
      AND DepartmentID = v_DepartmentID
      AND PaymentID = v_PaymentID;



      COMMIT;
      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;







   END;
   IF (NOT (v_Void = 1 OR v_Posted = 0 OR v_CreditAmount <= 0)) AND 1   < 2 then
      ROLLBACK;
   ELSE
      COMMIT;
   end if;

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
END