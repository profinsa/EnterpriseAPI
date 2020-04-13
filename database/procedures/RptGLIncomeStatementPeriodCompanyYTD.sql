CREATE PROCEDURE RptGLIncomeStatementPeriodCompanyYTD (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_Year INT,
	v_Period INT,
	INOUT v_PeriodEndDate DATETIME ,
	INOUT v_IncomeTotal DECIMAL(19,4) ,
	INOUT v_CogsTotal DECIMAL(19,4) ,
	INOUT v_ExpenseTotal DECIMAL(19,4) ,

	INOUT v_IncomeTotalYTD DECIMAL(19,4) ,
	INOUT v_CogsTotalYTD DECIMAL(19,4) ,
	INOUT v_ExpenseTotalYTD DECIMAL(19,4) ,INOUT SWP_Ret_Value INT) SWL_return:
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
   Call LedgerMain_PeriodDate2(v_CompanyID,v_DivisionID,v_DepartmentID,v_Period,v_PeriodStartDate,v_PeriodEndDate, v_ReturnStatus);
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
	
      SET v_PeriodEndDate = TIMESTAMPADD(year,-1,v_PeriodEndDate);
   end if;



   select   fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,CASE
   WHEN v_Period = 0 THEN IFNULL(SUM(GLCurrentYearPeriod1),0)
   WHEN v_Period = 1 THEN IFNULL(SUM(GLCurrentYearPeriod2),0)
   WHEN v_Period = 2 THEN IFNULL(SUM(GLCurrentYearPeriod3),0)
   WHEN v_Period = 3 THEN IFNULL(SUM(GLCurrentYearPeriod4),0)
   WHEN v_Period = 4 THEN IFNULL(SUM(GLCurrentYearPeriod5),0)
   WHEN v_Period = 5 THEN IFNULL(SUM(GLCurrentYearPeriod6),0)
   WHEN v_Period = 6 THEN IFNULL(SUM(GLCurrentYearPeriod7),0)
   WHEN v_Period = 7 THEN IFNULL(SUM(GLCurrentYearPeriod8),0)
   WHEN v_Period = 8 THEN IFNULL(SUM(GLCurrentYearPeriod9),0)
   WHEN v_Period = 9 THEN IFNULL(SUM(GLCurrentYearPeriod10),0)
   WHEN v_Period = 10 THEN IFNULL(SUM(GLCurrentYearPeriod11),0)
   WHEN v_Period = 11 THEN IFNULL(SUM(GLCurrentYearPeriod12),0)
   WHEN v_Period = 12 THEN IFNULL(SUM(GLCurrentYearPeriod13),0)
   WHEN v_Period = 13 THEN IFNULL(SUM(GLCurrentYearPeriod14),0)
   ELSE 0
   END,
   v_CompanyCurrencyID) INTO v_IncomeTotal FROM
   LedgerChartOfAccounts WHERE
   CompanyID = v_CompanyID AND
   GLBalanceType = 'Income';


   select   fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,CASE
   WHEN v_Period = 0 THEN IFNULL(SUM(GLCurrentYearPeriod1),0)
   WHEN v_Period = 1 THEN IFNULL(SUM(GLCurrentYearPeriod2),0)
   WHEN v_Period = 2 THEN IFNULL(SUM(GLCurrentYearPeriod3),0)
   WHEN v_Period = 3 THEN IFNULL(SUM(GLCurrentYearPeriod4),0)
   WHEN v_Period = 4 THEN IFNULL(SUM(GLCurrentYearPeriod5),0)
   WHEN v_Period = 5 THEN IFNULL(SUM(GLCurrentYearPeriod6),0)
   WHEN v_Period = 6 THEN IFNULL(SUM(GLCurrentYearPeriod7),0)
   WHEN v_Period = 7 THEN IFNULL(SUM(GLCurrentYearPeriod8),0)
   WHEN v_Period = 8 THEN IFNULL(SUM(GLCurrentYearPeriod9),0)
   WHEN v_Period = 9 THEN IFNULL(SUM(GLCurrentYearPeriod10),0)
   WHEN v_Period = 10 THEN IFNULL(SUM(GLCurrentYearPeriod11),0)
   WHEN v_Period = 11 THEN IFNULL(SUM(GLCurrentYearPeriod12),0)
   WHEN v_Period = 12 THEN IFNULL(SUM(GLCurrentYearPeriod13),0)
   WHEN v_Period = 13 THEN IFNULL(SUM(GLCurrentYearPeriod14),0)
   ELSE 0
   END,
   v_CompanyCurrencyID) INTO v_CogsTotal FROM
   LedgerChartOfAccounts WHERE
   CompanyID = v_CompanyID AND
   GLBalanceType = 'Expense' AND
   SUBSTRING(GLAccountNumber,1,1) = '5';


   select   fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,CASE
   WHEN v_Period = 0 THEN IFNULL(SUM(GLCurrentYearPeriod1),0)
   WHEN v_Period = 1 THEN IFNULL(SUM(GLCurrentYearPeriod2),0)
   WHEN v_Period = 2 THEN IFNULL(SUM(GLCurrentYearPeriod3),0)
   WHEN v_Period = 3 THEN IFNULL(SUM(GLCurrentYearPeriod4),0)
   WHEN v_Period = 4 THEN IFNULL(SUM(GLCurrentYearPeriod5),0)
   WHEN v_Period = 5 THEN IFNULL(SUM(GLCurrentYearPeriod6),0)
   WHEN v_Period = 6 THEN IFNULL(SUM(GLCurrentYearPeriod7),0)
   WHEN v_Period = 7 THEN IFNULL(SUM(GLCurrentYearPeriod8),0)
   WHEN v_Period = 8 THEN IFNULL(SUM(GLCurrentYearPeriod9),0)
   WHEN v_Period = 9 THEN IFNULL(SUM(GLCurrentYearPeriod10),0)
   WHEN v_Period = 10 THEN IFNULL(SUM(GLCurrentYearPeriod11),0)
   WHEN v_Period = 11 THEN IFNULL(SUM(GLCurrentYearPeriod12),0)
   WHEN v_Period = 12 THEN IFNULL(SUM(GLCurrentYearPeriod13),0)
   WHEN v_Period = 13 THEN IFNULL(SUM(GLCurrentYearPeriod14),0)
   ELSE 0
   END,
   v_CompanyCurrencyID) INTO v_ExpenseTotal FROM
   LedgerChartOfAccounts WHERE
   CompanyID = v_CompanyID AND
   GLBalanceType = 'Expense' AND
   SUBSTRING(GLAccountNumber,1,1) <> '5';



   select   IFNULL(fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,SUM(GLCreditAmount -GLDebitAmount),
   v_CompanyCurrencyID),0) INTO v_IncomeTotalYTD FROM
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
   GLBalanceType = 'Income' AND
   GLTransactionDate >= v_PeriodStartDate AND
   GLTransactionDate <= v_PeriodEndDate;
	
		


   select   IFNULL(fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,SUM(GLDebitAmount -GLCreditAmount),
   v_CompanyCurrencyID),0) INTO v_CogsTotalYTD FROM
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
   GLBalanceType = 'Expense' AND
   SUBSTRING(GLAccountNumber,1,1) = '5' AND
   GLTransactionDate >= v_PeriodStartDate AND
   GLTransactionDate <= v_PeriodEndDate;




   select   IFNULL(fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,SUM(GLDebitAmount -GLCreditAmount),
   v_CompanyCurrencyID),0) INTO v_ExpenseTotalYTD FROM
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
   GLBalanceType = 'Expense' AND
   SUBSTRING(GLAccountNumber,1,1) <> '5' AND
   GLTransactionDate >= v_PeriodStartDate AND
   GLTransactionDate <= v_PeriodEndDate;





   SELECT
   GLBalanceType,
		GLAccountName,
		GLAccountNumber,
		fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,CASE
   WHEN v_Period = 0 THEN IFNULL(SUM(GLCurrentYearPeriod1),0)
   WHEN v_Period = 1 THEN IFNULL(SUM(GLCurrentYearPeriod2),0)
   WHEN v_Period = 2 THEN IFNULL(SUM(GLCurrentYearPeriod3),0)
   WHEN v_Period = 3 THEN IFNULL(SUM(GLCurrentYearPeriod4),0)
   WHEN v_Period = 4 THEN IFNULL(SUM(GLCurrentYearPeriod5),0)
   WHEN v_Period = 5 THEN IFNULL(SUM(GLCurrentYearPeriod6),0)
   WHEN v_Period = 6 THEN IFNULL(SUM(GLCurrentYearPeriod7),0)
   WHEN v_Period = 7 THEN IFNULL(SUM(GLCurrentYearPeriod8),0)
   WHEN v_Period = 8 THEN IFNULL(SUM(GLCurrentYearPeriod9),0)
   WHEN v_Period = 9 THEN IFNULL(SUM(GLCurrentYearPeriod10),0)
   WHEN v_Period = 10 THEN IFNULL(SUM(GLCurrentYearPeriod11),0)
   WHEN v_Period = 11 THEN IFNULL(SUM(GLCurrentYearPeriod12),0)
   WHEN v_Period = 12 THEN IFNULL(SUM(GLCurrentYearPeriod13),0)
   WHEN v_Period = 13 THEN IFNULL(SUM(GLCurrentYearPeriod14),0)
   ELSE 0
   END,
   v_CompanyCurrencyID) As GLAccountBalance,
		case GLBalanceType
   when 'Expense' then SUM(IFNULL(GLDebitAmount,0) -IFNULL(GLCreditAmount,0))
   else SUM(IFNULL(GLCreditAmount,0) -IFNULL(GLDebitAmount,0))
   end as GLAccountBalanceYTD from(SELECT * FROM
      LedgerChartOfAccounts
      LEFT outer join LedgerTransactionsDetail
      on LedgerTransactionsDetail.GLTransactionAccount = LedgerChartOfAccounts.GLAccountNumber
      inner join LedgerTransactions
      on LedgerTransactions.GLTransactionNumber = LedgerTransactionsDetail.GLTransactionNumber
      WHERE
      LedgerChartOfAccounts.CompanyID = v_CompanyID AND
      LedgerTransactionsDetail.CompanyID = v_CompanyID AND
      LedgerTransactions.CompanyID = v_CompanyID AND
		(GLBalanceType = 'Income' OR GLBalanceType = 'Expense') AND
      GLTransactionDate >= v_PeriodStartDate AND
      GLTransactionDate <= v_PeriodEndDate
      UNION
      SELECT * FROM
      LedgerChartOfAccounts
      RIGHT outer join LedgerTransactionsDetail
      on LedgerTransactionsDetail.GLTransactionAccount = LedgerChartOfAccounts.GLAccountNumber
      inner join LedgerTransactions
      on LedgerTransactions.GLTransactionNumber = LedgerTransactionsDetail.GLTransactionNumber
      WHERE
      LedgerChartOfAccounts.CompanyID = v_CompanyID AND
      LedgerTransactionsDetail.CompanyID = v_CompanyID AND
      LedgerTransactions.CompanyID = v_CompanyID AND
		(GLBalanceType = 'Income' OR GLBalanceType = 'Expense') AND
      GLTransactionDate >= v_PeriodStartDate AND
      GLTransactionDate <= v_PeriodEndDate) AS TabAl GROUP BY
   GLBalanceType,GLAccountName,GLAccountNumber;


   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;






   CALL Error_InsertError(v_CompanyID,v_DepartmentID,v_DivisionID,'RptBalanceSheet',v_ErrorMessage,
   v_ErrorID);
   SET SWP_Ret_Value = -1;
END