DELIMITER //
DROP PROCEDURE IF EXISTS Inventory_Transfer;
//
CREATE   PROCEDURE Inventory_Transfer(v_CompanyID NATIONAL VARCHAR(36), 
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_ItemID NATIONAL VARCHAR(36),
	v_WarehouseID NATIONAL VARCHAR(36),
	v_WarehouseBinID NATIONAL VARCHAR(36),
	v_TransferWarehouseID NATIONAL VARCHAR(36),
	v_TransferWarehouseBinID NATIONAL VARCHAR(36),
	v_TransferQty INT,INOUT SWP_Ret_Value INT)
   SWL_return:
BEGIN










/*
Name of stored procedure: Inventory_Transfer
Method: 
	Trnasfers inventory items from one warehouse bin to another one

Date Created: EDE - 07/28/2015

Input Parameters:

	@CompanyID NVARCHAR(36)		 - the ID of the company
	@DivisionID NVARCHAR(36)	 - the ID of the division
	@DepartmentID NVARCHAR(36)	 - the ID of the department
	@ItemID NVARCHAR(36)		 - the ID of inventory item
	@WarehouseID NVARCHAR(36)	 - source warehouse
	@WarehouseBinID NVARCHAR(36)	 - source warehouse bin
	@TransferWarehouseID NVARCHAR(36) - destination warehouse
	@TransferWarehouseBinID NVARCHAR(36) - destination warehouse bin
	@TransferQty INT		 - items quantity to transfer

Output Parameters:

	NONE

Called From:

	Inventory_Transfer.vb

Calls:

	WarehouseBinShipGoods, WarehouseBinPutGoods, Error_InsertError, Error_InsertErrorDetail

Last Modified: 

Last Modified By: 

Revision History: 

*/

   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);
   DECLARE v_QtyOnHand INT;
   DECLARE v_QtyOnHandBeforeTrans INT;
   DECLARE v_QtyOnHandAfterTrans INT;
   DECLARE v_IsOverflow BOOLEAN;
   DECLARE v_ErrorID INT;
   IF v_TransferQty = 0 then
      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;
   end if;


   START TRANSACTION;

-- check for Transfer Qty >= 0
   IF v_TransferQty < 0 then
	
      SET v_ErrorMessage = 'Transfer Qty less then zero';
      ROLLBACK;
-- the error handler

      IF v_ErrorMessage <> '' then

	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Inventory_Transfer',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'ItemID',v_ItemID);
      end if;
      SET SWP_Ret_Value = -1;
   end if;

-- check for Qty On Hand >= Transfer Qty
   select   IFNULL(QtyOnHand,0) INTO v_QtyOnHand FROM InventoryByWarehouse WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND WarehouseID = v_WarehouseID
   AND WarehouseBinID = v_WarehouseBinID
   AND ItemID = v_ItemID;

   IF v_QtyOnHand < v_TransferQty then
	
      SET v_ErrorMessage = 'Qty On Hand less then Transfer Qty';
      ROLLBACK;
-- the error handler

      IF v_ErrorMessage <> '' then

	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Inventory_Transfer',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'ItemID',v_ItemID);
      end if;
      SET SWP_Ret_Value = -1;
   end if;


-- debit goods
   SET v_ReturnStatus = WarehouseBinShipGoods2(v_CompanyID,v_DivisionID,v_DepartmentID,v_WarehouseID,v_WarehouseBinID,
   v_ItemID,v_TransferQty,0,3);
   IF v_ReturnStatus = -1 then

      SET v_ErrorMessage = 'WarehouseBinShipGoods call failed';
      ROLLBACK;
-- the error handler

      IF v_ErrorMessage <> '' then

	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Inventory_Transfer',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'ItemID',v_ItemID);
      end if;
      SET SWP_Ret_Value = -1;
   end if;


-- previous Qty On Hand for transfer bin
   select   IFNULL(QtyOnHand,0) INTO v_QtyOnHandBeforeTrans FROM InventoryByWarehouse WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND WarehouseID = v_TransferWarehouseID
   AND WarehouseBinID = v_TransferWarehouseBinID
   AND ItemID = v_ItemID;
   SET v_QtyOnHandBeforeTrans = IFNULL(v_QtyOnHandBeforeTrans,0);


-- credit goods
   SET v_ReturnStatus = WarehouseBinPutGoods(v_CompanyID,v_DivisionID,v_DepartmentID,v_TransferWarehouseID,v_TransferWarehouseBinID,
   v_ItemID,NULL,NULL,NULL,NULL,v_TransferQty,6,v_IsOverflow);
   IF v_ReturnStatus = -1 then

      SET v_ErrorMessage = 'WarehouseBinPutGoods call failed';
      ROLLBACK;
-- the error handler

      IF v_ErrorMessage <> '' then

	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Inventory_Transfer',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'ItemID',v_ItemID);
      end if;
      SET SWP_Ret_Value = -1;
   end if;


-- Qty On Hand for transfer bin
   select   IFNULL(QtyOnHand,0) INTO v_QtyOnHandAfterTrans FROM InventoryByWarehouse WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND WarehouseID = v_TransferWarehouseID
   AND WarehouseBinID = v_TransferWarehouseBinID
   AND ItemID = v_ItemID;
   SET v_QtyOnHandAfterTrans = IFNULL(v_QtyOnHandAfterTrans,0);


-- check for transfer bin
   IF v_QtyOnHandAfterTrans -v_QtyOnHandBeforeTrans <> v_TransferQty then
	
      SET v_ErrorMessage = 'Transfer Qty more then available empty';
      ROLLBACK;
-- the error handler

      IF v_ErrorMessage <> '' then

	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Inventory_Transfer',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'ItemID',v_ItemID);
      end if;
      SET SWP_Ret_Value = -1;
   end if;


-- Everything is OK
   COMMIT;
   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;


-- if an error occured in the procedure this code will be executed
-- The information about the error are entered in the ErrrorLog and ErrorLogDetail tables.
-- The company, division, department informations are inserted in the ErrorLog table
-- along with information about the name of the procedure and the error message and an errorID is obtained.
-- The aditional information about other procedure parameters are inserted along with the errorID in the ErrorLogDetail table
-- (about the other parameters the name and the value are inserted).
   ROLLBACK;
-- the error handler

   IF v_ErrorMessage <> '' then

	
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Inventory_Transfer',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'ItemID',v_ItemID);
   end if;
   SET SWP_Ret_Value = -1;
END;











//

DELIMITER ;

-- Stored procedure definition script WarehouseBinPutGoods2 for MySQL
-- Generated by (c) Ispirer SQLWays 4.0 Build 219 Licensed to STFB
-- Timestamp: Tue Jul 28 16:20:00 2015

DELIMITER //
DROP PROCEDURE IF EXISTS WarehouseBinPutGoods2;
//
CREATE  PROCEDURE WarehouseBinPutGoods2(v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_WarehouseID NATIONAL VARCHAR(36),
	v_WarehouseBinID NATIONAL VARCHAR(36),
	v_InventoryItemID NATIONAL VARCHAR(36),
	v_PurchaseNumber NATIONAL VARCHAR(36),
	v_PurchaseLineNumber NUMERIC(18,0),
	v_SerialNumber NATIONAL VARCHAR(50),
	v_ReceivedDate DATETIME,
	v_Qty INT,
	v_Action INT,
	INOUT v_IsOverflow BOOLEAN ,INOUT SWP_Ret_Value INT)
   SWL_return:
BEGIN

/*
Name of stored procedure: WarehouseBinPutGoods
Method:
	this procedure put goods into warehouse bin
Date Created: EDE - 07/28/2015
Input Parameters:
	@CompanyID NVARCHAR(36)		 - the ID of the company
	@DivisionID NVARCHAR(36)	 - the ID of the division
	@DepartmentID NVARCHAR(36)	 - the ID of the department
	@WarehouseID NVARCHAR(36)	 - the ID of warehouse
	@WarehouseBinID NVARCHAR(36)	 - the ID of warehouse bin
	@InventoryItemID NVARCHAR(36)	 - the ID of inventory item
	@PurchaseNumber NVARCHAR(36)	 - the purchase number
	@PurchaseLineNumber NUMERIC(18	 - the detail purchase item ID
	@SerialNumber NVARCHAR(50)	 - serial number
	@ReceivedDate DATETIME		 - purchase receiving date
	@Qty INT			 - the inventory items count
	@Action INT			 - defines the operation that is performed with inventory items
							
1 - increase InventoryByWarehouse.QtyOnOrder in @Qty value used from Purchase_CreateFromBackOrders,Purchase_CreateFromOrder,Purchase_CreateFromReorder,Purchase_Post,RMA_Post procedures
2 - decrease InventoryByWarehouse.QtyOnOrder in @Qty value increase InventoryByWarehouse.QtyOnHand in @Qty value used from Receiving_AdjustInventory procedures
3 - decrease InventoryByWarehouse.QtyOnOrder in @Qty value used from DebitMemo_Cancel,Purchase_Cancel,RMA_Cancel procedures
4 - decrease InventoryByWarehouse.QtyOnHand in @Qty value used from DebitMemo_Cancel,Purchase_Cancel,RMA_Cancel procedures
5 - decrease InventoryByWarehouse.QtyOnHand in @Qty value not used from procedures
6 - increase InventoryByWarehouse.QtyOnHand in @Qty value used from Inventory_Assemblies,Inventory_Transfer procedures

   else - nothing

Output Parameters:
	@IsOverflow BIT 		 - retuns overflow status of the warehouse bit that accepts inventory
Called From:
	Purchase_CreateFromOrder, Inventory_Assemblies, Purchase_CreateFromBackOrders, RMA_Post, Purchase_Post, Purchase_Cancel, Purchase_CreateFromReorder, Inventory_Transfer, Receiving_AdjustInventory, RMA_Cancel, DebitMemo_Cancel
Calls:
	WarehouseBinGet, SerialNumber_Put, Error_InsertError, Error_InsertErrorDetail
Last Modified:
Last Modified By:
Revision History:
*/

   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);
   DECLARE v_QtyBin BIGINT;
   DECLARE v_AvailableEmpty BIGINT;
   DECLARE v_OverFlowBin NATIONAL VARCHAR(36);
   DECLARE v_ErrorID INT;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
   END;
   BEGIN
      PutToBin: BEGIN
      BEGIN
         SET @SWV_Error = 0;
         IF v_Qty = 0 then
		
            SET SWP_Ret_Value = 0;
            LEAVE SWL_return;
         end if;
	-- check input parameters
         IF v_Qty < 0 then
		
            SET v_ErrorMessage = 'Wrong inventory quantity';
            ROLLBACK;
            CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'WarehouseBinPutGoods',v_ErrorMessage,
            v_ErrorID);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'WarehouseID',v_WarehouseID);
            SET SWP_Ret_Value = -1;
         end if;
	-- get default Warehouse
         SET @SWV_Error = 0;
         SET v_ReturnStatus = WarehouseBinGet2(v_CompanyID,v_DivisionID,v_DepartmentID,v_InventoryItemID,v_WarehouseID,
         v_WarehouseBinID);
         IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then
	
            SET v_ErrorMessage = 'Get default root warehouse bin failed';
            ROLLBACK;
            CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'WarehouseBinPutGoods',v_ErrorMessage,
            v_ErrorID);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'WarehouseID',v_WarehouseID);
            SET SWP_Ret_Value = -1;
         end if;
         START TRANSACTION;
      END;				
      IF v_WarehouseBinID = 'Overflow' then
		
         IF(SELECT COUNT(*) FROM InventoryByWarehouse
         WHERE
         CompanyID = v_CompanyID AND
         DivisionID = v_DivisionID AND
         DepartmentID = v_DepartmentID AND
         ItemID = v_InventoryItemID AND
         WarehouseID = v_WarehouseID AND
         WarehouseBinID = v_WarehouseBinID) = 0 then
            SET @SWV_Error = 0;
            INSERT INTO InventoryByWarehouse(CompanyID,
							DivisionID,
							DepartmentID,
							ItemID,
							WarehouseID,
							WarehouseBinID,
							QtyOnHand,
							QtyCommitted,
							QtyOnOrder,
							QtyOnBackorder)
					VALUES(v_CompanyID,
							v_DivisionID,
							v_DepartmentID,
							v_InventoryItemID,
							v_WarehouseID,
							v_WarehouseBinID,
							0,
							0,
							0,
							0);
					
            IF @SWV_Error <> 0 then
					
               SET v_ErrorMessage = 'Insert InventoryByWarehouse bin failed';
               ROLLBACK;
               CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'WarehouseBinPutGoods',v_ErrorMessage,
               v_ErrorID);
               CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'WarehouseID',v_WarehouseID);
               SET SWP_Ret_Value = -1;
            end if;
         end if;
			-- put to bin
         SET @SWV_Error = 0;
         UPDATE InventoryByWarehouse
         SET
         QtyOnHand =
         CASE v_Action
         WHEN 1 THEN IFNULL(QtyOnHand,0)
         WHEN 2 THEN IFNULL(QtyOnHand,0)+v_Qty
         WHEN 3 THEN IFNULL(QtyOnHand,0)
         WHEN 4 THEN IFNULL(QtyOnHand,0) -v_Qty
         WHEN 5 THEN IFNULL(QtyOnHand,0) -v_Qty
         WHEN 6 THEN IFNULL(QtyOnHand,0)+v_Qty
         ELSE IFNULL(QtyOnHand,0)
         END,QtyOnOrder =
         CASE v_Action
         WHEN 1 THEN IFNULL(QtyOnOrder,0)+v_Qty
         WHEN 2 THEN IFNULL(QtyOnOrder,0) -v_Qty
         WHEN 3 THEN IFNULL(QtyOnOrder,0) -v_Qty
         WHEN 4 THEN IFNULL(QtyOnOrder,0)
         WHEN 5 THEN IFNULL(QtyOnOrder,0)
         WHEN 6 THEN IFNULL(QtyOnOrder,0)
         ELSE IFNULL(QtyOnOrder,0)
         END
         WHERE
         CompanyID = v_CompanyID AND
         DivisionID = v_DivisionID AND
         DepartmentID = v_DepartmentID AND
         ItemID = v_InventoryItemID AND
         WarehouseID = v_WarehouseID AND
         WarehouseBinID = v_WarehouseBinID;
         IF ROW_COUNT() <> 1 OR @SWV_Error <> 0 then
				
            SET v_ErrorMessage = 'Update InventoryByWarehouse bin failed';
            ROLLBACK;
            CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'WarehouseBinPutGoods',v_ErrorMessage,
            v_ErrorID);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'WarehouseID',v_WarehouseID);
            SET SWP_Ret_Value = -1;
         end if;
         IF v_Action = 2 then
				
            SET @SWV_Error = 0;
            SET v_ReturnStatus = SerialNumber_Put2(v_CompanyID,v_DivisionID,v_DepartmentID,v_WarehouseID,v_WarehouseBinID,
            v_PurchaseNumber,v_PurchaseLineNumber,v_SerialNumber,v_InventoryItemID,
            v_ReceivedDate,v_Qty);
            IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then
					-- An error occured, go to the error handler
					
               SET v_ErrorMessage = 'SerialNumber_Put call failed';
               ROLLBACK;
               CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'WarehouseBinPutGoods',v_ErrorMessage,
               v_ErrorID);
               CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'WarehouseID',v_WarehouseID);
               SET SWP_Ret_Value = -1;
            end if;
         end if;
         SET v_IsOverflow = 1;
      ELSE
			-- get quantity in bin
         select   IFNULL(SUM(cast(QtyOnHand as SIGNED INTEGER)),0)+IFNULL(SUM(cast(QtyCommitted as SIGNED INTEGER)),0) INTO v_QtyBin FROM InventoryByWarehouse WHERE
         CompanyID = v_CompanyID AND
         DivisionID = v_DivisionID AND
         DepartmentID = v_DepartmentID AND
         WarehouseID = v_WarehouseID AND
         WarehouseBinID = v_WarehouseBinID;
			-- check for overflow bin
         select   cast(IFNULL(MaximumQuantity,0) as SIGNED INTEGER) -v_QtyBin, IFNULL(NULLIF(RTRIM(OverFlowBin),''),'Overflow') INTO v_AvailableEmpty,v_OverFlowBin FROM WarehouseBins WHERE
         CompanyID = v_CompanyID AND
         DivisionID = v_DivisionID AND
         DepartmentID = v_DepartmentID AND
         WarehouseID = v_WarehouseID AND
         WarehouseBinID = v_WarehouseBinID;
         IF ROW_COUNT() = 0 OR @SWV_Error <> 0 then
				
            SET v_ErrorMessage = 'Get selected bin failed';
            ROLLBACK;
            CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'WarehouseBinPutGoods',v_ErrorMessage,
            v_ErrorID);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'WarehouseID',v_WarehouseID);
            SET SWP_Ret_Value = -1;
         end if;
         IF ABS(v_AvailableEmpty) > 2147483647 then
				
            SET v_ErrorMessage = 'Logical error - attempt to put goods more then maximum quantity';
            ROLLBACK;
            CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'WarehouseBinPutGoods',v_ErrorMessage,
            v_ErrorID);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'WarehouseID',v_WarehouseID);
            SET SWP_Ret_Value = -1;
         end if;
         IF(SELECT COUNT(*) FROM InventoryByWarehouse
         WHERE
         CompanyID = v_CompanyID AND
         DivisionID = v_DivisionID AND
         DepartmentID = v_DepartmentID AND
         ItemID = v_InventoryItemID AND
         WarehouseID = v_WarehouseID AND
         WarehouseBinID = v_WarehouseBinID) = 0 then
				
            SET @SWV_Error = 0;
            INSERT INTO InventoryByWarehouse(CompanyID,
							DivisionID,
							DepartmentID,
							ItemID,
							WarehouseID,
							WarehouseBinID,
							QtyOnHand,
							QtyCommitted,
							QtyOnOrder,
							QtyOnBackorder)
					VALUES(v_CompanyID,
							v_DivisionID,
							v_DepartmentID,
							v_InventoryItemID,
							v_WarehouseID,
							v_WarehouseBinID,
							0,
							0,
							0,
							0);
					
            IF @SWV_Error <> 0 then
					
               SET v_ErrorMessage = 'Insert InventoryByWarehouse bin failed';
               ROLLBACK;
               CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'WarehouseBinPutGoods',v_ErrorMessage,
               v_ErrorID);
               CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'WarehouseID',v_WarehouseID);
               SET SWP_Ret_Value = -1;
            end if;
         end if;
         IF v_AvailableEmpty >= v_Qty then
				
					-- put to this bin
            SET @SWV_Error = 0;
            UPDATE InventoryByWarehouse
            SET
            QtyOnHand =
            CASE v_Action
            WHEN 1 THEN IFNULL(QtyOnHand,0)
            WHEN 2 THEN IFNULL(QtyOnHand,0)+v_Qty
            WHEN 3 THEN IFNULL(QtyOnHand,0)
            WHEN 4 THEN IFNULL(QtyOnHand,0) -v_Qty
            WHEN 5 THEN IFNULL(QtyOnHand,0) -v_Qty
            WHEN 6 THEN IFNULL(QtyOnHand,0)+v_Qty
            ELSE IFNULL(QtyOnHand,0)
            END,QtyOnOrder =
            CASE v_Action
            WHEN 1 THEN IFNULL(QtyOnOrder,0)+v_Qty
            WHEN 2 THEN IFNULL(QtyOnOrder,0) -v_Qty
            WHEN 3 THEN IFNULL(QtyOnOrder,0) -v_Qty
            WHEN 4 THEN IFNULL(QtyOnOrder,0)
            WHEN 5 THEN IFNULL(QtyOnOrder,0)
            WHEN 6 THEN IFNULL(QtyOnOrder,0)
            ELSE IFNULL(QtyOnOrder,0)
            END
            WHERE
            CompanyID = v_CompanyID AND
            DivisionID = v_DivisionID AND
            DepartmentID = v_DepartmentID AND
            ItemID = v_InventoryItemID AND
            WarehouseID = v_WarehouseID AND
            WarehouseBinID = v_WarehouseBinID;
            IF ROW_COUNT() <> 1 OR @SWV_Error <> 0 then
						
               SET v_ErrorMessage = 'Update InventoryByWarehouse bin failed';
               ROLLBACK;
               CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'WarehouseBinPutGoods',v_ErrorMessage,
               v_ErrorID);
               CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'WarehouseID',v_WarehouseID);
               SET SWP_Ret_Value = -1;
            end if;
            IF v_Action = 2 then
						
               SET @SWV_Error = 0;
               SET v_ReturnStatus = SerialNumber_Put2(v_CompanyID,v_DivisionID,v_DepartmentID,v_WarehouseID,v_WarehouseBinID,
               v_PurchaseNumber,v_PurchaseLineNumber,v_SerialNumber,v_InventoryItemID,
               v_ReceivedDate,v_Qty);
               IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then
							-- An error occured, go to the error handler
							
                  SET v_ErrorMessage = 'SerialNumber_Put call failed';
                  ROLLBACK;
                  CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'WarehouseBinPutGoods',v_ErrorMessage,
                  v_ErrorID);
                  CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'WarehouseID',v_WarehouseID);
                  SET SWP_Ret_Value = -1;
               end if;
            end if;
         ELSE
					-- put to this bin
            SET @SWV_Error = 0;
            UPDATE InventoryByWarehouse
            SET
            QtyOnHand =
            CASE v_Action
            WHEN 1 THEN IFNULL(QtyOnHand,0)
            WHEN 2 THEN IFNULL(QtyOnHand,0)+v_AvailableEmpty
            WHEN 3 THEN IFNULL(QtyOnHand,0)
            WHEN 4 THEN IFNULL(QtyOnHand,0) -v_AvailableEmpty
            WHEN 5 THEN IFNULL(QtyOnHand,0) -v_AvailableEmpty
            WHEN 6 THEN IFNULL(QtyOnHand,0)+v_AvailableEmpty
            ELSE IFNULL(QtyOnHand,0)
            END,QtyOnOrder =
            CASE v_Action
            WHEN 1 THEN IFNULL(QtyOnOrder,0)+v_AvailableEmpty
            WHEN 2 THEN IFNULL(QtyOnOrder,0) -v_AvailableEmpty
            WHEN 3 THEN IFNULL(QtyOnOrder,0) -v_AvailableEmpty
            WHEN 4 THEN IFNULL(QtyOnOrder,0)
            WHEN 5 THEN IFNULL(QtyOnOrder,0)
            WHEN 6 THEN IFNULL(QtyOnOrder,0)
            ELSE IFNULL(QtyOnOrder,0)
            END
            WHERE
            CompanyID = v_CompanyID AND
            DivisionID = v_DivisionID AND
            DepartmentID = v_DepartmentID AND
            ItemID = v_InventoryItemID AND
            WarehouseID = v_WarehouseID AND
            WarehouseBinID = v_WarehouseBinID;
            IF ROW_COUNT() <> 1 OR @SWV_Error <> 0 then
						
               SET v_ErrorMessage = 'Update InventoryByWarehouse bin failed';
               ROLLBACK;
               CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'WarehouseBinPutGoods',v_ErrorMessage,
               v_ErrorID);
               CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'WarehouseID',v_WarehouseID);
               SET SWP_Ret_Value = -1;
            end if;
            IF v_Action = 2 then
						
               SET @SWV_Error = 0;
               SET v_ReturnStatus = SerialNumber_Put2(v_CompanyID,v_DivisionID,v_DepartmentID,v_WarehouseID,v_WarehouseBinID,
               v_PurchaseNumber,v_PurchaseLineNumber,v_SerialNumber,v_InventoryItemID,
               v_ReceivedDate,v_AvailableEmpty);
               IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then
							-- An error occured, go to the error handler
							
                  SET v_ErrorMessage = 'SerialNumber_Put call failed';
                  ROLLBACK;
                  CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'WarehouseBinPutGoods',v_ErrorMessage,
                  v_ErrorID);
                  CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'WarehouseID',v_WarehouseID);
                  SET SWP_Ret_Value = -1;
               end if;
            end if;
					-- put to next bin
            SET v_Qty = v_Qty -v_AvailableEmpty;
            SET v_WarehouseBinID = v_OverFlowBin;
            leave PutToBin;
         end if;
      end if;
      COMMIT;
      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;
   END
   ROLLBACK;
   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'WarehouseBinPutGoods',v_ErrorMessage,
   v_ErrorID);
   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'WarehouseID',v_WarehouseID);
	
   SET SWP_Ret_Value = -1;
   END PutToBin;
END;




//

DELIMITER ;
