CREATE PROCEDURE RptSalesItemSalesDetail (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),INOUT SWP_Ret_Value INT) BEGIN


















   SELECT
   InventoryItems.ItemID,
	InventoryItems.ItemName,
	InventoryItems.ItemDescription,
	InvoiceDetail.InvoiceNumber,
	InvoiceHeader.InvoiceDate,
	InvoiceDetail.OrderQty,
	fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,InvoiceDetail.ItemUnitPrice,N'') AS ItemUnitPrice,
	fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,InvoiceDetail.Total,InvoiceDetail.CurrencyID) AS Total,
	InvoiceDetail.CurrencyID,
	InvoiceDetail.CurrencyExchangeRate
   FROM
   InventoryItems INNER JOIN InvoiceDetail ON
   InventoryItems.CompanyID = InvoiceDetail.CompanyID AND
   InventoryItems.DivisionID = InvoiceDetail.DivisionID AND
   InventoryItems.DepartmentID = InvoiceDetail.DepartmentID AND
   InventoryItems.ItemID = InvoiceDetail.ItemID
   INNER JOIN InvoiceHeader ON
   InvoiceHeader.CompanyID = InvoiceDetail.CompanyID AND
   InvoiceHeader.DivisionID = InvoiceDetail.DivisionID AND
   InvoiceHeader.DepartmentID = InvoiceDetail.DepartmentID AND
   InvoiceHeader.InvoiceNumber = InvoiceDetail.InvoiceNumber
   WHERE
   InvoiceHeader.CompanyID = v_CompanyID AND
   InvoiceHeader.DivisionID = v_DivisionID AND
   InvoiceHeader.DepartmentID = v_DepartmentID AND
   InvoiceHeader.Posted = 1; 
	


   SET SWP_Ret_Value = 0;
END