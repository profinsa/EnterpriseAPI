CREATE PROCEDURE Order_Split (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_OrderNumber NATIONAL VARCHAR(36),INOUT SWP_Ret_Value INT) SWL_return:
BEGIN










   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);

   DECLARE v_CustomerID NATIONAL VARCHAR(36);
   DECLARE v_OrderTypeID NATIONAL VARCHAR(36);
   DECLARE v_AmountPaid DECIMAL(19,4);
   DECLARE v_Total DECIMAL(19,4);
   DECLARE v_OrderIsBackordered BOOLEAN;
   DECLARE v_OrderLineNumber NUMERIC(18,0);
   DECLARE v_ItemID NATIONAL VARCHAR(36);
   DECLARE v_OrderQty FLOAT; 
   DECLARE v_ItemUnitPrice DECIMAL(19,4);
   DECLARE v_ItemCost DECIMAL(19,4);
   DECLARE v_BackOrdered BOOLEAN;
   DECLARE v_BackOrderQyyty FLOAT;
   DECLARE v_DiscountPerc FLOAT;
   DECLARE v_Taxable BOOLEAN;
   DECLARE v_TotalDetail DECIMAL(19,4); 
   DECLARE v_WarehouseID NATIONAL VARCHAR(36);

   DECLARE v_TotalDetailOnHand DECIMAL(19,4);  
   DECLARE v_TotalDetailBackOrdered DECIMAL(19,4); 
   DECLARE v_TotalPaid DECIMAL(19,4); 
   DECLARE v_IsAmountPaidOver BOOLEAN; 
   DECLARE v_IsOrderDetailSplit BOOLEAN; 
   DECLARE v_QtyOldOrder FLOAT;
   DECLARE v_QtyNewOrder FLOAT;
   DECLARE v_IsNewOrderNeeded BOOLEAN;

   DECLARE v_OrderCancelDate DATETIME;
   DECLARE v_Result INT;


   DECLARE v_CancelOrderNumber NATIONAL VARCHAR(36);


   DECLARE v_ErrorID INT;
   DECLARE NO_DATA INT DEFAULT 0;
   DECLARE cOrderDetail CURSOR 
   FOR SELECT
   OrderLineNumber, 
		ItemID, 
		IFNULL(OrderQty,0),
		IFNULL(ItemUnitPrice,0), ItemCost,
		IFNULL(BackOrdered,0), 
		IFNULL(BackOrderQyyty,0),
		IFNULL(DiscountPerc,0), 
		IFNULL(Taxable,0), 
		IFNULL(Total,0),
		WarehouseID
   FROM 
   OrderDetail
   WHERE	
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND OrderNumber = v_OrderNumber;




   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
      SET NO_DATA = -2;
   END;
   DECLARE CONTINUE HANDLER FOR NOT FOUND SET NO_DATA = -1;
   SET @SWV_Error = 0;
   SET v_IsAmountPaidOver = 0;
   SET v_TotalPaid = 0;
   SET v_QtyOldOrder = 0;
   SET v_QtyNewOrder = 0;
   SET v_IsOrderDetailSplit = 0;

   START TRANSACTION; 

   SET @SWV_Error = 0;
   SET v_ReturnStatus = Order_Allocate2(v_CompanyID,v_DivisionID,v_DepartmentID,v_OrderNumber,v_Result);
   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then
	
      SET v_ErrorMessage = 'Order_Allocate failed';
      ROLLBACK;
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Order_Split',v_ErrorMessage,v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'OrderNumber',v_OrderNumber);
      SET SWP_Ret_Value = -1;
      LEAVE SWL_return;

   end if;

   select   CustomerID, OrderTypeID, IFNULL(AmountPaid,0), OrderCancelDate, IFNULL(Backordered,0), IFNULL(Total,0) INTO v_CustomerID,v_OrderTypeID,v_AmountPaid,v_OrderCancelDate,v_OrderIsBackordered,
   v_Total FROM
   OrderHeader WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND OrderNumber = v_OrderNumber;



   IF v_OrderIsBackordered = 0 then

      COMMIT;
      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;
   end if;



   SET v_IsNewOrderNeeded = 0;
   OPEN cOrderDetail;

   SET @SWV_Error = 0;
   SET NO_DATA = 0;
   FETCH cOrderDetail INTO
   v_OrderLineNumber,v_ItemID,v_OrderQty,v_ItemUnitPrice,v_ItemCost,v_BackOrdered,
   v_BackOrderQyyty,v_DiscountPerc,v_Taxable,v_TotalDetail,v_WarehouseID;




   IF @SWV_Error <> 0 then
	
      CLOSE cOrderDetail;
		
      SET v_ErrorMessage = 'Fetching from the order details cursor failed';
      ROLLBACK;
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Order_Split',v_ErrorMessage,v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'OrderNumber',v_OrderNumber);
      SET SWP_Ret_Value = -1;
      LEAVE SWL_return;

   end if;


   WHILE NO_DATA = 0 DO
      IF NOT (v_BackOrdered IS NULL) then
         IF v_BackOrdered = 1 then
            IF NOT (v_BackOrderQyyty IS NULL) then
               IF v_BackOrderQyyty > 0 then
                  IF v_OrderQty -v_BackOrderQyyty >= 0 then
                     SET v_IsNewOrderNeeded = 1;
                  end if;
               end if;
            end if;
         end if;
      end if;
      SET @SWV_Error = 0;
      SET NO_DATA = 0;
      FETCH cOrderDetail INTO
      v_OrderLineNumber,v_ItemID,v_OrderQty,v_ItemUnitPrice,v_ItemCost,v_BackOrdered,
      v_BackOrderQyyty,v_DiscountPerc,v_Taxable,v_TotalDetail,v_WarehouseID;
      IF @SWV_Error <> 0 then
		
         CLOSE cOrderDetail;
			
         SET v_ErrorMessage = 'Fetching from the order details cursor failed';
         ROLLBACK;
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Order_Split',v_ErrorMessage,v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'OrderNumber',v_OrderNumber);
         SET SWP_Ret_Value = -1;
         LEAVE SWL_return;

      end if;
   END WHILE;

   CLOSE cOrderDetail;

   IF v_IsNewOrderNeeded = 0 then

      CLOSE cOrderDetail;
	
      COMMIT;
      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;
   end if;



   SET @SWV_Error = 0;
   SET v_ReturnStatus = GetNextEntityID(v_CompanyID,v_DivisionID,v_DepartmentID,'NextOrderNumber',v_CancelOrderNumber);
   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then

      SET v_ErrorMessage = 'Getting the new order number failed';
      ROLLBACK;
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Order_Split',v_ErrorMessage,v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'OrderNumber',v_OrderNumber);
      SET SWP_Ret_Value = -1;
      LEAVE SWL_return;

   end if;


   OPEN cOrderDetail;

   SET @SWV_Error = 0;
   SET NO_DATA = 0;
   FETCH cOrderDetail INTO
   v_OrderLineNumber,v_ItemID,v_OrderQty,v_ItemUnitPrice,v_ItemCost,v_BackOrdered,
   v_BackOrderQyyty,v_DiscountPerc,v_Taxable,v_TotalDetail,v_WarehouseID;





   IF @SWV_Error <> 0 then
	
      CLOSE cOrderDetail;
		
      SET v_ErrorMessage = 'Fetching from the order details cursor failed';
      ROLLBACK;
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Order_Split',v_ErrorMessage,v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'OrderNumber',v_OrderNumber);
      SET SWP_Ret_Value = -1;
      LEAVE SWL_return;

   end if;



   WHILE NO_DATA = 0 DO
      IF NOT (v_BackOrdered IS NULL) then
         IF v_BackOrdered = 1 then
            IF NOT (v_BackOrderQyyty IS NULL) then
               IF v_BackOrderQyyty > 0 then
					
						
                  SET v_BackOrdered = 1;
						


                  SET @SWV_Error = 0;
                  INSERT INTO OrderDetail(CompanyID,
							DivisionID,
							DepartmentID,
							OrderNumber,
							ItemID,
							WarehouseID,
							WarehouseBinID,
							SerialNumber,
							OrderQty,
							BackOrdered,
							BackOrderQyyty,
							ItemUOM,
							ItemWeight,
							DiscountPerc,
							Taxable,
							ItemCost,
							ItemUnitPrice,
							Total,
							TotalWeight,
							GLSalesAccount,
							ProjectID,
							TaxGroupID,
							TaxAmount,
							TaxPercent,
							SubTotal)
                  SELECT
                  v_CompanyID,
							v_DivisionID,
							v_DepartmentID,
							v_CancelOrderNumber,
							ItemID,
							WarehouseID,
							WarehouseBinID,
							SerialNumber,
							v_BackOrderQyyty,
							v_BackOrdered,
							v_BackOrderQyyty,
							ItemUOM,
							ItemWeight,
							DiscountPerc,
							Taxable,
							ItemCost,
							ItemUnitPrice,
							v_BackOrderQyyty*ItemUnitPrice,
							0,
							GLSalesAccount,
							ProjectID,
							TaxGroupID,
							0,
							TaxPercent,
							0 
                  FROM
                  OrderDetail
                  WHERE
                  CompanyID = v_CompanyID
                  AND DivisionID = v_DivisionID
                  AND DepartmentID = v_DepartmentID
                  AND OrderNumber = v_OrderNumber
                  AND OrderLineNumber = v_OrderLineNumber;
                  IF @SWV_Error <> 0 OR ROW_COUNT() = 0 then
						
                     CLOSE cOrderDetail;
							
                     SET v_ErrorMessage = 'Creating the new order detail failed';
                     ROLLBACK;
                     CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Order_Split',v_ErrorMessage,v_ErrorID);
                     CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'OrderNumber',v_OrderNumber);
                     SET SWP_Ret_Value = -1;
                     LEAVE SWL_return;

                  end if;


						
						
                  SET @SWV_Error = 0;
                  IF v_OrderQty -v_BackOrderQyyty > 0 then
							
                     UPDATE
                     OrderDetail
                     SET
                     OrderQty = v_OrderQty -v_BackOrderQyyty,BackOrdered = 0,BackOrderQyyty = 0,Total = 0,
                     TotalWeight = 0,SubTotal = 0,TaxAmount = 0
                     WHERE
                     CompanyID = v_CompanyID
                     AND DivisionID = v_DivisionID
                     AND DepartmentID = v_DepartmentID
                     AND OrderNumber = v_OrderNumber
                     AND OrderLineNumber = v_OrderLineNumber;
                  ELSE
							
                     DELETE FROM
                     OrderDetail
                     WHERE
                     CompanyID = v_CompanyID
                     AND DivisionID = v_DivisionID
                     AND DepartmentID = v_DepartmentID
                     AND OrderNumber = v_OrderNumber
                     AND OrderLineNumber = v_OrderLineNumber;
                  end if;
                  IF @SWV_Error <> 0 then
						
                     CLOSE cOrderDetail;
							
                     SET v_ErrorMessage = 'Updating the order detail failed';
                     ROLLBACK;
                     CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Order_Split',v_ErrorMessage,v_ErrorID);
                     CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'OrderNumber',v_OrderNumber);
                     SET SWP_Ret_Value = -1;
                     LEAVE SWL_return;

                  end if;
               end if;
            end if;
         end if;
      end if;
      SET @SWV_Error = 0;
      SET NO_DATA = 0;
      FETCH cOrderDetail INTO
      v_OrderLineNumber,v_ItemID,v_OrderQty,v_ItemUnitPrice,v_ItemCost,v_BackOrdered,
      v_BackOrderQyyty,v_DiscountPerc,v_Taxable,v_TotalDetail,v_WarehouseID;
      IF @SWV_Error <> 0 then
		
         CLOSE cOrderDetail;
			
         SET v_ErrorMessage = 'Fetching from the order details cursor failed';
         ROLLBACK;
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Order_Split',v_ErrorMessage,v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'OrderNumber',v_OrderNumber);
         SET SWP_Ret_Value = -1;
         LEAVE SWL_return;

      end if;
   END WHILE;

   CLOSE cOrderDetail;





   SET @SWV_Error = 0;
   INSERT INTO OrderHeader(CompanyID,
	DivisionID,
	DepartmentID,
	OrderNumber,
	TransactionTypeID,
	OrderTypeID,
	OrderDate,
	OrderDueDate,
	OrderShipDate,
	OrderCancelDate,
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
	Commission,
	CommissionableSales,
	ComissionalbleCost,
	CustomerDropShipment,
	ShipMethodID,
	WarehouseID,
	ShipForID,
	ShipToID,
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
	Backordered,
	Shipped,
	ShipDate,
	TrackingNumber,
	Posted)
   SELECT
   CompanyID,
	DivisionID,
	DepartmentID,
	v_CancelOrderNumber,
	TransactionTypeID,
	OrderTypeID,
	CURRENT_TIMESTAMP,
	OrderDueDate,
	OrderShipDate,
	OrderCancelDate,
	CURRENT_TIMESTAMP,
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
	Commission,
	CommissionableSales,
	ComissionalbleCost,
	CustomerDropShipment,
	ShipMethodID,
	WarehouseID,
	ShipForID,
	ShipToID,
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
	0,
	BalanceDue,
	0,
	1,
	Shipped,
	ShipDate,
	TrackingNumber,
	1
   FROM
   OrderHeader
   WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   OrderNumber = v_OrderNumber;

   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Creating the new order header failed';
      ROLLBACK;
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Order_Split',v_ErrorMessage,v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'OrderNumber',v_OrderNumber);
      SET SWP_Ret_Value = -1;
      LEAVE SWL_return;

   end if;



   SET @SWV_Error = 0;
   SET v_ReturnStatus = Order_CreditCustomerAccount2(v_CompanyID,v_DivisionID,v_DepartmentID,v_CancelOrderNumber);

   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then

      SET v_ErrorMessage = 'Crediting the customer account failed';
      ROLLBACK;
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Order_Split',v_ErrorMessage,v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'OrderNumber',v_OrderNumber);
      SET SWP_Ret_Value = -1;
      LEAVE SWL_return;

   end if;


   SET @SWV_Error = 0;
   SET v_ReturnStatus = Order_Recalc(v_CompanyID,v_DivisionID,v_DepartmentID,v_CancelOrderNumber);
   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then

      SET v_ErrorMessage = 'Recalculating the new order failed';
      ROLLBACK;
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Order_Split',v_ErrorMessage,v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'OrderNumber',v_OrderNumber);
      SET SWP_Ret_Value = -1;
      LEAVE SWL_return;

   end if;


   IF(SELECT COUNT(*)
   FROM
   OrderDetail
   WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND OrderNumber = v_OrderNumber) > 0 then
	
      UPDATE
      OrderHeader
      SET
      Backordered = 0
      WHERE
      CompanyID = v_CompanyID AND
      DivisionID = v_DivisionID AND
      DepartmentID = v_DepartmentID AND
      OrderNumber = v_OrderNumber;

		
      SET @SWV_Error = 0;
      SET v_ReturnStatus = Order_Recalc(v_CompanyID,v_DivisionID,v_DepartmentID,v_OrderNumber);
      IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then
		
         SET v_ErrorMessage = 'Recalculating the old order failed';
         ROLLBACK;
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Order_Split',v_ErrorMessage,v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'OrderNumber',v_OrderNumber);
         SET SWP_Ret_Value = -1;
         LEAVE SWL_return;

      end if;
      COMMIT;
   ELSE
      COMMIT;
      SET SWP_Ret_Value =(-2147483648);
      LEAVE SWL_return;
   end if;


   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;







   ROLLBACK;
   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Order_Split',v_ErrorMessage,v_ErrorID);

   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'OrderNumber',v_OrderNumber);

   SET SWP_Ret_Value = -1;
   LEAVE SWL_return;



END