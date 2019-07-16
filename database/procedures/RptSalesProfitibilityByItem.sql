CREATE PROCEDURE RptSalesProfitibilityByItem (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),INOUT SWP_Ret_Value INT) BEGIN


















   SELECT
   InventoryItems.ItemID,
	InventoryItems.ItemName,
	InventoryItems.ItemDescription,
	(
		
		
		SELECT
      fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,SUM(InvoiceDetail.ItemCost*InvoiceDetail.OrderQty),
      N'')
      FROM
      InvoiceDetail INNER JOIN InvoiceHeader ON
      InvoiceDetail.CompanyID = InvoiceHeader.CompanyID AND
      InvoiceDetail.DivisionID = InvoiceHeader.DivisionID AND
      InvoiceDetail.DepartmentID = InvoiceHeader.DepartmentID AND
      InvoiceDetail.ItemID = InventoryItems.ItemID
      WHERE
      InvoiceHeader.CompanyID = v_CompanyID AND
      InvoiceHeader.DivisionID = v_DivisionID AND
      InvoiceHeader.DepartmentID  = v_DepartmentID AND
      InvoiceHeader.Posted = 1 AND 
      InvoiceHeader.TransactionTypeID = 'Order'
      GROUP BY
      InvoiceDetail.ItemID) AS TotalCost,
	(
		
		
		SELECT
      fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,SUM(InvoiceDetail.ItemUnitPrice*InvoiceDetail.OrderQty),
      N'')
      FROM
      InvoiceDetail INNER JOIN InvoiceHeader ON
      InvoiceDetail.CompanyID = InvoiceHeader.CompanyID AND
      InvoiceDetail.DivisionID = InvoiceHeader.DivisionID AND
      InvoiceDetail.DepartmentID = InvoiceHeader.DepartmentID AND
      InvoiceDetail.ItemID = InventoryItems.ItemID
      WHERE
      InvoiceHeader.CompanyID = v_CompanyID AND
      InvoiceHeader.DivisionID = v_DivisionID AND
      InvoiceHeader.DepartmentID  = v_DepartmentID AND
      InvoiceHeader.Posted = 1  AND
      InvoiceHeader.TransactionTypeID = 'Order'
      GROUP BY
      InvoiceDetail.ItemID) AS Total
   FROM
   InventoryItems
   WHERE
   InventoryItems.CompanyID = v_CompanyID AND
   InventoryItems.DivisionID = v_DivisionID AND
   InventoryItems.DepartmentID = v_DepartmentID AND
   InventoryItems.IsActive = 1; 
		


	
   SET SWP_Ret_Value = 0;
END