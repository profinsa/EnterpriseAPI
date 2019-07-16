CREATE PROCEDURE RptListLedgerTransactionsDetail (v_CompanyID NATIONAL VARCHAR(36), 
 v_DivisionID NATIONAL VARCHAR(36), 
 v_DepartmentID NATIONAL VARCHAR(36)) BEGIN














   SELECT
	
	
	
   GLTransactionNumber,
	GLTransactionNumberDetail,
	GLTransactionAccount, 
	
	
	fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,GLDebitAmount,CurrencyID) AS GLDebitAmount,
	fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,GLCreditAmount,CurrencyID) AS GLCreditAmount
	
   FROM LedgerTransactionsDetail
   WHERE CompanyID = v_CompanyID and DivisionID = v_DivisionID and DepartmentID = v_DepartmentID;
END