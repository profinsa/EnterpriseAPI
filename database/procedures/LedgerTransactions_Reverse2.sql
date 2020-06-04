CREATE PROCEDURE LedgerTransactions_Reverse2 (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_GLTransactionNumber NATIONAL VARCHAR(36),INOUT SWP_Ret_Value INT) SWL_return:
BEGIN








   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);
   DECLARE v_GLTransactionNumberNew NATIONAL VARCHAR(36);
   DECLARE v_Reversal BOOLEAN;

   DECLARE v_ErrorID INT;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
   END; 
   select   IFNULL(Reversal,0) INTO v_Reversal FROM
   LedgerTransactions WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND GLTransactionNumber = v_GLTransactionNumber;

   IF v_Reversal = 1 then

      CALL SWP_RaiseError(20000,'Transaction is reversed already');
      SET SWP_Ret_Value = 1;
      LEAVE SWL_return;
   end if;

   START TRANSACTION;


   SET v_ReturnStatus = GetNextEntityID(v_CompanyID,v_DivisionID,v_DepartmentID,'NextGLTransNumber',v_GLTransactionNumberNew);
   IF v_ReturnStatus = -1 then


      SET v_ErrorMessage = 'GetNextEntityID call failed';
      ROLLBACK;
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'LedgerTransactions_Reverse',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'GLTransactionNumber',
      v_GLTransactionNumber);
      SET SWP_Ret_Value = -1;
   end if;

   IF v_GLTransactionNumber IS NULL then


      SET v_ErrorMessage = 'Invalid transaction number';
      ROLLBACK;
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'LedgerTransactions_Reverse',v_ErrorMessage,
      v_ErrorID);
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
	Reversal)
   SELECT
   v_CompanyID,
		v_DivisionID,
		v_DepartmentID,
		v_GLTransactionNumberNew,
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
		1
   FROM
   LedgerTransactions
   WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND GLTransactionNumber = v_GLTransactionNumber;
   IF @SWV_Error <> 0 then


      SET v_ErrorMessage = 'Insert into LedgerTransactions failed';
      ROLLBACK;
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'LedgerTransactions_Reverse',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'GLTransactionNumber',
      v_GLTransactionNumber);
      SET SWP_Ret_Value = -1;
   end if;



   SET @SWV_Error = 0;
   INSERT INTO LedgerTransactionsDetail(CompanyID,
	DivisionID,
	DepartmentID,
	GLTransactionNumber,
	GLTransactionAccount,
	GLDebitAmount,
	GLCreditAmount,
	ProjectID)
   SELECT
   v_CompanyID,
		v_DivisionID,
		v_DepartmentID,
		v_GLTransactionNumberNew,
		GLTransactionAccount,
		IFNULL(GLCreditAmount,0),
		IFNULL(GLDebitAmount,0),
		ProjectID
   FROM
   LedgerTransactionsDetail
   WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND GLTransactionNumber = v_GLTransactionNumber;

   IF @SWV_Error <> 0 then


      SET v_ErrorMessage = 'Insert into LedgerTransactionsDetail failed';
      ROLLBACK;
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'LedgerTransactions_Reverse',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'GLTransactionNumber',
      v_GLTransactionNumber);
      SET SWP_Ret_Value = -1;
   end if;
   UPDATE LedgerTransactions
   SET Reversal = 1
   WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND GLTransactionNumber = v_GLTransactionNumber;

   COMMIT;

   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;








   ROLLBACK;
   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'LedgerTransactions_Reverse',v_ErrorMessage,
   v_ErrorID);

   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'GLTransactionNumber',
   v_GLTransactionNumber);

   SET SWP_Ret_Value = -1;
END