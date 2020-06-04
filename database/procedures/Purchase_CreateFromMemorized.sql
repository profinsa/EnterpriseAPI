CREATE PROCEDURE Purchase_CreateFromMemorized ( 
v_CompanyID NATIONAL VARCHAR(36),      
 v_DivisionID NATIONAL VARCHAR(36),      
 v_DepartmentID NATIONAL VARCHAR(36),      
 v_PurchaseNumber NATIONAL VARCHAR(36), 
 INOUT v_NewPurchaseNumber NATIONAL VARCHAR(72),INOUT SWP_Ret_Value INT) SWL_return:
BEGIN
      
      
      
      
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
      

   SET @SWV_Error = 0;
   SET v_NextNumber = LEFT(v_NewPurchaseNumber, 36);
   CALL GetNextEntityID2(v_CompanyID,v_DivisionID,v_DepartmentID,'NextPurchaseOrderNumber',v_NextNumber, v_ReturnStatus);
   SET v_NewPurchaseNumber = v_NextNumber;
   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then

      SET v_NewPurchaseNumber = N'';
      SET v_ErrorMessage = 'GetNextEntityID call failed';
      ROLLBACK;      

      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Purchase_CreateFromMemorized',
      v_ErrorMessage,v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseNumber',v_PurchaseNumber);
      SET SWP_Ret_Value = -1;
   end if;      
      
      

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
  CURRENT_TIMESTAMP,
  PurchaseDueDate,
  now(), 
  now(), 
  now(), 
  CURRENT_TIMESTAMP,
  0,
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
  0,
  NULL,
  PaymentMethodID,
  now(), 
  GLPurchaseAccount,
  0, 
  Total, 
  0, 
  NULL,
  now(), 
  now(), 
  CreditCardTypeID,
  CreditCardName,
  CreditCardNumber,
  CreditCardExpDate,
  CreditCardCSVNumber,
  CreditCardBillToZip,
  CreditCardValidationCode,
  CreditCardApprovalNumber,
  0,
  NULL, 
  now(), 
  0,
  now(), 
  0,
  now(), 
  TrackingNumber,
  0,
  now(), 
  NULL,
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
  HeaderMemo9,
  EnteredBy,
  Signature,
  SignaturePassword,
  SupervisorSignature,
  SupervisorPassword,
  ManagerSignature,
  ManagerPassword,
  NULL,
  NULL
   FROM
   PurchaseHeader
   WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND PurchaseNumber = v_PurchaseNumber;      
      
   IF @SWV_Error <> 0 then      


      SET v_ErrorMessage = 'Insert into PurchaseHeader failed';
      ROLLBACK;      

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
 0,
 now(), 
 0,
 NULL,
 NULL,
 DetailMemo1,
 DetailMemo2,
 DetailMemo3,
 DetailMemo4,
 DetailMemo5,
 NULL,
 NULL,
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


      SET v_ErrorMessage = 'Insert into PurchaseHeaderDetail failed';
      ROLLBACK;      

      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Purchase_CreateFromMemorized',
      v_ErrorMessage,v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseNumber',v_PurchaseNumber);
      SET SWP_Ret_Value = -1;
   end if;      
      
   SET v_NewPurchaseNumber = CONCAT('New Purchase Entry Created With Purchase Number:',v_NewPurchaseNumber);    
      
   COMMIT;      
   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;      
      






   ROLLBACK;      

   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Purchase_CreateFromMemorized',
   v_ErrorMessage,v_ErrorID);      
      
   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseNumber',v_PurchaseNumber);      
      
   SET SWP_Ret_Value = -1;
END