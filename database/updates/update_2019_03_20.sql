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
