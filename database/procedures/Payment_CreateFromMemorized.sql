CREATE PROCEDURE Payment_CreateFromMemorized (v_CompanyID NATIONAL VARCHAR(36),    
 v_DivisionID NATIONAL VARCHAR(36),    
 v_DepartmentID NATIONAL VARCHAR(36),    
 v_PaymentID NATIONAL VARCHAR(36), 
 INOUT v_NewPaymentID NATIONAL VARCHAR(72),INOUT SWP_Ret_Value INT) SWL_return:
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
   SET v_ReturnStatus = GetNextEntityID(v_CompanyID,v_DivisionID,v_DepartmentID,'NextVoucherNumber',v_NewPaymentID);    
   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then

      SET v_NewPaymentID = N'';
      SET v_ErrorMessage = 'GetNextEntityID call failed';
      ROLLBACK;    

      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payment_CreateFromMemorized',
      v_ErrorMessage,v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PaymentID',v_PaymentID);
      SET SWP_Ret_Value = -1;
   end if;    
    
    

   SET @SWV_Error = 0;
   INSERT INTO PaymentsHeader(CompanyID,
 DivisionID,
 DepartmentID,
 PaymentID,
 PaymentTypeID,
 CheckNumber,
 CheckPrinted,
 CheckDate,
 Paid,
 PaymentDate,
 Memorize,
 PaymentClassID,
 VendorID,
 SystemDate,
 DueToDate,
 PurchaseDate,
 Amount,
 UnAppliedAmount,
 GLBankAccount,
 PaymentStatus,
 Void,
 Notes,
 CurrencyID,
 CurrencyExchangeRate,
 CreditAmount,
 SelectedForPayment,
 SelectedForPaymentDate,
 ApprovedForPayment,
 ApprovedForPaymentDate,
 Cleared,
 InvoiceNumber,
 Posted,
 Reconciled,
 Credit,
 ApprovedBy,
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
  v_NewPaymentID,
  PaymentTypeID,
  NULL,
  0,
  NULL, 
  0,
  CURRENT_TIMESTAMP, 
  0,
  PaymentClassID,
  VendorID,
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP, 
  CURRENT_TIMESTAMP, 
  Amount,
  UnAppliedAmount,
  GLBankAccount,
  PaymentStatus,
  0,
  Notes,
  CurrencyID,
  CurrencyExchangeRate,
  CreditAmount,
  0, 
  NULL,
  0, 
  NULL, 
  0,
  InvoiceNumber,
  0,
  0,
  Credit,
  ApprovedBy,
  EnteredBy,
  BatchControlNumber,
  BatchControlTotal,
  Signature,
  SignaturePassword,
  SupervisorSignature,
  SupervisorPassword,
  ManagerSignature,
  ManagerPassword,
  NULL,
  NULL
   FROM
   PaymentsHeader
   WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID    AND PaymentID = v_PaymentID;    
    
   IF @SWV_Error <> 0 then    


      SET v_ErrorMessage = 'Insert into PaymentsHeader failed';
      ROLLBACK;    

      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payment_CreateFromMemorized',
      v_ErrorMessage,v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PaymentID',v_PaymentID);
      SET SWP_Ret_Value = -1;
   end if;    
    
    
   SET @SWV_Error = 0;
   INSERT INTO
   PaymentsDetail(CompanyID,
 DivisionID,
 DepartmentID,
 PaymentID,     
 
 PayedID,
 DocumentNumber,
 DocumentDate,
 CurrencyID,
 CurrencyExchangeRate,
 DiscountTaken,
 WriteOffAmount,
 AppliedAmount,
 Cleared,
 GLExpenseAccount,
 ProjectID,
 LockedBy,
 LockTS)
   SELECT
   CompanyID,
 DivisionID,
 DepartmentID,
 v_NewPaymentID,     
 
 PayedID,
 DocumentNumber,
 CURRENT_TIMESTAMP, 
 CurrencyID,
 CurrencyExchangeRate,
 DiscountTaken,
 WriteOffAmount,
 AppliedAmount,
 0,
 GLExpenseAccount,
 ProjectID,
 NULL,
 NULL
   FROM
   PaymentsDetail
   WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND PaymentID = v_PaymentID;    
    
    
   IF @SWV_Error <> 0 then    


      SET v_ErrorMessage = 'Insert into PaymentsHeaderDetail failed';
      ROLLBACK;    

      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payment_CreateFromMemorized',
      v_ErrorMessage,v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PaymentID',v_PaymentID);
      SET SWP_Ret_Value = -1;
   end if;    
    
   SET v_NewPaymentID = CONCAT('New Payment Entry Created With Payment ID:',v_NewPaymentID);    
    
   COMMIT;    
   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;    
    






   ROLLBACK;    

   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payment_CreateFromMemorized',
   v_ErrorMessage,v_ErrorID);    
    
   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PaymentID',v_PaymentID);    
    
   SET SWP_Ret_Value = -1;
END