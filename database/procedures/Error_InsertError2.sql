CREATE PROCEDURE Error_InsertError2 (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_ProcedureName NATIONAL VARCHAR(50),
	v_Error NATIONAL VARCHAR(200),
	INOUT v_ErrorID INT  ,
	v_IsRaise BOOLEAN ,
	v_EmployeeID NATIONAL VARCHAR(36) ,INOUT SWP_Ret_Value INT) SWL_return:
BEGIN









   DECLARE v_Context VARBINARY(128);
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
   END;
   IF v_IsRaise is null then
      set v_IsRaise = 1;
   END IF;
   IF v_EmployeeID is null then
      set v_EmployeeID = '';
   END IF;
   SET @SWV_Error = 0;
   IF v_IsRaise = 1 then
	
		
      select   context_info INTO v_Context FROM sysprocesses WHERE spid = CONNECTION_ID();
      SET v_EmployeeID = CAST(v_Context AS CHAR(36));
      





ELSE
		
      SET @SWV_Error = 0;
      INSERT INTO ErrorLog(CompanyID,
			DivisionID,
			DepartmentID,
			EmployeeID,
			ErrorDate,
			ErrorTime,
			ScreenName,
			ModuleName,
			ErrorCode,
			ErrorMessage)
		VALUES(v_CompanyID,
			v_DivisionID,
			v_DepartmentID,
			v_EmployeeID,
			CURRENT_TIMESTAMP,
			CURRENT_TIMESTAMP,
			NULL,
			v_ProcedureName,
			NULL,
			v_Error);
		
		
		
      IF @SWV_Error <> 0 then
		
         SET SWP_Ret_Value = -1;
         LEAVE SWL_return;
      end if;
      SET v_ErrorID = IDENT_CURRENT('ErrorLog');
   end if;


   SET SWP_Ret_Value = 0;
END