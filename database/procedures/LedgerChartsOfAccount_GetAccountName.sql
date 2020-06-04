CREATE PROCEDURE LedgerChartsOfAccount_GetAccountName (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36)) BEGIN
   SELECT
   DISTINCT GLAccountNumber,
		GLAccountName
   FROM
   LedgerChartOfAccounts
   WHERE
   CompanyID = v_CompanyID
   AND
   DivisionID = v_DivisionID
   AND
   DepartmentID = v_DepartmentID;		
END