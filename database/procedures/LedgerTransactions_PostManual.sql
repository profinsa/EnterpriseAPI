CREATE PROCEDURE LedgerTransactions_PostManual (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_GLTransactionNumber NATIONAL VARCHAR(36),
	INOUT v_PostingResult NATIONAL VARCHAR(200) ,
	INOUT v_DisbalanceAmount DECIMAL(19,4) ,
	INOUT v_IsValid INT ,INOUT SWP_Ret_Value INT) SWL_return:
BEGIN










   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);

   DECLARE v_GLTransactionAccount NATIONAL VARCHAR(36);
   DECLARE v_GLDebitAmount DECIMAL(19,4);
   DECLARE v_GLCreditAmount DECIMAL(19,4);
   DECLARE v_TransactionDate DATETIME;
   DECLARE v_Posted BOOLEAN;
   DECLARE v_PostCOA BOOLEAN;
   DECLARE v_Amount DECIMAL(19,4);
   DECLARE v_CompanyCurrencyID NATIONAL VARCHAR(3);


   DECLARE v_ErrorID INT;
   DECLARE NO_DATA INT DEFAULT 0;
   DECLARE cLedgerTransaction CURSOR FOR
   SELECT 
   GLTransactionAccount, IFNULL(GLDebitAmount,0), IFNULL(GLCreditAmount,0)
   FROM LedgerTransactionsDetail
   WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND GLTransactionNumber = v_GLTransactionNumber;


   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
      SET NO_DATA = -2;
   END;
   DECLARE CONTINUE HANDLER FOR NOT FOUND SET NO_DATA = -1;
   select   IFNULL(CurrencyID,N'') INTO v_CompanyCurrencyID FROM Companies WHERE CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID   LIMIT 1;

   SET @SWV_Error = 0;
   CALL LedgerTransactions_VerifyTransaction2(v_CompanyID,v_DivisionID,v_DepartmentID,v_GLTransactionNumber,v_PostingResult,
   v_DisbalanceAmount,v_IsValid, v_ReturnStatus);	
   IF v_ReturnStatus <> 0 OR @SWV_Error <> 0 then

      SET SWP_Ret_Value = -1;
      LEAVE SWL_return;
   end if;

   START TRANSACTION;

   SET v_Amount = 0;

   SET v_PostCOA = 1;


   select   GLTransactionDate INTO v_TransactionDate FROM
   LedgerTransactions WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND GLTransactionNumber = v_GLTransactionNumber;

   OPEN cLedgerTransaction;


   SET NO_DATA = 0;
   FETCH cLedgerTransaction
   INTO v_GLTransactionAccount,v_GLDebitAmount,v_GLCreditAmount;


   WHILE NO_DATA = 0 DO
      SET v_ReturnStatus = LedgerMain_PostCOA2(v_CompanyID,v_DivisionID,v_DepartmentID,v_GLTransactionAccount,v_TransactionDate,
      v_GLDebitAmount,v_GLCreditAmount,v_PostCOA);	
	
	
      IF  v_PostCOA = 0 OR v_ReturnStatus = -1 then
	
         CLOSE cLedgerTransaction;
		
         SET v_PostingResult = 'Can't post transaction. LedgerChartOfAccounts update is failed';
         SET v_ErrorMessage = 'LedgerMain_PostCOA call failed';
         SET v_IsValid = -7;
         ROLLBACK;


         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'LedgerTransactions_PostManual',
         v_ErrorMessage,v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'GLTransactionNumber',
         v_GLTransactionNumber);
         SET SWP_Ret_Value = -1;
      end if;
      Set v_Amount = v_Amount+v_GLDebitAmount;
      SET NO_DATA = 0;
      FETCH cLedgerTransaction
      INTO v_GLTransactionAccount,v_GLDebitAmount,v_GLCreditAmount;
   END WHILE;

   CLOSE cLedgerTransaction;


   Update
   LedgerTransactionsDetail
   SET
   GLDebitAmount = 0
   WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND GLTransactionNumber = v_GLTransactionNumber
   AND GLDebitAmount IS NULL;

   Update
   LedgerTransactionsDetail
   SET
   GLCreditAmount = 0
   WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND GLTransactionNumber = v_GLTransactionNumber
   AND GLCreditAmount IS NULL;





   SET @SWV_Error = 0;
   UPDATE
   LedgerTransactions
   SET
   GLTransactionAmount = v_Amount,GLTransactionBalance = 0,GLTransactionPostedYN = 1,
   GLTransactionSystemGenerated = 0,CurrencyID = v_CompanyCurrencyID,
   CurrencyExchangeRate = 1
   WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND GLTransactionNumber = v_GLTransactionNumber;

   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Update LedgerTransactions failed';
      ROLLBACK;


      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'LedgerTransactions_PostManual',
      v_ErrorMessage,v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'GLTransactionNumber',
      v_GLTransactionNumber);
      SET SWP_Ret_Value = -1;
   end if;

   COMMIT;
   SET v_IsValid = 1;
   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;








   ROLLBACK;


   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'LedgerTransactions_PostManual',
   v_ErrorMessage,v_ErrorID);

   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'GLTransactionNumber',
   v_GLTransactionNumber);

   SET SWP_Ret_Value = -1;
END