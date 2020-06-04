CREATE PROCEDURE RptCheckSummaryHeader (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_EmployeeID NATIONAL VARCHAR(35),INOUT SWP_Ret_Value INT) BEGIN
















   SELECT
   BankAccounts.GLBankAccount,
	BankAccounts.BankAccountNumber,
	BankAccounts.Balance,
	BankAccounts.CurrencyID,
	COUNT(DISTINCT CheckNumber) AS NumberOfChecks,
	MIN(cast(PaymentChecks.CheckNumber as SIGNED INTEGER)) AS StartingCheckNumber,
	fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,SUM(IFNULL(PaymentChecks.Amount,0)),
   N'') AS Total
   FROM
   PaymentChecks INNER JOIN BankAccounts ON
   PaymentChecks.CompanyID = BankAccounts.CompanyID AND
   PaymentChecks.DivisionID = BankAccounts.DivisionID AND
   PaymentChecks.DepartmentID = BankAccounts.DepartmentID AND
   PaymentChecks.GLBankAccount = BankAccounts.GLBankAccount
   WHERE
   PaymentChecks.CompanyID = v_CompanyID AND
   PaymentChecks.DivisionID = v_DivisionID AND
   PaymentChecks.DepartmentID = v_DepartmentID AND
   lower(PaymentChecks.EmployeeID) = lower(v_EmployeeID)
   GROUP BY
   BankAccounts.GLBankAccount,BankAccounts.BankAccountNumber,BankAccounts.Balance,
   BankAccounts.CurrencyID;



   SET SWP_Ret_Value = 0;
END