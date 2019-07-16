CREATE PROCEDURE Inventory_CreateFromAssembly2 (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_AssemblyID NATIONAL VARCHAR(36),INOUT SWP_Ret_Value INT) SWL_return:
BEGIN












   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);


   DECLARE v_AssemblyWheight FLOAT;
   DECLARE v_DefaultInventoryCostingMethod NATIONAL VARCHAR(1);
   DECLARE v_GLItemSalesAccount NATIONAL VARCHAR(36);
   DECLARE v_GLItemCOGSAccount NATIONAL VARCHAR(36);
   DECLARE v_GLItemInventoryAccount NATIONAL VARCHAR(36);
   DECLARE v_Price DECIMAL(19,4);

   DECLARE v_ErrorID INT;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
   END;
   SET @SWV_Error = 0;
   IF EXISTS(SELECT ItemID
   FROM InventoryItems
   WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND ItemID = v_AssemblyID) then
      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;
   end if;

   START TRANSACTION;

   select   IFNULL(DefaultInventoryCostingMethod,'F'), GLARSalesAccount, GLARCOGSAccount, GLARInventoryAccount INTO v_DefaultInventoryCostingMethod,v_GLItemSalesAccount,v_GLItemCOGSAccount,
   v_GLItemInventoryAccount FROM
   Companies WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID;

   select   Sum(IFNULL(ItemWeight,0)), Sum((CASE(v_DefaultInventoryCostingMethod)
   WHEN 'F' THEN IFNULL(FIFOCost,0)
   WHEN 'L' THEN IFNULL(LIFOCost,0)
   WHEN 'A' THEN IFNULL(AverageValue,0)
   ELSE 0
   END)*NumberOfItemsInAssembly+IFNULL(LaborCost,0)) INTO v_AssemblyWheight,v_Price FROM InventoryItems
   INNER JOIN InventoryAssemblies ON
   InventoryAssemblies.CompanyID = InventoryItems.CompanyID AND
   InventoryAssemblies.DivisionID = InventoryItems.DivisionID AND
   InventoryAssemblies.DepartmentID = InventoryItems.DepartmentID AND
   InventoryAssemblies.ItemID = InventoryItems.ItemID WHERE
   InventoryAssemblies.CompanyID = v_CompanyID AND
   InventoryAssemblies.DivisionID = v_DivisionID AND
   InventoryAssemblies.DepartmentID = v_DepartmentID AND
   InventoryAssemblies.AssemblyID = v_AssemblyID;



   SET @SWV_Error = 0;
   INSERT INTO InventoryItems(CompanyID,
	DivisionID,
	DepartmentID,
	ItemID,
	IsActive,
	ItemTypeID,
	ItemName,
	ItemDescription,
	ItemWeight,
	ItemDefaultWarehouse,
	ItemDefaultWarehouseBin,
	GLItemSalesAccount,
	GLItemCOGSAccount,
	GLItemInventoryAccount,
	Price,
	Taxable,
	IsAssembly,
	ItemAssembly,
	LIFO,
	LIFOValue,
	LIFOCost,
	Average,
	AverageValue,
	AverageCost,
	FIFO,
	FIFOValue,
	FIFOCost,
	Expected,
	ExpectedValue,
	ExpectedCost)
   SELECT 
   CompanyID,
		DivisionID,
		DepartmentID,
		v_AssemblyID,
		1,
		'Stock',
		v_AssemblyID,
		v_AssemblyID,
		v_AssemblyWheight,
		WarehouseID,
		WarehouseBinID,
		v_GLItemSalesAccount,
		v_GLItemCOGSAccount,
		v_GLItemInventoryAccount,
		v_Price,
		0,
		1,
		NULL, 
		0, 
		0, 
		0, 
		0, 
		0, 
		0, 
		0, 
		0, 
		0, 
		0, 
		0, 
		0 
   FROM
   InventoryAssemblies
   WHERE
   InventoryAssemblies.CompanyID = v_CompanyID AND
   InventoryAssemblies.DivisionID = v_DivisionID AND
   InventoryAssemblies.DepartmentID = v_DepartmentID AND
   InventoryAssemblies.AssemblyID = v_AssemblyID LIMIT 1;



   IF @SWV_Error <> 0 then


      SET v_ErrorMessage = 'Insert into InventoryAssembliesInstructions failed';
      ROLLBACK;

      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Inventory_CreateFromAssembly',
      v_ErrorMessage,v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'AssemblyID',v_AssemblyID);
      SET SWP_Ret_Value = -1;
   end if;




   COMMIT;
   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;








   ROLLBACK;

   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Inventory_CreateFromAssembly',
   v_ErrorMessage,v_ErrorID);

   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'AssemblyID',v_AssemblyID);

   SET SWP_Ret_Value = -1;
END