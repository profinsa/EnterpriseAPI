CREATE PROCEDURE FixedAssetDepreciation_CreateGLTransaction (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_AssetID NATIONAL VARCHAR(36),
	v_DepreciationAmount DECIMAL(19,4),
	v_TransDate DATETIME,INOUT SWP_Ret_Value INT) SWL_return:
BEGIN




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

   START TRANSACTION; 

   select   GLFixedAccumDepreciationAccount, GLFixedAssetAccount, CurrencyID, CurrencyExchangeRate, VendorID, Posted INTO v_GLFixedAccumDepreciationAccount,v_GLAssetAccount,v_CurrencyID,v_CurrencyExchangeRate,
   v_VendorID,v_Posted FROM FixedAssets WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND AssetID = v_AssetID;

   IF IFNULL(v_Posted,0) = 0 then

	
      SET v_ErrorMessage = 'You should book asset before depreciate it';
      ROLLBACK;


      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'FixedAssetDepreciate_CreateGLTransaction',
      v_ErrorMessage,v_ErrorID);
      SET SWP_Ret_Value = 1;
   end if;

   IF v_GLFixedAccumDepreciationAccount IS NULL then

	
      SET v_ErrorMessage = 'GL Fixed Accum Depreciation Account is not defined';
      ROLLBACK;


      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'FixedAssetDepreciate_CreateGLTransaction',
      v_ErrorMessage,v_ErrorID);
      SET SWP_Ret_Value = 1;
   end if;

   IF v_GLAssetAccount IS NULL then

	
      SET v_ErrorMessage = 'GL Asset Account is not defined';
      ROLLBACK;


      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'FixedAssetDepreciate_CreateGLTransaction',
      v_ErrorMessage,v_ErrorID);
      SET SWP_Ret_Value = 1;
   end if;

   SET @SWV_Error = 0;
   CALL VerifyCurrency2(v_CompanyID,v_DivisionID,v_DepartmentID,v_TransDate,0,v_CompanyCurrencyID,
   v_CurrencyID,v_CurrencyExchangeRate);
   IF @SWV_Error <> 0 then

	
      SET v_ErrorMessage = 'Currency retrieving failed';
      ROLLBACK;


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


      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'FixedAssetDepreciate_CreateGLTransaction',
      v_ErrorMessage,v_ErrorID);
      SET SWP_Ret_Value = 1;
   end if;

   SET v_ConvertedDepreciationAmount = fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,v_DepreciationAmount*v_CurrencyExchangeRate, 
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


      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'FixedAssetDepreciate_CreateGLTransaction',
      v_ErrorMessage,v_ErrorID);
      SET SWP_Ret_Value = 1;
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
	v_GLTransactionNumber,
	v_GLFixedAccumDepreciationAccount,
	v_ConvertedDepreciationAmount,
	0);




   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'INSERT INTO LedgerTransactionsDetail failed';
      ROLLBACK;


      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'FixedAssetDepreciate_CreateGLTransaction',
      v_ErrorMessage,v_ErrorID);
      SET SWP_Ret_Value = 1;
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
	v_GLTransactionNumber,
	v_GLAssetAccount,
	0,
	v_ConvertedDepreciationAmount);




   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'INSERT INTO LedgerTransactionsDetail failed';
      ROLLBACK;


      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'FixedAssetDepreciate_CreateGLTransaction',
      v_ErrorMessage,v_ErrorID);
      SET SWP_Ret_Value = 1;
   end if;



   SET @SWV_Error = 0;
   CALL LedgerTransactions_PostCOA_AllRecords2(v_CompanyID,v_DivisionID,v_DepartmentID,v_GLTransactionNumber, v_ReturnStatus);
   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then

      SET v_ErrorMessage = 'LedgerTransactions_PostCOA_AllRecords call failed';
      ROLLBACK;


      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'FixedAssetDepreciate_CreateGLTransaction',
      v_ErrorMessage,v_ErrorID);
      SET SWP_Ret_Value = 1;
   end if;


   COMMIT;
   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;



   ROLLBACK;


   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'FixedAssetDepreciate_CreateGLTransaction',
   v_ErrorMessage,v_ErrorID);


   SET SWP_Ret_Value = 1;
END