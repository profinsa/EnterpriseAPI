-- Stored procedure definition script Contract_CreateFromOrder for MySQL
-- Generated by (c) Ispirer SQLWays 4.0 Build 219 Licensed to STFB
-- Timestamp: Tue Jul 28 16:20:00 2015

DELIMITER //
DROP PROCEDURE IF EXISTS Contract_CreateFromOrder;
//
CREATE   PROCEDURE Contract_CreateFromOrder(v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_OrderNumber NATIONAL VARCHAR(36),INOUT SWP_Ret_Value INT)
   SWL_return:
BEGIN













/*
Name of stored procedure: Contract_CreateFromOrder
Method: 
	Will ALTER contracts from the orders in the system

Date Created: EDE - 07/28/2015

Input Parameters:

	@CompanyID NVARCHAR(36)		 - the ID of the company
	@DivisionID NVARCHAR(36)	 - the ID of the division
	@DepartmentID NVARCHAR(36)	 - the ID of the department
	@OrderNumber NVARCHAR(36)	 - the order to be transformed into a contract

Output Parameters:

	NONE

Called From:

	Contract_CreateFromOrder.vb

Calls:

	Error_InsertError, Error_InsertErrorDetail

Last Modified: 

Last Modified By: 

Revision History: 

*/

   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(36);



   DECLARE v_NewOrderNumber NATIONAL VARCHAR(36);
   DECLARE v_ErrorID INT;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
   END;
   SET @SWV_Error = 0;
   START TRANSACTION;
-- get the transaction number
   SET @SWV_Error = 0;
   SET v_ReturnStatus = GetNextEntityID(v_CompanyID,v_DivisionID,v_DepartmentID,'NextOrderNumber',v_NewOrderNumber);

   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then
-- An error occured , drop the temporary table and 
-- go to the error handler

      SET v_ErrorMessage = 'GetNextEntityID call failed';
      ROLLBACK;

-- the error handler
      CALL Error_InsertError(v_CompanyID,v_DivisionID,DepartmentID,'Contract_CreateFromOrder',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'OrderNumber',v_OrderNumber);
      SET SWP_Ret_Value = -1;
   end if;

-- insert the information about the new order into the ContractsHeader table
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
   v_CompanyID, v_DivisionID, v_DepartmentID, v_NewOrderNumber,
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

-- An error occured, goto the error handler
   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'OrderHeader insert failed';
      ROLLBACK;

-- the error handler
      CALL Error_InsertError(v_CompanyID,v_DivisionID,DepartmentID,'Contract_CreateFromOrder',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'OrderNumber',v_OrderNumber);
      SET SWP_Ret_Value = -1;
   end if;	


	-- insert order details for the new order based on contract details
   SET @SWV_Error = 0;
   INSERT INTO ContractsDetail(CompanyID, DivisionID, DepartmentID, OrderNumber,
		ItemID, WarehouseID, SerialNumber, Description, OrderQty,
		BackOrdered, BackOrderQty, ItemUOM, ItemWeight, DiscountPerc,
		Taxable, ItemCost, ItemUnitPrice,
		Total, TotalWeight, GLSalesAccount, ProjectID, TrackingNumber,
		TaxGroupID,
		TaxAmount,
		TaxPercent,
		SubTotal)
   SELECT
   v_CompanyID, v_DivisionID, v_DepartmentID, v_NewOrderNumber,
		ItemID, WarehouseID, SerialNumber, Description, OrderQty,
		BackOrdered, BackOrderQyyty, ItemUOM, ItemWeight, DiscountPerc,
		Taxable, ItemCost, ItemUnitPrice,
		Total, TotalWeight, GLSalesAccount, ProjectID, TrackingNumber,
		TaxGroupID,
		TaxAmount,
		TaxPercent,
		SubTotal
   FROM
   OrderDetail
   WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   OrderNumber = v_OrderNumber; 
	-- An error occured, go to the error handler
   IF @SWV_Error <> 0 then
	
--      CLOSE cOrderDetail;
		
      SET v_ErrorMessage = 'OrderDetail insert failed';
      ROLLBACK;

-- the error handler
      CALL Error_InsertError(v_CompanyID,v_DivisionID,DepartmentID,'Contract_CreateFromOrder',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'OrderNumber',v_OrderNumber);
      SET SWP_Ret_Value = -1;
   end if;	

-- Everythinng is ok
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
   CALL Error_InsertError(v_CompanyID,v_DivisionID,DepartmentID,'Contract_CreateFromOrder',v_ErrorMessage,
   v_ErrorID);

   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'OrderNumber',v_OrderNumber);

   SET SWP_Ret_Value = -1;
END;








//

DELIMITER ;
