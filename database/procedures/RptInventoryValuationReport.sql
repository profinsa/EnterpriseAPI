CREATE PROCEDURE RptInventoryValuationReport (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),INOUT SWP_Ret_Value INT) BEGIN











   DECLARE v_DefaultInventoryMethod NATIONAL VARCHAR(1);


   DECLARE v_CompanyCurrencyID NATIONAL VARCHAR(3);
   select   DefaultInventoryCostingMethod INTO v_DefaultInventoryMethod FROM
   Companies WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID;


   select   IFNULL(CurrencyID,N'') INTO v_CompanyCurrencyID FROM Companies WHERE CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID   LIMIT 1;
	


   SELECT
   InventoryItems.ItemID,
	InventoryItems.ItemName,
	InventoryItems.ItemDescription,
	InventoryItems.IsActive,
	InventoryByWarehouse.WarehouseID,
	InventoryByWarehouse.WarehouseBinID,
	fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,CASE v_DefaultInventoryMethod
   WHEN 'F' THEN FIFOValue*QtyOnHand 
   WHEN 'L' THEN LIFOValue*QtyOnHand 
   WHEN 'A' THEN AverageValue*QtyOnHand 
   ELSE 0
   END,v_CompanyCurrencyID) AS Valuation
   FROM
   InventoryItems INNER JOIN InventoryByWarehouse ON
   InventoryItems.ItemID = InventoryByWarehouse.ItemID AND
   InventoryItems.CompanyID = InventoryByWarehouse.CompanyID AND
   InventoryItems.DivisionID = InventoryByWarehouse.DivisionID AND
   InventoryItems.DepartmentID = InventoryByWarehouse.DepartmentID
   WHERE
   InventoryItems.CompanyID = v_CompanyID AND
   InventoryItems.DivisionID = v_DivisionID AND
   InventoryItems.DepartmentID = v_DepartmentID AND
   InventoryByWarehouse.QtyOnHand <> 0;
	

   SET SWP_Ret_Value = 0;
END