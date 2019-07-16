CREATE PROCEDURE ServiceInvoice_CreateFromMemorized (v_CompanyID  NATIONAL VARCHAR(36),      
 v_DivisionID  NATIONAL VARCHAR(36),      
 v_DepartmentID NATIONAL VARCHAR(36),      
 v_InvoiceNumber  NATIONAL VARCHAR(36),      
 INOUT v_NewInvoiceNumber  NATIONAL VARCHAR(72)  ,INOUT SWP_Ret_Value INT) SWL_return:
BEGIN
      
      
 



   DECLARE v_ReturnStatus SMALLINT;      
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);      
      
   DECLARE v_ErrorID INT;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
   END;
   SET @SWV_Error = 0;
   START TRANSACTION;      
      

   SET @SWV_Error = 0;
   SET v_ReturnStatus = GetNextEntityID(v_CompanyID,v_DivisionID,v_DepartmentID,'NextInvoiceNumber',v_NewInvoiceNumber);      
   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then

      SET v_NewInvoiceNumber = N'';
      SET v_ErrorMessage = 'GetNextEntityID call failed';
      ROLLBACK;
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'ServiceInvoice_CreateFromMemorized',
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
 v_NewInvoiceNumber, 
 OrderNumber,
 TransactionTypeID,
 TransOpen,
 CURRENT_TIMESTAMP, 
 InvoiceDueDate,
 InvoiceShipDate,
 InvoiceCancelDate,
 CURRENT_TIMESTAMP, 
 0, 
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
 0, 
 '1 / 1 / 1980', 
 0, 
 '1 / 1 / 1980', 
 0, 
 '1 / 1 / 1980', 
 TrackingNumber,
 0, 
 '1 / 1 / 1980', 
 0, 
 0, 
 '1 / 1 / 1980', 
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
      SET v_ErrorMessage = 'Cannot create Order Header';
      ROLLBACK;
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'ServiceInvoice_CreateFromMemorized',
      v_ErrorMessage,v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
      SET SWP_Ret_Value = -1;
   end if;      
      

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
 v_NewInvoiceNumber, 
 
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
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'ServiceInvoice_CreateFromMemorized',
      v_ErrorMessage,v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
      SET SWP_Ret_Value = -1;
   end if;      
      
   SET v_NewInvoiceNumber = CONCAT('New Service Invoice Created With Service Invoice Number:',v_NewInvoiceNumber);      
      
   COMMIT;      
   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;      
      






   ROLLBACK;      
      
   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'ServiceInvoice_CreateFromMemorized',
   v_ErrorMessage,v_ErrorID);      
   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);      
      
   SET SWP_Ret_Value = -1;
END