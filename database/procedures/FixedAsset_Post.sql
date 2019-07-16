CREATE PROCEDURE FixedAsset_Post (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_AssetID NATIONAL VARCHAR(36),
	INOUT v_PostAsset INT ,INOUT SWP_Ret_Value INT) SWL_return:
BEGIN

















   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);

   DECLARE v_AssetOriginalCost DECIMAL(19,4);
   DECLARE v_AssetSalvageValue DECIMAL(19,4);
   DECLARE v_Posted BOOLEAN;
   DECLARE v_TransDate DATETIME;
   DECLARE v_PeriodClosed INT;
   DECLARE v_PeriodToPost INT;
   DECLARE v_AssetStatusID NATIONAL VARCHAR(36);
   DECLARE v_AssetAcutalDisposalDate DATETIME;

   DECLARE v_ErrorID INT;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
   END;
   WriteError:
   BEGIN
      SET @SWV_Error = 0;
      SET v_PostAsset = 1;
      select   IFNULL(Posted,0), IFNULL(AssetOriginalCost,0) INTO v_Posted,v_AssetOriginalCost FROM FixedAssets WHERE
      CompanyID = v_CompanyID
      AND DivisionID = v_DivisionID
      AND DepartmentID = v_DepartmentID
      AND AssetID = v_AssetID;


      SET v_TransDate = STR_TO_DATE(DATE_FORMAT(CURRENT_TIMESTAMP,'%Y-%m-%d'),'%Y-%m-%d'); 




      IF	v_Posted = 1 then

         SET SWP_Ret_Value = 0;
         LEAVE SWL_return;
      end if;
      START TRANSACTION; 

      IF	IFNULL(v_AssetOriginalCost,0) <= 0 then

         SET v_ErrorMessage = 'Asset Original Cost must be > 0';
         LEAVE WriteError;
      end if;	

		


      CALL LedgerMain_VerifyPeriod2(v_CompanyID,v_DivisionID,v_DepartmentID,v_TransDate,v_PeriodToPost,v_PeriodClosed, v_ReturnStatus);
      IF v_PeriodClosed <> 0 then

         SET v_ErrorMessage = 'Period for asset posting closed ';
         LEAVE WriteError;
      end if;	


      IF v_ReturnStatus = -1 then

         SET v_ErrorMessage = 'Procedure call LedgerMain_VerifyPeriod failed';
         LEAVE WriteError;
      end if;


      SET @SWV_Error = 0;
      CALL FixedAsset_CreateGLTransaction(v_CompanyID,v_DivisionID,v_DepartmentID,v_AssetID,v_TransDate, v_ReturnStatus);
      IF v_ReturnStatus <> 0 OR @SWV_Error <> 0 then
	
         SET v_ErrorMessage = 'Call FixedAsset_CreateGLTransaction failed';
         LEAVE WriteError;
      end if;



      SET @SWV_Error = 0;
      UPDATE FixedAssets
      SET
      Posted = 1
      WHERE
      CompanyID = v_CompanyID
      AND DivisionID = v_DivisionID
      AND DepartmentID = v_DepartmentID
      AND AssetID = v_AssetID;
      IF @SWV_Error <> 0 then

         SET v_ErrorMessage = 'UPDATE FixedAssets failed';
         LEAVE WriteError;
      end if;
      COMMIT;
      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;
   END;
   SET v_PostAsset = 0;
   ROLLBACK;


   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'FixedAsset_Post',v_ErrorMessage,
   v_ErrorID);
END