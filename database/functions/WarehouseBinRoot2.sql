CREATE FUNCTION WarehouseBinRoot2 (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_WarehouseID NATIONAL VARCHAR(36),
	v_WarehouseBinID NATIONAL VARCHAR(36),
	v_InventoryItemID NATIONAL VARCHAR(36)) BEGIN

	
   IF v_WarehouseBinID IS NULL OR RTRIM(v_WarehouseBinID) = '' then
		
      select   ItemDefaultWarehouseBin INTO v_WarehouseBinID FROM
      InventoryItems WHERE
      CompanyID = v_CompanyID AND
      DivisionID = v_DivisionID AND
      DepartmentID = v_DepartmentID AND
      ItemID = v_InventoryItemID AND
      ItemDefaultWarehouse = v_WarehouseID;
      IF v_WarehouseBinID IS NULL OR RTRIM(v_WarehouseBinID) = '' then
				
         select   WarehouseBinID INTO v_WarehouseBinID FROM
         InventoryByWarehouse WHERE
         CompanyID = v_CompanyID AND
         DivisionID = v_DivisionID AND
         DepartmentID = v_DepartmentID AND
         ItemID = v_InventoryItemID AND
         WarehouseID = v_WarehouseID AND
         WarehouseBinID <> 'Overflow'   LIMIT 1;
      end if;
      IF v_WarehouseBinID IS NULL OR RTRIM(v_WarehouseBinID) = '' then
         SET v_WarehouseBinID = 'Overflow';
      end if;
   end if;
	
   RETURN v_WarehouseBinID;

END