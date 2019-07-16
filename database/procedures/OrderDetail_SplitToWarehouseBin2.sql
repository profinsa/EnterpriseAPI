CREATE PROCEDURE OrderDetail_SplitToWarehouseBin2 (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_OrderNumber NATIONAL VARCHAR(36),
	v_BackOrdered BOOLEAN,
	INOUT v_BackOrder BOOLEAN ,INOUT SWP_Ret_Value INT) SWL_return:
BEGIN




   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);

   DECLARE v_OrderLineNumber NUMERIC(18,0);
   DECLARE v_PrevWarehouseID NATIONAL VARCHAR(36);
   DECLARE v_PrevWarehouseBinID NATIONAL VARCHAR(36);
   DECLARE v_WarehouseID NATIONAL VARCHAR(36);
   DECLARE v_WarehouseBinID NATIONAL VARCHAR(36);
   DECLARE v_ItemID NATIONAL VARCHAR(36);
   DECLARE v_PrevQty FLOAT;
   DECLARE v_PrevBackOrderQty FLOAT;
   DECLARE v_Qty FLOAT;
   DECLARE v_AvlblQty FLOAT;
   DECLARE v_BackQty FLOAT;
   DECLARE v_First BOOLEAN;
   DECLARE SWV_cOD_CompanyID NATIONAL VARCHAR(36);
   DECLARE SWV_cOD_DivisionID NATIONAL VARCHAR(36);
   DECLARE SWV_cOD_DepartmentID NATIONAL VARCHAR(36);
   DECLARE SWV_cOD_OrderNumber NATIONAL VARCHAR(36);
   DECLARE SWV_cOD_OrderLineNumber NUMERIC(18,0);
   DECLARE v_ErrorID INT;
   DECLARE NO_DATA INT DEFAULT 0;
   DECLARE Counter INT;
   DECLARE Records INT DEFAULT 0;
   DECLARE cOD CURSOR
   FOR SELECT 
   WarehouseID, WarehouseBinID, 
			OrderLineNumber, ItemID, IFNULL(OrderQty,0), IFNULL(BackOrderQyyty,0), CompanyID,DivisionID,DepartmentID,OrderNumber,OrderLineNumber
   FROM 
   OrderDetail
   WHERE	
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND OrderNumber = v_OrderNumber
   AND IFNULL(BackOrdered,0) = IFNULL(v_BackOrdered,0);
	
	

   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
      SET NO_DATA = -2;
   END;
   DECLARE CONTINUE HANDLER FOR NOT FOUND SET NO_DATA = -1;

   SET @SWV_Error = 0;
   SET v_BackOrder = 0;

   START TRANSACTION;

   OPEN cOD;
   SET NO_DATA = 0;
   FETCH cOD INTO v_PrevWarehouseID,v_PrevWarehouseBinID,v_OrderLineNumber,v_ItemID,v_PrevQty, 
   v_PrevBackOrderQty,SWV_cOD_CompanyID,SWV_cOD_DivisionID,SWV_cOD_DepartmentID,
   SWV_cOD_OrderNumber,SWV_cOD_OrderLineNumber;
   WHILE NO_DATA = 0 DO
      SET v_First = 1;
      IF v_BackOrdered = 1 then
				
         SET @SWV_Error = 0;
         SET v_ReturnStatus = WarehouseBinLockGoods(v_CompanyID,v_DivisionID,v_DepartmentID,v_PrevWarehouseID,v_PrevWarehouseBinID,
         v_ItemID,0,v_PrevBackOrderQty,3);
         IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then
					
            CLOSE cOD;
						
            SET v_ErrorMessage = 'WarehouseBinLockGoods failed';
            ROLLBACK;
            CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'OrderDetail_SplitToWarehouseBin',
            v_ErrorMessage,v_ErrorID);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'OrderNumber',v_OrderNumber);
            SET SWP_Ret_Value = -1;
         end if;
      end if;

      SET NO_DATA = 0;

      SET Counter = WarehouseBinsForSplitCount(v_CompanyID, v_DivisionID, v_DepartmentID, v_PrevWarehouseID, v_PrevWarehouseBinID, v_ItemID, v_PrevQty, 5);      
      SET Records = Records + 1;
      CALL WarehouseBinsForSplitGetRecord(v_CompanyID, v_DivisionID, v_DepartmentID, v_PrevWarehouseID, v_PrevWarehouseBinID, v_ItemID, v_PrevQty, Records, @outIdent, v_WarehouseID, v_WarehouseBinID, v_Qty, v_AvlblQty, v_BackQty );
      	   IF Records = Counter then
		SET NO_DATA = 1;
           end if;
      WHILE NO_DATA = 0 DO
         IF v_BackQty > 0 then
						
            SET v_BackOrder = 1;
         end if;
         IF v_First = 1 then
						
            SET @SWV_Error = 0;
            UPDATE OrderDetail
            SET
            WarehouseID = v_WarehouseID,WarehouseBinID = v_WarehouseBinID,OrderQty = v_Qty,
            BackOrdered =
            CASE WHEN v_BackQty > 0 THEN 1
            ELSE 0 END,BackOrderQyyty = v_BackQty
            WHERE OrderDetail.CompanyID = SWV_cOD_CompanyID AND OrderDetail.DivisionID = SWV_cOD_DivisionID AND OrderDetail.DepartmentID = SWV_cOD_DepartmentID AND OrderDetail.OrderNumber = SWV_cOD_OrderNumber AND OrderDetail.OrderLineNumber = SWV_cOD_OrderLineNumber;
            IF @SWV_Error <> 0 then
							

								
               CLOSE cOD;
								
               SET v_ErrorMessage = 'Updating order detail failed';
               ROLLBACK;
               CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'OrderDetail_SplitToWarehouseBin',
               v_ErrorMessage,v_ErrorID);
               CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'OrderNumber',v_OrderNumber);
               SET SWP_Ret_Value = -1;
            end if;
            SET v_First = 0;
         ELSE
            SET @SWV_Error = 0;
            INSERT INTO OrderDetail(CompanyID,
								DivisionID,
								DepartmentID,
								OrderNumber,
								ItemID,
								WarehouseID,
								WarehouseBinID,
								SerialNumber,
								Description,
								OrderQty,
								BackOrdered,
								BackOrderQyyty,
								ItemUOM,
								ItemWeight,
								DiscountPerc,
								Taxable,
								ItemCost,
								ItemUnitPrice,
								Total,
								TotalWeight,
								GLSalesAccount,
								ProjectID,
								TrackingNumber,
								WarehouseBinZone,
								PalletLevel,
								CartonLevel,
								PackLevelA,
								PackLevelB,
								PackLevelC,
								DetailMemo1,
								DetailMemo2,
								DetailMemo3,
								DetailMemo4,
								DetailMemo5,
								TaxGroupID,
								TaxAmount,
								TaxPercent,
								SubTotal)
            SELECT
            CompanyID,
									DivisionID,
									DepartmentID,
									OrderNumber,
									ItemID,
									v_WarehouseID,
									v_WarehouseBinID,
									SerialNumber,
									Description,
									v_Qty,
									CASE WHEN v_BackQty > 0 THEN 1
            ELSE 0 END,
									v_BackQty,
									ItemUOM,
									ItemWeight,
									DiscountPerc,
									Taxable,
									ItemCost,
									ItemUnitPrice,
									Total,
									TotalWeight,
									GLSalesAccount,
									ProjectID,
									TrackingNumber,
									WarehouseBinZone,
									PalletLevel,
									CartonLevel,
									PackLevelA,
									PackLevelB,
									PackLevelC,
									DetailMemo1,
									DetailMemo2,
									DetailMemo3,
									DetailMemo4,
									DetailMemo5,
									TaxGroupID,
									TaxAmount,
									TaxPercent,
									SubTotal
            FROM
            OrderDetail
            WHERE
            CompanyID = v_CompanyID
            AND DivisionID = v_DivisionID
            AND DepartmentID = v_DepartmentID
            AND OrderNumber = v_OrderNumber
            AND OrderLineNumber = v_OrderLineNumber;
            IF @SWV_Error <> 0 then
							
							

								
               CLOSE cOD;
								
               SET v_ErrorMessage = 'Insert into OrderDetail failed';
               ROLLBACK;
               CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'OrderDetail_SplitToWarehouseBin',
               v_ErrorMessage,v_ErrorID);
               CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'OrderNumber',v_OrderNumber);
               SET SWP_Ret_Value = -1;
            end if;
         end if;
         SET @SWV_Error = 0;
         SET v_ReturnStatus = WarehouseBinLockGoods(v_CompanyID,v_DivisionID,v_DepartmentID,v_WarehouseID,v_WarehouseBinID,
         v_ItemID,v_AvlblQty,v_BackQty,1);
         IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then
					
            CLOSE cOD;
						
            SET v_ErrorMessage = 'WarehouseBinLockGoods failed';
            ROLLBACK;
            CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'OrderDetail_SplitToWarehouseBin',
            v_ErrorMessage,v_ErrorID);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'OrderNumber',v_OrderNumber);
            SET SWP_Ret_Value = -1;
         end if;
         SET NO_DATA = 0;

         IF Records = Counter then
	    SET NO_DATA = 1;
	 ELSE
		SET Records = Records + 1;
	 	CALL WarehouseBinsForSplitGetRecord(v_CompanyID, v_DivisionID, v_DepartmentID, v_PrevWarehouseID, v_PrevWarehouseBinID, v_ItemID, v_PrevQty, Records, @outIdent, v_WarehouseID, v_WarehouseBinID, v_Qty, v_AvlblQty, v_BackQty );
         END IF;
      END WHILE;

			
      SET NO_DATA = 0;
      FETCH cOD INTO v_PrevWarehouseID,v_PrevWarehouseBinID,v_OrderLineNumber,v_ItemID,v_PrevQty, 
      v_PrevBackOrderQty,SWV_cOD_CompanyID,SWV_cOD_DivisionID,SWV_cOD_DepartmentID,
      SWV_cOD_OrderNumber,SWV_cOD_OrderLineNumber;
   END WHILE;
	
   CLOSE cOD;
	


   SET @SWV_Error = 0;
   CALL Order_Recalc2(v_CompanyID,v_DivisionID,v_DepartmentID,v_OrderNumber, v_ReturnStatus);
   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then
	
      SET v_ErrorMessage = 'Recalculating the order failed';
      ROLLBACK;
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'OrderDetail_SplitToWarehouseBin',
      v_ErrorMessage,v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'OrderNumber',v_OrderNumber);
      SET SWP_Ret_Value = -1;
   end if;


   COMMIT;

   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;


   ROLLBACK;

   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'OrderDetail_SplitToWarehouseBin',
   v_ErrorMessage,v_ErrorID);
   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'OrderNumber',v_OrderNumber);
	
   SET SWP_Ret_Value = -1;

END