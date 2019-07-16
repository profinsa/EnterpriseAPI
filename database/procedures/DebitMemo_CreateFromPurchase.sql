CREATE PROCEDURE DebitMemo_CreateFromPurchase (v_CompanyID NATIONAL VARCHAR(36), 
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_PurchaseNumber  NATIONAL VARCHAR(36),
	v_Amount DECIMAL(19,4),
	INOUT v_DebitMemoNumber NATIONAL VARCHAR(36),INOUT SWP_Ret_Value INT) SWL_return:
BEGIN










   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);


   DECLARE v_ProjectID NATIONAL VARCHAR(36);
   DECLARE v_GLPurchaseAccount NATIONAL VARCHAR(36);


   DECLARE v_ErrorID INT;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
   END;
   SET @SWV_Error = 0;
   IF NOT EXISTS(SELECT PurchaseNumber
   FROM PurchaseHeader
   WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND PurchaseNumber = v_PurchaseNumber) then

      SET SWP_Ret_Value = -1;
      LEAVE SWL_return;
   end if;

   START TRANSACTION;


   SET @SWV_Error = 0;
   SET v_ReturnStatus = GetNextEntityID(v_CompanyID,v_DivisionID,v_DepartmentID,'NextPurchaseOrderNumber',v_DebitMemoNumber);
   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then

      SET v_ErrorMessage = 'GetNextEntityID call failed';
      ROLLBACK;

      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'DebitMemo_CreateFromPurchase',
      v_ErrorMessage,v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseNumber',v_PurchaseNumber);
      SET SWP_Ret_Value = -1;
   end if;
   





SET @SWV_Error = 0;
   INSERT INTO PurchaseHeader(CompanyID,
	DivisionID,
	DepartmentID,
	PurchaseNumber,
	TransactionTypeID,
	PurchaseDate,
	PurchaseDueDate,
	PurchaseShipDate,
	PurchaseCancelDate,
	PurchaseDateRequested,
	SystemDate,
	OrderNumber,
	VendorInvoiceNumber,
	OrderedBy,
	TaxExemptID,
	TaxGroupID,
	VendorID,
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
	ShipToWarehouse,
	WarehouseID,
	ShipMethodID,
	ShippingName,
	ShippingAddress1,
	ShippingAddress2,
	ShippingAddress3,
	ShippingCity,
	ShippingState,
	ShippingZip,
	ShippingCountry,
	PaymentMethodID,
	Paid,
	GLPurchaseAccount,
	AmountPaid,
	BalanceDue,
	UndistributedAmount,
	CheckNumber,
	CheckDate,
	PaidDate,
	CreditCardTypeID,
	CreditCardNumber,
	CreditCardExpDate,
	CreditCardCSVNumber,
	CreditCardBillToZip,
	CreditCardValidationCode,
	CreditCardApprovalNumber,
	Printed,
	PrintedDate,
	Shipped,
	ShipDate,
	TrackingNumber,
	Received,
	ReceivedDate,
	RecivingNumber,
	Posted,
	PostedDate)
   SELECT
   v_CompanyID,
		v_DivisionID,
		v_DepartmentID,
		v_DebitMemoNumber,
		'Debit Memo',
		CURRENT_TIMESTAMP,
		NULL,
		NULL,
		NULL,
		NULL,
		CURRENT_TIMESTAMP,
		PurchaseNumber,
		VendorInvoiceNumber,
		OrderedBy,
		TaxExemptID,
		TaxGroupID,
		VendorID,
		TermsID,
		CurrencyID,
		CurrencyExchangeRate,
		v_Amount,
		0,
		0,
		0,
		0,
		0,
		0,
		0,
		0,
		0,
		v_Amount,
		ShipToWarehouse,
		WarehouseID,
		ShipMethodID,
		ShippingName,
		ShippingAddress1,
		ShippingAddress2,
		ShippingAddress3,
		ShippingCity,
		ShippingState,
		ShippingZip,
		ShippingCountry,
		PaymentMethodID,
		0,
		GLPurchaseAccount,
		0,
		0,
		0,
		NULL,
		NULL,
		NULL,
		CreditCardTypeID,
		CreditCardNumber,
		CreditCardExpDate,
		CreditCardCSVNumber,
		CreditCardBillToZip,
		CreditCardValidationCode,
		CreditCardApprovalNumber,
		0,
		NULL,
		0,
		NULL,
		NULL,
		0,
		NULL,
		NULL,
		0,
		NULL
   FROM
   PurchaseHeader
   WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   PurchaseNumber = v_PurchaseNumber;					

   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then

      SET v_ErrorMessage = 'Unable to create Debit Memo';
      ROLLBACK;

      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'DebitMemo_CreateFromPurchase',
      v_ErrorMessage,v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseNumber',v_PurchaseNumber);
      SET SWP_Ret_Value = -1;
   end if;

   select   ProjectID INTO v_ProjectID FROM  PurchaseDetail WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND PurchaseNumber = v_PurchaseNumber
   AND NOT ProjectID IS NULL   LIMIT 1;


   select   GLPurchaseAccount INTO v_GLPurchaseAccount FROM PurchaseHeader WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND PurchaseNumber = v_PurchaseNumber;

   SET @SWV_Error = 0;
   INSERT INTO PurchaseDetail(CompanyID,
	DivisionID,
	DepartmentID,
	PurchaseNumber,
	ItemID,
	OrderQty,
	ItemUnitPrice,
	Total,
	GLPurchaseAccount,
	ProjectID)
VALUES(v_CompanyID,
	v_DivisionID,
	v_DepartmentID,
	v_DebitMemoNumber,
	'DebitMemo',
	1,
	v_Amount,
	v_Amount,
	v_GLPurchaseAccount,
	v_ProjectID);


   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then

      SET v_ErrorMessage = 'Unable to create Debit Memo Detail';
      ROLLBACK;

      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'DebitMemo_CreateFromPurchase',
      v_ErrorMessage,v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseNumber',v_PurchaseNumber);
      SET SWP_Ret_Value = -1;
   end if;


   COMMIT;
   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;








   ROLLBACK;

   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'DebitMemo_CreateFromPurchase',
   v_ErrorMessage,v_ErrorID);

   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseNumber',v_PurchaseNumber);

   SET SWP_Ret_Value = -1;
END