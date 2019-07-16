CREATE PROCEDURE LedgerChartsOfAccount_GetAccountBalances (v_CompanyID NATIONAL VARCHAR(36), 
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_GLAccountNumber NATIONAL VARCHAR(36),INOUT SWP_Ret_Value INT) BEGIN













   SELECT	CompanyID,
	DivisionID,
	DepartmentID,
	GLAccountNumber,
	GLCurrentYearBeginningBalance,
	GLCurrentYearPeriod1,
	GLCurrentYearPeriod2,
	GLCurrentYearPeriod3,
	GLCurrentYearPeriod4,
	GLCurrentYearPeriod5,
	GLCurrentYearPeriod6,
	GLCurrentYearPeriod7,
	GLCurrentYearPeriod8,
	GLCurrentYearPeriod9,
	GLCurrentYearPeriod10,
	GLCurrentYearPeriod11,
	GLCurrentYearPeriod12,
	GLCurrentYearPeriod13,
	GLCurrentYearPeriod14,
	GLPriorYearBeginningBalance,
	GLPriorYearPeriod1,
	GLPriorYearPeriod2,
	GLPriorYearPeriod3,
	GLPriorYearPeriod4,
	GLPriortYearPeriod5,
	GLPriorYearPeriod6,
	GLPriorYearPeriod7,
	GLPriorYearPeriod8,
	GLPriorYearPeriod9,
	GLPriortYearPeriod10,
	GLPriorYearPeriod11,
	GLPriorYearPeriod12,
	GLPriorYearPeriod13,
	GLPriorYearPeriod14,
	GLBudgetBeginningBalance,
	GLBudgetPeriod1,
	GLBudgetPeriod2,
	GLBudgetPeriod3,
	GLBudgetPeriod4,
	GLBudgetPeriod5,
	GLBudgetPeriod6,
	GLBudgetPeriod7,
	GLBudgetPeriod8,
	GLBudgetPeriod9,
	GLBudgetPeriod10,
	GLBudgetPeriod11,
	GLBudgetPeriod12,
	GLBudgetPeriod13,
	GLBudgetPeriod14
   FROM
   LedgerChartOfAccounts
   WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND GLAccountNumber = v_GLAccountNumber;
   SET SWP_Ret_Value = 0;
END