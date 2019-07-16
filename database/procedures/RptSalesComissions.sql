CREATE PROCEDURE RptSalesComissions (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),INOUT SWP_Ret_Value INT) BEGIN


















   SELECT
   InvoiceNumber,
	OrderNumber,
	InvoiceDate,
	EmployeeID,
	fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,Commission,CurrencyID) AS Commission,
	fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,CommissionableSales,CurrencyID) AS CommissionableSales,
	fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,ComissionalbleCost,CurrencyID) AS ComissionalbleCost,
	fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,Total,CurrencyID) AS Total,
	CurrencyID,
	CurrencyExchangeRate
   FROM
   InvoiceHeader
   WHERE
   InvoiceHeader.CompanyID = v_CompanyID AND
   InvoiceHeader.DivisionID = v_DivisionID AND
   InvoiceHeader.DepartmentID = v_DepartmentID AND
   InvoiceHeader.Posted = 1 AND 
   InvoiceHeader.CommissionPaid = 1; 
	
   SET SWP_Ret_Value = 0;
END