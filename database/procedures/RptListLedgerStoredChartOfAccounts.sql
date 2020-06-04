CREATE PROCEDURE RptListLedgerStoredChartOfAccounts (v_CompanyID NATIONAL VARCHAR(36), 
 v_DivisionID NATIONAL VARCHAR(36), 
 v_DepartmentID NATIONAL VARCHAR(36)) BEGIN











   SELECT
   IndustryType,
	GLStoredAccountNumber,
	GLStoredAccountName,
	GLStoredAccountType,
	GLStoredBalanceType,
	GLStoredReportingAccount,
	GLStoredReportingLevel,
	GLStoredNotes
   FROM LedgerStoredChartOfAccounts;
END