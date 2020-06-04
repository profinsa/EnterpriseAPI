CREATE PROCEDURE Payroll_FIT2 (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_EmployeeID NATIONAL VARCHAR(36),
	v_PayrollID NATIONAL VARCHAR(36),
	v_PayrollItemID NATIONAL VARCHAR(36),
	INOUT v_FIT DECIMAL(19,4) ,INOUT SWP_Ret_Value INT) SWL_return:
BEGIN















   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);

   DECLARE v_AGI REAL;
   DECLARE v_FITYN BOOLEAN;
   DECLARE v_AllowAmt DECIMAL(19,4);
   DECLARE v_Allowance DECIMAL(19,4);
   DECLARE v_FederalAllowance INT;

   DECLARE v_OverAmnt DECIMAL(19,4);
   DECLARE v_TaxBracket REAL;
   DECLARE v_Cumulative DECIMAL(19,4);
   DECLARE v_FederalWithholdingAmount DECIMAL(19,4);

   DECLARE v_CompanyCurrencyID NATIONAL VARCHAR(3);
   DECLARE v_ErrorID INT;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
   END;
   SET @SWV_Error = 0;
   START TRANSACTION;

   select   IFNULL(AGI,0) INTO v_AGI FROM PayrollRegister WHERE
   UPPER(CompanyID) = UPPER(v_CompanyID)
   AND UPPER(DivisionID) = UPPER(v_DivisionID)
   AND UPPER(DepartmentID) = UPPER(v_DepartmentID)
   AND UPPER(EmployeeID) = UPPER(v_EmployeeID)
   AND UPPER(PayrollID) = UPPER(v_PayrollID);

   SET v_FITYN = IFNULL((SELECT  FITYN
   FROM         PayrollEmployeesDetail
   WHERE
   UPPER(CompanyID) = UPPER(v_CompanyID)
   AND UPPER(DivisionID) = UPPER(v_DivisionID)
   AND UPPER(DepartmentID) = UPPER(v_DepartmentID)
   AND UPPER(EmployeeID) = UPPER(v_EmployeeID) LIMIT 1),
   0);

   SET v_FederalAllowance = IFNULL((SELECT  FederalAllowance
   FROM         PayrollEmployeesDetail
   WHERE
   UPPER(CompanyID) = UPPER(v_CompanyID)
   AND UPPER(DivisionID) = UPPER(v_DivisionID)
   AND UPPER(DepartmentID) = UPPER(v_DepartmentID)
   AND UPPER(EmployeeID) = UPPER(v_EmployeeID) LIMIT 1),0);

   SET v_FederalWithholdingAmount = IFNULL((SELECT  FederalWithholdingAmount
   FROM         PayrollEmployeesDetail
   WHERE
   UPPER(CompanyID) = UPPER(v_CompanyID)
   AND UPPER(DivisionID) = UPPER(v_DivisionID)
   AND UPPER(DepartmentID) = UPPER(v_DepartmentID)
   AND UPPER(EmployeeID) = UPPER(v_EmployeeID) LIMIT 1),0);


   SET v_TaxBracket = IFNULL((SELECT  TaxBracket
   FROM         PayrollWithholdings
   WHERE
   UPPER(CompanyID) = UPPER(v_CompanyID)
   AND UPPER(DivisionID) = UPPER(v_DivisionID)
   AND UPPER(DepartmentID) = UPPER(v_DepartmentID) LIMIT 1),0);

   SET v_OverAmnt = IFNULL((SELECT  OverAmnt
   FROM         PayrollWithholdings
   WHERE
   UPPER(CompanyID) = UPPER(v_CompanyID)
   AND UPPER(DivisionID) = UPPER(v_DivisionID)
   AND UPPER(DepartmentID) = UPPER(v_DepartmentID) LIMIT 1),0);

   SET v_Cumulative = IFNULL((SELECT  Cumulative
   FROM         PayrollWithholdings
   WHERE
   UPPER(CompanyID) = UPPER(v_CompanyID)
   AND UPPER(DivisionID) = UPPER(v_DivisionID)
   AND UPPER(DepartmentID) = UPPER(v_DepartmentID) LIMIT 1),0);

   SET v_Allowance = IFNULL((SELECT  Allowance
   FROM         PayrollWithholdings
   WHERE
   UPPER(CompanyID) = UPPER(v_CompanyID)
   AND UPPER(DivisionID) = UPPER(v_DivisionID)
   AND UPPER(DepartmentID) = UPPER(v_DepartmentID) LIMIT 1),0);

   select   IFNULL(CurrencyID,N'') INTO v_CompanyCurrencyID FROM Companies WHERE CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID   LIMIT 1;


   IF (v_FITYN = 0) then
	
      SET v_AllowAmt = fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,v_Allowance*v_FederalAllowance, 
      v_CompanyCurrencyID);
      SET v_FIT = fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,(v_AGI -v_AllowAmt -v_OverAmnt)*v_TaxBracket+v_Cumulative+v_FederalWithholdingAmount,v_CompanyCurrencyID);
   ELSE
      SET v_FIT = v_FederalWithholdingAmount;
   end if;


   SET @SWV_Error = 0;
   UPDATE PayrollRegister
   SET
   FIT = v_FIT
   WHERE
   UPPER(CompanyID) = UPPER(v_CompanyID)
   AND UPPER(DivisionID) = UPPER(v_DivisionID)
   AND UPPER(DepartmentID) = UPPER(v_DepartmentID)
   AND UPPER(EmployeeID) = UPPER(v_EmployeeID)
   AND UPPER(PayrollID) = UPPER(v_PayrollID);

   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'UPDATE PayrollRegister failed';
      ROLLBACK;

      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payroll_FIT',v_ErrorMessage,v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'EmployeeID',v_EmployeeID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PayrollID',v_PayrollID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PayrollItemID',v_PayrollItemID);
      SET SWP_Ret_Value = -1;
   end if;


   COMMIT;
   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;








   ROLLBACK;

   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payroll_FIT',v_ErrorMessage,v_ErrorID);

   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'EmployeeID',v_EmployeeID);
   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PayrollID',v_PayrollID);
   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PayrollItemID',v_PayrollItemID);

   SET SWP_Ret_Value = -1;
END