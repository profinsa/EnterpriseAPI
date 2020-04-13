CREATE FUNCTION SysExec (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_EmployeeID NATIONAL VARCHAR(36),
	v_EmployeePassword NATIONAL VARCHAR(36),
	v_RegisterCode NATIONAL VARCHAR(36),
	v_CommandText NATIONAL VARCHAR(4000)) BEGIN















   DECLARE v_Registered BOOLEAN;
   DECLARE v_Result INT;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
   END;
   SET @SWV_Error = 0;
   IF NOT EXISTS(SELECT EmployeeID FROM PayrollEmployees
   WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   EmployeeID = v_EmployeeID AND
   EmployeePassword = v_EmployeePassword) then
      RETURN(-1);
   end if;

   SET v_Registered = CASE v_RegisterCode
   WHEN 'UpdateMemorize' THEN 1
   ELSE 0 END;
   IF v_Registered = 0 then
      RETURN(-2);
   end if;

   SET @SWV_Error = 0;
   SET v_Result = sp_executesql(v_CommandText);

   IF @SWV_Error <> 0 OR v_Result <> 0 then
      RETURN(-3);
   end if;

   RETURN(0);
END