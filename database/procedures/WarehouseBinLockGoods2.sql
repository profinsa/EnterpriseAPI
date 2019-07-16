CREATE PROCEDURE WarehouseBinLockGoods2 (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_WarehouseID NATIONAL VARCHAR(36),
	v_WarehouseBinID NATIONAL VARCHAR(36),
	v_InventoryItemID NATIONAL VARCHAR(36),
	v_Qty FLOAT,
	v_BackQty FLOAT,
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


   IF(SELECT COUNT(*) FROM InventoryByWarehouse
   WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   ItemID = v_InventoryItemID AND
   WarehouseID = v_WarehouseID AND
   WarehouseBinID = v_WarehouseBinID) = 0 then
		
      SET @SWV_Error = 0;
      INSERT INTO InventoryByWarehouse(CompanyID,
					DivisionID,
					DepartmentID,
					ItemID,
					WarehouseID,
					WarehouseBinID,
					QtyOnHand,
					QtyCommitted,
					QtyOnOrder,
					QtyOnBackorder)
			VALUES(v_CompanyID,
					v_DivisionID,
					v_DepartmentID,
					v_InventoryItemID,
					v_WarehouseID,
					v_WarehouseBinID,
					0,
					0,
					0,
					0);
			
      IF @SWV_Error <> 0 then
			
         SET v_ErrorMessage = 'Insert InventoryByWarehouse bin failed';
         ROLLBACK;
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'WarehouseBinLockGoods',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'WarehouseID',v_WarehouseID);
         SET SWP_Ret_Value = -1;
      end if;
   end if;

   SET @SWV_Error = 0;
   UPDATE WarehouseBins
   SET
   LockerStockQty =
   CASE v_Action
   WHEN 1 THEN IFNULL(LockerStockQty,0)+v_Qty
   WHEN 2 THEN IFNULL(LockerStockQty,0) -(v_Qty -v_BackQty)
   WHEN 3 THEN IFNULL(LockerStockQty,0) -v_Qty
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
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'WarehouseBinLockGoods',v_ErrorMessage,
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
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'WarehouseBinLockGoods',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'WarehouseID',v_WarehouseID);
      SET SWP_Ret_Value = -1;
   end if;

   SET @SWV_Error = 0;
   UPDATE
   InventoryByWarehouse
   SET
   QtyOnHand =
   CASE v_Action
   WHEN 1 THEN IFNULL(QtyOnHand,0) - v_Qty
   WHEN 2 THEN IFNULL(QtyOnHand,0) + (v_Qty -v_BackQty)
   WHEN 3 THEN IFNULL(QtyOnHand,0) + v_Qty
   ELSE IFNULL(QtyOnHand,0)
   END,QtyCommitted =
   CASE v_Action
   WHEN 1 THEN IFNULL(QtyCommitted,0) + v_Qty
   WHEN 2 THEN IFNULL(QtyCommitted,0) - (v_Qty -v_BackQty)
   WHEN 3 THEN IFNULL(QtyCommitted,0) - v_Qty
   ELSE IFNULL(QtyCommitted,0)
   END,QtyOnBackorder =
   CASE v_Action
   WHEN 1 THEN IFNULL(QtyOnBackorder,0)+v_BackQty
   WHEN 2 THEN
      CASE
      WHEN IFNULL(QtyOnBackorder,0) -v_BackQty >= 0
      THEN IFNULL(QtyOnBackorder,0) -v_BackQty
      ELSE 0
      END
   WHEN 3 THEN
      CASE
      WHEN IFNULL(QtyOnBackorder,0) -v_BackQty >= 0
      THEN IFNULL(QtyOnBackorder,0) -v_BackQty
      ELSE 0
      END
   ELSE IFNULL(QtyOnBackorder,0)
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
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'WarehouseBinLockGoods',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'WarehouseID',v_WarehouseID);
      SET SWP_Ret_Value = -1;
   end if;



   COMMIT;

   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;


   ROLLBACK;

   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'WarehouseBinLockGoods',v_ErrorMessage,
   v_ErrorID);
   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'WarehouseID',v_WarehouseID);
	
   SET SWP_Ret_Value = -1;

END