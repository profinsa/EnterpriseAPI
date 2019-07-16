CREATE PROCEDURE Inventory_GetWarehouseForOrderItem (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_OrderNumber NATIONAL VARCHAR(36),
	v_OrderLineNumber NUMERIC(18,0),
	INOUT v_WarehouseID NATIONAL VARCHAR(36) ,
	INOUT v_WarehouseBinID NATIONAL VARCHAR(36) ,INOUT SWP_Ret_Value INT) SWL_return:
BEGIN













   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);
   DECLARE v_ErrorID INT;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
   END;
   select   IFNULL(WarehouseID,N''), IFNULL(WarehouseBinID,N'') INTO v_WarehouseID,v_WarehouseBinID FROM
   OrderDetail WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND OrderNumber = v_OrderNumber
   AND OrderLineNumber = v_OrderLineNumber;

   IF v_WarehouseID <> N'' and v_WarehouseBinID <> N'' then
	
      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;
   end if;
	
   START TRANSACTION;
   IF v_WarehouseID = N'' then
      CALL Inventory_GetWarehouseForOrder2(v_CompanyID,v_DivisionID,v_DepartmentID,v_OrderNumber,v_WarehouseID);
   end if; 

   IF v_WarehouseBinID = N'' then

      select   IFNULL(WarehouseBinID,N'DEFAULT') INTO v_WarehouseBinID FROM
      Companies WHERE
      CompanyID = v_CompanyID AND
      DivisionID = v_DivisionID AND
      DepartmentID = v_DepartmentID;
      SET @SWV_Error = 0;
      UPDATE OrderDetail
      SET
      WarehouseID = v_WarehouseID,WarehouseBinID = v_WarehouseBinID
      WHERE
      CompanyID = v_CompanyID
      AND DivisionID = v_DivisionID
      AND DepartmentID = v_DepartmentID
      AND OrderNumber = v_OrderNumber
      AND OrderLineNumber = v_OrderLineNumber;
      IF @SWV_Error <> 0 then
	
         SET v_ErrorMessage = 'Updating order header (backordering) failed';
         ROLLBACK;
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Inventory_GetWarehouseForOrderItem',
         v_ErrorMessage,v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'OrderNumber',v_OrderNumber);
         SET SWP_Ret_Value = -1;
      end if;
   end if;

   COMMIT;
   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;






   ROLLBACK;
   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Inventory_GetWarehouseForOrderItem',
   v_ErrorMessage,v_ErrorID);
   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'OrderNumber',v_OrderNumber);
   SET SWP_Ret_Value = -1;
END