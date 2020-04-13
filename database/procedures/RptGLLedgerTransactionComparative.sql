CREATE PROCEDURE RptGLLedgerTransactionComparative (v_CompanyID NATIONAL VARCHAR(36), 
 v_DivisionID NATIONAL VARCHAR(36), 
 v_DepartmentID NATIONAL VARCHAR(36),
 v_LedgerTransactionNumber NATIONAL VARCHAR(36)) BEGIN









   DECLARE v_CompanyCurrencyID NATIONAL VARCHAR(3);
   select   IFNULL(CurrencyID,N'') INTO v_CompanyCurrencyID FROM Companies WHERE CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID   LIMIT 1;


   SELECT
   GLTransactionNumber as TransID,
	GLTransactionTypeID as TransType,
	GLTransactionDate as TransDate,
	GLTransactionDescription as TransDesc,
	GLTransactionReference as TransRef,
	GLTransactionSource as TransSource
   FROM LedgerTransactions
   WHERE CompanyID = v_CompanyID and
   DivisionID = v_DivisionID and
   DepartmentID = v_DepartmentID and
   GLTransactionNumber = v_LedgerTransactionNumber;

   SELECT
   LedgerTransactionsDetail.GLTransactionAccount as AccountNumber,
	LedgerChartOfAccounts.GLAccountName as AccountName,
	LedgerTransactionsDetail.GLDebitAmount as Debit,
	LedgerTransactionsDetail.GLCreditAmount as Credit,
	LedgerTransactionsDetail.ProjectID as Project
   FROM LedgerTransactionsDetail
   INNER Join LedgerTransactions ON
   LedgerTransactions.GLTransactionNumber = LedgerTransactionsDetail.GLTransactionNumber and
   LedgerTransactions.CompanyID = v_CompanyID and
   LedgerTransactions.DivisionID = v_DivisionID and
   LedgerTransactions.DepartmentID = v_DepartmentID
   INNER Join LedgerChartOfAccounts ON
   LedgerChartOfAccounts.GLAccountNumber = LedgerTransactionsDetail.GLTransactionAccount and
   LedgerChartOfAccounts.CompanyID = v_CompanyID and
   LedgerChartOfAccounts.DivisionID = v_DivisionID and
   LedgerChartOfAccounts.DepartmentID = v_DepartmentID
   WHERE LedgerTransactionsDetail.CompanyID = v_CompanyID and
   LedgerTransactionsDetail.DivisionID = v_DivisionID and
   LedgerTransactionsDetail.DepartmentID = v_DepartmentID and
   LedgerTransactionsDetail.GLTransactionNumber = v_LedgerTransactionNumber;



   SELECT
   fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,SUM(IFNULL(LedgerTransactionsDetail.GLDebitAmount,0)),
   v_CompanyCurrencyID) as TotalDebit,
	fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,SUM(IFNULL(LedgerTransactionsDetail.GLCreditAmount,0)),
   v_CompanyCurrencyID) as TotalCredit
   FROM LedgerTransactionsDetail
   INNER Join LedgerTransactions ON
   LedgerTransactions.GLTransactionNumber = LedgerTransactionsDetail.GLTransactionNumber and
   LedgerTransactions.CompanyID = v_CompanyID and
   LedgerTransactions.DivisionID = v_DivisionID and
   LedgerTransactions.DepartmentID = v_DepartmentID
   WHERE LedgerTransactionsDetail.CompanyID = v_CompanyID and
   LedgerTransactionsDetail.DivisionID = v_DivisionID and
   LedgerTransactionsDetail.DepartmentID = v_DepartmentID and
   LedgerTransactionsDetail.GLTransactionNumber = v_LedgerTransactionNumber;
END