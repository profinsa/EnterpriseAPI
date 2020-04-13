update databaseinfo set value='2019_04_05',lastupdate=now() WHERE id='Version';
-- alter table orderheader ADD COLUMN CreatedByCart tinyint(1) after ManagerPassword;
DELIMITER //
DROP PROCEDURE IF EXISTS Inventory_Assemblies;
//
CREATE             PROCEDURE Inventory_Assemblies(v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_AssemblyID NATIONAL VARCHAR(36),
	v_WarehouseID NATIONAL VARCHAR(36),
	INOUT v_QtyRequired INT ,
	INOUT v_Result INT  ,INOUT SWP_Ret_Value INT)
   SWL_return:
BEGIN


/*
Name of stored procedure: Inventory_Assemblies
Method: 
	ALTER   Items from Assembly, takes as input
	Number of items to ALTER   and the assembly ID

Date Created: EDE - 07/28/2015

Input Parameters:

	@CompanyID NVARCHAR(36)		 - the ID of the company
	@DivisionID NVARCHAR(36)	 - the ID of the division
	@DepartmentID NVARCHAR(36)	 - the ID of the department
	@AssemblyID NVARCHAR(36)	 - the ID of the assembly to be created
	@WarehouseID NVARCHAR(36)	 - the ID of the warehouse
	@QtyRequired INT		 - the quantity required

Output Parameters:

	@Result INT  			 - Return values (@Result)
					   1	the operation completed successfuly
					   0	the quantities are not enough
					   2	passed @QtyRequired has invalid value, it should be >0
					   -1	there was a database error in processing the request

Called From:

	Order_CreateAssembly, Inventory_Assemblies.vb

Calls:

	WarehouseBinShipGoods, VerifyCurrency, WarehouseBinPutGoods, Inventory_Costing, Error_InsertError, Error_InsertErrorDetail, Inventory_CreateFromAssembly

Last Modified: 

Last Modified By: 

Revision History: 

*/

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
   DECLARE v_QtyOnHand INT; -- current quanity in the warehouse

   DECLARE v_ExchangeRateDate DATETIME;

   DECLARE v_IsOverflow BOOLEAN;

   DECLARE v_MaxAssemblyQty INT;


-- Find maximum number of assembly items that can be gathered
-- from esisting compound items in the warehouse
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


   /*DECLARE cBins CURSOR
   FOR SELECT 
   WarehouseID, WarehouseBinID, Qty, AvlblQty, BackQty
   FROM 
   WarehouseBinsForSplit(v_CompanyID,v_DivisionID,v_DepartmentID,v_WarehouseID,'',v_ItemID,v_QtyItem);*/

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

-- get the currency of the company 
-- get DefaultInventoryCostingMethod from companies
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

-- It is not enough existing items to create requested assembly count
         IF IFNULL(v_MaxAssemblyQty,0) < v_QtyRequired then

            SET v_QtyRequired = IFNULL(v_MaxAssemblyQty,0);
            SET v_Result = 0;
            SET SWP_Ret_Value = -1;
            LEAVE SWL_return;
         end if;




-- @MaxAssemblyQty>= @QtyRequired and we can create assembly
         START TRANSACTION;

-- Create the inventory item for assembly if it is not exists yet
         SET @SWV_Error = 0;
         CALL Inventory_CreateFromAssembly2(v_CompanyID,v_DivisionID,v_DepartmentID,v_AssemblyID, v_ReturnStatus);
         IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then
-- An error occured, go to the error handler

            SET v_ErrorMessage = 'Inventory_CreateFromAssembly call failed';
            ROLLBACK;
-- the error handler
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
	-- get all the quantity of the intem into the assembly's warehouse 
            SET v_QtyItem = v_QtyRequired*v_NumberOfItems;
         --   OPEN cBins;
            SET NO_DATA = 0;
          --  FETCH cBins INTO v_WarehouseID_bin,v_WarehouseBinID_bin,v_Qty_bin,v_AvlblQty_bin,v_BackQty_bin;
      SET Counter = WarehouseBinsForSplitCount(v_CompanyID, v_DivisionID, v_DepartmentID, v_PrevWarehouseID, v_PrevWarehouseBinID, v_ItemID, v_PrevQty);      
      SET Records = Records + 1;
      CALL WarehouseBinsForSplitGetRecord(v_CompanyID, v_DivisionID, v_DepartmentID, v_PrevWarehouseID, v_PrevWarehouseBinID, v_ItemID, v_PrevQty, Records, @outIdent, v_WarehouseID_bin, v_WarehouseBinID_bin, v_Qty_bin, v_AvlblQty_bin, v_BackQty_bin );
      	   IF Records = Counter OR Counter=0 then
		SET NO_DATA = 1;
           end if;

            WHILE NO_DATA = 0 DO
               SET @SWV_Error = 0;
	       CALL WarehouseBinShipGoods2(v_CompanyID,v_DivisionID,v_DepartmentID,v_WarehouseID_bin,v_WarehouseBinID_bin,
               v_ItemID,v_AvlblQty_bin,v_BackQty_bin,3, v_ReturnStatus);
               IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then
			
                --  CLOSE cOD;
				
                  SET v_ErrorMessage = 'WarehouseBinShipGoods failed';
                  ROLLBACK;
-- the error handler
                  CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Inventory_Assemblies',v_ErrorMessage,
                  v_ErrorID);
                  CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'AssemblyID',v_AssemblyID);
                  CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'QtyRequired',v_QtyRequired);
                  SET SWP_Ret_Value = -1;
               end if;
               SET NO_DATA = 0;
 		SET Records = Records + 1;
	 	CALL WarehouseBinsForSplitGetRecord(v_CompanyID, v_DivisionID, v_DepartmentID, v_PrevWarehouseID, v_PrevWarehouseBinID, v_ItemID, v_PrevQty, Records, @outIdent, v_WarehouseID_bin, v_WarehouseBinID_bin, v_Qty_bin, v_AvlblQty_bin, v_BackQty_bin );
           --   FETCH cBins INTO v_WarehouseID_bin,v_WarehouseBinID_bin,v_Qty_bin,v_AvlblQty_bin,v_BackQty_bin;
            END WHILE;
          --  CLOSE cBins;
	



	-- get the cost of the item and add it to the cost of the assembly
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
	-- Post inventory changes to InventoryLedger table and recalc item cost
            SET @SWV_Error = 0;
            CALL Inventory_CreateILTransaction2(v_CompanyID,v_DivisionID,v_DepartmentID,v_TranDate,v_ItemID,'Assembly',
            v_AssemblyID,0,v_QtyRequired,v_ItemCost, v_ReturnStatus);
            IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then
	-- An error occured, go to the error handler
	
		-- the procedure will return an error code
               CLOSE cInventoryAssembli;
		
               SET v_ErrorMessage = 'Inventory_CreateILTransaction call failed';
               ROLLBACK;
-- the error handler
               CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Inventory_Assemblies',v_ErrorMessage,
               v_ErrorID);
               CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'AssemblyID',v_AssemblyID);
               CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'QtyRequired',v_QtyRequired);
               SET SWP_Ret_Value = -1;
            end if;
            SET v_QtyRequired = -v_QtyRequired;


	-- get the cost of the item and add it to the assembly cost
            SET v_AssemblyCost = v_AssemblyCost+v_ItemCost*v_NumberOfItems+v_LaborCost;
            SET NO_DATA = 0;
            FETCH cInventoryAssembli INTO v_ItemID,v_NumberOfItems,v_LaborCost;
         END WHILE;
         CLOSE cInventoryAssembli;



-- put inventory
         SET @SWV_Error = 0;
         CALL WarehouseBinPutGoods2(v_CompanyID,v_DivisionID,v_DepartmentID,v_WarehouseID,'',v_AssemblyID,
         NULL,NULL,NULL,NULL,v_QtyRequired,6,v_IsOverflow, v_ReturnStatus);
         IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then
-- An error occured, go to the error handler

            SET v_ErrorMessage = 'WarehouseBinPutGoods call failed';
            ROLLBACK;
-- the error handler
            CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Inventory_Assemblies',v_ErrorMessage,
            v_ErrorID);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'AssemblyID',v_AssemblyID);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'QtyRequired',v_QtyRequired);
            SET SWP_Ret_Value = -1;
         end if;

-- Post inventory changes to InventoryLedger table and recalc item cost
         SET @SWV_Error = 0;
         CALL Inventory_CreateILTransaction2(v_CompanyID,v_DivisionID,v_DepartmentID,v_TranDate,v_AssemblyID,'Assembly',
         v_AssemblyID,0,v_QtyRequired,v_AssemblyCost, v_ReturnStatus);
         IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then
-- An error occured, go to the error handler

            SET v_ErrorMessage = 'Inventory_CreateILTransaction call failed';
            ROLLBACK;
-- the error handler
            CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Inventory_Assemblies',v_ErrorMessage,
            v_ErrorID);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'AssemblyID',v_AssemblyID);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'QtyRequired',v_QtyRequired);
            SET SWP_Ret_Value = -1;
         end if;


-- update the cost of the assembly
         SET @SWV_Error = 0;
         CALL Inventory_Costing2(v_CompanyID,v_DivisionID,v_DepartmentID,v_AssemblyID,v_WarehouseID,v_QtyRequired,
         v_AssemblyCost,0,v_Result, v_ReturnStatus);
         IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then
-- An error occured, go to the error handler

            SET v_ErrorMessage = 'Inventory_Costing call failed';
            ROLLBACK;
-- the error handler
            CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Inventory_Assemblies',v_ErrorMessage,
            v_ErrorID);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'AssemblyID',v_AssemblyID);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'QtyRequired',v_QtyRequired);
            SET SWP_Ret_Value = -1;
         end if;
         IF  v_Result <> 1 then
            LEAVE UnableToCreateAssembly;
         end if;
-- Everything is OK
         COMMIT;
         SET SWP_Ret_Value = 0;
         LEAVE SWL_return;
      END;
      ROLLBACK;
      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;
-- if an error occured in the procedure this code will be executed
-- The information about the error are entered in the ErrrorLog and ErrorLogDetail tables.
-- The company, division, department informations are inserted in the ErrorLog table
-- along with information about the name of the procedure and the error message and an errorID is obtained.
-- The aditional information about other procedure parameters are inserted along with the errorID in the ErrorLogDetail table
-- (about the other parameters the name and the value are inserted).

   END;
   ROLLBACK;
-- the error handler
   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Inventory_Assemblies',v_ErrorMessage,
   v_ErrorID);

   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'AssemblyID',v_AssemblyID);
   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'QtyRequired',v_QtyRequired);

   SET SWP_Ret_Value = -1;
END;



//

DELIMITER ;

