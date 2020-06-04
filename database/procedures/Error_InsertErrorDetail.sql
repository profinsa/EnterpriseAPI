CREATE PROCEDURE Error_InsertErrorDetail (v_CompanyID NATIONAL VARCHAR(36),
 	v_DivisionID NATIONAL VARCHAR(36),
 	v_DepartmentID NATIONAL VARCHAR(36),
	v_ErrorID INT,
	v_ParameterName NATIONAL VARCHAR(50),
	v_ParameterValue NATIONAL VARCHAR(50)) BEGIN
	SET @ret = Error_InsertErrorDetail2(v_CompanyID, v_DivisionID, v_DepartmentID, v_ErrorID, v_ParameterName, v_ParameterValue, 0);
		
END