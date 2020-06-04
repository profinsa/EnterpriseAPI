CREATE PROCEDURE RptGLIncomeStatementPeriod (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_Year INT,
	v_Period INT,
	INOUT v_PeriodEndDate DATETIME ,
	INOUT v_IncomeTotal DECIMAL(19,4) ,
	INOUT v_CogsTotal DECIMAL(19,4) ,
	INOUT v_ExpenseTotal DECIMAL(19,4) ,INOUT SWP_Ret_Value INT) SWL_return:
BEGIN














   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);

   DECLARE v_PeriodStartDate DATETIME;


   DECLARE v_CompanyCurrencyID NATIONAL VARCHAR(3);
   DECLARE v_ErrorID INT;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
   END;
   SET @SWV_Error = 0;
   CALL LedgerMain_PeriodDate2(v_CompanyID,v_DivisionID,v_DepartmentID,v_Period,v_PeriodStartDate,v_PeriodEndDate, v_ReturnStatus);
   IF @SWV_Error <> 0 OR v_ReturnStatus < 0 then

	
      SET v_ErrorMessage = 'Period End Date retrieving failed';
      CALL Error_InsertError(v_CompanyID,v_DepartmentID,v_DivisionID,'RptBalanceSheet',v_ErrorMessage,
      v_ErrorID);
      SET SWP_Ret_Value = -1;
   end if;



   select   IFNULL(CurrencyID,N'') INTO v_CompanyCurrencyID FROM Companies WHERE CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID   LIMIT 1;


   IF v_Year = 1 then
	
      SET v_PeriodStartDate = TIMESTAMPADD(year,-1,v_PeriodStartDate);
      SET v_PeriodEndDate = TIMESTAMPADD(year,-1,v_PeriodEndDate);
   end if;



   select   IFNULL(fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,SUM(GLCreditAmount -GLDebitAmount),
   v_CompanyCurrencyID),0) INTO v_IncomeTotal FROM
   LedgerTransactionsDetail
   INNER JOIN LedgerTransactions ON
   LedgerTransactionsDetail.GLTransactionNumber = LedgerTransactions.GLTransactionNumber AND
   LedgerTransactionsDetail.CompanyID = LedgerTransactions.CompanyID AND
   LedgerTransactionsDetail.DivisionID = LedgerTransactions.DivisionID AND
   LedgerTransactionsDetail.DepartmentID = LedgerTransactions.DepartmentID
   INNER JOIN LedgerChartOfAccounts ON
   GLTransactionAccount = GLAccountNumber AND
   LedgerTransactionsDetail.CompanyID = LedgerChartOfAccounts.CompanyID AND
   LedgerTransactionsDetail.DivisionID = LedgerChartOfAccounts.DivisionID AND
   LedgerTransactionsDetail.DepartmentID = LedgerChartOfAccounts.DepartmentID WHERE
   LedgerTransactionsDetail.CompanyID = v_CompanyID AND
   LedgerTransactionsDetail.DivisionID = v_DivisionID AND
   LedgerTransactionsDetail.DepartmentID = v_DepartmentID AND
   GLBalanceType = 'Income' AND
   GLTransactionDate >= v_PeriodStartDate AND
   GLTransactionDate <= v_PeriodEndDate;
	
		


   select   IFNULL(fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,SUM(GLCreditAmount -GLDebitAmount),
   v_CompanyCurrencyID),0) INTO v_CogsTotal FROM
   LedgerTransactionsDetail
   INNER JOIN LedgerTransactions ON
   LedgerTransactionsDetail.GLTransactionNumber = LedgerTransactions.GLTransactionNumber AND
   LedgerTransactionsDetail.CompanyID = LedgerTransactions.CompanyID AND
   LedgerTransactionsDetail.DivisionID = LedgerTransactions.DivisionID AND
   LedgerTransactionsDetail.DepartmentID = LedgerTransactions.DepartmentID
   INNER JOIN LedgerChartOfAccounts ON
   GLTransactionAccount = GLAccountNumber AND
   LedgerTransactionsDetail.CompanyID = LedgerChartOfAccounts.CompanyID AND
   LedgerTransactionsDetail.DivisionID = LedgerChartOfAccounts.DivisionID AND
   LedgerTransactionsDetail.DepartmentID = LedgerChartOfAccounts.DepartmentID WHERE
   LedgerTransactionsDetail.CompanyID = v_CompanyID AND
   LedgerTransactionsDetail.DivisionID = v_DivisionID AND
   LedgerTransactionsDetail.DepartmentID = v_DepartmentID AND
   GLBalanceType = 'Expense' AND
   SUBSTRING(GLAccountNumber,1,1) = '5' AND
   GLTransactionDate >= v_PeriodStartDate AND
   GLTransactionDate <= v_PeriodEndDate;




   select   IFNULL(fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,SUM(GLCreditAmount -GLDebitAmount),
   v_CompanyCurrencyID),0) INTO v_ExpenseTotal FROM
   LedgerTransactionsDetail
   INNER JOIN LedgerTransactions ON
   LedgerTransactionsDetail.GLTransactionNumber = LedgerTransactions.GLTransactionNumber AND
   LedgerTransactionsDetail.CompanyID = LedgerTransactions.CompanyID AND
   LedgerTransactionsDetail.DivisionID = LedgerTransactions.DivisionID AND
   LedgerTransactionsDetail.DepartmentID = LedgerTransactions.DepartmentID
   INNER JOIN LedgerChartOfAccounts ON
   GLTransactionAccount = GLAccountNumber AND
   LedgerTransactionsDetail.CompanyID = LedgerChartOfAccounts.CompanyID AND
   LedgerTransactionsDetail.DivisionID = LedgerChartOfAccounts.DivisionID AND
   LedgerTransactionsDetail.DepartmentID = LedgerChartOfAccounts.DepartmentID WHERE
   LedgerTransactionsDetail.CompanyID = v_CompanyID AND
   LedgerTransactionsDetail.DivisionID = v_DivisionID AND
   LedgerTransactionsDetail.DepartmentID = v_DepartmentID AND
   GLBalanceType = 'Expense' AND
   SUBSTRING(GLAccountNumber,1,1) <> '5' AND
   GLTransactionDate >= v_PeriodStartDate AND
   GLTransactionDate <= v_PeriodEndDate;





   SELECT
   GLBalanceType,
		GLAccountName,
		GLAccountNumber,
		IFNULL(fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,SUM(GLCreditAmount -GLDebitAmount),
   v_CompanyCurrencyID),0) AS GLAccountBalance
   FROM
   LedgerTransactionsDetail
   INNER JOIN LedgerTransactions ON
   LedgerTransactionsDetail.GLTransactionNumber = LedgerTransactions.GLTransactionNumber AND
   LedgerTransactionsDetail.CompanyID = LedgerTransactions.CompanyID AND
   LedgerTransactionsDetail.DivisionID = LedgerTransactions.DivisionID AND
   LedgerTransactionsDetail.DepartmentID = LedgerTransactions.DepartmentID
   INNER JOIN LedgerChartOfAccounts ON
   GLTransactionAccount = GLAccountNumber AND
   LedgerTransactionsDetail.CompanyID = LedgerChartOfAccounts.CompanyID AND
   LedgerTransactionsDetail.DivisionID = LedgerChartOfAccounts.DivisionID AND
   LedgerTransactionsDetail.DepartmentID = LedgerChartOfAccounts.DepartmentID
   WHERE
   LedgerTransactionsDetail.CompanyID = v_CompanyID AND
   LedgerTransactionsDetail.DivisionID = v_DivisionID AND
   LedgerTransactionsDetail.DepartmentID = v_DepartmentID AND
		(GLBalanceType = 'Income' OR GLBalanceType = 'Expense') AND
   GLTransactionDate >= v_PeriodStartDate AND
   GLTransactionDate <= v_PeriodEndDate
   GROUP BY
   GLBalanceType,GLAccountName,GLAccountNumber;



   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;






   CALL Error_InsertError(v_CompanyID,v_DepartmentID,v_DivisionID,'RptBalanceSheet',v_ErrorMessage,
   v_ErrorID);
   SET SWP_Ret_Value = -1;
END