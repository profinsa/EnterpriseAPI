CREATE PROCEDURE LedgerTransactions_CopyToHistory2 (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_GLTransactionNumber NATIONAL VARCHAR(36),INOUT SWP_Ret_Value INT) SWL_return:
BEGIN























   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);




   DECLARE v_Memorize BOOLEAN;

   DECLARE v_ErrorID INT;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
   END;
   select   Memorize INTO v_Memorize FROM
   LedgerTransactions WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND GLTransactionNumber = v_GLTransactionNumber
   AND IFNULL(GLTransactionPostedYN,0) = 1
   AND UPPER(GLTransactionNumber) <> 'DEFAULT';
   IF ROW_COUNT() = 0 then

      SET SWP_Ret_Value = -2;
      LEAVE SWL_return;
   end if;

   START TRANSACTION;

   IF NOT Exists(SELECT GLTransactionNumber
   FROM LedgerTransactionsHistory
   WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND GLTransactionNumber = v_GLTransactionNumber) then

      SET @SWV_Error = 0;
      INSERT INTO
      LedgerTransactionsDetailHistory(CompanyID,
		DivisionID,
		DepartmentID,
		GLTransactionNumber, 
		
		GLTransactionAccount,
		CurrencyID,
		CurrencyExchangeRate,
		GLDebitAmount,
		GLCreditAmount,
		ProjectID,
		LockedBy,
		LockTS)
      SELECT
      CompanyID,
		DivisionID,
		DepartmentID,
		GLTransactionNumber, 
		
		GLTransactionAccount,
		CurrencyID,
		CurrencyExchangeRate,
		GLDebitAmount,
		GLCreditAmount,
		ProjectID,
		LockedBy,
		LockTS
      FROM
      LedgerTransactionsDetail
      WHERE
      CompanyID = v_CompanyID
      AND DivisionID = v_DivisionID
      AND DepartmentID = v_DepartmentID
      AND GLTransactionNumber = v_GLTransactionNumber;
      IF @SWV_Error <> 0 then
	
         SET v_ErrorMessage = 'Insert into LedgerTransactionsDetailHistory failed';
         ROLLBACK;



         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'LedgerTransactions_CopyToHistory',
         v_ErrorMessage,v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'','');
         SET SWP_Ret_Value = -1;
      end if;
      SET @SWV_Error = 0;
      INSERT INTO
      LedgerTransactionsHistory
      SELECT * FROM
      LedgerTransactions
      WHERE
      CompanyID = v_CompanyID
      AND DivisionID = v_DivisionID
      AND DepartmentID = v_DepartmentID
      AND GLTransactionNumber = v_GLTransactionNumber;
      IF @SWV_Error <> 0 then
	
         SET v_ErrorMessage = 'Insert into LedgerTransactionsHistory failed';
         ROLLBACK;



         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'LedgerTransactions_CopyToHistory',
         v_ErrorMessage,v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'','');
         SET SWP_Ret_Value = -1;
      end if;
   end if;

   IF IFNULL(v_Memorize,0) <> 1 then

      SET @SWV_Error = 0;
      DELETE
      FROM
      LedgerTransactionsDetail
      WHERE
      CompanyID = v_CompanyID
      AND DivisionID = v_DivisionID
      AND DepartmentID = v_DepartmentID
      AND GLTransactionNumber = v_GLTransactionNumber;
      IF @SWV_Error <> 0 then
	
         SET v_ErrorMessage = 'Delete from LedgerTransactionsDetail failed';
         ROLLBACK;



         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'LedgerTransactions_CopyToHistory',
         v_ErrorMessage,v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'','');
         SET SWP_Ret_Value = -1;
      end if;
      SET @SWV_Error = 0;
      DELETE
      FROM
      LedgerTransactions
      WHERE
      CompanyID = v_CompanyID
      AND DivisionID = v_DivisionID
      AND DepartmentID = v_DepartmentID
      AND GLTransactionNumber = v_GLTransactionNumber;
      IF @SWV_Error <> 0 then
	
         SET v_ErrorMessage = 'Delete from LedgerTransactions failed';
         ROLLBACK;



         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'LedgerTransactions_CopyToHistory',
         v_ErrorMessage,v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'','');
         SET SWP_Ret_Value = -1;
      end if;
   end if;	


   COMMIT;
   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;







   ROLLBACK;



   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'LedgerTransactions_CopyToHistory',
   v_ErrorMessage,v_ErrorID);

   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'','');

   SET SWP_Ret_Value = -1;
END