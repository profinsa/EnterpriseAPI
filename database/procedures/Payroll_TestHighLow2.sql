CREATE PROCEDURE Payroll_TestHighLow2 (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_EmployeeID NATIONAL VARCHAR(36),
	INOUT v_HighLow INT ,INOUT SWP_Ret_Value INT) SWL_return:
BEGIN


























   DECLARE v_YTDGROSS FLOAT;
   DECLARE v_WageLow FLOAT;
   DECLARE v_WageHigh FLOAT;
   SET v_YTDGROSS = IFNULL((SELECT  YearToDateGross
   FROM         PayrollEmployeesDetail
   WHERE
   UPPER(CompanyID) = UPPER(v_CompanyID)
   AND UPPER(DivisionID) = UPPER(v_DivisionID)
   AND UPPER(DepartmentID) = UPPER(v_DepartmentID)
   AND UPPER(EmployeeID) = UPPER(v_EmployeeID) LIMIT 1),0);

   SET v_WageLow = IFNULL((SELECT  WageLow
   FROM         PayrollItems
   WHERE
   UPPER(CompanyID) = UPPER(v_CompanyID)
   AND UPPER(DivisionID) = UPPER(v_DivisionID)
   AND UPPER(DepartmentID) = UPPER(v_DepartmentID)
   AND UPPER(EmployeeID) = UPPER(v_EmployeeID) LIMIT 1),0);

   SET v_WageHigh = IFNULL((SELECT  WageHigh
   FROM         PayrollItems
   WHERE
   UPPER(CompanyID) = UPPER(v_CompanyID)
   AND UPPER(DivisionID) = UPPER(v_DivisionID)
   AND UPPER(DepartmentID) = UPPER(v_DepartmentID)
   AND UPPER(EmployeeID) = UPPER(v_EmployeeID) LIMIT 1),0);

 
   If (v_YTDGROSS >= v_WageLow) then

      If (v_WageHigh <> 0) then
	
         If (v_YTDGROSS >= v_WageHigh) then
		
            SET v_HighLow = 0;
            SET SWP_Ret_Value = 0;
            LEAVE SWL_return;
         end if;
      end if;
   ELSE
      SET v_HighLow = 0;
      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;
   end if;
   SET v_HighLow = 1;


   SET SWP_Ret_Value = 0;
END