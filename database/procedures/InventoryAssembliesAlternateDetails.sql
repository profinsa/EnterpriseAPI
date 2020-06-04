CREATE PROCEDURE InventoryAssembliesAlternateDetails (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_AssemblyID NATIONAL VARCHAR(36),
	v_ItemID NATIONAL VARCHAR(36)) BEGIN 
   SELECT
   CompanyID,
			DivisionID,
			DepartmentID,
			AssemblyID,
			ItemID as ItemID,
			AlternateItemID as AlternateItemID,
			NumberOfItemsInAssembly as NumberOfItemsInAssembly,
			CurrencyID as CurrencyID,
			CurrencyExchangeRate as CurrencyExchangeRate,
			LaborCost as LaborCost,
			WarehouseID as WarehouseID,
			WarehouseBinID as WarehouseBinID,
			Approved as Approved,
			ApprivedBy as ApprivedBy,
			ApprovedDate as ApprovedDate,
			EnteredBy as EnteredBy,
			LockedBy as LockedBy,
			LockTS as LockTS
   FROM
   InventoryAssembliesAlternate AS InventoryAssembliesAlternateDetails
   WHERE
   CompanyID = v_CompanyID
   AND
   DivisionID = v_DivisionID
   AND
   DepartmentID = v_DepartmentID
   AND
   AssemblyID = v_AssemblyID
   AND
   ItemID = v_ItemID;
END