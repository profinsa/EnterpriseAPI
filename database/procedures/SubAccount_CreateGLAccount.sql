CREATE PROCEDURE SubAccount_CreateGLAccount (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_SubAccountCode NATIONAL VARCHAR(36),
	v_AccountCode NATIONAL VARCHAR(36),INOUT SWP_Ret_Value INT) SWL_return:
BEGIN






   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);
   DECLARE v_ErrorID INT;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
   END;
   SET @SWV_Error = 0;
   START TRANSACTION;


   SET @SWV_Error = 0;
   INSERT INTO
   LedgerChartOfAccounts(CompanyID,
	DivisionID,
	DepartmentID,
	GLAccountNumber,
	GLAccountCode,
	GLSubAccountCode,
	GLAccountName,
	GLAccountUse,
	GLAccountType,
	GLBalanceType,
	GLReportingAccount,
	GLReportLevel,
	CurrencyID,
	CurrencyExchangeRate,
	GLAccountDescription)
   SELECT
   v_CompanyID,
	v_DivisionID,
	v_DepartmentID,
	CONCAT(v_AccountCode,'-',v_SubAccountCode),
	v_AccountCode,
	v_SubAccountCode,
	LedgerChartOfAccounts.GLAccountName,
	LedgerChartOfAccounts.GLAccountUse,
	LedgerChartOfAccounts.GLAccountType,
	LedgerChartOfAccounts.GLBalanceType,
	LedgerChartOfAccounts.GLReportingAccount,
	LedgerChartOfAccounts.GLReportLevel,
	LedgerChartOfAccounts.CurrencyID,
	LedgerChartOfAccounts.CurrencyExchangeRate,
	SubAccount.SubAccountDescription
   FROM LedgerChartOfAccounts
   INNER JOIN SubAccount ON
   LedgerChartOfAccounts.CompanyID = SubAccount.CompanyID AND
   LedgerChartOfAccounts.DivisionID = SubAccount.DivisionID AND
   LedgerChartOfAccounts.DepartmentID = SubAccount.DepartmentID AND
   LedgerChartOfAccounts.GLAccountNumber = SubAccount.AccountCode AND
   SubAccount.SubAccountCode = v_SubAccountCode
   WHERE
   LedgerChartOfAccounts.CompanyID = v_CompanyID AND
   LedgerChartOfAccounts.DivisionID = v_DivisionID AND
   LedgerChartOfAccounts.DepartmentID = v_DepartmentID AND
   LedgerChartOfAccounts.GLAccountNumber = v_AccountCode;
	




   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'update LedgerChartOfAccounts failed';
      ROLLBACK;

      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'SubAccount_CreateGLAccount',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'SubAccountCode',v_SubAccountCode);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'AccountCode',v_AccountCode);
      SET SWP_Ret_Value = -1;
   end if;


   COMMIT;
   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;








   ROLLBACK;

   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'SubAccount_CreateGLAccount',v_ErrorMessage,
   v_ErrorID);

   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'SubAccountCode',v_SubAccountCode);
   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'AccountCode',v_AccountCode);

   SET SWP_Ret_Value = -1;
END