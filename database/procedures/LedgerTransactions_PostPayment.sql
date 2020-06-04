CREATE PROCEDURE LedgerTransactions_PostPayment (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_GLTransactionTypeID NATIONAL VARCHAR(36), 
	v_GLTransactionDate DATETIME, 
	v_GLTransactionDescription NATIONAL VARCHAR(50), 
	v_GLTransactionReference NATIONAL VARCHAR(50),
	v_GLTransactionSource NATIONAL VARCHAR(50), 
	v_GLTransactionAmount DECIMAL(19,4),
	v_GLDebitAccount NATIONAL VARCHAR(36),
	v_GLCreditAccount NATIONAL VARCHAR(36),
	v_SystemGenerated BOOLEAN,
	INOUT v_Success INT ,INOUT SWP_Ret_Value INT) SWL_return:
BEGIN












   DECLARE v_PostCOA INT;
   DECLARE v_GLTransactionNumber NATIONAL VARCHAR(36);
   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);
   DECLARE v_ErrorID INT;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
   END;
   SET @SWV_Error = 0;
   SET v_Success = 1;
   IF v_GLTransactionAmount = 0 then

      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;
   end if;

   START TRANSACTION;


   SET @SWV_Error = 0;
   SET v_ReturnStatus = GetNextEntityID(v_CompanyID,v_DivisionID,v_DepartmentID,'NextGLTransNumber',v_GLTransactionNumber);
   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then

      SET v_ErrorMessage = 'GetNextEntityID call failed';
      ROLLBACK;
      IF v_Success = 1 then

         SET v_Success = 0;
      end if;

      IF v_ErrorMessage <> '' then

	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,DepartmentID,'GeneralLLedger_PostPayment',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,v_GLTransactionDescription,
         v_GLTransactionNumber);
      end if;
      SET SWP_Ret_Value = -1;
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
	GLTransactionSystemGenerated)
VALUES(v_CompanyID,
	v_DivisionID,
	v_DepartmentID,
	v_GLTransactionNumber,
	v_GLTransactionTypeID,
	v_GLTransactionDate,
	v_GLTransactionDescription,
	v_GLTransactionReference,
	v_GLTransactionSource,
	v_GLTransactionAmount,
	1,
	0,
	v_SystemGenerated);



   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'LedgerTransactions insert failed';
      ROLLBACK;
      IF v_Success = 1 then

         SET v_Success = 0;
      end if;

      IF v_ErrorMessage <> '' then

	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,DepartmentID,'GeneralLLedger_PostPayment',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,v_GLTransactionDescription,
         v_GLTransactionNumber);
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
	GLCreditAmount)
VALUES(v_CompanyID,
	v_DivisionID,
	v_DepartmentID,
	v_GLTransactionNumber,
	v_GLDebitAccount,
	v_GLTransactionAmount,
	0);


   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'LedgerTransactionsDetail insert failed';
      ROLLBACK;
      IF v_Success = 1 then

         SET v_Success = 0;
      end if;

      IF v_ErrorMessage <> '' then

	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,DepartmentID,'GeneralLLedger_PostPayment',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,v_GLTransactionDescription,
         v_GLTransactionNumber);
      end if;
      SET SWP_Ret_Value = -1;
   end if;


   SET v_ReturnStatus = LedgerMain_PostCOA2(v_CompanyID,v_DivisionID,v_DepartmentID,v_GLDebitAccount,v_GLTransactionDate,
   v_GLTransactionAmount,0,v_PostCOA);



   IF v_ReturnStatus = -1 then

      SET v_ErrorMessage = 'LedgerMain_PostCOA procedure call failed';
      ROLLBACK;
      IF v_Success = 1 then

         SET v_Success = 0;
      end if;

      IF v_ErrorMessage <> '' then

	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,DepartmentID,'GeneralLLedger_PostPayment',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,v_GLTransactionDescription,
         v_GLTransactionNumber);
      end if;
      SET SWP_Ret_Value = -1;
   ELSE 
      IF v_PostCOA = 0 then

         SET v_ErrorMessage = 'Period closed for reconciliation posting';
         ROLLBACK;
         IF v_Success = 1 then

            SET v_Success = 0;
         end if;

         IF v_ErrorMessage <> '' then

	
            CALL Error_InsertError(v_CompanyID,v_DivisionID,DepartmentID,'GeneralLLedger_PostPayment',v_ErrorMessage,
            v_ErrorID);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,v_GLTransactionDescription,
            v_GLTransactionNumber);
         end if;
         SET SWP_Ret_Value = -1;
      end if;
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
	v_GLCreditAccount,
	0,
	v_GLTransactionAmount);



   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'LedgerTransactionDetail insert failed';
      ROLLBACK;
      IF v_Success = 1 then

         SET v_Success = 0;
      end if;

      IF v_ErrorMessage <> '' then

	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,DepartmentID,'GeneralLLedger_PostPayment',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,v_GLTransactionDescription,
         v_GLTransactionNumber);
      end if;
      SET SWP_Ret_Value = -1;
   end if;


   SET v_ReturnStatus = LedgerMain_PostCOA2(v_CompanyID,v_DivisionID,v_DepartmentID,v_GLCreditAccount,v_GLTransactionDate,
   0,v_GLTransactionAmount,v_PostCOA);



   IF v_ReturnStatus = -1 then

      SET v_ErrorMessage = 'LedgerMain_PostCOA procedure call failed';
      ROLLBACK;
      IF v_Success = 1 then

         SET v_Success = 0;
      end if;

      IF v_ErrorMessage <> '' then

	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,DepartmentID,'GeneralLLedger_PostPayment',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,v_GLTransactionDescription,
         v_GLTransactionNumber);
      end if;
      SET SWP_Ret_Value = -1;
   ELSE 
      IF v_PostCOA = 0 then

         SET v_ErrorMessage = 'Period closed for reconciliation posting';
         ROLLBACK;
         IF v_Success = 1 then

            SET v_Success = 0;
         end if;

         IF v_ErrorMessage <> '' then

	
            CALL Error_InsertError(v_CompanyID,v_DivisionID,DepartmentID,'GeneralLLedger_PostPayment',v_ErrorMessage,
            v_ErrorID);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,v_GLTransactionDescription,
            v_GLTransactionNumber);
         end if;
         SET SWP_Ret_Value = -1;
      end if;
   end if;

   COMMIT;

   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;








   ROLLBACK;

   IF v_Success = 1 then

      SET v_Success = 0;
   end if;

   IF v_ErrorMessage <> '' then

	
      CALL Error_InsertError(v_CompanyID,v_DivisionID,DepartmentID,'GeneralLLedger_PostPayment',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,v_GLTransactionDescription,
      v_GLTransactionNumber);
   end if;
   SET SWP_Ret_Value = -1;
END