CREATE PROCEDURE Invoice_CreateFromReturn (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_OrderNumber  NATIONAL VARCHAR(36),
	INOUT v_InvoiceNumber NATIONAL VARCHAR(36)  ,INOUT SWP_Ret_Value INT) SWL_return:
BEGIN



















   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);


   DECLARE v_PostingResult NATIONAL VARCHAR(200);
   DECLARE v_ErrorID INT;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
   END;
   SET @SWV_Error = 0;
   IF EXISTS(SELECT * FROM
   InvoiceHeader
   WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND OrderNumber  = v_OrderNumber) then

	
      select   InvoiceNumber INTO v_InvoiceNumber FROM
      InvoiceHeader WHERE
      CompanyID = v_CompanyID
      AND DivisionID = v_DivisionID
      AND DepartmentID = v_DepartmentID
      AND OrderNumber  = v_OrderNumber;
      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;
   end if;

   START TRANSACTION;


   SET @SWV_Error = 0;
   SET v_ReturnStatus = GetNextEntityID(v_CompanyID,v_DivisionID,v_DepartmentID,'NextInvoiceNumber',v_InvoiceNumber);
   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then


      SET v_InvoiceNumber = N'';
      SET v_ErrorMessage = 'GetNextEntityID call failed';
      ROLLBACK;

      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Invoice_CreateFromReturn',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'OrderNumber',v_OrderNumber);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
      SET SWP_Ret_Value = -1;
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
	Memorize,
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
		v_InvoiceNumber,
		OrderNumber,
		'Return',
		OrderDate,
		OrderDueDate,
		OrderShipDate,
		OrderCancelDate,
		SystemDate ,
		Memorize,
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
		0,
		NULL,
		Backordered,
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
   OrderHeader
   WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND OrderNumber = v_OrderNumber;

   IF @SWV_Error <> 0 then


      SET v_InvoiceNumber = N'';
      SET v_ErrorMessage = 'Insert into InvoiceHeader failed';
      ROLLBACK;

      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Invoice_CreateFromReturn',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'OrderNumber',v_OrderNumber);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
      SET SWP_Ret_Value = -1;
   end if;



   SET @SWV_Error = 0;
   INSERT INTO InvoiceDetail(CompanyID,
	DivisionID,
	DepartmentID,
	InvoiceNumber,
	ItemID,
	WarehouseID,
	WarehouseBinID,
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
	DetailMemo5,
	TaxGroupID,
	TaxAmount,
	TaxPercent,
	SubTotal)
   SELECT
   CompanyID,
		DivisionID,
		DepartmentID,
		v_InvoiceNumber,
		ItemID,
		WarehouseID,
		WarehouseBinID,
		SerialNumber,
		OrderQty,
		BackOrdered,
		BackOrderQyyty,
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
		DetailMemo5,
		TaxGroupID,
		TaxAmount,
		TaxPercent,
		SubTotal
   FROM
   OrderDetail
   WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND OrderNumber = v_OrderNumber
   AND Total > 0;

   IF @SWV_Error <> 0 then


      SET v_InvoiceNumber = N'';
      SET v_ErrorMessage = 'Insert into InvoiceDetail failed';
      ROLLBACK;

      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Invoice_CreateFromReturn',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'OrderNumber',v_OrderNumber);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
      SET SWP_Ret_Value = -1;
   end if;




   SET @SWV_Error = 0;
   SET v_ReturnStatus = Invoice_Post(v_CompanyID,v_DivisionID,v_DepartmentID,v_InvoiceNumber,2,v_PostingResult);
   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then

      SET v_ErrorMessage = 'Posting invoice failed';
      ROLLBACK;

      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Invoice_CreateFromReturn',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'OrderNumber',v_OrderNumber);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
      SET SWP_Ret_Value = -1;
   end if;




   SET @SWV_Error = 0;
   UPDATE
   OrderHeader
   SET
   Invoiced = 1,InvoiceNumber = v_InvoiceNumber,InvoiceDate =(SELECT
   InvoiceDate
   FROM
   InvoiceHeader
   WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND InvoiceNumber = v_InvoiceNumber)
   WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND OrderNumber = v_OrderNumber;

   IF @SWV_Error <> 0 then


      SET v_InvoiceNumber = N'';
      SET v_ErrorMessage = 'Update OrderHeader failed';
      ROLLBACK;

      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Invoice_CreateFromReturn',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'OrderNumber',v_OrderNumber);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
      SET SWP_Ret_Value = -1;
   end if;



   COMMIT;
   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;







   ROLLBACK;

   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Invoice_CreateFromReturn',v_ErrorMessage,
   v_ErrorID);

   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'OrderNumber',v_OrderNumber);
   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);

   SET SWP_Ret_Value = -1;
END