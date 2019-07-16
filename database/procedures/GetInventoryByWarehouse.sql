CREATE PROCEDURE GetInventoryByWarehouse (v_CompanyID NATIONAL VARCHAR(36),
 v_DivisionID NATIONAL VARCHAR(36),
 v_DepartmentID NATIONAL VARCHAR(36),
 v_ItemID NATIONAL VARCHAR(72),
 v_WarehouseID NATIONAL VARCHAR(72),
 v_WarehouseBinID NATIONAL VARCHAR(72)) BEGIN
   SELECT DISTINCT
   InventoryByWarehouse.CompanyID,
	InventoryByWarehouse.DivisionID,
	InventoryByWarehouse.DepartmentID,
	InventoryByWarehouse.ItemID,
	InventoryByWarehouse.WarehouseID,
	InventoryByWarehouse.WarehouseBinID,
	InventoryByWarehouse.QtyOnHand,
	InventoryByWarehouse.QtyOnOrder
   FROM InventoryByWarehouse
   WHERE
   InventoryByWarehouse.CompanyID = v_CompanyID AND
   InventoryByWarehouse.DivisionID = v_DivisionID AND
   InventoryByWarehouse.DepartmentID = v_DepartmentID AND
   InventoryByWarehouse.ItemID = v_ItemID AND
   InventoryByWarehouse.WarehouseID = v_WarehouseID AND
   InventoryByWarehouse.WarehouseBinID = v_WarehouseBinID;
END