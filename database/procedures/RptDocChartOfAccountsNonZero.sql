CREATE PROCEDURE RptDocChartOfAccountsNonZero (v_CompanyID NATIONAL VARCHAR(36), 
 v_DivisionID NATIONAL VARCHAR(36), 
 v_DepartmentID NATIONAL VARCHAR(36)) BEGIN







   SELECT
   GLAccountNumber as AccountNumber,
	GLAccountName as AccountName,
	GLAccountType as AccountType,
	GLBalanceType as BalanceType,
	fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,GLAccountBalance,N'') as Balance
   FROM LedgerChartOfAccounts
   WHERE CompanyID = v_CompanyID and
   DivisionID = v_DivisionID and
   DepartmentID = v_DepartmentID and
   GLAccountBalance <> 0
   ORDER BY GLAccountNumber ASC;
END