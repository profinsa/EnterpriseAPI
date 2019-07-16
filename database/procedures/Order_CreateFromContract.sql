CREATE PROCEDURE Order_CreateFromContract (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_OrderNumber NATIONAL VARCHAR(36),INOUT SWP_Ret_Value INT) SWL_return:
BEGIN







   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);

   DECLARE v_NewOrderNumber NATIONAL VARCHAR(36);
   DECLARE v_ErrorID INT;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
   END;
   SET @SWV_Error = 0;
   START TRANSACTION;

   SET @SWV_Error = 0;
   SET v_ReturnStatus = GetNextEntityID(v_CompanyID,v_DivisionID,v_DepartmentID,'NextOrderNumber',v_NewOrderNumber);

   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then



      SET v_ErrorMessage = 'GetNextEntityID call failed';
      ROLLBACK;


      CALL Error_InsertError(v_CompanyID,v_DivisionID,DepartmentID,'Order_CreateFromContract',v_ErrorMessage,
      v_ErrorID);
      SET SWP_Ret_Value = -1;
   end if;


   SET @SWV_Error = 0;
   INSERT INTO OrderHeader(CompanyID
      ,DivisionID
      ,DepartmentID
      ,OrderNumber
      ,TransactionTypeID
      ,OrderTypeID
      ,OrderDate
      ,OrderDueDate
      ,OrderShipDate
      ,OrderCancelDate
      ,SystemDate
      ,Memorize
      ,PurchaseOrderNumber
      ,TaxExemptID
      ,TaxGroupID
      ,CustomerID
      ,TermsID
      ,CurrencyID
      ,CurrencyExchangeRate
      ,Subtotal
      ,DiscountPers
      ,DiscountAmount
      ,TaxPercent
      ,TaxAmount
      ,TaxableSubTotal
      ,Freight
      ,TaxFreight
      ,Handling
      ,Advertising
      ,Total
      ,EmployeeID
      ,Commission
      ,CommissionableSales
      ,ComissionalbleCost
      ,CustomerDropShipment
      ,ShipMethodID
      ,WarehouseID
      ,ShipForID
      ,ShipToID
      ,ShippingName
      ,ShippingAddress1
      ,ShippingAddress2
      ,ShippingAddress3
      ,ShippingCity
      ,ShippingState
      ,ShippingZip
      ,ShippingCountry
      ,ScheduledStartDate
      ,ScheduledEndDate
      ,ServiceStartDate
      ,ServiceEndDate
      ,PerformedBy
      ,GLSalesAccount
      ,PaymentMethodID
      ,AmountPaid
      ,BalanceDue
      ,UndistributedAmount
      ,CheckNumber
      ,CheckDate
      ,CreditCardTypeID
      ,CreditCardName
      ,CreditCardNumber
      ,CreditCardExpDate
      ,CreditCardCSVNumber
      ,CreditCardBillToZip
      ,CreditCardValidationCode
      ,CreditCardApprovalNumber
      ,Backordered
      ,Picked
      ,PickedDate
      ,Printed
      ,PrintedDate
      ,Shipped
      ,ShipDate
      ,TrackingNumber
      ,Billed
      ,BilledDate
      ,Invoiced
      ,InvoiceNumber
      ,InvoiceDate
      ,Posted
      ,PostedDate
      ,AllowanceDiscountPerc
      ,CashTendered
      ,MasterBillOfLading
      ,MasterBillOfLadingDate
      ,TrailerNumber
      ,TrailerPrefix
      ,HeaderMemo1
      ,HeaderMemo2
      ,HeaderMemo3
      ,HeaderMemo4
      ,HeaderMemo5
      ,HeaderMemo6
      ,HeaderMemo7
      ,HeaderMemo8
      ,HeaderMemo9
      ,Approved
      ,ApprovedBy
      ,ApprovedDate
      ,EnteredBy
      ,Signature
      ,SignaturePassword
      ,SupervisorSignature
      ,SupervisorPassword
      ,ManagerSignature
      ,ManagerPassword
      ,LockedBy
      ,LockTS)
   SELECT
   v_CompanyID
	  ,v_DivisionID
	  ,v_DepartmentID
	  ,v_NewOrderNumber
	  ,'Order' 
      ,CASE WHEN OrderType = 'Contract' THEN 'Order' ELSE OrderType END 
      ,CURRENT_TIMESTAMP 
      ,TIMESTAMPADD(day,30,CURRENT_TIMESTAMP)
      ,NULL 
      ,TIMESTAMPADD(day,30,CURRENT_TIMESTAMP) 
      ,CURRENT_TIMESTAMP 
      ,0 
      ,NULL 
      ,TaxExemptID
      ,TaxGroupID
      ,CustomerID
      ,TermsID
      ,CurrencyID
      ,CurrencyExchangeRate
      ,Subtotal
      ,DiscountPers
      ,DiscountAmount
      ,TaxPercent
      ,TaxAmount
      ,TaxableSubTotal
      ,Freight
      ,TaxFreight
      ,Handling
      ,Advertising
      ,Total
      ,EmployeeID
      ,Commission
      ,CommissionableSales
      ,ComissionalbleCost
      ,CustomerDropShipment
      ,ShipMethodID
      ,WarehouseID
      ,ShipForID
      ,ShipToID
      ,ShippingName
      ,ShippingAddress1
      ,ShippingAddress2
      ,ShippingAddress3
      ,ShippingCity
      ,ShippingState
      ,ShippingZip
      ,ShippingCountry
      ,ScheduledStartDate
      ,ScheduledEndDate
      ,ServiceStartDate
      ,ServiceEndDate
      ,PerformedBy
      ,GLSalesAccount
      ,PaymentMethodID
      ,AmountPaid
      ,BalanceDue
      ,UndistributedAmount
      ,CheckNumber
      ,CheckDate
      ,CreditCardTypeID
      ,CreditCardName
      ,CreditCardNumber
      ,CreditCardExpDate
      ,CreditCardCSVNumber
      ,CreditCardBillToZip
      ,CreditCardValidationCode
      ,CreditCardApprovalNumber
      ,Backordered
      ,Picked
      ,PickedDate
      ,Printed
      ,PrintedDate
      ,Shipped
      ,ShipDate
      ,TrackingNumber
      ,Billed
      ,BilledDate
      ,Invoiced
      ,InvoiceNumber
      ,InvoiceDate
      ,Posted
      ,PostedDate
      ,AllowanceDiscountPerc
      ,CashTendered
      ,NULL 
      ,NULL 
      ,NULL 
      ,NULL 
      ,HeaderMemo1
      ,HeaderMemo2
      ,HeaderMemo3
      ,HeaderMemo4
      ,HeaderMemo5
      ,HeaderMemo6
      ,HeaderMemo7
      ,HeaderMemo8
      ,HeaderMemo9
      ,Approved
      ,ApprovedBy
      ,ApprovedDate
      ,EnteredBy
      ,Signature
      ,SignaturePassword
      ,SupervisorSignature
      ,SupervisorPassword
      ,ManagerSignature
      ,ManagerPassword
      ,NULL 
      ,NULL 
   FROM
   ContractsHeader
   WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   OrderNumber = v_OrderNumber;


   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'OrderHeader insert failed';
      ROLLBACK;


      CALL Error_InsertError(v_CompanyID,v_DivisionID,DepartmentID,'Order_CreateFromContract',v_ErrorMessage,
      v_ErrorID);
      SET SWP_Ret_Value = -1;
   end if;	


   SET @SWV_Error = 0;
   INSERT INTO OrderDetail(CompanyID, DivisionID, DepartmentID, OrderNumber,
	ItemID, WarehouseID, WarehouseBinID, SerialNumber, Description, OrderQty,
	BackOrdered, BackOrderQyyty, ItemUOM, ItemWeight, DiscountPerc,
	Taxable,  ItemCost, ItemUnitPrice,
	Total, TotalWeight, GLSalesAccount, ProjectID, TrackingNumber,
	TaxGroupID,
	TaxAmount,
	TaxPercent,
	SubTotal)
   SELECT
   v_CompanyID, v_DivisionID, v_DepartmentID, v_NewOrderNumber,
	ItemID, WarehouseID, WarehouseBinID, SerialNumber, Description, OrderQty,
	BackOrdered, BackOrderQty, ItemUOM, ItemWeight, DiscountPerc,
	Taxable,  ItemCost, ItemUnitPrice,
	Total, TotalWeight, GLSalesAccount, ProjectID, TrackingNumber,
	TaxGroupID,
	TaxAmount,
	TaxPercent,
	SubTotal
   FROM
   ContractsDetail
   WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   OrderNumber = v_OrderNumber;


   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'OrderDetail insert failed';
      ROLLBACK;


      CALL Error_InsertError(v_CompanyID,v_DivisionID,DepartmentID,'Order_CreateFromContract',v_ErrorMessage,
      v_ErrorID);
      SET SWP_Ret_Value = -1;
   end if;


   SET @SWV_Error = 0;
   SET v_ReturnStatus = Order_Post(v_CompanyID,v_DivisionID,v_DepartmentID,v_NewOrderNumber,v_ErrorMessage);

   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then

	
      ROLLBACK;


      CALL Error_InsertError(v_CompanyID,v_DivisionID,DepartmentID,'Order_CreateFromContract',v_ErrorMessage,
      v_ErrorID);
      SET SWP_Ret_Value = -1;
   end if;	


   COMMIT;
   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;








   ROLLBACK;


   CALL Error_InsertError(v_CompanyID,v_DivisionID,DepartmentID,'Order_CreateFromContract',v_ErrorMessage,
   v_ErrorID);

   SET SWP_Ret_Value = -1;
END