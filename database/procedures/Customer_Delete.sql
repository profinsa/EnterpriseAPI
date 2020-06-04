CREATE PROCEDURE Customer_Delete (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_EmployeeID NATIONAL VARCHAR(36),
	v_CustomerID NATIONAL VARCHAR(36),
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
   IF NOT EXISTS(SELECT CustomerID
   From CustomerInformation
   WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   CustomerID = v_CustomerID) then

      SET SWP_Ret_Value = 1;
      LEAVE SWL_return;
   end if;


   IF v_CustomerID = 'DEFAULT' then

      SET v_DeleteError = N'Can''t delete customer because it''s a default customer';
      SET SWP_Ret_Value = 2;
      LEAVE SWL_return;
   end if;



   select   LockedBy INTO v_LockEmployeeID From CustomerInformation WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   CustomerID = v_CustomerID;
   IF IFNULL(v_LockEmployeeID,v_EmployeeID) <> v_EmployeeID then

      SET v_DeleteError = CONCAT(N'Can''t delete customer because the record is locked by employee ',
      v_LockEmployeeID);
      SET SWP_Ret_Value = 2;
      LEAVE SWL_return;
   end if;
   select   LockedBy INTO v_LockEmployeeID From CustomerComments WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   CustomerID = v_CustomerID AND
   IFNULL(LockedBy,v_EmployeeID) <> v_EmployeeID   LIMIT 1;

   IF IFNULL(v_LockEmployeeID,v_EmployeeID) <> v_EmployeeID then

      SET v_DeleteError = CONCAT(N'Can''t delete customer because some of its CustomerComments records is locked by employee ',v_LockEmployeeID);
      SET SWP_Ret_Value = 2;
      LEAVE SWL_return;
   end if;

   select   LockedBy INTO v_LockEmployeeID From CustomerContactLog WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   CustomerID = v_CustomerID AND
   IFNULL(LockedBy,v_EmployeeID) <> v_EmployeeID   LIMIT 1;

   IF IFNULL(v_LockEmployeeID,v_EmployeeID) <> v_EmployeeID then

      SET v_DeleteError = CONCAT(N'Can''t delete customer because some of its CustomerContactLog records is locked by employee ',v_LockEmployeeID);
      SET SWP_Ret_Value = 2;
      LEAVE SWL_return;
   end if;


   select   LockedBy INTO v_LockEmployeeID From CustomerContacts WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   CustomerID = v_CustomerID AND
   IFNULL(LockedBy,v_EmployeeID) <> v_EmployeeID   LIMIT 1;

   IF IFNULL(v_LockEmployeeID,v_EmployeeID) <> v_EmployeeID then

      SET v_DeleteError = CONCAT(N'Can''t delete customer because some of its CustomerContacts records is locked by employee ',v_LockEmployeeID);
      SET SWP_Ret_Value = 2;
      LEAVE SWL_return;
   end if;

   select   LockedBy INTO v_LockEmployeeID From CustomerCreditReferences WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   CustomerID = v_CustomerID AND
   IFNULL(LockedBy,v_EmployeeID) <> v_EmployeeID   LIMIT 1;

   IF IFNULL(v_LockEmployeeID,v_EmployeeID) <> v_EmployeeID then

      SET v_DeleteError = CONCAT(N'Can''t delete customer because some of its CustomerCreditReferences records is locked by employee ',v_LockEmployeeID);
      SET SWP_Ret_Value = 2;
      LEAVE SWL_return;
   end if;

   select   LockedBy INTO v_LockEmployeeID From CustomerFinancials WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   CustomerID = v_CustomerID AND
   IFNULL(LockedBy,v_EmployeeID) <> v_EmployeeID   LIMIT 1;

   IF IFNULL(v_LockEmployeeID,v_EmployeeID) <> v_EmployeeID then

      SET v_DeleteError = CONCAT(N'Can''t delete customer because its CustomerFinancials record is locked by employee ',v_LockEmployeeID);
      SET SWP_Ret_Value = 2;
      LEAVE SWL_return;
   end if;

   select   LockedBy INTO v_LockEmployeeID From CustomerItemCrossReference WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   CustomerID = v_CustomerID AND
   IFNULL(LockedBy,v_EmployeeID) <> v_EmployeeID   LIMIT 1;

   IF IFNULL(v_LockEmployeeID,v_EmployeeID) <> v_EmployeeID then

      SET v_DeleteError = CONCAT(N'Can''t delete customer because some of its CustomerItemCrossReference records is locked by employee ',v_LockEmployeeID);
      SET SWP_Ret_Value = 2;
      LEAVE SWL_return;
   end if;

   select   LockedBy INTO v_LockEmployeeID From CustomerPriceCrossReference WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   CustomerID = v_CustomerID AND
   IFNULL(LockedBy,v_EmployeeID) <> v_EmployeeID   LIMIT 1;

   IF IFNULL(v_LockEmployeeID,v_EmployeeID) <> v_EmployeeID then

      SET v_DeleteError = CONCAT(N'Can''t delete customer because some of its CustomerPriceCrossReference records is locked by employee ',v_LockEmployeeID);
      SET SWP_Ret_Value = 2;
      LEAVE SWL_return;
   end if;

   select   LockedBy INTO v_LockEmployeeID From CustomerReferences WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   CustomerID = v_CustomerID AND
   IFNULL(LockedBy,v_EmployeeID) <> v_EmployeeID   LIMIT 1;

   IF IFNULL(v_LockEmployeeID,v_EmployeeID) <> v_EmployeeID then

      SET v_DeleteError = CONCAT(N'Can''t delete customer because some of its CustomerReferences records is locked by employee ',v_LockEmployeeID);
      SET SWP_Ret_Value = 2;
      LEAVE SWL_return;
   end if;

   select   LockedBy INTO v_LockEmployeeID From CustomerSatisfaction WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   CustomerID = v_CustomerID AND
   IFNULL(LockedBy,v_EmployeeID) <> v_EmployeeID   LIMIT 1;

   IF IFNULL(v_LockEmployeeID,v_EmployeeID) <> v_EmployeeID then

      SET v_DeleteError = CONCAT(N'Can''t delete customer because some of its CustomerSatisfaction records is locked by employee ',v_LockEmployeeID);
      SET SWP_Ret_Value = 2;
      LEAVE SWL_return;
   end if;

   select   LockedBy INTO v_LockEmployeeID From CustomerShipForLocations WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   CustomerID = v_CustomerID AND
   IFNULL(LockedBy,v_EmployeeID) <> v_EmployeeID   LIMIT 1;

   IF IFNULL(v_LockEmployeeID,v_EmployeeID) <> v_EmployeeID then

      SET v_DeleteError = CONCAT(N'Can''t delete customer because some of its CustomerShipForLocations records is locked by employee ',v_LockEmployeeID);
      SET SWP_Ret_Value = 2;
      LEAVE SWL_return;
   end if;

   select   LockedBy INTO v_LockEmployeeID From CustomerShipToLocations WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   CustomerID = v_CustomerID AND
   IFNULL(LockedBy,v_EmployeeID) <> v_EmployeeID   LIMIT 1;

   IF IFNULL(v_LockEmployeeID,v_EmployeeID) <> v_EmployeeID then

      SET v_DeleteError = CONCAT(N'Can''t delete customer because some of its CustomerShipToLocations records is locked by employee ',v_LockEmployeeID);
      SET SWP_Ret_Value = 2;
      LEAVE SWL_return;
   end if;

   START TRANSACTION;

   SET @SWV_Error = 0;
   DELETE FROM CustomerComments
   WHERE 	CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   CustomerID = v_CustomerID;

   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Delete from CustomerComments failed';
      ROLLBACK;
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Customer_Delete',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'CustomerID',v_CustomerID);
      SET SWP_Ret_Value = -1;
   end if;
		
   SET @SWV_Error = 0;
   DELETE FROM CustomerContactLog
   WHERE 	CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   CustomerID = v_CustomerID;

   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Delete from CustomerContactLog failed';
      ROLLBACK;
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Customer_Delete',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'CustomerID',v_CustomerID);
      SET SWP_Ret_Value = -1;
   end if;

   SET @SWV_Error = 0;
   DELETE FROM CustomerContacts
   WHERE 	CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   CustomerID = v_CustomerID;

   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Delete from CustomerContacts failed';
      ROLLBACK;
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Customer_Delete',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'CustomerID',v_CustomerID);
      SET SWP_Ret_Value = -1;
   end if;

   SET @SWV_Error = 0;
   DELETE FROM CustomerCreditReferences
   WHERE 	CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   CustomerID = v_CustomerID;

   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Delete from CustomerCreditReferences failed';
      ROLLBACK;
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Customer_Delete',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'CustomerID',v_CustomerID);
      SET SWP_Ret_Value = -1;
   end if;

   SET @SWV_Error = 0;
   DELETE FROM CustomerFinancials
   WHERE 	CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   CustomerID = v_CustomerID;

   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Delete from CustomerFinancials failed';
      ROLLBACK;
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Customer_Delete',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'CustomerID',v_CustomerID);
      SET SWP_Ret_Value = -1;
   end if;

   SET @SWV_Error = 0;
   DELETE FROM CustomerItemCrossReference
   WHERE 	CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   CustomerID = v_CustomerID;

   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Delete from CustomerItemCrossReference failed';
      ROLLBACK;
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Customer_Delete',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'CustomerID',v_CustomerID);
      SET SWP_Ret_Value = -1;
   end if;

   SET @SWV_Error = 0;
   DELETE FROM CustomerPriceCrossReference
   WHERE 	CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   CustomerID = v_CustomerID;

   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Delete from CustomerPriceCrossReference failed';
      ROLLBACK;
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Customer_Delete',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'CustomerID',v_CustomerID);
      SET SWP_Ret_Value = -1;
   end if;

   SET @SWV_Error = 0;
   DELETE FROM CustomerReferences
   WHERE 	CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   CustomerID = v_CustomerID;

   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Delete from CustomerReferences failed';
      ROLLBACK;
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Customer_Delete',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'CustomerID',v_CustomerID);
      SET SWP_Ret_Value = -1;
   end if;

   SET @SWV_Error = 0;
   DELETE FROM CustomerSatisfaction
   WHERE 	CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   CustomerID = v_CustomerID;

   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Delete from CustomerSatisfaction failed';
      ROLLBACK;
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Customer_Delete',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'CustomerID',v_CustomerID);
      SET SWP_Ret_Value = -1;
   end if;

   SET @SWV_Error = 0;
   DELETE FROM CustomerShipForLocations
   WHERE 	CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   CustomerID = v_CustomerID;

   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Delete from CustomerShipForLocations failed';
      ROLLBACK;
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Customer_Delete',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'CustomerID',v_CustomerID);
      SET SWP_Ret_Value = -1;
   end if;

   SET @SWV_Error = 0;
   DELETE FROM CustomerShipToLocations
   WHERE 	CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   CustomerID = v_CustomerID;

   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Delete from CustomerShipToLocations failed';
      ROLLBACK;
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Customer_Delete',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'CustomerID',v_CustomerID);
      SET SWP_Ret_Value = -1;
   end if;

   SET @SWV_Error = 0;
   DELETE FROM CustomerInformation
   WHERE 	CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   CustomerID = v_CustomerID;

   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Delete from CustomerInformation failed';
      ROLLBACK;
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Customer_Delete',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'CustomerID',v_CustomerID);
      SET SWP_Ret_Value = -1;
   end if;

   COMMIT;
   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;

   ROLLBACK;
   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Customer_Delete',v_ErrorMessage,
   v_ErrorID);

   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'CustomerID',v_CustomerID);

   SET SWP_Ret_Value = -1;
END