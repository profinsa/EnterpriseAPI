CREATE PROCEDURE FixedAssetDisposal_CreateGLTransaction (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_AssetID NATIONAL VARCHAR(36),
	v_AssetAcutalDisposalDate DATETIME,INOUT SWP_Ret_Value INT) SWL_return:
BEGIN








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

  

      SET @SWV_Error = 1;
   END;
   WriteError:
   BEGIN
      SET @SWV_Error = 0;
      START TRANSACTION; 


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

	
         SET v_ErrorMessage = 'One of depreciation accounts is not defined';
         LEAVE WriteError;
      end if;


      select   GLARCashAccount INTO v_GLARCashAccount FROM	Companies WHERE	CompanyID = v_CompanyID AND
      DivisionID = v_DivisionID AND
      DepartmentID = v_DepartmentID;


      SET @SWV_Error = 0;
      CALL VerifyCurrency2(v_CompanyID,v_DivisionID,v_DepartmentID,v_AssetAcutalDisposalDate,0,v_CompanyCurrencyID,
      v_CurrencyID,v_CurrencyExchangeRate);
      IF @SWV_Error <> 0 then

	
         SET v_ErrorMessage = 'Currency retrieving failed';
         LEAVE WriteError;
      end if;
      select   IFNULL(DefaultGLPostingDate,'1') INTO v_PostDate FROM
      Companies WHERE
      CompanyID = v_CompanyID
      AND DivisionID = v_DivisionID
      AND DepartmentID = v_DepartmentID;





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




      SET v_DisposalYear = YEAR(v_AssetAcutalDisposalDate);
      SET v_LastDepreciationYear = YEAR(v_LastDepreciationDate);
      SET v_ConvertedAssetOriginalCost = fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,v_AssetOriginalCost*v_CurrencyExchangeRate, 
      v_CompanyCurrencyID);





      IF  (v_LastDepreciationYear IS NOT NULL) then



         SET @SWV_Error = 0;
         CALL GetNextEntityID2(v_CompanyID,v_DivisionID,v_DepartmentID,'NextGLTransNumber',v_NextGLTransNumber, v_Res);
         IF v_Res <> 0 OR @SWV_Error <> 0 then

            SET v_ErrorMessage = 'Call enterprise.GetNextEntityID failed1';
            LEAVE WriteError;
         end if;



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
	v_ConvertedAssetOriginalCost -v_AccumulatedDepreciation,  
	1,
	0,
	1,
	v_CurrencyID,
	v_CurrencyExchangeRate);

         IF @SWV_Error <> 0 then

            SET v_ErrorMessage = 'INSERT INTO LedgerTransactions failed';
            LEAVE WriteError;
         end if;



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



         SET @SWV_Error = 0;
         CALL LedgerTransactions_PostCOA_AllRecords2(v_CompanyID,v_DivisionID,v_DepartmentID,v_NextGLTransNumber, v_ReturnStatus);
         IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then

            SET v_ErrorMessage = 'LedgerTransactions_PostCOA_AllRecords call failed';
            LEAVE WriteError;
         end if;
      ELSE

	
         SET v_ConvertedDepreciationAmount = fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,v_DepreciationAmount*v_CurrencyExchangeRate, 
         v_CompanyCurrencyID);

	
         SET @SWV_Error = 0;
         CALL GetNextEntityID2(v_CompanyID,v_DivisionID,v_DepartmentID,'NextGLTransNumber',v_NextGLTransNumber, v_Res);
         IF v_Res <> 0 OR @SWV_Error <> 0 then
	
            SET v_ErrorMessage = 'Call enterprise.GetNextEntityID failed2';
            LEAVE WriteError;
         end if;


         SET @SWV_Error = 0;
         CALL GetNextEntityID2(v_CompanyID,v_DivisionID,v_DepartmentID,'NextGLTransNumber',v_NextGLTransNumber, v_Res);
         IF v_Res <> 0 OR @SWV_Error <> 0 then

            SET v_ErrorMessage = 'Call enterprise.GetNextEntityID failed3';
            LEAVE WriteError;
         end if;





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
	v_ConvertedAssetOriginalCost -v_ConvertedDepreciationAmount,  
	1,
	0,
	1,
	v_CurrencyID,
	v_CurrencyExchangeRate);

         IF @SWV_Error <> 0 then

            SET v_ErrorMessage = 'INSERT INTO LedgerTransactions failed';
            LEAVE WriteError;
         end if;



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



         SET @SWV_Error = 0;
         CALL LedgerTransactions_PostCOA_AllRecords2(v_CompanyID,v_DivisionID,v_DepartmentID,v_NextGLTransNumber, v_ReturnStatus);
         IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then

            SET v_ErrorMessage = 'LedgerTransactions_PostCOA_AllRecords call failed';
            LEAVE WriteError;
         end if;
      end if;




      IF  (v_DisposalYear > v_LastDepreciationYear) then

	
	
	
         SET v_ConvertedLastDepreciationAmount = fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,v_LastDepreciationAmount*v_CurrencyExchangeRate, 
         v_CompanyCurrencyID);

	
         SET @SWV_Error = 0;
         CALL GetNextEntityID2(v_CompanyID,v_DivisionID,v_DepartmentID,'NextGLTransNumber',v_NextGLTransNumber, v_Res);
         IF v_Res <> 0 OR @SWV_Error <> 0 then
	
            SET v_ErrorMessage = 'Call enterprise.GetNextEntityID failed3';
            LEAVE WriteError;
         end if;

	
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




      IF  (v_LastDepreciationYear IS NULL) then
	
	
         SET v_ConvertedDepreciationAmount = fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,v_DepreciationAmount*v_CurrencyExchangeRate, 
         v_CompanyCurrencyID);

	
         SET @SWV_Error = 0;
         CALL GetNextEntityID2(v_CompanyID,v_DivisionID,v_DepartmentID,'NextGLTransNumber',v_NextGLTransNumber, v_Res);
         IF v_Res <> 0 OR @SWV_Error <> 0 then
	
            SET v_ErrorMessage = 'Call enterprise.GetNextEntityID failed4';
            LEAVE WriteError;
         end if;

	
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

	
         SET @SWV_Error = 0;
         CALL LedgerTransactions_PostCOA_AllRecords2(v_CompanyID,v_DivisionID,v_DepartmentID,v_NextGLTransNumber, v_ReturnStatus);
         IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then
	
            SET v_ErrorMessage = 'LedgerTransactions_PostCOA_AllRecords call failed';
            LEAVE WriteError;
         end if;
      end if;





      SET @SWV_Error = 0;
      CALL GetNextEntityID2(v_CompanyID,v_DivisionID,v_DepartmentID,'NextGLTransNumber',v_NextGLTransNumber, v_Res);
      IF v_Res <> 0 OR @SWV_Error <> 0 then

         SET v_ErrorMessage = 'Call enterprise.GetNextEntityID failed5';
         LEAVE WriteError;
      end if;
      SET v_ConvertedAssetActualDisposalAmount = fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,v_AssetActualDisposalAmount*v_CurrencyExchangeRate, 
      v_CompanyCurrencyID);



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


   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'FixedAssetDisposal_CreateGLTrnasaction',
   v_ErrorMessage,v_ErrorID);
END