CREATE PROCEDURE Payroll_Regular2 (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_EmployeeID NATIONAL VARCHAR(36),
	INOUT v_Regular REAL ,
	INOUT v_OT REAL ,INOUT SWP_Ret_Value INT) BEGIN








   DECLARE v_PayFrequency NATIONAL VARCHAR(50);
   DECLARE v_OTConversion INT;
   DECLARE v_LastHours REAL;
   SET v_PayFrequency = '';
   SET v_OTConversion = 0;
   SET v_LastHours = 0;
   SET v_OT = 0;


   SET v_PayFrequency = IFNULL((SELECT PayFrequency
   FROM
   PayrollEmployeesDetail
   WHERE
   UPPER(CompanyID) = UPPER(v_CompanyID)
   AND UPPER(DivisionID) = UPPER(v_DivisionID)
   AND UPPER(DepartmentID) = UPPER(v_DepartmentID)
   AND UPPER(EmployeeID) = UPPER(v_EmployeeID)),0);

   SET v_LastHours = IFNULL((SELECT LastHours
   FROM
   PayrollEmployeesDetail
   WHERE
   UPPER(CompanyID) = UPPER(v_CompanyID)
   AND UPPER(DivisionID) = UPPER(v_DivisionID)
   AND UPPER(DepartmentID) = UPPER(v_DepartmentID)
   AND UPPER(EmployeeID) = UPPER(v_EmployeeID)),0);

   IF (v_PayFrequency = 'ByWeekly') then

      SET v_OTConversion = 2*IFNULL((SELECT OTAfter
      FROM
      PayrollSetup
      WHERE
      UPPER(CompanyID) = UPPER(v_CompanyID)
      AND UPPER(DivisionID) = UPPER(v_DivisionID)
      AND UPPER(DepartmentID) = UPPER(v_DepartmentID)),0);
   ELSE
      SET v_OTConversion = IFNULL((SELECT  OTAfter
      FROM
      PayrollSetup
      WHERE
      UPPER(CompanyID) = UPPER(v_CompanyID)
      AND UPPER(DivisionID) = UPPER(v_DivisionID)
      AND UPPER(DepartmentID) = UPPER(v_DepartmentID)),0);
   end if;

   IF (v_LastHours > v_OTConversion) then
	
      SET v_OT = v_LastHours -v_OTConversion;
      SET v_Regular = v_OTConversion;
   ELSE
      SET v_Regular = v_LastHours;
      SET v_OT = 0;
   end if;

   SET SWP_Ret_Value = 0;
END