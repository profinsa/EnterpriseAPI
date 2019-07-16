CREATE PROCEDURE InventoryAssembliesAlternateSelect (v_CompanyID VARCHAR(72),v_DivisionID VARCHAR(72),v_DepartmentID VARCHAR(72),
	v_AssemblyID VARCHAR(72),v_ItemID VARCHAR(72)) BEGIN
   SELECT
   ItemID,AlternateItemID,NumberOfItemsInAssembly,LaborCost,WarehouseID,WarehouseBinID
   FROM
   InventoryAssembliesAlternate
   WHERE
   CompanyID = v_CompanyID AND DivisionID = v_DivisionID AND DepartmentID = v_DepartmentID
   AND AssemblyID = v_AssemblyID AND ItemID = v_ItemID;
END