CREATE PROCEDURE GetStockDetails (v_CompanyID NATIONAL VARCHAR(36),  
	v_DivisionID NATIONAL VARCHAR(36),  
	v_DepartmentID NATIONAL VARCHAR(36),  
	v_AssemblyID NATIONAL VARCHAR(36),  
	v_ItemID NATIONAL VARCHAR(36),  
	v_WarehouseID NATIONAL VARCHAR(36),  
	v_WarehouseBinID NATIONAL VARCHAR(36)) BEGIN
   SELECT
   QtyOnHand
   FROM
   InventoryByWarehouse
   WHERE
   CompanyID = v_CompanyID
   AND
   DivisionID = v_DivisionID
   AND
   DepartmentID = v_DepartmentID
   AND
   ItemID = v_ItemID
   AND
   WarehouseID = v_WarehouseID
   AND
   WarehouseBinID = v_WarehouseBinID;
END