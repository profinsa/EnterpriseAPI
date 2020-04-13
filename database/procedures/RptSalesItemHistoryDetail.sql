CREATE PROCEDURE RptSalesItemHistoryDetail (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),INOUT SWP_Ret_Value INT) BEGIN



















   SELECT
   InventoryItems.ItemID,
	InventoryItems.ItemName,
	InventoryItems.ItemDescription,
	InvoiceDetailHistory.InvoiceNumber,
	InvoiceHeaderHistory.InvoiceDate,
	InvoiceDetailHistory.OrderQty,
	fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,InvoiceDetailHistory.ItemUnitPrice,
   N'') AS ItemUnitPrice,
	fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,InvoiceDetailHistory.Total,InvoiceDetailHistory.CurrencyID) AS Total,
	InvoiceDetailHistory.CurrencyID,
	InvoiceDetailHistory.CurrencyExchangeRate
   FROM
   InventoryItems INNER JOIN InvoiceDetailHistory ON
   InventoryItems.CompanyID = InvoiceDetailHistory.CompanyID AND
   InventoryItems.DivisionID = InvoiceDetailHistory.DivisionID AND
   InventoryItems.DepartmentID = InvoiceDetailHistory.DepartmentID AND
   InventoryItems.ItemID = InvoiceDetailHistory.ItemID
   INNER JOIN InvoiceHeaderHistory ON
   InvoiceHeaderHistory.CompanyID = InvoiceDetailHistory.CompanyID AND
   InvoiceHeaderHistory.DivisionID = InvoiceDetailHistory.DivisionID AND
   InvoiceHeaderHistory.DepartmentID = InvoiceDetailHistory.DepartmentID AND
   InvoiceHeaderHistory.InvoiceNumber = InvoiceDetailHistory.InvoiceNumber
   WHERE
   InvoiceHeaderHistory.CompanyID = v_CompanyID AND
   InvoiceHeaderHistory.DivisionID = v_DivisionID AND
   InvoiceHeaderHistory.DepartmentID = v_DepartmentID AND
   InvoiceHeaderHistory.Posted = 1; 
	


   SET SWP_Ret_Value = 0;
END