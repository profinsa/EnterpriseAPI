CREATE PROCEDURE LedgerTransactions_OpenDb (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),INOUT SWP_Ret_Value INT) BEGIN
















   SELECT
   LedgerTransactions.GLTransactionTypeID,
	LedgerTransactions.GLTransactionDate,
	LedgerTransactions.GLTransactionReference,
	LedgerTransactions.GLTransactionNumber,
	LedgerTransactions.GLTransactionPostedYN,
	LedgerTransactions.GLTransactionRecurringYN,
	LedgerTransactions.GLTransactionDescription,
	LedgerTransactions.GLTransactionSource,
	LedgerTransactionsDetail.GLTransactionAccount,
	LedgerTransactionsDetail.GLDebitAmount,
	LedgerTransactionsDetail.GLCreditAmount
   FROM
   LedgerTransactions INNER JOIN LedgerTransactionsDetail ON
   LedgerTransactions.CompanyID = LedgerTransactionsDetail.CompanyID
   AND LedgerTransactions.DivisionID = LedgerTransactionsDetail.DivisionID
   AND LedgerTransactions.DepartmentID = LedgerTransactionsDetail.DepartmentID
   AND LedgerTransactions.GLTransactionNumber = LedgerTransactionsDetail.GLTransactionNumber
   WHERE
   LedgerTransactions.CompanyID = v_CompanyID
   AND LedgerTransactions.DivisionID = v_DivisionID
   AND LedgerTransactions.DepartmentID = v_DepartmentID;


   SET SWP_Ret_Value = 0;
END