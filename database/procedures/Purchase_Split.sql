CREATE PROCEDURE Purchase_Split (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_PurchaseNumber NATIONAL VARCHAR(36),
	INOUT v_Success INT ,INOUT SWP_Ret_Value INT) SWL_return:
BEGIN




   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);

   DECLARE v_CancelDate DATETIME;
   DECLARE v_Paid BOOLEAN;
   DECLARE v_AmountPaid DECIMAL(19,4);
   DECLARE v_TotalPurchase DECIMAL(19,4);
   DECLARE v_Posted BOOLEAN;
   DECLARE v_VendorID NATIONAL VARCHAR(50);

   DECLARE v_NewPurchaseOrderNumber NATIONAL VARCHAR(36);
   DECLARE v_NewPurchaseHasDetails BOOLEAN;
   DECLARE v_Result BOOLEAN;

   DECLARE v_ID CHAR(144);
   DECLARE v_ItemID NATIONAL VARCHAR(36);
   DECLARE v_ItemUnitPrice DECIMAL(19,4);
   DECLARE v_WarehouseID NATIONAL VARCHAR(36);
   DECLARE v_PurchaseWarehouseID NATIONAL VARCHAR(36);
   DECLARE v_Total DECIMAL(19,4);
   DECLARE v_OrderQty FLOAT;
   DECLARE v_ReceivedQty FLOAT;
   DECLARE v_UnReceivedQty FLOAT;
   DECLARE v_CurrencyID NATIONAL VARCHAR(3);
   DECLARE v_CompanyCurrencyID NATIONAL VARCHAR(3);
   DECLARE v_CurrencyExchangeRate FLOAT;

   DECLARE v_TotalUnReceivedPurchase DECIMAL(19,4);
   DECLARE v_TotalNewPurchase DECIMAL(19,4);
   DECLARE v_PurchaseLineNumber NUMERIC(18,0);
   DECLARE v_ErrorID INT;
   DECLARE NO_DATA INT DEFAULT 0;
   DECLARE v_Start INT;
   DECLARE v_Number INT;
   DECLARE cPurchaseDetail CURSOR FOR
   SELECT
   PurchaseNumber,
		PurchaseLineNumber,
		ItemID,
		IFNULL(ItemUnitPrice,0),
		WarehouseID,
		IFNULL(OrderQty,0),
		IFNULL(ReceivedQty,0),
		Total
   FROM
   PurchaseDetail
   WHERE
   CompanyID = v_CompanyID AND	
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   PurchaseNumber = v_PurchaseNumber And
   IFNULL(Received,0) <> 1;


   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN



      SET @SWV_Error = 1;
      SET NO_DATA = -2;
   END;
   DECLARE CONTINUE HANDLER FOR NOT FOUND SET NO_DATA = -1;
   IF v_Success is null then
      set v_Success = 0;
   END IF;
   SET @SWV_Error = 0;
   SET v_NewPurchaseHasDetails = 0;
   SET v_TotalNewPurchase = 0;
   SET v_Success = 0;

   IF NOT EXISTS(SELECT * FROM PurchaseDetail
   WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   PurchaseNumber = v_PurchaseNumber AND
   IFNULL(OrderQty,0) > IFNULL(ReceivedQty,0)) then
      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;
   end if;


   IF Not Exists(SELECT * FROM PurchaseDetail
   WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   PurchaseNumber = v_PurchaseNumber AND
   IFNULL(ReceivedQty,0) > 0) then
      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;
   end if;


   select   IFNULL(CurrencyID,N'') INTO v_CompanyCurrencyID FROM Companies WHERE CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID   LIMIT 1;

   START TRANSACTION;


   select   PurchaseCancelDate, IFNULL(Paid,0), VendorID, IFNULL(AmountPaid,0), IFNULL(Total,0), Posted, CurrencyID, CurrencyExchangeRate INTO v_CancelDate,v_Paid,v_VendorID,v_AmountPaid,v_TotalPurchase,v_Posted,v_CurrencyID,
   v_CurrencyExchangeRate FROM
   PurchaseHeader WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   PurchaseNumber = v_PurchaseNumber;	





   IF LOCATE('-',v_PurchaseNumber) = 0 then
	
      SET v_NewPurchaseOrderNumber = CONCAT(v_PurchaseNumber,'-1');
   ELSE
		
      SET v_Start = LOCATE('-',v_PurchaseNumber)+1;
      SET v_Number = cast(SUBSTRING(v_PurchaseNumber,v_Start,4) as SIGNED INTEGER);
      SET v_Number = v_Number+1;
      SET v_NewPurchaseOrderNumber = CONCAT(SUBSTRING(v_PurchaseNumber,1,v_Start -1),CAST(v_Number AS CHAR(4)));
   end if;




   OPEN cPurchaseDetail;
   SET NO_DATA = 0;
   FETCH cPurchaseDetail INTO v_ID,v_PurchaseLineNumber,v_ItemID,v_ItemUnitPrice,v_WarehouseID,v_OrderQty, 
   v_ReceivedQty,v_Total;

   WHILE NO_DATA = 0 DO
      IF v_OrderQty < v_ReceivedQty then
         SET v_ReceivedQty = v_OrderQty;
      end if;
      SET v_UnReceivedQty = v_OrderQty -v_ReceivedQty;
      IF v_UnReceivedQty > 0 then
	
		
         SET @SWV_Error = 0;
         INSERT INTO PurchaseDetail(CompanyID,
			DivisionID,
			DepartmentID,
			PurchaseNumber,
			ItemID,
			VendorItemID,
			Description,
			WarehouseID,
			WarehouseBinID,
			SerialNumber,
			OrderQty,
			ItemUOM,
			ItemWeight,
			DiscountPerc,
			Taxable,
			ItemCost,
			ItemUnitPrice,
			Total,
			TotalWeight,
			GLPurchaseAccount,
			ProjectID,
			Received,
			ReceivedDate,
			ReceivedQty,
			RecivingNumber,
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
         v_CompanyID,
				v_DivisionID,
				v_DepartmentID,
				v_NewPurchaseOrderNumber,
				ItemID,
				VendorItemID,
				Description,
				WarehouseID,
				WarehouseBinID,
				SerialNumber,
				v_UnReceivedQty,
				ItemUOM,
				ItemWeight,
				DiscountPerc,
				Taxable,
				ItemCost,
				ItemUnitPrice,
				v_TotalUnReceivedPurchase, 
				ItemWeight*v_UnReceivedQty, 
				GLPurchaseAccount,
				ProjectID,
				0, 
				NULL, 
				0, 
				NULL, 
				NULL, 
				DetailMemo1,
				DetailMemo2,
				DetailMemo3,
				DetailMemo4,
				DetailMemo5,
				TaxGroupID,
				0,
				TaxPercent,
				0 

         FROM
         PurchaseDetail
         WHERE
         CompanyID = v_CompanyID AND
         DivisionID = v_DivisionID AND
         DepartmentID = v_DepartmentID AND
         PurchaseNumber = v_ID AND
         PurchaseLineNumber = v_PurchaseLineNumber;
         IF @SWV_Error <> 0 then
		
            CLOSE cPurchaseDetail;
			
            SET v_ErrorMessage = 'Insert into PurchaseDetail failed';
            ROLLBACK;
            CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Purchase_Split',v_ErrorMessage,
            v_ErrorID);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseNumber',v_PurchaseNumber);
            SET SWP_Ret_Value = -1;
         end if;
      end if;
      IF v_ReceivedQty > 0 then
	  	
		
         SET v_TotalUnReceivedPurchase = fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,v_ItemUnitPrice*v_UnReceivedQty, 
         v_CompanyCurrencyID);
		
         SET v_TotalPurchase = v_TotalPurchase -v_TotalUnReceivedPurchase;
         SET v_TotalNewPurchase = v_TotalNewPurchase+v_TotalUnReceivedPurchase;
         SET v_Success = 1;

		
         SET @SWV_Error = 0;
         UPDATE
         PurchaseDetail
         SET
         OrderQty = v_ReceivedQty,Total = IFNULL(Total,0) -v_TotalUnReceivedPurchase
         WHERE
         CompanyID = v_CompanyID AND
         DivisionID = v_DivisionID AND
         DepartmentID = v_DepartmentID AND
         PurchaseNumber = v_ID AND
         PurchaseLineNumber = v_PurchaseLineNumber;
         IF @SWV_Error <> 0 then
		
            CLOSE cPurchaseDetail;
			
            SET v_ErrorMessage = 'Update PurchaseDetail failed';
            ROLLBACK;
            CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Purchase_Split',v_ErrorMessage,
            v_ErrorID);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseNumber',v_PurchaseNumber);
            SET SWP_Ret_Value = -1;
         end if;
      ELSE
         DELETE FROM
         PurchaseDetail
         WHERE
         CompanyID = v_CompanyID
         AND DivisionID = v_DivisionID
         AND DepartmentID = v_DepartmentID
         AND PurchaseNumber = v_ID
         AND PurchaseLineNumber = v_PurchaseLineNumber;
      end if;
	

    
      SET NO_DATA = 0;
      FETCH cPurchaseDetail INTO v_ID,v_PurchaseLineNumber,v_ItemID,v_ItemUnitPrice,v_WarehouseID,v_OrderQty, 
      v_ReceivedQty,v_Total;
   END WHILE;


   CLOSE cPurchaseDetail;




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
	PostedDate,
	OriginalPurchaseNumber,
	OriginalPurchaseDate)
   SELECT
   v_CompanyID,
		v_DivisionID,
		v_DepartmentID,
		v_NewPurchaseOrderNumber,
		TransactionTypeID,
		PurchaseDate,
		PurchaseDueDate,
		PurchaseShipDate,
		PurchaseCancelDate,
		PurchaseDateRequested,
		CURRENT_TIMESTAMP,
		OrderNumber,
		VendorInvoiceNumber,
		OrderedBy,
		TaxExemptID,
		TaxGroupID,
		VendorID,
		TermsID,
		CurrencyID,
		CurrencyExchangeRate,
		v_TotalNewPurchase,
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
		0,
		GLPurchaseAccount,
		0,
		0,
		0,
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
		0,
		NULL,
		0,
		NULL,
		NULL,
		0,
		NULL,
		NULL,
		Posted,
		PostedDate,
		v_PurchaseNumber,
		IFNULL(ReceivedDate,CURRENT_TIMESTAMP)
   FROM
   PurchaseHeader
   WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   PurchaseNumber = v_PurchaseNumber;					

   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Insert into PurchaseHeader failed';
      ROLLBACK;
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Purchase_Split',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseNumber',v_PurchaseNumber);
      SET SWP_Ret_Value = -1;
   end if;	


   CALL Purchase_Recalc2(v_CompanyID,v_DivisionID,v_DepartmentID,v_PurchaseNumber, v_ReturnStatus);
   IF v_ReturnStatus = -1 then

      SET v_ErrorMessage = 'Purchase_Recalc call failed';
      ROLLBACK;
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Purchase_Split',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseNumber',v_PurchaseNumber);
      SET SWP_Ret_Value = -1;
   end if;


   CALL Purchase_Recalc2(v_CompanyID,v_DivisionID,v_DepartmentID,v_NewPurchaseOrderNumber, v_ReturnStatus);
   IF v_ReturnStatus = -1 then

      SET v_ErrorMessage = 'Purchase_Recalc call failed';
      ROLLBACK;
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Purchase_Split',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseNumber',v_PurchaseNumber);
      SET SWP_Ret_Value = -1;
   end if;



   COMMIT;
   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;








   ROLLBACK;
   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Purchase_Split',v_ErrorMessage,
   v_ErrorID);

   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseNumber',v_PurchaseNumber);

   SET SWP_Ret_Value = -1;
END