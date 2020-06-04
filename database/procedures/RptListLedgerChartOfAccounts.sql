CREATE PROCEDURE RptListLedgerChartOfAccounts (v_CompanyID NATIONAL VARCHAR(36), 
 v_DivisionID NATIONAL VARCHAR(36), 
 v_DepartmentID NATIONAL VARCHAR(36)) BEGIN














   SELECT
	
	
	
   GLAccountNumber,
	GLAccountName,
	GLAccountDescription,
	GLAccountUse,
	GLAccountType,
	GLBalanceType,
	GLReportingAccount,
	GLReportLevel,
	CurrencyID, 
	
	fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,GLAccountBalance,CurrencyID) AS GLAccountBalance
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
   FROM LedgerChartOfAccounts
   WHERE CompanyID = v_CompanyID and DivisionID = v_DivisionID and DepartmentID = v_DepartmentID;
END