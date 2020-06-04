CREATE PROCEDURE RptListLedgerTransactions (v_CompanyID NATIONAL VARCHAR(36), 
 v_DivisionID NATIONAL VARCHAR(36), 
 v_DepartmentID NATIONAL VARCHAR(36)) BEGIN














   SELECT
	
	
	
   GLTransactionNumber,
	GLTransactionTypeID,
	GLTransactionDate, 
	
	GLTransactionDescription,
	
	
	
	fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,GLTransactionAmount,CurrencyID) AS GLTransactionAmount
	
	
	
	
	
	
   FROM LedgerTransactions
   WHERE CompanyID = v_CompanyID and DivisionID = v_DivisionID and DepartmentID = v_DepartmentID;
END