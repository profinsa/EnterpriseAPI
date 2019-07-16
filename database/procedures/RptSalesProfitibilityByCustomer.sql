CREATE PROCEDURE RptSalesProfitibilityByCustomer (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),INOUT SWP_Ret_Value INT) BEGIN









   DECLARE v_DefaultCostingMethod NATIONAL VARCHAR(1);
   DECLARE v_CompanyCurrencyID NATIONAL VARCHAR(3);
   select   DefaultInventoryCostingMethod, CurrencyID INTO v_DefaultCostingMethod,v_CompanyCurrencyID FROM
   Companies WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID;


   SELECT
   InvoiceHeader.CustomerID,
	CustomerInformation.CustomerName,
	fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,(SELECT SUM(CASE v_DefaultCostingMethod
      WHEN 'F' THEN IFNULL(InventoryItems.FIFOValue,0)*InvoiceDetail.OrderQty
      WHEN 'L' THEN IFNULL(InventoryItems.LIFOValue,0)*InvoiceDetail.OrderQty
      WHEN 'A' THEN IFNULL(InventoryItems.AverageValue,0)*InvoiceDetail.OrderQty
      ELSE 0
      END)
      FROM
      InventoryItems INNER JOIN InvoiceDetail ON
      InventoryItems.CompanyID = InvoiceDetail.CompanyID AND
      InventoryItems.DivisionID = InvoiceDetail.DivisionID AND
      InventoryItems.DepartmentID = InvoiceDetail.DepartmentID AND
      InventoryItems.ItemID = InvoiceDetail.ItemID
      WHERE
      InventoryItems.CompanyID = v_CompanyID AND
      InventoryItems.DivisionID = v_DivisionID AND
      InventoryItems.DepartmentID = v_DepartmentID AND
      InventoryItems.ItemID = InvoiceDetail.ItemID 
      GROUP BY
      InventoryItems.ItemID),
   v_CompanyCurrencyID) AS TotalCost,
	fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,(SELECT
      SUM(Total)
      FROM
      InvoiceHeader
      WHERE
      InvoiceHeader.CustomerID = CustomerInformation.CustomerID
      GROUP BY
      InvoiceHeader.CustomerID),v_CompanyCurrencyID) AS Total
   FROM
   InvoiceHeader INNER JOIN CustomerInformation ON
   InvoiceHeader.CompanyID = CustomerInformation.CompanyID AND
   InvoiceHeader.DivisionID = CustomerInformation.DivisionID AND
   InvoiceHeader.DepartmentID = CustomerInformation.DepartmentID AND
   InvoiceHeader.CustomerID = CustomerInformation.CustomerID
   WHERE
   InvoiceHeader.CompanyID = v_CompanyID AND
   InvoiceHeader.DivisionID = v_DivisionID AND
   InvoiceHeader.DepartmentID = v_DepartmentID AND
   InvoiceHeader.Posted = 1 AND
   InvoiceHeader.TransactionTypeID = 'Order'
   GROUP BY
   InvoiceHeader.CustomerID,CustomerInformation.CustomerName,CustomerInformation.CustomerID;
	
	
   SET SWP_Ret_Value = 0;
END