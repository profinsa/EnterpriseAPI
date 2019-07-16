CREATE PROCEDURE Payroll_FUTA2 (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_EmployeeID NATIONAL VARCHAR(36),
	v_PayrollID NATIONAL VARCHAR(36),
	v_PayrollItemID NATIONAL VARCHAR(36),
	v_Check NATIONAL VARCHAR(36),
	INOUT v_FUTA DECIMAL(19,4) ,INOUT SWP_Ret_Value INT) SWL_return:
BEGIN















   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);
 
   DECLARE v_YearToDateGross DECIMAL(19,4);
   DECLARE v_FUTARate REAL;
   DECLARE v_FUTAWageBase REAL;
   DECLARE v_GROSS REAL;

   DECLARE v_CompanyCurrencyID NATIONAL VARCHAR(3);
   DECLARE v_ErrorID INT;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
   END;
   SET @SWV_Error = 0;
   START TRANSACTION; 

   select   IFNULL(Gross,0) INTO v_GROSS FROM PayrollRegister WHERE
   UPPER(CompanyID) = UPPER(v_CompanyID)
   AND UPPER(DivisionID) = UPPER(v_DivisionID)
   AND UPPER(DepartmentID) = UPPER(v_DepartmentID)
   AND UPPER(EmployeeID) = UPPER(v_EmployeeID)
   AND UPPER(PayrollID) = UPPER(v_PayrollID);

   select   IFNULL(YearToDateGross,0) INTO v_YearToDateGross FROM	PayrollEmployeesDetail WHERE
   UPPER(CompanyID) = UPPER(v_CompanyID)
   AND UPPER(DivisionID) = UPPER(v_DivisionID)
   AND UPPER(DepartmentID) = UPPER(v_DepartmentID)
   AND UPPER(EmployeeID) = UPPER(v_EmployeeID)   LIMIT 1;

		   
   select   IFNULL(FUTARate,0), IFNULL(FUTAWageBase,0) INTO v_FUTARate,v_FUTAWageBase FROM	PayrollSetup WHERE
   UPPER(CompanyID) = UPPER(v_CompanyID)
   AND UPPER(DivisionID) = UPPER(v_DivisionID)
   AND UPPER(DepartmentID) = UPPER(v_DepartmentID)   LIMIT 1;	
	
   select   IFNULL(CurrencyID,N'') INTO v_CompanyCurrencyID FROM Companies WHERE CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID   LIMIT 1;

   IF v_YearToDateGross < v_FUTAWageBase then
      IF v_YearToDateGross+v_GROSS < v_FUTAWageBase then
         SET v_FUTA = fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,v_GROSS*(v_FUTARate/100),v_CompanyCurrencyID);
      ELSE
         SET v_FUTA = fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,(v_FUTAWageBase -v_YearToDateGross)*(v_FUTARate/100), 
         v_CompanyCurrencyID);
      end if;
   ELSE
	
      SET v_ErrorMessage = 'UPDATE PayrollRegister failed, @FUTA is undefined';
      ROLLBACK;

      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payroll_FUTA',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'EmployeeID',v_EmployeeID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PayrollID',v_PayrollID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PayrollItemID',v_PayrollItemID);
      SET SWP_Ret_Value = -1;
   end if;

   SET @SWV_Error = 0;
   UPDATE PayrollRegister
   SET
   FUTA = v_FUTA
   WHERE
   UPPER(CompanyID) = UPPER(v_CompanyID)
   AND UPPER(DivisionID) = UPPER(v_DivisionID)
   AND UPPER(DepartmentID) = UPPER(v_DepartmentID)
   AND UPPER(EmployeeID) = UPPER(v_EmployeeID)
   AND UPPER(PayrollID) = UPPER(v_PayrollID);

   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'UPDATE PayrollRegister failed';
      ROLLBACK;

      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payroll_FUTA',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'EmployeeID',v_EmployeeID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PayrollID',v_PayrollID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PayrollItemID',v_PayrollItemID);
      SET SWP_Ret_Value = -1;
   end if;


   COMMIT;
   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;








   ROLLBACK;

   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payroll_FUTA',v_ErrorMessage,
   v_ErrorID);

   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'EmployeeID',v_EmployeeID);
   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PayrollID',v_PayrollID);
   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PayrollItemID',v_PayrollItemID);

   SET SWP_Ret_Value = -1;
END