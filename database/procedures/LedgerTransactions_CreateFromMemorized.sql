CREATE PROCEDURE LedgerTransactions_CreateFromMemorized ( 
v_CompanyID NATIONAL VARCHAR(36),    
 v_DivisionID NATIONAL VARCHAR(36),    
 v_DepartmentID NATIONAL VARCHAR(36),    
 v_GLTransactionNumber NATIONAL VARCHAR(36), 
 INOUT v_NewGLTransactionNumber NATIONAL VARCHAR(72),INOUT SWP_Ret_Value INT) SWL_return:
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
   SET v_NextNumber = LEFT(v_NewGLTransactionNumber, 36);
   CALL GetNextEntityID2(v_CompanyID,v_DivisionID,v_DepartmentID,'NextGLTransNumber',v_NextNumber, v_ReturnStatus);    
   SET v_NewGLTransactionNumber = v_NextNumber;
   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then

      SET v_NewGLTransactionNumber = N'';
      SET v_ErrorMessage = 'GetNextEntityID call failed';
      ROLLBACK;    

      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'LedgerTransactions_CreateFromMemorized',
      v_ErrorMessage,v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'GLTransactionNumber',
      v_GLTransactionNumber);
      SET SWP_Ret_Value = -1;
   end if;    
    
    

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
  v_NewGLTransactionNumber, 
  GLTransactionTypeID,
  now(),
  now(),
  GLTransactionDescription,
  GLTransactionReference,
  CurrencyID,
  CurrencyExchangeRate,
  GLTransactionAmount,
  GLTransactionAmountUndistributed,
  GLTransactionBalance,
  0,
  GLTransactionSource,
  GLTransactionSystemGenerated,
  0,
  0,
  0,
  ApprovedBy,
  now(),
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
   LedgerTransactions
   WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND GLTransactionNumber = v_GLTransactionNumber;    
    
   IF @SWV_Error <> 0 then    


      SET v_ErrorMessage = 'Insert into LedgerTransaction failed';
      ROLLBACK;    

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
 
 GLTransactionAccount,
 CurrencyID,
 CurrencyExchangeRate,
 GLDebitAmount,
 GLCreditAmount,
 ProjectID,
 NULL,
 NULL -LockTS
   FROM
   LedgerTransactionsDetail
   WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND GLTransactionNumber = v_GLTransactionNumber;    
    
   IF @SWV_Error <> 0 then    


      SET v_ErrorMessage = 'Insert into LedgerTransactionDetail failed';
      ROLLBACK;    

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
    






   ROLLBACK;    

   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'LedgerTransactions_CreateFromMemorized',
   v_ErrorMessage,v_ErrorID);    
    
   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'GLTransactionNumber',
   v_GLTransactionNumber);    
    
   SET SWP_Ret_Value = -1;
END