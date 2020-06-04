CREATE PROCEDURE RptCheckStub (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_EmployeeID NATIONAL VARCHAR(36),
	v_CheckNumber NATIONAL VARCHAR(20),INOUT SWP_Ret_Value INT) BEGIN















   SELECT
   PaymentsHeader.PaymentID,
	IFNULL(PaymentsDetail.DocumentNumber,PaymentsHeader.InvoiceNumber) As InvoiceNumber,
	IFNULL(PaymentsDetail.DocumentDate,PaymentsHeader.PurchaseDate) As InvoiceDate,
	IFNULL(PaymentsDetail.AppliedAmount,IFNULL(PaymentsHeader.CreditAmount,PaymentsHeader.Amount)) AS InvoiceAmount,
	(SELECT
      CurrenycySymbol
      FROM
      CurrencyTypes
      Where
      PaymentsHeader.CompanyID = CurrencyTypes.CompanyID AND
      PaymentsHeader.DivisionID = CurrencyTypes.DivisionID AND
      PaymentsHeader.DepartmentID = CurrencyTypes.DepartmentID AND
      PaymentsHeader.CurrencyID = CurrencyTypes.CurrencyID) AS CurrencySymbol,
	PaymentsHeader.Notes
   FROM
   Companies INNER JOIN PaymentChecks ON
   Companies.CompanyID = PaymentChecks.CompanyID AND
   Companies.DivisionID = PaymentChecks.DivisionID AND
   Companies.DepartmentID = PaymentChecks.DepartmentID
   INNER JOIN VendorInformation ON
   PaymentChecks.CompanyID = VendorInformation.CompanyID AND
   PaymentChecks.DivisionID = VendorInformation.DivisionID AND
   PaymentChecks.DepartmentID = VendorInformation.DepartmentID AND
   PaymentChecks.VendorID = VendorInformation.VendorID
   INNER JOIN PaymentsHeader ON
   PaymentChecks.PaymentID = PaymentsHeader.PaymentID AND
   PaymentChecks.CompanyID = PaymentsHeader.CompanyID AND
   PaymentChecks.DivisionID = PaymentsHeader.DivisionID AND
   PaymentChecks.DepartmentID = PaymentsHeader.DepartmentID
   LEFT JOIN PaymentsDetail ON
   PaymentsHeader.CompanyID = PaymentsDetail.CompanyID AND
   PaymentsHeader.DivisionID = PaymentsDetail.DivisionID AND
   PaymentsHeader.DepartmentID = PaymentsDetail.DepartmentID AND
   PaymentsHeader.PaymentID = PaymentsDetail.PaymentID
   WHERE
   Companies.CompanyID = v_CompanyID AND
   Companies.DivisionID = v_DivisionID AND
   Companies.DepartmentID = v_DepartmentID AND
   lower(PaymentChecks.EmployeeID) = lower(v_EmployeeID)	AND
   PaymentChecks.CheckNumber = v_CheckNumber;
   SET SWP_Ret_Value = 0;
END