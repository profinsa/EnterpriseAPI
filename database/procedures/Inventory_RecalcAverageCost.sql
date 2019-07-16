CREATE PROCEDURE Inventory_RecalcAverageCost (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_ItemID NATIONAL VARCHAR(36),
	v_IncomeQuantity BIGINT,
	v_IncomeCostPerUnit DECIMAL(19,4),INOUT SWP_Ret_Value INT) SWL_return:
BEGIN





   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);

   DECLARE v_AvailableQuantity BIGINT;
   DECLARE v_CostPerUnit DECIMAL(19,4);
   DECLARE v_OldAverageCost DECIMAL(19,4);


   DECLARE v_CompanyCurrencyID NATIONAL VARCHAR(3);
   DECLARE v_DefaultInventoryCostingMethod NATIONAL VARCHAR(1);
   DECLARE v_ErrorID INT;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
   END;
   select   IFNULL(CurrencyID,N'') INTO v_CompanyCurrencyID FROM Companies WHERE CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID   LIMIT 1;



   select   IFNULL(AverageCost,0) INTO v_OldAverageCost FROM
   InventoryItems WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   ItemID = v_ItemID;

   IF ROW_COUNT() = 0 then

      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;
   end if;



   select   IFNULL(SUM(IFNULL(Quantity,0)),0) INTO v_AvailableQuantity FROM
   InventoryLedger WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   ItemID = v_ItemID;


   SET v_OldAverageCost = IFNULL(v_OldAverageCost,0);
   SET v_AvailableQuantity = IFNULL(v_AvailableQuantity,0);

   IF v_AvailableQuantity > 0 then
      SET v_CostPerUnit =((v_AvailableQuantity -v_IncomeQuantity)*v_OldAverageCost+v_IncomeQuantity*v_IncomeCostPerUnit)/v_AvailableQuantity;
   ELSE
      SET v_CostPerUnit = v_IncomeCostPerUnit;
   end if;


   START TRANSACTION;




   IF v_OldAverageCost <> v_CostPerUnit AND v_CostPerUnit > 0 then

      UPDATE
      InventoryItems
      SET
      AverageCost = v_CostPerUnit
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
	
	
      IF v_DefaultInventoryCostingMethod = 'A' then
	
		
         SET @SWV_Error = 0;
         SET v_ReturnStatus = Order_UpdateCosting(v_CompanyID,v_DivisionID,v_DepartmentID,v_ItemID,v_CostPerUnit);
         IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then
		
		
            SET v_ErrorMessage = 'Order_UpdateCosting call failed';
            ROLLBACK;


            IF v_ErrorMessage <> '' then

	
               CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Inventory_RecalcAverageCost',
               v_ErrorMessage,v_ErrorID);
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

	
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Inventory_RecalcAverageCost',
      v_ErrorMessage,v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'ItemID',v_ItemID);
   end if;
   SET SWP_Ret_Value = -1;
END