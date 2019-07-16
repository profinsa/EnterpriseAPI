CREATE PROCEDURE PayrollCheckPrinted (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_EmployeeID NATIONAL VARCHAR(36),
	v_PayrollID NATIONAL VARCHAR(36),
	v_CheckNumber INT,INOUT SWP_Ret_Value INT) SWL_return:
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
   PayrollChecks
   SET
   CheckPrinted = 1
   WHERE
   UPPER(CompanyID) = UPPER(v_CompanyID) AND
   UPPER(DivisionID) = UPPER(v_DivisionID) AND
   UPPER(DepartmentID) = UPPER(v_DepartmentID) AND
   UPPER(PayrollID) = UPPER(v_PayrollID) AND
   UPPER(EmployeeID) = UPPER(v_EmployeeID) AND
   CheckNumber = v_CheckNumber;



   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Error Updating Data in PayrollChecks';
      ROLLBACK;


      CALL Error_InsertError(v_CompanyID,'','','PaymentCheck_Printed',v_ErrorMessage,v_ErrorID);
      SET SWP_Ret_Value = -1;
   end if;
	
	



   COMMIT;
   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;








   ROLLBACK;


   CALL Error_InsertError(v_CompanyID,'','','PaymentCheck_Printed',v_ErrorMessage,v_ErrorID);

   SET SWP_Ret_Value = -1;
END