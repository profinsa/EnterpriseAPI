update databaseinfo set value='2019_07_03',lastupdate=now() WHERE id='Version';

DELIMITER //
DROP PROCEDURE IF EXISTS Order_Post2;
//
CREATE                 PROCEDURE Order_Post2(v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_OrderNumber NATIONAL VARCHAR(36),
	INOUT v_PostingResult NATIONAL VARCHAR(200) ,INOUT SWP_Ret_Value INT)
   SWL_return:
BEGIN




/*
Name of stored procedure: Order_Post
Method:
	this procedure makes all the arrangement for an order to be posted and post it
Date Created: EDE - 07/28/2015
Input Parameters:
	@CompanyID NVARCHAR(36)		 - the ID of the company
	@DivisionID NVARCHAR(36)	 - the ID of the division
	@DepartmentID NVARCHAR(36)	 - the ID of the department
	@OrderNumber NVARCHAR(36)	 - the order number
Output Parameters:
	@PostingResult NVARCHAR(200)	 - error message that should be displayed for end user
Called From:
	Contract_CreateOrder, EDI_OrderProcessingInbound, Order_CreateFromQuote, Order_CreateFromContract, Order_Post.vb
Calls:
	Error_InsertError, Inventory_GetWarehouseForOrderItem, SerialNumber_Get, Order_CreditCustomerAccount, OrderDetail_SplitToWarehouseBin, Order_Recalc, Order_CreateAssembly, Error_InsertErrorDetail, Terms_GetNetDays, Order_MakeInvoiceReceipt
Last Modified:
Last Modified By:
Revision History:
*/
   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);
   DECLARE v_CustomerID NATIONAL VARCHAR(36);
   DECLARE v_OrderTypeID NATIONAL VARCHAR(36);
   DECLARE v_OrderLineNumber NUMERIC(18,0);
   DECLARE v_ItemID NATIONAL VARCHAR(36);
   DECLARE v_QtyOnHand INT;
   DECLARE v_OrderQty FLOAT;
   DECLARE v_AvailableQty INT;
   DECLARE v_DifferenceQty INT;
   DECLARE v_FlipBackOrderFlag BOOLEAN;
   DECLARE v_AmountPaid DECIMAL(19,4);
   DECLARE v_PaymentMethodID NATIONAL VARCHAR(36);
   DECLARE v_Posted BOOLEAN;
   DECLARE v_OrderCancelDate DATETIME;
   DECLARE v_HighestCredit DECIMAL(19,4);
   DECLARE v_AvailibleCredit DECIMAL(19,4);
   DECLARE v_OrderAmount DECIMAL(19,4);
   DECLARE v_WarehouseID NATIONAL VARCHAR(36);
   DECLARE v_WarehouseBinID NATIONAL VARCHAR(36);
   DECLARE v_SerialNumber NATIONAL VARCHAR(50);
   DECLARE v_CompanyCurrencyID NATIONAL VARCHAR(3);
   DECLARE v_ShipToID NATIONAL VARCHAR(36);
   DECLARE v_ShipToName NATIONAL VARCHAR(50);
   DECLARE v_ShipToAddress1 NATIONAL VARCHAR(50);
   DECLARE v_ShipToAddress2 NATIONAL VARCHAR(50);
   DECLARE v_ShipToAddress3 NATIONAL VARCHAR(50);
   DECLARE v_ShipToCity NATIONAL VARCHAR(50);
   DECLARE v_ShipToState NATIONAL VARCHAR(50);
   DECLARE v_ShipToZip NATIONAL VARCHAR(50);
   DECLARE v_ShipToCountry NATIONAL VARCHAR(50);
   DECLARE v_TermsID NATIONAL VARCHAR(36);
   DECLARE v_Result INT;
   DECLARE v_NetDays INT;
   DECLARE v_ErrorID INT;
   DECLARE NO_DATA INT DEFAULT 0;
   DECLARE cOrderDetail CURSOR 
   FOR SELECT
   OrderLineNumber,
		ItemID,
		IFNULL(OrderQty,0),
		WarehouseID,
		WarehouseBinID,
		SerialNumber
   FROM
   OrderDetail
   WHERE	
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND OrderNumber = v_OrderNumber;
-- open the cursor and get the first row
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
      SET NO_DATA = -2;
   END;
   DECLARE CONTINUE HANDLER FOR NOT FOUND SET NO_DATA = -1;
   SET @SWV_Error = 0;
   IF NOT EXISTS(SELECT * FROM
   OrderDetail
   WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   OrderNumber = v_OrderNumber) then

      SET v_PostingResult = 'Order was not posted: there are no detail items';
      SET SWP_Ret_Value = -1;
      LEAVE SWL_return;
   end if;
   IF EXISTS(SELECT * FROM
   OrderDetail
   WHERE
   IFNULL(OrderQty,0) = 0 AND
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   OrderNumber = v_OrderNumber) then

      SET v_PostingResult = 'Order was not posted: there is the detail item with undefined Order Qty value';
      SET SWP_Ret_Value = -1;
      LEAVE SWL_return;
   end if;
-- get the information about Customer, Order type, amount paid, payment method,
-- post status of the order, order cancel date and order amount
-- from the order header table for the company, division, department and
-- order specified in the procedure parameters
   select   CustomerID, OrderTypeID, IFNULL(AmountPaid,0), PaymentMethodID, IFNULL(Posted,0), OrderCancelDate, IFNULL(Total,0), TermsID INTO v_CustomerID,v_OrderTypeID,v_AmountPaid,v_PaymentMethodID,v_Posted,v_OrderCancelDate,
   v_OrderAmount,v_TermsID FROM
   OrderHeader WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND OrderNumber = v_OrderNumber;
-- if the order is already posted we simply exit
   IF v_Posted = 1 then

      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;
   end if;
-- If order type is quote, do nothing, just exit
   IF LOWER(v_OrderTypeID) = LOWER('Quote') then

      SET v_PostingResult = 'The Quote can''t be posted';
      SET SWP_Ret_Value = -1;
      LEAVE SWL_return;
   end if;
-- If the order is canceled I can't post it
   IF v_OrderCancelDate < CURRENT_TIMESTAMP then

      SET v_PostingResult = 'The order was not posted: Cancel date is older then current date.';
      SET SWP_Ret_Value = -1;
      LEAVE SWL_return;
   end if;
   START TRANSACTION;
-- Check order on Hold status
-- recalculate the order to be sure that it has correct total
-- EXEC @ReturnStatus = Order_RecalcCLR @CompanyID, @DivisionID, @DepartmentID, @OrderNumber
   SET @SWV_Error = 0;
   CALL Order_Recalc2(v_CompanyID,v_DivisionID,v_DepartmentID,v_OrderNumber, v_ReturnStatus);
   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then

      SET v_ErrorMessage = 'Recalculating the order failed';
      ROLLBACK;
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Order_Post',v_ErrorMessage,v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'OrderNumber',v_OrderNumber);
      SET v_PostingResult = CONCAT('Order was not posted:',v_ErrorMessage);
      SET SWP_Ret_Value = -1;
   end if;
   select   fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,IFNULL(Total,0)*IFNULL(CurrencyExchangeRate,1), 
   v_CompanyCurrencyID) INTO v_OrderAmount FROM
   OrderHeader WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND OrderNumber = v_OrderNumber;
   select   IFNULL(CurrencyID,N'') INTO v_CompanyCurrencyID FROM Companies WHERE CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID   LIMIT 1;
   SET v_OrderAmount = fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,v_OrderAmount,v_CompanyCurrencyID);
-- get the informations about highest credit and avaible credit
-- from the customer financials table
   select   IFNULL(HighestCredit,0), IFNULL(AvailibleCredit,0) INTO v_HighestCredit,v_AvailibleCredit FROM
   CustomerFinancials WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   CustomerID = v_CustomerID;
-- If customer has insufficent credit move order to Hold status and return from procedure
   IF v_AvailibleCredit -v_OrderAmount < 0 then

	-- recalc available credit to be sure that order should be moved on hold
      SET @SWV_Error = 0;
      CALL Order_RecalcCustomerCredit2(v_CompanyID,v_DivisionID,v_DepartmentID,v_CustomerID,v_AvailibleCredit, v_ReturnStatus);
      IF @SWV_Error <> 0 OR  v_ReturnStatus = -1 then
	
         SET v_ErrorMessage = 'OrderRecalcCustomerCredit failed';
         ROLLBACK;
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Order_Post',v_ErrorMessage,v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'OrderNumber',v_OrderNumber);
         SET v_PostingResult = CONCAT('Order was not posted:',v_ErrorMessage);
         SET SWP_Ret_Value = -1;
      end if;
      IF v_AvailibleCredit -v_OrderAmount < 0 then
	
         SET @SWV_Error = 0;
         UPDATE
         OrderHeader
         SET
         OrderTypeID = 'Hold'
         WHERE
         CompanyID = v_CompanyID AND
         DivisionID = v_DivisionID AND
         DepartmentID = v_DepartmentID AND
         OrderNumber = v_OrderNumber;
         IF @SWV_Error <> 0 then
		
            SET v_ErrorMessage = 'Order Type updating  failed';
            ROLLBACK;
            CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Order_Post',v_ErrorMessage,v_ErrorID);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'OrderNumber',v_OrderNumber);
            SET v_PostingResult = CONCAT('Order was not posted:',v_ErrorMessage);
            SET SWP_Ret_Value = -1;
         end if;
         COMMIT;
         SET v_PostingResult = 'Order is moved to On Hold Orders';
         SET SWP_Ret_Value = 1;
         LEAVE SWL_return;
      end if;
   end if;
-- debit the inventory
-- set the flag for back orders to 0
   SET v_FlipBackOrderFlag = 0;
-- declare a cursor to iterate through the order's items
   OPEN cOrderDetail;
   SET NO_DATA = 0;
   FETCH cOrderDetail INTO v_OrderLineNumber,v_ItemID,v_OrderQty,v_WarehouseID,v_WarehouseBinID,v_SerialNumber;
   WHILE NO_DATA = 0 DO
      SET v_FlipBackOrderFlag = 0;
      SET v_DifferenceQty = 0;
      SET v_QtyOnHand = 0;
      SET v_AvailableQty = 0;
-- get the @WarehouseID for the order
      SET @SWV_Error = 0;
      CALL Inventory_GetWarehouseForOrderItem(v_CompanyID,v_DivisionID,v_DepartmentID,v_OrderNumber,v_OrderLineNumber,
      v_WarehouseID,v_WarehouseBinID, v_ReturnStatus);
      IF @SWV_Error <> 0 OR  v_ReturnStatus = -1 then
	
         CLOSE cOrderDetail;
		
         SET v_ErrorMessage = 'Getting the WarehouseID failed';
         ROLLBACK;
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Order_Post',v_ErrorMessage,v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'OrderNumber',v_OrderNumber);
         SET v_PostingResult = CONCAT('Order was not posted:',v_ErrorMessage);
         SET SWP_Ret_Value = -1;
      end if;
      select   IFNULL(SUM(IFNULL(QtyOnHand,0)),0) INTO v_QtyOnHand FROM
      InventoryByWarehouse WHERE
      CompanyID = v_CompanyID
      AND DivisionID = v_DivisionID
      AND DepartmentID = v_DepartmentID
      AND WarehouseID = v_WarehouseID
      AND ItemID = v_ItemID;

      IF v_OrderQty < v_QtyOnHand then -- there is enough quantity in the warehouse
		
         SET v_AvailableQty = v_QtyOnHand;
         SET v_DifferenceQty = v_QtyOnHand - v_OrderQty;
--         SET v_DifferenceQty = v_OrderQty -v_QtyOnHand;
		
			-- verify if the item is an assembly and if the assembly can be created
			-- from items existing in the warehouses
         SET @SWV_Error = 0;
--         CALL Order_CreateAssembly(v_CompanyID,v_DivisionID,v_DepartmentID,v_ItemID,v_WarehouseID,v_DifferenceQty,
--         v_Result, v_ReturnStatus);
         CALL Order_CreateAssembly(v_CompanyID,v_DivisionID,v_DepartmentID,v_ItemID,v_WarehouseID,v_OrderQty,
         v_Result, v_ReturnStatus);
			-- check for errors
         IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then
			
            CLOSE cOrderDetail;
				
            -- NOT SUPPORTED Print CONCAT('ItemID: ',convert(CHAR(20),@ItemID),' OrderQty: ', convert(CHAR(20),@OrderQty))
SET v_ErrorMessage = 'Order_CreateAssembly call failed';
            ROLLBACK;
            CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Order_Post',v_ErrorMessage,v_ErrorID);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'OrderNumber',v_OrderNumber);
            SET v_PostingResult = CONCAT('Order was not posted:',v_ErrorMessage);
            SET SWP_Ret_Value = -1;
         end if;
      end if;
      SET NO_DATA = 0;
      FETCH cOrderDetail INTO v_OrderLineNumber,v_ItemID,v_OrderQty,v_WarehouseID,v_WarehouseBinID,v_SerialNumber;
   END WHILE;
   CLOSE cOrderDetail;
   SET @SWV_Error = 0;
   CALL OrderDetail_SplitToWarehouseBin2(v_CompanyID,v_DivisionID,v_DepartmentID,v_OrderNumber,0,v_FlipBackOrderFlag, v_ReturnStatus);
   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then
	
      SET v_ErrorMessage = 'OrderDetail_SplitToWarehouseBin failed';
      ROLLBACK;
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Order_Post',v_ErrorMessage,v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'OrderNumber',v_OrderNumber);
      SET v_PostingResult = CONCAT('Order was not posted:',v_ErrorMessage);
      SET SWP_Ret_Value = -1;
   end if;
-- open the cursor and get the first row
   OPEN cOrderDetail;
   SET NO_DATA = 0;
   FETCH cOrderDetail INTO v_OrderLineNumber,v_ItemID,v_OrderQty,v_WarehouseID,v_WarehouseBinID,v_SerialNumber;
   WHILE NO_DATA = 0 DO
      SET @SWV_Error = 0;
      CALL SerialNumber_Get2(v_CompanyID,v_DivisionID,v_DepartmentID,v_WarehouseID,v_WarehouseBinID,
      v_SerialNumber,v_ItemID,v_OrderNumber,v_OrderLineNumber,NULL,NULL,v_OrderQty, v_ReturnStatus);
      IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then
	
         CLOSE cOrderDetail;
		
         SET v_ErrorMessage = 'SerialNumber_Get failed';
         ROLLBACK;
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Order_Post',v_ErrorMessage,v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'OrderNumber',v_OrderNumber);
         SET v_PostingResult = CONCAT('Order was not posted:',v_ErrorMessage);
         SET SWP_Ret_Value = -1;
      end if;
      SET NO_DATA = 0;
      FETCH cOrderDetail INTO v_OrderLineNumber,v_ItemID,v_OrderQty,v_WarehouseID,v_WarehouseBinID,v_SerialNumber;
   END WHILE;
   CLOSE cOrderDetail;

-- Next step: Check special terms, and fill this into the terms amount on the order
   IF v_TermsID IS NULL then

      select   TermsID INTO v_TermsID FROM
      CustomerInformation WHERE
      CustomerInformation.CompanyID = v_CompanyID
      AND CustomerInformation.DivisionID = v_DivisionID
      AND CustomerInformation.DepartmentID = v_DepartmentID
      AND CustomerInformation.CustomerID = v_CustomerID;
   end if;
   SET @SWV_Error = 0;
   CALL Terms_GetNetDays2(v_CompanyID,v_DivisionID,v_DepartmentID,v_TermsID,v_NetDays);
   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Terms_GetNetDays the order failed';
      ROLLBACK;
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Order_Post',v_ErrorMessage,v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'OrderNumber',v_OrderNumber);
      SET v_PostingResult = CONCAT('Order was not posted:',v_ErrorMessage);
      SET SWP_Ret_Value = -1;
   end if;
   SET @SWV_Error = 0;
   UPDATE OrderHeader
   SET
   OrderHeader.TermsID = v_TermsID,OrderHeader.OrderDueDate = TIMESTAMPADD(Day,v_NetDays,IFNULL(OrderDate,CURRENT_TIMESTAMP)),OrderHeader.OrderDate = IFNULL(OrderDate,CURRENT_TIMESTAMP)
   WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND OrderNumber = v_OrderNumber;
   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Checking special terms failed';
      ROLLBACK;
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Order_Post',v_ErrorMessage,v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'OrderNumber',v_OrderNumber);
      SET v_PostingResult = CONCAT('Order was not posted:',v_ErrorMessage);
      SET SWP_Ret_Value = -1;
   end if;
-- If there is no inventory for any of the items on the order, flip the backorder flag
   IF v_FlipBackOrderFlag = 1 then

      SET @SWV_Error = 0;
      UPDATE
      OrderHeader
      SET
      Backordered = 1
      WHERE
      CompanyID = v_CompanyID
      AND DivisionID = v_DivisionID
      AND DepartmentID = v_DepartmentID
      AND OrderNumber = v_OrderNumber;
      IF @SWV_Error <> 0 then
	
         SET v_ErrorMessage = 'Updating order header (backordering) failed';
         ROLLBACK;
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Order_Post',v_ErrorMessage,v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'OrderNumber',v_OrderNumber);
         SET v_PostingResult = CONCAT('Order was not posted:',v_ErrorMessage);
         SET SWP_Ret_Value = -1;
      end if;
      SET v_PostingResult = 'Order is moved to Backorders list ';
   end if;
-- Properly credit the customer account ->
   SET @SWV_Error = 0;
   CALL Order_CreditCustomerAccount(v_CompanyID,v_DivisionID,v_DepartmentID,v_OrderNumber, v_ReturnStatus);
   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then

      SET v_ErrorMessage = 'Crediting the customer account failed';
      ROLLBACK;
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Order_Post',v_ErrorMessage,v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'OrderNumber',v_OrderNumber);
      SET v_PostingResult = CONCAT('Order was not posted:',v_ErrorMessage);
      SET SWP_Ret_Value = -1;
   end if;
-- get the ship informations for the order
-- from the order header
   select   IFNULL(ShipToID,''), IFNULL(ShippingName,''), IFNULL(ShippingAddress1,''), IFNULL(ShippingAddress2,''), IFNULL(ShippingAddress3,''), IFNULL(ShippingCity,''), IFNULL(ShippingState,''), IFNULL(ShippingZip,''), IFNULL(ShippingCountry,''), CustomerID INTO v_ShipToID,v_ShipToName,v_ShipToAddress1,v_ShipToAddress2,v_ShipToAddress3,
   v_ShipToCity,v_ShipToState,v_ShipToZip,v_ShipToCountry,v_CustomerID FROM
   OrderHeader WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND OrderNumber = v_OrderNumber;
   IF (LOWER(v_ShipToID) = LOWER('SAME')) then
-- use informations from Customer table

      SET @SWV_Error = 0;
      UPDATE CustomerInformation INNER JOIN OrderHeader ON
      CustomerInformation.CompanyID = OrderHeader.CompanyID AND
      CustomerInformation.DivisionID = OrderHeader.DivisionID AND
      CustomerInformation.DepartmentID = OrderHeader.DepartmentID AND
      CustomerInformation.CustomerID = OrderHeader.CustomerID
      SET
      OrderHeader.ShipToID = CustomerInformation.ShipMethodID,OrderHeader.ShippingName = CustomerInformation.CustomerName,
      OrderHeader.ShippingAddress1 = CustomerInformation.CustomerAddress1,
      OrderHeader.ShippingAddress2 = CustomerInformation.CustomerAddress2,
      OrderHeader.ShippingAddress3 = CustomerInformation.CustomerAddress3,
      OrderHeader.ShippingCity = CustomerInformation.CustomerCity,
      OrderHeader.ShippingState = CustomerInformation.CustomerState,
      OrderHeader.ShippingZip = CustomerInformation.CustomerZip,
      OrderHeader.ShippingCountry = CustomerInformation.CustomerCountry
      WHERE
      OrderHeader.CompanyID = v_CompanyID AND
      OrderHeader.DivisionID = v_DivisionID AND
      OrderHeader.DepartmentID = v_DepartmentID AND
      OrderHeader.OrderNumber = v_OrderNumber;
      IF @SWV_Error <> 0 then
	
         SET v_ErrorMessage = 'Update OrderHeader failed';
         ROLLBACK;
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Order_Post',v_ErrorMessage,v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'OrderNumber',v_OrderNumber);
         SET v_PostingResult = CONCAT('Order was not posted:',v_ErrorMessage);
         SET SWP_Ret_Value = -1;
      end if;
   ELSE
      IF(LOWER(v_ShipToID) = LOWER('Drop Ship')) then
	-- check if the ship information is completed and if not return error
	
         IF (v_ShipToID = '' OR v_ShipToName = '' OR
			(v_ShipToAddress1 = '' AND v_ShipToAddress2 = '' AND v_ShipToAddress3 = '') OR
         v_ShipToCity = '' OR (v_ShipToState = '' AND v_ShipToCountry = '')) then
		
            SET v_ErrorMessage = 'Ship information is not completed';
            ROLLBACK;
            CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Order_Post',v_ErrorMessage,v_ErrorID);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'OrderNumber',v_OrderNumber);
            SET v_PostingResult = CONCAT('Order was not posted:',v_ErrorMessage);
            SET SWP_Ret_Value = -1;
         end if;
      ELSE
         SET @SWV_Error = 0;
         UPDATE CustomerShipToLocations INNER JOIN OrderHeader ON
         CustomerShipToLocations.CompanyID = OrderHeader.CompanyID AND
         CustomerShipToLocations.DivisionID = OrderHeader.DivisionID AND
         CustomerShipToLocations.DepartmentID = OrderHeader.DepartmentID AND
         CustomerShipToLocations.CustomerID = OrderHeader.CustomerID
         SET
         OrderHeader.ShipToID = CustomerShipToLocations.ShipToID,OrderHeader.ShippingName = CustomerShipToLocations.ShipToName,
         OrderHeader.ShippingAddress1 = CustomerShipToLocations.ShipToAddress1,OrderHeader.ShippingAddress2 = CustomerShipToLocations.ShipToAddress2,OrderHeader.ShippingAddress3 = CustomerShipToLocations.ShipToAddress3,OrderHeader.ShippingCity = CustomerShipToLocations.ShipToCity,
         OrderHeader.ShippingState = CustomerShipToLocations.ShipToState,
         OrderHeader.ShippingZip = CustomerShipToLocations.ShipToZip,
         OrderHeader.ShippingCountry = CustomerShipToLocations.ShipToZip
         WHERE
         OrderHeader.CompanyID = v_CompanyID AND
         OrderHeader.DivisionID = v_DivisionID AND
         OrderHeader.DepartmentID = v_DepartmentID AND
         OrderHeader.OrderNumber = v_OrderNumber
         AND (CustomerShipToLocations.ShipToID = v_ShipToID);
         IF @SWV_Error <> 0 then
		
            SET v_ErrorMessage = 'Update OrderHeader failed';
            ROLLBACK;
            CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Order_Post',v_ErrorMessage,v_ErrorID);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'OrderNumber',v_OrderNumber);
            SET v_PostingResult = CONCAT('Order was not posted:',v_ErrorMessage);
            SET SWP_Ret_Value = -1;
         end if;
      end if;
   end if;
-- set the Posted flag to true and set the PostedDate
   SET @SWV_Error = 0;
   UPDATE
   OrderHeader
   SET
   Posted = 1,PostedDate = CURRENT_TIMESTAMP
   WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND OrderNumber = v_OrderNumber;
   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Setting the posted flag failed';
      ROLLBACK;
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Order_Post',v_ErrorMessage,v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'OrderNumber',v_OrderNumber);
      SET v_PostingResult = CONCAT('Order was not posted:',v_ErrorMessage);
      SET SWP_Ret_Value = -1;
   end if;
-- Is the order payed\?
   SET @SWV_Error = 0;
   IF v_AmountPaid = 0 then

-- success we return without making any invoice or receipt
      COMMIT;
      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;
-- The @AmountPayed is not zero, so do the necessary work
   ELSE 
      CALL Order_MakeInvoiceReceipt(v_CompanyID,v_DivisionID,v_DepartmentID,v_OrderNumber, v_ReturnStatus);
   end if;
   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then

      SET v_ErrorMessage = 'Making the invoice receipt failed';
      ROLLBACK;
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Order_Post',v_ErrorMessage,v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'OrderNumber',v_OrderNumber);
      SET v_PostingResult = CONCAT('Order was not posted:',v_ErrorMessage);
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
   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Order_Post',v_ErrorMessage,v_ErrorID);
   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'OrderNumber',v_OrderNumber);
   SET v_PostingResult = CONCAT('Order was not posted:',v_ErrorMessage);
   SET SWP_Ret_Value = -1;
END;






//

DELIMITER ;

DELIMITER //
DROP PROCEDURE IF EXISTS Order_CreateAssembly;
//
CREATE   PROCEDURE Order_CreateAssembly(v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_ItemID NATIONAL VARCHAR(36),
	v_WarehouseID NATIONAL VARCHAR(36),
	v_QtyRequired INT,
	INOUT v_Result INT  ,INOUT SWP_Ret_Value INT)
   SWL_return:
BEGIN




















/*
Name of stored procedure: Order_CreateAssembly
Method: 
	The procedure checkes to see if the item is an assembly. 
	If it is an assembly, it will check to see if there are enough parts in inventory to ALTER  the item. 
	If there are, then the order will ALTER  the assembly and allocate the order to it, 
	and properly adjust the inventory and costs just like a regular assembly creation

Date Created: EDE - 07/28/2015

Input Parameters:

	@CompanyID NVARCHAR(36)		 - the ID of the company
	@DivisionID NVARCHAR(36)	 - the ID of the division
	@DepartmentID NVARCHAR(36)	 - the ID of the department
	@ItemID NVARCHAR(36)		 - the ID item to be checked if it is an assembly and 

						   if it is to ALTER  it
	@WarehouseID NVARCHAR(36)	 - warehouse ID from which items should be taken from
	@QtyRequired INT		 - the quantity required

Output Parameters:

	@Result INT  			 - Return values (@Result)

							   1	the operation completed successfuly

							   0	the operation failed

Called From:

	Return_Post, Purchase_CreateFromBackOrders, Purchase_CreateFromOrder, Order_Post, Purchase_CreateFromReorder

Calls:

	Inventory_Assemblies, Error_InsertError, Error_InsertErrorDetail

Last Modified: 

Last Modified By: 

Revision History: 

*/

   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);

   DECLARE v_NumberOfItems SMALLINT;

   DECLARE v_ErrorID INT;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
--       GET DIAGNOSTICS CONDITION 1
--       @p1 = RETURNED_SQLSTATE, @p2 = MESSAGE_TEXT;
--       SELECT @p1, @p2;
       SET @SWV_Error = 1;
   END;
   SET @SWV_Error = 0;
   SET v_Result = 1;
   SET v_NumberOfItems = 0;

-- search the itemID to see if the item is an assembly
   select   COUNT(*) INTO v_NumberOfItems FROM
   InventoryAssemblies WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   AssemblyID = v_ItemID;

-- if the item is not an assembly return
   IF v_NumberOfItems = 0 then

      SET v_Result = 0;
      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;
   end if;
   START TRANSACTION;
-- if the item is an assembly create the requested quantity
   SET @SWV_Error = 0;
   CALL Inventory_Assemblies(v_CompanyID,v_DivisionID,v_DepartmentID,v_ItemID,v_WarehouseID,v_QtyRequired,
   v_Result, v_ReturnStatus);

-- check for errors in execution
   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then

      SET v_Result = 0;
      SET v_ErrorMessage = 'Inventory_Assemblies call failed';
      ROLLBACK;
      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Order_CreateAssembly',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'ItemID',v_ItemID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'QtyRequired',v_QtyRequired);
      SET SWP_Ret_Value = -1;
   end if;

-- check to see if the assembly had been created
   IF v_Result <> 1 then

      SET v_Result = 0;
      ROLLBACK;
      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;
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
   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;

   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Order_CreateAssembly',v_ErrorMessage,
   v_ErrorID);

   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'ItemID',v_ItemID);
   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'QtyRequired',v_QtyRequired);

   SET SWP_Ret_Value = -1;
END;





















//

DELIMITER ;

DELIMITER //
DROP PROCEDURE IF EXISTS Inventory_Assemblies;
//
CREATE             PROCEDURE Inventory_Assemblies(v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_AssemblyID NATIONAL VARCHAR(36),
	v_WarehouseID NATIONAL VARCHAR(36),
	INOUT v_QtyRequired INT ,
	INOUT v_Result INT  ,INOUT SWP_Ret_Value INT)
   SWL_return:
BEGIN


/*
Name of stored procedure: Inventory_Assemblies
Method: 
	ALTER   Items from Assembly, takes as input
	Number of items to ALTER   and the assembly ID

Date Created: EDE - 07/28/2015

Input Parameters:

	@CompanyID NVARCHAR(36)		 - the ID of the company
	@DivisionID NVARCHAR(36)	 - the ID of the division
	@DepartmentID NVARCHAR(36)	 - the ID of the department
	@AssemblyID NVARCHAR(36)	 - the ID of the assembly to be created
	@WarehouseID NVARCHAR(36)	 - the ID of the warehouse
	@QtyRequired INT		 - the quantity required

Output Parameters:

	@Result INT  			 - Return values (@Result)
					   1	the operation completed successfuly
					   0	the quantities are not enough
					   2	passed @QtyRequired has invalid value, it should be >0
					   -1	there was a database error in processing the request

Called From:

	Order_CreateAssembly, Inventory_Assemblies.vb

Calls:

	WarehouseBinShipGoods, VerifyCurrency, WarehouseBinPutGoods, Inventory_Costing, Error_InsertError, Error_InsertErrorDetail, Inventory_CreateFromAssembly

Last Modified: 

Last Modified By: 

Revision History: 

*/

   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);

   DECLARE v_DefaultInventoryCostingMethod CHAR(1);
   DECLARE v_CurrencyID NATIONAL VARCHAR(3);

   DECLARE v_ItemID NATIONAL VARCHAR(36);
   DECLARE v_NumberOfItems INT;
   DECLARE v_LaborCurrencyID NATIONAL VARCHAR(3);
   DECLARE v_LaborExchangeRate FLOAT;
   DECLARE v_LaborCost DECIMAL(19,4);

   DECLARE v_AssemblyCost DECIMAL(19,4);
   DECLARE v_QtyItem INT;
   DECLARE v_ItemCost DECIMAL(19,4);
   DECLARE v_ItemCurrencyID NATIONAL VARCHAR(3);
   DECLARE v_ItemExchangeRate FLOAT;
   DECLARE v_QtyOnHand INT; -- current quanity in the warehouse

   DECLARE v_ExchangeRateDate DATETIME;

   DECLARE v_IsOverflow BOOLEAN;

   DECLARE v_MaxAssemblyQty INT;


-- Find maximum number of assembly items that can be gathered
-- from esisting compound items in the warehouse
   DECLARE v_TranDate DATETIME;
   DECLARE v_ErrorID INT;
   DECLARE NO_DATA INT DEFAULT 0;
   DECLARE v_PrevWarehouseID NATIONAL VARCHAR(36);
   DECLARE v_PrevWarehouseBinID NATIONAL VARCHAR(36);
   DECLARE v_WarehouseID_bin NATIONAL VARCHAR(36);
   DECLARE v_WarehouseBinID_bin NATIONAL VARCHAR(36);
   DECLARE v_PrevQty FLOAT;
   DECLARE v_PrevBackOrderQty FLOAT;
   DECLARE v_Qty_bin FLOAT;
   DECLARE v_AvlblQty_bin FLOAT;
   DECLARE v_BackQty_bin FLOAT;
   DECLARE Counter INT;
   DECLARE Records INT DEFAULT 0;
   DECLARE cInventoryAssembli CURSOR FOR
   SELECT
   ItemID, 
		IFNULL(NumberOfItemsInAssembly,0),
		IFNULL(LaborCost,0)
   FROM
   InventoryAssemblies
   WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   AssemblyID = v_AssemblyID;


   /*DECLARE cBins CURSOR
   FOR SELECT 
   WarehouseID, WarehouseBinID, Qty, AvlblQty, BackQty
   FROM 
   WarehouseBinsForSplit(v_CompanyID,v_DivisionID,v_DepartmentID,v_WarehouseID,'',v_ItemID,v_QtyItem);*/

   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN 
/*       GET DIAGNOSTICS CONDITION 1
       @p1 = RETURNED_SQLSTATE, @p2 = MESSAGE_TEXT;
       SELECT @p1, @p2;*/
     SET @SWV_Error = 1;
      SET NO_DATA = -2;
   END;
   DECLARE CONTINUE HANDLER FOR NOT FOUND SET NO_DATA = -1;
   BEGIN
      UnableToCreateAssembly:
      BEGIN
         SET @SWV_Error = 0;
         IF IFNULL(v_QtyRequired,0) <= 0 then
            SET v_Result = 2;
            SET SWP_Ret_Value = -1;
            LEAVE SWL_return;
         end if;

         SET v_Result = 1;
         SET v_AssemblyCost = 0;

-- get the currency of the company 
-- get DefaultInventoryCostingMethod from companies
         select   CurrencyID, DefaultInventoryCostingMethod INTO v_CurrencyID,v_DefaultInventoryCostingMethod FROM
         Companies WHERE
         CompanyID = v_CompanyID AND
         DivisionID = v_DivisionID AND
         DepartmentID = v_DepartmentID;
         select   min(MaxQty) INTO v_MaxAssemblyQty FROM(SELECT
            InventoryAssemblies.ItemID,
	Sum(IFNULL(InventoryByWarehouse.QtyOnHand,0)/IFNULL(InventoryAssemblies.NumberOfItemsInAssembly,1)) as MaxQty
            FROM InventoryAssemblies
            INNER JOIN InventoryByWarehouse ON
            InventoryAssemblies.CompanyID = InventoryByWarehouse.CompanyID AND
            InventoryAssemblies.DivisionID = InventoryByWarehouse.DivisionID AND
            InventoryAssemblies.DepartmentID = InventoryByWarehouse.DepartmentID AND
            InventoryAssemblies.ItemID = InventoryByWarehouse.ItemID
            WHERE
            InventoryAssemblies.CompanyID = v_CompanyID AND
            InventoryAssemblies.DivisionID = v_DivisionID AND
            InventoryAssemblies.DepartmentID = v_DepartmentID AND
            InventoryAssemblies.AssemblyID = v_AssemblyID AND
            InventoryByWarehouse.WarehouseID = v_WarehouseID
            GROUP BY
            InventoryAssemblies.ItemID)
         AS tmpTable;

-- It is not enough existing items to create requested assembly count
         IF IFNULL(v_MaxAssemblyQty,0) < v_QtyRequired then

            SET v_QtyRequired = IFNULL(v_MaxAssemblyQty,0);
            SET v_Result = 0;
            SET SWP_Ret_Value = -1;
            LEAVE SWL_return;
         end if;




-- @MaxAssemblyQty>= @QtyRequired and we can create assembly
         START TRANSACTION;

-- Create the inventory item for assembly if it is not exists yet
         SET @SWV_Error = 0;
         CALL Inventory_CreateFromAssembly2(v_CompanyID,v_DivisionID,v_DepartmentID,v_AssemblyID, v_ReturnStatus);
         IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then
-- An error occured, go to the error handler

            SET v_ErrorMessage = 'Inventory_CreateFromAssembly call failed';
            ROLLBACK;
-- the error handler
            CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Inventory_Assemblies',v_ErrorMessage,
            v_ErrorID);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'AssemblyID',v_AssemblyID);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'QtyRequired',v_QtyRequired);
            SET SWP_Ret_Value = -1;
         end if;
         SET v_TranDate = CURRENT_TIMESTAMP;
         OPEN cInventoryAssembli;
         SET NO_DATA = 0;
         FETCH cInventoryAssembli INTO v_ItemID,v_NumberOfItems,v_LaborCost;
         WHILE NO_DATA = 0 DO
	-- get all the quantity of the intem into the assembly's warehouse 
            SET v_QtyItem = v_QtyRequired*v_NumberOfItems;
         --   OPEN cBins;
            SET NO_DATA = 0;
          --  FETCH cBins INTO v_WarehouseID_bin,v_WarehouseBinID_bin,v_Qty_bin,v_AvlblQty_bin,v_BackQty_bin;
      SET Counter = WarehouseBinsForSplitCount(v_CompanyID, v_DivisionID, v_DepartmentID, v_WarehouseID, '', v_ItemID, v_QtyItem);
      IF Counter > 0 then
      CALL WarehouseBinsForSplitGetRecord(v_CompanyID, v_DivisionID, v_DepartmentID, v_WarehouseID, '', v_ItemID, v_QtyItem, Records, @outIdent, v_WarehouseID_bin, v_WarehouseBinID_bin, v_Qty_bin, v_AvlblQty_bin, v_BackQty_bin );
            WHILE NO_DATA = 0 DO
               SET @SWV_Error = 0;
	       CALL WarehouseBinLockGoods2(v_CompanyID,v_DivisionID,v_DepartmentID,v_WarehouseID_bin,v_WarehouseBinID_bin,
               v_ItemID,v_AvlblQty_bin,v_BackQty_bin,1, v_ReturnStatus);
--	       CALL WarehouseBinShipGoods2(v_CompanyID,v_DivisionID,v_DepartmentID,v_WarehouseID_bin,v_WarehouseBinID_bin,
--               v_ItemID,v_AvlblQty_bin,v_BackQty_bin,3, v_ReturnStatus);
               IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then
			
                --  CLOSE cOD;
				
                  SET v_ErrorMessage = 'WarehouseBinShipGoods failed';
                  ROLLBACK;
-- the error handler
                  CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Inventory_Assemblies',v_ErrorMessage,
                  v_ErrorID);
                  CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'AssemblyID',v_AssemblyID);
                  CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'QtyRequired',v_QtyRequired);
                  SET SWP_Ret_Value = -1;
               end if;
               SET NO_DATA = 0;
	       
	       SET Records = Records + 1;
	       IF Records = Counter OR Counter=0 then
	       --	           select Records;
	           SET NO_DATA = 1;
	       else
	 	CALL WarehouseBinsForSplitGetRecord(v_CompanyID, v_DivisionID, v_DepartmentID, v_PrevWarehouseID, v_PrevWarehouseBinID, v_ItemID, v_PrevQty, Records, @outIdent, v_WarehouseID_bin, v_WarehouseBinID_bin, v_Qty_bin, v_AvlblQty_bin, v_BackQty_bin );	       
               end if;
           --   FETCH cBins INTO v_WarehouseID_bin,v_WarehouseBinID_bin,v_Qty_bin,v_AvlblQty_bin,v_BackQty_bin;
            END WHILE;
          --  CLOSE cBins;
	  END IF;	



	-- get the cost of the item and add it to the cost of the assembly
            select   IFNULL(CASE v_DefaultInventoryCostingMethod
            WHEN 'F' THEN FIFOCost
            WHEN 'L' THEN LIFOCost
            WHEN 'A' THEN AverageCost
            ELSE 0
            END,0) INTO v_ItemCost FROM
            InventoryItems WHERE
            CompanyID = v_CompanyID AND
            DivisionID = v_DivisionID AND
            DepartmentID = v_DepartmentID AND
            ItemID = v_ItemID;
            SET v_ExchangeRateDate = CURRENT_TIMESTAMP;
            SET v_QtyRequired = -v_QtyRequired;
	-- Post inventory changes to InventoryLedger table and recalc item cost
            SET @SWV_Error = 0;
            CALL Inventory_CreateILTransaction2(v_CompanyID,v_DivisionID,v_DepartmentID,v_TranDate,v_ItemID,'Assembly',
            v_AssemblyID,0,v_QtyRequired,v_ItemCost, v_ReturnStatus);
            IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then
	-- An error occured, go to the error handler
	
		-- the procedure will return an error code
               CLOSE cInventoryAssembli;
		
               SET v_ErrorMessage = 'Inventory_CreateILTransaction call failed';
               ROLLBACK;
-- the error handler
               CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Inventory_Assemblies',v_ErrorMessage,
               v_ErrorID);
               CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'AssemblyID',v_AssemblyID);
               CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'QtyRequired',v_QtyRequired);
               SET SWP_Ret_Value = -1;
            end if;
            SET v_QtyRequired = -v_QtyRequired;


	-- get the cost of the item and add it to the assembly cost
            SET v_AssemblyCost = v_AssemblyCost+v_ItemCost*v_NumberOfItems+v_LaborCost;
            SET NO_DATA = 0;
            FETCH cInventoryAssembli INTO v_ItemID,v_NumberOfItems,v_LaborCost;
         END WHILE;
         CLOSE cInventoryAssembli;


/* something strange with using WarehouseBinPuth and WarehouseBinShip, it works not as planned for Order_Post
-- put inventory
         SET @SWV_Error = 0;
         CALL WarehouseBinPutGoods2(v_CompanyID,v_DivisionID,v_DepartmentID,v_WarehouseID,'',v_AssemblyID,
         NULL,NULL,NULL,NULL,v_QtyRequired,6,v_IsOverflow, v_ReturnStatus);
         IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then
-- An error occured, go to the error handler

            SET v_ErrorMessage = 'WarehouseBinPutGoods call failed';
            ROLLBACK;
-- the error handler
            CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Inventory_Assemblies',v_ErrorMessage,
            v_ErrorID);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'AssemblyID',v_AssemblyID);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'QtyRequired',v_QtyRequired);
            SET SWP_Ret_Value = -1;
         end if;
*/
-- Post inventory changes to InventoryLedger table and recalc item cost
         SET @SWV_Error = 0;
         CALL Inventory_CreateILTransaction2(v_CompanyID,v_DivisionID,v_DepartmentID,v_TranDate,v_AssemblyID,'Assembly',
         v_AssemblyID,0,v_QtyRequired,v_AssemblyCost, v_ReturnStatus);
         IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then
-- An error occured, go to the error handler

            SET v_ErrorMessage = 'Inventory_CreateILTransaction call failed';
            ROLLBACK;
-- the error handler
            CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Inventory_Assemblies',v_ErrorMessage,
            v_ErrorID);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'AssemblyID',v_AssemblyID);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'QtyRequired',v_QtyRequired);
            SET SWP_Ret_Value = -1;
         end if;


-- update the cost of the assembly
         SET @SWV_Error = 0;
         CALL Inventory_Costing2(v_CompanyID,v_DivisionID,v_DepartmentID,v_AssemblyID,v_WarehouseID,v_QtyRequired,
         v_AssemblyCost,0,v_Result, v_ReturnStatus);
         IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then
-- An error occured, go to the error handler

            SET v_ErrorMessage = 'Inventory_Costing call failed';
            ROLLBACK;
-- the error handler
            CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Inventory_Assemblies',v_ErrorMessage,
            v_ErrorID);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'AssemblyID',v_AssemblyID);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'QtyRequired',v_QtyRequired);
            SET SWP_Ret_Value = -1;
         end if;
         IF  v_Result <> 1 then
            LEAVE UnableToCreateAssembly;
         end if;
-- Everything is OK
         COMMIT;
         SET SWP_Ret_Value = 0;
         LEAVE SWL_return;
      END;
      ROLLBACK;
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
-- the error handler
   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Inventory_Assemblies',v_ErrorMessage,
   v_ErrorID);

   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'AssemblyID',v_AssemblyID);
   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'QtyRequired',v_QtyRequired);

   SET SWP_Ret_Value = -1;
END;



//

DELIMITER ;

DELIMITER //
DROP PROCEDURE IF EXISTS WarehouseBinsForSplitGetRecord;
//
CREATE PROCEDURE WarehouseBinsForSplitGetRecord(v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_WarehouseID NATIONAL VARCHAR(36),
	v_WarehouseBinID NATIONAL VARCHAR(36),
	v_InventoryItemID NATIONAL VARCHAR(36),
	v_Qty FLOAT,
	Counter INT,
	
      	INOUT outIdent INT,
      	INOUT outWarehouseID NATIONAL VARCHAR(36),
      	INOUT outWarehouseBinID NATIONAL VARCHAR(36),
	INOUT outQty FLOAT,
	INOUT outAvlblQty FLOAT,
	INOUT outBackQty FLOAT
	) 
   SWL_return:
BEGIN

   DECLARE v_Ident INT;
   DECLARE v_QtyOnHand FLOAT;
   DECLARE NO_DATA INT DEFAULT 0;
   DECLARE cBins CURSOR
   FOR SELECT 
   WarehouseID, WarehouseBinID, QtyOnHand
   FROM 
   tt_fnWarehouseBinsRet;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
/*       GET DIAGNOSTICS CONDITION 1
       @p1 = RETURNED_SQLSTATE, @p2 = MESSAGE_TEXT;
       SELECT @p1, @p2;*/
      SET NO_DATA = -2;
   END;
   DECLARE CONTINUE HANDLER FOR NOT FOUND SET NO_DATA = -1;

   DROP TEMPORARY TABLE IF EXISTS tt_Ret;
   CREATE TEMPORARY TABLE IF NOT EXISTS tt_Ret
   (
      Ident INT,
      WarehouseID NATIONAL VARCHAR(36),
      WarehouseBinID NATIONAL VARCHAR(36),
      Qty FLOAT,
      AvlblQty FLOAT,
      BackQty FLOAT
   );
   CALL fnWarehouseBins(v_CompanyID, v_DivisionID, v_DepartmentID, v_WarehouseID, v_WarehouseBinID, v_InventoryItemID, 1);
   SET v_Ident = 1;

   OPEN cBins;
   SET NO_DATA = 0;
   FETCH cBins INTO v_WarehouseID,v_WarehouseBinID,v_QtyOnHand;
   WHILE NO_DATA = 0 DO
      IF v_Qty > 0 then
				
         IF v_Qty <= v_QtyOnHand then
						
            INSERT INTO tt_Ret(Ident,
								WarehouseID,
								WarehouseBinID,
								Qty,
								AvlblQty,
								BackQty)
							VALUES(v_Ident,
								v_WarehouseID,
								v_WarehouseBinID,
								v_Qty,
								v_Qty,
								0);
						
            SET v_Qty = 0;
         ELSE 
            IF v_QtyOnHand > 0 then
						
               INSERT INTO tt_Ret(Ident,
								WarehouseID,
								WarehouseBinID,
								Qty,
								AvlblQty,
								BackQty)
							VALUES(v_Ident,
								v_WarehouseID,
								v_WarehouseBinID,
								v_QtyOnHand,
								v_QtyOnHand,
								0);
						
               SET v_Qty = v_Qty -v_QtyOnHand;
            end if;
         end if;
      end if;
      SET v_Ident = v_Ident+1;
      SET NO_DATA = 0;
      FETCH cBins INTO v_WarehouseID,v_WarehouseBinID,v_QtyOnHand;
   END WHILE;
	
   CLOSE cBins;
	

   IF v_Qty > 0 then
		
      INSERT INTO tt_Ret(Ident,
				WarehouseID,
				WarehouseBinID,
				Qty,
				AvlblQty,
				BackQty)
			VALUES(v_Ident,
				v_WarehouseID,
				v_WarehouseBinID,
				v_Qty,
				0,
				v_Qty);
   end if;

   select * into outIdent, outWarehouseID, outWarehouseBinID, outQty, outAvlblQty, outBackQty from tt_Ret limit Counter, 1;
   LEAVE SWL_return;

END;


//

DELIMITER ;

DELIMITER //
DROP PROCEDURE IF EXISTS WarehouseBinsForSplitCount;
DROP FUNCTION IF EXISTS WarehouseBinsForSplitCount;
//
CREATE FUNCTION WarehouseBinsForSplitCount(v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_WarehouseID NATIONAL VARCHAR(36),
	v_WarehouseBinID NATIONAL VARCHAR(36),
	v_InventoryItemID NATIONAL VARCHAR(36),
	v_Qty FLOAT) 
   RETURNS INT
BEGIN

   DECLARE Counter INT;
   DECLARE v_Ident INT;
   DECLARE v_QtyOnHand FLOAT;
   DECLARE NO_DATA INT DEFAULT 0;
   DECLARE cBins CURSOR
   FOR SELECT 
   WarehouseID, WarehouseBinID, QtyOnHand
   FROM 
   tt_fnWarehouseBinsRet;

   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET NO_DATA = -2;
   END;
   DECLARE CONTINUE HANDLER FOR NOT FOUND SET NO_DATA = -1;

   DROP TEMPORARY TABLE IF EXISTS tt_Ret;
   CREATE TEMPORARY TABLE IF NOT EXISTS tt_Ret
   (
      Ident INT,
      WarehouseID NATIONAL VARCHAR(36),
      WarehouseBinID NATIONAL VARCHAR(36),
      Qty FLOAT,
      AvlblQty FLOAT,
      BackQty FLOAT
   );

   CALL fnWarehouseBins(v_CompanyID, v_DivisionID, v_DepartmentID, v_WarehouseID, v_WarehouseBinID, v_InventoryItemID, 1);
   SET v_Ident = 1;

   OPEN cBins;
   SET NO_DATA = 0;
   FETCH cBins INTO v_WarehouseID,v_WarehouseBinID,v_QtyOnHand;
   WHILE NO_DATA = 0 DO
      IF v_Qty > 0 then
				
         IF v_Qty <= v_QtyOnHand then
						
            INSERT INTO tt_Ret(Ident,
								WarehouseID,
								WarehouseBinID,
								Qty,
								AvlblQty,
								BackQty)
							VALUES(v_Ident,
								v_WarehouseID,
								v_WarehouseBinID,
								v_Qty,
								v_Qty,
								0);
						
            SET v_Qty = 0;
         ELSE 
            IF v_QtyOnHand > 0 then
						
               INSERT INTO tt_Ret(Ident,
								WarehouseID,
								WarehouseBinID,
								Qty,
								AvlblQty,
								BackQty)
							VALUES(v_Ident,
								v_WarehouseID,
								v_WarehouseBinID,
								v_QtyOnHand,
								v_QtyOnHand,
								0);
						
               SET v_Qty = v_Qty -v_QtyOnHand;
            end if;
         end if;
      end if;
      SET v_Ident = v_Ident+1;
      SET NO_DATA = 0;
      FETCH cBins INTO v_WarehouseID,v_WarehouseBinID,v_QtyOnHand;
   END WHILE;
	
   CLOSE cBins;
	

   IF v_Qty > 0 then
		
      INSERT INTO tt_Ret(Ident,
				WarehouseID,
				WarehouseBinID,
				Qty,
				AvlblQty,
				BackQty)
			VALUES(v_Ident,
				v_WarehouseID,
				v_WarehouseBinID,
				v_Qty,
				0,
				v_Qty);
   end if;

   SELECT COUNT(*) Into Counter FROM tt_Ret;
   RETURN Counter;
END;


//

DELIMITER ;

DELIMITER //

DROP PROCEDURE IF EXISTS WarehouseBinsForSplit2;
//
CREATE PROCEDURE WarehouseBinsForSplit2(v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_WarehouseID NATIONAL VARCHAR(36),
	v_WarehouseBinID NATIONAL VARCHAR(36),
	v_InventoryItemID NATIONAL VARCHAR(36),
	v_Qty FLOAT) 
   SWL_return:
BEGIN

   DECLARE v_Ident INT;
   DECLARE v_QtyOnHand FLOAT;
   DECLARE NO_DATA INT DEFAULT 0;
   DECLARE cBins CURSOR
   FOR SELECT 
   WarehouseID, WarehouseBinID, QtyOnHand
   FROM 
   tt_Ret;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET NO_DATA = -2;
   END;
   DECLARE CONTINUE HANDLER FOR NOT FOUND SET NO_DATA = -1;

   DROP TEMPORARY TABLE IF EXISTS tt_Ret;
   CREATE TEMPORARY TABLE IF NOT EXISTS tt_Ret
   (
      Ident INT,
      WarehouseID NATIONAL VARCHAR(36),
      WarehouseBinID NATIONAL VARCHAR(36),
      Qty FLOAT,
      AvlblQty FLOAT,
      BackQty FLOAT
   );
   SET v_Ident = 1;

   OPEN cBins;
   SET NO_DATA = 0;
   FETCH cBins INTO v_WarehouseID,v_WarehouseBinID,v_QtyOnHand;
   WHILE NO_DATA = 0 DO
      IF v_Qty > 0 then
				
         IF v_Qty <= v_QtyOnHand then
						
            INSERT INTO tt_Ret(Ident,
								WarehouseID,
								WarehouseBinID,
								Qty,
								AvlblQty,
								BackQty)
							VALUES(v_Ident,
								v_WarehouseID,
								v_WarehouseBinID,
								v_Qty,
								v_Qty,
								0);
						
            SET v_Qty = 0;
         ELSE 
            IF v_QtyOnHand > 0 then
						
               INSERT INTO tt_Ret(Ident,
								WarehouseID,
								WarehouseBinID,
								Qty,
								AvlblQty,
								BackQty)
							VALUES(v_Ident,
								v_WarehouseID,
								v_WarehouseBinID,
								v_QtyOnHand,
								v_QtyOnHand,
								0);
						
               SET v_Qty = v_Qty -v_QtyOnHand;
            end if;
         end if;
      end if;
      SET v_Ident = v_Ident+1;
      SET NO_DATA = 0;
      FETCH cBins INTO v_WarehouseID,v_WarehouseBinID,v_QtyOnHand;
   END WHILE;
	
   CLOSE cBins;
	

   IF v_Qty > 0 then
		
      INSERT INTO tt_Ret(Ident,
				WarehouseID,
				WarehouseBinID,
				Qty,
				AvlblQty,
				BackQty)
			VALUES(v_Ident,
				v_WarehouseID,
				v_WarehouseBinID,
				v_Qty,
				0,
				v_Qty);
   end if;

   select * from tt_Ret;
	
   LEAVE SWL_return;

END;


//

DELIMITER ;

DELIMITER //

DROP PROCEDURE IF EXISTS fnWarehouseBins;
//
CREATE PROCEDURE fnWarehouseBins(v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_WarehouseID NATIONAL VARCHAR(36),
	v_WarehouseBinID NATIONAL VARCHAR(36),
	v_InventoryItemID NATIONAL VARCHAR(36),
	v_Direction BOOLEAN) 
   SWL_return:
BEGIN
   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_Available FLOAT;
   DECLARE v_QtyBin FLOAT;
   DECLARE v_OverFlowBin NATIONAL VARCHAR(36);
   DECLARE v_Ident INT;
	-- get default Warehouse & bin
   DROP TEMPORARY TABLE IF EXISTS tt_fnWarehouseBinsRet;
   CREATE TEMPORARY TABLE IF NOT EXISTS tt_fnWarehouseBinsRet
   (
      WarehouseID NATIONAL VARCHAR(36),
      WarehouseBinID NATIONAL VARCHAR(36),
      MaximumQuantity FLOAT,
      QtyOnHand FLOAT
   );
   SET v_WarehouseID = WarehouseRoot2(v_CompanyID,v_DivisionID,v_DepartmentID,v_WarehouseID,v_InventoryItemID);
   SET v_WarehouseBinID = WarehouseBinRoot2(v_CompanyID,v_DivisionID,v_DepartmentID,v_WarehouseID,v_WarehouseBinID,
   v_InventoryItemID);
   DROP TEMPORARY TABLE IF EXISTS tt_Tbl;
   CREATE TEMPORARY TABLE tt_Tbl
   (
      Ident INT,
      WarehouseID NATIONAL VARCHAR(36),
      WarehouseBinID NATIONAL VARCHAR(36),
      MaximumQuantity FLOAT,
      QtyOnHand FLOAT
   );
   SET v_Ident = 1;
   WHILE NOT (v_WarehouseBinID IS NULL OR RTRIM(v_WarehouseBinID) = '' OR v_WarehouseBinID = 'Overflow') DO
			-- get quantity in bin
      select   IFNULL(SUM(IFNULL(QtyOnHand,0)),0) INTO v_QtyBin FROM InventoryByWarehouse WHERE
      CompanyID = v_CompanyID AND
      DivisionID = v_DivisionID AND
      DepartmentID = v_DepartmentID AND
      WarehouseID = v_WarehouseID AND
      WarehouseBinID = v_WarehouseBinID AND
      ItemID = v_InventoryItemID;
      select   IFNULL(MaximumQuantity,0) -IFNULL(LockerStockQty,0), OverFlowBin INTO v_Available,v_OverFlowBin FROM WarehouseBins WHERE
      CompanyID = v_CompanyID AND
      DivisionID = v_DivisionID AND
      DepartmentID = v_DepartmentID AND
      WarehouseID = v_WarehouseID AND
      WarehouseBinID = v_WarehouseBinID;
      IF NOT EXISTS(SELECT * FROM WarehouseBins
      WHERE
      CompanyID = v_CompanyID AND
      DivisionID = v_DivisionID AND
      DepartmentID = v_DepartmentID AND
      WarehouseID = v_WarehouseID AND
      WarehouseBinID = v_OverFlowBin) then
				
         SET v_OverFlowBin = '';
      end if;
      INSERT INTO tt_Tbl(Ident,
				WarehouseID,
				WarehouseBinID,
				MaximumQuantity,
				QtyOnHand)
			VALUES(v_Ident,
				v_WarehouseID,
				v_WarehouseBinID,
				v_Available,
				v_QtyBin);
			
      SET v_WarehouseBinID = v_OverFlowBin;
      SET v_Ident = v_Ident+1;
   END WHILE;
   select   IFNULL(SUM(QtyOnHand),0) INTO v_QtyBin FROM InventoryByWarehouse WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   WarehouseID = v_WarehouseID AND
   WarehouseBinID = 'Overflow' AND
   ItemID = v_InventoryItemID;
   INSERT INTO tt_Tbl(Ident,
		WarehouseID,
		WarehouseBinID,
		MaximumQuantity,
		QtyOnHand)
	VALUES(v_Ident,
		v_WarehouseID,
		'Overflow',
		-1,
		v_QtyBin);
	
   IF v_Direction = 0 then
		
      INSERT INTO tt_fnWarehouseBinsRet
      SELECT
      WarehouseID,
				WarehouseBinID,
				MaximumQuantity,
				QtyOnHand
      FROM
      tt_Tbl
      ORDER BY Ident ASC;
   ELSE
      INSERT INTO tt_fnWarehouseBinsRet
      SELECT
      WarehouseID,
				WarehouseBinID,
				MaximumQuantity,
				QtyOnHand
      FROM
      tt_Tbl
      ORDER BY Ident DESC;
   end if;
   LEAVE SWL_return;
END;



//

DELIMITER ;

DELIMITER //
DROP PROCEDURE IF EXISTS WarehouseBinLockGoods2;
//
CREATE      PROCEDURE WarehouseBinLockGoods2(v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_WarehouseID NATIONAL VARCHAR(36),
	v_WarehouseBinID NATIONAL VARCHAR(36),
	v_InventoryItemID NATIONAL VARCHAR(36),
	v_Qty FLOAT,
	v_BackQty FLOAT,
	v_Action INT,INOUT SWP_Ret_Value INT)
   SWL_return:
BEGIN










/*
Name of stored procedure: WarehouseBinLockGoods
Method: 
	this procedure lock goods into warehouse bin

Date Created: EDE - 07/28/2015

Input Parameters:

	@CompanyID NVARCHAR(36)		 - the ID of the company
	@DivisionID NVARCHAR(36)	 - the ID of the division
	@DepartmentID NVARCHAR(36)	 - the ID of the department
	@WarehouseID NVARCHAR(36)	 - the ID of warehouse
	@WarehouseBinID NVARCHAR(36)	 - the ID of warehouse bin
	@InventoryItemID NVARCHAR(36)	 - the ID of inventory item
	@Qty FLOAT			 - the locked items count
	@BackQty FLOAT			 - the count of backordered items
	@Action INT			 - defines the operation that is performed with inventory items


                                                           1 - increase InventoryByWarehouse.QtyCommitted in @Qty value 
                                                               decrease InventoryByWarehouse.QtyOnHand in @Qty value 
                                                               increase InventoryByWarehouse.QtyOnBackOrder in @BackQty value
                                                               increase WarehouseBins.LockerStockQty in @Qty value
                                                               used from InvoiceDetail_SplitToWarehouseBin,OrderDetail_SplitToWarehouseBin procedures

                                                           2 - decrease InventoryByWarehouse.QtyCommitted in (@Qty - @BackQty) value 
                                                               increase InventoryByWarehouse.QtyOnHand in (@Qty - @BackQty) value 
                                                               decrease InventoryByWarehouse.QtyOnBackOrder in @BackQty value
                                                               decrease WarehouseBins.LockerStockQty in (@Qty - @BackQty) value
                                                               used from  procedures Order_Cancel,Return_Cancel procedures

							   3 - reverse relative to 1 operation
                                                               decrease InventoryByWarehouse.QtyCommitted in @Qty value
                                                               increase InventoryByWarehouse.QtyOnHand in @Qty value
                                                               decrease InventoryByWarehouse.QtyOnBackOrder in @BackQty value
                                                               decrease WarehouseBins.LockerStockQty in @Qty value
                                                               used from InvoiceDetail_SplitToWarehouseBin,OrderDetail_SplitToWarehouseBin procedures

							   else - nothing

Output Parameters:

	NONE

Called From:

	OrderDetail_SplitToWarehouseBin, Return_Cancel, ReturnDetail_SplitToWarehouseBin, Order_Cancel

Calls:

	Error_InsertError, Error_InsertErrorDetail

Last Modified: 

Last Modified By: 

Revision History: 

*/



   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);
   DECLARE v_ErrorID INT;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
/*       GET DIAGNOSTICS CONDITION 1
       @p1 = RETURNED_SQLSTATE, @p2 = MESSAGE_TEXT;
       SELECT @p1, @p2;*/
      SET @SWV_Error = 1;
   END;


   SET @SWV_Error = 0;
   START TRANSACTION;


   IF(SELECT COUNT(*) FROM InventoryByWarehouse
   WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   ItemID = v_InventoryItemID AND
   WarehouseID = v_WarehouseID AND
   WarehouseBinID = v_WarehouseBinID) = 0 then
		
      SET @SWV_Error = 0;
      INSERT INTO InventoryByWarehouse(CompanyID,
					DivisionID,
					DepartmentID,
					ItemID,
					WarehouseID,
					WarehouseBinID,
					QtyOnHand,
					QtyCommitted,
					QtyOnOrder,
					QtyOnBackorder)
			VALUES(v_CompanyID,
					v_DivisionID,
					v_DepartmentID,
					v_InventoryItemID,
					v_WarehouseID,
					v_WarehouseBinID,
					0,
					0,
					0,
					0);
			
      IF @SWV_Error <> 0 then
			
         SET v_ErrorMessage = 'Insert InventoryByWarehouse bin failed';
         ROLLBACK;
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'WarehouseBinLockGoods',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'WarehouseID',v_WarehouseID);
         SET SWP_Ret_Value = -1;
      end if;
   end if;

   SET @SWV_Error = 0;
   UPDATE WarehouseBins
   SET
   LockerStockQty =
   CASE v_Action
   WHEN 1 THEN IFNULL(LockerStockQty,0)+v_Qty
   WHEN 2 THEN IFNULL(LockerStockQty,0) -(v_Qty -v_BackQty)
   WHEN 3 THEN IFNULL(LockerStockQty,0) -v_Qty
   ELSE IFNULL(LockerStockQty,0)
   END
   WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   WarehouseID = v_WarehouseID AND
   WarehouseBinID = v_WarehouseBinID;
   IF @SWV_Error <> 0 then
	
      SET v_ErrorMessage = 'Updating WarehouseBins failed';
      ROLLBACK;
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'WarehouseBinLockGoods',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'WarehouseID',v_WarehouseID);
      SET SWP_Ret_Value = -1;
   end if;

   SET @SWV_Error = 0;
   UPDATE WarehouseBins
   SET
   LockerStock =
   CASE
   WHEN LockerStockQty > 0 THEN 1
   ELSE 0
   END
   WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   WarehouseID = v_WarehouseID AND
   WarehouseBinID = v_WarehouseBinID;
   IF @SWV_Error <> 0 then
	
      SET v_ErrorMessage = 'Updating WarehouseBins failed';
      ROLLBACK;
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'WarehouseBinLockGoods',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'WarehouseID',v_WarehouseID);
      SET SWP_Ret_Value = -1;
   end if;

   SET @SWV_Error = 0;
   UPDATE
   InventoryByWarehouse
   SET
   QtyOnHand =
   CASE v_Action
   WHEN 1 THEN IFNULL(QtyOnHand,0) - v_Qty
   WHEN 2 THEN IFNULL(QtyOnHand,0) + (v_Qty -v_BackQty)
   WHEN 3 THEN IFNULL(QtyOnHand,0) + v_Qty
   ELSE IFNULL(QtyOnHand,0)
   END,QtyCommitted =
   CASE v_Action
   WHEN 1 THEN IFNULL(QtyCommitted,0) + v_Qty
   WHEN 2 THEN IFNULL(QtyCommitted,0) - (v_Qty -v_BackQty)
   WHEN 3 THEN IFNULL(QtyCommitted,0) - v_Qty
   ELSE IFNULL(QtyCommitted,0)
   END,QtyOnBackorder =
   CASE v_Action
   WHEN 1 THEN IFNULL(QtyOnBackorder,0)+v_BackQty
   WHEN 2 THEN
      CASE
      WHEN IFNULL(QtyOnBackorder,0) -v_BackQty >= 0
      THEN IFNULL(QtyOnBackorder,0) -v_BackQty
      ELSE 0
      END
   WHEN 3 THEN
      CASE
      WHEN IFNULL(QtyOnBackorder,0) -v_BackQty >= 0
      THEN IFNULL(QtyOnBackorder,0) -v_BackQty
      ELSE 0
      END
   ELSE IFNULL(QtyOnBackorder,0)
   END
   WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND WarehouseID = v_WarehouseID
   AND WarehouseBinID = v_WarehouseBinID
   AND ItemID = v_InventoryItemID;

   IF @SWV_Error <> 0 then
	
      SET v_ErrorMessage = 'Updating inventory failed';
      ROLLBACK;
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'WarehouseBinLockGoods',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'WarehouseID',v_WarehouseID);
      SET SWP_Ret_Value = -1;
   end if;



   COMMIT;

   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;


   ROLLBACK;

   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'WarehouseBinLockGoods',v_ErrorMessage,
   v_ErrorID);
   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'WarehouseID',v_WarehouseID);
	
   SET SWP_Ret_Value = -1;

END;






//

DELIMITER ;
