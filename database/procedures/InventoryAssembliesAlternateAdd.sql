CREATE PROCEDURE InventoryAssembliesAlternateAdd (v_CompanyID VARCHAR(72),v_DivisionID VARCHAR(72),v_DepartmentID VARCHAR(72),
	v_AssemblyID VARCHAR(72),v_ItemID VARCHAR(72),v_AlternateItemID VARCHAR(72),
	v_NumberOfItemsInAssembly INT,v_CurrencyID VARCHAR(6),
	v_CurrencyExchangeRate FLOAT,v_LaborCost DECIMAL(19,4),v_WarehouseID VARCHAR(72),
	v_WarehouseBinID VARCHAR(72),v_Approved BOOLEAN,v_ApprivedBy VARCHAR(72),
	v_ApprovedDate DATETIME,v_EnteredBy VARCHAR(72),v_LockedBy VARCHAR(72),
	v_LockTS DATETIME) BEGIN
   INSERT INTO
   InventoryAssembliesAlternate
	VALUES(v_CompanyID,v_DivisionID,v_DepartmentID,v_AssemblyID,v_ItemID,v_AlternateItemID,v_NumberOfItemsInAssembly,v_CurrencyID,
	v_CurrencyExchangeRate,v_LaborCost,v_WarehouseID,v_WarehouseBinID,v_Approved,v_ApprivedBy,v_ApprovedDate,
	v_EnteredBy,v_LockedBy,v_LockTS);
END