CREATE PROCEDURE RptListBankTransactions (v_CompanyID NATIONAL VARCHAR(36), 
 v_DivisionID NATIONAL VARCHAR(36), 
 v_DepartmentID NATIONAL VARCHAR(36)) BEGIN














   SELECT
	
	
	
   BankTransactionID,
	BankDocumentNumber, 
	
	
	TransactionType,
	TransactionDate, 
	
	CurrencyID, 
	
	fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,TransactionAmount,CurrencyID) AS TransactionAmount, 
	
	
	Posted,
	Cleared
	
   FROM BankTransactions
   WHERE CompanyID = v_CompanyID and DivisionID = v_DivisionID and DepartmentID = v_DepartmentID;
END