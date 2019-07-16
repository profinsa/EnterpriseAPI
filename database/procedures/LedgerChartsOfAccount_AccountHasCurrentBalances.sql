CREATE PROCEDURE LedgerChartsOfAccount_AccountHasCurrentBalances (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_GLAccountNumber NATIONAL VARCHAR(36),
	INOUT v_AccountHasCurrentBalances BOOLEAN   ,INOUT SWP_Ret_Value INT) BEGIN














   SET v_AccountHasCurrentBalances = 0;
   IF EXISTS(SELECT	GLAccountNumber
   FROM	LedgerChartOfAccounts
   WHERE	CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND GLAccountNumber = v_GLAccountNumber
   AND (GLCurrentYearPeriod1 > 0
   OR GLCurrentYearPeriod2 > 0
   OR GLCurrentYearPeriod3 > 0
   OR GLCurrentYearPeriod4 > 0
   OR GLCurrentYearPeriod5 > 0
   OR GLCurrentYearPeriod6 > 0
   OR GLCurrentYearPeriod7 > 0
   OR GLCurrentYearPeriod8 > 0
   OR GLCurrentYearPeriod9 > 0
   OR GLCurrentYearPeriod10 > 0
   OR GLCurrentYearPeriod11 > 0
   OR GLCurrentYearPeriod12 > 0
   OR GLCurrentYearPeriod13 > 0
   OR GLCurrentYearPeriod14 > 0)) then
      SET v_AccountHasCurrentBalances = 1;
   end if;


   SET SWP_Ret_Value = 0;
END