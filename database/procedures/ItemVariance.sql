CREATE PROCEDURE ItemVariance (v_AssemblyID NATIONAL VARCHAR(36)) BEGIN
   SELECT
   Distinct I.ItemID,
		WH.QtyOnHand AS QtyIssued,
		I.NumberOfItemsInAssembly AS QtyExpected,
		I.NumberOfItemsInAssembly -WH.QtyOnHand AS Variance,
		IT.Price AS `Value`
   FROM
   InventoryAssemblies	I
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
   WH.ItemID = IT.ItemID;
END