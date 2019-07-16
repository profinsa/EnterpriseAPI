CREATE PROCEDURE InventoryAdjustments_CreateGLTransaction (v_CompanyID NATIONAL VARCHAR(36), 
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_AdjustmentID NATIONAL VARCHAR(36),INOUT SWP_Ret_Value INT) SWL_return:
BEGIN
















   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);

   DECLARE v_Posted BOOLEAN;
   DECLARE v_PostedToGL BOOLEAN;
   DECLARE v_PostDate NATIONAL VARCHAR(1);
   DECLARE v_GLTransNumber NATIONAL VARCHAR(36);
   DECLARE v_VendorID NATIONAL VARCHAR(50);
   DECLARE v_Cost DECIMAL(19,4);
   DECLARE v_ConvertedCost DECIMAL(19,4);
   DECLARE v_CurrencyID NATIONAL VARCHAR(3);
   DECLARE v_CompanyCurrencyID NATIONAL VARCHAR(3);
   DECLARE v_CurrencyExchangeRate FLOAT;
   DECLARE v_PostCOA BOOLEAN;
   DECLARE v_ProjectID NATIONAL VARCHAR(36);
   DECLARE v_GLBankAccount NATIONAL VARCHAR(36);
   DECLARE v_GLInventoryAccount NATIONAL VARCHAR(36);
   DECLARE v_AdjustmentDate DATETIME;
   DECLARE v_ErrorID INT;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
   END;
   SET @SWV_Error = 0;
   IF NOT EXISTS(SELECT
   AdjustmentID
   FROM
   InventoryAdjustmentsDetail
   WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   AdjustmentID = v_AdjustmentID AND
   IFNULL(Cost,0) > 0) then

      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;
   end if;

   select   IFNULL(AdjustmentPosted,0), IFNULL(AdjustmentPostToGL,0), IFNULL(AdjustmentDate,CURRENT_TIMESTAMP) INTO v_Posted,v_PostedToGL,v_AdjustmentDate FROM
   InventoryAdjustments WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   AdjustmentID = v_AdjustmentID;


   IF v_Posted = 0 then

      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;
   end if;

   IF v_PostedToGL = 1 then

      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;
   end if;

   START TRANSACTION;




   select   IFNULL(DefaultGLPostingDate,'1'), GLAPInventoryAccount, IFNULL(CurrencyID,N'') INTO v_PostDate,v_GLInventoryAccount,v_CompanyCurrencyID FROM
   Companies WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID;


   IF v_PostDate = '1' then
      SET v_AdjustmentDate = CURRENT_TIMESTAMP;
   end if;

   select   ProjectID INTO v_ProjectID FROM InventoryAdjustmentsDetail WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   AdjustmentID = v_AdjustmentID AND
   NOT ProjectID IS NULL   LIMIT 1;


   DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;



   CREATE TEMPORARY TABLE tt_LedgerDetailTmp  
   (
      GLTransactionNumberDetail BIGINT NOT NULL  PRIMARY KEY  AUTO_INCREMENT,
      GLTransactionAccount NATIONAL VARCHAR(36),
      GLDebitAmount DECIMAL(19,4),
      GLCreditAmount DECIMAL(19,4),
      ProjectID NATIONAL VARCHAR(36)
   )  AUTO_INCREMENT = 1;


   SET @SWV_Error = 0;
   CALL GetNextEntityID2(v_CompanyID,v_DivisionID,v_DepartmentID,'NextGLTransNumber',v_GLTransNumber, v_ReturnStatus);
   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then

      SET v_ErrorMessage = 'GetNextEntityID call failed';
      ROLLBACK;


      DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;
      IF v_ErrorMessage <> '' then

	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'InventoryAdjustments_CreateGLTransaction',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'AdjustmentID',v_AdjustmentID);
      end if;
      SET SWP_Ret_Value = -1;
   end if;


   select   SUM(IFNULL(Cost,0)) INTO v_Cost FROM
   InventoryAdjustmentsDetail WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   AdjustmentID = v_AdjustmentID AND
   IFNULL(Cost,0) > 0;	




   SET @SWV_Error = 0;
   INSERT INTO LedgerTransactions(CompanyID,
	DivisionID,
	DepartmentID,
	GLTransactionNumber,
	GLTransactionTypeID,
	GLTransactionDate,
	GLTransactionDescription,
	GLTransactionReference,
	CurrencyID,
	CurrencyExchangeRate,
	GLTransactionAmount,
	GLTransactionPostedYN,
	GLTransactionSystemGenerated,
	GLTransactionBalance,
	GLTransactionAmountUndistributed)
VALUES(v_CompanyID,
	v_DivisionID,
	v_DepartmentID,
	v_GLTransNumber,
	N'Inventory Adjustment',
	v_AdjustmentDate,
	CONCAT(N'ADJ', v_AdjustmentID),
	N'',
	v_CompanyCurrencyID,
	1,
	v_Cost,
	1,
	1,
	0,
	0);

   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Insert into LedgerTransactions failed';
      ROLLBACK;


      DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;
      IF v_ErrorMessage <> '' then

	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payment_Post',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'AdjustmentID',v_AdjustmentID);
      end if;
      SET SWP_Ret_Value = -1;
   end if;





   SET @SWV_Error = 0;
   INSERT INTO tt_LedgerDetailTmp(GLTransactionAccount ,
	GLDebitAmount,
	GLCreditAmount,
	ProjectID)(SELECT
      v_GLInventoryAccount,
	0,
	SUM(IFNULL(Cost,0)),
	ProjectID
      FROM
      InventoryAdjustmentsDetail
      WHERE
      CompanyID = v_CompanyID
      AND DivisionID = v_DivisionID
      AND DepartmentID = v_DepartmentID
      AND AdjustmentID = v_AdjustmentID
      AND IFNULL(Cost,0) > 0
      AND IFNULL(AdjustedQuantity,0) < 0
      GROUP BY
      ProjectID);

   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Error Processing AP Data';
      ROLLBACK;


      DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;
      IF v_ErrorMessage <> '' then

	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payment_Post',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'AdjustmentID',v_AdjustmentID);
      end if;
      SET SWP_Ret_Value = -1;
   end if;



   SET @SWV_Error = 0;
   INSERT INTO tt_LedgerDetailTmp(GLTransactionAccount ,
	GLDebitAmount,
	GLCreditAmount,
	ProjectID)
   SELECT
   IFNULL(GLAdjustmentPostingAccount,(SELECT GLAPMiscAccount
      FROM Companies
      WHERE CompanyID = v_CompanyID AND DivisionID  = v_DivisionID AND  DepartmentID = v_DepartmentID)),
	SUM(IFNULL(Cost,0)),
	0,
	ProjectID
   FROM
   InventoryAdjustmentsDetail
   WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND AdjustmentID = v_AdjustmentID
   AND IFNULL(Cost,0) > 0
   AND IFNULL(AdjustedQuantity,0) < 0
   GROUP BY
   GLAdjustmentPostingAccount,ProjectID;

   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Error Processing Expense Data';
      ROLLBACK;


      DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;
      IF v_ErrorMessage <> '' then

	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payment_Post',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'AdjustmentID',v_AdjustmentID);
      end if;
      SET SWP_Ret_Value = -1;
   end if;






   SET @SWV_Error = 0;
   INSERT INTO tt_LedgerDetailTmp(GLTransactionAccount ,
	GLDebitAmount,
	GLCreditAmount,
	ProjectID)(SELECT
      v_GLInventoryAccount,
	SUM(IFNULL(Cost,0)),
	0,
	ProjectID
      FROM
      InventoryAdjustmentsDetail
      WHERE
      CompanyID = v_CompanyID
      AND DivisionID = v_DivisionID
      AND DepartmentID = v_DepartmentID
      AND AdjustmentID = v_AdjustmentID
      AND IFNULL(Cost,0) > 0
      AND IFNULL(AdjustedQuantity,0) > 0
      GROUP BY
      ProjectID);

   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Error Processing AP Data';
      ROLLBACK;


      DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;
      IF v_ErrorMessage <> '' then

	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payment_Post',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'AdjustmentID',v_AdjustmentID);
      end if;
      SET SWP_Ret_Value = -1;
   end if;



   SET @SWV_Error = 0;
   INSERT INTO tt_LedgerDetailTmp(GLTransactionAccount ,
	GLDebitAmount,
	GLCreditAmount,
	ProjectID)
   SELECT
   IFNULL(GLAdjustmentPostingAccount,(SELECT GLAPMiscAccount
      FROM Companies
      WHERE CompanyID = v_CompanyID AND DivisionID  = v_DivisionID AND  DepartmentID = v_DepartmentID)),
	0,
	SUM(IFNULL(Cost,0)),
	ProjectID
   FROM
   InventoryAdjustmentsDetail
   WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND AdjustmentID = v_AdjustmentID
   AND IFNULL(Cost,0) > 0
   AND IFNULL(AdjustedQuantity,0) > 0
   GROUP BY
   GLAdjustmentPostingAccount,ProjectID;

   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Error Processing Expense Data';
      ROLLBACK;


      DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;
      IF v_ErrorMessage <> '' then

	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payment_Post',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'AdjustmentID',v_AdjustmentID);
      end if;
      SET SWP_Ret_Value = -1;
   end if;



   SET @SWV_Error = 0;
   INSERT INTO LedgerTransactionsDetail(CompanyID,
	DivisionID,
	DepartmentID,
	GLTransactionNumber,
	GLTransactionAccount,
	GLDebitAmount,
	GLCreditAmount,
	ProjectID)
   SELECT
   v_CompanyID,
		v_DivisionID,
		v_DepartmentID,
		v_GLTransNumber,
		GLTransactionAccount,
		SUM(IFNULL(GLDebitAmount,0)),
		SUM(IFNULL(GLCreditAmount,0)),
		ProjectID
   FROM
   tt_LedgerDetailTmp
   GROUP BY
   GLTransactionAccount,ProjectID;

   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Insert into LedgerTransactionsDetail failed';
      ROLLBACK;


      DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;
      IF v_ErrorMessage <> '' then

	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payment_Post',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'AdjustmentID',v_AdjustmentID);
      end if;
      SET SWP_Ret_Value = -1;
   end if;

   SET @SWV_Error = 0;
   CALL LedgerTransactions_PostCOA_AllRecords2(v_CompanyID,v_DivisionID,v_DepartmentID,v_GLTransNumber, v_ReturnStatus);
   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then

      SET v_ErrorMessage = 'LedgerTransactions_PostCOA_AllRecords call failed';
      ROLLBACK;


      DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;
      IF v_ErrorMessage <> '' then

	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payment_Post',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'AdjustmentID',v_AdjustmentID);
      end if;
      SET SWP_Ret_Value = -1;
   end if;





   DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;



   UPDATE
   InventoryAdjustments
   SET
   AdjustmentPostToGL = 1
   WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   AdjustmentID = v_AdjustmentID;


   COMMIT;
   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;








   ROLLBACK;


   DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;
   IF v_ErrorMessage <> '' then

	
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payment_Post',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'AdjustmentID',v_AdjustmentID);
   end if;
   SET SWP_Ret_Value = -1;
END