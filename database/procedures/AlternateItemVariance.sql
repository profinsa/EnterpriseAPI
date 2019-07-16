CREATE PROCEDURE AlternateItemVariance (v_AssemblyID NATIONAL VARCHAR(36),
	v_ItemID NATIONAL VARCHAR(36)) BEGIN






   SELECT
   DISTINCT I.AlternateItemID as AlternateItemID,
		WH.QtyOnHand AS QtyIssued,
		I.NumberOfItemsInAssembly AS QtyExpected,
		I.NumberOfItemsInAssembly -WH.QtyOnHand AS Variance,
		IT.Price AS `Value`
   FROM
   InventoryAssembliesAlternate I
   INNER JOIN
   InventoryByWarehouse WH
   ON
   I.CompanyID = WH.CompanyID
   AND
   I.DivisionID = WH.DivisionID
   AND
   I.DepartmentID = WH.DepartmentID
   AND
   I.ItemID = WH.ItemID
   AND
   I.WarehouseID = WH.WarehouseID
   AND
   I.WarehouseBinID = WH.WarehouseBinID
   AND
   I.AssemblyID = v_AssemblyID
   INNER JOIN
   InventoryItems IT
   ON
   WH.CompanyID = IT.CompanyID
   AND
   WH.DivisionID = IT.DivisionID
   AND
   WH.DepartmentID = IT.DepartmentID
   AND
   WH.ItemID = IT.ItemID
   INNER JOIN
   InventoryAssemblies IA
   ON
   I.ItemID = v_ItemID
   AND
   I.WarehouseID = IA.WarehouseID
   AND
   I.WarehouseBinID = IA.WarehouseID;
END