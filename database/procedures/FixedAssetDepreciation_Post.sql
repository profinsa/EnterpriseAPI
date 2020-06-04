CREATE PROCEDURE FixedAssetDepreciation_Post (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_AssetID NATIONAL VARCHAR(36),
	INOUT v_PostAsset INT ,INOUT SWP_Ret_Value INT) SWL_return:
BEGIN

















   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);

   DECLARE v_AssetDepreciationMethodID NATIONAL VARCHAR(36);
   DECLARE v_AccumulatedDepreciation DECIMAL(19,4);
   DECLARE v_AssetOriginalCost DECIMAL(19,4);
   DECLARE v_AssetSalvageValue DECIMAL(19,4);
   DECLARE v_AssetUsefulLife SMALLINT;
   DECLARE v_AssetInServiceDate DATETIME;
   DECLARE v_LastDepreciationDate DATETIME;
   DECLARE v_DepreciationPeriod NATIONAL VARCHAR(1);
   DECLARE v_DepreciationAmount DECIMAL(19,4); 
   DECLARE v_TransDate DATETIME;
   DECLARE v_PeriodClosed INT;
   DECLARE v_PeriodToPost INT;
   DECLARE v_AssetStatusID NATIONAL VARCHAR(36);
   DECLARE v_AssetAcutalDisposalDate DATETIME;

   DECLARE v_CompanyCurrencyID NATIONAL VARCHAR(3);
   DECLARE v_ErrorID INT;
   DECLARE v_CurrentPeriod INT;
   DECLARE v_PeriodStartDate DATETIME;
   DECLARE v_PeriodEndDate DATETIME;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
   END;
   WriteError:
   BEGIN
      SET @SWV_Error = 0;
      SET v_PostAsset = 1;
      START TRANSACTION; 

      select   AssetDepreciationMethodID, DepreciationPeriod, IFNULL(AssetOriginalCost,0), IFNULL(AssetSalvageValue,0), IFNULL(AssetUsefulLife,0), AssetInServiceDate, IFNULL(LastDepreciationDate,AssetInServiceDate), IFNULL(AccumulatedDepreciation,0), DepreciationPeriod, AssetAcutalDisposalDate, IFNULL(AssetStatusID,N'') INTO v_AssetDepreciationMethodID,v_DepreciationPeriod,v_AssetOriginalCost,v_AssetSalvageValue,
      v_AssetUsefulLife,v_AssetInServiceDate,v_LastDepreciationDate,
      v_AccumulatedDepreciation,v_DepreciationPeriod,v_AssetAcutalDisposalDate,
      v_AssetStatusID FROM FixedAssets WHERE
      CompanyID = v_CompanyID
      AND DivisionID = v_DivisionID
      AND DepartmentID = v_DepartmentID
      AND AssetID = v_AssetID;


      SET v_TransDate = STR_TO_DATE(DATE_FORMAT(CURRENT_TIMESTAMP,'%Y-%m-%d'),'%Y-%m-%d'); 



      IF	(v_AssetAcutalDisposalDate IS NOT NULL AND STR_TO_DATE(v_AssetAcutalDisposalDate, '%d,%m,%Y') IS NOT NULL) OR
      v_AssetStatusID = 'Disposed' then

         SET v_ErrorMessage = 'Asset is already disposed';
         LEAVE WriteError;
      end if;
      IF	IFNULL(v_AssetOriginalCost,0) <= 0 then

         SET v_ErrorMessage = 'Asset Original Cost must be > 0';
         LEAVE WriteError;
      end if;
      IF	IFNULL(v_AssetSalvageValue,0) < 0 then

         SET v_ErrorMessage = 'Asset Salvage Value must be >= 0';
         LEAVE WriteError;
      end if;
      IF	v_AssetUsefulLife <= 0 then

         SET v_ErrorMessage = 'Asset UsefulLife must be >0';
         LEAVE WriteError;
      end if;
      IF	(v_AssetInServiceDate IS NULL) then

         SET v_ErrorMessage = 'Asset In Service Date is not defined';
         LEAVE WriteError;
      end if;
      IF	(v_AccumulatedDepreciation >= v_AssetOriginalCost) then

         SET v_ErrorMessage = 'Asset Accumulated Depreciation achieved Asset Original Cost already. Asset can't be depreciated, it can be disposed instead.';
         LEAVE WriteError;
      end if;	

		

      IF v_DepreciationPeriod = 'Y' then 

         IF v_LastDepreciationDate <> v_AssetInServiceDate AND TIMESTAMPDIFF(year,v_LastDepreciationDate,v_TransDate) <= 0 then
	
            SET v_ErrorMessage = 'Cannot depreciate asset twice in the same year';
            LEAVE WriteError;
         end if;
         BEGIN
            SET v_TransDate = TIMESTAMPADD(year,1,v_LastDepreciationDate);
         END;
      end if;
      IF v_DepreciationPeriod = 'Q' then 

         IF v_LastDepreciationDate <> v_AssetInServiceDate AND TIMESTAMPDIFF(quarter,v_LastDepreciationDate,v_TransDate) <= 0 then
	
            SET v_ErrorMessage = 'Cannot depreciate asset twice in the same quarter';
            LEAVE WriteError;
         ELSE
            SET v_TransDate = TIMESTAMPADD(quarter,1,v_LastDepreciationDate);
         end if;
      end if;
      IF v_DepreciationPeriod = 'M' then 

         IF v_LastDepreciationDate <> v_AssetInServiceDate AND TIMESTAMPDIFF(month,v_LastDepreciationDate,v_TransDate) <= 0 then
	
            SET v_ErrorMessage = 'Cannot depreciate asset twice in the same nonth';
            LEAVE WriteError;
         end if;
         BEGIN
            SET v_TransDate = TIMESTAMPADD(month,1,v_LastDepreciationDate);
         END;
      end if;
      IF v_DepreciationPeriod = 'P' then 

	
         CALL LedgerMain_CurrentPeriod2(v_CompanyID,v_DivisionID,v_DepartmentID,v_CurrentPeriod,v_PeriodStartDate,
         v_PeriodEndDate, v_ReturnStatus);
         IF v_ReturnStatus <> 0 then 
	
            SET v_ErrorMessage = 'Fail to get current Period';
            LEAVE WriteError;
         end if;
         IF v_LastDepreciationDate <> v_AssetInServiceDate AND v_LastDepreciationDate >= v_PeriodStartDate AND  v_LastDepreciationDate <= v_PeriodEndDate then
	
            SET v_ErrorMessage = 'Cannot depreciate asset twice in the same Period';
            LEAVE WriteError;
         end if;
         BEGIN
            SET v_TransDate = TIMESTAMPADD(day,TIMESTAMPDIFF(day,v_PeriodEndDate,v_PeriodStartDate),
            v_LastDepreciationDate);
         END;
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
      select   IFNULL(CurrencyID,N'') INTO v_CompanyCurrencyID FROM Companies WHERE CompanyID = v_CompanyID AND
      DivisionID = v_DivisionID AND
      DepartmentID = v_DepartmentID   LIMIT 1;



      IF v_AssetDepreciationMethodID = 'Straight' then

         SET v_DepreciationAmount = fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,(v_AssetOriginalCost -v_AssetSalvageValue)/v_AssetUsefulLife, 
         v_CompanyCurrencyID);
      ELSE 
         IF v_AssetDepreciationMethodID = 'Declining' then

            SET v_DepreciationAmount = fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,(v_AssetOriginalCost -v_AccumulatedDepreciation)/(v_AssetUsefulLife*0.5),v_CompanyCurrencyID);
         ELSE 
            IF v_AssetDepreciationMethodID = 'Double Decline' then

               SET v_DepreciationAmount = fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,(v_AssetOriginalCost -v_AccumulatedDepreciation)/(v_AssetUsefulLife*0.25),v_CompanyCurrencyID);
            ELSE 
               IF v_AssetDepreciationMethodID = 'Declining 150' then

                  SET v_DepreciationAmount = fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,(v_AssetOriginalCost -v_AccumulatedDepreciation)/(v_AssetUsefulLife*0.125),v_CompanyCurrencyID);
               ELSE 
                  IF v_AssetDepreciationMethodID = 'Sum Of Years' then



                     IF (v_DepreciationPeriod = 'Y') then
                        SET v_DepreciationAmount = fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,((v_AssetOriginalCost -v_AssetSalvageValue)*(v_AssetUsefulLife -ABS(TIMESTAMPDIFF(YEAR,v_AssetInServiceDate,v_LastDepreciationDate))))/((v_AssetUsefulLife*(v_AssetUsefulLife+1))/2), 
                        v_CompanyCurrencyID);
                     ELSE
                        IF (v_DepreciationPeriod = 'Q') then 
                           SET v_DepreciationAmount = fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,((v_AssetOriginalCost -v_AssetSalvageValue)*(v_AssetUsefulLife -ABS(TIMESTAMPDIFF(MONTH,v_AssetInServiceDate,v_LastDepreciationDate))))/((v_AssetUsefulLife*(v_AssetUsefulLife+1))/2), 
                           v_CompanyCurrencyID);
                        ELSE
                           IF (v_DepreciationPeriod = 'M') then 
                              SET v_DepreciationAmount = fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,((v_AssetOriginalCost -v_AssetSalvageValue)*(v_AssetUsefulLife -ABS(TIMESTAMPDIFF(DAY,v_AssetInServiceDate,v_LastDepreciationDate))))/((v_AssetUsefulLife*(v_AssetUsefulLife+1))/2), 
                              v_CompanyCurrencyID);
                           ELSE 
                              IF(v_DepreciationPeriod = 'P') then 
                                 SET v_DepreciationAmount = fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,((v_AssetOriginalCost -v_AssetSalvageValue)*(v_AssetUsefulLife -ABS(TIMESTAMPDIFF(DAY,v_AssetInServiceDate,v_LastDepreciationDate))))/((v_AssetUsefulLife*(v_AssetUsefulLife+1))/2), 
                                 v_CompanyCurrencyID);
                              end if;
                           end if;
                        end if;
                     end if;
                  ELSE
                     SET v_ErrorMessage = 'Undefined or invalid AssetDepreciationMethodID';
                     LEAVE WriteError;
                  end if;
               end if;
            end if;
         end if;
      end if;



      IF v_AccumulatedDepreciation+v_DepreciationAmount > v_AssetOriginalCost then
         SET v_DepreciationAmount = v_AssetOriginalCost -v_AccumulatedDepreciation;
      end if;
      IF v_DepreciationAmount < 0 then
         SET v_DepreciationAmount = 0;
      end if;
      SET v_AccumulatedDepreciation = v_AccumulatedDepreciation+v_DepreciationAmount;



      SET @SWV_Error = 0;
      CALL FixedAssetDepreciation_CreateGLTransaction(v_CompanyID,v_DivisionID,v_DepartmentID,v_AssetID,v_DepreciationAmount,
      v_TransDate, v_ReturnStatus);
      IF v_ReturnStatus <> 0 OR @SWV_Error <> 0 then
	
         SET v_ErrorMessage = 'Call FixedAssetDepreciation_CreateGLTransaction2 failed';
         LEAVE WriteError;
      end if;



      SET @SWV_Error = 0;
      UPDATE FixedAssets
      SET
      LastDepreciationDate = v_TransDate,LastDepreciationAmount = v_DepreciationAmount,
      AccumulatedDepreciation = v_AccumulatedDepreciation,AssetBookValue = v_AssetOriginalCost -v_AccumulatedDepreciation
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


   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'FixedAssetDepreciation_Post',
   v_ErrorMessage,v_ErrorID);
END