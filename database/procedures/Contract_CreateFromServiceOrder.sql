CREATE PROCEDURE Contract_CreateFromServiceOrder (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_OrderNumber NATIONAL VARCHAR(36),INOUT SWP_Ret_Value INT) SWL_return:
BEGIN















   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(36);

   DECLARE v_IDDetail NATIONAL VARCHAR(80);
   DECLARE v_OrderLineNumber INT;

   DECLARE v_ErrorID INT;
   DECLARE NO_DATA INT DEFAULT 0;
   DECLARE cOrderDetail CURSOR FOR
   SELECT
   ItemID,OrderLineNumber
   FROM
   OrderDetail
   WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   OrderNumber = v_OrderNumber;
		
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
      SET NO_DATA = -2;
   END;
   DECLARE CONTINUE HANDLER FOR NOT FOUND SET NO_DATA = -1;
   SET @SWV_Error = 0;
   START TRANSACTION;


   SET @SWV_Error = 0;
   INSERT INTO ContractsHeader(CompanyID, DivisionID, DepartmentID, OrderNumber,
	TransactionType, OrderType, OrderDate, OrderDueDate, OrderShipDate,
	OrderCancelDate, SystemDate, PurchaseOrderID, TaxExemptID, TaxGroupID,
	CustomerID, TermsID, CurrencyID, CurrencyExchangeRate, Subtotal, DiscountPers,
	DiscountAmount, TaxPercent, TaxAmount, TaxableSubTotal, Freight, TaxFreight,
	Handling, Advertising, Total, EmployeeID, Commission, ComissionalbleCost,
	CustomerDropShipment, ShipMethodID, WarehouseID, ShipForID,
	ShipToID, ShippingName, ShippingAddress1, ShippingAddress2, ShippingAddress3,
	ShippingCity, ShippingState, ShippingZip, ShippingCountry, GLSalesAccount,
	PaymentMethodID, AmountPaid, BalanceDue, UndistributedAmount)
   SELECT 
   v_CompanyID, v_DivisionID, v_DepartmentID, v_OrderNumber,
		'Contract', OrderTypeID, OrderDate, OrderDueDate, OrderShipDate,
		OrderCancelDate, CURRENT_TIMESTAMP, PurchaseOrderNumber, TaxExemptID, TaxGroupID,
		CustomerID, TermsID, CurrencyID, CurrencyExchangeRate, Subtotal, DiscountPers,
		DiscountAmount, TaxPercent, TaxAmount, TaxableSubTotal, Freight, TaxFreight,
		Handling, Advertising, Total, EmployeeID, Commission, ComissionalbleCost,
		CustomerDropShipment, ShipMethodID, WarehouseID, ShipForID,
		ShipToID, ShippingName, ShippingAddress1, ShippingAddress2, ShippingAddress3,
		ShippingCity, ShippingState, ShippingZip, ShippingCountry, GLSalesAccount,
		PaymentMethodID, AmountPaid, BalanceDue, UndistributedAmount
   FROM
   OrderHeader
   WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   OrderNumber = v_OrderNumber LIMIT 1; 


   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'OrderHeader insert failed';
      ROLLBACK;


      CALL Error_InsertError(v_CompanyID,v_DivisionID,DepartmentID,'Contract_CreateFromServiceOrder',
      v_ErrorMessage,v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'OrderNumber',v_OrderNumber);
      SET SWP_Ret_Value = -1;
   end if;	



   OPEN cOrderDetail;

   SET NO_DATA = 0;
   FETCH cOrderDetail INTO v_IDDetail,v_OrderLineNumber;

   WHILE NO_DATA = 0 DO	
	
      SET @SWV_Error = 0;
      INSERT INTO ContractsDetail(CompanyID, DivisionID, DepartmentID, OrderNumber,
		ItemID, WarehouseID, SerialNumber, Description, OrderQty,
		BackOrdered, BackOrderQty, ItemUOM, ItemWeight, DiscountPerc,
		Taxable, ItemCost, ItemUnitPrice,
		Total, TotalWeight, GLSalesAccount, ProjectID, TrackingNumber)
      SELECT
      v_CompanyID, v_DivisionID, v_DepartmentID, v_OrderNumber,
		ItemID, WarehouseID, SerialNumber, Description, OrderQty,
		BackOrdered, BackOrderQyyty, ItemUOM, ItemWeight, DiscountPerc,
		Taxable, ItemCost, ItemUnitPrice,
		Total, TotalWeight, GLSalesAccount, ProjectID, TrackingNumber
      FROM
      OrderDetail
      WHERE
      CompanyID = v_CompanyID AND
      DivisionID = v_DivisionID AND
      DepartmentID = v_DepartmentID AND
      ItemID = v_IDDetail AND
      OrderNumber = v_OrderNumber AND
      OrderLineNumber = v_OrderLineNumber;


	
      IF @SWV_Error <> 0 then
	
         CLOSE cOrderDetail;
		
         SET v_ErrorMessage = 'OrderDetail insert failed';
         ROLLBACK;


         CALL Error_InsertError(v_CompanyID,v_DivisionID,DepartmentID,'Contract_CreateFromServiceOrder',
         v_ErrorMessage,v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'OrderNumber',v_OrderNumber);
         SET SWP_Ret_Value = -1;
      end if;
      SET NO_DATA = 0;
      FETCH cOrderDetail INTO v_IDDetail,v_OrderLineNumber;
   END WHILE;

   CLOSE cOrderDetail;



   COMMIT;
   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;








   ROLLBACK;


   CALL Error_InsertError(v_CompanyID,v_DivisionID,DepartmentID,'Contract_CreateFromServiceOrder',
   v_ErrorMessage,v_ErrorID);

   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'OrderNumber',v_OrderNumber);

   SET SWP_Ret_Value = -1;
END