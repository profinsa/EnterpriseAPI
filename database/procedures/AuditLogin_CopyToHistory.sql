CREATE PROCEDURE AuditLogin_CopyToHistory (v_CompanyID 	NATIONAL VARCHAR(36),
	v_DivisionID 	NATIONAL VARCHAR(36),
	v_DepartmentID	NATIONAL VARCHAR(36),
	v_ToDate  DATETIME,INOUT SWP_Ret_Value INT) SWL_return:
BEGIN







   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);

   DECLARE v_ErrorID INT;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
   END;
   SET @SWV_Error = 0;
   START TRANSACTION;



   SET @SWV_Error = 0;
   INSERT INTO
   AuditLoginHistory(CompanyID,
	DivisionID,
	DepartmentID,
	EmployeeID,
	AuditID,
	LoginDateTime,
	MachineName,
	IPAddress,
	LoginType)
   SELECT
   CompanyID,
	DivisionID,
	DepartmentID,
	EmployeeID,
	AuditID,
	LoginDateTime,
	MachineName,
	IPAddress,
	LoginType
   FROM
   AuditLogin
   WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND LoginDateTime < v_ToDate
   ORDER BY
   AuditID;

   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Cannot copy AuditLogin';
      ROLLBACK;
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'AuditLogin_CopyToHistory',v_ErrorMessage,
      v_ErrorID);
      SET SWP_Ret_Value = -1;
   end if;


   SET @SWV_Error = 0;
   DELETE FROM
   AuditLogin
   WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND LoginDateTime < v_ToDate;

   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Cannot delete from AuditLogin';
      ROLLBACK;
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'AuditLogin_CopyToHistory',v_ErrorMessage,
      v_ErrorID);
      SET SWP_Ret_Value = -1;
   end if;


   COMMIT;
   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;







   ROLLBACK;

   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'AuditLogin_CopyToHistory',v_ErrorMessage,
   v_ErrorID);

   SET SWP_Ret_Value = -1;
END