CREATE PROCEDURE WarehouseBinPutGoods2 (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_WarehouseID NATIONAL VARCHAR(36),
	v_WarehouseBinID NATIONAL VARCHAR(36),
	v_InventoryItemID NATIONAL VARCHAR(36),
	v_PurchaseNumber NATIONAL VARCHAR(36),
	v_PurchaseLineNumber NUMERIC(18,0),
	v_SerialNumber NATIONAL VARCHAR(50),
	v_ReceivedDate DATETIME,
	v_Qty INT,
	v_Action INT,
	INOUT v_IsOverflow BOOLEAN ,INOUT SWP_Ret_Value INT) SWL_return:
BEGIN



   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);
   DECLARE v_QtyBin BIGINT;
   DECLARE v_AvailableEmpty BIGINT;
   DECLARE v_OverFlowBin NATIONAL VARCHAR(36);
   DECLARE v_ErrorID INT;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
   END;
      PutToBin: LOOP
         SET @SWV_Error = 0;
         IF v_Qty = 0 then
		
            SET SWP_Ret_Value = 0;
            LEAVE SWL_return;
         end if;
	
         IF v_Qty < 0 then
		
            SET v_ErrorMessage = 'Wrong inventory quantity';
            ROLLBACK;
            CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'WarehouseBinPutGoods',v_ErrorMessage,
            v_ErrorID);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'WarehouseID',v_WarehouseID);
            SET SWP_Ret_Value = -1;
         end if;
	
         SET @SWV_Error = 0;
         CALL WarehouseBinGet(v_CompanyID,v_DivisionID,v_DepartmentID,v_InventoryItemID,v_WarehouseID,
         v_WarehouseBinID, v_ReturnStatus);
         IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then
	
            SET v_ErrorMessage = 'Get default root warehouse bin failed';
            ROLLBACK;
            CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'WarehouseBinPutGoods',v_ErrorMessage,
            v_ErrorID);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'WarehouseID',v_WarehouseID);
            SET SWP_Ret_Value = -1;
         end if;
         START TRANSACTION;
      IF v_WarehouseBinID = 'Overflow' then
		
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
               CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'WarehouseBinPutGoods',v_ErrorMessage,
               v_ErrorID);
               CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'WarehouseID',v_WarehouseID);
               SET SWP_Ret_Value = -1;
            end if;
         end if;
			
         SET @SWV_Error = 0;
         UPDATE InventoryByWarehouse
         SET
         QtyOnHand =
         CASE v_Action
         WHEN 1 THEN IFNULL(QtyOnHand,0)
         WHEN 2 THEN IFNULL(QtyOnHand,0)+v_Qty
         WHEN 3 THEN IFNULL(QtyOnHand,0)
         WHEN 4 THEN IFNULL(QtyOnHand,0) -v_Qty
         WHEN 5 THEN IFNULL(QtyOnHand,0) -v_Qty
         WHEN 6 THEN IFNULL(QtyOnHand,0)+v_Qty
         ELSE IFNULL(QtyOnHand,0)
         END,QtyOnOrder =
         CASE v_Action
         WHEN 1 THEN IFNULL(QtyOnOrder,0)+v_Qty
         WHEN 2 THEN IFNULL(QtyOnOrder,0) -v_Qty
         WHEN 3 THEN IFNULL(QtyOnOrder,0) -v_Qty
         WHEN 4 THEN IFNULL(QtyOnOrder,0)
         WHEN 5 THEN IFNULL(QtyOnOrder,0)
         WHEN 6 THEN IFNULL(QtyOnOrder,0)
         ELSE IFNULL(QtyOnOrder,0)
         END
         WHERE
         CompanyID = v_CompanyID AND
         DivisionID = v_DivisionID AND
         DepartmentID = v_DepartmentID AND
         ItemID = v_InventoryItemID AND
         WarehouseID = v_WarehouseID AND
         WarehouseBinID = v_WarehouseBinID;
         IF ROW_COUNT() <> 1 OR @SWV_Error <> 0 then
				
            SET v_ErrorMessage = 'Update InventoryByWarehouse bin failed';
            ROLLBACK;
            CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'WarehouseBinPutGoods',v_ErrorMessage,
            v_ErrorID);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'WarehouseID',v_WarehouseID);
            SET SWP_Ret_Value = -1;
         end if;
         IF v_Action = 2 then
				
            SET @SWV_Error = 0;
            CALL SerialNumber_Put(v_CompanyID,v_DivisionID,v_DepartmentID,v_WarehouseID,v_WarehouseBinID,
            v_PurchaseNumber,v_PurchaseLineNumber,v_SerialNumber,v_InventoryItemID,
            v_ReceivedDate,v_Qty, v_ReturnStatus);
            IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then
					
					
               SET v_ErrorMessage = 'SerialNumber_Put call failed';
               ROLLBACK;
               CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'WarehouseBinPutGoods',v_ErrorMessage,
               v_ErrorID);
               CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'WarehouseID',v_WarehouseID);
               SET SWP_Ret_Value = -1;
            end if;
         end if;
         SET v_IsOverflow = 1;
      ELSE
			
         select   IFNULL(SUM(cast(QtyOnHand as SIGNED INTEGER)),0)+IFNULL(SUM(cast(QtyCommitted as SIGNED INTEGER)),0) INTO v_QtyBin FROM InventoryByWarehouse WHERE
         CompanyID = v_CompanyID AND
         DivisionID = v_DivisionID AND
         DepartmentID = v_DepartmentID AND
         WarehouseID = v_WarehouseID AND
         WarehouseBinID = v_WarehouseBinID;
			
         select   cast(IFNULL(MaximumQuantity,0) as SIGNED INTEGER) -v_QtyBin, IFNULL(NULLIF(RTRIM(OverFlowBin),''),'Overflow') INTO v_AvailableEmpty,v_OverFlowBin FROM WarehouseBins WHERE
         CompanyID = v_CompanyID AND
         DivisionID = v_DivisionID AND
         DepartmentID = v_DepartmentID AND
         WarehouseID = v_WarehouseID AND
         WarehouseBinID = v_WarehouseBinID;
         IF ROW_COUNT() = 0 OR @SWV_Error <> 0 then
				
            SET v_ErrorMessage = 'Get selected bin failed';
            ROLLBACK;
            CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'WarehouseBinPutGoods',v_ErrorMessage,
            v_ErrorID);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'WarehouseID',v_WarehouseID);
            SET SWP_Ret_Value = -1;
         end if;
         IF ABS(v_AvailableEmpty) > 2147483647 then
				
            SET v_ErrorMessage = 'Logical error - attempt to put goods more then maximum quantity';
            ROLLBACK;
            CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'WarehouseBinPutGoods',v_ErrorMessage,
            v_ErrorID);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'WarehouseID',v_WarehouseID);
            SET SWP_Ret_Value = -1;
         end if;
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
               CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'WarehouseBinPutGoods',v_ErrorMessage,
               v_ErrorID);
               CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'WarehouseID',v_WarehouseID);
               SET SWP_Ret_Value = -1;
            end if;
         end if;
         IF v_AvailableEmpty >= v_Qty then
				
					
            SET @SWV_Error = 0;
            UPDATE InventoryByWarehouse
            SET
            QtyOnHand =
            CASE v_Action
            WHEN 1 THEN IFNULL(QtyOnHand,0)
            WHEN 2 THEN IFNULL(QtyOnHand,0)+v_Qty
            WHEN 3 THEN IFNULL(QtyOnHand,0)
            WHEN 4 THEN IFNULL(QtyOnHand,0) -v_Qty
            WHEN 5 THEN IFNULL(QtyOnHand,0) -v_Qty
            WHEN 6 THEN IFNULL(QtyOnHand,0)+v_Qty
            ELSE IFNULL(QtyOnHand,0)
            END,QtyOnOrder =
            CASE v_Action
            WHEN 1 THEN IFNULL(QtyOnOrder,0)+v_Qty
            WHEN 2 THEN IFNULL(QtyOnOrder,0) -v_Qty
            WHEN 3 THEN IFNULL(QtyOnOrder,0) -v_Qty
            WHEN 4 THEN IFNULL(QtyOnOrder,0)
            WHEN 5 THEN IFNULL(QtyOnOrder,0)
            WHEN 6 THEN IFNULL(QtyOnOrder,0)
            ELSE IFNULL(QtyOnOrder,0)
            END
            WHERE
            CompanyID = v_CompanyID AND
            DivisionID = v_DivisionID AND
            DepartmentID = v_DepartmentID AND
            ItemID = v_InventoryItemID AND
            WarehouseID = v_WarehouseID AND
            WarehouseBinID = v_WarehouseBinID;
            IF ROW_COUNT() <> 1 OR @SWV_Error <> 0 then
						
               SET v_ErrorMessage = 'Update InventoryByWarehouse bin failed';
               ROLLBACK;
               CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'WarehouseBinPutGoods',v_ErrorMessage,
               v_ErrorID);
               CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'WarehouseID',v_WarehouseID);
               SET SWP_Ret_Value = -1;
            end if;
            IF v_Action = 2 then
						
               SET @SWV_Error = 0;
               CALL SerialNumber_Put(v_CompanyID,v_DivisionID,v_DepartmentID,v_WarehouseID,v_WarehouseBinID,
               v_PurchaseNumber,v_PurchaseLineNumber,v_SerialNumber,v_InventoryItemID,
               v_ReceivedDate,v_Qty, v_ReturnStatus);
               IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then
							
							
                  SET v_ErrorMessage = 'SerialNumber_Put call failed';
                  ROLLBACK;
                  CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'WarehouseBinPutGoods',v_ErrorMessage,
                  v_ErrorID);
                  CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'WarehouseID',v_WarehouseID);
                  SET SWP_Ret_Value = -1;
               end if;
            end if;
         ELSE
					
            SET @SWV_Error = 0;
            UPDATE InventoryByWarehouse
            SET
            QtyOnHand =
            CASE v_Action
            WHEN 1 THEN IFNULL(QtyOnHand,0)
            WHEN 2 THEN IFNULL(QtyOnHand,0)+v_AvailableEmpty
            WHEN 3 THEN IFNULL(QtyOnHand,0)
            WHEN 4 THEN IFNULL(QtyOnHand,0) -v_AvailableEmpty
            WHEN 5 THEN IFNULL(QtyOnHand,0) -v_AvailableEmpty
            WHEN 6 THEN IFNULL(QtyOnHand,0)+v_AvailableEmpty
            ELSE IFNULL(QtyOnHand,0)
            END,QtyOnOrder =
            CASE v_Action
            WHEN 1 THEN IFNULL(QtyOnOrder,0)+v_AvailableEmpty
            WHEN 2 THEN IFNULL(QtyOnOrder,0) -v_AvailableEmpty
            WHEN 3 THEN IFNULL(QtyOnOrder,0) -v_AvailableEmpty
            WHEN 4 THEN IFNULL(QtyOnOrder,0)
            WHEN 5 THEN IFNULL(QtyOnOrder,0)
            WHEN 6 THEN IFNULL(QtyOnOrder,0)
            ELSE IFNULL(QtyOnOrder,0)
            END
            WHERE
            CompanyID = v_CompanyID AND
            DivisionID = v_DivisionID AND
            DepartmentID = v_DepartmentID AND
            ItemID = v_InventoryItemID AND
            WarehouseID = v_WarehouseID AND
            WarehouseBinID = v_WarehouseBinID;
            IF ROW_COUNT() <> 1 OR @SWV_Error <> 0 then
						
               SET v_ErrorMessage = 'Update InventoryByWarehouse bin failed';
               ROLLBACK;
               CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'WarehouseBinPutGoods',v_ErrorMessage,
               v_ErrorID);
               CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'WarehouseID',v_WarehouseID);
               SET SWP_Ret_Value = -1;
            end if;
            IF v_Action = 2 then
						
               SET @SWV_Error = 0;
               CALL SerialNumber_Put(v_CompanyID,v_DivisionID,v_DepartmentID,v_WarehouseID,v_WarehouseBinID,
               v_PurchaseNumber,v_PurchaseLineNumber,v_SerialNumber,v_InventoryItemID,
               v_ReceivedDate,v_AvailableEmpty, v_ReturnStatus);
               IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then
							
							
                  SET v_ErrorMessage = 'SerialNumber_Put call failed';
                  ROLLBACK;
                  CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'WarehouseBinPutGoods',v_ErrorMessage,
                  v_ErrorID);
                  CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'WarehouseID',v_WarehouseID);
                  SET SWP_Ret_Value = -1;
               end if;
            end if;
					
            SET v_Qty = v_Qty -v_AvailableEmpty;
            SET v_WarehouseBinID = v_OverFlowBin;
            leave PutToBin;
         end if;
      end if;
      COMMIT;
      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;
   END LOOP PutToBin;
   ROLLBACK;
   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'WarehouseBinPutGoods',v_ErrorMessage,
   v_ErrorID);
   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'WarehouseID',v_WarehouseID);
	
   SET SWP_Ret_Value = -1;
END