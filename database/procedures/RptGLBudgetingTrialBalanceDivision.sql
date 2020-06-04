CREATE PROCEDURE RptGLBudgetingTrialBalanceDivision (v_CompanyID NATIONAL VARCHAR(36),
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
   SET v_ReturnStatus = LedgerMain_VerifyPeriodCurrent2(v_CompanyID,v_DivisionID,v_DepartmentID,v_Period,v_PeriodStart,v_PeriodEndDate);
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
   GLBudgetID As GLAccountName,
   GLAccountNumber,
		fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,CASE
   WHEN SUM(GLCreditAmount -GLDebitAmount) < 0 THEN -SUM(GLCreditAmount -GLDebitAmount)
   ELSE SUM(GLCreditAmount -GLDebitAmount)
   END,v_CompanyCurrencyID) AS GLAccountBalance,
		CASE
   WHEN SUM(GLCreditAmount -GLDebitAmount) < 0 THEN 'Debit'
   ELSE 'Credit'
   END AS GLBalanceType
   FROM
   LedgerTransactionsDetail
   INNER JOIN LedgerChartOfAccountsBudgets ON
   GLTransactionAccount = GLAccountNumber AND
   LedgerTransactionsDetail.CompanyID = LedgerChartOfAccountsBudgets.CompanyID AND
   LedgerTransactionsDetail.DivisionID = LedgerChartOfAccountsBudgets.DivisionID AND
   LedgerTransactionsDetail.DepartmentID = LedgerChartOfAccountsBudgets.DepartmentID
   WHERE
   LedgerTransactionsDetail.CompanyID = v_CompanyID AND
   LedgerTransactionsDetail.DivisionID = v_DivisionID
   GROUP BY
   GLAccountNumber,GLBudgetID
   ORDER BY
   GLBalanceType DESC;



   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;






   CALL Error_InsertError(v_CompanyID,v_DepartmentID,v_DivisionID,'RptBalanceSheet',v_ErrorMessage,
   v_ErrorID);
   SET SWP_Ret_Value = -1;
END