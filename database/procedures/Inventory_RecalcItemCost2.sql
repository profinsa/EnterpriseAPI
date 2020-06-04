CREATE PROCEDURE Inventory_RecalcItemCost2 (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_ItemID NATIONAL VARCHAR(36),
	v_IncomeQuantity BIGINT,
	v_IncomeCostPerUnit DECIMAL(19,4),
	INOUT v_ItemCost DECIMAL(19,4) ,INOUT SWP_Ret_Value INT) SWL_return:
BEGIN









   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);
   DECLARE v_RunningQuantitySold FLOAT;


   DECLARE v_DefaultInventoryCostingMethod NATIONAL VARCHAR(1);
   DECLARE v_ErrorID INT;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
   END;
   SET @SWV_Error = 0;
   START TRANSACTION;

   select   IFNULL(-SUM(IFNULL(Quantity,0)),0) INTO v_RunningQuantitySold FROM InventoryLedger WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   ItemID = v_ItemID AND
   Quantity < 0;



   SET @SWV_Error = 0;
   CALL Inventory_RecalcFIFOCost(v_CompanyID,v_DivisionID,v_DepartmentID,v_ItemID,v_RunningQuantitySold, v_ReturnStatus);
   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then


      SET v_ErrorMessage = 'Inventory_RecalcFIFOCost call failed';
      ROLLBACK;


      IF v_ErrorMessage <> '' then

	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Inventory_RecalcItemCost',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'ItemID',v_ItemID);
      end if;
      SET SWP_Ret_Value = -1;
   end if;


   SET @SWV_Error = 0;
   CALL Inventory_RecalcLIFOCost2(v_CompanyID,v_DivisionID,v_DepartmentID,v_ItemID,v_RunningQuantitySold, v_ReturnStatus);
   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then


      SET v_ErrorMessage = 'Inventory_RecalcLIFOCost call failed';
      ROLLBACK;


      IF v_ErrorMessage <> '' then

	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Inventory_RecalcItemCost',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'ItemID',v_ItemID);
      end if;
      SET SWP_Ret_Value = -1;
   end if;



   SET @SWV_Error = 0;
   CALL Inventory_RecalcAverageCost(v_CompanyID,v_DivisionID,v_DepartmentID,v_ItemID,v_IncomeQuantity,v_IncomeCostPerUnit, v_ReturnStatus);

   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then


      SET v_ErrorMessage = 'Inventory_RecalcAverageCost call failed';
      ROLLBACK;


      IF v_ErrorMessage <> '' then

	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Inventory_RecalcItemCost',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'ItemID',v_ItemID);
      end if;
      SET SWP_Ret_Value = -1;
   end if;


   select   IFNULL(DefaultInventoryCostingMethod,'F') INTO v_DefaultInventoryCostingMethod FROM
   Companies WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID;

   select(CASE(v_DefaultInventoryCostingMethod)
   WHEN 'F' THEN FIFOCost
   WHEN 'L' THEN LIFOCost
   WHEN 'A' THEN AverageCost
   END) INTO v_ItemCost FROM
   InventoryItems WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   ItemID = v_ItemID;




   COMMIT;
	
   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;








   ROLLBACK;


   IF v_ErrorMessage <> '' then

	
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Inventory_RecalcItemCost',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'ItemID',v_ItemID);
   end if;
   SET SWP_Ret_Value = -1;
END