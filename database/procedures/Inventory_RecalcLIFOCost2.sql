CREATE PROCEDURE Inventory_RecalcLIFOCost2 (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_ItemID NATIONAL VARCHAR(36),
	v_RunningQuantitySold BIGINT,INOUT SWP_Ret_Value INT) SWL_return:
BEGIN







   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);

   DECLARE v_Quantity BIGINT;
   DECLARE v_CostPerUnit DECIMAL(19,4);
   DECLARE v_OldLIFOCost DECIMAL(19,4);


   DECLARE NO_DATA INT DEFAULT 0;
   DECLARE v_DefaultInventoryCostingMethod NATIONAL VARCHAR(1);
   DECLARE v_ErrorID INT;
   DECLARE cQty CURSOR FOR
   SELECT 
   IFNULL(Quantity,0), IFNULL(CostPerUnit,0)
   FROM 
   InventoryLedger
   WHERE 
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   ItemID = v_ItemID AND
   IFNULL(Quantity,0) > 0
   ORDER BY TransDate DESC;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
      SET NO_DATA = -2;
   END;
   DECLARE CONTINUE HANDLER FOR NOT FOUND SET NO_DATA = -1;
   select   LIFOCost INTO v_OldLIFOCost FROM
   InventoryItems WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   ItemID = v_ItemID;

   IF ROW_COUNT() = 0 then

      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;
   end if;


   START TRANSACTION;

   OPEN cQty;

   SET NO_DATA = 0;
   FETCH cQty INTO v_Quantity,v_CostPerUnit;



   WHILE NO_DATA = 0 AND v_RunningQuantitySold >= 0 DO
      SET v_RunningQuantitySold = v_RunningQuantitySold -v_Quantity;
      IF  v_RunningQuantitySold >= 0 then
	
         SET NO_DATA = 0;
         FETCH cQty INTO v_Quantity,v_CostPerUnit;
      end if;
   END WHILE;


   CLOSE cQty;




   IF v_OldLIFOCost <> v_CostPerUnit AND v_CostPerUnit <> 0 then

      UPDATE
      InventoryItems
      SET
      LIFOCost = v_CostPerUnit
      WHERE
      CompanyID = v_CompanyID AND
      DivisionID = v_DivisionID AND
      DepartmentID = v_DepartmentID AND
      ItemID = v_ItemID;
      select   IFNULL(DefaultInventoryCostingMethod,'F') INTO v_DefaultInventoryCostingMethod FROM
      Companies WHERE
      CompanyID = v_CompanyID AND
      DivisionID = v_DivisionID AND
      DepartmentID = v_DepartmentID;
	
	
      IF v_DefaultInventoryCostingMethod = 'L' then
	
		
         SET @SWV_Error = 0;
         SET v_ReturnStatus = Order_UpdateCosting(v_CompanyID,v_DivisionID,v_DepartmentID,v_ItemID,v_CostPerUnit);
         IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then
		
		
            SET v_ErrorMessage = 'Order_UpdateCosting call failed';
            ROLLBACK;


            IF v_ErrorMessage <> '' then

	
               CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Inventory_RecalcLIFOCost',v_ErrorMessage,
               v_ErrorID);
               CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'ItemID',v_ItemID);
            end if;
            SET SWP_Ret_Value = -1;
         end if;
      end if;
   end if;




   COMMIT;
	
   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;








   ROLLBACK;


   IF v_ErrorMessage <> '' then

	
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Inventory_RecalcLIFOCost',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'ItemID',v_ItemID);
   end if;
   SET SWP_Ret_Value = -1;
END