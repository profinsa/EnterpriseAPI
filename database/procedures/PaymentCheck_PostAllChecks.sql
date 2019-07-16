CREATE PROCEDURE PaymentCheck_PostAllChecks (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_EmployeeID NATIONAL VARCHAR(36),INOUT SWP_Ret_Value INT) SWL_return:
BEGIN













   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);

   DECLARE v_PaymentID NATIONAL VARCHAR(36);
   DECLARE v_ErrorID INT;
   DECLARE NO_DATA INT DEFAULT 0;
   DECLARE cPaymentsPrint CURSOR FOR
   SELECT DISTINCT
   PaymentID
   FROM
   PaymentChecks
   WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   EmployeeID = v_EmployeeID;

   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN

  

      SET @SWV_Error = 1;
      SET NO_DATA = -2;
   END;
   DECLARE CONTINUE HANDLER FOR NOT FOUND SET NO_DATA = -1;
   SET @SWV_Error = 0;
   START TRANSACTION;


   OPEN cPaymentsPrint;
   SET NO_DATA = 0;
   FETCH cPaymentsPrint INTO v_PaymentID;

   WHILE NO_DATA = 0 DO
      SET @SWV_Error = 0;
      CALL PaymentCheck_Post2(v_CompanyID,v_DivisionID,v_DepartmentID,v_PaymentID, v_ReturnStatus);
	
      IF @SWV_Error <> 0 OR v_ReturnStatus <> 0 then
	
         CLOSE cPaymentsPrint;
		
         SET v_ErrorMessage = 'PaymentCheck_Post call failed';
         ROLLBACK;

         CALL Error_InsertError(v_CompanyID,'','','PaymentsCheck_PostAllChecks',v_ErrorMessage,v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'EmployeeID',v_EmployeeID);
         SET SWP_Ret_Value = -1;
      end if;
      SET @SWV_Error = 0;
      CALL PaymentCheck_Printed2(v_CompanyID,v_DivisionID,v_DepartmentID,v_EmployeeID,v_PaymentID, v_ReturnStatus);
	
      IF @SWV_Error <> 0 OR v_ReturnStatus <> 0 then
	
         CLOSE cPaymentsPrint;
		
         SET v_ErrorMessage = 'PaymentCheck_Printed call failed';
         ROLLBACK;

         CALL Error_InsertError(v_CompanyID,'','','PaymentsCheck_PostAllChecks',v_ErrorMessage,v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'EmployeeID',v_EmployeeID);
         SET SWP_Ret_Value = -1;
      end if;
      SET NO_DATA = 0;
      FETCH cPaymentsPrint INTO v_PaymentID;
   END WHILE;

   CLOSE cPaymentsPrint;



   SET @SWV_Error = 0;
   CALL PaymentCheck_PrintDelete2(v_CompanyID,v_DivisionID,v_DepartmentID,v_EmployeeID, v_ReturnStatus);

   IF @SWV_Error <> 0 OR v_ReturnStatus <> 0 then

      SET v_ErrorMessage = 'PaymentCheck_Delete call failed';
      ROLLBACK;

      CALL Error_InsertError(v_CompanyID,'','','PaymentsCheck_PostAllChecks',v_ErrorMessage,v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'EmployeeID',v_EmployeeID);
      SET SWP_Ret_Value = -1;
   end if;



   COMMIT;
   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;








   ROLLBACK;

   CALL Error_InsertError(v_CompanyID,'','','PaymentsCheck_PostAllChecks',v_ErrorMessage,v_ErrorID);

   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'EmployeeID',v_EmployeeID);


   SET SWP_Ret_Value = -1;
END