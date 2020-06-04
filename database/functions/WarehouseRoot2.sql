CREATE FUNCTION WarehouseRoot2 (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_WarehouseID NATIONAL VARCHAR(36),
	v_InventoryItemID NATIONAL VARCHAR(36)) BEGIN

   IF v_WarehouseID IS NULL OR RTRIM(v_WarehouseID) = '' then
		
      select   ItemDefaultWarehouse INTO v_WarehouseID FROM
      InventoryItems WHERE
      CompanyID = v_CompanyID AND
      DivisionID = v_DivisionID AND
      DepartmentID = v_DepartmentID AND
      ItemID = v_InventoryItemID;
      IF v_WarehouseID IS NULL OR RTRIM(v_WarehouseID) = '' then
         SET v_WarehouseID = 'DEFAULT';
      end if;
   end if;
	
   RETURN v_WarehouseID;

END