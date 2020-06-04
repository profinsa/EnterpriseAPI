CREATE PROCEDURE LedgerTransactions_CalcTotals (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_GLTransactionNumber NATIONAL VARCHAR(36),INOUT SWP_Ret_Value INT) BEGIN













   SELECT
   GLDebitAmount,
	GLCreditAmount
   FROM
   LedgerTransactionsDetail
   WHERE
   LedgerTransactionsDetail.CompanyID = v_CompanyID
   AND LedgerTransactionsDetail.DivisionID = v_DivisionID
   AND LedgerTransactionsDetail.DepartmentID = v_DepartmentID
   AND LedgerTransactionsDetail.GLTransactionNumber = v_GLTransactionNumber;


   SET SWP_Ret_Value = 0;
END