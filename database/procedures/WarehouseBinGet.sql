CREATE PROCEDURE WarehouseBinGet (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_InventoryItemID NATIONAL VARCHAR(36),
	INOUT v_WarehouseID NATIONAL VARCHAR(36) ,
	INOUT v_WarehouseBinID NATIONAL VARCHAR(36) ,INOUT SWP_Ret_Value INT) BEGIN











   SET v_WarehouseID = WarehouseRoot2(v_CompanyID,v_DivisionID,v_DepartmentID,v_WarehouseID,v_InventoryItemID);

   SET v_WarehouseBinID = WarehouseBinRoot2(v_CompanyID,v_DivisionID,v_DepartmentID,v_WarehouseID,v_WarehouseBinID,
   v_InventoryItemID);



   SET SWP_Ret_Value = 0;

END