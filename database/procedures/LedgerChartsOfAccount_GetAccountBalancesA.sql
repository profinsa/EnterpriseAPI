CREATE PROCEDURE LedgerChartsOfAccount_GetAccountBalancesA (v_CompanyID NATIONAL VARCHAR(36), 
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_GLAccountNumber NATIONAL VARCHAR(36),
	INOUT v_Balance DECIMAL(19,4)  ,INOUT SWP_Ret_Value INT) BEGIN













   select   IFNULL(GLCurrentYearBeginningBalance,0)+IFNULL(GLCurrentYearPeriod1,0)+IFNULL(GLCurrentYearPeriod2,0)+IFNULL(GLCurrentYearPeriod3,0)+IFNULL(GLCurrentYearPeriod4,0)+IFNULL(GLCurrentYearPeriod5,0)+IFNULL(GLCurrentYearPeriod6,0)+IFNULL(GLCurrentYearPeriod7,0)+IFNULL(GLCurrentYearPeriod8,0)+IFNULL(GLCurrentYearPeriod9,0)+IFNULL(GLCurrentYearPeriod10,0)+IFNULL(GLCurrentYearPeriod11,0)+IFNULL(GLCurrentYearPeriod12,0)+IFNULL(GLCurrentYearPeriod13,0) INTO v_Balance FROM	LedgerChartOfAccounts WHERE	CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND GLAccountNumber = v_GLAccountNumber;
   SET SWP_Ret_Value = 0;
END