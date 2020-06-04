CREATE PROCEDURE RptCompanyAccountsStatus (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),INOUT SWP_Ret_Value INT) BEGIN








   SELECT GLAccountType, fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,sum(IFNULL(GLAccountBalance,0)),
   N'') as Totals
   FROM LedgerChartOfAccounts
   WHERE 	CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID and
   LOWER(GLAccountType) in('cash','accounts payable','accounts receivable')
   Group by GLAccountType;

   SET SWP_Ret_Value = 0;
END