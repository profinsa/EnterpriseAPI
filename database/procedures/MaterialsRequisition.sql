CREATE PROCEDURE MaterialsRequisition (v_AssemblyID NATIONAL VARCHAR(36),
	v_QtytoProduce INT) BEGIN
	

   SELECT
   Distinct I.ItemID as ItemID,
		IT.ItemDescription As ItemDescription,
		I.NumberOfItemsInAssembly*v_QtytoProduce AS QtyRequired,
		WH.QtyOnHand AS QtyAvailable,
		(I.NumberOfItemsInAssembly*v_QtytoProduce) -WH.QtyOnHand AS QtyShortage,
		IT.Price*((I.NumberOfItemsInAssembly*v_QtytoProduce) -WH.QtyOnHand) AS  ShortageValue
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