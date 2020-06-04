CREATE PROCEDURE RptSalesItemHistorySummary (v_CompanyID NATIONAL VARCHAR(36),
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
	
	
	fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,SUM(CASE InvoiceDetailHistory.CurrencyID
   WHEN v_CurrencyID THEN InvoiceDetailHistory.Total
   ELSE InvoiceDetailHistory.Total*InvoiceDetailHistory.CurrencyExchangeRate
   END),
   v_CurrencyID) AS Total
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
   InvoiceHeaderHistory.Posted = 1
   GROUP BY
   InventoryItems.ItemID,InventoryItems.ItemName,InventoryItems.ItemDescription;
   SET SWP_Ret_Value = 0;
END