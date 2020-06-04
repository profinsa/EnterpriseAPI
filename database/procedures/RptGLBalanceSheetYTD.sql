CREATE PROCEDURE RptGLBalanceSheetYTD (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	INOUT v_PeriodEndDate DATETIME ,INOUT SWP_Ret_Value INT) SWL_return:
BEGIN













   DECLARE v_Period INT;
   DECLARE v_PeriodStart DATETIME;

   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);



   DECLARE v_ErrorID INT;
   CALL LedgerMain_VerifyPeriodCurrent(v_CompanyID,v_DivisionID,v_DepartmentID,v_Period,v_PeriodStart,v_PeriodEndDate, v_ReturnStatus);
   IF v_ReturnStatus = -1 then

      SET v_ErrorMessage = 'LedgerMain_CurrenPeriod call failed';
      CALL Error_InsertError(v_CompanyID,v_DepartmentID,v_DivisionID,'RptGLBalanceSheetYTD',v_ErrorMessage,
      v_ErrorID);
      SET SWP_Ret_Value = -1;
   end if;




   SELECT
   GLBalanceType, GLAccountName,
	GLAccountBalance,
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
      LedgerChartOfAccounts.DivisionID = v_DivisionID AND
      LedgerChartOfAccounts.DepartmentID = v_DepartmentID AND
      LedgerTransactionsDetail.CompanyID = v_CompanyID AND
      LedgerTransactionsDetail.DivisionID = v_DivisionID AND
      LedgerTransactionsDetail.DepartmentID = v_DepartmentID AND
      LedgerTransactions.CompanyID = v_CompanyID AND
      LedgerTransactions.DivisionID = v_DivisionID AND
      LedgerTransactions.DepartmentID = v_DepartmentID AND
      GLTransactionDate < CURRENT_TIMESTAMP AND
      IFNULL(GLAccountBalance,0) <> 0 AND
	(GLBalanceType = 'Asset' OR GLBalanceType = 'Liability' OR GLBalanceType = 'Equity')
      UNION
      SELECT * FROM
      LedgerChartOfAccounts
      RIGHT outer join LedgerTransactionsDetail
      on LedgerTransactionsDetail.GLTransactionAccount = LedgerChartOfAccounts.GLAccountNumber
      inner join LedgerTransactions
      on LedgerTransactions.GLTransactionNumber = LedgerTransactionsDetail.GLTransactionNumber
      WHERE
      LedgerChartOfAccounts.CompanyID = v_CompanyID AND
      LedgerChartOfAccounts.DivisionID = v_DivisionID AND
      LedgerChartOfAccounts.DepartmentID = v_DepartmentID AND
      LedgerTransactionsDetail.CompanyID = v_CompanyID AND
      LedgerTransactionsDetail.DivisionID = v_DivisionID AND
      LedgerTransactionsDetail.DepartmentID = v_DepartmentID AND
      LedgerTransactions.CompanyID = v_CompanyID AND
      LedgerTransactions.DivisionID = v_DivisionID AND
      LedgerTransactions.DepartmentID = v_DepartmentID AND
      GLTransactionDate < CURRENT_TIMESTAMP AND
      IFNULL(GLAccountBalance,0) <> 0 AND
	(GLBalanceType = 'Asset' OR GLBalanceType = 'Liability' OR GLBalanceType = 'Equity')) AS TabAl GROUP BY
   GLBalanceType,GLAccountName,GLAccountBalance;


   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;






   CALL Error_InsertError(v_CompanyID,v_DepartmentID,v_DivisionID,'RptGLBalanceSheetYTD',v_ErrorMessage,
   v_ErrorID);
   SET SWP_Ret_Value = -1;
END
