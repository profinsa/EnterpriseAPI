
DELIMITER //
DROP PROCEDURE IF EXISTS Return_Cancel;
//
CREATE     PROCEDURE Return_Cancel(v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_OrderNumber NATIONAL VARCHAR(36),INOUT SWP_Ret_Value INT)
   SWL_return:
BEGIN














/*
Name of stored procedure: Return_Cancel
Method: 
	this procedure cancels a return

Date Created: EDE - 07/28/2015

Input Parameters:

	@CompanyID NVARCHAR(36)		 - the ID of the company
	@DivisionID NVARCHAR(36)	 - the ID of the division
	@DepartmentID NVARCHAR(36)	 - the ID of the department
	@OrderNumber NVARCHAR(36)	 - the return number

Output Parameters:

	NONE

Called From:

	Return_Cancel.vb

Calls:

	VerifyCurrency, WarehouseBinLockGoods, SerialNumber_Cancel, Error_InsertError, Error_InsertErrorDetail

Last Modified: 

Last Modified By: 

Revision History: 

*/

   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);

   DECLARE v_OrderLineNumber NUMERIC(9,0);
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
   DECLARE v_AmountPaid DECIMAL(19,4);

-- get the information from the order header
   DECLARE v_ErrorID INT;
   DECLARE NO_DATA INT DEFAULT 0;
   DECLARE cOrderDetail CURSOR FOR
   SELECT 
   OrderLineNumber, 
		ItemID, 
		IFNULL(OrderQty,0), 
		IFNULL(BackOrderQyyty,0),
		WarehouseID,
		WarehouseBinID,
		SerialNumber
   FROM 
   OrderDetail
   WHERE	
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND OrderNumber = v_OrderNumber
   AND Total > 0;

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
   START TRANSACTION;


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
      SET v_ReturnStatus = WarehouseBinLockGoods(v_CompanyID,v_DivisionID,v_DepartmentID,v_WarehouseID,v_WarehouseBinID,
      v_ItemID,v_OrderQty,v_BackOrderQyyty,2);
      IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then
	
		
         SET v_ErrorMessage = 'WarehouseBinLockGoods_Return failed';
         ROLLBACK;
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Return_Cancel',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'OrderNumber',v_OrderNumber);

-- an error occured, return -1
         SET SWP_Ret_Value = -1;
      end if;
      SET @SWV_Error = 0;
      SET v_ReturnStatus = SerialNumber_Cancel(v_CompanyID,v_DivisionID,v_DepartmentID,v_WarehouseID,v_WarehouseBinID,
      v_SerialNumber,v_ItemID,v_OrderQty);
      IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then
	
		
         SET v_ErrorMessage = 'Return_SerialNumber_Cancel failed';
         ROLLBACK;
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Return_Cancel',v_ErrorMessage,
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
   Posted = 0
   WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   OrderNumber = v_OrderNumber;

   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Order header updating failed';
      ROLLBACK;
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Return_Cancel',v_ErrorMessage,
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

   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Return_Cancel',v_ErrorMessage,
   v_ErrorID);

   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'OrderNumber',v_OrderNumber);

-- an error occured, return -1
   SET SWP_Ret_Value = -1;
END;


























//

DELIMITER ;

-- Stored procedure definition script Invoice_AllReturns for MySQL
-- Generated by (c) Ispirer SQLWays 4.0 Build 219 Licensed to STFB
-- Timestamp: Tue Jul 28 16:20:00 2015

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
      SET v_ReturnStatus = ReturnInvoice_CreateFromReturn(v_CompanyID,v_DivisionID,v_DepartmentID,v_OrderNumber,v_InvoiceNumber);
      IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then
	
		
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
