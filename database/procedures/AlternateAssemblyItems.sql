CREATE PROCEDURE AlternateAssemblyItems (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_AssemblyID NATIONAL VARCHAR(36),
	v_ItemID NATIONAL VARCHAR(36)) BEGIN






   SELECT DISTINCT
   IA.AssemblyID AS AssemblyID ,
		IA.AlternateItemID AS AlternateItemID,
		IA.NumberOfItemsInAssembly AS NumberOfItems,
		IA.WarehouseID AS WarehouseID,
		IA.WarehouseBinID AS WarehouseBinID,      
		
		
		InventoryItems.ItemName AS ItemName,
		InventoryItems.ItemDescription AS ItemDescription,
		InventoryItems.Price AS Price
   FROM
   InventoryAssembliesAlternate IA
   LEFT OUTER JOIN
   InventoryItems
   ON
   InventoryItems.CompanyID = IA.CompanyID
   AND
   InventoryItems.DivisionID = IA.DivisionID
   AND
   InventoryItems.DepartmentID = IA.DepartmentID
   AND
   InventoryItems.ItemID = IA.AlternateItemID
   WHERE
   IA.CompanyID = v_CompanyID
   AND
   IA.DivisionID = v_DivisionID
   AND
   IA.DepartmentID = v_DepartmentID
   AND
   IA.AssemblyID = v_AssemblyID
   AND
   IA.ItemID = v_ItemID;
END