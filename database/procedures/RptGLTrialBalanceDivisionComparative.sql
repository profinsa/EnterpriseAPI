CREATE PROCEDURE RptGLTrialBalanceDivisionComparative (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	INOUT v_PeriodEndDate DATETIME ,INOUT SWP_Ret_Value INT) SWL_return:
BEGIN












   DECLARE v_Period INT;
   DECLARE v_PeriodStart DATETIME;

   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);



   DECLARE v_CompanyCurrencyID NATIONAL VARCHAR(3);
   DECLARE v_ErrorID INT;
   CALL LedgerMain_VerifyPeriodCurrent(v_CompanyID,v_DivisionID,v_DepartmentID,v_Period,v_PeriodStart,v_PeriodEndDate, v_ReturnStatus);
   IF v_ReturnStatus = -1 then

      SET v_ErrorMessage = 'LedgerMain_CurrenPeriod call failed';
      CALL Error_InsertError(v_CompanyID,v_DepartmentID,v_DivisionID,'RptBalanceSheet',v_ErrorMessage,
      v_ErrorID);
      SET SWP_Ret_Value = -1;
   end if;

   select   IFNULL(CurrencyID,N'') INTO v_CompanyCurrencyID FROM Companies WHERE CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID   LIMIT 1;



   SELECT
   GLAccountName,
		fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,CASE
   WHEN SUM(GLCreditAmount -GLDebitAmount) < 0 THEN -SUM(GLCreditAmount -GLDebitAmount)
   ELSE SUM(GLCreditAmount -GLDebitAmount)
   END,v_CompanyCurrencyID) AS GLAccountBalance,
		fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,SUM(CASE
   WHEN v_Period = 0 THEN IFNULL(GLPriorYearPeriod1,0)
   WHEN v_Period = 1 THEN IFNULL(GLPriorYearPeriod2,0)
   WHEN v_Period = 2 THEN IFNULL(GLPriorYearPeriod3,0)
   WHEN v_Period = 3 THEN IFNULL(GLPriorYearPeriod4,0)
   WHEN v_Period = 4 THEN IFNULL(GLPriortYearPeriod5,0)
   WHEN v_Period = 5 THEN IFNULL(GLPriorYearPeriod6,0)
   WHEN v_Period = 6 THEN IFNULL(GLPriorYearPeriod7,0)
   WHEN v_Period = 7 THEN IFNULL(GLPriorYearPeriod8,0)
   WHEN v_Period = 8 THEN IFNULL(GLPriorYearPeriod9,0)
   WHEN v_Period = 9 THEN IFNULL(GLPriortYearPeriod10,0)
   WHEN v_Period = 10 THEN IFNULL(GLPriorYearPeriod11,0)
   WHEN v_Period = 11 THEN IFNULL(GLPriorYearPeriod12,0)
   WHEN v_Period = 12 THEN IFNULL(GLPriorYearPeriod13,0)
   WHEN v_Period = 13 THEN IFNULL(GLPriorYearPeriod14,0)
   ELSE 0
   END),
   v_CompanyCurrencyID) AS GLAccountBalanceComparative,
		CASE
   WHEN SUM(GLCreditAmount -GLDebitAmount) < 0 THEN 'Debit'
   ELSE 'Credit'
   END AS GLBalanceType
   FROM
   LedgerTransactionsDetail
   INNER JOIN LedgerChartOfAccounts ON
   GLTransactionAccount = GLAccountNumber AND
   LedgerTransactionsDetail.CompanyID = LedgerChartOfAccounts.CompanyID AND
   LedgerTransactionsDetail.DivisionID = LedgerChartOfAccounts.DivisionID AND
   LedgerTransactionsDetail.DepartmentID = LedgerChartOfAccounts.DepartmentID
   WHERE
   LedgerTransactionsDetail.CompanyID = v_CompanyID AND
   LedgerTransactionsDetail.DivisionID = v_DivisionID
   GROUP BY
   GLAccountNumber,GLAccountName
   ORDER BY
   GLBalanceType DESC;



   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;






   CALL Error_InsertError(v_CompanyID,v_DepartmentID,v_DivisionID,'RptBalanceSheet',v_ErrorMessage,
   v_ErrorID);
   SET SWP_Ret_Value = -1;
END