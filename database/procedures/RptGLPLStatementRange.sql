CREATE PROCEDURE RptGLPLStatementRange (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_PeriodStart DATETIME,
	v_PeriodStop DATETIME,INOUT SWP_Ret_Value INT) SWL_return:
BEGIN










   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);

   DECLARE v_Period INT;


   DECLARE v_CompanyCurrencyID NATIONAL VARCHAR(3);
   DECLARE v_ErrorID INT;
   select   IFNULL(CurrencyID,N'') INTO v_CompanyCurrencyID FROM Companies WHERE CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID   LIMIT 1;



   SELECT
   LCA.GLAccountName,
	IFNULL(fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,SUM(CASE
   WHEN LCA.GLBalanceType = 'Credit' THEN
      CASE
      WHEN LTD.GLDebitAmount IS NULL THEN(-1)*LTD.GLCreditAmount
      ELSE LTD.GLDebitAmount
      END
   WHEN LCA.GLBalanceType = 'Debit' THEN
      CASE
      WHEN LTD.GLCreditAmount IS NULL THEN(-1)*LTD.GLDebitAmount
      ELSE LTD.GLCreditAmount
      END
   END),v_CompanyCurrencyID),0) AS Amount
   FROM
   LedgerTransactions LT
   INNER JOIN LedgerTransactionsDetail LTD
   ON (LT.CompanyID = LTD.CompanyID
   AND LT.DivisionID = LTD.DivisionID
   AND LT.DepartmentID = LTD.DepartmentID
   AND LT.GLTransactionNumber = LTD.GLTransactionNumber)
   RIGHT JOIN LedgerChartOfAccounts LCA
   ON(LTD.CompanyID = LCA.CompanyID
   AND LTD.DivisionID = LCA.DivisionID
   AND LTD.DepartmentID = LCA.DepartmentID
   AND LTD.GLTransactionAccount = LCA.GLAccountNumber)
   WHERE
   LT.CompanyID = v_CompanyID
   AND LT.DivisionID = v_DivisionID
   AND LT.DepartmentID = v_DepartmentID
   AND (LCA.GLAccountNumber LIKE '11%' OR LCA.GLAccountNumber LIKE '13%' OR
   LCA.GLAccountNumber LIKE '14%' OR LCA.GLAccountNumber LIKE '15%' OR LCA.GLAccountNumber LIKE '16%' OR LCA.GLAccountNumber LIKE '17%')
   AND LT.GLTransactionDate >= v_PeriodStart
   AND LT.GLTransactionDate < v_PeriodStop
   GROUP BY
   LCA.GLAccountName;



   SELECT
   LCA.GLAccountName,
	IFNULL(fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,SUM(CASE
   WHEN LCA.GLBalanceType = 'Debit' THEN
      CASE
      WHEN LTD.GLDebitAmount IS NULL THEN(-1)*LTD.GLCreditAmount
      ELSE LTD.GLDebitAmount
      END
   WHEN LCA.GLBalanceType = 'Credit' THEN
      CASE
      WHEN LTD.GLCreditAmount IS NULL THEN(-1)*LTD.GLDebitAmount
      ELSE LTD.GLCreditAmount
      END
   END),v_CompanyCurrencyID),0) AS Amount
   FROM
   LedgerTransactions LT
   INNER JOIN LedgerTransactionsDetail LTD
   ON (LT.CompanyID = LTD.CompanyID
   AND LT.DivisionID = LTD.DivisionID
   AND LT.DepartmentID = LTD.DepartmentID
   AND LT.GLTransactionNumber = LTD.GLTransactionNumber)
   RIGHT JOIN LedgerChartOfAccounts LCA
   ON(LTD.CompanyID = LCA.CompanyID
   AND LTD.DivisionID = LCA.DivisionID
   AND LTD.DepartmentID = LCA.DepartmentID
   AND LTD.GLTransactionAccount = LCA.GLAccountNumber)
   WHERE
   LT.CompanyID = v_CompanyID
   AND LT.DivisionID = v_DivisionID
   AND LT.DepartmentID = v_DepartmentID
   AND (LCA.GLAccountNumber LIKE '5%' OR LCA.GLAccountNumber LIKE '510%' OR
   LCA.GLAccountNumber LIKE '515%' OR LCA.GLAccountNumber LIKE '520%' OR
   LCA.GLAccountNumber LIKE '525%' OR LCA.GLAccountNumber LIKE '530%' OR
   LCA.GLAccountNumber LIKE '535%' OR LCA.GLAccountNumber LIKE '540%')
   AND LT.GLTransactionDate >= v_PeriodStart
   AND LT.GLTransactionDate < v_PeriodStop
   GROUP BY
   LCA.GLAccountName;



   SELECT
   LCA.GLAccountName,
	IFNULL(fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,SUM(CASE
   WHEN LCA.GLBalanceType = 'Credit' THEN
      CASE
      WHEN LTD.GLDebitAmount IS NULL THEN(-1)*LTD.GLCreditAmount
      ELSE LTD.GLDebitAmount
      END
   WHEN LCA.GLBalanceType = 'Debit' THEN
      CASE
      WHEN LTD.GLCreditAmount IS NULL THEN(-1)*LTD.GLDebitAmount
      ELSE LTD.GLCreditAmount
      END
   END),v_CompanyCurrencyID),0) AS Amount
   FROM
   LedgerTransactions LT
   INNER JOIN LedgerTransactionsDetail LTD
   ON (LT.CompanyID = LTD.CompanyID
   AND LT.DivisionID = LTD.DivisionID
   AND LT.DepartmentID = LTD.DepartmentID
   AND LT.GLTransactionNumber = LTD.GLTransactionNumber)
   RIGHT JOIN LedgerChartOfAccounts LCA
   ON(LTD.CompanyID = LCA.CompanyID
   AND LTD.DivisionID = LCA.DivisionID
   AND LTD.DepartmentID = LCA.DepartmentID
   AND LTD.GLTransactionAccount = LCA.GLAccountNumber)
   WHERE
   LT.CompanyID = v_CompanyID
   AND LT.DivisionID = v_DivisionID
   AND LT.DepartmentID = v_DepartmentID
   AND (LCA.GLAccountNumber LIKE '12%' OR LCA.GLAccountNumber LIKE '121%' OR
   LCA.GLAccountNumber LIKE '122%' OR LCA.GLAccountNumber LIKE '123%'
   OR LCA.GLAccountNumber LIKE '4%')
   AND LT.GLTransactionDate >= v_PeriodStart
   AND LT.GLTransactionDate < v_PeriodStop
   GROUP BY
   LCA.GLAccountName;

   SELECT
   LCA.GLAccountName,
	IFNULL(fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,SUM(CASE
   WHEN LCA.GLBalanceType = 'Debit' THEN
      CASE
      WHEN LTD.GLDebitAmount IS NULL THEN(-1)*LTD.GLCreditAmount
      ELSE LTD.GLDebitAmount
      END
   WHEN LCA.GLBalanceType = 'Credit' THEN
      CASE
      WHEN LTD.GLCreditAmount IS NULL THEN(-1)*LTD.GLDebitAmount
      ELSE LTD.GLCreditAmount
      END
   END),v_CompanyCurrencyID),0) AS Amount
   FROM
   LedgerTransactions LT
   INNER JOIN LedgerTransactionsDetail LTD
   ON (LT.CompanyID = LTD.CompanyID
   AND LT.DivisionID = LTD.DivisionID
   AND LT.DepartmentID = LTD.DepartmentID
   AND LT.GLTransactionNumber = LTD.GLTransactionNumber)
   RIGHT JOIN LedgerChartOfAccounts LCA
   ON(LTD.CompanyID = LCA.CompanyID
   AND LTD.DivisionID = LCA.DivisionID
   AND LTD.DepartmentID = LCA.DepartmentID
   AND LTD.GLTransactionAccount = LCA.GLAccountNumber)
   WHERE
   LT.CompanyID = v_CompanyID
   AND LT.DivisionID = v_DivisionID
   AND LT.DepartmentID = v_DepartmentID
   AND (LCA.GLAccountNumber LIKE '6%' OR LCA.GLAccountNumber LIKE '7%' OR
   LCA.GLAccountNumber LIKE '8%')
   AND LT.GLTransactionDate >= v_PeriodStart
   AND LT.GLTransactionDate < v_PeriodStop
   GROUP BY
   LCA.GLAccountName;


   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;







   CALL Error_InsertError(v_CompanyID,v_DepartmentID,v_DivisionID,'RptGLPLStatement',v_ErrorMessage,
   v_ErrorID);


   SET SWP_Ret_Value = -1;
END