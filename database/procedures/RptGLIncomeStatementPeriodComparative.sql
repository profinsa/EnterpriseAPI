CREATE PROCEDURE RptGLIncomeStatementPeriodComparative (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_Year INT,
	v_Period INT,
	INOUT v_PeriodEndDate DATETIME ,
	INOUT v_IncomeTotal DECIMAL(19,4) ,
	INOUT v_CogsTotal DECIMAL(19,4) ,
	INOUT v_ExpenseTotal DECIMAL(19,4) ,

	INOUT v_IncomeTotalComparative DECIMAL(19,4) ,
	INOUT v_CogsTotalComparative DECIMAL(19,4) ,
	INOUT v_ExpenseTotalComparative DECIMAL(19,4) ,INOUT SWP_Ret_Value INT) SWL_return:
BEGIN













   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);


   DECLARE v_CompanyCurrencyID NATIONAL VARCHAR(3);
   DECLARE v_ErrorID INT;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
   END;
   SET @SWV_Error = 0;
   CALL LedgerMain_PeriodEndDate(v_CompanyID,v_DivisionID,v_DepartmentID,v_Period,v_PeriodEndDate, v_ReturnStatus);
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
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
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
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
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
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   GLBalanceType = 'Expense' AND
   SUBSTRING(GLAccountNumber,1,1) <> '5';




   select   IFNULL(fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,SUM(CASE
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
   v_CompanyCurrencyID),0) INTO v_IncomeTotalComparative FROM
   LedgerChartOfAccounts WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   GLBalanceType = 'Income' AND
   IFNULL(GLAccountBalance,0) <> 0;


   select   IFNULL(fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,SUM(CASE
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
   v_CompanyCurrencyID),0) INTO v_CogsTotalComparative FROM
   LedgerChartOfAccounts WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   GLBalanceType = 'Expense' AND
   SUBSTRING(GLAccountNumber,1,1) = '5' AND
   IFNULL(GLAccountBalance,0) <> 0;


   select   IFNULL(fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,SUM(CASE
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
   v_CompanyCurrencyID),0) INTO v_ExpenseTotalComparative FROM
   LedgerChartOfAccounts WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   GLBalanceType = 'Expense' AND
   SUBSTRING(GLAccountNumber,1,1) <> '5' AND
   IFNULL(GLAccountBalance,0) <> 0;





   SELECT
   GLBalanceType,
		GLAccountName,
		GLAccountNumber,
		IFNULL(fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,CASE
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
   v_CompanyCurrencyID),0) AS GLAccountBalance,
		IFNULL(fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,SUM(CASE
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
   v_CompanyCurrencyID),0) AS GLAccountBalanceComparative
   FROM
   LedgerChartOfAccounts
   WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
		(GLBalanceType = 'Income' OR GLBalanceType = 'Expense')
   GROUP BY
   GLBalanceType,GLAccountName,GLAccountNumber;



   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;






   CALL Error_InsertError(v_CompanyID,v_DepartmentID,v_DivisionID,'RptBalanceSheet',v_ErrorMessage,
   v_ErrorID);
   SET SWP_Ret_Value = -1;
END