CREATE PROCEDURE RptListBankReconciliation (v_CompanyID NATIONAL VARCHAR(36), 
 v_DivisionID NATIONAL VARCHAR(36), 
 v_DepartmentID NATIONAL VARCHAR(36)) BEGIN














   SELECT
	
	
	
   BankID,
	BankRecStartDate,
	BankRecEndDate,
	CurrencyID,
	
	
	fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,BankRecEndingBalance,CurrencyID) AS BankRecEndingBalance
	
	
	
	
	
	
	
   FROM BankReconciliation
   WHERE CompanyID = v_CompanyID and DivisionID = v_DivisionID and DepartmentID = v_DepartmentID;
END