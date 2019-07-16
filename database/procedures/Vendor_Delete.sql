CREATE PROCEDURE Vendor_Delete (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_EmployeeID NATIONAL VARCHAR(36),
	v_VendorID NATIONAL VARCHAR(36),
	INOUT v_DeleteError NATIONAL VARCHAR(250) ,INOUT SWP_Ret_Value INT) SWL_return:
BEGIN




   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);


   DECLARE v_LockEmployeeID NATIONAL VARCHAR(36);


   DECLARE v_ErrorID INT;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
   END;
   SET @SWV_Error = 0;
   IF NOT EXISTS(SELECT VendorID
   From VendorInformation
   WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   VendorID = v_VendorID) then

      SET SWP_Ret_Value = 1;
      LEAVE SWL_return;
   end if;


   IF v_VendorID = 'DEFAULT' then

      SET v_DeleteError = N'Can''t delete vendor because it''s a default vendor';
      SET SWP_Ret_Value = 2;
      LEAVE SWL_return;
   end if;


   select   LockedBy INTO v_LockEmployeeID From VendorInformation WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   VendorID = v_VendorID;
   IF IFNULL(v_LockEmployeeID,v_EmployeeID) <> v_EmployeeID then

      SET v_DeleteError = CONCAT(N'Can''t delete vendor because the record is locked by employee ',
      v_LockEmployeeID);
      SET SWP_Ret_Value = 2;
      LEAVE SWL_return;
   end if;
   select   LockedBy INTO v_LockEmployeeID From VendorComments WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   VendorID = v_VendorID AND
   IFNULL(LockedBy,v_EmployeeID) <> v_EmployeeID   LIMIT 1;

   IF IFNULL(v_LockEmployeeID,v_EmployeeID) <> v_EmployeeID then

      SET v_DeleteError = CONCAT(N'Can''t delete vendor because some of its VendorComments records is locked by employee ',v_LockEmployeeID);
      SET SWP_Ret_Value = 2;
      LEAVE SWL_return;
   end if;



   select   LockedBy INTO v_LockEmployeeID From VendorContacts WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   VendorID = v_VendorID AND
   IFNULL(LockedBy,v_EmployeeID) <> v_EmployeeID   LIMIT 1;

   IF IFNULL(v_LockEmployeeID,v_EmployeeID) <> v_EmployeeID then

      SET v_DeleteError = CONCAT(N'Can''t delete vendor because some of its VendorContacts records is locked by employee ',v_LockEmployeeID);
      SET SWP_Ret_Value = 2;
      LEAVE SWL_return;
   end if;

   select   LockedBy INTO v_LockEmployeeID From VendorFinancials WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   VendorID = v_VendorID AND
   IFNULL(LockedBy,v_EmployeeID) <> v_EmployeeID   LIMIT 1;

   IF IFNULL(v_LockEmployeeID,v_EmployeeID) <> v_EmployeeID then

      SET v_DeleteError = CONCAT(N'Can''t delete vendor because its VendorFinancials record is locked by employee ',v_LockEmployeeID);
      SET SWP_Ret_Value = 2;
      LEAVE SWL_return;
   end if;

   select   LockedBy INTO v_LockEmployeeID From VendorItemCrossReference WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   VendorID = v_VendorID AND
   IFNULL(LockedBy,v_EmployeeID) <> v_EmployeeID   LIMIT 1;

   IF IFNULL(v_LockEmployeeID,v_EmployeeID) <> v_EmployeeID then

      SET v_DeleteError = CONCAT(N'Can''t delete vendor because some of its VendorItemCrossReference records is locked by employee ',v_LockEmployeeID);
      SET SWP_Ret_Value = 2;
      LEAVE SWL_return;
   end if;

   select   LockedBy INTO v_LockEmployeeID From VendorPriceCrossReference WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   VendorID = v_VendorID AND
   IFNULL(LockedBy,v_EmployeeID) <> v_EmployeeID   LIMIT 1;

   IF IFNULL(v_LockEmployeeID,v_EmployeeID) <> v_EmployeeID then

      SET v_DeleteError = CONCAT(N'Can''t delete vendor because some of its VendorPriceCrossReference records is locked by employee ',v_LockEmployeeID);
      SET SWP_Ret_Value = 2;
      LEAVE SWL_return;
   end if;


   START TRANSACTION;

   SET @SWV_Error = 0;
   DELETE FROM VendorComments
   WHERE 	CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   VendorID = v_VendorID;

   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Delete from VendorComments failed';
      ROLLBACK;
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Vendor_Delete',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'VendorID',v_VendorID);
      SET SWP_Ret_Value = -1;
   end if;
		

   SET @SWV_Error = 0;
   DELETE FROM VendorContacts
   WHERE 	CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   VendorID = v_VendorID;

   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Delete from VendorContacts failed';
      ROLLBACK;
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Vendor_Delete',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'VendorID',v_VendorID);
      SET SWP_Ret_Value = -1;
   end if;


   SET @SWV_Error = 0;
   DELETE FROM VendorFinancials
   WHERE 	CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   VendorID = v_VendorID;

   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Delete from VendorFinancials failed';
      ROLLBACK;
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Vendor_Delete',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'VendorID',v_VendorID);
      SET SWP_Ret_Value = -1;
   end if;

   SET @SWV_Error = 0;
   DELETE FROM VendorItemCrossReference
   WHERE 	CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   VendorID = v_VendorID;

   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Delete from VendorItemCrossReference failed';
      ROLLBACK;
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Vendor_Delete',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'VendorID',v_VendorID);
      SET SWP_Ret_Value = -1;
   end if;

   SET @SWV_Error = 0;
   DELETE FROM VendorPriceCrossReference
   WHERE 	CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   VendorID = v_VendorID;

   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Delete from VendorPriceCrossReference failed';
      ROLLBACK;
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Vendor_Delete',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'VendorID',v_VendorID);
      SET SWP_Ret_Value = -1;
   end if;


   SET @SWV_Error = 0;
   DELETE FROM VendorInformation
   WHERE 	CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   VendorID = v_VendorID;

   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Delete from VendorInformation failed';
      ROLLBACK;
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Vendor_Delete',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'VendorID',v_VendorID);
      SET SWP_Ret_Value = -1;
   end if;

   COMMIT;
   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;

   ROLLBACK;
   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Vendor_Delete',v_ErrorMessage,
   v_ErrorID);

   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'VendorID',v_VendorID);

   SET SWP_Ret_Value = -1;
END