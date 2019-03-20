update databaseinfo set value='20_03_2019',lastupdate=now() where id='Version';

DELIMITER //
DROP PROCEDURE IF EXISTS ServiceInvoice_CreateFromOrder2;
//
CREATE          PROCEDURE ServiceInvoice_CreateFromOrder2(v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_OrderNumber  NATIONAL VARCHAR(36),
	INOUT v_InvoiceNumber NATIONAL VARCHAR(36)  ,INOUT SWP_Ret_Value INT)
   SWL_return:
BEGIN















/*
Name of stored procedure: ServiceInvoice_CreateFromOrder
Method: 
	for a specified service order verify if allready exists an Service Invoice; if so, @InvoiceNumber parameter will store the number of this invoice
	if an service invoice does not exists then creates one using the service order as pattern and  @InvoiceNumber parameter will store the number of the new service invoice;

Date Created: EDE - 07/28/2015

Input Parameters:

	@CompanyID NVARCHAR(36)		 - the ID of the company
	@DivisionID NVARCHAR(36)	 - the ID of the division
	@DepartmentID NVARCHAR(36)	 - the ID of the department
	@OrderNumber NVARCHAR (36)	 - the service order number

Output Parameters:

	@InvoiceNumber NVARCHAR (36)	 - if an service invoice does not exists then creates one using the service order as pattern and  @InvoiceNumber parameter will store the number of the new service invoice;

Called From:

	ServiceOrder_MakeInvoiceReceipt

Calls:

	GetNextEntityID, ServiceInvoice_Post, Error_InsertError, Error_InsertErrorDetail

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
   DECLARE v_CustomerID NATIONAL VARCHAR(36);
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
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'ServiceInvoice_CreateFromOrder',
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
	HeaderMemo9,
    AllowanceDiscountPerc)
   SELECT
   v_CompanyID,
		v_DivisionID,
		v_DepartmentID,
		v_InvoiceNumber,
		OrderNumber,
		'Service Invoice',
		OrderDate,
		OrderDueDate,
		OrderShipDate,
		OrderCancelDate,
		SystemDate ,
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
		NULL,
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
		HeaderMemo9,
        AllowanceDiscountPerc
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
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'ServiceInvoice_CreateFromOrder',
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
   AND Total > 0;

   IF @SWV_Error <> 0 then
-- An error occured, go to the error handler

      SET v_InvoiceNumber = N'';
      SET v_ErrorMessage = 'Insert into InvoiceDetail failed';
      ROLLBACK;
-- the error handler
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'ServiceInvoice_CreateFromOrder',
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
   CALL ServiceInvoice_Post2(v_CompanyID,v_DivisionID,v_DepartmentID,v_InvoiceNumber,v_PostingResult, v_ReturnStatus);
   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then

      SET v_ErrorMessage = 'Posting invoice failed';
      ROLLBACK;
-- the error handler
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'ServiceInvoice_CreateFromOrder',
      v_ErrorMessage,v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'OrderNumber',v_OrderNumber);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
      SET SWP_Ret_Value = -1;
   end if;


-- Update the invoiced flag and 
-- InvoiceNumber, InvoiceDate for the order taken from the invoice inserted above
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



   select   fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,IFNULL(Total,0)*IFNULL(CurrencyExchangeRate,1), 
   v_CompanyCurrencyID), CustomerID INTO v_OrderAmount,v_CustomerID FROM
   OrderHeader WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND OrderNumber = v_OrderNumber;

   SET @SWV_Error = 0;
   UPDATE
   CustomerFinancials
   SET
   BookedOrders = IFNULL(BookedOrders,0) -v_OrderAmount
   WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND CustomerID = v_CustomerID;

   SET @SWV_Error = 0;
   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Updating CustomerFinancials failed';
      ROLLBACK;
-- the error handler
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'ServiceInvoice_CreateFromOrder',
      v_ErrorMessage,v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'OrderNumber',v_OrderNumber);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
      SET SWP_Ret_Value = -1;
   end if;


   IF @SWV_Error <> 0 then
-- An error occured, go to the error handler

      SET v_InvoiceNumber = N'';
      SET v_ErrorMessage = 'Update OrderHeader failed';
      ROLLBACK;
-- the error handler
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'ServiceInvoice_CreateFromOrder',
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
   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'ServiceInvoice_CreateFromOrder',
   v_ErrorMessage,v_ErrorID);

   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'OrderNumber',v_OrderNumber);
   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);

   SET SWP_Ret_Value = -1;
END;













//

DELIMITER ;

DELIMITER //
DROP PROCEDURE IF EXISTS ServiceOrder_Post;
//
CREATE                 PROCEDURE ServiceOrder_Post(v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_OrderNumber NATIONAL VARCHAR(36),
	INOUT v_PostingResult NATIONAL VARCHAR(200) ,INOUT SWP_Ret_Value INT)
   SWL_return:
BEGIN





/*
Name of stored procedure: ServiceOrder_Post
Method:
	this procedure makes all the arrangement for an service order to be posted
Date Created: EDE - 07/28/2015
Input Parameters:
	@CompanyID NVARCHAR(36)		 - the ID of the company
	@DivisionID NVARCHAR(36)	 - the ID of the division
	@DepartmentID NVARCHAR(36)	 - the ID of the department
	@OrderNumber NVARCHAR(36)	 - the service order number
Output Parameters:
	@PostingResult NVARCHAR(200)	 - the error message that should be displayed for end user
Called From:
	ServiceOrder_Post.vb
Calls:
	ServiceOrder_Recalc, Terms_GetNetDays, Order_CreditCustomerAccount, ServiceOrder_MakeInvoiceReceipt, Error_InsertError, Error_InsertErrorDetail
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
   DECLARE v_OrderQty FLOAT;
   DECLARE v_DifferenceQty INT;
   DECLARE v_AmountPaid DECIMAL(19,4);
   DECLARE v_PaymentMethodID NATIONAL VARCHAR(36);
   DECLARE v_Posted BOOLEAN;
   DECLARE v_OrderCancelDate DATETIME;
   DECLARE v_HighestCredit DECIMAL(19,4);
   DECLARE v_AvailibleCredit DECIMAL(19,4);
   DECLARE v_OrderAmount DECIMAL(19,4);
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
   DECLARE v_CompanyCurrencyID NATIONAL VARCHAR(3);
   DECLARE v_NetDays INT;
   DECLARE v_ErrorID INT;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
	SET @SWV_Error = 1;
   END;
   SET @SWV_Error = 0;
   IF NOT EXISTS(SELECT * FROM
   OrderDetail
   WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   OrderNumber = v_OrderNumber) then

      SET v_PostingResult = 'Service Order was not posted: order has no detail items';
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

      SET v_PostingResult = 'Service Order was not posted: there is order detail item with undefined Order Qty value';
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
-- If the order is canceled I can't post it
   IF v_OrderCancelDate < CURRENT_TIMESTAMP then

      SET v_PostingResult = 'The Service Order was not posted: Cancel date is older then current date.';
      SET SWP_Ret_Value = -1;
      LEAVE SWL_return;
   end if;
   START TRANSACTION;
-- Check order on Hold status
-- recalculate the order to be sure that it has correct total
-- EXEC @ReturnStatus = ServiceOrder_RecalcCLR @CompanyID, @DivisionID, @DepartmentID, @OrderNumber
   SET @SWV_Error = 0;
   CALL ServiceOrder_Recalc2(v_CompanyID,v_DivisionID,v_DepartmentID,v_OrderNumber, v_ReturnStatus);
   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then

      SET v_ErrorMessage = 'Recalculating the order failed';
      ROLLBACK;
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'ServiceOrder_Post',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'OrderNumber',v_OrderNumber);
      SET v_PostingResult = CONCAT('Service Order was not posted:',v_ErrorMessage);
      SET SWP_Ret_Value = -1;
   end if;
   select   IFNULL(CurrencyID,N'') INTO v_CompanyCurrencyID FROM Companies WHERE CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID   LIMIT 1;
   select   fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,IFNULL(Total,0)*IFNULL(CurrencyExchangeRate,1), 
   v_CompanyCurrencyID) INTO v_OrderAmount FROM
   OrderHeader WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND OrderNumber = v_OrderNumber;
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
	
--         CLOSE cOrderDetail;
		
         SET v_ErrorMessage = 'OrderRecalcCustomerCredit failed';
         ROLLBACK;
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'ServiceOrder_Post',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'OrderNumber',v_OrderNumber);
         SET v_PostingResult = CONCAT('Service Order was not posted:',v_ErrorMessage);
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
            CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'ServiceOrder_Post',v_ErrorMessage,
            v_ErrorID);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'OrderNumber',v_OrderNumber);
            SET v_PostingResult = CONCAT('Service Order was not posted:',v_ErrorMessage);
            SET SWP_Ret_Value = -1;
         end if;
         COMMIT;
         SET v_PostingResult = 'Service Order is moved to On Hold Orders';
         SET SWP_Ret_Value = 0;
         LEAVE SWL_return;
      end if;
   end if;
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
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'ServiceOrder_Post',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'OrderNumber',v_OrderNumber);
      SET v_PostingResult = CONCAT('Service Order was not posted:',v_ErrorMessage);
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
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'ServiceOrder_Post',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'OrderNumber',v_OrderNumber);
      SET v_PostingResult = CONCAT('Service Order was not posted:',v_ErrorMessage);
      SET SWP_Ret_Value = -1;
   end if;
-- Properly credit the customer account ->
   SET @SWV_Error = 0;
   CALL Order_CreditCustomerAccount(v_CompanyID,v_DivisionID,v_DepartmentID,v_OrderNumber, v_ReturnStatus);
   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then

      SET v_ErrorMessage = 'Crediting the customer account failed';
      ROLLBACK;
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'ServiceOrder_Post',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'OrderNumber',v_OrderNumber);
      SET v_PostingResult = CONCAT('Service Order was not posted:',v_ErrorMessage);
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
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'ServiceOrder_Post',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'OrderNumber',v_OrderNumber);
         SET v_PostingResult = CONCAT('Service Order was not posted:',v_ErrorMessage);
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
            CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'ServiceOrder_Post',v_ErrorMessage,
            v_ErrorID);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'OrderNumber',v_OrderNumber);
            SET v_PostingResult = CONCAT('Service Order was not posted:',v_ErrorMessage);
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
            CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'ServiceOrder_Post',v_ErrorMessage,
            v_ErrorID);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'OrderNumber',v_OrderNumber);
            SET v_PostingResult = CONCAT('Service Order was not posted:',v_ErrorMessage);
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
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'ServiceOrder_Post',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'OrderNumber',v_OrderNumber);
      SET v_PostingResult = CONCAT('Service Order was not posted:',v_ErrorMessage);
      SET SWP_Ret_Value = -1;
   end if;
   SET @SWV_Error = 0;
   UPDATE
   CustomerFinancials
   SET
   BookedOrders = IFNULL(BookedOrders,0)+v_OrderAmount
   WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND CustomerID = v_CustomerID;
   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Updating CustomerFinancials failed';
      ROLLBACK;
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'ServiceOrder_Post',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'OrderNumber',v_OrderNumber);
      SET v_PostingResult = CONCAT('Service Order was not posted:',v_ErrorMessage);
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
      CALL ServiceOrder_MakeInvoiceReceipt(v_CompanyID,v_DivisionID,v_DepartmentID,v_OrderNumber, v_ReturnStatus);
   end if;
   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then

      SET v_ErrorMessage = 'Making the invoice receipt failed';
      ROLLBACK;
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'ServiceOrder_Post',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'OrderNumber',v_OrderNumber);
      SET v_PostingResult = CONCAT('Service Order was not posted:',v_ErrorMessage);
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
   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'ServiceOrder_Post',v_ErrorMessage,
   v_ErrorID);
   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'OrderNumber',v_OrderNumber);
   SET v_PostingResult = CONCAT('Service Order was not posted:',v_ErrorMessage);
   SET SWP_Ret_Value = -1;
END;






//

DELIMITER ;

DELIMITER //
DROP PROCEDURE IF EXISTS ServiceInvoice_Post2;
//
CREATE              PROCEDURE ServiceInvoice_Post2(v_CompanyID NATIONAL VARCHAR(36), 
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_InvoiceNumber NATIONAL VARCHAR(36) ,
	INOUT v_PostingResult NATIONAL VARCHAR(200) ,INOUT SWP_Ret_Value INT)
   SWL_return:
BEGIN



/*
Name of stored procedure: ServiceInvoice_Post
Method: 
	takes all the necessary actions to post an service invoice

Date Created: EDE - 07/28/2015

Input Parameters:

	@CompanyID NVARCHAR(36)		 - the ID of the company
	@DivisionID NVARCHAR(36)	 - the ID of the division
	@DepartmentID NVARCHAR(36)	 - the ID of the department

Output Parameters:

	@InvoiceNumber NVARCHAR(36)	 - the service invoice number
	@PostingResult NVARCHAR(200)	 - returns error message that should be displayed for user

Called From:

	Invoice_Control, ServiceInvoice_CreateFromOrder, Invoice_CreateFromServiceOrder

Calls:

	Error_InsertError, ServiceReceipt_CreateFromInvoice, ServiceReceipt_Post, LedgerMain_VerifyPeriod, ServiceInvoice_CreateGLTransaction, CreditMemo_CreateFromInvoice, CreditMemo_Post, ServiceInvoice_Recalc, VerifyCurrency, Error_InsertErrorDetail, Invoice_CustomerFinancialsUpdateAging, Invoice_AdjustCustomerFinancials

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
   DECLARE v_CustomerID NATIONAL VARCHAR(36);
   DECLARE v_DefaultInventoryCostingMethod CHAR(1);
   DECLARE v_InventoryCost DECIMAL(19,4);

   DECLARE v_ItemID NATIONAL VARCHAR(36);
   DECLARE v_OrderQty NATIONAL VARCHAR(36);
   DECLARE v_ItemUnitPrice DECIMAL(19,4);
   DECLARE v_ItemCost DECIMAL(19,4);
   DECLARE v_ItemCurrencyID NATIONAL VARCHAR(3); 
   DECLARE v_CompanyCurrencyID NATIONAL VARCHAR(3);
   DECLARE v_ItemCurrencyExchangeRate FLOAT;
   DECLARE v_InvoiceDate DATETIME;
   DECLARE v_ID CHAR(180);
   DECLARE v_Posted BOOLEAN;
   DECLARE v_ProjectID NATIONAL VARCHAR(36);
   DECLARE v_PaymentMethodID NATIONAL VARCHAR(36);
   DECLARE v_ReceiptID NATIONAL VARCHAR(36);
   DECLARE v_Cleared BOOLEAN;
   DECLARE v_Success BOOLEAN;
   DECLARE v_ErrorID INT;
   DECLARE v_CreditMemoNumber NATIONAL VARCHAR(36);
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
   END;
   SET @SWV_Error = 0;
   IF NOT EXISTS(SELECT * FROM
   InvoiceDetail
   WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   InvoiceNumber = v_InvoiceNumber) then

      SET v_PostingResult = 'Service Invoice was not posted: there are no detail items';
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

      SET v_PostingResult = 'Service Invoice was not posted: there is the detail item with undefined Order Qty value';
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



-- get informations from invoice
   select   IFNULL(TransactionTypeID,N''), IFNULL(AmountPaid,0), IFNULL(Total,0), CurrencyID, CurrencyExchangeRate, InvoiceDate, IFNULL(GLSalesAccount,N''), IFNULL(GLSalesAccount,N''), CustomerID, IFNULL(PaymentMethodID,N''), CASE CreditCardApprovalNumber
   WHEN NULL THEN 0
   ELSE 1
   END INTO v_InvoiceType,v_Amount,v_TotalAmount,v_CurrencyID,v_CurrencyExchangeRate,
   v_InvoiceDate,v_CustomerSalesAcct,v_BankKey,v_CustomerID,v_PaymentMethodID,
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


   START TRANSACTION;

   SET @SWV_Error = 0;
   CALL VerifyCurrency2(v_CompanyID,v_DivisionID,v_DepartmentID,v_InvoiceDate,1,v_CompanyCurrencyID,
   v_CurrencyID,v_CurrencyExchangeRate);
   IF @SWV_Error <> 0 then

	-- the procedure will return an error code
      SET v_ErrorMessage = 'Currency retrieving failed';
      ROLLBACK;
-- the error handler
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Invoice_Post',v_ErrorMessage,
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
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Invoice_Post',v_ErrorMessage,
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
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Invoice_Post',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
      SET SWP_Ret_Value = -1;
   end if;

-- Adjust Customer Finacials information
   SET @SWV_Error = 0;
   CALL Invoice_AdjustCustomerFinancials(v_CompanyID,v_DivisionID,v_DepartmentID,v_InvoiceNumber, v_ReturnStatus);
   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then
-- An error occured, go to the error handler

      SET v_ErrorMessage = 'Invoice_AdjustCustomerFinancials call failed';
      ROLLBACK;
-- the error handler
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Invoice_Post',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
      SET SWP_Ret_Value = -1;
   end if;

-- Calculate the Aging
   SET @SWV_Error = 0;
   CALL Invoice_CustomerFinancialsUpdateAging(v_CompanyID,v_DivisionID,v_DepartmentID,v_InvoiceNumber, v_ReturnStatus);
   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then
-- An error occured, go to the error handler

      SET v_ErrorMessage = 'Invoice_CustomerFinancialsUpdateAging call failed';
      ROLLBACK;
-- the error handler
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Invoice_Post',v_ErrorMessage,
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

   IF ABS(v_Rest) > 0.005 then

      IF v_Rest < 0 then
	
		
	
		-- Create credit memo for extra money
         SET v_Rest = -v_Rest; -- we should post extra money as positive value
         SET @SWV_Error = 0;
         SET v_ReturnStatus = CreditMemo_CreateFromInvoice2(v_CompanyID,v_DivisionID,v_DepartmentID,v_InvoiceNumber,v_Rest,v_CreditMemoNumber);
         IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then
		-- An error occured, go to the error handler
		
            SET v_ErrorMessage = 'CreditMemo_CreateFromInvoice call failed';
            ROLLBACK;
-- the error handler
            CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Invoice_Post',v_ErrorMessage,
            v_ErrorID);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
            SET SWP_Ret_Value = -1;
         end if;
         SET @SWV_Error = 0;
         SET v_ReturnStatus = CreditMemo_Post2(v_CompanyID,v_DivisionID,v_DepartmentID,v_CreditMemoNumber,v_PostingResult);
         IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then
		-- An error occured, go to the error handler
		
            SET v_ErrorMessage = 'CreditMemo_Post call failed';
            ROLLBACK;
-- the error handler
            CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Invoice_Post',v_ErrorMessage,
            v_ErrorID);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
            SET SWP_Ret_Value = -1;
         end if;
      end if;
   end if;


	
-- Recalculate the invoice before posting
-- EXEC @ReturnStatus = ServiceInvoice_RecalcCLR @CompanyID,@DivisionID,@DepartmentID, @InvoiceNumber
   SET @SWV_Error = 0;
   CALL ServiceInvoice_Recalc2(v_CompanyID,v_DivisionID,v_DepartmentID,v_InvoiceNumber, v_ReturnStatus);
   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then
-- An error occured, go to the error handler

      SET v_ErrorMessage = 'Invoice_Recalc call failed';
      ROLLBACK;
-- the error handler
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Invoice_Post',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
      SET SWP_Ret_Value = -1;
   end if;


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
   CALL ServiceInvoice_CreateGLTransaction(v_CompanyID,v_DivisionID,v_DepartmentID,v_InvoiceNumber,v_PostDate, v_ReturnStatus);
   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then
-- An error occured, go to the error handler

      SET v_ErrorMessage = 'Invoice_CreateGLTransaction call failed';
      ROLLBACK;
-- the error handler
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Invoice_Post',v_ErrorMessage,
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
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Invoice_Post',v_ErrorMessage,
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
   CALL ServiceReceipt_CreateFromInvoice2(v_CompanyID,v_DivisionID,v_DepartmentID,v_InvoiceNumber,v_ReceiptID, v_ReturnStatus);
   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then

      SET v_ErrorMessage = 'Creating receipt from invoice failed';
      ROLLBACK;
-- the error handler
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Invoice_Post',v_ErrorMessage,
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
      SET v_ReturnStatus = ServiceReceipt_Post(v_CompanyID,v_DivisionID,v_DepartmentID,v_ReceiptID,v_Success,v_PostingResult);
      IF @SWV_Error <> 0 OR v_ReturnStatus = -1 OR  v_Success = 0 then
	
         SET v_ErrorMessage = 'Posting the receipt failed';
         ROLLBACK;
-- the error handler
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Invoice_Post',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
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
   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Invoice_Post',v_ErrorMessage,
   v_ErrorID);

   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);

   SET SWP_Ret_Value = -1;
END;






//

DELIMITER ;

DELIMITER //
DROP PROCEDURE IF EXISTS Invoice_CustomerFinancialsUpdateAging;
//
CREATE   PROCEDURE Invoice_CustomerFinancialsUpdateAging(v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_InvoiceNumber  NATIONAL VARCHAR(36),INOUT SWP_Ret_Value INT)
   SWL_return:
BEGIN
















/*
Name of stored procedure: Invoice_CustomerFinancialsUpdateAging
Method: 
	updates the information about the customer

Date Created: EDE - 07/28/2015

Input Parameters:

	@CompanyID NVARCHAR(36)		 - the ID of the company
	@DivisionID NVARCHAR(36)	 - the ID of the division
	@DepartmentID NVARCHAR(36)	 - the ID of the department
	@InvoiceNumber NVARCHAR (36)	 - used to identify the invoice

Output Parameters:

	NONE

Called From:

	ServiceInvoice_Post, Invoice_Post

Calls:

	VerifyCurrency, Error_InsertError, Error_InsertErrorDetail

Last Modified: 

Last Modified By: 

Revision History: 

*/

   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);

   DECLARE v_DateToAgeBy DATETIME;
   DECLARE v_AgeInvoicesBy NATIONAL VARCHAR(1);
   DECLARE v_Amount DECIMAL(19,4);
   DECLARE v_ConvertedAmount DECIMAL(19,4);
   DECLARE v_CurrencyID NATIONAL VARCHAR(3);
   DECLARE v_CompanyCurrencyID NATIONAL VARCHAR(3);
   DECLARE v_CurrencyExchangeRate FLOAT;
   DECLARE v_InvoiceDate DATETIME;
   DECLARE v_position INT;
   DECLARE v_CustomerID NATIONAL VARCHAR(36);
   DECLARE v_Balance DECIMAL(19,4);
-- calculate the @DateToAgeBy
   DECLARE v_ErrorID INT;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
   END;
   select   AgeInvoicesBy INTO v_AgeInvoicesBy FROM
   Companies WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID;


   IF v_AgeInvoicesBy = N'1' then
-- get the invoicedate

      select   InvoiceDate INTO v_DateToAgeBy FROM
      InvoiceHeader WHERE
      CompanyID = v_CompanyID
      AND DivisionID = v_DivisionID
      AND DepartmentID = v_DepartmentID
      AND InvoiceNumber = v_InvoiceNumber;
   end if;

   IF v_AgeInvoicesBy = N'2' then
-- get the ship date

      select   ShipDate INTO v_DateToAgeBy FROM
      InvoiceHeader WHERE
      CompanyID = v_CompanyID
      AND DivisionID = v_DivisionID
      AND DepartmentID = v_DepartmentID
      AND InvoiceNumber = v_InvoiceNumber;
   end if;


   select   AmountPaid, CurrencyID, CurrencyExchangeRate, InvoiceDate, CustomerID INTO v_Amount,v_CurrencyID,v_CurrencyExchangeRate,v_InvoiceDate,v_CustomerID FROM
   InvoiceHeader WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND InvoiceNumber = v_InvoiceNumber;


-- get the difference between today and datetoageby
   SET v_position = TIMESTAMPDIFF(DAY,v_DateToAgeBy,CURRENT_TIMESTAMP);

   START TRANSACTION;

   SET @SWV_Error = 0;
   CALL VerifyCurrency2(v_CompanyID,v_DivisionID,v_DepartmentID,v_InvoiceDate,1,v_CompanyCurrencyID,
   v_CurrencyID,v_CurrencyExchangeRate);
   IF @SWV_Error <> 0 then

	-- the procedure will return an error code
      SET v_ErrorMessage = 'Currency retrieving failed';
      ROLLBACK;
-- the error handler
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Invoice_CustomerFinancialsUpdateAging',
      v_ErrorMessage,v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
      SET SWP_Ret_Value = -1;
   end if;

-- calculate the converted amount
   SET v_ConvertedAmount = fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,v_Amount*v_CurrencyExchangeRate, 
   v_CompanyCurrencyID);

-- and the update the apropriate customer financials
   IF v_position < 30 then

      SET @SWV_Error = 0;
      UPDATE
      CustomerFinancials
      SET
      Under30 = Under30+v_ConvertedAmount
      WHERE
      CompanyID = v_CompanyID
      AND DivisionID = v_DivisionID
      AND DepartmentID = v_DepartmentID
      AND CustomerID = v_CustomerID;
      IF @SWV_Error <> 0 then
	-- An error occured, go to the error handler
	
         SET v_ErrorMessage = 'Update CustomerFinancials failed';
         ROLLBACK;
-- the error handler
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Invoice_CustomerFinancialsUpdateAging',
         v_ErrorMessage,v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
         SET SWP_Ret_Value = -1;
      end if;
   end if;

   IF v_position >= 30 AND v_position < 60 then

      SET @SWV_Error = 0;
      UPDATE
      CustomerFinancials
      SET
      Over30 = Over30+v_ConvertedAmount
      WHERE
      CompanyID = v_CompanyID
      AND DivisionID = v_DivisionID
      AND DepartmentID = v_DepartmentID
      AND CustomerID = v_CustomerID;
      IF @SWV_Error <> 0 then
	-- An error occured, go to the error handler
	
         SET v_ErrorMessage = 'Update CustomerFinancials failed';
         ROLLBACK;
-- the error handler
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Invoice_CustomerFinancialsUpdateAging',
         v_ErrorMessage,v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
         SET SWP_Ret_Value = -1;
      end if;
   end if;

   IF v_position >= 60 AND v_position < 90 then

      SET @SWV_Error = 0;
      UPDATE
      CustomerFinancials
      SET
      Over60 = Over60+v_ConvertedAmount
      WHERE
      CompanyID = v_CompanyID
      AND DivisionID = v_DivisionID
      AND DepartmentID = v_DepartmentID
      AND CustomerID = v_CustomerID;
      IF @SWV_Error <> 0 then
	-- An error occured, go to the error handler
	
         SET v_ErrorMessage = 'Update CustomerFinancials failed';
         ROLLBACK;
-- the error handler
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Invoice_CustomerFinancialsUpdateAging',
         v_ErrorMessage,v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
         SET SWP_Ret_Value = -1;
      end if;
   end if;

   IF v_position >= 90 AND v_position < 120 then

      SET @SWV_Error = 0;
      UPDATE
      CustomerFinancials
      SET
      Over90 = Over90+v_ConvertedAmount
      WHERE
      CompanyID = v_CompanyID
      AND DivisionID = v_DivisionID
      AND DepartmentID = v_DepartmentID
      AND CustomerID = v_CustomerID;
      IF @SWV_Error <> 0 then
	-- An error occured, go to the error handler
	
         SET v_ErrorMessage = 'Update CustomerFinancials failed';
         ROLLBACK;
-- the error handler
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Invoice_CustomerFinancialsUpdateAging',
         v_ErrorMessage,v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
         SET SWP_Ret_Value = -1;
      end if;
   end if;

   IF v_position >= 120 AND v_position < 150 then
      SET @SWV_Error = 0;
      UPDATE
      CustomerFinancials
      SET
      Over120 = Over120+v_ConvertedAmount
      WHERE
      CompanyID = v_CompanyID
      AND DivisionID = v_DivisionID
      AND DepartmentID = v_DepartmentID
      AND CustomerID = v_CustomerID;
      IF @SWV_Error <> 0 then
	-- An error occured, go to the error handler
	
         SET v_ErrorMessage = 'Update CustomerFinancials failed';
         ROLLBACK;
-- the error handler
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Invoice_CustomerFinancialsUpdateAging',
         v_ErrorMessage,v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
         SET SWP_Ret_Value = -1;
      end if;
   end if;

   IF v_position >= 150 AND v_position < 180 then

      SET @SWV_Error = 0;
      UPDATE
      CustomerFinancials
      SET
      Over150 = Over150+v_ConvertedAmount
      WHERE
      CompanyID = v_CompanyID
      AND DivisionID = v_DivisionID
      AND DepartmentID = v_DepartmentID
      AND CustomerID = v_CustomerID;
      IF @SWV_Error <> 0 then
	-- An error occured, go to the error handler
	
         SET v_ErrorMessage = 'Update CustomerFinancials failed';
         ROLLBACK;
-- the error handler
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Invoice_CustomerFinancialsUpdateAging',
         v_ErrorMessage,v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
         SET SWP_Ret_Value = -1;
      end if;
   end if;

   IF v_position >= 180 then

      SET @SWV_Error = 0;
      UPDATE
      CustomerFinancials
      SET
      Over180 = Over180+v_ConvertedAmount
      WHERE
      CompanyID = v_CompanyID
      AND DivisionID = v_DivisionID
      AND DepartmentID = v_DepartmentID
      AND CustomerID = v_CustomerID;
      IF @SWV_Error <> 0 then
	-- An error occured, go to the error handler
	
         SET v_ErrorMessage = 'Update CustomerFinancials failed';
         ROLLBACK;
-- the error handler
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Invoice_CustomerFinancialsUpdateAging',
         v_ErrorMessage,v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
         SET SWP_Ret_Value = -1;
      end if;
   end if;

-- SET CurrentARBalance = Under30
   SET @SWV_Error = 0;
   UPDATE
   CustomerFinancials
   SET
   CurrentARBalance = Under30
   WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND CustomerID = v_CustomerID;
   IF @SWV_Error <> 0 then
-- An error occured, go to the error handler

      SET v_ErrorMessage = 'Update CustomerFinancials failed';
      ROLLBACK;
-- the error handler
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Invoice_CustomerFinancialsUpdateAging',
      v_ErrorMessage,v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
      SET SWP_Ret_Value = -1;
   end if;

-- If after the processes is complete the CurrentARBalance above is less than the HighestBalance
-- then the Highest Balance = the current balance
   select   HighestBalance -CurrentARBalance INTO v_Balance FROM
   CustomerFinancials WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND CustomerID = v_CustomerID;

   IF v_Balance < 0 then

      SET @SWV_Error = 0;
      UPDATE
      CustomerFinancials
      SET
      HighestBalance = CurrentARBalance
      WHERE
      CompanyID = v_CompanyID
      AND DivisionID = v_DivisionID
      AND DepartmentID = v_DepartmentID
      AND CustomerID = v_CustomerID;
      IF @SWV_Error <> 0 then
	-- An error occured, go to the error handler
	
         SET v_ErrorMessage = 'Update CustomerFinancials failed';
         ROLLBACK;
-- the error handler
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Invoice_CustomerFinancialsUpdateAging',
         v_ErrorMessage,v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
         SET SWP_Ret_Value = -1;
      end if;
   end if;

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
   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Invoice_CustomerFinancialsUpdateAging',
   v_ErrorMessage,v_ErrorID);

   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);

   SET SWP_Ret_Value = -1;
END;













//

DELIMITER ;

DELIMITER //
DROP PROCEDURE IF EXISTS ServiceInvoice_Recalc2;
//
CREATE              PROCEDURE ServiceInvoice_Recalc2(v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_InvoiceNumber  NATIONAL VARCHAR(36),INOUT SWP_Ret_Value INT)
   SWL_return:
BEGIN


















/*
Name of stored procedure: ServiceInvoice_Recalc
Method: 
	Calculates the amounts of money for a specified service invoice

Date Created: EDE - 07/28/2015

Input Parameters:

	@CompanyID NVARCHAR(36)		 - the ID of the company
	@DivisionID NVARCHAR(36)	 - the ID of the division
	@DepartmentID NVARCHAR(36)	 - the ID of the department
	@InvoiceNumber NVARCHAR (36)	 - the service invoice number

Output Parameters:

	NONE

Called From:

	ServiceInvoice_Post, ServiceInvoice_Recalc.vb

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
   DECLARE v_AllowanceDiscountPercent FLOAT;

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
   select   CurrencyID, CurrencyExchangeRate, InvoiceDate, IFNULL(DiscountPers,0), IFNULL(TaxFreight,0), IFNULL(Freight,0), IFNULL(Handling,0), TaxGroupID, IFNULL(AllowanceDiscountPerc,0) INTO v_CurrencyID,v_CurrencyExchangeRate,v_InvoiceDate,v_DiscountPers,v_TaxFreight,
   v_Freight,v_Handling,v_HeaderTaxGroupID,v_AllowanceDiscountPercent FROM
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
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'ServiceInvoice_Recalc',v_ErrorMessage,
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
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'ServiceInvoice_Recalc',v_ErrorMessage,
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
            CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'ServiceInvoice_Recalc',v_ErrorMessage,
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
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'ServiceInvoice_Recalc',v_ErrorMessage,
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
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'ServiceInvoice_Recalc',v_ErrorMessage,
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

   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'ServiceInvoice_Recalc',v_ErrorMessage,
   v_ErrorID);

   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);

   SET SWP_Ret_Value = -1;
END;































//

DELIMITER ;

DELIMITER //
DROP PROCEDURE IF EXISTS ServiceInvoice_CreateGLTransaction;
//
CREATE              PROCEDURE ServiceInvoice_CreateGLTransaction(v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_InvoiceNumber NATIONAL VARCHAR(36),
	v_PostDate  NATIONAL VARCHAR(1),INOUT SWP_Ret_Value INT)
   SWL_return:
BEGIN

/*
Name of stored procedure: ServiceInvoice_CreateGLTransaction
Method:
	Creates a new GL transaction for the service invoice
Date Created: EDE - 07/28/2015
Input Parameters:
	@CompanyID NVARCHAR(36)		 - the ID of the company
	@DivisionID NVARCHAR(36)	 - the ID of the division
	@DepartmentID NVARCHAR(36)	 - the ID of the department
	@InvoiceNumber NVARCHAR(36)	 - the service invoice number
	@PostDate NVARCHAR(1)			 - defines the date of GL transaction
							   1 - the current date
							   0 - the service invoice date
Output Parameters:
	NONE
Called From:
	ServiceInvoice_Post
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
   DECLARE v_ConvertedTotal DECIMAL(19,4);
   DECLARE v_ItemGLSalesAccount NATIONAL VARCHAR(36);
   DECLARE v_ItemUnitPrice DECIMAL(19,4);
   DECLARE v_ItemProjectID NATIONAL VARCHAR(36);
   DECLARE v_TaxAccount NATIONAL VARCHAR(36);
   DECLARE v_TaxAmount DECIMAL(19,4);
   DECLARE v_TaxGroupID NATIONAL VARCHAR(36);
   DECLARE v_TotalTaxPercent FLOAT;
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
	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'ServiceInvoice_CreateGLTransaction',
         v_ErrorMessage,v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
      end if;
      SET SWP_Ret_Value = -1;
   end if;
   select   ProjectID INTO v_ProjectID FROM  InvoiceDetail WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND InvoiceNumber = v_InvoiceNumber
   AND NOT ProjectID IS NULL   LIMIT 1;
   SET v_ConvertedTotal = fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,v_Total*v_CurrencyExchangeRate, 
   v_CompanyCurrencyID);
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
	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'ServiceInvoice_CreateGLTransaction',
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
	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'ServiceInvoice_CreateGLTransaction',
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
	
            CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'ServiceInvoice_CreateGLTransaction',
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
	
            CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'ServiceInvoice_CreateGLTransaction',
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
		fnRound(v_CompanyID, v_DivisionID, v_DepartmentID, v_DiscountAmount*v_CurrencyExchangeRate, v_CompanyCurrencyID),
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
	
            CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'ServiceInvoice_CreateGLTransaction',
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
	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'ServiceInvoice_CreateGLTransaction',
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
         CALL TaxGroup_GetTotalPercent(v_CompanyID,v_DivisionID,v_DepartmentID,v_TaxGroupID,v_TotalTaxPercent);
         IF @SWV_Error <> 0 then
	
            SET v_ErrorMessage = 'Procedure call TaxGroup_GetTotalPercent failed';
            ROLLBACK;
            DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;
            IF v_ErrorMessage <> '' then

	-- the error handler
	
               CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'ServiceInvoice_CreateGLTransaction',
               v_ErrorMessage,v_ErrorID);
               CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
            end if;
            SET SWP_Ret_Value = -1;
         end if;
         OPEN cTax;
         SET NO_DATA = 0;
         FETCH cTax INTO v_TaxPercent,v_GLTaxAccount;
         WHILE NO_DATA = 0 DO
	-- Credit Tax to Tax Account
            IF v_TotalTaxPercent <> 0 then
               SET v_ItemTaxAmount = fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,v_TaxAmount*v_CurrencyExchangeRate*v_TaxPercent/v_TotalTaxPercent, 
               v_CompanyCurrencyID);
            ELSE
               SET v_ItemTaxAmount = 0;
            end if;
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
	
                  CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'ServiceInvoice_CreateGLTransaction',
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
	
            CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'ServiceInvoice_CreateGLTransaction',
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
	-- Credit Handling from AR Handling Account
      SET @SWV_Error = 0;
      INSERT INTO tt_LedgerDetailTmp(GLTransactionAccount,
		GLDebitAmount,
		GLCreditAmount,
		ProjectID)
	VALUES(v_GLARHandlingAccount,
		0,
		fnRound(v_CompanyID, v_DivisionID , v_DepartmentID,v_Handling*v_CurrencyExchangeRate, v_CompanyCurrencyID),
		v_ProjectID);
	
      IF @SWV_Error <> 0 then
	-- An error occured, go to the error handler
	-- and drop the temporary table
	
         SET v_ErrorMessage = 'Error Processing Handling Data';
         ROLLBACK;
         DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;
         IF v_ErrorMessage <> '' then

	-- the error handler
	
            CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'ServiceInvoice_CreateGLTransaction',
            v_ErrorMessage,v_ErrorID);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
         end if;
         SET SWP_Ret_Value = -1;
      end if;
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
	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'ServiceInvoice_CreateGLTransaction',
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
	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'ServiceInvoice_CreateGLTransaction',
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
	
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'ServiceInvoice_CreateGLTransaction',
      v_ErrorMessage,v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
   end if;
   SET SWP_Ret_Value = -1;
END;




//

DELIMITER ;
