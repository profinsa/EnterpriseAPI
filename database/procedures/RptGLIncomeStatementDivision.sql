CREATE PROCEDURE RptGLIncomeStatementDivision (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	INOUT v_PeriodEndDate DATETIME ,
	INOUT v_IncomeTotal DECIMAL(19,4) ,
	INOUT v_CogsTotal DECIMAL(19,4) ,
	INOUT v_ExpenseTotal DECIMAL(19,4) ,INOUT SWP_Ret_Value INT) SWL_return:
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



   select   IFNULL(fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,SUM(GLAccountBalance),v_CompanyCurrencyID),0) INTO v_IncomeTotal FROM
   LedgerChartOfAccounts WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   GLBalanceType = 'Income' AND
   IFNULL(GLAccountBalance,0) <> 0;


   select   IFNULL(fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,SUM(GLAccountBalance),v_CompanyCurrencyID),0) INTO v_CogsTotal FROM
   LedgerChartOfAccounts WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   GLBalanceType = 'Expense' AND
   SUBSTRING(GLAccountNumber,1,1) = '5' AND
   IFNULL(GLAccountBalance,0) <> 0;


   select   IFNULL(fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,SUM(GLAccountBalance),v_CompanyCurrencyID),0) INTO v_ExpenseTotal FROM
   LedgerChartOfAccounts WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   GLBalanceType = 'Expense' AND
   SUBSTRING(GLAccountNumber,1,1) <> '5' AND
   IFNULL(GLAccountBalance,0) <> 0;



   SELECT
   GLBalanceType,
		GLAccountName,
		GLAccountNumber,
		fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,GLAccountBalance,v_CompanyCurrencyID) AS GLAccountBalance,
		DepartmentID
   FROM
   LedgerChartOfAccounts
   WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   IFNULL(GLAccountBalance,0) <> 0 AND
		(GLBalanceType = 'Income' OR GLBalanceType = 'Expense'); 



   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;






   CALL Error_InsertError(v_CompanyID,v_DepartmentID,v_DivisionID,'RptBalanceSheet',v_ErrorMessage,
   v_ErrorID);
   SET SWP_Ret_Value = -1;
END