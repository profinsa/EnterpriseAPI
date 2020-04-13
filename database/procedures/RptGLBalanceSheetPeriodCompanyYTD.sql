CREATE PROCEDURE RptGLBalanceSheetPeriodCompanyYTD (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_Year INT,
	v_Period INT,
	INOUT v_PeriodEndDate DATETIME ,INOUT SWP_Ret_Value INT) SWL_return:
BEGIN













   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);



   DECLARE v_ErrorID INT;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
   END;
   SET @SWV_Error = 0;
   CALL LedgerMain_PeriodEndDate(v_CompanyID,v_DivisionID,v_DepartmentID,v_Period,v_PeriodEndDate, v_ReturnStatus);
   IF @SWV_Error <> 0 OR v_ReturnStatus < 0 then

	
      SET v_ErrorMessage = 'Period End Date retrieving failed';
      CALL Error_InsertError(v_CompanyID,v_DepartmentID,v_DivisionID,'RptGLBalanceSheetYTD',v_ErrorMessage,
      v_ErrorID);
      SET SWP_Ret_Value = -1;
   end if;

   IF v_Year = 1 then
	
      SET v_PeriodEndDate = TIMESTAMPADD(year,-1,v_PeriodEndDate);
   end if;




   SELECT
   GLBalanceType,
	GLAccountName,
	fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,CASE
   WHEN v_Period = 0 THEN SUM(IFNULL(GLCurrentYearPeriod1,0))
   WHEN v_Period = 1 THEN SUM(IFNULL(GLCurrentYearPeriod2,0))
   WHEN v_Period = 2 THEN SUM(IFNULL(GLCurrentYearPeriod3,0))
   WHEN v_Period = 3 THEN SUM(IFNULL(GLCurrentYearPeriod4,0))
   WHEN v_Period = 4 THEN SUM(IFNULL(GLCurrentYearPeriod5,0))
   WHEN v_Period = 5 THEN SUM(IFNULL(GLCurrentYearPeriod6,0))
   WHEN v_Period = 6 THEN SUM(IFNULL(GLCurrentYearPeriod7,0))
   WHEN v_Period = 7 THEN SUM(IFNULL(GLCurrentYearPeriod8,0))
   WHEN v_Period = 8 THEN SUM(IFNULL(GLCurrentYearPeriod9,0))
   WHEN v_Period = 9 THEN SUM(IFNULL(GLCurrentYearPeriod10,0))
   WHEN v_Period = 10 THEN SUM(IFNULL(GLCurrentYearPeriod11,0))
   WHEN v_Period = 11 THEN SUM(IFNULL(GLCurrentYearPeriod12,0))
   WHEN v_Period = 12 THEN SUM(IFNULL(GLCurrentYearPeriod13,0))
   WHEN v_Period = 13 THEN SUM(IFNULL(GLCurrentYearPeriod14,0))
   ELSE 0
   END,
   N'') AS GLAccountBalance,
	fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,case GLBalanceType
   when 'Asset' then SUM(IFNULL(GLDebitAmount,0) -IFNULL(GLCreditAmount,0))
   when 'Expense' then SUM(IFNULL(GLDebitAmount,0) -IFNULL(GLCreditAmount,0))
   else SUM(IFNULL(GLCreditAmount,0) -IFNULL(GLDebitAmount,0))
   end,
   N'') as GLAccountBalanceYTD from(SELECT * FROM
      LedgerChartOfAccounts
      LEFT outer join LedgerTransactionsDetail
      on LedgerTransactionsDetail.GLTransactionAccount = LedgerChartOfAccounts.GLAccountNumber
      inner join LedgerTransactions
      on LedgerTransactions.GLTransactionNumber = LedgerTransactionsDetail.GLTransactionNumber
      WHERE
      LedgerChartOfAccounts.CompanyID = v_CompanyID AND
      LedgerTransactionsDetail.CompanyID = v_CompanyID AND
      LedgerTransactions.CompanyID = v_CompanyID AND
      GLTransactionDate < v_PeriodEndDate AND
	(GLBalanceType = 'Asset' OR GLBalanceType = 'Liability' OR GLBalanceType = 'Equity') AND
      0 <>
      CASE
      WHEN v_Period = 0 THEN IFNULL(GLCurrentYearPeriod1,0)
      WHEN v_Period = 1 THEN IFNULL(GLCurrentYearPeriod2,0)
      WHEN v_Period = 2 THEN IFNULL(GLCurrentYearPeriod3,0)
      WHEN v_Period = 3 THEN IFNULL(GLCurrentYearPeriod4,0)
      WHEN v_Period = 4 THEN IFNULL(GLCurrentYearPeriod5,0)
      WHEN v_Period = 5 THEN IFNULL(GLCurrentYearPeriod6,0)
      WHEN v_Period = 6 THEN IFNULL(GLCurrentYearPeriod7,0)
      WHEN v_Period = 7 THEN IFNULL(GLCurrentYearPeriod8,0)
      WHEN v_Period = 8 THEN IFNULL(GLCurrentYearPeriod9,0)
      WHEN v_Period = 9 THEN IFNULL(GLCurrentYearPeriod10,0)
      WHEN v_Period = 10 THEN IFNULL(GLCurrentYearPeriod11,0)
      WHEN v_Period = 11 THEN IFNULL(GLCurrentYearPeriod12,0)
      WHEN v_Period = 12 THEN IFNULL(GLCurrentYearPeriod13,0)
      WHEN v_Period = 13 THEN IFNULL(GLCurrentYearPeriod14,0)
      ELSE 0
      END
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
      GLTransactionDate < v_PeriodEndDate AND
	(GLBalanceType = 'Asset' OR GLBalanceType = 'Liability' OR GLBalanceType = 'Equity') AND
      0 <>
      CASE
      WHEN v_Period = 0 THEN IFNULL(GLCurrentYearPeriod1,0)
      WHEN v_Period = 1 THEN IFNULL(GLCurrentYearPeriod2,0)
      WHEN v_Period = 2 THEN IFNULL(GLCurrentYearPeriod3,0)
      WHEN v_Period = 3 THEN IFNULL(GLCurrentYearPeriod4,0)
      WHEN v_Period = 4 THEN IFNULL(GLCurrentYearPeriod5,0)
      WHEN v_Period = 5 THEN IFNULL(GLCurrentYearPeriod6,0)
      WHEN v_Period = 6 THEN IFNULL(GLCurrentYearPeriod7,0)
      WHEN v_Period = 7 THEN IFNULL(GLCurrentYearPeriod8,0)
      WHEN v_Period = 8 THEN IFNULL(GLCurrentYearPeriod9,0)
      WHEN v_Period = 9 THEN IFNULL(GLCurrentYearPeriod10,0)
      WHEN v_Period = 10 THEN IFNULL(GLCurrentYearPeriod11,0)
      WHEN v_Period = 11 THEN IFNULL(GLCurrentYearPeriod12,0)
      WHEN v_Period = 12 THEN IFNULL(GLCurrentYearPeriod13,0)
      WHEN v_Period = 13 THEN IFNULL(GLCurrentYearPeriod14,0)
      ELSE 0
      END) AS TabAl GROUP BY
   GLBalanceType,GLAccountName,CASE
   WHEN v_Period = 0 THEN IFNULL(GLCurrentYearPeriod1,0)
   WHEN v_Period = 1 THEN IFNULL(GLCurrentYearPeriod2,0)
   WHEN v_Period = 2 THEN IFNULL(GLCurrentYearPeriod3,0)
   WHEN v_Period = 3 THEN IFNULL(GLCurrentYearPeriod4,0)
   WHEN v_Period = 4 THEN IFNULL(GLCurrentYearPeriod5,0)
   WHEN v_Period = 5 THEN IFNULL(GLCurrentYearPeriod6,0)
   WHEN v_Period = 6 THEN IFNULL(GLCurrentYearPeriod7,0)
   WHEN v_Period = 7 THEN IFNULL(GLCurrentYearPeriod8,0)
   WHEN v_Period = 8 THEN IFNULL(GLCurrentYearPeriod9,0)
   WHEN v_Period = 9 THEN IFNULL(GLCurrentYearPeriod10,0)
   WHEN v_Period = 10 THEN IFNULL(GLCurrentYearPeriod11,0)
   WHEN v_Period = 11 THEN IFNULL(GLCurrentYearPeriod12,0)
   WHEN v_Period = 12 THEN IFNULL(GLCurrentYearPeriod13,0)
   WHEN v_Period = 13 THEN IFNULL(GLCurrentYearPeriod14,0)
   ELSE 0
   END;



   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;






   CALL Error_InsertError(v_CompanyID,v_DepartmentID,v_DivisionID,'RptGLBalanceSheetYTD',v_ErrorMessage,
   v_ErrorID);
   SET SWP_Ret_Value = -1;
END