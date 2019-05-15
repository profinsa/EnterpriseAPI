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

DELIMITER //
DROP PROCEDURE IF EXISTS FixedAssetDisposal_Post;
//
CREATE           PROCEDURE FixedAssetDisposal_Post(v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_AssetID NATIONAL VARCHAR(36),
	INOUT v_PostAsset INT ,INOUT SWP_Ret_Value INT)
   SWL_return:
BEGIN













/*
Name of stored procedure: FixedAssetDisposal_Post
Method: 
	Performs all needed checks and posts disposal data to General Ledger

Date Created: EDE - 07/28/2015

Input Parameters:

	@CompanyID NVARCHAR(36)		 - the ID of the company
	@DivisionID NVARCHAR(36)	 - the ID of the division
	@DepartmentID NVARCHAR(36)	 - the ID of the department
	@AssetID NVARCHAR(36)		 - the ID of the fixed asset

Output Parameters:

	@PostAsset INT 

Called From:

	FixedAssetDisposal_Post.vb

Calls:

	LedgerMain_VerifyPeriod, FixedAssetDisposal_CreateGLTransaction, Error_InsertError

Last Modified: 

Last Modified By: 

Revision History: 

*/

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

   START TRANSACTION; -- transaction

-- get asset values that should be validated before posting
   select   AssetAcutalDisposalDate, AccumulatedDepreciation, AssetOriginalCost, AssetActualDisposalAmount, GLFixedDisposalAccount, GLFixedAssetAccount, GLFixedAccumDepreciationAccount, AssetStatusID INTO v_AssetAcutalDisposalDate,v_AccumulatedDepreciation,v_AssetOriginalCost,
   v_AssetActualDisposalAmount,v_GLFixedDisposalAccount,v_GLFixedAssetAccount,
   v_GLFixedAccumDepreciationAccount,v_AssetStatusID FROM	FixedAssets WHERE	CompanyID = v_CompanyID AND DivisionID = v_DivisionID AND DepartmentID = v_DepartmentID AND AssetID = v_AssetID;


-- check if asset is not already disposed and needed fields are populated
   IF	(v_AssetAcutalDisposalDate IS NOT NULL AND ISDATE(v_AssetAcutalDisposalDate) = 1) OR
   v_AssetStatusID = 'Disposed' then

      SET v_ErrorMessage = 'Asset is already disposed';
      ROLLBACK;
      IF v_PostAsset = 1 then
         SET v_PostAsset = 2;
      end if;
-- the error handler
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
-- the error handler
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
-- the error handler
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
-- the error handler
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
-- the error handler
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
-- the error handler
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Fixed_AssetDisposal',v_ErrorMessage,
      v_ErrorID);
      SET SWP_Ret_Value = -1;
   end if;	

   SET v_AssetAcutalDisposalDate = CURRENT_TIMESTAMP;

-- Verify the time Period (make a call to the enterprise.LedgerMain_VerifyPeriod stored procedure)
   CALL LedgerMain_VerifyPeriod2(v_CompanyID,v_DivisionID,v_DepartmentID,v_AssetAcutalDisposalDate,v_PeriodToPost,
   v_PeriodToClose, v_Res);
   IF v_PeriodToClose <> 0 then

      SET v_PostAsset = 1;
      SET v_ErrorMessage = 'Period for asset posting closed ';
      ROLLBACK;
      IF v_PostAsset = 1 then
         SET v_PostAsset = 2;
      end if;
-- the error handler
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Fixed_AssetDisposal',v_ErrorMessage,
      v_ErrorID);
      SET SWP_Ret_Value = -1;
   end if;	

-- In case of an error we go to the error handling routine
   IF v_Res = -1 then

      SET v_ErrorMessage = 'Procedure call LedgerMain_VerifyPeriod failed';
      ROLLBACK;
      IF v_PostAsset = 1 then
         SET v_PostAsset = 2;
      end if;
-- the error handler
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Fixed_AssetDisposal',v_ErrorMessage,
      v_ErrorID);
      SET SWP_Ret_Value = -1;
   end if;


-- Post disposed asset data to GL
   SET @SWV_Error = 0;
   CALL FixedAssetDisposal_CreateGLTransaction(v_CompanyID,v_DivisionID,v_DepartmentID,v_AssetID,v_AssetAcutalDisposalDate, v_Res);
   IF v_Res <> 0 OR @SWV_Error <> 0 then

      SET v_ErrorMessage = 'FixedAssetDisposal_CreateGLTransaction call failed';
      ROLLBACK;
      IF v_PostAsset = 1 then
         SET v_PostAsset = 2;
      end if;
-- the error handler
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Fixed_AssetDisposal',v_ErrorMessage,
      v_ErrorID);
      SET SWP_Ret_Value = -1;
   end if;


-- Update disposal date to prevent further asset disposal posting
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
-- the error handler
   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Fixed_AssetDisposal',v_ErrorMessage,
   v_ErrorID);

   SET SWP_Ret_Value = -1;
END;







//

DELIMITER ;

DELIMITER //
DROP PROCEDURE IF EXISTS FixedAssetDisposal_CreateGLTransaction;
//
CREATE PROCEDURE FixedAssetDisposal_CreateGLTransaction(v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_AssetID NATIONAL VARCHAR(36),
	v_AssetAcutalDisposalDate DATETIME,INOUT SWP_Ret_Value INT)
   SWL_return:
BEGIN






/*
Name of stored procedure: FixedAssetDisposal_CreateGLTransaction
Method: 
	This procedure performs all nesessary GL postings to dispose purchased assets
	All data validation for this procedure is perfomed in the parent FixedAssetDisposal_Post procedure

Date Created: EDE - 07/28/2015

Input Parameters:

	@CompanyID NVARCHAR(36)		 - the ID of the company
	@DivisionID NVARCHAR(36)	 - the ID of the division
	@DepartmentID NVARCHAR(36)	 - the ID of the department
	@AssetID NVARCHAR(36)		 - the ID of fixed asset
	@AssetAcutalDisposalDate DATETIME - the date of disposal

Output Parameters:

	NONE

Called From:

	FixedAssetDisposal_Post

Calls:

	VerifyCurrency, GetNextEntityID, LedgerTransactions_PostCOA_AllRecords, Error_InsertError

Last Modified: 03/04/2009

Last Modified By: 

Revision History: 

*/

   DECLARE v_Res INT;
   DECLARE v_ErrorID INT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(100);
   DECLARE v_CurrencyID NATIONAL VARCHAR(36);
   DECLARE v_CompanyCurrencyID NATIONAL VARCHAR(36);
   DECLARE v_CurrencyExchangeRate FLOAT;
   DECLARE v_AssetInServiceDate DATETIME;
   DECLARE v_AssetDepreciationMethodID NATIONAL VARCHAR(36);
   DECLARE v_AssetUsefulLife SMALLINT;
   DECLARE v_AssetSalvageValue DECIMAL(19,4);
   DECLARE v_LastDepreciationDate DATETIME;
   DECLARE v_DepreciationPeriod NATIONAL VARCHAR(1);
   DECLARE v_AssetOriginalCost DECIMAL(19,4);
   DECLARE v_AccumulatedDepreciation DECIMAL(19,4);
   DECLARE v_AssetActualDisposalAmount DECIMAL(19,4);
   DECLARE v_LastDepreciationAmount DECIMAL(19,4);
   DECLARE v_GLFixedDisposalAccount NATIONAL VARCHAR(36);
   DECLARE v_GLFixedAssetAccount NATIONAL VARCHAR(36);
   DECLARE v_GLFixedAccumDepreciationAccount NATIONAL VARCHAR(36);
   DECLARE v_GLARCashAccount NATIONAL VARCHAR(36);
   DECLARE v_NextGLTransNumber NATIONAL VARCHAR(36);
   DECLARE v_VendorID NATIONAL VARCHAR(50);
   DECLARE v_ReturnStatus INT;
   DECLARE v_Posted BOOLEAN;


   DECLARE v_PostDate NATIONAL VARCHAR(1);
   DECLARE v_DepreciationCount INT;
   DECLARE v_DepreciationAmount DECIMAL(19,4); 
   DECLARE v_DateCount INT;
   DECLARE v_ConvertedDepreciationAmount DECIMAL(19,4); 

   DECLARE v_DisposalYear INT;
   DECLARE v_LastDepreciationYear INT;
   DECLARE v_ConvertedAssetOriginalCost DECIMAL(19,4);
   DECLARE v_ConvertedAssetActualDisposalAmount DECIMAL(19,4);
   DECLARE v_ConvertedLastDepreciationAmount DECIMAL(19,4);
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
--	GET DIAGNOSTICS CONDITION 1
  --       @p1 = RETURNED_SQLSTATE, @p2 = MESSAGE_TEXT;
--	  SELECT @p1, @p2;
      SET @SWV_Error = 1;
   END;
   WriteError:
   BEGIN
      SET @SWV_Error = 0;
      START TRANSACTION; -- transaction 

-- get GL acounts and amounts
      select   IFNULL(AccumulatedDepreciation,0), AssetInServiceDate, AssetUsefulLife, AssetSalvageValue, LastDepreciationDate, LastDepreciationAmount, AssetDepreciationMethodID, DepreciationPeriod, IFNULL(AssetOriginalCost,0), IFNULL(AssetActualDisposalAmount,0), GLFixedDisposalAccount, GLFixedAssetAccount, GLFixedAccumDepreciationAccount, IFNULL(CurrencyID,0), IFNULL(CurrencyExchangeRate,0), VendorID, Posted INTO v_AccumulatedDepreciation,v_AssetInServiceDate,v_AssetUsefulLife,v_AssetSalvageValue,
      v_LastDepreciationDate,v_LastDepreciationAmount,v_AssetDepreciationMethodID,
      v_DepreciationPeriod,v_AssetOriginalCost,v_AssetActualDisposalAmount,
      v_GLFixedDisposalAccount,v_GLFixedAssetAccount,v_GLFixedAccumDepreciationAccount,
      v_CurrencyID,v_CurrencyExchangeRate,v_VendorID,
      v_Posted FROM
      FixedAssets WHERE
      CompanyID = v_CompanyID
      AND DivisionID = v_DivisionID
      AND DepartmentID = v_DepartmentID
      AND AssetID = v_AssetID;
      IF v_GLFixedDisposalAccount IS NULL OR v_GLFixedAssetAccount IS NULL OR v_GLFixedAccumDepreciationAccount IS NULL then

	-- the procedure will return an error code
         SET v_ErrorMessage = 'One of depreciation accounts is not defined';
         LEAVE WriteError;
      end if;

-- get default cash acount
      select   GLARCashAccount INTO v_GLARCashAccount FROM	Companies WHERE	CompanyID = v_CompanyID AND
      DivisionID = v_DivisionID AND
      DepartmentID = v_DepartmentID;

-- Get currency exchange rate for asset currency
      SET @SWV_Error = 0;
      CALL VerifyCurrency2(v_CompanyID,v_DivisionID,v_DepartmentID,v_AssetAcutalDisposalDate,0,v_CompanyCurrencyID,
      v_CurrencyID,v_CurrencyExchangeRate);
      IF @SWV_Error <> 0 then

	-- the procedure will return an error code
         SET v_ErrorMessage = 'Currency retrieving failed';
         LEAVE WriteError;
      end if;
      select   IFNULL(DefaultGLPostingDate,'1') INTO v_PostDate FROM
      Companies WHERE
      CompanyID = v_CompanyID
      AND DivisionID = v_DivisionID
      AND DepartmentID = v_DepartmentID;

-- Need to check whether depreciation has done before disposal for that current year. \?
-- To Find how many depreciations shoud be occured and depreciation value

-- -------------Calculation of depreciation amount begins---------------
      SET v_DepreciationCount = TIMESTAMPDIFF(YEAR,v_AssetInServiceDate,v_AssetAcutalDisposalDate);
      SET v_DepreciationCount = v_DepreciationCount+1;
      IF v_AssetDepreciationMethodID = 'Straight' then

         SET v_DepreciationAmount = fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,(v_AssetOriginalCost -v_AssetSalvageValue)/v_AssetUsefulLife, 
         v_CompanyCurrencyID);
         SET v_DepreciationAmount = v_DepreciationAmount*v_DepreciationCount;
      ELSE 
         IF v_AssetDepreciationMethodID = 'Declining' then

            SET v_DepreciationAmount = fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,(v_AssetOriginalCost -v_AccumulatedDepreciation)/(v_AssetUsefulLife*0.5),v_CompanyCurrencyID);
            SET v_DepreciationAmount = v_DepreciationAmount*v_DepreciationCount;
         ELSE 
            IF v_AssetDepreciationMethodID = 'Double Decline' then

               SET v_DepreciationAmount = fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,(v_AssetOriginalCost -v_AccumulatedDepreciation)/(v_AssetUsefulLife*0.25),v_CompanyCurrencyID);
               SET v_DepreciationAmount = v_DepreciationAmount*v_DepreciationCount;
            ELSE 
               IF v_AssetDepreciationMethodID = 'Declining 150' then

                  SET v_DepreciationAmount = fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,(v_AssetOriginalCost -v_AccumulatedDepreciation)/(v_AssetUsefulLife*0.125),v_CompanyCurrencyID);
                  SET v_DepreciationAmount = v_DepreciationAmount*v_DepreciationCount;
               ELSE 
                  IF v_AssetDepreciationMethodID = 'Sum Of Years' then

-- we calculate the depreciation usind the Sum of Year method
-- FIB()=AssetUsefulLife+(AssetUsefulLife-1)+(AssetUsefulLife-2)+...+0=(AssetUsefulLife*(AssetUsefulLife+1))/2
                     IF (v_DepreciationPeriod = 'Y') then
                        SET v_DepreciationAmount = fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,((v_AssetOriginalCost -v_AssetSalvageValue)*(v_AssetUsefulLife -ABS(TIMESTAMPDIFF(YEAR,v_AssetInServiceDate,v_LastDepreciationDate))))/((v_AssetUsefulLife*(v_AssetUsefulLife+1))/2), 
                        v_CompanyCurrencyID)*v_DepreciationCount;
                     ELSE
                        IF (v_DepreciationPeriod = 'Q') then 
                           SET v_DepreciationAmount = fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,((v_AssetOriginalCost -v_AssetSalvageValue)*(v_AssetUsefulLife -ABS(TIMESTAMPDIFF(MONTH,v_AssetInServiceDate,v_LastDepreciationDate))))/((v_AssetUsefulLife*(v_AssetUsefulLife+1))/2), 
                           v_CompanyCurrencyID)*v_DepreciationCount;
                        ELSE
                           IF (v_DepreciationPeriod = 'M') then 
                              SET v_DepreciationAmount = fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,((v_AssetOriginalCost -v_AssetSalvageValue)*(v_AssetUsefulLife -ABS(TIMESTAMPDIFF(DAY,v_AssetInServiceDate,v_LastDepreciationDate))))/((v_AssetUsefulLife*(v_AssetUsefulLife+1))/2), 
                              v_CompanyCurrencyID)*v_DepreciationCount;
                           ELSE 
                              IF(v_DepreciationPeriod = 'P') then 
                                 SET v_DepreciationAmount = fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,((v_AssetOriginalCost -v_AssetSalvageValue)*(v_AssetUsefulLife -ABS(TIMESTAMPDIFF(DAY,v_AssetInServiceDate,v_LastDepreciationDate))))/((v_AssetUsefulLife*(v_AssetUsefulLife+1))/2), 
                                 v_CompanyCurrencyID)*v_DepreciationCount;
                              end if;
                           end if;
                        end if;
                     end if;
                  end if;
               end if;
            end if;
         end if;
      end if;

-- -------------Calculation of depreciation amount ends---------------

-- -------------Calculation of AssetOriginalCost,Year of ActualDisposalDate and Year of LastDepreciationDate begns--------
      SET v_DisposalYear = YEAR(v_AssetAcutalDisposalDate);
      SET v_LastDepreciationYear = YEAR(v_LastDepreciationDate);
      SET v_ConvertedAssetOriginalCost = fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,v_AssetOriginalCost*v_CurrencyExchangeRate, 
      v_CompanyCurrencyID);

-- -------------Calculation of AssetOriginalCost,Year of ActualDisposalDate and Year of LastDepreciationDate ends--------

-- First transaction posts @AssetOriginalCost to GL
-- Years AssetInService and ActualDisposalDate are not same
      IF  (v_LastDepreciationYear IS NOT NULL) then


-- get next GL transaction number
         SET @SWV_Error = 0;
         CALL GetNextEntityID2(v_CompanyID,v_DivisionID,v_DepartmentID,'NextGLTransNumber',v_NextGLTransNumber, v_Res);
         IF v_Res <> 0 OR @SWV_Error <> 0 then

            SET v_ErrorMessage = 'Call enterprise.GetNextEntityID failed1';
            LEAVE WriteError;
         end if;


-- insert record into LedgerTransactions table
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
	v_NextGLTransNumber,
	'Disposal',
	CASE v_PostDate WHEN '1' THEN CURRENT_TIMESTAMP ELSE v_AssetAcutalDisposalDate END,
	v_VendorID,
	v_AssetID,
	CONCAT('DISP ', cast(v_AssetID as char(10))),
	v_ConvertedAssetOriginalCost -v_AccumulatedDepreciation,  -- MyChanges
	1,
	0,
	1,
	v_CurrencyID,
	v_CurrencyExchangeRate);

         IF @SWV_Error <> 0 then

            SET v_ErrorMessage = 'INSERT INTO LedgerTransactions failed';
            LEAVE WriteError;
         end if;

-- debit AssetOriginalCost from GLFixedDisposalAccount

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
	v_NextGLTransNumber,
	v_GLFixedDisposalAccount,
	v_ConvertedAssetOriginalCost -v_AccumulatedDepreciation,
	0.0);

         IF @SWV_Error <> 0 then

            SET v_ErrorMessage = 'INSERT INTO LedgerTransactionsDetail failed';
            LEAVE WriteError;
         end if;

-- credit AssetOriginalCost to GLFixedAssetAccount
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
	v_NextGLTransNumber,
	v_GLFixedAssetAccount,
	0.0,
	v_ConvertedAssetOriginalCost -v_AccumulatedDepreciation);

         IF @SWV_Error <> 0 then

            SET v_ErrorMessage = 'INSERT INTO LedgerTransactionsDetail failed';
            LEAVE WriteError;
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
         CALL LedgerTransactions_PostCOA_AllRecords2(v_CompanyID,v_DivisionID,v_DepartmentID,v_NextGLTransNumber, v_ReturnStatus);
         IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then

            SET v_ErrorMessage = 'LedgerTransactions_PostCOA_AllRecords call failed';
            LEAVE WriteError;
         end if;
      ELSE

	-- get DepreciationAmount against ExchangeRate.	
         SET v_ConvertedDepreciationAmount = fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,v_DepreciationAmount*v_CurrencyExchangeRate, 
         v_CompanyCurrencyID);

	-- get next GL transaction number
         SET @SWV_Error = 0;
         CALL GetNextEntityID2(v_CompanyID,v_DivisionID,v_DepartmentID,'NextGLTransNumber',v_NextGLTransNumber, v_Res);
         IF v_Res <> 0 OR @SWV_Error <> 0 then
	
            SET v_ErrorMessage = 'Call enterprise.GetNextEntityID failed2';
            LEAVE WriteError;
         end if;

-- get next GL transaction number
         SET @SWV_Error = 0;
         CALL GetNextEntityID2(v_CompanyID,v_DivisionID,v_DepartmentID,'NextGLTransNumber',v_NextGLTransNumber, v_Res);
         IF v_Res <> 0 OR @SWV_Error <> 0 then

            SET v_ErrorMessage = 'Call enterprise.GetNextEntityID failed3';
            LEAVE WriteError;
         end if;

-- DECLARE @ConvertedAssetOriginalCost MONEY
-- SET @ConvertedAssetOriginalCost=dbo.fnRound(@CompanyID, @DivisionID , @DepartmentID, @AssetOriginalCost*@CurrencyExchangeRate, @CompanyCurrencyID)

-- insert record into LedgerTransactions table
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
	v_NextGLTransNumber,
	'Disposal',
	CASE v_PostDate WHEN '1' THEN CURRENT_TIMESTAMP ELSE v_AssetAcutalDisposalDate END,
	v_VendorID,
	v_AssetID,
	CONCAT('DISP ', cast(v_AssetID as char(10))),
	v_ConvertedAssetOriginalCost -v_ConvertedDepreciationAmount,  -- MyChanges
	1,
	0,
	1,
	v_CurrencyID,
	v_CurrencyExchangeRate);

         IF @SWV_Error <> 0 then

            SET v_ErrorMessage = 'INSERT INTO LedgerTransactions failed';
            LEAVE WriteError;
         end if;

-- debit AssetOriginalCost from GLFixedDisposalAccount

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
	v_NextGLTransNumber,
	v_GLFixedDisposalAccount,
	v_ConvertedAssetOriginalCost -v_ConvertedDepreciationAmount,
	0.0);

         IF @SWV_Error <> 0 then

            SET v_ErrorMessage = 'INSERT INTO LedgerTransactionsDetail failed';
            LEAVE WriteError;
         end if;

-- credit AssetOriginalCost to GLFixedAssetAccount
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
	v_NextGLTransNumber,
	v_GLFixedAssetAccount,
	0.0,
	v_ConvertedAssetOriginalCost -v_ConvertedDepreciationAmount);

         IF @SWV_Error <> 0 then

            SET v_ErrorMessage = 'INSERT INTO LedgerTransactionsDetail failed';
            LEAVE WriteError;
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
         CALL LedgerTransactions_PostCOA_AllRecords2(v_CompanyID,v_DivisionID,v_DepartmentID,v_NextGLTransNumber, v_ReturnStatus);
         IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then

            SET v_ErrorMessage = 'LedgerTransactions_PostCOA_AllRecords call failed';
            LEAVE WriteError;
         end if;
      end if;
-- -----------------------------------------------------------------------

-- Second transaction posts LastDepreciationAmount to GL
-- Same Year AssetInServiceDate and DisposalDate. without depreciation begins	
      IF  (v_DisposalYear > v_LastDepreciationYear) then

	
	
	-- get converted LastDepreciation amount with use of CurrencyExchageRate
         SET v_ConvertedLastDepreciationAmount = fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,v_LastDepreciationAmount*v_CurrencyExchangeRate, 
         v_CompanyCurrencyID);

	-- get next GL transaction number
         SET @SWV_Error = 0;
         CALL GetNextEntityID2(v_CompanyID,v_DivisionID,v_DepartmentID,'NextGLTransNumber',v_NextGLTransNumber, v_Res);
         IF v_Res <> 0 OR @SWV_Error <> 0 then
	
            SET v_ErrorMessage = 'Call enterprise.GetNextEntityID failed3';
            LEAVE WriteError;
         end if;

	-- insert record into LedgerTransactions table
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
		v_NextGLTransNumber,
		'Disposal',
		v_AssetAcutalDisposalDate,
		v_VendorID,
		v_AssetID,
		CONCAT('DISP ', cast(v_AssetID as char(10))),
		v_ConvertedLastDepreciationAmount,
		1,
		0,
		1,
		v_CurrencyID,
		v_CurrencyExchangeRate);
	
         IF @SWV_Error <> 0 then
	
            SET v_ErrorMessage = 'INSERT INTO LedgerTransactions failed';
            LEAVE WriteError;
         end if;
	
	-- debit @LastDepreciationAmount from GLFixedAccumDepreciationAccount
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
		v_NextGLTransNumber,
		v_GLFixedAccumDepreciationAccount,
		v_ConvertedLastDepreciationAmount,
		0.0);
	
         IF @SWV_Error <> 0 then
	
            SET v_ErrorMessage = 'INSERT INTO LedgerTransactionsDetail failed';
            LEAVE WriteError;
         end if;
	
	-- credit @LastDepreciationAmount to GLFixedDisposalAccount
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
		v_NextGLTransNumber,
		v_GLFixedDisposalAccount,
		0.0,
		v_ConvertedLastDepreciationAmount);
	
         IF @SWV_Error <> 0 then
	
            SET v_ErrorMessage = 'INSERT INTO LedgerTransactionsDetail failed';
            LEAVE WriteError;
         end if;
      end if;
-- ----------- Ends -------------

-- Same AssetInServiceDate and DisposalDate. without depreciation begins 
-- Second transaction posts DepreciationAmount to GL
      IF  (v_LastDepreciationYear IS NULL) then
	
	-- get the converted depreciation amount with use of its CurrencyExchangeRate
         SET v_ConvertedDepreciationAmount = fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,v_DepreciationAmount*v_CurrencyExchangeRate, 
         v_CompanyCurrencyID);

	-- get next GL transaction number
         SET @SWV_Error = 0;
         CALL GetNextEntityID2(v_CompanyID,v_DivisionID,v_DepartmentID,'NextGLTransNumber',v_NextGLTransNumber, v_Res);
         IF v_Res <> 0 OR @SWV_Error <> 0 then
	
            SET v_ErrorMessage = 'Call enterprise.GetNextEntityID failed4';
            LEAVE WriteError;
         end if;

	-- insert record into LedgerTransactions table
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
		v_NextGLTransNumber,
		'Disposal',
		v_AssetAcutalDisposalDate,
		v_VendorID,
		v_AssetID,
		CONCAT('DISP ', cast(v_AssetID as char(10))),
		v_ConvertedDepreciationAmount,
		1,
		0,
		1,
		v_CurrencyID,
		v_CurrencyExchangeRate);
	
         IF @SWV_Error <> 0 then
	
            SET v_ErrorMessage = 'INSERT INTO LedgerTransactions failed';
            LEAVE WriteError;
         end if;
	
	-- debit DepreciationAmount from GLFixedAccumDepreciationAccount
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
		v_NextGLTransNumber,
		v_GLFixedAccumDepreciationAccount,
		v_ConvertedDepreciationAmount,
		0.0);
	
         IF @SWV_Error <> 0 then
	
            SET v_ErrorMessage = 'INSERT INTO LedgerTransactionsDetail failed';
            LEAVE WriteError;
         end if;
	
	-- credit @DepreciationAmount to GLFixedDisposalAccount
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
		v_NextGLTransNumber,
		v_GLFixedDisposalAccount,
		0.0,
		v_ConvertedDepreciationAmount);
	
         IF @SWV_Error <> 0 then
	
            SET v_ErrorMessage = 'INSERT INTO LedgerTransactionsDetail failed';
            LEAVE WriteError;
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
         CALL LedgerTransactions_PostCOA_AllRecords2(v_CompanyID,v_DivisionID,v_DepartmentID,v_NextGLTransNumber, v_ReturnStatus);
         IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then
	
            SET v_ErrorMessage = 'LedgerTransactions_PostCOA_AllRecords call failed';
            LEAVE WriteError;
         end if;
      end if;

-- -----------------------------------------------------------------------
-- Third transaction posts AssetActualDisposalAmount to GL

-- get next GL transaction number
      SET @SWV_Error = 0;
      CALL GetNextEntityID2(v_CompanyID,v_DivisionID,v_DepartmentID,'NextGLTransNumber',v_NextGLTransNumber, v_Res);
      IF v_Res <> 0 OR @SWV_Error <> 0 then

         SET v_ErrorMessage = 'Call enterprise.GetNextEntityID failed5';
         LEAVE WriteError;
      end if;
      SET v_ConvertedAssetActualDisposalAmount = fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,v_AssetActualDisposalAmount*v_CurrencyExchangeRate, 
      v_CompanyCurrencyID);


-- insert a new transaction into LedgerTransaction
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
	v_NextGLTransNumber,
	'Disposal',
	v_AssetAcutalDisposalDate,
	v_VendorID,
	v_AssetID,
	CONCAT('DISP ', cast(v_AssetID as char(10))),
	v_ConvertedAssetActualDisposalAmount,
	1,
	0,
	1,
	v_CurrencyID,
	v_CurrencyExchangeRate);

      IF @SWV_Error <> 0 then

         SET v_ErrorMessage = 'INSERT INTO LedgerTransactions failed';
         LEAVE WriteError;
      end if;

-- debit AssetActualDisposalAmount from default cash acount
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
	v_NextGLTransNumber,
	v_GLARCashAccount,
	v_ConvertedAssetActualDisposalAmount,
	0.0);

      IF @SWV_Error <> 0 then

         SET v_ErrorMessage = 'INSERT INTO LedgerTransactionsDetail failed';
         LEAVE WriteError;
      end if;

-- credit AssetActualDisposalAmount to GLFixedDisposalAccount
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
	v_NextGLTransNumber,
	v_GLFixedDisposalAccount,
	0.0,
	v_ConvertedAssetActualDisposalAmount);

      IF @SWV_Error <> 0 then

         SET v_ErrorMessage = 'INSERT INTO LedgerTransactionsDetail failed';
         LEAVE WriteError;
      end if;
-- -----------------------------------------------------------------------

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
      CALL LedgerTransactions_PostCOA_AllRecords2(v_CompanyID,v_DivisionID,v_DepartmentID,v_NextGLTransNumber, v_ReturnStatus);
      IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then

         SET v_ErrorMessage = 'LedgerTransactions_PostCOA_AllRecords call failed';
         LEAVE WriteError;
      end if;
      COMMIT;
      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;
   END;
   ROLLBACK;

-- the error handler
   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'FixedAssetDisposal_CreateGLTrnasaction',
   v_ErrorMessage,v_ErrorID);
END;




















//

DELIMITER ;

DELIMITER //
DROP PROCEDURE IF EXISTS GetNextEntityID2;
//
CREATE   PROCEDURE GetNextEntityID2(v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_Entity NATIONAL VARCHAR(50),
	INOUT v_EntityID NATIONAL VARCHAR(36)  ,INOUT SWP_Ret_Value INT)
   SWL_return:
BEGIN







/*
Name of stored procedure: GetNextEntityID
Method: 
	This stored procedure is used to retrieve and generate IDs for different entities in the system
	It reads the ID from the CompaniesNextNumbers table and then generates a new ID for the specified entity

Date Created: EDE - 07/28/2015

Input Parameters:

	@CompanyID NVARCHAR(36)		 - the ID of the company
	@DivisionID NVARCHAR(36)	 - the ID of the division
	@DepartmentID NVARCHAR(36)	 - the ID of the department
	@Entity NVARCHAR(50)		 - the name of entity that identify the entity in the CompaniesNextNumbers table

Output Parameters:

	@EntityID NVARCHAR(36)		 - the ID; after this ID is retrieved as an output parameter, a new one is generated

Called From:

	Invoice_CreateFromReturn, GetNextEntityID.vb, DepreciationMethod_SumOfYears, Payroll_CalcCurrent, CreditMemo_CreateFromRMA, Purchase_CreateFromBackOrders, EDI_OrderProcessingInbound, PayrollCheck_Post, ServiceInvoice_CreateGLTransaction, DebitMemo_CreateFromPurchase, Receipt_CreateFromOrder, Purchase_DebitMemoPost, Payroll_CalcForEmployee, Payroll_Current, Payroll_Post, DepreciationMethod_Declining, ReturnReceipt_CreateGLTransaction, InventoryAdjustments_CreateGLTransaction, ServiceReceipt_CreateFromInvoice, Payment_CreateGLTransaction, FixedAssetDisposal_CreateGLTransaction, Invoice_CreditMemoCreateGLTransaction, Invoice_CreateFromMemorized, Invoice_CreditMemoPost, Return_Split, EDI_ShipmentNoticesProcessingOutbound, Payment_Recur, DepreciationMethod_DoubleDecline, Payment_CreateFromPurchase, DebitMemo_CreateFromMemorized, PaymentCheck_CreateGLTransaction, LedgerTransactions_Recur, Purchase_CreateFromReorder, EDI_InvoiceProcessingInbound, ReturnInvoice_CreateFromMemorized, Receipt_CreateFromInvoice, CreditMemo_CreateGLTransaction, DepreciationMethod_Declining150, Payment_CreateFromMemorized, Fixed_AssetDisposal, Purchase_Split, EDI_ShipmentNoticesProcessingInbound, RMA_Split, Payment_CreateCreditMemo, Receipt_Cash, ReturnReceipt_CreateFromInvoice, ServiceReceipt_CreateGLTransaction, Invoice_CreateGLTransaction, Order_Split, RMAReceiving_CreateGLTransaction, Purchase_Recur, Payment_CreateFromRMA, FixedAssetDepreciation_CreateGLTransaction, Payroll_W3, Invoice_CreateFromServiceOrder, Purchase_CreateFromOrder, ServiceInvoice_CreateFromMemorized, Receipt_CreateGLTransaction, ReturnReceipt_Cash, Receiving_CreateGLTransaction, RMA_Recur, ServiceOrder_Split, CreditMemo_CreateFromReturnInvoice, LedgerTransactions_PostPayment, Purchase_CreateFromMemorized, Invoice_CreateFromOrder, RMA_CreateFromMemorized, CreditMemo_CreateFromMemorized, Receipt_Cash_Manual, Payment_CreateChecks, CreditMemo_CreatePayment, DebitMemo_CreateGLTransaction, EDI_InvoiceProcessingOutbound, ReceiptCash_CreateGLTransaction, Payroll_Post, RMA_CreateFromInvoice, Receipt_CreateFromMemorized, EDI_PurchaseProcessingOutbound, ServiceOrder_CreateFromMemorized, Return_CreateFromMemorized, ReturnInvoice_CreateGLTransaction, ReceiptCash_Return_CreateGLTransaction, DepreciationMethod_Straight, ServiceInvoice_CreateFromOrder, PayrollCheckInsert, Bank_CreateGLTransaction, CreditMemo_CreateFromInvoice, LedgerTransactions_CreateFromMemorized, Order_CreateFromMemorized, LedgerTransactions_Reverse, ReturnInvoice_CreateFromReturn

Calls:

	Error_InsertError, Error_InsertErrorDetail

Last Modified: 

Last Modified By: 

Revision History: 

*/

   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);

   DECLARE v_nextid INT;
   DECLARE v_ErrorID INT;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
--	GET DIAGNOSTICS CONDITION 1
  --       @p1 = RETURNED_SQLSTATE, @p2 = MESSAGE_TEXT;
--	  SELECT @p1, @p2;
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

-- An error occured, go to the error handler
   IF @SWV_Error <> 0 then

      SET v_EntityID = N'';
      SET v_ErrorMessage = 'CompaniesNextNumbers update failed';
      ROLLBACK;
-- The error handler
      CALL Error_InsertError(v_CompanyID,'','','GetNextEntityID',v_ErrorMessage,v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,'','',v_ErrorID,'Entity',v_Entity);
      SET SWP_Ret_Value = -1;
   end if;


-- Everything is OK
   COMMIT;


   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;


-- if an error occured in the procedure this code will be executed
-- The information about the error are entered in the ErrrorLog and ErrorLogDetail tables.
-- The company, division, department informations are inserted in the ErrorLog table
-- along with information about the name of the procedure and the error message and an errorID is obtained.
-- The aditional information about other procedure parameters are inserted along with the errorID in the ErrorLogDetail table
-- (about the other parameters the name and the value are inserted).
   ROLLBACK;
-- The error handler
   CALL Error_InsertError(v_CompanyID,'','','GetNextEntityID',v_ErrorMessage,v_ErrorID);

   CALL Error_InsertErrorDetail(v_CompanyID,'','',v_ErrorID,'Entity',v_Entity);

   SET SWP_Ret_Value = -1;
END;











//

DELIMITER ;

DELIMITER //
DROP PROCEDURE IF EXISTS FixedAsset_Post;
//
CREATE                  PROCEDURE FixedAsset_Post(v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_AssetID NATIONAL VARCHAR(36),
	INOUT v_PostAsset INT ,INOUT SWP_Ret_Value INT)
   SWL_return:
BEGIN















/*
Name of stored procedure: FixedAsset_Post
Method: 
	This store procedure posts new fixed asset into general ledger

Date Created: EDE - 07/28/2015

Input Parameters:

	@CompanyID NVARCHAR(36)		 - the ID of the company
	@DivisionID NVARCHAR(36)	 - the ID of the division
	@DepartmentID NVARCHAR(36)	 - the ID of the department
	@AssetID NVARCHAR(36)		 - the ID of fixed asset

Output Parameters:

	@PostAsset INT 

Called From:

	FixedAsset_Post.vb

Calls:

	LedgerMain_CurrentPeriod, LedgerMain_VerifyPeriod, FixedAssetDepreciation_CreateGLTransaction, Error_InsertError

Last Modified: 

Last Modified By: 

Revision History: 

*/

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

-- We will use current date without time part as default transaction date
      SET v_TransDate = STR_TO_DATE(DATE_FORMAT(CURRENT_TIMESTAMP,'%Y-%m-%d'),'%Y-%m-%d'); 


-- check if asset is not already disposed and needed fields are populated

      IF	v_Posted = 1 then

         SET SWP_Ret_Value = 0;
         LEAVE SWL_return;
      end if;
      START TRANSACTION; -- transaction

      IF	IFNULL(v_AssetOriginalCost,0) <= 0 then

         SET v_ErrorMessage = 'Asset Original Cost must be > 0';
         LEAVE WriteError;
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

-- Post depreciation to general ledger
      SET @SWV_Error = 0;
      CALL FixedAsset_CreateGLTransaction(v_CompanyID,v_DivisionID,v_DepartmentID,v_AssetID,v_TransDate, v_ReturnStatus);
      IF v_ReturnStatus <> 0 OR @SWV_Error <> 0 then
	
         SET v_ErrorMessage = 'Call FixedAsset_CreateGLTransaction failed';
         LEAVE WriteError;
      end if;


-- we update Fixed Assets table with data just calculated
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

-- the error handler
   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'FixedAsset_Post',v_ErrorMessage,
   v_ErrorID);
END;


















//

DELIMITER ;

DELIMITER //
DROP PROCEDURE IF EXISTS FixedAsset_CreateGLTransaction;
//
CREATE                   PROCEDURE FixedAsset_CreateGLTransaction(v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_AssetID NATIONAL VARCHAR(36),
	v_TransDate DATETIME,INOUT SWP_Ret_Value INT)
   SWL_return:
BEGIN


















/*
Name of stored procedure: FixedAsset_CreateGLTransaction
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
   DECLARE v_GLFixedAssetAccount NATIONAL VARCHAR(36);
   DECLARE v_GLARAccount NATIONAL VARCHAR(36);
   DECLARE v_AssetOriginalCost DECIMAL(19,4);
   DECLARE v_VendorID NATIONAL VARCHAR(50);

   DECLARE v_PostDate NATIONAL VARCHAR(1);
   DECLARE v_ConvertedAssetOriginalCost DECIMAL(19,4);
   DECLARE v_ErrorID INT;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
   END;
   select   IFNULL(AssetOriginalCost,0), GLFixedAssetAccount, CurrencyID, CurrencyExchangeRate, VendorID INTO v_AssetOriginalCost,v_GLFixedAssetAccount,v_CurrencyID,v_CurrencyExchangeRate,
   v_VendorID FROM FixedAssets WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND AssetID = v_AssetID;

   IF IFNULL(v_AssetOriginalCost,0) = 0 then
      SET SWP_Ret_Value = -1;
      LEAVE SWL_return;
   end if;

   START TRANSACTION; -- transaction

   IF v_GLFixedAssetAccount IS NULL then

	-- the procedure will return an error code
      SET v_ErrorMessage = 'GLFixedAssetAccount is not defined';
      ROLLBACK;

-- the error handler
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'FixedAsset_CreateGLTransaction',
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
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'FixedAsset_CreateGLTransaction',
      v_ErrorMessage,v_ErrorID);
      SET SWP_Ret_Value = 1;
   end if;

   select   IFNULL(DefaultGLPostingDate,'1'), GLARAccount INTO v_PostDate,v_GLARAccount FROM
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
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'FixedAsset_CreateGLTransaction',
      v_ErrorMessage,v_ErrorID);
      SET SWP_Ret_Value = 1;
   end if;

   SET v_ConvertedAssetOriginalCost = fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,v_AssetOriginalCost*v_CurrencyExchangeRate, 
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
	'Asset',
	CASE v_PostDate WHEN '1' THEN CURRENT_TIMESTAMP ELSE v_TransDate END,
	v_VendorID,
	v_AssetID,
	CONCAT('ASSET ', cast(v_AssetID as char(10))),
	v_ConvertedAssetOriginalCost,
	1,
	0,
	1,
	v_CurrencyID,
	v_CurrencyExchangeRate);





   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'INSERT INTO LedgerTransactions failed';
      ROLLBACK;

-- the error handler
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'FixedAsset_CreateGLTransaction',
      v_ErrorMessage,v_ErrorID);
      SET SWP_Ret_Value = 1;
   end if;

-- we debit GLFixedAssetAccount
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
	v_GLFixedAssetAccount,
	v_ConvertedAssetOriginalCost,
	0);




   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'INSERT INTO LedgerTransactionsDetail failed';
      ROLLBACK;

-- the error handler
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'FixedAsset_CreateGLTransaction',
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
	v_GLARAccount,
	0,
	v_ConvertedAssetOriginalCost);




   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'INSERT INTO LedgerTransactionsDetail failed';
      ROLLBACK;

-- the error handler
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'FixedAsset_CreateGLTransaction',
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
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'FixedAsset_CreateGLTransaction',
      v_ErrorMessage,v_ErrorID);
      SET SWP_Ret_Value = 1;
   end if;


   COMMIT;
   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;



   ROLLBACK;

-- the error handler
   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'FixedAsset_CreateGLTransaction',
   v_ErrorMessage,v_ErrorID);


   SET SWP_Ret_Value = 1;
END;


















//

DELIMITER ;

DELIMITER //
DROP PROCEDURE IF EXISTS FixedAssetDepreciation_PostAll;
//
CREATE     PROCEDURE FixedAssetDepreciation_PostAll(v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	INOUT v_Result INT ,INOUT SWP_Ret_Value INT)
BEGIN

















/*
Name of stored procedure: FixedAssetDepreciation_PostAll
Method: 
	Depreciates and posts all assets in the company, that require depreciation

Date Created: EDE - 07/28/2015

Input Parameters:

	@CompanyID NVARCHAR(36)		 - the ID of the company
	@DivisionID NVARCHAR(36)	 - the ID of the division
	@DepartmentID NVARCHAR(36)	 - the ID of the department

Output Parameters:

	@Result int 

Called From:

	FixedAssetDepriciation_PostAll.vb

Calls:

	FixedAssetDepreciation_Post

Last Modified: 

Last Modified By: 

Revision History: 

*/

   DECLARE v_Res INT;
   DECLARE v_Return INT;
   DECLARE v_AssetID NATIONAL VARCHAR(36);
   DECLARE v_PostAsset INT;

   DECLARE NO_DATA INT DEFAULT 0;
   DECLARE cAssets CURSOR  FOR
   SELECT	AssetID
   FROM	FixedAssets
   WHERE	CompanyID = v_CompanyID AND DivisionID = v_DivisionID AND DepartmentID = v_DepartmentID;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET NO_DATA = -2;
   END;
   DECLARE CONTINUE HANDLER FOR NOT FOUND SET NO_DATA = -1;
   SET v_Return = 1;




-- Get assets from FixedAssets table
   SELECT	AssetID
   FROM	FixedAssets
   WHERE	CompanyID = v_CompanyID AND DivisionID = v_DivisionID AND DepartmentID = v_DepartmentID;
   SET NO_DATA = 0;
   FETCH cAssets INTO v_AssetID;
   WHILE NO_DATA = 0 DO
      CALL FixedAssetDepreciation_Post(v_CompanyID,v_DivisionID,v_DepartmentID,v_AssetID,v_PostAsset, v_Res);
      IF v_Res <> 1 then -- Calculation fail
         SET v_Return = 0;
      end if;
      SET NO_DATA = 0;
      FETCH cAssets INTO v_AssetID;
   END WHILE;

   SET SWP_Ret_Value = v_Return;
END;



//

DELIMITER ;
