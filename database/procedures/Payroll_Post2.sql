CREATE PROCEDURE Payroll_Post2 (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_EmployeeID NATIONAL VARCHAR(36),
	v_PayrollID NATIONAL VARCHAR(36),
	v_CheckNumber NATIONAL VARCHAR(36),INOUT SWP_Ret_Value INT) SWL_return:
BEGIN






   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);

   DECLARE v_Posted BOOLEAN;


   DECLARE v_CurDate DATETIME;
   DECLARE v_MonthToDateGross DECIMAL(19,4);
   DECLARE v_MonthToDateFICA DECIMAL(19,4);
   DECLARE v_MonthToDateFederal DECIMAL(19,4);
   DECLARE v_MonthToDateState DECIMAL(19,4);
   DECLARE v_MonthToDateLocal DECIMAL(19,4);
   DECLARE v_MonthToDateOther DECIMAL(19,4);
   DECLARE v_QuarterToDateGross DECIMAL(19,4);
   DECLARE v_QuarterToDateFICA DECIMAL(19,4);
   DECLARE v_QuarterToDateFederal DECIMAL(19,4);
   DECLARE v_QuarterToDateState DECIMAL(19,4);
   DECLARE v_QuarterToDateLocal DECIMAL(19,4);
   DECLARE v_QuarterToDateOther DECIMAL(19,4);
   DECLARE v_YearToDateGross DECIMAL(19,4);
   DECLARE v_YearToDateFICA DECIMAL(19,4);
   DECLARE v_YearToDateFederal DECIMAL(19,4);
   DECLARE v_YearToDateState DECIMAL(19,4);
   DECLARE v_YearToDateLocal DECIMAL(19,4);
   DECLARE v_YearToDateOther DECIMAL(19,4);

   DECLARE v_YearToDateAGI DECIMAL(19,4);
   DECLARE v_YearToDateFICAMed DECIMAL(19,4);
   DECLARE v_YearToDateFUTA DECIMAL(19,4);
   DECLARE v_YearToDateSUTA DECIMAL(19,4);
   DECLARE v_YearToDateSIT DECIMAL(19,4);
   DECLARE v_YearToDateSDI DECIMAL(19,4);
   DECLARE v_YearToDateLUI DECIMAL(19,4);





   DECLARE v_YearStartDate DATETIME;
   DECLARE v_YearEndDate DATETIME;
   DECLARE v_QuarterStartDate DATETIME;
   DECLARE v_QuarterEndDate DATETIME;
   DECLARE v_MonthStartDate DATETIME;
   DECLARE v_MonthEndDate DATETIME;
   DECLARE v_Year INT;
   DECLARE v_Month INT;
   DECLARE v_QuarterMonth INT;
   DECLARE v_ErrorID INT;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
   END;
   select   IFNULL(Posted,0) INTO v_Posted FROM
   PayrollRegister WHERE
   UPPER(CompanyID) = UPPER(v_CompanyID) AND
   UPPER(DivisionID) = UPPER(v_DivisionID) AND
   UPPER(DepartmentID) = UPPER(v_DepartmentID) AND
   UPPER(EmployeeID) = UPPER(v_EmployeeID) AND
   UPPER(PayrollID) = UPPER(v_PayrollID);




   IF v_Posted = 1 then

      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;
   end if;


   START TRANSACTION;



   SET @SWV_Error = 0;
   SET v_ReturnStatus = Payroll_CreateGLTransaction2(v_CompanyID,v_DivisionID,v_DepartmentID,v_EmployeeID,v_PayrollID);
   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then

      SET v_ErrorMessage = 'Payroll_CreateGLTransaction call failed';
      ROLLBACK;
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payroll_Post',v_ErrorMessage,
      v_ErrorID);
      SET SWP_Ret_Value = -1;
   end if;

   SET v_CurDate = CURRENT_TIMESTAMP;


   UPDATE
   PayrollRegister
   SET
   Posted = 1,CheckNumber = v_CheckNumber,PayrollCheckDate = v_CurDate
   WHERE
   UPPER(CompanyID) = UPPER(v_CompanyID) AND
   UPPER(DivisionID) = UPPER(v_DivisionID) AND
   UPPER(DepartmentID) = UPPER(v_DepartmentID) AND
   UPPER(EmployeeID) = UPPER(v_EmployeeID) AND
   UPPER(PayrollID) = UPPER(v_PayrollID);

   SET v_Year = YEAR(v_CurDate);
   SET v_Month = MONTH(v_CurDate);
   SET v_QuarterMonth =((v_Month -1)/3)*3+1;

   SET v_YearStartDate = CAST(CONCAT('1-1-',CAST(v_Year AS CHAR(30))) AS DATETIME);
   SET v_YearEndDate = CAST(CONCAT('12-31-',CAST(v_Year AS CHAR(30))) AS DATETIME);
   select   IFNULL(FiscalStartDate,v_YearStartDate), IFNULL(FiscalEndDate,v_YearEndDate) INTO v_YearStartDate,v_YearEndDate FROM
   Companies WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID;

   SET v_YearStartDate = fnTrimDateLower(v_YearStartDate);
   IF v_CurDate BETWEEN v_YearStartDate AND v_YearEndDate then

      SET v_MonthStartDate = CAST(CONCAT(CAST(v_Month AS CHAR(30)),'-1-',CAST(v_Year AS CHAR(30))) AS DATETIME);
      SET v_MonthEndDate = TIMESTAMPADD(month,1,v_MonthStartDate);
      SET v_MonthEndDate = TIMESTAMPADD(day,-1,v_MonthEndDate);
      SET v_QuarterStartDate = CAST(CONCAT(CAST(v_QuarterMonth AS CHAR(30)),'-1-',CAST(v_Year AS CHAR(30))) AS DATETIME);
      SET v_QuarterEndDate = TIMESTAMPADD(month,3,v_QuarterStartDate);
      SET v_QuarterEndDate = TIMESTAMPADD(day,-1,v_QuarterEndDate);
      select   SUM(IFNULL(Gross,0)), SUM(IFNULL(FICA,0)), SUM(IFNULL(FIT,0)), SUM(IFNULL(StateTax,0)), SUM(IFNULL(CountyTax,0)), SUM(IFNULL(CityTax,0)) INTO v_MonthToDateGross,v_MonthToDateFICA,v_MonthToDateFederal,v_MonthToDateState,
      v_MonthToDateLocal,v_MonthToDateOther FROM
      PayrollRegister WHERE
      UPPER(CompanyID) = UPPER(v_CompanyID) AND
      UPPER(DivisionID) = UPPER(v_DivisionID) AND
      UPPER(DepartmentID) = UPPER(v_DepartmentID) AND
      UPPER(EmployeeID) = UPPER(v_EmployeeID) AND
      Posted = 1 AND
      fnTrimDateLower(PayrollCheckDate) BETWEEN v_MonthStartDate AND v_MonthEndDate;
      select   SUM(IFNULL(Gross,0)), SUM(IFNULL(FICA,0)), SUM(IFNULL(FIT,0)), SUM(IFNULL(StateTax,0)), SUM(IFNULL(CountyTax,0)), SUM(IFNULL(CityTax,0)) INTO v_QuarterToDateGross,v_QuarterToDateFICA,v_QuarterToDateFederal,v_QuarterToDateState,
      v_QuarterToDateLocal,v_QuarterToDateOther FROM
      PayrollRegister WHERE
      UPPER(CompanyID) = UPPER(v_CompanyID) AND
      UPPER(DivisionID) = UPPER(v_DivisionID) AND
      UPPER(DepartmentID) = UPPER(v_DepartmentID) AND
      UPPER(EmployeeID) = UPPER(v_EmployeeID) AND
      Posted = 1 AND
      fnTrimDateLower(PayrollCheckDate) BETWEEN v_QuarterStartDate AND v_QuarterEndDate;
      select   SUM(IFNULL(Gross,0)), SUM(IFNULL(FICA,0)), SUM(IFNULL(FIT,0)), SUM(IFNULL(StateTax,0)), SUM(IFNULL(CountyTax,0)), SUM(IFNULL(CityTax,0)), SUM(IFNULL(AGI,0)), SUM(IFNULL(FICAMed,0)), SUM(IFNULL(FUTA,0)), SUM(IFNULL(SUTA,0)), SUM(IFNULL(SIT,0)), SUM(IFNULL(SDI,0)), SUM(IFNULL(LUI,0)) INTO v_YearToDateGross,v_YearToDateFICA,v_YearToDateFederal,v_YearToDateState,
      v_YearToDateLocal,v_YearToDateOther,v_YearToDateAGI,v_YearToDateFICAMed,
      v_YearToDateFUTA,v_YearToDateSUTA,v_YearToDateSIT,v_YearToDateSDI,
      v_YearToDateLUI FROM
      PayrollRegister WHERE
      UPPER(CompanyID) = UPPER(v_CompanyID) AND
      UPPER(DivisionID) = UPPER(v_DivisionID) AND
      UPPER(DepartmentID) = UPPER(v_DepartmentID) AND
      UPPER(EmployeeID) = UPPER(v_EmployeeID) AND
      Posted = 1 AND
      fnTrimDateLower(PayrollCheckDate) BETWEEN v_YearStartDate AND v_YearEndDate;
      UPDATE
      PayrollEmployees
      SET
      MonthToDateGross = IFNULL(v_MonthToDateGross,0),MonthToDateFICA = IFNULL(v_MonthToDateFICA,0),
      MonthToDateFederal = IFNULL(v_MonthToDateFederal,0),
      MonthToDateState = IFNULL(v_MonthToDateState,0),MonthToDateLocal = IFNULL(v_MonthToDateLocal,0),
      MonthToDateOther = IFNULL(v_MonthToDateOther,0),QuarterToDateGross = IFNULL(v_QuarterToDateGross,0),
      QuarterToDateFICA = IFNULL(v_QuarterToDateFICA,0),
      QuarterToDateFederal = IFNULL(v_QuarterToDateFederal,0),
      QuarterToDateState = IFNULL(v_QuarterToDateState,0),QuarterToDateLocal = IFNULL(v_QuarterToDateLocal,0),
      QuarterToDateOther = IFNULL(v_QuarterToDateOther,0),
      YearToDateGross = IFNULL(v_YearToDateGross,0),YearToDateFICA = IFNULL(v_YearToDateFICA,0),
      YearToDateFederal = IFNULL(v_YearToDateFederal,0),
      YearToDateState = IFNULL(v_YearToDateState,0),YearToDateLocal = IFNULL(v_YearToDateLocal,0),
      YearToDateOther = IFNULL(v_YearToDateOther,0)
      WHERE
      UPPER(CompanyID) = UPPER(v_CompanyID) AND
      UPPER(DivisionID) = UPPER(v_DivisionID) AND
      UPPER(DepartmentID) = UPPER(v_DepartmentID) AND
      UPPER(EmployeeID) = UPPER(v_EmployeeID);
      UPDATE
      PayrollEmployeesDetail
      SET
      YearToDateGross = IFNULL(v_YearToDateGross,0),YearToDateFICA = IFNULL(v_YearToDateFICA,0),
      YearToDateLocal = IFNULL(v_YearToDateLocal,0),YearToDateAGI = IFNULL(v_YearToDateAGI,0),
      YearToDateFICAMed = IFNULL(v_YearToDateFICAMed,0),
      YearToDateFUTA = IFNULL(v_YearToDateFUTA,0),YearToDateSUTA = IFNULL(v_YearToDateSUTA,0),
      YearToDateSIT = IFNULL(v_YearToDateSIT,0),YearToDateSDI = IFNULL(v_YearToDateSDI,0),
      YearToDateLUI = IFNULL(v_YearToDateLUI,0)
      WHERE
      UPPER(CompanyID) = UPPER(v_CompanyID) AND
      UPPER(DivisionID) = UPPER(v_DivisionID) AND
      UPPER(DepartmentID) = UPPER(v_DepartmentID) AND
      UPPER(EmployeeID) = UPPER(v_EmployeeID);
      UPDATE
      PayrollRegister
      SET
      YTDGross = IFNULL(v_YearToDateGross,0)
      WHERE
      UPPER(CompanyID) = UPPER(v_CompanyID) AND
      UPPER(DivisionID) = UPPER(v_DivisionID) AND
      UPPER(DepartmentID) = UPPER(v_DepartmentID) AND
      UPPER(EmployeeID) = UPPER(v_EmployeeID) AND
      UPPER(PayrollID) = UPPER(v_PayrollID);
   end if;

   COMMIT;
   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;








   ROLLBACK;

   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payroll_Post',v_ErrorMessage,
   v_ErrorID);

   SET SWP_Ret_Value = -1;
END