update databaseinfo set value='2019_07_10',lastupdate=now() WHERE id='Version';

DELIMITER //
DROP PROCEDURE IF EXISTS Return_Post;
//
CREATE            PROCEDURE Return_Post(v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_OrderNumber NATIONAL VARCHAR(36),
	INOUT v_PostingResult NATIONAL VARCHAR(200) ,INOUT SWP_Ret_Value INT)
   SWL_return:
BEGIN



/*
Name of stored procedure: Return_Post
Method:
	this procedure makes all the arrangement for an return to be posted and posts it to General Ledger
Date Created: EDE - 07/28/2015
Input Parameters:
	@CompanyID NVARCHAR(36)		 - the ID of the company
	@DivisionID NVARCHAR(36)	 - the ID of the division
	@DepartmentID NVARCHAR(36)	 - the ID of the department
	@OrderNumber NVARCHAR(36)	 - the return number
Output Parameters:
	@PostingResult NVARCHAR(200)	 - the error message that should be displayed for end user
Called From:
	Return_Post.vb
Calls:
	Error_InsertError, Inventory_GetWarehouseForOrderItem, SerialNumber_Get, Return_MakeInvoiceReceipt, OrderDetail_SplitToWarehouseBin, Customer_CreateFromVendor, Order_CreateAssembly, Return_Recalc, Terms_GetNetDays, Return_CreditVendorAccount, Error_InsertErrorDetail
Last Modified:
Last Modified By:
Revision History:
*/
   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);
   DECLARE v_VendorID NATIONAL VARCHAR(50);
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
   DECLARE v_OrderDate DATETIME;
   DECLARE v_HighestCredit DECIMAL(19,4);
   DECLARE v_AvailableCredit DECIMAL(19,4);
   DECLARE v_OrderAmount DECIMAL(19,4);
   DECLARE v_WarehouseID NATIONAL VARCHAR(36);
   DECLARE v_WarehouseBinID NATIONAL VARCHAR(36);
   DECLARE v_SerialNumber NATIONAL VARCHAR(50);
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

      SET v_PostingResult = 'Return was not posted: there are no detail items';
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

      SET v_PostingResult = 'Return was not posted: there is the detail item with undefined Order Qty value';
      SET SWP_Ret_Value = -1;
      LEAVE SWL_return;
   end if;
-- get the information about Vendor, Order type, amount paid, payment method,
-- post status of the order, order cancel date and order amount
-- from the order header table for the company, division, department and
-- order specified in the procedure parameters
   select   CustomerID, OrderTypeID, IFNULL(AmountPaid,0), PaymentMethodID, IFNULL(Posted,0), OrderCancelDate, IFNULL(Total,0), IFNULL(v_OrderDate,CURRENT_TIMESTAMP), TermsID INTO v_VendorID,v_OrderTypeID,v_AmountPaid,v_PaymentMethodID,v_Posted,v_OrderCancelDate,
   v_OrderAmount,v_OrderDate,v_TermsID FROM
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
   START TRANSACTION;
-- Check order on Hold status
-- recalculate the order to be sure that it has correct total
-- EXEC @ReturnStatus = Return_RecalcCLR @CompanyID, @DivisionID, @DepartmentID, @OrderNumber
   SET @SWV_Error = 0;
   CALL Return_Recalc2(v_CompanyID,v_DivisionID,v_DepartmentID,v_OrderNumber, v_ReturnStatus);
   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then

      SET v_ErrorMessage = 'Recalculating the return failed';
      ROLLBACK;
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Return_Post',v_ErrorMessage,v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'OrderNumber',v_OrderNumber);
      SET SWP_Ret_Value = -1;
   end if;
   select   IFNULL(Total,0) INTO v_OrderAmount FROM
   OrderHeader WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND OrderNumber = v_OrderNumber;
-- check special terms
   IF v_TermsID IS NULL then

      select   TermsID INTO v_TermsID FROM
      VendorInformation WHERE
      CompanyID = v_CompanyID
      AND DivisionID = v_DivisionID
      AND DepartmentID = v_DepartmentID
      AND VendorID = v_VendorID;
   end if;
   SET @SWV_Error = 0;
   CALL Terms_GetNetDays2(v_CompanyID,v_DivisionID,v_DepartmentID,v_TermsID,v_NetDays);
   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Terms_GetNetDays the order failed';
      ROLLBACK;
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Return_Post',v_ErrorMessage,v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'OrderNumber',v_OrderNumber);
      SET SWP_Ret_Value = -1;
   end if;
   SET @SWV_Error = 0;
   UPDATE OrderHeader
   SET
   OrderHeader.TermsID = v_TermsID,OrderHeader.OrderDueDate = TIMESTAMPADD(Day,v_NetDays,v_OrderDate),
   OrderHeader.OrderDate = v_OrderDate
   WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND OrderNumber = v_OrderNumber;
   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Checking special terms failed';
      ROLLBACK;
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Return_Post',v_ErrorMessage,v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'OrderNumber',v_OrderNumber);
      SET SWP_Ret_Value = -1;
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
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Return_Post',v_ErrorMessage,v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'OrderNumber',v_OrderNumber);
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
         CALL Order_CreateAssembly(v_CompanyID,v_DivisionID,v_DepartmentID,v_ItemID,v_WarehouseID,v_DifferenceQty,
         v_Result, v_ReturnStatus);
			-- check for errors
         IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then
			
            CLOSE cOrderDetail;
				
            -- NOT SUPPORTED Print CONCAT('ItemID: ',convert(CHAR(20),@ItemID),' OrderQty: ', convert(CHAR(20),@OrderQty))
SET v_ErrorMessage = 'Order_CreateAssembly call failed';
            ROLLBACK;
            CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Return_Post',v_ErrorMessage,v_ErrorID);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'OrderNumber',v_OrderNumber);
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
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Return_Post',v_ErrorMessage,v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'OrderNumber',v_OrderNumber);
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
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Return_Post',v_ErrorMessage,v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'OrderNumber',v_OrderNumber);
         SET SWP_Ret_Value = -1;
      end if;
      SET NO_DATA = 0;
      FETCH cOrderDetail INTO v_OrderLineNumber,v_ItemID,v_OrderQty,v_WarehouseID,v_WarehouseBinID,v_SerialNumber;
   END WHILE;
   CLOSE cOrderDetail;

-- If there is no inventory for any of the items on the order, flip the backorder flag
   SET @SWV_Error = 0;
   IF v_FlipBackOrderFlag = 1 then

      SET v_ErrorMessage = 'There is no inventory for any of the items on the return order';
      ROLLBACK;
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Return_Post',v_ErrorMessage,v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'OrderNumber',v_OrderNumber);
      SET SWP_Ret_Value = -1;
   end if;
   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then

      SET v_ErrorMessage = 'Crediting the customer account failed';
      ROLLBACK;
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Return_Post',v_ErrorMessage,v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'OrderNumber',v_OrderNumber);
      SET SWP_Ret_Value = -1;
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
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Return_Post',v_ErrorMessage,v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'OrderNumber',v_OrderNumber);
      SET SWP_Ret_Value = -1;
   end if;
-- Add vendor to customers table
   SET @SWV_Error = 0;
   CALL Customer_CreateFromVendor(v_CompanyID,v_DivisionID,v_DepartmentID,v_VendorID, v_ReturnStatus);
-- An error occured, go to the error handler
   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then

      SET v_ErrorMessage = 'Customer_CreateFromVendor call failed';
      ROLLBACK;
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Return_Post',v_ErrorMessage,v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'OrderNumber',v_OrderNumber);
      SET SWP_Ret_Value = -1;
   end if;
-- update vendor financials
-- we should increase VendorReturns amount (the amount for open returns)
-- and set last return date
   SET @SWV_Error = 0;
   UPDATE
   VendorFinancials
   SET
   VendorReturns = IFNULL(VendorReturns,0)+v_OrderAmount,LastReturnDate = v_OrderDate
   WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   VendorID = v_VendorID;
   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Update VendorFinancials failed';
      ROLLBACK;
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Return_Post',v_ErrorMessage,v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'OrderNumber',v_OrderNumber);
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
      CALL Return_MakeInvoiceReceipt(v_CompanyID,v_DivisionID,v_DepartmentID,v_OrderNumber, v_ReturnStatus);
   end if;
   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then

      SET v_ErrorMessage = 'Making the invoice receipt failed';
      ROLLBACK;
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Return_Post',v_ErrorMessage,v_ErrorID);
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
   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Return_Post',v_ErrorMessage,v_ErrorID);
   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'OrderNumber',v_OrderNumber);
   SET SWP_Ret_Value = -1;
END;






//

DELIMITER ;

DELIMITER //
DROP PROCEDURE IF EXISTS Return_Recalc2;
//
CREATE            PROCEDURE Return_Recalc2(v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_OrderNumber  NATIONAL VARCHAR(36),INOUT SWP_Ret_Value INT)
   SWL_return:
BEGIN



















/*
Name of stored procedure: Return_Recalc
Method: 
	Calculates the amounts of money for a specified return

Date Created: EDE - 07/28/2015

Input Parameters:

	@CompanyID NVARCHAR(36)		 - the ID of the company
	@DivisionID NVARCHAR(36)	 - the ID of the division
	@DepartmentID NVARCHAR(36)	 - the ID of the department
	@OrderNumber NVARCHAR (36)	 - the return number

Output Parameters:

	NONE

Called From:

	Return_Split, Return_Post, ReturnDetail_SplitToWarehouseBin, Return_Recalc.vb

Calls:

	TaxGroup_GetTotalPercent, VerifyCurrency, Return_CreditVendorOrder, Error_InsertError, Error_InsertErrorDetail

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
   select   CurrencyID, CurrencyExchangeRate, CustomerID, OrderDate, IFNULL(DiscountPers,0), IFNULL(TaxFreight,0), IFNULL(Freight,0), IFNULL(Handling,0), TaxGroupID, IFNULL(AmountPaid,0) INTO v_CurrencyID,v_CurrencyExchangeRate,v_CustomerID,v_OrderDate,v_DiscountPers,
   v_TaxFreight,v_Freight,v_Handling,v_HeaderTaxGroupID,v_AmountPaid FROM
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
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Return_Recalc',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'OrderNumber',v_OrderNumber);
      SET SWP_Ret_Value = -1;
   end if;

   SET v_HeaderTaxPercent = IFNULL(v_HeaderTaxPercent,0);

   SET @SWV_Error = 0;
   CALL VerifyCurrency2(v_CompanyID,v_DivisionID,v_DepartmentID,v_OrderDate,1,v_CompanyCurrencyID,
   v_CurrencyID,v_CurrencyExchangeRate);
   SET @SWV_Error = 0;
   IF @SWV_Error <> 0 then

	-- the procedure will return an error code
      SET v_ErrorMessage = 'Currency retrieving failed';
      ROLLBACK;
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Return_Recalc',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'OrderNumber',v_OrderNumber);
      SET SWP_Ret_Value = -1;
   end if;

-- get the details Totals
   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then

      SET v_ErrorMessage = 'Crediting the customer order failed';
      ROLLBACK;
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Return_Recalc',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'OrderNumber',v_OrderNumber);
      SET SWP_Ret_Value = -1;
   end if;



   SET v_Subtotal = 0;
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
      SET v_DiscountAmount = fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,v_DiscountAmount+v_ItemOrderQty*v_ItemUnitPrice*(v_ItemDiscountPerc)/100,v_CompanyCurrencyID);

  -- recalculate the Total for every line of the Order; the total for a line is = OrderQty * ItemUnitPrice * ( 100 - DiscountPerc )/100
      SET v_ItemTotal = fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,v_ItemOrderQty*v_ItemUnitPrice*(100 -v_ItemDiscountPerc)/100, 
      v_CompanyCurrencyID);
      IF v_TaxGroupID <> N'' then
		
         SET @SWV_Error = 0;
         CALL TaxGroup_GetTotalPercent2(v_CompanyID,v_DivisionID,v_DepartmentID,v_TaxGroupID,v_TaxPercent);
         IF @SWV_Error <> 0 then
			
            SET v_ErrorMessage = 'Procedure call TaxGroup_GetTotalPercent failed';
            ROLLBACK;
            CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Return_Recalc',v_ErrorMessage,
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
         SET v_ItemTaxAmount = fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,(v_ItemTotal*v_TaxPercent)/100, 
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
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Return_Recalc',v_ErrorMessage,
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
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Return_Recalc',v_ErrorMessage,
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



   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Return_Recalc',v_ErrorMessage,
   v_ErrorID);

   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'OrderNumber',v_OrderNumber);

   SET SWP_Ret_Value = -1;
END;



































//

DELIMITER ;

DELIMITER //
DROP PROCEDURE IF EXISTS ReturnInvoice_CreateFromReturn2;
//
CREATE       PROCEDURE ReturnInvoice_CreateFromReturn2(v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_OrderNumber  NATIONAL VARCHAR(36),
	INOUT v_InvoiceNumber NATIONAL VARCHAR(36)  ,INOUT SWP_Ret_Value INT)
   SWL_return:
BEGIN




















/*
Name of stored procedure: ReturnInvoice_CreateFromReturn
Method: 
	for a specified return order verify if allready exists an return Invoice; if so, @InvoiceNumber parameter will store the number of this invoice
	if an return invoice does not exists then creates one using the return order as pattern and  @InvoiceNumber parameter will store the number of the new return invoice;

Date Created: EDE - 07/28/2015

Input Parameters:

	@CompanyID NVARCHAR(36)		 - the ID of the company
	@DivisionID NVARCHAR(36)	 - the ID of the division
	@DepartmentID NVARCHAR(36)	 - the ID of the department
	@OrderNumber NVARCHAR (36)	 - the return number

Output Parameters:

	@InvoiceNumber NVARCHAR (36)	 - if an return invoice does not exists then creates one using the return order as pattern and  @InvoiceNumber parameter will store the number of the new return invoice;

Called From:

	Return_MakeInvoiceReceipt, Invoice_AllReturns, ReturnInvoice_CreateFromReturn.vb

Calls:

	GetNextEntityID, ReturnInvoice_Post, Error_InsertError, Error_InsertErrorDetail

Last Modified: 

Last Modified By: 

Revision History: 

*/

   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);

-- check if the invoice for the specified order exists
   DECLARE v_CompanyCurrencyID NATIONAL VARCHAR(3);
   DECLARE v_PostingResult NATIONAL VARCHAR(200);
   DECLARE v_OrderAmount DECIMAL(19,4);
   DECLARE v_VendorID NATIONAL VARCHAR(36);
   DECLARE v_ErrorID INT;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
--      GET DIAGNOSTICS CONDITION 1
  --        @p1 = RETURNED_SQLSTATE, @p2 = MESSAGE_TEXT;
    --  SELECT @p1, @p2;
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

	-- if exists, we get the invoice number and exit
      select   InvoiceNumber INTO v_InvoiceNumber FROM
      InvoiceHeader WHERE
      CompanyID = v_CompanyID
      AND DivisionID = v_DivisionID
      AND DepartmentID = v_DepartmentID
      AND OrderNumber  = v_OrderNumber;
      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;
   end if;



   select   IFNULL(CurrencyID,N'') INTO v_CompanyCurrencyID FROM Companies WHERE CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID   LIMIT 1;


   START TRANSACTION;

-- get the new invoice number
   SET @SWV_Error = 0;
   CALL GetNextEntityID2(v_CompanyID,v_DivisionID,v_DepartmentID,'NextInvoiceNumber',v_InvoiceNumber, v_ReturnStatus);
   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then
-- An error occured, go to the error handler

      SET v_InvoiceNumber = N'';
      SET v_ErrorMessage = 'GetNextEntityID call failed';
      ROLLBACK;
-- the error handler
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'ReturnInvoice_CreateFromReturn',
      v_ErrorMessage,v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'OrderNumber',v_OrderNumber);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
      SET SWP_Ret_Value = -1;
   end if;

-- create the invoice header getting all the data from the order
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
	        now(),
		0,
		Backordered,
		0,
		now(),
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
-- An error occured, go to the error handler

      SET v_InvoiceNumber = N'';
      SET v_ErrorMessage = 'Insert into InvoiceHeader failed';
      ROLLBACK;
-- the error handler
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'ReturnInvoice_CreateFromReturn',
      v_ErrorMessage,v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'OrderNumber',v_OrderNumber);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
      SET SWP_Ret_Value = -1;
   end if;


-- create the invoice details getting all the data from the order
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
   AND IFNULL(Total,0) > 0;


   IF @SWV_Error <> 0 then
-- An error occured, go to the error handler

      SET v_InvoiceNumber = N'';
      SET v_ErrorMessage = 'Insert into InvoiceDetail failed';
      ROLLBACK;
-- the error handler
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'ReturnInvoice_CreateFromReturn',
      v_ErrorMessage,v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'OrderNumber',v_OrderNumber);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
      SET SWP_Ret_Value = -1;
   end if;


-- POST THE INVOICE
/*
call the procedure thet posts the new created invoice
parameters	@CompanyID NVARCHAR(36),
		@DivisionID NVARCHAR(36),
		@DepartmentID NVARCHAR(36),
		@InvoiceNumber NVARCHAR (36)
		used to identify the invoice
*/
   SET @SWV_Error = 0;
   CALL ReturnInvoice_Post2(v_CompanyID,v_DivisionID,v_DepartmentID,v_InvoiceNumber,v_PostingResult, v_ReturnStatus);
   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then

      SET v_ErrorMessage = 'Posting invoice failed';
      ROLLBACK;
-- the error handler
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'ReturnInvoice_CreateFromReturn',
      v_ErrorMessage,v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'OrderNumber',v_OrderNumber);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
      SET SWP_Ret_Value = -1;
   end if;


-- Update the invoiced flag and 
-- InvoiceNumber, InvoiceDate for the order taken from the invoice inserted above
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
-- An error occured, go to the error handler

      SET v_InvoiceNumber = N'';
      SET v_ErrorMessage = 'Update OrderHeader failed';
      ROLLBACK;
-- the error handler
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'ReturnInvoice_CreateFromReturn',
      v_ErrorMessage,v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'OrderNumber',v_OrderNumber);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
      SET SWP_Ret_Value = -1;
   end if;


-- update vendor financials
-- Vendor financials was recalculated inside ReturnInvoice_Post procedure
-- but we chanded Invoiced flag of Return and this will affect 
-- to VendorReturns, ReturnsYTD and ReturnsLifetime values
   select   fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,IFNULL(Total,0)*IFNULL(CurrencyExchangeRate,1), 
   v_CompanyCurrencyID), CustomerID INTO v_OrderAmount,v_VendorID FROM
   OrderHeader WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND OrderNumber = v_OrderNumber;


   SET @SWV_Error = 0;
   UPDATE
   VendorFinancials
   SET
   VendorReturns = IFNULL(VendorReturns,0) -v_OrderAmount,ReturnsYTD = IFNULL(ReturnsYTD,0)+v_OrderAmount,
   ReturnsLifetime = IFNULL(ReturnsLifetime,0)+v_OrderAmount
   WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   VendorID = v_VendorID;
   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Update VendorFinancials failed';
      ROLLBACK;
-- the error handler
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'ReturnInvoice_CreateFromReturn',
      v_ErrorMessage,v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'OrderNumber',v_OrderNumber);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
      SET SWP_Ret_Value = -1;
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
   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'ReturnInvoice_CreateFromReturn',
   v_ErrorMessage,v_ErrorID);

   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'OrderNumber',v_OrderNumber);
   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);

   SET SWP_Ret_Value = -1;
END;


















//

DELIMITER ;

DELIMITER //
DROP PROCEDURE IF EXISTS Invoice_AllReturns;
//
CREATE  PROCEDURE Invoice_AllReturns(v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),INOUT SWP_Ret_Value INT)
   SWL_return:
BEGIN












/*
Name of stored procedure: Invoice_AllReturns
Method: 
	Creates invoices for all non-invoiced returns

Date Created: EDE - 07/28/2015

Input Parameters:

	@CompanyID NVARCHAR(36)		 - the ID of the company
	@DivisionID NVARCHAR(36)	 - the ID of the division
	@DepartmentID NVARCHAR(36)	 - the ID of the department

Output Parameters:

	NONE

Called From:

	Invoice_AllReturns.vb

Calls:

	ReturnInvoice_CreateFromReturn, Error_InsertError

Last Modified: 

Last Modified By: 

Revision History: 

*/

   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);

   DECLARE v_OrderNumber NATIONAL VARCHAR(36);
   DECLARE v_InvoiceNumber NATIONAL VARCHAR(36);

   DECLARE v_ErrorID INT;
   DECLARE NO_DATA INT DEFAULT 0;
   DECLARE cOrder CURSOR FOR
   SELECT
   OrderNumber
   FROM
   OrderHeader
   WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   Shipped = 1 
   AND IFNULL(Invoiced,0) = 0
   AND TransactionTypeID = 'Return';

   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
      SET NO_DATA = -2;
   END;
   DECLARE CONTINUE HANDLER FOR NOT FOUND SET NO_DATA = -1;
   SET @SWV_Error = 0;
   START TRANSACTION;

   OPEN cOrder;
   SET NO_DATA = 0;
   FETCH cOrder INTO v_OrderNumber;
   WHILE NO_DATA = 0 DO
      SET @SWV_Error = 0;
      CALL ReturnInvoice_CreateFromReturn(v_CompanyID,v_DivisionID,v_DepartmentID,v_OrderNumber,v_InvoiceNumber, v_ReturnStatus);
      IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then
	
         CLOSE cOrder;
		
         ROLLBACK;
-- the error handler
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Invoice_AllReturns','',v_ErrorID);
         SET SWP_Ret_Value = -1;
      end if;
      SET NO_DATA = 0;
      FETCH cOrder INTO v_OrderNumber;
   END WHILE;

   CLOSE cOrder;


	
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
   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Invoice_AllReturns','',v_ErrorID);

   SET SWP_Ret_Value = -1;
END;



//

DELIMITER ;

DELIMITER //
DROP PROCEDURE IF EXISTS ReturnInvoice_Post2;
//
CREATE             PROCEDURE ReturnInvoice_Post2(v_CompanyID NATIONAL VARCHAR(36), 
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_InvoiceNumber NATIONAL VARCHAR(36) ,
	INOUT v_PostingResult NATIONAL VARCHAR(200) ,INOUT SWP_Ret_Value INT)
   SWL_return:
BEGIN



/*
Name of stored procedure: ReturnInvoice_Post
Method: 
	takes all the necessary actions to post an invoice

Date Created: EDE - 07/28/2015

Input Parameters:

	@CompanyID NVARCHAR(36)		 - the ID of the company
	@DivisionID NVARCHAR(36)	 - the ID of the division
	@DepartmentID NVARCHAR(36)	 - the ID of the department

Output Parameters:

	@InvoiceNumber NVARCHAR(36)	 - the return invoice number
	@PostingResult NVARCHAR(200)	 - the error message that should be displayed for end user

Called From:

	Invoice_Control, ReturnInvoice_CreateFromReturn, Invoice_PostReturn.vb

Calls:

	VendorFinancials_ReCalc, ReturnReceipt_CreateFromInvoice, CreditMemo_CreateFromReturnInvoice, Error_InsertError, Error_InsertErrorDetail, LedgerMain_VerifyPeriod, Inventory_CreateILTransaction, ReturnInvoice_Recalc, CreditMemo_Post, ReturnInvoice_AdjustInventory, VerifyCurrency, ReturnInvoice_CreateGLTransaction, ReturnReceipt_Post

Last Modified: 

Last Modified By: 

Revision History: 

*/

   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);

   DECLARE v_Rest DECIMAL(19,4);
   DECLARE v_PostDate NATIONAL VARCHAR(1);
   DECLARE v_TranDate DATETIME;
   DECLARE v_PeriodToPost INT;
   DECLARE v_PeriodClosed INT;
   DECLARE v_InvoiceType NATIONAL VARCHAR(36);
   DECLARE v_BankKey NATIONAL VARCHAR(36);
   DECLARE v_Amount DECIMAL(19,4);
   DECLARE v_TotalAmount DECIMAL(19,4);
   DECLARE v_ConvertedAmount DECIMAL(19,4);
   DECLARE v_ConvertedTotalAmount DECIMAL(19,4);
   DECLARE v_CurrencyID NATIONAL VARCHAR(3);
   DECLARE v_CurrencyExchangeRate FLOAT;
   DECLARE v_CustomerSalesAcct NATIONAL VARCHAR(36);
   DECLARE v_VendorID NATIONAL VARCHAR(36);
   DECLARE v_DefaultInventoryCostingMethod CHAR(1);
   DECLARE v_InventoryCost DECIMAL(19,4);

   DECLARE v_InvoiceLineNumber NUMERIC(18,0);
   DECLARE v_ItemID NATIONAL VARCHAR(36);
   DECLARE v_OrderQty NATIONAL VARCHAR(36);
   DECLARE v_ItemUnitPrice DECIMAL(19,4);
   DECLARE v_ItemCost DECIMAL(19,4);
   DECLARE v_ItemCurrencyID NATIONAL VARCHAR(3); 
   DECLARE v_CompanyCurrencyID NATIONAL VARCHAR(3);
   DECLARE v_ItemCurrencyExchangeRate FLOAT;
   DECLARE v_InvoiceDate DATETIME;
   DECLARE v_Posted BOOLEAN;
   DECLARE v_ProjectID NATIONAL VARCHAR(36);
   DECLARE v_PaymentMethodID NATIONAL VARCHAR(36);
   DECLARE v_ReceiptID NATIONAL VARCHAR(36);
   DECLARE v_Cleared BOOLEAN;
   DECLARE v_Success BOOLEAN;
   DECLARE v_ConvertedItemCost DECIMAL(19,4);
-- We select OrderQty as negative value
-- to post it to InventoryLedger table as outgoing inventory
   DECLARE v_ErrorID INT;
   DECLARE NO_DATA INT DEFAULT 0;
   DECLARE v_CreditMemoNumber NATIONAL VARCHAR(36);
   DECLARE cInvoiceDetail CURSOR FOR
   SELECT
   InvoiceLineNumber,
		ItemID,
		IFNULL(ItemUnitPrice,0),
		IFNULL(ItemCost,0),
		-IFNULL(OrderQty,0) 
   FROM
   InvoiceDetail
   WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   InvoiceNumber = v_InvoiceNumber;

   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
--      GET DIAGNOSTICS CONDITION 1
  --        @p1 = RETURNED_SQLSTATE, @p2 = MESSAGE_TEXT;
    --  SELECT @p1, @p2;
      SET @SWV_Error = 1;
      SET NO_DATA = -2;
   END;
   DECLARE CONTINUE HANDLER FOR NOT FOUND SET NO_DATA = -1;
   SET @SWV_Error = 0;
   IF NOT EXISTS(SELECT * FROM
   InvoiceDetail
   WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   InvoiceNumber = v_InvoiceNumber) then

      SET v_PostingResult = 'Return Invoice was not posted: there are no detail items';
      SET SWP_Ret_Value = -1;
      LEAVE SWL_return;
   end if;

   IF EXISTS(SELECT * FROM
   InvoiceDetail
   WHERE
   IFNULL(OrderQty,0) = 0 AND
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   InvoiceNumber = v_InvoiceNumber) then

      SET v_PostingResult = 'Return Invoice was not posted: there is the detail item with undefined Order Qty value';
      SET SWP_Ret_Value = -1;
      LEAVE SWL_return;
   end if;

   select   Posted INTO v_Posted FROM
   InvoiceHeader WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   InvoiceNumber = v_InvoiceNumber;
	
-- if the invoice is allready posted return	
   IF v_Posted = 1 then

      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;
   end if;

-- get current posting Period from companies
   select   IFNULL(DefaultGLPostingDate,'1') INTO v_PostDate FROM
   Companies WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID;

   START TRANSACTION;
-- Recalculate the invoice before posting
-- EXEC @ReturnStatus = ReturnInvoice_RecalcCLR @CompanyID,@DivisionID,@DepartmentID, @InvoiceNumber
   SET @SWV_Error = 0;
   CALL ReturnInvoice_Recalc2(v_CompanyID,v_DivisionID,v_DepartmentID,v_InvoiceNumber, v_ReturnStatus);
   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then
-- An error occured, go to the error handler

      SET v_ErrorMessage = 'ReturnInvoice_Recalc call failed';
      ROLLBACK;
-- the error handler
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Invoice_PostReturn',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
      SET SWP_Ret_Value = -1;
   end if;



-- get informations from invoice
   select   IFNULL(TransactionTypeID,N''), IFNULL(AmountPaid,0), IFNULL(Total,0), CurrencyID, CurrencyExchangeRate, InvoiceDate, IFNULL(GLSalesAccount,N''), IFNULL(GLSalesAccount,N''), CustomerID, IFNULL(PaymentMethodID,N''), CASE CreditCardApprovalNumber
   WHEN NULL THEN 0
   ELSE 1
   END INTO v_InvoiceType,v_Amount,v_TotalAmount,v_CurrencyID,v_CurrencyExchangeRate,
   v_InvoiceDate,v_CustomerSalesAcct,v_BankKey,v_VendorID,v_PaymentMethodID,
   v_Cleared FROM
   InvoiceHeader WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND InvoiceNumber = v_InvoiceNumber;

   select   ProjectID INTO v_ProjectID FROM InvoiceDetail WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   InvoiceNumber = v_InvoiceNumber AND
   NOT ProjectID IS NULL   LIMIT 1;



   SET @SWV_Error = 0;
   CALL VerifyCurrency2(v_CompanyID,v_DivisionID,v_DepartmentID,v_InvoiceDate,1,v_CompanyCurrencyID,
   v_CurrencyID,v_CurrencyExchangeRate);
   IF @SWV_Error <> 0 then

	-- the procedure will return an error code
      SET v_ErrorMessage = 'Currency retrieving failed';
      ROLLBACK;
-- the error handler
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Invoice_PostReturn',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
      SET SWP_Ret_Value = -1;
   end if;


-- begin the posting process

-- get the post date
   IF v_PostDate = '1' then
      SET v_TranDate = CURRENT_TIMESTAMP;
   ELSE
      select   IFNULL(InvoiceDate,CURRENT_TIMESTAMP) INTO v_TranDate FROM
      InvoiceHeader WHERE
      CompanyID = v_CompanyID
      AND DivisionID = v_DivisionID
      AND DepartmentID = v_DepartmentID
      AND InvoiceNumber = v_InvoiceNumber;
   end if;

-- verify the Period of time
   SET @SWV_Error = 0;
   CALL LedgerMain_VerifyPeriod2(v_CompanyID,v_DivisionID,v_DepartmentID,v_TranDate,v_PeriodToPost,v_PeriodClosed, v_ReturnStatus);
   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then
-- An error occured, go to the error handler

      SET v_ErrorMessage = 'LedgerMain_VerifyPeriod call failed';
      ROLLBACK;
-- the error handler
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Invoice_PostReturn',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
      SET SWP_Ret_Value = -1;
   end if;

   IF v_PeriodClosed <> 0 then
-- the Period is closed, go to the error handler
-- and set the apropriate error message

      SET v_ErrorMessage = 'Period is closed';
      ROLLBACK;
-- the error handler
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Invoice_PostReturn',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
      SET SWP_Ret_Value = -1;
   end if;

-- debit the inventory from the Committed field
   SET @SWV_Error = 0;
   CALL ReturnInvoice_AdjustInventory(v_CompanyID,v_DivisionID,v_DepartmentID,v_InvoiceNumber, v_ReturnStatus);
   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then
-- An error occured, go to the error handler

      SET v_ErrorMessage = 'ReturnInvoice_AdjustInventory call failed';
      ROLLBACK;
-- the error handler
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Invoice_PostReturn',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
      SET SWP_Ret_Value = -1;
   end if;


-- get the amount unpaid
   select   IFNULL(Total,0) -IFNULL(AmountPaid,0) INTO v_Rest FROM
   InvoiceHeader WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND InvoiceNumber = v_InvoiceNumber;
   SET v_Rest = fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,v_Rest,v_CompanyCurrencyID);

   IF ABS(v_Rest) > 0.005 then

      IF v_Rest < 0 then
	
		
	
		-- Create credit memo for extra money
         SET v_Rest = -v_Rest; -- we should post extra money as positive value
         SET @SWV_Error = 0;
         CALL CreditMemo_CreateFromReturnInvoice2(v_CompanyID,v_DivisionID,v_DepartmentID,v_InvoiceNumber,v_Rest,v_CreditMemoNumber, v_ReturnStatus);
         IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then
		-- An error occured, go to the error handler
		
            SET v_ErrorMessage = 'CreditMemo_CreateFromReturnInvoice call failed';
            ROLLBACK;
-- the error handler
            CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Invoice_PostReturn',v_ErrorMessage,
            v_ErrorID);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
            SET SWP_Ret_Value = -1;
         end if;
         SET @SWV_Error = 0;
         CALL CreditMemo_Post(v_CompanyID,v_DivisionID,v_DepartmentID,v_CreditMemoNumber,v_PostingResult, v_ReturnStatus);
         IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then
		-- An error occured, go to the error handler
		
            SET v_ErrorMessage = 'CreditMemo_Post call failed';
            ROLLBACK;
-- the error handler
            CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Invoice_PostReturn',v_ErrorMessage,
            v_ErrorID);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
            SET SWP_Ret_Value = -1;
         end if;
      end if;
   end if;


	
-- update cost for items in invetory

-- get @DefaultInventoryCostingMethod 
   select   IFNULL(DefaultInventoryCostingMethod,'F') INTO v_DefaultInventoryCostingMethod FROM
   Companies WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID;

   OPEN cInvoiceDetail;
   SET NO_DATA = 0;
   FETCH cInvoiceDetail INTO v_InvoiceLineNumber,v_ItemID,v_ItemUnitPrice,v_ItemCost,v_OrderQty;


   WHILE NO_DATA = 0 DO
	-- Post inventory changes to InventoryLedger table and recalc item cost
      SET v_ConvertedItemCost = fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,v_ItemCost*v_CurrencyExchangeRate, 
      v_CompanyCurrencyID);
      SET @SWV_Error = 0;
      CALL Inventory_CreateILTransaction2(v_CompanyID,v_DivisionID,v_DepartmentID,v_TranDate,v_ItemID,'Return',v_InvoiceNumber,
      v_InvoiceLineNumber,v_OrderQty,v_ConvertedItemCost, v_ReturnStatus);
      IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then
	-- An error occured, go to the error handler
	
         CLOSE cInvoiceDetail;
		
         SET v_ErrorMessage = 'Inventory_CreateILTransaction call failed';
         ROLLBACK;
-- the error handler
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Invoice_PostReturn',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
         SET SWP_Ret_Value = -1;
      end if;
      select(CASE(v_DefaultInventoryCostingMethod)
      WHEN 'F' THEN FIFOCost
      WHEN 'L' THEN LIFOCost
      WHEN 'A' THEN AverageCost
      END) INTO v_InventoryCost FROM
      InventoryItems WHERE
      CompanyID = v_CompanyID AND
      DivisionID = v_DivisionID AND
      DepartmentID = v_DepartmentID AND
      ItemID = v_ItemID;
      IF v_CurrencyID <> v_CompanyCurrencyID then
	
         SET v_InventoryCost = fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,(1/v_CurrencyExchangeRate)*v_InventoryCost, 
         v_CompanyCurrencyID);
      end if;
      SET @SWV_Error = 0;
      UPDATE
      InvoiceDetail
      SET
      ItemCost = CAST(v_InventoryCost AS DECIMAL(19,4))
      WHERE
      CompanyID = v_CompanyID AND
      DivisionID = v_DivisionID AND
      DepartmentID = v_DepartmentID AND
      InvoiceNumber = v_InvoiceNumber AND
      InvoiceLineNumber = v_InvoiceLineNumber;
      IF @SWV_Error <> 0 then
	-- An error occured, go to the error handler
	
         CLOSE cInvoiceDetail;
		
         SET v_ErrorMessage = 'Update InvoiceDetail failed';
         ROLLBACK;
-- the error handler
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Invoice_PostReturn',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
         SET SWP_Ret_Value = -1;
      end if;
      SET NO_DATA = 0;
      FETCH cInvoiceDetail INTO v_InvoiceLineNumber,v_ItemID,v_ItemUnitPrice,v_ItemCost,v_OrderQty;
   END WHILE;

   CLOSE cInvoiceDetail;



-- CREATE THE TRANSACTION FROM THE INVOICE
/*
parameters	@CompanyID NVARCHAR(36),
		@DivisionID NVARCHAR(36),
		@DepartmentID NVARCHAR(36),
		@InvoiceNumber NVARCHAR (36)
		used to identify the invoice
		@PostDate NVARCHAR(1) - used in the process of creation of the transaction
*/
   SET @SWV_Error = 0;
   CALL ReturnInvoice_CreateGLTransaction(v_CompanyID,v_DivisionID,v_DepartmentID,v_InvoiceNumber,v_PostDate, v_ReturnStatus);
   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then
-- An error occured, go to the error handler

      SET v_ErrorMessage = 'ReturnInvoice_CreateGLTransaction call failed';
      ROLLBACK;
-- the error handler
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Invoice_PostReturn',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
      SET SWP_Ret_Value = -1;
   end if;


   SET @SWV_Error = 0;
   UPDATE
   InvoiceHeader
   SET
   Posted = 1,PostedDate = CURRENT_TIMESTAMP
   WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   InvoiceNumber = v_InvoiceNumber;
   IF @SWV_Error <> 0 then
-- An error occured, go to the error handler

      SET v_ErrorMessage = 'InvoiceHeader update failed';
      ROLLBACK;
-- the error handler
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Invoice_PostReturn',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
      SET SWP_Ret_Value = -1;
   end if;	

-- CREATE THE RECEIPT
/*
parameters	@CompanyID NVARCHAR(36),
		@DivisionID NVARCHAR(36),
		@DepartmentID NVARCHAR(36),
		@InvoiceNumber NVARCHAR (36)
		used to identify the order
		@ReceiptID output parameter; stores the new created invoice number; if @ReceiptID is N'' then exit the procedure
*/
   SET @SWV_Error = 0;
   CALL ReturnReceipt_CreateFromInvoice2(v_CompanyID,v_DivisionID,v_DepartmentID,v_InvoiceNumber,v_ReceiptID, v_ReturnStatus);
   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then

      SET v_ErrorMessage = 'Creating receipt from invoice failed';
      ROLLBACK;
-- the error handler
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Invoice_PostReturn',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
      SET SWP_Ret_Value = -1;
   end if;

   IF IFNULL(v_ReceiptID,N'') <> N'' then

	-- POST THE RECEIPT
	/*
	call the procedure thet posts the new created invoice
	parameters	@CompanyID NVARCHAR(36),
			@DivisionID NVARCHAR(36),
			@DepartmentID NVARCHAR(36),
			@ReceiptID NVARCHAR (36)
			used to identify the reciept
			@Succes output parameter; stores the new created invoice number; if @Succes is 0 then exit the procedure
	*/
      SET @SWV_Error = 0;
      CALL ReturnReceipt_Post2(v_CompanyID,v_DivisionID,v_DepartmentID,v_ReceiptID,v_Success,v_PostingResult, v_ReturnStatus);
      IF @SWV_Error <> 0 OR v_ReturnStatus = -1 OR  v_Success = 0 then
	
         SET v_ErrorMessage = 'Posting the receipt failed';
         ROLLBACK;
-- the error handler
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Invoice_PostReturn',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
         SET SWP_Ret_Value = -1;
      end if;
   end if;

   SET @SWV_Error = 0;
   SET v_ReturnStatus = VendorFinancials_ReCalc2(v_CompanyID,v_DivisionID,v_DepartmentID,v_VendorID);
   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 OR  v_Success = 0 then

      SET v_ErrorMessage = 'VendorFinancials_ReCalc2 call failed';
      ROLLBACK;
-- the error handler
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Invoice_PostReturn',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
      SET SWP_Ret_Value = -1;
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
   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Invoice_PostReturn',v_ErrorMessage,
   v_ErrorID);

   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);

   SET SWP_Ret_Value = -1;
END;








//

DELIMITER ;

DELIMITER //
DROP PROCEDURE IF EXISTS ReturnInvoice_Recalc2;
//
CREATE        PROCEDURE ReturnInvoice_Recalc2(v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_InvoiceNumber  NATIONAL VARCHAR(36),INOUT SWP_Ret_Value INT)
   SWL_return:
BEGIN















/*
Name of stored procedure: ReturnInvoice_Recalc
Method: 
	Calculates the amounts of money for a specified return invoice

Date Created: EDE - 07/28/2015

Input Parameters:

	@CompanyID NVARCHAR(36)		 - the ID of the company
	@DivisionID NVARCHAR(36)	 - the ID of the division
	@DepartmentID NVARCHAR(36)	 - the ID of the department
	@InvoiceNumber NVARCHAR (36)	 - the return invoice number

Output Parameters:

	NONE

Called From:

	ReturnInvoice_Post, ReturnInvoice_Recalc.vb

Calls:

	TaxGroup_GetTotalPercent, VerifyCurrency, Error_InsertError, Error_InsertErrorDetail

Last Modified: 

Last Modified By: 

Revision History: 

*/

   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);
   DECLARE v_CurrencyID NATIONAL VARCHAR(3);
   DECLARE v_CurrencyExchangeRate FLOAT;
   DECLARE v_InvoiceDate DATETIME;
   DECLARE v_Subtotal DECIMAL(19,4);
   DECLARE v_SubtotalMinusDetailDiscount DECIMAL(19,4);
   DECLARE v_Total DECIMAL(19,4);
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

   DECLARE v_TaxPercent FLOAT;
   DECLARE v_HeaderTaxPercent FLOAT;

   DECLARE v_ItemOrderQty FLOAT;
   DECLARE v_ItemUnitPrice FLOAT;
   DECLARE v_ItemTotal DECIMAL(19,4);
   DECLARE v_ItemSubTotal DECIMAL(19,4);
   DECLARE v_ItemDiscountPerc FLOAT;
   DECLARE v_ItemTaxable BOOLEAN;
   DECLARE v_TaxGroupID NATIONAL VARCHAR(36);
   DECLARE v_HeaderTaxGroupID NATIONAL VARCHAR(36);
   DECLARE v_AllowanceDiscountAmount DECIMAL(19,4);

   DECLARE v_CompanyCurrencyID NATIONAL VARCHAR(36);

   DECLARE SWV_cInvoiceDetail_CompanyID NATIONAL VARCHAR(36);
   DECLARE SWV_cInvoiceDetail_DivisionID NATIONAL VARCHAR(36);
   DECLARE SWV_cInvoiceDetail_DepartmentID NATIONAL VARCHAR(36);
   DECLARE SWV_cInvoiceDetail_InvoiceNumber NATIONAL VARCHAR(36);
   DECLARE SWV_cInvoiceDetail_InvoiceLineNumber NUMERIC(18,0);
   DECLARE v_ErrorID INT;
   DECLARE NO_DATA INT DEFAULT 0;
   DECLARE cInvoiceDetail CURSOR 
   FOR SELECT 
   IFNULL(OrderQty,0),
		IFNULL(ItemUnitPrice,0),
		IFNULL(DiscountPerc,0),
		IFNULL(Taxable,0),
		IFNULL(TaxGroupID,N''), CompanyID,DivisionID,DepartmentID,InvoiceNumber,InvoiceLineNumber
   FROM 
   InvoiceDetail
   WHERE	
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND InvoiceNumber = v_InvoiceNumber
   AND IFNULL(Total,0) >= 0;

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
   InvoiceHeader WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   InvoiceNumber = v_InvoiceNumber;	

   IF v_Posted = 1 then

      IF v_Picked = 1 then 
	-- if the order is posted and picked return
	
         SET SWP_Ret_Value = 0;
         LEAVE SWL_return;
      end if;
   end if;

-- get the currency id for the order header
   select   CurrencyID, CurrencyExchangeRate, InvoiceDate, IFNULL(DiscountPers,0), IFNULL(TaxFreight,0), IFNULL(Freight,0), IFNULL(Handling,0), TaxGroupID INTO v_CurrencyID,v_CurrencyExchangeRate,v_InvoiceDate,v_DiscountPers,v_TaxFreight,
   v_Freight,v_Handling,v_HeaderTaxGroupID FROM
   InvoiceHeader WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   InvoiceNumber = v_InvoiceNumber;

   START TRANSACTION;

   SET @SWV_Error = 0;
   CALL TaxGroup_GetTotalPercent2(v_CompanyID,v_DivisionID,v_DepartmentID,v_HeaderTaxGroupID,v_HeaderTaxPercent);
   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Procedure call TaxGroup_GetTotalPercent failed';
      ROLLBACK;
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'ReturnInvoice_Recalc',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
      SET SWP_Ret_Value = -1;
   end if;

   SET v_HeaderTaxPercent = IFNULL(v_HeaderTaxPercent,0);

   SET @SWV_Error = 0;
   CALL VerifyCurrency2(v_CompanyID,v_DivisionID,v_DepartmentID,v_InvoiceDate,1,v_CompanyCurrencyID,
   v_CurrencyID,v_CurrencyExchangeRate);
   IF @SWV_Error <> 0 then

	-- the procedure will return an error code
      SET v_ErrorMessage = 'Currency retrieving failed';
      ROLLBACK;
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'ReturnInvoice_Recalc',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
      SET SWP_Ret_Value = -1;
   end if;

-- get the details Totals
   SET v_Subtotal = 0;
   SET v_ItemSubTotal = 0;
   SET v_SubtotalMinusDetailDiscount = 0;
   SET v_TotalTaxable = 0;
   SET v_DiscountAmount = 0;
   SET v_TaxAmount = 0;
   SET v_Total = 0;

-- open the cursor and get the first row
   OPEN cInvoiceDetail;
   SET NO_DATA = 0;
   FETCH cInvoiceDetail INTO v_ItemOrderQty,v_ItemUnitPrice,v_ItemDiscountPerc,v_ItemTaxable,v_TaxGroupID,
   SWV_cInvoiceDetail_CompanyID,SWV_cInvoiceDetail_DivisionID,SWV_cInvoiceDetail_DepartmentID,
   SWV_cInvoiceDetail_InvoiceNumber,SWV_cInvoiceDetail_InvoiceLineNumber;
   WHILE NO_DATA = 0 DO
      SET v_TaxPercent = 0;
      SET v_ItemTaxAmount = 0;
	-- update totals
      SET v_ItemSubTotal = fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,v_ItemOrderQty*v_ItemUnitPrice, 
      v_CompanyCurrencyID);
      SET v_Subtotal = v_Subtotal+v_ItemSubTotal;
      SET v_DiscountAmount = fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,v_DiscountAmount+v_ItemOrderQty*v_ItemUnitPrice*v_ItemDiscountPerc/100,v_CompanyCurrencyID);
    -- recalculate the Total for every line of the Order; the total for a line is = OrderQty * ItemUnitPrice * ( 100 - DiscountPerc )/100
      SET v_ItemTotal = fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,v_ItemOrderQty*v_ItemUnitPrice*(100 -v_ItemDiscountPerc)/100, 
      v_CompanyCurrencyID);
      IF v_TaxGroupID <> N'' then
		
         SET @SWV_Error = 0;
         CALL TaxGroup_GetTotalPercent2(v_CompanyID,v_DivisionID,v_DepartmentID,v_TaxGroupID,v_TaxPercent);
         IF @SWV_Error <> 0 then
			
            SET v_ErrorMessage = 'Procedure call TaxGroup_GetTotalPercent failed';
            ROLLBACK;
            CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'ReturnInvoice_Recalc',v_ErrorMessage,
            v_ErrorID);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
            SET SWP_Ret_Value = -1;
         end if;
      end if;
      SET v_Total = v_Total+v_ItemTotal;
      IF v_ItemTaxable = 1 then
	
         IF v_TaxGroupID = N'' then
		
            SET v_TaxGroupID = v_HeaderTaxGroupID;
            SET v_TaxPercent = v_HeaderTaxPercent;
         end if;
         SET v_ItemTaxAmount = fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,(v_ItemTotal*v_TaxPercent)/100, 
         v_CompanyCurrencyID);
         SET v_TaxAmount = v_TaxAmount+v_ItemTaxAmount;
         SET v_TotalTaxable = v_TotalTaxable+v_ItemTotal;
         SET v_ItemTotal = v_ItemTotal+v_ItemTaxAmount;
      end if;
	-- update item total
      SET @SWV_Error = 0;
      UPDATE InvoiceDetail
      SET
      Total = v_ItemTotal,SubTotal = v_ItemSubTotal,TaxPercent = v_TaxPercent,
      TaxGroupID = v_TaxGroupID,TaxAmount = v_ItemTaxAmount
      WHERE InvoiceDetail.CompanyID = SWV_cInvoiceDetail_CompanyID AND InvoiceDetail.DivisionID = SWV_cInvoiceDetail_DivisionID AND InvoiceDetail.DepartmentID = SWV_cInvoiceDetail_DepartmentID AND InvoiceDetail.InvoiceNumber = SWV_cInvoiceDetail_InvoiceNumber AND InvoiceDetail.InvoiceLineNumber = SWV_cInvoiceDetail_InvoiceLineNumber;
      IF @SWV_Error <> 0 then
	
         CLOSE cInvoiceDetail;
		
         SET v_ErrorMessage = 'Updating order detail failed';
         ROLLBACK;
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'ReturnInvoice_Recalc',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
         SET SWP_Ret_Value = -1;
      end if;
      SET NO_DATA = 0;
      FETCH cInvoiceDetail INTO v_ItemOrderQty,v_ItemUnitPrice,v_ItemDiscountPerc,v_ItemTaxable,v_TaxGroupID,
      SWV_cInvoiceDetail_CompanyID,SWV_cInvoiceDetail_DivisionID,SWV_cInvoiceDetail_DepartmentID,
      SWV_cInvoiceDetail_InvoiceNumber,SWV_cInvoiceDetail_InvoiceLineNumber;
   END WHILE;
   CLOSE cInvoiceDetail;



   IF v_Handling > 0 then
      SET v_TaxAmount = fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,v_TaxAmount+v_Handling*v_HeaderTaxPercent/100, 
      v_CompanyCurrencyID);
   end if;
   IF v_Freight > 0 AND v_TaxFreight = 1 then
      SET v_TaxAmount = fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,v_TaxAmount+v_Freight*v_HeaderTaxPercent/100, 
      v_CompanyCurrencyID);
   end if;
   SET v_Total = v_Total+v_Handling+v_Freight+v_TaxAmount;



   SET @SWV_Error = 0;
   UPDATE
   InvoiceHeader
   SET
   Subtotal = v_Subtotal,DiscountAmount = v_DiscountAmount,TaxableSubTotal = v_TotalTaxable,
   TaxPercent = v_HeaderTaxPercent,TaxAmount = v_TaxAmount,
   Total = v_Total,BalanceDue = fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,v_Total -IFNULL(AmountPaid,0), 
   v_CompanyCurrencyID)
   WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND InvoiceNumber = v_InvoiceNumber;

   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Recalculating order header totals failed';
      ROLLBACK;
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'ReturnInvoice_Recalc',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
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

   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'ReturnInvoice_Recalc',v_ErrorMessage,
   v_ErrorID);

   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);

   SET SWP_Ret_Value = -1;
END;



































//

DELIMITER ;

DELIMITER //
DROP PROCEDURE IF EXISTS ReturnInvoice_CreateGLTransaction;
//
CREATE        PROCEDURE ReturnInvoice_CreateGLTransaction(v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_InvoiceNumber NATIONAL VARCHAR(36),
	v_PostDate  NATIONAL VARCHAR(1),INOUT SWP_Ret_Value INT)
   SWL_return:
BEGIN

/*
Name of stored procedure: ReturnInvoice_CreateGLTransaction
Method:
	Creates a new GL transaction for the return invoice
Date Created: EDE - 07/28/2015
Input Parameters:
	@CompanyID NVARCHAR(36)		 - the ID of the company
	@DivisionID NVARCHAR(36)	 - the ID of the division
	@DepartmentID NVARCHAR(36)	 - the ID of the department
	@InvoiceNumber NVARCHAR(36)	 - the return invoice numebr
	@PostDate NVARCHAR(1)
Output Parameters:
	NONE
Called From:
	ReturnInvoice_Post
Calls:
	VerifyCurrency, GetNextEntityID, TaxGroup_GetTotalPercent, LedgerTransactions_PostCOA_AllRecords, Error_InsertError, Error_InsertErrorDetail
Last Modified:
Last Modified By:
Revision History:
*/
   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);
   DECLARE v_OrderNumber NATIONAL VARCHAR(36);
   DECLARE v_PaymentID NATIONAL VARCHAR(36);
   DECLARE v_GLTransNumber NATIONAL VARCHAR(36);
   DECLARE v_AmountPaid DECIMAL(19,4);
   DECLARE v_Total DECIMAL(19,4);
   DECLARE v_ConvertedTotal DECIMAL(19,4);
   DECLARE v_DiscountAmount DECIMAL(19,4);
   DECLARE v_SalesAcctDefault BOOLEAN;
   DECLARE v_GLSalesAccount NATIONAL VARCHAR(36);
   DECLARE v_GLInvoiceSalesAccount NATIONAL VARCHAR(36);
   DECLARE v_SubTotal DECIMAL(19,4);
   DECLARE v_HeaderTaxAmount DECIMAL(19,4);
   DECLARE v_Freight DECIMAL(19,4);
   DECLARE v_Handling DECIMAL(19,4);
   DECLARE v_CurrencyID NATIONAL VARCHAR(3);
   DECLARE v_CompanyCurrencyID NATIONAL VARCHAR(3);
   DECLARE v_CurrencyExchangeRate FLOAT;
   DECLARE v_InvoiceDate DATETIME;
   DECLARE v_GLARAccount NATIONAL VARCHAR(36);
   DECLARE v_TranDate DATETIME;
   DECLARE v_PostCoa BOOLEAN;
   DECLARE v_ItemTaxAmount DECIMAL(19,4);
   DECLARE v_GLARDiscountAccount NATIONAL VARCHAR(36);
   DECLARE v_GLItemSalesAccount NATIONAL VARCHAR(36);
   DECLARE v_GLTaxAccount NATIONAL VARCHAR(36);
   DECLARE v_GLARFreightAccount NATIONAL VARCHAR(36);
   DECLARE v_GLARHandlingAccount NATIONAL VARCHAR(36);
   DECLARE v_GLItemInventoryAccount NATIONAL VARCHAR(36);
   DECLARE v_GLItemCOGSAccount NATIONAL VARCHAR(36);
   DECLARE v_ProjectID NATIONAL VARCHAR(36);
   DECLARE v_HeaderTaxGroupID NATIONAL VARCHAR(36);
   DECLARE v_HeaderTaxPercent FLOAT;
-- get the ammount of money from the Invoice
   DECLARE v_ItemGLSalesAccount NATIONAL VARCHAR(36);
   DECLARE v_ItemUnitPrice DECIMAL(19,4);
   DECLARE v_ItemProjectID NATIONAL VARCHAR(36);
   DECLARE v_ConvertedDiscountAmount DECIMAL(19,4);
   DECLARE v_TaxAccount NATIONAL VARCHAR(36);
   DECLARE v_TaxAmount DECIMAL(19,4);
   DECLARE v_TaxGroupID NATIONAL VARCHAR(36);
   DECLARE v_TotalTaxPercent FLOAT;
   DECLARE v_DefaultInventoryCostingMethod NATIONAL VARCHAR(1);
   DECLARE NO_DATA INT DEFAULT 0;
   DECLARE v_ErrorID INT;
   DECLARE v_TaxPercent FLOAT;
   DECLARE SWV_CurNum INT DEFAULT 0;
   DECLARE cInvoiceDetail CURSOR FOR
   SELECT
   GLSalesAccount,
		fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,SUM(IFNULL(ItemUnitPrice,0)*IFNULL(OrderQty,0)), 
   v_CompanyCurrencyID),
		ProjectID
   FROM
   InvoiceDetail
   WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   InvoiceNumber = v_InvoiceNumber AND
   IFNULL(SubTotal,0) > 0
   GROUP BY
   GLSalesAccount,ProjectID;
   DECLARE cInvoiceDetail2 CURSOR  FOR SELECT
   SUM(IFNULL(TaxAmount,0)),
		TaxGroupID,
		TaxPercent,
		ProjectID
		
   FROM
   InvoiceDetail
   WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   InvoiceNumber = v_InvoiceNumber AND
   IFNULL(Total,0) > 0
   GROUP BY
   TaxGroupID,TaxPercent,ProjectID;
   DECLARE cTax CURSOR FOR
   SELECT
   IFNULL(Taxes.TaxPercent,0),
			IFNULL(Taxes.GLTaxAccount,(SELECT GLARMiscAccount
      FROM Companies
      WHERE CompanyID = v_CompanyID AND DivisionID  = v_DivisionID AND  DepartmentID = v_DepartmentID))
   FROM
   TaxGroups
   INNER JOIN  TaxGroupDetail ON
   TaxGroupDetail.CompanyID = TaxGroups.CompanyID
   AND TaxGroupDetail.DivisionID = TaxGroups.DivisionID
   AND TaxGroupDetail.DepartmentID = TaxGroups.DepartmentID
   AND TaxGroupDetail.TaxGroupDetailID = TaxGroups.TaxGroupDetailID
   INNER JOIN  Taxes ON
   TaxGroupDetail.CompanyID = Taxes.CompanyID
   AND TaxGroupDetail.DivisionID = Taxes.DivisionID
   AND TaxGroupDetail.DepartmentID = Taxes.DepartmentID
   AND TaxGroupDetail.TaxID = Taxes.TaxID
	
   WHERE
   TaxGroups.CompanyID = v_CompanyID
   AND TaxGroups.DivisionID = v_DivisionID
   AND TaxGroups.DepartmentID = v_DepartmentID
   AND TaxGroups.TaxGroupID = v_TaxGroupID;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
      SET NO_DATA = -2;
   END;
   DECLARE CONTINUE HANDLER FOR NOT FOUND SET NO_DATA = -1;
   select   OrderNumber, IFNULL(AmountPaid,0), IFNULL(Total,0), IFNULL(DiscountAmount,0), IFNULL(TaxPercent,0), IFNULL(TaxAmount,0), IFNULL(Freight,0), IFNULL(Subtotal,0), IFNULL(Handling,0), GLSalesAccount, TaxGroupID INTO v_OrderNumber,v_AmountPaid,v_Total,v_DiscountAmount,v_HeaderTaxPercent,
   v_HeaderTaxAmount,v_Freight,v_SubTotal,v_Handling,v_GLInvoiceSalesAccount,
   v_HeaderTaxGroupID FROM
   InvoiceHeader WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND InvoiceNumber = v_InvoiceNumber;
   SET v_GLInvoiceSalesAccount = IFNULL(v_GLInvoiceSalesAccount,(SELECT GLARSalesAccount
   FROM Companies
   WHERE CompanyID = v_CompanyID AND DivisionID  = v_DivisionID AND  DepartmentID = v_DepartmentID));
   START TRANSACTION;
/*
a temporary table used to collect information about the details of the Transaction;
at the end, the record from this table will be grouped by the GLTransactionAccount and inserted into the LedgerTransactionsDetail
*/
   CREATE TEMPORARY TABLE tt_LedgerDetailTmp  
   (
      GLTransactionNumberDetail BIGINT NOT NULL  PRIMARY KEY  AUTO_INCREMENT,
      GLTransactionAccount NATIONAL VARCHAR(36),
      GLDebitAmount DECIMAL(19,4),
      GLCreditAmount DECIMAL(19,4),
      ProjectID NATIONAL VARCHAR(36)
   )  AUTO_INCREMENT = 1;
   select   CurrencyID, CurrencyExchangeRate, InvoiceDate INTO v_CurrencyID,v_CurrencyExchangeRate,v_InvoiceDate FROM
   InvoiceHeader WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND InvoiceNumber = v_InvoiceNumber;
   SET @SWV_Error = 0;
   CALL VerifyCurrency2(v_CompanyID,v_DivisionID,v_DepartmentID,v_InvoiceDate,1,v_CompanyCurrencyID,
   v_CurrencyID,v_CurrencyExchangeRate);
   IF @SWV_Error <> 0 then

	-- the procedure will return an error code
      SET v_ErrorMessage = 'Currency retrieving failed';
      ROLLBACK;
      DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;
      IF v_ErrorMessage <> '' then

	-- the error handler
	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'ReturnInvoice_CreateGLTransaction',
         v_ErrorMessage,v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
      end if;
      SET SWP_Ret_Value = -1;
   end if;
   SET v_ConvertedTotal = fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,v_Total*v_CurrencyExchangeRate, 
   v_CompanyCurrencyID);
   select   ProjectID INTO v_ProjectID FROM  InvoiceDetail WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND InvoiceNumber = v_InvoiceNumber
   AND NOT ProjectID IS NULL   LIMIT 1;
-- get the transaction number
   SET @SWV_Error = 0;
   CALL GetNextEntityID2(v_CompanyID,v_DivisionID,v_DepartmentID,'NextGLTransNumber',v_GLTransNumber, v_ReturnStatus);
   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then
-- An error occured, go to the error handler

      SET v_ErrorMessage = 'GetNextEntityID call failed';
      ROLLBACK;
      DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;
      IF v_ErrorMessage <> '' then

	-- the error handler
	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'ReturnInvoice_CreateGLTransaction',
         v_ErrorMessage,v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
      end if;
      SET SWP_Ret_Value = -1;
   end if;
-- Insert into LedgerTransactions
-- first calculate the Transaction date
   select   CASE v_PostDate WHEN '1' THEN CURRENT_TIMESTAMP ELSE InvoiceDate END INTO v_TranDate FROM
   InvoiceHeader WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND InvoiceNumber = v_InvoiceNumber;
   SET @SWV_Error = 0;
   INSERT INTO LedgerTransactions(CompanyID,
	DivisionID,
	DepartmentID,
	GLTransactionNumber,
	GLTransactionTypeID,
	GLTransactionDate,
	GLTransactionDescription,
	GLTransactionReference,
	CurrencyID,
	CurrencyExchangeRate,
	GLTransactionAmount,
	GLTransactionAmountUndistributed,
	GLTransactionBalance,
	GLTransactionPostedYN,
	GLTransactionSource,
	GLTransactionSystemGenerated)
   SELECT
   v_CompanyID,
		v_DivisionID,
		v_DepartmentID,
		v_GLTransNumber,
		CASE TransactionTypeID WHEN 'Service Invoice' THEN 'SERINV' ELSE 'Invoice' END ,
		v_TranDate,
		CustomerID,
		InvoiceNumber,
		v_CompanyCurrencyID,
		1,
		v_ConvertedTotal,
		0,
		0,
		1,
		CONCAT('INV ',cast(v_InvoiceNumber as char(10))),
		1
   FROM
   InvoiceHeader
   WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND InvoiceNumber = v_InvoiceNumber;
   IF @SWV_Error <> 0 then
-- An error occured, go to the error handler
-- and drop the temporary table

      SET v_ErrorMessage = 'Insert into LedgerTransactions failed';
      ROLLBACK;
      DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;
      IF v_ErrorMessage <> '' then

	-- the error handler
	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'ReturnInvoice_CreateGLTransaction',
         v_ErrorMessage,v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
      end if;
      SET SWP_Ret_Value = -1;
   end if;
-- Get Company Account Receivable
   select   GLARAccount INTO v_GLARAccount FROM
   Companies WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID;
-- Debit @Total to Account Receivable
   IF v_Total > 0 then

      SET @SWV_Error = 0;
      INSERT INTO tt_LedgerDetailTmp(GLTransactionAccount,
		GLDebitAmount,
		GLCreditAmount,
		ProjectID)
	VALUES(v_GLARAccount,
		v_ConvertedTotal,
		0,
		v_ProjectID);
	
      IF @SWV_Error <> 0 then
	-- An error occured, go to the error handler
	-- and drop the temporary table
	
         SET v_ErrorMessage = 'Error Processing AR Data';
         ROLLBACK;
         DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;
         IF v_ErrorMessage <> '' then

	-- the error handler
	
            CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'ReturnInvoice_CreateGLTransaction',
            v_ErrorMessage,v_ErrorID);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
         end if;
         SET SWP_Ret_Value = -1;
      end if;
   end if;
-- Define default AR Sales Account,
-- it will be used if detail Sales Account is undefined
   IF v_GLInvoiceSalesAccount IS NULL then

      select   GLARSalesAccount INTO v_GLInvoiceSalesAccount FROM
      Companies WHERE
      CompanyID = v_CompanyID
      AND DivisionID = v_DivisionID
      AND DepartmentID = v_DepartmentID;
   end if;
-- Credit Subtotal to AR Sales Account
-- Different detail items can have different Sales Account
-- So we will collect this information scanning all invoice detail items
   IF SWV_CurNum = 0 THEN
      OPEN cInvoiceDetail;
   ELSE
      OPEN cInvoiceDetail2;
   END IF;
   SET NO_DATA = 0;
   FETCH cInvoiceDetail INTO v_ItemGLSalesAccount,v_ItemUnitPrice,v_ItemProjectID;
   WHILE NO_DATA = 0 DO
      SET @SWV_Error = 0;
      INSERT INTO tt_LedgerDetailTmp(GLTransactionAccount,
		GLDebitAmount,
		GLCreditAmount,
		ProjectID)
	VALUES(IFNULL(v_ItemGLSalesAccount,v_GLInvoiceSalesAccount),
		0,
		fnRound(v_CompanyID, v_DivisionID, v_DepartmentID, v_ItemUnitPrice*v_CurrencyExchangeRate, v_CompanyCurrencyID),
		v_ItemProjectID);
	
      IF @SWV_Error <> 0 then
	-- An error occured, go to the error handler
	
         IF SWV_CurNum = 0 THEN
            CLOSE cInvoiceDetail;
         ELSE
            CLOSE cInvoiceDetail2;
         END IF;
		
         SET v_ErrorMessage = 'Update InvoiceDetail failed';
         ROLLBACK;
         DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;
         IF v_ErrorMessage <> '' then

	-- the error handler
	
            CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'ReturnInvoice_CreateGLTransaction',
            v_ErrorMessage,v_ErrorID);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
         end if;
         SET SWP_Ret_Value = -1;
      end if;
      SET NO_DATA = 0;
      FETCH cInvoiceDetail INTO v_ItemGLSalesAccount,v_ItemUnitPrice,v_ItemProjectID;
   END WHILE;
   IF SWV_CurNum = 0 THEN
      CLOSE cInvoiceDetail;
   ELSE
      CLOSE cInvoiceDetail2;
   END IF;

   SET v_ConvertedDiscountAmount = fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,v_DiscountAmount*v_CurrencyExchangeRate, 
   v_CompanyCurrencyID);
   SET @SWV_Error = 0;
   IF v_DiscountAmount > 0 then

      select   GLARDiscountAccount INTO v_GLARDiscountAccount FROM
      Companies WHERE
      CompanyID = v_CompanyID AND
      DivisionID = v_DivisionID AND
      DepartmentID = v_DepartmentID;
	-- Debit DiscountAmount From GLARDiscountAccount
      SET @SWV_Error = 0;
      INSERT INTO tt_LedgerDetailTmp(GLTransactionAccount,
		GLDebitAmount,
		GLCreditAmount,
		ProjectID)
	VALUES(v_GLARDiscountAccount,
		v_ConvertedDiscountAmount,
		0,
		v_ProjectID);
	
      IF @SWV_Error <> 0 then
	-- An error occured, go to the error handler
	-- and drop the temporary table
	
         SET v_ErrorMessage = 'Error Processing Discount GL Data';
         ROLLBACK;
         DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;
         IF v_ErrorMessage <> '' then

	-- the error handler
	
            CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'ReturnInvoice_CreateGLTransaction',
            v_ErrorMessage,v_ErrorID);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
         end if;
         SET SWP_Ret_Value = -1;
      end if;
   end if;
   IF @SWV_Error <> 0 then
-- An error occured, go to the error handler
-- and drop the temporary table

      SET v_ErrorMessage = 'Error Processing Discount Data';
      ROLLBACK;
      DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;
      IF v_ErrorMessage <> '' then

	-- the error handler
	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'ReturnInvoice_CreateGLTransaction',
         v_ErrorMessage,v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
      end if;
      SET SWP_Ret_Value = -1;
   end if;
-- insert the record for @TaxAmount
-- we will redistribute @TaxAmount between different GLTaxAccounts included to Invoice tax group
   IF SWV_CurNum = 0 THEN
      OPEN cInvoiceDetail;
   ELSE
      OPEN cInvoiceDetail2;
   END IF;
   SET NO_DATA = 0;
   FETCH cInvoiceDetail INTO v_TaxAmount,v_TaxGroupID,v_TotalTaxPercent,v_ItemProjectID;
   WHILE NO_DATA = 0 DO
      IF v_TaxAmount > 0 then
	
         IF v_TaxGroupID = N'' then
		
            SET v_TaxGroupID = v_HeaderTaxGroupID;
            SET v_TotalTaxPercent = v_HeaderTaxPercent;
         end if;
         SET @SWV_Error = 0;
         CALL TaxGroup_GetTotalPercent2(v_CompanyID,v_DivisionID,v_DepartmentID,v_TaxGroupID,v_TotalTaxPercent);
         IF @SWV_Error <> 0 then
		
            SET v_ErrorMessage = 'Procedure call TaxGroup_GetTotalPercent failed';
            ROLLBACK;
            DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;
            IF v_ErrorMessage <> '' then

	-- the error handler
	
               CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'ReturnInvoice_CreateGLTransaction',
               v_ErrorMessage,v_ErrorID);
               CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
            end if;
            SET SWP_Ret_Value = -1;
         end if;
         OPEN cTax;
         SET NO_DATA = 0;
         FETCH cTax INTO v_TaxPercent,v_GLTaxAccount;
         WHILE NO_DATA = 0 DO
            IF v_TotalTaxPercent <> 0 then
               SET v_ItemTaxAmount = fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,v_TaxAmount*v_CurrencyExchangeRate*v_TaxPercent/v_TotalTaxPercent, 
               v_CompanyCurrencyID);
            ELSE
               SET v_ItemTaxAmount = 0;
            end if;

		-- Credit Tax to Tax Account
            SET @SWV_Error = 0;
            INSERT INTO tt_LedgerDetailTmp(GLTransactionAccount,
			GLDebitAmount,
			GLCreditAmount,
			ProjectID)
		VALUES(v_GLTaxAccount,
			0,
			v_ItemTaxAmount,
			v_ItemProjectID);
		
            IF @SWV_Error <> 0 then
		-- An error occured, go to the error handler
		-- and drop the temporary table
		
               SET v_ErrorMessage = 'Error Processing Tax Data';
               CLOSE cTax;
			
               ROLLBACK;
               DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;
               IF v_ErrorMessage <> '' then

	-- the error handler
	
                  CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'ReturnInvoice_CreateGLTransaction',
                  v_ErrorMessage,v_ErrorID);
                  CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
               end if;
               SET SWP_Ret_Value = -1;
            end if;
            SET NO_DATA = 0;
            FETCH cTax INTO v_TaxPercent,v_GLTaxAccount;
         END WHILE;
         CLOSE cTax;
      end if;
      SET NO_DATA = 0;
      FETCH cInvoiceDetail INTO v_TaxAmount,v_TaxGroupID,v_TotalTaxPercent,v_ItemProjectID;
   END WHILE;
   IF SWV_CurNum = 0 THEN
      CLOSE cInvoiceDetail;
   ELSE
      CLOSE cInvoiceDetail2;
   END IF;

-- insert the record for @Freight
   IF v_Freight > 0 then

	-- Get AR Freight Account
      select   GLARFreightAccount INTO v_GLARFreightAccount FROM
      Companies WHERE
      CompanyID = v_CompanyID AND
      DivisionID = v_DivisionID AND
      DepartmentID = v_DepartmentID;
	-- Credit Freight to AR Freight Account
      SET @SWV_Error = 0;
      INSERT INTO tt_LedgerDetailTmp(GLTransactionAccount,
		GLDebitAmount,
		GLCreditAmount,
		ProjectID)
	VALUES(v_GLARFreightAccount,
		0,
		fnRound(v_CompanyID, v_DivisionID , v_DepartmentID,v_Freight*v_CurrencyExchangeRate, v_CompanyCurrencyID),
		v_ProjectID);
	
      IF @SWV_Error <> 0 then
	-- An error occured, go to the error handler
	-- and drop the temporary table
	
         SET v_ErrorMessage = 'Error Processing Freight Data';
         ROLLBACK;
         DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;
         IF v_ErrorMessage <> '' then

	-- the error handler
	
            CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'ReturnInvoice_CreateGLTransaction',
            v_ErrorMessage,v_ErrorID);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
         end if;
         SET SWP_Ret_Value = -1;
      end if;
   end if;
-- insert the record for @Handling
   IF v_Handling > 0 then

	-- Get AR Handling Account
      select   GLARHandlingAccount INTO v_GLARHandlingAccount FROM
      Companies WHERE
      CompanyID = v_CompanyID AND
      DivisionID = v_DivisionID AND
      DepartmentID = v_DepartmentID;
      SET v_Handling = fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,v_Handling*v_CurrencyExchangeRate, 
      v_CompanyCurrencyID);
	-- Credit Handling from AR Handling Account
      SET @SWV_Error = 0;
      INSERT INTO tt_LedgerDetailTmp(GLTransactionAccount,
		GLDebitAmount,
		GLCreditAmount,
		ProjectID)
	VALUES(v_GLARHandlingAccount,
		0,
		v_Handling,
		v_ProjectID);
	
      IF @SWV_Error <> 0 then
	-- An error occured, go to the error handler
	-- and drop the temporary table
	
         SET v_ErrorMessage = 'Error Processing Handling Data';
         ROLLBACK;
         DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;
         IF v_ErrorMessage <> '' then

	-- the error handler
	
            CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'ReturnInvoice_CreateGLTransaction',
            v_ErrorMessage,v_ErrorID);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
         end if;
         SET SWP_Ret_Value = -1;
      end if;
   end if;
   select   IFNULL(DefaultInventoryCostingMethod,'F') INTO v_DefaultInventoryCostingMethod FROM
   Companies WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID;
-- Credit invetory cost to GLItemInventoryAccount
   SET @SWV_Error = 0;
   INSERT INTO tt_LedgerDetailTmp(GLTransactionAccount,
	GLDebitAmount,
	GLCreditAmount,
	ProjectID)
   SELECT
   IFNULL(GLItemInventoryAccount,(SELECT GLARInventoryAccount
      FROM Companies
      WHERE CompanyID = v_CompanyID AND DivisionID  = v_DivisionID AND  DepartmentID = v_DepartmentID)),
	0,
	SUM(OrderQty*CASE(CASE(v_DefaultInventoryCostingMethod)
   WHEN 'F' THEN IFNULL(FIFOCost,0)
   WHEN 'L' THEN IFNULL(LIFOCost,0)
   WHEN 'A' THEN IFNULL(AverageCost,0)
   ELSE 0 END)
   WHEN 0 THEN IFNULL(ItemCost,0)
   ELSE(CASE(v_DefaultInventoryCostingMethod)
      WHEN 'F' THEN IFNULL(FIFOCost,0)
      WHEN 'L' THEN IFNULL(LIFOCost,0)
      WHEN 'A' THEN IFNULL(AverageCost,0)
      ELSE 0 END) END),
	InvoiceDetail.ProjectID
   FROM
   InvoiceDetail, InventoryItems
   WHERE
   InvoiceDetail.CompanyID = InventoryItems.CompanyID
   AND InvoiceDetail.DivisionID = InventoryItems.DivisionID
   AND InvoiceDetail.DepartmentID = InventoryItems.DepartmentID
   AND InventoryItems.ItemID =  InvoiceDetail.ItemID
   AND InvoiceDetail.CompanyID = v_CompanyID
   AND InvoiceDetail.DivisionID = v_DivisionID
   AND InvoiceDetail.DepartmentID = v_DepartmentID
   AND InvoiceDetail.InvoiceNumber = v_InvoiceNumber
   AND(CASE(CASE(v_DefaultInventoryCostingMethod)
   WHEN 'F' THEN IFNULL(FIFOCost,0)
   WHEN 'L' THEN IFNULL(LIFOCost,0)
   WHEN 'A' THEN IFNULL(AverageCost,0)
   ELSE 0 END)
   WHEN 0 THEN IFNULL(ItemCost,0)
   ELSE(CASE(v_DefaultInventoryCostingMethod)
      WHEN 'F' THEN IFNULL(FIFOCost,0)
      WHEN 'L' THEN IFNULL(LIFOCost,0)
      WHEN 'A' THEN IFNULL(AverageCost,0)
      ELSE 0 END) END) > 0
   GROUP BY
   GLItemInventoryAccount,InvoiceDetail.ProjectID;
	
   IF @SWV_Error <> 0 then
-- An error occured, go to the error handler
-- and drop the temporary table	

      SET v_ErrorMessage = 'Error Processing Inventory Data';
      ROLLBACK;
      DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;
      IF v_ErrorMessage <> '' then

	-- the error handler
	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'ReturnInvoice_CreateGLTransaction',
         v_ErrorMessage,v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
      end if;
      SET SWP_Ret_Value = -1;
   end if;
-- Debit inventory cost to COGS Accout
   SET @SWV_Error = 0;
   INSERT INTO tt_LedgerDetailTmp(GLTransactionAccount,
	GLDebitAmount,
	GLCreditAmount,
	ProjectID)
   SELECT
   IFNULL(GLItemCOGSAccount,(SELECT GLARCOGSAccount
      FROM Companies
      WHERE CompanyID = v_CompanyID AND DivisionID  = v_DivisionID AND  DepartmentID = v_DepartmentID)),
	SUM(OrderQty*CASE(CASE(v_DefaultInventoryCostingMethod)
   WHEN 'F' THEN IFNULL(FIFOCost,0)
   WHEN 'L' THEN IFNULL(LIFOCost,0)
   WHEN 'A' THEN IFNULL(AverageCost,0)
   ELSE 0 END)
   WHEN 0 THEN IFNULL(ItemCost,0)
   ELSE(CASE(v_DefaultInventoryCostingMethod)
      WHEN 'F' THEN IFNULL(FIFOCost,0)
      WHEN 'L' THEN IFNULL(LIFOCost,0)
      WHEN 'A' THEN IFNULL(AverageCost,0)
      ELSE 0 END) END),
	0,
	InvoiceDetail.ProjectID
   FROM
   InvoiceDetail, InventoryItems
   WHERE
   InvoiceDetail.CompanyID = InventoryItems.CompanyID
   AND InvoiceDetail.DivisionID = InventoryItems.DivisionID
   AND InvoiceDetail.DepartmentID = InventoryItems.DepartmentID
   AND InventoryItems.ItemID =  InvoiceDetail.ItemID
   AND InvoiceDetail.CompanyID = v_CompanyID
   AND InvoiceDetail.DivisionID = v_DivisionID
   AND InvoiceDetail.DepartmentID = v_DepartmentID
   AND InvoiceDetail.InvoiceNumber = v_InvoiceNumber
   AND(CASE(CASE(v_DefaultInventoryCostingMethod)
   WHEN 'F' THEN IFNULL(FIFOCost,0)
   WHEN 'L' THEN IFNULL(LIFOCost,0)
   WHEN 'A' THEN IFNULL(AverageCost,0)
   ELSE 0 END)
   WHEN 0 THEN IFNULL(ItemCost,0)
   ELSE(CASE(v_DefaultInventoryCostingMethod)
      WHEN 'F' THEN IFNULL(FIFOCost,0)
      WHEN 'L' THEN IFNULL(LIFOCost,0)
      WHEN 'A' THEN IFNULL(AverageCost,0)
      ELSE 0 END) END) > 0
   GROUP BY
   GLItemCOGSAccount,InvoiceDetail.ProjectID;
   IF @SWV_Error <> 0 then
-- An error occured, go to the error handler
-- and drop the temporary table

      SET v_ErrorMessage = 'Error Processing COGS Data';
      ROLLBACK;
      DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;
      IF v_ErrorMessage <> '' then

	-- the error handler
	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'ReturnInvoice_CreateGLTransaction',
         v_ErrorMessage,v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
      end if;
      SET SWP_Ret_Value = -1;
   end if;
-- insert the data into the LedgerTransactionsDetail table;
-- the records are grouped by GLTransactionAccount and ProjectID
   SET @SWV_Error = 0;
   INSERT INTO LedgerTransactionsDetail(CompanyID,
	DivisionID,
	DepartmentID,
	GLTransactionNumber,
	GLTransactionAccount,
	GLDebitAmount,
	GLCreditAmount,
	ProjectID)
   SELECT
   v_CompanyID,
	v_DivisionID,
	v_DepartmentID,
	v_GLTransNumber,
	GLTransactionAccount,
	SUM(IFNULL(GLDebitAmount,0)),
	SUM(IFNULL(GLCreditAmount,0)) ,
	ProjectID
   FROM
   tt_LedgerDetailTmp
   GROUP BY
   ProjectID,GLTransactionAccount;
   IF @SWV_Error <> 0 then
-- An error occured, go to the error handler
-- and drop the temporary table

      SET v_ErrorMessage = 'Insert into LedgerTransactionDetail failed';
      ROLLBACK;
      DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;
      IF v_ErrorMessage <> '' then

	-- the error handler
	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'ReturnInvoice_CreateGLTransaction',
         v_ErrorMessage,v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
      end if;
      SET SWP_Ret_Value = -1;
   end if;
   DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;
/*
update the information in the Ledger Chart of Accounts fro the accounts of the newly inserted transaction
parameters	@CompanyID NVARCHAR(36),
		@DivisionID NVARCHAR(36),
		@DepartmentID NVARCHAR(36),
		@GLTransNumber NVARCHAR (36)
		used to identify the TRANSACTION
		@PostCOA BIT - used in the process of creation of the transaction
*/
   SET @SWV_Error = 0;
   CALL LedgerTransactions_PostCOA_AllRecords2(v_CompanyID,v_DivisionID,v_DepartmentID,v_GLTransNumber, v_ReturnStatus);
   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then
-- An error occured, go to the error handler
-- and drop the temporary table

      SET v_ErrorMessage = 'LedgerTransactions_PostCOA_AllRecords call failed';
      ROLLBACK;
      DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;
      IF v_ErrorMessage <> '' then

	-- the error handler
	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'ReturnInvoice_CreateGLTransaction',
         v_ErrorMessage,v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
      end if;
      SET SWP_Ret_Value = -1;
   end if;
-- Everything is  OK
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
   DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;
   IF v_ErrorMessage <> '' then

	-- the error handler
	
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'ReturnInvoice_CreateGLTransaction',
      v_ErrorMessage,v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
   end if;
   SET SWP_Ret_Value = -1;
END;




//

DELIMITER ;

DELIMITER //
DROP PROCEDURE IF EXISTS ReturnInvoice_AdjustInventory;
//
CREATE    PROCEDURE ReturnInvoice_AdjustInventory(v_CompanyID NATIONAL VARCHAR(36), 
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_InvoiceNumber NATIONAL VARCHAR(36),INOUT SWP_Ret_Value INT)
   SWL_return:
BEGIN











/*
Name of stored procedure: ReturnInvoice_AdjustInventory
Method: 
	this procedure adjusts the inventory to show that the goods are gone and paid for.
	We already moved the inventory from the On Hand Column to the Committed Column 
	when the order was processed, now we are going to debit the inventory from 
	the Committed field.

Date Created: EDE - 07/28/2015

Input Parameters:

	@CompanyID NVARCHAR(36)		 - the ID of the company
	@DivisionID NVARCHAR(36)	 - the ID of the division
	@DepartmentID NVARCHAR(36)	 - the ID of the department
	@InvoiceNumber NVARCHAR(36)	 - the return invoice number

Output Parameters:

	NONE

Called From:

	ReturnInvoice_Post

Calls:

	Inventory_GetWarehouseForOrder, WarehouseBinShipGoods, Error_InsertError, Error_InsertErrorDetail

Last Modified: 

Last Modified By: 

Revision History: 

*/

   DECLARE v_OrderNumber NATIONAL VARCHAR(36);
   DECLARE v_WarehouseID NATIONAL VARCHAR(36);
   DECLARE v_WarehouseBinID NATIONAL VARCHAR(36);
   DECLARE v_ReturnStatus INT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(250);
   DECLARE v_InvoiceLineNumber INT; 
   DECLARE v_ItemID NATIONAL VARCHAR(36);
   DECLARE v_OrderQty INT;
   DECLARE v_BackOrderQty INT;

   DECLARE v_ErrorID INT;
   DECLARE NO_DATA INT DEFAULT 0;
   DECLARE cInvoiceDetail CURSOR 
   FOR SELECT 
   WarehouseID, WarehouseBinID,
		InvoiceLineNumber, ItemID, IFNULL(OrderQty,0), IFNULL(BackOrderQty,0)
   FROM 
   InvoiceDetail
   WHERE	
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND InvoiceNumber = v_InvoiceNumber;

-- open the cursor and get the first row
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
      SET NO_DATA = -2;
   END;
   DECLARE CONTINUE HANDLER FOR NOT FOUND SET NO_DATA = -1;
   SET @SWV_Error = 0;
   START TRANSACTION;

   select   OrderNumber INTO v_OrderNumber FROM InvoiceHeader WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND InvoiceNumber = v_InvoiceNumber;


-- get the @WarehouseID for the invoice order
   CALL Inventory_GetWarehouseForOrder(v_CompanyID,v_DivisionID,v_DepartmentID,v_OrderNumber,v_WarehouseID, v_ReturnStatus); 
   IF v_ReturnStatus = -1 then

      SET v_ErrorMessage = 'Getting the WarehouseID failed';
      ROLLBACK;
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'ReturnInvoice_AdjustInventory',
      v_ErrorMessage,v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoceNumber',v_InvoiceNumber);
      SET SWP_Ret_Value = -1;
   end if;

   OPEN cInvoiceDetail;
   SET NO_DATA = 0;
   FETCH cInvoiceDetail INTO v_WarehouseID,v_WarehouseBinID,v_InvoiceLineNumber,v_ItemID,v_OrderQty, 
   v_BackOrderQty;
   WHILE NO_DATA = 0 DO
      SET @SWV_Error = 0;
      CALL WarehouseBinShipGoods2(v_CompanyID,v_DivisionID,v_DepartmentID,v_WarehouseID,v_WarehouseBinID,
      v_ItemID,v_OrderQty,v_BackOrderQty,1, v_ReturnStatus);
      IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then
	
         CLOSE cInvoiceDetail;
		
         SET v_ErrorMessage = 'WarehouseBinShipGoods failed';
         ROLLBACK;
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'ReturnInvoice_AdjustInventory',
         v_ErrorMessage,v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoceNumber',v_InvoiceNumber);
         SET SWP_Ret_Value = -1;
      end if;
      SET NO_DATA = 0;
      FETCH cInvoiceDetail INTO v_WarehouseID,v_WarehouseBinID,v_InvoiceLineNumber,v_ItemID,v_OrderQty, 
      v_BackOrderQty;
   END WHILE;
   CLOSE cInvoiceDetail;


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
   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'ReturnInvoice_AdjustInventory',
   v_ErrorMessage,v_ErrorID);

   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoceNumber',v_InvoiceNumber);

   SET SWP_Ret_Value = -1;
END;















//

DELIMITER ;

DELIMITER //
DROP PROCEDURE IF EXISTS ReturnReceipt_Post2;
//
CREATE        PROCEDURE ReturnReceipt_Post2(v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_ReceiptID NATIONAL VARCHAR(36),
	INOUT v_Success INT   ,
	INOUT v_PostingResult NATIONAL VARCHAR(200) ,INOUT SWP_Ret_Value INT)
   SWL_return:
BEGIN









/*
Name of stored procedure: ReturnReceipt_Post
Method: 
	Posts a return receipt into the system

Date Created: EDE - 07/28/2015

Input Parameters:

	@CompanyID NVARCHAR(36)		 - the ID of the company
	@DivisionID NVARCHAR(36)	 - the ID of the division
	@DepartmentID NVARCHAR(36)	 - the ID of the department
	@ReceiptID NVARCHAR(36)		 - the ID of the return receipt

Output Parameters:

	@Success INT  			 - RETURN VALUES for the @Succes output parameter:

							   1 succes

							   0 error while processin data

							   2 error on geting time Period
	@PostingResult NVARCHAR(200)	 - the error message that should be displayed for the end user

Called From:

	ReturnInvoice_Post, ReturnReceipt_Post.vb

Calls:

	ReturnReceipt_Recalc, ReturnReceipt_CreateGLTransaction, Project_ReCalc, Error_InsertError, Error_InsertErrorDetail

Last Modified: 

Last Modified By: 

Revision History: 

*/

   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);

   DECLARE v_PostDate NATIONAL VARCHAR(1);
   DECLARE v_PeriodToPost INT;
   DECLARE v_PeriodClosed INT;
   DECLARE v_TranDate DATETIME;
   DECLARE v_GLTransNumber NATIONAL VARCHAR(36);
   DECLARE v_GLARCashAccount NATIONAL VARCHAR(36);
   DECLARE v_CurrencyID NATIONAL VARCHAR(3);
   DECLARE v_CompanyCurrencyID NATIONAL VARCHAR(3);
   DECLARE v_CurrencyExchangeRate FLOAT;
   DECLARE v_ReceiptDate DATETIME;
   DECLARE v_CustomerID NATIONAL VARCHAR(50);
   DECLARE v_PostCOA BOOLEAN;
   DECLARE v_Posted BOOLEAN;
   DECLARE v_Amount DECIMAL(19,4);
   DECLARE v_ConvertedAmount DECIMAL(19,4);
   DECLARE v_TotalAppliedAmount DECIMAL(19,4);
   DECLARE v_ProjectID NATIONAL VARCHAR(36);
   DECLARE v_GLBankAccount NATIONAL VARCHAR(36);
   DECLARE v_ErrorID INT;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
   END;

-- set the success flag to true
-- this flag will be changed if any error will occurr
-- in the procedure
   SET @SWV_Error = 0;
   SET v_Success = 1;
   SET v_ErrorMessage = '';



   IF NOT EXISTS(SELECT
   ReceiptID
   FROM
   ReceiptsDetail
   WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   ReceiptID = v_ReceiptID) then

      SET v_PostingResult = 'Return Receipt was not posted: there are no detail items';
      SET SWP_Ret_Value = -1;
      LEAVE SWL_return;
   end if;

   IF EXISTS(SELECT
   ReceiptID
   FROM
   ReceiptsDetail
   WHERE
   AppliedAmount IS NULL AND
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   ReceiptID = v_ReceiptID) then

      SET v_PostingResult = 'Return Receipt was not posted: there is the detail item with undefined AppliedAmount value';
      SET SWP_Ret_Value = -1;
      LEAVE SWL_return;
   end if;


   select   Posted INTO v_Posted FROM
   ReceiptsHeader WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   ReceiptID = v_ReceiptID;



   IF v_Posted = 1 then

      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;
   end if;


   START TRANSACTION;
   SET @SWV_Error = 0;
   CALL ReturnReceipt_Recalc2(v_CompanyID,v_DivisionID,v_DepartmentID,v_ReceiptID, v_ReturnStatus);
   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then

	-- the procedure will return an error code
      SET v_ErrorMessage = 'Receipt_Recalc call failed';
      ROLLBACK;
      IF v_Success <> 1 then

         SET v_Success = 0;
      end if;
      DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;
      IF v_ErrorMessage <> '' then

	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'ReturnReceipt_Post',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'ReceiptID',v_ReceiptID);
      end if;
      SET SWP_Ret_Value = -1;
   end if;

   select   IFNULL(Amount,0) INTO v_Amount FROM
   ReceiptsHeader WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   ReceiptID = v_ReceiptID;

   IF v_Amount = 0 then -- Nothing to post

      SET v_PostingResult = 'Return Receipt was not posted:  Receipt Amount=0';
	
-- We do not begin transaction before jump to this point, so should not call ROLLBACK TRAN
      SET v_Success = 2;
      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;
-- if an error occured in the procedure this code will be executed
-- The information about the error are entered in the ErrrorLog and ErrorLogDetail tables.
-- The company, division, department informations are inserted in the ErrorLog table
-- along with information about the name of the procedure and the error message and an errorID is obtained.
-- The aditional information about other procedure parameters are inserted along with the errorID in the ErrorLogDetail table
-- (about the other parameters the name and the value are inserted).
   end if;

   SET @SWV_Error = 0;
   CALL ReturnReceipt_CreateGLTransaction(v_CompanyID,v_DivisionID,v_DepartmentID,v_ReceiptID, v_ReturnStatus);
   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then

	-- the procedure will return an error code
      SET v_ErrorMessage = 'ReturnReceipt_CreateGLTransaction call failed';
      ROLLBACK;
      IF v_Success <> 1 then

         SET v_Success = 0;
      end if;
      DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;
      IF v_ErrorMessage <> '' then

	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'ReturnReceipt_Post',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'ReceiptID',v_ReceiptID);
      end if;
      SET SWP_Ret_Value = -1;
   end if;

-- Period to post is closed already so we can't post the Receipt
   IF v_ReturnStatus = 1 then

      SET v_PostingResult = 'Return Receipt was not posted: Period to post is closed already';
	
-- We do not begin transaction before jump to this point, so should not call ROLLBACK TRAN
      SET v_Success = 2;
      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;
-- if an error occured in the procedure this code will be executed
-- The information about the error are entered in the ErrrorLog and ErrorLogDetail tables.
-- The company, division, department informations are inserted in the ErrorLog table
-- along with information about the name of the procedure and the error message and an errorID is obtained.
-- The aditional information about other procedure parameters are inserted along with the errorID in the ErrorLogDetail table
-- (about the other parameters the name and the value are inserted).
   end if;

-- Update fields in Projects table
   SET @SWV_Error = 0;
   CALL Project_Recalc2(v_CompanyID,v_DivisionID,v_DepartmentID,v_ProjectID, v_ReturnStatus);
   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then

	-- the procedure will return an error code
      SET v_ErrorMessage = 'Project_ReCalc call failed';
      ROLLBACK;
      IF v_Success <> 1 then

         SET v_Success = 0;
      end if;
      DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;
      IF v_ErrorMessage <> '' then

	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'ReturnReceipt_Post',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'ReceiptID',v_ReceiptID);
      end if;
      SET SWP_Ret_Value = -1;
   end if;


-- set posted flag for payment
   SET @SWV_Error = 0;
   UPDATE
   ReceiptsHeader
   SET
   Posted = 1,Status = 'Posted'
   WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   ReceiptID = v_ReceiptID;

   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Update ReceiptsHeader failed';
      ROLLBACK;
      IF v_Success <> 1 then

         SET v_Success = 0;
      end if;
      DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;
      IF v_ErrorMessage <> '' then

	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'ReturnReceipt_Post',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'ReceiptID',v_ReceiptID);
      end if;
      SET SWP_Ret_Value = -1;
   end if;

   COMMIT;


   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;



-- We do not begin transaction before jump to this point, so should not call ROLLBACK TRAN
   SET v_Success = 2;
   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;
-- if an error occured in the procedure this code will be executed
-- The information about the error are entered in the ErrrorLog and ErrorLogDetail tables.
-- The company, division, department informations are inserted in the ErrorLog table
-- along with information about the name of the procedure and the error message and an errorID is obtained.
-- The aditional information about other procedure parameters are inserted along with the errorID in the ErrorLogDetail table
-- (about the other parameters the name and the value are inserted).
   ROLLBACK;


   IF v_Success <> 1 then

      SET v_Success = 0;
   end if;
   DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;

   IF v_ErrorMessage <> '' then

	
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'ReturnReceipt_Post',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'ReceiptID',v_ReceiptID);
   end if;

   SET SWP_Ret_Value = -1;
END;

























//

DELIMITER ;

DELIMITER //
DROP PROCEDURE IF EXISTS ReturnReceipt_CreateGLTransaction;
//
CREATE     PROCEDURE ReturnReceipt_CreateGLTransaction(v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_ReceiptID NATIONAL VARCHAR(36),INOUT SWP_Ret_Value INT)
   SWL_return:
BEGIN















/*
Name of stored procedure: ReturnReceipt_CreateGLTransaction
Method: 
	Posts a return receipt to LedgerTransactions table

Date Created: EDE - 07/28/2015

Input Parameters:

	@CompanyID NVARCHAR(36)		 - the ID of the company
	@DivisionID NVARCHAR(36)	 - the ID of the division
	@DepartmentID NVARCHAR(36)	 - the ID of the department
	@ReceiptID NVARCHAR(36)		 - the ID of return receipt

Output Parameters:

	NONE

Called From:

	ReturnReceipt_Post

Calls:

	LedgerMain_VerifyPeriod, VerifyCurrency, GetNextEntityID, LedgerTransactions_PostCOA_AllRecords, Error_InsertError, Error_InsertErrorDetail

Last Modified: 

Last Modified By: 

Revision History: 

*/

   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);

   DECLARE v_PostDate NATIONAL VARCHAR(1);
   DECLARE v_PeriodToPost INT;
   DECLARE v_PeriodClosed INT;
   DECLARE v_TranDate DATETIME;
   DECLARE v_GLTransNumber NATIONAL VARCHAR(36);
   DECLARE v_GLARCashAccount NATIONAL VARCHAR(36);
   DECLARE v_CurrencyID NATIONAL VARCHAR(3);
   DECLARE v_CompanyCurrencyID NATIONAL VARCHAR(3);
   DECLARE v_CurrencyExchangeRate FLOAT;
   DECLARE v_ReceiptDate DATETIME;
   DECLARE v_CustomerID NATIONAL VARCHAR(50);
   DECLARE v_PostCOA BOOLEAN;
   DECLARE v_Posted BOOLEAN;
   DECLARE v_Amount DECIMAL(19,4);
   DECLARE v_TotalAppliedAmount DECIMAL(19,4);
   DECLARE v_ProjectID NATIONAL VARCHAR(36);
   DECLARE v_GLBankAccount NATIONAL VARCHAR(36);
   DECLARE v_GLARAccount NATIONAL VARCHAR(36);

-- set the success flag to true
-- this flag will be changed if any error will occurr
-- in the procedure
   DECLARE v_ConvertedAmount DECIMAL(19,4);
   DECLARE v_DiscountAccount NATIONAL VARCHAR(36);
   DECLARE v_WriteOffAccount NATIONAL VARCHAR(36);
   DECLARE v_ErrorID INT;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
   END;
   BEGIN
      TransactionFinish:
      BEGIN
         SET @SWV_Error = 0;
         SET v_ErrorMessage = '';
         select   Posted, IFNULL(Amount,0), CustomerID, GLBankAccount, CurrencyID, CurrencyExchangeRate, OrderDate INTO v_Posted,v_Amount,v_CustomerID,v_GLBankAccount,v_CurrencyID,v_CurrencyExchangeRate,
         v_ReceiptDate FROM
         ReceiptsHeader WHERE
         CompanyID = v_CompanyID AND
         DivisionID = v_DivisionID AND
         DepartmentID = v_DepartmentID AND
         ReceiptID = v_ReceiptID;
         IF v_Posted = 1 then

            SET SWP_Ret_Value = 0;
            LEAVE SWL_return;
         end if;
         IF v_Amount = 0 then -- Nothing to post

            SET SWP_Ret_Value = 0;
            LEAVE SWL_return;
         end if;
         select   ProjectID INTO v_ProjectID FROM  ReceiptsDetail WHERE
         CompanyID = v_CompanyID
         AND DivisionID = v_DivisionID
         AND DepartmentID = v_DepartmentID
         AND ReceiptID = ReceiptID
         AND NOT ProjectID IS NULL   LIMIT 1;


-- get the post date for the company
         select   IFNULL(DefaultGLPostingDate,'1') INTO v_PostDate FROM
         Companies WHERE
         CompanyID = v_CompanyID AND
         DivisionID = v_DivisionID AND
         DepartmentID = v_DepartmentID;

-- begin the posting process
         IF v_PostDate = '1' then
            SET v_TranDate = CURRENT_TIMESTAMP;
         ELSE
            select   TransactionDate INTO v_TranDate FROM
            ReceiptsHeader WHERE
            CompanyID = v_CompanyID AND
            DivisionID = v_DivisionID AND
            DepartmentID = v_DepartmentID AND
            ReceiptID = v_ReceiptID;
         end if;

-- verify the Period of time
         CALL LedgerMain_VerifyPeriod2(v_CompanyID,v_DivisionID,v_DepartmentID,v_TranDate,v_PeriodToPost,v_PeriodClosed, v_ReturnStatus);
         IF v_PeriodClosed <> 0 OR v_ReturnStatus = -1 then
            SET SWP_Ret_Value = 1;
            LEAVE SWL_return;
         end if;
         SET @SWV_Error = 0;
         CALL VerifyCurrency2(v_CompanyID,v_DivisionID,v_DepartmentID,v_ReceiptDate,1,v_CompanyCurrencyID,
         v_CurrencyID,v_CurrencyExchangeRate);
         IF @SWV_Error <> 0 then

	-- the procedure will return an error code
            SET v_ErrorMessage = 'Currency retrieving failed';
            ROLLBACK;
            DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;
            IF v_ErrorMessage <> '' then

	
               CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'ReturnReceipt_CreateGLTransaction',
               v_ErrorMessage,v_ErrorID);
               CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'ReceiptID',v_ReceiptID);
            end if;
            SET SWP_Ret_Value = -1;
         end if;
         SET v_ConvertedAmount = fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,v_Amount*v_CurrencyExchangeRate, 
         v_CompanyCurrencyID);
         START TRANSACTION;
-- get the transaction number
         SET @SWV_Error = 0;
         CALL GetNextEntityID2(v_CompanyID,v_DivisionID,v_DepartmentID,'NextGLTransNumber',v_GLTransNumber, v_ReturnStatus);
         IF @SWV_Error <> 0  OR v_ReturnStatus = -1 then

            SET v_ErrorMessage = 'GetNextEntityID call failed';
            ROLLBACK;
            DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;
            IF v_ErrorMessage <> '' then

	
               CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'ReturnReceipt_CreateGLTransaction',
               v_ErrorMessage,v_ErrorID);
               CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'ReceiptID',v_ReceiptID);
            end if;
            SET SWP_Ret_Value = -1;
         end if;

-- Insert into LedgerTransactions the necessary entries
-- setting the transaction type to RECEIPT and
-- the post date as current date or transaction date depending
-- of the data from company table (@PostDate)
         SET @SWV_Error = 0;
         INSERT INTO LedgerTransactions(CompanyID,
	DivisionID,
	DepartmentID,
	GLTransactionNumber,
	GLTransactionTypeID,
	GLTransactionDate,
	GLTransactionDescription,
	GLTransactionReference,
	CurrencyID,
	CurrencyExchangeRate,
	GLTransactionAmount,
	GLTransactionPostedYN,
	GLTransactionSystemGenerated,
	GLTransactionBalance,
	GLTransactionAmountUndistributed)
         SELECT
         v_CompanyID,
		v_DivisionID,
		v_DepartmentID,
		v_GLTransNumber,
		CASE ReceiptTypeID WHEN 'Cash' THEN 'Cash'
         ELSE 'Check'
         END,
		CASE v_PostDate WHEN '1' THEN CURRENT_TIMESTAMP ELSE TransactionDate END,
		v_CustomerID,
		v_ReceiptID,
		v_CompanyCurrencyID,
		1,
		v_ConvertedAmount,
		1,
		1,
		0,
		0
         FROM
         ReceiptsHeader
         WHERE
         CompanyID = v_CompanyID AND
         DivisionID = v_DivisionID AND
         DepartmentID = v_DepartmentID AND
         ReceiptID = v_ReceiptID;
         IF @SWV_Error <> 0 then

            SET v_ErrorMessage = 'Insert into LedgerTransactions failed';
            ROLLBACK;
            DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;
            IF v_ErrorMessage <> '' then

	
               CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'ReturnReceipt_CreateGLTransaction',
               v_ErrorMessage,v_ErrorID);
               CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'ReceiptID',v_ReceiptID);
            end if;
            SET SWP_Ret_Value = -1;
         end if;
         DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;


-- create temporary table for payment information
         CREATE TEMPORARY TABLE tt_LedgerDetailTmp  
         (
            GLTransactionNumberDetail BIGINT NOT NULL  PRIMARY KEY  AUTO_INCREMENT,
            GLTransactionAccount NATIONAL VARCHAR(36),
            GLDebitAmount DECIMAL(19,4),
            GLCreditAmount DECIMAL(19,4),
            ProjectID NATIONAL VARCHAR(36)
         )  AUTO_INCREMENT = 1;


-- Get additional company accounts
         select   GLARDiscountAccount, GLARWriteOffAccount, GLARAccount INTO v_DiscountAccount,v_WriteOffAccount,v_GLARAccount FROM Companies WHERE
         CompanyID = v_CompanyID AND
         DivisionID = v_DivisionID AND
         DepartmentID = v_DepartmentID;


-- Get total for Receipt
         select   SUM(fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,IFNULL(AppliedAmount,0),v_CompanyCurrencyID)) INTO v_TotalAppliedAmount FROM
         ReceiptsDetail WHERE
         CompanyID = v_CompanyID AND
         DivisionID = v_DivisionID AND
         DepartmentID = v_DepartmentID AND
         ReceiptID = v_ReceiptID AND
         IFNULL(AppliedAmount,0) > 0;
         SET v_TotalAppliedAmount = IFNULL(v_TotalAppliedAmount,0);
         IF ABS(v_TotalAppliedAmount -v_Amount) > 0.05 then

	-- Patial payment is posted using simplified scheme
            IF v_TotalAppliedAmount > v_Amount then
	
		-- insert into TransactionsDetail the records from ReceiptsDetail
		-- Debit Receipt Amount to Bank Account
               SET @SWV_Error = 0;
               INSERT INTO tt_LedgerDetailTmp(GLTransactionAccount ,
			GLDebitAmount,
			GLCreditAmount,
			ProjectID)
		VALUES(v_GLBankAccount,
			v_ConvertedAmount,
			0,
			v_ProjectID);
		
               IF @SWV_Error <> 0 then
		
                  SET v_ErrorMessage = 'Error Processing Data';
                  ROLLBACK;
                  DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;
                  IF v_ErrorMessage <> '' then

	
                     CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'ReturnReceipt_CreateGLTransaction',
                     v_ErrorMessage,v_ErrorID);
                     CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'ReceiptID',v_ReceiptID);
                  end if;
                  SET SWP_Ret_Value = -1;
               end if;
		
		
		-- Credit Receipt amount to Account Receivable
               SET @SWV_Error = 0;
               INSERT INTO tt_LedgerDetailTmp(GLTransactionAccount ,
			GLDebitAmount,
			GLCreditAmount,
			ProjectID)
		VALUES(v_GLARAccount,
			0,
			v_ConvertedAmount,
			v_ProjectID);
		
               IF @SWV_Error <> 0 then
		
                  SET v_ErrorMessage = 'Error Processing Data';
                  ROLLBACK;
                  DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;
                  IF v_ErrorMessage <> '' then

	
                     CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'ReturnReceipt_CreateGLTransaction',
                     v_ErrorMessage,v_ErrorID);
                     CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'ReceiptID',v_ReceiptID);
                  end if;
                  SET SWP_Ret_Value = -1;
               end if;
               LEAVE TransactionFinish;
            end if;
         end if;
-- insert into TransactionsDetail the records from ReceiptsDetail
-- Debit Receipt Amount to Bank Account
         SET @SWV_Error = 0;
         INSERT INTO tt_LedgerDetailTmp(GLTransactionAccount ,
	GLDebitAmount,
	GLCreditAmount,
	ProjectID)
         SELECT
         v_GLBankAccount,
		SUM(fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,AppliedAmount*v_CurrencyExchangeRate, 
         v_CompanyCurrencyID)),
		0,
		ProjectID
         FROM
         ReceiptsDetail
         WHERE
         CompanyID = v_CompanyID AND
         DivisionID = v_DivisionID AND
         DepartmentID = v_DepartmentID AND
         ReceiptID = v_ReceiptID AND
         IFNULL(AppliedAmount,0) > 0
         GROUP BY ProjectID;
         IF @SWV_Error <> 0 then

            SET v_ErrorMessage = 'Error Processing Data';
            ROLLBACK;
            DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;
            IF v_ErrorMessage <> '' then

	
               CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'ReturnReceipt_CreateGLTransaction',
               v_ErrorMessage,v_ErrorID);
               CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'ReceiptID',v_ReceiptID);
            end if;
            SET SWP_Ret_Value = -1;
         end if;


-- Credit Receipt amount from Account Receivable
         SET @SWV_Error = 0;
         INSERT INTO tt_LedgerDetailTmp(GLTransactionAccount ,
	GLDebitAmount,
	GLCreditAmount,
	ProjectID)
         SELECT
         Companies.GLARAccount,
	0,
	SUM(fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,AppliedAmount*v_CurrencyExchangeRate, 
         v_CompanyCurrencyID)),
	ProjectID
         FROM
         ReceiptsDetail INNER JOIN Companies ON
         ReceiptsDetail.CompanyID = Companies.CompanyID AND
         ReceiptsDetail.DivisionID = Companies.DivisionID AND
         ReceiptsDetail.DepartmentID = Companies.DepartmentID
         WHERE
         ReceiptsDetail.CompanyID = v_CompanyID AND
         ReceiptsDetail.DivisionID = v_DivisionID AND
         ReceiptsDetail.DepartmentID = v_DepartmentID AND
         ReceiptsDetail.ReceiptID = v_ReceiptID AND
         IFNULL(AppliedAmount,0) > 0
         GROUP BY Companies.GLARAccount,ProjectID;
         IF @SWV_Error <> 0 then

            SET v_ErrorMessage = 'Error Processing Data';
            ROLLBACK;
            DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;
            IF v_ErrorMessage <> '' then

	
               CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'ReturnReceipt_CreateGLTransaction',
               v_ErrorMessage,v_ErrorID);
               CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'ReceiptID',v_ReceiptID);
            end if;
            SET SWP_Ret_Value = -1;
         end if;
         IF EXISTS(SELECT DiscountTaken
         FROM
         ReceiptsDetail
         WHERE
         CompanyID = v_CompanyID AND
         DivisionID = v_DivisionID AND
         DepartmentID = v_DepartmentID AND
         ReceiptID = v_ReceiptID AND
         IFNULL(DiscountTaken,0) > 0) then

	-- Debit DiscountTaken to GLARDiscountAccount
            SET @SWV_Error = 0;
            INSERT INTO tt_LedgerDetailTmp(GLTransactionAccount ,
		GLDebitAmount,
		GLCreditAmount,
		ProjectID)
            SELECT
            v_DiscountAccount,
		SUM(fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,DiscountTaken*v_CurrencyExchangeRate, 
            v_CompanyCurrencyID)),
		0,
		ProjectID
            FROM
            ReceiptsDetail
            WHERE
            ReceiptsDetail.CompanyID = v_CompanyID AND
            ReceiptsDetail.DivisionID = v_DivisionID AND
            ReceiptsDetail.DepartmentID = v_DepartmentID AND
            ReceiptsDetail.ReceiptID = v_ReceiptID AND
            IFNULL(DiscountTaken,0) > 0
            GROUP BY
            ProjectID;
            IF @SWV_Error <> 0 then
	
               SET v_ErrorMessage = 'Error Processing Data';
               ROLLBACK;
               DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;
               IF v_ErrorMessage <> '' then

	
                  CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'ReturnReceipt_CreateGLTransaction',
                  v_ErrorMessage,v_ErrorID);
                  CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'ReceiptID',v_ReceiptID);
               end if;
               SET SWP_Ret_Value = -1;
            end if;
	
	-- Credit DiscountTaken from AR Account
            SET @SWV_Error = 0;
            INSERT INTO tt_LedgerDetailTmp(GLTransactionAccount ,
		GLDebitAmount,
		GLCreditAmount,
		ProjectID)
            SELECT
            v_GLARAccount,
		0,
		SUM(fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,DiscountTaken*v_CurrencyExchangeRate, 
            v_CompanyCurrencyID)),
		ProjectID
            FROM
            ReceiptsDetail
            WHERE
            ReceiptsDetail.CompanyID = v_CompanyID AND
            ReceiptsDetail.DivisionID = v_DivisionID AND
            ReceiptsDetail.DepartmentID = v_DepartmentID AND
            ReceiptsDetail.ReceiptID = v_ReceiptID AND
            IFNULL(DiscountTaken,0) > 0
            GROUP BY
            ProjectID;
            IF @SWV_Error <> 0 then
	
               SET v_ErrorMessage = 'Error Processing Data';
               ROLLBACK;
               DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;
               IF v_ErrorMessage <> '' then

	
                  CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'ReturnReceipt_CreateGLTransaction',
                  v_ErrorMessage,v_ErrorID);
                  CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'ReceiptID',v_ReceiptID);
               end if;
               SET SWP_Ret_Value = -1;
            end if;
         end if;
         IF EXISTS(SELECT WriteOffAmount
         FROM
         ReceiptsDetail
         WHERE
         CompanyID = v_CompanyID AND
         DivisionID = v_DivisionID AND
         DepartmentID = v_DepartmentID AND
         ReceiptID = v_ReceiptID AND
         IFNULL(WriteOffAmount,0) > 0) then

	-- Debit WriteOffAmount to GLARWriteOffAccount
            SET @SWV_Error = 0;
            INSERT INTO tt_LedgerDetailTmp(GLTransactionAccount ,
		GLDebitAmount,
		GLCreditAmount,
		ProjectID)
            SELECT
            v_WriteOffAccount,
		SUM(fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,WriteOffAmount*v_CurrencyExchangeRate, 
            v_CompanyCurrencyID)),
		0,
		ProjectID
            FROM
            ReceiptsDetail
            WHERE
            ReceiptsDetail.CompanyID = v_CompanyID AND
            ReceiptsDetail.DivisionID = v_DivisionID AND
            ReceiptsDetail.DepartmentID = v_DepartmentID AND
            ReceiptsDetail.ReceiptID = v_ReceiptID AND
            IFNULL(WriteOffAmount,0) > 0
            GROUP BY
            ProjectID;
            IF @SWV_Error <> 0 then
	
               SET v_ErrorMessage = 'Error Processing Data';
               ROLLBACK;
               DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;
               IF v_ErrorMessage <> '' then

	
                  CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'ReturnReceipt_CreateGLTransaction',
                  v_ErrorMessage,v_ErrorID);
                  CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'ReceiptID',v_ReceiptID);
               end if;
               SET SWP_Ret_Value = -1;
            end if;
	
	-- Credit WriteOffAmount from Account Receivable
            SET @SWV_Error = 0;
            INSERT INTO tt_LedgerDetailTmp(GLTransactionAccount ,
		GLDebitAmount,
		GLCreditAmount,
		ProjectID)
            SELECT
            v_GLARAccount,
		0,
		SUM(fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,WriteOffAmount*v_CurrencyExchangeRate, 
            v_CompanyCurrencyID)),
		ProjectID
            FROM
            ReceiptsDetail
            WHERE
            ReceiptsDetail.CompanyID = v_CompanyID AND
            ReceiptsDetail.DivisionID = v_DivisionID AND
            ReceiptsDetail.DepartmentID = v_DepartmentID AND
            ReceiptsDetail.ReceiptID = v_ReceiptID AND
            IFNULL(WriteOffAmount,0) > 0
            GROUP BY
            ProjectID;
            IF @SWV_Error <> 0 then
	
               SET v_ErrorMessage = 'Error Processing Data';
               ROLLBACK;
               DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;
               IF v_ErrorMessage <> '' then

	
                  CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'ReturnReceipt_CreateGLTransaction',
                  v_ErrorMessage,v_ErrorID);
                  CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'ReceiptID',v_ReceiptID);
               end if;
               SET SWP_Ret_Value = -1;
            end if;
         end if;

-- insert the information in the LedgerTransactionsDetail group by GLTransactionAccount, CurrencyID, CurrencyExchangeRate
         SET @SWV_Error = 0;
      END;
      INSERT INTO LedgerTransactionsDetail(CompanyID,
	DivisionID,
	DepartmentID,
	GLTransactionNumber,
	GLTransactionAccount,
	GLDebitAmount,
	GLCreditAmount,
	ProjectID)
      SELECT
      v_CompanyID,
		v_DivisionID,
		v_DepartmentID,
		v_GLTransNumber,
		GLTransactionAccount,
		SUM(IFNULL(GLDebitAmount,0)),
		SUM(IFNULL(GLCreditAmount,0)),
		ProjectID
      FROM
      tt_LedgerDetailTmp
      GROUP BY
      GLTransactionAccount,ProjectID;
      IF @SWV_Error <> 0 then

         SET v_ErrorMessage = 'Insert into LedgerTransactionsDetail failed';
         ROLLBACK;
         DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;
         IF v_ErrorMessage <> '' then

	
            CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'ReturnReceipt_CreateGLTransaction',
            v_ErrorMessage,v_ErrorID);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'ReceiptID',v_ReceiptID);
         end if;
         SET SWP_Ret_Value = -1;
      end if;

/*
update the information in the Ledger Chart of Accounts fro the accounts of the newly inserted transaction

parameters	@CompanyID NVARCHAR(36),
		@DivisionID NVARCHAR(36),
		@DepartmentID NVARCHAR(36),
		@GLTransNumber NVARCHAR (36)
		used to identify the TRANSACTION
		@PostCOA BIT - used in the process of creation of the transaction
*/
      SET @SWV_Error = 0;
      CALL LedgerTransactions_PostCOA_AllRecords2(v_CompanyID,v_DivisionID,v_DepartmentID,v_GLTransNumber, v_ReturnStatus);
      IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then

         SET v_ErrorMessage = 'LedgerTransactions_PostCOA_AllRecords call failed';
         ROLLBACK;
         DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;
         IF v_ErrorMessage <> '' then

	
            CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'ReturnReceipt_CreateGLTransaction',
            v_ErrorMessage,v_ErrorID);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'ReceiptID',v_ReceiptID);
         end if;
         SET SWP_Ret_Value = -1;
      end if;

-- drop temporary table used for ledger details
      DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;
      COMMIT;
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


   DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;

   IF v_ErrorMessage <> '' then

	
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'ReturnReceipt_CreateGLTransaction',
      v_ErrorMessage,v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'ReceiptID',v_ReceiptID);
   end if;

   SET SWP_Ret_Value = -1;
END;













//

DELIMITER ;

DELIMITER //
DROP PROCEDURE IF EXISTS ReturnReceipt_Cash;
//
CREATE      PROCEDURE ReturnReceipt_Cash(v_CompanyID NATIONAL VARCHAR(36), 
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_InvoiceNumber NATIONAL VARCHAR(36),
	v_ReceiptID NATIONAL VARCHAR(36),
	v_ReceiptType NATIONAL VARCHAR(36),
	v_TransactionType NATIONAL VARCHAR(36),
	v_Amount DECIMAL(19,4),
	INOUT v_Result SMALLINT ,INOUT SWP_Ret_Value INT)
   SWL_return:
BEGIN









/*
Name of stored procedure: ReturnReceipt_Cash
Method: 
	takes all the necessary actions to cash a return receiped

Date Created: EDE - 07/28/2015

Input Parameters:

	@CompanyID NVARCHAR(36)		 - the ID of the company
	@DivisionID NVARCHAR(36)	 - the ID of the division
	@DepartmentID NVARCHAR(36)	 - the ID of the department
	@InvoiceNumber NVARCHAR(36)	 - the the number of the cashed transaction
	@ReceiptID NVARCHAR(36)		 - the ID of the cash
	@ReceiptType NVARCHAR(36)	 - the cash type ('Receipt' or 'Credit Memo')
	@TransactionType NVARCHAR(36)	 - the transacition type ("Debit memo" or "Return Invoice")
	@Amount MONEY			 - the cash amount

Output Parameters:

	@Result SMALLINT 		 - return value

						   1 - the cash is applied to the invoice

						   0 - the cash was not applied to the invoice

Called From:

	ReturnReceipt_Cash.vb

Calls:

	GetNextEntityID, CreditMemo_Post, ReceiptCash_Return_CreateGLTransaction, VendorFinancials_Recalc, Error_InsertError, Error_InsertErrorDetail

Last Modified: 

Last Modified By: 

Revision History: 

*/

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

-- customer info
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

-- get information about the invoice
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
-- verify if the invoice can be used
   IF v_InvoicePost <> 1 OR v_InvoiceBalance = 0 OR v_InvoiceTotal = 0 then

      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;
   end if;

   IF v_ReceiptType = 'Credit Memo' then
	-- get the information about the credit memo
      select   1, IFNULL(Total,0) -IFNULL(AmountPaid,0), IFNULL(Total,0) -IFNULL(AmountPaid,0), CurrencyID, CurrencyExchangeRate, CheckNumber, InvoiceDate INTO v_ReceiptPost,v_ReceiptCreditAmount,v_ReceiptAmount,v_ReceiptCurrencyID,
      v_CurrencyExchangeRate,v_ReceiptCheckNumber,v_ReceiptCheckDate FROM
      InvoiceHeader WHERE
      CompanyID = v_CompanyID AND
      DivisionID = v_DivisionID AND
      DepartmentID = v_DepartmentID AND
      InvoiceNumber = v_ReceiptID;
   ELSE
	-- get the information about the receipt
      select   IFNULL(Posted,0), IFNULL(CreditAmount,IFNULL(Amount,0)), IFNULL(Amount,0), CurrencyID, CurrencyExchangeRate, CheckNumber, TransactionDate INTO v_ReceiptPost,v_ReceiptCreditAmount,v_ReceiptAmount,v_ReceiptCurrencyID,
      v_CurrencyExchangeRate,v_ReceiptCheckNumber,v_ReceiptCheckDate FROM
      ReceiptsHeader WHERE
      CompanyID = v_CompanyID AND
      DivisionID = v_DivisionID AND
      DepartmentID = v_DepartmentID AND
      ReceiptID = v_ReceiptID;
   end if;

-- verify if the receipt can be used
   IF v_ReceiptPost <> 1 OR v_ReceiptCreditAmount = 0 OR v_ReceiptAmount = 0 then

      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;
   end if;

-- verify if the invoice and the receipt are in the same currency
   IF v_InvoiceCurrencyID <> v_ReceiptCurrencyID then

      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;
   end if;

-- get the total amount of money the receipts has to transfer

   SET v_PayInvoice = v_ReceiptCreditAmount;
-- if the amount is greater that the invoice needs to be totally paid get only
-- the amount needed to pay the invoice
   IF v_PayInvoice > v_InvoiceTotal -v_InvoiceAmountPaid then

      SET v_PayInvoice = v_InvoiceTotal -v_InvoiceAmountPaid;
      SET v_Result = 1;
   ELSE
      SET v_Result = 0;
   end if;

-- reduce the amount if specified
   IF v_Amount IS NOT NULL AND v_PayInvoice > v_Amount then

      SET v_PayInvoice = v_Amount;
   end if;

   START TRANSACTION;

-- cash the receipt
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
-- the error handler
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
-- the error handler
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'ReturnReceipt_Cash',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'ReceiptID',v_ReceiptID);
         SET SWP_Ret_Value = -1;
      end if;
   ELSE
	-- update the receipt header and substract from the credit amount the money used to pay the invoice
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
-- the error handler
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'ReturnReceipt_Cash',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'ReceiptID',v_ReceiptID);
         SET SWP_Ret_Value = -1;
      end if;
   end if;

-- create a credit memo if we have some money left (if it's not already created)

   IF (v_PayInvoice < v_ReceiptCreditAmount) AND (IFNULL(v_ReceiptType,'') <> 'Credit Memo') then

      SET @SWV_Error = 0;
      CALL GetNextEntityID2(v_CompanyID,v_DivisionID,v_DepartmentID,'NextInvoiceNumber',v_CreditMemoNumber, v_ReturnStatus);
      IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then
	
         SET v_ErrorMessage = 'GetNextEntityID call failed';
         ROLLBACK;
-- the error handler
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'ReturnReceipt_Cash',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'ReceiptID',v_ReceiptID);
         SET SWP_Ret_Value = -1;
      end if;
      -- NOT SUPPORTED PRINT CONCAT('@CreditMemoNumber = ', @CreditMemoNumber)


	-- obtain Vendor info	
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
-- the error handler
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
-- the error handler
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
-- the error handler
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'ReturnReceipt_Cash',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'ReceiptID',v_ReceiptID);
         SET SWP_Ret_Value = -1;
      end if;

	-- Post created Credit Memo
      SET @SWV_Error = 0;
      CALL CreditMemo_Post(v_CompanyID,v_DivisionID,v_DepartmentID,v_CreditMemoNumber, v_PostingResult, v_ReturnStatus);
      IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then
	-- An error occured, go to the error handler
	
         SET v_ErrorMessage = 'CreditMemo_Post call failed';
         ROLLBACK;
-- the error handler
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
-- An error occured, go to the error handler

      SET v_ErrorMessage = 'ReceiptCash_Return_CreateGLTransaction call failed';
      ROLLBACK;
-- the error handler
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'ReturnReceipt_Cash',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'ReceiptID',v_ReceiptID);
      SET SWP_Ret_Value = -1;
   end if;

   SET @SWV_Error = 0;
   SET v_ReturnStatus = VendorFinancials_ReCalc2(v_CompanyID,v_DivisionID,v_DepartmentID,v_VendorID);
   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then
-- An error occured, go to the error handler

      SET v_ErrorMessage = 'VendorFinancials_Recalc call failed';
      ROLLBACK;
-- the error handler
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'ReturnReceipt_Cash',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'ReceiptID',v_ReceiptID);
      SET SWP_Ret_Value = -1;
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
   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'ReturnReceipt_Cash',v_ErrorMessage,
   v_ErrorID);

   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'ReceiptID',v_ReceiptID);

   SET SWP_Ret_Value = -1;
END;























//

DELIMITER ;

DELIMITER //
DROP PROCEDURE IF EXISTS FinancialsRecalc;
//
CREATE  PROCEDURE FinancialsRecalc(v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),INOUT SWP_Ret_Value INT)
   SWL_return:
BEGIN







/*
Name of stored procedure: FinancialsRecalc
Method: 
	Recalculalates financial information for all customers and vendors in the system.

Date Created: EDE - 07/28/2015

Input Parameters:

	@CompanyID NVARCHAR(36)		 - the ID of the company
	@DivisionID NVARCHAR(36)	 - the ID of the division
	@DepartmentID NVARCHAR(36)	 - the ID of the department

Output Parameters:

	NONE

Called From:

	Ledger_PeriodEndClose

Calls:

	CustomerFinancials_ReCalc, VendorFinancials_ReCalc, Error_InsertError

Last Modified: 

Last Modified By: 

Revision History: 

*/

   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);
   DECLARE v_CustomerID NATIONAL VARCHAR(36);
   DECLARE v_VendorID NATIONAL VARCHAR(36);

   DECLARE v_ErrorID INT;
   DECLARE NO_DATA INT DEFAULT 0;
   DECLARE cCustomerInformati CURSOR 
   FOR SELECT 
   CustomerID
   FROM 
   CustomerInformation
   WHERE	
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND IFNULL(ConvertedFromVendor,0) = 0;

   DECLARE cVendorInformation CURSOR 
   FOR SELECT 
   VendorID
   FROM 
   VendorInformation
   WHERE	
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND IFNULL(ConvertedFromCustomer,0) = 0;


   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
      SET NO_DATA = -2;
   END;
   DECLARE CONTINUE HANDLER FOR NOT FOUND SET NO_DATA = -1;
   SET @SWV_Error = 0;
   START TRANSACTION;

   OPEN cCustomerInformati;
   SET NO_DATA = 0;
   FETCH cCustomerInformati INTO v_CustomerID;
   WHILE NO_DATA = 0 DO
      SET @SWV_Error = 0;
      CALL CustomerFinancials_ReCalc(v_CompanyID,v_DivisionID,v_DepartmentID,v_CustomerID, v_ReturnStatus);
      IF @SWV_Error <> 0 OR v_ReturnStatus <> 0 then
	
         CLOSE cCustomerInformati;
		
         SET v_ErrorMessage = 'CustomerFinancials_Recalc call failed';
         ROLLBACK;

-- the error handler
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'FinancialsRecalc',v_ErrorMessage,
         v_ErrorID);
         SET SWP_Ret_Value = -1;
      end if;
      SET NO_DATA = 0;
      FETCH cCustomerInformati INTO v_CustomerID;
   END WHILE;
   CLOSE cCustomerInformati;


   OPEN cVendorInformation;
   SET NO_DATA = 0;
   FETCH cVendorInformation INTO v_VendorID;
   WHILE NO_DATA = 0 DO
      SET @SWV_Error = 0;
      SET v_ReturnStatus =  VendorFinancials_ReCalc2(v_CompanyID,v_DivisionID,v_DepartmentID,v_VendorID);
      IF @SWV_Error <> 0 OR v_ReturnStatus <> 0  then
	
         CLOSE cVendorInformation;
		
         SET v_ErrorMessage = 'VendorFinancials_Recalc2 call failed';
         ROLLBACK;

-- the error handler
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'FinancialsRecalc',v_ErrorMessage,
         v_ErrorID);
         SET SWP_Ret_Value = -1;
      end if;
      SET NO_DATA = 0;
      FETCH cVendorInformation INTO v_VendorID;
   END WHILE;
   CLOSE cVendorInformation;


-- Everyting is OK
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
   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'FinancialsRecalc',v_ErrorMessage,
   v_ErrorID);

   SET SWP_Ret_Value = -1;
END;







//

DELIMITER ;

DELIMITER //
DROP PROCEDURE IF EXISTS Ledger_PeriodEndClose;
//
CREATE PROCEDURE Ledger_PeriodEndClose(v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),INOUT SWP_Ret_Value INT)
   SWL_return:
BEGIN


/*
Name of stored procedure: Ledger_PeriodEndClose
Method:
	This procedure closes the current period and
	copies the proper values in the right fields in
	the Customer and the Chart of Accounts tables
Date Created: EDE - 07/28/2015
Input Parameters:
	@CompanyID NVARCHAR(36)		 - the ID of the company
	@DivisionID NVARCHAR(36)	 - the ID of the division
	@DepartmentID NVARCHAR(36)	 - the ID of the department
Output Parameters:
	NONE
Called From:
	Ledger_PeriodEndClose.vb
Calls:
	LedgerMain_CurrentPeriod, FinancialsRecalc, Error_InsertError
Last Modified: 3/4/2009
Last Modified By:
Revision History:
*/

   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);
-- First, we find out the month and the year we need to close
   DECLARE v_CurrentYear SMALLINT;
   DECLARE v_CurrentPeriod INT;
   DECLARE v_PeriodStartDate DATETIME;
   DECLARE v_PeriodEndDate DATETIME;
   DECLARE v_NextPeriodStartDate DATETIME;
   DECLARE v_ErrorID INT;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
   END;
   SET @SWV_Error = 0;
   START TRANSACTION;
   CALL LedgerMain_CurrentPeriod2(v_CompanyID,v_DivisionID,v_DepartmentID,v_CurrentPeriod,v_PeriodStartDate,
   v_PeriodEndDate, v_ReturnStatus);

   IF v_ReturnStatus <> 0 then   -- fail to receive current Period

      SET v_ErrorMessage = 'Fail to get current Period';
      ROLLBACK;
-- the error handler
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Ledger_PeriodEndClose',v_ErrorMessage,
      v_ErrorID);
      SET SWP_Ret_Value = -1;
   end if;

-- to indicate all periods have been closed
   IF v_PeriodEndDate IS NULL then

      SET v_ErrorMessage = 'All Periods have been closed.';
      ROLLBACK;
-- the error handler
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Ledger_PeriodEndClose',v_ErrorMessage,
      v_ErrorID);
      SET SWP_Ret_Value = -1;
   end if;

   IF v_PeriodEndDate >= CURRENT_TIMESTAMP then

      SET v_ErrorMessage = 'Can''t close period. Current period is not finished yet.';
      ROLLBACK;
-- the error handler
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Ledger_PeriodEndClose',v_ErrorMessage,
      v_ErrorID);
      SET SWP_Ret_Value = -1;
   end if;

   select   CurrentFiscalYear INTO v_CurrentYear FROM
   Companies WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID
   AND CurrentFiscalYear = YEAR(CurrentPeriod);
   SET v_NextPeriodStartDate = TIMESTAMPADD(day,1,v_PeriodEndDate);
   SET v_NextPeriodStartDate = STR_TO_DATE(DATE_FORMAT(v_NextPeriodStartDate,'%Y-%m-%d'),'%Y%m%d');
-- next we recalc the financials
   SET @SWV_Error = 0;
   CALL FinancialsRecalc(v_CompanyID,v_DivisionID,v_DepartmentID, v_ReturnStatus);
   IF @SWV_Error <> 0 AND v_ReturnStatus = -1 then
	-- An error occured, go to the error handler
	
      SET v_ErrorMessage = 'Financials recalc failed';
      ROLLBACK;
-- the error handler
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Ledger_PeriodEndClose',v_ErrorMessage,
      v_ErrorID);
      SET SWP_Ret_Value = -1;
   end if;	

-- then we select the transactions of that period from
-- ledger transactions detail and do the balance
   CREATE TEMPORARY TABLE tt_Temp AS SELECT
      CASE
      WHEN SUM(IFNULL(GLCreditAmount,0) -IFNULL(GLDebitAmount,0)) < 0 THEN -SUM(IFNULL(GLCreditAmount,0) -IFNULL(GLDebitAmount,0))
      ELSE SUM(IFNULL(GLCreditAmount,0) -IFNULL(GLDebitAmount,0))
      END AS Balance,
		GLTransactionAccount

      FROM
      LedgerTransactionsDetail
      INNER JOIN LedgerChartOfAccounts ON
      GLTransactionAccount = GLAccountNumber AND
      LedgerTransactionsDetail.CompanyID = LedgerChartOfAccounts.CompanyID AND
      LedgerTransactionsDetail.DivisionID = LedgerChartOfAccounts.DivisionID AND
      LedgerTransactionsDetail.DepartmentID = LedgerChartOfAccounts.DepartmentID
      INNER JOIN LedgerTransactions ON
      LedgerTransactionsDetail.GLTransactionNumber = LedgerTransactions.GLTransactionNumber
      WHERE
      LedgerTransactionsDetail.CompanyID = v_CompanyID AND
      LedgerTransactionsDetail.DivisionID = v_DivisionID AND
      LedgerTransactionsDetail.DepartmentID = v_DepartmentID AND
      LedgerTransactions.GLTransactionDate < v_NextPeriodStartDate AND
      IFNULL(LedgerTransactions.GLTransactionPostedYN,0) = 1 AND
      UPPER(LedgerTransactions.GLTransactionNumber) <> 'DEFAULT'
      GROUP BY
      GLTransactionAccount;
   IF @SWV_Error <> 0 then
-- An error occured, go to the error handler
	
      SET v_ErrorMessage = 'Selecting summaries from LedgerTransactionsDetail failed';
      ROLLBACK;
-- the error handler
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Ledger_PeriodEndClose',v_ErrorMessage,
      v_ErrorID);
      SET SWP_Ret_Value = -1;
   end if;
-- Then we update the Chart Of Accounts for the proper period
-- and we update the Companies table for the proper period
-- 1 period is closing
   SET @SWV_Error = 0;
   IF v_CurrentPeriod = 0 then

      UPDATE
      LedgerChartOfAccounts
      SET
      GLCurrentYearPeriod1 =(SELECT
      Balance
      FROM
      tt_Temp T
      WHERE
      T.GLTransactionAccount = GLAccountNumber)
      WHERE
      CompanyID = v_CompanyID AND
      DivisionID = v_DivisionID AND
      DepartmentID = v_DepartmentID;
-- 2 period is closing
   ELSE 
      IF v_CurrentPeriod = 1 then

         UPDATE
         LedgerChartOfAccounts
         SET
         GLCurrentYearPeriod2 =(SELECT
         Balance
         FROM
         tt_Temp T
         WHERE
         T.GLTransactionAccount = GLAccountNumber)
         WHERE
         CompanyID = v_CompanyID AND
         DivisionID = v_DivisionID AND
         DepartmentID = v_DepartmentID;
-- 3 period is closing
      ELSE 
         IF v_CurrentPeriod = 2 then

            UPDATE
            LedgerChartOfAccounts
            SET
            GLCurrentYearPeriod3 =(SELECT
            Balance
            FROM
            tt_Temp T
            WHERE
            T.GLTransactionAccount = GLAccountNumber)
            WHERE
            CompanyID = v_CompanyID AND
            DivisionID = v_DivisionID AND
            DepartmentID = v_DepartmentID;
-- 4 period is closing
         ELSE 
            IF v_CurrentPeriod = 3 then

               UPDATE
               LedgerChartOfAccounts
               SET
               GLCurrentYearPeriod4 =(SELECT
               Balance
               FROM
               tt_Temp T
               WHERE
               T.GLTransactionAccount = GLAccountNumber)
               WHERE
               CompanyID = v_CompanyID AND
               DivisionID = v_DivisionID AND
               DepartmentID = v_DepartmentID;
-- 5 period is closing
            ELSE 
               IF v_CurrentPeriod = 4 then

                  UPDATE
                  LedgerChartOfAccounts
                  SET
                  GLCurrentYearPeriod5 =(SELECT
                  Balance
                  FROM
                  tt_Temp T
                  WHERE
                  T.GLTransactionAccount = GLAccountNumber)
                  WHERE
                  CompanyID = v_CompanyID AND
                  DivisionID = v_DivisionID AND
                  DepartmentID = v_DepartmentID;
-- 6 period is closing
               ELSE 
                  IF v_CurrentPeriod = 5 then

                     UPDATE
                     LedgerChartOfAccounts
                     SET
                     GLCurrentYearPeriod6 =(SELECT
                     Balance
                     FROM
                     tt_Temp T
                     WHERE
                     T.GLTransactionAccount = GLAccountNumber)
                     WHERE
                     CompanyID = v_CompanyID AND
                     DivisionID = v_DivisionID AND
                     DepartmentID = v_DepartmentID;
-- 7 period is closing
                  ELSE 
                     IF v_CurrentPeriod = 6 then

                        UPDATE
                        LedgerChartOfAccounts
                        SET
                        GLCurrentYearPeriod7 =(SELECT
                        Balance
                        FROM
                        tt_Temp T
                        WHERE
                        T.GLTransactionAccount = GLAccountNumber)
                        WHERE
                        CompanyID = v_CompanyID AND
                        DivisionID = v_DivisionID AND
                        DepartmentID = v_DepartmentID;
-- 8 period is closing
                     ELSE 
                        IF v_CurrentPeriod = 7 then

                           UPDATE
                           LedgerChartOfAccounts
                           SET
                           GLCurrentYearPeriod8 =(SELECT
                           Balance
                           FROM
                           tt_Temp T
                           WHERE
                           T.GLTransactionAccount = GLAccountNumber)
                           WHERE
                           CompanyID = v_CompanyID AND
                           DivisionID = v_DivisionID AND
                           DepartmentID = v_DepartmentID;
-- 9 period is closing
                        ELSE 
                           IF v_CurrentPeriod = 8 then

                              UPDATE
                              LedgerChartOfAccounts
                              SET
                              GLCurrentYearPeriod9 =(SELECT
                              Balance
                              FROM
                              tt_Temp T
                              WHERE
                              T.GLTransactionAccount = GLAccountNumber)
                              WHERE
                              CompanyID = v_CompanyID AND
                              DivisionID = v_DivisionID AND
                              DepartmentID = v_DepartmentID;
-- 10 period is closing
                           ELSE 
                              IF v_CurrentPeriod = 9 then

                                 UPDATE
                                 LedgerChartOfAccounts
                                 SET
                                 GLCurrentYearPeriod10 =(SELECT
                                 Balance
                                 FROM
                                 tt_Temp T
                                 WHERE
                                 T.GLTransactionAccount = GLAccountNumber)
                                 WHERE
                                 CompanyID = v_CompanyID AND
                                 DivisionID = v_DivisionID AND
                                 DepartmentID = v_DepartmentID;
                              ELSE 
                                 IF v_CurrentPeriod = 10 then

                                    UPDATE
                                    LedgerChartOfAccounts
                                    SET
                                    GLCurrentYearPeriod11 =(SELECT
                                    Balance
                                    FROM
                                    tt_Temp T
                                    WHERE
                                    T.GLTransactionAccount = GLAccountNumber)
                                    WHERE
                                    CompanyID = v_CompanyID AND
                                    DivisionID = v_DivisionID AND
                                    DepartmentID = v_DepartmentID;
                                 ELSE 
                                    IF v_CurrentPeriod = 11 then

                                       UPDATE
                                       LedgerChartOfAccounts
                                       SET
                                       GLCurrentYearPeriod12 =(SELECT
                                       Balance
                                       FROM
                                       tt_Temp T
                                       WHERE
                                       T.GLTransactionAccount = GLAccountNumber)
                                       WHERE
                                       CompanyID = v_CompanyID AND
                                       DivisionID = v_DivisionID AND
                                       DepartmentID = v_DepartmentID;
                                    ELSE 
                                       IF v_CurrentPeriod = 12 then

                                          UPDATE
                                          LedgerChartOfAccounts
                                          SET
                                          GLCurrentYearPeriod13 =(SELECT
                                          Balance
                                          FROM
                                          tt_Temp T
                                          WHERE
                                          T.GLTransactionAccount = GLAccountNumber)
                                          WHERE
                                          CompanyID = v_CompanyID AND
                                          DivisionID = v_DivisionID AND
                                          DepartmentID = v_DepartmentID;
                                       ELSE 
                                          IF v_CurrentPeriod = 13 then

                                             UPDATE
                                             LedgerChartOfAccounts
                                             SET
                                             GLCurrentYearPeriod14 =(SELECT
                                             Balance
                                             FROM
                                             tt_Temp T
                                             WHERE
                                             T.GLTransactionAccount = GLAccountNumber)
                                             WHERE
                                             CompanyID = v_CompanyID AND
                                             DivisionID = v_DivisionID AND
                                             DepartmentID = v_DepartmentID;
                                          end if;
                                       end if;
                                    end if;
                                 end if;
                              end if;
                           end if;
                        end if;
                     end if;
                  end if;
               end if;
            end if;
         end if;
      end if;
   end if;
   IF @SWV_Error <> 0 then
-- An error occured, go to the error handler

      SET v_ErrorMessage = 'Updating LedgerChartOfAccounts failed';
      ROLLBACK;
-- the error handler
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Ledger_PeriodEndClose',v_ErrorMessage,
      v_ErrorID);
      SET SWP_Ret_Value = -1;
   end if;	
   SET @SWV_Error = 0;
   UPDATE
   Companies
   SET
   Period1Closed = CASE v_CurrentPeriod WHEN 0 THEN 1 ELSE Period1Closed END,Period2Closed = CASE v_CurrentPeriod WHEN 1 THEN 1 ELSE Period2Closed END,Period3Closed = CASE v_CurrentPeriod WHEN 2 THEN 1 ELSE Period3Closed END,Period4Closed = CASE v_CurrentPeriod WHEN 3 THEN 1 ELSE Period4Closed END,Period5Closed = CASE v_CurrentPeriod WHEN 4 THEN 1 ELSE Period5Closed END,Period6Closed = CASE v_CurrentPeriod WHEN 5 THEN 1 ELSE Period6Closed END,Period7Closed = CASE v_CurrentPeriod WHEN 6 THEN 1 ELSE Period7Closed END,Period8Closed = CASE v_CurrentPeriod WHEN 7 THEN 1 ELSE Period8Closed END,Period9Closed = CASE v_CurrentPeriod WHEN 8 THEN 1 ELSE Period9Closed END,Period10Closed = CASE v_CurrentPeriod WHEN 9 THEN 1 ELSE Period10Closed END,Period11Closed = CASE v_CurrentPeriod WHEN 10 THEN 1 ELSE Period11Closed END,Period12Closed = CASE v_CurrentPeriod WHEN 11 THEN 1 ELSE Period12Closed END,Period13Closed = CASE v_CurrentPeriod WHEN 12 THEN 1 ELSE Period13Closed END,Period14Closed = CASE v_CurrentPeriod WHEN 13 THEN 1 ELSE Period14Closed END
   WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID;
   IF @SWV_Error <> 0 then
-- An error occured, go to the error handler

      SET v_ErrorMessage = 'Updating Companies failed';
      ROLLBACK;
-- the error handler
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Ledger_PeriodEndClose',v_ErrorMessage,
      v_ErrorID);
      SET SWP_Ret_Value = -1;
   end if;	
-- dropping the temporary table used
   SET @SWV_Error = 0;
   DROP TEMPORARY TABLE IF EXISTS tt_Temp;
   IF @SWV_Error <> 0 then
-- An error occured, go to the error handler

      SET v_ErrorMessage = 'Dropping temporary table failed';
      ROLLBACK;
-- the error handler
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Ledger_PeriodEndClose',v_ErrorMessage,
      v_ErrorID);
      SET SWP_Ret_Value = -1;
   end if;	

-- Update the CurrentPeriod in companies table with PeriodEndDate
   CALL LedgerMain_CurrentPeriod2(v_CompanyID,v_DivisionID,v_DepartmentID,v_CurrentPeriod,v_PeriodStartDate,
   v_PeriodEndDate, v_ReturnStatus);
   IF v_ReturnStatus <> 0 then -- fail to receive current Period

      SET v_ErrorMessage = 'Fail to get current Period';
      ROLLBACK;
-- the error handler
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Ledger_PeriodEndClose',v_ErrorMessage,
      v_ErrorID);
      SET SWP_Ret_Value = -1;
   end if;
   UPDATE
   Companies
   SET
   CurrentPeriod = v_PeriodEndDate
   WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID;
-- Everyting is OK
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
   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Ledger_PeriodEndClose',v_ErrorMessage,
   v_ErrorID);
   SET SWP_Ret_Value = -1;
END;







//

DELIMITER ;

DELIMITER //
DROP PROCEDURE IF EXISTS ReceiptCash_Return_CreateGLTransaction;
//
CREATE       PROCEDURE ReceiptCash_Return_CreateGLTransaction(v_CompanyID NATIONAL VARCHAR(36), 
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_InvoiceNumber NATIONAL VARCHAR(36),
	v_PayInvoice DECIMAL(19,4),INOUT SWP_Ret_Value INT)
   SWL_return:
BEGIN






















/*
Name of stored procedure: ReceiptCash_Return_CreateGLTransaction
Method: 
	Creates a new GL transaction for the cashed return invoice

Date Created: EDE - 07/28/2015

Input Parameters:

	@CompanyID NVARCHAR(36)		 - the ID of the company
	@DivisionID NVARCHAR(36)	 - the ID of the division
	@DepartmentID NVARCHAR(36)	 - the ID of the department
	@InvoiceNumber NVARCHAR(36)	 - the return invoice number
	@PayInvoice MONEY		 - the cash amount

Output Parameters:

	NONE

Called From:

	ReturnReceipt_Cash

Calls:

	VerifyCurrency, GetNextEntityID, LedgerTransactions_PostCOA_AllRecords, Error_InsertError, Error_InsertErrorDetail

Last Modified: 

Last Modified By: 

Revision History: 

*/

   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);

   DECLARE v_GLTransNumber NATIONAL VARCHAR(36);
   DECLARE v_ValueDate DATETIME;
   DECLARE v_OldAmount DECIMAL(19,4);
   DECLARE v_NewAmount DECIMAL(19,4);
   DECLARE v_GainLossAmount DECIMAL(19,4);
   DECLARE v_GLInvoiceSalesAccount NATIONAL VARCHAR(36);
   DECLARE v_CurrencyID NATIONAL VARCHAR(3); 
   DECLARE v_CompanyCurrencyID NATIONAL VARCHAR(3); 
   DECLARE v_CurrencyExchangeRate FLOAT;
   DECLARE v_CurrencyExchangeRateNew FLOAT;
   DECLARE v_GLARAccount NATIONAL VARCHAR(36);
   DECLARE v_GLARCashAccount NATIONAL VARCHAR(36);
   DECLARE v_GLGainLossAccount NATIONAL VARCHAR(36);
   DECLARE v_PostingResult NATIONAL VARCHAR(200);
   DECLARE v_ProjectID NATIONAL VARCHAR(36);


-- get the ammount of money from the Invoice
   DECLARE v_PostDate NATIONAL VARCHAR(1);
   DECLARE v_ErrorID INT;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
   END;
   select   GLSalesAccount, CurrencyID, CurrencyExchangeRate INTO v_GLInvoiceSalesAccount,v_CurrencyID,v_CurrencyExchangeRate FROM
   InvoiceHeader WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND InvoiceNumber = v_InvoiceNumber;


   SET v_ValueDate = CURRENT_TIMESTAMP;
   SET @SWV_Error = 0;
   CALL VerifyCurrency2(v_CompanyID,v_DivisionID,v_DepartmentID,v_ValueDate,2,v_CompanyCurrencyID,
   v_CurrencyID,v_CurrencyExchangeRateNew);
   IF @SWV_Error <> 0 then

	-- the procedure will return an error code
      SET v_ErrorMessage = 'Currency retrieving failed';
      ROLLBACK;
      DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;
      IF v_ErrorMessage <> '' then

	-- the error handler
	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'ReceiptCash_Return_CreateGLTransaction',
         v_ErrorMessage,v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
      end if;
      SET SWP_Ret_Value = -1;
   end if;

-- calculate exchange gain/loss
   SET v_OldAmount = fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,v_PayInvoice*v_CurrencyExchangeRate, 
   v_CompanyCurrencyID);
   SET v_NewAmount = fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,v_PayInvoice*v_CurrencyExchangeRateNew, 
   v_CompanyCurrencyID);
   SET v_GainLossAmount = v_NewAmount -v_OldAmount;

   IF ABS(v_GainLossAmount) < 0.005 then

      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;
   end if;


   START TRANSACTION;


/*
a temporary table used to collect information about the details of the Transaction;
at the end, the record from this table will be grouped by the GLTransactionAccount and inserted into the LedgerTransactionsDetail
*/
   CREATE TEMPORARY TABLE tt_LedgerDetailTmp  
   (
      GLTransactionNumberDetail BIGINT NOT NULL  PRIMARY KEY  AUTO_INCREMENT,
      GLTransactionAccount NATIONAL VARCHAR(36),
      GLDebitAmount DECIMAL(19,4),
      GLCreditAmount DECIMAL(19,4),
      ProjectID NATIONAL VARCHAR(36)
   )  AUTO_INCREMENT = 1;

   select   ProjectID INTO v_ProjectID FROM  InvoiceDetail WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND InvoiceNumber = v_InvoiceNumber
   AND NOT ProjectID IS NULL   LIMIT 1;


-- get the transaction number
   SET @SWV_Error = 0;
   CALL GetNextEntityID2(v_CompanyID,v_DivisionID,v_DepartmentID,'NextGLTransNumber',v_GLTransNumber, v_ReturnStatus);
   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then
-- An error occured, go to the error handler

      SET v_ErrorMessage = 'GetNextEntityID call failed';	
      ROLLBACK;
      DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;
      IF v_ErrorMessage <> '' then

	-- the error handler
	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'ReceiptCash_Return_CreateGLTransaction',
         v_ErrorMessage,v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
      end if;
      SET SWP_Ret_Value = -1;
   end if;

   select   IFNULL(DefaultGLPostingDate,'1') INTO v_PostDate FROM
   Companies WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID;


   SET @SWV_Error = 0;
   INSERT INTO LedgerTransactions(CompanyID,
	DivisionID,
	DepartmentID,
	GLTransactionNumber,
	GLTransactionTypeID,
	GLTransactionDate,
	GLTransactionDescription,
	GLTransactionReference,
	CurrencyID,
	CurrencyExchangeRate,
	GLTransactionAmount,
	GLTransactionAmountUndistributed,
	GLTransactionBalance,
	GLTransactionPostedYN,
	GLTransactionSource,
	GLTransactionSystemGenerated)
   SELECT
   v_CompanyID,
		v_DivisionID,
		v_DepartmentID,
		v_GLTransNumber,
		'XRate Adj',
		CASE v_PostDate WHEN '1' THEN CURRENT_TIMESTAMP ELSE InvoiceDate END ,
		CustomerID,
		InvoiceNumber,
		v_CompanyCurrencyID,
		1,
		ABS(v_GainLossAmount),
		0,
		0,
		1,
		CONCAT('INV ',cast(v_InvoiceNumber as char(10))),
		1
   FROM
   InvoiceHeader
   WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND InvoiceNumber = v_InvoiceNumber;
   IF @SWV_Error <> 0 then
-- An error occured, go to the error handler
-- and drop the temporary table

      SET v_ErrorMessage = 'Insert into LedgerTransactions failed';
      ROLLBACK;
      DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;
      IF v_ErrorMessage <> '' then

	-- the error handler
	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'ReceiptCash_Return_CreateGLTransaction',
         v_ErrorMessage,v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
      end if;
      SET SWP_Ret_Value = -1;
   end if;

-- Get Company Account Receivable
   select   GLARAccount, GLARCashAccount, GLCurrencyGainLossAccount INTO v_GLARAccount,v_GLARCashAccount,v_GLGainLossAccount FROM
   Companies WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID;


-- Debit/Credit @GainLossAmount to Account Receivable
   SET @SWV_Error = 0;
   INSERT INTO tt_LedgerDetailTmp(GLTransactionAccount,
		GLDebitAmount,
		GLCreditAmount,
		ProjectID)
		VALUES(CASE WHEN v_GainLossAmount > 0 THEN v_GLARCashAccount ELSE v_GLARAccount END,
			CASE WHEN v_GainLossAmount > 0 THEN v_GainLossAmount ELSE 0 END,
			CASE WHEN v_GainLossAmount < 0 THEN(-1)*v_GainLossAmount ELSE 0 END,
			v_ProjectID);
		
	
   IF @SWV_Error <> 0 then
	
      SET v_ErrorMessage = 'Insert AR into LedgerTransactionsDetail failed';
      ROLLBACK;
      DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;
      IF v_ErrorMessage <> '' then

	-- the error handler
	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'ReceiptCash_Return_CreateGLTransaction',
         v_ErrorMessage,v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
      end if;
      SET SWP_Ret_Value = -1;
   end if;

-- Debit/Credit @GainLossAmount to Gain/Loss Account
   SET @SWV_Error = 0;
   INSERT INTO tt_LedgerDetailTmp(GLTransactionAccount,
		GLDebitAmount,
		GLCreditAmount,
		ProjectID)
		VALUES(v_GLGainLossAccount,
			CASE WHEN v_GainLossAmount < 0 THEN(-1)*v_GainLossAmount ELSE 0 END,
			CASE WHEN v_GainLossAmount > 0 THEN v_GainLossAmount ELSE 0 END,
			v_ProjectID);
		
	
   IF @SWV_Error <> 0 then
	
      SET v_ErrorMessage = 'Insert Gain Loss into LedgerTransactionsDetail failed';
      ROLLBACK;
      DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;
      IF v_ErrorMessage <> '' then

	-- the error handler
	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'ReceiptCash_Return_CreateGLTransaction',
         v_ErrorMessage,v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
      end if;
      SET SWP_Ret_Value = -1;
   end if;


-- insert the data into the LedgerTransactionsDetail table; 
-- the records are grouped by GLTransactionAccount and ProjectID 
   SET @SWV_Error = 0;
   INSERT INTO LedgerTransactionsDetail(CompanyID,
	DivisionID,
	DepartmentID,
	GLTransactionNumber,
	GLTransactionAccount,
	GLDebitAmount,
	GLCreditAmount,
	ProjectID)
   SELECT
   v_CompanyID,
	v_DivisionID,
	v_DepartmentID,
	v_GLTransNumber,
	GLTransactionAccount,
	SUM(IFNULL(GLDebitAmount,0)),
	SUM(IFNULL(GLCreditAmount,0)) ,
	ProjectID
   FROM
   tt_LedgerDetailTmp
   GROUP BY
   ProjectID,GLTransactionAccount;
   IF @SWV_Error <> 0 then
-- An error occured, go to the error handler
-- and drop the temporary table

      SET v_ErrorMessage = 'Insert into LedgerTransactionDetail failed';
      ROLLBACK;
      DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;
      IF v_ErrorMessage <> '' then

	-- the error handler
	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'ReceiptCash_Return_CreateGLTransaction',
         v_ErrorMessage,v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
      end if;
      SET SWP_Ret_Value = -1;
   end if;


   DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;


/*
update the information in the Ledger Chart of Accounts fro the accounts of the newly inserted transaction

parameters	@CompanyID NVARCHAR(36),
		@DivisionID NVARCHAR(36),
		@DepartmentID NVARCHAR(36),
		@GLTransNumber NVARCHAR (36)
		used to identify the TRANSACTION
		@PostCOA BIT - used in the process of creation of the transaction
*/
   SET @SWV_Error = 0;
   CALL LedgerTransactions_PostCOA_AllRecords2(v_CompanyID,v_DivisionID,v_DepartmentID,v_GLTransNumber, v_ReturnStatus);
   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then
-- An error occured, go to the error handler
-- and drop the temporary table

      SET v_ErrorMessage = 'LedgerTransactions_PostCOA_AllRecords call failed';
      ROLLBACK;
      DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;
      IF v_ErrorMessage <> '' then

	-- the error handler
	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'ReceiptCash_Return_CreateGLTransaction',
         v_ErrorMessage,v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
      end if;
      SET SWP_Ret_Value = -1;
   end if;


-- Everything is  OK
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

   DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;

   IF v_ErrorMessage <> '' then

	-- the error handler
	
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'ReceiptCash_Return_CreateGLTransaction',
      v_ErrorMessage,v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
   end if;
   SET SWP_Ret_Value = -1;
END;



















//

DELIMITER ;

DELIMITER //
DROP PROCEDURE IF EXISTS Ledger_YearEndClose;
//
CREATE        PROCEDURE Ledger_YearEndClose(v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),INOUT SWP_Ret_Value INT)
   SWL_return:
BEGIN


/*
Name of stored procedure: Ledger_YearEndClose
Method:
	This procedure closes the current period and
	copies the proper values in the right fields in
	the Customer and the Chart of Accounts tables.It
	also closes the year and updates the LedgerChartOfAccounts
	table.
Date Created: EDE - 07/28/2015
Input Parameters:
	@CompanyID NVARCHAR(36)		 - the ID of the company
	@DivisionID NVARCHAR(36)	 - the ID of the division
	@DepartmentID NVARCHAR(36)	 - the ID of the department
Output Parameters:
	NONE
Called From:
	Ledger_YearEndClose.vb
Calls:
	LedgerMain_CurrentPeriod, Error_InsertError
Last Modified:
Last Modified By:
Revision History:
*/
   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);
   DECLARE v_GLRetainedEarningsAccount NATIONAL VARCHAR(36);
   DECLARE v_PeriodCurrent INT;
   DECLARE v_PeriodStartDate DATETIME;
   DECLARE v_PeriodEndDate DATETIME;
   DECLARE v_LastPeriodDate DATETIME;
   DECLARE v_CurrentFiscalYear INT;
   DECLARE v_ErrorID INT;
   DECLARE Temp1 DECIMAL(19,4);
   DECLARE Temp2 DECIMAL(19,4);
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
--      GET DIAGNOSTICS CONDITION 1
  --        @p1 = RETURNED_SQLSTATE, @p2 = MESSAGE_TEXT;
    --  SELECT @p1, @p2;
      SET @SWV_Error = 1;
   END;
   select   GLRetainedEarningsAccount INTO v_GLRetainedEarningsAccount FROM
   Companies WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID;
	
   START TRANSACTION;
   CALL LedgerMain_CurrentPeriod2(v_CompanyID,v_DivisionID,v_DepartmentID,v_PeriodCurrent,v_PeriodStartDate,
   v_PeriodEndDate, v_ReturnStatus);
   IF v_ReturnStatus <> 0 then -- fail to receive current Period

      SET v_ErrorMessage = 'Fail to get current Period';
      ROLLBACK;
-- the error handler
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Ledger_PeriodEndClose',v_ErrorMessage,
      v_ErrorID);
      SET SWP_Ret_Value = -1;
   end if;
   CALL LedgerMain_GetLastPeriod2(v_CompanyID,v_DivisionID,v_DepartmentID,v_LastPeriodDate, v_ReturnStatus);
   IF v_ReturnStatus = -1 then -- fail to receive current Period

      SET v_ErrorMessage = 'Fail to get last period';
      ROLLBACK;
-- the error handler
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Ledger_PeriodEndClose',v_ErrorMessage,
      v_ErrorID);
      SET SWP_Ret_Value = -1;
   end if;
   IF v_LastPeriodDate > v_PeriodEndDate OR v_ReturnStatus > v_PeriodCurrent then

      SET v_ErrorMessage = 'Can''t close the year. Not all periods are closed yet';
      ROLLBACK;
-- the error handler
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Ledger_PeriodEndClose',v_ErrorMessage,
      v_ErrorID);
      SET SWP_Ret_Value = -1;
   end if;
-- Copy chart of account information to the previous year chart of account table
   select   CurrentFiscalYear INTO v_CurrentFiscalYear FROM
   Companies WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID;
   SET @SWV_Error = 0;
   INSERT INTO LedgerChartOfAccountsPriorYears(CompanyID,
	DivisionID,
	DepartmentID,
	GLAccountNumber,
	GLFiscalYear,
	GLAccountName,
	GLAccountDescription,
	GLAccountUse,
	GLAccountType,
	GLBalanceType,
	GLReportingAccount,
	GLReportLevel,
	CurrencyID,
	CurrencyExchangeRate,
	GLAccountBalance,
	GLAccountBeginningBalance,
	GLOtherNotes,
	GLBudgetID,
	GLPriorYearBeginningBalance,
	GLPriorYearPeriod1,
	GLPriorYearPeriod2,
	GLPriorYearPeriod3,
	GLPriorYearPeriod4,
	GLPriortYearPeriod5,
	GLPriorYearPeriod6,
	GLPriorYearPeriod7,
	GLPriorYearPeriod8,
	GLPriorYearPeriod9,
	GLPriortYearPeriod10,
	GLPriorYearPeriod11,
	GLPriorYearPeriod12,
	GLPriorYearPeriod13,
	GLPriorYearPeriod14)
   SELECT
   CompanyID,
	DivisionID,
	DepartmentID,
	GLAccountNumber,
	CONCAT(CAST(v_CurrentFiscalYear AS CHAR(4)),N'0101'),
	GLAccountName,
	GLAccountDescription,
	GLAccountUse,
	GLAccountType,
	GLBalanceType,
	GLReportingAccount,
	GLReportLevel,
	CurrencyID,
	CurrencyExchangeRate,
	GLAccountBalance,
	GLAccountBeginningBalance,
	GLOtherNotes,
	GLBudgetID,
	GLPriorYearBeginningBalance,
	GLPriorYearPeriod1,
	GLPriorYearPeriod2,
	GLPriorYearPeriod3,
	GLPriorYearPeriod4,
	GLPriortYearPeriod5,
	GLPriorYearPeriod6,
	GLPriorYearPeriod7,
	GLPriorYearPeriod8,
	GLPriorYearPeriod9,
	GLPriortYearPeriod10,
	GLPriorYearPeriod11,
	GLPriorYearPeriod12,
	GLPriorYearPeriod13,
	GLPriorYearPeriod14
   FROM
   LedgerChartOfAccounts
   WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID;
   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'inserting into the prior year chart of accounts failed';
      ROLLBACK;
-- the error handler
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Ledger_PeriodEndClose',v_ErrorMessage,
      v_ErrorID);
      SET SWP_Ret_Value = -1;
   end if;
-- 1) Sum all of the Expense Accounts, and sum all of the Revenue accounts, minus (Sum(Revenue) - Sum(Expense)) and post this number into the retained earnings account
   SET @SWV_Error = 0;
   SELECT IFNULL(SUM(IFNULL(GLAccountBalance,0)),0) into Temp1
   FROM LedgerChartOfAccounts
   WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND (GLBalanceType = 'Income' OR GLBalanceType = 'Revenue');
   
   SELECT IFNULL(SUM(IFNULL(GLAccountBalance,0)),0) into Temp2
   FROM LedgerChartOfAccounts
   WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND GLBalanceType = 'Expense';

   
   UPDATE
   LedgerChartOfAccounts
   SET
   GLAccountBalance = Temp1 - Temp2
   WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND GLAccountNumber = v_GLRetainedEarningsAccount;
   IF @SWV_Error <> 0 then
	-- An error occured, go to the error handler
	
      SET v_ErrorMessage = 'Updating the chart of accounts failed 1';
      ROLLBACK;
-- the error handler
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Ledger_PeriodEndClose',v_ErrorMessage,
      v_ErrorID);
      SET SWP_Ret_Value = -1;
   end if;	
-- 2) Copy the beginning balances into last years beginning balances
   SET @SWV_Error = 0;
   UPDATE
   LedgerChartOfAccounts
   SET
   GLPriorYearBeginningBalance = GLCurrentYearBeginningBalance
   WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID;
   IF @SWV_Error <> 0 then
	-- An error occured, go to the error handler
	
      SET v_ErrorMessage = 'Updating the chart of accounts failed 2';
      ROLLBACK;
-- the error handler
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Ledger_PeriodEndClose',v_ErrorMessage,
      v_ErrorID);
      SET SWP_Ret_Value = -1;
   end if;	
-- 3) Copy the Current balance into the last years ending balances
   SET @SWV_Error = 0;
   UPDATE
   LedgerChartOfAccounts
   SET
   GLPriorYearPeriod1 =
   CASE
   WHEN v_PeriodCurrent = 0 THEN GLAccountBalance
   ELSE GLPriorYearPeriod1
   END,GLPriorYearPeriod2 =
   CASE
   WHEN v_PeriodCurrent = 1 THEN GLAccountBalance
   ELSE GLPriorYearPeriod2
   END,
   GLPriorYearPeriod3 =
   CASE
   WHEN v_PeriodCurrent = 2 THEN GLAccountBalance
   ELSE GLPriorYearPeriod3
   END,GLPriorYearPeriod4 =
   CASE
   WHEN v_PeriodCurrent = 3 THEN GLAccountBalance
   ELSE GLPriorYearPeriod4
   END,
   GLPriortYearPeriod5 =
   CASE
   WHEN v_PeriodCurrent = 4 THEN GLAccountBalance
   ELSE GLPriortYearPeriod5
   END,GLPriorYearPeriod6 =
   CASE
   WHEN v_PeriodCurrent = 5 THEN GLAccountBalance
   ELSE GLPriorYearPeriod6
   END,
   GLPriorYearPeriod7 =
   CASE
   WHEN v_PeriodCurrent = 6 THEN GLAccountBalance
   ELSE GLPriorYearPeriod7
   END,
   GLPriorYearPeriod8 =
   CASE
   WHEN v_PeriodCurrent = 7 THEN GLAccountBalance
   ELSE GLPriorYearPeriod8
   END,GLPriorYearPeriod9 =
   CASE
   WHEN v_PeriodCurrent = 8 THEN GLAccountBalance
   ELSE GLPriorYearPeriod9
   END,
   GLPriortYearPeriod10 =
   CASE
   WHEN v_PeriodCurrent = 9 THEN GLAccountBalance
   ELSE GLPriortYearPeriod10
   END,GLPriorYearPeriod11 =
   CASE
   WHEN v_PeriodCurrent = 10 THEN GLAccountBalance
   ELSE GLPriorYearPeriod11
   END,
   GLPriorYearPeriod12 =
   CASE
   WHEN v_PeriodCurrent = 11 THEN GLAccountBalance
   ELSE GLPriorYearPeriod12
   END,
   GLPriorYearPeriod13 =
   CASE
   WHEN v_PeriodCurrent = 12 THEN GLAccountBalance
   ELSE GLPriorYearPeriod13
   END,GLPriorYearPeriod14 =
   CASE
   WHEN v_PeriodCurrent = 13 THEN GLAccountBalance
   ELSE GLPriorYearPeriod14
   END
   WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID;
   IF @SWV_Error <> 0 then
	-- An error occured, go to the error handler
	
      SET v_ErrorMessage = 'Updating the chart of accounts failed 3';
      ROLLBACK;
-- the error handler
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Ledger_PeriodEndClose',v_ErrorMessage,
      v_ErrorID);
      SET SWP_Ret_Value = -1;
   end if;	
-- 4) Copy the Current balance into this years beginning balance
   SET @SWV_Error = 0;
   UPDATE
   LedgerChartOfAccounts
   SET
   GLCurrentYearBeginningBalance = GLAccountBalance
   WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID;
   IF @SWV_Error <> 0 then
	-- An error occured, go to the error handler
	
      SET v_ErrorMessage = 'Updating the chart of accounts failed 4';
      ROLLBACK;
-- the error handler
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Ledger_PeriodEndClose',v_ErrorMessage,
      v_ErrorID);
      SET SWP_Ret_Value = -1;
   end if;	
-- 5) Zero this years current balance
   SET @SWV_Error = 0;
   UPDATE
   LedgerChartOfAccounts
   SET
   GLAccountBalance = 0
   WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND (GLBalanceType = 'Income' OR GLBalanceType = 'Revenue' OR GLBalanceType = 'Expense');
   IF @SWV_Error <> 0 then
	-- An error occured, go to the error handler
	
      SET v_ErrorMessage = 'Updating the chart of accounts failed 5';
      ROLLBACK;
-- the error handler
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Ledger_PeriodEndClose',v_ErrorMessage,
      v_ErrorID);
      SET SWP_Ret_Value = -1;
   end if;	
-- 6) Copy each of the period balances into the last years period balances
   SET @SWV_Error = 0;
   UPDATE
   LedgerChartOfAccounts
   SET
   GLPriorYearPeriod1 = GLCurrentYearPeriod1,GLPriorYearPeriod2 = GLCurrentYearPeriod2,
   GLPriorYearPeriod3 = GLCurrentYearPeriod3,GLPriorYearPeriod4 = GLCurrentYearPeriod4,
   GLPriortYearPeriod5 = GLCurrentYearPeriod5,
   GLPriorYearPeriod6 = GLCurrentYearPeriod6,GLPriorYearPeriod7 = GLCurrentYearPeriod7,
   GLPriorYearPeriod8 = GLCurrentYearPeriod8,GLPriorYearPeriod9 = GLCurrentYearPeriod9,
   GLPriortYearPeriod10 = GLCurrentYearPeriod10,
   GLPriorYearPeriod11 = GLCurrentYearPeriod11,GLPriorYearPeriod12 = GLCurrentYearPeriod12,
   GLPriorYearPeriod13 = GLCurrentYearPeriod13,GLPriorYearPeriod14 = GLCurrentYearPeriod14
   WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID;
   IF @SWV_Error <> 0 then
	-- An error occured, go to the error handler
	
      SET v_ErrorMessage = 'Updating the chart of accounts failed 6';
      ROLLBACK;
-- the error handler
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Ledger_PeriodEndClose',v_ErrorMessage,
      v_ErrorID);
      SET SWP_Ret_Value = -1;
   end if;	
-- 7) Go into the Vendor Financials and move the current numbers into the last years numbers
   SET @SWV_Error = 0;
   UPDATE
   VendorFinancials
   SET
   PurchaseLastYear = PurchaseYTD,PaymentsLastYear = PaymentsYTD,ReturnsLastYear = ReturnsYTD,
   DebitMemosLastYear = DebitMemosYTD
   WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID;
   IF @SWV_Error <> 0 then
	-- An error occured, go to the error handler
	
      SET v_ErrorMessage = 'Updating the chart of accounts failed 7';
      ROLLBACK;
-- the error handler
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Ledger_PeriodEndClose',v_ErrorMessage,
      v_ErrorID);
      SET SWP_Ret_Value = -1;
   end if;	
-- 8) Go into the Customer Financials and move the current numbers into the last years numbers
   SET @SWV_Error = 0;
   UPDATE
   CustomerFinancials
   SET
   SalesLastYear = SalesYTD,PaymentsLastYear = PaymentsYTD,WriteOffsLastYear = WriteOffsYTD,
   InvoicesLastYear = InvoicesYTD,CreditMemosLastYear = CreditMemosYTD,
   RMAsLastYear = RMAsYTD
   WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID;
   IF @SWV_Error <> 0 then
	-- An error occured, go to the error handler
	
      SET v_ErrorMessage = 'Updating the chart of accounts failed 8';
      ROLLBACK;
-- the error handler
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Ledger_PeriodEndClose',v_ErrorMessage,
      v_ErrorID);
      SET SWP_Ret_Value = -1;
   end if;	
-- 9) Copy all closed GL transactions to the history table
   SET @SWV_Error = 0;
   CALL LedgerTransactions_CopyAllToHistory2(v_CompanyID,v_DivisionID,v_DepartmentID, v_ReturnStatus);
   IF @SWV_Error <> 0 OR v_ReturnStatus <> 0 then
-- An error occured, go to the error handler

      SET v_ErrorMessage = 'Error during copying GL transactions to history';
      ROLLBACK;
-- the error handler
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Ledger_PeriodEndClose',v_ErrorMessage,
      v_ErrorID);
      SET SWP_Ret_Value = -1;
   end if;	
-- 10)
-- everything is OK
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
   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Ledger_PeriodEndClose',v_ErrorMessage,
   v_ErrorID);
   SET SWP_Ret_Value = -1;
END;



//

DELIMITER ;
