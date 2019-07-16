CREATE PROCEDURE RptListBankReconciliationDetail (v_CompanyID NATIONAL VARCHAR(36), 
 v_DivisionID NATIONAL VARCHAR(36), 
 v_DepartmentID NATIONAL VARCHAR(36)) BEGIN














   SELECT
	
	
	
   BankRecDocumentNumber,
	BankRecCleared,
	BankRecClearedDate,
	
	
	CurrencyID,
	
	fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,BankRecAmount,CurrencyID) AS BankRecAmount
	
   FROM BankReconciliationDetail
   WHERE CompanyID = v_CompanyID and DivisionID = v_DivisionID and DepartmentID = v_DepartmentID;
END