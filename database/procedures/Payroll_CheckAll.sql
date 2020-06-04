CREATE PROCEDURE Payroll_CheckAll (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),INOUT SWP_Ret_Value INT) SWL_return:
BEGIN








   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);

   DECLARE v_EmployeeID NATIONAL VARCHAR(36);
   DECLARE v_PayrollID NATIONAL VARCHAR(36);

   DECLARE v_ErrorID INT;
   DECLARE NO_DATA INT DEFAULT 0;
   DECLARE Register_cursor CURSOR FOR
   SELECT 
   EmployeeID,
	PayrollID
   FROM PayrollRegister
   WHERE     
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND (IFNULL(Posted,0) = 0) 
   AND (UPPER(PayrollID) <> 'DEFAULT');

   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
      SET NO_DATA = -2;
   END;
   DECLARE CONTINUE HANDLER FOR NOT FOUND SET NO_DATA = -1;
   SET @SWV_Error = 0;
   START TRANSACTION;


   OPEN Register_cursor;

   SET NO_DATA = 0;
   FETCH Register_cursor INTO v_EmployeeID,v_PayrollID;
   WHILE NO_DATA = 0 DO
      SET @SWV_Error = 0;
      SET v_ReturnStatus = Payroll_Check2(v_CompanyID,v_DivisionID,v_DepartmentID,v_EmployeeID,v_PayrollID);
      IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then
	
         CLOSE Register_cursor;
		
         SET v_ErrorMessage = 'Payroll_Check call failed';
         ROLLBACK;
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payroll_CheckAll',v_ErrorMessage,
         v_ErrorID);
         SET SWP_Ret_Value = -1;
      end if;
      SET NO_DATA = 0;
      FETCH Register_cursor INTO v_EmployeeID,v_PayrollID;
   END WHILE;

   CLOSE Register_cursor;



   COMMIT;

   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;








   ROLLBACK;

   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payroll_CheckAll',v_ErrorMessage,
   v_ErrorID);

   SET SWP_Ret_Value = -1;
END