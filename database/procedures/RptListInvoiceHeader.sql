CREATE PROCEDURE RptListInvoiceHeader (v_CompanyID NATIONAL VARCHAR(36), 
 v_DivisionID NATIONAL VARCHAR(36), 
 v_DepartmentID NATIONAL VARCHAR(36)) BEGIN



   SELECT
	
	
	
   InvoiceNumber, 
	
	
	
	InvoiceDate,
	InvoiceDueDate, 
	
	
	
	
	
	
	CustomerID,
	TermsID, 
	
	
	
	
	
	
	
	
	
	
	
	
	CurrencyTypes.CurrencyID,
	CurrencyTypes.CurrenycySymbol,
	cast(fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,Total,InvoiceHeader.CurrencyID) as SIGNED INTEGER) AS Total,
	EmployeeID
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	

   FROM InvoiceHeader
   INNER JOIN CurrencyTypes ON
   InvoiceHeader.CompanyID = CurrencyTypes.CompanyID and
   InvoiceHeader.DivisionID = CurrencyTypes.DivisionID and
   InvoiceHeader.DepartmentID = CurrencyTypes.DepartmentID and
   InvoiceHeader.CurrencyID = CurrencyTypes.CurrencyID
   WHERE
   InvoiceHeader.CompanyID = v_CompanyID and
   InvoiceHeader.DivisionID = v_DivisionID and
   InvoiceHeader.DepartmentID = v_DepartmentID;
END