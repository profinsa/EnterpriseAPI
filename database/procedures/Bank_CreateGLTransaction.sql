CREATE PROCEDURE Bank_CreateGLTransaction (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_GLTransactionTypeID NATIONAL VARCHAR(36), 
	v_GLTransactionDate DATETIME, 
	v_GLTransactionDescription NATIONAL VARCHAR(50), 
	v_GLTransactionReference NATIONAL VARCHAR(50),
	v_GLTransactionSource NATIONAL VARCHAR(50), 
	v_GLTransactionAmount DECIMAL(19,4),
	v_GLDebitAccount NATIONAL VARCHAR(36),
	v_GLCreditAccount NATIONAL VARCHAR(36),
	v_SystemGenerated BOOLEAN,
	v_CurrencyID NATIONAL VARCHAR(3),
	v_CurrencyExchangeRate FLOAT,INOUT SWP_Ret_Value INT) SWL_return:
BEGIN














   DECLARE v_PostCOA INT;
   DECLARE v_GLTransactionNumber NATIONAL VARCHAR(36);
   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);
   DECLARE v_ErrorID INT;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
   END;


   SET @SWV_Error = 0;
   IF v_GLTransactionAmount = 0 then

      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;
   end if;

   START TRANSACTION;


   SET @SWV_Error = 0;
   SET v_ReturnStatus = GetNextEntityID(v_CompanyID,v_DivisionID,v_DepartmentID,'NextGLTransNumber',v_GLTransactionNumber);
   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then

      SET v_ErrorMessage = 'GetNextEntityID call failed';
      ROLLBACK;


      IF v_ErrorMessage <> '' then

	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,DepartmentID,'GeneralLLedger_PostPayment',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,v_GLTransactionDescription,
         v_GLTransactionNumber);
      end if;
      SET SWP_Ret_Value = -1;
   end if;

   SET @SWV_Error = 0;
   INSERT INTO LedgerTransactions(CompanyID,
	DivisionID,
	DepartmentID,
	GLTransactionNumber,
	GLTransactionTypeID,
	GLTransactionDate,
	GLTransactionDescription,
	GLTransactionReference,
	GLTransactionSource,
	GLTransactionAmount,
	GLTransactionPostedYN,
	GLTransactionBalance,
	GLTransactionSystemGenerated,
	CurrencyID,
	CurrencyExchangeRate)
VALUES(v_CompanyID,
	v_DivisionID,
	v_DepartmentID,
	v_GLTransactionNumber,
	v_GLTransactionTypeID,
	v_GLTransactionDate,
	v_GLTransactionDescription,
	v_GLTransactionReference,
	v_GLTransactionSource,
	v_GLTransactionAmount,
	1,
	0,
	v_SystemGenerated,
	v_CurrencyID,
	v_CurrencyExchangeRate);



   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'LedgerTransactions insert failed';
      ROLLBACK;


      IF v_ErrorMessage <> '' then

	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,DepartmentID,'GeneralLLedger_PostPayment',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,v_GLTransactionDescription,
         v_GLTransactionNumber);
      end if;
      SET SWP_Ret_Value = -1;
   end if;


   SET @SWV_Error = 0;
   INSERT INTO LedgerTransactionsDetail(CompanyID,
	DivisionID,
	DepartmentID,
	GLTransactionNumber,
	GLTransactionAccount,
	GLDebitAmount,
	GLCreditAmount)
VALUES(v_CompanyID,
	v_DivisionID,
	v_DepartmentID,
	v_GLTransactionNumber,
	v_GLDebitAccount,
	v_GLTransactionAmount,
	0);


   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'LedgerTransactionsDetail insert failed';
      ROLLBACK;


      IF v_ErrorMessage <> '' then

	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,DepartmentID,'GeneralLLedger_PostPayment',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,v_GLTransactionDescription,
         v_GLTransactionNumber);
      end if;
      SET SWP_Ret_Value = -1;
   end if;



   SET @SWV_Error = 0;
   INSERT INTO LedgerTransactionsDetail(CompanyID,
	DivisionID,
	DepartmentID,
	GLTransactionNumber,
	GLTransactionAccount,
	GLDebitAmount,
	GLCreditAmount)
VALUES(v_CompanyID,
	v_DivisionID,
	v_DepartmentID,
	v_GLTransactionNumber,
	v_GLCreditAccount,
	0,
	v_GLTransactionAmount);



   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'LedgerTransactionDetail insert failed';
      ROLLBACK;


      IF v_ErrorMessage <> '' then

	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,DepartmentID,'GeneralLLedger_PostPayment',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,v_GLTransactionDescription,
         v_GLTransactionNumber);
      end if;
      SET SWP_Ret_Value = -1;
   end if;


   SET @SWV_Error = 0;
   SET v_ReturnStatus = LedgerTransactions_PostCOA_AllRecords(v_CompanyID,v_DivisionID,v_DepartmentID,v_GLTransactionNumber);
   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then

      SET v_ErrorMessage = 'LedgerTransactions_PostCOA_AllRecords call failed';
      ROLLBACK;


      IF v_ErrorMessage <> '' then

	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,DepartmentID,'GeneralLLedger_PostPayment',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,v_GLTransactionDescription,
         v_GLTransactionNumber);
      end if;
      SET SWP_Ret_Value = -1;
   end if;

   COMMIT;

   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;








   ROLLBACK;


   IF v_ErrorMessage <> '' then

	
      CALL Error_InsertError(v_CompanyID,v_DivisionID,DepartmentID,'GeneralLLedger_PostPayment',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,v_GLTransactionDescription,
      v_GLTransactionNumber);
   end if;
   SET SWP_Ret_Value = -1;
END