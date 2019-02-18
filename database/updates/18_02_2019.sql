DELIMITER //
DROP PROCEDURE IF EXISTS Order_CreateFromQuote;
//
CREATE PROCEDURE Order_CreateFromQuote(v_CompanyID 	NATIONAL VARCHAR(36),
	v_DivisionID 	NATIONAL VARCHAR(36),
	v_DepartmentID 	NATIONAL VARCHAR(36),
	v_OrderNumber 	NATIONAL VARCHAR(36),INOUT SWP_Ret_Value INT)
   SWL_return:
BEGIN

/*
Name of stored procedure: Order_CreateFromQuote
Method: 
	This stored procedure will ALTER  an order from a quote in the system.

Date Created: EDE - 07/28/2015

Input Parameters:

	@CompanyID NVARCHAR(36)		 - the ID of the company
	@DivisionID NVARCHAR(36)	 - the ID of the division
	@DepartmentID NVARCHAR(36)	 - the ID of the department
	@OrderNumber NVARCHAR(36)	 - used to identify the order (quote type)

Output Parameters:

	NONE

Called From:

	Order_CreateFromQuote.vb

Calls:

	Order_Post, Error_InsertError, Error_InsertErrorDetail

Last Modified: 

Last Modified By: 

Revision History: 

*/

   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);
   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_OrderTypeID NATIONAL VARCHAR(36);

-- get the type of the order
   DECLARE v_ErrorID INT;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
   END;
   select   OrderTypeID INTO v_OrderTypeID FROM
   OrderHeader WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   OrderNumber = v_OrderNumber;

-- if the order is not a quote return
   IF LOWER(v_OrderTypeID) <> LOWER('Quote') then

      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;
   end if;

   START TRANSACTION;

-- change the quote into an order
-- and set the post state to unposted
   SET @SWV_Error = 0;
   UPDATE
   OrderHeader
   SET
   Posted = 0,OrderTypeID = 'Order',TransactionTypeID = 'Order'
   WHERE
   OrderNumber = v_OrderNumber
   AND CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID;

   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Updating order header failed';
      ROLLBACK;
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Order_CreateFromQuote',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'OrderNumber',v_OrderNumber);
      SET SWP_Ret_Value = -1;
   end if;
	
-- post the order
   SET @SWV_Error = 0;
   CALL Order_Post2(v_CompanyID,v_DivisionID,v_DepartmentID,v_OrderNumber,v_ErrorMessage, v_ReturnStatus);
   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then

	-- SET @ErrorMessage = 'Order_Post call failed'
      ROLLBACK;
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Order_CreateFromQuote',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'OrderNumber',v_OrderNumber);
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
   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Order_CreateFromQuote',v_ErrorMessage,
   v_ErrorID);

   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'OrderNumber',v_OrderNumber);

   SET SWP_Ret_Value = -1;
END;


//

DELIMITER ;

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
      SET v_ReturnStatus = Order_RecalcCustomerCredit(v_CompanyID,v_DivisionID,v_DepartmentID,v_CustomerID,v_AvailibleCredit);
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
      IF v_OrderQty > v_QtyOnHand then -- there is enough quantity in the warehouse
		
         SET v_AvailableQty = v_QtyOnHand;
         SET v_DifferenceQty = v_OrderQty -v_QtyOnHand;
		
			-- verify if the item is an assembly and if the assembly can be created
			-- from items existing in the warehouses
         SET @SWV_Error = 0;
         SET v_ReturnStatus = Order_CreateAssembly2(v_CompanyID,v_DivisionID,v_DepartmentID,v_ItemID,v_WarehouseID,v_DifferenceQty,
         v_Result);
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
      SET v_ReturnStatus = Order_MakeInvoiceReceipt2(v_CompanyID,v_DivisionID,v_DepartmentID,v_OrderNumber);
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
DROP PROCEDURE IF EXISTS Order_Cancel;
//
CREATE     PROCEDURE Order_Cancel(v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_OrderNumber NATIONAL VARCHAR(36),INOUT SWP_Ret_Value INT)
   SWL_return:
BEGIN










/*
Name of stored procedure: Order_Cancel
Method: 
	this procedure cancels an order

Date Created: EDE - 07/28/2015

Input Parameters:

	@CompanyID NVARCHAR(36)		 - the ID of the company
	@DivisionID NVARCHAR(36)	 - the ID of the division
	@DepartmentID NVARCHAR(36)	 - the ID of the department
	@OrderNumber NVARCHAR(36)	 - the number of the order

Output Parameters:

	NONE

Called From:

	Order_Cancel.vb

Calls:

	VerifyCurrency, WarehouseBinLockGoods, SerialNumber_Cancel, Error_InsertError, Error_InsertErrorDetail

Last Modified: 

Last Modified By: 

Revision History: 

*/

   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);

   DECLARE v_OrderLineNumber NUMERIC(18,0);
   DECLARE v_ItemID NATIONAL VARCHAR(36);
   DECLARE v_OrderQty FLOAT;
   DECLARE v_BackOrderQyyty FLOAT;
   DECLARE v_WarehouseID NATIONAL VARCHAR(36);
   DECLARE v_WarehouseBinID NATIONAL VARCHAR(36);
   DECLARE v_SerialNumber NATIONAL VARCHAR(50);

   DECLARE v_Posted BOOLEAN;
   DECLARE v_Picked BOOLEAN;
   DECLARE v_Shipped BOOLEAN;
   DECLARE v_Invoiced BOOLEAN;
   DECLARE v_OrderTypeID NATIONAL VARCHAR(36);

   DECLARE v_CustomerID NATIONAL VARCHAR(50);

   DECLARE v_DifferenceQty FLOAT;


   DECLARE v_CurrencyID NATIONAL VARCHAR(3);
   DECLARE v_CompanyCurrencyID NATIONAL VARCHAR(3);
   DECLARE v_CurrencyExchangeRate FLOAT;
   DECLARE v_OrderDate DATETIME;
   DECLARE v_Total DECIMAL(19,4);
   DECLARE v_ConvertedTotal DECIMAL(19,4);
   DECLARE v_HighestCredit DECIMAL(19,4);
   DECLARE v_AvailibleCredit DECIMAL(19,4);
   DECLARE v_AmountPaid DECIMAL(19,4);

-- get the information from the order header
   DECLARE v_ErrorID INT;
   DECLARE NO_DATA INT DEFAULT 0;
   DECLARE cOrderDetail CURSOR FOR
   SELECT 
   OrderLineNumber, 
		OrderDetail.ItemID, 
		IFNULL(OrderQty,0), 
		IFNULL(BackOrderQyyty,0),
		OrderDetail.WarehouseID,
		OrderDetail.WarehouseBinID,
		OrderDetail.SerialNumber
   FROM 
   OrderDetail
   INNER JOIN InventoryItems ON
   InventoryItems.CompanyID = OrderDetail.CompanyID
   AND InventoryItems.DivisionID = OrderDetail.DivisionID
   AND InventoryItems.DepartmentID = OrderDetail.DepartmentID
   AND InventoryItems.ItemID = OrderDetail.ItemID
   WHERE	
   OrderDetail.CompanyID = v_CompanyID
   AND OrderDetail.DivisionID = v_DivisionID
   AND OrderDetail.DepartmentID = v_DepartmentID
   AND OrderDetail.OrderNumber = v_OrderNumber
   AND OrderDetail.OrderQty > 0
   AND SUBSTRING(ItemTypeID,1,7) <> N'Service';

-- open the cursor and get the first order detail

   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
      SET NO_DATA = -2;
   END;
   DECLARE CONTINUE HANDLER FOR NOT FOUND SET NO_DATA = -1;
   select   IFNULL(Posted,0), IFNULL(Picked,0), IFNULL(Shipped,0), IFNULL(Invoiced,0), IFNULL(AmountPaid,0), IFNULL(OrderTypeID,N'') INTO v_Posted,v_Picked,v_Shipped,v_Invoiced,v_AmountPaid,v_OrderTypeID FROM
   OrderHeader WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND OrderNumber = v_OrderNumber;

-- if the order cannot be canceled return
   IF v_Posted = 0 OR v_Picked = 1 OR v_Shipped = 1 OR v_Invoiced = 1 OR v_AmountPaid > 0  OR LOWER(v_OrderTypeID) = 'quote' then

      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;
   end if;

-- REDO THE CUSTOMERS FINANCIALS

-- get the informations regarding the customers from the order header
   select   CustomerID, Total, CurrencyID, CurrencyExchangeRate, OrderDate INTO v_CustomerID,v_Total,v_CurrencyID,v_CurrencyExchangeRate,v_OrderDate FROM
   OrderHeader WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND OrderNumber = v_OrderNumber;

   START TRANSACTION;

-- adjust the system to for the multicurrency 
   SET @SWV_Error = 0;
   CALL VerifyCurrency2(v_CompanyID,v_DivisionID,v_DepartmentID,v_OrderDate,1,v_CompanyCurrencyID,
   v_CurrencyID,v_CurrencyExchangeRate);
   IF @SWV_Error <> 0 then

	-- the procedure will return an error code
      SET v_ErrorMessage = 'Currency retrieving failed';
      ROLLBACK;
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Order_Cancel',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'OrderNumber',v_OrderNumber);

-- an error occured, return -1
      SET SWP_Ret_Value = -1;
   end if;

   SET v_ConvertedTotal = fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,v_Total*v_CurrencyExchangeRate, 
   v_CompanyCurrencyID);

-- update customer financials 
   SET @SWV_Error = 0;
   UPDATE
   CustomerFinancials
   SET
   AvailibleCredit = IFNULL(AvailibleCredit,0)+v_ConvertedTotal,BookedOrders = IFNULL(BookedOrders,0) -v_ConvertedTotal,
   SalesYTD = IFNULL(SalesYTD,0) -v_ConvertedTotal
   WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND CustomerID = v_CustomerID;
   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'customer financials updating failed';
      ROLLBACK;
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Order_Cancel',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'OrderNumber',v_OrderNumber);

-- an error occured, return -1
      SET SWP_Ret_Value = -1;
   end if;


-- REDO THE INVENTORY

-- declare a cursor to iterate through the order details
   OPEN cOrderDetail;
   SET NO_DATA = 0;
   FETCH cOrderDetail INTO v_OrderLineNumber,v_ItemID,v_OrderQty,v_BackOrderQyyty,v_WarehouseID,v_WarehouseBinID, 
   v_SerialNumber;
   WHILE NO_DATA = 0 DO
	-- get the difference between the order quantity and the back order (quantity in inventory)
      SET v_DifferenceQty = v_OrderQty -v_BackOrderQyyty;
      SET @SWV_Error = 0;
      CALL WarehouseBinLockGoods2(v_CompanyID,v_DivisionID,v_DepartmentID,v_WarehouseID,v_WarehouseBinID,
      v_ItemID,v_OrderQty,v_BackOrderQyyty,2, v_ReturnStatus);
      IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then
	
--         CLOSE cOD;
		
         SET v_ErrorMessage = 'WarehouseBinLockGoods failed';
         ROLLBACK;
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Order_Cancel',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'OrderNumber',v_OrderNumber);

-- an error occured, return -1
         SET SWP_Ret_Value = -1;
      end if;
      SET @SWV_Error = 0;
      CALL SerialNumber_Cancel2(v_CompanyID,v_DivisionID,v_DepartmentID,v_WarehouseID,v_WarehouseBinID,
      v_SerialNumber,v_ItemID,v_OrderQty, v_ReturnStatus);
      IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then
	
--         CLOSE cOD;
		
         SET v_ErrorMessage = 'SerialNumber_Cancel failed';
         ROLLBACK;
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Order_Cancel',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'OrderNumber',v_OrderNumber);

-- an error occured, return -1
         SET SWP_Ret_Value = -1;
      end if;

	-- get next order detail from the cursor	
      SET NO_DATA = 0;
      FETCH cOrderDetail INTO v_OrderLineNumber,v_ItemID,v_OrderQty,v_BackOrderQyyty,v_WarehouseID,v_WarehouseBinID, 
      v_SerialNumber;
   END WHILE;


   CLOSE cOrderDetail;
 	


-- update order header and set the order cancel date
-- to current date
   SET @SWV_Error = 0;
   UPDATE
   OrderHeader
   SET
   Posted = 0,Backordered = 0,PostedDate = NULL
   WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   OrderNumber = v_OrderNumber;

   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Order header updating failed';
      ROLLBACK;
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Order_Cancel',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'OrderNumber',v_OrderNumber);

-- an error occured, return -1
      SET SWP_Ret_Value = -1;
   end if;

-- update order details - clear backorder flag
   SET @SWV_Error = 0;
   UPDATE
   OrderDetail
   SET
   BackOrdered = 0,BackOrderQyyty = 0
   WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   OrderNumber = v_OrderNumber;

   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Order header updating failed';
      ROLLBACK;
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Order_Cancel',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'OrderNumber',v_OrderNumber);

-- an error occured, return -1
      SET SWP_Ret_Value = -1;
   end if;


-- everyting is ok, return 0
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

   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Order_Cancel',v_ErrorMessage,
   v_ErrorID);

   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'OrderNumber',v_OrderNumber);

-- an error occured, return -1
   SET SWP_Ret_Value = -1;
END;




//

DELIMITER ;

DELIMITER //
DROP PROCEDURE IF EXISTS Order_Recalc2;
//
CREATE                PROCEDURE Order_Recalc2(v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_OrderNumber  NATIONAL VARCHAR(36),INOUT SWP_Ret_Value INT)
   SWL_return:
BEGIN





/*
Name of stored procedure: Order_Recalc
Method: 
	Calculates the amounts of money for a specified Order

Date Created: EDE - 07/28/2015

Input Parameters:

	@CompanyID NVARCHAR(36)		 - the ID of the company
	@DivisionID NVARCHAR(36)	 - the ID of the division
	@DepartmentID NVARCHAR(36)	 - the ID of the department
	@OrderNumber NVARCHAR (36)	 - used to identify the Order

Output Parameters:

	NONE

Called From:

	OrderDetail_SplitToWarehouseBin, Order_Split, Order_Post, Order_Recalc.vb

Calls:

	TaxGroup_GetTotalPercent, VerifyCurrency, Order_CreditCustomerOrder, Error_InsertError, Error_InsertErrorDetail

Last Modified: 

Last Modified By: 

Revision History: 

*/

   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);
   DECLARE v_CurrencyID NATIONAL VARCHAR(3);
   DECLARE v_CustomerID NATIONAL VARCHAR(36);
   DECLARE v_CompanyCurrencyID NATIONAL VARCHAR(3);
   DECLARE v_CurrencyExchangeRate FLOAT;
   DECLARE v_OrderDate DATETIME;
   DECLARE v_Subtotal DECIMAL(19,4);
   DECLARE v_SubtotalMinusDetailDiscount DECIMAL(19,4);
   DECLARE v_Total DECIMAL(19,4);
   DECLARE v_AmountPaid DECIMAL(19,4);
   DECLARE v_TotalTaxable DECIMAL(19,4);
   DECLARE v_DiscountPers FLOAT;
   DECLARE v_DiscountAmount DECIMAL(19,4);
   DECLARE v_TaxAmount DECIMAL(19,4);
   DECLARE v_ItemTaxAmount DECIMAL(19,4);
   DECLARE v_Freight DECIMAL(19,4);
   DECLARE v_Handling DECIMAL(19,4);
   DECLARE v_TaxFreight BOOLEAN;
   DECLARE v_Posted BOOLEAN;
   DECLARE v_Picked BOOLEAN;

   DECLARE v_HighestCredit DECIMAL(19,4);
   DECLARE v_AvailibleCredit DECIMAL(19,4);
   DECLARE v_OldTotal DECIMAL(19,4);
   DECLARE v_TaxPercent FLOAT;
   DECLARE v_HeaderTaxPercent FLOAT;

   DECLARE v_ItemOrderQty FLOAT;
   DECLARE v_ItemUnitPrice FLOAT;
   DECLARE v_ItemTotal DECIMAL(19,4);
   DECLARE v_ItemSubtotal DECIMAL(19,4);
   DECLARE v_ItemDiscountPerc FLOAT;
   DECLARE v_ItemTaxable BOOLEAN;
   DECLARE v_TaxGroupID NATIONAL VARCHAR(36);
   DECLARE v_HeaderTaxGroupID NATIONAL VARCHAR(36);
   DECLARE v_AllowanceDiscountAmount DECIMAL(19,4);


   DECLARE SWV_cOD_CompanyID NATIONAL VARCHAR(36);
   DECLARE SWV_cOD_DivisionID NATIONAL VARCHAR(36);
   DECLARE SWV_cOD_DepartmentID NATIONAL VARCHAR(36);
   DECLARE SWV_cOD_OrderNumber NATIONAL VARCHAR(36);
   DECLARE SWV_cOD_OrderLineNumber NUMERIC(18,0);
   DECLARE v_AllowanceDiscountPercent FLOAT;
   DECLARE v_BalanceDue DECIMAL(19,4);
   DECLARE v_ErrorID INT;
   DECLARE NO_DATA INT DEFAULT 0;
   DECLARE cOD CURSOR
   FOR SELECT 
   IFNULL(OrderQty,0),
		IFNULL(ItemUnitPrice,0),
		IFNULL(DiscountPerc,0),
		IFNULL(Taxable,0),
		IFNULL(TaxGroupID,N''), CompanyID,DivisionID,DepartmentID,OrderNumber,OrderLineNumber
   FROM 
   OrderDetail
   WHERE	
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND OrderNumber = v_OrderNumber
   AND IFNULL(OrderQty,0) >= 0;


-- Next step: Properly credit the customer order
-- We recalulate AllowanceDiscountPercent and store it 
-- in the OrderHeader AllowanceDiscountPerc field
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
      SET NO_DATA = -2;
   END;
   DECLARE CONTINUE HANDLER FOR NOT FOUND SET NO_DATA = -1;
   SET @SWV_Error = 0;
   SET v_TaxPercent = 0;

-- get the information about the order status
   select   IFNULL(Posted,0), IFNULL(Picked,0) INTO v_Posted,v_Picked FROM
   OrderHeader WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   OrderNumber = v_OrderNumber;	

   IF v_Posted = 1 then

      IF v_Picked = 1 then 
	-- if the order is posted and picked return
	
         SET SWP_Ret_Value = 0;
         LEAVE SWL_return;
      end if;
   end if;


-- get the currency id for the order header
   select   CurrencyID, CurrencyExchangeRate, CustomerID, OrderDate, IFNULL(DiscountPers,0), IFNULL(TaxFreight,0), IFNULL(Freight,0), IFNULL(Handling,0), IFNULL(Total,0), TaxGroupID, IFNULL(AmountPaid,0) INTO v_CurrencyID,v_CurrencyExchangeRate,v_CustomerID,v_OrderDate,v_DiscountPers,
   v_TaxFreight,v_Freight,v_Handling,v_OldTotal,v_HeaderTaxGroupID,
   v_AmountPaid FROM
   OrderHeader WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   OrderNumber = v_OrderNumber;

   START TRANSACTION;

   SET @SWV_Error = 0;
   CALL TaxGroup_GetTotalPercent2(v_CompanyID,v_DivisionID,v_DepartmentID,v_HeaderTaxGroupID,v_HeaderTaxPercent);
   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Procedure call TaxGroup_GetTotalPercent failed';
      ROLLBACK;
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Order_Recalc',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'OrderNumber',v_OrderNumber);
      SET SWP_Ret_Value = -1;
   end if;

   SET v_HeaderTaxPercent = IFNULL(v_HeaderTaxPercent,0);

   SET @SWV_Error = 0;
   CALL VerifyCurrency2(v_CompanyID,v_DivisionID,v_DepartmentID,v_OrderDate,1,v_CompanyCurrencyID,
   v_CurrencyID,v_CurrencyExchangeRate);
   IF @SWV_Error <> 0 then

	-- the procedure will return an error code
      SET v_ErrorMessage = 'Currency retrieving failed';
      ROLLBACK;
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Order_Recalc',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'OrderNumber',v_OrderNumber);
      SET SWP_Ret_Value = -1;
   end if;

-- get the details Totals
   SET @SWV_Error = 0;
   CALL Order_CreditCustomerOrder(v_CompanyID,v_DivisionID,v_DepartmentID,v_CustomerID,v_OrderNumber,v_AllowanceDiscountPercent, v_ReturnStatus);
   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then

      SET v_ErrorMessage = 'Crediting the customer order failed';
      ROLLBACK;
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Order_Recalc',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'OrderNumber',v_OrderNumber);
      SET SWP_Ret_Value = -1;
   end if;



   SET v_Subtotal = 0;
   SET v_ItemSubtotal = 0;
   SET v_SubtotalMinusDetailDiscount = 0;
   SET v_TotalTaxable = 0;
   SET v_DiscountAmount = 0;
   SET v_TaxAmount = 0;
   SET v_Total = 0;


-- open the cursor and get the first row
   OPEN cOD;
   SET NO_DATA = 0;
   FETCH cOD INTO v_ItemOrderQty,v_ItemUnitPrice,v_ItemDiscountPerc,v_ItemTaxable,v_TaxGroupID,
   SWV_cOD_CompanyID,SWV_cOD_DivisionID,SWV_cOD_DepartmentID,SWV_cOD_OrderNumber,
   SWV_cOD_OrderLineNumber;
   WHILE NO_DATA = 0 DO
      SET v_TaxPercent = 0;
      SET v_ItemTaxAmount = 0;
	-- update totals

      SET v_ItemSubtotal = fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,v_ItemOrderQty*v_ItemUnitPrice, 
      v_CompanyCurrencyID);
      SET v_Subtotal = v_Subtotal+v_ItemSubtotal;
      SET v_DiscountAmount = fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,v_DiscountAmount+v_ItemOrderQty*v_ItemUnitPrice*(v_ItemDiscountPerc+v_AllowanceDiscountPercent)/100, 
      v_CompanyCurrencyID);

  	-- recalculate the Total for every line of the Order; the total for a line is = OrderQty * ItemUnitPrice * ( 100 - DiscountPerc )/100
      SET v_ItemTotal = fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,v_ItemOrderQty*v_ItemUnitPrice*(100 -v_ItemDiscountPerc -v_AllowanceDiscountPercent)/100,v_CompanyCurrencyID);
      IF v_TaxGroupID <> N'' then
		
         SET @SWV_Error = 0;
         CALL TaxGroup_GetTotalPercent2(v_CompanyID,v_DivisionID,v_DepartmentID,v_TaxGroupID,v_TaxPercent);
         IF @SWV_Error <> 0 then
			
            SET v_ErrorMessage = 'Procedure call TaxGroup_GetTotalPercent failed';
            ROLLBACK;
            CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Order_Recalc',v_ErrorMessage,
            v_ErrorID);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'OrderNumber',v_OrderNumber);
            SET SWP_Ret_Value = -1;
         end if;
      end if;
      SET v_Total = v_Total+v_ItemTotal;
      IF v_ItemTaxable = 1 then
	
         IF v_TaxGroupID = N'' then
		
            SET v_TaxGroupID = v_HeaderTaxGroupID;
            SET v_TaxPercent = v_HeaderTaxPercent;
         end if;
         SET v_ItemTaxAmount =  fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,(v_ItemTotal*v_TaxPercent)/100, 
         v_CompanyCurrencyID);
         SET v_TaxAmount = v_TaxAmount+v_ItemTaxAmount;
         SET v_TotalTaxable = v_TotalTaxable+v_ItemTotal;
         SET v_ItemTotal = v_ItemTotal+v_ItemTaxAmount;
      end if;
	-- update item total
      SET @SWV_Error = 0;
      UPDATE OrderDetail
      SET
      Total = v_ItemTotal,SubTotal = v_ItemSubtotal,TaxPercent = v_TaxPercent,
      TaxGroupID = v_TaxGroupID,TaxAmount = v_ItemTaxAmount
      WHERE OrderDetail.CompanyID = SWV_cOD_CompanyID AND OrderDetail.DivisionID = SWV_cOD_DivisionID AND OrderDetail.DepartmentID = SWV_cOD_DepartmentID AND OrderDetail.OrderNumber = SWV_cOD_OrderNumber AND OrderDetail.OrderLineNumber = SWV_cOD_OrderLineNumber;
      IF @SWV_Error <> 0 then
	
         CLOSE cOD;
		
         SET v_ErrorMessage = 'Updating order detail failed';
         ROLLBACK;
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Order_Recalc',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'OrderNumber',v_OrderNumber);
         SET SWP_Ret_Value = -1;
      end if;
      SET NO_DATA = 0;
      FETCH cOD INTO v_ItemOrderQty,v_ItemUnitPrice,v_ItemDiscountPerc,v_ItemTaxable,v_TaxGroupID,
      SWV_cOD_CompanyID,SWV_cOD_DivisionID,SWV_cOD_DepartmentID,SWV_cOD_OrderNumber,
      SWV_cOD_OrderLineNumber;
   END WHILE;
   CLOSE cOD;



   IF v_Handling > 0 then
      SET v_TaxAmount = fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,v_TaxAmount+v_Handling*v_HeaderTaxPercent/100, 
      v_CompanyCurrencyID);
   end if;
   IF v_Freight > 0 AND v_TaxFreight = 1 then
      SET v_TaxAmount = fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,v_TaxAmount+v_Freight*v_HeaderTaxPercent/100, 
      v_CompanyCurrencyID);
   end if;
   SET v_Total = v_Total+v_Handling+v_Freight+v_TaxAmount;

   SET v_BalanceDue = fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,v_Total -v_AmountPaid,v_CompanyCurrencyID);
   SET @SWV_Error = 0;
   UPDATE
   OrderHeader
   SET
   Subtotal = v_Subtotal,DiscountAmount = v_DiscountAmount,TaxableSubTotal = v_TotalTaxable,
   TaxPercent = v_HeaderTaxPercent,TaxAmount = v_TaxAmount,
   Total = v_Total,BalanceDue = v_BalanceDue
   WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND OrderNumber = v_OrderNumber;

   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Recalculating order header totals failed';
      ROLLBACK;
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Order_Recalc',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'OrderNumber',v_OrderNumber);
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

   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Order_Recalc',v_ErrorMessage,
   v_ErrorID);

   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'OrderNumber',v_OrderNumber);

   SET SWP_Ret_Value = -1;
END;






























//

DELIMITER ;

DELIMITER //
DROP PROCEDURE IF EXISTS Order_CreditCustomerAccount;
//
CREATE    PROCEDURE Order_CreditCustomerAccount(v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_OrderNumber  NATIONAL VARCHAR(36),INOUT SWP_Ret_Value INT)
   SWL_return:
BEGIN

/*
Name of stored procedure: Order_CreditCustomerAccount
Method: 
	Available Credit - Debit the order amount from this amount add this order amount to the booked orders amount,
	 for example booked orders = booked orders + this order amount	
	SalesYTD - SalesYTD = SalesYTD + this order amount	Last Sales Date = today
	if available credit is currently higher than highest credit, then update highest credit
	If Available Credit is less then zero, make set order type equal to Hold

Date Created: EDE - 07/28/2015

Input Parameters:

	@CompanyID NVARCHAR(36)		 - the ID of the company
	@DivisionID NVARCHAR(36)	 - the ID of the division
	@DepartmentID NVARCHAR(36)	 - the ID of the department
	@OrderNumber NVARCHAR (36)	 - the order numeber

Output Parameters:

	NONE

Called From:

	ServiceOrder_Post, ServiceOrder_Split, Order_Split, Order_Post, Order_CreditCustomerAccount.vb

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
   DECLARE v_OrderDate DATETIME;
   DECLARE v_Total DECIMAL(19,4);
   DECLARE v_ConvertedTotal DECIMAL(19,4);
   DECLARE v_HighestCredit DECIMAL(19,4);
   DECLARE v_AvailibleCredit DECIMAL(19,4);

-- select informations about the customer,
-- the total value of the order
-- the currency of the order and the exchange rate
   DECLARE v_ErrorID INT;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
   END;
   select   CustomerID, Total, CurrencyID, CurrencyExchangeRate, OrderDate INTO v_CustomerID,v_Total,v_CurrencyID,v_CurrencyExchangeRate,v_OrderDate FROM
   OrderHeader WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND OrderNumber = v_OrderNumber;

-- adjust the system to for the multicurrency 
   SET @SWV_Error = 0;
   CALL VerifyCurrency2(v_CompanyID,v_DivisionID,v_DepartmentID,v_OrderDate,1,v_CompanyCurrencyID,
   v_CurrencyID,v_CurrencyExchangeRate);
   IF @SWV_Error <> 0 then

	-- the procedure will return an error code
      SET v_ErrorMessage = 'Currency retrieving failed';
      ROLLBACK;
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Order_CreditCustomerAccount',
      v_ErrorMessage,v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'OrderNumber',v_OrderNumber);
      SET SWP_Ret_Value = -1;
   end if;

   SET v_ConvertedTotal = fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,v_Total*v_CurrencyExchangeRate, 
   v_CompanyCurrencyID);

   START TRANSACTION;

-- Available Credit - Debit the order amount from this amount
-- Add this order amount to the booked orders amount, for example booked orders = booked orders + this order amount
-- SalesYTD - SalesYTD = SalesYTD + this order amount
-- Last Sales Date = today
   SET @SWV_Error = 0;
   UPDATE
   CustomerFinancials
   SET
   AvailibleCredit = IFNULL(AvailibleCredit,0) -v_ConvertedTotal,BookedOrders = IFNULL(BookedOrders,0)+v_ConvertedTotal,
   SalesYTD = IFNULL(SalesYTD,0)+v_ConvertedTotal,
   LastSalesDate = v_OrderDate
   WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND CustomerID = v_CustomerID;
   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'customer financials updating failed';
      ROLLBACK;
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Order_CreditCustomerAccount',
      v_ErrorMessage,v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'OrderNumber',v_OrderNumber);
      SET SWP_Ret_Value = -1;
   end if;


-- get the availible credit for the customer
-- and the highest credit the customer ever had to the company
   select   IFNULL(AvailibleCredit,0), IFNULL(HighestCredit,0) INTO v_AvailibleCredit,v_HighestCredit FROM
   CustomerFinancials WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND CustomerID = v_CustomerID;

-- if available credit is currently higher than highest credit, then update highest credit
   IF v_AvailibleCredit > v_HighestCredit then

      SET @SWV_Error = 0;
      UPDATE
      CustomerFinancials
      SET
      HighestCredit = v_AvailibleCredit
      WHERE
      CompanyID = v_CompanyID
      AND DivisionID = v_DivisionID
      AND DepartmentID = v_DepartmentID
      AND CustomerID = v_CustomerID;
      IF @SWV_Error <> 0 then
	
         SET v_ErrorMessage = 'Highest credit updating failed';
         ROLLBACK;
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Order_CreditCustomerAccount',
         v_ErrorMessage,v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'OrderNumber',v_OrderNumber);
         SET SWP_Ret_Value = -1;
      end if;
   end if;
-- If Available Credit is less then zero, make set order type equal to Hold
/*
IF @AvailibleCredit < 0
BEGIN
	UPDATE 
		OrderHeader
	SET 
		OrderTypeID = 'Hold'
	WHERE 
		CompanyID = @CompanyID
		AND DivisionID = @DivisionID
		AND DepartmentID = @DepartmentID
		AND OrderNumber = @OrderNumber
	IF @@ERROR <> 0
	BEGIN
		SET @ErrorMessage = 'Order holding failed'
		GOTO WriteError
	END
END
*/
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

   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Order_CreditCustomerAccount',
   v_ErrorMessage,v_ErrorID);

   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'OrderNumber',v_OrderNumber);

   SET SWP_Ret_Value = -1;
END;




//

DELIMITER ;

DELIMITER //
DROP PROCEDURE IF EXISTS OrderDetail_SplitToWarehouseBin2;
//
CREATE        PROCEDURE OrderDetail_SplitToWarehouseBin2(v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_OrderNumber NATIONAL VARCHAR(36),
	v_BackOrdered BOOLEAN,
	INOUT v_BackOrder BOOLEAN ,INOUT SWP_Ret_Value INT)
   SWL_return:
BEGIN
/*
Name of stored procedure: OrderDetail_SplitToWarehouseBin
Method: 
	this procedure split order items to warehouse bins

Date Created: EDE - 07/28/2015

Input Parameters:

	@CompanyID NVARCHAR(36)		 - the ID of the company
	@DivisionID NVARCHAR(36)	 - the ID of the division
	@DepartmentID NVARCHAR(36)	 - the ID of the department
	@OrderNumber NVARCHAR(36)	 - the order numeber
	@BackOrdered BIT		 - backordered status of the order

Output Parameters:

	@BackOrder BIT 			 - backordered status of the order

Called From:

	Return_Post, Order_Allocate, Order_Post

Calls:

	WarehouseBinLockGoods, Order_Recalc, Error_InsertError, Error_InsertErrorDetail

Last Modified: 

Last Modified By: 

Revision History: 

*/



   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);

   DECLARE v_OrderLineNumber NUMERIC(18,0);
   DECLARE v_PrevWarehouseID NATIONAL VARCHAR(36);
   DECLARE v_PrevWarehouseBinID NATIONAL VARCHAR(36);
   DECLARE v_WarehouseID NATIONAL VARCHAR(36);
   DECLARE v_WarehouseBinID NATIONAL VARCHAR(36);
   DECLARE v_ItemID NATIONAL VARCHAR(36);
   DECLARE v_PrevQty FLOAT;
   DECLARE v_PrevBackOrderQty FLOAT;
   DECLARE v_Qty FLOAT;
   DECLARE v_AvlblQty FLOAT;
   DECLARE v_BackQty FLOAT;
   DECLARE v_First BOOLEAN;
   DECLARE SWV_cOD_CompanyID NATIONAL VARCHAR(36);
   DECLARE SWV_cOD_DivisionID NATIONAL VARCHAR(36);
   DECLARE SWV_cOD_DepartmentID NATIONAL VARCHAR(36);
   DECLARE SWV_cOD_OrderNumber NATIONAL VARCHAR(36);
   DECLARE SWV_cOD_OrderLineNumber NUMERIC(18,0);
   DECLARE v_ErrorID INT;
   DECLARE NO_DATA INT DEFAULT 0;
   DECLARE Counter INT;
   DECLARE Records INT DEFAULT 0;
   DECLARE cOD CURSOR
   FOR SELECT 
   WarehouseID, WarehouseBinID, 
			OrderLineNumber, ItemID, IFNULL(OrderQty,0), IFNULL(BackOrderQyyty,0), CompanyID,DivisionID,DepartmentID,OrderNumber,OrderLineNumber
   FROM 
   OrderDetail
   WHERE	
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND OrderNumber = v_OrderNumber
   AND IFNULL(BackOrdered,0) = IFNULL(v_BackOrdered,0);
	
	-- open the cursor and get the first row
/*   DECLARE cBins CURSOR
   FOR SELECT 
   WarehouseID, WarehouseBinID, Qty, AvlblQty, BackQty
   FROM 
   WarehouseBinsForSplit(v_CompanyID,v_DivisionID,v_DepartmentID,v_PrevWarehouseID,v_PrevWarehouseBinID, 
   v_ItemID,v_PrevQty);*/
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
      SET NO_DATA = -2;
   END;
   DECLARE CONTINUE HANDLER FOR NOT FOUND SET NO_DATA = -1;

   SET @SWV_Error = 0;
   SET v_BackOrder = 0;

   START TRANSACTION;

   OPEN cOD;
   SET NO_DATA = 0;
   FETCH cOD INTO v_PrevWarehouseID,v_PrevWarehouseBinID,v_OrderLineNumber,v_ItemID,v_PrevQty, 
   v_PrevBackOrderQty,SWV_cOD_CompanyID,SWV_cOD_DivisionID,SWV_cOD_DepartmentID,
   SWV_cOD_OrderNumber,SWV_cOD_OrderLineNumber;
   WHILE NO_DATA = 0 DO
      SET v_First = 1;
      IF v_BackOrdered = 1 then
				
         SET @SWV_Error = 0;
         SET v_ReturnStatus = WarehouseBinLockGoods(v_CompanyID,v_DivisionID,v_DepartmentID,v_PrevWarehouseID,v_PrevWarehouseBinID,
         v_ItemID,0,v_PrevBackOrderQty,3);
         IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then
					
            CLOSE cOD;
						
            SET v_ErrorMessage = 'WarehouseBinLockGoods failed';
            ROLLBACK;
            CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'OrderDetail_SplitToWarehouseBin',
            v_ErrorMessage,v_ErrorID);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'OrderNumber',v_OrderNumber);
            SET SWP_Ret_Value = -1;
         end if;
      end if;
--      OPEN cBins;
      SET NO_DATA = 0;
--      FETCH cBins INTO v_WarehouseID,v_WarehouseBinID,v_Qty,v_AvlblQty,v_BackQty;
      SET Counter = WarehouseBinsForSplitCount(v_CompanyID, v_DivisionID, v_DepartmentID, v_PrevWarehouseID, v_PrevWarehouseBinID, v_ItemID, v_PrevQty, 5);      
      SET Records = Records + 1;
      CALL WarehouseBinsForSplitGetRecord(v_CompanyID, v_DivisionID, v_DepartmentID, v_PrevWarehouseID, v_PrevWarehouseBinID, v_ItemID, v_PrevQty, Records, @outIdent, v_WarehouseID, v_WarehouseBinID, v_Qty, v_AvlblQty, v_BackQty );
      	   IF Records = Counter then
		SET NO_DATA = 1;
           end if;
      WHILE NO_DATA = 0 DO
         IF v_BackQty > 0 then
						
            SET v_BackOrder = 1;
         end if;
         IF v_First = 1 then
						
            SET @SWV_Error = 0;
            UPDATE OrderDetail
            SET
            WarehouseID = v_WarehouseID,WarehouseBinID = v_WarehouseBinID,OrderQty = v_Qty,
            BackOrdered =
            CASE WHEN v_BackQty > 0 THEN 1
            ELSE 0 END,BackOrderQyyty = v_BackQty
            WHERE OrderDetail.CompanyID = SWV_cOD_CompanyID AND OrderDetail.DivisionID = SWV_cOD_DivisionID AND OrderDetail.DepartmentID = SWV_cOD_DepartmentID AND OrderDetail.OrderNumber = SWV_cOD_OrderNumber AND OrderDetail.OrderLineNumber = SWV_cOD_OrderLineNumber;
            IF @SWV_Error <> 0 then
							
--               CLOSE cBins;
								
               CLOSE cOD;
								
               SET v_ErrorMessage = 'Updating order detail failed';
               ROLLBACK;
               CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'OrderDetail_SplitToWarehouseBin',
               v_ErrorMessage,v_ErrorID);
               CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'OrderNumber',v_OrderNumber);
               SET SWP_Ret_Value = -1;
            end if;
            SET v_First = 0;
         ELSE
            SET @SWV_Error = 0;
            INSERT INTO OrderDetail(CompanyID,
								DivisionID,
								DepartmentID,
								OrderNumber,
								ItemID,
								WarehouseID,
								WarehouseBinID,
								SerialNumber,
								Description,
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
								TrackingNumber,
								WarehouseBinZone,
								PalletLevel,
								CartonLevel,
								PackLevelA,
								PackLevelB,
								PackLevelC,
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
									OrderNumber,
									ItemID,
									v_WarehouseID,
									v_WarehouseBinID,
									SerialNumber,
									Description,
									v_Qty,
									CASE WHEN v_BackQty > 0 THEN 1
            ELSE 0 END,
									v_BackQty,
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
									TrackingNumber,
									WarehouseBinZone,
									PalletLevel,
									CartonLevel,
									PackLevelA,
									PackLevelB,
									PackLevelC,
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
            AND OrderLineNumber = v_OrderLineNumber;
            IF @SWV_Error <> 0 then
							-- An error occured, go to the error handler
							
--               CLOSE cBins;
								
               CLOSE cOD;
								
               SET v_ErrorMessage = 'Insert into OrderDetail failed';
               ROLLBACK;
               CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'OrderDetail_SplitToWarehouseBin',
               v_ErrorMessage,v_ErrorID);
               CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'OrderNumber',v_OrderNumber);
               SET SWP_Ret_Value = -1;
            end if;
         end if;
         SET @SWV_Error = 0;
         SET v_ReturnStatus = WarehouseBinLockGoods(v_CompanyID,v_DivisionID,v_DepartmentID,v_WarehouseID,v_WarehouseBinID,
         v_ItemID,v_AvlblQty,v_BackQty,1);
         IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then
					
            CLOSE cOD;
						
            SET v_ErrorMessage = 'WarehouseBinLockGoods failed';
            ROLLBACK;
            CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'OrderDetail_SplitToWarehouseBin',
            v_ErrorMessage,v_ErrorID);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'OrderNumber',v_OrderNumber);
            SET SWP_Ret_Value = -1;
         end if;
         SET NO_DATA = 0;
--         FETCH cBins INTO v_WarehouseID,v_WarehouseBinID,v_Qty,v_AvlblQty,v_BackQty;
         IF Records = Counter then
	    SET NO_DATA = 1;
	 ELSE
		SET Records = Records + 1;
	 	CALL WarehouseBinsForSplitGetRecord(v_CompanyID, v_DivisionID, v_DepartmentID, v_PrevWarehouseID, v_PrevWarehouseBinID, v_ItemID, v_PrevQty, Records, @outIdent, v_WarehouseID, v_WarehouseBinID, v_Qty, v_AvlblQty, v_BackQty );
         END IF;
      END WHILE;
--      CLOSE cBins;
			
      SET NO_DATA = 0;
      FETCH cOD INTO v_PrevWarehouseID,v_PrevWarehouseBinID,v_OrderLineNumber,v_ItemID,v_PrevQty, 
      v_PrevBackOrderQty,SWV_cOD_CompanyID,SWV_cOD_DivisionID,SWV_cOD_DepartmentID,
      SWV_cOD_OrderNumber,SWV_cOD_OrderLineNumber;
   END WHILE;
	
   CLOSE cOD;
	


   SET @SWV_Error = 0;
   CALL Order_Recalc2(v_CompanyID,v_DivisionID,v_DepartmentID,v_OrderNumber, v_ReturnStatus);
   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then
	
      SET v_ErrorMessage = 'Recalculating the order failed';
      ROLLBACK;
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'OrderDetail_SplitToWarehouseBin',
      v_ErrorMessage,v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'OrderNumber',v_OrderNumber);
      SET SWP_Ret_Value = -1;
   end if;


   COMMIT;

   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;


   ROLLBACK;

   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'OrderDetail_SplitToWarehouseBin',
   v_ErrorMessage,v_ErrorID);
   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'OrderNumber',v_OrderNumber);
	
   SET SWP_Ret_Value = -1;

END;

//

DELIMITER ;

DELIMITER //
DROP PROCEDURE IF EXISTS InvoiceDetail_SplitToWarehouseBin2;
//
CREATE   PROCEDURE InvoiceDetail_SplitToWarehouseBin2(v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_InvoiceNumber NATIONAL VARCHAR(36),
	v_BackOrdered BOOLEAN,
	INOUT v_BackOrder BOOLEAN ,INOUT SWP_Ret_Value INT)
   SWL_return:
BEGIN
/*
Name of stored procedure: InvoiceDetail_SplitToWarehouseBin
Method: 
	this procedure split Invoice items to warehouse bins

Date Created: EDE - 07/28/2015

Input Parameters:

	@CompanyID NVARCHAR(36)		 - the ID of the company
	@DivisionID NVARCHAR(36)	 - the ID of the division
	@DepartmentID NVARCHAR(36)	 - the ID of the department
	@InvoiceNumber NVARCHAR(36)	 - the Invoice numeber
	@BackInvoiceed BIT		 - backInvoiceed status of the Invoice

Output Parameters:

	@BackInvoice BIT 			 - backInvoiceed status of the Invoice

Called From:

	Return_Post, Invoice_Allocate, Invoice_Post

Calls:

	WarehouseBinLockGoods, Invoice_Recalc, Error_InsertError, Error_InsertErrorDetail

Last Modified: 

Last Modified By: 

Revision History: 

*/



   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);

   DECLARE v_InvoiceLineNumber NUMERIC(18,0);
   DECLARE v_PrevWarehouseID NATIONAL VARCHAR(36);
   DECLARE v_PrevWarehouseBinID NATIONAL VARCHAR(36);
   DECLARE v_WarehouseID NATIONAL VARCHAR(36);
   DECLARE v_WarehouseBinID NATIONAL VARCHAR(36);
   DECLARE v_ItemID NATIONAL VARCHAR(36);
   DECLARE v_PrevQty FLOAT;
   DECLARE v_PrevBackInvoiceQty FLOAT;
   DECLARE v_Qty FLOAT;
   DECLARE v_AvlblQty FLOAT;
   DECLARE v_BackQty FLOAT;
   DECLARE v_First BOOLEAN;
   DECLARE SWV_cOD_CompanyID NATIONAL VARCHAR(36);
   DECLARE SWV_cOD_DivisionID NATIONAL VARCHAR(36);
   DECLARE SWV_cOD_DepartmentID NATIONAL VARCHAR(36);
   DECLARE SWV_cOD_InvoiceNumber NATIONAL VARCHAR(36);
   DECLARE SWV_cOD_InvoiceLineNumber NUMERIC(18,0);
   DECLARE v_ErrorID INT;
   DECLARE NO_DATA INT DEFAULT 0;
   DECLARE Counter INT;
   DECLARE Records INT DEFAULT 0;
   DECLARE cOD CURSOR
   FOR SELECT 
   WarehouseID, WarehouseBinID, 
			InvoiceLineNumber, ItemID, IFNULL(OrderQty,0), IFNULL(BackOrderQty,0), CompanyID,DivisionID,DepartmentID,InvoiceNumber,InvoiceLineNumber
   FROM 
   InvoiceDetail
   WHERE	
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND InvoiceNumber = v_InvoiceNumber
   AND IFNULL(BackOrdered,0) = IFNULL(v_BackOrdered,0);
	
	-- open the cursor and get the first row
/*   DECLARE cBins CURSOR
   FOR SELECT 
   WarehouseID, WarehouseBinID, Qty, AvlblQty, BackQty
   FROM 
   WarehouseBinsForSplit(v_CompanyID,v_DivisionID,v_DepartmentID,v_PrevWarehouseID,v_PrevWarehouseBinID, 
   v_ItemID,v_PrevQty);*/
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
      SET NO_DATA = -2;
   END;
   DECLARE CONTINUE HANDLER FOR NOT FOUND SET NO_DATA = -1;

   SET @SWV_Error = 0;
   SET v_BackOrder = 0;

   START TRANSACTION;

   OPEN cOD;
   SET NO_DATA = 0;
   FETCH cOD INTO v_PrevWarehouseID,v_PrevWarehouseBinID,v_InvoiceLineNumber,v_ItemID,v_PrevQty, 
   v_PrevBackInvoiceQty,SWV_cOD_CompanyID,SWV_cOD_DivisionID,SWV_cOD_DepartmentID,
   SWV_cOD_InvoiceNumber,SWV_cOD_InvoiceLineNumber;
   WHILE NO_DATA = 0 DO
      SET v_First = 1;
      IF v_BackOrdered = 1 then
				
         SET @SWV_Error = 0;
         SET v_ReturnStatus = WarehouseBinLockGoods(v_CompanyID,v_DivisionID,v_DepartmentID,v_PrevWarehouseID,v_PrevWarehouseBinID,
         v_ItemID,0,v_PrevBackInvoiceQty,3);
         IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then
					
            CLOSE cOD;
						
            SET v_ErrorMessage = 'WarehouseBinLockGoods failed';
            ROLLBACK;
            CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'InvoiceDetail_SplitToWarehouseBin',
            v_ErrorMessage,v_ErrorID);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
            SET SWP_Ret_Value = -1;
         end if;
      end if;

      
      -- OPEN cBins;
      SET NO_DATA = 0;
      -- FETCH cBins INTO v_WarehouseID,v_WarehouseBinID,v_Qty,v_AvlblQty,v_BackQty;
      SET Counter = WarehouseBinsForSplitCount(v_CompanyID, v_DivisionID, v_DepartmentID, v_PrevWarehouseID, v_PrevWarehouseBinID, v_ItemID, v_PrevQty, 5);      
      SET Records = Records + 1;
      CALL WarehouseBinsForSplitGetRecord(v_CompanyID, v_DivisionID, v_DepartmentID, v_PrevWarehouseID, v_PrevWarehouseBinID, v_ItemID, v_PrevQty, Records, @outIdent, v_WarehouseID, v_WarehouseBinID, v_Qty, v_AvlblQty, v_BackQty );
      WHILE NO_DATA = 0 DO
         IF v_BackQty > 0 then
						
            SET v_BackOrder = 1;
         end if;
         IF v_First = 1 then
						
            SET @SWV_Error = 0;
            UPDATE InvoiceDetail
            SET
            WarehouseID = v_WarehouseID,WarehouseBinID = v_WarehouseBinID,OrderQty = v_Qty,
            BackOrdered =
            CASE WHEN v_BackQty > 0 THEN 1
            ELSE 0 END,BackOrderQty = v_BackQty
            WHERE InvoiceDetail.CompanyID = SWV_cOD_CompanyID AND InvoiceDetail.DivisionID = SWV_cOD_DivisionID AND InvoiceDetail.DepartmentID = SWV_cOD_DepartmentID AND InvoiceDetail.InvoiceNumber = SWV_cOD_InvoiceNumber AND InvoiceDetail.InvoiceLineNumber = SWV_cOD_InvoiceLineNumber;
            IF @SWV_Error <> 0 then
							
               -- CLOSE cBins;
								
               CLOSE cOD;
								
               SET v_ErrorMessage = 'Updating Invoice detail failed';
               ROLLBACK;
               CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'InvoiceDetail_SplitToWarehouseBin',
               v_ErrorMessage,v_ErrorID);
               CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
               SET SWP_Ret_Value = -1;
            end if;
            SET v_First = 0;
         ELSE
            SET @SWV_Error = 0;
            INSERT INTO InvoiceDetail(CompanyID,
								DivisionID,
								DepartmentID,
								InvoiceNumber,
								ItemID,
								WarehouseID,
								WarehouseBinID,
								SerialNumber,
								Description,
								OrderQty,
								BackOrdered,
								BackOrderQty,
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
								TrackingNumber,
								WarehouseBinZone,
								PalletLevel,
								CartonLevel,
								PackLevelA,
								PackLevelB,
								PackLevelC,
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
									InvoiceNumber,
									ItemID,
									v_WarehouseID,
									v_WarehouseBinID,
									SerialNumber,
									Description,
									v_Qty,
									CASE WHEN v_BackQty > 0 THEN 1
            ELSE 0 END,
									v_BackQty,
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
									TrackingNumber,
									WarehouseBinZone,
									PalletLevel,
									CartonLevel,
									PackLevelA,
									PackLevelB,
									PackLevelC,
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
            InvoiceDetail
            WHERE
            CompanyID = v_CompanyID
            AND DivisionID = v_DivisionID
            AND DepartmentID = v_DepartmentID
            AND InvoiceNumber = v_InvoiceNumber
            AND InvoiceLineNumber = v_InvoiceLineNumber;
            IF @SWV_Error <> 0 then
							-- An error occured, go to the error handler
							
               -- CLOSE cBins;
								
               CLOSE cOD;
								
               SET v_ErrorMessage = 'Insert into InvoiceDetail failed';
               ROLLBACK;
               CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'InvoiceDetail_SplitToWarehouseBin',
               v_ErrorMessage,v_ErrorID);
               CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
               SET SWP_Ret_Value = -1;
            end if;
         end if;
         SET @SWV_Error = 0;
         SET v_ReturnStatus = WarehouseBinLockGoods(v_CompanyID,v_DivisionID,v_DepartmentID,v_WarehouseID,v_WarehouseBinID,
         v_ItemID,v_AvlblQty,v_BackQty,1);
         IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then
					
            CLOSE cOD;
						
            SET v_ErrorMessage = 'WarehouseBinLockGoods failed';
            ROLLBACK;
            CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'InvoiceDetail_SplitToWarehouseBin',
            v_ErrorMessage,v_ErrorID);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
            SET SWP_Ret_Value = -1;
         end if;
	 
         IF Records = Counter then
	    SET NO_DATA = 1;
	 ELSE
		SET Records = Records + 1;
	 	CALL WarehouseBinsForSplitGetRecord(v_CompanyID, v_DivisionID, v_DepartmentID, v_PrevWarehouseID, v_PrevWarehouseBinID, v_ItemID, v_PrevQty, Records, @outIdent, v_WarehouseID, v_WarehouseBinID, v_Qty, v_AvlblQty, v_BackQty );
         END IF;
     	 -- FETCH cBins INTO v_WarehouseID,v_WarehouseBinID,v_Qty,v_AvlblQty,v_BackQty;
      END WHILE;
      -- CLOSE cBins;
			
      SET NO_DATA = 0;
      FETCH cOD INTO v_PrevWarehouseID,v_PrevWarehouseBinID,v_InvoiceLineNumber,v_ItemID,v_PrevQty, 
      v_PrevBackInvoiceQty,SWV_cOD_CompanyID,SWV_cOD_DivisionID,SWV_cOD_DepartmentID,
      SWV_cOD_InvoiceNumber,SWV_cOD_InvoiceLineNumber;
   END WHILE;
	
   CLOSE cOD;
	


   SET @SWV_Error = 0;
   CALL Invoice_Recalc2(v_CompanyID,v_DivisionID,v_DepartmentID,v_InvoiceNumber, v_ReturnStatus);
   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then
	
      SET v_ErrorMessage = 'Recalculating the Invoice failed';
      ROLLBACK;
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'InvoiceDetail_SplitToWarehouseBin',
      v_ErrorMessage,v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
      SET SWP_Ret_Value = -1;
   end if;


   COMMIT;

   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;


   ROLLBACK;

   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'InvoiceDetail_SplitToWarehouseBin',
   v_ErrorMessage,v_ErrorID);
   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
	
   SET SWP_Ret_Value = -1;

END;

//

DELIMITER ;

DELIMITER //
DROP PROCEDURE IF EXISTS Purchase_Post2;
//
CREATE                          PROCEDURE Purchase_Post2(v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_PurchaseNumber NATIONAL VARCHAR(36),
	INOUT v_PostingResult NATIONAL VARCHAR(200) ,INOUT SWP_Ret_Value INT)
   SWL_return:
BEGIN
/*
Name of stored procedure: Purchase_Post
Method: 
	Posts a purchase order to the system and updates Vendor Financials

Date Created: EDE - 07/28/2015

Input Parameters:

	@CompanyID NVARCHAR(36)		 - the ID of the company
	@DivisionID NVARCHAR(36)	 - the ID of the division
	@DepartmentID NVARCHAR(36)	 - the ID of the department
	@PurchaseNumber NVARCHAR(36)	 - the number of purchase

Output Parameters:

	@PostingResult NVARCHAR(200)	 - the error message that should be displayed for end user

Called From:

	EDI_PurchaseProcessingOutbound, Purchase_Control, EDI_ShipmentNoticesProcessingInbound, Purchase_Post.vb

Calls:

	Inventory_GetWarehouseForPurchase, WarehouseBinPutGoods, VerifyCurrency, Terms_GetNetDays, Error_InsertError, Error_InsertErrorDetail

Last Modified: 

Last Modified By: 

Revision History: 

*/

   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);

   DECLARE v_GLTransNumber NATIONAL VARCHAR(36);
   DECLARE v_OrderWarehouseID NATIONAL VARCHAR(36);
   DECLARE v_DetailWarehouseID NATIONAL VARCHAR(36);
   DECLARE v_WarehouseBinID NATIONAL VARCHAR(36);
   DECLARE v_PurchaseDetailID CHAR(144);
   DECLARE v_ItemID NATIONAL VARCHAR(36);
   DECLARE v_OrderQty FLOAT;
   DECLARE v_SerialNumber NATIONAL VARCHAR(50);
   DECLARE v_PurchaseLineNumber NUMERIC(18,0);

   DECLARE v_CompanyCurrencyID NATIONAL VARCHAR(3);

   DECLARE v_Total DECIMAL(19,4);


   DECLARE v_VendorID NATIONAL VARCHAR(50);
   DECLARE v_VendorCurrencyID NATIONAL VARCHAR(3);
   DECLARE v_PurchaseCurrencyID NATIONAL VARCHAR(3);
   DECLARE v_PurchaseCurrencyExchangeRate FLOAT;
   DECLARE v_PurchaseDate DATETIME;
   DECLARE v_PurchaseAmount DECIMAL(19,4);
   DECLARE v_HighestCredit DECIMAL(19,4);
   DECLARE v_AvailableCredit DECIMAL(19,4);

   DECLARE v_PurchasePosted BOOLEAN;
   DECLARE v_PurchasePaid BOOLEAN;
   DECLARE v_PurchaseShipped BOOLEAN;
   DECLARE v_PurchaseReceived BOOLEAN;
   DECLARE v_PurchaseCancelDate DATETIME;
   DECLARE v_AmountPaid DECIMAL(19,4);
   DECLARE v_IncomeTaxRate FLOAT;

   DECLARE v_IsOverflow BOOLEAN;

   DECLARE v_TermsID NATIONAL VARCHAR(36);
   DECLARE v_NetDays INT;

   DECLARE v_ErrorID INT;
   DECLARE NO_DATA INT DEFAULT 0;
   DECLARE v_Success INT;
   DECLARE v_Amount FLOAT;
   DECLARE cPurchaseDetail CURSOR FOR
   SELECT
   PurchaseNumber,
		PurchaseLineNumber,
		ItemID, 

		WarehouseID, 
		WarehouseBinID,
		IFNULL(OrderQty,0),
		IFNULL(Total,0),
		SerialNumber
   FROM
   PurchaseDetail
   WHERE
   PurchaseNumber = v_PurchaseNumber AND
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID;

   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
      SET NO_DATA = -2;
   END;
   DECLARE CONTINUE HANDLER FOR NOT FOUND SET NO_DATA = -1;
   SET @SWV_Error = 0;
   IF NOT EXISTS(SELECT * FROM
   PurchaseDetail
   WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   PurchaseNumber = v_PurchaseNumber) then

      SET v_PostingResult = 'Purchase was not posted: there are no detail items';
      SET SWP_Ret_Value = -1;
      LEAVE SWL_return;
   end if;

   IF EXISTS(SELECT * FROM
   PurchaseDetail
   WHERE
		(IFNULL(OrderQty,0) = 0) AND -- OR ISNULL(ItemCost,0)=0) 
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   PurchaseNumber = v_PurchaseNumber) then

      SET v_PostingResult = 'Purchase was not posted: there is the detail item with zero Qty';
      SET SWP_Ret_Value = -1;
      LEAVE SWL_return;
   end if;
-- if purchase is posted return
   select   IFNULL(Posted,0), IFNULL(Received,0), PurchaseCancelDate, IFNULL(Paid,0), IFNULL(AmountPaid,0) INTO v_PurchasePosted,v_PurchaseReceived,v_PurchaseCancelDate,v_PurchasePaid,
   v_AmountPaid FROM
   PurchaseHeader WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   PurchaseNumber = v_PurchaseNumber;

   IF v_PurchasePosted <> 0 then

      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;
   end if;
-- if order is canceled
-- or order is not posted exit the procedure
   IF ((NOT v_PurchaseCancelDate IS NULL) AND v_PurchaseCancelDate < CURRENT_TIMESTAMP) then

      SET v_PostingResult = 'Purchase was not posted: Cancel date is older then current date.';
      SET SWP_Ret_Value = -1;
      LEAVE SWL_return;
   end if;

   IF EXISTS(SELECT * FROM
   PurchaseDetail
   WHERE
   IFNULL(ItemUnitPrice,0) = 0 AND
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   PurchaseNumber = v_PurchaseNumber) then

      SET v_PostingResult = 'Warning: there is the detail item with zero item unit price, but purchase was posted nevertheless.';
   end if;


   START TRANSACTION;
-- EXEC @ReturnStatus = Purchase_RecalcCLR @CompanyID, @DivisionID, @DepartmentID, @PurchaseNumber
   SET @SWV_Error = 0;
   CALL Purchase_Recalc2(v_CompanyID,v_DivisionID,v_DepartmentID,v_PurchaseNumber, v_ReturnStatus);
   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then

      SET v_ErrorMessage = 'Recalculating the purchase failed';
      ROLLBACK;
-- the error handler
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Purchase_Post',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseNumber',v_PurchaseNumber);
      SET SWP_Ret_Value = -1;
   end if;

-- credit the invenory
-- get the warehouse for the order
   SET @SWV_Error = 0;
   CALL Inventory_GetWarehouseForPurchase2(v_CompanyID,v_DivisionID,v_DepartmentID,v_PurchaseNumber,v_OrderWarehouseID, v_ReturnStatus);


   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then

      SET v_ErrorMessage = 'Inventory_GetWarehouseForPurchase call failed';
      ROLLBACK;
-- the error handler
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Purchase_Post',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseNumber',v_PurchaseNumber);
      SET SWP_Ret_Value = -1;
   end if;	

-- create cursor for iteration of purchase details	
   OPEN cPurchaseDetail;
   SET NO_DATA = 0;
   FETCH cPurchaseDetail INTO v_PurchaseDetailID,v_PurchaseLineNumber,v_ItemID,v_DetailWarehouseID,v_WarehouseBinID, 
   v_OrderQty,v_Total,v_SerialNumber;

   WHILE NO_DATA = 0 DO
      SET @SWV_Error = 0;
      CALL WarehouseBinPutGoods2(v_CompanyID,v_DivisionID,v_DepartmentID,v_DetailWarehouseID,v_WarehouseBinID,
      v_ItemID,v_PurchaseNumber,v_PurchaseLineNumber,v_SerialNumber,NULL,
      v_OrderQty,1,v_IsOverflow, v_ReturnStatus);
      IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then
	
         CLOSE cPurchaseDetail;
		
         SET v_ErrorMessage = 'WarehouseBinPutGoods failed';
         ROLLBACK;
-- the error handler
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Purchase_Post',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseNumber',v_PurchaseNumber);
         SET SWP_Ret_Value = -1;
      end if;
      SET NO_DATA = 0;
      FETCH cPurchaseDetail INTO v_PurchaseDetailID,v_PurchaseLineNumber,v_ItemID,v_DetailWarehouseID,v_WarehouseBinID, 
      v_OrderQty,v_Total,v_SerialNumber;
   END WHILE;

   CLOSE cPurchaseDetail;


-- get the purchase amount


-- get values from PurchaseHeader
   select   VendorID, IFNULL(Total,0), CurrencyID, CurrencyExchangeRate, PurchaseDate, IFNULL(IncomeTaxRate,0) INTO v_VendorID,v_PurchaseAmount,v_PurchaseCurrencyID,v_PurchaseCurrencyExchangeRate,
   v_PurchaseDate,v_IncomeTaxRate FROM
   PurchaseHeader WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   PurchaseNumber = v_PurchaseNumber;

   SET @SWV_Error = 0;
   CALL VerifyCurrency(v_CompanyID,v_DivisionID,v_DepartmentID,v_PurchaseDate,2,v_CompanyCurrencyID,
   v_PurchaseCurrencyID,v_PurchaseCurrencyExchangeRate);
   IF @SWV_Error <> 0 then

	-- the procedure will return an error code
      SET v_ErrorMessage = 'Currency retrieving failed';
      ROLLBACK;
-- the error handler
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Purchase_Post',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseNumber',v_PurchaseNumber);
      SET SWP_Ret_Value = -1;
   end if;


-- transform if necessary (different currencies)
   IF v_PurchaseCurrencyID <> v_CompanyCurrencyID then

      SET v_PurchaseAmount = v_PurchaseAmount*v_PurchaseCurrencyExchangeRate;
   end if;
-- update vendor financials
   select   IFNULL(HighestCredit,0), IFNULL(AvailableCredit,0) INTO v_HighestCredit,v_AvailableCredit FROM
   VendorFinancials WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   VendorID = v_VendorID;

   SET v_AvailableCredit = v_AvailableCredit -v_PurchaseAmount;
   IF v_HighestCredit < v_AvailableCredit then
      SET v_HighestCredit = v_AvailableCredit;
   end if;

   SET @SWV_Error = 0;
   UPDATE
   VendorFinancials
   SET
   AvailableCredit = v_AvailableCredit,HighestCredit = v_HighestCredit,BookedPurchaseOrders = IFNULL(BookedPurchaseOrders,0)+v_PurchaseAmount
   WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   VendorID = v_VendorID;
   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Update VendorFinancials failed';
      ROLLBACK;
-- the error handler
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Purchase_Post',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseNumber',v_PurchaseNumber);
      SET SWP_Ret_Value = -1;
   end if;	

-- check special terms
   select   TermsID INTO v_TermsID FROM
   VendorInformation WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND VendorID = v_VendorID;

   SET @SWV_Error = 0;
   CALL Terms_GetNetDays(v_CompanyID,v_DivisionID,v_DepartmentID,v_TermsID,v_NetDays);
   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Terms_GetNetDays the order failed';
      ROLLBACK;
-- the error handler
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Purchase_Post',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseNumber',v_PurchaseNumber);
      SET SWP_Ret_Value = -1;
   end if;



   SET @SWV_Error = 0;
   UPDATE PurchaseHeader
   SET
   PurchaseHeader.TermsID = v_TermsID,PurchaseHeader.PurchaseDueDate = TIMESTAMPADD(Day,v_NetDays,PurchaseDate)
   WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND PurchaseNumber = v_PurchaseNumber;
   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Checking special terms failed';
      ROLLBACK;
-- the error handler
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Purchase_Post',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseNumber',v_PurchaseNumber);
      SET SWP_Ret_Value = -1;
   end if;


   UPDATE
   PurchaseHeader
   SET
   Posted = 1,PostedDate = CURRENT_TIMESTAMP
   WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   PurchaseNumber = v_PurchaseNumber;


   IF (v_PurchaseReceived = 1) then

	
      SET @SWV_Error = 0;
      CALL Receiving_Post(v_CompanyID,v_DivisionID,v_DepartmentID,v_PurchaseNumber,v_Success);
      IF @SWV_Error <> 0 OR v_Success <> 1 then
	
         SET v_ErrorMessage = 'Receiving Post failed';
         ROLLBACK;
-- the error handler
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Purchase_Post',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseNumber',v_PurchaseNumber);
         SET SWP_Ret_Value = -1;
      end if;
   end if;


-- create IncomeTaxSection CreditMemo
   if v_IncomeTaxRate is not null and v_PurchaseAmount > 0 and v_IncomeTaxRate > 0 then

	
      set v_Amount = fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,v_PurchaseAmount*v_IncomeTaxRate/100, 
      v_CompanyCurrencyID);
      SET @SWV_Error = 0;
      SET v_ReturnStatus = CreditMemo_CreateIncomeTax(v_CompanyID,v_DivisionID,v_DepartmentID,v_PurchaseNumber,v_Amount);
      IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then
	
         SET v_ErrorMessage = 'Income Tax credit memo creation is failed';
         ROLLBACK;
-- the error handler
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Purchase_Post',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseNumber',v_PurchaseNumber);
         SET SWP_Ret_Value = -1;
      end if;
      SET @SWV_Error = 0;
      SET v_ReturnStatus = DebitMemo_CreateIncomeTax(v_CompanyID,v_DivisionID,v_DepartmentID,v_PurchaseNumber,v_Amount);
      IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then
	
         SET v_ErrorMessage = 'Income Tax credit memo creation is failed';
         ROLLBACK;
-- the error handler
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Purchase_Post',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseNumber',v_PurchaseNumber);
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
   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Purchase_Post',v_ErrorMessage,
   v_ErrorID);

   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseNumber',v_PurchaseNumber);
   SET SWP_Ret_Value = -1;
END;




//

DELIMITER ;
