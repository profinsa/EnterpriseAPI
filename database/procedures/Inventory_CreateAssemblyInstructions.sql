CREATE PROCEDURE Inventory_CreateAssemblyInstructions (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_AssemblyID NATIONAL VARCHAR(36),INOUT SWP_Ret_Value INT) SWL_return:
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

   IF NOT EXISTS(SELECT AssemblyID
   FROM InventoryAssembliesInstructions
   WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND AssemblyID = v_AssemblyID) then

      SET @SWV_Error = 0;
      INSERT INTO InventoryAssembliesInstructions(CompanyID,
		DivisionID,
		DepartmentID,
		AssemblyID,
		AssemblyLastUpdated,
		AssemblyLastUpdatedBy)
	VALUES(v_CompanyID,
		v_DivisionID,
		v_DepartmentID,
		v_AssemblyID,
		CURRENT_TIMESTAMP,
		NULL);
	
      IF @SWV_Error <> 0 then
	
	
         SET v_ErrorMessage = 'Insert into InventoryAssembliesInstructions failed';
         ROLLBACK;

         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Inventory_CreateAssemblyInstructions',
         v_ErrorMessage,v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'AssemblyID',v_AssemblyID);
         SET SWP_Ret_Value = -1;
      end if;
   end if;




   COMMIT;
   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;








   ROLLBACK;

   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Inventory_CreateAssemblyInstructions',
   v_ErrorMessage,v_ErrorID);

   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'AssemblyID',v_AssemblyID);

   SET SWP_Ret_Value = -1;
END