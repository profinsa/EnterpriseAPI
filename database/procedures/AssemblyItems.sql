CREATE PROCEDURE AssemblyItems (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_AssemblyID NATIONAL VARCHAR(36)) BEGIN






   SELECT DISTINCT
   InventoryAssemblies.AssemblyID AS AssemblyID ,
		InventoryAssemblies.ItemID AS ItemID,
		InventoryAssemblies.NumberOfItemsInAssembly AS NumberOfItems,
		InventoryAssemblies.WarehouseID AS WarehouseID,
		InventoryAssemblies.WarehouseBinID AS WarehouseBinID,      
		
		
		InventoryItems.ItemName AS ItemName,
		InventoryItems.ItemDescription AS ItemDescription,
		InventoryItems.Price AS Price
   FROM
   InventoryAssemblies
   LEFT OUTER JOIN
   InventoryItems
   ON
   InventoryItems.CompanyID = InventoryAssemblies.CompanyID
   AND
   InventoryItems.DivisionID = InventoryAssemblies.DivisionID
   AND
   InventoryItems.DepartmentID = InventoryAssemblies.DepartmentID
   AND
   InventoryItems.ItemID = InventoryAssemblies.ItemID
   WHERE
   InventoryAssemblies.CompanyID = v_CompanyID
   AND
   InventoryAssemblies.DivisionID = v_DivisionID
   AND
   InventoryAssemblies.DepartmentID = v_DepartmentID
   AND
   InventoryAssemblies.AssemblyID = v_AssemblyID;
END