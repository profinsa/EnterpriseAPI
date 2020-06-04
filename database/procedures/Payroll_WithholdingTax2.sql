CREATE PROCEDURE Payroll_WithholdingTax2 (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_EmployeeID NATIONAL VARCHAR(36),
	v_PayrollID NATIONAL VARCHAR(36),
	v_Check NATIONAL VARCHAR(36),INOUT SWP_Ret_Value INT) SWL_return:
BEGIN




   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);



   DECLARE v_CountyWithholdingAmount DECIMAL(19,4);
   DECLARE v_CityWithholdingAmount DECIMAL(19,4);
   DECLARE v_StateWithholdingAmount DECIMAL(19,4);
   DECLARE v_FederalWithholdingAmount DECIMAL(19,4);
   DECLARE v_State NATIONAL VARCHAR(50);
   DECLARE v_Country NATIONAL VARCHAR(50);
   DECLARE v_County NATIONAL VARCHAR(50);
   DECLARE v_City NATIONAL VARCHAR(50);
   DECLARE v_PayrollCheckYear INT;
   DECLARE v_PayrollCheckDate DATETIME;
   DECLARE v_AnnualGrossPay DECIMAL(19,4);

   DECLARE v_ErrorID INT;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
   END;
   SET @SWV_Error = 0;
   START TRANSACTION;

   select   PayPeriodEndDate INTO v_PayrollCheckDate FROM PayrollRegister WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND EmployeeID = v_EmployeeID
   AND PayrollID = v_PayrollID;


   SET v_PayrollCheckYear = YEAR(v_PayrollCheckDate);

   select   EmployeeCountry, EmployeeState, EmployeeCounty, EmployeeCity INTO v_Country,v_State,v_County,v_City FROM PayrollEmployees WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND EmployeeID = v_EmployeeID;



   select   IFNULL(AGI,0) INTO v_AnnualGrossPay FROM PayrollRegister WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND EmployeeID = v_EmployeeID
   AND PayrollID = v_PayrollID;



   SET @SWV_Error = 0;
   SET v_ReturnStatus = Payroll_WithholdingTax_City(v_CompanyID,v_DivisionID,v_DepartmentID,v_EmployeeID,v_PayrollID,v_State,
   v_County,v_City,v_PayrollCheckYear,v_AnnualGrossPay);
   IF v_ReturnStatus <> 0 OR @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Call enterprise.Payroll_WithholdingTax_City failed';
      ROLLBACK;

      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payroll_WithholdingTax',v_ErrorMessage,
      v_ErrorID);
      SET SWP_Ret_Value = -1;
   end if;


   SET @SWV_Error = 0;
   SET v_ReturnStatus = Payroll_WithholdingTax_County(v_CompanyID,v_DivisionID,v_DepartmentID,v_EmployeeID,v_PayrollID,v_State,
   v_County,v_PayrollCheckYear,v_AnnualGrossPay);
   IF v_ReturnStatus <> 0 OR @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Call enterprise.Payroll_WithholdingTax_County failed';
      ROLLBACK;

      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payroll_WithholdingTax',v_ErrorMessage,
      v_ErrorID);
      SET SWP_Ret_Value = -1;
   end if;


   SET @SWV_Error = 0;
   SET v_ReturnStatus = Payroll_WithholdingTax_State(v_CompanyID,v_DivisionID,v_DepartmentID,v_EmployeeID,v_PayrollID,v_State,
   v_PayrollCheckYear,v_AnnualGrossPay);
   IF v_ReturnStatus <> 0 OR @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Call enterprise.Payroll_WithholdingTax_State failed';
      ROLLBACK;

      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payroll_WithholdingTax',v_ErrorMessage,
      v_ErrorID);
      SET SWP_Ret_Value = -1;
   end if;


   SET @SWV_Error = 0;
   SET v_ReturnStatus = Payroll_WithholdingTax_Fed(v_CompanyID,v_DivisionID,v_DepartmentID,v_EmployeeID,v_PayrollID,v_Country,
   v_PayrollCheckYear,v_AnnualGrossPay);
   IF v_ReturnStatus <> 0 OR @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Call enterprise.Payroll_WithholdingTax_Fed failed';
      ROLLBACK;

      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payroll_WithholdingTax',v_ErrorMessage,
      v_ErrorID);
      SET SWP_Ret_Value = -1;
   end if;



   select   IFNULL(CountyTax,0), IFNULL(CityTax,0), IFNULL(StateTax,0), IFNULL(FIT,0) INTO v_CountyWithholdingAmount,v_CityWithholdingAmount,v_StateWithholdingAmount,
   v_FederalWithholdingAmount FROM
   PayrollRegister WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND EmployeeID = v_EmployeeID
   AND PayrollID = v_PayrollID;


   SET @SWV_Error = 0;
   UPDATE PayrollEmployeesDetail
   SET
   CountyWithhoddingAmount = v_CountyWithholdingAmount,CityWithhoddingAmount = v_CityWithholdingAmount,
   StateWithholdingAmount = v_StateWithholdingAmount,
   FederalWithholdingAmount = v_FederalWithholdingAmount
   WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND EmployeeID = v_EmployeeID;

   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'UPDATE PayrollEmployeesDetail failed';
      ROLLBACK;

      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payroll_WithholdingTax',v_ErrorMessage,
      v_ErrorID);
      SET SWP_Ret_Value = -1;
   end if;




   COMMIT;


   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;



   ROLLBACK;

   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payroll_WithholdingTax',v_ErrorMessage,
   v_ErrorID);

   SET SWP_Ret_Value = -1;
END