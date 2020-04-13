CREATE PROCEDURE SerialNumber_Get2 (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_WarehouseID NATIONAL VARCHAR(36),
	v_WarehouseBinID NATIONAL VARCHAR(36),
	v_SerialNumber NATIONAL VARCHAR(50),
	v_ItemID NATIONAL VARCHAR(36),
	v_OrderNumber NATIONAL VARCHAR(36),
	v_OrderLineNumber SMALLINT,
	v_InvoiceNumber NATIONAL VARCHAR(36),
	v_InvoiceLineNumber SMALLINT,
	v_OrderQty INT,INOUT SWP_Ret_Value INT) SWL_return:
BEGIN





   DECLARE v_ReturnStatus INT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(250);
   DECLARE v_ErrorID INT;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
   END;
   SET @SWV_Error = 0;
   IF v_SerialNumber IS NULL OR v_SerialNumber = '' then
      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;
   end if;
   START TRANSACTION;
   SET @SWV_Error = 0;
   UPDATE
   InventorySerialNumbers
   SET
   OrderNumber = v_OrderNumber,OrderLineNumber = v_OrderLineNumber,InvoiceNumber = v_InvoiceNumber,
   InvoiceLineNumber = v_InvoiceLineNumber,CurrentLotOrderQty = CurrentLotOrderQty -v_OrderQty
   WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   ItemID = v_ItemID AND
   SerialNumber = v_SerialNumber AND
   WarehouseID = v_WarehouseID AND
   WarehouseBinID = v_WarehouseBinID AND
   CurrentLotOrderQty >= v_OrderQty;
   IF @SWV_Error <> 0 OR ROW_COUNT() <> 1 then
	
      SET v_ErrorMessage = 'Update InventorySerialNumbers failed';
      ROLLBACK;
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'SerialNumber_Get',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'SerialNumber',v_SerialNumber);
      SET SWP_Ret_Value = -1;
   end if;
   COMMIT;
   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;






   ROLLBACK;
   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'SerialNumber_Get',v_ErrorMessage,
   v_ErrorID);
   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'SerialNumber',v_SerialNumber);
   SET SWP_Ret_Value = -1;
END