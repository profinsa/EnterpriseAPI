CREATE PROCEDURE Inventory_Transfer (v_CompanyID NATIONAL VARCHAR(36), 
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_ItemID NATIONAL VARCHAR(36),
	v_WarehouseID NATIONAL VARCHAR(36),
	v_WarehouseBinID NATIONAL VARCHAR(36),
	v_TransferWarehouseID NATIONAL VARCHAR(36),
	v_TransferWarehouseBinID NATIONAL VARCHAR(36),
	v_TransferQty INT,INOUT SWP_Ret_Value INT) SWL_return:
BEGIN












   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);
   DECLARE v_QtyOnHand INT;
   DECLARE v_QtyOnHandBeforeTrans INT;
   DECLARE v_QtyOnHandAfterTrans INT;
   DECLARE v_IsOverflow BOOLEAN;
   DECLARE v_ErrorID INT;
   IF v_TransferQty = 0 then
      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;
   end if;


   START TRANSACTION;


   IF v_TransferQty < 0 then
	
      SET v_ErrorMessage = 'Transfer Qty less then zero';
      ROLLBACK;


      IF v_ErrorMessage <> '' then

	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Inventory_Transfer',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'ItemID',v_ItemID);
      end if;
      SET SWP_Ret_Value = -1;
   end if;


   select   IFNULL(QtyOnHand,0) INTO v_QtyOnHand FROM InventoryByWarehouse WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND WarehouseID = v_WarehouseID
   AND WarehouseBinID = v_WarehouseBinID
   AND ItemID = v_ItemID;

   IF v_QtyOnHand < v_TransferQty then
	
      SET v_ErrorMessage = 'Qty On Hand less then Transfer Qty';
      ROLLBACK;


      IF v_ErrorMessage <> '' then

	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Inventory_Transfer',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'ItemID',v_ItemID);
      end if;
      SET SWP_Ret_Value = -1;
   end if;



   call WarehouseBinShipGoods2(v_CompanyID,v_DivisionID,v_DepartmentID,v_WarehouseID,v_WarehouseBinID,
   v_ItemID,v_TransferQty,0,3, @shipRetValue);
   select @shipRetValue as v_ReturnStatus;
   IF v_ReturnStatus = -1 then

      SET v_ErrorMessage = 'WarehouseBinShipGoods call failed';
      ROLLBACK;


      IF v_ErrorMessage <> '' then

	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Inventory_Transfer',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'ItemID',v_ItemID);
      end if;
      SET SWP_Ret_Value = -1;
   end if;



   select   IFNULL(QtyOnHand,0) INTO v_QtyOnHandBeforeTrans FROM InventoryByWarehouse WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND WarehouseID = v_TransferWarehouseID
   AND WarehouseBinID = v_TransferWarehouseBinID
   AND ItemID = v_ItemID;
   SET v_QtyOnHandBeforeTrans = IFNULL(v_QtyOnHandBeforeTrans,0);



   SET v_ReturnStatus = WarehouseBinPutGoods(v_CompanyID,v_DivisionID,v_DepartmentID,v_TransferWarehouseID,v_TransferWarehouseBinID,
   v_ItemID,NULL,NULL,NULL,NULL,v_TransferQty,6,v_IsOverflow);
   IF v_ReturnStatus = -1 then

      SET v_ErrorMessage = 'WarehouseBinPutGoods call failed';
      ROLLBACK;


      IF v_ErrorMessage <> '' then

	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Inventory_Transfer',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'ItemID',v_ItemID);
      end if;
      SET SWP_Ret_Value = -1;
   end if;



   select   IFNULL(QtyOnHand,0) INTO v_QtyOnHandAfterTrans FROM InventoryByWarehouse WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND WarehouseID = v_TransferWarehouseID
   AND WarehouseBinID = v_TransferWarehouseBinID
   AND ItemID = v_ItemID;
   SET v_QtyOnHandAfterTrans = IFNULL(v_QtyOnHandAfterTrans,0);



   IF v_QtyOnHandAfterTrans -v_QtyOnHandBeforeTrans <> v_TransferQty then
	
      SET v_ErrorMessage = 'Transfer Qty more then available empty';
      ROLLBACK;


      IF v_ErrorMessage <> '' then

	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Inventory_Transfer',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'ItemID',v_ItemID);
      end if;
      SET SWP_Ret_Value = -1;
   end if;



   COMMIT;
   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;








   ROLLBACK;


   IF v_ErrorMessage <> '' then

	
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Inventory_Transfer',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'ItemID',v_ItemID);
   end if;
   SET SWP_Ret_Value = -1;
END