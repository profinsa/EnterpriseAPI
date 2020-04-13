CREATE PROCEDURE RptListInvoiceDetail (v_CompanyID NATIONAL VARCHAR(36), 
 v_DivisionID NATIONAL VARCHAR(36), 
 v_DepartmentID NATIONAL VARCHAR(36)) BEGIN



   SELECT
	
	
	
	
	
   ItemID,
	InvoiceDetail.WarehouseID, 
	
	OrderQty, 
	
	
	
	
	
	
	
	
	
	
	cast(fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,ItemUnitPrice,N'') as SIGNED INTEGER) AS ItemUnitPrice,
	CurrencyTypes.CurrencyID,
	CurrencyTypes.CurrenycySymbol,
	cast(fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,InvoiceDetail.Total,InvoiceHeader.CurrencyID) as SIGNED INTEGER) AS Total, 
	
	
	ProjectID
	
	
	
	
	
	
   FROM InvoiceDetail
   INNER JOIN InvoiceHeader ON
   InvoiceHeader.CompanyID = InvoiceDetail.CompanyID and
   InvoiceHeader.DivisionID = InvoiceDetail.DivisionID and
   InvoiceHeader.DepartmentID = InvoiceDetail.DepartmentID and
   InvoiceHeader.InvoiceNumber = InvoiceDetail.InvoiceNumber
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