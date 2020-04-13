CREATE PROCEDURE ServiceOrder_Delete (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_OrderNumber NATIONAL VARCHAR(36),INOUT SWP_Ret_Value INT) SWL_return:
BEGIN







   DECLARE v_ServiceOrderStatus SMALLINT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);

   DECLARE v_CanDelete BOOLEAN; 


   DECLARE v_ErrorID INT;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
   END;
   SET @SWV_Error = 0;
   START TRANSACTION;

   SET @SWV_Error = 0;
   CALL ServiceOrder_CanDelete2(v_CompanyID,v_DivisionID,v_DepartmentID,v_OrderNumber,v_CanDelete);
   IF @SWV_Error <> 0 then

	
      SET v_ErrorMessage = 'ServiceOrder_CanDelete failed';
      ROLLBACK;


      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'ServiceOrder_Delete',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'OrderNumber',v_OrderNumber);
      
SET SWP_Ret_Value = -1;
   end if;

   IF IFNULL(v_CanDelete,0) = 0 then

      COMMIT;
      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;
   end if;


   SET @SWV_Error = 0;
   CALL ServiceOrder_Cancel2(v_CompanyID,v_DivisionID,v_DepartmentID,v_OrderNumber);
   IF @SWV_Error <> 0 then

	
      SET v_ErrorMessage = 'ServiceOrder_Cancel failed';
      ROLLBACK;


      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'ServiceOrder_Delete',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'OrderNumber',v_OrderNumber);
      
SET SWP_Ret_Value = -1;
   end if;


   SET @SWV_Error = 0;
   DELETE FROM
   OrderDetail
   WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND	OrderNumber = v_OrderNumber;

   IF @SWV_Error <> 0 then

	
      SET v_ErrorMessage = 'DELETE FROM OrderDetail failed';
      ROLLBACK;


      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'ServiceOrder_Delete',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'OrderNumber',v_OrderNumber);
      
SET SWP_Ret_Value = -1;
   end if;

   SET @SWV_Error = 0;
   DELETE FROM
   OrderTrackingDetail
   WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND	OrderNumber = v_OrderNumber;

   IF @SWV_Error <> 0 then

	
      SET v_ErrorMessage = 'DELETE FROM OrderTrackingDetail failed';
      ROLLBACK;


      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'ServiceOrder_Delete',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'OrderNumber',v_OrderNumber);
      
SET SWP_Ret_Value = -1;
   end if;

   SET @SWV_Error = 0;
   DELETE FROM
   OrderTrackingHeader
   WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND	OrderNumber = v_OrderNumber;

   IF @SWV_Error <> 0 then

	
      SET v_ErrorMessage = 'DELETE FROM OrderTrackingHeader failed';
      ROLLBACK;


      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'ServiceOrder_Delete',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'OrderNumber',v_OrderNumber);
      
SET SWP_Ret_Value = -1;
   end if;

   SET @SWV_Error = 0;
   DELETE FROM
   OrderHeader
   WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND	OrderNumber = v_OrderNumber;

   IF @SWV_Error <> 0 then

	
      SET v_ErrorMessage = 'DELETE FROM OrderHeader failed';
      ROLLBACK;


      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'ServiceOrder_Delete',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'OrderNumber',v_OrderNumber);
      
SET SWP_Ret_Value = -1;
   end if;



   COMMIT;
   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;









   ROLLBACK;


   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'ServiceOrder_Delete',v_ErrorMessage,
   v_ErrorID);

   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'OrderNumber',v_OrderNumber);

   
SET SWP_Ret_Value = -1;
END