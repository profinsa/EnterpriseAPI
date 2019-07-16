CREATE PROCEDURE Purchase_CreateFromBackOrders (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),INOUT SWP_Ret_Value INT) SWL_return:
BEGIN









   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);
   DECLARE v_PurchaseNumberNew NATIONAL VARCHAR(36);

   DECLARE v_VendorID NATIONAL VARCHAR(50);
   DECLARE v_ItemID NATIONAL VARCHAR(36);
   DECLARE v_WarehouseID NATIONAL VARCHAR(36);
   DECLARE v_WarehouseBinID NATIONAL VARCHAR(36);
   DECLARE v_QtyOnBackorder INT;
   DECLARE v_ItemUOM NATIONAL VARCHAR(15);
   DECLARE v_ItemWeight FLOAT;
   DECLARE v_IsAssembly BOOLEAN;

   DECLARE v_GLPurchaseAccount NATIONAL VARCHAR(36);
   DECLARE v_PurchaseHasDetails BOOLEAN;
   DECLARE v_AssemblyCreated BOOLEAN;
   DECLARE v_Result INT;

   DECLARE v_IsOverflow BOOLEAN;

   DECLARE v_ErrorID INT;
   DECLARE NO_DATA INT DEFAULT 0;
   DECLARE cVendorForItems CURSOR FOR
   SELECT DISTINCT
   InventoryItems.VendorID
   FROM
   InventoryByWarehouse INNER JOIN InventoryItems ON
   InventoryByWarehouse.CompanyID = InventoryItems.CompanyID AND
   InventoryByWarehouse.DivisionID = InventoryItems.DivisionID AND
   InventoryByWarehouse.DepartmentID = InventoryItems.DepartmentID AND
   InventoryByWarehouse.ItemID = InventoryItems.ItemID
   WHERE
   InventoryByWarehouse.CompanyID = v_CompanyID AND
   InventoryByWarehouse.DivisionID = v_DivisionID AND
   InventoryByWarehouse.DepartmentID = v_DepartmentID AND
   InventoryByWarehouse.QtyOnBackorder > 0;


   DECLARE cItemsForVendor CURSOR FOR
   SELECT
   InventoryByWarehouse.ItemID,
			InventoryByWarehouse.WarehouseID,
			InventoryByWarehouse.WarehouseBinID,
			InventoryByWarehouse.QtyOnBackorder,
			InventoryItems.ItemUOM,
			InventoryItems.ItemWeight,
			InventoryItems.IsAssembly
   FROM
   InventoryByWarehouse INNER JOIN InventoryItems ON
   InventoryByWarehouse.CompanyID = InventoryItems.CompanyID AND
   InventoryByWarehouse.DivisionID = InventoryItems.DivisionID AND
   InventoryByWarehouse.DepartmentID = InventoryItems.DepartmentID AND
   InventoryByWarehouse.ItemID = InventoryItems.ItemID
   WHERE
   InventoryByWarehouse.CompanyID = v_CompanyID AND
   InventoryByWarehouse.DivisionID = v_DivisionID AND
   InventoryByWarehouse.DepartmentID = v_DepartmentID AND
   InventoryByWarehouse.QtyOnBackorder > 0 AND
   InventoryItems.VendorID = v_VendorID;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
      SET NO_DATA = -2;
   END;
   DECLARE CONTINUE HANDLER FOR NOT FOUND SET NO_DATA = -1;
   SET @SWV_Error = 0;
   SET v_PurchaseHasDetails = 1;
   SET v_AssemblyCreated = 0;

   START TRANSACTION;


   select   GLAPAccount INTO v_GLPurchaseAccount FROM
   Companies WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID;





   OPEN cVendorForItems;
   SET NO_DATA = 0;
   FETCH cVendorForItems INTO v_VendorID;

   WHILE NO_DATA <> 0 DO
	
	
      IF (v_PurchaseHasDetails = 1) then
	
		
         SET @SWV_Error = 0;
         SET v_ReturnStatus = GetNextEntityID(v_CompanyID,v_DivisionID,v_DepartmentID,'NextPurchaseOrderNumber',v_PurchaseNumberNew);
         IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then
		
            CLOSE cVendorForItems;
			
            SET v_ErrorMessage = 'GetNextEntityID call failed';
            ROLLBACK;


            CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Purchase_CreateFromBackOrders',
            v_ErrorMessage,v_ErrorID);
            SET SWP_Ret_Value = -1;
         end if;
      end if;
      SET v_PurchaseHasDetails = 0;

	
	
	


	
      OPEN cItemsForVendor;
      SET NO_DATA = 0;
      FETCH cItemsForVendor INTO v_ItemID,v_WarehouseID,v_WarehouseBinID,v_QtyOnBackorder,v_ItemUOM,v_ItemWeight, 
      v_IsAssembly;
      WHILE NO_DATA <> 0 DO
         SET v_AssemblyCreated = 0;

		
         IF (v_IsAssembly = 1) then
		
            SET @SWV_Error = 0;
            SET v_ReturnStatus = Order_CreateAssembly2(v_CompanyID,v_DivisionID,v_DepartmentID,v_ItemID,v_QtyOnBackorder,v_Result);
			
            IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then
			
               CLOSE cVendorForItems;
				
               CLOSE cItemsForVendor;
				
               SET v_ErrorMessage = 'Order_CreateAssembly call failed';
               ROLLBACK;


               CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Purchase_CreateFromBackOrders',
               v_ErrorMessage,v_ErrorID);
               SET SWP_Ret_Value = -1;
            end if;

			
            IF v_Result = 0 then
			
				
               SET v_AssemblyCreated = 1;
            end if;
         end if;		

		
		
         IF (v_AssemblyCreated = 0) then
		
			
            SET v_PurchaseHasDetails = 1;
			
            SET @SWV_Error = 0;
            INSERT INTO PurchaseDetail(CompanyID,
				 DivisionID,
				 DepartmentID,
				 PurchaseNumber ,
				 ItemID,
				 WarehouseID,
				 OrderQty ,
				 ItemUOM,
				 ItemWeight ,
				 TotalWeight,
				 GLPurchaseAccount ,
				 Received)
			VALUES(v_CompanyID,
				v_DivisionID,
				v_DepartmentID,
				v_PurchaseNumberNew,
				v_ItemID,
				v_WarehouseID,
				v_QtyOnBackorder,
				v_ItemUOM,
				v_ItemWeight,
				v_QtyOnBackorder*v_ItemWeight,
				v_GLPurchaseAccount,
				0);
			
            IF @SWV_Error <> 0 then
			
               CLOSE cVendorForItems;
				
               CLOSE cItemsForVendor;
				
               SET v_ErrorMessage = 'Insert into PurchaseDetail failed';
               ROLLBACK;


               CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Purchase_CreateFromBackOrders',
               v_ErrorMessage,v_ErrorID);
               SET SWP_Ret_Value = -1;
            end if;
			
            SET @SWV_Error = 0;
            SET v_ReturnStatus = WarehouseBinPutGoods(v_CompanyID,v_DivisionID,v_DepartmentID,v_WarehouseID,v_WarehouseBinID,
            v_ItemID,NULL,NULL,NULL,NULL,v_QtyOnBackorder,1,v_IsOverflow);
            IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then
			
               CLOSE cVendorForItems;
				
               CLOSE cItemsForVendor;
				
               SET v_ErrorMessage = 'WarehouseBinPutGoods failed';
               ROLLBACK;


               CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Purchase_CreateFromBackOrders',
               v_ErrorMessage,v_ErrorID);
               SET SWP_Ret_Value = -1;
            end if;
         end if;
         SET NO_DATA = 0;
         FETCH cItemsForVendor INTO v_ItemID,v_WarehouseID,v_WarehouseBinID,v_QtyOnBackorder,v_ItemUOM,v_ItemWeight, 
         v_IsAssembly;
      END WHILE;
      CLOSE cItemsForVendor;
	
	
	
	
      IF (v_PurchaseHasDetails = 1) then
	
         SET @SWV_Error = 0;
         INSERT INTO PurchaseHeader(CompanyID,
			DivisionID,
			DepartmentID,
			VendorID,
			PurchaseNumber,
			TransactionTypeID,
			PurchaseDate,
			Posted,
			AmountPaid)
		VALUES(v_CompanyID,
			v_DivisionID ,
			v_DepartmentID ,
			v_VendorID,
			v_PurchaseNumberNew ,
			'PurchaseOrder',
			CURRENT_TIMESTAMP,
			0,
			0);
		
         IF @SWV_Error <> 0 then
		
            CLOSE cVendorForItems;
			
            SET v_ErrorMessage = 'Insert into PurchaseHeader failed';
            ROLLBACK;


            CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Purchase_CreateFromBackOrders',
            v_ErrorMessage,v_ErrorID);
            SET SWP_Ret_Value = -1;
         end if;
      end if;
      SET NO_DATA = 0;
      FETCH cVendorForItems INTO v_VendorID;
   END WHILE;

   CLOSE cVendorForItems;



   COMMIT;
   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;









   ROLLBACK;


   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Purchase_CreateFromBackOrders',
   v_ErrorMessage,v_ErrorID);

   SET SWP_Ret_Value = -1;
END