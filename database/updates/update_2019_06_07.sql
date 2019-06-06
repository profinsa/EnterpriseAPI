update databaseinfo set value='2019_06_07',lastupdate=now() WHERE id='Version';

DELIMITER //
DROP PROCEDURE IF EXISTS Invoice_CreateFromMemorized;
//
CREATE PROCEDURE Invoice_CreateFromMemorized(v_CompanyID  NATIONAL VARCHAR(36),    
 v_DivisionID  NATIONAL VARCHAR(36),    
 v_DepartmentID NATIONAL VARCHAR(36),    
 v_InvoiceNumber  NATIONAL VARCHAR(36),    
 INOUT v_NewInvoiceNumber  NATIONAL VARCHAR(72)  ,INOUT SWP_Ret_Value INT)
   SWL_return:
BEGIN
       /*    
Name of stored procedure: Invoice_CreateFromMemorized    
Method:     
 Creates an Invoice from an Memorized Invoice    
    
Date Created: EDE - 07/28/2015    
    
Input Parameters:    
    
 @CompanyID NVARCHAR(36)   - the ID of the company    
 @DivisionID NVARCHAR(36)  - the ID of the division    
 @DepartmentID NVARCHAR(36)  - the ID of the department    
 @InvoiceNumber NVARCHAR (36)  - the ID of memorized invoice    
    
Output Parameters:    
    
 @NewInvoiceNumber NVARCHAR (36)  - the ID of created invoice    
    
Called From:    
    
 Invoice_CreateFromMemorized.vb    
    
Calls:    
    
 GetNextEntityID, Error_InsertError, Error_InsertErrorDetail    
    
Last Modified:     
    
Last Modified By:     
    
Revision History:     
    
*/    
   DECLARE v_ReturnStatus SMALLINT;    
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);    
    
   DECLARE v_ErrorID INT;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
   END;
   SET @SWV_Error = 0;
   START TRANSACTION;    
    
-- get the RMA number as a new number from the company table    
   SET @SWV_Error = 0;
   CALL GetNextEntityID2(v_CompanyID,v_DivisionID,v_DepartmentID,'NextInvoiceNumber',v_NewInvoiceNumber, v_ReturnStatus);    
   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then

      SET v_NewInvoiceNumber = N'';
      SET v_ErrorMessage = 'GetNextEntityID call failed';
      ROLLBACK;
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Invoice_CreateFromMemorized',
      v_ErrorMessage,v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
      SET SWP_Ret_Value = -1;
   end if;    
    
   SET @SWV_Error = 0;
   INSERT INTO InvoiceHeader(CompanyID,
 DivisionID,
 DepartmentID,
 InvoiceNumber,
 OrderNumber,
 TransactionTypeID,
 TransOpen,
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
 CommissionPaid,
 CommissionSelectToPay,
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
 ScheduledStartDate,
 ScheduledEndDate,
 ServiceStartDate,
 ServiceEndDate,
 PerformedBy,
 GLSalesAccount,
 PaymentMethodID,
 AmountPaid,
 UndistributedAmount,
 BalanceDue,
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
 Billed,
 BilledDate,
 Backordered,
 Posted,
 PostedDate,
 MasterBillOfLading,
 MasterBillOfLadingDate,
 TrailerNumber,
 TrailerPrefix,
 HeaderMemo1,
 HeaderMemo2,
 HeaderMemo3,
 HeaderMemo4,
 HeaderMemo5,
 HeaderMemo6,
 HeaderMemo7,
 HeaderMemo8,
 HeaderMemo9,
 Approved,
 ApprovedBy,
 ApprovedDate,
 EnteredBy,
 Signature,
 SignaturePassword,
 SupervisorSignature,
 SupervisorPassword,
 ManagerSignature,
 ManagerPassword)
   SELECT
   CompanyID,
 DivisionID,
 DepartmentID,
 v_NewInvoiceNumber, -- [InvoiceNumber],    
 OrderNumber,
 TransactionTypeID,
 TransOpen,
 now(), -- [InvoiceDate],    
 InvoiceDueDate,
 InvoiceShipDate,
 InvoiceCancelDate,
 now(), -- [SystemDate],    
 0, -- [Memorize],    
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
 CommissionPaid,
 CommissionSelectToPay,
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
 ScheduledStartDate,
 ScheduledEndDate,
 ServiceStartDate,
 ServiceEndDate,
 PerformedBy,
 GLSalesAccount,
 PaymentMethodID,
 AmountPaid,
 UndistributedAmount,
 BalanceDue,
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
 0, -- [Picked],    
 now(), -- [PickedDate],    
 0, -- [Printed],    
 now(), -- [PrintedDate],    
 0, -- [Shipped],    
 now(), -- [ShipDate],    
 TrackingNumber,
 0, -- [Billed],    
 now(), -- [BilledDate],    
 0, -- [Backordered],    
 0, -- [Posted],    
 now(), -- [PostedDate],    
 MasterBillOfLading,
 MasterBillOfLadingDate,
 TrailerNumber,
 TrailerPrefix,
 HeaderMemo1,
 HeaderMemo2,
 HeaderMemo3,
 HeaderMemo4,
 HeaderMemo5,
 HeaderMemo6,
 HeaderMemo7,
 HeaderMemo8,
 HeaderMemo9,
 Approved,
 ApprovedBy,
 ApprovedDate,
 EnteredBy,
 Signature,
 SignaturePassword,
 SupervisorSignature,
 SupervisorPassword,
 ManagerSignature,
 ManagerPassword
   FROM         InvoiceHeader   WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND InvoiceNumber = v_InvoiceNumber;    
    
   IF @SWV_Error <> 0 then

      SET v_NewInvoiceNumber = N'';
      SET v_ErrorMessage = 'Cannot create Invoice Header';
      ROLLBACK;
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Invoice_CreateFromMemorized',
      v_ErrorMessage,v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
      SET SWP_Ret_Value = -1;
   end if;    
    
-- create the Order details getting all the data from the invoice    
   SET @SWV_Error = 0;
   INSERT INTO InvoiceDetail(CompanyID,
 DivisionID,
 DepartmentID,
 InvoiceNumber,    
 -- [InvoiceLineNumber],    
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
 CurrencyID,
 CurrencyExchangeRate,
 ItemCost,
 ItemUnitPrice,
 Total,
 TotalWeight,
 GLSalesAccount,
 ProjectID,
 WarehouseBinZone,
 PalletLevel,
 CartonLevel,
 PackLevelA,
 PackLevelB,
 PackLevelC,
 TrackingNumber,
 ScheduledStartDate,
 ScheduledEndDate,
 ServiceStartDate,
 ServiceEndDate,
 PerformedBy,
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
 v_NewInvoiceNumber, -- [InvoiceNumber],    
 -- [InvoiceLineNumber],    
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
 CurrencyID,
 CurrencyExchangeRate,
 ItemCost,
 ItemUnitPrice,
 Total,
 TotalWeight,
 GLSalesAccount,
 ProjectID,
 WarehouseBinZone,
 PalletLevel,
 CartonLevel,
 PackLevelA,
 PackLevelB,
 PackLevelC,
 TrackingNumber,
 ScheduledStartDate,
 ScheduledEndDate,
 ServiceStartDate,
 ServiceEndDate,
 PerformedBy,
 DetailMemo1,
 DetailMemo2,
 DetailMemo3,
 DetailMemo4,
 DetailMemo5,
 TaxGroupID,
 TaxAmount,
 TaxPercent,
 SubTotal
   FROM         InvoiceDetail WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND InvoiceNumber = v_InvoiceNumber;    
    
   IF @SWV_Error <> 0 then

      SET v_NewInvoiceNumber = N'';
      SET v_ErrorMessage = 'Cannot create Invoice Details';
      ROLLBACK;
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Invoice_CreateFromMemorized',
      v_ErrorMessage,v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
      SET SWP_Ret_Value = -1;
   end if;    
  
   SET v_NewInvoiceNumber = CONCAT('New Invoice Created With Invoice Number:',v_NewInvoiceNumber);     
  
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
    
   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Invoice_CreateFromMemorized',
   v_ErrorMessage,v_ErrorID);    
   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);    
    
   SET SWP_Ret_Value = -1;
END;

//

DELIMITER ;

DELIMITER //
DROP PROCEDURE IF EXISTS Purchase_CreateFromMemorized;
//
CREATE PROCEDURE Purchase_CreateFromMemorized( -- the number of the transaction to be cloned      
v_CompanyID NATIONAL VARCHAR(36),      
 v_DivisionID NATIONAL VARCHAR(36),      
 v_DepartmentID NATIONAL VARCHAR(36),      
 v_PurchaseNumber NATIONAL VARCHAR(36), -- the number of the transaction to be cloned      
 INOUT v_NewPurchaseNumber NATIONAL VARCHAR(72),INOUT SWP_Ret_Value INT)
   SWL_return:
BEGIN
/*      
Name of stored procedure: Purchase_CreateFromMemorized      
Method:       
 ALTER  a new purchase from a memorized one      
      
Date Created: EDE - 07/28/2015      
      
Input Parameters:      
      
 @CompanyID NVARCHAR(36)   - the ID of the company      
 @DivisionID NVARCHAR(36)  - the ID of the division      
 @DepartmentID NVARCHAR(36)  - the ID of the department      
 @PurchaseNumber NVARCHAR(36)  - the number of the transaction to be cloned      
      
Output Parameters:      
      
 @NewPurchaseNumber NVARCHAR(36)  - the number of the created purchase      
      
Called From:      
      
 Purchase_CreateFromMemorized.vb      
      
Calls:      
      
 GetNextEntityID, Error_InsertError, Error_InsertErrorDetail      
      
Last Modified:       
      
Last Modified By:       
      
Revision History:       
      
*/      
      
      
/*      
Clone the transaction @PurchaseNumber,       
so makes an insert into the PurchaseHeader       
and a bulk insert into PurchaseHeaderDetail      
*/      
   DECLARE v_ReturnStatus SMALLINT;      
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);      
      
   DECLARE v_ErrorID INT;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
   END;
   SET @SWV_Error = 0;
   START TRANSACTION;      
      
-- get the GL Transaction Number      
   SET @SWV_Error = 0;
   CALL GetNextEntityID2(v_CompanyID,v_DivisionID,v_DepartmentID,'NextPurchaseOrderNumber',v_NewPurchaseNumber, v_ReturnStatus);      
   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then

      SET v_NewPurchaseNumber = N'';
      SET v_ErrorMessage = 'GetNextEntityID call failed';
      ROLLBACK;      
-- the error handler      
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Purchase_CreateFromMemorized',
      v_ErrorMessage,v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseNumber',v_PurchaseNumber);
      SET SWP_Ret_Value = -1;
   end if;      
      
      
-- inserts a record into the PurchaseHeader table      
   SET @SWV_Error = 0;
   INSERT INTO PurchaseHeader(CompanyID,
 DivisionID,
 DepartmentID,
 PurchaseNumber,
 TransactionTypeID,
 PurchaseDate,
 PurchaseDueDate,
 PurchaseShipDate,
 PurchaseCancelDate,
 PurchaseDateRequested,
 SystemDate,
 Memorize,
 OrderNumber,
 VendorInvoiceNumber,
 OrderedBy,
 TaxExemptID,
 TaxGroupID,
 VendorID,
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
 ShipToWarehouse,
 WarehouseID,
 ShipMethodID,
 ShippingName,
 ShippingAddress1,
 ShippingAddress2,
 ShippingAddress3,
 ShippingCity,
 ShippingState,
 ShippingZip,
 ShippingCountry,
 Paid,
 PaymentID,
 PaymentMethodID,
 PaymentDate,
 GLPurchaseAccount,
 AmountPaid,
 BalanceDue,
 UndistributedAmount,
 CheckNumber,
 CheckDate,
 PaidDate,
 CreditCardTypeID,
 CreditCardName,
 CreditCardNumber,
 CreditCardExpDate,
 CreditCardCSVNumber,
 CreditCardBillToZip,
 CreditCardValidationCode,
 CreditCardApprovalNumber,
 Approved,
 ApprovedBy,
 ApprovedDate,
 Printed,
 PrintedDate,
 Shipped,
 ShipDate,
 TrackingNumber,
 Received,
 ReceivedDate,
 RecivingNumber,
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
 EnteredBy,
 Signature,
 SignaturePassword,
 SupervisorSignature,
 SupervisorPassword,
 ManagerSignature,
 ManagerPassword,
 LockedBy,
 LockTS)
   SELECT
   CompanyID,
  DivisionID,
  DepartmentID,
  v_NewPurchaseNumber,
  TransactionTypeID,
  CURRENT_TIMESTAMP,-- [PurchaseDate],       
  PurchaseDueDate,
  now(), -- [PurchaseShipDate],       
  now(), -- [PurchaseCancelDate],       
  now(), -- [PurchaseDateRequested],       
  CURRENT_TIMESTAMP,-- [SystemDate],       
  0,-- [Memorize],       
  OrderNumber,
  VendorInvoiceNumber,
  OrderedBy,
  TaxExemptID,
  TaxGroupID,
  VendorID,
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
  ShipToWarehouse,
  WarehouseID,
  ShipMethodID,
  ShippingName,
  ShippingAddress1,
  ShippingAddress2,
  ShippingAddress3,
  ShippingCity,
  ShippingState,
  ShippingZip,
  ShippingCountry,
  0,-- [Paid],       
  NULL,-- [PaymentID],       
  PaymentMethodID,
  now(), -- [PaymentDate],       
  GLPurchaseAccount,
  0, -- [AmountPaid],       
  Total, -- [BalanceDue],       
  0, -- [UndistributedAmount],       
  NULL,-- [CheckNumber],       
  now(), -- [CheckDate],       
  now(), -- [PaidDate],       
  CreditCardTypeID,
  CreditCardName,
  CreditCardNumber,
  CreditCardExpDate,
  CreditCardCSVNumber,
  CreditCardBillToZip,
  CreditCardValidationCode,
  CreditCardApprovalNumber,
  0,-- [Approved],       
  NULL, -- [ApprovedBy],       
  now(), -- [ApprovedDate],       
  0,-- [Printed],       
  now(), -- [PrintedDate],       
  0,-- [Shipped],       
  now(), -- [ShipDate],       
  TrackingNumber,
  0,-- [Received],       
  now(), -- [ReceivedDate],       
  NULL,-- [RecivingNumber],       
  0,-- [Posted],       
  now(), -- [PostedDate],       
  HeaderMemo1,
  HeaderMemo2,
  HeaderMemo3,
  HeaderMemo4,
  HeaderMemo5,
  HeaderMemo6,
  HeaderMemo7,
  HeaderMemo8,
  HeaderMemo9,
  EnteredBy,
  Signature,
  SignaturePassword,
  SupervisorSignature,
  SupervisorPassword,
  ManagerSignature,
  ManagerPassword,
  NULL,-- [LockedBy],       
  NULL-- [LockTS]       
   FROM
   PurchaseHeader
   WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND PurchaseNumber = v_PurchaseNumber;      
      
   IF @SWV_Error <> 0 then      
-- An error occured, go to error handler      

      SET v_ErrorMessage = 'Insert into PurchaseHeader failed';
      ROLLBACK;      
-- the error handler      
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Purchase_CreateFromMemorized',
      v_ErrorMessage,v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseNumber',v_PurchaseNumber);
      SET SWP_Ret_Value = -1;
   end if;      
      
      
   SET @SWV_Error = 0;
   INSERT INTO
   PurchaseDetail(CompanyID,
 DivisionID,
 DepartmentID,
 PurchaseNumber,       
 -- [PurchaseLineNumber],       
 ItemID,
 VendorItemID,
 Description,
 WarehouseID,
 WarehouseBinID,
 SerialNumber,
 OrderQty,
 ItemUOM,
 ItemWeight,
 DiscountPerc,
 Taxable,
 ItemCost,
 CurrencyID,
 CurrencyExchangeRate,
 ItemUnitPrice,
 Total,
 TotalWeight,
 GLPurchaseAccount,
 ProjectID,
 Received,
 ReceivedDate,
 ReceivedQty,
 RecivingNumber,
 TrackingNumber,
 DetailMemo1,
 DetailMemo2,
 DetailMemo3,
 DetailMemo4,
 DetailMemo5,
 LockedBy,
 LockTS,
 TaxGroupID,
 TaxAmount,
 TaxPercent,
 SubTotal)
   SELECT
   CompanyID,
 DivisionID,
 DepartmentID,
 v_NewPurchaseNumber,       
 -- [PurchaseLineNumber],       
 ItemID,
 VendorItemID,
 Description,
 WarehouseID,
 WarehouseBinID,
 SerialNumber,
 OrderQty,
 ItemUOM,
 ItemWeight,
 DiscountPerc,
 Taxable,
 ItemCost,
 CurrencyID,
 CurrencyExchangeRate,
 ItemUnitPrice,
 Total,
 TotalWeight,
 GLPurchaseAccount,
 ProjectID,
 0,-- [Received],       
 now(), -- [ReceivedDate],       
 0,-- [ReceivedQty],       
 NULL,-- [RecivingNumber],       
 NULL,-- [TrackingNumber],       
 DetailMemo1,
 DetailMemo2,
 DetailMemo3,
 DetailMemo4,
 DetailMemo5,
 NULL,-- [LockedBy],       
 NULL,-- [LockTS]       
 TaxGroupID,
 TaxAmount,
 TaxPercent,
 SubTotal
   FROM
   PurchaseDetail
   WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND PurchaseNumber = v_PurchaseNumber;      
      
   IF @SWV_Error <> 0 then      
-- An error occured, go to error handler      

      SET v_ErrorMessage = 'Insert into PurchaseHeaderDetail failed';
      ROLLBACK;      
-- the error handler      
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Purchase_CreateFromMemorized',
      v_ErrorMessage,v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseNumber',v_PurchaseNumber);
      SET SWP_Ret_Value = -1;
   end if;      
      
   SET v_NewPurchaseNumber = CONCAT('New Purchase Entry Created With Purchase Number:',v_NewPurchaseNumber);    
      
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
   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Purchase_CreateFromMemorized',
   v_ErrorMessage,v_ErrorID);      
      
   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseNumber',v_PurchaseNumber);      
      
   SET SWP_Ret_Value = -1;
END;

//

DELIMITER ;

DELIMITER //
DROP PROCEDURE IF EXISTS Order_CreateFromMemorized;
//
CREATE PROCEDURE Order_CreateFromMemorized(v_CompanyID  NATIONAL VARCHAR(36),  
 v_DivisionID  NATIONAL VARCHAR(36),  
 v_DepartmentID NATIONAL VARCHAR(36),  
 v_OrderNumber  NATIONAL VARCHAR(36),  
 INOUT v_NewOrderNumber  NATIONAL VARCHAR(72)  ,INOUT SWP_Ret_Value INT)
   SWL_return:
BEGIN
/*  
Name of stored procedure: Order_CreateFromMemorized  
Method:   
 Creates an Order from an Memorized Order  
  
Date Created: EDE - 07/28/2015  
  
Input Parameters:  
  
 @CompanyID NVARCHAR(36)   - the ID of the company  
 @DivisionID NVARCHAR(36)  - the ID of the division  
 @DepartmentID NVARCHAR(36)  - the ID of the department  
 @OrderNumber NVARCHAR (36)  - the order number  
  
Output Parameters:  
  
 @NewOrderNumber NVARCHAR (36)  - the number of new order  
  
Called From:  
  
 Order_CreateFromMemorized.vb  
  
Calls:  
  
 GetNextEntityID, Error_InsertError, Error_InsertErrorDetail  
  
Last Modified:   
  
Last Modified By:   
  
Revision History:   
  
*/  
  
   DECLARE v_ReturnStatus SMALLINT;  
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);  
  
   DECLARE v_ErrorID INT;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
   END;
   SET @SWV_Error = 0;
   START TRANSACTION;  
  
-- get the RMA number as a new number from the company table  
   SET @SWV_Error = 0;
   CALL GetNextEntityID2(v_CompanyID,v_DivisionID,v_DepartmentID,'NextOrderNumber',v_NewOrderNumber, v_ReturnStatus);  
   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then

      SET v_NewOrderNumber = N'';
      SET v_ErrorMessage = 'GetNextEntityID call failed';
      ROLLBACK;
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Order_CreateFromMemorized',
      v_ErrorMessage,v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'OrderNumber',v_OrderNumber);
      SET SWP_Ret_Value = -1;
   end if;  
  
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
 ScheduledStartDate,
 ScheduledEndDate,
 ServiceStartDate,
 ServiceEndDate,
 PerformedBy,
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
 Backordered,
 Picked,
 PickedDate,
 Printed,
 PrintedDate,
 Shipped,
 ShipDate,
 TrackingNumber,
 Billed,
 BilledDate,
 Invoiced,
 InvoiceNumber,
 InvoiceDate,
 Posted,
 PostedDate,
 MasterBillOfLading,
 MasterBillOfLadingDate,
 TrailerNumber,
 TrailerPrefix,
 HeaderMemo1,
 HeaderMemo2,
 HeaderMemo3,
 HeaderMemo4,
 HeaderMemo5,
 HeaderMemo6,
 HeaderMemo7,
 HeaderMemo8,
 HeaderMemo9,
 Approved,
 ApprovedBy,
 ApprovedDate,
 EnteredBy,
 Signature,
 SignaturePassword,
 SupervisorSignature,
 SupervisorPassword,
 ManagerSignature,
 ManagerPassword)
   SELECT
   CompanyID,
 DivisionID,
 DepartmentID,
 v_NewOrderNumber, -- [OrderNumber],  
 TransactionTypeID,
 OrderTypeID,
 now(), -- [OrderDate],  
 OrderDueDate,
 OrderShipDate,
 OrderCancelDate,
 now(), -- [SystemDate],  
 0, -- [Memorize],  
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
 ScheduledStartDate,
 ScheduledEndDate,
 ServiceStartDate,
 ServiceEndDate,
 PerformedBy,
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
 0, -- [Backordered],  
 0, -- [Picked],  
 now(), -- [PickedDate],  
 0, -- [Printed],  
 now(), -- [PrintedDate],  
 0, -- [Shipped],  
 now(), -- [ShipDate],  
 NULL, -- [TrackingNumber],  
 0, -- [Billed],  
 now(), -- [BilledDate],  
 0, -- [Invoiced],  
 NULL, -- [InvoiceNumber],  
 now(), -- [InvoiceDate],  
 0, -- [Posted],  
 now(), -- [PostedDate],  
 MasterBillOfLading,
 MasterBillOfLadingDate,
 TrailerNumber,
 TrailerPrefix,
 HeaderMemo1,
 HeaderMemo2,
 HeaderMemo3,
 HeaderMemo4,
 HeaderMemo5,
 HeaderMemo6,
 HeaderMemo7,
 HeaderMemo8,
 HeaderMemo9,
 Approved,
 ApprovedBy,
 ApprovedDate,
 EnteredBy,
 Signature,
 SignaturePassword,
 SupervisorSignature,
 SupervisorPassword,
 ManagerSignature,
 ManagerPassword
   FROM   OrderHeader WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND OrderNumber = v_OrderNumber;  
  
   IF @SWV_Error <> 0 then

      SET v_NewOrderNumber = N'';
      SET v_ErrorMessage = 'Cannot create Order Header';
      ROLLBACK;
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Order_CreateFromMemorized',
      v_ErrorMessage,v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'OrderNumber',v_OrderNumber);
      SET SWP_Ret_Value = -1;
   end if;  
  
-- create the Order details getting all the data from the invoice  
   SET @SWV_Error = 0;
   INSERT INTO OrderDetail(CompanyID,
 DivisionID,
 DepartmentID,
 OrderNumber,  
 -- [OrderLineNumber],  
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
 CurrencyID,
 CurrencyExchangeRate,
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
 ScheduledStartDate,
 ScheduledEndDate,
 ServiceStartDate,
 ServiceEndDate,
 PerformedBy,
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
 v_NewOrderNumber, -- [OrderNumber],  
 -- [OrderLineNumber],  
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
 CurrencyID,
 CurrencyExchangeRate,
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
 ScheduledStartDate,
 ScheduledEndDate,
 ServiceStartDate,
 ServiceEndDate,
 PerformedBy,
 DetailMemo1,
 DetailMemo2,
 DetailMemo3,
 DetailMemo4,
 DetailMemo5,
 TaxGroupID,
 TaxAmount,
 TaxPercent,
 SubTotal
   FROM         OrderDetail
   WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND OrderNumber = v_OrderNumber;  
  
   IF @SWV_Error <> 0 then

      SET v_NewOrderNumber = N'';
      SET v_ErrorMessage = 'Cannot create Order Details';
      ROLLBACK;
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'ServiceOrder_CreateFromMemorized',
      v_ErrorMessage,v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'OrderNumber',v_OrderNumber);
      SET SWP_Ret_Value = -1;
   end if;  
  
   SET v_NewOrderNumber = CONCAT('New Order Created With OrderNumber:',v_NewOrderNumber);  
  
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
  
   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Order_CreateFromMemorized',
   v_ErrorMessage,v_ErrorID);  
   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'OrderNumber',v_OrderNumber);  
  
   SET SWP_Ret_Value = -1;
END;

//

DELIMITER ;

DELIMITER //
DROP PROCEDURE IF EXISTS LedgerTransactions_CreateFromMemorized;
//
CREATE PROCEDURE LedgerTransactions_CreateFromMemorized( -- the number of the transaction to be cloned    
v_CompanyID NATIONAL VARCHAR(36),    
 v_DivisionID NATIONAL VARCHAR(36),    
 v_DepartmentID NATIONAL VARCHAR(36),    
 v_GLTransactionNumber NATIONAL VARCHAR(36), -- the number of the transaction to be cloned    
 INOUT v_NewGLTransactionNumber NATIONAL VARCHAR(72),INOUT SWP_Ret_Value INT)
   SWL_return:
BEGIN
/*    
Name of stored procedure: LedgerTransactions_CreateFromMemorized    
Method:     
 ALTER  a new ledger transaction from an memorized one    
    
Date Created: EDE - 07/28/2015    
    
Input Parameters:    
    
 @CompanyID NVARCHAR(36)   - the ID of the company    
 @DivisionID NVARCHAR(36)  - the ID of the division    
 @DepartmentID NVARCHAR(36)  - the ID of the department    
 @GLTransactionNumber NVARCHAR(36) - the number of the transaction to be cloned    
    
Output Parameters:    
    
 @NewGLTransactionNumber NVARCHAR(36) - the number of the new transaction    
    
Called From:    
    
 LedgerTransactions_CreateFromMemorized.vb    
    
Calls:    
    
 GetNextEntityID, Error_InsertError, Error_InsertErrorDetail    
    
Last Modified:     
    
Last Modified By:     
    
Revision History:     
    
*/    
    
    
/*    
Clone the transaction @GLTransactionNumber,     
so makes an insert into the LedgerTransactions     
and a bulk insert into LedgerTransactionsDetail    
*/    
   DECLARE v_ReturnStatus SMALLINT;    
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);    
    
   DECLARE v_ErrorID INT;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
   END;
   SET @SWV_Error = 0;
   START TRANSACTION;    
    
-- get the GL Transaction Number    
   SET @SWV_Error = 0;
   CALL GetNextEntityID2(v_CompanyID,v_DivisionID,v_DepartmentID,'NextGLTransNumber',v_NewGLTransactionNumber, v_ReturnStatus);    
   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then

      SET v_NewGLTransactionNumber = N'';
      SET v_ErrorMessage = 'GetNextEntityID call failed';
      ROLLBACK;    
-- the error handler    
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'LedgerTransactions_CreateFromMemorized',
      v_ErrorMessage,v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'GLTransactionNumber',
      v_GLTransactionNumber);
      SET SWP_Ret_Value = -1;
   end if;    
    
    
-- inserts a record into the LedgerTransactions table    
   SET @SWV_Error = 0;
   INSERT INTO LedgerTransactions(CompanyID,
 DivisionID,
 DepartmentID,
 GLTransactionNumber,
 GLTransactionTypeID,
 GLTransactionDate,
 SystemDate,
 GLTransactionDescription,
 GLTransactionReference,
 CurrencyID,
 CurrencyExchangeRate,
 GLTransactionAmount,
 GLTransactionAmountUndistributed,
 GLTransactionBalance,
 GLTransactionPostedYN,
 GLTransactionSource,
 GLTransactionSystemGenerated,
 GLTransactionRecurringYN,
 Reversal,
 Approved,
 ApprovedBy,
 ApprovedDate,
 EnteredBy,
 BatchControlNumber,
 BatchControlTotal,
 Signature,
 SignaturePassword,
 SupervisorSignature,
 SupervisorPassword,
 ManagerSignature,
 ManagerPassword,
 LockedBy,
 LockTS)
   SELECT
   CompanyID,
  DivisionID,
  DepartmentID,
  v_NewGLTransactionNumber, -- [GLTransactionNumber],     
  GLTransactionTypeID,
  now(),-- [GLTransactionDate],     
  now(),-- [SystemDate],     
  GLTransactionDescription,
  GLTransactionReference,
  CurrencyID,
  CurrencyExchangeRate,
  GLTransactionAmount,
  GLTransactionAmountUndistributed,
  GLTransactionBalance,
  0,-- [GLTransactionPostedYN],     
  GLTransactionSource,
  GLTransactionSystemGenerated,
  0,-- [GLTransactionRecurringYN],     
  0,-- [Reversal],     
  0,-- [Approved],     
  ApprovedBy,
  now(),-- [ApprovedDate],     
  EnteredBy,
  BatchControlNumber,
  BatchControlTotal,
  Signature,
  SignaturePassword,
  SupervisorSignature,
  SupervisorPassword,
  ManagerSignature,
  ManagerPassword,
  NULL,-- [LockedBy],     
  NULL-- [LockTS]     
   FROM
   LedgerTransactions
   WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND GLTransactionNumber = v_GLTransactionNumber;    
    
   IF @SWV_Error <> 0 then    
-- An error occured, go to error handler    

      SET v_ErrorMessage = 'Insert into LedgerTransaction failed';
      ROLLBACK;    
-- the error handler    
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'LedgerTransactions_CreateFromMemorized',
      v_ErrorMessage,v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'GLTransactionNumber',
      v_GLTransactionNumber);
      SET SWP_Ret_Value = -1;
   end if;    
    
    
   SET @SWV_Error = 0;
   INSERT INTO
   LedgerTransactionsDetail(CompanyID,
 DivisionID,
 DepartmentID,
 GLTransactionNumber,     
 -- [GLTransactionNumberDetail],     
 GLTransactionAccount,
 CurrencyID,
 CurrencyExchangeRate,
 GLDebitAmount,
 GLCreditAmount,
 ProjectID,
 LockedBy,
 LockTS)
   SELECT
   CompanyID,
 DivisionID,
 DepartmentID,
 v_NewGLTransactionNumber,     
 -- [GLTransactionNumberDetail],     
 GLTransactionAccount,
 CurrencyID,
 CurrencyExchangeRate,
 GLDebitAmount,
 GLCreditAmount,
 ProjectID,
 NULL,-- [LockedBy],     
 NULL -LockTS
   FROM
   LedgerTransactionsDetail
   WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND GLTransactionNumber = v_GLTransactionNumber;    
    
   IF @SWV_Error <> 0 then    
-- An error occured, go to error handler    

      SET v_ErrorMessage = 'Insert into LedgerTransactionDetail failed';
      ROLLBACK;    
-- the error handler    
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'LedgerTransactions_CreateFromMemorized',
      v_ErrorMessage,v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'GLTransactionNumber',
      v_GLTransactionNumber);
      SET SWP_Ret_Value = -1;
   end if;    
    
   SET v_NewGLTransactionNumber = CONCAT('New Ledger Transaction Created With Transaction Number:',v_NewGLTransactionNumber);     
    
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
   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'LedgerTransactions_CreateFromMemorized',
   v_ErrorMessage,v_ErrorID);    
    
   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'GLTransactionNumber',
   v_GLTransactionNumber);    
    
   SET SWP_Ret_Value = -1;
END;

//

DELIMITER ;
