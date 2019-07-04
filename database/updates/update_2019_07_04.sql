update databaseinfo set value='2019_07_04',lastupdate=now() WHERE id='Version';

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
   DECLARE v_NextNumber VARCHAR(36);      
      
   DECLARE v_ErrorID INT;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
   END;
   SET @SWV_Error = 0;
   START TRANSACTION;      
      
-- get the GL Transaction Number      
   SET @SWV_Error = 0;
   SET v_NextNumber = LEFT(v_NewPurchaseNumber, 36);
   CALL GetNextEntityID2(v_CompanyID,v_DivisionID,v_DepartmentID,'NextPurchaseOrderNumber',v_NextNumber, v_ReturnStatus);
   SET v_NewPurchaseNumber = v_NextNumber;
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
