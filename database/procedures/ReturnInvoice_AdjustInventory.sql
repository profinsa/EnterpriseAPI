CREATE PROCEDURE ReturnInvoice_AdjustInventory (v_CompanyID NATIONAL VARCHAR(36), 
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_InvoiceNumber NATIONAL VARCHAR(36),INOUT SWP_Ret_Value INT) SWL_return:
BEGIN













   DECLARE v_OrderNumber NATIONAL VARCHAR(36);
   DECLARE v_WarehouseID NATIONAL VARCHAR(36);
   DECLARE v_WarehouseBinID NATIONAL VARCHAR(36);
   DECLARE v_ReturnStatus INT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(250);
   DECLARE v_InvoiceLineNumber INT; 
   DECLARE v_ItemID NATIONAL VARCHAR(36);
   DECLARE v_OrderQty INT;
   DECLARE v_BackOrderQty INT;

   DECLARE v_ErrorID INT;
   DECLARE NO_DATA INT DEFAULT 0;
   DECLARE cInvoiceDetail CURSOR 
   FOR SELECT 
   WarehouseID, WarehouseBinID,
		InvoiceLineNumber, ItemID, IFNULL(OrderQty,0), IFNULL(BackOrderQty,0)
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

   select   OrderNumber INTO v_OrderNumber FROM InvoiceHeader WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND InvoiceNumber = v_InvoiceNumber;



   CALL Inventory_GetWarehouseForOrder(v_CompanyID,v_DivisionID,v_DepartmentID,v_OrderNumber,v_WarehouseID, v_ReturnStatus); 
   IF v_ReturnStatus = -1 then

      SET v_ErrorMessage = 'Getting the WarehouseID failed';
      ROLLBACK;
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'ReturnInvoice_AdjustInventory',
      v_ErrorMessage,v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoceNumber',v_InvoiceNumber);
      SET SWP_Ret_Value = -1;
   end if;

   OPEN cInvoiceDetail;
   SET NO_DATA = 0;
   FETCH cInvoiceDetail INTO v_WarehouseID,v_WarehouseBinID,v_InvoiceLineNumber,v_ItemID,v_OrderQty, 
   v_BackOrderQty;
   WHILE NO_DATA = 0 DO
      SET @SWV_Error = 0;
      CALL WarehouseBinShipGoods2(v_CompanyID,v_DivisionID,v_DepartmentID,v_WarehouseID,v_WarehouseBinID,
      v_ItemID,v_OrderQty,v_BackOrderQty,1, v_ReturnStatus);
      IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then
	
         CLOSE cInvoiceDetail;
		
         SET v_ErrorMessage = 'WarehouseBinShipGoods failed';
         ROLLBACK;
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'ReturnInvoice_AdjustInventory',
         v_ErrorMessage,v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoceNumber',v_InvoiceNumber);
         SET SWP_Ret_Value = -1;
      end if;
      SET NO_DATA = 0;
      FETCH cInvoiceDetail INTO v_WarehouseID,v_WarehouseBinID,v_InvoiceLineNumber,v_ItemID,v_OrderQty, 
      v_BackOrderQty;
   END WHILE;
   CLOSE cInvoiceDetail;


   COMMIT;
   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;








   ROLLBACK;
   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'ReturnInvoice_AdjustInventory',
   v_ErrorMessage,v_ErrorID);

   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoceNumber',v_InvoiceNumber);

   SET SWP_Ret_Value = -1;
END