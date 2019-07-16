CREATE PROCEDURE spInventoryLowStockAlert (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),INOUT SWP_Ret_Value INT) BEGIN











   SELECT
   InventoryItems.ItemID as Item,
	InventoryByWarehouse.WarehouseID as WH,
	InventoryByWarehouse.QtyOnHand as Qty,
	InventoryItems.ReOrderLevel as Rlvl,
	InventoryItems.ReOrderQty as Rqty
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
   InventoryItems.ReOrderLevel >= InventoryByWarehouse.QtyOnHand 

   ORDER BY Qty ASC,Rlvl DESC;

   SET SWP_Ret_Value = 0;
END