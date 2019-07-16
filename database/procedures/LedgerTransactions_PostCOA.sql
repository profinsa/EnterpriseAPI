CREATE PROCEDURE LedgerTransactions_PostCOA (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_GLAccountNumber NATIONAL VARCHAR(36),
	v_TranDate DATETIME,
	v_DebitAmount DECIMAL(19,4),
	v_CreditAmount DECIMAL(19,4),
	v_GLTransactionNumber NATIONAL VARCHAR(36),
	v_GLTransactionTypeID NATIONAL VARCHAR(15),
	v_GLTransactionPostedYN BOOLEAN,
	v_GLTransactionSource NATIONAL VARCHAR(50),INOUT SWP_Ret_Value INT) SWL_return:
BEGIN







   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);

   DECLARE v_PostCOA BOOLEAN;

   DECLARE v_ErrorID INT;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
   END;
   SET @SWV_Error = 0;
   START TRANSACTION;

   SET @SWV_Error = 0;
   SET v_ReturnStatus = LedgerMain_PostCOA2(v_CompanyID,v_DivisionID,v_DepartmentID,v_GLAccountNumber,v_TranDate,v_DebitAmount,
   v_CreditAmount,v_PostCOA);

   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then

      SET v_ErrorMessage = 'LedgerMain_PostCOA call failed';
      ROLLBACK;
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'LedgerTransactions_PostCOA',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'GLAccountNumber',v_GLAccountNumber);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'TranDate',v_TranDate);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'DebitAmount',v_DebitAmount);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'CreditAmount',v_CreditAmount);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'GLTransactionNumber',
      v_GLTransactionNumber);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'GLTransactionTypeID',
      v_GLTransactionTypeID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'GLTransactionSource',
      v_GLTransactionSource);
      SET SWP_Ret_Value = -1;
   end if;	

   SET @SWV_Error = 0;
   UPDATE
   LedgerTransactions
   SET
   GLTransactionTypeID = v_GLTransactionTypeID,GLTransactionPostedYN = v_GLTransactionPostedYN,
   GLTransactionSource = v_GLTransactionSource
   WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND GLTransactionNumber = v_GLTransactionNumber;
   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Update LedgerTransactions failed';
      ROLLBACK;
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'LedgerTransactions_PostCOA',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'GLAccountNumber',v_GLAccountNumber);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'TranDate',v_TranDate);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'DebitAmount',v_DebitAmount);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'CreditAmount',v_CreditAmount);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'GLTransactionNumber',
      v_GLTransactionNumber);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'GLTransactionTypeID',
      v_GLTransactionTypeID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'GLTransactionSource',
      v_GLTransactionSource);
      SET SWP_Ret_Value = -1;
   end if;

   COMMIT;
   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;








   ROLLBACK;
   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'LedgerTransactions_PostCOA',v_ErrorMessage,
   v_ErrorID);

   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'GLAccountNumber',v_GLAccountNumber);
   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'TranDate',v_TranDate);
   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'DebitAmount',v_DebitAmount);
   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'CreditAmount',v_CreditAmount);
   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'GLTransactionNumber',
   v_GLTransactionNumber);
   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'GLTransactionTypeID',
   v_GLTransactionTypeID);
   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'GLTransactionSource',
   v_GLTransactionSource);


   SET SWP_Ret_Value = -1;
END