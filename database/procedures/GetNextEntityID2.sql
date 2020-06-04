CREATE PROCEDURE GetNextEntityID2 (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_Entity NATIONAL VARCHAR(50),
	INOUT v_EntityID NATIONAL VARCHAR(36)  ,INOUT SWP_Ret_Value INT) SWL_return:
BEGIN









   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);

   DECLARE v_nextid INT;
   DECLARE v_ErrorID INT;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN

  

      SET @SWV_Error = 1;
   END;
   SET @SWV_Error = 0;
   START TRANSACTION;

   select   NextNumberValue, IFNULL(cast(NextNumberValue as SIGNED INTEGER),0) INTO v_EntityID,v_nextid FROM CompaniesNextNumbers WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   NextNumberName = v_Entity;

   SET v_nextid = v_nextid+1;

   SET @SWV_Error = 0;
   UPDATE CompaniesNextNumbers
   SET NextNumberValue = CAST(v_nextid AS CHAR(30))
   WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   NextNumberName = v_Entity;


   IF @SWV_Error <> 0 then

      SET v_EntityID = N'';
      SET v_ErrorMessage = 'CompaniesNextNumbers update failed';
      ROLLBACK;

      CALL Error_InsertError(v_CompanyID,'','','GetNextEntityID',v_ErrorMessage,v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,'','',v_ErrorID,'Entity',v_Entity);
      SET SWP_Ret_Value = -1;
   end if;



   COMMIT;


   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;








   ROLLBACK;

   CALL Error_InsertError(v_CompanyID,'','','GetNextEntityID',v_ErrorMessage,v_ErrorID);

   CALL Error_InsertErrorDetail(v_CompanyID,'','',v_ErrorID,'Entity',v_Entity);

   SET SWP_Ret_Value = -1;
END