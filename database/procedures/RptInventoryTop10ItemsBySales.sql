CREATE PROCEDURE RptInventoryTop10ItemsBySales (v_CompanyID NATIONAL VARCHAR(36),
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
	InventoryItems.Price as UnitPrice,
	InventoryItems.FIFOValue as UnitCost,
	fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,SUM(InvoiceDetail.OrderQty),InvoiceDetail.CurrencyID) AS Units,
	fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,SUM(InvoiceDetail.OrderQty*InvoiceDetail.ItemUnitPrice),
   InvoiceDetail.CurrencyID) AS Total,
	fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,SUM(InvoiceDetail.OrderQty*InvoiceDetail.ItemCost),
   InvoiceDetail.CurrencyID) AS Cost,
	fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,SUM(InvoiceDetail.Total -InvoiceDetail.OrderQty*InvoiceDetail.ItemCost),InvoiceDetail.CurrencyID) AS Profit
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
   InventoryItems.ItemID,InventoryItems.ItemName,InventoryItems.ItemDescription,
   InventoryItems.Price,InventoryItems.FIFOValue,InvoiceDetail.CurrencyID LIMIT 10;

   SET SWP_Ret_Value = 0;
END