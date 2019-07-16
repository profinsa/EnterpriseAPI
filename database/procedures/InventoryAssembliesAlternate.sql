CREATE PROCEDURE InventoryAssembliesAlternate (
	
v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_AssemblyID NATIONAL VARCHAR(36),
	v_ItemID NATIONAL VARCHAR(36),
	v_AlternateItemID NATIONAL VARCHAR(36),
	v_NumberOfItemsInAssembly INT,
	v_LaborCost NATIONAL VARCHAR(3),
	v_WarehouseID NATIONAL VARCHAR(36),
	v_WarehouseIDBinID NATIONAL VARCHAR(36),INOUT SWP_Ret_Value INT) SWL_return:
BEGIN
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);
   DECLARE v_Cnt INT;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
   END;
   WriteError:
   BEGIN
      select   COUNT(*) INTO v_Cnt FROM
      InventoryAssembliesAlternate WHERE
      CompanyID = v_CompanyID
      AND
      DivisionID = v_DivisionID
      AND
      DepartmentID = v_DepartmentID
      AND
      ItemID = v_ItemID;
      IF v_Cnt >= 10 then
		
         SET SWP_Ret_Value = 0;
         LEAVE SWL_return;
      end if;
      START TRANSACTION;
      SET @SWV_Error = 0;
      INSERT INTO InventoryAssembliesAlternate(CompanyID
			,DivisionID
			,DepartmentID
			,AssemblyID
			,ItemID
			,AlternateItemID
			,NumberOfItemsInAssembly
			,LaborCost
			,WarehouseID
			,WarehouseBinID)
		VALUES(v_CompanyID
			,v_DivisionID
			,v_DepartmentID
			,v_AssemblyID
			,v_ItemID
			,v_AlternateItemID
			,v_NumberOfItemsInAssembly
			,v_LaborCost
			,v_WarehouseID
			,v_WarehouseIDBinID);
	
	
      IF @SWV_Error <> 0 then
	
         SET v_ErrorMessage = 'CompaniesNextNumbers update failed';
         LEAVE WriteError;
      end if;
	
      COMMIT;
      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;
   END;
   ROLLBACK;
END