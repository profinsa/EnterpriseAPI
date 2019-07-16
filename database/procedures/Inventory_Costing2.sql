CREATE PROCEDURE Inventory_Costing2 (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_ItemID NATIONAL VARCHAR(36),
	v_WarehouseID NATIONAL VARCHAR(36),
	v_ReceivedQty INT,
	v_ItemUnitPrice DECIMAL(19,4),
	v_Mode INT,
	INOUT v_Result INT  ,INOUT SWP_Ret_Value INT) SWL_return:
BEGIN




   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);

   DECLARE v_FIFOValue DECIMAL(19,4);
   DECLARE v_LIFOValue DECIMAL(19,4);
   DECLARE v_AverageValue DECIMAL(19,4);
   DECLARE v_ConvertedItemUnitPrice DECIMAL(19,4);
   DECLARE v_TotalItemQuantity INT;
   DECLARE v_QtyOnHand INT;
   DECLARE v_CompanyCurrencyID NATIONAL VARCHAR(3);
   DECLARE v_InventoryCurrencyID NATIONAL VARCHAR(3);
   DECLARE v_InventoryExchangeRate FLOAT;

   DECLARE v_ExchangeRateDate DATETIME;

   DECLARE v_ErrorID INT;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
   END;
   SET @SWV_Error = 0;
   SET v_Result = 1;





   START TRANSACTION;

   SET v_ExchangeRateDate = CURRENT_TIMESTAMP;

   SET @SWV_Error = 0;
   CALL VerifyCurrency2(v_CompanyID,v_DivisionID,v_DepartmentID,v_ExchangeRateDate,0,v_CompanyCurrencyID,
   v_InventoryCurrencyID,v_InventoryExchangeRate);
   IF @SWV_Error <> 0 then

	
      SET v_ErrorMessage = 'Currency retrieving failed';
      ROLLBACK;

      SET v_Result = 0;
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Inventory_Costing',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'ItemID',v_ItemID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'QtyReceived',v_ReceivedQty);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'ItemUnitCost',v_ItemUnitPrice);
      SET SWP_Ret_Value = -1;
   end if;
   SET v_ConvertedItemUnitPrice = v_ItemUnitPrice; 

   select   IFNULL(SUM(IFNULL(QtyOnHand,0)),0) INTO v_QtyOnHand FROM
   InventoryByWarehouse WHERE
   InventoryByWarehouse.CompanyID = v_CompanyID AND
   InventoryByWarehouse.DivisionID = v_DivisionID AND
   InventoryByWarehouse.DepartmentID = v_DepartmentID AND
   InventoryByWarehouse.ItemID = v_ItemID AND
   InventoryByWarehouse.WarehouseID = v_WarehouseID;

   select   IFNULL(AverageValue,0), IFNULL(LIFOValue,0) INTO v_AverageValue,v_LIFOValue FROM
   InventoryItems WHERE
   InventoryItems.CompanyID = v_CompanyID AND
   InventoryItems.DivisionID = v_DivisionID AND
   InventoryItems.DepartmentID = v_DepartmentID AND
   InventoryItems.ItemID = v_ItemID;

   IF ROW_COUNT() > 0 then

	
	
      IF v_ConvertedItemUnitPrice > 0 then
	
         IF v_Mode = 1 then
			
            SET v_QtyOnHand = v_QtyOnHand -v_ReceivedQty;
         end if;
         IF v_QtyOnHand < 0 then
		
            SET v_QtyOnHand = 0;
         end if;
         IF v_QtyOnHand+v_ReceivedQty > 0 then
		
            SET v_AverageValue = fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,(v_AverageValue*v_QtyOnHand+v_ConvertedItemUnitPrice*v_ReceivedQty)/(v_QtyOnHand+v_ReceivedQty), 
            v_CompanyCurrencyID);
         ELSE
            SET v_AverageValue = fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,v_ConvertedItemUnitPrice,v_CompanyCurrencyID);
         end if;
         SET v_ConvertedItemUnitPrice = fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,v_ConvertedItemUnitPrice,v_CompanyCurrencyID);
         IF v_QtyOnHand = 0 OR v_LIFOValue = 0 then
		
            SET v_LIFOValue = v_ConvertedItemUnitPrice;
         end if;

		
         SET @SWV_Error = 0;
         UPDATE
         InventoryItems
         SET
         LIFOValue = v_LIFOValue,AverageValue = v_AverageValue,FIFOValue = v_ConvertedItemUnitPrice
         WHERE
         InventoryItems.CompanyID = v_CompanyID AND
         InventoryItems.DivisionID = v_DivisionID AND
         InventoryItems.DepartmentID = v_DepartmentID AND
         InventoryItems.ItemID = v_ItemID;
         IF @SWV_Error <> 0 then
		
            SET v_ErrorMessage = 'Update InventoryItems failed';
            ROLLBACK;

            SET v_Result = 0;
            CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Inventory_Costing',v_ErrorMessage,
            v_ErrorID);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'ItemID',v_ItemID);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'QtyReceived',v_ReceivedQty);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'ItemUnitCost',v_ItemUnitPrice);
            SET SWP_Ret_Value = -1;
         end if;
      end if;
   end if;





   COMMIT;
   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;








   ROLLBACK;

   SET v_Result = 0;
   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Inventory_Costing',v_ErrorMessage,
   v_ErrorID);

   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'ItemID',v_ItemID);
   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'QtyReceived',v_ReceivedQty);
   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'ItemUnitCost',v_ItemUnitPrice);

   SET SWP_Ret_Value = -1;
END