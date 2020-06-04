CREATE PROCEDURE Inventory_PopulateItemInfo (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_ItemID NATIONAL VARCHAR(36),
	v_TransactionNumber NATIONAL VARCHAR(36),
	v_ParentTable NATIONAL VARCHAR(80),
	v_Qty INT,
	INOUT v_Result INT  ,
	INOUT v_Description NATIONAL VARCHAR(80)  ,
	INOUT v_ItemUOM NATIONAL VARCHAR(15)  ,
	INOUT v_ItemWeight FLOAT  ,
	INOUT v_DiscountPercent FLOAT ,
	INOUT v_WarehouseID NATIONAL VARCHAR(36)  ,
	INOUT v_WarehouseBinID NATIONAL VARCHAR(36)  ,
	INOUT v_GLAccount NATIONAL VARCHAR(36)  ,
  	INOUT v_ItemCost DECIMAL(19,4)  ,
	INOUT v_ItemPrice DECIMAL(19,4) ,
	INOUT v_Serialized BOOLEAN ,
	INOUT v_SerialNumber NATIONAL VARCHAR(50) ,
	INOUT v_Taxable BOOLEAN ,
	INOUT v_TaxGroupID NATIONAL VARCHAR(36) ,
	INOUT v_PopulateResult NATIONAL VARCHAR(200) ,INOUT SWP_Ret_Value INT) SWL_return:
BEGIN





   DECLARE v_CostingMethod NATIONAL VARCHAR(1);
   DECLARE v_FIFOCost DECIMAL(19,4);
   DECLARE v_LIFOCost DECIMAL(19,4);
   DECLARE v_AverageCost DECIMAL(19,4);
   DECLARE v_DefaultGLTracking NATIONAL VARCHAR(1);
   DECLARE v_TmpGLAccount NATIONAL VARCHAR(36);
   DECLARE v_PriceMatrix NATIONAL VARCHAR(36);
   DECLARE v_CustomerID NATIONAL VARCHAR(36);
   DECLARE v_VendorID NATIONAL VARCHAR(36);
   DECLARE v_TmpItemPrice DECIMAL(19,4);
   DECLARE v_ID NATIONAL VARCHAR(36);
   DECLARE v_CurrDate DATETIME;

   DECLARE v_TransactionTypeID NATIONAL VARCHAR(36);
   select   ItemID, ItemUOM, ItemDescription, FIFOCost, LIFOCost, AverageCost, case
   when v_ParentTable = 'PurchaseHeader' then GLItemCOGSAccount
   else GLItemSalesAccount
   end, Price, ItemWeight, IFNULL(Taxable,0), TaxGroupID INTO v_ID,v_ItemUOM,v_Description,v_FIFOCost,v_LIFOCost,v_AverageCost,v_GLAccount,
   v_ItemPrice,v_ItemWeight,v_Taxable,v_TaxGroupID From
   InventoryItems Where CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND ItemID = v_ItemID;


   IF ROW_COUNT() <= 0 then

      SET v_Result = 0;
      SET SWP_Ret_Value =(-1);
      LEAVE SWL_return;
   end if;		



   if v_ParentTable = 'OrderHeader' then

 
	
      select   OrderNumber, DiscountPers, TransactionTypeID, CustomerID, CustomerID INTO v_ID,v_DiscountPercent,v_TransactionTypeID,v_CustomerID,v_VendorID From OrderHeader Where CompanyID = v_CompanyID
      AND DivisionID = v_DivisionID
      AND DepartmentID = v_DepartmentID
      AND OrderNumber = v_TransactionNumber;
   Else 
      If v_ParentTable = 'InvoiceHeader' then

 
	
         select   InvoiceNumber, DiscountPers, TransactionTypeID, CustomerID INTO v_ID,v_DiscountPercent,v_TransactionTypeID,v_CustomerID From InvoiceHeader Where CompanyID = v_CompanyID
         AND DivisionID = v_DivisionID
         AND DepartmentID = v_DepartmentID
         AND InvoiceNumber = v_TransactionNumber;
      Else 
         If v_ParentTable = 'ContractsHeader' then

 
	
            select   OrderNumber, DiscountPers, TransactionType, CustomerID INTO v_ID,v_DiscountPercent,v_TransactionTypeID,v_CustomerID From ContractsHeader Where CompanyID = v_CompanyID
            AND DivisionID = v_DivisionID
            AND DepartmentID = v_DepartmentID
            AND OrderNumber = v_TransactionNumber;
         Else 
            If v_ParentTable = 'PurchaseHeader' then

 
	
               select   PurchaseNumber, DiscountPers, TransactionTypeID, VendorID, VendorID INTO v_ID,v_DiscountPercent,v_TransactionTypeID,v_VendorID,v_CustomerID From PurchaseHeader Where CompanyID = v_CompanyID
               AND DivisionID = v_DivisionID
               AND DepartmentID = v_DepartmentID
               AND PurchaseNumber = v_TransactionNumber;
            Else
               
SET v_Result = 0;
               SET SWP_Ret_Value =(-2);
               LEAVE SWL_return;
            end if;
         end if;
      end if;
   end if;

   IF ROW_COUNT() <= 0 then 

      
SET v_PopulateResult = CONCAT(' No rows were found in ',v_ParentTable,' with TransactionNumber =',
      v_TransactionNumber);
      SET v_Result = 0;
      SET SWP_Ret_Value =(-3);
      LEAVE SWL_return;
   end if;		


	
   SET v_WarehouseID = WarehouseRoot2(v_CompanyID,v_DivisionID,v_DepartmentID,v_WarehouseID,v_ItemID);
   SET v_WarehouseBinID = WarehouseBinRoot2(v_CompanyID,v_DivisionID,v_DepartmentID,v_WarehouseID,v_WarehouseBinID,
   v_ItemID);


   select   Serialized INTO v_Serialized FROM InventoryItemTypes WHERE
   CompanyID = v_CompanyID  AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   ItemTypeID =(SELECT ItemTypeID
      FROM InventoryItems
      WHERE
      CompanyID = v_CompanyID  AND
      DivisionID = v_DivisionID AND
      DepartmentID = v_DepartmentID AND
      ItemID = v_ItemID);

   IF v_Serialized = 1 then
	
      select   SerialNumber INTO v_SerialNumber FROM InventorySerialNumbers WHERE
      CompanyID = v_CompanyID  AND
      DivisionID = v_DivisionID AND
      DepartmentID = v_DepartmentID AND
      ItemID = v_ItemID AND
      WarehouseID = v_WarehouseID AND
      WarehouseBinID = v_WarehouseBinID AND
      CurrentLotOrderQty >= IFNULL(v_Qty,0)   ORDER BY CurrentLotOrderQty ASC LIMIT 1;
      IF IFNULL(v_SerialNumber,'') = '' then
			
         
SET v_PopulateResult = 'there are no serialized items available';
         SET v_Result = 0;
         SET SWP_Ret_Value =(-6);
         LEAVE SWL_return;
      end if;
   end if;



   If v_ParentTable = 'PurchaseHeader' then
      select   DefaultInventoryCostingMethod, DefaultGLPurchaseGLTracking INTO v_CostingMethod,v_DefaultGLTracking From Companies Where CompanyID = v_CompanyID  AND
      DivisionID = v_DivisionID AND
      DepartmentID = v_DepartmentID;
   else
      select   DefaultInventoryCostingMethod, DefaultSalesGLTracking INTO v_CostingMethod,v_DefaultGLTracking From Companies Where CompanyID = v_CompanyID  AND
      DivisionID = v_DivisionID AND
      DepartmentID = v_DepartmentID;
   end if;


   IF ROW_COUNT() <= 0 then 

      
SET v_PopulateResult = CONCAT(' No rows were found in Companies with CompanyID =',v_CompanyID);
      SET v_Result = 0;
      SET SWP_Ret_Value =(-4);
      LEAVE SWL_return;
   end if;		


   IF  v_CostingMethod = 'F' then

      SET v_ItemCost = v_FIFOCost;
   ELSE 
      IF  v_CostingMethod = 'L' then

         SET v_ItemCost = v_LIFOCost;
      ELSE 
         IF  v_CostingMethod = 'A' then

            SET v_ItemCost = v_AverageCost;
         ELSE
            SET  v_ItemCost = 0;
         end if;
      end if;
   end if;


   If (v_ParentTable = 'PurchaseHeader' AND IFNULL(v_TransactionTypeID,N'') <> 'RMA') OR
	(v_ParentTable = 'OrderHeader' AND  IFNULL(v_TransactionTypeID,N'') = 'Return') OR
	(v_ParentTable = 'InvoiceHeader' AND  IFNULL(v_TransactionTypeID,N'') = 'Return') then

      SET v_CustomerID = NULL;
      select   GLPurchaseAccount, PriceMatrix INTO v_TmpGLAccount,v_PriceMatrix From VendorInformation Where CompanyID = v_CompanyID
      AND DivisionID = v_DivisionID
      AND DepartmentID = v_DepartmentID
      AND VendorID = v_VendorID;
   Else
      SET v_VendorID = NULL;
      select   CustomerID, GLSalesAccount, PriceMatrix INTO v_ID,v_TmpGLAccount,v_PriceMatrix From CustomerInformation Where CompanyID = v_CompanyID
      AND DivisionID = v_DivisionID
      AND DepartmentID = v_DepartmentID
      AND CustomerID = v_CustomerID;
   end if;
   IF ROW_COUNT() <= 0 then 


      
SET v_PopulateResult = CONCAT(' No rows were found in CustomerInformation with CustomerID =',
      v_CustomerID);
      SET v_Result = 0;
      SET SWP_Ret_Value =(-5);
      LEAVE SWL_return;
   end if;		



   If v_DefaultGLTracking = '1' then

      SET v_GLAccount = v_TmpGLAccount;
   end if;


   CALL Inventory_PopulatePrice2(v_CompanyID,v_DivisionID,v_DepartmentID,v_ItemID,NULL,v_CustomerID,v_VendorID,
   v_TmpItemPrice, @SWP_Poupulate_Out);














   IF IFNULL(v_TmpItemPrice,0) > 0 then

      Set v_ItemPrice = v_TmpItemPrice;
   ELSE 
      If (v_ParentTable = 'PurchaseHeader' AND IFNULL(v_TransactionTypeID,N'') <> 'RMA') OR
	(v_ParentTable = 'OrderHeader' AND  IFNULL(v_TransactionTypeID,N'') = 'Return') OR
	(v_ParentTable = 'InvoiceHeader' AND  IFNULL(v_TransactionTypeID,N'') = 'Return') then

         Set v_ItemPrice = v_ItemCost;
      end if;
   end if;



   SET v_Result = 1;

   SET SWP_Ret_Value = 0;
END