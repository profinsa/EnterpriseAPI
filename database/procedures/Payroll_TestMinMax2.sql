CREATE PROCEDURE Payroll_TestMinMax2 (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_EmployeeID NATIONAL VARCHAR(36),
	v_PayrollID NATIONAL VARCHAR(36),
	v_PayrollItemID NATIONAL VARCHAR(36),
	v_Check NATIONAL VARCHAR(36),
	INOUT v_ok DECIMAL(19,4) ,INOUT SWP_Ret_Value INT) SWL_return:
BEGIN

















   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);

   DECLARE v_Basis NATIONAL VARCHAR(20); 
   DECLARE v_YTDMaximum DECIMAL(19,4);
   DECLARE v_TotalAmount DECIMAL(19,4);
   DECLARE v_ItemTotalAmount DECIMAL(19,4);


   DECLARE v_ErrorID INT;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
   END;
   SET @SWV_Error = 0;
   START TRANSACTION; 

   SET @SWV_Error = 0;
   SET v_ReturnStatus = Payroll_ItemTotalAmount(v_CompanyID,v_DivisionID,v_DepartmentID,v_EmployeeID,v_PayrollID,v_PayrollItemID,
   v_Check,v_ItemTotalAmount);
   IF v_ReturnStatus <> 0 OR @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Call enterprise.Payroll_ItemTotalAmount failed';
      ROLLBACK;


      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payroll_TestMinMax',v_ErrorMessage,
      v_ErrorID);
      SET SWP_Ret_Value = -1;
   end if;


   select   IFNULL(YTDMaximum,0) INTO v_YTDMaximum FROM	PayrollItems WHERE
   UPPER(CompanyID) = UPPER(v_CompanyID)
   AND UPPER(DivisionID) = UPPER(v_DivisionID)
   AND UPPER(DepartmentID) = UPPER(v_DepartmentID)
   AND UPPER(EmployeeID) = UPPER(v_EmployeeID)
   AND UPPER(PayrollItemID) = UPPER(v_PayrollItemID)   LIMIT 1;


   IF @SWV_Error <> 0 OR v_YTDMaximum IS NULL then

      SET v_ErrorMessage = 'select top 1 FROM PayrollItems failed';
      ROLLBACK;


      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payroll_TestMinMax',v_ErrorMessage,
      v_ErrorID);
      SET SWP_Ret_Value = -1;
   end if;


   select   IFNULL(TotalAmount,0) INTO v_TotalAmount FROM	PayrollRegisterDetail WHERE
   UPPER(CompanyID) = UPPER(v_CompanyID)
   AND UPPER(DivisionID) = UPPER(v_DivisionID)
   AND UPPER(DepartmentID) = UPPER(v_DepartmentID)
   AND UPPER(EmployeeID) = UPPER(v_EmployeeID)
   AND UPPER(PayrollID) = UPPER(v_PayrollID)
   AND UPPER(PayrollItemID) = UPPER(v_PayrollItemID)   LIMIT 1;


   IF @SWV_Error <> 0 OR v_TotalAmount IS NULL then

      SET v_ErrorMessage = 'select top 1 FROM PayrollRegisterDetail failed';
      ROLLBACK;


      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payroll_TestMinMax',v_ErrorMessage,
      v_ErrorID);
      SET SWP_Ret_Value = -1;
   end if;


   If v_YTDMaximum > 0 then
      If v_YTDMaximum > v_TotalAmount then
         If v_YTDMaximum > v_TotalAmount+v_ItemTotalAmount then
            SET v_ok = 0;
         ELSE
            SET v_ok = v_YTDMaximum -v_TotalAmount;
         end if;
      ELSE
         SET v_ok = -1;
      end if;
   ELSE
      SET v_ok = 1;
   end if;
		    

   COMMIT;
   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;








   ROLLBACK;


   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payroll_TestMinMax',v_ErrorMessage,
   v_ErrorID);

   SET SWP_Ret_Value = -1;
END