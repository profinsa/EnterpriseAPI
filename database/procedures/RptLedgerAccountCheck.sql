CREATE PROCEDURE RptLedgerAccountCheck (v_CompanyID NATIONAL VARCHAR(36), 
 v_DivisionID NATIONAL VARCHAR(36), 
 v_DepartmentID NATIONAL VARCHAR(36),
 v_GLAccountNumber NATIONAL VARCHAR(36)) BEGIN











   DECLARE v_CompanyCurrencyID NATIONAL VARCHAR(3);
   select   IFNULL(CurrencyID,N'') INTO v_CompanyCurrencyID FROM Companies WHERE CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID   LIMIT 1;

   SELECT
	
	
	
   GLTransactionNumber,
	GLTransactionNumberDetail,
	GLTransactionAccount as AccountNumber, 
	
	
	fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,GLDebitAmount,v_CompanyCurrencyID) as Debit,
	fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,GLCreditAmount,v_CompanyCurrencyID) as Credit
	
   FROM LedgerTransactionsDetail
   WHERE CompanyID = v_CompanyID and DivisionID = v_DivisionID and DepartmentID = v_DepartmentID and GLTransactionAccount = v_GLAccountNumber;
END