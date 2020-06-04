CREATE PROCEDURE Bank_PostServiceFee (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_BankTransactionID  NATIONAL VARCHAR(36), 
	INOUT v_Result INT  ,INOUT SWP_Ret_Value INT) SWL_return:
BEGIN





















   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);

   DECLARE v_PostDate NATIONAL VARCHAR(1);
   DECLARE v_TranDate DATETIME;
   DECLARE v_PeriodToPost INT;
   DECLARE v_PeriodToClose INT;
   DECLARE v_GLCashAccount NATIONAL VARCHAR(25);
   DECLARE v_GLOffsetAccount NATIONAL VARCHAR(25);
   DECLARE v_Amount DECIMAL(19,4);
   DECLARE v_BeginningBalance BOOLEAN;
   DECLARE v_CurrencyID NATIONAL VARCHAR(3);
   DECLARE v_CompanyCurrencyID NATIONAL VARCHAR(3);
   DECLARE v_CurrencyExchangeRate FLOAT;
   DECLARE v_ConvertedAmount DECIMAL(19,4);
   DECLARE v_Posted BOOLEAN;
   DECLARE v_GLTransactionReference NATIONAL VARCHAR(36);
   DECLARE v_BankDocumentNumber NATIONAL VARCHAR(36);
   DECLARE v_GLTransactionDescription NATIONAL VARCHAR(200);
   DECLARE v_Success BOOLEAN;

   DECLARE v_ErrorID INT;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
   END;

   SET @SWV_Error = 0;
   SET v_Result = 1;



   select   GLBankAccount1, GLBankAccount2, IFNULL(TransactionAmount,0), BeginningBalance, CurrencyID, CurrencyExchangeRate, IFNULL(Reference,N''), IFNULL(BankDocumentNumber,N''), Posted INTO v_GLCashAccount,v_GLOffsetAccount,v_Amount,v_BeginningBalance,v_CurrencyID,
   v_CurrencyExchangeRate,v_GLTransactionReference,v_BankDocumentNumber,
   v_Posted FROM
   BankTransactions WHERE
   CompanyID = v_CompanyID
   AND DivisionID  = v_DivisionID
   AND  DepartmentID = v_DepartmentID
   AND BankTransactionID = v_BankTransactionID;

   SET v_GLCashAccount = IFNULL(v_GLCashAccount,(SELECT BankAccount
   FROM Companies
   WHERE CompanyID = v_CompanyID AND DivisionID  = v_DivisionID AND  DepartmentID = v_DepartmentID));

   SET v_GLOffsetAccount = IFNULL(v_GLOffsetAccount,(SELECT GLAPMiscAccount 
   FROM Companies
   WHERE CompanyID = v_CompanyID AND DivisionID  = v_DivisionID AND  DepartmentID = v_DepartmentID));


   IF v_Posted = 1 then

      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;
   end if;


   IF v_Amount = 0 then

      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;
   end if;


   select   IFNULL(DefaultGLPostingDate,'1') INTO v_PostDate FROM
   Companies WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID;


   IF v_PostDate = '1' then
      SET v_TranDate = CURRENT_TIMESTAMP;
   ELSE
      select   TransactionDate INTO v_TranDate FROM
      BankTransactions WHERE
      CompanyID = v_CompanyID
      AND DivisionID = v_DivisionID
      AND DepartmentID = v_DepartmentID
      AND BankTransactionID = v_BankTransactionID;
   end if;

   START TRANSACTION; 

   SET v_ReturnStatus = LedgerMain_VerifyPeriod(v_CompanyID,v_DivisionID,v_DepartmentID,v_TranDate,v_PeriodToPost,v_PeriodToClose);
   IF v_PeriodToClose <> 0 then 
	
	

      COMMIT;
      SET v_Result = 2;
      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;






   end if;



   IF v_ReturnStatus = -1 then

      SET v_ErrorMessage = 'Procedure call LedgerMain_VerifyPeriod failed';
      ROLLBACK;
      CALL Error_InsertError(v_CompanyID,v_DivisionID,DepartmentID,'Bank_PostServiceFee',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'BankTransactionID',
      v_BankTransactionID);
      SET SWP_Ret_Value = -1;
   end if;


   SET @SWV_Error = 0;
   CALL VerifyCurrency(v_CompanyID,v_DivisionID,v_DepartmentID,v_TranDate,0,v_CompanyCurrencyID,
   v_CurrencyID,v_CurrencyExchangeRate);
   IF @SWV_Error <> 0 then

	
      SET v_ErrorMessage = 'Currency retrieving failed';
      ROLLBACK;
      CALL Error_InsertError(v_CompanyID,v_DivisionID,DepartmentID,'Bank_PostServiceFee',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'BankTransactionID',
      v_BankTransactionID);
      SET SWP_Ret_Value = -1;
   end if;

   SET v_ConvertedAmount = fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,v_Amount*v_CurrencyExchangeRate, 
   v_CompanyCurrencyID);


   SET v_GLTransactionDescription = CASE v_GLTransactionReference WHEN N'' THEN CONCAT(N'SRF  ',v_BankDocumentNumber) ELSE v_GLTransactionReference END;
   SET v_BankDocumentNumber = CONCAT(N'SRF ',v_BankDocumentNumber);


 
	 
	 
	 
	 
   SET @SWV_Error = 0;
   SET v_ReturnStatus = Bank_CreateGLTransaction2(v_CompanyID,v_DivisionID,v_DepartmentID,N'Service Fee',v_TranDate,v_GLTransactionDescription,
   v_GLTransactionReference,v_BankDocumentNumber,v_ConvertedAmount,
   v_GLOffsetAccount,v_GLCashAccount,1,v_CurrencyID,v_CurrencyExchangeRate);

   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then

      SET v_ErrorMessage = 'Unable to post Bank Service Fee to LedgerTransactions';
      ROLLBACK;
      CALL Error_InsertError(v_CompanyID,v_DivisionID,DepartmentID,'Bank_PostServiceFee',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'BankTransactionID',
      v_BankTransactionID);
      SET SWP_Ret_Value = -1;
   end if;



   SET @SWV_Error = 0;
   UPDATE
   BankTransactions
   SET
   Posted = 1
   WHERE
   CompanyID = v_CompanyID
   AND DivisionID  = v_DivisionID
   AND  DepartmentID = v_DepartmentID
   AND BankTransactionID = v_BankTransactionID;
   IF @SWV_Error <> 0 then

      SET v_Result = 0;
      SET v_ErrorMessage = 'BankTransactions update failed';
      ROLLBACK;
      CALL Error_InsertError(v_CompanyID,v_DivisionID,DepartmentID,'Bank_PostServiceFee',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'BankTransactionID',
      v_BankTransactionID);
      SET SWP_Ret_Value = -1;
   end if;


   COMMIT;
   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;



   COMMIT;
   SET v_Result = 2;

   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;






   ROLLBACK;

   CALL Error_InsertError(v_CompanyID,v_DivisionID,DepartmentID,'Bank_PostServiceFee',v_ErrorMessage,
   v_ErrorID);

   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'BankTransactionID',
   v_BankTransactionID);
   SET SWP_Ret_Value = -1;
END