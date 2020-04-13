CREATE PROCEDURE Receipt_CreateFromMemorized (v_CompanyID  NATIONAL VARCHAR(36),      
 v_DivisionID  NATIONAL VARCHAR(36),      
 v_DepartmentID NATIONAL VARCHAR(36),      
 v_ReceiptID  NATIONAL VARCHAR(36),      
 INOUT v_NewReceiptID  NATIONAL VARCHAR(72)  ,INOUT SWP_Ret_Value INT) SWL_return:
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
   SET v_ReturnStatus = GetNextEntityID(v_CompanyID,v_DivisionID,v_DepartmentID,'NextReceiptNumber',v_NewReceiptID);      
   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then

      SET v_NewReceiptID = N'';
      SET v_ErrorMessage = 'GetNextEntityID call failed';
      ROLLBACK;
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Receipt_CreateFromMemorized',
      v_ErrorMessage,v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'ReceiptID',v_ReceiptID);
      SET SWP_Ret_Value = -1;
   end if;      
      
   SET @SWV_Error = 0;
   INSERT INTO ReceiptsHeader(CompanyID,
 DivisionID,
 DepartmentID,
 ReceiptID,
 ReceiptTypeID,
 ReceiptClassID,
 CheckNumber,
 CustomerID,
 Memorize,
 TransactionDate,
 SystemDate,
 DueToDate,
 OrderDate,
 CurrencyID,
 CurrencyExchangeRate,
 Amount,
 UnAppliedAmount,
 GLBankAccount,
 Status,
 NSF,
 Notes,
 CreditAmount,
 Cleared,
 Posted,
 Reconciled,
 Deposited,
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
 BatchControlNumber,
 BatchControlTotal,
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
 v_NewReceiptID, 
 ReceiptTypeID,
 ReceiptClassID,
 CheckNumber,
 CustomerID,
 0, 
 CURRENT_TIMESTAMP, 
 CURRENT_TIMESTAMP, 
 NULL, 
 NULL, 
 CurrencyID,
 CurrencyExchangeRate,
 Amount,
 UnAppliedAmount,
 GLBankAccount,
 Status,
 NSF,
 Notes,
 CreditAmount,
 Cleared,
 Posted,
 Reconciled,
 Deposited,
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
 BatchControlNumber,
 BatchControlTotal,
 Signature,
 SignaturePassword,
 SupervisorSignature,
 SupervisorPassword,
 ManagerSignature,
 ManagerPassword
   FROM         ReceiptsHeader   WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND ReceiptID = v_ReceiptID;      
      
   IF @SWV_Error <> 0 then

      SET v_NewReceiptID = N'';
      SET v_ErrorMessage = 'Cannot create Receipt Header';
      ROLLBACK;
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Receipt_CreateFromMemorized',
      v_ErrorMessage,v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'ReceiptID',v_ReceiptID);
      SET SWP_Ret_Value = -1;
   end if;      
      

   SET @SWV_Error = 0;
   INSERT INTO ReceiptsDetail(CompanyID,
 DivisionID,
 DepartmentID,
 ReceiptID,      
 
 DocumentNumber,
 DocumentDate,
 PaymentID,
 PayedID,
 CurrencyID,
 CurrencyExchangeRate,
 DiscountTaken,
 WriteOffAmount,
 AppliedAmount,
 Cleared,
 ProjectID,
 DetailMemo1,
 DetailMemo2,
 DetailMemo3,
 DetailMemo4,
 DetailMemo5)
   SELECT
   CompanyID,
 DivisionID,
 DepartmentID,
 v_NewReceiptID, 
 
 DocumentNumber,
 DocumentDate,
 PaymentID,
 PayedID,
 CurrencyID,
 CurrencyExchangeRate,
 DiscountTaken,
 WriteOffAmount,
 AppliedAmount,
 Cleared,
 ProjectID,
 DetailMemo1,
 DetailMemo2,
 DetailMemo3,
 DetailMemo4,
 DetailMemo5
   FROM         ReceiptsDetail WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND ReceiptID = v_ReceiptID;      
      
   IF @SWV_Error <> 0 then

      SET v_NewReceiptID = N'';
      SET v_ErrorMessage = 'Cannot create Receipt Details';
      ROLLBACK;
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Receipt_CreateFromMemorized',
      v_ErrorMessage,v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'ReceiptID',v_ReceiptID);
      SET SWP_Ret_Value = -1;
   end if;      
     
   SET v_NewReceiptID = CONCAT('New Receipt Created With Receipt ID:',v_NewReceiptID);      
     
   COMMIT;      
   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;      
      






   ROLLBACK;      
      
   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Receipt_CreateFromMemorized',
   v_ErrorMessage,v_ErrorID);      
   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'ReceiptID',v_ReceiptID);      
      
   SET SWP_Ret_Value = -1;
END