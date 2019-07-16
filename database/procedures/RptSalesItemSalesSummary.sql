CREATE PROCEDURE RptSalesItemSalesSummary (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),INOUT SWP_Ret_Value INT) BEGIN








   DECLARE v_CurrencyID NATIONAL VARCHAR(3);


   select   CurrencyID INTO v_CurrencyID FROM
   Companies WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID;


   SELECT
   InventoryItems.ItemID,
	InventoryItems.ItemName,
	InventoryItems.ItemDescription,
	
	fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,SUM(CASE InvoiceDetail.CurrencyID
   WHEN v_CurrencyID THEN InvoiceDetail.Total
   ELSE InvoiceDetail.Total*InvoiceDetail.CurrencyExchangeRate
   END),v_CurrencyID) AS Total
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
   InvoiceHeader.Posted = 1 
   GROUP BY
   InventoryItems.ItemID,InventoryItems.ItemName,InventoryItems.ItemDescription;
   SET SWP_Ret_Value = 0;
END