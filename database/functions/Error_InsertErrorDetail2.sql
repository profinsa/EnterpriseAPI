CREATE FUNCTION Error_InsertErrorDetail2 (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_ErrorID INT,
	v_ParameterName NATIONAL VARCHAR(50),
	v_ParameterValue NATIONAL VARCHAR(50),
	v_IsRaise BOOLEAN) BEGIN







   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
   END;
   IF v_IsRaise is null then
      set v_IsRaise = 1;
   END IF;
   SET @SWV_Error = 0;
   IF v_IsRaise = 1 then
	
      

SET @SWV_Null_Var = 0;
   ELSE
		
      SET @SWV_Error = 0;
      INSERT INTO ErrorLogDetail(CompanyID,
			DivisionID,
			DepartmentID,
			ErrorID,
			ParameterName,
			ParameterValue)
		VALUES(v_CompanyID,
			v_DivisionID,
			v_DepartmentID,
			v_ErrorID,
			v_ParameterName,
			v_ParameterValue);
		
		
		
      IF @SWV_Error <> 0 then
		
         RETURN -1;
      end if;
   end if;


   RETURN 0;
END