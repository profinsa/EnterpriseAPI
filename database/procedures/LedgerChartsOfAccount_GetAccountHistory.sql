CREATE PROCEDURE LedgerChartsOfAccount_GetAccountHistory (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_GLAccountNumber NATIONAL VARCHAR(36),INOUT SWP_Ret_Value INT) BEGIN













   SELECT DISTINCT
   LedgerTransactionsDetail.GLTransactionNumberDetail,
	LedgerTransactions.GLTransactionDescription,
	LedgerTransactions.GLTransactionSource,
	LedgerTransactions.GLTransactionReference,
	LedgerTransactions.GLTransactionDate,
	LedgerTransactionsDetail.GLDebitAmount,
	LedgerTransactionsDetail.GLCreditAmount
   FROM
   LedgerTransactions INNER JOIN LedgerTransactionsDetail ON
   LedgerTransactions.CompanyID = LedgerTransactionsDetail.CompanyID
   AND LedgerTransactions.DivisionID = LedgerTransactionsDetail.DivisionID
   AND LedgerTransactions.DepartmentID = LedgerTransactionsDetail.DepartmentID
   AND LedgerTransactions.GLTransactionNumber = LedgerTransactionsDetail.GLTransactionNumber
   WHERE
   LedgerTransactions.GLTransactionPostedYN = 1
   AND LedgerTransactionsDetail.CompanyID = v_CompanyID
   AND LedgerTransactionsDetail.DivisionID = v_DivisionID
   AND LedgerTransactionsDetail.DepartmentID = v_DepartmentID
   AND LedgerTransactionsDetail.GLTransactionAccount = v_GLAccountNumber;
   SET SWP_Ret_Value = 0;
END