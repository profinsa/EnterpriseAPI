CREATE PROCEDURE LedgerChartOfAccounts_OpenDb (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),INOUT SWP_Ret_Value INT) BEGIN















   SELECT
   GLAccountNumber, GLAccountName, GLAccountBalance, GLBalanceType
   FROM
   LedgerChartOfAccounts
   WHERE
   CompanyID = v_CompanyID and
   DivisionID = v_DivisionID and
   DepartmentID = v_DepartmentID;

   SET SWP_Ret_Value = 0;
END