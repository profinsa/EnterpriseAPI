CREATE PROCEDURE WarehouseBinShipGoods2 (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_WarehouseID NATIONAL VARCHAR(36),
	v_WarehouseBinID NATIONAL VARCHAR(36),
	v_InventoryItemID NATIONAL VARCHAR(36),
	v_Qty FLOAT,
	v_BackOrderQty FLOAT,
	v_Action INT,INOUT SWP_Ret_Value INT) SWL_return:
BEGIN













   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);
   DECLARE v_ErrorID INT;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
   END;


   SET @SWV_Error = 0;
   START TRANSACTION;


   SET @SWV_Error = 0;
   UPDATE WarehouseBins
   SET
   LockerStockQty =
   CASE v_Action
   WHEN 1 THEN IFNULL(LockerStockQty,0) -v_Qty+v_BackOrderQty
   WHEN 2 THEN IFNULL(LockerStockQty,0)+v_Qty -v_BackOrderQty
   WHEN 3 THEN IFNULL(LockerStockQty,0)
   WHEN 4 THEN IFNULL(LockerStockQty,0)
   ELSE IFNULL(LockerStockQty,0)
   END
   WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   WarehouseID = v_WarehouseID AND
   WarehouseBinID = v_WarehouseBinID;
   IF @SWV_Error <> 0 then
	
      SET v_ErrorMessage = 'Updating WarehouseBins failed';
      ROLLBACK;
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'WarehouseBinShipGoods',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'WarehouseID',v_WarehouseID);
      SET SWP_Ret_Value = -1;
   end if;

   SET @SWV_Error = 0;
   UPDATE WarehouseBins
   SET
   LockerStock =
   CASE
   WHEN LockerStockQty > 0 THEN 1
   ELSE 0
   END
   WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   WarehouseID = v_WarehouseID AND
   WarehouseBinID = v_WarehouseBinID;
   IF @SWV_Error <> 0 then
	
      SET v_ErrorMessage = 'Updating WarehouseBins failed';
      ROLLBACK;
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'WarehouseBinShipGoods',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'WarehouseID',v_WarehouseID);
      SET SWP_Ret_Value = -1;
   end if;


   SET @SWV_Error = 0;
   UPDATE
   InventoryByWarehouse
   SET
   QtyCommitted =
   CASE v_Action
   WHEN 1 THEN IFNULL(QtyCommitted,0) -v_Qty+v_BackOrderQty
   WHEN 2 THEN IFNULL(QtyCommitted,0)+v_Qty  -v_BackOrderQty
   WHEN 3 THEN IFNULL(QtyCommitted,0)
   WHEN 4 THEN IFNULL(QtyCommitted,0)
   ELSE IFNULL(QtyCommitted,0)
   END,QtyOnHand =
   CASE v_Action
   WHEN 1 THEN IFNULL(QtyOnHand,0)
   WHEN 2 THEN IFNULL(QtyOnHand,0)
   WHEN 3 THEN IFNULL(QtyOnHand,0) -v_Qty
   WHEN 4 THEN IFNULL(QtyOnHand,0)+v_Qty
   ELSE IFNULL(QtyOnHand,0)
   END
   WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND WarehouseID = v_WarehouseID
   AND WarehouseBinID = v_WarehouseBinID
   AND ItemID = v_InventoryItemID;
   IF @SWV_Error <> 0 then
	
      SET v_ErrorMessage = 'Updating inventory failed';
      ROLLBACK;
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'WarehouseBinShipGoods',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'WarehouseID',v_WarehouseID);
      SET SWP_Ret_Value = -1;
   end if;


   COMMIT;

   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;


   ROLLBACK;

   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'WarehouseBinShipGoods',v_ErrorMessage,
   v_ErrorID);
   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'WarehouseID',v_WarehouseID);
	
   SET SWP_Ret_Value = -1;

END