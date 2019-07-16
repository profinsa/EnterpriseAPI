CREATE PROCEDURE Invoice_DebitInventory (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_InvoiceNumber NATIONAL VARCHAR(36),INOUT SWP_Ret_Value INT) SWL_return:
BEGIN


   DECLARE v_ReturnStatus INT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(250);
   DECLARE v_FlipBackInvoiceFlag BOOLEAN;
   DECLARE v_InvoiceLineNumber NUMERIC(18,0);
   DECLARE v_ItemID NATIONAL VARCHAR(36);
   DECLARE v_QtyOnHand INT;
   DECLARE v_InvoiceQty FLOAT;
   DECLARE v_AvailableQty INT;
   DECLARE v_DifferenceQty INT;
   DECLARE v_WarehouseID NATIONAL VARCHAR(36);
   DECLARE v_WarehouseBinID NATIONAL VARCHAR(36);
   DECLARE v_SerialNumber NATIONAL VARCHAR(50);
   DECLARE v_Result INT;
   DECLARE v_ErrorID INT;
   DECLARE NO_DATA INT DEFAULT 0;
   DECLARE cInvoiceDetail CURSOR 
   FOR SELECT
   InvoiceLineNumber,
		ItemID,
		IFNULL(OrderQty,0),
		WarehouseID,
		WarehouseBinID,
		SerialNumber
   FROM
   InvoiceDetail
   WHERE	
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND InvoiceNumber = v_InvoiceNumber;

   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
      SET NO_DATA = -2;
   END;
   DECLARE CONTINUE HANDLER FOR NOT FOUND SET NO_DATA = -1;
   SET @SWV_Error = 0;
   START TRANSACTION;


   SET v_FlipBackInvoiceFlag = 0;

   OPEN cInvoiceDetail;
   SET NO_DATA = 0;
   FETCH cInvoiceDetail INTO v_InvoiceLineNumber,v_ItemID,v_InvoiceQty,v_WarehouseID,v_WarehouseBinID, 
   v_SerialNumber;
   WHILE NO_DATA = 0 DO
      SET v_FlipBackInvoiceFlag = 0;
      SET v_DifferenceQty = 0;
      SET v_QtyOnHand = 0;
      SET v_AvailableQty = 0;

      SET @SWV_Error = 0;
      CALL Inventory_GetWarehouseForInvoiceItem(v_CompanyID,v_DivisionID,v_DepartmentID,v_InvoiceNumber,v_InvoiceLineNumber,
      v_WarehouseID,v_WarehouseBinID, v_ReturnStatus);
      IF @SWV_Error <> 0 OR  v_ReturnStatus = -1 then
	
         CLOSE cInvoiceDetail;
		
         SET v_ErrorMessage = 'Getting the WarehouseID failed';
         ROLLBACK;
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Invoice_DebitInventory',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoceNumber',v_InvoiceNumber);
         SET SWP_Ret_Value = -1;
      end if;
      select   IFNULL(SUM(IFNULL(QtyOnHand,0)),0) INTO v_QtyOnHand FROM
      InventoryByWarehouse WHERE
      CompanyID = v_CompanyID
      AND DivisionID = v_DivisionID
      AND DepartmentID = v_DepartmentID
      AND WarehouseID = v_WarehouseID
      AND ItemID = v_ItemID;
      IF v_InvoiceQty > v_QtyOnHand then 
		
         SET v_AvailableQty = v_QtyOnHand;
         SET v_DifferenceQty = v_InvoiceQty -v_QtyOnHand;
		
			
			
         SET @SWV_Error = 0;
         CALL Invoice_CreateAssembly(v_CompanyID,v_DivisionID,v_DepartmentID,v_ItemID,v_WarehouseID,v_DifferenceQty,
         v_Result, v_ReturnStatus);
			
         IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then
			
            CLOSE cInvoiceDetail;
				
            
SET v_ErrorMessage = 'Invoice_CreateAssembly call failed';
            ROLLBACK;
            CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Invoice_DebitInventory',v_ErrorMessage,
            v_ErrorID);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoceNumber',v_InvoiceNumber);
            SET SWP_Ret_Value = -1;
         end if;
      end if;
      SET NO_DATA = 0;
      FETCH cInvoiceDetail INTO v_InvoiceLineNumber,v_ItemID,v_InvoiceQty,v_WarehouseID,v_WarehouseBinID, 
      v_SerialNumber;
   END WHILE;
   CLOSE cInvoiceDetail;
   SET @SWV_Error = 0;
   CALL  InvoiceDetail_SplitToWarehouseBin2(v_CompanyID,v_DivisionID,v_DepartmentID,v_InvoiceNumber,0,v_FlipBackInvoiceFlag, v_ReturnStatus);
   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then

      SET v_ErrorMessage = 'InvoiceDetail_SplitToWarehouseBin failed';
      ROLLBACK;
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Invoice_DebitInventory',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoceNumber',v_InvoiceNumber);
      SET SWP_Ret_Value = -1;
   end if;
   IF v_FlipBackInvoiceFlag = 1 then

	
      SET v_ErrorMessage = 'The Invoice did not post: there is not enough staff in Inventory to cover the invoice';
      ROLLBACK;
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Invoice_DebitInventory',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoceNumber',v_InvoiceNumber);
      SET SWP_Ret_Value = -1;
   end if;

   OPEN cInvoiceDetail;
   SET NO_DATA = 0;
   FETCH cInvoiceDetail INTO v_InvoiceLineNumber,v_ItemID,v_InvoiceQty,v_WarehouseID,v_WarehouseBinID, 
   v_SerialNumber;
   WHILE NO_DATA = 0 DO
      SET @SWV_Error = 0;
      CALL SerialNumber_Get2(v_CompanyID,v_DivisionID,v_DepartmentID,v_WarehouseID,v_WarehouseBinID,
      v_SerialNumber,v_ItemID,NULL,NULL,v_InvoiceNumber,v_InvoiceLineNumber,
      v_InvoiceQty, v_ReturnStatus);
      IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then
	
         CLOSE cInvoiceDetail;
		
         SET v_ErrorMessage = 'SerialNumber_Get failed';
         ROLLBACK;
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Invoice_DebitInventory',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoceNumber',v_InvoiceNumber);
         SET SWP_Ret_Value = -1;
      end if;
      SET NO_DATA = 0;
      FETCH cInvoiceDetail INTO v_InvoiceLineNumber,v_ItemID,v_InvoiceQty,v_WarehouseID,v_WarehouseBinID, 
      v_SerialNumber;
   END WHILE;
   CLOSE cInvoiceDetail;

   COMMIT;
   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;






   ROLLBACK;
   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Invoice_DebitInventory',v_ErrorMessage,
   v_ErrorID);
   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoceNumber',v_InvoiceNumber);
   SET SWP_Ret_Value = -1;
END