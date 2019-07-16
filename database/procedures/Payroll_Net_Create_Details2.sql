CREATE PROCEDURE Payroll_Net_Create_Details2 (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_EmployeeID NATIONAL VARCHAR(36),
	v_PayrollID NATIONAL VARCHAR(36),
	v_Check NATIONAL VARCHAR(36),INOUT SWP_Ret_Value INT) SWL_return:
BEGIN










   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);

   DECLARE v_PayrollItemID NATIONAL VARCHAR(36);
   DECLARE v_ApplyItem BOOLEAN;

   DECLARE v_ErrorID INT;
   DECLARE NO_DATA INT DEFAULT 0;
   DECLARE PayrollItem_cursor CURSOR FOR
   SELECT 
   PayrollItemID,
	ApplyItem
   FROM PayrollItems
   WHERE     
   UPPER(CompanyID) = UPPER(v_CompanyID)
   AND UPPER(DivisionID) = UPPER(v_DivisionID)
   AND UPPER(DepartmentID) = UPPER(v_DepartmentID)
   AND UPPER(EmployeeID) = UPPER(v_EmployeeID) 	
   AND UPPER(Basis) = 'NET'
   AND IFNULL(ApplyItem,0) = 1
   ORDER BY PayrollItemTypeID;


   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
      SET NO_DATA = -2;
   END;
   DECLARE CONTINUE HANDLER FOR NOT FOUND SET NO_DATA = -1;
   SET @SWV_Error = 0;
   START TRANSACTION;


   OPEN PayrollItem_cursor;

   SET NO_DATA = 0;
   FETCH PayrollItem_cursor INTO v_PayrollItemID,v_ApplyItem;
   WHILE NO_DATA = 0 DO
	
	

      SET @SWV_Error = 0;
      SET v_ReturnStatus = Payroll_Net_Create_Detail_One2(v_CompanyID,v_DivisionID,v_DepartmentID,v_EmployeeID,v_PayrollID,v_PayrollItemID,
      v_Check);
      IF v_ReturnStatus <> 0 OR @SWV_Error <> 0 then
	
         SET v_ErrorMessage = 'Call enterprise.Payroll_Net_Create_Detail_One failed';
         ROLLBACK;

         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payroll_Net_Create_Details',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'EmployeeID',v_EmployeeID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PayrollID',v_PayrollID);
         SET SWP_Ret_Value = -1;
      end if;
      SET NO_DATA = 0;
      FETCH PayrollItem_cursor INTO v_PayrollItemID,v_ApplyItem;
   END WHILE;

   CLOSE PayrollItem_cursor;




   COMMIT;
   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;








   ROLLBACK;

   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payroll_Net_Create_Details',v_ErrorMessage,
   v_ErrorID);

   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'EmployeeID',v_EmployeeID);
   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PayrollID',v_PayrollID);

   SET SWP_Ret_Value = -1;
END