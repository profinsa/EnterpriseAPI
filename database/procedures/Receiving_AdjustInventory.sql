CREATE PROCEDURE Receiving_AdjustInventory (v_CompanyID NATIONAL VARCHAR(36), 
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_PurchaseNumber NATIONAL VARCHAR(36),INOUT SWP_Ret_Value INT) SWL_return:
BEGIN









   DECLARE v_WarehouseID NATIONAL VARCHAR(36);
   DECLARE v_WarehouseBinID NATIONAL VARCHAR(36);
   DECLARE v_PurchaseWarehouseID NATIONAL VARCHAR(36);
   DECLARE v_ReturnStatus INT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(250);
   DECLARE v_InvoiceLineNumber INT; 
   DECLARE v_ItemID NATIONAL VARCHAR(36);
   DECLARE v_OrderQty INT;
   DECLARE v_BackOrderQty INT;
   DECLARE v_IsOverflow BOOLEAN;
   DECLARE v_PurchaseLineNumber NUMERIC(18,0);
   DECLARE v_SerialNumber NATIONAL VARCHAR(50);
   DECLARE v_ReceivedDate DATETIME;

   DECLARE v_ErrorID INT;
   DECLARE NO_DATA INT DEFAULT 0;
   DECLARE C CURSOR FOR 
   SELECT  
   ItemID, 
		IFNULL(OrderQty,0),
		IFNULL(WarehouseID,v_PurchaseWarehouseID),
		WarehouseBinID,
		PurchaseLineNumber,
		SerialNumber,
		ReceivedDate
   FROM  
   PurchaseDetail
   WHERE 
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   PurchaseNumber = v_PurchaseNumber AND
   IFNULL(Received,0) = 0;	
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
      SET NO_DATA = -2;
   END;
   DECLARE CONTINUE HANDLER FOR NOT FOUND SET NO_DATA = -1;
   SET @SWV_Error = 0;
   START TRANSACTION;



   SET @SWV_Error = 0;
   CALL Inventory_GetWarehouseForPurchase2(v_CompanyID,v_DivisionID,v_DepartmentID,v_PurchaseNumber,v_PurchaseWarehouseID, v_ReturnStatus); 
   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then

      SET v_ErrorMessage = 'Getting the WarehouseID failed';
      ROLLBACK;
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'PurchaseAdjustInventory',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseNumber',v_PurchaseNumber);
      SET SWP_Ret_Value = -1;
   end if;


   OPEN C;



   SET NO_DATA = 0;
   FETCH C INTO v_ItemID,v_OrderQty,v_WarehouseID,v_WarehouseBinID,v_PurchaseLineNumber, 
   v_SerialNumber,v_ReceivedDate;
   WHILE NO_DATA = 0 DO
      SET @SWV_Error = 0;
      CALL WarehouseBinPutGoods2(v_CompanyID,v_DivisionID,v_DepartmentID,v_WarehouseID,v_WarehouseBinID,
      v_ItemID,v_PurchaseNumber,v_PurchaseLineNumber,v_SerialNumber,v_ReceivedDate,
      v_OrderQty,2,v_IsOverflow, v_ReturnStatus);
      IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then
	
         CLOSE C;
		
         SET v_ErrorMessage = 'WarehouseBinPutGoods failed';
         ROLLBACK;
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'PurchaseAdjustInventory',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseNumber',v_PurchaseNumber);
         SET SWP_Ret_Value = -1;
      end if;
      SET NO_DATA = 0;
      FETCH C INTO v_ItemID,v_OrderQty,v_WarehouseID,v_WarehouseBinID,v_PurchaseLineNumber, 
      v_SerialNumber,v_ReceivedDate;
   END WHILE;
   CLOSE C;


   COMMIT;
   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;









   ROLLBACK;
   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'PurchaseAdjustInventory',v_ErrorMessage,
   v_ErrorID);

   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseNumber',v_PurchaseNumber);

   SET SWP_Ret_Value = -1;
END