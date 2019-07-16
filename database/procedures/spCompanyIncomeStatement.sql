CREATE PROCEDURE spCompanyIncomeStatement (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),INOUT SWP_Ret_Value INT) BEGIN







   SELECT GLAccountType, Sum(GLAccountBalance) as Totals
   FROM LedgerChartOfAccounts
   WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID and
   GLAccountBalance <> 0
   GROUP BY GLAccountType;


   SET SWP_Ret_Value = 0;
END