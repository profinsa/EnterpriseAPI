CREATE PROCEDURE FixedAsset_CreateGLTransaction (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_AssetID NATIONAL VARCHAR(36),
	v_TransDate DATETIME,INOUT SWP_Ret_Value INT) SWL_return:
BEGIN




















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

   START TRANSACTION; 

   IF v_GLFixedAssetAccount IS NULL then

	
      SET v_ErrorMessage = 'GLFixedAssetAccount is not defined';
      ROLLBACK;


      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'FixedAsset_CreateGLTransaction',
      v_ErrorMessage,v_ErrorID);
      SET SWP_Ret_Value = 1;
   end if;

   SET @SWV_Error = 0;
   CALL VerifyCurrency2(v_CompanyID,v_DivisionID,v_DepartmentID,v_TransDate,0,v_CompanyCurrencyID,
   v_CurrencyID,v_CurrencyExchangeRate);
   IF @SWV_Error <> 0 then

	
      SET v_ErrorMessage = 'Currency retrieving failed';
      ROLLBACK;


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


      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'FixedAsset_CreateGLTransaction',
      v_ErrorMessage,v_ErrorID);
      SET SWP_Ret_Value = 1;
   end if;

   SET v_ConvertedAssetOriginalCost = fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,v_AssetOriginalCost*v_CurrencyExchangeRate, 
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


      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'FixedAsset_CreateGLTransaction',
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
	v_GLFixedAssetAccount,
	v_ConvertedAssetOriginalCost,
	0);




   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'INSERT INTO LedgerTransactionsDetail failed';
      ROLLBACK;


      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'FixedAsset_CreateGLTransaction',
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
	v_GLARAccount,
	0,
	v_ConvertedAssetOriginalCost);




   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'INSERT INTO LedgerTransactionsDetail failed';
      ROLLBACK;


      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'FixedAsset_CreateGLTransaction',
      v_ErrorMessage,v_ErrorID);
      SET SWP_Ret_Value = 1;
   end if;



   SET @SWV_Error = 0;
   CALL LedgerTransactions_PostCOA_AllRecords2(v_CompanyID,v_DivisionID,v_DepartmentID,v_GLTransactionNumber, v_ReturnStatus);
   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then

      SET v_ErrorMessage = 'LedgerTransactions_PostCOA_AllRecords call failed';
      ROLLBACK;


      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'FixedAsset_CreateGLTransaction',
      v_ErrorMessage,v_ErrorID);
      SET SWP_Ret_Value = 1;
   end if;


   COMMIT;
   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;



   ROLLBACK;


   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'FixedAsset_CreateGLTransaction',
   v_ErrorMessage,v_ErrorID);


   SET SWP_Ret_Value = 1;
END