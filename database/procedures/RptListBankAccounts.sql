CREATE PROCEDURE RptListBankAccounts (v_CompanyID NATIONAL VARCHAR(36), 
 v_DivisionID NATIONAL VARCHAR(36), 
 v_DepartmentID NATIONAL VARCHAR(36)) BEGIN








   SELECT DISTINCT
   BankAccounts.BankID as BankID,
	BankAccounts.BankAccountNumber as AccountNumber,
	BankAccounts.BankName as BankName,
	BankAccounts.GLBankAccount as GLAccount,
	BankAccounts.CurrencyID as Currency,
	fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,IFNULL(LedgerChartOfAccounts.GLAccountBalance,0),
   N'') as Balance
   FROM BankAccounts
   INNER Join LedgerChartOfAccounts on
   BankAccounts.GLBankAccount = LedgerChartOfAccounts.GLAccountNumber and
   BankAccounts.CompanyID = LedgerChartOfAccounts.CompanyID and
   BankAccounts.DivisionID = LedgerChartOfAccounts.DivisionID and
   BankAccounts.DepartmentID = LedgerChartOfAccounts.DepartmentID
   WHERE BankAccounts.CompanyID = v_CompanyID and
   BankAccounts.DivisionID = v_DivisionID and
   BankAccounts.DepartmentID = v_DepartmentID;
END