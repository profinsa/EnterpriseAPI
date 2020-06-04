CREATE PROCEDURE Payment_Approve (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_PaymentID NATIONAL VARCHAR(36),
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
   UPDATE
   PaymentsHeader
   SET
   ApprovedForPayment = 1,ApprovedForPaymentDate = CURRENT_TIMESTAMP,ApprovedBy = v_EmployeeID
   WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND PaymentID = v_PaymentID
   AND IFNULL(Posted,0) = 1
   AND IFNULL(ApprovedForPayment,0) = 0
   AND PaymentID <> 'DEFAULT';



   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'update PaymentsHeader failed';
      ROLLBACK;

      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payment_Approve',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'EmployeeID',v_EmployeeID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PaymentID',v_PaymentID);
      SET SWP_Ret_Value = -1;
   end if;


   COMMIT;
   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;








   ROLLBACK;

   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payment_Approve',v_ErrorMessage,
   v_ErrorID);

   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'EmployeeID',v_EmployeeID);
   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PaymentID',v_PaymentID);

   SET SWP_Ret_Value = -1;
END