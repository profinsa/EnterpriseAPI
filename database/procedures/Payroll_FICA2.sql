CREATE PROCEDURE Payroll_FICA2 (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_EmployeeID NATIONAL VARCHAR(36),
	v_PayrollID NATIONAL VARCHAR(36),
	v_PayrollItemID NATIONAL VARCHAR(36),
	v_Check NATIONAL VARCHAR(36),
	INOUT v_FICAEE DECIMAL(19,4) ,
	INOUT v_FICAER DECIMAL(19,4) ,
	INOUT v_Medi DECIMAL(19,4) ,INOUT SWP_Ret_Value INT) SWL_return:
BEGIN








   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);

   DECLARE v_LastFICA DECIMAL(19,4);
   DECLARE v_YearToDateGROSS DECIMAL(19,4);
   DECLARE v_FICAYN BOOLEAN;
   DECLARE v_FICARate REAL;
   DECLARE v_FICAWageBase REAL;
   DECLARE v_FICAMedRate REAL;
   DECLARE v_FICAMedWageBase REAL;
   DECLARE v_SSIRate REAL;
   DECLARE v_SSIWageBase REAL;
   DECLARE v_SocSec DECIMAL(19,4);
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

   select   IFNULL(LastFICA,0), IFNULL(YearToDateGross,0), IFNULL(FICAYN,0) INTO v_LastFICA,v_YearToDateGROSS,v_FICAYN FROM	PayrollEmployeesDetail WHERE
   UPPER(CompanyID) = UPPER(v_CompanyID)
   AND UPPER(DivisionID) = UPPER(v_DivisionID)
   AND UPPER(DepartmentID) = UPPER(v_DepartmentID)
   AND UPPER(EmployeeID) = UPPER(v_EmployeeID)   LIMIT 1;
		   
   select   IFNULL(FICARate,0), IFNULL(FICAWageBase,0), IFNULL(FICAMedRate,0), IFNULL(FICAMedWageBase,0), IFNULL(SSIRate,0), IFNULL(v_SSIWageBase,0) INTO v_FICARate,v_FICAWageBase,v_FICAMedRate,v_FICAMedWageBase,v_SSIRate,v_SSIWageBase FROM	PayrollSetup WHERE
   UPPER(CompanyID) = UPPER(v_CompanyID)
   AND UPPER(DivisionID) = UPPER(v_DivisionID)
   AND UPPER(DepartmentID) = UPPER(v_DepartmentID)   LIMIT 1;	
	
   SET v_Medi = 0;
   SET v_SocSec = 0;

   select   IFNULL(CurrencyID,N'') INTO v_CompanyCurrencyID FROM Companies WHERE CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID   LIMIT 1;


   IF UPPER(v_Check) = UPPER('Manual') then

      SET v_FICAEE = v_LastFICA;
      SET v_FICAER = fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,v_FICAEE/(1 -(v_FICARate/100))*(v_FICARate/100), 
      v_CompanyCurrencyID);
   ELSE
      IF v_FICAYN = 0 then
         IF v_YearToDateGROSS < v_SSIWageBase then
            IF v_YearToDateGROSS+v_GROSS < v_SSIWageBase then
               SET v_SocSec = fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,(v_GROSS*v_SSIRate)/100,v_CompanyCurrencyID);
            ELSE
               SET v_SocSec = fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,v_SSIWageBase -(v_YearToDateGROSS*v_SSIRate)/100, 
               v_CompanyCurrencyID);
            end if;
         end if;
      end if;
      IF v_FICAMedWageBase > 0 then
	
         IF v_YearToDateGROSS < v_FICAMedWageBase then
            IF v_YearToDateGROSS+v_GROSS < v_FICAMedWageBase then
               SET v_Medi = fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,(v_GROSS*v_FICAMedRate)/100,v_CompanyCurrencyID);
            ELSE
               SET v_Medi = fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,v_FICAMedWageBase -(v_YearToDateGROSS*v_FICAMedRate)/100, 
               v_CompanyCurrencyID);
            end if;
         end if;
      ELSE
         SET v_Medi = fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,(v_GROSS*v_FICAMedRate)/100,v_CompanyCurrencyID);
      end if;
      SET v_FICAEE = fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,(v_Medi+v_SocSec)*(1 -(v_FICARate/100)), 
      v_CompanyCurrencyID);
      SET v_FICAER = fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,(v_Medi+v_SocSec)*(v_FICARate)/100, 
      v_CompanyCurrencyID);
   end if;



   SET @SWV_Error = 0;
   UPDATE PayrollRegister
   SET
   FICA = v_FICAEE,FICAER = v_FICAER,FICAMed = v_Medi
   WHERE
   UPPER(CompanyID) = UPPER(v_CompanyID)
   AND UPPER(DivisionID) = UPPER(v_DivisionID)
   AND UPPER(DepartmentID) = UPPER(v_DepartmentID)
   AND UPPER(EmployeeID) = UPPER(v_EmployeeID)
   AND UPPER(PayrollID) = UPPER(v_PayrollID);

   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'UPDATE PayrollRegister failed';
      ROLLBACK;

      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payroll_FICA',v_ErrorMessage,
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

   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payroll_FICA',v_ErrorMessage,
   v_ErrorID);

   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'EmployeeID',v_EmployeeID);
   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PayrollID',v_PayrollID);
   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PayrollItemID',v_PayrollItemID);

   SET SWP_Ret_Value = -1;
END