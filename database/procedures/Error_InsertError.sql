CREATE PROCEDURE Error_InsertError (v_CompanyID NATIONAL VARCHAR(36),
 	v_DivisionID NATIONAL VARCHAR(36),
 	v_DepartmentID NATIONAL VARCHAR(36),
	v_ProcedureName NATIONAL VARCHAR(50),
 	v_Error NATIONAL VARCHAR(200),
 	INOUT v_ErrorID INT) BEGIN
	SET @RetValue = 1;
	CALL Error_InsertError2(v_CompanyID, v_DivisionID, v_DepartmentID, v_ProcedureName, v_Error, v_ErrorID, 0, NULL, @RetValue);
		
END