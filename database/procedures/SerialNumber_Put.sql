CREATE PROCEDURE SerialNumber_Put (v_CompanyID NATIONAL VARCHAR(36), 
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_WarehouseID NATIONAL VARCHAR(36),
	v_WarehouseBinID NATIONAL VARCHAR(36),
	v_PurchaseNumber NATIONAL VARCHAR(36),
	v_PurchaseLineNumber NUMERIC(18,0),
	v_SerialNumber NATIONAL VARCHAR(50),
	v_ItemID NATIONAL VARCHAR(36),
	v_ReceivedDate DATETIME,
	v_OrderQty INT,INOUT SWP_Ret_Value INT) SWL_return:
BEGIN








   DECLARE v_ReturnStatus INT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(250);

   DECLARE v_ErrorID INT;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
   END;
   SET @SWV_Error = 0;
   IF v_SerialNumber IS NULL OR v_SerialNumber = '' then
      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;
   end if;

   START TRANSACTION;

   IF EXISTS(SELECT * FROM InventorySerialNumbers
   WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   ItemID = v_ItemID AND
   PurchaseOrderNumber = v_PurchaseNumber AND
   PurchaseOrderLineNumber = v_PurchaseLineNumber AND
   WarehouseID = v_WarehouseID AND
   WarehouseBinID = v_WarehouseBinID) then
		
      SET @SWV_Error = 0;
      UPDATE
      InventorySerialNumbers
      SET
      OriginalLotOrderQty = OriginalLotOrderQty+v_OrderQty,CurrentLotOrderQty = CurrentLotOrderQty+v_OrderQty
      WHERE
      CompanyID = v_CompanyID AND
      DivisionID = v_DivisionID AND
      DepartmentID = v_DepartmentID AND
      ItemID = v_ItemID AND
      PurchaseOrderNumber = v_PurchaseNumber AND
      PurchaseOrderLineNumber = v_PurchaseLineNumber AND
      WarehouseID = v_WarehouseID AND
      WarehouseBinID = v_WarehouseBinID;
      IF @SWV_Error <> 0 then
			
         SET v_ErrorMessage = 'Update InventorySerialNumbers failed';
         ROLLBACK;
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'SerialNumber_Put',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseNumber',v_PurchaseNumber);
         SET SWP_Ret_Value = -1;
      end if;
   ELSE
      SET @SWV_Error = 0;
      INSERT INTO
      InventorySerialNumbers(CompanyID,
					DivisionID,
					DepartmentID,
					ItemID,
					SerialNumber,
					PurchaseOrderNumber,
					PurchaseOrderLineNumber,
					DateReceived,
					OriginalLotOrderQty,
					CurrentLotOrderQty,
					WarehouseID,
					WarehouseBinID)
			VALUES(v_CompanyID,
					v_DivisionID,
					v_DepartmentID,
					v_ItemID,
					v_SerialNumber,
					v_PurchaseNumber,
					v_PurchaseLineNumber,
					v_ReceivedDate,
					v_OrderQty,
					v_OrderQty,
					v_WarehouseID,
					v_WarehouseBinID);
			
      IF @SWV_Error <> 0 then
			
         SET v_ErrorMessage = 'Insert InventorySerialNumbers failed';
         ROLLBACK;
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'SerialNumber_Put',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseNumber',v_PurchaseNumber);
         SET SWP_Ret_Value = -1;
      end if;
   end if;

   COMMIT;
   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;









   ROLLBACK;
   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'SerialNumber_Put',v_ErrorMessage,
   v_ErrorID);

   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseNumber',v_PurchaseNumber);

   SET SWP_Ret_Value = -1;
END