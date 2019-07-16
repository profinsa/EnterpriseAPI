CREATE PROCEDURE RptCheckSummaryDetail (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_EmployeeID NATIONAL VARCHAR(35),INOUT SWP_Ret_Value INT) BEGIN















   SELECT
   VendorName,
	PaymentChecks.CheckNumber,
	PaymentChecks.CurrencyID,
	fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,SUM(IFNULL(Amount,0)),N'') AS Total
   FROM
   PaymentChecks INNER JOIN VendorInformation ON
   PaymentChecks.CompanyID = VendorInformation.CompanyID AND
   PaymentChecks.DivisionID = VendorInformation.DivisionID AND
   PaymentChecks.DepartmentID = VendorInformation.DepartmentID AND
   PaymentChecks.VendorID = VendorInformation.VendorID
   WHERE
   PaymentChecks.CompanyID = v_CompanyID AND
   PaymentChecks.DivisionID = v_DivisionID AND
   PaymentChecks.DepartmentID = v_DepartmentID AND
   lower(PaymentChecks.EmployeeID) = lower(v_EmployeeID)
   GROUP BY
   VendorName,PaymentChecks.CheckNumber,PaymentChecks.CurrencyID;


   SET SWP_Ret_Value = 0;
END