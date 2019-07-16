CREATE PROCEDURE RptCheck_01 (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_EmployeeID NATIONAL VARCHAR(36),INOUT SWP_Ret_Value INT) BEGIN










   CALL PaymentCheck_Run2(v_CompanyID,v_DivisionID,v_DepartmentID,v_EmployeeID);

   SELECT DISTINCT
   Companies.CompanyName,
	Companies.CompanyAddress1,
	Companies.CompanyState,
	Companies.CompanyCountry,
	Companies.CompanyPhone,
	Companies.CompanyZip,
	VendorInformation.VendorName,
	VendorInformation.AccountNumber,
	BankAccounts.BankAccountNumber,
	BankAccounts.RoutingCode,
	BankAccounts.BankName,
	BankAccounts.BankAddress1,
	BankAccounts.BankAddress2,
	BankAccounts.BankCity,
	BankAccounts.BankState,
	BankAccounts.BankCountry,
	BankAccounts.BankPhone,
	PC.CheckNumber,
	PaymentsHeader.CheckDate,
	IFNULL((SELECT
      fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,SUM(IFNULL(Amount,0)),N'')
      FROM
      PaymentChecks
      WHERE
      PaymentChecks.CompanyID = v_CompanyID AND
      PaymentChecks.DivisionID = v_DivisionID AND
      PaymentChecks.DepartmentID = v_DepartmentID AND
      PaymentChecks.CheckNumber = PaymentsHeader.CheckNumber
      GROUP BY
      PaymentChecks.CheckNumber),0) AS CheckAmount,
	MajorUnits,
	MinorUnits
   FROM
   PaymentChecks PC
   INNER JOIN Companies  ON
   Companies.CompanyID = PC.CompanyID AND
   Companies.DivisionID = PC.DivisionID AND
   Companies.DepartmentID = PC.DepartmentID
   INNER JOIN VendorInformation ON
   PC.CompanyID = VendorInformation.CompanyID AND
   PC.DivisionID = VendorInformation.DivisionID AND
   PC.DepartmentID = VendorInformation.DepartmentID AND
   PC.VendorID = VendorInformation.VendorID
   INNER JOIN PaymentsHeader ON
   PC.PaymentID = PaymentsHeader.PaymentID AND
   PC.CompanyID = PaymentsHeader.CompanyID AND
   PC.DivisionID = PaymentsHeader.DivisionID AND
   PC.DepartmentID = PaymentsHeader.DepartmentID
   INNER JOIN BankAccounts ON
   PC.CompanyID = BankAccounts.CompanyID AND
   PC.DivisionID = BankAccounts.DivisionID AND
   PC.DepartmentID = BankAccounts.DepartmentID AND
   PC.GLBankAccount = BankAccounts.GLBankAccount
   LEFT OUTER JOIN CurrencyTypes ON
   Companies.CompanyID = CurrencyTypes.CompanyID AND
   Companies.DivisionID = CurrencyTypes.DivisionID AND
   Companies.DepartmentID = CurrencyTypes.DepartmentID AND
   Companies.CurrencyID = CurrencyTypes.CurrencyID
   WHERE
   PC.CompanyID = v_CompanyID AND
   PC.DivisionID = v_DivisionID AND
   PC.DepartmentID = v_DepartmentID AND
   lower(PC.EmployeeID) = lower(v_EmployeeID)	AND
   PaymentsHeader.PaymentTypeID = 'Check'
   ORDER BY
   VendorInformation.VendorName;
   SET SWP_Ret_Value = 0;
END