CREATE PROCEDURE Invoice_CreateAssembly (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_ItemID NATIONAL VARCHAR(36),
	v_WarehouseID NATIONAL VARCHAR(36),
	v_QtyRequired INT,
	INOUT v_Result INT  ,INOUT SWP_Ret_Value INT) SWL_return:
BEGIN





   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);

   DECLARE v_NumberOfItems SMALLINT;

   DECLARE v_ErrorID INT;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
   END;
   SET @SWV_Error = 0;
   SET v_Result = 1;
   SET v_NumberOfItems = 0;


   select   COUNT(*) INTO v_NumberOfItems FROM
   InventoryAssemblies WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   AssemblyID = v_ItemID;


   IF v_NumberOfItems = 0 then

      SET v_Result = 0;
      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;
   end if;
   START TRANSACTION;

   SET @SWV_Error = 0;
   SET v_ReturnStatus = Inventory_Assemblies2(v_CompanyID,v_DivisionID,v_DepartmentID,v_ItemID,v_WarehouseID,v_QtyRequired,
   v_Result);


   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then

      SET v_Result = 0;
      SET v_ErrorMessage = 'Inventory_Assemblies call failed';
      ROLLBACK;
      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Invoice_CreateAssembly',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'ItemID',v_ItemID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'QtyRequired',v_QtyRequired);
      SET SWP_Ret_Value = -1;
   end if;


   IF v_Result <> 1 then

      SET v_Result = 0;
      ROLLBACK;
      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;
   end if;	

   COMMIT;
   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;







   ROLLBACK;
   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;

   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Invoice_CreateAssembly',v_ErrorMessage,
   v_ErrorID);

   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'ItemID',v_ItemID);
   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'QtyRequired',v_QtyRequired);

   SET SWP_Ret_Value = -1;
END