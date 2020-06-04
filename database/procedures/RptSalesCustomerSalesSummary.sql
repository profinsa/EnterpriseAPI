CREATE PROCEDURE RptSalesCustomerSalesSummary (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),INOUT SWP_Ret_Value INT) BEGIN









   DECLARE v_CurrencyID NATIONAL VARCHAR(3);


   select   CurrencyID INTO v_CurrencyID FROM
   Companies WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID;



   SELECT
   CustomerInformation.CustomerID,
	CustomerInformation.CustomerName,
	fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,SUM(IFNULL(InvoiceDetail.Total,0)),
   N'') as Total
   FROM
   CustomerInformation INNER JOIN InvoiceHeader ON
   CustomerInformation.CompanyID = InvoiceHeader.CompanyID AND
   CustomerInformation.DivisionID = InvoiceHeader.DivisionID AND
   CustomerInformation.DepartmentID = InvoiceHeader.DepartmentID AND
   CustomerInformation.CustomerID = InvoiceHeader.CustomerID
   INNER JOIN InvoiceDetail ON
   InvoiceHeader.CompanyID = InvoiceDetail.CompanyID AND
   InvoiceHeader.DivisionID = InvoiceDetail.DivisionID AND
   InvoiceHeader.DepartmentID = InvoiceDetail.DepartmentID AND
   InvoiceHeader.InvoiceNumber = InvoiceDetail.InvoiceNumber
   WHERE
   InvoiceHeader.CompanyID = v_CompanyID AND
   InvoiceHeader.DivisionID = v_DivisionID AND
   InvoiceHeader.DepartmentID = v_DepartmentID AND
   InvoiceHeader.Posted = 1 


   GROUP BY
   CustomerInformation.CustomerID,CustomerInformation.CustomerName;

   SET SWP_Ret_Value = 0;
END