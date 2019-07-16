CREATE PROCEDURE GetNextCheckNumber (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_GLBankAccount NATIONAL VARCHAR(36),
	INOUT v_EntityID INT  ,INOUT SWP_Ret_Value INT) SWL_return:
BEGIN














   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);
   DECLARE v_nextid INT;

   DECLARE v_ErrorID INT;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
   END;
   SET @SWV_Error = 0;
   SET v_EntityID = 0;

   select   IFNULL(NextCheckNumber,0) INTO v_EntityID FROM
   BankAccounts WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   GLBankAccount = v_GLBankAccount   LIMIT 1;


   IF v_EntityID = 0 then

      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;
   end if;

   SET v_nextid = v_EntityID+1;

   START TRANSACTION;



   SET @SWV_Error = 0;
   UPDATE
   BankAccounts
   SET
   NextCheckNumber = v_nextid
   WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   GLBankAccount = v_GLBankAccount;


   IF @SWV_Error <> 0 then

      SET v_EntityID = N'';
      SET v_ErrorMessage = 'BankAccounts update failed';
      ROLLBACK;

      CALL Error_InsertError(v_CompanyID,'','','GetNextCheckNumber',v_ErrorMessage,v_ErrorID);
      SET SWP_Ret_Value = -1;
   end if;


   COMMIT;
   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;








   ROLLBACK;

   CALL Error_InsertError(v_CompanyID,'','','GetNextCheckNumber',v_ErrorMessage,v_ErrorID);

   SET SWP_Ret_Value = -1;
END