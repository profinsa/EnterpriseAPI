CREATE PROCEDURE RMA_Approve (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_PurchaseNumber NATIONAL VARCHAR(36),
	v_EmployeeID NATIONAL VARCHAR(36),INOUT SWP_Ret_Value INT) SWL_return:
BEGIN








   DECLARE v_ErrorID INT;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
   END;
   SET @SWV_Error = 0;
   START TRANSACTION;

   SET @SWV_Error = 0;
   UPDATE
   PurchaseHeader
   SET
   Approved = 1,ApprovedDate = CURRENT_TIMESTAMP,ApprovedBy = v_EmployeeID
   WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND PurchaseNumber = v_PurchaseNumber
   AND PurchaseNumber <> 'DEFAULT'
   AND IFNULL(Posted,0) = 1
   AND IFNULL(Approved,0) = 0
   AND LOWER(IFNULL(PurchaseHeader.TransactionTypeID,N'')) = N'rma';

   IF @SWV_Error <> 0 then
      ROLLBACK;

      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'RMA_Approve ','',v_ErrorID);
      SET SWP_Ret_Value = -1;
   end if;

	

   COMMIT;
   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;








   ROLLBACK;

   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'RMA_Approve ','',v_ErrorID);

   SET SWP_Ret_Value = -1;
END