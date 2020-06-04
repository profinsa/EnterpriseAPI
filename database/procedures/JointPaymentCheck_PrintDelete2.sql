CREATE PROCEDURE JointPaymentCheck_PrintDelete2 (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_EmployeeID NATIONAL VARCHAR(36),INOUT SWP_Ret_Value INT) SWL_return:
BEGIN



   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);
   DECLARE v_ErrorID INT;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
   END;
   SET @SWV_Error = 0;
   START TRANSACTION;

   SET @SWV_Error = 0;
   DELETE FROM
   PaymentChecks
   WHERE
		(CompanyID <> v_CompanyID OR
   DivisionID <> v_DivisionID OR
   DepartmentID <> v_DepartmentID) AND
   EmployeeID = v_EmployeeID AND
   Printed = 1;

	
   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Error Deleting Data';
      ROLLBACK;

      CALL Error_InsertError(v_CompanyID,'','','JointPaymentCheck_PrintDelete',v_ErrorMessage,v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'EmployeeID',v_EmployeeID);
      SET SWP_Ret_Value = -1;
   end if;


   COMMIT;
   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;








   ROLLBACK;

   CALL Error_InsertError(v_CompanyID,'','','JointPaymentCheck_PrintDelete',v_ErrorMessage,v_ErrorID);

   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'EmployeeID',v_EmployeeID);

   SET SWP_Ret_Value = -1;
END