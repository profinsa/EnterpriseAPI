CREATE PROCEDURE LedgerChartOfAccounts_CanDelete (v_CompanyID NATIONAL VARCHAR(36), 
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_GLAccountNumber NATIONAL VARCHAR(36),
	INOUT v_CanDelete BOOLEAN ,INOUT SWP_Ret_Value INT) BEGIN








	
   SET v_CanDelete = 1;

	
	
   IF EXISTS(SELECT * FROM LedgerTransactionsDetail D, LedgerTransactions T WHERE
   D.CompanyID = v_CompanyID AND D.DivisionID = v_DivisionID AND D.DepartmentID = v_DepartmentID AND
   T.CompanyID = v_CompanyID AND T.DivisionID = v_DivisionID AND T.DepartmentID = v_DepartmentID AND
   D.GLTransactionNumber = T.GLTransactionNumber AND
   D.GLTransactionAccount = v_GLAccountNumber) then
      SET v_CanDelete = 0;
   end if;
	
   
SET SWP_Ret_Value = 0;
END