CREATE PROCEDURE Inventory_Assemblies (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_AssemblyID NATIONAL VARCHAR(36),
	v_WarehouseID NATIONAL VARCHAR(36),
	INOUT v_QtyRequired INT ,
	INOUT v_Result INT  ,INOUT SWP_Ret_Value INT) SWL_return:
BEGIN




   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);

   DECLARE v_DefaultInventoryCostingMethod CHAR(1);
   DECLARE v_CurrencyID NATIONAL VARCHAR(3);

   DECLARE v_ItemID NATIONAL VARCHAR(36);
   DECLARE v_NumberOfItems INT;
   DECLARE v_LaborCurrencyID NATIONAL VARCHAR(3);
   DECLARE v_LaborExchangeRate FLOAT;
   DECLARE v_LaborCost DECIMAL(19,4);

   DECLARE v_AssemblyCost DECIMAL(19,4);
   DECLARE v_QtyItem INT;
   DECLARE v_ItemCost DECIMAL(19,4);
   DECLARE v_ItemCurrencyID NATIONAL VARCHAR(3);
   DECLARE v_ItemExchangeRate FLOAT;
   DECLARE v_QtyOnHand INT; 

   DECLARE v_ExchangeRateDate DATETIME;

   DECLARE v_IsOverflow BOOLEAN;

   DECLARE v_MaxAssemblyQty INT;




   DECLARE v_TranDate DATETIME;
   DECLARE v_ErrorID INT;
   DECLARE NO_DATA INT DEFAULT 0;
   DECLARE v_PrevWarehouseID NATIONAL VARCHAR(36);
   DECLARE v_PrevWarehouseBinID NATIONAL VARCHAR(36);
   DECLARE v_WarehouseID_bin NATIONAL VARCHAR(36);
   DECLARE v_WarehouseBinID_bin NATIONAL VARCHAR(36);
   DECLARE v_PrevQty FLOAT;
   DECLARE v_PrevBackOrderQty FLOAT;
   DECLARE v_Qty_bin FLOAT;
   DECLARE v_AvlblQty_bin FLOAT;
   DECLARE v_BackQty_bin FLOAT;
   DECLARE Counter INT;
   DECLARE Records INT DEFAULT 0;
   DECLARE cInventoryAssembli CURSOR FOR
   SELECT
   ItemID, 
		IFNULL(NumberOfItemsInAssembly,0),
		IFNULL(LaborCost,0)
   FROM
   InventoryAssemblies
   WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   AssemblyID = v_AssemblyID;


   

   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN 

     SET @SWV_Error = 1;
      SET NO_DATA = -2;
   END;
   DECLARE CONTINUE HANDLER FOR NOT FOUND SET NO_DATA = -1;
   BEGIN
      UnableToCreateAssembly:
      BEGIN
         SET @SWV_Error = 0;
         IF IFNULL(v_QtyRequired,0) <= 0 then
            SET v_Result = 2;
            SET SWP_Ret_Value = -1;
            LEAVE SWL_return;
         end if;

         SET v_Result = 1;
         SET v_AssemblyCost = 0;



         select   CurrencyID, DefaultInventoryCostingMethod INTO v_CurrencyID,v_DefaultInventoryCostingMethod FROM
         Companies WHERE
         CompanyID = v_CompanyID AND
         DivisionID = v_DivisionID AND
         DepartmentID = v_DepartmentID;
         select   min(MaxQty) INTO v_MaxAssemblyQty FROM(SELECT
            InventoryAssemblies.ItemID,
	Sum(IFNULL(InventoryByWarehouse.QtyOnHand,0)/IFNULL(InventoryAssemblies.NumberOfItemsInAssembly,1)) as MaxQty
            FROM InventoryAssemblies
            INNER JOIN InventoryByWarehouse ON
            InventoryAssemblies.CompanyID = InventoryByWarehouse.CompanyID AND
            InventoryAssemblies.DivisionID = InventoryByWarehouse.DivisionID AND
            InventoryAssemblies.DepartmentID = InventoryByWarehouse.DepartmentID AND
            InventoryAssemblies.ItemID = InventoryByWarehouse.ItemID
            WHERE
            InventoryAssemblies.CompanyID = v_CompanyID AND
            InventoryAssemblies.DivisionID = v_DivisionID AND
            InventoryAssemblies.DepartmentID = v_DepartmentID AND
            InventoryAssemblies.AssemblyID = v_AssemblyID AND
            InventoryByWarehouse.WarehouseID = v_WarehouseID
            GROUP BY
            InventoryAssemblies.ItemID)
         AS tmpTable;


         IF IFNULL(v_MaxAssemblyQty,0) < v_QtyRequired then

            SET v_QtyRequired = IFNULL(v_MaxAssemblyQty,0);
            SET v_Result = 0;
            SET SWP_Ret_Value = -1;
            LEAVE SWL_return;
         end if;





         START TRANSACTION;


         SET @SWV_Error = 0;
         CALL Inventory_CreateFromAssembly2(v_CompanyID,v_DivisionID,v_DepartmentID,v_AssemblyID, v_ReturnStatus);
         IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then


            SET v_ErrorMessage = 'Inventory_CreateFromAssembly call failed';
            ROLLBACK;

            CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Inventory_Assemblies',v_ErrorMessage,
            v_ErrorID);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'AssemblyID',v_AssemblyID);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'QtyRequired',v_QtyRequired);
            SET SWP_Ret_Value = -1;
         end if;
         SET v_TranDate = CURRENT_TIMESTAMP;
         OPEN cInventoryAssembli;
         SET NO_DATA = 0;
         FETCH cInventoryAssembli INTO v_ItemID,v_NumberOfItems,v_LaborCost;
         WHILE NO_DATA = 0 DO
	
            SET v_QtyItem = v_QtyRequired*v_NumberOfItems;
         
            SET NO_DATA = 0;
          
      SET Counter = WarehouseBinsForSplitCount(v_CompanyID, v_DivisionID, v_DepartmentID, v_WarehouseID, '', v_ItemID, v_QtyItem);
      IF Counter > 0 then
      CALL WarehouseBinsForSplitGetRecord(v_CompanyID, v_DivisionID, v_DepartmentID, v_WarehouseID, '', v_ItemID, v_QtyItem, Records, @outIdent, v_WarehouseID_bin, v_WarehouseBinID_bin, v_Qty_bin, v_AvlblQty_bin, v_BackQty_bin );
            WHILE NO_DATA = 0 DO
               SET @SWV_Error = 0;
	       CALL WarehouseBinLockGoods2(v_CompanyID,v_DivisionID,v_DepartmentID,v_WarehouseID_bin,v_WarehouseBinID_bin,
               v_ItemID,v_AvlblQty_bin,v_BackQty_bin,1, v_ReturnStatus);


               IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then
			
                
				
                  SET v_ErrorMessage = 'WarehouseBinShipGoods failed';
                  ROLLBACK;

                  CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Inventory_Assemblies',v_ErrorMessage,
                  v_ErrorID);
                  CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'AssemblyID',v_AssemblyID);
                  CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'QtyRequired',v_QtyRequired);
                  SET SWP_Ret_Value = -1;
               end if;
               SET NO_DATA = 0;
	       
	       SET Records = Records + 1;
	       IF Records = Counter OR Counter=0 then
	       
	           SET NO_DATA = 1;
	       else
	 	CALL WarehouseBinsForSplitGetRecord(v_CompanyID, v_DivisionID, v_DepartmentID, v_PrevWarehouseID, v_PrevWarehouseBinID, v_ItemID, v_PrevQty, Records, @outIdent, v_WarehouseID_bin, v_WarehouseBinID_bin, v_Qty_bin, v_AvlblQty_bin, v_BackQty_bin );	       
               end if;
           
            END WHILE;
          
	  END IF;	



	
            select   IFNULL(CASE v_DefaultInventoryCostingMethod
            WHEN 'F' THEN FIFOCost
            WHEN 'L' THEN LIFOCost
            WHEN 'A' THEN AverageCost
            ELSE 0
            END,0) INTO v_ItemCost FROM
            InventoryItems WHERE
            CompanyID = v_CompanyID AND
            DivisionID = v_DivisionID AND
            DepartmentID = v_DepartmentID AND
            ItemID = v_ItemID;
            SET v_ExchangeRateDate = CURRENT_TIMESTAMP;
            SET v_QtyRequired = -v_QtyRequired;
	
            SET @SWV_Error = 0;
            CALL Inventory_CreateILTransaction2(v_CompanyID,v_DivisionID,v_DepartmentID,v_TranDate,v_ItemID,'Assembly',
            v_AssemblyID,0,v_QtyRequired,v_ItemCost, v_ReturnStatus);
            IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then
	
	
		
               CLOSE cInventoryAssembli;
		
               SET v_ErrorMessage = 'Inventory_CreateILTransaction call failed';
               ROLLBACK;

               CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Inventory_Assemblies',v_ErrorMessage,
               v_ErrorID);
               CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'AssemblyID',v_AssemblyID);
               CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'QtyRequired',v_QtyRequired);
               SET SWP_Ret_Value = -1;
            end if;
            SET v_QtyRequired = -v_QtyRequired;


	
            SET v_AssemblyCost = v_AssemblyCost+v_ItemCost*v_NumberOfItems+v_LaborCost;
            SET NO_DATA = 0;
            FETCH cInventoryAssembli INTO v_ItemID,v_NumberOfItems,v_LaborCost;
         END WHILE;
         CLOSE cInventoryAssembli;




         SET @SWV_Error = 0;
         CALL Inventory_CreateILTransaction2(v_CompanyID,v_DivisionID,v_DepartmentID,v_TranDate,v_AssemblyID,'Assembly',
         v_AssemblyID,0,v_QtyRequired,v_AssemblyCost, v_ReturnStatus);
         IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then


            SET v_ErrorMessage = 'Inventory_CreateILTransaction call failed';
            ROLLBACK;

            CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Inventory_Assemblies',v_ErrorMessage,
            v_ErrorID);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'AssemblyID',v_AssemblyID);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'QtyRequired',v_QtyRequired);
            SET SWP_Ret_Value = -1;
         end if;



         SET @SWV_Error = 0;
         CALL Inventory_Costing2(v_CompanyID,v_DivisionID,v_DepartmentID,v_AssemblyID,v_WarehouseID,v_QtyRequired,
         v_AssemblyCost,0,v_Result, v_ReturnStatus);
         IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then


            SET v_ErrorMessage = 'Inventory_Costing call failed';
            ROLLBACK;

            CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Inventory_Assemblies',v_ErrorMessage,
            v_ErrorID);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'AssemblyID',v_AssemblyID);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'QtyRequired',v_QtyRequired);
            SET SWP_Ret_Value = -1;
         end if;
         IF  v_Result <> 1 then
            LEAVE UnableToCreateAssembly;
         end if;

         COMMIT;
         SET SWP_Ret_Value = 0;
         LEAVE SWL_return;
      END;
      ROLLBACK;
      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;







   END;
   ROLLBACK;

   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Inventory_Assemblies',v_ErrorMessage,
   v_ErrorID);

   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'AssemblyID',v_AssemblyID);
   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'QtyRequired',v_QtyRequired);

   SET SWP_Ret_Value = -1;
END