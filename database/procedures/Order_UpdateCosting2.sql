CREATE PROCEDURE Order_UpdateCosting2 (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_ItemID NATIONAL VARCHAR(36),
	v_ItemCost DECIMAL(19,4),INOUT SWP_Ret_Value INT) SWL_return:
BEGIN








   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);
   DECLARE v_ErrorID INT;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
   END;
   SET @SWV_Error = 0;
   START TRANSACTION;
   SET @SWV_Error = 0;
   UPDATE OrderDetail, OrderHeader
   SET OrderDetail.ItemCost = v_ItemCost
   WHERE
   OrderHeader.CompanyID = v_CompanyID AND
   OrderHeader.DivisionID = v_DivisionID AND
   OrderHeader.DepartmentID = v_DepartmentID AND
   IFNULL(OrderHeader.Invoiced,0) = 0 AND
   OrderHeader.CompanyID = OrderDetail.CompanyID AND
   OrderHeader.DivisionID = OrderDetail.DivisionID AND
   OrderHeader.DepartmentID = OrderDetail.DepartmentID AND
   OrderHeader.OrderNumber = OrderDetail.OrderNumber AND
   OrderDetail.ItemID = v_ItemID;
	
   IF @SWV_Error <> 0 then


      SET v_ErrorMessage = 'Order_UpdateCosting: Update Costing failed';
      ROLLBACK;

      IF v_ErrorMessage <> '' then

	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Order_UpdateCosting',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'ItemID',v_ItemID);
      end if;
      SET SWP_Ret_Value = -1;
   end if;

   COMMIT;
	
   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;






   ROLLBACK;

   IF v_ErrorMessage <> '' then

	
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Order_UpdateCosting',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'ItemID',v_ItemID);
   end if;
   SET SWP_Ret_Value = -1;
END