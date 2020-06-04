CREATE PROCEDURE RptGLAccountCheckComparative (v_CompanyID NATIONAL VARCHAR(36), 
 v_DivisionID NATIONAL VARCHAR(36), 
 v_DepartmentID NATIONAL VARCHAR(36),
 v_GLAccountNumber NATIONAL VARCHAR(36)) BEGIN











   SELECT
	
	
	
   GLTransactionNumber,
	GLTransactionNumberDetail,
	GLTransactionAccount as AccountNumber, 
	
	
	fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,GLDebitAmount,N'') as Debit,
	fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,GLCreditAmount,N'') as Credit
	
   FROM LedgerTransactionsDetail
   WHERE CompanyID = v_CompanyID and DivisionID = v_DivisionID and DepartmentID = v_DepartmentID and GLTransactionAccount = v_GLAccountNumber;


   SELECT
   fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,Sum(IFNULL(GLDebitAmount,0)),N'') as TotalDebit,
	fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,Sum(IFNULL(GLCreditAmount,0)),
   N'') as TotalCredit
	
   FROM LedgerTransactionsDetail
   WHERE CompanyID = v_CompanyID and DivisionID = v_DivisionID and DepartmentID = v_DepartmentID and GLTransactionAccount = v_GLAccountNumber;
END