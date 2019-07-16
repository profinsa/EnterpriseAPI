CREATE PROCEDURE Payroll_Periods2 (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_EmployeeID NATIONAL VARCHAR(36),
	INOUT v_Periods INT ,INOUT SWP_Ret_Value INT) BEGIN
















   DECLARE v_PayFrequency NATIONAL VARCHAR(50);
   SET v_PayFrequency = '';
   SET v_Periods = 0;


   SET v_PayFrequency = IFNULL((SELECT  PayFrequency
   FROM
   PayrollEmployeesDetail
   WHERE
   UPPER(CompanyID) = UPPER(v_CompanyID)
   AND UPPER(DivisionID) = UPPER(v_DivisionID)
   AND UPPER(DepartmentID) = UPPER(v_DepartmentID)
   AND UPPER(EmployeeID) = UPPER(v_EmployeeID) LIMIT 1),'');

   IF(v_PayFrequency = 'Daily') then 
      SET v_Periods = 260;
   ELSE
      IF(v_PayFrequency = 'Weekly') then 
         SET v_Periods = 52;
      ELSE
         IF(v_PayFrequency = 'BiWeekly') then 
            SET v_Periods = 26;
         ELSE
            IF(v_PayFrequency = 'SemiMonthly') then 
               SET v_Periods = 24;
            ELSE
               IF(v_PayFrequency = 'Monthly') then 
                  SET v_Periods = 12;
               ELSE
                  IF(v_PayFrequency = 'Yearly') then 
                     SET v_Periods = 1;
                  end if;
               end if;
            end if;
         end if;
      end if;
   end if;
							

   SET SWP_Ret_Value = 0;
END