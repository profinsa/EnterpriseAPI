CREATE PROCEDURE RptPayrollCheck (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_PayrollID NATIONAL VARCHAR(36) ,INOUT SWP_Ret_Value INT) BEGIN


   SELECT * FROM
   PayrollRegister
   INNER JOIN PayrollEmployees ON
   PayrollRegister.CompanyID = PayrollEmployees.CompanyID AND
   PayrollRegister.DivisionID = PayrollEmployees.DivisionID AND
   PayrollRegister.DepartmentID = PayrollEmployees.DepartmentID AND
   PayrollRegister.EmployeeID = PayrollEmployees.EmployeeID
   INNER JOIN Companies ON
   PayrollRegister.CompanyID = Companies.CompanyID AND
   PayrollRegister.DivisionID = Companies.DivisionID AND
   PayrollRegister.DepartmentID = Companies.DepartmentID
   INNER JOIN CurrencyTypes ON
   Companies.CompanyID = CurrencyTypes.CompanyID AND
   Companies.DivisionID = CurrencyTypes.DivisionID AND
   Companies.DepartmentID = CurrencyTypes.DepartmentID AND
   Companies.CurrencyID = CurrencyTypes.CurrencyID
   INNER JOIN BankAccounts ON
   PayrollRegister.CompanyID = BankAccounts.CompanyID AND
   PayrollRegister.DivisionID = BankAccounts.DivisionID AND
   PayrollRegister.DepartmentID = BankAccounts.DepartmentID AND
   BankAccounts.BankID = 'Payroll'
   WHERE
   PayrollRegister.CompanyID = v_CompanyID AND
   PayrollRegister.DivisionID = v_DivisionID AND
   PayrollRegister.DepartmentID = v_DepartmentID AND
   PayrollRegister.PayrollID = v_PayrollID;
   SET SWP_Ret_Value = 0;
END