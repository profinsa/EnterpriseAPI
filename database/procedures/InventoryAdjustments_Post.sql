CREATE PROCEDURE InventoryAdjustments_Post (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_AdjustmentID NATIONAL VARCHAR(36),
	INOUT v_Success INT ,
	INOUT v_PostingResult NATIONAL VARCHAR(200) ,INOUT SWP_Ret_Value INT) SWL_return:
BEGIN

   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);
   DECLARE v_Posted BOOLEAN;
   DECLARE v_PostDate NATIONAL VARCHAR(1);
   DECLARE v_AdjustmentDate DATETIME;
   DECLARE v_PeriodToPost INT;
   DECLARE v_PeriodClosed INT;
   DECLARE v_WarehouseID NATIONAL VARCHAR(36);
   DECLARE v_WarehouseBinID NATIONAL VARCHAR(36);
   DECLARE v_DefaultInventoryCostingMethod NATIONAL VARCHAR(1);
   DECLARE v_CompanyCurrencyID NATIONAL VARCHAR(3);

   DECLARE v_AdjustmentLineID INT;
   DECLARE v_ItemID NATIONAL VARCHAR(36);
   DECLARE v_AdjustedQuantity INT;
   DECLARE v_ItemCost DECIMAL(19,4);
   DECLARE v_Total DECIMAL(19,4);
   DECLARE v_Context VARBINARY(128);
   DECLARE v_EmployeeID NATIONAL VARCHAR(36);
   DECLARE NO_DATA INT DEFAULT 0;
   DECLARE v_ErrorID INT;
   DECLARE v_QtyOnHand INT;
	
   DECLARE v_Cost DECIMAL(19,4);
   DECLARE v_IsOverflow BOOLEAN;
   DECLARE cAdjustmentDetail CURSOR 
   FOR SELECT
   InventoryAdjustmentsDetail.AdjustmentLineID,
		InventoryAdjustmentsDetail.WarehouseID,
		InventoryAdjustmentsDetail.WarehouseBinID,
		InventoryAdjustmentsDetail.ItemID,
		IFNULL(InventoryAdjustmentsDetail.AdjustedQuantity,0),
		(CASE(v_DefaultInventoryCostingMethod)
   WHEN 'F' THEN InventoryItems.FIFOValue
   WHEN 'L' THEN InventoryItems.LIFOValue
   WHEN 'A' THEN InventoryItems.AverageValue
   END)
   FROM
   InventoryAdjustmentsDetail
   INNER JOIN InventoryItems ON
   InventoryAdjustmentsDetail.CompanyID = InventoryItems.CompanyID
   AND InventoryAdjustmentsDetail.DivisionID = InventoryItems.DivisionID
   AND InventoryAdjustmentsDetail.DepartmentID = InventoryItems.DepartmentID
   AND InventoryAdjustmentsDetail.ItemID = InventoryItems.ItemID
   WHERE	
   InventoryAdjustmentsDetail.CompanyID = v_CompanyID
   AND InventoryAdjustmentsDetail.DivisionID = v_DivisionID
   AND InventoryAdjustmentsDetail.DepartmentID = v_DepartmentID
   AND InventoryAdjustmentsDetail.AdjustmentID = v_AdjustmentID
   AND IFNULL(InventoryAdjustmentsDetail.AdjustedQuantity,0) <> 0;

   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
      SET NO_DATA = -2;
   END;
   DECLARE CONTINUE HANDLER FOR NOT FOUND SET NO_DATA = -1;
   SET @SWV_Error = 0;
   SET v_Success =  1;

   IF IFNULL(v_AdjustmentID,N'') = N'DEFAULT' then
      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;
   end if;

   IF NOT EXISTS(SELECT
   AdjustmentID
   FROM
   InventoryAdjustmentsDetail
   WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   AdjustmentID = v_AdjustmentID AND
   IFNULL(AdjustedQuantity,0) <> 0) then

      SET v_PostingResult = 'Adjustment was not posted: there are no detail items';
      SET SWP_Ret_Value = -1;
      LEAVE SWL_return;
   end if;
   select   IFNULL(CurrencyID,N''), IFNULL(DefaultInventoryCostingMethod,'F') INTO v_CompanyCurrencyID,v_DefaultInventoryCostingMethod FROM
   Companies WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID;
   IF EXISTS(SELECT(CASE(v_DefaultInventoryCostingMethod)
   WHEN 'F' THEN InventoryItems.FIFOValue
   WHEN 'L' THEN InventoryItems.LIFOValue
   WHEN 'A' THEN InventoryItems.AverageValue
   END) As ItemCost
   FROM
   InventoryAdjustmentsDetail
   INNER JOIN InventoryItems ON
   InventoryAdjustmentsDetail.CompanyID = InventoryItems.CompanyID
   AND InventoryAdjustmentsDetail.DivisionID = InventoryItems.DivisionID
   AND InventoryAdjustmentsDetail.DepartmentID = InventoryItems.DepartmentID
   AND InventoryAdjustmentsDetail.ItemID = InventoryItems.ItemID
   WHERE
   InventoryAdjustmentsDetail.CompanyID = v_CompanyID
   AND InventoryAdjustmentsDetail.DivisionID = v_DivisionID
   AND InventoryAdjustmentsDetail.DepartmentID = v_DepartmentID
   AND InventoryAdjustmentsDetail.AdjustmentID = v_AdjustmentID
   AND(CASE(v_DefaultInventoryCostingMethod)
   WHEN 'F' THEN IFNULL(InventoryItems.FIFOValue,0)
   WHEN 'L' THEN IFNULL(InventoryItems.LIFOValue,0)
   WHEN 'A' THEN IFNULL(InventoryItems.AverageValue,0)
   END) = 0) then

      SET v_PostingResult = 'Adjustment was not posted: the cost of some detail items is not defined';
      SET SWP_Ret_Value = -1;
      LEAVE SWL_return;
   end if;
   select   IFNULL(AdjustmentPosted,0), IFNULL(v_AdjustmentDate,CURRENT_TIMESTAMP) INTO v_Posted,v_AdjustmentDate FROM
   InventoryAdjustments WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   AdjustmentID = v_AdjustmentID;

   IF v_Posted = 1 then

      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;
   end if;


   select   IFNULL(DefaultGLPostingDate,'1') INTO v_PostDate FROM
   Companies WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID;

   IF v_PostDate = '1' then
      SET v_AdjustmentDate = CURRENT_TIMESTAMP;
   end if;
   START TRANSACTION;

   SET v_ReturnStatus = LedgerMain_VerifyPeriod(v_CompanyID,v_DivisionID,v_DepartmentID,v_AdjustmentDate,v_PeriodToPost,
   v_PeriodClosed);
   IF v_ReturnStatus = -1 then

      SET v_ErrorMessage = 'LedgerMain_VerifyPeriod call failed';
      ROLLBACK;

      IF v_Success = 1 then

         SET v_Success = 0;
      end if;
      IF v_ErrorMessage <> '' then

	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'InventoryAdjustments_Post',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'AdjustmentID',v_AdjustmentID);
      end if;
      SET SWP_Ret_Value = -1;
   end if;
   IF v_PeriodClosed <> 0 then

      SET v_Success = 2;
      SET v_ErrorMessage = 'UNABLE_TO_POST_HERE';
      ROLLBACK;

      IF v_Success = 1 then

         SET v_Success = 0;
      end if;
      IF v_ErrorMessage <> '' then

	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'InventoryAdjustments_Post',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'AdjustmentID',v_AdjustmentID);
      end if;
      SET SWP_Ret_Value = -1;
   end if;
   Set v_Total = 0;
   OPEN cAdjustmentDetail;
   SET NO_DATA = 0;
   FETCH cAdjustmentDetail INTO v_AdjustmentLineID,v_WarehouseID,v_WarehouseBinID,v_ItemID,v_AdjustedQuantity, 
   v_ItemCost;
   WHILE NO_DATA = 0 DO
      SET v_ItemCost = fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,v_ItemCost,v_CompanyCurrencyID);
      select   IFNULL(QtyOnHand,0) INTO v_QtyOnHand FROM 	InventoryByWarehouse WHERE
      CompanyID = v_CompanyID
      AND DivisionID = v_DivisionID
      AND DepartmentID = v_DepartmentID
      AND WarehouseID = v_WarehouseID
      AND WarehouseBinID = v_WarehouseBinID
      AND ItemID = v_ItemID;
	
      IF v_AdjustedQuantity < 0 AND v_QtyOnHand < -v_AdjustedQuantity then
		
         CLOSE cAdjustmentDetail;
			
         SET v_ErrorMessage = 'Qty On Hand < Adjusted Quantity';
         ROLLBACK;

         IF v_Success = 1 then

            SET v_Success = 0;
         end if;
         IF v_ErrorMessage <> '' then

	
            CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'InventoryAdjustments_Post',v_ErrorMessage,
            v_ErrorID);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'AdjustmentID',v_AdjustmentID);
         end if;
         SET SWP_Ret_Value = -1;
      end if;
      SET @SWV_Error = 0;
      CALL Inventory_CreateILTransaction2(v_CompanyID,v_DivisionID,v_DepartmentID,v_AdjustmentDate,v_ItemID,'Adjustment',
      v_AdjustmentID,v_AdjustmentLineID,v_AdjustedQuantity,v_ItemCost, v_ReturnStatus);
      IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then
	
	
         CLOSE cAdjustmentDetail;
		
         SET v_ErrorMessage = 'Inventory_CreateILTransaction call failed';
         ROLLBACK;

         IF v_Success = 1 then

            SET v_Success = 0;
         end if;
         IF v_ErrorMessage <> '' then

	
            CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'InventoryAdjustments_Post',v_ErrorMessage,
            v_ErrorID);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'AdjustmentID',v_AdjustmentID);
         end if;
         SET SWP_Ret_Value = -1;
      end if;
      SET v_Cost = fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,ABS(v_AdjustedQuantity*v_ItemCost), 
      v_CompanyCurrencyID);
      SET v_Total = v_Total+v_Cost;
	
      UPDATE	InventoryAdjustmentsDetail
      SET
      AdjustedQuantity = v_AdjustedQuantity,OriginalQuantity = v_QtyOnHand,Cost = v_Cost,
      CurrencyID = v_CompanyCurrencyID,CurrencyExchangeRate = 1
      WHERE
      CompanyID = v_CompanyID
      AND DivisionID = v_DivisionID
      AND DepartmentID = v_DepartmentID
      AND AdjustmentID = v_AdjustmentID
      AND AdjustmentLineID = v_AdjustmentLineID;
      IF v_AdjustedQuantity > 0 then
	
		
         SET @SWV_Error = 0;
         CALL WarehouseBinPutGoods2(v_CompanyID,v_DivisionID,v_DepartmentID,v_WarehouseID,v_WarehouseBinID,
         v_ItemID,v_AdjustmentID,v_AdjustmentLineID,NULL,v_AdjustmentDate,v_AdjustedQuantity,
         6,v_IsOverflow, v_ReturnStatus);
         IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then
		
            
			
            SET v_ErrorMessage = 'WarehouseBinPutGoods failed';
            ROLLBACK;

            IF v_Success = 1 then

               SET v_Success = 0;
            end if;
            IF v_ErrorMessage <> '' then

	
               CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'InventoryAdjustments_Post',v_ErrorMessage,
               v_ErrorID);
               CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'AdjustmentID',v_AdjustmentID);
            end if;
            SET SWP_Ret_Value = -1;
         end if;
      ELSE
         SET v_AdjustedQuantity = -v_AdjustedQuantity;
         CALL WarehouseBinShipGoods2(v_CompanyID,v_DivisionID,v_DepartmentID,v_WarehouseID,v_WarehouseBinID,
         v_ItemID,v_AdjustedQuantity,0,3, v_ReturnStatus);
         IF v_ReturnStatus = -1 then
		
            CLOSE cAdjustmentDetail;
			
            SET v_ErrorMessage = 'WarehouseBinShipGoods call failed';
            ROLLBACK;

            IF v_Success = 1 then

               SET v_Success = 0;
            end if;
            IF v_ErrorMessage <> '' then

	
               CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'InventoryAdjustments_Post',v_ErrorMessage,
               v_ErrorID);
               CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'AdjustmentID',v_AdjustmentID);
            end if;
            SET SWP_Ret_Value = -1;
         end if;
      end if;
      SET NO_DATA = 0;
      FETCH cAdjustmentDetail INTO  v_AdjustmentLineID,v_WarehouseID,v_WarehouseBinID,v_ItemID,v_AdjustedQuantity, 
      v_ItemCost;
   END WHILE;
   CLOSE cAdjustmentDetail;

   select   context_info INTO v_Context FROM sysprocesses WHERE spid = CONNECTION_ID();
   SET v_EmployeeID = CAST(v_Context AS CHAR(36));

   SET @SWV_Error = 0;
   UPDATE
   InventoryAdjustments
   SET
   AdjustmentPosted = 1,EnteredBy = v_EmployeeID,Total = v_Total,AdjustmentDate = CASE WHEN IFNULL(AdjustmentDate,'1980/01/01') = '1980/01/01' THEN CURRENT_TIMESTAMP ELSE AdjustmentDate END
   WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   AdjustmentID = v_AdjustmentID;
   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Update InventoryAdjustments failed';
      ROLLBACK;

      IF v_Success = 1 then

         SET v_Success = 0;
      end if;
      IF v_ErrorMessage <> '' then

	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'InventoryAdjustments_Post',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'AdjustmentID',v_AdjustmentID);
      end if;
      SET SWP_Ret_Value = -1;
   end if;
   SET @SWV_Error = 0;
   CALL InventoryAdjustments_CreateGLTransaction(v_CompanyID,v_DivisionID,v_DepartmentID,v_AdjustmentID, v_ReturnStatus);
   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Payment_CreateGLTransaction call failed';
      ROLLBACK;

      IF v_Success = 1 then

         SET v_Success = 0;
      end if;
      IF v_ErrorMessage <> '' then

	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'InventoryAdjustments_Post',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'AdjustmentID',v_AdjustmentID);
      end if;
      SET SWP_Ret_Value = -1;
   end if;

   COMMIT;
   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;






   ROLLBACK;

   IF v_Success = 1 then

      SET v_Success = 0;
   end if;
   IF v_ErrorMessage <> '' then

	
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'InventoryAdjustments_Post',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'AdjustmentID',v_AdjustmentID);
   end if;
   SET SWP_Ret_Value = -1;
END