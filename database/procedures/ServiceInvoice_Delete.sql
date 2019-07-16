CREATE PROCEDURE ServiceInvoice_Delete (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_InvoiceNumber NATIONAL VARCHAR(36),INOUT SWP_Ret_Value INT) SWL_return:
BEGIN






   DECLARE v_ServiceInvoiceStatus SMALLINT;
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
   CALL ServiceInvoice_CanDelete2(v_CompanyID,v_DivisionID,v_DepartmentID,v_InvoiceNumber,v_CanDelete);
   IF @SWV_Error <> 0 then

	
      SET v_ErrorMessage = 'ServiceInvoice_CanDelete failed';
      ROLLBACK;


      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'ServiceInvoice_Delete',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
      
SET SWP_Ret_Value = -1;
   end if;

   IF IFNULL(v_CanDelete,0) = 0 then

      COMMIT;
      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;
   end if;


   SET @SWV_Error = 0;
   CALL ServiceInvoice_Cancel2(v_CompanyID,v_DivisionID,v_DepartmentID,v_InvoiceNumber);
   IF @SWV_Error <> 0 then

	
      SET v_ErrorMessage = 'ServiceInvoice_Cancel failed';
      ROLLBACK;


      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'ServiceInvoice_Delete',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
      
SET SWP_Ret_Value = -1;
   end if;


   SET @SWV_Error = 0;
   DELETE FROM
   InvoiceDetail
   WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND	InvoiceNumber = v_InvoiceNumber;

   IF @SWV_Error <> 0 then

	
      SET v_ErrorMessage = 'DELETE FROM InvoiceDetail failed';
      ROLLBACK;


      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'ServiceInvoice_Delete',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
      
SET SWP_Ret_Value = -1;
   end if;

   SET @SWV_Error = 0;
   DELETE FROM
   InvoiceTrackingDetail
   WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND	InvoiceNumber = v_InvoiceNumber;

   IF @SWV_Error <> 0 then

	
      SET v_ErrorMessage = 'DELETE FROM InvoiceTrackingDetail failed';
      ROLLBACK;


      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'ServiceInvoice_Delete',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
      
SET SWP_Ret_Value = -1;
   end if;

   SET @SWV_Error = 0;
   DELETE FROM
   InvoiceTrackingHeader
   WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND	InvoiceNumber = v_InvoiceNumber;

   IF @SWV_Error <> 0 then

	
      SET v_ErrorMessage = 'DELETE FROM InvoiceTrackingHeader failed';
      ROLLBACK;


      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'ServiceInvoice_Delete',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
      
SET SWP_Ret_Value = -1;
   end if;

   SET @SWV_Error = 0;
   DELETE FROM
   InvoiceHeader
   WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND	InvoiceNumber = v_InvoiceNumber;

   IF @SWV_Error <> 0 then

	
      SET v_ErrorMessage = 'DELETE FROM InvoiceHeader failed';
      ROLLBACK;


      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'ServiceInvoice_Delete',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
      
SET SWP_Ret_Value = -1;
   end if;



   COMMIT;
   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;









   ROLLBACK;


   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'ServiceInvoice_Delete',v_ErrorMessage,
   v_ErrorID);

   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);

   
SET SWP_Ret_Value = -1;
END