CREATE PROCEDURE FixedAssetDisposal_Post (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_AssetID NATIONAL VARCHAR(36),
	INOUT v_PostAsset INT ,INOUT SWP_Ret_Value INT) SWL_return:
BEGIN















   DECLARE v_Res INT;
   DECLARE v_ErrorID INT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(100);

   DECLARE v_AssetAcutalDisposalDate DATETIME;
   DECLARE v_AssetOriginalCost DECIMAL(19,4);
   DECLARE v_AccumulatedDepreciation DECIMAL(19,4);
   DECLARE v_AssetActualDisposalAmount DECIMAL(19,4);
   DECLARE v_NextGLTransNumber NATIONAL VARCHAR(36);
   DECLARE v_GLFixedDisposalAccount NATIONAL VARCHAR(36);
   DECLARE v_GLFixedAssetAccount NATIONAL VARCHAR(36);
   DECLARE v_GLFixedAccumDepreciationAccount NATIONAL VARCHAR(36);
   DECLARE v_AssetStatusID NATIONAL VARCHAR(36);
   DECLARE v_PeriodToPost INT;
   DECLARE v_PeriodToClose INT;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
   END;
   SET @SWV_Error = 0;
   SET v_PostAsset = 1;

   START TRANSACTION; 


   select   AssetAcutalDisposalDate, AccumulatedDepreciation, AssetOriginalCost, AssetActualDisposalAmount, GLFixedDisposalAccount, GLFixedAssetAccount, GLFixedAccumDepreciationAccount, AssetStatusID INTO v_AssetAcutalDisposalDate,v_AccumulatedDepreciation,v_AssetOriginalCost,
   v_AssetActualDisposalAmount,v_GLFixedDisposalAccount,v_GLFixedAssetAccount,
   v_GLFixedAccumDepreciationAccount,v_AssetStatusID FROM	FixedAssets WHERE	CompanyID = v_CompanyID AND DivisionID = v_DivisionID AND DepartmentID = v_DepartmentID AND AssetID = v_AssetID;



   IF	(v_AssetAcutalDisposalDate IS NOT NULL AND ISDATE(v_AssetAcutalDisposalDate) = 1) OR
   v_AssetStatusID = 'Disposed' then

      SET v_ErrorMessage = 'Asset is already disposed';
      ROLLBACK;
      IF v_PostAsset = 1 then
         SET v_PostAsset = 2;
      end if;

      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Fixed_AssetDisposal',v_ErrorMessage,
      v_ErrorID);
      SET SWP_Ret_Value = -1;
   end if;	

   IF	(v_AssetOriginalCost IS NULL) then

      SET v_ErrorMessage = 'Asset Original Cost is not defined';
      ROLLBACK;
      IF v_PostAsset = 1 then
         SET v_PostAsset = 2;
      end if;

      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Fixed_AssetDisposal',v_ErrorMessage,
      v_ErrorID);
      SET SWP_Ret_Value = -1;
   end if;	

   IF	(v_AssetActualDisposalAmount IS NULL) then

      SET v_ErrorMessage = 'Asset Actual Disposal Amount is not defined';
      ROLLBACK;
      IF v_PostAsset = 1 then
         SET v_PostAsset = 2;
      end if;

      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Fixed_AssetDisposal',v_ErrorMessage,
      v_ErrorID);
      SET SWP_Ret_Value = -1;
   end if;	

   IF	(v_GLFixedDisposalAccount IS NULL) then

      SET v_ErrorMessage = 'GL Fixed Disposal Account is not defined';
      ROLLBACK;
      IF v_PostAsset = 1 then
         SET v_PostAsset = 2;
      end if;

      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Fixed_AssetDisposal',v_ErrorMessage,
      v_ErrorID);
      SET SWP_Ret_Value = -1;
   end if;	

   IF	(v_GLFixedAssetAccount IS NULL) then

      SET v_ErrorMessage = 'GL Fixed Asset Account is not defined';
      ROLLBACK;
      IF v_PostAsset = 1 then
         SET v_PostAsset = 2;
      end if;

      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Fixed_AssetDisposal',v_ErrorMessage,
      v_ErrorID);
      SET SWP_Ret_Value = -1;
   end if;	

   IF	(v_GLFixedAccumDepreciationAccount IS NULL) then

      SET v_ErrorMessage = 'GL Fixed Accum Depreciation Account is not defined';
      ROLLBACK;
      IF v_PostAsset = 1 then
         SET v_PostAsset = 2;
      end if;

      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Fixed_AssetDisposal',v_ErrorMessage,
      v_ErrorID);
      SET SWP_Ret_Value = -1;
   end if;	

   SET v_AssetAcutalDisposalDate = CURRENT_TIMESTAMP;


   CALL LedgerMain_VerifyPeriod2(v_CompanyID,v_DivisionID,v_DepartmentID,v_AssetAcutalDisposalDate,v_PeriodToPost,
   v_PeriodToClose, v_Res);
   IF v_PeriodToClose <> 0 then

      SET v_PostAsset = 1;
      SET v_ErrorMessage = 'Period for asset posting closed ';
      ROLLBACK;
      IF v_PostAsset = 1 then
         SET v_PostAsset = 2;
      end if;

      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Fixed_AssetDisposal',v_ErrorMessage,
      v_ErrorID);
      SET SWP_Ret_Value = -1;
   end if;	


   IF v_Res = -1 then

      SET v_ErrorMessage = 'Procedure call LedgerMain_VerifyPeriod failed';
      ROLLBACK;
      IF v_PostAsset = 1 then
         SET v_PostAsset = 2;
      end if;

      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Fixed_AssetDisposal',v_ErrorMessage,
      v_ErrorID);
      SET SWP_Ret_Value = -1;
   end if;



   SET @SWV_Error = 0;
   CALL FixedAssetDisposal_CreateGLTransaction(v_CompanyID,v_DivisionID,v_DepartmentID,v_AssetID,v_AssetAcutalDisposalDate, v_Res);
   IF v_Res <> 0 OR @SWV_Error <> 0 then

      SET v_ErrorMessage = 'FixedAssetDisposal_CreateGLTransaction call failed';
      ROLLBACK;
      IF v_PostAsset = 1 then
         SET v_PostAsset = 2;
      end if;

      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Fixed_AssetDisposal',v_ErrorMessage,
      v_ErrorID);
      SET SWP_Ret_Value = -1;
   end if;



   UPDATE FixedAssets
   SET
   FixedAssets.AssetAcutalDisposalDate = v_AssetAcutalDisposalDate,FixedAssets.AssetStatusID = 'Disposed'
   WHERE	CompanyID = v_CompanyID AND DivisionID = v_DivisionID AND DepartmentID = v_DepartmentID AND AssetID = v_AssetID;


   COMMIT;
   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;



   ROLLBACK;
   IF v_PostAsset = 1 then
      SET v_PostAsset = 2;
   end if;

   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Fixed_AssetDisposal',v_ErrorMessage,
   v_ErrorID);

   SET SWP_Ret_Value = -1;
END