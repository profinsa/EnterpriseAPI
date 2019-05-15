DELIMITER //
DROP PROCEDURE IF EXISTS FixedAssetDepreciation_Post;
//
CREATE                   PROCEDURE FixedAssetDepreciation_Post(v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_AssetID NATIONAL VARCHAR(36),
	INOUT v_PostAsset INT ,INOUT SWP_Ret_Value INT)
   SWL_return:
BEGIN















/*
Name of stored procedure: FixedAssetDepreciation_Post
Method: 
	This store procedure will calculate the depreciation 
	and post related data into general ledger

Date Created: EDE - 07/28/2015

Input Parameters:

	@CompanyID NVARCHAR(36)		 - the ID of the company
	@DivisionID NVARCHAR(36)	 - the ID of the division
	@DepartmentID NVARCHAR(36)	 - the ID of the department
	@AssetID NVARCHAR(36)		 - the ID of fixed asset

Output Parameters:

	@PostAsset INT 

Called From:

	FixedAssetDepreciation_PostAll, FixedAssetDepreciation_Post.vb

Calls:

	LedgerMain_CurrentPeriod, LedgerMain_VerifyPeriod, FixedAssetDepreciation_CreateGLTransaction, Error_InsertError

Last Modified: 

Last Modified By: 

Revision History: 

*/

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
	GET DIAGNOSTICS CONDITION 1
         @p1 = RETURNED_SQLSTATE, @p2 = MESSAGE_TEXT;
	  SELECT @p1, @p2;
      SET @SWV_Error = 1;
   END;
   WriteError:
   BEGIN
      SET @SWV_Error = 0;
      SET v_PostAsset = 1;
      START TRANSACTION; -- transaction

      select   AssetDepreciationMethodID, DepreciationPeriod, IFNULL(AssetOriginalCost,0), IFNULL(AssetSalvageValue,0), IFNULL(AssetUsefulLife,0), AssetInServiceDate, IFNULL(LastDepreciationDate,AssetInServiceDate), IFNULL(AccumulatedDepreciation,0), DepreciationPeriod, AssetAcutalDisposalDate, IFNULL(AssetStatusID,N'') INTO v_AssetDepreciationMethodID,v_DepreciationPeriod,v_AssetOriginalCost,v_AssetSalvageValue,
      v_AssetUsefulLife,v_AssetInServiceDate,v_LastDepreciationDate,
      v_AccumulatedDepreciation,v_DepreciationPeriod,v_AssetAcutalDisposalDate,
      v_AssetStatusID FROM FixedAssets WHERE
      CompanyID = v_CompanyID
      AND DivisionID = v_DivisionID
      AND DepartmentID = v_DepartmentID
      AND AssetID = v_AssetID;

-- We will use current date without time part as default transaction date
      SET v_TransDate = STR_TO_DATE(DATE_FORMAT(CURRENT_TIMESTAMP,'%Y-%m-%d'),'%Y-%m-%d'); 


-- check if asset is not already disposed and needed fields are populated
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

         SET v_ErrorMessage = 'Asset Accumulated Depreciation achieved Asset Original Cost already. Asset can''t be depreciated, it can be disposed instead.';
         LEAVE WriteError;
      end if;	

		
-- check to meke sure we don't depreciate the same asset
      IF v_DepreciationPeriod = 'Y' then -- Yearly

         IF v_LastDepreciationDate <> v_AssetInServiceDate AND TIMESTAMPDIFF(year,v_LastDepreciationDate,v_TransDate) <= 0 then
	
            SET v_ErrorMessage = 'Cannot depreciate asset twice in the same year';
            LEAVE WriteError;
         end if;
         BEGIN
            SET v_TransDate = TIMESTAMPADD(year,1,v_LastDepreciationDate);
         END;
      end if;
      IF v_DepreciationPeriod = 'Q' then -- Quarterly

         IF v_LastDepreciationDate <> v_AssetInServiceDate AND TIMESTAMPDIFF(quarter,v_LastDepreciationDate,v_TransDate) <= 0 then
	
            SET v_ErrorMessage = 'Cannot depreciate asset twice in the same quarter';
            LEAVE WriteError;
         ELSE
            SET v_TransDate = TIMESTAMPADD(quarter,1,v_LastDepreciationDate);
         end if;
      end if;
      IF v_DepreciationPeriod = 'M' then -- Monthly

         IF v_LastDepreciationDate <> v_AssetInServiceDate AND TIMESTAMPDIFF(month,v_LastDepreciationDate,v_TransDate) <= 0 then
	
            SET v_ErrorMessage = 'Cannot depreciate asset twice in the same nonth';
            LEAVE WriteError;
         end if;
         BEGIN
            SET v_TransDate = TIMESTAMPADD(month,1,v_LastDepreciationDate);
         END;
      end if;
      IF v_DepreciationPeriod = 'P' then -- Period

	
         CALL LedgerMain_CurrentPeriod2(v_CompanyID,v_DivisionID,v_DepartmentID,v_CurrentPeriod,v_PeriodStartDate,
         v_PeriodEndDate, v_ReturnStatus);
         IF v_ReturnStatus <> 0 then -- fail to receive current Period
	
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

-- Verify the time Period (make a call to the enterprise.LedgerMain_VerifyPeriod stored procedure)
      CALL LedgerMain_VerifyPeriod2(v_CompanyID,v_DivisionID,v_DepartmentID,v_TransDate,v_PeriodToPost,v_PeriodClosed, v_ReturnStatus);
      IF v_PeriodClosed <> 0 then

         SET v_ErrorMessage = 'Period for asset posting closed ';
         LEAVE WriteError;
      end if;	

-- In case of an error we go to the error handling routine
      IF v_ReturnStatus = -1 then

         SET v_ErrorMessage = 'Procedure call LedgerMain_VerifyPeriod failed';
         LEAVE WriteError;
      end if;
      select   IFNULL(CurrencyID,N'') INTO v_CompanyCurrencyID FROM Companies WHERE CompanyID = v_CompanyID AND
      DivisionID = v_DivisionID AND
      DepartmentID = v_DepartmentID   LIMIT 1;


-- we will calculate depreciation
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

-- we calculate the depreciation usind the Sum of Year method
-- FIB()=AssetUsefulLife+(AssetUsefulLife-1)+(AssetUsefulLife-2)+...+0=(AssetUsefulLife*(AssetUsefulLife+1))/2
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


-- Calculate @AccumulatedDepreciation that should be posted to GL
      IF v_AccumulatedDepreciation+v_DepreciationAmount > v_AssetOriginalCost then
         SET v_DepreciationAmount = v_AssetOriginalCost -v_AccumulatedDepreciation;
      end if;
      IF v_DepreciationAmount < 0 then
         SET v_DepreciationAmount = 0;
      end if;
      SET v_AccumulatedDepreciation = v_AccumulatedDepreciation+v_DepreciationAmount;


-- Post depreciation to general ledger
      SET @SWV_Error = 0;
      CALL FixedAssetDepreciation_CreateGLTransaction(v_CompanyID,v_DivisionID,v_DepartmentID,v_AssetID,v_DepreciationAmount,
      v_TransDate, v_ReturnStatus);
      IF v_ReturnStatus <> 0 OR @SWV_Error <> 0 then
	
         SET v_ErrorMessage = 'Call FixedAssetDepreciation_CreateGLTransaction2 failed';
         LEAVE WriteError;
      end if;


-- we update Fixed Assets table with data just calculated
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

-- the error handler
   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'FixedAssetDepreciation_Post',
   v_ErrorMessage,v_ErrorID);
END;


















//

DELIMITER ;

DELIMITER //
DROP PROCEDURE IF EXISTS FixedAssetDepreciation_CreateGLTransaction;
//
CREATE                   PROCEDURE FixedAssetDepreciation_CreateGLTransaction(v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_AssetID NATIONAL VARCHAR(36),
	v_DepreciationAmount DECIMAL(19,4),
	v_TransDate DATETIME,INOUT SWP_Ret_Value INT)
   SWL_return:
BEGIN


/*
Name of stored procedure: FixedAssetDepreciation_CreateGLTransaction
Method: 
	Posts Depreciation Amount into General Ledger

Date Created: EDE - 07/28/2015

Input Parameters:

	@CompanyID NVARCHAR(36)		 - the ID of the company
	@DivisionID NVARCHAR(36)	 - the ID of the division
	@DepartmentID NVARCHAR(36)	 - the ID of the department
	@AssetID NVARCHAR(36)		 - the ID of the fixed asset
	@DepreciationAmount Money	 - amoutn to be post
	@TransDate DATETIME		 - date of the depreciation

Output Parameters:

	NONE

Called From:

	FixedAssetDepreciation_Post

Calls:

	VerifyCurrency, GetNextEntityID, LedgerTransactions_PostCOA_AllRecords, Error_InsertError

Last Modified: 

Last Modified By: 

Revision History: 

*/

   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);

   DECLARE v_CurrencyID NATIONAL VARCHAR(36);
   DECLARE v_CompanyCurrencyID NATIONAL VARCHAR(36);
   DECLARE v_CurrencyExchangeRate FLOAT;
   DECLARE v_GLTransactionNumber NATIONAL VARCHAR(36);
   DECLARE v_GLFixedDepreciationAccount NATIONAL VARCHAR(36);
   DECLARE v_GLFixedAccumDepreciationAccount NATIONAL VARCHAR(36);
   DECLARE v_GLAssetAccount NATIONAL VARCHAR(36);
   DECLARE v_VendorID NATIONAL VARCHAR(50);
   DECLARE v_Posted BOOLEAN;

   DECLARE v_PostDate NATIONAL VARCHAR(1);
   DECLARE v_ConvertedDepreciationAmount DECIMAL(19,4);
   DECLARE v_ErrorID INT;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
	GET DIAGNOSTICS CONDITION 1
         @p1 = RETURNED_SQLSTATE, @p2 = MESSAGE_TEXT;
	  SELECT @p1, @p2;
       SET @SWV_Error = 1;
   END;
   SET @SWV_Error = 0;
   IF IFNULL(v_DepreciationAmount,0) = 0 then
      SET SWP_Ret_Value = 1;
      LEAVE SWL_return;
   end if;

   START TRANSACTION; -- transaction

   select   GLFixedAccumDepreciationAccount, GLFixedAssetAccount, CurrencyID, CurrencyExchangeRate, VendorID, Posted INTO v_GLFixedAccumDepreciationAccount,v_GLAssetAccount,v_CurrencyID,v_CurrencyExchangeRate,
   v_VendorID,v_Posted FROM FixedAssets WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND AssetID = v_AssetID;

   IF IFNULL(v_Posted,0) = 0 then

	-- the procedure will return an error code
      SET v_ErrorMessage = 'You should book asset before depreciate it';
      ROLLBACK;

-- the error handler
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'FixedAssetDepreciate_CreateGLTransaction',
      v_ErrorMessage,v_ErrorID);
      SET SWP_Ret_Value = 1;
   end if;

   IF v_GLFixedAccumDepreciationAccount IS NULL then

	-- the procedure will return an error code
      SET v_ErrorMessage = 'GL Fixed Accum Depreciation Account is not defined';
      ROLLBACK;

-- the error handler
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'FixedAssetDepreciate_CreateGLTransaction',
      v_ErrorMessage,v_ErrorID);
      SET SWP_Ret_Value = 1;
   end if;

   IF v_GLAssetAccount IS NULL then

	-- the procedure will return an error code
      SET v_ErrorMessage = 'GL Asset Account is not defined';
      ROLLBACK;

-- the error handler
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'FixedAssetDepreciate_CreateGLTransaction',
      v_ErrorMessage,v_ErrorID);
      SET SWP_Ret_Value = 1;
   end if;

   SET @SWV_Error = 0;
   CALL VerifyCurrency2(v_CompanyID,v_DivisionID,v_DepartmentID,v_TransDate,0,v_CompanyCurrencyID,
   v_CurrencyID,v_CurrencyExchangeRate);
   IF @SWV_Error <> 0 then

	-- the procedure will return an error code
      SET v_ErrorMessage = 'Currency retrieving failed';
      ROLLBACK;

-- the error handler
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'FixedAssetDepreciate_CreateGLTransaction',
      v_ErrorMessage,v_ErrorID);
      SET SWP_Ret_Value = 1;
   end if;

   select   IFNULL(DefaultGLPostingDate,'1'), GLFixedDepreciationAccount INTO v_PostDate,v_GLFixedDepreciationAccount FROM
   Companies WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID;


   SET @SWV_Error = 0;
   CALL GetNextEntityID2(v_CompanyID,v_DivisionID,v_DepartmentID,'NextGLTransNumber',v_GLTransactionNumber, v_ReturnStatus);
   IF v_ReturnStatus <> 0 OR @SWV_Error <> 0 then
	
      SET v_ErrorMessage = 'Call enterprise.GetNextEntityID failed';
      ROLLBACK;

-- the error handler
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'FixedAssetDepreciate_CreateGLTransaction',
      v_ErrorMessage,v_ErrorID);
      SET SWP_Ret_Value = 1;
   end if;

   SET v_ConvertedDepreciationAmount = fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,v_DepreciationAmount*v_CurrencyExchangeRate, 
   v_CompanyCurrencyID);
-- we insert a new transaction into LedgerTransactions table

   SET @SWV_Error = 0;
   INSERT INTO LedgerTransactions(CompanyID,
	DivisionID,
	DepartmentID,
	GLTransactionNumber,
	GLTransactionTypeID,
	GLTransactionDate,
	GLTransactionDescription,
	GLTransactionReference,
	GLTransactionSource,
	GLTransactionAmount,
	GLTransactionPostedYN,
	GLTransactionBalance,
	GLTransactionSystemGenerated,
	CurrencyID,
	CurrencyExchangeRate)
VALUES(v_CompanyID,
	v_DivisionID,
	v_DepartmentID,
	v_GLTransactionNumber,
	'Depreciation',
	CASE v_PostDate WHEN '1' THEN CURRENT_TIMESTAMP ELSE v_TransDate END,
	v_VendorID,
	v_AssetID,
	CONCAT('DEPR ', cast(v_AssetID as char(10))),
	v_DepreciationAmount,
	1,
	0,
	1,
	v_CurrencyID,
	v_CurrencyExchangeRate);





   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'INSERT INTO LedgerTransactions failed';
      ROLLBACK;

-- the error handler
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'FixedAssetDepreciate_CreateGLTransaction',
      v_ErrorMessage,v_ErrorID);
      SET SWP_Ret_Value = 1;
   end if;

-- we debit GLFixedAccumDepreciationAccount
   SET @SWV_Error = 0;
   INSERT INTO LedgerTransactionsDetail(CompanyID,
	DivisionID,
	DepartmentID,
	GLTransactionNumber,
	GLTransactionAccount,
	GLDebitAmount,
	GLCreditAmount)
VALUES(v_CompanyID,
	v_DivisionID,
	v_DepartmentID,
	v_GLTransactionNumber,
	v_GLFixedAccumDepreciationAccount,
	v_ConvertedDepreciationAmount,
	0);




   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'INSERT INTO LedgerTransactionsDetail failed';
      ROLLBACK;

-- the error handler
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'FixedAssetDepreciate_CreateGLTransaction',
      v_ErrorMessage,v_ErrorID);
      SET SWP_Ret_Value = 1;
   end if;

-- we credit GLFixedAccumDepreciationAccount
   SET @SWV_Error = 0;
   INSERT INTO LedgerTransactionsDetail(CompanyID,
	DivisionID,
	DepartmentID,
	GLTransactionNumber,
	GLTransactionAccount,
	GLDebitAmount,
	GLCreditAmount)
VALUES(v_CompanyID,
	v_DivisionID,
	v_DepartmentID,
	v_GLTransactionNumber,
	v_GLAssetAccount,
	0,
	v_ConvertedDepreciationAmount);




   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'INSERT INTO LedgerTransactionsDetail failed';
      ROLLBACK;

-- the error handler
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'FixedAssetDepreciate_CreateGLTransaction',
      v_ErrorMessage,v_ErrorID);
      SET SWP_Ret_Value = 1;
   end if;


/*
update the information in the Ledger Chart of Accounts for the accounts of the newly inserted transaction

parameters	@CompanyID NVARCHAR(36),
		@DivisionID NVARCHAR(36),
		@DepartmentID NVARCHAR(36),
		@GLTransNumber NVARCHAR (36)
		used to identify the TRANSACTION
		@PostCOA BIT - used in the process of creation of the transaction
*/
   SET @SWV_Error = 0;
   CALL LedgerTransactions_PostCOA_AllRecords2(v_CompanyID,v_DivisionID,v_DepartmentID,v_GLTransactionNumber, v_ReturnStatus);
   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then

      SET v_ErrorMessage = 'LedgerTransactions_PostCOA_AllRecords call failed';
      ROLLBACK;

-- the error handler
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'FixedAssetDepreciate_CreateGLTransaction',
      v_ErrorMessage,v_ErrorID);
      SET SWP_Ret_Value = 1;
   end if;


   COMMIT;
   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;



   ROLLBACK;

-- the error handler
   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'FixedAssetDepreciate_CreateGLTransaction',
   v_ErrorMessage,v_ErrorID);


   SET SWP_Ret_Value = 1;
END;






//

DELIMITER ;
