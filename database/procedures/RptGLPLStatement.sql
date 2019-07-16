CREATE PROCEDURE RptGLPLStatement (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),INOUT SWP_Ret_Value INT) SWL_return:
BEGIN










   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);

   DECLARE v_Period INT;
   DECLARE v_PeriodStart DATETIME;
   DECLARE v_PeriodStop DATETIME;

   DECLARE v_CompanyCurrencyID NATIONAL VARCHAR(3);
   DECLARE v_ErrorID INT;
   SET v_ReturnStatus = LedgerMain_CurrentPeriod(v_CompanyID,v_DivisionID,v_DepartmentID,v_Period,v_PeriodStart,v_PeriodStop);
   IF v_ReturnStatus = -1 then

      SET v_ErrorMessage = 'LedgerMain_CurrenPeriod call failed';
      CALL Error_InsertError(v_CompanyID,v_DepartmentID,v_DivisionID,'RptGLPLStatement',v_ErrorMessage,
      v_ErrorID);
      SET SWP_Ret_Value = -1;
   end if;

   select   IFNULL(CurrencyID,N'') INTO v_CompanyCurrencyID FROM Companies WHERE CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID   LIMIT 1;



   CREATE TEMPORARY TABLE tt_TASSETS
   (	
      GLACCOUNTNAME NATIONAL VARCHAR(30),
      AMOUNT DECIMAL(19,4),
      DISPLAYORDER INT   DEFAULT 0
   );
   INSERT INTO tt_TASSETS(GLACCOUNTNAME, AMOUNT)
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

   DROP TEMPORARY TABLE IF EXISTS tt_TASSETS_t;
   CREATE TEMPORARY TABLE tt_TASSETS_t  AS SELECT * FROM tt_TASSETS;
   INSERT INTO tt_TASSETS(GLACCOUNTNAME, AMOUNT, DISPLAYORDER)
   SELECT 'TOTAL', fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,SUM(AMOUNT),v_CompanyCurrencyID), 1 FROM tt_TASSETS_t;

   SELECT GLACCOUNTNAME, IFNULL(AMOUNT,0) AS Amount FROM tt_TASSETS ORDER BY DISPLAYORDER,GLACCOUNTNAME;
   DROP TEMPORARY TABLE IF EXISTS tt_TASSETS;


   CREATE TEMPORARY TABLE tt_TCOG
   (	
      GLACCOUNTNAME NATIONAL VARCHAR(30),
      AMOUNT DECIMAL(19,4),
      DISPLAYORDER INT   DEFAULT 0
   );
   INSERT INTO tt_TCOG(GLACCOUNTNAME, AMOUNT)
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

   DROP TEMPORARY TABLE IF EXISTS tt_TCOG_t;
   CREATE TEMPORARY TABLE tt_TCOG_t  AS SELECT * FROM tt_TCOG;
   INSERT INTO tt_TCOG(GLACCOUNTNAME, AMOUNT, DISPLAYORDER)
   SELECT 'TOTAL', fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,SUM(AMOUNT),v_CompanyCurrencyID), 1 FROM tt_TCOG_t;

   SELECT GLACCOUNTNAME, IFNULL(AMOUNT,0) AS Amount FROM tt_TCOG ORDER BY DISPLAYORDER,GLACCOUNTNAME;
   DROP TEMPORARY TABLE IF EXISTS tt_TCOG;


   CREATE TEMPORARY TABLE tt_TINCOME
   (	
      GLACCOUNTNAME NATIONAL VARCHAR(30),
      AMOUNT DECIMAL(19,4),
      DISPLAYORDER INT   DEFAULT 0
   );
   INSERT INTO tt_TINCOME(GLACCOUNTNAME, AMOUNT)
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

   DROP TEMPORARY TABLE IF EXISTS tt_TINCOME_t;
   CREATE TEMPORARY TABLE tt_TINCOME_t  AS SELECT * FROM tt_TINCOME;
   INSERT INTO tt_TINCOME(GLACCOUNTNAME, AMOUNT, DISPLAYORDER)
   SELECT 'TOTAL', fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,SUM(AMOUNT),v_CompanyCurrencyID), 1 FROM tt_TINCOME_t;

   SELECT GLACCOUNTNAME, IFNULL(AMOUNT,0) AS Amount FROM tt_TINCOME ORDER BY DISPLAYORDER,GLACCOUNTNAME;
   DROP TEMPORARY TABLE IF EXISTS tt_TINCOME;

   CREATE TEMPORARY TABLE tt_TEXPENSES
   (	
      GLACCOUNTNAME NATIONAL VARCHAR(30),
      AMOUNT DECIMAL(19,4),
      DISPLAYORDER INT   DEFAULT 0
   );
   INSERT INTO tt_TEXPENSES(GLACCOUNTNAME, AMOUNT)
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

   DROP TEMPORARY TABLE IF EXISTS tt_TEXPENSES_t;
   CREATE TEMPORARY TABLE tt_TEXPENSES_t  AS SELECT * FROM tt_TEXPENSES;
   INSERT INTO tt_TEXPENSES(GLACCOUNTNAME, AMOUNT, DISPLAYORDER)
   SELECT 'TOTAL', fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,SUM(AMOUNT),v_CompanyCurrencyID), 1 FROM tt_TEXPENSES_t;

   SELECT GLACCOUNTNAME, IFNULL(AMOUNT,0) AS Amount FROM tt_TEXPENSES ORDER BY DISPLAYORDER,GLACCOUNTNAME;
   DROP TEMPORARY TABLE IF EXISTS tt_TEXPENSES;

   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;







   CALL Error_InsertError(v_CompanyID,v_DepartmentID,v_DivisionID,'RptGLPLStatement',v_ErrorMessage,
   v_ErrorID);


   SET SWP_Ret_Value = -1;
END